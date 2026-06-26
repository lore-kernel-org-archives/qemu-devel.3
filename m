Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A958CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3cx-0006Ds-Vz; Fri, 26 Jun 2026 06:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3cw-0006Cv-6Q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ct-00053i-4Z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYWIqbUMZiNIGFSZanWK622KV92npvNyKOKjAPQEbgk=;
 b=jK6c3/QXepTz/3jnNW2K/ePtk65W1a9FeHn8GAEL8doJgeZwjSgkDbaYRGo2k2Zio5GUiw
 KaDKEhPMB/1aT3WOpEorONzvbYUH2Oq8vZdbZSvlxxPCUEBQWVBjl81k5ky8zs797QN0U5
 X4732SF0Kba1obMftkFUY/Mry00FRsA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-9g4otM6POm6wJRHVyNwoCg-1; Fri, 26 Jun 2026 06:17:33 -0400
X-MC-Unique: 9g4otM6POm6wJRHVyNwoCg-1
X-Mimecast-MFC-AGG-ID: 9g4otM6POm6wJRHVyNwoCg_1782469052
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-463dd955dafso424756f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469052; x=1783073852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYWIqbUMZiNIGFSZanWK622KV92npvNyKOKjAPQEbgk=;
 b=sNtmLi1c374xydDaWW2us3kEDxGkpK7AqIFu9Yu73VkZ3ZqwRgNCahyvOUWaCSdDst
 hXsYNCDrbbyIR85iDIKWGCFZjO1I3dS1VRIaqyAZF5hpt0ObDJsVH3dhwUKujAve+AM8
 2tgGCgYtkngVmLVXYIzjNPSDZ2NzvpkLNYD1hHAyzDGTUwHY2iAmDErF+SHZrdPHoKiQ
 XQBSAJ+iauPmuZK8962IgOYlzPQ0pViGCRut21BjTv9utkpOpFppT7+q0Uo2yuC2H4Kq
 PuZPNcVsL4OjPe20NVGkwaJFcfkGzCAo4foEsBu8z2D1hwEOsK2MqO7s12EYePZp1Cjo
 Q/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469052; x=1783073852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fYWIqbUMZiNIGFSZanWK622KV92npvNyKOKjAPQEbgk=;
 b=g/lBlddj0w7drfHvtPvlEm/ura1FyG1Bz4j0HQ9sVSwQ1iFb+ygY9l59S1o9LCaSa0
 7et3GurSyE9RJfCJM3UmtF+A1aekdEKPiE/OWb7veOOT8sKTTvW5D1zouDoQ4RNmAW0/
 NWvgUAgJhjiSmjyRIxApBj843DVqjIshRo/DFfTLPOdXafh/JOWf45SSMIVmvgbpQSbe
 DUTQDGSTLcB0TuiduyP8YlKtr5muuMTuFgiG+sOBlolOIYWoVRldvSk5wvWvaNk3I1QW
 6VS8AmnuD7uYy+GchTfpu3GMo12m9KUEizM9CH+4L6etjgRHv4jiwi4PT0Siv+2Quqr7
 88fw==
X-Gm-Message-State: AOJu0YzTNmYplNSyQc9s/xboCK0reTgQm+iUl1X44F+XuHXZCOGn7Od3
 FY899WSXHpYGxuCHGHnQ6DKShAXBxIyViRqQWBD3cejcYKy131+8uwc4rGRJEzErrRmHN/DBbsU
 YJsQOzot4HFXvPQXA/OdrQhudsPQecs6/JF9JJbu5h2HjozET4SerMQy8pcINN8ZohcQik3BC3C
 GeZmfK2p9Y3usqMb4NX+Kz01JSqdPlkdG8cbGmMdFk
