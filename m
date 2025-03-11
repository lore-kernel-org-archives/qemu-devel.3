Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17F6C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts26X-0000NV-O4; Tue, 11 Mar 2025 12:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts226-0003zR-63
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts223-0005hI-Ol
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEHUeb7rP3pziRM5M1M5vXuLC6X6GpTgsDjSzUiJWqg=;
 b=Sz4Xf2RdLAqy+mmkP8lWI44dCY97N8wGhqXVU5AE5AtY33JKfD9TaMtKtkNjejBU9SrmrB
 YedEKEZPd8gTGCEkAb1aR64C6msD2oszArtdaPyfjFTrkLPS2+tRuDcW97ZmeFbMD4moRF
 BM7m58d5OaPxgu6f1AqQk/Yi0huIa2w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-f2R_OsgWMsCoG6vfiraPMA-1; Tue,
 11 Mar 2025 12:00:37 -0400
X-MC-Unique: f2R_OsgWMsCoG6vfiraPMA-1
X-Mimecast-MFC-AGG-ID: f2R_OsgWMsCoG6vfiraPMA_1741708836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3D319560AF; Tue, 11 Mar 2025 16:00:36 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D46EA180AF7B; Tue, 11 Mar 2025 16:00:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/22] aio: Create AioPolledEvent
Date: Tue, 11 Mar 2025 17:00:04 +0100
Message-ID: <20250311160021.349761-6-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As a preparation for having multiple adaptive polling states per
AioContext, move the 'ns' field into a separate struct.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250307221634.71951-4-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h |  6 +++++-
 util/aio-posix.c    | 31 ++++++++++++++++---------------
 util/async.c        |  3 ++-
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index b2ab3514de..c9fcfe7ccf 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -123,6 +123,10 @@ struct BHListSlice {
 
 typedef QSLIST_HEAD(, AioHandler) AioHandlerSList;
 
+typedef struct AioPolledEvent {
+    int64_t ns;        /* current polling time in nanoseconds */
+} AioPolledEvent;
+
 struct AioContext {
     GSource source;
 
@@ -229,7 +233,7 @@ struct AioContext {
     int poll_disable_cnt;
 
     /* Polling mode parameters */
-    int64_t poll_ns;        /* current polling time in nanoseconds */
+    AioPolledEvent poll;
     int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
     int64_t poll_grow;      /* polling time growth factor */
     int64_t poll_shrink;    /* polling time shrink factor */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 06bf9f456c..95bddb9e4b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -585,7 +585,7 @@ static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
         return false;
     }
 
-    max_ns = qemu_soonest_timeout(*timeout, ctx->poll_ns);
+    max_ns = qemu_soonest_timeout(*timeout, ctx->poll.ns);
     if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
         /*
          * Enable poll mode. It pairs with the poll_set_started() in
@@ -683,40 +683,40 @@ bool aio_poll(AioContext *ctx, bool blocking)
     if (ctx->poll_max_ns) {
         int64_t block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
 
-        if (block_ns <= ctx->poll_ns) {
+        if (block_ns <= ctx->poll.ns) {
             /* This is the sweet spot, no adjustment needed */
         } else if (block_ns > ctx->poll_max_ns) {
             /* We'd have to poll for too long, poll less */
-            int64_t old = ctx->poll_ns;
+            int64_t old = ctx->poll.ns;
 
             if (ctx->poll_shrink) {
-                ctx->poll_ns /= ctx->poll_shrink;
+                ctx->poll.ns /= ctx->poll_shrink;
             } else {
-                ctx->poll_ns = 0;
+                ctx->poll.ns = 0;
             }
 
-            trace_poll_shrink(ctx, old, ctx->poll_ns);
-        } else if (ctx->poll_ns < ctx->poll_max_ns &&
+            trace_poll_shrink(ctx, old, ctx->poll.ns);
+        } else if (ctx->poll.ns < ctx->poll_max_ns &&
                    block_ns < ctx->poll_max_ns) {
             /* There is room to grow, poll longer */
-            int64_t old = ctx->poll_ns;
+            int64_t old = ctx->poll.ns;
             int64_t grow = ctx->poll_grow;
 
             if (grow == 0) {
                 grow = 2;
             }
 
-            if (ctx->poll_ns) {
-                ctx->poll_ns *= grow;
+            if (ctx->poll.ns) {
+                ctx->poll.ns *= grow;
             } else {
-                ctx->poll_ns = 4000; /* start polling at 4 microseconds */
+                ctx->poll.ns = 4000; /* start polling at 4 microseconds */
             }
 
-            if (ctx->poll_ns > ctx->poll_max_ns) {
-                ctx->poll_ns = ctx->poll_max_ns;
+            if (ctx->poll.ns > ctx->poll_max_ns) {
+                ctx->poll.ns = ctx->poll_max_ns;
             }
 
-            trace_poll_grow(ctx, old, ctx->poll_ns);
+            trace_poll_grow(ctx, old, ctx->poll.ns);
         }
     }
 
@@ -770,8 +770,9 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
     /* No thread synchronization here, it doesn't matter if an incorrect value
      * is used once.
      */
+    ctx->poll.ns = 0;
+
     ctx->poll_max_ns = max_ns;
-    ctx->poll_ns = 0;
     ctx->poll_grow = grow;
     ctx->poll_shrink = shrink;
 
diff --git a/util/async.c b/util/async.c
index 47e3d35a26..fc8a78aa79 100644
--- a/util/async.c
+++ b/util/async.c
@@ -609,7 +609,8 @@ AioContext *aio_context_new(Error **errp)
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
 
-    ctx->poll_ns = 0;
+    ctx->poll.ns = 0;
+
     ctx->poll_max_ns = 0;
     ctx->poll_grow = 0;
     ctx->poll_shrink = 0;
-- 
2.48.1


