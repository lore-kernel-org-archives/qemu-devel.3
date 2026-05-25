Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A688ECD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2r-00068J-EH; Mon, 25 May 2026 11:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2p-00064b-Tv
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2o-0007XU-8z
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=gLylFw0bgDmpe7gDDaF+JpZxz6BmrW4T7ixw+xFyoqBiIo1yRHpJ3v5G1scFGKWHAeKKhI
 onX/+b5k6VtqLsYODPZwfMUeCSF44aESa8Te5MexPdVWiGRw3E2+3DmV91HuwYKjPTpBpS
 3jaZFpG5CYNy7AHlb6Fbl5S8woxjfUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-ZCnK8RhzMfWD-YyfNbAn9A-1; Mon, 25 May 2026 11:16:39 -0400
X-MC-Unique: ZCnK8RhzMfWD-YyfNbAn9A-1
X-Mimecast-MFC-AGG-ID: ZCnK8RhzMfWD-YyfNbAn9A_1779722198
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe24773c8so51055555e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722198; x=1780326998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=puIPqvy2+zoGUDbiAWTi0oS6VQ1pjf7EOaMGYWiiYZn5K8dMXt2/iidpMfHhZZSsCf
 UPzVaqD/J4FQew4Ai+A/thgnvRXFLSXoQNz5T6q67d+Aerdq+YRBmiTsNZE/gXVwNljA
 aw5oz+WllnlwNXnHPtGZgY/2g5FLfGpETb2gBqLBH8BXLKJ0cU2+dl27P7PSReiFxfrd
 ds5K4IFxMCoo1sGAZZ2iE3rBMNZiSdKtGaqQDO8HqWLgdLdqkmVj3682dknu/0P4NuQ6
 2rDT0aXZjpSsTxkEG0V5l6XDaCWA2cIV21pbc4ZU5mm3sBAKbQRgeo8xUJxfpZ2NdHJC
 9NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722198; x=1780326998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=gFZeOTEMsdIwdN9GOyU5cc6mVxQTE7pOaowF3aF6FgJpUiFlLv+gim2R9EAwhbbVoO
 SKW2PHsFQGr4QYffQXWC606FBaL9g1ehf+u+VLXd7RzPttjKKT4IzeaTyeFlkZknHI8s
 oAs5rS+bA/TeEAbBlhTh/sFImHool1vBSPFJ9o/kyS6Lc6Ew+LpdjxfCTfH8nYtj8alD
 djXL6z8xvHxXhDwJlGAEh7C9meh9kDIBZ9tzsujj77cPb3kx1MypDgsu4AU1YCei0hWJ
 gNQx9xE2w78F3q6qXLhd2dLA2Gtw+7+XOTcP/TG2WKUY6uWksbV59h5mncbTq1ah+Zw+
 Nxig==
X-Gm-Message-State: AOJu0YwlRV6qwzcpBhXUh6C8y7OmgZZ+j57C9elRSrd5QkHh9MmgC+iB
 QU5kP3AU17e/Sr7SaiULMsd1SccDiXLWFaJWw1qrQKuYGByDhQ91bnIOC4erB2BU7a9Bp50bvWP
 7Q08bTEXrgsNa0DHmlD5iJzez7stObrH0/QtBh2fSmfcZN4wEBwucPTpWTiPeUnJJYUITDVtDmW
 /DJE7z0dxo5hu5t53K1/FtDm579e9epN/mQ0SAdguh
X-Gm-Gg: Acq92OFhz3pkNVZan/a4ITnTiV/TrZwZl8XCyrB4j4GE4bUSy8mlTGVuGlAK7ZWUHVQ
 0GygvGAjkxft9R+jja6Z1Fpkn9JZdQokf5MteHNpMEBZqUH1C/T1TV4sJ95UfyDllBV8AvTHDP3
 kshPMIa0WVxy4hd32ufOTXGmASiVOTM+SvY9IXgaqgruE1YBO9PCjkKfFyAgsKAv+iYoOke/dwE
 hfBSmMghRijEHzodd67o+4Ipnp/eyjfn9U20QXrj90qnQ4YxHVk9uXnD1C7AbwhzqmEqmTUkr8T
 8TBmL2xN0xHB7xMGsCwFgv+D0Yu9KHAP6g+gwpratMdMgexDbFX70JL6NXg72BNAAJLQvTJXOcm
 Qp9yoP0MwWigiM72A5qEjozx784RhMWm/pBtKRO0pjLVWRQjTvNV5Gdv9tgBeA/hAnHKT24bx6B
 /0hJDkLyndTBwV2j68iTnVCX3AC0qq
X-Received: by 2002:a05:600c:4ecc:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-490428c9564mr238084275e9.19.1779722198079; 
 Mon, 25 May 2026 08:16:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-490428c9564mr238083745e9.19.1779722197525; 
 Mon, 25 May 2026 08:16:37 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49044f2bad3sm274395015e9.0.2026.05.25.08.16.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:16:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] json-parser: constify JSONToken
Date: Mon, 25 May 2026 17:16:21 +0200
Message-ID: <20260525151621.395954-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151621.395954-1-pbonzini@redhat.com>
References: <20260525151621.395954-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qobject/json-parser.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7483e582fea..f6622b82b0a 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -55,7 +55,8 @@ static QObject *parse_value(JSONParserContext *ctxt);
  * Error handler
  */
 static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
-                                           JSONToken *token, const char *msg, ...)
+                                            const JSONToken *token,
+                                            const char *msg, ...)
 {
     va_list ap;
     char message[1024];
@@ -126,7 +127,7 @@ static int cvt4hex(const char *s)
  * - Invalid Unicode characters are rejected.
  * - Control characters \x00..\x1F are rejected by the lexer.
  */
-static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
+static QString *parse_string(JSONParserContext *ctxt, const JSONToken *token)
 {
     const char *ptr = token->str;
     GString *str;
@@ -239,14 +240,14 @@ out:
  * parser_context_pop_token is deleted as soon as parser_context_pop_token
  * is called again.
  */
-static JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
+static const JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
 {
     g_free(ctxt->current);
     ctxt->current = g_queue_pop_head(ctxt->buf);
     return ctxt->current;
 }
 
-static JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
+static const JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
 {
     return g_queue_peek_head(ctxt->buf);
 }
@@ -259,7 +260,7 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict)
     QObject *key_obj = NULL;
     QString *key;
     QObject *value;
-    JSONToken *peek, *token;
+    const JSONToken *peek, *token;
 
     peek = parser_context_peek_token(ctxt);
     if (peek == NULL) {
@@ -309,7 +310,7 @@ out:
 static QObject *parse_object(JSONParserContext *ctxt)
 {
     QDict *dict = NULL;
-    JSONToken *token, *peek;
+    const JSONToken *token, *peek;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_LCURLY);
@@ -363,7 +364,7 @@ out:
 static QObject *parse_array(JSONParserContext *ctxt)
 {
     QList *list = NULL;
-    JSONToken *token, *peek;
+    const JSONToken *token, *peek;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_LSQUARE);
@@ -426,7 +427,7 @@ out:
 
 static QObject *parse_keyword(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_KEYWORD);
@@ -444,7 +445,7 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
 
 static QObject *parse_interpolation(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_INTERP);
@@ -480,7 +481,7 @@ static QObject *parse_interpolation(JSONParserContext *ctxt)
 
 static QObject *parse_literal(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_pop_token(ctxt);
     assert(token);
@@ -532,7 +533,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
 
 static QObject *parse_value(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_peek_token(ctxt);
     if (token == NULL) {
-- 
2.54.0


