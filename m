Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4682CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ598-0007cc-FK; Mon, 15 Jun 2026 07:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ595-0007cE-UB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ594-0007Yz-AV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781521580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zhaWiUk+thqYJxqHq/cB9HkoUiv7mVfKeNUIdcQihA=;
 b=DQYoUoHr9zbfJs1CSMwJ+B/Ut1Gu3KS3F9PofuiX21opMZQ0U6ufjJG2KeRlk/eFO+dRdh
 LnQPSb/lMvGtq4t40hRikITQiK5ROD6ZMIXr/wXP/8pKtUWi1dqz/udwRSWIUB4jVLzTDD
 MM6P/R9xO/GVrgwbM1VOQzlhOewBF4I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-jKPKAnuBMFmgz1SKEMSdqw-1; Mon,
 15 Jun 2026 07:06:19 -0400
X-MC-Unique: jKPKAnuBMFmgz1SKEMSdqw-1
X-Mimecast-MFC-AGG-ID: jKPKAnuBMFmgz1SKEMSdqw_1781521578
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C7B1956063
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:06:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41A34180049F
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:06:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEB3F21E6A01; Mon, 15 Jun 2026 13:06:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/7] json-parser: replace with a push parser
In-Reply-To: <20260525150503.393743-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 May 2026 17:04:58 +0200")
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-3-pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 13:06:15 +0200
Message-ID: <878q8gqd08.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
> index 8c01f236276..1f435cb8eb2 100644
> --- a/qobject/json-parser-int.h
> +++ b/qobject/json-parser-int.h
> @@ -49,6 +49,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>  
>  /* json-parser.c */
>  JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
> -QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
> +void json_parser_init(JSONParserContext *ctxt, va_list *ap);
> +void json_parser_reset(JSONParserContext *ctxt);
> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);

checkpatch WARNING: line over 80 characters.  It's just a warning, but
the line is *really* easy to break.

> +void json_parser_destroy(JSONParserContext *ctxt);
>  
>  #endif

[...]


