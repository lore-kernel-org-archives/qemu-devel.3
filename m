Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1BDE9D800
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 20:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9TlA-0005fq-OC; Sun, 05 Apr 2026 16:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl7-0005e2-Li; Sun, 05 Apr 2026 16:07:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl4-00036h-O5; Sun, 05 Apr 2026 16:07:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635GKlp83045555; Sun, 5 Apr 2026 20:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rjNuhebYUg6vqJ5le
 MWXD+6D1lC7nXdGyxXk4HOp6WI=; b=rXBwZeQw8TRGwN0FRhssmRVQIm8H/KNfF
 MYnnYdOTF0hXfjqeuLJQlpka3QgrPLqgfKmZ++BiGfRIjSsW/zYN+mldNWYPdIVj
 reSAyBkrGJ9jCg6kq9AJfkXuv3f8Jop6RVA/igsU4x0K1UYs3youYYRx5kOXpVq6
 uenO3EwGZX0nb0cZa+/ad80Za0aGmYO7f5YM5UNsJsRxSjkY6yWfV/iNCcBS0j7N
 9UbliX4jMRevqqSnEiV6cVvhRHQkv+mSY/alwxadgo896qRrptIpHyIZN4UOfItf
 gfQuoyqD4muu7Fe33GMi2YvMXz9YdvbUM5w7zdtf/nsBVFhEY/pqQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2m7pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635Hb5Hk006367;
 Sun, 5 Apr 2026 20:07:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbfp1j2cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 635K7f2q26083950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 5 Apr 2026 20:07:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C8B358051;
 Sun,  5 Apr 2026 20:07:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2280B5805A;
 Sun,  5 Apr 2026 20:07:41 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.243.136])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  5 Apr 2026 20:07:41 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v3 2/3] aio-poll: refine iothread polling using weighted
 handler intervals
Date: Sun,  5 Apr 2026 15:07:33 -0500
Message-ID: <20260405200735.3075407-3-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405200735.3075407-1-jhkim@linux.ibm.com>
References: <20260405200735.3075407-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIwNiBTYWx0ZWRfX+3sK9ZjCUAk8
 y9K39AXd0FjiYM9Kx5PBIloon6Z+EC6pQOaR6ouuB5UCpc7HfOk9dG3iqnUAfNT+Lgfm5SBpflH
 pVAD6hWvHLhBwZ+BUujWCe7q1Q5o6Y3x6VYaczRSJ1n3VEsFPnK1ErwrvdXdRJzhImEorAnN4k0
 YP/eNHXBvAS3BGn59rEhfqwlCvcXdtO2ivVsnfacQ5wZ8RqSLg0gWGlZyI6w8XaMfJ8fXoP5TDZ
 GURl5YKhjOe2iDCrjVztxhzaO1AeTTegeQsPkX4Eo7XnAqAiGMAy9JZDkBQu6WPu1H6/IgcyyDm
 kOg9FjlEjXg5mYcYpIC8lmrzGhfhxgOfsjfKA6SbW2iLIhE1oTMLeTb4mqB4UQHH0PX+rSAgm10
 kV1ucsvTQS2uwOhgDLhO+HrlE7+WFX0W7YNiNZ2R5I4AAYjRSWYQHewMklqoNKxDwc4ThQKnGSU
 gIdziT24YwV/OrmhI2g==
X-Proofpoint-GUID: _K0uGTQqG-ZBIioVqDva0qT18g8OXMfq
X-Proofpoint-ORIG-GUID: _K0uGTQqG-ZBIioVqDva0qT18g8OXMfq
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d2c10f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=7aeLzZfa0VvpqtFDgoYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050206
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The table below shows a comparison between:
-Host: RHEL 10.1 GA + qemu-10.0.0-14.el10_1, Guest: RHEL 9.6GA vs.
-Host: RHEL 10.1 GA + qemu-10.0.0-14.el10_1 (w=2/w=3), Guest: RHEL 9.6GA
for FIO FCP and FICON with 1 iothread and 8 iothreads.
The values shown are the averages for numjobs 1, 4, and 8.

Summary of results (% change vs baseline):

                    | poll-weight=2      | poll-weight=3
--------------------|--------------------|-----------------
Throughput avg      | -2.4% (all tests)  | -2.2% (all tests)
CPU consumption avg | -10.9% (all tests) | -9.4% (all tests)

Both configurations achieve ~10% CPU reduction with minimal
throughput impact (~2%), addressing the QEMU 10.0.0 CPU regression.
Weight=3 is chosen as default for its slightly better throughput
while maintaining substantial CPU savings.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 include/qemu/aio.h |   3 +-
 util/aio-posix.c   | 130 ++++++++++++++++++++++++++++++---------------
 util/aio-posix.h   |   2 +-
 util/async.c       |   1 +
 4 files changed, 90 insertions(+), 46 deletions(-)

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
-
-        if (ctx->poll_shrink) {
-            poll->ns /= ctx->poll_shrink;
-        } else {
-            poll->ns = 0;
+    if (block_ns < ctx->poll_ns) {
+        int64_t old = ctx->poll_ns;
+        int64_t shrink = ctx->poll_shrink;
+
+        if (shrink == 0) {
+            shrink = 2;
+        }
+
+        if (block_ns < (ctx->poll_ns / shrink)) {
+            ctx->poll_ns /= shrink;
         }
 
-        trace_poll_shrink(ctx, old, poll->ns);
-    } else if (poll->ns < ctx->poll_max_ns &&
-               block_ns < ctx->poll_max_ns) {
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
2.43.0


