require 'pry'
class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combo|
      board.taken?(win_combo[0] + 1) &&
      board.cells[win_combo[0]] == board.cells[win_combo[1]] &&
      board.cells[win_combo[1]] == board.cells[win_combo[2]]
    end
  end

  def draw?
    !won? && board.full?
  end

  def over?
    won? || draw?
  end

  def winner
    if winning_move = won?
      board.cells[winning_move[0]]
    end
  end

  def turn
    player = current_player
    current_move = player.move(board)
    if board.valid_move?(current_move)
      board.update(current_move, player)
      board.display
    else
      turn
    end
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
