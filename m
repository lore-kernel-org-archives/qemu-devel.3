Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCDDCD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2lJ-0001rm-NX; Fri, 12 Jun 2026 10:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wY2lI-0001rX-Fg
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wY2lF-0006Cm-JC
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781274088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E24zBHQAvQd+No1v9uQ3KF3aJ4dTL/p4vGBBQcY4rDc=;
 b=iZRt4KUFnmzSoE6tBNWHN6Rkp+g1276PzPtJGOlXOp0UxgIdjP/qlUpjFt1WkwIXo1uFSF
 UXLhQCQNTljqDVNM3lAc65uZMRGsXkoRzkF3xSoWpmosc4+A5JRbHG6Qqlxobd6GFuwWJk
 uFUlIufdPzYF43lWPlZewMq0XWXUCIQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-6isTQBkLOjij0pnLU6ip-g-1; Fri,
 12 Jun 2026 10:21:26 -0400
X-MC-Unique: 6isTQBkLOjij0pnLU6ip-g-1
X-Mimecast-MFC-AGG-ID: 6isTQBkLOjij0pnLU6ip-g_1781274085
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48AEE19539A8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:21:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEEB41955BD4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:21:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37AE921E6A01; Fri, 12 Jun 2026 16:21:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/7] json-parser: replace with a push parser
In-Reply-To: <20260525150503.393743-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 May 2026 17:04:58 +0200")
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-3-pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 16:21:22 +0200
Message-ID: <87v7bnvnz1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
> ---
>  include/qobject/json-parser.h |   6 +
>  qobject/json-parser-int.h     |   5 +-
>  qobject/json-parser.c         | 551 ++++++++++++++++++++--------------
>  qobject/json-streamer.c       |  21 +-
>  4 files changed, 345 insertions(+), 238 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 7345a9bd5cb..05346fa816b 100644
> --- a/include/qobject/json-parser.h
> +++ b/include/qobject/json-parser.h
> @@ -20,6 +20,12 @@ typedef struct JSONLexer {
>      int x, y;
>  } JSONLexer;
>=20=20
> +typedef struct JSONParserContext {
> +    Error *err;
> +    GQueue *stack;
> +    va_list *ap;
> +} JSONParserContext;
> +
>  typedef struct JSONMessageParser {
>      void (*emit)(void *opaque, QObject *json, Error *err);
>      void *opaque;
> diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
> index 8c01f236276..1f435cb8eb2 100644
> --- a/qobject/json-parser-int.h
> +++ b/qobject/json-parser-int.h
> @@ -49,6 +49,9 @@ void json_message_process_token(JSONLexer *lexer, GStri=
ng *input,
>=20=20
>  /* json-parser.c */
>  JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
> -QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
> +void json_parser_init(JSONParserContext *ctxt, va_list *ap);
> +void json_parser_reset(JSONParserContext *ctxt);
> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *toke=
n, Error **errp);
> +void json_parser_destroy(JSONParserContext *ctxt);
>=20=20
>  #endif
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index f6622b82b0a..3b5edc5bae4 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -31,12 +31,105 @@ struct JSONToken {
>      char str[];
>  };
>=20=20
> -typedef struct JSONParserContext {
> -    Error *err;
> -    JSONToken *current;
> -    GQueue *buf;
> -    va_list *ap;
> -} JSONParserContext;
> +/*
> + * The JSON parser is a push parser, returning to the caller after every
> + * token.

The thing that returns after every token is json_parser_feed(), right?

Detail not mentioned here: the value it returns.  Leaving that to
json_parser_feed()'s contract feels fine, but pointing from here to
there could be useful.

>             Therefore it has an explicit representation of its parser
> + * stack; each stack entry consists of a parser state and a QObject:
> + * - a QList, for an array that is being added to
> + * - a QDict, for a dictionary that is being added to
> + * - a QString, for the key of the next pair that will be added to a QDi=
ct
> + *
> + * The stack represents an arbitrary nesting of arrays and dictionaries
> + * (whose next key has been parsed); it can also have a dictionary whose
> + * next key has not been parsed, but that can only happen at the top lev=
el.
> + * Because of this, the stack contents are always of the form
> + * "(QList | QDict QString)* QDict?".
> + *
> + * An empty stack represents the beginning of the parsing process, with
> + * start state BEFORE_VALUE.
> + */
> +
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
> +    /*
> +     * State when the container is completed or, for the top of the stac=
k,
> +     * entry state for the next token.
> +     */
> +    JSONParserState state;
> +
> +    /*
> +     * A QString with the last parsed key, or a QList/QDict for the curr=
ent
> +     * container.
> +     */
> +    QObject *partial;
> +} JSONParserStackEntry;
> +
> +/*
> + * This is the JSON grammar that's parsed, with the state transition and
> + * action at each point of the grammar.  While this is not a formal
> + * description, "-> action" represents the pseudocode of the action
> + * and "-> STATE" sets the top stack entry's state to STATE.
> + *
> + * // The initial state is BEFORE_VALUE.
> + * input :=3D  value         -> END_OF_VALUE -> return parsed value
> + *           END_OF_INPUT  -> check stack is empty

How can the stack *not* be empty here?

> + *
> + * // entered on BEFORE_VALUE; after any of these rules are processed, t=
he
> + * // parser has completed a QObject and is in the END_OF_VALUE state.
> + * //
> + * // When the parser reaches the END_OF_VALUE state, it examines the
> + * // top of the stack to see if it's coming from "input" (stack empty),
> + * // "array_items" (TOS is a QList) or "dict_pairs" (TOS is a QString; =
the
> + * // item below will be a QDict).  It then proceeds with the correspond=
ing
> + * // actions, which will be one of:
> + * // - return parsed value
> + * // - add value to QList
> + * // - pop QString with the key, add key/value to the QDict
> + * value :=3D literal        -> END_OF_VALUE
> + *        | '['            -> push empty QList -> AFTER_LSQUARE
> + *           after_lsquare -> END_OF_VALUE
> + *        | '{'            -> push empty QDict -> AFTER_LCURLY
> + *           after_lcurly  -> END_OF_VALUE
> + *
> + * // non-recursive values, entered on BEFORE_VALUE
> + * literal :=3D INTEGER      -> END_OF_VALUE
> + *       | FLOAT           -> END_OF_VALUE
> + *       | KEYWORD         -> END_OF_VALUE
> + *       | STRING          -> END_OF_VALUE
> + *       | INTERP          -> END_OF_VALUE
> + *
> + * // entered on AFTER_LSQUARE
> + * after_lsquare :=3D ']'    -> pop completed QList -> END_OF_VALUE
> + *         | =CF=B5             -> BEFORE_VALUE
> + *           array_items   -> END_OF_VALUE
> + *
> + * // entered on BEFORE_VALUE, with TOS being a QList
> + * array_items :=3D value    -> add value to QList -> END_OF_VALUE
> + *         (']'            -> pop completed QList -> END_OF_VALUE
> + *          | ','          -> BEFORE_VALUE
> + *            array_items) -> END_OF_VALUE
> + *
> + * // entered on AFTER_LCURLY
> + * after_lcurly :=3D '}'     -> pop completed QDict -> END_OF_VALUE
> + *         | =CF=B5             -> BEFORE_KEY
> + *           dict_pairs    -> END_OF_VALUE
> + *
> + * // entered on BEFORE_KEY, with TOS being a QDict
> + * dict_pairs :=3D (STRING | INTERP) -> push QString -> END_OF_KEY
> + *         ':'             -> BEFORE_VALUE
> + *         value           -> pop QString + add pair to QDict -> END_OF_=
VALUE
> + *         ('}'            -> pop completed QDict -> END_OF_VALUE
> + *          | ','          -> BEFORE_KEY
> + *            dict_pairs)  -> END_OF_VALUE
> + */

