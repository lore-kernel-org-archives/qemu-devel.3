Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0CBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6oM-0007A0-JM; Mon, 03 Nov 2025 21:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6o6-00071X-Dg
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6o3-0003wH-10
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMLM1AvrE4ogaTXGPs1h6wX+VSpgpOX3+7letvy9Qtw=;
 b=aA4VYI0WXVgbtuDSsAzsaeYyzZcx+92O/FHIRRjRrvIDBB7lPhv8IBXfwoo1jCFF5X7mk0
 Z+7MGqVNzelW3nJBioq2+M7WNGCJfc7iNadO19n/EP2VGMU2gg9c1NI53BWRYyJDd0khzx
 857SKLE2CvX3VMFhjajKzGNJgH/PBoc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-oK2ba8DVOeeBeHDRUfkjdA-1; Mon,
 03 Nov 2025 21:29:55 -0500
X-MC-Unique: oK2ba8DVOeeBeHDRUfkjdA-1
X-Mimecast-MFC-AGG-ID: oK2ba8DVOeeBeHDRUfkjdA_1762223394
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 011CD180065F; Tue,  4 Nov 2025 02:29:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31B5B19560A2; Tue,  4 Nov 2025 02:29:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: [PATCH v6 06/15] aio-posix: integrate fdmon into glib event loop
Date: Mon,  3 Nov 2025 21:29:24 -0500
Message-ID: <20251104022933.618123-7-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

AioContext's glib integration only supports ppoll(2) file descriptor
monitoring. epoll(7) and io_uring(7) disable themselves and switch back
to ppoll(2) when the glib event loop is used. The main loop thread
cannot use epoll(7) or io_uring(7) because it always uses the glib event
loop.

Future QEMU features may require io_uring(7). One example is uring_cmd
support in FUSE exports. Each feature could create its own io_uring(7)
context and integrate it into the event loop, but this is inefficient
due to extra syscalls. It would be more efficient to reuse the
AioContext's existing fdmon-io_uring.c io_uring(7) context because
fdmon-io_uring.c will already be active on systems where Linux io_uring
is available.

In order to keep fdmon-io_uring.c's AioContext operational even when the
glib event loop is used, extend FDMonOps with an API similar to
GSourceFuncs so that file descriptor monitoring can integrate into the
glib event loop.

A quick summary of the GSourceFuncs API:
- prepare() is called each event loop iteration before waiting for file
  descriptors and timers.
- check() is called to determine whether events are ready to be
  dispatched after waiting.
- dispatch() is called to process events.

More details here: https://docs.gtk.org/glib/struct.SourceFuncs.html

Move the ppoll(2)-specific code from aio-posix.c into fdmon-poll.c and
also implement epoll(7)- and io_uring(7)-specific file descriptor
monitoring code for glib event loops.

Note that it's still faster to use aio_poll() rather than the glib event
loop since glib waits for file descriptor activity with ppoll(2) and
does not support adaptive polling. But at least epoll(7) and io_uring(7)
now work in glib event loops.

