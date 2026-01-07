Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74CDCF6C04
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPEH-0008KE-0s; Wed, 07 Jan 2026 03:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDs-0007qW-H8
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDq-0008HU-9B
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767775733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5po6tsrt4IQ0D/x9eF96zQfTjykL6tNnFFFoC5rONSQ=;
 b=OiS9jAS3X9W6Kdl7IPHWxhsQIiKxRTPyxPIdI8L4agETlGeeiYsLzdAN0gMExCoUIC8inf
 zFADMUIGAFe2sZmABMiwwgDaYtbNvstnDcXlNUQG8pL0IWU8rIWVvQoCIFGv+qjW8bBlyi
 2KGVUkmudoLTMhr5WbG+9ZjNNaLweUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-FZPFTHJ-OjaGdJ5-lG7PLg-1; Wed, 07 Jan 2026 03:48:52 -0500
X-MC-Unique: FZPFTHJ-OjaGdJ5-lG7PLg-1
X-Mimecast-MFC-AGG-ID: FZPFTHJ-OjaGdJ5-lG7PLg_1767775731
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so13748195e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767775730; x=1768380530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5po6tsrt4IQ0D/x9eF96zQfTjykL6tNnFFFoC5rONSQ=;
 b=fwsku4m0OLIl9ranVXIuh8hxgTNsAXbkv2pec31G8NbHqJI3B1+soGsF4N7eeQ65ty
 YrY1vQh7AzJoE2B/KOKlCELChY+eR1KiMuNLXOJowxi/KRO68tGLYBmvlfgD0hjmgEKo
 eQlOQWG3h98fpJvfq/akIMTkGbzKr0stzUAyO0XS3bwoXtQaL0ziNvJ2V3hxbDcrLjdH
 bbZYWWdu4JlVBEGM2pab47KBqZwrLfCGmBNu5N5FiUc1Co4hoKpHIdsO5N7PqPdzZ7rH
 f+FtnDTFqs5EhFGWrdlqW51HydFWLqcE8dNK6r3NcbcvOw1VaOUGU6RlXKfZcOt54jwc
 cCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767775730; x=1768380530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5po6tsrt4IQ0D/x9eF96zQfTjykL6tNnFFFoC5rONSQ=;
 b=sc8zk8nZVB5psNf25EYS8pQdgMjIPr41utBEjU4f0o5fI08B93f9oiZfud0LWZSAi8
 epM1Zwt7UBNim930Blu8dCrSywszc2Ylr9DIuc4YefCSzz4PArb7PgBZxjKf1JugQRqs
 fSiN1RCg43i5feeLkp2Mx46gvsoDYFASCZ9IdUN1s7PTc9TK4XLjhX75zWakXbeKoojv
 87kkxsCYTbzYHgTEpLlXfFKiuHLZ4Omh9Qd3M5oySH9nlH7VkrC8qpp8Io/5w4AkGAu+
 FN9PvLzeEtipdb4S3uwDwGbCil3kvt5M3UNY1IHyz2DwU6uea5VtURiqgYEW8M3s67HP
 U0JQ==
X-Gm-Message-State: AOJu0Yw6BqWnvVLJoZkcW9tNdxry8YqGT8x0kqQ305o4GlHjSqbUEv+v
 +kQnx8YOBNE9THBkNeFEN6W2pyFRB6kEe+D9dgpMinP1vAJka8U8fLy7XcoawQwAK4NYJxj5/5d
 cMSkgu42qkJbsoOH7Q2QrJaCUwsgLpNliccF65hwo74+rBOBP+ZyH6ZmUCbCHpmXwIcIutnyTz1
 sODG38mJR6FvTg/mYxrS/trVnEE5ogvC/h7xtJ/9eU
X-Gm-Gg: AY/fxX4kaab5dLu7N53nkNZFpbN4bndmFClt92e44jD8qNqB5ji/O6wkYPdjrBEoRxs
 eNvGkPLQo91QmlcsbiOJIpWHvGXJXJNQq5kjwNRGeMNxY8UDF71T2GTL3y0etM0FLcDlWLNYZfT
 eNRvhojL5Azc3zy/yHWVaCNIAhF/oeaKoCyTMxfkV/afefsYpALFISzIdXFIqhtiONaXVQ4Sbfm
 Ewr1mUs0eGanurn/MHoO0kPjVn4Nn4gXtUskd1OyR4Vz8tFd66myN+ehY9tpIKA5cyneLEXBoQU
 tRX2Ta/QmlLN2DO+GLzFLlfGzpyeCRsWedwwodRzd33/NBT5Wnptw550Wjutiio+o13x1Ywu3iP
 N7wBsN4CBLNGvVEGafEsWWunYV8Y2mXujkOq2m/eLx0TKA4cvjY6T3QpXs/BXu+Wj9FTbu4N8j9
 j53QEfBAjxfUVBUA==
X-Received: by 2002:a05:600c:1385:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-47d84b0a929mr13878255e9.7.1767775730285; 
 Wed, 07 Jan 2026 00:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/RsxVjTpz3FafFQPpLvfcqF3PTXEKnv4NXhyKWXjD18PJUmNPcJM8hpJG4DFcpIfizDcUtA==
X-Received: by 2002:a05:600c:1385:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-47d84b0a929mr13877975e9.7.1767775729819; 
 Wed, 07 Jan 2026 00:48:49 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d86c6ff40sm15191825e9.2.2026.01.07.00.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 00:48:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 4/5] json-streamer: do not heap-allocate JSONToken
Date: Wed,  7 Jan 2026 09:48:39 +0100
Message-ID: <20260107084840.150843-5-pbonzini@redhat.com>
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

This is not needed with a push parser.  Since it processes tokens
immediately, the JSONToken can be created directly on the stack
and does not need to copy the lexer's string data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qobject/json-parser-int.h |  8 ++++++--
 qobject/json-parser.c     | 18 ------------------
 qobject/json-streamer.c   |  4 ++--
 3 files changed, 8 insertions(+), 22 deletions(-)

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
index 7abdea4dacb..2fede59842f 100644
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
  * Objects: { } | { members }
  * - Empty: { -> AFTER_LCURLY -> }
@@ -529,17 +522,6 @@ static QObject *json_parser_parse_token(JSONParserContext *ctxt, const JSONToken
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
index a1210128ac1..07e0ef51ce3 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -23,7 +23,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
-    g_autofree JSONToken *token = json_token(type, x, y, input);
+    JSONToken token = (JSONToken) { .type = type, .x = x, .y = y, .str = input->str };
     Error *err = NULL;
 
     parser->token_size += input->len;
@@ -64,7 +64,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         } else if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
             error_setg(&err, "JSON nesting depth limit exceeded");
         } else {
-            QObject *json = json_parser_feed(&parser->parser, token, &err);
+            QObject *json = json_parser_feed(&parser->parser, &token, &err);
             if (json) {
                 parser->emit(parser->opaque, json, NULL);
             }
-- 
2.52.0


