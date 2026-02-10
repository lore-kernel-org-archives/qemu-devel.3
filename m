Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B616EA3F22
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpj15-0007HE-8F; Tue, 10 Feb 2026 03:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpj13-0007H4-PV
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpj11-0003wz-Il
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770711754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTHl9hOmXKlf3mYaxTYzfMkkb3j1MOWZoF4xlzDE5KU=;
 b=e0A/A9k3AYnqU5KxOriYlktFvWvg78fljYZgKr6XU9/Z5gf86iAXNWU1Ho1sYM7RAa+wbT
 5TMh+1hbATQ7+jRWye4s3B6sYI3/woAfieVHqhdj+ioblrshAeBKPmP3V8P9fT52qc8OnX
 2Lo7hPHsX0m0NVkfpe5e68hyxiLUDXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-3JxizhJHOHWL4izJUU_WmQ-1; Tue, 10 Feb 2026 03:22:32 -0500
X-MC-Unique: 3JxizhJHOHWL4izJUU_WmQ-1
X-Mimecast-MFC-AGG-ID: 3JxizhJHOHWL4izJUU_WmQ_1770711752
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so49929895e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 00:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770711751; x=1771316551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTHl9hOmXKlf3mYaxTYzfMkkb3j1MOWZoF4xlzDE5KU=;
 b=d1N9L6ST7oldL0OfpvUwNDRbiPXfITO0o+lT0ajhhzxMMHdTxgszbojnkVbOOiHS+L
 6mbZ1gbiuyeeWADJwBhpuQYovxcgRA3vNpBcfBGu0EnKtRSP1iZQPbbntmuOPmHlkNX9
 iK0HZXMpsxYIB8va6ZL4p0JIOSCqSV3enby4ExDymTwna4N6L2An3KIEy2MJfv3Zx7yB
 Xemz/KK9hWlwbSKQN33g8rKRZsLSiKQ9SLOlmGUCr/h96hJeTXp2AvQQAtEJ0j5BFUYZ
 Vp1gfmzixlWQmbZtCMHaUp1pH4Z+3xlYx0v31QLB7N0Kx+Ruj/LYlPJFBOF0roOGwXNb
 Bd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770711751; x=1771316551;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTHl9hOmXKlf3mYaxTYzfMkkb3j1MOWZoF4xlzDE5KU=;
 b=OvhZXdDcyOwNGmsdoJPjJqfMTAoE28uMxuYXVp0YdE/pTqPKqhlTXDLjmSGYM7+IE4
 8ZVk09RwYbPgx+T43vpqv1uy5fnsu6zlMWZ+catb19ekodRVOyMHE9z8/qVAnOKOqLgQ
 tQ6VwXBL4or4cIjAdabJw0wyEpzwiqr7oOQG51EhcZhEwfdBDhi9LphQI3QCtm7ZTK68
 dMQrzJOvgudyfHDn9g6Bpw86zN0SDmXlkoq/gY5VWSdDWIocu7NNSlNy2qxs00JhydLC
 imitSWP7U3vzuaCB7SnhAkyBzOpsG2Q9O7rY7jUK6eUQ4lS8hvXqconH4rgMJsrie+/m
 dvlw==
X-Gm-Message-State: AOJu0Yx9FX2oVMHHZT0DzjsMx1Po7C4WpJ2407dW0oirzDHydB0bsv/d
 11DN/4B2xpJDHdO5MUF1v6ArFkadEUWLc7DgDu7qaTgi4gcGqSOWffo1htXk8xbtMgrKG4BRUmU
 SF2tOTjdbHPFGwTv344cOtrivObIsXVHH4g6r/bkE9j4TEW5zLBhSC7H10HkX2Lpb
X-Gm-Gg: AZuq6aKCfG7io/zaESMDg1t5dgbUGq9+ELkQdQTEwfKhvBRfV1kgVNxLSzmy+pfUakf
 bgWaPMGwv2tUGq/hrnfbwevujMzNWBuRbVuIbq9Aw4nJ0oth5i+kycUfx4d0kY0llM5GqEl5hfd
 zc7Vqfgk53FSe0b1jINGnPKxNJYQ+jcysW8Q0PWJifkknVJ4LtpFjTH7Lk+J/zbnKEmMVvno4qg
 g/xpz1ZMFqkoQW3fqqKEl03nvUM0UL95mL2+MLzIofqtR3AGSEOc0kzIbXShedjC7GGXsXh+4X7
 j4m/zaoLHe9wukzKF/l0sauT+6ei5ulTRcFZKAffppG9IDXjjnWbmkwd0s/ZR4i6LOkR5PdJ1Y6
 q2a+Cf1ArqDau4S1OvbE+ddnhZ0KbcQzquUYAmTco22IoRqH6bd7dGBsPBEdQ/eKfChDXB9fgc6
 5ORwNMC9aCBNLDNlIXjIKK0qzuiw==
