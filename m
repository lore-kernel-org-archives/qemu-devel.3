Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F20E7E0C8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 10:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpOvl-0004id-5F; Mon, 09 Feb 2026 05:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpOuF-0003qw-3S
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpOu1-0003t7-Lg
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770634439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQ/63H2gplpNU1enRuu//maT2ee1yi6ZX69RTFgtkWo=;
 b=fxUhhy8CynoDD3cRSh27z+Mo/DCNR+XzvgZCSqkn75uYkJZnb0jrqB5oskSIetcJA6gYYm
 PAODEEgMnIO/knMZbYhfK42GjU9SLXq1hv4hd8uHGUO7AXNAzRgUht4wbUlAFJ6AaiMljA
 4ehrErCV5cpO0IcghWumeI9n6vFk3rs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-Rtlz1t3DNiGPiSs3T6spmA-1; Mon, 09 Feb 2026 05:53:58 -0500
X-MC-Unique: Rtlz1t3DNiGPiSs3T6spmA-1
X-Mimecast-MFC-AGG-ID: Rtlz1t3DNiGPiSs3T6spmA_1770634437
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b88511307b0so366710866b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770634437; x=1771239237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQ/63H2gplpNU1enRuu//maT2ee1yi6ZX69RTFgtkWo=;
 b=USROuTnIIb1qzBr0Cg1r4oJA221EEckc/e14YyL2+xPHL0rXVU6fA3Qtnv9XynFPt1
 TfKuNeCaZRVejMK1kH8VANokcFGZrPbid5hHsvIQatIjBNcm5cN3nJd7ODtsT/VMvyvI
 U5iQNfMCJi7uhY7GncFcXCJTMB6fRsmh/nRB9++OVooafpT4KViXF6iVnC5YsMxMYuQ4
 kHnh7IMUDXuHSDbEDpf935p5EcWJWz52Ef8rnyx8Lmuj/LpK3i9NXXh+NTLqlMik1TNV
 9oE+mtHfyuElRhtHIvKLs3yaXQE5l+nzz2IIsBVO1Kd4M3MPxWyurCd+GLtxCCGp3V+x
 Vbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770634437; x=1771239237;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQ/63H2gplpNU1enRuu//maT2ee1yi6ZX69RTFgtkWo=;
 b=uyMQInvb5BJXlJODvgh8F1zTze+gS0ZEEWGJXbhtZSxbZCeyMf6M5ayHGGxO+94FEX
 1e0Itw/6h/5c0Fs0M5VhA5SbriI/1u6OcWXWBG6wSXudXmHwhzL+5vzEFDXE+1T5KKV0
 L8b0D7n3DrB8l5olb8j0uFDa/MAMZ569IjT2omyKUS+98w6L1YV2Ezy0frJ40mLLS73B
 ceQUzyT25oRy5x4ok3/hhyIhOnCGyfsH3vl2+301vQ8jGEnYH8B1OJsecrjXDt9qM4GW
 MzxlBhrih7Rwi4Jk4nBK97cKuAr5Hs2ZrHLhcxsVJsW5OwFtHm/nG70vT4LImmjFrUP2
 TvHg==
X-Gm-Message-State: AOJu0YzZdbxyv5lc4R5NTk1kSwW6rpPiiBkZABYNP4Goytrw2i1hs6uf
 5uBQU4GDQS/rU7dHhD0nHbaOnrKmAJU7zuXehJrn6ABB8rEw4f2nehHEI9GhR83ptxiK9hCi2e1
 PmPm1fjCVbNBi6KFeMAo0ZBou3tTYGPT7FBUyV2lqFOEKxtFvL8BOABc1
