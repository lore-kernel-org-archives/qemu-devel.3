Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4976C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts27r-0001dI-VG; Tue, 11 Mar 2025 12:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22D-00044C-N8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22B-0005j0-QR
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDW6dSOze4AXVEFycmqqUI4XjjNB4hqnpaIsI5KoTEQ=;
 b=NgR4QlwHjUYqKwbmmbYxzC5gk1vGzC9UYSnX9lhFNOwH/xqdUzOK788RgYFesl3gHFGNTK
 BopWnVvGiPhPM5bsI1jPJAe2aUygpoH0jcchvLTgGV3xlyQaHzNP3fNN9TnPLpjTr/nHPP
 KovRr+oSPacXU4rlZOjbE0VEXiCPJ1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-hgG9bouPOh29Zv4N9rzJQg-1; Tue,
 11 Mar 2025 12:00:43 -0400
X-MC-Unique: hgG9bouPOh29Zv4N9rzJQg-1
X-Mimecast-MFC-AGG-ID: hgG9bouPOh29Zv4N9rzJQg_1741708842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A32D9180025B; Tue, 11 Mar 2025 16:00:42 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 070401800373; Tue, 11 Mar 2025 16:00:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/22] aio-posix: Adjust polling time also for new handlers
Date: Tue, 11 Mar 2025 17:00:07 +0100
Message-ID: <20250311160021.349761-9-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

aio_dispatch_handler() adds handlers to ctx->poll_aio_handlers if
polling should be enabled. If we call adjust_polling_time() for all
polling handlers before this, new polling handlers are still left at
poll->ns = 0 and polling is only actually enabled after the next event.
Move the adjust_polling_time() call after aio_dispatch_handler().

This fixes test-nested-aio-poll, which expects that polling becomes
effective the first time around.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250311141912.135657-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/aio-posix.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 80785c29d2..2e0a5dadc4 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -28,6 +28,9 @@
 /* Stop userspace polling on a handler if it isn't active for some time */
 #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
 
+static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
+                                int64_t block_ns);
+
 bool aio_poll_disabled(AioContext *ctx)
 {
     return qatomic_read(&ctx->poll_disable_cnt);
@@ -392,7 +395,8 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
  * scanning all handlers with aio_dispatch_handlers().
  */
 static bool aio_dispatch_ready_handlers(AioContext *ctx,
-                                        AioHandlerList *ready_list)
+                                        AioHandlerList *ready_list,
+                                        int64_t block_ns)
 {
     bool progress = false;
     AioHandler *node;
@@ -400,6 +404,14 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
     while ((node = QLIST_FIRST(ready_list))) {
         QLIST_REMOVE(node, node_ready);
         progress = aio_dispatch_handler(ctx, node) || progress;
+
+        /*
+         * Adjust polling time only after aio_dispatch_handler(), which can
+         * add the handler to ctx->poll_aio_handlers.
+         */
+        if (ctx->poll_max_ns && QLIST_IS_INSERTED(node, node_poll)) {
+            adjust_polling_time(ctx, &node->poll, block_ns);
+        }
     }
 
     return progress;
@@ -653,6 +665,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     bool use_notify_me;
     int64_t timeout;
     int64_t start = 0;
+    int64_t block_ns = 0;
 
     /*
      * There cannot be two concurrent aio_poll calls for the same AioContext (or
@@ -725,20 +738,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     aio_notify_accept(ctx);
 
-    /* Adjust polling time */
+    /* Calculate blocked time for adaptive polling */
     if (ctx->poll_max_ns) {
-        AioHandler *node;
-        int64_t block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
-
-        QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
-            if (QLIST_IS_INSERTED(node, node_ready)) {
-                adjust_polling_time(ctx, &node->poll, block_ns);
-            }
-        }
+        block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
     }
 
     progress |= aio_bh_poll(ctx);
-    progress |= aio_dispatch_ready_handlers(ctx, &ready_list);
+    progress |= aio_dispatch_ready_handlers(ctx, &ready_list, block_ns);
 
     aio_free_deleted_handlers(ctx);
 
-- 
2.48.1


