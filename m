Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A80CF6C0D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPDq-0007mi-5F; Wed, 07 Jan 2026 03:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDn-0007lQ-7C
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDl-0008Gm-55
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767775728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9afH1pn9SL3+pMXkAtwJhwWo5oJMAHQYUxmUA6SZKU=;
 b=DtrWuHTNme9ll33dIagi4/cCHtDvqDraQr/1gnHteGmMHJaqIFuAHT734RXRNXouVak7P3
 lmRQRw9LuSLCEKqVhhQSgBd8Xw+6R+OtazjZfkkV+6tugeGBxIlTFgMj3Ir0Fb4cG2iRPH
 BSAeib+tQ4thnXyIOtfFB5pmhsSqapk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-_kr9qy-CO6OLEFCtaIhLNQ-1; Wed, 07 Jan 2026 03:48:47 -0500
X-MC-Unique: _kr9qy-CO6OLEFCtaIhLNQ-1
X-Mimecast-MFC-AGG-ID: _kr9qy-CO6OLEFCtaIhLNQ_1767775726
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fcfe4494so1387558f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767775725; x=1768380525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9afH1pn9SL3+pMXkAtwJhwWo5oJMAHQYUxmUA6SZKU=;
 b=HiOL4oKJTOB9yubYHEQEhfOrrziDaNJtkqCHQBR8cvMrkcns4BvGIq8nk+DfKIe4IY
 4pwO8v1n/rph8bh4wv4De93upTuA2YKUrQz5tXyNAkwQrin9qGbBLNwKi1fGQcpwzucJ
 B+hceQBW/cQewnsffF/pWNQVI8SD+vMdnD1oh8SZM+OPyy+hUs7bfm8VH5bwFPoNquyd
 svTlC4KkmKSpl805eFMxkR/aTk7q6Os8k/xEgyvcdt2f7cawS214eF8dfwajntFLZUBp
 zbQROf+6eGb//EWU5670EHF5teAbCvHdbSIyRpwgmpTq0ffQ031n2WT4WmbJ+ev1Ic9Z
 Tsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767775725; x=1768380525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9afH1pn9SL3+pMXkAtwJhwWo5oJMAHQYUxmUA6SZKU=;
 b=FkH8ZcMwlG4FUprlTaH8iCukV6MfGwAU2LnkHJyMow5wGhRrJNi/de31R9b4udOXaL
 Fni2WCL7yMd/d4T39tBmY01hv8IP50Bqf8fjKxcHKEd3B2228oWc/4QOUnXKl6ow+M4F
 ZFJZWa8Pq+3/SNA7CtHAx5RxIok5PWckEPPmohegzniBiglUwRFJgg2DHhTvqJkJOiN6
 81GExktf0inGwj58bFpWrIx6PladS3L5FK4ixzxFuHIuHsbhJypT8PU2cz0UawYRCijy
 U9m3FTiUDd7FVtzEzk5nmWYC7s+idXh94sdZ4aejjdOesFeS6cPswTgL1yoqbWQfRJjT
 smww==
X-Gm-Message-State: AOJu0Yyc+CtYnTaIeV3OmkwVNp9/3bfQ1ELIIKRt/JW7zRJZL7LP97tA
 RUWkDeCLsaOZKtvXStqGCgpBgB4wSGAAiJQ67EcjlD0Q/yisc9yvlgaByYiTMzrnUzh2j8Oc3aS
 DyUV/4RMSQHL+ljPvPy9aky49pVoLEiKD7+23of0I5tdgNg3np/sbU4aOmPTlxG3ftr6/JRXiMg
 8/NDFTfu4Ws76xohbRCw1rckI1lEn1pVyWbq0MKuhm
X-Gm-Gg: AY/fxX4WTdA3tc6rv3Sy0y2w/OI81ornYHs7q5+yoeWCRxXU+HX6XO2ozdefiRjnoHP
 k017Fu2xx/YDLsakBRv9f62Wt6Efjs/sBRsE25qNod7B8XQBGr4dq5RTkB4RFiD0/CoPpw1ni/k
 B0LyuJF0m/2TS2/mZM1Scgd26JSFK1+fjCzxGW5UwfW+nqBG/eDzqsGWoMbhszBe5gIRFHtEr5h
 yaE5Hz9BtG5nP934e9WvuK3IHVioDYECmjFM0DooM/eaxslveDE8E5TxSZ28j5ltv69sSVyeBzq
 4Cz8PAuPYI2pb+DyprSj1IvC9HkT8/Q5fpBBA41KHu3fWE2vcoHhyJpLqnnwmHZvw0hXqdTzSO1
 Y7L1dRxouoGJWRFGlUqJJVkiWjmGy7Hbm06U1raizmMc6K/OFn4AZitjsjw4lCEUXPdrnLp+fmb
 Q6tH/enAHOFdFzew==