This is useful.

It doesn't mention how we do parse errors.  Leaving that to
json_parser_feed()'s contract feels fine.

>=20=20
>  #define BUG_ON(cond) assert(!(cond))
>=20=20
> @@ -49,7 +142,26 @@ typedef struct JSONParseCrontext {
>   * 4) deal with premature EOI
>   */
>=20=20
> -static QObject *parse_value(JSONParserContext *ctxt);
> +static inline JSONParserStackEntry *current_entry(JSONParserContext *ctx=
t)
> +{
> +    return g_queue_peek_tail(ctxt->stack);
> +}
> +
> +static void push_entry(JSONParserContext *ctxt, QObject *partial,
> +                       JSONParserState state)
> +{
> +    JSONParserStackEntry *entry =3D g_new(JSONParserStackEntry, 1);
> +    entry->partial =3D partial;
> +    entry->state =3D state;
> +    g_queue_push_tail(ctxt->stack, entry);
> +}
> +
> +static JSONParserStackEntry *pop_entry(JSONParserContext *ctxt)
> +{
> +    JSONParserStackEntry *entry =3D g_queue_pop_tail(ctxt->stack);
> +    g_free(entry);
> +    return current_entry(ctxt);
> +}

This pops the stack and returns the entry now on top.  Slightly
surprising; pop operations commonly return the entry popped from the
stack.

