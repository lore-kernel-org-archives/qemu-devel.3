Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F6DCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3d6-0006Fb-1N; Fri, 26 Jun 2026 06:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3d4-0006FK-H9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3d1-00054R-On
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXLdP7Z/ImFU396DY/eG/3Y3KVTSa70n4PlfMSVXj5A=;
 b=gTQVmP+0tT26FqFDTLWvGuXPCqw3XfpybuRp7fZCKkfyIiMb/EoYOrmynCerc19PnsCUCJ
 bts5XL0Eb5hOFZAMFkZZzSgGZzP50jiRgEHfIXogc+0uRnyFyeO1dmAOPiQOcFOndrJSoS
 iwiNbVHl19D4SA1wSdnLDLzm2jDbTic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-_8ylBa-YMlS7vEz_0eF0Jg-1; Fri, 26 Jun 2026 06:17:40 -0400
X-MC-Unique: _8ylBa-YMlS7vEz_0eF0Jg-1
X-Mimecast-MFC-AGG-ID: _8ylBa-YMlS7vEz_0eF0Jg_1782469060
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4923411f041so8754865e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469060; x=1783073860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXLdP7Z/ImFU396DY/eG/3Y3KVTSa70n4PlfMSVXj5A=;
 b=NPZs/KFUOejvXsJHXNQ22+3Fyq51PjBGdgtnYgJNJhJisXU/+d4EHAwbhsZYBlu747
 VM94wTFbT0g6ahhmmkru17jQwKfi7jHYHQNxTTCwEEZ/PQDlyVexUmfOrzHxv721WlrR
 T4wIjFUvKs4h+Zfd78un0wBrVijwVwouah30IkM0lKhCdXZt5mOi4zrDV86+YSyEEcqz
 TWFIaIKbMDpXFYP141F1N8YwgBK/dCEht+yTkoyLTPVQJj+uVA3z9CUdU1U+tsbD3/8r
 gYnnR06ztzDJxwAWvTRkaJL/D/CEtkKExMqVlWDi4vCZja3jJ36PCwm49V1Jg4mN2aPx
 QduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469060; x=1783073860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OXLdP7Z/ImFU396DY/eG/3Y3KVTSa70n4PlfMSVXj5A=;
 b=Ex7+J5CcyHz7mqfwvSFy3jH+OhXzKFbN3YhjrIaf0bdxP0HhdCirEngYF57g9QNySx
 5F5AlKUwJ/tYsit0s4iHov3sZC+fIPzx612Px8l2HUT1/5Jhj6izmP2MxlU2qsEUDBAg
 xuJYbSxuBedzyWUn/3hht92PYrAlVi4tK56OgjHOABQwP08hDIZuj3/hYwdCnU4ANxU2
 D66mxidpPox1HxkkwuR0nDCldPaC2qUijOLArdA1ax7ZHzl0fAveKQrtyyWLBLra1afG
 9zAtMcBy/Ysj17gh4mtd9DQ1ySVVsBUwi5XzTuJAhQTlb3gEMxoOneyw9bXvorAWC1b6
 5eeQ==
X-Gm-Message-State: AOJu0Yy1tDtMMtVpU0GyFOIqT1TfvODtrL6ypzpLkYbVF3xohKFAP0a/
 u9K5oWRPY3wgJYvB5fI5Ub9jYv/n32tHxu2M7w7nHig8wP2B2dR6W9d0Pyj+2e9vjfL3L26kR0Y
 Cb0QJBgMmGwO9hbFHAR+OFfycMfcCoCT4upMj8R+uLZ7O4lM6e/Ns7/Xyntn77spnYNRRwjpi6y
 xIXOwwO7f5HIgK+ALyTAZpkKAji6QOhQLoRnd+usTs