X-Received: by 2002:a05:6000:40cd:b0:430:f7bc:4d0c with SMTP id
 ffacd0b85a97d-432c3775717mr1724953f8f.28.1767775725185; 
 Wed, 07 Jan 2026 00:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQeGlThVCrhOoXxXJ+Dtqd4hO6VR8DzASEeKAzNcywrfwt6Tk/lf11Q2P8N8ZheH1AtDrS8Q==
X-Received: by 2002:a05:6000:40cd:b0:430:f7bc:4d0c with SMTP id
 ffacd0b85a97d-432c3775717mr1724920f8f.28.1767775724631; 
 Wed, 07 Jan 2026 00:48:44 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5fe83bsm9369824f8f.38.2026.01.07.00.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 00:48:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 1/5] json-parser: pass around lookahead token, constify
Date: Wed,  7 Jan 2026 09:48:36 +0100
Message-ID: <20260107084840.150843-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107084840.150843-1-pbonzini@redhat.com>
References: <20260107084840.150843-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pass the lookahead token down to the various functions implementing the
recursive descent, instead of first peeking and then getting the token
again multiple times.

The main purpose of this patch is to switch the argument passing style
for parse_* functions to something more desirable for a push parser,
which gets one and exactly one token at a time.  However, there are
some minor improvement in code size and a bugfix as well.

In particular, because parse_array() and parse_object() can assume
that the opening bracket/brace is not anymore in the token stream, it
is now apparent that the first entry of an array incorrectly used the
'[' character (stored in "token") as its location.  parse_pair, for
comparison, handled it correctly:

    if (!key) {
        parse_error(ctxt, peek, "key is not a string in object");
        goto out;
    }

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qobject/json-parser.c | 125 +++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 70 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7483e582fea..eabc9f8358c 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -49,13 +49,13 @@ typedef struct JSONParserContext {
  * 4) deal with premature EOI
  */
 
-static QObject *parse_value(JSONParserContext *ctxt);
+static QObject *parse_value(JSONParserContext *ctxt, const JSONToken *token);
 
 /**
  * Error handler
  */
 static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
-                                           JSONToken *token, const char *msg, ...)
+                                           const JSONToken *token, const char *msg, ...)
 {
     va_list ap;
     char message[1024];
@@ -126,7 +126,7 @@ static int cvt4hex(const char *s)
  * - Invalid Unicode characters are rejected.
  * - Control characters \x00..\x1F are rejected by the lexer.
  */
-static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
+static QString *parse_string(JSONParserContext *ctxt, const JSONToken *token)
 {
     const char *ptr = token->str;
     GString *str;
@@ -235,42 +235,29 @@ out:
     return NULL;
 }
 
-/* Note: the token object returned by parser_context_peek_token or
- * parser_context_pop_token is deleted as soon as parser_context_pop_token
- * is called again.
+/* Note: the token object returned by parser_context_pop_token is
+ * deleted as soon as parser_context_pop_token is called again.
  */
-static JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
+static const JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
 {
     g_free(ctxt->current);
     ctxt->current = g_queue_pop_head(ctxt->buf);
     return ctxt->current;
 }
 
-static JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
-{
-    return g_queue_peek_head(ctxt->buf);
-}
-
 /**
  * Parsing rules
  */
-static int parse_pair(JSONParserContext *ctxt, QDict *dict)
+static int parse_pair(JSONParserContext *ctxt, const JSONToken *token, QDict *dict)
 {
     QObject *key_obj = NULL;
     QString *key;
     QObject *value;
-    JSONToken *peek, *token;
 
-    peek = parser_context_peek_token(ctxt);
-    if (peek == NULL) {
-        parse_error(ctxt, NULL, "premature EOI");
-        goto out;
-    }
-
-    key_obj = parse_value(ctxt);
+    key_obj = parse_value(ctxt, token);
     key = qobject_to(QString, key_obj);
     if (!key) {
-        parse_error(ctxt, peek, "key is not a string in object");
+        parse_error(ctxt, token, "key is not a string in object");
         goto out;
     }
 
@@ -285,7 +272,13 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict)
         goto out;
     }
 