X-Gm-Gg: AfdE7cnvsVruMXHi+JLUBrFnfDWeXKCVCSqinxfKsP+cAl1Z+3S/EIPZA3f3Pyk0oJ9
 1u+Dlzbb0BS+sKyODJeDOBkjSIPgB4OBeGHsIA1IoUUAgVUEYw9MkdrCqdBz/lyB8VCExIHCX8d
 EvYm2VpA3xkPgCr6zs9Rxks1jtAa69fZ5ls0edyeUJLZPD8vzwuaGQG/h2M/02L2JsQejxXNoSI
 0tFUMJ2OHsFf+cIvXm6Thb8qlTCqedloOwP6oKEG5+KOClSQxQABq249pYwNvGg/7XBtqZezdhn
 aiJtwu1IPqap8vPk28H5WGAT+83g5EC2War299fs+BulT6r1NPhtUBMZdRAGfHm8QsB8YjKwu2L
 NQf40+qJp6nehLIAmekCai02S3pg/d7j7VeLZoP9jem5vSTQHLx52vzvIImiOU9KTTPFoJCDnQk
 DuxuXV/AYCz5ZojT9e
X-Received: by 2002:a05:600c:8b4b:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-4926688974amr86016645e9.28.1782469051489; 
 Fri, 26 Jun 2026 03:17:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4b:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-4926688974amr86015755e9.28.1782469050789; 
 Fri, 26 Jun 2026 03:17:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f9db29a94sm719858f8f.22.2026.06.26.03.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 1/6] json-parser: replace with a push parser
Date: Fri, 26 Jun 2026 12:17:21 +0200
Message-ID: <20260626101727.1727389-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101727.1727389-1-pbonzini@redhat.com>
References: <20260626101727.1727389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In order to avoid stashing all the tokens corresponding to a JSON value,
embed the parsing stack and state machine in JSONParser.  This is more
efficient and allows for more prompt error recovery; it also does not
make the code substantially larger than the current recursive descent
parser, though the state machine is probably a bit harder to follow.

The stack consists of QLists and QDicts corresponding to open
brackets and braces, plus optionally a QString with the current
key on top of each QDict.

After each value is parsed, it is added to the top array or dictionary
or, if the stack is empty, json_parser_feed returns the complete
QObject.

For now, json-streamer.c keeps tracking the tokens up until braces
and brackets are balanced, and then shoves the whole queue of tokens
into the push parser.  The only logic change is that JSON_END_OF_INPUT
always triggers the emptying of the queue; the parser takes notice and
checks that there is nothing on the stack.  Not using brace_count
and bracket_count for this is the first step towards improved separation
of concerns between json-parser.c and json-streamer.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |   6 +
 qobject/json-parser-int.h     |   5 +-
 qobject/json-parser.c         | 565 ++++++++++++++++++++--------------
 qobject/json-streamer.c       |  21 +-
 4 files changed, 359 insertions(+), 238 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 7345a9bd5cb..05346fa816b 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -20,6 +20,12 @@ typedef struct JSONLexer {
     int x, y;
 } JSONLexer;
 
+typedef struct JSONParserContext {
+    Error *err;
+    GQueue *stack;
+    va_list *ap;
+} JSONParserContext;
+
 typedef struct JSONMessageParser {
     void (*emit)(void *opaque, QObject *json, Error *err);
     void *opaque;
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 8c01f236276..1f435cb8eb2 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -49,6 +49,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
 /* json-parser.c */
 JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
-QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp);
+void json_parser_init(JSONParserContext *ctxt, va_list *ap);
+void json_parser_reset(JSONParserContext *ctxt);
+QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
+void json_parser_destroy(JSONParserContext *ctxt);
 
 #endif
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index f6622b82b0a..845da3699aa 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -31,12 +31,111 @@ struct JSONToken {
     char str[];
 };
 
