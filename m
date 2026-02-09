Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7055DE7E0B2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNhS-00010C-8l; Mon, 09 Feb 2026 04:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpNhQ-0000zw-Cb
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 04:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpNhM-00020u-9n
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 04:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770629810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bpQmOWePxve9nhFeK4GH7bRfCaJvW34zGTA4jKkHfZo=;
 b=IpEQrhruyeH1Z5Z5salweFNy+XJtKHezchPMkh1Rgm3tBiruwku7nLn+ejXQrZPbr10e+o
 26E1A+YYtcYjMj2I06NshtE5GaPsYihQR+GZ2hWukBEIiEhQr3c1+tqYh7nV4PqUVvtibf
 2RU8bMx8JhqxltTx+ORcvI1thuCHfKk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-OZxp12EhOGGEKtanrEKmrQ-1; Mon,
 09 Feb 2026 04:36:48 -0500
X-MC-Unique: OZxp12EhOGGEKtanrEKmrQ-1
X-Mimecast-MFC-AGG-ID: OZxp12EhOGGEKtanrEKmrQ_1770629808
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3F221955F12
 for <qemu-devel@nongnu.org>; Mon,  9 Feb 2026 09:36:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3640319560B8
 for <qemu-devel@nongnu.org>; Mon,  9 Feb 2026 09:36:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B30E821E692D; Mon, 09 Feb 2026 10:36:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] json-parser: replace with a push parser
In-Reply-To: <20260107084840.150843-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 7 Jan 2026 09:48:37 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-3-pbonzini@redhat.com>
Date: Mon, 09 Feb 2026 10:36:44 +0100
Message-ID: <87sebab6mr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I figure that's tolerable, because we don't expect to change the parser
much.

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
> into the push parser.

Peeking ahead...  the next patch will make the streamer stream tokens as
they arrive?

>                        The only logic change is that JSON_END_OF_INPUT
> always triggers the emptying of the queue; the parser takes notice and
> checks that there is nothing on the stack.  Not using brace_count
> and bracket_count for this is the first step towards improved separation
> of concerns between json-parser.c and json-streamer.c.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/json-parser.h |   6 +
>  qobject/json-parser-int.h     |   4 +-
>  qobject/json-parser.c         | 430 +++++++++++++++++-----------------
>  qobject/json-streamer.c       |  21 +-
>  4 files changed, 245 insertions(+), 216 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 7345a9bd5cb..05346fa816b 100644
> --- a/include/qobject/json-parser.h
> +++ b/include/qobject/json-parser.h
> @@ -20,6 +20,12 @@ typedef struct JSONLexer {
>      int x, y;
>  } JSONLexer;
>  
> +typedef struct JSONParserContext {
> +    Error *err;
> +    GQueue *stack;

This tells us we have a stack of something, but not what the something
is.  Further down, we'll see what the something is.

The commit message explains what the stack means.

Worth a comment here?

We know the stack is at most 1024 deep (MAX_NESTING).  Have you
considered using an array instead of GQueue?

> +    va_list *ap;
> +} JSONParserContext;
> +

Having to move struct definitions to headers is always a bit sad.  Could
this go into json-parser-int.h instead?

>  typedef struct JSONMessageParser {
>      void (*emit)(void *opaque, QObject *json, Error *err);
>      void *opaque;
> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
> index 8c01f236276..05e2e8e1831 100644
> --- a/qobject/json-parser-int.h
> +++ b/qobject/json-parser-int.h
> @@ -49,6 +49,8 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>  
>  /* json-parser.c */
>  JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
> -QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
> +void json_parser_init(JSONParserContext *ctxt, va_list *ap);
> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);

checkpatch points out

    0002-json-parser-replace-with-a-push-parser.patch:64: WARNING: line over 80 characters

The line is easy enough to break.

Several more long lines below, not flagging them.

> +void json_parser_destroy(JSONParserContext *ctxt);
>  
>  #endif

Note: I'm jumping down to qobject/json-streamer.c further down before I
continue here.  Suggest you do the same.

> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index eabc9f8358c..338f0c5aae6 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -31,12 +31,36 @@ struct JSONToken {
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
> + * Objects: { } | { members }
> + * - Empty: { -> AFTER_LCURLY -> }
> + * - Non-empty: { -> AFTER_LCURLY -> BEFORE_KEY -> string -> END_OF_KEY -> : ->
> + *              BEFORE_VALUE -> value -> END_OF_VALUE -> , -> BEFORE_KEY -> ... -> }
> + *
> + * Arrays: [ ] | [ elements ]
> + * - Empty: [ -> AFTER_LSQUARE -> ]
> + * - Non-empty: [ -> AFTER_LSQUARE -> BEFORE_VALUE -> value -> END_OF_VALUE -> , ->
> + *              BEFORE_VALUE -> ... -> ]
> + *
> + * The two cases for END_OF_VALUE are distinguished based on the type of QObject at
> + * top-of-stack.
> + */

I'm afraid I need a comment telling me how to read this comment.

> +typedef enum JSONParserState {
> +    AFTER_LCURLY,
> +    AFTER_LSQUARE,
> +    BEFORE_KEY,
> +    BEFORE_VALUE,
> +    END_OF_KEY,
> +    END_OF_VALUE,
> +} JSONParserState;
> +
> +typedef struct JSONParserStackEntry {
> +    /* A QString with the last parsed key, or a QList/QDict for the current container.  */
> +    QObject *partial;
> +
> +    /* Needed to distinguish whether the parser is waiting for a colon or comma.  */
> +    JSONParserState state;

If the comment was 100% accurate, a bool would do.

> +} JSONParserStackEntry;

This is the "something" in the stack of something.  Not locally obvious.

>  
>  #define BUG_ON(cond) assert(!(cond))
>  
> @@ -49,7 +73,29 @@ typedef struct JSONParserContext {
>   * 4) deal with premature EOI
>   */
>  
> -static QObject *parse_value(JSONParserContext *ctxt, const JSONToken *token);
> +static inline JSONParserStackEntry *current_entry(JSONParserContext *ctxt)
> +{
> +    return g_queue_peek_tail(ctxt->stack);
> +}
> +
> +static void push_entry(JSONParserContext *ctxt, QObject *partial, JSONParserState state)
> +{
> +    JSONParserStackEntry *entry = g_new(JSONParserStackEntry, 1);

I'd like a blank line between declarations and statements, please.  More
of the same below, not flagging it again.

> +    entry->partial = partial;
> +    entry->state = state;
> +    g_queue_push_tail(ctxt->stack, entry);
> +}
> +
> +/* Note that entry->partial does *not* lose its reference count even if value == NULL.  */
> +static JSONParserStackEntry *pop_entry(JSONParserContext *ctxt, QObject **value)
> +{
> +    JSONParserStackEntry *entry = g_queue_pop_tail(ctxt->stack);
> +    if (value) {
> +        *value = entry->partial;
> +    }
> +    g_free(entry);
> +    return current_entry(ctxt);
> +}

This is a rather peculiar function.  If you disagree, try writing a
contract for it :)

