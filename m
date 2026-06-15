Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B470CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ51j-00052K-Fp; Mon, 15 Jun 2026 06:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ51i-000523-Cp
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ51g-00044Y-9P
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781521122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+htNBxiryUkLHAXUKy8m97qzrP0aQPEkEVManGL9AJg=;
 b=Cijc6sS5T61zVzVHFuskNKUZvuOjNb3EzuFChwFUn8Hqhh3m168WnbBf+nnlzj3iUzVYIl
 aYn0OwWPD45gaWY20ckOixcccNLrPwVN4/hxZAuYdF7VXoOiVplTzI7QUiQfWfjpMekMnI
 TQ3EN9CFAPIGoPV8KXNdt2Nss6OpHpc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-7nGL_um5OiqaYQGk929P9A-1; Mon,
 15 Jun 2026 06:58:41 -0400
X-MC-Unique: 7nGL_um5OiqaYQGk929P9A-1
X-Mimecast-MFC-AGG-ID: 7nGL_um5OiqaYQGk929P9A_1781521120
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 323E21955EA0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:58:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2FAE1954105
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:58:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D89321E6A01; Mon, 15 Jun 2026 12:58:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 5/7] json-streamer: remove token queue
In-Reply-To: <20260525150503.393743-6-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 May 2026 17:05:01 +0200")
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-6-pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 12:58:37 +0200
Message-ID: <87y0ggqdcy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> Now fully exploit the push parser, feeding it one token at a time
> without having to wait until braces and brackets are balanced.
>
> While the nesting counts are retained for error recovery purposes,
> the system can now report the first parsing error without waiting
> for parentheses to be balanced.  This also means that JSON_ERROR
> can be handled in json-parser.c, not json-streamer.c.
>
> After reporting the error, json-streamer.c then enters an error recovery
> mode where subsequent errors are suppressed.  This mimics the previous
> error reporting behavior, but it provides prompt feedback on parsing
> errors.  As an example, here is an example interaction with qemu-ga.
>
> BEFORE (error reported only once braces are balanced):
>
>    >> {"execute":foo
>    >> }
>    << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
>    >> {"execute":"somecommand"}
>    << {"error": {"class": "CommandNotFound", "desc": "The command somecommand has not been found"}}
>
> AFTER (error reported immediately, but similar error recovery as before):
>
>    >> {"execute":foo
>    << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
>    >> }
>    >> {"execute":"somecommand"}
>    << {"error": {"class": "CommandNotFound", "desc": "The command somecommand has not been found"}}

Welcome quality of life improvement for human use of QMP, such as manual
testing.  The experience is still sub-par when you miss closing
parenthesis: you still get the silent treatment.  However, the confused
input a confused user is likely to send then is now more likely to
produce an error, and thus a parser reset.

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/json-parser.h |   3 +-
>  qobject/json-parser.c         |   4 ++
>  qobject/json-streamer.c       | 100 ++++++++++++++--------------------
>  3 files changed, 46 insertions(+), 61 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 0cf6932ecdc..3479e637588 100644
> --- a/include/qobject/json-parser.h
> +++ b/include/qobject/json-parser.h
> @@ -33,7 +33,8 @@ typedef struct JSONMessageParser {
>      JSONParserContext parser;
>      unsigned int brace_count;
>      unsigned int bracket_count;
> -    GQueue tokens;
> +    unsigned int token_count;
> +    bool error;
>      uint64_t token_size;
>  } JSONMessageParser;
>  
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 3b5edc5bae4..b77baab585f 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -659,6 +659,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token,
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
> index b0bf2083ca6..82d2bbc9426 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -1,5 +1,5 @@
>  /*
> - * JSON streaming support
> + * JSON parser - callback interface and error recovery

The file name is now a bit of a misnomer.  I don't care.

>   *
>   * Copyright IBM, Corp. 2009
>   *
> @@ -19,23 +19,16 @@
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
> -    QObject *json = NULL;
>      Error *err = NULL;
> -    JSONToken *token;
>  
> +    parser->token_size += input->len;
> +    parser->token_count++;

Note for later: @token_size and @token_count are incremented early
rather than late.

> +
> +    /* Detect message boundaries for error recovery purposes.  */
>      switch (type) {
>      case JSON_LCURLY:
>          parser->brace_count++;
> @@ -56,12 +49,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          parser->bracket_count--;
>          break;
>      case JSON_ERROR:
> -        error_setg(&err, "JSON parse error, stray '%s'", input->str);
> -        goto out_emit;
> -    case JSON_END_OF_INPUT:
> -        if (g_queue_is_empty(&parser->tokens)) {
> -            return;
> -        }
>      end_error_recovery:
>          /*
>           * Cause error recovery to end immediately.
> @@ -76,49 +63,43 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          break;
>      }
>  
> -    /*
> -     * Security consideration, we limit total memory allocated per object
> -     * and the maximum recursion depth that a message can force.
> -     */
> -    if (parser->token_size + input->len + 1 > MAX_TOKEN_SIZE) {

Left operand of > is unincremented token_size plus increment plus 1.

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
> +    if (parser->error) {
> +        /* error recovery, eat tokens until parentheses balance */
> +    } else {
> +        /*
> +         * Safety consideration, we limit total memory allocated per object
> +         * and the maximum nesting depth that a message can force.
> +         */
> +        if (parser->token_size > MAX_TOKEN_SIZE) {

Left operand of > is incremented token size.

Isn't this one less than before the patch?

> +            error_setg(&err, "JSON token size limit exceeded");
> +        } else if (parser->token_count > MAX_TOKEN_COUNT) {

Likewise.

> +            error_setg(&err, "JSON token count limit exceeded");
> +        } else if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
> +            error_setg(&err, "JSON nesting depth limit exceeded");
> +        } else {
> +            g_autofree JSONToken *token = json_token(type, x, y, input);
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
> -    if (parser->brace_count > 0 || parser->bracket_count > 0) {
> -        return;
> -    }
> -
> -    /* Process all tokens in the queue */
> -    while (!g_queue_is_empty(&parser->tokens)) {
> -        token = g_queue_pop_head(&parser->tokens);
> -        json = json_parser_feed(&parser->parser, token, &err);
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
> -out_emit:
> -    parser->brace_count = 0;
> -    parser->bracket_count = 0;
> -    json_message_free_tokens(parser);
> -    parser->token_size = 0;
> -    parser->emit(parser->opaque, json, err);
> -    json_parser_reset(&parser->parser);
> +    if ((parser->brace_count == 0 && parser->bracket_count == 0)
> +        || type == JSON_END_OF_INPUT) {

We need to check for JSON_END_OF_INPUT, because this is the one error
that cannot go through normal error recovery "eat tokens until curlies
and squares balance or we ate JSON_END_OF_INPUT".  Took me a few minutes
to figure out.

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
> @@ -128,9 +109,10 @@ void json_message_parser_init(JSONMessageParser *parser,
>  {
>      parser->emit = emit;
>      parser->opaque = opaque;
> +    parser->error = false;
>      parser->brace_count = 0;
>      parser->bracket_count = 0;
> -    g_queue_init(&parser->tokens);
> +    parser->token_count = 0;
>      parser->token_size = 0;
>  
>      json_parser_init(&parser->parser, ap);
> @@ -146,12 +128,10 @@ void json_message_parser_feed(JSONMessageParser *parser,
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
>      json_parser_destroy(&parser->parser);
>  }