-typedef struct JSONParserContext {
-    Error *err;
-    JSONToken *current;
-    GQueue *buf;
-    va_list *ap;
-} JSONParserContext;
+/*
+ * The JSON parser is a push parser, returning to the caller after every
+ * token.  Therefore it has an explicit representation of its parser
+ * stack; each stack entry consists of a parser state and a QObject:
+ * - a QList, for an array that is being added to
+ * - a QDict, for a dictionary that is being added to
+ * - a QString, for the key of the next pair that will be added to a QDict
+ *
+ * The stack represents an arbitrary nesting of arrays and dictionaries
+ * (whose next key has been parsed); it can also have a dictionary whose
+ * next key has not been parsed, but that can only happen at the top level.
+ * Because of this, the stack contents are always of the form
+ * "(QList | QDict QString)* QDict?".
+ *
+ * An empty stack represents the beginning of the parsing process, with
+ * start state BEFORE_VALUE.
+ */
+
+typedef enum JSONParserState {
+    AFTER_LCURLY,
+    AFTER_LSQUARE,
+    BEFORE_KEY,
+    BEFORE_VALUE,
+    END_OF_KEY,
+    END_OF_VALUE,
+} JSONParserState;
+
+typedef struct JSONParserStackEntry {
+    /*
+     * State when the container is completed or, for the top of the stack,
+     * entry state for the next token.
+     */
+    JSONParserState state;
+
+    /*
+     * A QString with the last parsed key, or a QList/QDict for the current
+     * container.
+     */
+    QObject *partial;
+} JSONParserStackEntry;
+
+/*
+ * This is the JSON grammar that's parsed, with the state transition and
+ * action at each point of the grammar.  While this is not a formal
+ * description, "-> action" represents the pseudocode of the action
+ * and "-> STATE" sets the top stack entry's state to STATE.
+ *
+ * The state alone is enough to tell you what to parse; the state plus
+ * the type of the top of stack tells you which action to take.
+ *
+ * // The initial state is BEFORE_VALUE.
+ * input :=  value         -> END_OF_VALUE -> return parsed value
+ *           (input | END_OF_INPUT)
+ *
+ * // entered on BEFORE_VALUE; after any of these rules are processed, the
+ * // parser has completed a QObject and is in the END_OF_VALUE state.
+ * //
+ * // When the parser reaches the END_OF_VALUE state, it examines the
+ * // top of the stack to see if it's coming from "input" (stack empty),
+ * // "array_items" (TOS is a QList) or "dict_pairs" (TOS is a QString; the
+ * // item below will be a QDict).  It then proceeds with the corresponding
+ * // actions, which will be one of:
+ * // - return parsed value
+ * // - add value to QList
+ * // - pop QString with the key, add key/value to the QDict
+ * value := literal        -> END_OF_VALUE
+ *        | '['            -> push empty QList -> AFTER_LSQUARE
+ *           after_lsquare -> END_OF_VALUE
+ *        | '{'            -> push empty QDict -> AFTER_LCURLY
+ *           after_lcurly  -> END_OF_VALUE
+ *
+ * // non-recursive values, entered on BEFORE_VALUE
+ * literal := INTEGER      -> END_OF_VALUE
+ *       | FLOAT           -> END_OF_VALUE
+ *       | KEYWORD         -> END_OF_VALUE
+ *       | STRING          -> END_OF_VALUE
+ *       | INTERP          -> END_OF_VALUE
+ *
+ * // entered on AFTER_LSQUARE
+ * after_lsquare := ']'    -> pop completed QList -> END_OF_VALUE
+ *         | ϵ             -> BEFORE_VALUE
+ *           array_items   -> END_OF_VALUE
+ *
+ * // entered on BEFORE_VALUE, with TOS being a QList
+ * array_items := value    -> add value to QList -> END_OF_VALUE
+ *         (']'            -> pop completed QList -> END_OF_VALUE
+ *          | ','          -> BEFORE_VALUE
+ *            array_items) -> END_OF_VALUE
+ *
+ * // entered on AFTER_LCURLY
+ * after_lcurly := '}'     -> pop completed QDict -> END_OF_VALUE
+ *         | ϵ             -> BEFORE_KEY
+ *           dict_pairs    -> END_OF_VALUE
+ *
+ * // entered on BEFORE_KEY, with TOS being a QDict
+ * dict_pairs := (STRING | INTERP) -> push QString -> END_OF_KEY
+ *         ':'             -> BEFORE_VALUE
+ *         value           -> pop QString + add pair to QDict -> END_OF_VALUE
+ *         ('}'            -> pop completed QDict -> END_OF_VALUE
+ *          | ','          -> BEFORE_KEY
+ *            dict_pairs)  -> END_OF_VALUE
+ *
+ * Parse errors ignore the token.  json_parser_reset() can be
+ * called to restart parsing from scratch, with an empty stack.
+ */
 
 #define BUG_ON(cond) assert(!(cond))
 
@@ -49,7 +148,27 @@ typedef struct JSONParserContext {
  * 4) deal with premature EOI
  */
 
