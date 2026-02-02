Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337E8E7FDC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmztV-0000Py-6w; Mon, 02 Feb 2026 14:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztR-0000Nu-9S; Mon, 02 Feb 2026 14:47:30 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztP-0003Ee-7B; Mon, 02 Feb 2026 14:47:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A54318509E;
 Mon, 02 Feb 2026 22:46:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1BABA35B280;
 Mon, 02 Feb 2026 22:46:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 12/69] nvme: Note in which AioContext some functions
 run
Date: Mon,  2 Feb 2026 22:45:35 +0300
Message-ID: <20260202194638.939438-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hanna Czenczek <hreitz@redhat.com>

Sprinkle comments throughout block/nvme.c noting for some functions
(where it may not be obvious) that they require a certain AioContext, or
in which AioContext they do happen to run (for callbacks, BHs, event
notifiers).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-10-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ac3520f599fedee05945ce06bb0f71820a7b2ffc)
(Mjt: pick this comments-only, no-code-changes commit to 10.0.x
 so the next change applies cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nvme.c b/block/nvme.c
index 2e93abdb4b..bef515e903 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -64,6 +64,7 @@ typedef struct {
 } NVMeQueue;
 
 typedef struct {
+    /* Called from nvme_process_completion() in the BDS's main AioContext */
     BlockCompletionFunc *cb;
     void *opaque;
     int cid;
@@ -83,6 +84,7 @@ typedef struct {
     uint8_t     *prp_list_pages;
 
     /* Fields protected by @lock */
+    /* Coroutines in this queue are woken in their own context */
     CoQueue     free_req_queue;
     NVMeQueue   sq, cq;
     int         cq_phase;
@@ -91,7 +93,7 @@ typedef struct {
     int         need_kick;
     int         inflight;
 
-    /* Thread-safe, no lock necessary */
+    /* Thread-safe, no lock necessary; runs in the BDS's main context */
     QEMUBH      *completion_bh;
 } NVMeQueuePair;
 
@@ -205,11 +207,13 @@ static void nvme_free_queue_pair(NVMeQueuePair *q)
     g_free(q);
 }
 
+/* Runs in the BDS's main AioContext */
 static void nvme_free_req_queue_cb(void *opaque)
 {
     NVMeQueuePair *q = opaque;
 
     qemu_mutex_lock(&q->lock);
+    /* qemu_co_enter_next() wakes the coroutine in its own AioContext */
     while (q->free_req_head != -1 &&
            qemu_co_enter_next(&q->free_req_queue, &q->lock)) {
         /* Retry waiting requests */
@@ -280,7 +284,7 @@ fail:
     return NULL;
 }
 
-/* With q->lock */
+/* With q->lock, must be run in the BDS's main AioContext */
 static void nvme_kick(NVMeQueuePair *q)
 {
     BDRVNVMeState *s = q->s;
@@ -307,7 +311,10 @@ static NVMeRequest *nvme_get_free_req_nofail_locked(NVMeQueuePair *q)
     return req;
 }
 
-/* Return a free request element if any, otherwise return NULL.  */
+/*
+ * Return a free request element if any, otherwise return NULL.
+ * May be run from any AioContext.
+ */
 static NVMeRequest *nvme_get_free_req_nowait(NVMeQueuePair *q)
 {
     QEMU_LOCK_GUARD(&q->lock);
@@ -320,6 +327,7 @@ static NVMeRequest *nvme_get_free_req_nowait(NVMeQueuePair *q)
 /*
  * Wait for a free request to become available if necessary, then
  * return it.
+ * May be called in any AioContext.
  */
 static coroutine_fn NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
 {
@@ -327,20 +335,21 @@ static coroutine_fn NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
 
     while (q->free_req_head == -1) {
         trace_nvme_free_req_queue_wait(q->s, q->index);
+        /* nvme_free_req_queue_cb() wakes us in our own AioContext */
         qemu_co_queue_wait(&q->free_req_queue, &q->lock);
     }
 
     return nvme_get_free_req_nofail_locked(q);
 }
 
-/* With q->lock */
+/* With q->lock, may be called in any AioContext */
 static void nvme_put_free_req_locked(NVMeQueuePair *q, NVMeRequest *req)
 {
     req->free_req_next = q->free_req_head;
     q->free_req_head = req - q->reqs;
 }
 
-/* With q->lock */
+/* With q->lock, may be called in any AioContext */
 static void nvme_wake_free_req_locked(NVMeQueuePair *q)
 {
     if (!qemu_co_queue_empty(&q->free_req_queue)) {
@@ -349,7 +358,7 @@ static void nvme_wake_free_req_locked(NVMeQueuePair *q)
     }
 }
 
-/* Insert a request in the freelist and wake waiters */
+/* Insert a request in the freelist and wake waiters (from any AioContext) */
 static void nvme_put_free_req_and_wake(NVMeQueuePair *q, NVMeRequest *req)
 {
     qemu_mutex_lock(&q->lock);
@@ -380,7 +389,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
     }
 }
 
-/* With q->lock */
+/* With q->lock, must be run in the BDS's main AioContext */
 static bool nvme_process_completion(NVMeQueuePair *q)
 {
     BDRVNVMeState *s = q->s;
@@ -450,6 +459,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
     return progress;
 }
 
+/* As q->completion_bh, runs in the BDS's main AioContext */
 static void nvme_process_completion_bh(void *opaque)
 {
     NVMeQueuePair *q = opaque;
@@ -480,6 +490,7 @@ static void nvme_trace_command(const NvmeCmd *cmd)
     }
 }
 
+/* Must be run in the BDS's main AioContext */
 static void nvme_kick_and_check_completions(void *opaque)
 {
     NVMeQueuePair *q = opaque;
@@ -489,6 +500,7 @@ static void nvme_kick_and_check_completions(void *opaque)
     nvme_process_completion(q);
 }
 
+/* Runs in nvme_submit_command()'s AioContext */
 static void nvme_deferred_fn(void *opaque)
 {
     NVMeQueuePair *q = opaque;
@@ -501,6 +513,7 @@ static void nvme_deferred_fn(void *opaque)
     }
 }
 
+/* May be run in any AioContext */
 static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
                                 NvmeCmd *cmd, BlockCompletionFunc cb,
                                 void *opaque)
