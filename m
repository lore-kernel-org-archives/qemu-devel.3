Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18BFCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3d6-0006Fq-Ek; Fri, 26 Jun 2026 06:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3d5-0006FT-DF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3d3-00055V-HO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXJQgLsRLvqft6rTlkd6uJkNVGDg/FaswUbPamdfO7g=;
 b=TwzaGWVmiTfrWEYY15bxPa5fDJFkQjfu5yG5FynzZufVQFYTDD6kXjvp+DCz6FNPACiyuL
 uXvbZ3skFrEYjWrxJWDy82p7AzXKtcYu6Dub0OrM/TW5Ah5+iS60HID9PaS57tqq0OMaAC
 a4K1tm2uEFpf+m5wLUr4lcaGZtr+IiQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-CZZesMOCNJWgeFAdBbAwAg-1; Fri, 26 Jun 2026 06:17:43 -0400
X-MC-Unique: CZZesMOCNJWgeFAdBbAwAg-1
X-Mimecast-MFC-AGG-ID: CZZesMOCNJWgeFAdBbAwAg_1782469062
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46dc84ca722so464997f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469062; x=1783073862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXJQgLsRLvqft6rTlkd6uJkNVGDg/FaswUbPamdfO7g=;
 b=CCDdQWMV6aDwtLcZpK3Z8LoJ/BRI/k4cYueKRktqsHdYZZItIq/kT3duOFe2UBONwK
 NPSYzNYWgvtFC+MjPHuoBdTi5JbjG1rphiNARiB1Pzui58b4gAoEQCoGGAmFRN+qJCVm
 VhSoZYiNDKbj36ZNX00Tgl4V+hzKpgwLTqU4a1N0cUAm35FxXF/z7nxkYHTZFzFZ4232
 gQErNUX7LnGEQ5VlvrhzJmeE/vEbcqpaQ1YcMoG2fbmeIMUQ1QQT7Lha7mc3dzMt73Sb
 /xDn5wbFURKmM/PegSCULB8rjVdDXD4okzoAjiAyNPW9Ivs/WjyY45eOgUwDv/ZbXq0I
 0pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469062; x=1783073862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXJQgLsRLvqft6rTlkd6uJkNVGDg/FaswUbPamdfO7g=;
 b=opqLYglYtyLwDsBhPAGZL3Aw252/Tkm+MK+fbjIdeD5UrhUv+rJiQWu6a9XMziRqge
 ixDsN3ROdlGkKA5l4Ka8GAe/qT+GrjW2IA7L56b6CYE5iV+VzTCXFfn7WCkNbrUYi7Rf
 qx8KqjBLUVDIF8KMnMQpfZqagwiVFBEWp9aT+X6N2TWKYLxmTecipvbrsfFKTULS8Tof
 kxwkvgQM/+EyXK+ygo1LhSJ0n9ppe+B34Ur8nflg2224ZuFPM2+BGUU1X5SFowtQSB/j
 MUbVP2CvXocnD3O5ciiK0f/KOci24GApAym3BSQCHgduzd4sZoNgP9Vmz/pJJW7fLnPZ
 m54A==
X-Gm-Message-State: AOJu0YwkbIReNtaFLB93xMzK56naUcZcUZYJPnsJOtoKXQiUX3/4V9I+
 Pnu26+L9ehpNGtUXNjA9AXf3a/15btVgv3pSs6LCOPSWNwI5/TL6R7aXYY2oVhXqb6A7YeKzaAU
 Q3CwEO/ktDrpf4vHfUyN4DCPjJTziTAiPu4u4iSkyCyu53YN7dyTkwZNBnZlZgJsIArdJfisPP6
 4j1QDaryeGwLB/5IgqLvBXFv0x/IdhhNn1dg85SKlQ
X-Gm-Gg: AfdE7cmwBdjJ2uRyrQB54g0i4nMjb2kcr7yurFfR4wauMezHFTNQmsCjtz1NxEN4qXt
 KgG15uYc8wdkv04PexeiyIVYuFL1UqmXT4TQYQt1uvXZeoqwDh/bYY/0e1ZxEVyxnhaJw805jCX
 Eu8ReGFbCZi+8OGiomq/W80H/4sUja1CEoQMcBo9pPbPdwmwJUSGD3ckz0RLbPqQhA/9n5WrqDT
 Rb2WsNDsv1CEN/I3EYOMxmAF88Mc96Gd7pjXFj9mnYBR5TNklxNYP/14e0u57crOmFh9rjKWo6N
 jyPIMVK8fwu+m8DgHDuyqh9NYfnt51xGcwvPap0ztoGSxc5jkYdo8a0HRySm1kbbDGQEdfuQbrx
 luK0M/F66jmHRK1IJ6O18jakND/FDhoMLKfFjpXOOrk6u2uLSWU8kkVdO4DNQDlC6I5a3JC6b0S
 72PwnaTs9z7o1HHyGW
X-Received: by 2002:a05:600d:644e:20b0:492:3fc4:bd6b with SMTP id
 5b1f17b1804b1-49266862939mr69554505e9.7.1782469061844; 
 Fri, 26 Jun 2026 03:17:41 -0700 (PDT)
X-Received: by 2002:a05:600d:644e:20b0:492:3fc4:bd6b with SMTP id
 5b1f17b1804b1-49266862939mr69554125e9.7.1782469061317; 
 Fri, 26 Jun 2026 03:17:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c286442sm23524675e9.1.2026.06.26.03.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 5/6] json-streamer: do not heap-allocate JSONToken
Date: Fri, 26 Jun 2026 12:17:25 +0200
Message-ID: <20260626101727.1727389-6-pbonzini@redhat.com>
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
index 484956deae4..4a3f5866129 100644
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
@@ -623,17 +616,6 @@ static QObject *parse_token(JSONParserContext *ctxt, const JSONToken *token)
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
index 9526f815f00..6d7c947f94a 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -78,8 +78,13 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
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