-static QObject *parse_value(JSONParserContext *ctxt);
+static inline JSONParserStackEntry *current_entry(JSONParserContext *ctxt)
+{
+    return g_queue_peek_tail(ctxt->stack);
+}
+
+static void push_entry(JSONParserContext *ctxt, QObject *partial,
+                       JSONParserState state)
+{
+    JSONParserStackEntry *entry = g_new(JSONParserStackEntry, 1);
+    entry->partial = partial;
+    entry->state = state;
+    g_queue_push_tail(ctxt->stack, entry);
+}
+
+/* Drop the top entry and return the new top entry.  */
+static JSONParserStackEntry *pop_entry(JSONParserContext *ctxt)
+{
+    JSONParserStackEntry *entry = g_queue_pop_tail(ctxt->stack);
+    g_free(entry);
+    return current_entry(ctxt);
+}
 
 /**
  * Error handler
@@ -236,200 +355,10 @@ out:
     return NULL;
 }
 
-/* Note: the token object returned by parser_context_peek_token or
- * parser_context_pop_token is deleted as soon as parser_context_pop_token
- * is called again.
- */
-static const JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
+/* Terminals  */
+
+static QObject *parse_keyword(JSONParserContext *ctxt, const JSONToken *token)
 {
-    g_free(ctxt->current);
-    ctxt->current = g_queue_pop_head(ctxt->buf);
-    return ctxt->current;
-}
-
-static const JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
-{
-    return g_queue_peek_head(ctxt->buf);
-}
-
-/**
- * Parsing rules
- */
-static int parse_pair(JSONParserContext *ctxt, QDict *dict)
-{
-    QObject *key_obj = NULL;
-    QString *key;
-    QObject *value;
-    const JSONToken *peek, *token;
-
-    peek = parser_context_peek_token(ctxt);
-    if (peek == NULL) {
-        parse_error(ctxt, NULL, "premature EOI");
-        goto out;
-    }
-
-    key_obj = parse_value(ctxt);
-    key = qobject_to(QString, key_obj);
-    if (!key) {
-        parse_error(ctxt, peek, "key is not a string in object");
-        goto out;
-    }
-
-    token = parser_context_pop_token(ctxt);
-    if (token == NULL) {
-        parse_error(ctxt, NULL, "premature EOI");
-        goto out;
-    }
-
-    if (token->type != JSON_COLON) {
-        parse_error(ctxt, token, "missing : in object pair");
-        goto out;
-    }
-
-    value = parse_value(ctxt);
-    if (value == NULL) {
-        parse_error(ctxt, token, "Missing value in dict");
-        goto out;
-    }
-
-    if (qdict_haskey(dict, qstring_get_str(key))) {
-        parse_error(ctxt, token, "duplicate key");
-        goto out;
-    }
-
-    qdict_put_obj(dict, qstring_get_str(key), value);
-
-    qobject_unref(key_obj);
-    return 0;
-
-out:
-    qobject_unref(key_obj);
-    return -1;
-}
-
-static QObject *parse_object(JSONParserContext *ctxt)
-{
-    QDict *dict = NULL;
-    const JSONToken *token, *peek;
-
-    token = parser_context_pop_token(ctxt);
-    assert(token && token->type == JSON_LCURLY);
-
-    dict = qdict_new();
-
-    peek = parser_context_peek_token(ctxt);
-    if (peek == NULL) {
-        parse_error(ctxt, NULL, "premature EOI");
-        goto out;
-    }
-
-    if (peek->type != JSON_RCURLY) {
-        if (parse_pair(ctxt, dict) == -1) {
-            goto out;
-        }
-
-        token = parser_context_pop_token(ctxt);
-        if (token == NULL) {
-            parse_error(ctxt, NULL, "premature EOI");
-            goto out;
-        }
-
-        while (token->type != JSON_RCURLY) {
-            if (token->type != JSON_COMMA) {
-                parse_error(ctxt, token, "expected separator in dict");
-                goto out;
-            }
-
-            if (parse_pair(ctxt, dict) == -1) {
-                goto out;
-            }
-
-            token = parser_context_pop_token(ctxt);
-            if (token == NULL) {
-                parse_error(ctxt, NULL, "premature EOI");
-                goto out;
-            }
-        }
-    } else {
-        (void)parser_context_pop_token(ctxt);
-    }
-
-    return QOBJECT(dict);
-
-out:
-    qobject_unref(dict);
-    return NULL;
-}
-
-static QObject *parse_array(JSONParserContext *ctxt)
-{
-    QList *list = NULL;
-    const JSONToken *token, *peek;
-
-    token = parser_context_pop_token(ctxt);
-    assert(token && token->type == JSON_LSQUARE);
-
-    list = qlist_new();
-
-    peek = parser_context_peek_token(ctxt);
-    if (peek == NULL) {
-        parse_error(ctxt, NULL, "premature EOI");
-        goto out;
-    }
-
-    if (peek->type != JSON_RSQUARE) {
-        QObject *obj;
-
-        obj = parse_value(ctxt);
-        if (obj == NULL) {
-            parse_error(ctxt, token, "expecting value");
-            goto out;
-        }
-
-        qlist_append_obj(list, obj);
-
-        token = parser_context_pop_token(ctxt);
-        if (token == NULL) {
-            parse_error(ctxt, NULL, "premature EOI");
-            goto out;
-        }
-
-        while (token->type != JSON_RSQUARE) {
-            if (token->type != JSON_COMMA) {
-                parse_error(ctxt, token, "expected separator in list");
-                goto out;
-            }
-
-            obj = parse_value(ctxt);
-            if (obj == NULL) {
-                parse_error(ctxt, token, "expecting value");
-                goto out;
-            }
-
-            qlist_append_obj(list, obj);
-
-            token = parser_context_pop_token(ctxt);
-            if (token == NULL) {
-                parse_error(ctxt, NULL, "premature EOI");
-                goto out;
-            }
-        }
-    } else {
-        (void)parser_context_pop_token(ctxt);
-    }
-
-    return QOBJECT(list);
-
-out:
-    qobject_unref(list);
-    return NULL;
-}
-
-static QObject *parse_keyword(JSONParserContext *ctxt)
-{
-    const JSONToken *token;
-
-    token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_KEYWORD);
 
     if (!strcmp(token->str, "true")) {
@@ -443,11 +372,9 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
     return NULL;
 }
 