X-Gm-Gg: AfdE7cmGiPbc3yae+HY56MSB6hTqr4HVatM8ixack9Vz136/mTI8H1VJwF5ETsqldOb
 LQaoKb5ZmOYcYCMRcgxYyxynO/96VrNwOy7LLabi8rkviI4OUMG2bF+fo9R+h51/wLuGdgOd7aU
 FxflvblIcisJw02GMuOv91JYCay5VE09tfgwapfP0FL6Vo3qemkbWHUN0e2TzDuzeJQps6dq6ab
 IaLxRD+/jdfpul48ep4POfxMHTKpcRiJWeMRgc2nz9XJigLuMZIc2xR3BBt1weqSFTvrN2PRCJN
 iNEMyGrV3FPiCdhJgeuLfBXg4wn0W+gCIu6mJwCJXw5ySN7mUoTkKn0pVI9fV8cqw24sWsO5VSk
 kVaaVftkdmb4AOX8fgqkbRaOmWgvry8h6PcfxTNCXVDPT/LmwdKWqqsNtbbozaeHIcUjFeWYRZ1
 1KivTwdKXRYfmU9Tjf
X-Received: by 2002:a05:600c:6309:b0:490:bd1d:4732 with SMTP id
 5b1f17b1804b1-4926687e7a7mr82981005e9.23.1782469059534; 
 Fri, 26 Jun 2026 03:17:39 -0700 (PDT)
X-Received: by 2002:a05:600c:6309:b0:490:bd1d:4732 with SMTP id
 5b1f17b1804b1-4926687e7a7mr82980425e9.23.1782469058929; 
 Fri, 26 Jun 2026 03:17:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fc0d36sm112576045e9.2.2026.06.26.03.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 4/6] json-streamer: remove token queue
Date: Fri, 26 Jun 2026 12:17:24 +0200
Message-ID: <20260626101727.1727389-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101727.1727389-1-pbonzini@redhat.com>
References: <20260626101727.1727389-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Now fully exploit the push parser, feeding it one token at a time
without having to wait until braces and brackets are balanced.

While the nesting counts are retained for error recovery purposes,
the system can now report the first parsing error without waiting
for parentheses to be balanced.  This also means that JSON_ERROR
can be handled in json-parser.c, not json-streamer.c.

After reporting the error, json-streamer.c then enters an error recovery
mode where subsequent errors are suppressed.  This mimics the previous
error reporting behavior, but it provides prompt feedback on parsing
errors.  As an example, here is an example interaction with qemu-ga.

BEFORE (error reported only once braces are balanced):

   >> {"execute":foo
   >> }
   << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
   >> {"execute":"somecommand"}
   << {"error": {"class": "CommandNotFound", "desc": "The command somecommand has not been found"}}

