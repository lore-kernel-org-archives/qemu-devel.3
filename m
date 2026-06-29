Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4900CC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBde-0001qK-Nd; Mon, 29 Jun 2026 09:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weBdd-0001q4-3a
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weBdb-0000FO-8P
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782738178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciJF5/WYZLwpkx6DBQrCJuAAxUWN2FcssFmLvGEcCsQ=;
 b=WC1SlKRvps9XgRAEc4amvsyVgC/te+QiriFCLzsR8ICKpYc25InVwBGHZwQyTSNBwP4h/5
 IZS2VdwR9uanxGIX0d7PFtE3ZF1mXW77bQTZTWJtXm8AwjD5yjpznOCVGMaLIyuyCqZyAp
 lZ7/1TCKejZICVlGZUydX4nVSj58QV0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-bHyazvqKNcaI015Wfslr_Q-1; Mon,
 29 Jun 2026 09:02:55 -0400
X-MC-Unique: bHyazvqKNcaI015Wfslr_Q-1
X-Mimecast-MFC-AGG-ID: bHyazvqKNcaI015Wfslr_Q_1782738175
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C49D1955F6F
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:02:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E4C51800348
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:02:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34DCF21E6920; Mon, 29 Jun 2026 15:02:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/6] json-streamer: remove token queue
In-Reply-To: <20260626101727.1727389-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 26 Jun 2026 12:17:24 +0200")
References: <20260626101727.1727389-1-pbonzini@redhat.com>
 <20260626101727.1727389-5-pbonzini@redhat.com>
Date: Mon, 29 Jun 2026 15:02:52 +0200
Message-ID: <878q7xts77.fsf@pond.sub.org>
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
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/json-parser.h |   3 +-
>  qobject/json-parser.c         |   4 ++
>  qobject/json-streamer.c       | 106 +++++++++++++---------------------
>  3 files changed, 47 insertions(+), 66 deletions(-)
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
> index 845da3699aa..484956deae4 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -673,6 +673,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token,
>  
>      assert(!ctxt->err);
>      switch (token->type) {
> +    case JSON_ERROR:
> +        parse_error(ctxt, token, "stray '%s'", token->str);
> +        break;
> +
>      case JSON_END_OF_INPUT:
>          /* Check for premature end of input */
>          if (!g_queue_is_empty(ctxt->stack)) {
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index 9e1f650bad8..9526f815f00 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -1,5 +1,5 @@
>  /*
> - * JSON streaming support
> + * JSON parser - callback interface and error recovery
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
> +
> +    /* Detect message boundaries for error recovery purposes.  */
>      switch (type) {
>      case JSON_LCURLY:
>          parser->brace_count++;
> @@ -56,19 +49,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          parser->bracket_count--;
>          break;
>      case JSON_ERROR:
> -        error_setg(&err, "JSON parse error, stray '%s'", input->str);
> -        goto out_emit;
> -    case JSON_END_OF_INPUT:
> -        /*
> -         * Force the parentheses to appear balanced and the queue
> -         * to be emptied, causing a parse error if it wasn't.
> -         */
> -        if (g_queue_is_empty(&parser->tokens)) {
> -            return;
> -        }
>      end_error_recovery:
>          /*
> -         * We goto here due to receiving either JSON_ERROR or a
> +         * We come here due to receiving either JSON_ERROR or a

Line was added in the previous commit.  Squash the change into it?

>           * JSON_R{CURLY,SQUARE}) that is known to be unbalanced.
>           * If in error recovery, end it immediately.  If not in
>           * error recovery, json_parser_feed() will raise an error
> @@ -81,49 +64,43 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
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

I believe this is one less than before the patch.  Testing...  yes:

    -blockdev '{"a":"01234567890123456789012345678901234567890123456789012345"}'

with MAX_TOKEN_SIZE hacked to 64: is rejected before the series, and
accepted afterwards.

Obvious fix: change > to >=.

If you'd prefer not to change the code, mention the change in the commit
message.

> +            error_setg(&err, "JSON token size limit exceeded");
> +        } else if (parser->token_count > MAX_TOKEN_COUNT) {
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
> -    json_parser_reset(&parser->parser);
> -    parser->brace_count = 0;
> -    parser->bracket_count = 0;
> -    json_message_free_tokens(parser);
> -    parser->token_size = 0;
> -    parser->emit(parser->opaque, json, err);
> +    if ((parser->brace_count == 0 && parser->bracket_count == 0)
> +        || type == JSON_END_OF_INPUT) {
> +        json_parser_reset(&parser->parser);
> +        parser->error = false;
> +        parser->brace_count = 0;
> +        parser->bracket_count = 0;
> +        parser->token_count = 0;
> +        parser->token_size = 0;
> +    }
>  }
>  
>  void json_message_parser_init(JSONMessageParser *parser,
> @@ -133,9 +110,10 @@ void json_message_parser_init(JSONMessageParser *parser,
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
> @@ -151,12 +129,10 @@ void json_message_parser_feed(JSONMessageParser *parser,
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


