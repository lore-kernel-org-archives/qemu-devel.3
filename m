Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CF7CF6C04
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPEA-0007yR-6L; Wed, 07 Jan 2026 03:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDr-0007nP-0y
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDp-0008H9-4x
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767775732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/FsbdCWOY56dDxZsECSCejih4ncADi7hDumpDJ65gk=;
 b=d57TST26S9Tpr6M/LlwSpgqx1ocWqMoHKGtI+sCvnX+hDnNaLRdEjEV1yhl3kVFFOguzi+
 DhUeA+NUQo7LU1F8pQJwPWJfr3ZlLRmoFohni88bFb9CfMoVmQ+7tTY6IeLIrgKj9uwiPg
 nBisrHE9w4nA76yzZY33e0JR2JSUoKA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-qlp-v9NgMNqT1iIphehwqA-1; Wed, 07 Jan 2026 03:48:51 -0500
X-MC-Unique: qlp-v9NgMNqT1iIphehwqA-1
X-Mimecast-MFC-AGG-ID: qlp-v9NgMNqT1iIphehwqA_1767775730
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so17338215e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767775729; x=1768380529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/FsbdCWOY56dDxZsECSCejih4ncADi7hDumpDJ65gk=;
 b=R8rappoSQurWKn9b8QXk40gEfPjTxFIfRZ3uy9trvIA99M9jVQZ6EGnMsxQRE1EJiy
 1rZi6e+oPruAO6Yol3YgYKGaDiBsDRRbhkuL8rPDIx3ya3LGO9Jaa8v8RVR09WMYZcJt
 a5Ae4drlhhg7gRof1ZyRCGToA3mO3Z1qlLel29CB59TtmGQLsWP13L4gxYoiN+iirL7R
 9hlvP5flJrEmEEbbXikEhB5YTIbtP6RX1e0auCPz9FtY40woqYCN/JLplJ7NQqy4/Tzk
 tcXhxJpZJiZ+OMSWNCTPhzVYvDJaG32wJySottfu9Oak9GdtfLEgbRqsw5pTMEkNEBTO
 /Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767775729; x=1768380529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f/FsbdCWOY56dDxZsECSCejih4ncADi7hDumpDJ65gk=;
 b=eBHGp47mqJ5Xb41ZcT7ZbvQbUfI7CF6zjIRSTrNP27WgJNdyuQabnfzDK7YAxWTvfW
 3/tJPV3JdPa1aW30ZDrgcHm+crpEUpKI0DPNzKMVhq+omuzoaZU005EBestTxBZSUoFT
 KuEz0+mNWXyFEY2lEYfMcsRfuSmtFCuQtFXVLztgKShiMcX0tBKPApBanYlz678aFda3
 27e2PEb+K3OyoUNMwNY/inqRysCodPkLB/5LkD3nBuu3aDQ0l4Ps9W07/QUgdvBcJ2/V
 UiXyuMr5jkyTRoTU62yZ1SZQE8pJAoUVnQD3G6JEZZPUs3mTSiqRRE/PR2ouWHP8Pahw
 ihKA==
X-Gm-Message-State: AOJu0YwRb/g6TPpFOt6u38mcI8veAQc4n9GCf/u3DaPRMrJLI1+yCdiv
 QP0WmOVY72MxQ/KWrXi42ykJEpzz41os4trOj1EGYgDQrkJL5NDftsUo/zE/zWGBUDjF/WWA6gm
 HMq9dv9mN0Sg6/yjyQZFzv1HjAy8OvmDchbYtkR59qheRUZfUh0LM1HGx4ptlGPKJAVZ2Axknh5
 USJ/EwjF8LFhvidRE3O6O/1XUU5iPVmmjMPIgXcPqS
X-Gm-Gg: AY/fxX594Mo2JhGWiPhdw6OJzoHfS3qjuwYS0znoT4onrVD2vWaKv9QQXhXv8urnQvD
 0mE9z9FEBflAqjhhym1s/7HiC8GsoxkyIV43uXsAokysOWU62VuQp3JX/93nn/P4KTlUKhctNwx
 NfucnQmdSMmgYASZxPxnrEUPNr8plyVDhDNUsPXh5o3g4ljuMxznyrvBz0dK0VfjjoiyrKemCDP
 /Es2KHG5+BbEIUHGe4+LxKUWmtL5u+sond9g7YNdSUgAKiCTn6toFvkrfGzvksSSTnZIpP/5iu7
 Ni9K4jQI/ZRPhqKRB+ggWGV4wpCQZBF2rQ7PwPziPI7Jmk6Su54j2qMVlc+zxxhILGp9Tn5PBwy
 xJXHb6Vmlj1Z4u4Q67FcPmmmFzTxehENBxv/HVatcqgVPPd3vUR2FeWleN3kq/upJvjkDi+AUYt
 6OCXfV/x/LREqmbw==
