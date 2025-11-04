Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6220CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6ov-0007In-KM; Mon, 03 Nov 2025 21:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oM-00079m-Fv
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oJ-0004Cj-1L
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUvAPVpBkMWS7uz/pr00E0CD5XkNIotOQvCIiZlq74U=;
 b=Wr2YUD1SJ5n0C7Epr5ytsHN6Li0fzLYlcGcRp+NYOAPcH+668pdtnRopSNkHp6+Ck95TfL
 /OXUbf2huMUVXSsJAaqAQUQOfDnxqQ4LSl4FkFdX9w6i/9nZgra8xhEC3ZDWYjHjARGD+x
 jBPed6yQTiMj3/I9VlbDZL64Uuu6k0I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-uzYWN9dJM_ijvGQu6G1nfA-1; Mon,
 03 Nov 2025 21:30:11 -0500
X-MC-Unique: uzYWN9dJM_ijvGQu6G1nfA-1
X-Mimecast-MFC-AGG-ID: uzYWN9dJM_ijvGQu6G1nfA_1762223410
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C30618001E8; Tue,  4 Nov 2025 02:30:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A0C019560B2; Tue,  4 Nov 2025 02:30:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: [PATCH v6 13/15] aio-posix: add aio_add_sqe() API for user-defined
 io_uring requests
Date: Mon,  3 Nov 2025 21:29:31 -0500
Message-ID: <20251104022933.618123-14-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
monitoring and BHs do. This comes at a complexity cost: CQE callbacks
must be placed on a list so that nested event loops can invoke pending
CQE callbacks from parent event loops. If you're wondering why
CqeHandler exists instead of just a callback function pointer, this is
why.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v5:
- Replace cqe_handler_bh with FDMonOps->dispatch() [Kevin]
- Rename AioHandler->cqe_handler field to ->internal_cqe_handler [Kevin]
- Consolidate fdmon-io_uring.c trace-events changes into this commit
v2:
- Fix pre_sqe -> prep_sqe typo [Eric]
- Add #endif terminator comment [Eric]
---
 include/block/aio.h   |  83 +++++++++++++++++++++++++++++++-
 util/aio-posix.h      |   1 +
 util/aio-posix.c      |   9 ++++
 util/fdmon-io_uring.c | 109 ++++++++++++++++++++++++++++++++++++------
 util/trace-events     |   4 ++
 5 files changed, 190 insertions(+), 16 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index b266daa58f..05d1bf4036 100644
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
@@ -157,6 +178,27 @@ typedef struct {
      * Called with list_lock incremented.
      */
     void (*gsource_dispatch)(AioContext *ctx, AioHandlerList *ready_list);
+
+#ifdef CONFIG_LINUX_IO_URING
+    /**
+     * add_sqe: Add an io_uring sqe for submission.
+     * @prep_sqe: invoked with an sqe that should be prepared for submission
+     * @opaque: user-defined argument to @prep_sqe()
+     * @cqe_handler: the unique cqe handler associated with this request
+     *
+     * The caller's @prep_sqe() function is invoked to fill in the details of
+     * the sqe. Do not call io_uring_sqe_set_data() on this sqe.
+     *
+     * The kernel may see the sqe as soon as @prep_sqe() returns or it may take
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
@@ -274,7 +316,10 @@ struct AioContext {
     struct io_uring fdmon_io_uring;
     AioHandlerSList submit_list;
     gpointer io_uring_fd_tag;
-#endif
+
+    /* Pending callback state for cqe handlers */
+    CqeHandlerSimpleQ cqe_handler_ready_list;
+#endif /* CONFIG_LINUX_IO_URING */
 
     /* TimerLists for calling timers - one per clock type.  Has its own
      * locking.
@@ -782,4 +827,40 @@ void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch);
  */
 void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
                                         int64_t max, Error **errp);
