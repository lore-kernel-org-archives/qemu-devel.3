Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3AAF4611B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fkn-0004Ur-6z; Mon, 23 Mar 2026 09:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkY-0004K1-0u; Mon, 23 Mar 2026 09:55:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkV-0006RM-At; Mon, 23 Mar 2026 09:55:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MMLd62832984; Mon, 23 Mar 2026 13:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lcbnpfBJVTyJcVuns
 TyLxArvfPrWZVsAm5mqRKTbaow=; b=d+RCfqOoiQrS4N7/P+DTA3R8tkw5X6M9q
 jbr3Lxp4nY4OWVOvNYFhFI4E+7lln2hloBvmkd/YGSyRSu9Xb+IJxIW/FUwazpy6
 6BPxCIAFqak1HC8u1a9pKj0LVBUGAm9mUXUSF1PRxCEMYw4Jf3J8zuGg2imqtu7K
 MrhlQzwxJmIXVmW8tK8uK2oeNvYlHkxShRHa1qWfloj8smJUKt2jnl1iveYgv5F+
 vhx3VgQlxHQeNPplSdCtz/boQL2ejwuNWaTnNP+syR/ZJ9mBpFHUW80w38iT+4fv
 9B/TEfR92BOgURMoBqBcWtpyPMQPwEQ4ALg6MGVUH3B6Tu4qQZGNQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq73wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NDXAMf004375;
 Mon, 23 Mar 2026 13:55:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1wak3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:12 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NDtASB61931892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 13:55:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D7CC58063;
 Mon, 23 Mar 2026 13:55:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B934A58059;
 Mon, 23 Mar 2026 13:55:09 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.54])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 13:55:09 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, armbru@redhat.com,
 eblake@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 dave@treblig.org, sw@weilnetz.de, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight parameter for
 aio-poll
Date: Mon, 23 Mar 2026 08:54:51 -0500
Message-ID: <20260323135451.579655-4-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135451.579655-1-jhkim@linux.ibm.com>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TIIRIPUfpMeU2mxIgVBh32h9tJMZCKj_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwNyBTYWx0ZWRfX18qkWnb1byd+
 mgySBvFMbh2i+godQSArL9LSlqsS67bdMNzBpinKCe5gd9QGcdITA2QnKI9dQW2WaGIoZMCYiT1
 fywuLKERKNj7F4Pf6XNfoCGRi91PShF0/33wlBFvQnzquFPy60c1Dq33DTdkMtaApJuABR/JVYb
 qh0hwotd7wTMLmLjYKtVdCD+rlN3EAaDVUwChjN43NJZnaoET2HAV0Zr/ZvOU765yCG+jLR+0OG
 CTkLRAu5xRpzceW4UR6jXasaIZ/HanY5A3J2+rBF5JAw5MVCE39YqbAv/YRizVt+3vpFdRnUHng
 ga03f4Pz0mxP9+B3W/4Vm4z9onYvo2NVxlHedN2i2Z2keyY/tr4eaAclROD5o2PKnW5e7trA1ah
 LuOS4Bz+nzpAL6Im2bcJYpX7CsRG1vwbB8w1Om1UN3N/bK6O1FEHMPuikTx1l8RIg4CLDveMGqL
 sPxivkceqO3bDY2bdDw==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c14641 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=A1X0JdhQAAAA:8
 a=4gC5F_T_yQe02bOqTGwA:9
X-Proofpoint-GUID: TIIRIPUfpMeU2mxIgVBh32h9tJMZCKj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230107
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

Introduce a configurable poll-weight parameter for adaptive polling
in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
constant, allowing runtime control over how much the most recent
event interval affects the next polling duration calculation.

The poll-weight parameter uses a shift value where larger values
decrease the weight of the current interval, enabling more gradual
adjustments. When set to 0, a default value of 3 is used (meaning
the current interval contributes approximately 1/8 to the weighted
average).

