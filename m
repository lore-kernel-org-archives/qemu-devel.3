Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13741C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzce1-0006pd-PT; Tue, 01 Apr 2025 10:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcdz-0006oc-Dl
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcdv-0005wZ-Qu
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743517867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6mPebaynhuuOFMHo/lh7KcN9Epz+ODw0XfaG/YSz5E=;
 b=YuKPSHBYHuTc2PQ7N80JffKtqY7qyKdgeqd84setR9e9GUzOKtLJPUk4qIauXjy4l8+Gvs
 IEzsEXY7RBO7gxyZITzxRct4DZx3H1JKlCrqiISbUB3FokEDmssI/96tcQLIKY/l39rgi2
 xniba4g6pPutSsOdQZtXd03+g43X7EI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-OUnTbxghM2W96kXkux55eA-1; Tue,
 01 Apr 2025 10:31:04 -0400
X-MC-Unique: OUnTbxghM2W96kXkux55eA-1
X-Mimecast-MFC-AGG-ID: OUnTbxghM2W96kXkux55eA_1743517862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1093A1956060; Tue,  1 Apr 2025 14:31:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14FA9180B488; Tue,  1 Apr 2025 14:30:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, surajshirvankar@gmail.com,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 2/3] aio-posix: add aio_add_sqe() API for user-defined
 io_uring requests
Date: Tue,  1 Apr 2025 10:27:20 -0400
Message-ID: <20250401142721.280287-3-stefanha@redhat.com>
In-Reply-To: <20250401142721.280287-1-stefanha@redhat.com>
References: <20250401142721.280287-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce the aio_add_sqe() API for submitting io_uring requests in the
current AioContext. This allows other components in QEMU, like the block
layer, to take advantage of io_uring features without creating their own
io_uring context.

This API supports nested event loops just like file descriptor
monitoring and BHs do. This comes at a complexity cost: a BH is required
to dispatch CQE callbacks and they are placed on a list so that a nested
event loop can invoke its parent's pending CQE callbacks. If you're
wondering why CqeHandler exists instead of just a callback function
pointer, this is why.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h   |  67 +++++++++++++++++++
 util/aio-posix.h      |   1 +
 util/aio-posix.c      |   9 +++
 util/fdmon-io_uring.c | 145 +++++++++++++++++++++++++++++++-----------
 4 files changed, 185 insertions(+), 37 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 1657740a0e..4dfb419a21 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -61,6 +61,27 @@ typedef struct LuringState LuringState;
 /* Is polling disabled? */
 bool aio_poll_disabled(AioContext *ctx);
 
