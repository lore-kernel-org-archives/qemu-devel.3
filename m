Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C97D10F26
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkq2-0002fu-8l; Sun, 17 Nov 2024 14:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkpz-0002fR-2U
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:36 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkpw-0005s9-Pe
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:34 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkpt-00000002GTN-1Kvp; Sun, 17 Nov 2024 20:21:29 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool support
Date: Sun, 17 Nov 2024 20:19:59 +0100
Message-ID: <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/block/thread-pool.h |   9 +++
 util/thread-pool.c          | 109 ++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 6f27eb085b45..3f9f66307b65 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -38,5 +38,14 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
 int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
 void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
 
+typedef struct ThreadPool ThreadPool;
+
+ThreadPool *thread_pool_new(void);
+void thread_pool_free(ThreadPool *pool);
+void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
+                        void *opaque, GDestroyNotify opaque_destroy);
+void thread_pool_wait(ThreadPool *pool);
+bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
+bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);
 
 #endif
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 908194dc070f..d80c4181c897 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -374,3 +374,112 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
     qemu_mutex_destroy(&pool->lock);
     g_free(pool);
 }
+
+struct ThreadPool { /* type safety */
+    GThreadPool *t;
+    size_t unfinished_el_ctr;
+    QemuMutex unfinished_el_ctr_mutex;
+    QemuCond unfinished_el_ctr_zero_cond;
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
+    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
+
+    assert(pool->unfinished_el_ctr > 0);
+    pool->unfinished_el_ctr--;
+
+    if (pool->unfinished_el_ctr == 0) {
+        qemu_cond_signal(&pool->unfinished_el_ctr_zero_cond);
+    }
+}
+
+ThreadPool *thread_pool_new(void)
+{
+    ThreadPool *pool = g_new(ThreadPool, 1);
+
+    pool->unfinished_el_ctr = 0;
+    qemu_mutex_init(&pool->unfinished_el_ctr_mutex);
+    qemu_cond_init(&pool->unfinished_el_ctr_zero_cond);
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
+    g_thread_pool_free(pool->t, FALSE, TRUE);
+
+    qemu_cond_destroy(&pool->unfinished_el_ctr_zero_cond);
+    qemu_mutex_destroy(&pool->unfinished_el_ctr_mutex);
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
+    WITH_QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex) {
+        pool->unfinished_el_ctr++;
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
+void thread_pool_wait(ThreadPool *pool)
+{
+    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
+
+    if (pool->unfinished_el_ctr > 0) {
+        qemu_cond_wait(&pool->unfinished_el_ctr_zero_cond,
+                       &pool->unfinished_el_ctr_mutex);
+        assert(pool->unfinished_el_ctr == 0);
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
+    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
+
+    return thread_pool_set_max_threads(pool, pool->unfinished_el_ctr);
+}

