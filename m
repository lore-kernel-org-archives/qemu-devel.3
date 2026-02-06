Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725EAEE2089
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJLm-00081Q-9p; Fri, 06 Feb 2026 05:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voJLj-00081D-HM
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voJLh-0001YB-05
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770374763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxNz8jrn5pTUFip8rtG//E2eG0WEH00r3qGvzT6V3SU=;
 b=eSqR6uBMS8pWHFncIZzeZQC6uc1bpBIGZ9VfFrHfrjWDfQ4ISqdeLXy7UD4YfeJqzju9l4
 Wt0048/MRk19oU/Y1Uq1uPMSZqutAE3QdC/Ana+8rWHm6RlaqTZ8hDSRQEqGynO0DJiLdJ
 grTBozQmjC+HvN4/TXARuKsjBxKV6QE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-Mom4NyiaPniq0-reFeS5SQ-1; Fri,
 06 Feb 2026 05:46:02 -0500
X-MC-Unique: Mom4NyiaPniq0-reFeS5SQ-1
X-Mimecast-MFC-AGG-ID: Mom4NyiaPniq0-reFeS5SQ_1770374761
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C086180034D
 for <qemu-devel@nongnu.org>; Fri,  6 Feb 2026 10:46:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E94F119373D8
 for <qemu-devel@nongnu.org>; Fri,  6 Feb 2026 10:46:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6445021E692D; Fri, 06 Feb 2026 11:45:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] json-parser: pass around lookahead token, constify
In-Reply-To: <20260107084840.150843-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 7 Jan 2026 09:48:36 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-2-pbonzini@redhat.com>
Date: Fri, 06 Feb 2026 11:45:58 +0100
Message-ID: <871piyw3o9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Subject smells like a patch splitting opportunity: a trivial patch
adding const, followed by the more interesting patch passing around the
lookahead.  Or the other way round.

In fact, I just did this to help me review the interesting patch: the
trivial patch adds const to JSONToken *.  I can split in my tree.

Paolo Bonzini <pbonzini@redhat.com> writes:

> Pass the lookahead token down to the various functions implementing the
> recursive descent, instead of first peeking and then getting the token
> again multiple times.
>
> The main purpose of this patch is to switch the argument passing style
> for parse_* functions to something more desirable for a push parser,
> which gets one and exactly one token at a time.

Peeking at the lookahead is just fine in a traditional parser, but
you're preparing the way for a push parser.  Got it.

>                                                  However, there are
> some minor improvement in code size and a bugfix as well.
>
> In particular, because parse_array() and parse_object() can assume
> that the opening bracket/brace is not anymore in the token stream, it
> is now apparent that the first entry of an array incorrectly used the
> '[' character (stored in "token") as its location.

For a value of "apparent".  Not sure I would've seen it without your
heads up.

I believe you're talking about

        obj = parse_value(ctxt);
        if (obj == NULL) {
            parse_error(ctxt, token, "expecting value");
            goto out;
        }

where @token indeed holds the array's '['.

This isn't the only spot where we pass a bad @token argument to
parse_error().  For instance:

        parse_error(ctxt, NULL, "premature EOI");

These bad arguments are all masked by parse_error() completely ignoring
its argument!  We tell users what's wrong with the input, but telling
them where it's wrong has been TODO since the initial commit in 2009[*].
I see your PATCH 5 finally takes care of it.

Losely related: how the parser recovers from syntax errors.  Consider
parse_pair():

    key_obj = parse_value(ctxt);

If @key_obj, parse_value() successfully parsed a value into @key_obj.

Else, it reported an error.

    key = qobject_to(QString, key_obj);

If @key, parse_value() recognized a string.

Else, it either recognized something else, or reported an error.

    if (!key) {
        parse_error(ctxt, peek, "key is not a string in object");

This error makes sense if it recognized something else.

It doesn't when it reported an error.  Works, sort of, because
parse_error() keeps only the first error, and silently ignores
subsequent ones.

Robust parsers handle errors explicitly, they don't blindly continue,
throwing away any subsequent errors.  Moreover, I find these misleading
errors grating when I read the code.

But I digress.

        goto out;
    }

>                                                     parse_pair, for
> comparison, handled it correctly:
>
>     if (!key) {
>         parse_error(ctxt, peek, "key is not a string in object");
>         goto out;
>     }
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qobject/json-parser.c | 125 +++++++++++++++++++-----------------------
>  1 file changed, 55 insertions(+), 70 deletions(-)
>
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 7483e582fea..eabc9f8358c 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -49,13 +49,13 @@ typedef struct JSONParserContext {
>   * 4) deal with premature EOI
>   */
>  
> -static QObject *parse_value(JSONParserContext *ctxt);
> +static QObject *parse_value(JSONParserContext *ctxt, const JSONToken *token);
>  
>  /**
>   * Error handler
>   */
>  static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
> -                                           JSONToken *token, const char *msg, ...)
> +                                           const JSONToken *token, const char *msg, ...)

