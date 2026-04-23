Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76727FDEE47
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG0D1-0001QZ-4w; Thu, 23 Apr 2026 15:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wG0Cy-0001P8-NJ; Thu, 23 Apr 2026 15:59:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wG0Cw-0003Kg-Bp; Thu, 23 Apr 2026 15:59:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIrsnV3657859; Thu, 23 Apr 2026 19:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7E8iut2b3IrTPbT3O
 q/NIhki47ihpJha5zB64R30CIg=; b=nTRtU7gs6NX8CF50aGQtMjXtG8k4P4TFt
 1xoKXUqZfzcpAtLytMTEUWYIiiR6RnKMlJmstpGykFvUxQfGG05ruWTxMvu5XAwA
 V2DzTPQdbD2zO4cN//ecVc3+eowviQ4dK1Z3pSrnvRnuJFD4WztR9oGtCAxZuND3
 1A6SSUzuwm6MhXCfdilq94+MTGzfrSMOqpbVn/w1RrOu4+LTrztedt2Z5rIQyCiw
 ZyDskLUZ88DEAr8/F5fNHBVwQo0zMR6zhpOStLh1l6JIbTbBOBlyvPHoA2/J1tAv
 ZJjr1Bx6ppfNPgrCV1GeWHlch9Ma0mstJM2N9AH+JQzI3uZBiXhsQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7sy20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 19:59:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NJoTOL019220;
 Thu, 23 Apr 2026 19:59:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky83sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 19:59:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NJxQkm29229810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 19:59:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C49E5805E;
 Thu, 23 Apr 2026 19:59:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2F3758056;
 Thu, 23 Apr 2026 19:59:25 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.254.253])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 19:59:25 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v5 3/3] qapi/iothread: introduce poll-weight parameter for
 aio-poll
Date: Thu, 23 Apr 2026 14:59:18 -0500
Message-ID: <20260423195918.661299-4-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423195918.661299-1-jhkim@linux.ibm.com>
References: <20260423195918.661299-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MzHHkHICqcyzwgGV5wZDkXQNv4ZRQC93
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ea7a1f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=A1X0JdhQAAAA:8
 a=lBH6PFgD_fRyFddJ3aEA:9
X-Proofpoint-GUID: MzHHkHICqcyzwgGV5wZDkXQNv4ZRQC93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE5MyBTYWx0ZWRfX7E1ztxCM9fm6
 rO4ggD/3sbdjUvMLG1a5dP614Rs8YREqA3k6d76gRTgSra+n5sSWyceNVvO5vuKCZlvWZJpt8MG
 /rPw0Aw2ddYjzr6vE75L0XoxEOHePSmKLUsuKmFP3zOT6tn1iO9qdYKe5EJMU8pNBvB7x+0F4Ky
 EO5OvhYeizeRFH+mq+ZJX7fGpf/nMySEHkJ+DLZKkrUnMfQGXkM5qOmKxriwFXcrLt9rCxiaC+V
 0mpiDuPh3scYK48LanURJ/LyK+mL7LZ/W3mMG+GVAA+dNU88K/8AvaQZZXslmfkwYnymubwMgyf
 wytcCT+K6y6zVjfvDQHbOJySOabvbxmeNtX2u+5+1KneL+7GRbAFXjeNaZja5xU+jLeDKU9Rpxv
 OvFyw4K227jAXqZTKG63Ncc8dh9088x/JAYuBhwKKkrRlCXx2nhhsvItRSh3IF5bjqLPutIpmQ6
 nWQBo+MI172sAyVMTUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230193
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch also removes the hardcoded default value checks from
adjust_polling_time(). Instead, poll-grow, poll-shrink, and
poll-weight now use default values initialized in iothread.c
during IOThread creation.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/aio.h                |  4 ++-
 include/system/iothread.h         | 18 ++++++++++++
 iothread.c                        | 47 ++++++++++++++++++++++---------
 monitor/hmp-cmds.c                |  1 +
 qapi/misc.json                    |  6 ++++
 qapi/qom.json                     | 10 ++++++-
 qemu-options.hx                   |  8 +++++-
 tests/unit/test-nested-aio-poll.c |  2 +-
 util/aio-posix.c                  | 37 +++++++++---------------
 util/aio-win32.c                  |  3 +-
 util/async.c                      |  1 +
 11 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index 6c22064a28..e65e90093a 100644