-static QObject *parse_interpolation(JSONParserContext *ctxt)
+static QObject *parse_interpolation(JSONParserContext *ctxt,
+                                    const JSONToken *token)
 {
-    const JSONToken *token;
-
-    token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_INTERP);
 
     if (!strcmp(token->str, "%p")) {
@@ -479,11 +406,8 @@ static QObject *parse_interpolation(JSONParserContext *ctxt)
     return NULL;
 }
 
-static QObject *parse_literal(JSONParserContext *ctxt)
+static QObject *parse_literal(JSONParserContext *ctxt, const JSONToken *token)
 {
-    const JSONToken *token;
-
-    token = parser_context_pop_token(ctxt);
     assert(token);
 
     switch (token->type) {
@@ -531,35 +455,174 @@ static QObject *parse_literal(JSONParserContext *ctxt)
     }
 }
 
-static QObject *parse_value(JSONParserContext *ctxt)
+/* Parsing state machine  */
+
+static QObject *parse_begin_value(JSONParserContext *ctxt,
+                                  const JSONToken *token)
 {
-    const JSONToken *token;
-
-    token = parser_context_peek_token(ctxt);
-    if (token == NULL) {
-        parse_error(ctxt, NULL, "premature EOI");
-        return NULL;
-    }
-
     switch (token->type) {
     case JSON_LCURLY:
-        return parse_object(ctxt);
+        push_entry(ctxt, QOBJECT(qdict_new()), AFTER_LCURLY);
+        return NULL;
     case JSON_LSQUARE:
-        return parse_array(ctxt);
+        push_entry(ctxt, QOBJECT(qlist_new()), AFTER_LSQUARE);
+        return NULL;
     case JSON_INTERP:
-        return parse_interpolation(ctxt);
+        return parse_interpolation(ctxt, token);
     case JSON_INTEGER:
     case JSON_FLOAT:
     case JSON_STRING:
-        return parse_literal(ctxt);
+        return parse_literal(ctxt, token);
     case JSON_KEYWORD:
-        return parse_keyword(ctxt);
+        return parse_keyword(ctxt, token);
     default:
         parse_error(ctxt, token, "expecting value");
         return NULL;
     }
 }
 
