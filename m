Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0738AC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaO3-0008Ae-TW; Tue, 04 Mar 2025 17:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaO1-00087n-An
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:13 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNz-0000a1-4z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:13 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNv-00000000LWw-3UN3; Tue, 04 Mar 2025 23:05:07 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 04/36] thread-pool: Implement generic (non-AIO) pool support
Date: Tue,  4 Mar 2025 23:03:31 +0100
Message-ID: <b1efaebdbea7cb7068b8fb74148777012383e12b.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Migration code wants to manage device data sending threads in one place.

QEMU has an existing thread pool implementation, however it is limited
to queuing AIO operations only and essentially has a 1:1 mapping between
the current AioContext and the AIO ThreadPool in use.

Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
GThreadPool.

This brings a few new operations on a pool:
* thread_pool_wait() operation waits until all the submitted work requests
have finished.

* thread_pool_set_max_threads() explicitly sets the maximum thread count
in the pool.

* thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
in the pool to equal the number of still waiting in queue or unfinished work.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/block/thread-pool.h |  51 ++++++++++++++++
 util/thread-pool.c          | 119 ++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 6f27eb085b45..dd48cf07e85f 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -38,5 +38,56 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
 int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
 void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
 
+/* ------------------------------------------- */
+/* Generic thread pool types and methods below */
+typedef struct ThreadPool ThreadPool;
+
+/* Create a new thread pool. Never returns NULL. */
+ThreadPool *thread_pool_new(void);
+
+/*
+ * Free the thread pool.
+ * Waits for all the previously submitted work to complete before performing
+ * the actual freeing operation.
+ */
+void thread_pool_free(ThreadPool *pool);
+
+/*
+ * Submit a new work (task) for the pool.
+ *
+ * @opaque_destroy is an optional GDestroyNotify for the @opaque argument
+ * to the work function at @func.
+ */
+void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
+                        void *opaque, GDestroyNotify opaque_destroy);
+
+/*
+ * Submit a new work (task) for the pool, making sure it starts getting
+ * processed immediately, launching a new thread for it if necessary.
+ *
+ * @opaque_destroy is an optional GDestroyNotify for the @opaque argument
+ * to the work function at @func.
+ */
+void thread_pool_submit_immediate(ThreadPool *pool, ThreadPoolFunc *func,
+                                  void *opaque, GDestroyNotify opaque_destroy);
+
+/*
+ * Wait for all previously submitted work to complete before returning.
+ *
+ * Can be used as a barrier between two sets of tasks executed on a thread
+ * pool without destroying it or in a performance sensitive path where the
+ * caller just wants to wait for all tasks to complete while deferring the
+ * pool free operation for later, less performance sensitive time.
+ */
+void thread_pool_wait(ThreadPool *pool);
+
+/* Set the maximum number of threads in the pool. */
+bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
+
+/*
+ * Adjust the maximum number of threads in the pool to give each task its
+ * own thread (exactly one thread per task).
+ */
+bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);
 
 #endif
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 908194dc070f..d2ead6b72857 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -374,3 +374,122 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
     qemu_mutex_destroy(&pool->lock);
     g_free(pool);
 }
+
+struct ThreadPool {
+    GThreadPool *t;
+    size_t cur_work;
+    QemuMutex cur_work_lock;
+    QemuCond all_finished_cond;
+};
+
+typedef struct {
+    ThreadPoolFunc *func;
+    void *opaque;
+    GDestroyNotify opaque_destroy;
+} ThreadPoolElement;
+
+static void thread_pool_func(gpointer data, gpointer user_data)
+{
+    ThreadPool *pool = user_data;
+    g_autofree ThreadPoolElement *el = data;
+
+    el->func(el->opaque);
+
+    if (el->opaque_destroy) {
+        el->opaque_destroy(el->opaque);
+    }
+
+    QEMU_LOCK_GUARD(&pool->cur_work_lock);
+
+    assert(pool->cur_work > 0);
+    pool->cur_work--;
+
+    if (pool->cur_work == 0) {
+        qemu_cond_signal(&pool->all_finished_cond);
+    }
+}
+
+ThreadPool *thread_pool_new(void)
+{
+    ThreadPool *pool = g_new(ThreadPool, 1);
+
+    pool->cur_work = 0;
+    qemu_mutex_init(&pool->cur_work_lock);
+    qemu_cond_init(&pool->all_finished_cond);
+
+    pool->t = g_thread_pool_new(thread_pool_func, pool, 0, TRUE, NULL);
+    /*
+     * g_thread_pool_new() can only return errors if initial thread(s)
+     * creation fails but we ask for 0 initial threads above.
+     */
+    assert(pool->t);
+
+    return pool;
+}
+
+void thread_pool_free(ThreadPool *pool)
+{
+    /*
+     * With _wait = TRUE this effectively waits for all
+     * previously submitted work to complete first.
+     */
+    g_thread_pool_free(pool->t, FALSE, TRUE);
+
+    qemu_cond_destroy(&pool->all_finished_cond);
+    qemu_mutex_destroy(&pool->cur_work_lock);
+
+    g_free(pool);
+}
+
+void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
+                        void *opaque, GDestroyNotify opaque_destroy)
+{
+    ThreadPoolElement *el = g_new(ThreadPoolElement, 1);
+
+    el->func = func;
+    el->opaque = opaque;
+    el->opaque_destroy = opaque_destroy;
+
+    WITH_QEMU_LOCK_GUARD(&pool->cur_work_lock) {
+        pool->cur_work++;
+    }
+
+    /*
+     * Ignore the return value since this function can only return errors
+     * if creation of an additional thread fails but even in this case the
+     * provided work is still getting queued (just for the existing threads).
+     */
+    g_thread_pool_push(pool->t, el, NULL);
+}
+
+void thread_pool_submit_immediate(ThreadPool *pool, ThreadPoolFunc *func,
+                                  void *opaque, GDestroyNotify opaque_destroy)
+{
+    thread_pool_submit(pool, func, opaque, opaque_destroy);
+    thread_pool_adjust_max_threads_to_work(pool);
+}
+
+void thread_pool_wait(ThreadPool *pool)
+{
+    QEMU_LOCK_GUARD(&pool->cur_work_lock);
+
+    while (pool->cur_work > 0) {
+        qemu_cond_wait(&pool->all_finished_cond,
+                       &pool->cur_work_lock);
+    }
+}
+
+bool thread_pool_set_max_threads(ThreadPool *pool,
+                                 int max_threads)
+{
+    assert(max_threads > 0);
+
+    return g_thread_pool_set_max_threads(pool->t, max_threads, NULL);
+}
+
+bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool)
+{
+    QEMU_LOCK_GUARD(&pool->cur_work_lock);
+
+    return thread_pool_set_max_threads(pool, pool->cur_work);
+}

