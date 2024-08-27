Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3474DC54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Pz-0005JV-GT; Tue, 27 Aug 2024 13:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Pv-00059R-KM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:43 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Ph-0001ZH-UZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:43 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0PS-0002Lw-F1; Tue, 27 Aug 2024 19:55:14 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 04/17] thread-pool: Add a DestroyNotify parameter to
 thread_pool_submit{, _aio)()
Date: Tue, 27 Aug 2024 19:54:23 +0200
Message-ID: <7e14c1ea1ca1797ac5658033398f2bde22c6a364.1724701542.git.maciej.szmigiero@oracle.com>
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

Automatic memory management is less prone to mistakes or confusion
who is responsible for freeing the memory backing the "arg" parameter
or dropping a strong reference to object pointed by this parameter.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 backends/tpm/tpm_backend.c    |  2 +-
 block/file-win32.c            |  2 +-
 hw/9pfs/coth.c                |  3 ++-
 hw/ppc/spapr_nvdimm.c         |  4 ++--
 hw/virtio/virtio-pmem.c       |  2 +-
 include/block/thread-pool.h   |  6 ++++--
 tests/unit/test-thread-pool.c |  8 ++++----
 util/thread-pool.c            | 16 ++++++++++++----
 8 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/backends/tpm/tpm_backend.c b/backends/tpm/tpm_backend.c
index 485a20b9e09f..65ef961b59ae 100644
--- a/backends/tpm/tpm_backend.c
+++ b/backends/tpm/tpm_backend.c
@@ -107,7 +107,7 @@ void tpm_backend_deliver_request(TPMBackend *s, TPMBackendCmd *cmd)
 
     s->cmd = cmd;
     object_ref(OBJECT(s));
-    thread_pool_submit_aio(tpm_backend_worker_thread, s,
+    thread_pool_submit_aio(tpm_backend_worker_thread, s, NULL,
                            tpm_backend_request_completed, s);
 }
 
diff --git a/block/file-win32.c b/block/file-win32.c
index 7e1baa1ece6a..9b99ae2f89e1 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -167,7 +167,7 @@ static BlockAIOCB *paio_submit(BlockDriverState *bs, HANDLE hfile,
     acb->aio_offset = offset;
 
     trace_file_paio_submit(acb, opaque, offset, count, type);
-    return thread_pool_submit_aio(aio_worker, acb, cb, opaque);
+    return thread_pool_submit_aio(aio_worker, acb, NULL, cb, opaque);
 }
 
 int qemu_ftruncate64(int fd, int64_t length)
