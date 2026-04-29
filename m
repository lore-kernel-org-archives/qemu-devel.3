Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7E2FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9Yn-0003Ef-Vu; Wed, 29 Apr 2026 14:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9Xq-0002fI-K1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9Xk-0003it-EE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777486910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bUrkCrR0eARoen5Ol8TqCgzEV95zBAPnbtOs4MP4uU=;
 b=ScOeHD+OXB1PxKHwB9qZ0dU/vVaiTXuu1aXGgpgpz9GdoxwZ3o/RRICDOfAlZhtp6raOFI
 Bd+7wKeCCwmg0fkd7TLiWhqOOl8Mlkz/DaB09OY4DtqmbEx/+jozqqNlDRkVIjO4t8amBe
 YjC/GIf+DTTQpP/3ipPFv3Ghi3Uh+3o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-HG82EkBBPvOMBAp2a3Vcmw-1; Wed,
 29 Apr 2026 14:21:46 -0400
X-MC-Unique: HG82EkBBPvOMBAp2a3Vcmw-1
X-Mimecast-MFC-AGG-ID: HG82EkBBPvOMBAp2a3Vcmw_1777486905
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28CF01800579; Wed, 29 Apr 2026 18:21:45 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8A5D19560AB; Wed, 29 Apr 2026 18:21:43 +0000 (UTC)
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
Subject: [PULL 3/3] qapi/iothread: introduce poll-weight parameter for aio-poll
Date: Wed, 29 Apr 2026 14:21:27 -0400
Message-ID: <20260429182127.219776-4-stefanha@redhat.com>
In-Reply-To: <20260429182127.219776-1-stefanha@redhat.com>
References: <20260429182127.219776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260423195918.661299-4-jhkim@linux.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/misc.json                    |  6 ++++
 qapi/qom.json                     | 10 ++++++-
 include/qemu/aio.h                |  4 ++-
 include/system/iothread.h         | 18 ++++++++++++
 iothread.c                        | 47 ++++++++++++++++++++++---------
 monitor/hmp-cmds.c                |  1 +
 tests/unit/test-nested-aio-poll.c |  2 +-
 util/aio-posix.c                  | 37 +++++++++---------------
 util/aio-win32.c                  |  3 +-
 util/async.c                      |  1 +
 qemu-options.hx                   |  8 +++++-
 11 files changed, 95 insertions(+), 42 deletions(-)

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
-- 
2.54.0


