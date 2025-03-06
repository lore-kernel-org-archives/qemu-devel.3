Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98CCC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC0v-0007qy-Ic; Thu, 06 Mar 2025 09:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0F-0007AT-Nq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0D-0001mG-1K
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaUCwVBWNisuA+DLJLKKBbuf+EdU9eDWEbHvI3b6clg=;
 b=PEH6eB3HFVdLaJG/fK3Bta9gK7ReZlQb68OGm10jcjZo7+o3gz7PLdPGAq5PGqB+lE2o8U
 TAykSit+volRP9OJz6XX6Ilk76Qgddz8LO4b5KMFojKsfdpIb6PzHwvmVJ6e2t2NmRu7TJ
 WbnK+WmdrC1b8bAL/peLyZBrdrSAVZA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-N7jfAxwKPCG_AgiubYe-6A-1; Thu,
 06 Mar 2025 09:15:05 -0500
X-MC-Unique: N7jfAxwKPCG_AgiubYe-6A-1
X-Mimecast-MFC-AGG-ID: N7jfAxwKPCG_AgiubYe-6A_1741270504
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1948180025B; Thu,  6 Mar 2025 14:15:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CE5818009BC; Thu,  6 Mar 2025 14:15:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 11/42] thread-pool: Remove thread_pool_submit() function
Date: Thu,  6 Mar 2025 15:13:47 +0100
Message-ID: <20250306141419.2015340-12-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This function name conflicts with one used by a future generic thread pool
function and it was only used by one test anyway.

Update the trace event name in thread_pool_submit_aio() accordingly.

Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/6830f07777f939edaf0a2d301c39adcaaf3817f0.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/block/thread-pool.h   | 3 +--
 tests/unit/test-thread-pool.c | 6 +++---
 util/thread-pool.c            | 7 +------
 util/trace-events             | 2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 948ff5f30c31de452361578dec9fa252817b4a69..4f6694026123e2b6b503eab3ee23cf51db4bdef1 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -30,13 +30,12 @@ ThreadPool *thread_pool_new(struct AioContext *ctx);
 void thread_pool_free(ThreadPool *pool);
 
 /*
- * thread_pool_submit* API: submit I/O requests in the thread's
+ * thread_pool_submit_{aio,co} API: submit I/O requests in the thread's
  * current AioContext.
  */
 BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
                                    BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
-void thread_pool_submit(ThreadPoolFunc *func, void *arg);
 
 void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
 
diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
index 1483e53473db56d43508fc3c4363dbdfbd64cf1f..33407b595d3565614c631a58759bc55be1bcfac3 100644
--- a/tests/unit/test-thread-pool.c
+++ b/tests/unit/test-thread-pool.c
@@ -43,10 +43,10 @@ static void done_cb(void *opaque, int ret)
     active--;
 }
 
-static void test_submit(void)
+static void test_submit_no_complete(void)
 {
     WorkerTestData data = { .n = 0 };
-    thread_pool_submit(worker_cb, &data);
+    thread_pool_submit_aio(worker_cb, &data, NULL, NULL);
     while (data.n == 0) {
         aio_poll(ctx, true);
     }
@@ -236,7 +236,7 @@ int main(int argc, char **argv)
     ctx = qemu_get_current_aio_context();
 
     g_test_init(&argc, &argv, NULL);
-    g_test_add_func("/thread-pool/submit", test_submit);
+    g_test_add_func("/thread-pool/submit-no-complete", test_submit_no_complete);
     g_test_add_func("/thread-pool/submit-aio", test_submit_aio);
     g_test_add_func("/thread-pool/submit-co", test_submit_co);
     g_test_add_func("/thread-pool/submit-many", test_submit_many);
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 27eb777e855b62818a64cc5ad4f4937903b64ed1..2f751d55b33ffcbde584c99030c5b46b583b87d3 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -256,7 +256,7 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
 
     QLIST_INSERT_HEAD(&pool->head, req, all);
 
-    trace_thread_pool_submit(pool, req, arg);
+    trace_thread_pool_submit_aio(pool, req, arg);
 
     qemu_mutex_lock(&pool->lock);
     if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
@@ -290,11 +290,6 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
     return tpc.ret;
 }
 
-void thread_pool_submit(ThreadPoolFunc *func, void *arg)
-{
-    thread_pool_submit_aio(func, arg, NULL, NULL);
-}
-
 void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
 {
     qemu_mutex_lock(&pool->lock);
diff --git a/util/trace-events b/util/trace-events
index 49a4962e18869d9793349283fce5c5d4a33efe3e..5be12d7fab8943458097d7d03bf1fe41e330aba6 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -14,7 +14,7 @@ aio_co_schedule_bh_cb(void *ctx, void *co) "ctx %p co %p"
 reentrant_aio(void *ctx, const char *name) "ctx %p name %s"
 
 # thread-pool.c
-thread_pool_submit(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
+thread_pool_submit_aio(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
 thread_pool_complete(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
 thread_pool_cancel(void *req, void *opaque) "req %p opaque %p"
 
-- 
2.48.1