+#ifdef CONFIG_LINUX_IO_URING
+/*
+ * Each io_uring request must have a unique CqeHandler that processes the cqe.
+ * The lifetime of a CqeHandler must be at least from aio_add_sqe() until
+ * ->cb() invocation.
+ */
+typedef struct CqeHandler CqeHandler;
+struct CqeHandler {
+    /* Called by the AioContext when the request has completed */
+    void (*cb)(CqeHandler *handler);
+
+    /* Used internally, do not access this */
+    QSIMPLEQ_ENTRY(CqeHandler) next;
+
+    /* This field is filled in before ->cb() is called */
+    struct io_uring_cqe cqe;
+};
+
+typedef QSIMPLEQ_HEAD(, CqeHandler) CqeHandlerSimpleQ;
+#endif /* CONFIG_LINUX_IO_URING */
+
 /* Callbacks for file descriptor monitoring implementations */
 typedef struct {
     /*
@@ -138,6 +159,27 @@ typedef struct {
      * Called with list_lock incremented.
      */
     void (*gsource_dispatch)(AioContext *ctx, AioHandlerList *ready_list);
+
+#ifdef CONFIG_LINUX_IO_URING
+    /**
+     * aio_add_sqe: Add an io_uring sqe for submission.
+     * @prep_sqe: invoked with an sqe that should be prepared for submission
+     * @opaque: user-defined argument to @prep_sqe()
+     * @cqe_handler: the unique cqe handler associated with this request
+     *
+     * The caller's @prep_sqe() function is invoked to fill in the details of
+     * the sqe. Do not call io_uring_sqe_set_data() on this sqe.
+     *
+     * The kernel may see the sqe as soon as @pre_sqe() returns or it may take
+     * until the next event loop iteration.
+     *
+     * This function is called from the current AioContext and is not
+     * thread-safe.
+     */
+    void (*add_sqe)(AioContext *ctx,
+                    void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
+                    void *opaque, CqeHandler *cqe_handler);
+#endif /* CONFIG_LINUX_IO_URING */
 } FDMonOps;
 
 /*
@@ -255,6 +297,10 @@ struct AioContext {
     struct io_uring fdmon_io_uring;
     AioHandlerSList submit_list;
     gpointer io_uring_fd_tag;
+
+    /* Pending callback state for cqe handlers */
+    CqeHandlerSimpleQ cqe_handler_ready_list;
+    QEMUBH *cqe_handler_bh;
 #endif
 
     /* TimerLists for calling timers - one per clock type.  Has its own
@@ -370,6 +416,27 @@ QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
 #define aio_bh_new_guarded(ctx, cb, opaque, guard) \
     aio_bh_new_full((ctx), (cb), (opaque), (stringify(cb)), guard)
 
+#ifdef CONFIG_LINUX_IO_URING
+/**
+ * aio_add_sqe: Add an io_uring sqe for submission.
+ * @prep_sqe: invoked with an sqe that should be prepared for submission
+ * @opaque: user-defined argument to @prep_sqe()
+ * @cqe_handler: the unique cqe handler associated with this request
+ *
+ * The caller's @prep_sqe() function is invoked to fill in the details of the
+ * sqe. Do not call io_uring_sqe_set_data() on this sqe.
+ *
+ * The sqe is submitted by the current AioContext. The kernel may see the sqe
+ * as soon as @pre_sqe() returns or it may take until the next event loop
+ * iteration.
+ *
+ * When the AioContext is destroyed, pending sqes are ignored and their
+ * CqeHandlers are not invoked.
+ */
+void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
+                 void *opaque, CqeHandler *cqe_handler);
+#endif /* CONFIG_LINUX_IO_URING */
+
 /**
  * aio_notify: Force processing of pending events.
  *
diff --git a/util/aio-posix.h b/util/aio-posix.h
index f9994ed79e..d3e2f66957 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -35,6 +35,7 @@ struct AioHandler {
 #ifdef CONFIG_LINUX_IO_URING
     QSLIST_ENTRY(AioHandler) node_submitted;
     unsigned flags; /* see fdmon-io_uring.c */
+    CqeHandler cqe_handler;
 #endif
     int64_t poll_idle_timeout; /* when to stop userspace polling */
     bool poll_ready; /* has polling detected an event? */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 6c2ee0b0b4..f2535dc868 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -767,3 +767,12 @@ void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch)
 
     aio_notify(ctx);
 }
+
+#ifdef CONFIG_LINUX_IO_URING
+void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
+                 void *opaque, CqeHandler *cqe_handler)
+{
+    AioContext *ctx = qemu_get_current_aio_context();
+    ctx->fdmon_ops->add_sqe(ctx, prep_sqe, opaque, cqe_handler);
+}
+#endif /* CONFIG_LINUX_IO_URING */
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 18b33a0370..a4523e3dcc 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -75,8 +75,8 @@ static inline int pfd_events_from_poll(int poll_events)
 }
 
 /*
- * Returns an sqe for submitting a request.  Only be called within
- * fdmon_io_uring_wait().
+ * Returns an sqe for submitting a request. Only called from the AioContext
+ * thread.
  */
 static struct io_uring_sqe *get_sqe(AioContext *ctx)
 {
@@ -166,23 +166,43 @@ static void fdmon_io_uring_update(AioContext *ctx,
     }
 }
 
