Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3559ECD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWrp-0000tZ-Sh; Mon, 25 May 2026 11:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrp-0000r9-6x
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrn-00016q-5E
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbwwr95qXJz4xq269Q4zZDMuyeyImlQhnooKYRjbphE=;
 b=D8vmKl6DLuRHivUUcLNx8iZ8u349CwrWFdk46nZ6z62UTjcaUpfC8Fz29YW5bMpe0IWRZQ
 S51pMT0ozxZk2pfxTLxPBxj73AX6EUzChnUyokXgth2Klvz/RvmHF/PAHY6MPXdBdlMdof
 Uj+/4Fuy9Tt4jRj/vxW5Fbys8iqTRqc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-nK4RZMjQNuGXQnGFLvsz5A-1; Mon, 25 May 2026 11:05:17 -0400
X-MC-Unique: nK4RZMjQNuGXQnGFLvsz5A-1
X-Mimecast-MFC-AGG-ID: nK4RZMjQNuGXQnGFLvsz5A_1779721516
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso8830961f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721516; x=1780326316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tbwwr95qXJz4xq269Q4zZDMuyeyImlQhnooKYRjbphE=;
 b=pYOpCXB46dQtXwLBhjjFVXj8I1AKVR6aswmLA5aqXLCo4MW9B1I4Q7o9B1xzzixJdz
 Rm0Km7RWl8PJDGsSiWRaRQOiCiJUlgscliOAjcaciJDLfdwtXlBdeA58eDkgIoECv5CM
 o0+5ZOkpoQeNjHbkdHs+ks0L2eawX+H783R07ji0VdI0q8k6exN8NFy+Z+EBoqJubNTM
 PbPZmxuqrc8gdju79q0nHlxxKsDRGnYZbsT4MUd3Ts9432EcChMGZt4N5Naih6yYa+fZ
 E1peVNe3hw25rsFpR9X1xN2NYQP4s20X6fs504YKFcroHTfrDbOlI9WjOMaObEPDUf1j
 wbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721516; x=1780326316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tbwwr95qXJz4xq269Q4zZDMuyeyImlQhnooKYRjbphE=;
 b=rbsfHOUxtX4k2Uy9GiHMuwS4JB/kVfss6sgl1slJi53Lc9Y0lmeWPBjTw47KHsKvEX
 cg6Jzxe2eQfwR0SEgNuqo/HTMUyOs7S97/yTOj/pw70UrAM00ljoOg526sNMdPXHorxj
 xuvbrNizk3yfyE9u3eP7EV1MyvoFe9D6cANKU4XYvffrmJemqKX/WU+doxg28wPTBXoN
 SKY5sBlmYN3yc5xSNv80SlnKzem3CFRP/7nhHg2TtEmAg+7qEb8YDcbWA9Nxko4Cn679
 agLY/yc55O/wIZjui2gU9F/LgZZwhtpcKIP4WcLmlmqJoKsp/UN1jZDEBN9FwINI8cg9
 294Q==
X-Gm-Message-State: AOJu0YwHop8vBbN4deAHbLPxeK6EPq1zCR/YlnZH9cqDgTKcPKDl7VVX
 1k6KHYICJdFvRHMSlix44+sRp6NWuEOHW0KuLpOhvBGlA6cM/YySvVakVeJnrhuNc4DTW+58iu1
 dr/P0TLnyJ8GJu3V71+RPR3ZxnMj4t/4fgy7lilvZ9UrobOYMKa4emvgddLLhAYUkj29vEP9M+n
 aHIXhZGf9QWcEtuY5OL8E0qS5WJ5vsjt+bLvpsvuZz
X-Gm-Gg: Acq92OEUclNwrC1ybUSPA/+FX0nDME37/n6wBb3FEl1ehKIakLjKFaDlOgrv42EhzdQ
 x793SF9XpuJ2a2pDXVRSkHdGh5uj/LPCOJi7Xqe49d2GfsCYn64aP3yfbfeC9ZcYiutzmvtWR4m
 QflheeYiCvACKykDE0WBPRUDaAClGlO8bR3bucX+IDXHKH38z58UpwVaYMB6mEG3wtR0ku5MliJ
 dzEkZ2FztC/hOVEgrEhDloX5Jw2tQyd1Bsp5Oe85L3hSUZ982XSZGxi4Loq7bkfd4isA1CQWk82
 rgtbfOWsk2TRgMUrZJIA6NLVhbN5dxhiCvs57TZTF+U6A8Q7LZt1OPPHt1MIvflTG/o7SxlDFnT
 fikRwKKJ0Y9nPJw1XSb14ZKiJ7SBar90cyaoYFnW2EoqosRrmMXaxZGYzq3TowDpukxHV7hFjOO
 93btvC5TGqVljOA9M9uBz2kJTfj8Xf4zFMNG5kCb8=
X-Received: by 2002:a5d:6f0f:0:b0:45e:6518:21ad with SMTP id
 ffacd0b85a97d-45eb369cf4amr23170384f8f.3.1779721515489; 
 Mon, 25 May 2026 08:05:15 -0700 (PDT)
X-Received: by 2002:a5d:6f0f:0:b0:45e:6518:21ad with SMTP id
 ffacd0b85a97d-45eb369cf4amr23170307f8f.3.1779721514856; 
 Mon, 25 May 2026 08:05:14 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d64eb1sm31257502f8f.32.2026.05.25.08.05.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:05:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] json-streamer: remove token queue
Date: Mon, 25 May 2026 17:05:01 +0200
Message-ID: <20260525150503.393743-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525150503.393743-1-pbonzini@redhat.com>
References: <20260525150503.393743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 3b5edc5bae4..b77baab585f 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -659,6 +659,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token,
 
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
index b0bf2083ca6..82d2bbc9426 100644
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


