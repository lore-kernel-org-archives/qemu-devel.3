Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C89EF46119
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fkm-0004T1-J2; Mon, 23 Mar 2026 09:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkW-0004JB-PK; Mon, 23 Mar 2026 09:55:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkU-0006RD-D7; Mon, 23 Mar 2026 09:55:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NAVvvJ3744362; Mon, 23 Mar 2026 13:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cAk4sgZufdpjvnpR4
 8ebECgNeceQtYvYmskYqF/jHKc=; b=ntJd6VgWw9p4yKBn4MeLOZwf2stQLj68E
 r9cDRGSn+FtLaUfecfbxi+eaZJG1aYE72WS0uGaMLIeVoWUo4Y2FA6jHx0lG53is
 Vb3QKn3lpJhQU3Eln1CRP+aFbw2PCEUvvfcrhbv5/UQPWnB6bkS2uErDtOnF8Rfn
 cCCiiqS+nO2/U+ZQrct/qIDjF0Tk1ERnvOQxXQaI1dYgLZoI1QJYcU59zpfW57tx
 MPIPVP8tU7lz/5qxS9tXex1hWz8kpzvbLObj1rpAAMfGQRFtv1apyZKt5A2v6VDf
 q2xZGCwBXK1bdBkXVnGwIz6YeQtFfd03BPrjcHqgDybMVJOZGFHEA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9q3ty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NDbPVm004369;
 Mon, 23 Mar 2026 13:55:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1wak2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NDt8Ow13632216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 13:55:08 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A561D58063;
 Mon, 23 Mar 2026 13:55:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC64F58055;
 Mon, 23 Mar 2026 13:55:07 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.54])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 13:55:07 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, armbru@redhat.com,
 eblake@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 dave@treblig.org, sw@weilnetz.de, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v2 2/3] aio-poll: refine iothread polling using weighted
 handler intervals
Date: Mon, 23 Mar 2026 08:54:50 -0500
Message-ID: <20260323135451.579655-3-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135451.579655-1-jhkim@linux.ibm.com>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LphzQBpHZyqgBXF8ZGoo2cRI5I3Ux8Ik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwNyBTYWx0ZWRfXzPRs6KtRkQmj
 PWYHiKfBXWBLKjdRZiMl33Qlfahe5eW5NsJ7R9by2KlZpmTrqqxA7c9ukSbZw0EeaBJOoOoQXUm
 RYDloIotDajsnoJ7t5fkDAEpVfvehXnHtk5C6ysU3TjcH3RNrEtUuZ9p8j3EZA5jC20EMgeJqaA
 9vrjy2K1XKNjt3w4MxKA96znp6P+HpQ+mQWVRfMXs0uf3MBDxfj0m3Sh2HmfvkfoJ2IxS+qZwYY
 MmjehE6q2YOWDOwROLjRPCuBov+h//fG+xsCyCXlx6h7aaMIt2oRovwBYlIa5VFaX+f7IIi7VNI
 2CwrN+kDS/nusiU+v8g9c0BumNE65oAKlqn8LTyMhU6OX5y/fIXZlux85G8+N9MLaY7sF31ID9D
 Rm8PL+Ajv2b7rQQ0ipEziGp0OzcfdLIonuYD4pNgyx8ehqcEwhyUuL1PKjUWfQUTKB+ftR89TT+
 zt4hvXsM5P/BORbcuIw==
X-Proofpoint-GUID: LphzQBpHZyqgBXF8ZGoo2cRI5I3Ux8Ik
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c1463f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=0fTNcCBiaAR8iZ-VC-YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230107
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

Refine adaptive polling in aio_poll by updating iothread polling
duration based on weighted AioHandler event intervals.

Each AioHandler's poll.ns is updated using a weighted factor when an
event occurs. Idle handlers accumulate block_ns until poll_max_ns and
then reset to 0, preventing sporadically active handlers from
unnecessarily prolonging iothread polling.

The iothread polling duration is set based on the largest poll.ns among
active handlers. The shrink divider defaults to 2, matching the grow
rate, to reduce frequent poll_ns resets for slow devices.

The default weight factor (POLL_WEIGHT_SHIFT=3, meaning the current
interval contributes 12.5% to the weighted average) was selected based
on extensive testing comparing QEMU 10.0.0 baseline vs poll-weight=2
and poll-weight=3 across various workloads.

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

Both weight=2 and weight=3 show significant CPU consumption reduction
(~10%) compared to baseline, which addresses the CPU utilization
regression observed in QEMU 10.0.0. The throughput impact is minimal
for both (~2%).

Weight=3 is selected as the default because it provides slightly better
throughput (-2.2% vs -2.4%) while still achieving substantial CPU
savings (-9.4%). The difference between weight=2 and weight=3 is small,
but weight=3 offers a better balance for general-purpose workloads.

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
index b02beb0505..2b3522f2f9 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -29,9 +29,11 @@
 
 /* Stop userspace polling on a handler if it isn't active for some time */
 #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
+#define POLL_WEIGHT_SHIFT   (3)
 
-static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
-                                int64_t block_ns);
+static void adjust_block_ns(AioContext *ctx, int64_t block_ns);
+static void grow_polling_time(AioContext *ctx, int64_t block_ns);
+static void shrink_polling_time(AioContext *ctx, int64_t block_ns);
 
 bool aio_poll_disabled(AioContext *ctx)
 {
@@ -373,7 +375,7 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
          * add the handler to ctx->poll_aio_handlers.
          */
         if (ctx->poll_max_ns && QLIST_IS_INSERTED(node, node_poll)) {
-            adjust_polling_time(ctx, &node->poll, block_ns);
+            node->poll.has_event = true;
         }
     }
 
@@ -560,18 +562,13 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
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
@@ -587,46 +584,98 @@ static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
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
+            if (node->poll.ns > ctx->poll_max_ns) {
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
+                if (node->poll.ns > ctx->poll_max_ns) {
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
@@ -723,6 +772,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     aio_free_deleted_handlers(ctx);
 
+    if (ctx->poll_max_ns) {
+        adjust_block_ns(ctx, block_ns);
+    }
+
     qemu_lockcnt_dec(&ctx->list_lock);
 
     progress |= timerlistgroup_run_timers(&ctx->tlg);
@@ -784,6 +837,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
 
     qemu_lockcnt_inc(&ctx->list_lock);
     QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+        node->poll.has_event = false;
         node->poll.ns = 0;
     }
     qemu_lockcnt_dec(&ctx->list_lock);
@@ -794,6 +848,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
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


