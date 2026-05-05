Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3DACD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9bU-0000Eh-2j; Tue, 05 May 2026 02:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9bF-0000Dl-HJ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9bB-0005zp-Ip
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777963780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9Zty9QPvafc3EO/rY42r/T0cheD7R5WL7hpe0gpaW4=;
 b=fAtt60eJ6DTX1bdtBPcw4wI9OuAWDdAPMRG9+WzgKyvH8sF0yR/VztRoa6eKUrGbJiaCcR
 Us+zU0QLuEZiZFRUsymIWTHtwh3DktANRKAk7Xv9/AgtjbFPCvGSwSUKzAgJDBosKG9UU7
 Wzbd8xqMyyfV5PMVIuuMbOkkJOK7F/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-P8P8HpqSPu-vCU0q0-8glA-1; Tue, 05 May 2026 02:49:39 -0400
X-MC-Unique: P8P8HpqSPu-vCU0q0-8glA-1
X-Mimecast-MFC-AGG-ID: P8P8HpqSPu-vCU0q0-8glA_1777963778
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488ba2f4094so34764355e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777963777; x=1778568577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9Zty9QPvafc3EO/rY42r/T0cheD7R5WL7hpe0gpaW4=;
 b=HpUQPsOAU+mgsc3fZ2Dnzw08kDgaeDxJ3Sw52l175P6ermv0d0Br4k+z8lM+/aHCcX
 8r0l4amYNx6Hh6V2FChl76525Jyi+8e9DSESX6tg5trz+0DtRqLoWirnJ6869xPzhFcM
 sgD/oijwA590aVUpWa5Qukli26kXTfMnj+/OCQDNzzkZb1sAiqQlKBD3ga+M1c/QT6vT
 FAyrxpn2L3jAr0/NEDMda61TXvKkCFghpB8+ZzpBhoKeLb3pKymnUGc6aR4c7YYhY0aL
 TBMn5wKXEu9d9LILk4ZdGD5dY3jF2VwCDgKt18R1e8xaT7MvxGJ2ed6BhuUOtOynBBs+
 lHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963777; x=1778568577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K9Zty9QPvafc3EO/rY42r/T0cheD7R5WL7hpe0gpaW4=;
 b=T4CDYTLRbARqZC2r6A2tjRzocUVlSFmn/16EOyL8sSu3dW51yWow08iw82yqhYVRpp
 PQPu7bn+TNgcsEH1pAC1DavrK7LZFKgFFHTz0QZh6dtX5GlaE3+LaP5B7Hj34S61RC+c
 tCfq3peiV0apqhdnln3oEZALKATsOSLlxG+2RbVFZrO94QsZlTYdgiTXcXrzt9vXoO1a
 MkrO+gF+fejCct2vq3rowH54VGM3ehS0glfvXYF6Ek/7lBuGZR0D/xwfMLPovoHIgh0Z
 weXJnUJTXw0u2barV9QwByDgAkzShTIVit0wNDKafOPTBpdgPyGrIVAkDW+798WMNdXy
 tPbA==
X-Gm-Message-State: AOJu0YyoiQXnk+2OFd3zRB0Cb2o+I1MpGRttZpZsufSLUt7nMUNzxdto
 2lOOg88AQvvz88iSmuPFA1ooYChnR3wCKUEEu3Ve6RMmNwMvlNtZZOcBHlD3nLWSzyM4/b1opkf
 pYUvQp/D9u1ExsMhhzivuZN+90BdUEnN9duevlxuz4ARDJSKHdkB8ImJ+UXxxtvc0iJ9c1OvSDl
 OAqjGYeCCfb9LAj8cKDnPFmFSBCCsGaA6vVdXzIfYv