@@ -522,6 +535,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
     defer_call(nvme_deferred_fn, q);
 }
 
+/* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
 static void nvme_admin_cmd_sync_cb(void *opaque, int ret)
 {
     int *pret = opaque;
@@ -529,6 +543,7 @@ static void nvme_admin_cmd_sync_cb(void *opaque, int ret)
     aio_wait_kick();
 }
 
+/* Must be run in the BDS's or qemu's main AioContext */
 static int nvme_admin_cmd_sync(BlockDriverState *bs, NvmeCmd *cmd)
 {
     BDRVNVMeState *s = bs->opaque;
@@ -637,6 +652,7 @@ out:
     return ret;
 }
 
+/* Must be run in the BDS's main AioContext */
 static void nvme_poll_queue(NVMeQueuePair *q)
 {
     const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
@@ -659,6 +675,7 @@ static void nvme_poll_queue(NVMeQueuePair *q)
     qemu_mutex_unlock(&q->lock);
 }
 
+/* Must be run in the BDS's main AioContext */
 static void nvme_poll_queues(BDRVNVMeState *s)
 {
     int i;
@@ -668,6 +685,7 @@ static void nvme_poll_queues(BDRVNVMeState *s)
     }
 }
 
+/* Run as an event notifier in the BDS's main AioContext */
 static void nvme_handle_event(EventNotifier *n)
 {
     BDRVNVMeState *s = container_of(n, BDRVNVMeState,
@@ -721,6 +739,7 @@ out_error:
     return false;
 }
 
+/* Run as an event notifier in the BDS's main AioContext */
 static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
@@ -744,6 +763,7 @@ static bool nvme_poll_cb(void *opaque)
     return false;
 }
 
+/* Run as an event notifier in the BDS's main AioContext */
 static void nvme_poll_ready(EventNotifier *e)
 {
     BDRVNVMeState *s = container_of(e, BDRVNVMeState,
@@ -1045,7 +1065,7 @@ static int nvme_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
     return 0;
 }
 
-/* Called with s->dma_map_lock */
+/* Called with s->dma_map_lock, may be run in any AioContext */
 static coroutine_fn int nvme_cmd_unmap_qiov(BlockDriverState *bs,
                                             QEMUIOVector *qiov)
 {
@@ -1056,13 +1076,17 @@ static coroutine_fn int nvme_cmd_unmap_qiov(BlockDriverState *bs,
     if (!s->dma_map_count && !qemu_co_queue_empty(&s->dma_flush_queue)) {
         r = qemu_vfio_dma_reset_temporary(s->vfio);
         if (!r) {
+            /*
+             * Queue access is protected by the dma_map_lock, and all
+             * coroutines are woken in their own AioContext
+             */
             qemu_co_queue_restart_all(&s->dma_flush_queue);
         }
     }
     return r;
 }
 
-/* Called with s->dma_map_lock */
+/* Called with s->dma_map_lock, may be run in any AioContext */
 static coroutine_fn int nvme_cmd_map_qiov(BlockDriverState *bs, NvmeCmd *cmd,
                                           NVMeRequest *req, QEMUIOVector *qiov)
 {
@@ -1175,6 +1199,7 @@ typedef struct {
     int ret;
 } NVMeCoData;
 
+/* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NVMeCoData *data = opaque;
-- 
2.47.3