Splitting this into multiple commits without temporarily breaking
AioContext proved difficult so this commit makes all the changes. The
next commit will remove the aio_context_use_g_source() API because it is
no longer needed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v5:
- Avoid g_source_add_poll() use-after-free in fdmon_poll_update() [Kevin]
- Avoid duplication in fdmon_epoll_gsource_dispatch(), use fdmon_epoll_wait() [Kevin]
- Drop unnecessary revents checks in fdmon_poll_gsource_dispatch() [Kevin]
---
 include/block/aio.h   | 36 ++++++++++++++++++
 util/aio-posix.h      |  5 +++
 tests/unit/test-aio.c |  7 +++-
 util/aio-posix.c      | 69 ++++++++---------------------------
 util/fdmon-epoll.c    | 34 ++++++++++++++---
 util/fdmon-io_uring.c | 44 +++++++++++++++++++++-
 util/fdmon-poll.c     | 85 ++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 218 insertions(+), 62 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 99ff48420b..39ed86d14d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -106,6 +106,38 @@ typedef struct {
      * Returns: true if ->wait() should be called, false otherwise.
      */
     bool (*need_wait)(AioContext *ctx);
+
+    /*
+     * gsource_prepare:
+     * @ctx: the AioContext
+     *
+     * Prepare for the glib event loop to wait for events instead of the usual
+     * ->wait() call. See glib's GSourceFuncs->prepare().
+     */
+    void (*gsource_prepare)(AioContext *ctx);
+
+    /*
+     * gsource_check:
+     * @ctx: the AioContext
+     *
+     * Called by the glib event loop from glib's GSourceFuncs->check() after
+     * waiting for events.
+     *
+     * Returns: true when ready to be dispatched.
+     */
+    bool (*gsource_check)(AioContext *ctx);
+
+    /*
+     * gsource_dispatch:
+     * @ctx: the AioContext
+     * @ready_list: list for handlers that become ready
+     *
+     * Place ready AioHandlers on ready_list. Called as part of the glib event
+     * loop from glib's GSourceFuncs->dispatch().
+     *
+     * Called with list_lock incremented.
+     */
+    void (*gsource_dispatch)(AioContext *ctx, AioHandlerList *ready_list);
 } FDMonOps;
 
 /*
@@ -222,6 +254,7 @@ struct AioContext {
     /* State for file descriptor monitoring using Linux io_uring */
     struct io_uring fdmon_io_uring;
     AioHandlerSList submit_list;
+    gpointer io_uring_fd_tag;
 #endif
 
     /* TimerLists for calling timers - one per clock type.  Has its own
@@ -254,6 +287,9 @@ struct AioContext {
     /* epoll(7) state used when built with CONFIG_EPOLL */
     int epollfd;
 
+    /* The GSource unix fd tag for epollfd */
+    gpointer epollfd_tag;
+
     const FDMonOps *fdmon_ops;
 };
 
diff --git a/util/aio-posix.h b/util/aio-posix.h
index 82a0201ea4..f9994ed79e 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -47,9 +47,14 @@ void aio_add_ready_handler(AioHandlerList *ready_list, AioHandler *node,
 
 extern const FDMonOps fdmon_poll_ops;
 
+/* Switch back to poll(2). list_lock must be held. */
+void fdmon_poll_downgrade(AioContext *ctx);
+
 #ifdef CONFIG_EPOLL_CREATE1
 bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd);
 void fdmon_epoll_setup(AioContext *ctx);
+
+/* list_lock must be held */
 void fdmon_epoll_disable(AioContext *ctx);
 #else
 static inline bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd)
diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index e77d86be87..010d65b79a 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -527,7 +527,12 @@ static void test_source_bh_delete_from_cb(void)
     g_assert_cmpint(data1.n, ==, data1.max);
     g_assert(data1.bh == NULL);
 
-    assert(g_main_context_iteration(NULL, false));
+    /*
+     * There may be up to one more iteration due to the aio_notify
+     * EventNotifier.
+     */
+    g_main_context_iteration(NULL, false);
+
     assert(!g_main_context_iteration(NULL, false));
 }
 
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 824fdc34cc..9de05ee7e8 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -70,15 +70,6 @@ static AioHandler *find_aio_handler(AioContext *ctx, int fd)
 
 static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
 {
-    /* If the GSource is in the process of being destroyed then
-     * g_source_remove_poll() causes an assertion failure.  Skip
-     * removal in that case, because glib cleans up its state during
-     * destruction anyway.
-     */
-    if (!g_source_is_destroyed(&ctx->source)) {
-        g_source_remove_poll(&ctx->source, &node->pfd);
-    }
-
     node->pfd.revents = 0;
     node->poll_ready = false;
 
@@ -153,7 +144,6 @@ void aio_set_fd_handler(AioContext *ctx,
         } else {
             new_node->pfd = node->pfd;
         }
-        g_source_add_poll(&ctx->source, &new_node->pfd);
 
         new_node->pfd.events = (io_read ? G_IO_IN | G_IO_HUP | G_IO_ERR : 0);
         new_node->pfd.events |= (io_write ? G_IO_OUT | G_IO_ERR : 0);
@@ -267,37 +257,13 @@ bool aio_prepare(AioContext *ctx)
     poll_set_started(ctx, &ready_list, false);
     /* TODO what to do with this list? */
 
+    ctx->fdmon_ops->gsource_prepare(ctx);
     return false;
 }
 
 bool aio_pending(AioContext *ctx)
 {
-    AioHandler *node;
-    bool result = false;
-
-    /*
-     * We have to walk very carefully in case aio_set_fd_handler is
-     * called while we're walking.
-     */
-    qemu_lockcnt_inc(&ctx->list_lock);
-
-    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
-        int revents;
-
-        /* TODO should this check poll ready? */
-        revents = node->pfd.revents & node->pfd.events;
-        if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read) {
-            result = true;
-            break;
-        }
-        if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write) {
-            result = true;
-            break;
-        }
-    }
-    qemu_lockcnt_dec(&ctx->list_lock);
-
-    return result;
+    return ctx->fdmon_ops->gsource_check(ctx);
 }
 
 static void aio_free_deleted_handlers(AioContext *ctx)
