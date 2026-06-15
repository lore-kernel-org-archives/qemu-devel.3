Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444AECD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ248-0005uU-Uh; Mon, 15 Jun 2026 03:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ246-0005uK-Kw
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ243-0005lf-PR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781509737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJzIVRHuBc3AVcIMe4XoJbo5iX4YgYNCF0SvNPHobKg=;
 b=PazchB994kYizQpx2HZtVFpYZYTBD3KO2NZoip/HsMemkO43ds3j8MxnVEeOEYwNMqpWQE
 O9S7N/rigDe4aiH8HJoJpVTZmOSibq3IBKoNB36ZAdhwwYBRduxSOFdVyoHYGe7B+xsEgl
 kC794x2getQu6BenjV6gtFewSagYAgs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-rXiC14haMzaVxOmqLxYKfg-1; Mon,
 15 Jun 2026 03:48:55 -0400
X-MC-Unique: rXiC14haMzaVxOmqLxYKfg-1
X-Mimecast-MFC-AGG-ID: rXiC14haMzaVxOmqLxYKfg_1781509735
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D498919560A1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:48:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51DC7180049F
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:48:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB57821E6A01; Mon, 15 Jun 2026 09:48:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/7] json-parser: replace with a push parser
In-Reply-To: <eeff3845-a564-4871-9b7f-bf91ba3f2295@redhat.com> (Paolo
 Bonzini's message of "Fri, 12 Jun 2026 17:08:34 +0200")
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-3-pbonzini@redhat.com>
 <87v7bnvnz1.fsf@pond.sub.org>
 <eeff3845-a564-4871-9b7f-bf91ba3f2295@redhat.com>
Date: Mon, 15 Jun 2026 09:48:51 +0200
Message-ID: <87jys0s0po.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/12/26 16:21, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> In order to avoid stashing all the tokens corresponding to a JSON value,
>>> embed the parsing stack and state machine in JSONParser.  This is more
>>> efficient and allows for more prompt error recovery; it also does not
>>> make the code substantially larger than the current recursive descent
>>> parser, though the state machine is probably a bit harder to follow.
>>>
>>> The stack consists of QLists and QDicts corresponding to open
>>> brackets and braces, plus optionally a QString with the current
>>> key on top of each QDict.
>>>
>>> After each value is parsed, it is added to the top array or dictionary
>>> or, if the stack is empty, json_parser_feed returns the complete
>>> QObject.
>>>
>>> For now, json-streamer.c keeps tracking the tokens up until braces
>>> and brackets are balanced, and then shoves the whole queue of tokens
>>> into the push parser.  The only logic change is that JSON_END_OF_INPUT
>>> always triggers the emptying of the queue; the parser takes notice and
>>> checks that there is nothing on the stack.  Not using brace_count
>>> and bracket_count for this is the first step towards improved separation
>>> of concerns between json-parser.c and json-streamer.c.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   include/qobject/json-parser.h |   6 +
>>>   qobject/json-parser-int.h     |   5 +-
>>>   qobject/json-parser.c         | 551 ++++++++++++++++++++--------------
>>>   qobject/json-streamer.c       |  21 +-
>>>   4 files changed, 345 insertions(+), 238 deletions(-)
>>>
>>> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
>>> index 7345a9bd5cb..05346fa816b 100644
>>> --- a/include/qobject/json-parser.h
>>> +++ b/include/qobject/json-parser.h
>>> @@ -20,6 +20,12 @@ typedef struct JSONLexer {
>>>      int x, y;
>>>  } JSONLexer;
>>>  +typedef struct JSONParserContext {
>>> +    Error *err;
>>> +    GQueue *stack;
>>> +    va_list *ap;
>>> +} JSONParserContext;
>>> +
>>>  typedef struct JSONMessageParser {
>>>      void (*emit)(void *opaque, QObject *json, Error *err);
>>>      void *opaque;
>>> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
>>> index 8c01f236276..1f435cb8eb2 100644
>>> --- a/qobject/json-parser-int.h
>>> +++ b/qobject/json-parser-int.h
>>> @@ -49,6 +49,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>>>  /* json-parser.c */
>>>  JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
>>> -QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
>>> +void json_parser_init(JSONParserContext *ctxt, va_list *ap);
>>> +void json_parser_reset(JSONParserContext *ctxt);
>>> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
>>> +void json_parser_destroy(JSONParserContext *ctxt);
>>>
>>>  #endif
>>> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
>>> index f6622b82b0a..3b5edc5bae4 100644
>>> --- a/qobject/json-parser.c
>>> +++ b/qobject/json-parser.c
>>> @@ -31,12 +31,105 @@ struct JSONToken {
>>>      char str[];
>>>  };
>>> -typedef struct JSONParserContext {
>>> -    Error *err;
>>> -    JSONToken *current;
>>> -    GQueue *buf;
>>> -    va_list *ap;
>>> -} JSONParserContext;
>>> +/*
>>> + * The JSON parser is a push parser, returning to the caller after every
>>> + * token.
>>
>> The thing that returns after every token is json_parser_feed(), right?
>> Detail not mentioned here: the value it returns.  Leaving that to
>> json_parser_feed()'s contract feels fine, but pointing from here to
>> there could be useful.
>
> "returning a completed top-level object, an error, or NULL (if the object is incomplete and no error happened) after every token"?

I like it!

>>> + * // The initial state is BEFORE_VALUE.
>>> + * input :=  value         -> END_OF_VALUE -> return parsed value
>>> + *           END_OF_INPUT  -> check stack is empty
>>
>> How can the stack *not* be empty here?
>
> Right, this is not END_OF_INPUT in the middle of the stream.  Will delete.
>>> + * // entered on BEFORE_KEY, with TOS being a QDict
>>> + * dict_pairs := (STRING | INTERP) -> push QString -> END_OF_KEY
>>> + *         ':'             -> BEFORE_VALUE
>>> + *         value           -> pop QString + add pair to QDict -> END_OF_VALUE
>>> + *         ('}'            -> pop completed QDict -> END_OF_VALUE
>>> + *          | ','          -> BEFORE_KEY
>>> + *            dict_pairs)  -> END_OF_VALUE
>>> + */
>>
>> This is useful.
>>
>> It doesn't mention how we do parse errors.  Leaving that to
>> json_parser_feed()'s contract feels fine.
>
> Right---parse errors are out of the scope because recovery happens in json-streamer.c.
>
> I can add a note for this and everything else, thanks for the review! Rewrites are not the most enticing form of thing to receive, or the most polite to send.
>
> Paolo

In all fairness, I had moaned about this parser more than once,
e.g. "it's half-assed: it's a push lexer wed to a pull parser with
parenthesis counting."