diff --git a/hw/9pfs/coth.c b/hw/9pfs/coth.c
index 598f46add993..fe5bfa6920fe 100644
--- a/hw/9pfs/coth.c
+++ b/hw/9pfs/coth.c
@@ -41,5 +41,6 @@ static int coroutine_enter_func(void *arg)
 void co_run_in_worker_bh(void *opaque)
 {
     Coroutine *co = opaque;
-    thread_pool_submit_aio(coroutine_enter_func, co, coroutine_enter_cb, co);
+    thread_pool_submit_aio(coroutine_enter_func, co, NULL,
+                           coroutine_enter_cb, co);
 }
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 7d2dfe5e3d2f..f9ee45935d1d 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -517,7 +517,7 @@ static int spapr_nvdimm_flush_post_load(void *opaque, int version_id)
     }
 
     QLIST_FOREACH(state, &s_nvdimm->pending_nvdimm_flush_states, node) {
-        thread_pool_submit_aio(flush_worker_cb, state,
+        thread_pool_submit_aio(flush_worker_cb, state, NULL,
                                spapr_nvdimm_flush_completion_cb, state);
     }
 
@@ -698,7 +698,7 @@ static target_ulong h_scm_flush(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
         state->drcidx = drc_index;
 
-        thread_pool_submit_aio(flush_worker_cb, state,
+        thread_pool_submit_aio(flush_worker_cb, state, NULL,
                                spapr_nvdimm_flush_completion_cb, state);
 
         continue_token = state->continue_token;
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c3512c2dae3f..f1331c03f474 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -87,7 +87,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
     req_data->fd   = memory_region_get_fd(&backend->mr);
     req_data->pmem = pmem;
     req_data->vdev = vdev;
-    thread_pool_submit_aio(worker_cb, req_data, done_cb, req_data);
+    thread_pool_submit_aio(worker_cb, req_data, NULL, done_cb, req_data);
 }
 
 static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config)
diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 948ff5f30c31..b484c4780ea6 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -33,10 +33,12 @@ void thread_pool_free(ThreadPool *pool);
  * thread_pool_submit* API: submit I/O requests in the thread's
  * current AioContext.
  */
-BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
+BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
+                                   void *arg, GDestroyNotify arg_destroy,
                                    BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
-void thread_pool_submit(ThreadPoolFunc *func, void *arg);
+void thread_pool_submit(ThreadPoolFunc *func,
+                        void *arg, GDestroyNotify arg_destroy);
 
 void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
 
diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
index 1483e53473db..e4afb9e36292 100644
--- a/tests/unit/test-thread-pool.c
+++ b/tests/unit/test-thread-pool.c
@@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
 static void test_submit(void)
 {
     WorkerTestData data = { .n = 0 };
-    thread_pool_submit(worker_cb, &data);
+    thread_pool_submit(worker_cb, &data, NULL);
     while (data.n == 0) {
         aio_poll(ctx, true);
     }
@@ -56,7 +56,7 @@ static void test_submit(void)
 static void test_submit_aio(void)
 {
     WorkerTestData data = { .n = 0, .ret = -EINPROGRESS };
-    data.aiocb = thread_pool_submit_aio(worker_cb, &data,
+    data.aiocb = thread_pool_submit_aio(worker_cb, &data, NULL,
                                         done_cb, &data);
 
     /* The callbacks are not called until after the first wait.  */
@@ -121,7 +121,7 @@ static void test_submit_many(void)
     for (i = 0; i < 100; i++) {
         data[i].n = 0;
         data[i].ret = -EINPROGRESS;
-        thread_pool_submit_aio(worker_cb, &data[i], done_cb, &data[i]);
+        thread_pool_submit_aio(worker_cb, &data[i], NULL, done_cb, &data[i]);
     }
 
     active = 100;
@@ -149,7 +149,7 @@ static void do_test_cancel(bool sync)
     for (i = 0; i < 100; i++) {
         data[i].n = 0;
         data[i].ret = -EINPROGRESS;
-        data[i].aiocb = thread_pool_submit_aio(long_cb, &data[i],
+        data[i].aiocb = thread_pool_submit_aio(long_cb, &data[i], NULL,
                                                done_cb, &data[i]);
     }
 
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 27eb777e855b..69a87ee79252 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -38,6 +38,7 @@ struct ThreadPoolElement {
     ThreadPool *pool;
     ThreadPoolFunc *func;
     void *arg;
+    GDestroyNotify arg_destroy;
 
     /* Moving state out of THREAD_QUEUED is protected by lock.  After
      * that, only the worker thread can write to it.  Reads and writes
@@ -188,6 +189,10 @@ restart:
                                    elem->ret);
         QLIST_REMOVE(elem, all);
 
+        if (elem->arg_destroy) {
+            elem->arg_destroy(elem->arg);
+        }
+
         if (elem->common.cb) {
             /* Read state before ret.  */
             smp_rmb();
@@ -238,7 +243,8 @@ static const AIOCBInfo thread_pool_aiocb_info = {
     .cancel_async       = thread_pool_cancel,
 };
 
-BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
+BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
+                                   void *arg, GDestroyNotify arg_destroy,
                                    BlockCompletionFunc *cb, void *opaque)
 {
     ThreadPoolElement *req;
@@ -251,6 +257,7 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
     req = qemu_aio_get(&thread_pool_aiocb_info, NULL, cb, opaque);
     req->func = func;
     req->arg = arg;
+    req->arg_destroy = arg_destroy;
     req->state = THREAD_QUEUED;
     req->pool = pool;
 
@@ -285,14 +292,15 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
 {
     ThreadPoolCo tpc = { .co = qemu_coroutine_self(), .ret = -EINPROGRESS };
     assert(qemu_in_coroutine());
-    thread_pool_submit_aio(func, arg, thread_pool_co_cb, &tpc);
+    thread_pool_submit_aio(func, arg, NULL, thread_pool_co_cb, &tpc);
     qemu_coroutine_yield();
     return tpc.ret;
 }
 
-void thread_pool_submit(ThreadPoolFunc *func, void *arg)
+void thread_pool_submit(ThreadPoolFunc *func,
+                        void *arg, GDestroyNotify arg_destroy)
 {
-    thread_pool_submit_aio(func, arg, NULL, NULL);
+    thread_pool_submit_aio(func, arg, arg_destroy, NULL, NULL);
 }
 
 void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)