+
+#ifdef CONFIG_LINUX_IO_URING
+/**
+ * aio_has_io_uring: Return whether io_uring is available.
+ *
+ * io_uring is either available in all AioContexts or in none, so this only
+ * needs to be called once from within any thread's AioContext.
+ */
+static inline bool aio_has_io_uring(void)
+{
+    AioContext *ctx = qemu_get_current_aio_context();
+    return ctx->fdmon_ops->add_sqe;
+}
+
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
+ * as soon as @prep_sqe() returns or it may take until the next event loop
+ * iteration.
+ *
+ * When the AioContext is destroyed, pending sqes are ignored and their
+ * CqeHandlers are not invoked.
+ *
+ * This function must be called only when aio_has_io_uring() returns true.
+ */
+void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
+                 void *opaque, CqeHandler *cqe_handler);
+#endif /* CONFIG_LINUX_IO_URING */
+
 #endif
diff --git a/util/aio-posix.h b/util/aio-posix.h
index dfa1a51c0b..babbfa8314 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -36,6 +36,7 @@ struct AioHandler {
 #ifdef CONFIG_LINUX_IO_URING
     QSLIST_ENTRY(AioHandler) node_submitted;
     unsigned flags; /* see fdmon-io_uring.c */
+    CqeHandler internal_cqe_handler; /* used for POLL_ADD/POLL_REMOVE */
 #endif
     int64_t poll_idle_timeout; /* when to stop userspace polling */
     bool poll_ready; /* has polling detected an event? */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 6ff36b6e51..e24b955fd9 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -806,3 +806,12 @@ void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch)
 
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
index a06bbe2715..4230bf33e3 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -46,8 +46,10 @@
 #include "qemu/osdep.h"
 #include <poll.h>
 #include "qapi/error.h"
+#include "qemu/defer-call.h"
 #include "qemu/rcu_queue.h"
 #include "aio-posix.h"
+#include "trace.h"
 
 enum {
     FDMON_IO_URING_ENTRIES  = 128, /* sq/cq ring size */
@@ -76,8 +78,8 @@ static inline int pfd_events_from_poll(int poll_events)
 }
 
 /*
- * Returns an sqe for submitting a request.  Only be called within
- * fdmon_io_uring_wait().
+ * Returns an sqe for submitting a request. Only called from the AioContext
+ * thread.
  */
 static struct io_uring_sqe *get_sqe(AioContext *ctx)
 {
@@ -168,23 +170,46 @@ static void fdmon_io_uring_update(AioContext *ctx,
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
+
+    trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->fd, sqe->off,
+                                 cqe_handler);
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
 static void add_poll_add_sqe(AioContext *ctx, AioHandler *node)
 {
     struct io_uring_sqe *sqe = get_sqe(ctx);
     int events = poll_events_from_pfd(node->pfd.events);
 
     io_uring_prep_poll_add(sqe, node->pfd.fd, events);
-    io_uring_sqe_set_data(sqe, node);
+    node->internal_cqe_handler.cb = fdmon_special_cqe_handler;
+    io_uring_sqe_set_data(sqe, &node->internal_cqe_handler);
 }
 
 static void add_poll_remove_sqe(AioContext *ctx, AioHandler *node)
 {
     struct io_uring_sqe *sqe = get_sqe(ctx);
+    CqeHandler *cqe_handler = &node->internal_cqe_handler;
 
 #ifdef LIBURING_HAVE_DATA64
-    io_uring_prep_poll_remove(sqe, (uintptr_t)node);
+    io_uring_prep_poll_remove(sqe, (uintptr_t)cqe_handler);
 #else
-    io_uring_prep_poll_remove(sqe, node);
+    io_uring_prep_poll_remove(sqe, cqe_handler);
 #endif
     io_uring_sqe_set_data(sqe, NULL);
 }
@@ -219,19 +244,13 @@ static void fill_sq_ring(AioContext *ctx)
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
     unsigned flags;
 
-    /* poll_timeout and poll_remove have a zero user_data field */
-    if (!node) {
-        return false;
-    }
-
     /*
      * Deletion can only happen when IORING_OP_POLL_ADD completes.  If we race
      * with enqueue() here then we can safely clear the FDMON_IO_URING_REMOVE
@@ -255,6 +274,35 @@ static bool process_cqe(AioContext *ctx,
     return true;
 }
 
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
+        AioHandler *node = container_of(cqe_handler, AioHandler,
+                                        internal_cqe_handler);
+        return process_cqe_aio_handler(ctx, ready_list, node, cqe);
+    }
+
+    cqe_handler->cqe = *cqe;
+
+    /* Handlers are invoked later by fdmon_io_uring_dispatch() */
+    QSIMPLEQ_INSERT_TAIL(&ctx->cqe_handler_ready_list, cqe_handler, next);
+    return false;
+}
+
 static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
 {
     struct io_uring *ring = &ctx->fdmon_io_uring;
@@ -297,6 +345,32 @@ static bool fdmon_io_uring_gsource_check(AioContext *ctx)
     return g_source_query_unix_fd(&ctx->source, tag) & G_IO_IN;
 }
 