+static void fdmon_io_uring_add_sqe(AioContext *ctx,
+        void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
+        void *opaque, CqeHandler *cqe_handler)
+{
+    struct io_uring_sqe *sqe = get_sqe(ctx);
+
+    prep_sqe(sqe, opaque);
+    io_uring_sqe_set_data(sqe, cqe_handler);
+}
+
+static void fdmon_special_cqe_handler(CqeHandler *cqe_handler)
+{
+    /*
+     * This is an empty function that is never called. It is used as a function
+     * pointer to distinguish it from ordinary cqe handlers.
+     */
+}
+
 static void add_poll_multishot_sqe(AioContext *ctx, AioHandler *node)
 {
     struct io_uring_sqe *sqe = get_sqe(ctx);
     int events = poll_events_from_pfd(node->pfd.events);
 
     io_uring_prep_poll_multishot(sqe, node->pfd.fd, events);
-    io_uring_sqe_set_data(sqe, node);
+    node->cqe_handler.cb = fdmon_special_cqe_handler;
+    io_uring_sqe_set_data(sqe, &node->cqe_handler);
 }
 
 static void add_poll_remove_sqe(AioContext *ctx, AioHandler *node)
 {
     struct io_uring_sqe *sqe = get_sqe(ctx);
+    CqeHandler *cqe_handler = &node->cqe_handler;
 
 #ifdef LIBURING_HAVE_DATA64
-    io_uring_prep_poll_remove(sqe, (uintptr_t)node);
+    io_uring_prep_poll_remove(sqe, (uintptr_t)cqe_handler);
 #else
-    io_uring_prep_poll_remove(sqe, node);
+    io_uring_prep_poll_remove(sqe, cqe_handler);
 #endif
     io_uring_sqe_set_data(sqe, NULL);
 }
@@ -221,20 +241,12 @@ static void fill_sq_ring(AioContext *ctx)
     }
 }
 