X-Received: by 2002:a05:600c:a16:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d84b0aadcmr15982765e9.2.1767775729008; 
 Wed, 07 Jan 2026 00:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHru43wlLq870Le44ky7slXIf33c1MeOM6bTg0/ZZVBIq0VnslBIdKkE8ZGD92BblvG0E2tOA==
X-Received: by 2002:a05:600c:a16:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d84b0aadcmr15982385e9.2.1767775728417; 
 Wed, 07 Jan 2026 00:48:48 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm92171235e9.1.2026.01.07.00.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 00:48:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 3/5] json-streamer: remove token queue
Date: Wed,  7 Jan 2026 09:48:38 +0100
Message-ID: <20260107084840.150843-4-pbonzini@redhat.com>
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

Now fully exploit the push parser, feeding it one token at a time
without having to wait until braces and brackets are balanced.

While the nesting counts are retained for error recovery purposes,
the system can now report the first parsing error without waiting
for delimiters to be balanced.  This also means that JSON_ERROR
can be handled in json-parser.c, not json-streamer.c.

After reporting the error, json-streamer.c then enters an error recovery
mode where subsequent errors are suppressed.  This mimics the previous
error reporting behavior, but it provides prompt feedback on parsing
errors.  As an example, here is an example interaction with qemu-ga.

BEFORE (error reported only once braces are balanced):

   >> {'execute':foo
   >> }
   << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
   >> {'execute':'somecommand'}
   << {"error": {"class": "CommandNotFound", "desc": "The command somecommand has not been found"}}

AFTER (error reported immediately, but similar error recovery as before):

   >> {'execute':foo
   << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
   >> }
   >> {'execute':'qmp_capabilities'}
   << {"error": {"class": "CommandNotFound", "desc": "The command qmp_capabilities has not been found"}}

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |   5 +-
 qobject/json-parser-int.h     |   1 +
 qobject/json-parser.c         |  26 +++++---
 qobject/json-streamer.c       | 116 ++++++++++++++--------------------
 4 files changed, 68 insertions(+), 80 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 05346fa816b..923eb74ca00 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -29,11 +29,12 @@ typedef struct JSONParserContext {
 typedef struct JSONMessageParser {
     void (*emit)(void *opaque, QObject *json, Error *err);
     void *opaque;
-    va_list *ap;
     JSONLexer lexer;
+    JSONParserContext parser;
     int brace_count;
     int bracket_count;
-    GQueue tokens;
+    int token_count;
+    bool error;
     uint64_t token_size;
 } JSONMessageParser;
 
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 05e2e8e1831..1f435cb8eb2 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -50,6 +50,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 /* json-parser.c */
 JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
 void json_parser_init(JSONParserContext *ctxt, va_list *ap);
+void json_parser_reset(JSONParserContext *ctxt);
 QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
 void json_parser_destroy(JSONParserContext *ctxt);
 
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 338f0c5aae6..7abdea4dacb 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -541,21 +541,27 @@ JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
     return token;
 }
 
-void json_parser_init(JSONParserContext *ctxt, va_list *ap)
-{
-    ctxt->err = NULL;
-    ctxt->stack = g_queue_new();
-    ctxt->ap = ap;
-}
-
-void json_parser_destroy(JSONParserContext *ctxt)
+void json_parser_reset(JSONParserContext *ctxt)
 {
     JSONParserStackEntry *entry;
 
+    ctxt->err = NULL;
     while ((entry = g_queue_pop_tail(ctxt->stack)) != NULL) {
         qobject_unref(entry->partial);
         g_free(entry);
     }
+}
+
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
     g_queue_free(ctxt->stack);
     ctxt->stack = NULL;
 }