@@ -390,10 +356,6 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
     return progress;
 }
 
-/*
- * If we have a list of ready handlers then this is more efficient than
- * scanning all handlers with aio_dispatch_handlers().
- */
 static bool aio_dispatch_ready_handlers(AioContext *ctx,
                                         AioHandlerList *ready_list,
                                         int64_t block_ns)
@@ -417,24 +379,18 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
     return progress;
 }
 
-/* Slower than aio_dispatch_ready_handlers() but only used via glib */
-static bool aio_dispatch_handlers(AioContext *ctx)
-{
-    AioHandler *node, *tmp;
-    bool progress = false;
-
-    QLIST_FOREACH_SAFE_RCU(node, &ctx->aio_handlers, node, tmp) {
-        progress = aio_dispatch_handler(ctx, node) || progress;
-    }
-
-    return progress;
-}
-
 void aio_dispatch(AioContext *ctx)
 {
+    AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
+
     qemu_lockcnt_inc(&ctx->list_lock);
     aio_bh_poll(ctx);
-    aio_dispatch_handlers(ctx);
+
+    ctx->fdmon_ops->gsource_dispatch(ctx, &ready_list);
+
+    /* block_ns is 0 because polling is disabled in the glib event loop */
+    aio_dispatch_ready_handlers(ctx, &ready_list, 0);
+
     aio_free_deleted_handlers(ctx);
     qemu_lockcnt_dec(&ctx->list_lock);
 
@@ -766,6 +722,7 @@ void aio_context_setup(AioContext *ctx)
 {
     ctx->fdmon_ops = &fdmon_poll_ops;
     ctx->epollfd = -1;
+    ctx->epollfd_tag = NULL;
 
     /* Use the fastest fd monitoring implementation if available */
     if (fdmon_io_uring_setup(ctx)) {
@@ -778,7 +735,11 @@ void aio_context_setup(AioContext *ctx)
 void aio_context_destroy(AioContext *ctx)
 {
     fdmon_io_uring_destroy(ctx);
+
+    qemu_lockcnt_lock(&ctx->list_lock);
     fdmon_epoll_disable(ctx);
+    qemu_lockcnt_unlock(&ctx->list_lock);
+
     aio_free_deleted_handlers(ctx);
 }
 
diff --git a/util/fdmon-epoll.c b/util/fdmon-epoll.c
index 9fb8800dde..61118e1ee6 100644
--- a/util/fdmon-epoll.c
+++ b/util/fdmon-epoll.c
@@ -19,8 +19,12 @@ void fdmon_epoll_disable(AioContext *ctx)
         ctx->epollfd = -1;
     }
 
-    /* Switch back */
-    ctx->fdmon_ops = &fdmon_poll_ops;
+    if (ctx->epollfd_tag) {
+        g_source_remove_unix_fd(&ctx->source, ctx->epollfd_tag);
+        ctx->epollfd_tag = NULL;
+    }
+
+    fdmon_poll_downgrade(ctx);
 }
 
 static inline int epoll_events_from_pfd(int pfd_events)
@@ -93,10 +97,29 @@ out:
     return ret;
 }
 
