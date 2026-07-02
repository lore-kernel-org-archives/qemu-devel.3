Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D8EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGiH-0004g9-6V; Thu, 02 Jul 2026 08:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi7-0004cZ-0a
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi3-0000bO-Fg
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782996002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cKsmNByVUGfSieyuA+9LR/rYjRAcBMJs3v8ne67gDM=;
 b=MWmuTo91BxRVYukDkxiUpGpQyIzVNgt96T4oVifYN/boA8sfpwDu7jUIKhzKVvimQI5YhY
 /VMQA04sODX9PqXCDN/orONUyv5yBmlV/A6PeFZPIv6Zvuip6mF8fBBqnXG2f9HgQNTgFA
 LYg/nMHjchPsII8C6J7BUHz5VZ/s4+I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-SceaZBtAOn6rP6m5dK1pCw-1; Thu,
 02 Jul 2026 08:40:01 -0400
X-MC-Unique: SceaZBtAOn6rP6m5dK1pCw-1
X-Mimecast-MFC-AGG-ID: SceaZBtAOn6rP6m5dK1pCw_1782996000
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADFBF1944B01
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2026 12:40:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C57A36F0B
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2026 12:40:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 182CA21E66CA; Thu, 02 Jul 2026 14:39:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 6/7] json-streamer: do not heap-allocate JSONToken
Date: Thu,  2 Jul 2026 14:39:53 +0200
Message-ID: <20260702123954.1284221-7-armbru@redhat.com>
In-Reply-To: <20260702123954.1284221-1-armbru@redhat.com>
References: <20260702123954.1284221-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

This is not needed with a push parser.  Since it processes tokens
immediately, the JSONToken can be created directly on the stack
and does not need to copy the lexer's string data.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260626101727.1727389-6-pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser-int.h |  8 ++++++--
 qobject/json-parser.c     | 18 ------------------
 qobject/json-streamer.c   |  9 +++++++--
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 1f435cb8eb..5a6b5c9af9 100644
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
index 79a2989e7a..0dcc94fefd 100644
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
  * The JSON parser is a push parser, returning a completed top-level
  * object, an error, or NULL (if the object is incomplete and no error
@@ -624,17 +617,6 @@ static QObject *parse_token(JSONParserContext *ctxt, const JSONToken *token)
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
index 48c5506771..b634bbe99c 100644
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


