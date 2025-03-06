Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A07FC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC0z-000842-I2; Thu, 06 Mar 2025 09:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0Z-0007MF-26
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0S-0001nK-1r
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORsMgR5tNUkV2umt2LiJWC8AWrhfAOEM9RMcEU3OdRk=;
 b=YMj673rgglNVZFQW5cZL6uDp9JZgV/qPIJqdypq+CPVJOm0nVcbZ89tpPml6fjwzD2xrR8
 wdIzdBlRPKECvEIFU0pw+T4w9qxAH3lzXU8iz5dTUxXwaAwtq3eaBnQxRaCXOXYuhWlMHG
 cukj3+9qVFamHvQ6KiqCa4X5hUNejVI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-ZqouXhPaO6CfDQxDWiUCDg-1; Thu,
 06 Mar 2025 09:15:10 -0500
X-MC-Unique: ZqouXhPaO6CfDQxDWiUCDg-1
X-Mimecast-MFC-AGG-ID: ZqouXhPaO6CfDQxDWiUCDg_1741270510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D978A180AF5B; Thu,  6 Mar 2025 14:15:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF79D18001D3; Thu,  6 Mar 2025 14:15:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/42] thread-pool: Implement generic (non-AIO) pool support
Date: Thu,  6 Mar 2025 15:13:49 +0100
Message-ID: <20250306141419.2015340-14-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/b1efaebdbea7cb7068b8fb74148777012383e12b.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/block/thread-pool.h |  51 ++++++++++++++++
 util/thread-pool.c          | 119 ++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 6f27eb085b451ecc712aeff385944541a729c83d..dd48cf07e85f886e9efc44916e4018141f352233 100644
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
index 908194dc070fb90390c493f0c7fb10062dcb5c15..d2ead6b7285765821f0fa956132b207b5985b015 100644
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
-- 
2.48.1


