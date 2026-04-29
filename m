Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C7CD13D3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9Xs-0002fp-Od; Wed, 29 Apr 2026 14:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9Xk-0002dY-Iq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9Xd-0003hz-Pm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777486904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXB5hgY0R41Sv4TSwA9HHxO+9wz/jng/A3ubUblAZ5o=;
 b=Az7pa3V7NsE4s8JdgvN0SqeC4OdjVJB/du07HEtRGqBLp3o8qe4WorAQ6zM+Z0VTsSK02l
 3hp9foDTKjpDKXqoY2170cjCDak0nTX8QmwooHFyq4ue3rjnjsxbw8qQ4JE3fKPwiZXr8m
 vYI4A6XSmqq4msspv7ADv+JJEqJl1SE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-vmZs4b_SM_mkATI4zAmauQ-1; Wed,
 29 Apr 2026 14:21:42 -0400
X-MC-Unique: vmZs4b_SM_mkATI4zAmauQ-1
X-Mimecast-MFC-AGG-ID: vmZs4b_SM_mkATI4zAmauQ_1777486900
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0E3F18002CA; Wed, 29 Apr 2026 18:21:40 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90CA41800480; Wed, 29 Apr 2026 18:21:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PULL 2/3] aio-poll: refine iothread polling using weighted handler
 intervals
Date: Wed, 29 Apr 2026 14:21:26 -0400
Message-ID: <20260429182127.219776-3-stefanha@redhat.com>
In-Reply-To: <20260429182127.219776-1-stefanha@redhat.com>
References: <20260429182127.219776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jaehoon Kim <jhkim@linux.ibm.com>

Improve adaptive polling by updating each AioHandler's poll.ns
every loop iteration using weighted averages. This reduces CPU
consumption while minimizing performance impact.

Background:
Starting from QEMU 10.0, poll.ns was introduced per event handler
to mitigate excessive fluctuations in IOThread polling times
observed in earlier versions (QEMU 9.x). However, the current
design has limitations:

1. poll.ns is updated only when an event occurs, making it
   difficult to treat block_ns as a reliable event interval.
2. The IOThread's next polling time is determined by the maximum
   poll.ns among all AioHandlers, meaning idle AioHandlers with
   high poll.ns can have an outsized impact on polling duration.
3. For io_uring, idle AioHandlers are cleared after
   POLL_IDLE_INTERVAL_NS (7s), but for ppoll/epoll there is no
   such mechanism, leading to increased CPU consumption from idle
   nodes.

Implementation:
This patch treats block_ns as an event interval and updates each
AioHandler's poll.ns in every loop iteration:

- Active handlers (with events): poll.ns is updated using a
  weighted average of the current block_ns and previous poll.ns,
  smoothing out adjustments and preventing excessive fluctuations.
- Inactive handlers (no events): poll.ns accumulates block_ns
  without weighting, allowing rapid isolation of idle nodes. When
  poll.ns exceeds poll_max_ns, it resets to 0, preventing
  sporadically active handlers from unnecessarily prolonging
  iothread polling.
- The iothread polling duration is set based on the largest poll.ns
  among active handlers. The shrink divider defaults to 2, matching
  the grow rate, to reduce frequent poll_ns resets for slow devices.

The implementation renames poll_idle_timeout to last_dispatch_timestamp
for use as an active handler identifier.

Testing:
POLL_WEIGHT_SHIFT=3 (12.5% weight) was selected based on testing
comparing baseline vs weight=2/3 across various workloads:
Performance results (RHEL 10.1 + QEMU 10.0.0, FCP/FICON, 1-8 iothreads,
numjobs 1/4/8 averaged):
                    | poll-weight=2      | poll-weight=3
--------------------|--------------------|-----------------
Throughput avg      | -2.4% (all tests)  | -2.2% (all tests)
CPU consumption avg | -10.9% (all tests) | -9.4% (all tests)

Both configurations achieve ~10% CPU reduction with minimal throughput
impact (~2%). Weight=3 is chosen as default for slightly better
throughput while maintaining substantial CPU savings.

Additional validation testing on s390x SSD with fio (bs=8k, iodepth=8,
numjobs=1) shows how poll_weight affects polling time (poll.ns)
behavior:

