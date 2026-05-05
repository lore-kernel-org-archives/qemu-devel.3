Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0086CCD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9bT-0000EY-De; Tue, 05 May 2026 02:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9bC-0000Cn-Ta
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9b9-0005yK-DZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777963777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAFLgNMvcSnlXSKkNfRXd6OuUhnFRvE1krLfdKSFa9Q=;
 b=FlRBmWW6vaG49Cmp9A2PGzSBHx6G177QrtNvhWsVf6dSSdukj/LHiW+oweqSWDaysPzKG7
 Lp6VfIeUbOfZv18R9gBgdsyr6ANYZHEtxhuaMCs9df8uyg/Bu+bEiJXTM2lygHg86px4vf
 YJg3lGTmkEUfufojcyGzrq7HEWPLglA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-8XDxV6O6MtKv2c_Llc7BHg-1; Tue, 05 May 2026 02:49:35 -0400
X-MC-Unique: 8XDxV6O6MtKv2c_Llc7BHg-1
X-Mimecast-MFC-AGG-ID: 8XDxV6O6MtKv2c_Llc7BHg_1777963775
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7a5b9678so3919340f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777963774; x=1778568574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAFLgNMvcSnlXSKkNfRXd6OuUhnFRvE1krLfdKSFa9Q=;
 b=TZtdCkt1jWtgNiI2CMvPP8rSm2uwGu4pUcmL5txVkjDaRGKpsvqTstlWsfIlJXROvM
 E4pNmf1JPEcM2fzW8u/XvplG+kg1P087UuRvYT5rt1IBzXvPJ24XteJEQGNwlllve8U1
 Rf8u6DzTYJVJyKzqDAHBH8nqr7nNyzzAa9J7wk4VTPIIRqC+3GougH1hYS5H5WmkulAi
 tSDKGRtjEwqfQdKlQ/En9BXcCPRAg17vgEjKC/gdLTxF9lBxojPhDmSajca1OIvR4A/H
 8XzNePJmM+vypAcyRdC5wVUpdBVWwQDdRQWrgL5Z9iRuZ0yonGqVCkgG9vQ50j6ulA2B
 xAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963774; x=1778568574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GAFLgNMvcSnlXSKkNfRXd6OuUhnFRvE1krLfdKSFa9Q=;
 b=J1xobi2I5FkHuJKecME2jsDj2tauzg0AZjD2FgR6T4Ftjh5BVPCoxKcrLtDOi29Idc
 0J6cOLomVFhB9tyvjKDvMPC/q1p+t3d1PN/Z/ahenzwCWmbQ7rW3Zs+Ypoueb4qXgRFb
 UDZIXDiMTgfO1GaLQmUm0ZmfnEASWeCijZL/9TtTeMdqm1cXnJxD7fokMNVgLMb6ylhV
 2uIVf4aNSOMNepf544JZ2UAPZCyWKqyiqiFEOJgf3dFuNUAaP8XnX9qDWWscl8k0zhSy
 pa8+7E1PvSoGkOxJWK+JXKZxqqYUJUFtmFIYV4VrGifS33CITNJcAeDWNEm+nLVYDt8Y
 sQew==
X-Gm-Message-State: AOJu0YwfklQcuicjyBWS6HDk1Er853ReBYUY7tOvJ/hzePMo3MU64eBq
 WfnAu1xr56fiNVNJaSBKW3RE5omv/GSqv5xfM/yCUGnNKIgDym+wE3aelEu26RzaBrQqfGunSBu
 CJ8+7kSc+z7bUZbxwWnBok+8B8SgX5GxzJ0psZbbVItgvMrWOM55/IiPvr8YVMBUoZ2nnm+ge8m
 TPXBPCx5WJr+1DqQLtrG8/g7EDLsBfvCG/5lwVtz+5
X-Gm-Gg: AeBDieuRoIPjKqT6niT9wf+4lN2WdW8Pn1R9EXs624cPuJhHcMB76GBt/MuNCOwjB09
 155dFpUMdCLbWeYxYLKz69GZfGYAPoE6kM9iq1GY/PgzHcwNsNQgUq137emUblIiVn3eu9Cf8iY
 LxEYVa8J9UYw0C3qQeBDvpf3qMwaLhAHqz3afNpDmw37HazeClIQdSswyRiwxk/Pp2cqybxLoVV
 4QjSPQzxHvkAYlXBLu0wnI4fUBbWe8ssOKacAgqW7HI2KserYubcHBZMOQGFyStdaFzbwBAa8cG
 UCibGB7qo8ja9jKgTIhPLwEIfa5SvN2AZ2Xu2yQygnVIwOqlFi6/U/958AxRlSZ0h7izdN6w8VZ
 tUhRwZJspJtMkq6ewZcrpAaBPxhzR9LOSbjZ5KMM6FsIupJbqSysXtDGJANX3t+hOxPYN1wiQz3
 Mlw9crimROXFkWF5LJdG2+Le8M20A+ntw7BI/b4SI=
X-Received: by 2002:adf:e902:0:b0:44f:d9f8:bb9f with SMTP id
 ffacd0b85a97d-44fd9f8bbf3mr3255503f8f.43.1777963774252; 
 Mon, 04 May 2026 23:49:34 -0700 (PDT)
X-Received: by 2002:adf:e902:0:b0:44f:d9f8:bb9f with SMTP id
 ffacd0b85a97d-44fd9f8bbf3mr3255477f8f.43.1777963773773; 
 Mon, 04 May 2026 23:49:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055e2d3d0sm2027855f8f.34.2026.05.04.23.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:49:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2 5/7] json-streamer: remove token queue
Date: Tue,  5 May 2026 08:49:17 +0200
Message-ID: <20260505064919.177855-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505064919.177855-1-pbonzini@redhat.com>
References: <20260505064919.177855-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
 qobject/json-streamer.c       | 100 ++++++++++++++--------------------
 3 files changed, 46 insertions(+), 61 deletions(-)

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
index df103b4666c..93ad48361af 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -656,6 +656,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token,
 
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
index d400e3814fa..bc223053828 100644
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
@@ -56,12 +49,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         parser->bracket_count--;
         break;
     case JSON_ERROR:
-        error_setg(&err, "JSON parse error, stray '%s'", input->str);
-        goto out_emit;
-    case JSON_END_OF_INPUT:
-        if (g_queue_is_empty(&parser->tokens)) {
-            return;
-        }
     end_error_recovery:
         /*
          * Cause error recovery to end immediately.
@@ -76,49 +63,43 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
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
-    parser->brace_count = 0;
-    parser->bracket_count = 0;
-    json_message_free_tokens(parser);
-    parser->token_size = 0;
-    parser->emit(parser->opaque, json, err);
-    json_parser_reset(&parser->parser);
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
@@ -128,9 +109,10 @@ void json_message_parser_init(JSONMessageParser *parser,
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
@@ -146,12 +128,10 @@ void json_message_parser_feed(JSONMessageParser *parser,
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


