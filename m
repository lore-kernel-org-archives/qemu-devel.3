Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C087C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbJP-0006Cc-VE; Tue, 01 Apr 2025 09:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tzbIf-0005YZ-0f; Tue, 01 Apr 2025 09:05:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tzbIU-0008Bk-2o; Tue, 01 Apr 2025 09:05:02 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZRp4V1mdPz1f1dW;
 Tue,  1 Apr 2025 20:59:54 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 07A021400E8;
 Tue,  1 Apr 2025 21:04:42 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Apr
 2025 21:04:40 +0800
To: <qemu-devel@nongnu.org>
CC: <armbru@redhat.com>, <alex.chen@huawei.com>, <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <kwolf@redhat.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-stable@nongnu.org>, <renxuming@huawei.com>,
 <stefanha@redhat.com>, <suxiaodong1@huawei.com>, <wangjian161@huawei.com>,
 <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: [PATCH v4 1/3] io/block: Refactoring the bdrv_drained_begin()
 function and implement a timeout mechanism.
Date: Tue, 1 Apr 2025 21:02:58 +0800
Message-ID: <20250401130300.1457584-2-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250401130300.1457584-1-zoudongjie@huawei.com>
References: <20250401130300.1457584-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zoudongjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  zoudongjie <zoudongjie@huawei.com>
From:  zoudongjie via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhu Yangyang <zhuyangyang14@huawei.com>

The bdrv_drained_begin() function is a blocking function. In scenarios where network storage
is used and network links fail, it may block for a long time.
Therefore, we add a timeout parameter to control the duration of the block.

Since bdrv_drained_begin() has been widely adopted, both bdrv_drained_begin()
and bdrv_drained_begin_timeout() will be retained.

Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
---
 block/io.c               | 58 +++++++++++++++++++++++++++++++++-------
 include/block/aio-wait.h | 47 +++++++++++++++++++++++---------
 include/block/block-io.h | 22 ++++++++++++++-
 util/aio-wait.c          |  5 ++++
 4 files changed, 108 insertions(+), 24 deletions(-)

diff --git a/block/io.c b/block/io.c
index 1ba8d1aeea..912b76c4a4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -255,6 +255,8 @@ typedef struct {
     bool begin;
     bool poll;
     BdrvChild *parent;
+    uint64_t timeout_ns;
+    int ret;
 } BdrvCoDrainData;
 
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll() */
@@ -283,6 +285,10 @@ static bool bdrv_drain_poll_top_level(BlockDriverState *bs,
     return bdrv_drain_poll(bs, ignore_parent, false);
 }
 
+static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
+                                         BdrvChild *parent,
+                                         bool poll,
+                                         uint64_t timeout_ns);
 static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
                                   bool poll);
 static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent);
@@ -296,7 +302,9 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     if (bs) {
         bdrv_dec_in_flight(bs);
         if (data->begin) {
-            bdrv_do_drained_begin(bs, data->parent, data->poll);
+            data->ret = bdrv_do_drained_begin_timeout(bs, data->parent,
+                                                      data->poll,
+                                                      data->timeout_ns);
         } else {
             assert(!data->poll);
             bdrv_do_drained_end(bs, data->parent);
@@ -310,10 +318,11 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     aio_co_wake(co);
 }
 
-static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
-                                                bool begin,
-                                                BdrvChild *parent,
-                                                bool poll)
+static int coroutine_fn bdrv_co_yield_to_drain_timeout(BlockDriverState *bs,
+                                                       bool begin,
+                                                       BdrvChild *parent,
+                                                       bool poll,
+                                                       uint64_t timeout_ns)
 {
     BdrvCoDrainData data;
     Coroutine *self = qemu_coroutine_self();
@@ -329,6 +338,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
         .begin = begin,
         .parent = parent,
         .poll = poll,
+        .timeout_ns = timeout_ns,
+        .ret = 0
     };
 
     if (bs) {
@@ -342,16 +353,27 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     /* If we are resumed from some other event (such as an aio completion or a
      * timer callback), it is a bug in the caller that should be fixed. */
     assert(data.done);
+    return data.ret;
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
-                                  bool poll)
+static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
+                                                bool begin,
+                                                BdrvChild *parent,
+                                                bool poll)
+{
+    bdrv_co_yield_to_drain_timeout(bs, begin, parent, poll, 0);
+}
+
+static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
+                                         BdrvChild *parent,
+                                         bool poll,
+                                         uint64_t timeout_ns)
 {
     IO_OR_GS_CODE();
 
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, true, parent, poll);
-        return;
+        return bdrv_co_yield_to_drain_timeout(bs, true, parent, poll,
+                                              timeout_ns);
     }
 
     GLOBAL_STATE_CODE();