X-Received: by 2002:a05:600c:828e:b0:47d:6140:3284 with SMTP id
 5b1f17b1804b1-48350835edfmr15410315e9.37.1770711750755; 
 Tue, 10 Feb 2026 00:22:30 -0800 (PST)
X-Received: by 2002:a05:600c:828e:b0:47d:6140:3284 with SMTP id
 5b1f17b1804b1-48350835edfmr15410015e9.37.1770711750236; 
 Tue, 10 Feb 2026 00:22:30 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d8df8sm47795665e9.3.2026.02.10.00.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 00:22:29 -0800 (PST)
Message-ID: <f7e66270-9d0e-46fb-b465-0b4887287a7f@redhat.com>
Date: Tue, 10 Feb 2026 09:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] json-streamer: remove token queue
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-4-pbonzini@redhat.com> <87v7g581xh.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87v7g581xh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/10/26 08:58, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Now fully exploit the push parser, feeding it one token at a time
>> without having to wait until braces and brackets are balanced.
>>
>> While the nesting counts are retained for error recovery purposes,
>> the system can now report the first parsing error without waiting
>> for delimiters to be balanced.  This also means that JSON_ERROR
>> can be handled in json-parser.c, not json-streamer.c.
>>
>> After reporting the error, json-streamer.c then enters an error recovery
>> mode where subsequent errors are suppressed.  This mimics the previous
>> error reporting behavior, but it provides prompt feedback on parsing
>> errors.  As an example, here is an example interaction with qemu-ga.
>>
>> BEFORE (error reported only once braces are balanced):
>>
>>     >> {'execute':foo
>>     >> }
>>     << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
>>     >> {'execute':'somecommand'}
>>     << {"error": {"class": "CommandNotFound", "desc": "The command somecommand has not been found"}}
>>
>> AFTER (error reported immediately, but similar error recovery as before):
>>
>>     >> {'execute':foo
>>     << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
>>     >> }
>>     >> {'execute':'qmp_capabilities'}
>>     << {"error": {"class": "CommandNotFound", "desc": "The command qmp_capabilities has not been found"}}
> 
> Welcome quality of life improvement for human use of QMP, such as manual
> testing.  The experience is still sub-par when you miss closing
> parenthesis: you get the silent treatment.
> 
> Nitpick #1: Single quotes are an syntax extension made to enable more
> readable QMP input in C strings.  Letting it leak into the external
> interface was a mistake.  The less we show their use, the better.  Let's
> stick to doublequotes here.
> 
> Nitpick #2: example input differs needlessly between BEFORE and AFTER.
> 
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   include/qobject/json-parser.h |   5 +-
>>   qobject/json-parser-int.h     |   1 +
>>   qobject/json-parser.c         |  26 +++++---
>>   qobject/json-streamer.c       | 116 ++++++++++++++--------------------
>>   4 files changed, 68 insertions(+), 80 deletions(-)
>>
>> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
>> index 05346fa816b..923eb74ca00 100644
>> --- a/include/qobject/json-parser.h
>> +++ b/include/qobject/json-parser.h
>> @@ -29,11 +29,12 @@ typedef struct JSONParserContext {
>>   typedef struct JSONMessageParser {
>>       void (*emit)(void *opaque, QObject *json, Error *err);
>>       void *opaque;
>> -    va_list *ap;
>>       JSONLexer lexer;
>> +    JSONParserContext parser;
>>       int brace_count;
>>       int bracket_count;
>> -    GQueue tokens;
>> +    int token_count;
>> +    bool error;
>>       uint64_t token_size;
>>   } JSONMessageParser;
>>   
>> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
>> index 05e2e8e1831..1f435cb8eb2 100644
>> --- a/qobject/json-parser-int.h
>> +++ b/qobject/json-parser-int.h
>> @@ -50,6 +50,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>>   /* json-parser.c */
>>   JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
>>   void json_parser_init(JSONParserContext *ctxt, va_list *ap);
>> +void json_parser_reset(JSONParserContext *ctxt);
>>   QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
>>   void json_parser_destroy(JSONParserContext *ctxt);
>>   
>> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
>> index 338f0c5aae6..7abdea4dacb 100644
>> --- a/qobject/json-parser.c
>> +++ b/qobject/json-parser.c
>> @@ -541,21 +541,27 @@ JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
>>       return token;
>>   }
>>   
>> -void json_parser_init(JSONParserContext *ctxt, va_list *ap)
>> -{
>> -    ctxt->err = NULL;
>> -    ctxt->stack = g_queue_new();
>> -    ctxt->ap = ap;
>> -}
>> -
>> -void json_parser_destroy(JSONParserContext *ctxt)
>> +void json_parser_reset(JSONParserContext *ctxt)
>>   {
>>       JSONParserStackEntry *entry;
>>   
>> +    ctxt->err = NULL;
>>       while ((entry = g_queue_pop_tail(ctxt->stack)) != NULL) {
>>           qobject_unref(entry->partial);
>>           g_free(entry);
>>       }
>> +}
>> +
>> +void json_parser_init(JSONParserContext *ctxt, va_list *ap)
>> +{
>> +    ctxt->stack = g_queue_new();
>> +    ctxt->ap = ap;
>> +    json_parser_reset(ctxt);
>> +}
>> +
>> +void json_parser_destroy(JSONParserContext *ctxt)
>> +{
>> +    json_parser_reset(ctxt);
>>       g_queue_free(ctxt->stack);
>>       ctxt->stack = NULL;
>>   }
>> @@ -566,6 +572,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error
>>   
>>       assert(!ctxt->err);
>>       switch (token->type) {
>> +    case JSON_ERROR:
>> +        parse_error(ctxt, token, "JSON parse error, stray '%s'", token->str);
>> +        break;
>> +
>>       case JSON_END_OF_INPUT:
>>           /* Check for premature end of input */
>>           if (!g_queue_is_empty(ctxt->stack)) {
>> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
>> index 6c93e6fd78d..a1210128ac1 100644
>> --- a/qobject/json-streamer.c
>> +++ b/qobject/json-streamer.c
>> @@ -1,5 +1,5 @@
>>   /*
>> - * JSON streaming support
>> + * JSON parser - callback interface and error recovery
> 
> "Streaming" has always been misleading.  This isn't a streaming parser,
> and never was.  It's a conventional parser wed to a push lexer with a
> hack before this series, and a push parser afterwards.
> 
>>    *
>>    * Copyright IBM, Corp. 2009
>>    *
>> @@ -19,97 +19,73 @@
>>   #define MAX_TOKEN_COUNT (2ULL << 20)
>>   #define MAX_NESTING (1 << 10)
>>   
>> -static void json_message_free_tokens(JSONMessageParser *parser)
>> -{
>> -    JSONToken *token;
>> -
>> -    while ((token = g_queue_pop_head(&parser->tokens))) {
>> -        g_free(token);
>> -    }
>> -}
>> -
>>   void json_message_process_token(JSONLexer *lexer, GString *input,
>>                                   JSONTokenType type, int x, int y)
>>   {
>>       JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
>> -    JSONParserContext ctxt;
>> -    QObject *json = NULL;
>> +    g_autofree JSONToken *token = json_token(type, x, y, input);
>>       Error *err = NULL;
>> -    JSONToken *token;
>>   
>> +    parser->token_size += input->len;
>> +    parser->token_count++;
>> +
>> +    /* Detect message boundaries for error recovery purposes.  */
> 
> I like the comment.
> 
>>       switch (type) {
>>       case JSON_LCURLY:
>>           parser->brace_count++;
>>           break;
>>       case JSON_RCURLY:
>> -        parser->brace_count--;
>> +        if (parser->brace_count > 0) {
>> +            parser->brace_count--;
>> +        }
> 
> Looks like you're keeping @brace_count (here) and @bracket_count (below)
> non-negative.  Any particular reason?

Because negative brace_count/bracket_count is an insta-recovered error. 
I could make it

     if ((parser->brace_count <= 0 && parser->bracket_count <= 0)

below, or even better make this a separate patch.

>> +        /*
>> +         * Security consideration, we limit total memory allocated per object
>> +         * and the maximum recursion depth that a message can force.
>> +         */
> 
> This comment now needs rephrasing: there's no recursion anymore.  In the
> previous commit if we're feeling persnickety.

s/recursion/nesting/?

> Not mentioned in the commit message: before the patch, the "streamer"
> calls json_parser_init() and json_parser_destroy() for each balanced
> expression.  Afterwards, it calls them once, and instea calls
> json_parser_reset() between balanced expressions.
> 
> I wonder whether it could be a separate patch.

Sure.  I'll also try to make "brace_count"/"bracket_count" unsigned in a 
separate patch.

Paolo