This patch also removes the hardcoded default values for poll-grow
and poll-shrink parameters from the grow_polling_time() and
shrink_polling_time() functions, as these defaults are now properly
initialized in iothread.c during IOThread creation.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 include/qemu/aio.h                |  4 +++-
 include/system/iothread.h         |  1 +
 iothread.c                        | 34 ++++++++++++++++++++++++++++++-
 monitor/hmp-cmds.c                |  1 +
 qapi/misc.json                    |  7 +++++++
 qapi/qom.json                     |  8 +++++++-
 qemu-options.hx                   |  7 ++++++-
 tests/unit/test-nested-aio-poll.c |  2 +-
 util/aio-posix.c                  | 17 +++++-----------
 util/aio-win32.c                  |  3 ++-
 util/async.c                      |  1 +
 11 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index 6c77a190e9..50b8db2712 100644
--- a/include/qemu/aio.h
+++ b/include/qemu/aio.h
@@ -311,6 +311,7 @@ struct AioContext {
     int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
     int64_t poll_grow;      /* polling time growth factor */
     int64_t poll_shrink;    /* polling time shrink factor */
+    int64_t poll_weight;    /* weight of current interval in calculation */
 
     /* AIO engine parameters */
     int64_t aio_max_batch;  /* maximum number of requests in a batch */
@@ -792,12 +793,13 @@ void aio_context_destroy(AioContext *ctx);
  * @max_ns: how long to busy poll for, in nanoseconds
  * @grow: polling time growth factor
  * @shrink: polling time shrink factor
+ * @weight: weight factor applied to the current polling interval
  *
  * Poll mode can be disabled by setting poll_max_ns to 0.
  */
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink,
-                                 Error **errp);
+                                 int64_t weight, Error **errp);
 
 /**
  * aio_context_set_aio_params:
diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..6ea57ed126 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -38,6 +38,7 @@ struct IOThread {
     int64_t poll_max_ns;
     int64_t poll_grow;
     int64_t poll_shrink;
+    int64_t poll_weight;
 };
 typedef struct IOThread IOThread;
 
diff --git a/iothread.c b/iothread.c
index caf68e0764..0389b8f7a8 100644
--- a/iothread.c
+++ b/iothread.c
@@ -32,8 +32,14 @@
  * workloads.
  */
 #define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
+#define IOTHREAD_POLL_GROW_DEFAULT 2ULL
+#define IOTHREAD_POLL_SHRINK_DEFAULT 2ULL
+#define IOTHREAD_POLL_WEIGHT_DEFAULT 3ULL
 #else
 #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
+#define IOTHREAD_POLL_GROW_DEFAULT 0ULL
+#define IOTHREAD_POLL_SHRINK_DEFAULT 0ULL
+#define IOTHREAD_POLL_WEIGHT_DEFAULT 0ULL
 #endif
 
 static void *iothread_run(void *opaque)
@@ -103,6 +109,10 @@ static void iothread_instance_init(Object *obj)
     IOThread *iothread = IOTHREAD(obj);
 
     iothread->poll_max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
+    iothread->poll_grow = IOTHREAD_POLL_GROW_DEFAULT;
+    iothread->poll_shrink = IOTHREAD_POLL_SHRINK_DEFAULT;
+    iothread->poll_weight = IOTHREAD_POLL_WEIGHT_DEFAULT;
+
     iothread->thread_id = -1;
     qemu_sem_init(&iothread->init_done_sem, 0);
     /* By default, we don't run gcontext */
@@ -164,6 +174,7 @@ static void iothread_set_aio_context_params(EventLoopBase *base, Error **errp)
                                 iothread->poll_max_ns,
                                 iothread->poll_grow,
                                 iothread->poll_shrink,