@@ -375,8 +397,17 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
      * nodes.
      */
     if (poll) {
-        BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
+        return BDRV_POLL_WHILE_TIMEOUT(bs,
+                                       bdrv_drain_poll_top_level(bs, parent),
+                                       timeout_ns);
     }
+    return 0;
+}
+
+static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
+                                  bool poll)
+{
+    bdrv_do_drained_begin_timeout(bs, parent, poll, 0);
 }
 
 void bdrv_do_drained_begin_quiesce(BlockDriverState *bs, BdrvChild *parent)
@@ -391,6 +422,13 @@ bdrv_drained_begin(BlockDriverState *bs)
     bdrv_do_drained_begin(bs, NULL, true);
 }
 
+int coroutine_mixed_fn
+bdrv_drained_begin_timeout(BlockDriverState *bs, uint64_t timeout_ns)
+{
+    IO_OR_GS_CODE();
+    return bdrv_do_drained_begin_timeout(bs, NULL, true, timeout_ns);
+}
+
 /**
  * This function does not poll, nor must any of its recursively called
  * functions.
diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index cf5e8bde1c..7610880b61 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -59,10 +59,12 @@ typedef struct {
 extern AioWait global_aio_wait;
 
 /**
- * AIO_WAIT_WHILE_INTERNAL:
+ * AIO_WAIT_WHILE_TIMEOUT:
  * @ctx: the aio context, or NULL if multiple aio contexts (for which the
  *       caller does not hold a lock) are involved in the polling condition.
  * @cond: wait while this conditional expression is true
+ * @timeout_ns: maximum duration to wait, in nanoseconds, except the value
+ *              is unsigned, 0 means infinite.
  *
  * Wait while a condition is true.  Use this to implement synchronous
  * operations that require event loop activity.
@@ -74,37 +76,54 @@ extern AioWait global_aio_wait;
  * thread (with @ctx acquired exactly once).  This function cannot be used to
  * wait on conditions between two IOThreads since that could lead to deadlock,
  * go via the main loop instead.
+ *
+ * Returns: 0 if succeeded; -ETIMEDOUT when a timeout occurs.
  */
-#define AIO_WAIT_WHILE_INTERNAL(ctx, cond) ({                      \
-    bool waited_ = false;                                          \
+#define AIO_WAIT_WHILE_TIMEOUT(ctx, cond, timeout_ns) ({           \
+    int ret_ = 0;                                                  \
+    uint64_t timeout_ = (timeout_ns);                              \
     AioWait *wait_ = &global_aio_wait;                             \
     AioContext *ctx_ = (ctx);                                      \
