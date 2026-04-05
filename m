Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8818DE9D816
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 20:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9TlB-0005gZ-UZ; Sun, 05 Apr 2026 16:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl9-0005fN-NB; Sun, 05 Apr 2026 16:07:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl7-000370-8Z; Sun, 05 Apr 2026 16:07:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635DcAkL2751733; Sun, 5 Apr 2026 20:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=x+ig7IiReeCq9m5VX
 rH4NZ6kCaebUCZTUKKG8vtQka0=; b=Gwer1odkIABBi2iVetSADnxqBRtPbBHPj
 +RnUc4EFkoCnUKP7TbcKdzgZMdLV2BBPUL2EW35WTEn7p9PAyeyb5WMJWo+e/1rG
 5S6a9c5Fjv0GuMgS1xKKJT7nMY1nlUmVQKiKFgBMEa0kOzjae3Z3LNADZNprdbd6
 lv4wbkHkAvpH2GMml+aEmAjbZYLO5vcnRJH/q+I5ZbToNAaXmT4yLcMg5i6O77UY
 UEQCgIHHL/ya+q7erwGNbA2HaJOcU2y/XQptVPEmJbW8imOC+cNSne1Iwlx4dwf5
 gyiRjYn+5MRz3igf1QjL9Tyh2kkxGpZojpLkQaAtAXjBoZ3dJSnXw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap46yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635Ge66E022883;
 Sun, 5 Apr 2026 20:07:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbefka768-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:43 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 635K7gYr31064684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 5 Apr 2026 20:07:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66DB858051;
 Sun,  5 Apr 2026 20:07:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13D105805C;
 Sun,  5 Apr 2026 20:07:42 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.243.136])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  5 Apr 2026 20:07:42 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v3 3/3] qapi/iothread: introduce poll-weight parameter for
 aio-poll
Date: Sun,  5 Apr 2026 15:07:34 -0500
Message-ID: <20260405200735.3075407-4-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405200735.3075407-1-jhkim@linux.ibm.com>
References: <20260405200735.3075407-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d2c111 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=A1X0JdhQAAAA:8
 a=lBH6PFgD_fRyFddJ3aEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIwNiBTYWx0ZWRfXwmY8OISVFm1A
 VD0dKffjguw2Ea9xDi79Ypel3tgev9urfPtfYGhRQq6pEWDyA8diC6rza3JshMg2NiZbAu4KOCn
 sASvHlfJquc7DTdfO54F0P+TRiIqdAaiJLRyqnsf6CmPE1K9HjPl9lexkAdLhY9r/ngDNm3hP4G
 SYc2RiGbGHdf/hhnEZ6t32W/MH1J76AyiA4yUP3yBmGeJ5BidqvJNmYP5rsZYJ7vrtpmuci6LT/
 zmRY7VlFGcVGyROCtwenQKOLhZLDBFjf5YK8J4k8aSzsN0Ybj7z24tuxDGOJm8aaZs7EZXTcVp9
 VmVdsyJf3iVCGkW4vYr+1QkMSpBPPNF588mGgGZ5IEgN/jNSqqKEfUFd4d/ymzQY4lX35KUI1E6
 iVgCYWPah4pKELaGH05NPlme/PdbHwE/kYgOr5H7eqxL6Y+RyINf+1+R7cCmAk3sviaEdF6k77r
 zs37lHfa6zrpblHFF5g==
X-Proofpoint-GUID: lQ0MFx7p4-_iFxc_MV2G0RpBim_BNyB8
X-Proofpoint-ORIG-GUID: lQ0MFx7p4-_iFxc_MV2G0RpBim_BNyB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/aio.h                |  4 ++-
 include/system/iothread.h         | 18 ++++++++++++
 iothread.c                        | 47 ++++++++++++++++++++++---------
 monitor/hmp-cmds.c                |  1 +
 qapi/misc.json                    |  7 +++++
 qapi/qom.json                     | 10 ++++++-
 qemu-options.hx                   |  7 ++++-
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
index 28c641fe2f..554b0c5717 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -85,6 +85,12 @@
 # @poll-shrink: how many ns will be removed from polling time, 0 means
 #     that it's not configured (since 2.9)
 #
+# @poll-weight: the weight factor for adaptive polling.
+#     Determines how much the current event interval contributes to
+#     the next polling time calculation.  Valid values are 1 or
+#     greater.  0 selects the system default value which is currently
+#     3 (since 11.1)
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
2.43.0


