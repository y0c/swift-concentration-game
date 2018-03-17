//
//  Concentration.swift
//  CardGame
//
//  Created by LimHoSung on 2018. 2. 11..
//  Copyright © 2018년 LimHoSung. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            //뒤집힌 카드가 하나일경우 해당 index 있을경우 nil        
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            //해당 index를 제외하고 모두 뒤집어준다.(매칭이안됬을경우)
            for index in cards.indices {
                cards[index].isFaceUp = ( index == newValue )
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosne index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsCards: Int) {
        assert(numberOfPairsCards > 0 ,"Concentration.init(\(numberOfPairsCards)): you must at least one pair of cards")
        for _ in 1...numberOfPairsCards {
            let card = Card()
            
            cards += [ card, card ]
        }
        
        //TODO: Shuffle the cards
        
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
