Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DB6CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2BI-00078W-PW; Mon, 15 Jun 2026 03:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ2B7-00078B-5Y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ2B5-0006yH-FQ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781510173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92J3hjNOrtyDukETXToigRW3VGgdjmEMgo32Tq7vO8w=;
 b=ZTnH6DmYA3cvPTjJkVOgZoFL/iL0c2E1GO9GkPt726WQLwB7EA4LvR0POI+rQWjNFgCo1U
 9+TWklWbaZ9r/JCGZ0xxaGVHPoANdDuC5SsXAMUC39lf37eWcaaoO29QUmx8iPTHQtLEpw
 GJ74cGvw2j9Ei+YZ+R0tiJ1dy1U3iyY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-giQoQRvHPI2OJ--kb15ElA-1; Mon,
 15 Jun 2026 03:56:11 -0400
X-MC-Unique: giQoQRvHPI2OJ--kb15ElA-1
X-Mimecast-MFC-AGG-ID: giQoQRvHPI2OJ--kb15ElA_1781510170
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 770731956058
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:56:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 352F51800367
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:56:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD2B021E6A01; Mon, 15 Jun 2026 09:56:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/7] json-streamer: reuse parser
In-Reply-To: <20260525150503.393743-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 May 2026 17:04:59 +0200")
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-4-pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 09:56:07 +0200
Message-ID: <87fr2os0dk.fsf@pond.sub.org>
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

> The push parser can be reset, so reuse it when the json-streamer
> detects a completed toplevel object.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/json-parser.h |  2 +-
>  qobject/json-streamer.c       | 11 ++++-------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 05346fa816b..4c3d89f751f 100644
> --- a/include/qobject/json-parser.h
> +++ b/include/qobject/json-parser.h
> @@ -29,8 +29,8 @@ typedef struct JSONParserContext {
>  typedef struct JSONMessageParser {
>      void (*emit)(void *opaque, QObject *json, Error *err);
>      void *opaque;
> -    va_list *ap;
>      JSONLexer lexer;
> +    JSONParserContext parser;
>      int brace_count;
>      int bracket_count;
>      GQueue tokens;
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index 6c93e6fd78d..f3dfdcaea12 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -32,7 +32,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>                                  JSONTokenType type, int x, int y)
>  {
>      JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
> -    JSONParserContext ctxt;
>      QObject *json = NULL;
>      Error *err = NULL;
>      JSONToken *token;
> @@ -90,26 +89,23 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          return;
>      }
>  
> -    json_parser_init(&ctxt, parser->ap);
> -
>      /* Process all tokens in the queue */
>      while (!g_queue_is_empty(&parser->tokens)) {
>          token = g_queue_pop_head(&parser->tokens);
> -        json = json_parser_feed(&ctxt, token, &err);
> +        json = json_parser_feed(&parser->parser, token, &err);
>          g_free(token);
>          if (json || err) {
>              break;
>          }
>      }
>  
> -    json_parser_destroy(&ctxt);
> -
>  out_emit:
>      parser->brace_count = 0;
>      parser->bracket_count = 0;
>      json_message_free_tokens(parser);
>      parser->token_size = 0;
>      parser->emit(parser->opaque, json, err);
> +    json_parser_reset(&parser->parser);
>  }

This made me stop and think.

I figure the more obvious *delta* would be to json_parser_reset() right
where json_parser_destroy() was.

But putting it here makes the code more obviously correct, I think.

No objection.  A hint in the commit message could've saved me a minute
or two.

>  
>  void json_message_parser_init(JSONMessageParser *parser,
> @@ -119,12 +115,12 @@ void json_message_parser_init(JSONMessageParser *parser,
>  {
>      parser->emit = emit;
>      parser->opaque = opaque;
> -    parser->ap = ap;
>      parser->brace_count = 0;
>      parser->bracket_count = 0;
>      g_queue_init(&parser->tokens);
>      parser->token_size = 0;
>  
> +    json_parser_init(&parser->parser, ap);
>      json_lexer_init(&parser->lexer, !!ap);
>  }
>  
> @@ -144,4 +140,5 @@ void json_message_parser_destroy(JSONMessageParser *parser)
>  {
>      json_lexer_destroy(&parser->lexer);
>      json_message_free_tokens(parser);
> +    json_parser_destroy(&parser->parser);
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


