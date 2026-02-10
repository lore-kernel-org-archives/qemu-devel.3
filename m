Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC035EA3F22
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpj8w-0008Tf-Ej; Tue, 10 Feb 2026 03:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpj8v-0008TG-5X
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpj8s-0004sj-QJ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770712241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMVyhuQUhxGrEugH2MTu4rr3OlHJ8pB2w5f1Hcqbm2k=;
 b=PsnyRLWahJVlGjGme7cKoOkgYLog2SqD7zerzf5IU53CK+kO0ZDzFMYr8mIbbfqWxDwu38
 Rmjp7POPKAu74tDZF13lIdAuJXOO/Ta9sU8Czq1mg1Eh3wSLvp8kPj3PPF3tdzbQsRow2T
 bcneIW5+BjpEMivVRqFC6//ymusUziI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-2ZzEZPfIOpWnKTn9yNRKng-1; Tue,
 10 Feb 2026 03:30:40 -0500
X-MC-Unique: 2ZzEZPfIOpWnKTn9yNRKng-1
X-Mimecast-MFC-AGG-ID: 2ZzEZPfIOpWnKTn9yNRKng_1770712239
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CEC318005BC
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 08:30:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B2CD30001A5
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 08:30:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8ADFB21E692D; Tue, 10 Feb 2026 09:30:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] json-streamer: do not heap-allocate JSONToken
In-Reply-To: <20260107084840.150843-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 7 Jan 2026 09:48:39 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-5-pbonzini@redhat.com>
Date: Tue, 10 Feb 2026 09:30:36 +0100
Message-ID: <87pl6d80gj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> This is not needed with a push parser.  Since it processes tokens
> immediately, the JSONToken can be created directly on the stack
> and does not need to copy the lexer's string data.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qobject/json-parser-int.h |  8 ++++++--
>  qobject/json-parser.c     | 18 ------------------
>  qobject/json-streamer.c   |  4 ++--
>  3 files changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
> index 1f435cb8eb2..5a6b5c9af90 100644
> --- a/qobject/json-parser-int.h
> +++ b/qobject/json-parser-int.h
> @@ -35,7 +35,12 @@ typedef enum json_token_type {
>      JSON_MAX = JSON_END_OF_INPUT
>  } JSONTokenType;
>  
> -typedef struct JSONToken JSONToken;
> +typedef struct JSONToken {
> +    JSONTokenType type;
> +    int x;
> +    int y;
> +    char *str;
> +} JSONToken;
>  
>  /* json-lexer.c */
>  void json_lexer_init(JSONLexer *lexer, bool enable_interpolation);
> @@ -48,7 +53,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>                                  JSONTokenType type, int x, int y);
>  
>  /* json-parser.c */
> -JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
>  void json_parser_init(JSONParserContext *ctxt, va_list *ap);
>  void json_parser_reset(JSONParserContext *ctxt);
>  QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 7abdea4dacb..2fede59842f 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -24,13 +24,6 @@
>  #include "qobject/qstring.h"
>  #include "json-parser-int.h"
>  
> -struct JSONToken {
> -    JSONTokenType type;
> -    int x;
> -    int y;
> -    char str[];
> -};
> -
>  /*
>   * Objects: { } | { members }
>   * - Empty: { -> AFTER_LCURLY -> }
> @@ -529,17 +522,6 @@ static QObject *json_parser_parse_token(JSONParserContext *ctxt, const JSONToken
>      return NULL;
>  }
>  
> -JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
> -{
> -    JSONToken *token = g_malloc(sizeof(JSONToken) + tokstr->len + 1);
> -
> -    token->type = type;
> -    memcpy(token->str, tokstr->str, tokstr->len);
> -    token->str[tokstr->len] = 0;
> -    token->x = x;
> -    token->y = y;
> -    return token;
> -}
>  
>  void json_parser_reset(JSONParserContext *ctxt)
>  {
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index a1210128ac1..07e0ef51ce3 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -23,7 +23,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>                                  JSONTokenType type, int x, int y)
>  {
>      JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
> -    g_autofree JSONToken *token = json_token(type, x, y, input);
> +    JSONToken token = (JSONToken) { .type = type, .x = x, .y = y, .str = input->str };

checkpatch points out:

    0004-json-streamer-do-not-heap-allocate-JSONToken.patch:89: WARNING: line over 80 characters

Easy enough to avoid.

>      Error *err = NULL;
>  
>      parser->token_size += input->len;
> @@ -64,7 +64,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          } else if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
>              error_setg(&err, "JSON nesting depth limit exceeded");
>          } else {
> -            QObject *json = json_parser_feed(&parser->parser, token, &err);
> +            QObject *json = json_parser_feed(&parser->parser, &token, &err);
>              if (json) {
>                  parser->emit(parser->opaque, json, NULL);
>              }

With the long line tidied up
Reviewed-by: Markus Armbruster <armbru@redhat.com>