+                                iothread->poll_weight,
                                 errp);
     if (*errp) {
         return;
@@ -233,6 +244,9 @@ static IOThreadParamInfo poll_grow_info = {
 static IOThreadParamInfo poll_shrink_info = {
     "poll-shrink", offsetof(IOThread, poll_shrink),
 };
+static IOThreadParamInfo poll_weight_info = {
+    "poll-weight", offsetof(IOThread, poll_weight),
+};
 
 static void iothread_get_param(Object *obj, Visitor *v,
         const char *name, IOThreadParamInfo *info, Error **errp)
@@ -260,7 +274,19 @@ static bool iothread_set_param(Object *obj, Visitor *v,
         return false;
     }
 
-    *field = value;
+    if (value == 0) {
+        if (info->offset == offsetof(IOThread, poll_grow)) {
+            *field = IOTHREAD_POLL_GROW_DEFAULT;
+        } else if (info->offset == offsetof(IOThread, poll_shrink)) {
+            *field = IOTHREAD_POLL_SHRINK_DEFAULT;
+        } else if (info->offset == offsetof(IOThread, poll_weight)) {
+            *field = IOTHREAD_POLL_WEIGHT_DEFAULT;
+        } else {
+            *field = value;
+        }
+    } else {
+        *field = value;
+    }
 
     return true;
 }
@@ -288,6 +314,7 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
                                     iothread->poll_max_ns,
                                     iothread->poll_grow,
                                     iothread->poll_shrink,
+                                    iothread->poll_weight,
                                     errp);
     }
 }
@@ -311,6 +338,10 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
+    object_class_property_add(klass, "poll-weight", "int",
+                              iothread_get_poll_param,
+                              iothread_set_poll_param,
+                              NULL, &poll_weight_info);
 }
 
 static const TypeInfo iothread_info = {
@@ -356,6 +387,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
+    info->poll_weight = iothread->poll_weight;
     info->aio_max_batch = iothread->parent_obj.aio_max_batch;
 
     QAPI_LIST_APPEND(*tail, info);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bad034937a..75b6e7fa65 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -206,6 +206,7 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
+        monitor_printf(mon, "  poll-weight=%" PRId64 "\n", value->poll_weight);
         monitor_printf(mon, "  aio-max-batch=%" PRId64 "\n",
                        value->aio_max_batch);
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..39d17010bc 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -85,6 +85,12 @@
 # @poll-shrink: how many ns will be removed from polling time, 0 means
 #     that it's not configured (since 2.9)
 #
+# @poll-weight: the weight factor for adaptive polling.
+#     Determines how much the current event interval contributes to
+#     the next polling time calculation.  Valid values are 1 or
+#     greater.  0 selects the system default value which is current 3
+#     (since 10.2)
+#
 # @aio-max-batch: maximum number of requests in a batch for the AIO
 #     engine, 0 means that the engine will use its default (since 6.1)
 #
@@ -96,6 +102,7 @@
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
+           'poll-weight': 'int',
            'aio-max-batch': 'int' } }
 
 ##
diff --git a/qapi/qom.json b/qapi/qom.json
index c653248f85..feb80b6cfe 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -606,6 +606,11 @@
 #     algorithm detects it is spending too long polling without
 #     encountering events.  0 selects a default behaviour (default: 0)
 #
+# @poll-weight: the weight factor for adaptive polling.
+#     Determines how much the current event interval contributes to
+#     the next polling time calculation.  Valid values are 1 or
+#     greater.  If set to 0, the default value of 3 is used.
+#
 # The @aio-max-batch option is available since 6.1.
 #
 # Since: 2.0
@@ -614,7 +619,8 @@
   'base': 'EventLoopBaseProperties',
   'data': { '*poll-max-ns': 'int',
             '*poll-grow': 'int',
-            '*poll-shrink': 'int' } }
+            '*poll-shrink': 'int',
+            '*poll-weight': 'int' } }
 
 ##
 # @MainLoopProperties:
diff --git a/qemu-options.hx b/qemu-options.hx
index 69e5a874c1..8ddf6c8d36 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6413,7 +6413,7 @@ SRST
 
             CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
 
-    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
+    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,poll-weight=poll-weight,aio-max-batch=aio-max-batch``
         Creates a dedicated event loop thread that devices can be
         assigned to. This is known as an IOThread. By default device
         emulation happens in vCPU threads or the main event loop thread.
