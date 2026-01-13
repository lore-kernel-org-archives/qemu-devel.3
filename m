Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E472D2F34F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfiWj-0005wp-0p; Tue, 13 Jan 2026 12:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vfiVT-0005UM-L8; Tue, 13 Jan 2026 12:48:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vfiVP-0004Tm-Cb; Tue, 13 Jan 2026 12:48:38 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60DEEhvp025420;
 Tue, 13 Jan 2026 17:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MeoklWTSX48o5BL9O
 yZiCwpEP02ax2+GunxooUxhevc=; b=GpNnA1JfzZtYuoomTsoVYKqCBIuHGnc3D
 o/V4EY9OX1oW3tfJOaMoPiTSyJ3IElgVd5wfMoaWFF44cGWL1UvX+c5DO5/krGtd
 L7FvyBdUEffKho+YFHgywjtQId04met18b7qmTEs/0p8DF1++Zq418sANhdP2slp
 fEJlGSNOC6ayj5+FNnmLmH2f1D/9+r77fEzMrVSFJOAA4UFT8fFw+P0pMytIo67Y
 1DxCY9stCqQty6ERgGVhZFz8MqPwyv/T1zhrASYvSF3mt0SjVHXtgDUHXNGpiLKw
 8QSWf9L2FcEOwn+QXBNW0smm3qMiIi+VlEccm9MlPsaaQxu56EG5A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedswem5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 17:48:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60DGMuYU025838;
 Tue, 13 Jan 2026 17:48:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kkdp4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 17:48:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60DHmT1W33358430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jan 2026 17:48:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71FD558053;
 Tue, 13 Jan 2026 17:48:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA2FA58059;
 Tue, 13 Jan 2026 17:48:28 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.252.253])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Jan 2026 17:48:28 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v1 2/3] aio-poll: refine iothread polling using weighted
 handler intervals
Date: Tue, 13 Jan 2026 11:48:23 -0600
Message-ID: <20260113174824.464720-3-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113174824.464720-1-jhkim@linux.ibm.com>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0OCBTYWx0ZWRfXw8cBpqfXENfq
 gMDazUAeV1s2Cb0QHrP6Uluqg5coGP0e5g4qzI5ZA+uDGlhzI5lwGwcRlNLtIECqdB+pz59Q8RQ
 LQHaFFuIeiUzCG6QaMHGhucjJ4Vi9pOJFiEpQ1FInJaBz5mSYF8lD8V82yGgZPlsbGEeaUEC2bU
 RgflE2a0HSf3bYxfT0sDkk8iKNkT8EG5GlBbzPLCnChduA0E5Rn0oFH1UJ3r69900um9yFmJqs+
 OZsEFfw32unfH3hwUV8JVK+yB6fsbElA2041OM1KbQxv7WkpYdyWRE5GVeWtd8oExftZ0ufm3qA
 JNvQ8djsAOFbz3san6dkXGgjkosAzqvuFWYlHAtudGTKQP/9cxId7Ip/zTQDwg9nGpaAJ1yjk2q
 m/Cx0N1ktT7rNY6wtpeWYFUxvhBGpZEGISYZOKbfkZUq9X7bJ993kF8GHREAVckVrBaqoTAE379
 D36zHFba0ulJQKONpgQ==
X-Proofpoint-GUID: g019utTVZIGextgC8Ax4QBvFl5JDjoDi
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6966856f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=xxBNnxn5Vv9M6JHFot4A:9
X-Proofpoint-ORIG-GUID: g019utTVZIGextgC8Ax4QBvFl5JDjoDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Refine adaptive polling in aio_poll by updating iothread polling
duration based on weighted AioHandler event intervals.

Each AioHandler's poll.ns is updated using a weighted factor when an
event occurs. Idle handlers accumulate block_ns until poll_max_ns and
then reset to 0, preventing sporadically active handlers from
unnecessarily prolonging iothread polling.

The iothread polling duration is set based on the largest poll.ns among
active handlers. The shrink divider defaults to 2, matching the grow
rate, to reduce frequent poll_ns resets for slow devices.

The default weight factor (POLL_WEIGHT_SHIFT=2) was selected based on
various FIO tests to balance mean poll_ns, reset frequency, and high
poll_ns occurrences. Correlation between current block_ns and weighted
value (adj_block_ns) slightly decreases as weight increases. Lower
weights cause more fluctuation; higher weights maintain poll_ns once it
rises.

The table below shows results for a representative randread case (bs=4k,
iodepth=8, 2 IOThread), illustrating the average poll_ns, the ratio of
poll_ns resets to 0, and the time spent near the maximum poll_ns for
different weight values.

Weight| Mean poll_ns |  poll_ns reset rate | Time near max(%)
------| ------------ | ------------------- | -----------------
  1   |     4523     |       89.9%         |     7.41%
  2   |     8442     |       78.6%         |     15.84%
  3   |    11147     |       70.4%         |     21.38%
  4   |    11624     |       70.1%         |     23.35%