+/* Dispatch CQE handlers that are ready */
+static bool fdmon_io_uring_dispatch(AioContext *ctx)
+{
+    CqeHandlerSimpleQ *ready_list = &ctx->cqe_handler_ready_list;
+    bool progress = false;
+
+    /* Handlers may use defer_call() to coalesce frequent operations */
+    defer_call_begin();
+
+    while (!QSIMPLEQ_EMPTY(ready_list)) {
+        CqeHandler *cqe_handler = QSIMPLEQ_FIRST(ready_list);
+
+        QSIMPLEQ_REMOVE_HEAD(ready_list, next);
+
+        trace_fdmon_io_uring_cqe_handler(ctx, cqe_handler,
+                                         cqe_handler->cqe.res);
+        cqe_handler->cb(cqe_handler);
+        progress = true;
+    }
+
+    defer_call_end();
+
+    return progress;
+}
+
+
 /* This is where CQEs are processed in the glib event loop */
 static void fdmon_io_uring_gsource_dispatch(AioContext *ctx,
                                             AioHandlerList *ready_list)
@@ -369,9 +443,11 @@ static const FDMonOps fdmon_io_uring_ops = {
     .update = fdmon_io_uring_update,
     .wait = fdmon_io_uring_wait,
     .need_wait = fdmon_io_uring_need_wait,
+    .dispatch = fdmon_io_uring_dispatch,
     .gsource_prepare = fdmon_io_uring_gsource_prepare,
     .gsource_check = fdmon_io_uring_gsource_check,
     .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
+    .add_sqe = fdmon_io_uring_add_sqe,
 };
 
 bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
@@ -387,6 +463,7 @@ bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
     }
 
     QSLIST_INIT(&ctx->submit_list);
+    QSIMPLEQ_INIT(&ctx->cqe_handler_ready_list);
     ctx->fdmon_ops = &fdmon_io_uring_ops;
     ctx->io_uring_fd_tag = g_source_add_unix_fd(&ctx->source,
             ctx->fdmon_io_uring.ring_fd, G_IO_IN);
@@ -423,6 +500,8 @@ void fdmon_io_uring_destroy(AioContext *ctx)
     g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
     ctx->io_uring_fd_tag = NULL;
 
+    assert(QSIMPLEQ_EMPTY(&ctx->cqe_handler_ready_list));
+
     qemu_lockcnt_lock(&ctx->list_lock);
     fdmon_poll_downgrade(ctx);
     qemu_lockcnt_unlock(&ctx->list_lock);
diff --git a/util/trace-events b/util/trace-events
index bd8f25fb59..540d662507 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -24,6 +24,10 @@ buffer_move_empty(const char *buf, size_t len, const char *from) "%s: %zd bytes
 buffer_move(const char *buf, size_t len, const char *from) "%s: %zd bytes from %s"
 buffer_free(const char *buf, size_t len) "%s: capacity %zd"
 
+# fdmon-io_uring.c
+fdmon_io_uring_add_sqe(void *ctx, void *opaque, int opcode, int fd, uint64_t off, void *cqe_handler) "ctx %p opaque %p opcode %d fd %d off %"PRId64" cqe_handler %p"
+fdmon_io_uring_cqe_handler(void *ctx, void *cqe_handler, int cqe_res) "ctx %p cqe_handler %p cqe_res %d"
+
 # filemonitor-inotify.c
 qemu_file_monitor_add_watch(void *mon, const char *dirpath, const char *filename, void *cb, void *opaque, int64_t id) "File monitor %p add watch dir='%s' file='%s' cb=%p opaque=%p id=%" PRId64
 qemu_file_monitor_remove_watch(void *mon, const char *dirpath, int64_t id) "File monitor %p remove watch dir='%s' id=%" PRId64
-- 
2.51.1