@@ -6449,6 +6449,11 @@ SRST
         the polling time when the algorithm detects it is spending too
         long polling without encountering events.
 
+        The ``poll-weight`` parameter is the weight factor used in the
+        adaptive polling algorithm. It determines how much the most
+        recent event interval affects the calculation of the next
+        polling duration.
+
         The ``aio-max-batch`` parameter is the maximum number of requests
         in a batch for the AIO engine, 0 means that the engine will use
         its default.
diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index 9ab1ad08a7..4c38f36fd4 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -81,7 +81,7 @@ static void test(void)
     qemu_set_current_aio_context(td.ctx);
 
     /* Enable polling */
-    aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
+    aio_context_set_poll_params(td.ctx, 1000000, 2, 2, 3, &error_abort);
 
     /* Make the event notifier active (set) right away */
     event_notifier_init(&td.poll_notifier, 1);
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2b3522f2f9..13b7f94911 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -29,7 +29,6 @@
 
 /* Stop userspace polling on a handler if it isn't active for some time */
 #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
-#define POLL_WEIGHT_SHIFT   (3)
 
 static void adjust_block_ns(AioContext *ctx, int64_t block_ns);
 static void grow_polling_time(AioContext *ctx, int64_t block_ns);
@@ -593,10 +592,6 @@ static void shrink_polling_time(AioContext *ctx, int64_t block_ns)
     int64_t old = ctx->poll_ns;
     int64_t shrink = ctx->poll_shrink;
 
-    if (shrink == 0) {
-        shrink = 2;
-    }
-
     if (block_ns < (ctx->poll_ns / shrink)) {
         ctx->poll_ns /= shrink;
     }
@@ -610,10 +605,6 @@ static void grow_polling_time(AioContext *ctx, int64_t block_ns)
     int64_t old = ctx->poll_ns;
     int64_t grow = ctx->poll_grow;
 
-    if (grow == 0) {
-        grow = 2;
-    }
-
     if (block_ns > ctx->poll_ns * grow) {
         ctx->poll_ns = block_ns;
     } else {
@@ -640,8 +631,8 @@ static void adjust_block_ns(AioContext *ctx, int64_t block_ns)
              * poll.ns to smooth out polling time adjustments.
              */
             node->poll.ns = node->poll.ns
-                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
-                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
+                ? (node->poll.ns - (node->poll.ns >> ctx->poll_weight))
+                + (block_ns >> ctx->poll_weight) : block_ns;
 
             if (node->poll.ns > ctx->poll_max_ns) {
                 node->poll.ns = 0;
@@ -831,7 +822,8 @@ void aio_context_destroy(AioContext *ctx)
 }
 
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
-                                 int64_t grow, int64_t shrink, Error **errp)
+                                 int64_t grow, int64_t shrink,
+                                 int64_t weight, Error **errp)
 {
     AioHandler *node;
 
@@ -848,6 +840,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
     ctx->poll_max_ns = max_ns;
     ctx->poll_grow = grow;
     ctx->poll_shrink = shrink;
+    ctx->poll_weight = weight;
     ctx->poll_ns = 0;
 
     aio_notify(ctx);
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 6e6f699e4b..1985843233 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -429,7 +429,8 @@ void aio_context_destroy(AioContext *ctx)
 }
 
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
-                                 int64_t grow, int64_t shrink, Error **errp)
+                                 int64_t grow, int64_t shrink,
+                                 int64_t weight, Error **errp)
 {
     if (max_ns) {
         error_setg(errp, "AioContext polling is not implemented on Windows");
diff --git a/util/async.c b/util/async.c
index 9d3627566f..741fcfd6a7 100644
--- a/util/async.c
+++ b/util/async.c
@@ -609,6 +609,7 @@ AioContext *aio_context_new(Error **errp)
     ctx->poll_ns = 0;
     ctx->poll_grow = 0;
     ctx->poll_shrink = 0;
+    ctx->poll_weight = 0;
 
     ctx->aio_max_batch = 0;
 
-- 
2.50.1


