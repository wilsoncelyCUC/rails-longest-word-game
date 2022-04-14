require 'open-uri'
require 'json'
require 'time'

class GamesController < ApplicationController

  def new
    # TODO: generate random grid of letters
    number = rand(7..10)
    @letters = Array.new(number) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:word].downcase
    letter = params[:letter].downcase
    @results =
    if included?(@guess, letter)
      if english_word?(@guess)
        'Well done'
      else
        'It s not an english word'
      end
    else
      'The word is not in the grid'
    end
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json_hash = JSON.parse(response.read)
    json_hash['found']
  end

end
