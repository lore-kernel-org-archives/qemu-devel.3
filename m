Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EDDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBdY-0001pb-GM; Mon, 29 Jun 2026 09:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weBdX-0001pQ-1M
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weBdV-0000EV-A8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782738171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4fQvXF6OJ+yS/Hv8VL8K6f+PD9YtdaHZwYXmNM/VKE=;
 b=g3k/NljSqIIL4G9ezXZgsSNYAdkJlYjQmAQJLN+h1t0ljHAwMNNw9B8xe3nLedFohO3YUP
 /HBOVHOFu9yV8gQ3F2cCbNlkX7/iRnDf2vMj8HSqQg/JtN7abQqgKkRrseeSbwUxK1+cg9
 6x1qRzVji+uT7UtGjHTXeI/RWyX+fto=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-068vVdivPZ6qF4DD3JlUSw-1; Mon,
 29 Jun 2026 09:02:49 -0400
X-MC-Unique: 068vVdivPZ6qF4DD3JlUSw-1
X-Mimecast-MFC-AGG-ID: 068vVdivPZ6qF4DD3JlUSw_1782738168
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C4C1195606B
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:02:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5939219560AB
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:02:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF1E521E6920; Mon, 29 Jun 2026 15:02:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/6] json-parser: replace with a push parser
In-Reply-To: <20260626101727.1727389-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 26 Jun 2026 12:17:21 +0200")
References: <20260626101727.1727389-1-pbonzini@redhat.com>
 <20260626101727.1727389-2-pbonzini@redhat.com>
Date: Mon, 29 Jun 2026 15:02:45 +0200
Message-ID: <87a4sdts7e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> In order to avoid stashing all the tokens corresponding to a JSON value,
> embed the parsing stack and state machine in JSONParser.  This is more
> efficient and allows for more prompt error recovery; it also does not
> make the code substantially larger than the current recursive descent
> parser, though the state machine is probably a bit harder to follow.
>
> The stack consists of QLists and QDicts corresponding to open
> brackets and braces, plus optionally a QString with the current
> key on top of each QDict.
>
> After each value is parsed, it is added to the top array or dictionary
> or, if the stack is empty, json_parser_feed returns the complete
> QObject.
>
> For now, json-streamer.c keeps tracking the tokens up until braces
> and brackets are balanced, and then shoves the whole queue of tokens
> into the push parser.  The only logic change is that JSON_END_OF_INPUT
> always triggers the emptying of the queue; the parser takes notice and
> checks that there is nothing on the stack.  Not using brace_count
> and bracket_count for this is the first step towards improved separation
> of concerns between json-parser.c and json-streamer.c.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

[...]

> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index f6622b82b0a..845da3699aa 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -31,12 +31,111 @@ struct JSONToken {
>      char str[];
>  };
>  
> -typedef struct JSONParserContext {
> -    Error *err;
> -    JSONToken *current;
> -    GQueue *buf;
> -    va_list *ap;
> -} JSONParserContext;
> +/*
> + * The JSON parser is a push parser, returning to the caller after every
> + * token.  Therefore it has an explicit representation of its parser

I think you proposed "returning a completed top-level object, an error,
or NULL (if the object is incomplete and no error happened) after every
token".  Happy to apply that without a respin.

> + * stack; each stack entry consists of a parser state and a QObject:
> + * - a QList, for an array that is being added to
> + * - a QDict, for a dictionary that is being added to
> + * - a QString, for the key of the next pair that will be added to a QDict
> + *
> + * The stack represents an arbitrary nesting of arrays and dictionaries
> + * (whose next key has been parsed); it can also have a dictionary whose
> + * next key has not been parsed, but that can only happen at the top level.
> + * Because of this, the stack contents are always of the form
> + * "(QList | QDict QString)* QDict?".
> + *
> + * An empty stack represents the beginning of the parsing process, with
> + * start state BEFORE_VALUE.
> + */

[...]

> +/*
> + * Advance the parser based on the token that is passed.
> + * Return the finished top-level value if the token completes it.
> + * If an error is returned, the function must not be called without
> + * first resetting the parser.
> + */

Suggested polish:

    /*
    * Advance the parser based on the token that is passed.
    * Return the finished top-level value if the token completes it,
    * else NULL.
    * Once an error is returned, the function must not be called again
    * without first resetting the parser.
    */

Again, not worth a respin.

> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token,
> +                          Error **errp)
> +{
> +    QObject *result = NULL;
> +
> +    assert(!ctxt->err);
> +    switch (token->type) {
> +    case JSON_END_OF_INPUT:
> +        /* Check for premature end of input */
> +        if (!g_queue_is_empty(ctxt->stack)) {
> +            parse_error(ctxt, token, "premature end of input");
> +        }
> +        break;
> +
> +    default:
> +        result = parse_token(ctxt, token);
> +        break;
> +    }
> +
> +    error_propagate(errp, ctxt->err);
>      return result;
>  }

[...]


