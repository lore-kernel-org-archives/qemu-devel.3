Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A979ACD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWri-0000ja-FF; Mon, 25 May 2026 11:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrh-0000iv-Ip
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrf-00014N-Ne
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=EVyJewoj9G3aQA1Rw+rRUiQDiDu1SA0UaR5nkvrsdL76WRwbq4LSPMuX7FMw8RUaP3wxDD
 nys88KJ11QYxYeD1DOdg2k9EoTOHRppDpE5/3y3mcTzSbyCJ2zQgTfaZhisyo+c5Z1XptM
 eKXRVs7P23fEfsRppcf6rOLb1B8jpQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-9qttMOuRPeOa5CEwjEfyuQ-1; Mon, 25 May 2026 11:05:08 -0400
X-MC-Unique: 9qttMOuRPeOa5CEwjEfyuQ-1
X-Mimecast-MFC-AGG-ID: 9qttMOuRPeOa5CEwjEfyuQ_1779721507
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49050c44bcdso29140745e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721507; x=1780326307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=A7a9SosVTQ3C2KQS3ECkB7p3i8euAlZ1MILDilppnp2VUTAD4Rxs5EqGCVEh+uqBKH
 7ofNZim3AkU4dekSGhWhro6yE26H7BqYSQ0hwd/jMqaAuZ7U93vD6UhRdxU3T0TC4uvr
 SuEvA4H9nEDBWPv6kdvZPK3gpoHxUE4hPW4u1Ny+SJtOT351NKCcFNYbbnMFaJVsqR7l
 u7O5ib+AHN8xB118nKMjKjYBSq9lBpGzMOQPclhpGKenWYqewa7F37TMpM5q55Bz1qQb
 7XtDuJIm4hcY7xCQFUGQ+uqDCCfE5xR5ruGhxvC8gH8ZFR4B/uTWS1WpeKSUWSx3GW0h
 k6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721507; x=1780326307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=aqTR70AOPWF82LboXP9JxTCJmR5WVSoGetkDC7GB7S2dXehIi9hHkApuaRkd6UWvpp
 TGvkWrHk7EvhXW9/JsP/NPGi/VQAxl2DEYqQfpXi68tczYW6Pi2Pz4chfFY7Ke8gBrzg
 9YNvy+MlcF/q9T3YrmcTrlksLZcZj8FBbj5UorUgS7QHCrGkgzFGceoL7aeKmYBD2UFc
 MW0/4OM5dAOqdcsP+GWiGKl50e3iVGKxCU2VuvjHFq7/HVvEH8Cpb3tDO8SVNFPzL/bB
 WlUaEy834zb8Ud1id24ywYXmGVrzP/WX+0IPs4dStGxhhZTLuqhLWp4D6Q7E/6RYS9Rl
 lAEw==
X-Gm-Message-State: AOJu0Yw4JBqdHSMFlsCrDRqeSY8D8Go+J/n+kIfsB7PwVSuJAAVhhbE7
 SBn/A3/1jRe1v50Z7+boWmchpMUt95VgadfHJ8Hgc24uTbqD4X03AgYtp0VWG8VeONHcfO72mK6
 vh/xYz9WI75PYu3k5I2GwAz5a/jl3OMDdm/Ab/+fopuZNKhZk1NTeoaZd1QrPd2lEY3hRjVzWSP
 h5UM8p2ggLgH6jnO/3pTECzMyb4dkQN+U2yoXt5YI0
X-Gm-Gg: Acq92OGrFTMnlskobnoJYlWgyMkgGFVYZpt9dpENqsdNdRo1Fd8tBGTsjIezViZquwF
 v/T1pFuICB1HSeA747ZAarb0RbSrTf4v70r7RxKKuxLXSdp/WKPG57lODsSbvmPIQ8YGWYk70X1
 sLRKXoNtBJ0YEKOWIaXtSqax3reCsrHA4Cvm/+pIATZ5dFj68x6pVa5pr/VTy5PO8XmXuVUBVTt
 ikvbCHjOZHQcdZfq70vqC99ZwhLRDcVTjHbphDv1+R26b83rhR5BxTLGJZIjBWT+kRvSMrASAgE
 SHuLWayKrtSGNwBf95vdTRstm49FW8Gdfq+LoNOymB9lKfnibONWo2asxwIukmO0XqwSrpU99D+
 nBLkFhEkGEzOHp6vQDINFNauHRp+MWteP4xdiW44MW+OCdjUFagOuq3tSGp6kn2Z+y2bfNhBDbM
 w+AgtyA6vNZ7LB/g4vBykQJ37kHb6c
X-Received: by 2002:a05:600d:6450:10b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-4904249d125mr172190575e9.6.1779721507366; 
 Mon, 25 May 2026 08:05:07 -0700 (PDT)
X-Received: by 2002:a05:600d:6450:10b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-4904249d125mr172189955e9.6.1779721506852; 
 Mon, 25 May 2026 08:05:06 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ea134sm284210305e9.8.2026.05.25.08.05.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:05:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] json-parser: constify JSONToken
Date: Mon, 25 May 2026 17:04:57 +0200
Message-ID: <20260525150503.393743-2-pbonzini@redhat.com>
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


