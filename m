Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76585CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY3V0-0000Z4-1V; Fri, 12 Jun 2026 11:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wY3Uy-0000Yf-MZ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wY3Uw-0005cc-Pp
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781276920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DtfpKfNkGBrYaAjBDalL46vJazpq/yTtZu3slAzi/5k=;
 b=GsQACE21gOH0Q/HN0bQsGPaJCCkV52UDfCYgAK3i+2gnxHSbPNCkmSgbsal//ZX9m3xflh
 3yqirbowSICV27qT8w24rqAnZ402P2qbkY2SwLsjpxfKpzhHFQELLJg2Z8Lq81312q4YGs
 7BsvC9heCGjwTHh3T8BqfjM2RQ4GioM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-xu9HiwYxOSCzdZKC9A9W2g-1; Fri,
 12 Jun 2026 11:08:39 -0400
X-MC-Unique: xu9HiwYxOSCzdZKC9A9W2g-1
X-Mimecast-MFC-AGG-ID: xu9HiwYxOSCzdZKC9A9W2g_1781276918
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95840195609E
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 15:08:38 +0000 (UTC)
Received: from [10.44.32.88] (unknown [10.44.32.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 839A61955BD4; Fri, 12 Jun 2026 15:08:37 +0000 (UTC)
Message-ID: <eeff3845-a564-4871-9b7f-bf91ba3f2295@redhat.com>
Date: Fri, 12 Jun 2026 17:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] json-parser: replace with a push parser
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-3-pbonzini@redhat.com> <87v7bnvnz1.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87v7bnvnz1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/12/26 16:21, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> In order to avoid stashing all the tokens corresponding to a JSON value,
>> embed the parsing stack and state machine in JSONParser.  This is more
>> efficient and allows for more prompt error recovery; it also does not
>> make the code substantially larger than the current recursive descent
>> parser, though the state machine is probably a bit harder to follow.
>>
>> The stack consists of QLists and QDicts corresponding to open
>> brackets and braces, plus optionally a QString with the current
>> key on top of each QDict.
>>
>> After each value is parsed, it is added to the top array or dictionary
>> or, if the stack is empty, json_parser_feed returns the complete
>> QObject.
>>
>> For now, json-streamer.c keeps tracking the tokens up until braces
>> and brackets are balanced, and then shoves the whole queue of tokens
>> into the push parser.  The only logic change is that JSON_END_OF_INPUT
>> always triggers the emptying of the queue; the parser takes notice and
>> checks that there is nothing on the stack.  Not using brace_count
>> and bracket_count for this is the first step towards improved separation
>> of concerns between json-parser.c and json-streamer.c.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   include/qobject/json-parser.h |   6 +
>>   qobject/json-parser-int.h     |   5 +-
>>   qobject/json-parser.c         | 551 ++++++++++++++++++++--------------
>>   qobject/json-streamer.c       |  21 +-
>>   4 files changed, 345 insertions(+), 238 deletions(-)
>>
>> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
>> index 7345a9bd5cb..05346fa816b 100644
>> --- a/include/qobject/json-parser.h
>> +++ b/include/qobject/json-parser.h
>> @@ -20,6 +20,12 @@ typedef struct JSONLexer {
>>       int x, y;
>>   } JSONLexer;
>>   
>> +typedef struct JSONParserContext {
>> +    Error *err;
>> +    GQueue *stack;
>> +    va_list *ap;
>> +} JSONParserContext;
>> +
>>   typedef struct JSONMessageParser {
>>       void (*emit)(void *opaque, QObject *json, Error *err);
>>       void *opaque;
>> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
>> index 8c01f236276..1f435cb8eb2 100644
>> --- a/qobject/json-parser-int.h
>> +++ b/qobject/json-parser-int.h
>> @@ -49,6 +49,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>>   
>>   /* json-parser.c */
>>   JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
>> -QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
>> +void json_parser_init(JSONParserContext *ctxt, va_list *ap);
>> +void json_parser_reset(JSONParserContext *ctxt);
>> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
>> +void json_parser_destroy(JSONParserContext *ctxt);
>>   
>>   #endif
>> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
>> index f6622b82b0a..3b5edc5bae4 100644
>> --- a/qobject/json-parser.c
>> +++ b/qobject/json-parser.c
>> @@ -31,12 +31,105 @@ struct JSONToken {
>>       char str[];
>>   };
>>   
>> -typedef struct JSONParserContext {
>> -    Error *err;
>> -    JSONToken *current;
>> -    GQueue *buf;
>> -    va_list *ap;
>> -} JSONParserContext;
>> +/*
>> + * The JSON parser is a push parser, returning to the caller after every
>> + * token.
> 
> The thing that returns after every token is json_parser_feed(), right?
> 
> Detail not mentioned here: the value it returns.  Leaving that to
> json_parser_feed()'s contract feels fine, but pointing from here to
> there could be useful.

"returning a completed top-level object, an error, or NULL (if the 
object is incomplete and no error happened) after every token"?
>> + * // The initial state is BEFORE_VALUE.
>> + * input :=  value         -> END_OF_VALUE -> return parsed value
>> + *           END_OF_INPUT  -> check stack is empty
> 
> How can the stack *not* be empty here?

Right, this is not END_OF_INPUT in the middle of the stream.  Will delete.
>> + * // entered on BEFORE_KEY, with TOS being a QDict
>> + * dict_pairs := (STRING | INTERP) -> push QString -> END_OF_KEY
>> + *         ':'             -> BEFORE_VALUE
>> + *         value           -> pop QString + add pair to QDict -> END_OF_VALUE
>> + *         ('}'            -> pop completed QDict -> END_OF_VALUE
>> + *          | ','          -> BEFORE_KEY
>> + *            dict_pairs)  -> END_OF_VALUE
>> + */
> 
> This is useful.
> 
> It doesn't mention how we do parse errors.  Leaving that to
> json_parser_feed()'s contract feels fine.

Right---parse errors are out of the scope because recovery happens in 
json-streamer.c.

I can add a note for this and everything else, thanks for the review! 
Rewrites are not the most enticing form of thing to receive, or the most 
polite to send.

Paolo


