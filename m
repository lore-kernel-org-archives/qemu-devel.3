Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9406DE81A45
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 16:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs1f9-0006vw-F4; Mon, 16 Feb 2026 11:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vs1f5-0006vA-VY
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vs1f3-0006gr-Mt
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771260084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PH69ymGU1hd3RMvCr1aj28iRFM6o81M+DRFFOvg8PQ0=;
 b=CkiJoFhMm5rDeWX4JtcjiQ2ioCKT0McYOaln/mu01x7TUgTYKzVwheZtQ4V1lXzyKlMv4B
 O3OEPbsA8mfeXdGseLVRGEHp3QSBewXskdVrR3p0E9lL9zvu2oS9mGftSPboK8AEtb3aeZ
 831ER08pEi8SkxeFjjl1TC2OMNEzAn4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-V4lJ7_W7NDmi3SBAY9kBvA-1; Mon, 16 Feb 2026 11:41:22 -0500
X-MC-Unique: V4lJ7_W7NDmi3SBAY9kBvA-1
X-Mimecast-MFC-AGG-ID: V4lJ7_W7NDmi3SBAY9kBvA_1771260081
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b8887913accso703130466b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771260081; x=1771864881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PH69ymGU1hd3RMvCr1aj28iRFM6o81M+DRFFOvg8PQ0=;
 b=DhRd55Fc1HQ0sIcp6qyjUA+uMONBIxSbTJhlGQTp4lzxGSkZe3Vu1MPvZ05fB0e3ri
 s2PviMhm8dacvlbwHi+Tut7uZLuOQgIs2iqIeMyVg9LeZH0lr1bHIGHgRSnEFcLsZ1J6
 W7x+xENw0jhIvn93TpwODp2pHI5L7Xw0B6m+WnvlbodCMe4AyaiGwS+WyZzkgkN0CyGQ
 fePifu0PIUxER6NA0nw5dYVD8jFYco+84KR2H7NwHgXE/bixdK6to7kkckXB5JQPEZzX
 aDK7hGxTlphtgZBcaw+dewIO0SEocFogWtfyxc7Va6o6xSj46BWaWIbmroARG0IKlkB7
 z7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260081; x=1771864881;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PH69ymGU1hd3RMvCr1aj28iRFM6o81M+DRFFOvg8PQ0=;
 b=wTa1+SOA8G2Qrh40QAk6Hcq+pWcHyNTD6ftDon/C4IMr8G9/K6DYdhsz/hMyhCTtzZ
 y5AKiMsHcGvE5DwO6X5bx+3eTifPF8HEsHYaTy5Fhukn78cBJOw+VloaIAGHHPFrv+E+
 FzDLaOiNwne+Fow0mCfMUk6RDiOxMTrSRRiY7FQJQMcHyrilUi9wU+1a2GRxxFVyoEkn
 QkX2gaXYcl3VYz5YwEhltnULM2ECgBIMm8qEtIu9M00loMKaYV4Rp/cOIJmieokUDiiZ
 Xo2arSfhInTWa5+KRCO6UHbZeZvDQgLN+gCW4rKDxcs5ZsHkI9/K+8ChUOiKSyIFa+vV
 kgnw==
X-Gm-Message-State: AOJu0YwdHv/jTRpxyfX7dNUfqoGjcjftEKbLo7AuQLOLx1Kn4+GknDuw
 0g6EvQEQiQnszx05VydUM4+TQ5y07Sgb51zoKPBF/dcb50LEOsJWUdfG7ae4kejs4neKzNtq8Fk
 2DPzxfMdUOXC5SzEE3W0Svsa15RI3X25Em8Yrydh9guF7rFyze3289urC
X-Gm-Gg: AZuq6aKKh5RB6KAqxaBa5S7YVeo7uiApk8nxBWI6Uh2WXcvFrlJtDo0Ny0C9cGNTJKU
 f6uPTpub809VaWvBHYGneod+6mQ1FeRauxEVLm5RN5/82BHGm3qU7OdvlyZywaplJCDxnPKf1j/
 RRy3OqTbVayQeaeXPvjSp06jcd0r9u+EKA0+proP2KAJEMqvwKUZ1sEOTktckA1o44mBHG2qvja
 lPhTkCkKTlqSJBRxEPYC8kqKihHTL3GgbdvUomVo0LSkD6MAIFuMGR9PejEVX2DkSDwI3zX8RJB
 r84RltvXZWqTQd9S+EoqBX9dhD+0Y7e+tpoQi/xPfZNHTfYJXU6iecPJDjmbOk8uSaQr46GPm6t
 pYKUTqGZnCcBW0PyXGwHFe0fSrkKm2d27eLrjWgltgUv0kYt4WinlQfPT2EOykZ192XoM+KNSIV
 fKWgjaxlRnP3+mvKo2dpP1833d1DU=