X-Gm-Gg: AZuq6aKpR764ZsPhWrphx457dWfa0ErveevNyVdyqmzyZDcldRq6YvisUtgwHyTo3qs
 rUZ3OG7drXPa5z8Phz+PUeKWsnNm63+t2MFa2goUMo+FSa8qhh4M/+SW/vpId5oHJCqQriLW+UR
 1CTagRjie51GkfCzO07mO+5E9e2FvwUgiQQihw8NfMs1niXTkQz6uNa8WT04hvK2PTYnr0tGk39
 AiNYwGmXQcfoovbiSB5JpCl4ib4QnbTWAeXtj96PL0gyjJftZIv89U9+rr3DcTB8p7BnlpXKiF2
 NaMByIg4b61EW4iffd74+GeFlY/8CL6wjTL/S1PaHIDpPupVQgAWinajKb6zTzZxJZ7tQdv0mC3
 HHfOA7mMWeNmJmQgt+uxbQ6niOEP6UoS706VAtWHHMMnLik/Z2VLnpVD/79sHF/lcVqJHoc1WTy
 OztRxlWC7L+4Oh8A==
X-Received: by 2002:a17:907:9723:b0:b87:225f:2e74 with SMTP id
 a640c23a62f3a-b8edf19d5a6mr616904666b.14.1770634436882; 
 Mon, 09 Feb 2026 02:53:56 -0800 (PST)
X-Received: by 2002:a17:907:9723:b0:b87:225f:2e74 with SMTP id
 a640c23a62f3a-b8edf19d5a6mr616902866b.14.1770634436294; 
 Mon, 09 Feb 2026 02:53:56 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b8eda7e6577sm367271766b.30.2026.02.09.02.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 02:53:55 -0800 (PST)
Message-ID: <a31dca74-1ae8-428c-9ed8-315594afecbf@redhat.com>
Date: Mon, 9 Feb 2026 11:53:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] json-parser: replace with a push parser
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-3-pbonzini@redhat.com> <87sebab6mr.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87sebab6mr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 2/9/26 10:36, Markus Armbruster wrote:
>> +typedef struct JSONParserContext {
>> +    Error *err;
>> +    GQueue *stack;
> 
> This tells us we have a stack of something, but not what the something
> is.  Further down, we'll see what the something is.
> 
> The commit message explains what the stack means.
> 
> Worth a comment here?

Yes, makes sense.

> We know the stack is at most 1024 deep (MAX_NESTING).  Have you
> considered using an array instead of GQueue?

It'd be only 8K, but I preferred to keep MAX_NESTING hidden within 
json-streamer.c.  Not having bounds checking makes me a bit nervous 
about having fixed-size arrays.

See more below about responsibility split between parser and streamer.

>> +    va_list *ap;
>> +} JSONParserContext;
>> +
> 
> Having to move struct definitions to headers is always a bit sad.  Could
> this go into json-parser-int.h instead?

No because it's embedded in JSONMessageParser, just like JSONLexer.  It 
was previously hidden only because the parser was created and destroyed 
after parentheses were balanced, but not doing that is kind of the whole 
story here. :)
>> +/*
>> + * Objects: { } | { members }
>> + * - Empty: { -> AFTER_LCURLY -> }
>> + * - Non-empty: { -> AFTER_LCURLY -> BEFORE_KEY -> string -> END_OF_KEY -> : ->
>> + *              BEFORE_VALUE -> value -> END_OF_VALUE -> , -> BEFORE_KEY -> ... -> }
>> + *
>> + * Arrays: [ ] | [ elements ]
>> + * - Empty: [ -> AFTER_LSQUARE -> ]
>> + * - Non-empty: [ -> AFTER_LSQUARE -> BEFORE_VALUE -> value -> END_OF_VALUE -> , ->
>> + *              BEFORE_VALUE -> ... -> ]
>> + *
>> + * The two cases for END_OF_VALUE are distinguished based on the type of QObject at
>> + * top-of-stack.
>> + */
> 
> I'm afraid I need a comment telling me how to read this comment.

That's basically the automaton that you request below (with epsilon 
transitions), I'll expand on it.