It's this way because you use it like

    // invariant: @entry is the entry on top of ctxt->stack, null if empty
    value =3D entry->partial;
    entry =3D pop_entry(ctxt);

Okay.  A function comment might reduce surprise.

>=20=20
>  /**
>   * Error handler
> @@ -236,200 +348,10 @@ out:
>      return NULL;
>  }
>=20=20
> -/* Note: the token object returned by parser_context_peek_token or
> - * parser_context_pop_token is deleted as soon as parser_context_pop_tok=
en
> - * is called again.
> - */
> -static const JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
> +/* Terminals  */
> +
> +static QObject *parse_keyword(JSONParserContext *ctxt, const JSONToken *=
token)
>  {
> -    g_free(ctxt->current);
> -    ctxt->current =3D g_queue_pop_head(ctxt->buf);
> -    return ctxt->current;
> -}
> -
> -static const JSONToken *parser_context_peek_token(JSONParserContext *ctx=
t)
> -{
> -    return g_queue_peek_head(ctxt->buf);
> -}
> -
> -/**
> - * Parsing rules
> - */
> -static int parse_pair(JSONParserContext *ctxt, QDict *dict)
> -{
> -    QObject *key_obj =3D NULL;
> -    QString *key;
> -    QObject *value;
> -    const JSONToken *peek, *token;
> -
> -    peek =3D parser_context_peek_token(ctxt);
> -    if (peek =3D=3D NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    key_obj =3D parse_value(ctxt);
> -    key =3D qobject_to(QString, key_obj);
> -    if (!key) {
> -        parse_error(ctxt, peek, "key is not a string in object");
> -        goto out;
> -    }
> -
> -    token =3D parser_context_pop_token(ctxt);
> -    if (token =3D=3D NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    if (token->type !=3D JSON_COLON) {
> -        parse_error(ctxt, token, "missing : in object pair");
> -        goto out;
> -    }
> -
> -    value =3D parse_value(ctxt);
> -    if (value =3D=3D NULL) {
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
> -    QDict *dict =3D NULL;
> -    const JSONToken *token, *peek;
> -
> -    token =3D parser_context_pop_token(ctxt);
> -    assert(token && token->type =3D=3D JSON_LCURLY);
> -
> -    dict =3D qdict_new();
> -
> -    peek =3D parser_context_peek_token(ctxt);
> -    if (peek =3D=3D NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    if (peek->type !=3D JSON_RCURLY) {
> -        if (parse_pair(ctxt, dict) =3D=3D -1) {
> -            goto out;
> -        }
> -
> -        token =3D parser_context_pop_token(ctxt);
> -        if (token =3D=3D NULL) {
> -            parse_error(ctxt, NULL, "premature EOI");
> -            goto out;
> -        }
> -
> -        while (token->type !=3D JSON_RCURLY) {
> -            if (token->type !=3D JSON_COMMA) {
> -                parse_error(ctxt, token, "expected separator in dict");
> -                goto out;
> -            }
> -
> -            if (parse_pair(ctxt, dict) =3D=3D -1) {
> -                goto out;
> -            }
> -
> -            token =3D parser_context_pop_token(ctxt);
> -            if (token =3D=3D NULL) {
> -                parse_error(ctxt, NULL, "premature EOI");
> -                goto out;
> -            }
> -        }
> -    } else {
> -        (void)parser_context_pop_token(ctxt);
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
> -    QList *list =3D NULL;
> -    const JSONToken *token, *peek;
> -
> -    token =3D parser_context_pop_token(ctxt);
> -    assert(token && token->type =3D=3D JSON_LSQUARE);
> -
> -    list =3D qlist_new();
> -
> -    peek =3D parser_context_peek_token(ctxt);
> -    if (peek =3D=3D NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        goto out;
> -    }
> -
> -    if (peek->type !=3D JSON_RSQUARE) {
> -        QObject *obj;
> -
> -        obj =3D parse_value(ctxt);
> -        if (obj =3D=3D NULL) {
> -            parse_error(ctxt, token, "expecting value");
> -            goto out;
> -        }
> -
> -        qlist_append_obj(list, obj);
> -
> -        token =3D parser_context_pop_token(ctxt);
> -        if (token =3D=3D NULL) {
> -            parse_error(ctxt, NULL, "premature EOI");
> -            goto out;
> -        }
> -
> -        while (token->type !=3D JSON_RSQUARE) {
> -            if (token->type !=3D JSON_COMMA) {
> -                parse_error(ctxt, token, "expected separator in list");
> -                goto out;
> -            }
> -
> -            obj =3D parse_value(ctxt);
> -            if (obj =3D=3D NULL) {
> -                parse_error(ctxt, token, "expecting value");
> -                goto out;
> -            }
> -
> -            qlist_append_obj(list, obj);
> -
> -            token =3D parser_context_pop_token(ctxt);
> -            if (token =3D=3D NULL) {
> -                parse_error(ctxt, NULL, "premature EOI");
> -                goto out;
> -            }
> -        }
> -    } else {
> -        (void)parser_context_pop_token(ctxt);
> -    }
> -
> -    return QOBJECT(list);
> -
> -out:
> -    qobject_unref(list);
> -    return NULL;
> -}
> -
> -static QObject *parse_keyword(JSONParserContext *ctxt)
> -{
> -    const JSONToken *token;
> -
> -    token =3D parser_context_pop_token(ctxt);
>      assert(token && token->type =3D=3D JSON_KEYWORD);
>=20=20
>      if (!strcmp(token->str, "true")) {
> @@ -443,11 +365,9 @@ static QObject *parse_keyword(JSONParserContext *ctx=
t)
>      return NULL;
>  }
>=20=20
> -static QObject *parse_interpolation(JSONParserContext *ctxt)
> +static QObject *parse_interpolation(JSONParserContext *ctxt,
> +                                    const JSONToken *token)
>  {
> -    const JSONToken *token;
> -
> -    token =3D parser_context_pop_token(ctxt);
>      assert(token && token->type =3D=3D JSON_INTERP);
>=20=20
>      if (!strcmp(token->str, "%p")) {
> @@ -479,11 +399,8 @@ static QObject *parse_interpolation(JSONParserContex=
t *ctxt)
>      return NULL;
>  }
>=20=20
> -static QObject *parse_literal(JSONParserContext *ctxt)
> +static QObject *parse_literal(JSONParserContext *ctxt, const JSONToken *=
token)
>  {
> -    const JSONToken *token;
> -
> -    token =3D parser_context_pop_token(ctxt);
>      assert(token);
>=20=20
>      switch (token->type) {
> @@ -531,35 +448,167 @@ static QObject *parse_literal(JSONParserContext *c=
txt)
>      }
>  }
>=20=20
> -static QObject *parse_value(JSONParserContext *ctxt)
> +/* Parsing state machine  */
> +
> +static QObject *parse_begin_value(JSONParserContext *ctxt,
> +                                  const JSONToken *token)
>  {
> -    const JSONToken *token;
> -
> -    token =3D parser_context_peek_token(ctxt);
> -    if (token =3D=3D NULL) {
> -        parse_error(ctxt, NULL, "premature EOI");
> -        return NULL;
> -    }
> -
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
>      }
>  }
>=20=20
> +static QObject *parse_token(JSONParserContext *ctxt, const JSONToken *to=
ken)
> +{
> +    JSONParserStackEntry *entry;
> +    JSONParserState state;
> +    QString *key;
> +    QObject *key_obj =3D NULL, *value =3D NULL;
> +
> +    entry =3D current_entry(ctxt);
> +    state =3D entry ? entry->state : BEFORE_VALUE;
> +    switch (state) {
> +    case AFTER_LCURLY:
> +        /* Grab '}' for empty object or fall through to BEFORE_KEY */
> +        assert(qobject_type(entry->partial) =3D=3D QTYPE_QDICT);
> +        if (token->type =3D=3D JSON_RCURLY) {
> +            value =3D entry->partial;
> +            entry =3D pop_entry(ctxt);
> +            break;
> +        }
> +        entry->state =3D BEFORE_KEY;
> +        /* fall through */
> +
> +    case BEFORE_KEY:
> +        /* Expecting object key */
> +        assert(qobject_type(entry->partial) =3D=3D QTYPE_QDICT);
> +        if (token->type =3D=3D JSON_STRING || token->type =3D=3D JSON_IN=
TERP) {
> +            key_obj =3D parse_begin_value(ctxt, token);

v2 used parse_string() here, which broke interpolation with %s.  This
version works.

> +            if (!key_obj) {
> +                /* parse error happened */
> +                return NULL;
> +            }
> +        }
> +        if (!key_obj || qobject_type(key_obj) !=3D QTYPE_QSTRING) {
> +            parse_error(ctxt, token, "key is not a string in object");
> +            return NULL;
> +        }
> +
> +        /* Store key in a special entry on the stack */
> +        push_entry(ctxt, key_obj, END_OF_KEY);
> +        return NULL;
> +
> +    case END_OF_KEY:
> +        /* Expecting ':' after key */
> +        assert(qobject_type(entry->partial) =3D=3D QTYPE_QSTRING);
> +        if (token->type =3D=3D JSON_COLON) {
> +            entry->state =3D BEFORE_VALUE;
> +        } else {
> +            parse_error(ctxt, token, "expecting ':'");
> +        }
> +        return NULL;
> +
> +    case AFTER_LSQUARE:
> +        /* Grab ']' for empty array or fall through to BEFORE_VALUE */
> +        assert(qobject_type(entry->partial) =3D=3D QTYPE_QLIST);
> +        if (token->type =3D=3D JSON_RSQUARE) {
> +            value =3D entry->partial;
> +            entry =3D pop_entry(ctxt);
> +            break;
> +        }
> +        entry->state =3D BEFORE_VALUE;
> +        /* fall through */
> +
> +    case BEFORE_VALUE:
> +        /* Expecting value */
> +        assert(!entry || qobject_type(entry->partial) !=3D QTYPE_QDICT);
> +        value =3D parse_begin_value(ctxt, token);
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
> +            if (token->type !=3D JSON_RSQUARE) {
> +                if (token->type =3D=3D JSON_COMMA) {
> +                    entry->state =3D BEFORE_VALUE;
> +                } else {
> +                    parse_error(ctxt, token, "expected ',' or ']'");
> +                }
> +                return NULL;
> +            }
> +        } else if (qobject_to(QDict, entry->partial)) {
> +            /* Object */
> +            if (token->type !=3D JSON_RCURLY) {
> +                if (token->type =3D=3D JSON_COMMA) {
> +                    entry->state =3D BEFORE_KEY;
> +                } else {
> +                    parse_error(ctxt, token, "expected ',' or '}'");
> +                }
> +                return NULL;
> +            }
> +        } else {
> +            g_assert_not_reached();
> +        }
> +
> +        /* Got ']' or '}'; return full value or insert into parent conta=
iner */
> +        value =3D entry->partial;
> +        entry =3D pop_entry(ctxt);
> +        break;
> +    }
> +
> +    assert(value);
> +    if (entry =3D=3D NULL) {
> +        /* The toplevel value is complete.  */

Maybe

           /* Parse stack is empty, top level value is complete */

> +        return value;
> +    }
> +

Suggest

       /*
        * Parse stack is not empty.
        * If we're parsing an object, it's QString (key) on top of
        * QDict.  Pop off key, and store (key, value) in QDict.
        * If we're parsing an array, it's QList.  Store value in it.
        */

> +    key =3D qobject_to(QString, entry->partial);
> +    if (key) {
> +        const char *key_str;
> +        QDict *dict;
> +
> +        entry =3D pop_entry(ctxt);
> +        dict =3D qobject_to(QDict, entry->partial);
> +        assert(dict);
> +        key_str =3D qstring_get_str(key);
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
> +    entry->state =3D END_OF_VALUE;
> +    return NULL;
> +}
> +
>  JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
>  {
>      JSONToken *token =3D g_malloc(sizeof(JSONToken) + tokstr->len + 1);
> @@ -572,20 +621,56 @@ JSONToken *json_token(JSONTokenType type, int x, in=
t y, GString *tokstr)
>      return token;
>  }
>=20=20
> -QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
> +void json_parser_reset(JSONParserContext *ctxt)
>  {
> -    JSONParserContext ctxt =3D { .buf =3D tokens, .ap =3D ap };
> -    QObject *result;
> +    JSONParserStackEntry *entry;
>=20=20
> -    result =3D parse_value(&ctxt);
> -    assert(ctxt.err || g_queue_is_empty(ctxt.buf));
> -
> -    error_propagate(errp, ctxt.err);
> -
> -    while (!g_queue_is_empty(ctxt.buf)) {
> -        parser_context_pop_token(&ctxt);
> +    ctxt->err =3D NULL;
> +    while ((entry =3D g_queue_pop_tail(ctxt->stack)) !=3D NULL) {
> +        qobject_unref(entry->partial);
> +        g_free(entry);
>      }
> -    g_free(ctxt.current);
> +}
>=20=20
> +void json_parser_init(JSONParserContext *ctxt, va_list *ap)
> +{
> +    ctxt->stack =3D g_queue_new();
> +    ctxt->ap =3D ap;
> +    json_parser_reset(ctxt);
> +}
> +
> +void json_parser_destroy(JSONParserContext *ctxt)
> +{
> +    json_parser_reset(ctxt);
> +    g_queue_free(ctxt->stack);
> +    ctxt->stack =3D NULL;
> +}
> +
> +/*
> + * Advance the parser based on the token that is passed.
> + * Return the finished toplevel value if the token completes it.

My dictionary wants "top level" or "top-level".

> + * If an error is returned, the function must not be called without
> + * first resetting the parser.
> + */
> +QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *toke=
n,
> +                          Error **errp)
> +{
> +    QObject *result =3D NULL;
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
> +        result =3D parse_token(ctxt, token);
> +        break;
> +    }
> +
> +    error_propagate(errp, ctxt->err);
>      return result;
>  }
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index b93d97b995f..6c93e6fd78d 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -32,6 +32,7 @@ void json_message_process_token(JSONLexer *lexer, GStri=
ng *input,
>                                  JSONTokenType type, int x, int y)
>  {
>      JSONMessageParser *parser =3D container_of(lexer, JSONMessageParser,=
 lexer);
> +    JSONParserContext ctxt;
>      QObject *json =3D NULL;
>      Error *err =3D NULL;
>      JSONToken *token;
> @@ -56,8 +57,7 @@ void json_message_process_token(JSONLexer *lexer, GStri=
ng *input,
>          if (g_queue_is_empty(&parser->tokens)) {
>              return;
>          }
> -        json =3D json_parser_parse(&parser->tokens, parser->ap, &err);
> -        goto out_emit;
> +        break;
>      default:
>          break;
>      }
> @@ -85,11 +85,24 @@ void json_message_process_token(JSONLexer *lexer, GSt=
ring *input,
>      g_queue_push_tail(&parser->tokens, token);
>=20=20
>      if ((parser->brace_count > 0 || parser->bracket_count > 0)
> -        && parser->brace_count >=3D 0 && parser->bracket_count >=3D 0) {
> +        && parser->brace_count >=3D 0 && parser->bracket_count >=3D 0
> +        && type !=3D JSON_END_OF_INPUT) {
>          return;
>      }
>=20=20
> -    json =3D json_parser_parse(&parser->tokens, parser->ap, &err);
> +    json_parser_init(&ctxt, parser->ap);
> +
> +    /* Process all tokens in the queue */
> +    while (!g_queue_is_empty(&parser->tokens)) {
> +        token =3D g_queue_pop_head(&parser->tokens);
> +        json =3D json_parser_feed(&ctxt, token, &err);
> +        g_free(token);
> +        if (json || err) {
> +            break;
> +        }
> +    }
> +
> +    json_parser_destroy(&ctxt);
>=20=20
>  out_emit:
>      parser->brace_count =3D 0;