X-Received: by 2002:a17:907:c0a:b0:b88:58e5:86ff with SMTP id
 a640c23a62f3a-b8fc0216b5emr719032666b.0.1771260081090; 
 Mon, 16 Feb 2026 08:41:21 -0800 (PST)
X-Received: by 2002:a17:907:c0a:b0:b88:58e5:86ff with SMTP id
 a640c23a62f3a-b8fc0216b5emr719031366b.0.1771260080539; 
 Mon, 16 Feb 2026 08:41:20 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b8fc735ed50sm269584266b.8.2026.02.16.08.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 08:41:19 -0800 (PST)
Message-ID: <682de27d-4ebf-4c08-ad0c-45626a5a9dea@redhat.com>
Date: Mon, 16 Feb 2026 17:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] json-parser: replace with a push parser
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-3-pbonzini@redhat.com> <87sebab6mr.fsf@pond.sub.org>
 <a31dca74-1ae8-428c-9ed8-315594afecbf@redhat.com>
 <87wm0iumuv.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87wm0iumuv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/12/26 14:12, Markus Armbruster wrote:
>>> We know the stack is at most 1024 deep (MAX_NESTING).  Have you
>>> considered using an array instead of GQueue?
>>
>> It'd be only 8K, but I preferred to keep MAX_NESTING hidden within
>> json-streamer.c.  Not having bounds checking makes me a bit nervous
>> about having fixed-size arrays.
> 
> Looks mostly harmless to me: there's exactly one spot where we push
> something onto the stack, one where we pop, and one where we pop
> everything.  We only ever look at the top of the stack.

Yes, code-wise it's not hard.  But it's ugly/brittle to have two pieces 
of code that have to sync on MAX_NESTING.

>>> The parser's interesting part follows.  The parser is a pushdown
>>> automaton.  The pushdown automaton is coded in C.  On the one hand,
>>> d'oh!  Of course it is.  On the other hand, it's hard to see the actual
>>> automaton in C.  May I have a comment explaining state and state
>>> transitions?  Perhaps we better start with an informal description,
>>> discuss it, then distill the discussion into a comment.
>>
>> That was the purpose of the mysterious comment above.  If a mix between
>> BNF and automaton is okay for you, it could be something like
>>
>> input := value        -> END_OF_VALUE
>>            END_OF_INPUT -> check stack is empty, return parsed value
>>
>> // entered on BEFORE_VALUE; after any of these rules are processed, the
>> // parser has completed a QObject and is in the END_OF_VALUE state.
> 
> What do you mean by "after any of these rules are processed, ..."?

That "literal", "'[' after_lsquare" and "'{' after_lcurly" both end up 
with the state machine in the END_OF_VALUE state.

>> //
>> // When the parser reaches the END_OF_VALUE state, it examines the
>> // top of the stack to see if it's coming from "input" (stack empty),
>> // "array_items" (TOS is a QList) or "dict_pairs" (TOS is a QString; the
>> // item below will be a QDict).  It then proceeds with the corresponding
>> // actions, which will be one of:
>> // - return parsed value
>> // - add value to QList
>> // - pop QString with the key, add key/value to the QDict
> 
> Forward references to array_items and dict_pairs.  Suggest to add a
> suitable "below", or indicate the forward reference some other way.

I can put instead after_lsquare and after_lcurly.

