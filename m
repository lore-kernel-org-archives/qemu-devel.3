Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C13C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGiD-0004e4-1a; Thu, 02 Jul 2026 08:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi7-0004ca-0n
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi1-0000ZC-Bg
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782996000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8L15Bcx32fMBn9ToX54ay9RXWuDg7j6veFMiwl9j+H0=;
 b=Stl83micMVTg5NbOCb9LTvUrUTFZtiMVSYiIFXhuyP6UhzJ8wSK0VsdKRqn285/TD29CuN
 n3rUNDuyYjZci1b8sBaacSOpDM60p2BO9eKZwKBxyUYEl4I0Y5XLaibE6AJq3TWpcYJ54D
 T/CK7kQc3wHhB9k1FpjB/bIp+rcpRhk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-If-u7y84Ok22PhFxp3ADpQ-1; Thu,
 02 Jul 2026 08:39:59 -0400
X-MC-Unique: If-u7y84Ok22PhFxp3ADpQ-1
X-Mimecast-MFC-AGG-ID: If-u7y84Ok22PhFxp3ADpQ_1782995998
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2BB9183338B; Thu,  2 Jul 2026 12:39:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A99A71971E6F; Thu,  2 Jul 2026 12:39:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BE1621E68B4; Thu, 02 Jul 2026 14:39:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 3/7] json-streamer: reuse parser
Date: Thu,  2 Jul 2026 14:39:50 +0200
Message-ID: <20260702123954.1284221-4-armbru@redhat.com>
In-Reply-To: <20260702123954.1284221-1-armbru@redhat.com>
References: <20260702123954.1284221-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Paolo Bonzini <pbonzini@redhat.com>

The push parser can be reset, so reuse it when the json-streamer
detects a completed toplevel object.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260626101727.1727389-3-pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qobject/json-parser.h |  2 +-
 qobject/json-streamer.c       | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 05346fa816..4c3d89f751 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -29,8 +29,8 @@ typedef struct JSONParserContext {
 typedef struct JSONMessageParser {
     void (*emit)(void *opaque, QObject *json, Error *err);
     void *opaque;
-    va_list *ap;
     JSONLexer lexer;
+    JSONParserContext parser;
     int brace_count;
     int bracket_count;
     GQueue tokens;
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 6c93e6fd78..6c4f99b3e7 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -32,7 +32,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
-    JSONParserContext ctxt;
     QObject *json = NULL;
     Error *err = NULL;
     JSONToken *token;
@@ -90,21 +89,18 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         return;
     }
 
-    json_parser_init(&ctxt, parser->ap);
-
     /* Process all tokens in the queue */
     while (!g_queue_is_empty(&parser->tokens)) {
         token = g_queue_pop_head(&parser->tokens);
-        json = json_parser_feed(&ctxt, token, &err);
+        json = json_parser_feed(&parser->parser, token, &err);
         g_free(token);
         if (json || err) {
             break;
         }
     }
 
-    json_parser_destroy(&ctxt);
-
 out_emit:
+    json_parser_reset(&parser->parser);
     parser->brace_count = 0;
     parser->bracket_count = 0;
     json_message_free_tokens(parser);
@@ -119,12 +115,12 @@ void json_message_parser_init(JSONMessageParser *parser,
 {
     parser->emit = emit;
     parser->opaque = opaque;
-    parser->ap = ap;
     parser->brace_count = 0;
     parser->bracket_count = 0;
     g_queue_init(&parser->tokens);
     parser->token_size = 0;
 
+    json_parser_init(&parser->parser, ap);
     json_lexer_init(&parser->lexer, !!ap);
 }
 
@@ -144,4 +140,5 @@ void json_message_parser_destroy(JSONMessageParser *parser)
 {
     json_lexer_destroy(&parser->lexer);
     json_message_free_tokens(parser);
+    json_parser_destroy(&parser->parser);
 }
-- 
2.54.0