>  
>  /**
>   * Error handler
> @@ -235,189 +281,7 @@ out:
>      return NULL;
>  }
>  
> -/* Note: the token object returned by parser_context_pop_token is
> - * deleted as soon as parser_context_pop_token is called again.
> - */
> -static const JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
> -{
> -    g_free(ctxt->current);
> -    ctxt->current = g_queue_pop_head(ctxt->buf);
> -    return ctxt->current;
> -}
> -
> -/**
> - * Parsing rules
> - */
> -static int parse_pair(JSONParserContext *ctxt, const JSONToken *token, QDict *dict)
> -{
> -    QObject *key_obj = NULL;
> -    QString *key;
> -    QObject *value;
> -
> -    key_obj = parse_value(ctxt, token);
> -    key = qobject_to(QString, key_obj);
> -    if (!key) {
> -        parse_error(ctxt, token, "key is not a string in object");
> -        goto out;
> -    }
> -
> -    token = parser_context_pop_token(ctxt);
> -    if (token == NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    if (token->type != JSON_COLON) {
> -        parse_error(ctxt, token, "missing : in object pair");
> -        goto out;
> -    }
> -
> -    token = parser_context_pop_token(ctxt);
> -    if (token == NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    value = parse_value(ctxt, token);
> -    if (value == NULL) {
> -        parse_error(ctxt, token, "Missing value in dict");
> -        goto out;
> -    }
> -
> -    if (qdict_haskey(dict, qstring_get_str(key))) {
> -        parse_error(ctxt, token, "duplicate key");
> -        goto out;
> -    }
> -
> -    qdict_put_obj(dict, qstring_get_str(key), value);
> -
> -    qobject_unref(key_obj);
> -    return 0;
> -
> -out:
> -    qobject_unref(key_obj);
> -    return -1;
> -}
> -
> -static QObject *parse_object(JSONParserContext *ctxt)
> -{
> -    QDict *dict = NULL;
> -    const JSONToken *token;
> -
> -    dict = qdict_new();
> -
> -    token = parser_context_pop_token(ctxt);
> -    if (token == NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    if (token->type != JSON_RCURLY) {
> -        if (parse_pair(ctxt, token, dict) == -1) {
> -            goto out;
> -        }
> -
> -        token = parser_context_pop_token(ctxt);
> -        if (token == NULL) {
> -            parse_error(ctxt, NULL, "premature EOI");
> -            goto out;
> -        }
> -
> -        while (token->type != JSON_RCURLY) {
> -            if (token->type != JSON_COMMA) {
> -                parse_error(ctxt, token, "expected separator in dict");
> -                goto out;
> -            }
> -
> -            token = parser_context_pop_token(ctxt);
> -            if (token == NULL) {
> -                parse_error(ctxt, NULL, "premature EOI");
> -                goto out;
> -            }
> -
> -            if (parse_pair(ctxt, token, dict) == -1) {
> -                goto out;
> -            }
> -
> -            token = parser_context_pop_token(ctxt);
> -            if (token == NULL) {
> -                parse_error(ctxt, NULL, "premature EOI");
> -                goto out;
> -            }
> -        }
> -    }
> -
> -    return QOBJECT(dict);
> -
> -out:
> -    qobject_unref(dict);
> -    return NULL;
> -}
> -
> -static QObject *parse_array(JSONParserContext *ctxt)
> -{
> -    QList *list = NULL;
> -    const JSONToken *token;
> -
> -    list = qlist_new();
> -
> -    token = parser_context_pop_token(ctxt);
> -    if (token == NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    if (token->type != JSON_RSQUARE) {
> -        QObject *obj;
> -
> -        obj = parse_value(ctxt, token);
> -        if (obj == NULL) {
> -            parse_error(ctxt, token, "expecting value");
> -            goto out;
> -        }
> -
> -        qlist_append_obj(list, obj);
> -
> -        token = parser_context_pop_token(ctxt);
> -        if (token == NULL) {
> -            parse_error(ctxt, NULL, "premature EOI");
> -            goto out;
> -        }
> -
> -        while (token->type != JSON_RSQUARE) {
> -            if (token->type != JSON_COMMA) {
> -                parse_error(ctxt, token, "expected separator in list");
> -                goto out;
> -            }
> -
> -            token = parser_context_pop_token(ctxt);
> -            if (token == NULL) {
> -                parse_error(ctxt, NULL, "premature EOI");
> -                goto out;
> -            }
> -
> -            obj = parse_value(ctxt, token);
> -            if (obj == NULL) {
> -                parse_error(ctxt, token, "expecting value");
> -                goto out;
> -            }
> -
> -            qlist_append_obj(list, obj);
> -
> -            token = parser_context_pop_token(ctxt);
> -            if (token == NULL) {
> -                parse_error(ctxt, NULL, "premature EOI");
> -                goto out;
> -            }
> -        }
> -    }
> -
> -    return QOBJECT(list);
> -
> -out:
> -    qobject_unref(list);
> -    return NULL;
> -}
> +/* Terminals  */
>  
>  static QObject *parse_keyword(JSONParserContext *ctxt, const JSONToken *token)
>  {
> @@ -516,13 +380,17 @@ static QObject *parse_literal(JSONParserContext *ctxt, const JSONToken *token)
>      }
>  }
>  

The parser's interesting part follows.  The parser is a pushdown
automaton.  The pushdown automaton is coded in C.  On the one hand,
d'oh!  Of course it is.  On the other hand, it's hard to see the actual
automaton in C.  May I have a comment explaining state and state
transitions?  Perhaps we better start with an informal description,
discuss it, then distill the discussion into a comment.

> -static QObject *parse_value(JSONParserContext *ctxt, const JSONToken *token)
> +/* Parsing state machine  */
> +
> +static QObject *parse_begin_value(JSONParserContext *ctxt, const JSONToken *token)
>  {
>      switch (token->type) {
>      case JSON_LCURLY:
> -        return parse_object(ctxt);
> +        push_entry(ctxt, QOBJECT(qdict_new()), AFTER_LCURLY);
> +        return NULL;
>      case JSON_LSQUARE:
> -        return parse_array(ctxt);
> +        push_entry(ctxt, QOBJECT(qlist_new()), AFTER_LSQUARE);
> +        return NULL;
>      case JSON_INTERP:
>          return parse_interpolation(ctxt, token);
>      case JSON_INTEGER:
> @@ -537,6 +405,130 @@ static QObject *parse_value(JSONParserContext *ctxt, const JSONToken *token)
>      }
>  }
>  
> +static QObject *json_parser_parse_token(JSONParserContext *ctxt, const JSONToken *token)

Rename to parse_token()?  Or inline into json_parser_feed()?

> +{
> +    JSONParserStackEntry *entry;
> +    JSONParserState state;
> +    QString *key;
> +    QObject *value = NULL;
> +
> +    entry = current_entry(ctxt);
> +    state = entry ? entry->state : BEFORE_VALUE;

Blank line here, please.

> +    switch (state) {
> +    case AFTER_LCURLY:
> +        /* Grab '}' for empty object or fall through to BEFORE_KEY */
> +        if (token->type == JSON_RCURLY) {
> +            entry = pop_entry(ctxt, &value);
> +            break;
> +        }
> +        entry->state = BEFORE_KEY;
> +        /* fall through */
> +
> +    case BEFORE_KEY:
> +        /* Expecting object key */
> +        if (token->type == JSON_STRING) {
> +            key = parse_string(ctxt, token);
> +            if (!key) {
> +                return NULL;
> +            }

Key to understand the switch is the meaning of "break" and "return
NULL".

We do the latter when we're done for this token.

We do the former when this token completed a (sub-)value.  @value holds
it.  If the stack is empty, @value is the result of the parse, and the
code after the switch returns it.  Else, @value is a sub-value, and the
code after the switch stores it in the object being constructed.

> +
> +            /* Store key in a special entry on the stack */
> +            push_entry(ctxt, QOBJECT(key), END_OF_KEY);
> +        } else {
> +            parse_error(ctxt, token, "expecting key");

What's the state machine's parse error recovery story?

> +        }
> +        return NULL;
> +
> +    case END_OF_KEY:
> +        /* Expecting ':' after key */
> +        if (token->type == JSON_COLON) {
> +            entry->state = BEFORE_VALUE;
> +        } else {
> +            parse_error(ctxt, token, "expecting ':'");
> +        }
> +        return NULL;
> +
> +    case AFTER_LSQUARE:
> +        /* Grab ']' for empty array or fall through to BEFORE_VALUE */
> +        if (token->type == JSON_RSQUARE) {
> +            entry = pop_entry(ctxt, &value);
> +            break;
> +        }
> +        entry->state = BEFORE_VALUE;
> +        /* fall through */
> +
> +    case BEFORE_VALUE:
> +        /* Expecting value */
> +        value = parse_begin_value(ctxt, token);
> +        if (!value) {
> +            /* Error or '['/'{' */
> +            return NULL;
> +        }
> +        /* Return value or insert it into a container */
> +        break;
> +
> +    case END_OF_VALUE:
> +        /* Grab ',' or ']' for array; ',' or '}' for object */
> +        if (qobject_to(QList, entry->partial)) {
> +            /* Array */
> +            if (token->type != JSON_RSQUARE) {
> +                if (token->type == JSON_COMMA) {
> +                    entry->state = BEFORE_VALUE;
> +                } else {
> +                    parse_error(ctxt, token, "expected ',' or ']'");
> +                }
> +                return NULL;
> +            }
> +        } else if (qobject_to(QDict, entry->partial)) {
> +            /* Object */
> +            if (token->type != JSON_RCURLY) {
> +                if (token->type == JSON_COMMA) {
> +                    entry->state = BEFORE_KEY;
> +                } else {
> +                    parse_error(ctxt, token, "expected ',' or '}'");
> +                }
> +                return NULL;
> +            }
> +        } else {
> +            g_assert_not_reached();
> +        }
> +
> +        /* Got ']' or '}', return value or insert into parent container */
> +        entry = pop_entry(ctxt, &value);
> +        break;
> +    }
> +
> +    assert(value);
> +    if (entry == NULL) {
> +        /* The toplevel value is complete.  */
> +        return value;
> +    }
> +
> +    key = qobject_to(QString, entry->partial);
> +    if (key) {
> +        const char *key_str;
> +        QDict *dict;
> +
> +        entry = pop_entry(ctxt, NULL);
> +        dict = qobject_to(QDict, entry->partial);
> +        assert(dict);
> +        key_str = qstring_get_str(key);
> +        if (qdict_haskey(dict, key_str)) {
> +            parse_error(ctxt, token, "duplicate key");
> +            qobject_unref(value);
> +            return NULL;
> +        }
> +        qdict_put_obj(dict, key_str, value);
> +        qobject_unref(key);
> +    } else {
> +        /* Add to array */
> +        qlist_append_obj(qobject_to(QList, entry->partial), value);
> +    }
> +
> +    entry->state = END_OF_VALUE;
> +    return NULL;
> +}
> +
>  JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
>  {
>      JSONToken *token = g_malloc(sizeof(JSONToken) + tokstr->len + 1);
> @@ -549,27 +541,43 @@ JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
>      return token;
>  }
>  
> -QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
> +void json_parser_init(JSONParserContext *ctxt, va_list *ap)
>  {
> -    JSONParserContext ctxt = { .buf = tokens, .ap = ap };
> -    QObject *result;
> -    const JSONToken *token;
> +    ctxt->err = NULL;
> +    ctxt->stack = g_queue_new();
> +    ctxt->ap = ap;
> +}
>  
> -    token = parser_context_pop_token(&ctxt);
> -    if (token == NULL) {
> -        parse_error(&ctxt, NULL, "premature EOI");
> -        return NULL;
> +void json_parser_destroy(JSONParserContext *ctxt)
> +{
> +    JSONParserStackEntry *entry;
> +
> +    while ((entry = g_queue_pop_tail(ctxt->stack)) != NULL) {
> +        qobject_unref(entry->partial);
> +        g_free(entry);
> +    }
> +    g_queue_free(ctxt->stack);
> +    ctxt->stack = NULL;
> +}
> +
> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp)

The return value isn't immediately obvious.  A brief function contract
could help the reader.

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
> +        result = json_parser_parse_token(ctxt, token);
> +        break;
>      }
>  
> -    result = parse_value(&ctxt, token);
> -    assert(ctxt.err || g_queue_is_empty(ctxt.buf));
> -
> -    error_propagate(errp, ctxt.err);
> -
> -    while (!g_queue_is_empty(ctxt.buf)) {
> -        parser_context_pop_token(&ctxt);
> -    }
> -    g_free(ctxt.current);
> -
> +    error_propagate(errp, ctxt->err);
>      return result;
>  }
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index b93d97b995f..6c93e6fd78d 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -32,6 +32,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>                                  JSONTokenType type, int x, int y)
>  {
>      JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
> +    JSONParserContext ctxt;
>      QObject *json = NULL;
>      Error *err = NULL;
>      JSONToken *token;
> @@ -56,8 +57,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          if (g_queue_is_empty(&parser->tokens)) {
>              return;
>          }
> -        json = json_parser_parse(&parser->tokens, parser->ap, &err);
> -        goto out_emit;
> +        break;

Before the patch: flush the queue on end of input.

Afterwards: push a JSON_END_OF_INPUT token into the queue.

>      default:
>          break;
>      }
> @@ -85,11 +85,24 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>      g_queue_push_tail(&parser->tokens, token);
>  
>      if ((parser->brace_count > 0 || parser->bracket_count > 0)
> -        && parser->brace_count >= 0 && parser->bracket_count >= 0) {
> +        && parser->brace_count >= 0 && parser->bracket_count >= 0
> +        && type != JSON_END_OF_INPUT) {
>          return;

Before the patch: flush the queue when both counts are zero or at least
one is negative.

After the patch: additionally flush it on end of input.

I figure the two hunks together make the parser see a JSON_END_OF_INPUT
token at the end of input.  Correct?

>      }
>  
> -    json = json_parser_parse(&parser->tokens, parser->ap, &err);
> +    json_parser_init(&ctxt, parser->ap);
> +
> +    /* Process all tokens in the queue */
> +    while (!g_queue_is_empty(&parser->tokens)) {
> +        token = g_queue_pop_head(&parser->tokens);
> +        json = json_parser_feed(&ctxt, token, &err);
> +        g_free(token);
> +        if (json || err) {
> +            break;
> +        }
> +    }
> +
> +    json_parser_destroy(&ctxt);

This is where we switch from feeding the parser balanced expressions to
feeding it tokens one by one.

When we break the loop early, parser->tokens is not empty here.  Fine,
because...

>  
>  out_emit:
>      parser->brace_count = 0;
       parser->bracket_count = 0;
       json_message_free_tokens(parser);

... we drain it here.

       parser->token_size = 0;
       parser->emit(parser->opaque, json, err);
   }

Back to qobject/json-parser.c now.