>> value := literal       -> END_OF_VALUE
>>         | '['            -> push empty QList -> AFTER_LSQUARE
>>            after_lsquare -> END_OF_VALUE
>>         | '{'            -> push empty QDict -> AFTER_LCURLY
>>            after_lcurly  -> END_OF_VALUE
>>
>> // non-recursive values, entered on BEFORE_VALUE
>> literal := INTEGER   -> END_OF_VALUE
>>        | FLOAT         -> END_OF_VALUE
>>        | KEYWORD       -> END_OF_VALUE
>>        | STRING        -> END_OF_VALUE
>>        | INTERP        -> END_OF_VALUE
>>
>> // entered on AFTER_LSQUARE
>> after_lsquare := ']' -> pop completed QList -> END_OF_VALUE
>>          | ϵ           -> BEFORE_VALUE
>>            array_items -> END_OF_VALUE
>>
>> // entered on BEFORE_VALUE, with TOS being a QList
>> array_items := value   -> add value to QList -> END_OF_VALUE
>>          (']'            -> pop completed QList -> END_OF_VALUE
>>           | ','          -> BEFORE_VALUE
>>             array_items) -> END_OF_VALUE
>>
>> // entered on AFTER_LCURLY
>> after_lcurly := '}'  -> pop completed QDict -> END_OF_VALUE
>>          | ϵ           -> BEFORE_KEY
>>            dict_pairs  -> END_OF_VALUE
>>
>> // entered on BEFORE_KEY, with TOS being a QDict
>> dict_pairs := STRING  -> push QString -> END_OF_KEY
>>          ':'            -> BEFORE_VALUE
>>          value          -> pop QString + add pair to QDict -> END_OF_VALUE
>>          ('}'           -> pop completed QDict -> END_OF_VALUE
>>           | ','         -> BEFORE_KEY
>>             dict_pairs) -> END_OF_VALUE
> 
> The BNF part is everything but the -> ...  Easy enough.  However, I'm
> not quite certain how to interpret the --> ...
> 
> The "// entered on STATE ..." I can read as assertion.

Yes, that's a comment (with C++ syntax to have something familiar).

> The text after "->" seems to be one ore more state / stack transitions.
> Let me describe them in my own words to make sure I understand you.
> Note that I had to also look at the source code to produce my
> description.
> 
> -> STATE
> 
>     Set top stack entry's state to STATE.
> 
> -> push OBJ -> STATE
> 
>     Push (STATE, OBJ) onto the stack.

Intended more like push (OBJ, undefined), set top stack entry state to 
STATE, but yes.

> -> pop completed OBJ -> END_OF_VALUE
> 
>     Pop (_, OBJ) from the stack, set new top stack entry's state to
>     END_OF_VALUE.  OBJ is the result of parsing non-terminal @value.
> 
> -> add value to QList -> END_OF_VALUE
> 
>     Append the result of parsing non-terminal @value to the top stack
>     entry's QList.  Set the top stack entry's state to END_OF_VALUE.
> 
> -> pop QString + add pair to QDict -> END_OF_VALUE
> 
>     Pop (_, QString) from the stack, it's the key.  Its value is the
>     result of parsing non-terminal value.  Store this key: value pair in
>     the top stack entry's QDict.  Set the top stack entry's state to
>     END_OF_VALUE.

Correct. "-> STATE" generally means "go to state STATE", where teh state 
is stored in the top stack entry.

> Stack entry members @partial from bottom to top:
> 
> * a QList element for an unclosed '[',
> 
> * a QDict and a QString element for an unclosed '{', except the
>    innermost one need not have a QString.  This is because the QString is
>    on the stack only while we're parsing ':' value.
> 
> So, stack contents invariant:
> 
>      ( QList | QDict QString )* QDict?

Makes sense.

> I found the QString business somewhat confusing, probably because I
> expected one stack entry per nesting level, and tossing that invalid
> assumption took mental effort.

... while I wrote the parser as one per pending nonterminal.  Coming 
from the recursive descent probably suggested that approach, somewhat 
subconsciously.

> I figure we could have one stack entry per: add a const char *key member
> to JSONParserStackEntry, non-null exactly when we have a QString sitting
> on a QDict now.  We'd trade representable invalid state "QString
> directly above non-QDict in the stack" for "QList stack entry has member
> @key set".  Would be slightly more local.  Matter of taste, I guess.

I can check what the code looks like, sure.