>> +typedef enum JSONParserState {
>> +    AFTER_LCURLY,
>> +    AFTER_LSQUARE,
>> +    BEFORE_KEY,
>> +    BEFORE_VALUE,
>> +    END_OF_KEY,
>> +    END_OF_VALUE,
>> +} JSONParserState;
>> +
>> +typedef struct JSONParserStackEntry {
>> +    /* A QString with the last parsed key, or a QList/QDict for the current container.  */
>> +    QObject *partial;
>> +
>> +    /* Needed to distinguish whether the parser is waiting for a colon or comma.  */
>> +    JSONParserState state;
> 
> If the comment was 100% accurate, a bool would do.

Hmm when I wrote I did think that a bool + the type of the top QObject 
would do.  But really there are three cases that the top QObject does 
not distinguish:

- "after opening bracket, closed parenthesis or next element accepted",

- "after comma, next element required"

- "after element, closed parenthesis or comma accepted"

So, a bool would not be enough.  Will fix.


>> +/* Note that entry->partial does *not* lose its reference count even if value == NULL.  */
>> +static JSONParserStackEntry *pop_entry(JSONParserContext *ctxt, QObject **value)
>> +{
>> +    JSONParserStackEntry *entry = g_queue_pop_tail(ctxt->stack);
>> +    if (value) {
>> +        *value = entry->partial;
>> +    }
>> +    g_free(entry);
>> +    return current_entry(ctxt);
>> +}
> 
> This is a rather peculiar function.  If you disagree, try writing a
> contract for it :)

Hmm... yes, better pull the "value = entry->partial" to the callers even 
if there are several of them.  The code is overall simpler.

> The parser's interesting part follows.  The parser is a pushdown
> automaton.  The pushdown automaton is coded in C.  On the one hand,
> d'oh!  Of course it is.  On the other hand, it's hard to see the actual
> automaton in C.  May I have a comment explaining state and state
> transitions?  Perhaps we better start with an informal description,
> discuss it, then distill the discussion into a comment.

That was the purpose of the mysterious comment above.  If a mix between 
BNF and automaton is okay for you, it could be something like

input := value        -> END_OF_VALUE
          END_OF_INPUT -> check stack is empty, return parsed value

// entered on BEFORE_VALUE; after any of these rules are processed, the
// parser has completed a QObject and is in the END_OF_VALUE state.
//
// When the parser reaches the END_OF_VALUE state, it examines the
// top of the stack to see if it's coming from "input" (stack empty),
// "array_items" (TOS is a QList) or "dict_pairs" (TOS is a QString; the
// item below will be a QDict).  It then proceeds with the corresponding
// actions, which will be one of:
// - return parsed value
// - add value to QList
// - pop QString with the key, add key/value to the QDict

value := literal       -> END_OF_VALUE
       | '['            -> push empty QList -> AFTER_LSQUARE
          after_lsquare -> END_OF_VALUE
       | '{'            -> push empty QDict -> AFTER_LCURLY
          after_lcurly  -> END_OF_VALUE

// non-recursive values, entered on BEFORE_VALUE
literal := INTEGER   -> END_OF_VALUE
      | FLOAT         -> END_OF_VALUE
      | KEYWORD       -> END_OF_VALUE
      | STRING        -> END_OF_VALUE
      | INTERP        -> END_OF_VALUE

// entered on AFTER_LSQUARE
after_lsquare := ']' -> pop completed QList -> END_OF_VALUE
        | ϵ           -> BEFORE_VALUE
          array_items -> END_OF_VALUE

// entered on BEFORE_VALUE, with TOS being a QList
array_items := value   -> add value to QList -> END_OF_VALUE
        (']'            -> pop completed QList -> END_OF_VALUE
         | ','          -> BEFORE_VALUE
           array_items) -> END_OF_VALUE

// entered on AFTER_LCURLY
after_lcurly := '}'  -> pop completed QDict -> END_OF_VALUE
        | ϵ           -> BEFORE_KEY
          dict_pairs  -> END_OF_VALUE