+static QObject *parse_token(JSONParserContext *ctxt, const JSONToken *token)
+{
+    JSONParserStackEntry *entry;
+    JSONParserState state;
+    QString *key;
+    QObject *key_obj = NULL, *value = NULL;
+
+    entry = current_entry(ctxt);
+    state = entry ? entry->state : BEFORE_VALUE;
+    switch (state) {
+    case AFTER_LCURLY:
+        /* Grab '}' for empty object or fall through to BEFORE_KEY */
+        assert(qobject_type(entry->partial) == QTYPE_QDICT);
+        if (token->type == JSON_RCURLY) {
+            value = entry->partial;
+            entry = pop_entry(ctxt);
+            break;
+        }
+        entry->state = BEFORE_KEY;
+        /* fall through */
+
+    case BEFORE_KEY:
+        /* Expecting object key */
+        assert(qobject_type(entry->partial) == QTYPE_QDICT);
+        if (token->type != JSON_STRING && token->type != JSON_INTERP) {
+            parse_error(ctxt, token, "expecting key");
+            return NULL;
+        }
+
+        key_obj = parse_begin_value(ctxt, token);
+        if (!key_obj) {
+            /* Parse error already reported */
+        } else if (qobject_type(key_obj) != QTYPE_QSTRING) {
+            /* An interpolation was valid syntactically but not %s */
+            parse_error(ctxt, token, "key is not a string in object");
+        } else {
+            /* Store key in a special entry on the stack */
+            push_entry(ctxt, key_obj, END_OF_KEY);
+        }
+        return NULL;
+
+    case END_OF_KEY:
+        /* Expecting ':' after key */
+        assert(qobject_type(entry->partial) == QTYPE_QSTRING);
+        if (token->type == JSON_COLON) {
+            entry->state = BEFORE_VALUE;
+        } else {
+            parse_error(ctxt, token, "expecting ':'");
+        }
+        return NULL;
+
+    case AFTER_LSQUARE:
+        /* Grab ']' for empty array or fall through to BEFORE_VALUE */
+        assert(qobject_type(entry->partial) == QTYPE_QLIST);
+        if (token->type == JSON_RSQUARE) {
+            value = entry->partial;
+            entry = pop_entry(ctxt);
+            break;
+        }
+        entry->state = BEFORE_VALUE;
+        /* fall through */
+
+    case BEFORE_VALUE:
+        /* Expecting value */
+        assert(!entry || qobject_type(entry->partial) != QTYPE_QDICT);
+        value = parse_begin_value(ctxt, token);
+        if (!value) {
+            /* Error or '['/'{' */
+            return NULL;
+        }
+        /* Return value or insert it into a container */
+        break;
+
+    case END_OF_VALUE:
+        /* Grab ',' or ']' for array; ',' or '}' for object */
+        if (qobject_to(QList, entry->partial)) {
+            /* Array */
+            if (token->type != JSON_RSQUARE) {
+                if (token->type == JSON_COMMA) {
+                    entry->state = BEFORE_VALUE;
+                } else {
+                    parse_error(ctxt, token, "expected ',' or ']'");
+                }
+                return NULL;
+            }
+        } else if (qobject_to(QDict, entry->partial)) {
+            /* Object */
+            if (token->type != JSON_RCURLY) {
+                if (token->type == JSON_COMMA) {
+                    entry->state = BEFORE_KEY;
+                } else {
+                    parse_error(ctxt, token, "expected ',' or '}'");
+                }
+                return NULL;
+            }
+        } else {
+            g_assert_not_reached();
+        }
+
+        /* Got ']' or '}'; return full value or insert into parent container */
+        value = entry->partial;
+        entry = pop_entry(ctxt);
+        break;
+    }
+
+    assert(value);
+    if (entry == NULL) {
+        /* Parse stack now empty, the top-level value is complete.  */
+        return value;
+    }
+
+    /*
+     * Parse stack is not empty and entry->partial is the top of stack.
+     * It's a QString with the key (and a QDict is below it) if we're
+     * parsing an object, or a QList if we're parsing an array.
+     */
+    key = qobject_to(QString, entry->partial);
+    if (key) {
+        const char *key_str;
+        QDict *dict;
+
+        /* Pop off key, and store (key, value) in QDict.  */
+        entry = pop_entry(ctxt);
+        dict = qobject_to(QDict, entry->partial);
+        assert(dict);
+        key_str = qstring_get_str(key);
+        if (qdict_haskey(dict, key_str)) {
+            parse_error(ctxt, token, "duplicate key");
+            qobject_unref(value);
+            return NULL;
+        }
+        qdict_put_obj(dict, key_str, value);
+        qobject_unref(key);
+    } else {
+        /* Array, just store value in the QList.  */
+        qlist_append_obj(qobject_to(QList, entry->partial), value);
+    }
+
+    entry->state = END_OF_VALUE;
+    return NULL;
+}
+
 JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
 {
     JSONToken *token = g_malloc(sizeof(JSONToken) + tokstr->len + 1);
@@ -572,20 +635,56 @@ JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
     return token;
 }
 
-QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
+void json_parser_reset(JSONParserContext *ctxt)
 {
-    JSONParserContext ctxt = { .buf = tokens, .ap = ap };
-    QObject *result;
+    JSONParserStackEntry *entry;
 
-    result = parse_value(&ctxt);
-    assert(ctxt.err || g_queue_is_empty(ctxt.buf));
-
-    error_propagate(errp, ctxt.err);
-
-    while (!g_queue_is_empty(ctxt.buf)) {
-        parser_context_pop_token(&ctxt);
+    ctxt->err = NULL;
+    while ((entry = g_queue_pop_tail(ctxt->stack)) != NULL) {
+        qobject_unref(entry->partial);
+        g_free(entry);
     }
-    g_free(ctxt.current);
+}
 
+void json_parser_init(JSONParserContext *ctxt, va_list *ap)
+{
+    ctxt->stack = g_queue_new();
+    ctxt->ap = ap;
+    json_parser_reset(ctxt);
+}
+
+void json_parser_destroy(JSONParserContext *ctxt)
+{
+    json_parser_reset(ctxt);
+    g_queue_free(ctxt->stack);
+    ctxt->stack = NULL;
+}
+
+/*
+ * Advance the parser based on the token that is passed.
+ * Return the finished top-level value if the token completes it.
+ * If an error is returned, the function must not be called without
+ * first resetting the parser.
+ */
+QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token,
+                          Error **errp)
+{
+    QObject *result = NULL;
+
+    assert(!ctxt->err);
+    switch (token->type) {
+    case JSON_END_OF_INPUT:
+        /* Check for premature end of input */
+        if (!g_queue_is_empty(ctxt->stack)) {
+            parse_error(ctxt, token, "premature end of input");
+        }
+        break;
+
+    default:
+        result = parse_token(ctxt, token);
+        break;
+    }
+
+    error_propagate(errp, ctxt->err);
     return result;
 }
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index b93d97b995f..6c93e6fd78d 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -32,6 +32,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
+    JSONParserContext ctxt;
     QObject *json = NULL;
     Error *err = NULL;
     JSONToken *token;
@@ -56,8 +57,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         if (g_queue_is_empty(&parser->tokens)) {
             return;
         }
-        json = json_parser_parse(&parser->tokens, parser->ap, &err);
-        goto out_emit;
+        break;
     default:
         break;
     }
@@ -85,11 +85,24 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
     g_queue_push_tail(&parser->tokens, token);
 
     if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->brace_count >= 0 && parser->bracket_count >= 0) {
+        && parser->brace_count >= 0 && parser->bracket_count >= 0
+        && type != JSON_END_OF_INPUT) {
         return;
     }
 
-    json = json_parser_parse(&parser->tokens, parser->ap, &err);
+    json_parser_init(&ctxt, parser->ap);
+
+    /* Process all tokens in the queue */
+    while (!g_queue_is_empty(&parser->tokens)) {
+        token = g_queue_pop_head(&parser->tokens);
+        json = json_parser_feed(&ctxt, token, &err);
+        g_free(token);
+        if (json || err) {
+            break;
+        }
+    }
+
+    json_parser_destroy(&ctxt);
 
 out_emit:
     parser->brace_count = 0;
-- 
2.54.0