> More representable invalid state, as far as I can tell (observation, not
> objection):
> 
> * a QList stack entry can only have state AFTER_LSQUARE, BEFORE_VALUE,
>    END_OF_VALUE, never AFTER_LCURLY, BEFORE_KEY, END_OF_KEY
> 
> * a QDict stack entry can only have state AFTER_LCURLY, BEFORE_KEY,
>    END_OF_VALUE, never AFTER_LSQUARE, BEFORE_VALUE, END_OF_KEY
> 
> * a QString stack entry can only have state BEFORE_VALUE and END_OF_KEY,
>    never AFTER_LCURLY, AFTER_LSQUARE, BEFORE_VALUE, END_OF_VALUE.
> 
> Stack entries by @state instead of by @partial:
> * AFTER_LCURLY: @partial is QDict
> * AFTER_LSQUARE: @partial is QList
> * BEFORE_KEY: @partial is QDict
> * BEFORE_VALUE: @partial is QList or QString

... or empty:

     state = entry ? entry->state : BEFORE_VALUE;


> * END_OF_KEY: @partial is QString
> * END_OF_VALUE: @partial is QList or QString
>
> Invariants worth documenting, I think.

Ok---as assertions in the code?

> Here's my attempt at explaining the automaton and how states and stack
> fit together: annotated JSON syntax diagrams.  The diagrams are from
> www.json.org with whitespace nonterminal omitted for brevity.
> 
> Semantic actions are connected with dashed lines.  State names are
> abbreviated to ALC, ALS, BK, BV, EOK, EOV.  (STATE, QTYPE) describes the
> top stack entry.  "assert (STATE, QTYPE)" asserts the top stack entry's
> @state is STATE, and its @partial is of QTYPE.  "set STATE" means the
> top stack entry's state is set to STATE.
> 
>                                  set EOV
>                             result is QObject
>            value                    ┆
>            >────────╮─── string ──╭───>
>            ┆        │             │
>    assert (BV, _)   ╰─── number ──╯
>                     │             │
>                     ╰─── object ──╯
>                     │             │
>                     ╰─── array ───╯
>                     │             │
>                     ╰─── true ────╯
>                     │             │
>                     ╰─── false ───╯
>                     │             │
>                     ╰─── null ────╯
> 
> 
>                push (ALS, QList)   pop (ALS, QList)
>                       ┆             assert (BV, _)
>                       ┆               set EOV
>                       ┆          result is popped QList
>            array      ┆                  ┆
>            >─────── [ ─╮────────────╭─ ] ──>
>            ┆           │            │
>    assert (BV, _)      │ ┄ set BV   │
>                        │            │
>                set BV  │            │
>                    ┆   │            │
>               ╭─ , ────╰── value ──╮╯
>               │                    │ ┄ assert (EOV, QList)
>               ╰────────────────────╯   put value into QList
> 
> 
> 
>                push (ALC, QDict)                  pop (ALC, QDict)
>                       ┆                            assert (BV, _)
>                       ┆                              set EOV
>                       ┆                         result is popped QDict
>            object     ┆                                 ┆
>            >─────── { ─╮───────────────────────────╭─ } ──>
>            ┆           │                           │
>    assert (BV, _)      │ ┄ set BK                  │
>                        │                           │
>                set BK  │  push (EOK, QString)      │
>                    ┆   │         ┆                 │
>               ╭─ , ────╰─ string ─── : ─── value ─╮╯
>               │                        ┆          │   pop (BV, QString)
>               │                     set BV        │ ┄ assert (EOV, QDict)
>               │                                   │   put string: value
>               ╰───────────────────────────────────╯      into QDict
> 
> Might be your turn to be confused ;)

I'm not confused but maybe it is a bit too detailed.

>>>> +static QObject *json_parser_parse_token(JSONParserContext *ctxt, const JSONToken *token)
>>>
>>> Rename to parse_token()?  Or inline into json_parser_feed()?
>>
>> Renaming is good.
>>
>>>> +            if (!key) {
>>>> +                return NULL;
>>>> +            }
>>>
>>> Key to understand the switch is the meaning of "break" and "return
>>> NULL".
>>>
>>> We do the latter when we're done for this token.
>>>
>>> We do the former when this token completed a (sub-)value.  @value holds
>>> it.  If the stack is empty, @value is the result of the parse, and the
>>> code after the switch returns it.  Else, @value is a sub-value, and the
>>> code after the switch stores it in the object being constructed.
>>
>> Correct.  Want me to include it somehow or is the grammar above fine?
> 
> Whether the grammar makes the meaning of "break" and "return NULL"
> obvious enough is hard to tell now: I know too much.  Should fix itself
> within a few days ;)

Probably not. :)  I'll see if I can move the post-pr

Paolo