+static void fdmon_epoll_gsource_prepare(AioContext *ctx)
+{
+    /* Do nothing */
+}
+
+static bool fdmon_epoll_gsource_check(AioContext *ctx)
+{
+    return g_source_query_unix_fd(&ctx->source, ctx->epollfd_tag) & G_IO_IN;
+}
+
+static void fdmon_epoll_gsource_dispatch(AioContext *ctx,
+                                         AioHandlerList *ready_list)
+{
+    fdmon_epoll_wait(ctx, ready_list, 0);
+}
+
 static const FDMonOps fdmon_epoll_ops = {
     .update = fdmon_epoll_update,
     .wait = fdmon_epoll_wait,
     .need_wait = aio_poll_disabled,
+    .gsource_prepare = fdmon_epoll_gsource_prepare,
+    .gsource_check = fdmon_epoll_gsource_check,
+    .gsource_dispatch = fdmon_epoll_gsource_dispatch,
 };
 
 static bool fdmon_epoll_try_enable(AioContext *ctx)
@@ -118,6 +141,8 @@ static bool fdmon_epoll_try_enable(AioContext *ctx)
     }
 
     ctx->fdmon_ops = &fdmon_epoll_ops;
+    ctx->epollfd_tag = g_source_add_unix_fd(&ctx->source, ctx->epollfd,
+                                            G_IO_IN);
     return true;
 }
 
@@ -139,12 +164,11 @@ bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd)
     }
 
     ok = fdmon_epoll_try_enable(ctx);
-
-    qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
-
     if (!ok) {
         fdmon_epoll_disable(ctx);
     }
+
+    qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
     return ok;
 }
 
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 3d8638b0e5..0a5ec5ead6 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -262,6 +262,11 @@ static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
     unsigned num_ready = 0;
     unsigned head;
 
+    /* If the CQ overflowed then fetch CQEs with a syscall */
+    if (io_uring_cq_has_overflow(ring)) {
+        io_uring_get_events(ring);
+    }
+
     io_uring_for_each_cqe(ring, head, cqe) {
         if (process_cqe(ctx, ready_list, cqe)) {
             num_ready++;
@@ -274,6 +279,30 @@ static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
     return num_ready;
 }
 
+/* This is where SQEs are submitted in the glib event loop */
+static void fdmon_io_uring_gsource_prepare(AioContext *ctx)
+{
+    fill_sq_ring(ctx);
+    if (io_uring_sq_ready(&ctx->fdmon_io_uring)) {
+        while (io_uring_submit(&ctx->fdmon_io_uring) == -EINTR) {
+            /* Keep trying if syscall was interrupted */
+        }
+    }
+}
+
+static bool fdmon_io_uring_gsource_check(AioContext *ctx)
+{
+    gpointer tag = ctx->io_uring_fd_tag;
+    return g_source_query_unix_fd(&ctx->source, tag) & G_IO_IN;
+}
+
+/* This is where CQEs are processed in the glib event loop */
+static void fdmon_io_uring_gsource_dispatch(AioContext *ctx,
+                                            AioHandlerList *ready_list)
+{
+    process_cq_ring(ctx, ready_list);
+}
+
 static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
                                int64_t timeout)
 {
@@ -339,12 +368,17 @@ static const FDMonOps fdmon_io_uring_ops = {
     .update = fdmon_io_uring_update,
     .wait = fdmon_io_uring_wait,
     .need_wait = fdmon_io_uring_need_wait,
+    .gsource_prepare = fdmon_io_uring_gsource_prepare,
+    .gsource_check = fdmon_io_uring_gsource_check,
+    .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
 };
 
 bool fdmon_io_uring_setup(AioContext *ctx)
 {
     int ret;
 
+    ctx->io_uring_fd_tag = NULL;
+
     ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
     if (ret != 0) {
         return false;
@@ -352,6 +386,9 @@ bool fdmon_io_uring_setup(AioContext *ctx)
 
     QSLIST_INIT(&ctx->submit_list);
     ctx->fdmon_ops = &fdmon_io_uring_ops;
+    ctx->io_uring_fd_tag = g_source_add_unix_fd(&ctx->source,
+            ctx->fdmon_io_uring.ring_fd, G_IO_IN);
+
     return true;
 }
 
@@ -379,6 +416,11 @@ void fdmon_io_uring_destroy(AioContext *ctx)
             QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
         }
 
-        ctx->fdmon_ops = &fdmon_poll_ops;
+        g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
+        ctx->io_uring_fd_tag = NULL;
+
+        qemu_lockcnt_lock(&ctx->list_lock);
+        fdmon_poll_downgrade(ctx);
+        qemu_lockcnt_unlock(&ctx->list_lock);
     }
 }
