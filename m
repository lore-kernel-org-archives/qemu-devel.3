Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13D5C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Q5-0005ns-EN; Tue, 27 Aug 2024 13:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Px-0005FF-20
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:45 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Pl-0001Zc-3H
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:44 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0PX-0002MW-Nt; Tue, 27 Aug 2024 19:55:19 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool support
Date: Tue, 27 Aug 2024 19:54:24 +0200
Message-ID: <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Migration code wants to manage device data sending threads in one place.

QEMU has an existing thread pool implementation, however it was limited
to queuing AIO operations only and essentially had a 1:1 mapping between
the current AioContext and the ThreadPool in use.

Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
too.

This brings a few new operations on a pool:
* thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
thread count in the pool.

* thread_pool_join() operation waits until all the submitted work requests
have finished.

* thread_pool_poll() lets the new thread and / or thread completion bottom
halves run (if they are indeed scheduled to be run).
It is useful for thread pool users that need to launch or terminate new
threads without returning to the QEMU main loop.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/block/thread-pool.h   | 10 ++++-
 tests/unit/test-thread-pool.c |  2 +-
 util/thread-pool.c            | 77 ++++++++++++++++++++++++++++++-----
 3 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index b484c4780ea6..1769496056cd 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -37,9 +37,15 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
                                    void *arg, GDestroyNotify arg_destroy,
                                    BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
-void thread_pool_submit(ThreadPoolFunc *func,
-                        void *arg, GDestroyNotify arg_destroy);
+BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
+                               void *arg, GDestroyNotify arg_destroy,
+                               BlockCompletionFunc *cb, void *opaque);
 
+void thread_pool_join(ThreadPool *pool);
+void thread_pool_poll(ThreadPool *pool);
+
+void thread_pool_set_minmax_threads(ThreadPool *pool,
+                                    int min_threads, int max_threads);
 void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
 
 #endif
diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
index e4afb9e36292..469c0f7057b6 100644
--- a/tests/unit/test-thread-pool.c
+++ b/tests/unit/test-thread-pool.c
@@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
 static void test_submit(void)
 {
     WorkerTestData data = { .n = 0 };
-    thread_pool_submit(worker_cb, &data, NULL);
+    thread_pool_submit(NULL, worker_cb, &data, NULL, NULL, NULL);
     while (data.n == 0) {
         aio_poll(ctx, true);
     }
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 69a87ee79252..2bf3be875a51 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -60,6 +60,7 @@ struct ThreadPool {
     QemuMutex lock;
     QemuCond worker_stopped;
     QemuCond request_cond;
+    QemuCond no_requests_cond;
     QEMUBH *new_thread_bh;
 
     /* The following variables are only accessed from one AioContext. */
@@ -73,6 +74,7 @@ struct ThreadPool {
     int pending_threads; /* threads created but not running yet */
     int min_threads;
     int max_threads;
+    size_t requests_executing;
 };
 
 static void *worker_thread(void *opaque)
@@ -107,6 +109,10 @@ static void *worker_thread(void *opaque)
         req = QTAILQ_FIRST(&pool->request_list);
         QTAILQ_REMOVE(&pool->request_list, req, reqs);
         req->state = THREAD_ACTIVE;
+
+        assert(pool->requests_executing < SIZE_MAX);
+        pool->requests_executing++;
+
         qemu_mutex_unlock(&pool->lock);
 
         ret = req->func(req->arg);
@@ -118,6 +124,14 @@ static void *worker_thread(void *opaque)
 
         qemu_bh_schedule(pool->completion_bh);
         qemu_mutex_lock(&pool->lock);
+
+        assert(pool->requests_executing > 0);
+        pool->requests_executing--;
+
+        if (pool->requests_executing == 0 &&
+            QTAILQ_EMPTY(&pool->request_list)) {
+            qemu_cond_signal(&pool->no_requests_cond);
+        }
     }
 
     pool->cur_threads--;
@@ -243,13 +257,16 @@ static const AIOCBInfo thread_pool_aiocb_info = {
     .cancel_async       = thread_pool_cancel,
 };
 
-BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
-                                   void *arg, GDestroyNotify arg_destroy,
-                                   BlockCompletionFunc *cb, void *opaque)
+BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
+                               void *arg, GDestroyNotify arg_destroy,
+                               BlockCompletionFunc *cb, void *opaque)
 {
     ThreadPoolElement *req;
     AioContext *ctx = qemu_get_current_aio_context();
-    ThreadPool *pool = aio_get_thread_pool(ctx);
+
+    if (!pool) {
+        pool = aio_get_thread_pool(ctx);
+    }
 
     /* Assert that the thread submitting work is the same running the pool */
     assert(pool->ctx == qemu_get_current_aio_context());
@@ -275,6 +292,18 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
     return &req->common;
 }
 
+BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
+                                   void *arg, GDestroyNotify arg_destroy,
+                                   BlockCompletionFunc *cb, void *opaque)
+{
+    return thread_pool_submit(NULL, func, arg, arg_destroy, cb, opaque);
+}
+
+void thread_pool_poll(ThreadPool *pool)
+{
+    aio_bh_poll(pool->ctx);
+}
+
 typedef struct ThreadPoolCo {
     Coroutine *co;
     int ret;
@@ -297,18 +326,38 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
     return tpc.ret;
 }
 
-void thread_pool_submit(ThreadPoolFunc *func,
-                        void *arg, GDestroyNotify arg_destroy)
+void thread_pool_join(ThreadPool *pool)
 {
-    thread_pool_submit_aio(func, arg, arg_destroy, NULL, NULL);
+    /* Assert that the thread waiting is the same running the pool */
+    assert(pool->ctx == qemu_get_current_aio_context());
+
+    qemu_mutex_lock(&pool->lock);
+
+    if (pool->requests_executing > 0 ||
+        !QTAILQ_EMPTY(&pool->request_list)) {
+        qemu_cond_wait(&pool->no_requests_cond, &pool->lock);
+    }
+    assert(pool->requests_executing == 0 &&
+           QTAILQ_EMPTY(&pool->request_list));
+
+    qemu_mutex_unlock(&pool->lock);
+
+    aio_bh_poll(pool->ctx);
+
+    assert(QLIST_EMPTY(&pool->head));
 }
 
-void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
+void thread_pool_set_minmax_threads(ThreadPool *pool,
+                                    int min_threads, int max_threads)
 {
+    assert(min_threads >= 0);
+    assert(max_threads > 0);
+    assert(max_threads >= min_threads);
+
     qemu_mutex_lock(&pool->lock);
 
-    pool->min_threads = ctx->thread_pool_min;
-    pool->max_threads = ctx->thread_pool_max;
+    pool->min_threads = min_threads;
+    pool->max_threads = max_threads;
 
     /*
      * We either have to:
@@ -330,6 +379,12 @@ void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
     qemu_mutex_unlock(&pool->lock);
 }
 
+void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
+{
+    thread_pool_set_minmax_threads(pool,
+                                   ctx->thread_pool_min, ctx->thread_pool_max);
+}
+
 static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
 {
     if (!ctx) {
@@ -342,6 +397,7 @@ static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
     qemu_mutex_init(&pool->lock);
     qemu_cond_init(&pool->worker_stopped);
     qemu_cond_init(&pool->request_cond);
+    qemu_cond_init(&pool->no_requests_cond);
     pool->new_thread_bh = aio_bh_new(ctx, spawn_thread_bh_fn, pool);
 
     QLIST_INIT(&pool->head);
@@ -382,6 +438,7 @@ void thread_pool_free(ThreadPool *pool)
     qemu_mutex_unlock(&pool->lock);
 
     qemu_bh_delete(pool->completion_bh);
+    qemu_cond_destroy(&pool->no_requests_cond);
     qemu_cond_destroy(&pool->request_cond);
     qemu_cond_destroy(&pool->worker_stopped);
     qemu_mutex_destroy(&pool->lock);