@@ -566,6 +572,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error
 
     assert(!ctxt->err);
     switch (token->type) {
+    case JSON_ERROR:
+        parse_error(ctxt, token, "JSON parse error, stray '%s'", token->str);
+        break;
+
     case JSON_END_OF_INPUT:
         /* Check for premature end of input */
         if (!g_queue_is_empty(ctxt->stack)) {
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 6c93e6fd78d..a1210128ac1 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -1,5 +1,5 @@
 /*
- * JSON streaming support
+ * JSON parser - callback interface and error recovery
  *
  * Copyright IBM, Corp. 2009
  *
@@ -19,97 +19,73 @@
 #define MAX_TOKEN_COUNT (2ULL << 20)
 #define MAX_NESTING (1 << 10)
 
-static void json_message_free_tokens(JSONMessageParser *parser)
-{
-    JSONToken *token;
-
-    while ((token = g_queue_pop_head(&parser->tokens))) {
-        g_free(token);
-    }
-}
-
 void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
-    JSONParserContext ctxt;
-    QObject *json = NULL;
+    g_autofree JSONToken *token = json_token(type, x, y, input);
     Error *err = NULL;
-    JSONToken *token;
 
+    parser->token_size += input->len;
+    parser->token_count++;
+
+    /* Detect message boundaries for error recovery purposes.  */
     switch (type) {
     case JSON_LCURLY:
         parser->brace_count++;
         break;
     case JSON_RCURLY:
-        parser->brace_count--;
+        if (parser->brace_count > 0) {
+            parser->brace_count--;
+        }
         break;
     case JSON_LSQUARE:
         parser->bracket_count++;
         break;
     case JSON_RSQUARE:
-        parser->bracket_count--;
-        break;
-    case JSON_ERROR:
-        error_setg(&err, "JSON parse error, stray '%s'", input->str);
-        goto out_emit;
-    case JSON_END_OF_INPUT:
-        if (g_queue_is_empty(&parser->tokens)) {
-            return;
+        if (parser->bracket_count > 0) {
+            parser->bracket_count--;
         }
         break;
     default:
         break;
     }
 
-    /*
-     * Security consideration, we limit total memory allocated per object
-     * and the maximum recursion depth that a message can force.
-     */
-    if (parser->token_size + input->len + 1 > MAX_TOKEN_SIZE) {
-        error_setg(&err, "JSON token size limit exceeded");
-        goto out_emit;
-    }
-    if (g_queue_get_length(&parser->tokens) + 1 > MAX_TOKEN_COUNT) {
-        error_setg(&err, "JSON token count limit exceeded");
-        goto out_emit;
-    }
-    if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
-        error_setg(&err, "JSON nesting depth limit exceeded");
-        goto out_emit;
-    }
+    /* during error recovery eat tokens until parentheses balance */
+    if (!parser->error) {
+        /*
+         * Security consideration, we limit total memory allocated per object
+         * and the maximum recursion depth that a message can force.
+         */
+        if (parser->token_size > MAX_TOKEN_SIZE) {
+            error_setg(&err, "JSON token size limit exceeded");
+        } else if (parser->token_count > MAX_TOKEN_COUNT) {
+            error_setg(&err, "JSON token count limit exceeded");
+        } else if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
+            error_setg(&err, "JSON nesting depth limit exceeded");
+        } else {
+            QObject *json = json_parser_feed(&parser->parser, token, &err);
+            if (json) {
+                parser->emit(parser->opaque, json, NULL);
+            }
+        }
 
-    token = json_token(type, x, y, input);
-    parser->token_size += input->len;
-
-    g_queue_push_tail(&parser->tokens, token);
-
-    if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->brace_count >= 0 && parser->bracket_count >= 0
-        && type != JSON_END_OF_INPUT) {
-        return;
-    }
-
-    json_parser_init(&ctxt, parser->ap);
-
-    /* Process all tokens in the queue */
-    while (!g_queue_is_empty(&parser->tokens)) {
-        token = g_queue_pop_head(&parser->tokens);
-        json = json_parser_feed(&ctxt, token, &err);
-        g_free(token);
-        if (json || err) {
-            break;
+        if (err) {
+            parser->emit(parser->opaque, NULL, err);
+            /* start recovery */
+            parser->error = true;
         }
     }
 
-    json_parser_destroy(&ctxt);
-
-out_emit:
-    parser->brace_count = 0;
-    parser->bracket_count = 0;
-    json_message_free_tokens(parser);
-    parser->token_size = 0;
-    parser->emit(parser->opaque, json, err);
+    if ((parser->brace_count == 0 && parser->bracket_count == 0)
+        || type == JSON_END_OF_INPUT) {
+        parser->error = false;
+        parser->brace_count = 0;
+        parser->bracket_count = 0;
+        parser->token_count = 0;
+        parser->token_size = 0;
+        json_parser_reset(&parser->parser);
+    }
 }
 
 void json_message_parser_init(JSONMessageParser *parser,
@@ -119,12 +95,13 @@ void json_message_parser_init(JSONMessageParser *parser,
 {
     parser->emit = emit;
     parser->opaque = opaque;
-    parser->ap = ap;
+    parser->error = false;
     parser->brace_count = 0;
     parser->bracket_count = 0;
-    g_queue_init(&parser->tokens);
+    parser->token_count = 0;
     parser->token_size = 0;
 
+    json_parser_init(&parser->parser, ap);
     json_lexer_init(&parser->lexer, !!ap);
 }
 
@@ -137,11 +114,10 @@ void json_message_parser_feed(JSONMessageParser *parser,
 void json_message_parser_flush(JSONMessageParser *parser)
 {
     json_lexer_flush(&parser->lexer);
-    assert(g_queue_is_empty(&parser->tokens));
 }
 
 void json_message_parser_destroy(JSONMessageParser *parser)
 {
     json_lexer_destroy(&parser->lexer);
-    json_message_free_tokens(parser);
+    json_parser_destroy(&parser->parser);
 }
-- 
2.52.0