Weight=1 reacts quickly, Weight=3-4 holds poll_ns higher once it rises,
and Weight=2 provides a good balance between responsiveness and CPU
usage.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 include/qemu/aio.h |   4 +-
 util/aio-posix.c   | 135 +++++++++++++++++++++++++++++++--------------
 util/async.c       |   1 +
 3 files changed, 99 insertions(+), 41 deletions(-)

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index 8cca2360d1..6c77a190e9 100644
--- a/include/qemu/aio.h
+++ b/include/qemu/aio.h
@@ -195,7 +195,8 @@ struct BHListSlice {
 typedef QSLIST_HEAD(, AioHandler) AioHandlerSList;
 
 typedef struct AioPolledEvent {
-    int64_t ns;        /* current polling time in nanoseconds */
+    bool has_event; /* Flag to indicate if an event has occurred */
+    int64_t ns;     /* estimated block time in nanoseconds */
 } AioPolledEvent;
 
 struct AioContext {
@@ -306,6 +307,7 @@ struct AioContext {
     int poll_disable_cnt;
 
     /* Polling mode parameters */
+    int64_t poll_ns;        /* current polling time in nanoseconds */
     int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
     int64_t poll_grow;      /* polling time growth factor */
     int64_t poll_shrink;    /* polling time shrink factor */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 7ddf92a25f..dd6008898b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -28,9 +28,11 @@
 
 /* Stop userspace polling on a handler if it isn't active for some time */
 #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
+#define POLL_WEIGHT_SHIFT   (2)
 
-static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
-                                int64_t block_ns);
+static void adjust_block_ns(AioContext *ctx, int64_t block_ns);
+static void grow_polling_time(AioContext *ctx, int64_t block_ns);
+static void shrink_polling_time(AioContext *ctx, int64_t block_ns);
 
 bool aio_poll_disabled(AioContext *ctx)
 {
@@ -372,7 +374,7 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
          * add the handler to ctx->poll_aio_handlers.
          */
         if (ctx->poll_max_ns && QLIST_IS_INSERTED(node, node_poll)) {
-            adjust_polling_time(ctx, &node->poll, block_ns);
+            node->poll.has_event = true;
         }
     }
 
@@ -559,18 +561,13 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
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
@@ -586,46 +583,98 @@ static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
     return false;
 }
 
-static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
-                                int64_t block_ns)
+static void shrink_polling_time(AioContext *ctx, int64_t block_ns)
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
-        }
+    /*
+     * Reduce polling time if the block_ns is zero or
+     * less than the current poll_ns.
+     */
+    int64_t old = ctx->poll_ns;
+    int64_t shrink = ctx->poll_shrink;
 
-        trace_poll_shrink(ctx, old, poll->ns);
-    } else if (poll->ns < ctx->poll_max_ns &&
-               block_ns < ctx->poll_max_ns) {
-        /* There is room to grow, poll longer */
-        int64_t old = poll->ns;
-        int64_t grow = ctx->poll_grow;
+    if (shrink == 0) {
+        shrink = 2;
+    }
 
-        if (grow == 0) {
-            grow = 2;
-        }
+    if (block_ns < (ctx->poll_ns / shrink)) {
+        ctx->poll_ns /= shrink;
+    }
 
-        if (poll->ns) {
-            poll->ns *= grow;
-        } else {
-            poll->ns = 4000; /* start polling at 4 microseconds */
-        }
+    trace_poll_shrink(ctx, old, ctx->poll_ns);
+}
 
-        if (poll->ns > ctx->poll_max_ns) {
-            poll->ns = ctx->poll_max_ns;
-        }
+static void grow_polling_time(AioContext *ctx, int64_t block_ns)
+{
+    /* There is room to grow, poll longer */
+    int64_t old = ctx->poll_ns;
+    int64_t grow = ctx->poll_grow;
 
-        trace_poll_grow(ctx, old, poll->ns);
+    if (grow == 0) {
+        grow = 2;
     }
+
+    if (block_ns > ctx->poll_ns * grow) {
+        ctx->poll_ns = block_ns;
+    } else {
+        ctx->poll_ns *= grow;
+    }
+
+    if (ctx->poll_ns > ctx->poll_max_ns) {
+        ctx->poll_ns = ctx->poll_max_ns;
+    }
+
+    trace_poll_grow(ctx, old, ctx->poll_ns);
 }
 
+static void adjust_block_ns(AioContext *ctx, int64_t block_ns)
+{
+    AioHandler *node;
+    int64_t adj_block_ns = -1;
+
+    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
+        if (node->poll.has_event) {
+            /*
+             * Update poll.ns for the node with an event.
+             * Uses a weighted average of the current block_ns and the previous
+             * poll.ns to smooth out polling time adjustments.
+             */
+            node->poll.ns = node->poll.ns
+                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
+                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
+
+            if (node->poll.ns >= ctx->poll_max_ns) {
+                node->poll.ns = 0;
+            }
+            /*
+             * To avoid excessive polling time increase, update adj_block_ns
+             * for nodes with the event flag set to true
+             */
+            adj_block_ns = MAX(adj_block_ns, node->poll.ns);
+            node->poll.has_event = false;
+         } else {
+            /*
+             * No event now, but was active before.
+             * If it waits longer than poll_max_ns, poll.ns will stay 0
+             * until the next event arrives.
+             */
+            if (node->poll.ns != 0) {
+                node->poll.ns += block_ns;
+                if (node->poll.ns >= ctx->poll_max_ns) {
+                    node->poll.ns = 0;
+                }
+            }
+        }
+    }
+
+    if (adj_block_ns >= 0) {
+        if (adj_block_ns > ctx->poll_ns) {
+            grow_polling_time(ctx, adj_block_ns);
+        } else {
+            shrink_polling_time(ctx, adj_block_ns);
+         }
+     }
+ }
+
 bool aio_poll(AioContext *ctx, bool blocking)
 {
     AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
@@ -722,6 +771,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     aio_free_deleted_handlers(ctx);
 
+    if (ctx->poll_max_ns) {
+        adjust_block_ns(ctx, block_ns);
+    }
+
     qemu_lockcnt_dec(&ctx->list_lock);
 
     progress |= timerlistgroup_run_timers(&ctx->tlg);
@@ -783,6 +836,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
 
     qemu_lockcnt_inc(&ctx->list_lock);
     QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+        node->poll.has_event = false;
         node->poll.ns = 0;
     }
     qemu_lockcnt_dec(&ctx->list_lock);
@@ -793,6 +847,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
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
2.50.1