RandRead workload:
+-------------+-----------+-----------+-------------+-------------+
| poll_weight | #samples  | Mean (ns) | 50th % (ns) | 90th % (ns) |
+-------------+-----------+-----------+-------------+-------------+
| 1           | 4.79M     |  8,034    |  5,116      | 20,509      |
| 2           | 5.01M     | 12,584    | 11,078      | 24,693      |
| 3           | 5.01M     | 15,647    | 14,863      | 28,695      |
| 4           | 5.12M     | 16,430    | 15,556      | 30,848      |
| 5           | 5.14M     | 16,461    | 15,306      | 32,123      |
+-------------+-----------+-----------+-------------+-------------+
RandWrite workload:
+-------------+-----------+-----------+-------------+-------------+
| poll_weight | #samples  | Mean (ns) | 50th % (ns) | 90th % (ns) |
+-------------+-----------+-----------+-------------+-------------+
| 1           | 6.37M     |  2,049    |  1,262      |  4,301      |
| 2           | 7.46M     |  4,118    |  3,226      |  7,476      |
| 3           | 7.97M     |  7,034    |  5,984      | 11,645      |
| 4           | 7.96M     | 12,789    | 11,362      | 20,040      |
| 5           | 7.82M     | 22,992    | 20,644      | 32,768      |
+-------------+-----------+-----------+-------------+-------------+

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Message-ID: <20260423195918.661299-3-jhkim@linux.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/aio.h |   3 +-
 util/aio-posix.h   |   2 +-
 util/aio-posix.c   | 128 ++++++++++++++++++++++++++++++---------------
 util/async.c       |   1 +
 4 files changed, 89 insertions(+), 45 deletions(-)

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index 8cca2360d1..6c22064a28 100644
--- a/include/qemu/aio.h
+++ b/include/qemu/aio.h
@@ -195,7 +195,7 @@ struct BHListSlice {
 typedef QSLIST_HEAD(, AioHandler) AioHandlerSList;
 
 typedef struct AioPolledEvent {
-    int64_t ns;        /* current polling time in nanoseconds */
+    int64_t ns;     /* estimated block time in nanoseconds */
 } AioPolledEvent;
 
 struct AioContext {
@@ -306,6 +306,7 @@ struct AioContext {
     int poll_disable_cnt;
 
     /* Polling mode parameters */
+    int64_t poll_ns;        /* current polling time in nanoseconds */
     int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
     int64_t poll_grow;      /* polling time growth factor */
     int64_t poll_shrink;    /* polling time shrink factor */
diff --git a/util/aio-posix.h b/util/aio-posix.h
index ab894a3c0f..cd459bbbae 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -38,7 +38,7 @@ struct AioHandler {
     unsigned flags; /* see fdmon-io_uring.c */
     CqeHandler internal_cqe_handler; /* used for POLL_ADD/POLL_REMOVE */
 #endif
-    int64_t poll_idle_timeout; /* when to stop userspace polling */
+    int64_t last_dispatch_timestamp; /* when last handler was dispatched */
     bool poll_ready; /* has polling detected an event? */
     AioPolledEvent poll;
 };
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 351847c6fb..8e9e9e5d8f 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -29,9 +29,11 @@
 
 /* Stop userspace polling on a handler if it isn't active for some time */
 #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
+#define POLL_WEIGHT_SHIFT   (3)
 
-static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
-                                int64_t block_ns);
+static void update_handler_poll_times(AioContext *ctx, int64_t block_ns,
+                                      int64_t dispatch_time);
+static void adjust_polling_time(AioContext *ctx, int64_t block_ns);
 
 bool aio_poll_disabled(AioContext *ctx)
 {
@@ -359,7 +361,7 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
 
 static bool aio_dispatch_ready_handlers(AioContext *ctx,
                                         AioHandlerList *ready_list,
-                                        int64_t block_ns)
+                                        int64_t dispatch_time)
 {
     bool progress = false;
     AioHandler *node;
@@ -369,11 +371,11 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
         progress = aio_dispatch_handler(ctx, node) || progress;
 
         /*
-         * Adjust polling time only after aio_dispatch_handler(), which can
-         * add the handler to ctx->poll_aio_handlers.
+         * Update last_dispatch_timestamp to mark this as an active
+         * handler for polling time adjustment and prevent idle removal.
          */
         if (ctx->poll_max_ns && QLIST_IS_INSERTED(node, node_poll)) {
-            adjust_polling_time(ctx, &node->poll, block_ns);
+            node->last_dispatch_timestamp = dispatch_time;
         }
     }
 
@@ -394,7 +396,7 @@ void aio_dispatch(AioContext *ctx)
         ctx->fdmon_ops->dispatch(ctx);
     }
 
-    /* block_ns is 0 because polling is disabled in the glib event loop */
+    /* Set now to 0 as polling is disabled in the glib event loop */
     aio_dispatch_ready_handlers(ctx, &ready_list, 0);
 
     aio_free_deleted_handlers(ctx);
@@ -415,9 +417,6 @@ static bool run_poll_handlers_once(AioContext *ctx,
     QLIST_FOREACH_SAFE(node, &ctx->poll_aio_handlers, node_poll, tmp) {
         if (node->io_poll(node->opaque)) {
             aio_add_poll_ready_handler(ready_list, node);
-
-            node->poll_idle_timeout = now + POLL_IDLE_INTERVAL_NS;
-
             /*
              * Polling was successful, exit try_poll_mode immediately
              * to adjust the next polling time.
@@ -458,11 +457,10 @@ static bool remove_idle_poll_handlers(AioContext *ctx,
     }
 
     QLIST_FOREACH_SAFE(node, &ctx->poll_aio_handlers, node_poll, tmp) {
-        if (node->poll_idle_timeout == 0LL) {
-            node->poll_idle_timeout = now + POLL_IDLE_INTERVAL_NS;
-        } else if (now >= node->poll_idle_timeout) {
+        if (node->poll_ready == false &&
+            now >= node->last_dispatch_timestamp + POLL_IDLE_INTERVAL_NS) {
             trace_poll_remove(ctx, node, node->pfd.fd);
-            node->poll_idle_timeout = 0LL;
+            node->last_dispatch_timestamp = 0LL;
             QLIST_SAFE_REMOVE(node, node_poll);
             if (ctx->poll_started && node->io_poll_end) {
                 node->io_poll_end(node->opaque);
@@ -560,18 +558,13 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
 static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
                           int64_t *timeout)
 {
-    AioHandler *node;
     int64_t max_ns;
 
     if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
         return false;
     }
 
-    max_ns = 0;
-    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
-        max_ns = MAX(max_ns, node->poll.ns);
-    }
-    max_ns = qemu_soonest_timeout(*timeout, max_ns);
+    max_ns = qemu_soonest_timeout(*timeout, ctx->poll_ns);
 
     if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
         /*
@@ -587,43 +580,85 @@ static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
     return false;
 }
 
-static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
-                                int64_t block_ns)
+static void adjust_polling_time(AioContext *ctx, int64_t block_ns)
 {
-    if (block_ns <= poll->ns) {
-        /* This is the sweet spot, no adjustment needed */
-    } else if (block_ns > ctx->poll_max_ns) {
-        /* We'd have to poll for too long, poll less */
-        int64_t old = poll->ns;
+    if (block_ns < ctx->poll_ns) {
+        int64_t old = ctx->poll_ns;
+        int64_t shrink = ctx->poll_shrink;
 
-        if (ctx->poll_shrink) {
-            poll->ns /= ctx->poll_shrink;
-        } else {
-            poll->ns = 0;
+        if (shrink == 0) {
+            shrink = 2;
         }
 
-        trace_poll_shrink(ctx, old, poll->ns);
-    } else if (poll->ns < ctx->poll_max_ns &&
-               block_ns < ctx->poll_max_ns) {
+        if (block_ns < (ctx->poll_ns / shrink)) {
+            ctx->poll_ns /= shrink;
+        }
+
+        trace_poll_shrink(ctx, old, ctx->poll_ns);
+    } else if (block_ns > ctx->poll_ns) {
         /* There is room to grow, poll longer */
-        int64_t old = poll->ns;
+        int64_t old = ctx->poll_ns;
         int64_t grow = ctx->poll_grow;
 
         if (grow == 0) {
             grow = 2;
         }
 
-        if (poll->ns) {
-            poll->ns *= grow;
+        if (block_ns > ctx->poll_ns * grow) {
+            ctx->poll_ns = block_ns;
         } else {
-            poll->ns = 4000; /* start polling at 4 microseconds */
+            ctx->poll_ns *= grow;
         }
 
-        if (poll->ns > ctx->poll_max_ns) {
-            poll->ns = ctx->poll_max_ns;
+        if (ctx->poll_ns > ctx->poll_max_ns) {
+            ctx->poll_ns = ctx->poll_max_ns;
         }
 
-        trace_poll_grow(ctx, old, poll->ns);
+        trace_poll_grow(ctx, old, ctx->poll_ns);
+    }
+}
+
+static void update_handler_poll_times(AioContext *ctx, int64_t block_ns,
+                                      int64_t dispatch_time)
+{
+    AioHandler *node;
+    int64_t max_poll_ns = -1;
+
+    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
+        if (node->last_dispatch_timestamp == dispatch_time) {
+            /*
+             * Active handler: had an event in this aio_poll() call.
+             * Update poll.ns using a weighted average of the current
+             * block_ns and previous poll.ns to smooth adjustments.
+             */
+            node->poll.ns = node->poll.ns
+                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
+                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
+
+            if (node->poll.ns > ctx->poll_max_ns) {
+                node->poll.ns = 0;
+            }
+            /*
+             * Track the maximum poll.ns among active handlers to
+             * calculate the next polling time.
+             */
+            max_poll_ns = MAX(max_poll_ns, node->poll.ns);
+        } else {
+            /*
+             * Inactive handler: no event in this aio_poll() call but
+             * was active before. Increase poll.ns by block_ns. If it
+             * exceeds poll_max_ns, reset to 0 until next event.
+             */
+            if (node->poll.ns != 0) {
+                node->poll.ns += block_ns;
+                if (node->poll.ns > ctx->poll_max_ns) {
+                    node->poll.ns = 0;
+                }
+            }
+        }
+    }
+    if (max_poll_ns >= 0) {
+        adjust_polling_time(ctx, max_poll_ns);
     }
 }
 
@@ -635,6 +670,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int64_t timeout;
     int64_t start = 0;
     int64_t block_ns = 0;
+    int64_t dispatch_ns = 0;
 
     /*
      * There cannot be two concurrent aio_poll calls for the same AioContext (or
@@ -711,7 +747,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     /* Calculate blocked time for adaptive polling */
     if (ctx->poll_max_ns) {
-        block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
+        dispatch_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+        block_ns = dispatch_ns - start;
     }
 
     if (ctx->fdmon_ops->dispatch) {
@@ -719,10 +756,14 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }
 
     progress |= aio_bh_poll(ctx);
-    progress |= aio_dispatch_ready_handlers(ctx, &ready_list, block_ns);
+    progress |= aio_dispatch_ready_handlers(ctx, &ready_list, dispatch_ns);
 
     aio_free_deleted_handlers(ctx);
 
+    if (ctx->poll_max_ns) {
+        update_handler_poll_times(ctx, block_ns, dispatch_ns);
+    }
+
     qemu_lockcnt_dec(&ctx->list_lock);
 
     progress |= timerlistgroup_run_timers(&ctx->tlg);
@@ -794,6 +835,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
     ctx->poll_max_ns = max_ns;
     ctx->poll_grow = grow;
     ctx->poll_shrink = shrink;
+    ctx->poll_ns = 0;
 
     aio_notify(ctx);
 }
diff --git a/util/async.c b/util/async.c
index 80d6b01a8a..9d3627566f 100644
--- a/util/async.c
+++ b/util/async.c
@@ -606,6 +606,7 @@ AioContext *aio_context_new(Error **errp)
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
 
     ctx->poll_max_ns = 0;
+    ctx->poll_ns = 0;
     ctx->poll_grow = 0;
     ctx->poll_shrink = 0;
 
-- 
2.54.0