-/* Returns true if a handler became ready */
-static bool process_cqe(AioContext *ctx,
-                        AioHandlerList *ready_list,
-                        struct io_uring_cqe *cqe)
+static bool process_cqe_aio_handler(AioContext *ctx,
+                                    AioHandlerList *ready_list,
+                                    AioHandler *node,
+                                    struct io_uring_cqe *cqe)
 {
-    AioHandler *node = io_uring_cqe_get_data(cqe);
-    unsigned flags;
-
-    /* poll_timeout and poll_remove have a zero user_data field */
-    if (!node) {
-        return false;
-    }
-
-    flags = qatomic_read(&node->flags);
+    unsigned flags = qatomic_read(&node->flags);
 
     /*
      * poll_multishot cancelled by poll_remove? Or completed early because fd
@@ -261,6 +273,56 @@ static bool process_cqe(AioContext *ctx,
     return true;
 }
 
+/* Process CqeHandlers from the ready list */
+static void cqe_handler_bh(void *opaque)
+{
+    AioContext *ctx = opaque;
+    CqeHandlerSimpleQ *ready_list = &ctx->cqe_handler_ready_list;
+
+    /*
+     * If cqe_handler->cb() calls aio_poll() it must continue processing
+     * ready_list. Schedule a BH so the inner event loop calls us again.
+     */
+    qemu_bh_schedule(ctx->cqe_handler_bh);
+
+    while (!QSIMPLEQ_EMPTY(ready_list)) {
+        CqeHandler *cqe_handler = QSIMPLEQ_FIRST(ready_list);
+
+        QSIMPLEQ_REMOVE_HEAD(ready_list, next);
+
+        cqe_handler->cb(cqe_handler);
+    }
+
+    qemu_bh_cancel(ctx->cqe_handler_bh);
+}
+
+/* Returns true if a handler became ready */
+static bool process_cqe(AioContext *ctx,
+                        AioHandlerList *ready_list,
+                        struct io_uring_cqe *cqe)
+{
+    CqeHandler *cqe_handler = io_uring_cqe_get_data(cqe);
+
+    /* poll_timeout and poll_remove have a zero user_data field */
+    if (!cqe_handler) {
+        return false;
+    }
+
+    /*
+     * Special handling for AioHandler cqes. They need ready_list and have a
+     * return value.
+     */
+    if (cqe_handler->cb == fdmon_special_cqe_handler) {
+        AioHandler *node = container_of(cqe_handler, AioHandler, cqe_handler);
+        return process_cqe_aio_handler(ctx, ready_list, node, cqe);
+    }
+
+    cqe_handler->cqe = *cqe;
+    QSIMPLEQ_INSERT_TAIL(&ctx->cqe_handler_ready_list, cqe_handler, next);
+    qemu_bh_schedule(ctx->cqe_handler_bh);
+    return false;
+}
+
 static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
 {
     struct io_uring *ring = &ctx->fdmon_io_uring;
@@ -360,6 +422,7 @@ static const FDMonOps fdmon_io_uring_ops = {
     .gsource_prepare = fdmon_io_uring_gsource_prepare,
     .gsource_check = fdmon_io_uring_gsource_check,
     .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
+    .add_sqe = fdmon_io_uring_add_sqe,
 };
 
 bool fdmon_io_uring_setup(AioContext *ctx)
@@ -375,6 +438,8 @@ bool fdmon_io_uring_setup(AioContext *ctx)
     }
 
     QSLIST_INIT(&ctx->submit_list);
+    QSIMPLEQ_INIT(&ctx->cqe_handler_ready_list);
+    ctx->cqe_handler_bh = aio_bh_new(ctx, cqe_handler_bh, ctx);
     ctx->fdmon_ops = &fdmon_io_uring_ops;
     ctx->io_uring_fd_tag = g_source_add_unix_fd(&ctx->source,
             ctx->fdmon_io_uring.ring_fd, G_IO_IN);
@@ -384,30 +449,36 @@ bool fdmon_io_uring_setup(AioContext *ctx)
 
 void fdmon_io_uring_destroy(AioContext *ctx)
 {
-    if (ctx->fdmon_ops == &fdmon_io_uring_ops) {
-        AioHandler *node;
+    AioHandler *node;
 
-        io_uring_queue_exit(&ctx->fdmon_io_uring);
+    if (ctx->fdmon_ops != &fdmon_io_uring_ops) {
+        return;
+    }
 
-        /* Move handlers due to be removed onto the deleted list */
-        while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
-            unsigned flags = qatomic_fetch_and(&node->flags,
-                    ~(FDMON_IO_URING_PENDING |
-                      FDMON_IO_URING_ADD |
-                      FDMON_IO_URING_REMOVE));
+    io_uring_queue_exit(&ctx->fdmon_io_uring);
 
-            if (flags & FDMON_IO_URING_REMOVE) {
-                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
-            }
+    /* Move handlers due to be removed onto the deleted list */
+    while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
+        unsigned flags = qatomic_fetch_and(&node->flags,
+                ~(FDMON_IO_URING_PENDING |
+                  FDMON_IO_URING_ADD |
+                  FDMON_IO_URING_REMOVE));
 
-            QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
+        if (flags & FDMON_IO_URING_REMOVE) {
+            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
+                                  node, node_deleted);
         }
 
-        g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
-        ctx->io_uring_fd_tag = NULL;
-
-        qemu_lockcnt_lock(&ctx->list_lock);
-        fdmon_poll_downgrade(ctx);
-        qemu_lockcnt_unlock(&ctx->list_lock);
+        QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
     }
+
+    g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
+    ctx->io_uring_fd_tag = NULL;
+
+    assert(QSIMPLEQ_EMPTY(&ctx->cqe_handler_ready_list));
+    qemu_bh_delete(ctx->cqe_handler_bh);
+
+    qemu_lockcnt_lock(&ctx->list_lock);
+    fdmon_poll_downgrade(ctx);
+    qemu_lockcnt_unlock(&ctx->list_lock);
 }
-- 
2.49.0