--- a/include/qemu/aio.h
+++ b/include/qemu/aio.h
@@ -310,6 +310,7 @@ struct AioContext {
     int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
     int64_t poll_grow;      /* polling time growth factor */
     int64_t poll_shrink;    /* polling time shrink factor */
+    int64_t poll_weight;    /* weight of current interval in calculation */
 
     /* AIO engine parameters */
     int64_t aio_max_batch;  /* maximum number of requests in a batch */
@@ -791,12 +792,13 @@ void aio_context_destroy(AioContext *ctx);
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
index e26d13c6c7..a1ef7696cb 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -21,6 +21,23 @@
 
 #define TYPE_IOTHREAD "iothread"
 
+#ifdef CONFIG_POSIX
+/*
+ * Benchmark results from 2016 on NVMe SSD drives show max polling times around
+ * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
+ * workloads.
+ */
+#define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
+#define IOTHREAD_POLL_GROW_DEFAULT 2ULL
+#define IOTHREAD_POLL_SHRINK_DEFAULT 2ULL
+#define IOTHREAD_POLL_WEIGHT_DEFAULT 3ULL
+#else
+#define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
+#define IOTHREAD_POLL_GROW_DEFAULT 0ULL
+#define IOTHREAD_POLL_SHRINK_DEFAULT 0ULL
+#define IOTHREAD_POLL_WEIGHT_DEFAULT 0ULL
+#endif
+
 struct IOThread {
     EventLoopBase parent_obj;
 
@@ -38,6 +55,7 @@ struct IOThread {
     int64_t poll_max_ns;
     int64_t poll_grow;
     int64_t poll_shrink;
+    int64_t poll_weight;
 };
 typedef struct IOThread IOThread;
 
diff --git a/iothread.c b/iothread.c
index caf68e0764..3558535b40 100644
--- a/iothread.c
+++ b/iothread.c
@@ -25,17 +25,6 @@
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
 
-
-#ifdef CONFIG_POSIX
-/* Benchmark results from 2016 on NVMe SSD drives show max polling times around
- * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
- * workloads.
- */
-#define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
-#else
-#define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
-#endif
-
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -103,6 +92,10 @@ static void iothread_instance_init(Object *obj)
     IOThread *iothread = IOTHREAD(obj);
 
     iothread->poll_max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
+    iothread->poll_grow = IOTHREAD_POLL_GROW_DEFAULT;
+    iothread->poll_shrink = IOTHREAD_POLL_SHRINK_DEFAULT;
+    iothread->poll_weight = IOTHREAD_POLL_WEIGHT_DEFAULT;
+
     iothread->thread_id = -1;
     qemu_sem_init(&iothread->init_done_sem, 0);
     /* By default, we don't run gcontext */
@@ -164,6 +157,7 @@ static void iothread_set_aio_context_params(EventLoopBase *base, Error **errp)
                                 iothread->poll_max_ns,
                                 iothread->poll_grow,
                                 iothread->poll_shrink,
+                                iothread->poll_weight,
                                 errp);
     if (*errp) {
         return;
@@ -233,6 +227,9 @@ static IOThreadParamInfo poll_grow_info = {
 static IOThreadParamInfo poll_shrink_info = {
     "poll-shrink", offsetof(IOThread, poll_shrink),
 };
+static IOThreadParamInfo poll_weight_info = {
+    "poll-weight", offsetof(IOThread, poll_weight),
+};
 
 static void iothread_get_param(Object *obj, Visitor *v,
         const char *name, IOThreadParamInfo *info, Error **errp)
@@ -254,13 +251,31 @@ static bool iothread_set_param(Object *obj, Visitor *v,
         return false;
     }
 
-    if (value < 0) {
+    if (info->offset == offsetof(IOThread, poll_weight)) {
+        if (value < 0 || value > 63) {
+            error_setg(errp, "%s value must be in range [0, 63]",
+                       info->name);
+            return false;
+        }
+    } else if (value < 0) {
         error_setg(errp, "%s value must be in range [0, %" PRId64 "]",
                    info->name, INT64_MAX);
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
@@ -288,6 +303,7 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
                                     iothread->poll_max_ns,
                                     iothread->poll_grow,
                                     iothread->poll_shrink,
+                                    iothread->poll_weight,
                                     errp);
     }
 }
@@ -311,6 +327,10 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
+    object_class_property_add(klass, "poll-weight", "int",
+                              iothread_get_poll_param,
+                              iothread_set_poll_param,
+                              NULL, &poll_weight_info);
 }
 
 static const TypeInfo iothread_info = {
@@ -356,6 +376,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
+    info->poll_weight = iothread->poll_weight;
     info->aio_max_batch = iothread->parent_obj.aio_max_batch;
 
     QAPI_LIST_APPEND(*tail, info);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bc26b39d70..afa7b709a6 100644
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
index 28c641fe2f..22b7afed9f 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -85,6 +85,11 @@
 # @poll-shrink: how many ns will be removed from polling time, 0 means
 #     that it's not configured (since 2.9)
 #
+# @poll-weight: the weight factor for adaptive polling.
+#     Determines how much the current event interval contributes to
+#     the next polling time calculation.  Valid values are 1 or
+#     greater (since 11.1)
+#
 # @aio-max-batch: maximum number of requests in a batch for the AIO
 #     engine, 0 means that the engine will use its default (since 6.1)
 #
@@ -96,6 +101,7 @@
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
+           'poll-weight': 'int',
            'aio-max-batch': 'int' } }
 
 ##