-    value = parse_value(ctxt);
+    token = parser_context_pop_token(ctxt);
+    if (token == NULL) {
+        parse_error(ctxt, NULL, "premature EOI");
+        goto out;
+    }
+
+    value = parse_value(ctxt, token);
     if (value == NULL) {
         parse_error(ctxt, token, "Missing value in dict");
         goto out;
@@ -309,21 +302,18 @@ out:
 static QObject *parse_object(JSONParserContext *ctxt)
 {
     QDict *dict = NULL;
-    JSONToken *token, *peek;
-
-    token = parser_context_pop_token(ctxt);
-    assert(token && token->type == JSON_LCURLY);
+    const JSONToken *token;
 
     dict = qdict_new();
 
-    peek = parser_context_peek_token(ctxt);
-    if (peek == NULL) {
+    token = parser_context_pop_token(ctxt);
+    if (token == NULL) {
         parse_error(ctxt, NULL, "premature EOI");
         goto out;
     }
 
-    if (peek->type != JSON_RCURLY) {
-        if (parse_pair(ctxt, dict) == -1) {
+    if (token->type != JSON_RCURLY) {
+        if (parse_pair(ctxt, token, dict) == -1) {
             goto out;
         }
 
@@ -339,7 +329,13 @@ static QObject *parse_object(JSONParserContext *ctxt)
                 goto out;
             }
 
-            if (parse_pair(ctxt, dict) == -1) {
+            token = parser_context_pop_token(ctxt);
+            if (token == NULL) {
+                parse_error(ctxt, NULL, "premature EOI");
+                goto out;
+            }
+
+            if (parse_pair(ctxt, token, dict) == -1) {
                 goto out;
             }
 
@@ -349,8 +345,6 @@ static QObject *parse_object(JSONParserContext *ctxt)
                 goto out;
             }
         }
-    } else {
-        (void)parser_context_pop_token(ctxt);
     }
 
     return QOBJECT(dict);
@@ -363,23 +357,20 @@ out:
 static QObject *parse_array(JSONParserContext *ctxt)
 {
     QList *list = NULL;
-    JSONToken *token, *peek;
-
-    token = parser_context_pop_token(ctxt);
-    assert(token && token->type == JSON_LSQUARE);
+    const JSONToken *token;
 
     list = qlist_new();
 
-    peek = parser_context_peek_token(ctxt);
-    if (peek == NULL) {
+    token = parser_context_pop_token(ctxt);
+    if (token == NULL) {
         parse_error(ctxt, NULL, "premature EOI");
         goto out;
     }
 
-    if (peek->type != JSON_RSQUARE) {
+    if (token->type != JSON_RSQUARE) {
         QObject *obj;
 
-        obj = parse_value(ctxt);
+        obj = parse_value(ctxt, token);
         if (obj == NULL) {
             parse_error(ctxt, token, "expecting value");
             goto out;
@@ -399,7 +390,13 @@ static QObject *parse_array(JSONParserContext *ctxt)
                 goto out;
             }
 
-            obj = parse_value(ctxt);
+            token = parser_context_pop_token(ctxt);
+            if (token == NULL) {
+                parse_error(ctxt, NULL, "premature EOI");
+                goto out;
+            }
+
+            obj = parse_value(ctxt, token);
             if (obj == NULL) {
                 parse_error(ctxt, token, "expecting value");
                 goto out;
@@ -413,8 +410,6 @@ static QObject *parse_array(JSONParserContext *ctxt)
                 goto out;
             }
         }
-    } else {
-        (void)parser_context_pop_token(ctxt);
     }
 
     return QOBJECT(list);
@@ -424,11 +419,8 @@ out:
     return NULL;
 }
 
-static QObject *parse_keyword(JSONParserContext *ctxt)
+static QObject *parse_keyword(JSONParserContext *ctxt, const JSONToken *token)
 {
-    JSONToken *token;
-
-    token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_KEYWORD);
 
     if (!strcmp(token->str, "true")) {
@@ -442,11 +434,8 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
     return NULL;
 }
 
-static QObject *parse_interpolation(JSONParserContext *ctxt)
+static QObject *parse_interpolation(JSONParserContext *ctxt, const JSONToken *token)
 {
-    JSONToken *token;
-
-    token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_INTERP);
 
     if (!strcmp(token->str, "%p")) {
@@ -478,11 +467,8 @@ static QObject *parse_interpolation(JSONParserContext *ctxt)
     return NULL;
 }
 
-static QObject *parse_literal(JSONParserContext *ctxt)
+static QObject *parse_literal(JSONParserContext *ctxt, const JSONToken *token)
 {
-    JSONToken *token;
-
-    token = parser_context_pop_token(ctxt);
     assert(token);
 
     switch (token->type) {
@@ -530,29 +516,21 @@ static QObject *parse_literal(JSONParserContext *ctxt)
     }
 }
 
-static QObject *parse_value(JSONParserContext *ctxt)
+static QObject *parse_value(JSONParserContext *ctxt, const JSONToken *token)
 {
-    JSONToken *token;
-
-    token = parser_context_peek_token(ctxt);
-    if (token == NULL) {
-        parse_error(ctxt, NULL, "premature EOI");
-        return NULL;
-    }
-
     switch (token->type) {
     case JSON_LCURLY:
         return parse_object(ctxt);
     case JSON_LSQUARE:
         return parse_array(ctxt);
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
@@ -575,8 +553,15 @@ QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
 {
     JSONParserContext ctxt = { .buf = tokens, .ap = ap };
     QObject *result;
+    const JSONToken *token;
 
-    result = parse_value(&ctxt);
+    token = parser_context_pop_token(&ctxt);
+    if (token == NULL) {
+        parse_error(&ctxt, NULL, "premature EOI");
+        return NULL;
+    }
+
+    result = parse_value(&ctxt, token);
     assert(ctxt.err || g_queue_is_empty(ctxt.buf));
 
     error_propagate(errp, ctxt.err);
-- 
2.52.0