diff --git a/util/fdmon-poll.c b/util/fdmon-poll.c
index 17df917cf9..0ae755cc13 100644
--- a/util/fdmon-poll.c
+++ b/util/fdmon-poll.c
@@ -72,6 +72,11 @@ static int fdmon_poll_wait(AioContext *ctx, AioHandlerList *ready_list,
 
     /* epoll(7) is faster above a certain number of fds */
     if (fdmon_epoll_try_upgrade(ctx, npfd)) {
+        QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
+            if (!QLIST_IS_INSERTED(node, node_deleted) && node->pfd.events) {
+                g_source_remove_poll(&ctx->source, &node->pfd);
+            }
+        }
         npfd = 0; /* we won't need pollfds[], reset npfd */
         return ctx->fdmon_ops->wait(ctx, ready_list, timeout);
     }
@@ -97,11 +102,89 @@ static void fdmon_poll_update(AioContext *ctx,
                               AioHandler *old_node,
                               AioHandler *new_node)
 {
-    /* Do nothing, AioHandler already contains the state we'll need */
+    if (old_node) {
+        /*
+         * If the GSource is in the process of being destroyed then
+         * g_source_remove_poll() causes an assertion failure.  Skip removal in
+         * that case, because glib cleans up its state during destruction
+         * anyway.
+         */
+        if (!g_source_is_destroyed(&ctx->source)) {
+            g_source_remove_poll(&ctx->source, &old_node->pfd);
+        }
+    }
+
+    if (new_node) {
+        g_source_add_poll(&ctx->source, &new_node->pfd);
+    }
+}
+
+static void fdmon_poll_gsource_prepare(AioContext *ctx)
+{
+    /* Do nothing */
+}
+
+static bool fdmon_poll_gsource_check(AioContext *ctx)
+{
+    AioHandler *node;
+    bool result = false;
+
+    /*
+     * We have to walk very carefully in case aio_set_fd_handler is
+     * called while we're walking.
+     */
+    qemu_lockcnt_inc(&ctx->list_lock);
+
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
+        int revents = node->pfd.revents & node->pfd.events;
+
+        if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read) {
+            result = true;
+            break;
+        }
+        if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write) {
+            result = true;
+            break;
+        }
+    }
+
+    qemu_lockcnt_dec(&ctx->list_lock);
+
+    return result;
+}
+
+static void fdmon_poll_gsource_dispatch(AioContext *ctx,
+                                        AioHandlerList *ready_list)
+{
+    AioHandler *node;
+
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
+        int revents = node->pfd.revents;
+
+        if (revents) {
+            aio_add_ready_handler(ready_list, node, revents);
+        }
+    }
 }
 
 const FDMonOps fdmon_poll_ops = {
     .update = fdmon_poll_update,
     .wait = fdmon_poll_wait,
     .need_wait = aio_poll_disabled,
+    .gsource_prepare = fdmon_poll_gsource_prepare,
+    .gsource_check = fdmon_poll_gsource_check,
+    .gsource_dispatch = fdmon_poll_gsource_dispatch,
 };
+
+void fdmon_poll_downgrade(AioContext *ctx)
+{
+    AioHandler *node;
+
+    ctx->fdmon_ops = &fdmon_poll_ops;
+
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
+        if (!QLIST_IS_INSERTED(node, node_deleted) && node->pfd.events) {
+            g_source_add_poll(&ctx->source, &node->pfd);
+        }
+    }
+}
-- 
2.51.1