+    AioContext *current_ctx_ = NULL;                               \
+    QEMUTimer timer_;                                              \
     /* Increment wait_->num_waiters before evaluating cond. */     \
     qatomic_inc(&wait_->num_waiters);                              \
     /* Paired with smp_mb in aio_wait_kick(). */                   \
     smp_mb__after_rmw();                                           \
     if (ctx_ && in_aio_context_home_thread(ctx_)) {                \
-        while ((cond)) {                                           \
-            aio_poll(ctx_, true);                                  \
-            waited_ = true;                                        \
-        }                                                          \
+        current_ctx_ = ctx_;                                       \
     } else {                                                       \
         assert(qemu_get_current_aio_context() ==                   \
                qemu_get_aio_context());                            \
-        while ((cond)) {                                           \
-            aio_poll(qemu_get_aio_context(), true);                \
-            waited_ = true;                                        \
+        current_ctx_ = qemu_get_aio_context();                     \
+    }                                                              \
+    if (timeout_ > 0) {                                            \
+        timer_init_full(&timer_, &current_ctx_->tlg,               \
+                        QEMU_CLOCK_REALTIME,                       \
+                        SCALE_NS, 0, aio_wait_timer_cb, NULL);     \
+        timer_mod_ns(&timer_,                                      \
+                     qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +      \
+                     timeout_);                                    \
+    }                                                              \
+    while ((cond)) {                                               \
+        aio_poll(current_ctx_, true);                              \
+        if (timeout_ > 0 && !timer_pending(&timer_)) {             \
+            ret_ = -ETIMEDOUT;                                     \
+            break;                                                 \
         }                                                          \
     }                                                              \
+    if (timeout_ > 0) {                                            \
+        timer_del(&timer_);                                        \
+    }                                                              \
     qatomic_dec(&wait_->num_waiters);                              \
-    waited_; })
+    ret_; })
 
 #define AIO_WAIT_WHILE(ctx, cond)                                  \
-    AIO_WAIT_WHILE_INTERNAL(ctx, cond)
+    AIO_WAIT_WHILE_TIMEOUT(ctx, cond, 0)
 
 /* TODO replace this with AIO_WAIT_WHILE() in a future patch */
 #define AIO_WAIT_WHILE_UNLOCKED(ctx, cond)                         \
-    AIO_WAIT_WHILE_INTERNAL(ctx, cond)
+    AIO_WAIT_WHILE_TIMEOUT(ctx, cond, 0)
 
 /**
  * aio_wait_kick:
@@ -149,4 +168,6 @@ static inline bool in_aio_context_home_thread(AioContext *ctx)
     }
 }
 
+void aio_wait_timer_cb(void *opaque);
+
 #endif /* QEMU_AIO_WAIT_H */
diff --git a/include/block/block-io.h b/include/block/block-io.h
index b49e0537dd..844e9cf350 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -354,6 +354,11 @@ bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
     AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
                    cond); })
 
+#define BDRV_POLL_WHILE_TIMEOUT(bs, cond, timeout_ns) ({   \
+    BlockDriverState *bs_ = (bs);                          \
+    AIO_WAIT_WHILE_TIMEOUT(bdrv_get_aio_context(bs_),      \
+                           cond, timeout_ns); })
+
 void bdrv_drain(BlockDriverState *bs);
 
 int co_wrapper_mixed_bdrv_rdlock
@@ -432,7 +437,22 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
 void bdrv_drained_begin(BlockDriverState *bs);
 
 /**
- * bdrv_do_drained_begin_quiesce:
+ * bdrv_drained_begin_timeout:
+ *
+ * Added timeout parameter for bdrv_drained_begin() to make a time limited.
+ *
+ * @timeout_ns: maximum duration to wait; 0 means infinite, equal to call
+ *              bdrv_drained_begin().
+ *
+ * Returns: 0 if succeeded; -ETIMEDOUT when a timeout occurs.
+ *
+ * Note: when the timeout fails, we've already begin aquiesced section, so we
+ * still need to call bdrv_drained_end() to end the quiescent section.
+ */
+int bdrv_drained_begin_timeout(BlockDriverState *bs, uint64_t timeout_ns);
+
+/**
+ * bdrv_do_drained_badegin_quiesce:
  *
  * Quiesces a BDS like bdrv_drained_begin(), but does not wait for already
  * running requests to complete.
diff --git a/util/aio-wait.c b/util/aio-wait.c
index b5336cf5fd..64c3714fb8 100644
--- a/util/aio-wait.c
+++ b/util/aio-wait.c
@@ -84,3 +84,8 @@ void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
     aio_bh_schedule_oneshot(ctx, aio_wait_bh, &data);
     AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
 }
+
+void aio_wait_timer_cb(void *opaque)
+{
+    /* The point is to make AIO_WAIT_WHILE_TIMEOUT()'s aio_poll() return */
+}
-- 
2.33.0


