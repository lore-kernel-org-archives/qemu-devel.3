Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2EBCD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWrs-0000vK-Sd; Mon, 25 May 2026 11:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrq-0000uk-He
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWro-000170-Vm
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7RDjCFtQaBkL/yRAJRX+bTcPtvbDBTZmwcpcHMzSVs=;
 b=HLGC0ZN8zEwM7+VLAsmdJ1yJXRoQ2ee2RSsR5SUz+XfvIstrQPkMHJUUXRkXTjQIAHHdv7
 iRN9wrw2jm0X72Cq/ypBtudjoq3u5upZq9eBy4Aoz6zlyze7fTGu3JaKc9E0pRAXZv+LkD
 cnCnzNGTIQddi12av4dLA6zCxL3YKxo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Pn3h9GjENVGO3O0Nax5Yeg-1; Mon, 25 May 2026 11:05:18 -0400
X-MC-Unique: Pn3h9GjENVGO3O0Nax5Yeg-1
X-Mimecast-MFC-AGG-ID: Pn3h9GjENVGO3O0Nax5Yeg_1779721518
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4903dcb32f8so31531305e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721517; x=1780326317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7RDjCFtQaBkL/yRAJRX+bTcPtvbDBTZmwcpcHMzSVs=;
 b=QRaV7OcI4+Vnd1KNC6hkf6G7gRLgJRfT8H/vNA/bE73B8cG8JGLepoQUMVs0g09bjM
 Woh3EqdLRbrh6p5aGki2lSfRQY+9X/N+rQaNrE/Iv65SdlLD3AnYwirapfprx7N/1eIP
 RR7kpt7bHFb6lqVlnGdhdeEmEr2eGT9xD66TeYWF8SOhs698YTb53qFUGNBNycubt+t7
 +AxSC/hYkKFjq/AJovKlEjVQY192sfR167c356UDHSIAwvX5ShBHA7XN01qnj9iLVTFm
 RboZLyL+jjoVpVsP5ORGnTtRtTnNKsxWHIAckQlUX8I0VYgJ9fgwcemgtNt6OZXrQ3Tx
 NZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721517; x=1780326317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K7RDjCFtQaBkL/yRAJRX+bTcPtvbDBTZmwcpcHMzSVs=;
 b=RMY9LIwaeVz+TX1FA1KAmVEj3bLzMxML/nKwU5zg2BUazeUoTDWZ6kv/fsp8GqObAT
 PqxcvIKe8lsS/KvPNxFu1z1EQUbR0by+iZhldwfjsqzr6QjRpeuRRNuX8sCGp6Iw9NZ4
 KkseE0cfQRM0Q8vv+vIfzJxwpB8pFM2okwY81R+RuMhCd2M3oinZ6PE+zYqbRmkGgdqt
 51RPZP2biwnNqsXETNZbE7amhg6GPx2P5oprS4HEFxRHpW/i7BHJbKtV2Jx6nWqp/WKE
 hLrJiQQLXI55JgB3LX8blimQm+w/XFnXCKK+0XozjuBAvUPckDVzKpV4C6Brl/ff8Xz0
 TPXg==
X-Gm-Message-State: AOJu0Yze/LoXMQ91EGz/EtcwqMYG91nMjJZLpvJRf9YgRiKkR+VpMnth
 qFzB4RofLIGgf3uzUgP8Lu9Vb56AI53nmfp78eOHX5VvKyb9NBlV4/RM/A8YOi03hw6u791abbF
 auz41yyY/0KOOBc65DVfa5beFErot4jQYIqfQODmAQ1LITry+8Je+P01XhD9yfvzRQkX8R2PlhG
 k1PBZmUSxKiy63YY4II9giii+rQoHtNtdb/31eOoq4
X-Gm-Gg: Acq92OHjS1eGeVREvPBK9fLZ+zW1pvlPo8gjm6GJZuMCwLNM8oYhcjsPywX2BXf9/f/
 SlI7O8BIySLDulp2aXHUvCsYD+ots/NsITNb4+oDr9OZ14in3tIhCZbSX86olaAC/bdzhn31Bep
 gUrwr3U3Dk1I/7HInMqhQ/ecyW9L8mJUvSkdO3Y2Yt6dHQ15Om9toOCbRcm1IHn7yc60wzeeiA5
 /MSg4fwuI01QiWFePIZdf4mChCHjSOXcHbR/PiX0vQRhLP0BGVKkb7s8OBqBHpUtEwaovvZbP/Z
 lr6l1DNxg5PCoJUPygFvu8qgD2g8qMwyBTmrAJRNPglffOeqwhpMw3XPCqeLLVEiUc3CK8GoIsg
 3P9yPa6r7rzZ8CjAySQPR+mzIazBLpHpi2A5pvtdrdyuS0W/4d/JurwoL4QZ0FDe3rPyTfhJKBM
 yA72pGD2utAIk7o8d1OVIK6QioVhKJqDIx1dH3yeI=
X-Received: by 2002:a05:600c:a012:b0:490:5191:6e26 with SMTP id
 5b1f17b1804b1-490519170bamr180276935e9.18.1779721517520; 
 Mon, 25 May 2026 08:05:17 -0700 (PDT)
X-Received: by 2002:a05:600c:a012:b0:490:5191:6e26 with SMTP id
 5b1f17b1804b1-490519170bamr180276125e9.18.1779721517051; 
 Mon, 25 May 2026 08:05:17 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d48e23sm26784409f8f.20.2026.05.25.08.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:05:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 6/7] json-streamer: do not heap-allocate JSONToken
Date: Mon, 25 May 2026 17:05:02 +0200
Message-ID: <20260525150503.393743-7-pbonzini@redhat.com>
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
index b77baab585f..faf3a9142bd 100644
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
@@ -609,17 +602,6 @@ static QObject *parse_token(JSONParserContext *ctxt, const JSONToken *token)
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
index 82d2bbc9426..2c1f20fc62b 100644
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


