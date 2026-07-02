Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BC9C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGi6-0004cX-Vh; Thu, 02 Jul 2026 08:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi4-0004c3-T9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi1-0000Yz-8C
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782996000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzkgJH733zQ1/24sgPR1KcHp8RMMso47pRoPPIy81gs=;
 b=NE/BD8mjHXayYfbyFuvcffN5enh6V1l9Prjyu+WlyeCrJlcEL+hZKoA6kRLXslZ7UDY/fT
 fSfxVzxCGJ2RX32mhNPsF9+6rZ9AhT+3j5X7CxT6awZyiCaryQPjCJXHV/9a905F0mtKPd
 6hM9WL4HLwwfClpK82jiXexorO/g0VY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-w4Zcfsv3MHG2-Kb0W2BJXQ-1; Thu,
 02 Jul 2026 08:39:58 -0400
X-MC-Unique: w4Zcfsv3MHG2-Kb0W2BJXQ-1
X-Mimecast-MFC-AGG-ID: w4Zcfsv3MHG2-Kb0W2BJXQ_1782995998
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B7991944F01
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2026 12:39:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4FCC194510C
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2026 12:39:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1193B21E6837; Thu, 02 Jul 2026 14:39:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 4/7] json-streamer: make brace/bracket count unsigned
Date: Thu,  2 Jul 2026 14:39:51 +0200
Message-ID: <20260702123954.1284221-5-armbru@redhat.com>
In-Reply-To: <20260702123954.1284221-1-armbru@redhat.com>
References: <20260702123954.1284221-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It makes no sense to let brace_count and bracket_count go negative,
also because it immediately ends error recovery and sets them both
back to zero.  Instead set them to zero *before* choosing
whether to process the token queue; this makes it possible to
have the fields as unsigned.

Note that JSON_END_OF_INPUT now forces the parentheses to appear
balanced, so that the queue is emptied and an error is reported;
hence, the "type != JSON_END_OF_INPUT" condition can be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260626101727.1727389-4-pbonzini@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Comment tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qobject/json-parser.h |  4 ++--
 qobject/json-streamer.c       | 24 +++++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 4c3d89f751..0cf6932ecd 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -31,8 +31,8 @@ typedef struct JSONMessageParser {
     void *opaque;
     JSONLexer lexer;
     JSONParserContext parser;
-    int brace_count;
-    int bracket_count;
+    unsigned int brace_count;
+    unsigned int bracket_count;
     GQueue tokens;
     uint64_t token_size;
 } JSONMessageParser;
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 6c4f99b3e7..e18fd9bb0e 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -41,21 +41,41 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         parser->brace_count++;
         break;
     case JSON_RCURLY:
+        if (!parser->brace_count) {
+            goto end_error_recovery;
+        }
         parser->brace_count--;
         break;
     case JSON_LSQUARE:
         parser->bracket_count++;
         break;
     case JSON_RSQUARE:
+        if (!parser->bracket_count) {
+            goto end_error_recovery;
+        }
         parser->bracket_count--;
         break;
     case JSON_ERROR:
         error_setg(&err, "JSON parse error, stray '%s'", input->str);
         goto out_emit;
     case JSON_END_OF_INPUT:
+        /*
+         * Force the parentheses to appear balanced and the queue
+         * to be emptied, causing a parse error if it wasn't.
+         */
         if (g_queue_is_empty(&parser->tokens)) {
             return;
         }
+    end_error_recovery:
+        /*
+         * We come here due to receiving either JSON_ERROR or a
+         * JSON_R{CURLY,SQUARE}) that is known to be unbalanced.
+         * If in error recovery, end it immediately.  If not in
+         * error recovery, json_parser_feed() will raise an error
+         * but error recovery won't be entered at all.
+         */
+        parser->brace_count = 0;
+        parser->bracket_count = 0;
         break;
     default:
         break;
@@ -83,9 +103,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
     g_queue_push_tail(&parser->tokens, token);
 
-    if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->brace_count >= 0 && parser->bracket_count >= 0
-        && type != JSON_END_OF_INPUT) {
+    if (parser->brace_count > 0 || parser->bracket_count > 0) {
         return;
     }
 
-- 
2.54.0