// entered on BEFORE_KEY, with TOS being a QDict
dict_pairs := STRING  -> push QString -> END_OF_KEY
        ':'            -> BEFORE_VALUE
        value          -> pop QString + add pair to QDict -> END_OF_VALUE
        ('}'           -> pop completed QDict -> END_OF_VALUE
         | ','         -> BEFORE_KEY
           dict_pairs) -> END_OF_VALUE
>> +static QObject *json_parser_parse_token(JSONParserContext *ctxt, const JSONToken *token)
> 
> Rename to parse_token()?  Or inline into json_parser_feed()?

Renaming is good.

>> +            if (!key) {
>> +                return NULL;
>> +            }
> 
> Key to understand the switch is the meaning of "break" and "return
> NULL".
> 
> We do the latter when we're done for this token.
> 
> We do the former when this token completed a (sub-)value.  @value holds
> it.  If the stack is empty, @value is the result of the parse, and the
> code after the switch returns it.  Else, @value is a sub-value, and the
> code after the switch stores it in the object being constructed.

Correct.  Want me to include it somehow or is the grammar above fine?

>> +
>> +            /* Store key in a special entry on the stack */
>> +            push_entry(ctxt, QOBJECT(key), END_OF_KEY);
>> +        } else {
>> +            parse_error(ctxt, token, "expecting key");
> 
> What's the state machine's parse error recovery story?

As simple as it can be:

     assert(!ctxt->err);

because a push parser can actually refuse to deal with tokens after an 
error, and make recovery someone else's problem.

In other words a push parser can actually be the pure theoretical thing 
from your compilers and automata book, and all the engineering sits on 
top.  IMO this (at least for a JSON parser that you won't touch that 
often) balances the complexity of the state machine.

So, error recovery is handled entirely in json-streamer.c.  As of this 
patch, json-streamer.c has gathered all tokens up to the next balanced 
parentheses, and that's implicitly the place where the error recovery is 
complete.

>> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp)
> 
> The return value isn't immediately obvious.  A brief function contract
> could help the reader.

Ok, will add.

> Before the patch: flush the queue when both counts are zero or at least
> one is negative.
> 
> After the patch: additionally flush it on end of input.
> 
> I figure the two hunks together make the parser see a JSON_END_OF_INPUT
> token at the end of input.  Correct?

Yes, see the commit message.  This is the only change I have made here 
to the parser/streamer split, because it makes sense to have the 
unbalanced parentheses error happen in the parser.  Otherwise you're not 
really implementing the whole grammar.

>>       }
>>   
>> -    json = json_parser_parse(&parser->tokens, parser->ap, &err);
>> +    json_parser_init(&ctxt, parser->ap);
>> +
>> +    /* Process all tokens in the queue */
>> +    while (!g_queue_is_empty(&parser->tokens)) {
>> +        token = g_queue_pop_head(&parser->tokens);
>> +        json = json_parser_feed(&ctxt, token, &err);
>> +        g_free(token);
>> +        if (json || err) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    json_parser_destroy(&ctxt);
> 
> This is where we switch from feeding the parser balanced expressions to
> feeding it tokens one by one.
> 
> When we break the loop early, parser->tokens is not empty here.  Fine,
> because...
> 
>>   
>>   out_emit:
>>       parser->brace_count = 0;
>         parser->bracket_count = 0;
>         json_message_free_tokens(parser);
> 
> ... we drain it here.
> 
>         parser->token_size = 0;
>         parser->emit(parser->opaque, json, err);
>     }

Correct, and this reset code will survive in patch 3, sort of like this:

     // feed tokens as they're passed to the streamer
     if (!ctxt->err) {
         json = json_parser_feed(...)
         if (json || ctxt->err) {
             parser->emit(parser->opaque, json, ctxt->err);
         }
     }

     if (value || error recovery complete) {
         // reset the streamer state
         // reset the parser
     }

Paolo