X-Gm-Gg: AeBDievLyYWA9s8mfMYPZX/PmTHdmPiG4HC1WknSY1jHNr3y05yRBPpVGaQdXFw9mHB
 lF9QEJ/CL1WepRXDXpok/Qv23y+QLyxaOPWcIqzyA3J+nKmJYaO2/5Tn7FEMs0IuiQjauFcbr75
 CNBqqVThE3lXNNZMQNfG/gJqqsr9sb8RJy+HT3/clSSiYqaovnsaJBv2HQLVxypSpE8ivop89hE
 0XSr3vl0FZPfdUsdMHelE7GB+DFQrc1zqZZzgeB6ehcHiWG2J9DxoegGnf/EtEwmnqLhGmceVKp
 +pL+KAqa+mrOt/E28HcVYRU4t9vP0sh/AXg3o/LTpL33qmBlF222OjlV+uIMT8pS1FMzsyj1wjE
 Zysp4LAP0K8RpijEz/64jG5Rod0PNTx54tr9RZ5u6yv3DcgfILpzETMqaH9HDzEObkdrxaBtVI/
 saSsQbC0CUv2VXngeUfMybqzdhT62nNmsh0OiQLRs=
X-Received: by 2002:a05:600c:a46:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-48d186dc7c6mr25544755e9.1.1777963777048; 
 Mon, 04 May 2026 23:49:37 -0700 (PDT)
X-Received: by 2002:a05:600c:a46:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-48d186dc7c6mr25544335e9.1.1777963776585; 
 Mon, 04 May 2026 23:49:36 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d14786d8csm12392455e9.0.2026.05.04.23.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:49:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2 6/7] json-streamer: do not heap-allocate JSONToken
Date: Tue,  5 May 2026 08:49:18 +0200
Message-ID: <20260505064919.177855-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505064919.177855-1-pbonzini@redhat.com>
References: <20260505064919.177855-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

This is not needed with a push parser.  Since it processes tokens
immediately, the JSONToken can be created directly on the stack
and does not need to copy the lexer's string data.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qobject/json-parser-int.h |  8 ++++++--
 qobject/json-parser.c     | 18 ------------------
 qobject/json-streamer.c   |  9 +++++++--
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 1f435cb8eb2..5a6b5c9af90 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -35,7 +35,12 @@ typedef enum json_token_type {
     JSON_MAX = JSON_END_OF_INPUT
 } JSONTokenType;
 
-typedef struct JSONToken JSONToken;
+typedef struct JSONToken {
+    JSONTokenType type;
+    int x;
+    int y;
+    char *str;
+} JSONToken;
 
 /* json-lexer.c */
 void json_lexer_init(JSONLexer *lexer, bool enable_interpolation);
@@ -48,7 +53,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y);
 
 /* json-parser.c */
-JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr);
 void json_parser_init(JSONParserContext *ctxt, va_list *ap);
 void json_parser_reset(JSONParserContext *ctxt);
 QObject *json_parser_feed(JSONParserContext *ctxt, const JSONToken *token, Error **errp);
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 93ad48361af..7bf1a81af86 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -24,13 +24,6 @@
 #include "qobject/qstring.h"
 #include "json-parser-int.h"
 
-struct JSONToken {
-    JSONTokenType type;
-    int x;
-    int y;
-    char str[];
-};
-
 /*
  * The JSON parser is a push parser, returning to the caller after every
  * token.  Therefore it has an explicit representation of its parser
@@ -606,17 +599,6 @@ static QObject *parse_token(JSONParserContext *ctxt, const JSONToken *token)
     return NULL;
 }
 
-JSONToken *json_token(JSONTokenType type, int x, int y, GString *tokstr)
-{
-    JSONToken *token = g_malloc(sizeof(JSONToken) + tokstr->len + 1);
-
-    token->type = type;
-    memcpy(token->str, tokstr->str, tokstr->len);
-    token->str[tokstr->len] = 0;
-    token->x = x;
-    token->y = y;
-    return token;
-}
 
 void json_parser_reset(JSONParserContext *ctxt)
 {
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index bc223053828..c4395f865f3 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -77,8 +77,13 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         } else if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
             error_setg(&err, "JSON nesting depth limit exceeded");
         } else {
-            g_autofree JSONToken *token = json_token(type, x, y, input);
-            QObject *json = json_parser_feed(&parser->parser, token, &err);
+            JSONToken token = (JSONToken) {
+                .type = type,
+                .x = x,
+                .y = y,
+                .str = input->str
+            };
+            QObject *json = json_parser_feed(&parser->parser, &token, &err);
             if (json) {
                 parser->emit(parser->opaque, json, NULL);
             }
-- 
2.54.0