checkpatch points out

    0001-json-parser-pass-around-lookahead-token-constify.patch:48: WARNING: line over 80 characters

Easy enough to avoid.  Both

   static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
                                               const JSONToken *token,
                                               const char *msg, ...)

and

   static void G_GNUC_PRINTF(3, 4)
   parse_error(JSONParserContext *ctxt, const JSONToken *token,
               const char *msg, ...)

would be easier on my eyes.

More of the same below, not flagging again.

>  {
>      va_list ap;
>      char message[1024];
> @@ -126,7 +126,7 @@ static int cvt4hex(const char *s)
>   * - Invalid Unicode characters are rejected.
>   * - Control characters \x00..\x1F are rejected by the lexer.
>   */
> -static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
> +static QString *parse_string(JSONParserContext *ctxt, const JSONToken *token)
>  {
>      const char *ptr = token->str;
>      GString *str;
> @@ -235,42 +235,29 @@ out:
>      return NULL;
>  }
>  
> -/* Note: the token object returned by parser_context_peek_token or
> - * parser_context_pop_token is deleted as soon as parser_context_pop_token
> - * is called again.
> +/* Note: the token object returned by parser_context_pop_token is
> + * deleted as soon as parser_context_pop_token is called again.
>   */
> -static JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
> +static const JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
>  {
>      g_free(ctxt->current);
>      ctxt->current = g_queue_pop_head(ctxt->buf);
>      return ctxt->current;
>  }
>  
> -static JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
> -{
> -    return g_queue_peek_head(ctxt->buf);
> -}
> -
>  /**
>   * Parsing rules
>   */
> -static int parse_pair(JSONParserContext *ctxt, QDict *dict)
> +static int parse_pair(JSONParserContext *ctxt, const JSONToken *token, QDict *dict)
>  {
>      QObject *key_obj = NULL;
>      QString *key;
>      QObject *value;
> -    JSONToken *peek, *token;
>  
> -    peek = parser_context_peek_token(ctxt);
> -    if (peek == NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    key_obj = parse_value(ctxt);
> +    key_obj = parse_value(ctxt, token);
>      key = qobject_to(QString, key_obj);
>      if (!key) {
> -        parse_error(ctxt, peek, "key is not a string in object");
> +        parse_error(ctxt, token, "key is not a string in object");
>          goto out;
>      }
>  

@peek isn't exactly a great name, but @token tells me even less.
@first_token?

> @@ -285,7 +272,13 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict)
>          goto out;
>      }
>  
> -    value = parse_value(ctxt);
> +    token = parser_context_pop_token(ctxt);

Assignment to parameter.  Not a fan.

If we rename the parameter, we can keep the local variable @token for
use here.

> +    if (token == NULL) {
> +        parse_error(ctxt, NULL, "premature EOI");
> +        goto out;
> +    }
> +
> +    value = parse_value(ctxt, token);
>      if (value == NULL) {
>          parse_error(ctxt, token, "Missing value in dict");
>          goto out;
> @@ -309,21 +302,18 @@ out:
>  static QObject *parse_object(JSONParserContext *ctxt)
>  {
>      QDict *dict = NULL;
> -    JSONToken *token, *peek;
> -
> -    token = parser_context_pop_token(ctxt);
> -    assert(token && token->type == JSON_LCURLY);
> +    const JSONToken *token;

Before the patch, parse_object() parses the entire object, as its name
indicates, with the precondition that the lookahead is '{'.

After the patch, it parses the part of the object after the '{'.  Hmm.

We could pass it the first token, like we do for all the other parsing
functions except this one and parse_array(), and keep the assertion.
I'd prefer that, but it's a matter of taste.

>  
>      dict = qdict_new();
>  
> -    peek = parser_context_peek_token(ctxt);
> -    if (peek == NULL) {
> +    token = parser_context_pop_token(ctxt);
> +    if (token == NULL) {
>          parse_error(ctxt, NULL, "premature EOI");
>          goto out;
>      }
>  
> -    if (peek->type != JSON_RCURLY) {
> -        if (parse_pair(ctxt, dict) == -1) {
> +    if (token->type != JSON_RCURLY) {
> +        if (parse_pair(ctxt, token, dict) == -1) {
>              goto out;
>          }
>  
> @@ -339,7 +329,13 @@ static QObject *parse_object(JSONParserContext *ctxt)
>                  goto out;
>              }
>  
> -            if (parse_pair(ctxt, dict) == -1) {
> +            token = parser_context_pop_token(ctxt);
> +            if (token == NULL) {
> +                parse_error(ctxt, NULL, "premature EOI");
> +                goto out;
> +            }
> +
> +            if (parse_pair(ctxt, token, dict) == -1) {
>                  goto out;
>              }
>  
> @@ -349,8 +345,6 @@ static QObject *parse_object(JSONParserContext *ctxt)
>                  goto out;
>              }
>          }
> -    } else {
> -        (void)parser_context_pop_token(ctxt);
>      }
>  
>      return QOBJECT(dict);
> @@ -363,23 +357,20 @@ out:
>  static QObject *parse_array(JSONParserContext *ctxt)
>  {
>      QList *list = NULL;
> -    JSONToken *token, *peek;
> -
> -    token = parser_context_pop_token(ctxt);
> -    assert(token && token->type == JSON_LSQUARE);
> +    const JSONToken *token;

Likewise.

>  
>      list = qlist_new();
>  
> -    peek = parser_context_peek_token(ctxt);
> -    if (peek == NULL) {
> +    token = parser_context_pop_token(ctxt);
> +    if (token == NULL) {
>          parse_error(ctxt, NULL, "premature EOI");
>          goto out;
>      }
>  
> -    if (peek->type != JSON_RSQUARE) {
> +    if (token->type != JSON_RSQUARE) {
>          QObject *obj;
>  
> -        obj = parse_value(ctxt);
> +        obj = parse_value(ctxt, token);
>          if (obj == NULL) {
>              parse_error(ctxt, token, "expecting value");
>              goto out;
> @@ -399,7 +390,13 @@ static QObject *parse_array(JSONParserContext *ctxt)
>                  goto out;
>              }
>  
> -            obj = parse_value(ctxt);
> +            token = parser_context_pop_token(ctxt);
> +            if (token == NULL) {
> +                parse_error(ctxt, NULL, "premature EOI");
> +                goto out;
> +            }
> +
> +            obj = parse_value(ctxt, token);
>              if (obj == NULL) {
>                  parse_error(ctxt, token, "expecting value");
>                  goto out;
> @@ -413,8 +410,6 @@ static QObject *parse_array(JSONParserContext *ctxt)
>                  goto out;
>              }
>          }
> -    } else {
> -        (void)parser_context_pop_token(ctxt);
>      }
>  
>      return QOBJECT(list);
> @@ -424,11 +419,8 @@ out:
>      return NULL;
>  }
>  
> -static QObject *parse_keyword(JSONParserContext *ctxt)
> +static QObject *parse_keyword(JSONParserContext *ctxt, const JSONToken *token)
>  {
> -    JSONToken *token;
> -
> -    token = parser_context_pop_token(ctxt);
>      assert(token && token->type == JSON_KEYWORD);
>  
>      if (!strcmp(token->str, "true")) {
> @@ -442,11 +434,8 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
>      return NULL;
>  }
>  
> -static QObject *parse_interpolation(JSONParserContext *ctxt)
> +static QObject *parse_interpolation(JSONParserContext *ctxt, const JSONToken *token)
>  {
> -    JSONToken *token;
> -
> -    token = parser_context_pop_token(ctxt);
>      assert(token && token->type == JSON_INTERP);
>  
>      if (!strcmp(token->str, "%p")) {
> @@ -478,11 +467,8 @@ static QObject *parse_interpolation(JSONParserContext *ctxt)
>      return NULL;
>  }
>  
> -static QObject *parse_literal(JSONParserContext *ctxt)
> +static QObject *parse_literal(JSONParserContext *ctxt, const JSONToken *token)
>  {
> -    JSONToken *token;
> -
> -    token = parser_context_pop_token(ctxt);
>      assert(token);
>  
>      switch (token->type) {
> @@ -530,29 +516,21 @@ static QObject *parse_literal(JSONParserContext *ctxt)
>      }
>  }
>  
> -static QObject *parse_value(JSONParserContext *ctxt)
> +static QObject *parse_value(JSONParserContext *ctxt, const JSONToken *token)

If we name parse_pair()'s new argument @first_token, we should name this
one the same.

>  {
> -    JSONToken *token;
> -
> -    token = parser_context_peek_token(ctxt);
> -    if (token == NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        return NULL;
> -    }
> -
>      switch (token->type) {
>      case JSON_LCURLY:
>          return parse_object(ctxt);
>      case JSON_LSQUARE:
>          return parse_array(ctxt);
>      case JSON_INTERP:
> -        return parse_interpolation(ctxt);
> +        return parse_interpolation(ctxt, token);
>      case JSON_INTEGER:
>      case JSON_FLOAT:
>      case JSON_STRING:
> -        return parse_literal(ctxt);
> +        return parse_literal(ctxt, token);
>      case JSON_KEYWORD:
> -        return parse_keyword(ctxt);
> +        return parse_keyword(ctxt, token);
>      default:
>          parse_error(ctxt, token, "expecting value");
>          return NULL;
> @@ -575,8 +553,15 @@ QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
>  {
>      JSONParserContext ctxt = { .buf = tokens, .ap = ap };
>      QObject *result;
> +    const JSONToken *token;
>  
> -    result = parse_value(&ctxt);
> +    token = parser_context_pop_token(&ctxt);
> +    if (token == NULL) {
> +        parse_error(&ctxt, NULL, "premature EOI");
> +        return NULL;
> +    }
> +
> +    result = parse_value(&ctxt, token);
>      assert(ctxt.err || g_queue_is_empty(ctxt.buf));
>  
>      error_propagate(errp, ctxt.err);

       while (!g_queue_is_empty(ctxt.buf)) {
           parser_context_pop_token(&ctxt);

This is the only call of parser_context_pop_token() that isn't
immediately followed by "if it returned null, report "premature EOI".
I went "let's factor this out", then realized the next patch replaces
all this.  Nevermind!

       }
       g_free(ctxt.current);

       return result;
   }


Summary:

* parse_pair() and parse_value() now receive the first token as
  argument.  Popping the first token moves to their callers.

* parse_keyword(), parse_interpolation(), and parse_literal() now
  receive the token as argument.  Popping it moves to their callers.
  parse_string() works like this even before the patch, and is not
  changed.

* parse_object() and parse_array() now parse the part after the object's
  / array's first token.

Works.



[*] Reminds me of "Ed is generous enough to flag errors, yet prudent
enough not to overwhelm the novice with verbosity."