diff --git a/qapi/qom.json b/qapi/qom.json
index c653248f85..dd45ac1087 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -606,6 +606,13 @@
 #     algorithm detects it is spending too long polling without
 #     encountering events.  0 selects a default behaviour (default: 0)
 #
+# @poll-weight: the weight factor for adaptive polling.  Determines
+#     how much the most recent event interval affects the next
+#     polling duration calculation.  If set to 0, the system default
+#     value of 3 is used.  Typical values: 1 (high weight on recent
+#     interval), 2-4 (moderate weight on recent interval).
+#     (default: 0) (since 11.1)
+#
 # The @aio-max-batch option is available since 6.1.
 #
 # Since: 2.0
@@ -614,7 +621,8 @@
   'base': 'EventLoopBaseProperties',
   'data': { '*poll-max-ns': 'int',
             '*poll-grow': 'int',
-            '*poll-shrink': 'int' } }
+            '*poll-shrink': 'int',
+            '*poll-weight': 'int' } }
 
 ##
 # @MainLoopProperties:
diff --git a/qemu-options.hx b/qemu-options.hx
index 21972f8326..29c09415c1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6443,7 +6443,7 @@ SRST
 
             CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
 
-    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
+    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,poll-weight=poll-weight,aio-max-batch=aio-max-batch``
         Creates a dedicated event loop thread that devices can be
         assigned to. This is known as an IOThread. By default device
         emulation happens in vCPU threads or the main event loop thread.
@@ -6479,6 +6479,12 @@ SRST
         the polling time when the algorithm detects it is spending too
         long polling without encountering events.
 
+        The ``poll-weight`` parameter is the weight factor for adaptive
+        polling. It determines how much the most recent event interval
+        affects the next polling duration calculation. If set to 0, the
+        system default value of 3 is used. Typical values: 1 (high weight
+        on recent interval), 2-4 (moderate weight on recent interval).
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
index 8e9e9e5d8f..df1c213ce5 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -29,7 +29,6 @@
 
 /* Stop userspace polling on a handler if it isn't active for some time */
 #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
-#define POLL_WEIGHT_SHIFT   (3)
 
 static void update_handler_poll_times(AioContext *ctx, int64_t block_ns,
                                       int64_t dispatch_time);
@@ -582,28 +581,11 @@ static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
 
 static void adjust_polling_time(AioContext *ctx, int64_t block_ns)
 {
-    if (block_ns < ctx->poll_ns) {
-        int64_t old = ctx->poll_ns;
-        int64_t shrink = ctx->poll_shrink;
-
-        if (shrink == 0) {
-            shrink = 2;
-        }
-
-        if (block_ns < (ctx->poll_ns / shrink)) {
-            ctx->poll_ns /= shrink;
-        }
-
-        trace_poll_shrink(ctx, old, ctx->poll_ns);
-    } else if (block_ns > ctx->poll_ns) {
+    if (block_ns > ctx->poll_ns) {
         /* There is room to grow, poll longer */
         int64_t old = ctx->poll_ns;
         int64_t grow = ctx->poll_grow;
 
-        if (grow == 0) {
-            grow = 2;
-        }
-
         if (block_ns > ctx->poll_ns * grow) {
             ctx->poll_ns = block_ns;
         } else {
@@ -615,6 +597,11 @@ static void adjust_polling_time(AioContext *ctx, int64_t block_ns)
         }
 
         trace_poll_grow(ctx, old, ctx->poll_ns);
+    } else if (block_ns < (ctx->poll_ns / ctx->poll_shrink)) {
+        int64_t old = ctx->poll_ns;
+        ctx->poll_ns /= ctx->poll_shrink;
+
+        trace_poll_shrink(ctx, old, ctx->poll_ns);
     }
 }
 
@@ -632,8 +619,8 @@ static void update_handler_poll_times(AioContext *ctx, int64_t block_ns,
              * block_ns and previous poll.ns to smooth adjustments.
              */
             node->poll.ns = node->poll.ns
-                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
-                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
+                ? (node->poll.ns - (node->poll.ns >> ctx->poll_weight))
+                + (block_ns >> ctx->poll_weight) : block_ns;
 
             if (node->poll.ns > ctx->poll_max_ns) {
                 node->poll.ns = 0;
@@ -819,7 +806,8 @@ void aio_context_destroy(AioContext *ctx)
 }
 
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
-                                 int64_t grow, int64_t shrink, Error **errp)
+                                 int64_t grow, int64_t shrink,
+                                 int64_t weight, Error **errp)
 {
     AioHandler *node;
 
@@ -833,8 +821,9 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
      * is used once.
      */
     ctx->poll_max_ns = max_ns;
-    ctx->poll_grow = grow;
-    ctx->poll_shrink = shrink;
+    ctx->poll_grow = (grow ? grow : IOTHREAD_POLL_GROW_DEFAULT);
+    ctx->poll_shrink = (shrink ? shrink : IOTHREAD_POLL_SHRINK_DEFAULT);
+    ctx->poll_weight = (weight ? weight : IOTHREAD_POLL_WEIGHT_DEFAULT);
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


