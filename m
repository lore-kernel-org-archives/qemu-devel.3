Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90110EA3F16
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpieG-00027J-88; Tue, 10 Feb 2026 02:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpieC-000270-LP
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:59:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpieA-0007ru-33
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770710336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lq9xdh238CQACAJTyxElMbaXFlmV/VQDDf06qqMVSCY=;
 b=Tad/QSH5bm/fN35SQEMakDJ1EcR7jmCJKYFjmq+ANgdlTE29Z1cB8RPxRqakv7R1SnVU+5
 G+L8EPYJyQPjGfIyZMIJU2G8wTK9mQi/bYPjq2W4aSfLkF097flnSgjpSFtFIxACkjf+62
 av9FN5Q7z0rYHiAYNmEMY+tMnPr35rQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-9VACNYpEMEuI4hzHNRKxNQ-1; Tue,
 10 Feb 2026 02:58:54 -0500
X-MC-Unique: 9VACNYpEMEuI4hzHNRKxNQ-1
X-Mimecast-MFC-AGG-ID: 9VACNYpEMEuI4hzHNRKxNQ_1770710334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9C6A1800365
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:58:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27D1F19560A3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:58:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93F1E21E692D; Tue, 10 Feb 2026 08:58:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] json-streamer: remove token queue
In-Reply-To: <20260107084840.150843-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 7 Jan 2026 09:48:38 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-4-pbonzini@redhat.com>
Date: Tue, 10 Feb 2026 08:58:50 +0100
Message-ID: <87v7g581xh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> Now fully exploit the push parser, feeding it one token at a time
> without having to wait until braces and brackets are balanced.
>
> While the nesting counts are retained for error recovery purposes,
> the system can now report the first parsing error without waiting
> for delimiters to be balanced.  This also means that JSON_ERROR
> can be handled in json-parser.c, not json-streamer.c.
>
> After reporting the error, json-streamer.c then enters an error recovery
> mode where subsequent errors are suppressed.  This mimics the previous
> error reporting behavior, but it provides prompt feedback on parsing
> errors.  As an example, here is an example interaction with qemu-ga.
>
> BEFORE (error reported only once braces are balanced):
>
>    >> {'execute':foo
>    >> }
>    << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
>    >> {'execute':'somecommand'}
>    << {"error": {"class": "CommandNotFound", "desc": "The command somecommand has not been found"}}
>
> AFTER (error reported immediately, but similar error recovery as before):
>
>    >> {'execute':foo
>    << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
>    >> }
>    >> {'execute':'qmp_capabilities'}
>    << {"error": {"class": "CommandNotFound", "desc": "The command qmp_capabilities has not been found"}}

Welcome quality of life improvement for human use of QMP, such as manual
testing.  The experience is still sub-par when you miss closing
parenthesis: you get the silent treatment.

Nitpick #1: Single quotes are an syntax extension made to enable more
readable QMP input in C strings.  Letting it leak into the external
interface was a mistake.  The less we show their use, the better.  Let's
stick to doublequotes here.