AFTER (error reported immediately, but similar error recovery as before):

   >> {"execute":foo
   << {"error": {"class": "GenericError", "desc": "JSON parse error, invalid keyword 'foo'"}}
   >> }
   >> {"execute":"somecommand"}
   << {"error": {"class": "CommandNotFound", "desc": "The command somecommand has not been found"}}

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |   3 +-
 qobject/json-parser.c         |   4 ++
 qobject/json-streamer.c       | 106 +++++++++++++---------------------
 3 files changed, 47 insertions(+), 66 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 0cf6932ecdc..3479e637588 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -33,7 +33,8 @@ typedef struct JSONMessageParser {
     JSONParserContext parser;
     unsigned int brace_count;
     unsigned int bracket_count;
-    GQueue tokens;
+    unsigned int token_count;
+    bool error;
     uint64_t token_size;
 } JSONMessageParser;
 
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 845da3699aa..484956deae4 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -673,6 +673,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token,
 
     assert(!ctxt->err);
     switch (token->type) {
+    case JSON_ERROR:
+        parse_error(ctxt, token, "stray '%s'", token->str);
+        break;
+
     case JSON_END_OF_INPUT:
         /* Check for premature end of input */
         if (!g_queue_is_empty(ctxt->stack)) {
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 9e1f650bad8..9526f815f00 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -1,5 +1,5 @@
 /*
- * JSON streaming support
+ * JSON parser - callback interface and error recovery
  *
  * Copyright IBM, Corp. 2009
  *
@@ -19,23 +19,16 @@
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
-    QObject *json = NULL;
     Error *err = NULL;
-    JSONToken *token;
 
+    parser->token_size += input->len;
+    parser->token_count++;
+
+    /* Detect message boundaries for error recovery purposes.  */
     switch (type) {
     case JSON_LCURLY:
         parser->brace_count++;
@@ -56,19 +49,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         parser->bracket_count--;
         break;
     case JSON_ERROR:
-        error_setg(&err, "JSON parse error, stray '%s'", input->str);
-        goto out_emit;
-    case JSON_END_OF_INPUT:
-        /*
-         * Force the parentheses to appear balanced and the queue
-         * to be emptied, causing a parse error if it wasn't.
-         */
-        if (g_queue_is_empty(&parser->tokens)) {
-            return;
-        }
     end_error_recovery:
         /*
-         * We goto here due to receiving either JSON_ERROR or a
+         * We come here due to receiving either JSON_ERROR or a
          * JSON_R{CURLY,SQUARE}) that is known to be unbalanced.
          * If in error recovery, end it immediately.  If not in
          * error recovery, json_parser_feed() will raise an error
@@ -81,49 +64,43 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
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
+    if (parser->error) {
+        /* error recovery, eat tokens until parentheses balance */
+    } else {
+        /*
+         * Safety consideration, we limit total memory allocated per object
+         * and the maximum nesting depth that a message can force.
+         */
+        if (parser->token_size > MAX_TOKEN_SIZE) {
+            error_setg(&err, "JSON token size limit exceeded");
+        } else if (parser->token_count > MAX_TOKEN_COUNT) {
+            error_setg(&err, "JSON token count limit exceeded");
+        } else if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
+            error_setg(&err, "JSON nesting depth limit exceeded");
+        } else {
+            g_autofree JSONToken *token = json_token(type, x, y, input);
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
-    if (parser->brace_count > 0 || parser->bracket_count > 0) {
-        return;
-    }
-
-    /* Process all tokens in the queue */
-    while (!g_queue_is_empty(&parser->tokens)) {
-        token = g_queue_pop_head(&parser->tokens);
-        json = json_parser_feed(&parser->parser, token, &err);
-        g_free(token);
-        if (json || err) {
-            break;
+        if (err) {
+            parser->emit(parser->opaque, NULL, err);
+            /* start recovery */
+            parser->error = true;
         }
     }
 
-out_emit:
-    json_parser_reset(&parser->parser);
-    parser->brace_count = 0;
-    parser->bracket_count = 0;
-    json_message_free_tokens(parser);
-    parser->token_size = 0;
-    parser->emit(parser->opaque, json, err);
+    if ((parser->brace_count == 0 && parser->bracket_count == 0)
+        || type == JSON_END_OF_INPUT) {
+        json_parser_reset(&parser->parser);
+        parser->error = false;
+        parser->brace_count = 0;
+        parser->bracket_count = 0;
+        parser->token_count = 0;
+        parser->token_size = 0;
+    }
 }
 
 void json_message_parser_init(JSONMessageParser *parser,
@@ -133,9 +110,10 @@ void json_message_parser_init(JSONMessageParser *parser,
 {
     parser->emit = emit;
     parser->opaque = opaque;
+    parser->error = false;
     parser->brace_count = 0;
     parser->bracket_count = 0;
-    g_queue_init(&parser->tokens);
+    parser->token_count = 0;
     parser->token_size = 0;
 
     json_parser_init(&parser->parser, ap);
@@ -151,12 +129,10 @@ void json_message_parser_feed(JSONMessageParser *parser,
 void json_message_parser_flush(JSONMessageParser *parser)
 {
     json_lexer_flush(&parser->lexer);
-    assert(g_queue_is_empty(&parser->tokens));
 }
 
 void json_message_parser_destroy(JSONMessageParser *parser)
 {
     json_lexer_destroy(&parser->lexer);
-    json_message_free_tokens(parser);
     json_parser_destroy(&parser->parser);
 }
-- 
2.54.0