Nitpick #2: example input differs needlessly between BEFORE and AFTER.

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/json-parser.h |   5 +-
>  qobject/json-parser-int.h     |   1 +
>  qobject/json-parser.c         |  26 +++++---
>  qobject/json-streamer.c       | 116 ++++++++++++++--------------------
>  4 files changed, 68 insertions(+), 80 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 05346fa816b..923eb74ca00 100644
> --- a/include/qobject/json-parser.h
> +++ b/include/qobject/json-parser.h
> @@ -29,11 +29,12 @@ typedef struct JSONParserContext {
>  typedef struct JSONMessageParser {
>      void (*emit)(void *opaque, QObject *json, Error *err);
>      void *opaque;
> -    va_list *ap;
>      JSONLexer lexer;
> +    JSONParserContext parser;
>      int brace_count;
>      int bracket_count;
> -    GQueue tokens;
> +    int token_count;
> +    bool error;
>      uint64_t token_size;
>  } JSONMessageParser;
>  
> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
> index 05e2e8e1831..1f435cb8eb2 100644
> --- a/qobject/json-parser-int.h
> +++ b/qobject/json-parser-int.h
> @@ -50,6 +50,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>  /* json-parser.c */
>  JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
>  void json_parser_init(JSONParserContext *ctxt, va_list *ap);
> +void json_parser_reset(JSONParserContext *ctxt);
>  QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
>  void json_parser_destroy(JSONParserContext *ctxt);
>  
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 338f0c5aae6..7abdea4dacb 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -541,21 +541,27 @@ JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
>      return token;
>  }
>  
> -void json_parser_init(JSONParserContext *ctxt, va_list *ap)
> -{
> -    ctxt->err = NULL;
> -    ctxt->stack = g_queue_new();
> -    ctxt->ap = ap;
> -}
> -
> -void json_parser_destroy(JSONParserContext *ctxt)
> +void json_parser_reset(JSONParserContext *ctxt)
>  {
>      JSONParserStackEntry *entry;
>  
> +    ctxt->err = NULL;
>      while ((entry = g_queue_pop_tail(ctxt->stack)) != NULL) {
>          qobject_unref(entry->partial);
>          g_free(entry);
>      }
> +}
> +
> +void json_parser_init(JSONParserContext *ctxt, va_list *ap)
> +{
> +    ctxt->stack = g_queue_new();
> +    ctxt->ap = ap;
> +    json_parser_reset(ctxt);
> +}
> +
> +void json_parser_destroy(JSONParserContext *ctxt)
> +{
> +    json_parser_reset(ctxt);
>      g_queue_free(ctxt->stack);
>      ctxt->stack = NULL;
>  }
> @@ -566,6 +572,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error
>  
>      assert(!ctxt->err);
>      switch (token->type) {
> +    case JSON_ERROR:
> +        parse_error(ctxt, token, "JSON parse error, stray '%s'", token->str);
> +        break;
> +
>      case JSON_END_OF_INPUT:
>          /* Check for premature end of input */
>          if (!g_queue_is_empty(ctxt->stack)) {
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index 6c93e6fd78d..a1210128ac1 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -1,5 +1,5 @@
>  /*
> - * JSON streaming support
> + * JSON parser - callback interface and error recovery

"Streaming" has always been misleading.  This isn't a streaming parser,
and never was.  It's a conventional parser wed to a push lexer with a
hack before this series, and a push parser afterwards.

>   *
>   * Copyright IBM, Corp. 2009
>   *
> @@ -19,97 +19,73 @@
>  #define MAX_TOKEN_COUNT (2ULL << 20)
>  #define MAX_NESTING (1 << 10)
>  
> -static void json_message_free_tokens(JSONMessageParser *parser)
> -{
> -    JSONToken *token;
> -
> -    while ((token = g_queue_pop_head(&parser->tokens))) {
> -        g_free(token);
> -    }
> -}
> -
>  void json_message_process_token(JSONLexer *lexer, GString *input,
>                                  JSONTokenType type, int x, int y)
>  {
>      JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
> -    JSONParserContext ctxt;
> -    QObject *json = NULL;
> +    g_autofree JSONToken *token = json_token(type, x, y, input);
>      Error *err = NULL;
> -    JSONToken *token;
>  
> +    parser->token_size += input->len;
> +    parser->token_count++;
> +
> +    /* Detect message boundaries for error recovery purposes.  */

I like the comment.

>      switch (type) {
>      case JSON_LCURLY:
>          parser->brace_count++;
>          break;
>      case JSON_RCURLY:
> -        parser->brace_count--;
> +        if (parser->brace_count > 0) {
> +            parser->brace_count--;
> +        }

Looks like you're keeping @brace_count (here) and @bracket_count (below)
non-negative.  Any particular reason?

Make them unsigned?

>          break;
>      case JSON_LSQUARE:
>          parser->bracket_count++;
>          break;
>      case JSON_RSQUARE:
> -        parser->bracket_count--;
> -        break;
> -    case JSON_ERROR:
> -        error_setg(&err, "JSON parse error, stray '%s'", input->str);
> -        goto out_emit;
> -    case JSON_END_OF_INPUT:
> -        if (g_queue_is_empty(&parser->tokens)) {
> -            return;
> +        if (parser->bracket_count > 0) {
> +            parser->bracket_count--;
>          }
>          break;
>      default:
>          break;
>      }
>  
> -    /*
> -     * Security consideration, we limit total memory allocated per object
> -     * and the maximum recursion depth that a message can force.
> -     */
> -    if (parser->token_size + input->len + 1 > MAX_TOKEN_SIZE) {
> -        error_setg(&err, "JSON token size limit exceeded");
> -        goto out_emit;
> -    }
> -    if (g_queue_get_length(&parser->tokens) + 1 > MAX_TOKEN_COUNT) {
> -        error_setg(&err, "JSON token count limit exceeded");
> -        goto out_emit;
> -    }
> -    if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
> -        error_setg(&err, "JSON nesting depth limit exceeded");
> -        goto out_emit;
> -    }
> +    /* during error recovery eat tokens until parentheses balance */
> +    if (!parser->error) {

I think I'd write this as

       if (parser->error) {
           /* error recovery: eat tokens until parentheses balance */
       } else {

> +        /*
> +         * Security consideration, we limit total memory allocated per object
> +         * and the maximum recursion depth that a message can force.
> +         */

This comment now needs rephrasing: there's no recursion anymore.  In the
previous commit if we're feeling persnickety.

Suggest s/security/safety/ while there.

> +        if (parser->token_size > MAX_TOKEN_SIZE) {
> +            error_setg(&err, "JSON token size limit exceeded");
> +        } else if (parser->token_count > MAX_TOKEN_COUNT) {
> +            error_setg(&err, "JSON token count limit exceeded");
> +        } else if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
> +            error_setg(&err, "JSON nesting depth limit exceeded");
> +        } else {
> +            QObject *json = json_parser_feed(&parser->parser, token, &err);
> +            if (json) {
> +                parser->emit(parser->opaque, json, NULL);
> +            }
> +        }
>  
> -    token = json_token(type, x, y, input);
> -    parser->token_size += input->len;
> -
> -    g_queue_push_tail(&parser->tokens, token);
> -
> -    if ((parser->brace_count > 0 || parser->bracket_count > 0)
> -        && parser->brace_count >= 0 && parser->bracket_count >= 0
> -        && type != JSON_END_OF_INPUT) {
> -        return;
> -    }
> -
> -    json_parser_init(&ctxt, parser->ap);
> -
> -    /* Process all tokens in the queue */
> -    while (!g_queue_is_empty(&parser->tokens)) {
> -        token = g_queue_pop_head(&parser->tokens);
> -        json = json_parser_feed(&ctxt, token, &err);
> -        g_free(token);
> -        if (json || err) {
> -            break;
> +        if (err) {
> +            parser->emit(parser->opaque, NULL, err);
> +            /* start recovery */
> +            parser->error = true;
>          }
>      }
>  
> -    json_parser_destroy(&ctxt);
> -
> -out_emit:
> -    parser->brace_count = 0;
> -    parser->bracket_count = 0;
> -    json_message_free_tokens(parser);
> -    parser->token_size = 0;
> -    parser->emit(parser->opaque, json, err);
> +    if ((parser->brace_count == 0 && parser->bracket_count == 0)
> +        || type == JSON_END_OF_INPUT) {
> +        parser->error = false;
> +        parser->brace_count = 0;
> +        parser->bracket_count = 0;
> +        parser->token_count = 0;
> +        parser->token_size = 0;
> +        json_parser_reset(&parser->parser);
> +    }
>  }
>  
>  void json_message_parser_init(JSONMessageParser *parser,
> @@ -119,12 +95,13 @@ void json_message_parser_init(JSONMessageParser *parser,
>  {
>      parser->emit = emit;
>      parser->opaque = opaque;
> -    parser->ap = ap;
> +    parser->error = false;
>      parser->brace_count = 0;
>      parser->bracket_count = 0;
> -    g_queue_init(&parser->tokens);
> +    parser->token_count = 0;
>      parser->token_size = 0;
>  
> +    json_parser_init(&parser->parser, ap);
>      json_lexer_init(&parser->lexer, !!ap);
>  }
>  
> @@ -137,11 +114,10 @@ void json_message_parser_feed(JSONMessageParser *parser,
>  void json_message_parser_flush(JSONMessageParser *parser)
>  {
>      json_lexer_flush(&parser->lexer);
> -    assert(g_queue_is_empty(&parser->tokens));
>  }
>  
>  void json_message_parser_destroy(JSONMessageParser *parser)
>  {
>      json_lexer_destroy(&parser->lexer);
> -    json_message_free_tokens(parser);
> +    json_parser_destroy(&parser->parser);
>  }

Not mentioned in the commit message: before the patch, the "streamer"
calls json_parser_init() and json_parser_destroy() for each balanced
expression.  Afterwards, it calls them once, and instea calls
json_parser_reset() between balanced expressions.

I wonder whether it could be a separate patch.


