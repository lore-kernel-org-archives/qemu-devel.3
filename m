Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA44CEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP77-0000Pj-Ie; Tue, 18 Nov 2025 12:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP76-0000N2-79
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP74-0004mH-Bm
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+yC7im+C2p18l24gI2oPCljue+FlW0opE6viWD+S0+Y=;
 b=EG1gBOPvWoVYgTgQqfXTBukyYMr0DGb0kY5DHpjDQMwgVwjTO1UXtHHUnUJ8JH+4ToYPu6
 /ntRRs2qn3jR7gMx77X06C5qujy899l3xeaTyY6a39Ioa4AD08CzmvVpiYH/J/nra9NmRx
 sflK8xTsjdPXzyLddNHGbFXTVuWljKo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-bi46hEPzOcSypzbrmz-g7w-1; Tue,
 18 Nov 2025 12:03:26 -0500
X-MC-Unique: bi46hEPzOcSypzbrmz-g7w-1
X-Mimecast-MFC-AGG-ID: bi46hEPzOcSypzbrmz-g7w_1763485403
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D075C195605C; Tue, 18 Nov 2025 17:03:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 498B2300ABAF; Tue, 18 Nov 2025 17:03:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/19] nvme: Note in which AioContext some functions run
Date: Tue, 18 Nov 2025 18:02:46 +0100
Message-ID: <20251118170256.272087-10-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
---
 block/nvme.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b8262ebfd9..919e14cef9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -65,6 +65,7 @@ typedef struct {
 } NVMeQueue;
 
 typedef struct {
+    /* Called from nvme_process_completion() in the BDS's main AioContext */
     BlockCompletionFunc *cb;
     void *opaque;
     int cid;
@@ -84,6 +85,7 @@ typedef struct {
     uint8_t     *prp_list_pages;
 
     /* Fields protected by @lock */
+    /* Coroutines in this queue are woken in their own context */
     CoQueue     free_req_queue;
     NVMeQueue   sq, cq;
     int         cq_phase;
@@ -92,7 +94,7 @@ typedef struct {
     int         need_kick;
     int         inflight;
 
-    /* Thread-safe, no lock necessary */
+    /* Thread-safe, no lock necessary; runs in the BDS's main context */
     QEMUBH      *completion_bh;
 } NVMeQueuePair;
 
@@ -206,11 +208,13 @@ static void nvme_free_queue_pair(NVMeQueuePair *q)
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
@@ -281,7 +285,7 @@ fail:
     return NULL;
 }
 
-/* With q->lock */
+/* With q->lock, must be run in the BDS's main AioContext */
 static void nvme_kick(NVMeQueuePair *q)
 {
     BDRVNVMeState *s = q->s;
@@ -308,7 +312,10 @@ static NVMeRequest *nvme_get_free_req_nofail_locked(NVMeQueuePair *q)
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
@@ -321,6 +328,7 @@ static NVMeRequest *nvme_get_free_req_nowait(NVMeQueuePair *q)
 /*
  * Wait for a free request to become available if necessary, then
  * return it.
+ * May be called in any AioContext.
  */
 static coroutine_fn NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
 {
@@ -328,20 +336,21 @@ static coroutine_fn NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
 
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
@@ -350,7 +359,7 @@ static void nvme_wake_free_req_locked(NVMeQueuePair *q)
     }
 }
 
-/* Insert a request in the freelist and wake waiters */
+/* Insert a request in the freelist and wake waiters (from any AioContext) */
 static void nvme_put_free_req_and_wake(NVMeQueuePair *q, NVMeRequest *req)
 {
     qemu_mutex_lock(&q->lock);
@@ -381,7 +390,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
     }
 }
 
-/* With q->lock */
+/* With q->lock, must be run in the BDS's main AioContext */
 static bool nvme_process_completion(NVMeQueuePair *q)
 {
     BDRVNVMeState *s = q->s;
@@ -451,6 +460,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
     return progress;
 }
 
+/* As q->completion_bh, runs in the BDS's main AioContext */
 static void nvme_process_completion_bh(void *opaque)
 {
     NVMeQueuePair *q = opaque;
@@ -481,6 +491,7 @@ static void nvme_trace_command(const NvmeCmd *cmd)
     }
 }
 
+/* Must be run in the BDS's main AioContext */
 static void nvme_kick_and_check_completions(void *opaque)
 {
     NVMeQueuePair *q = opaque;
@@ -490,6 +501,7 @@ static void nvme_kick_and_check_completions(void *opaque)
     nvme_process_completion(q);
 }
 
+/* Runs in nvme_submit_command()'s AioContext */
 static void nvme_deferred_fn(void *opaque)
 {
     NVMeQueuePair *q = opaque;
@@ -502,6 +514,7 @@ static void nvme_deferred_fn(void *opaque)
     }
 }
 
+/* May be run in any AioContext */
 static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
                                 NvmeCmd *cmd, BlockCompletionFunc cb,
                                 void *opaque)
@@ -523,6 +536,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
     defer_call(nvme_deferred_fn, q);
 }
 
+/* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
 static void nvme_admin_cmd_sync_cb(void *opaque, int ret)
 {
     int *pret = opaque;
@@ -530,6 +544,7 @@ static void nvme_admin_cmd_sync_cb(void *opaque, int ret)
     aio_wait_kick();
 }
 
+/* Must be run in the BDS's or qemu's main AioContext */
 static int nvme_admin_cmd_sync(BlockDriverState *bs, NvmeCmd *cmd)
 {
     BDRVNVMeState *s = bs->opaque;
@@ -638,6 +653,7 @@ out:
     return ret;
 }
 
+/* Must be run in the BDS's main AioContext */
 static void nvme_poll_queue(NVMeQueuePair *q)
 {
     const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
@@ -660,6 +676,7 @@ static void nvme_poll_queue(NVMeQueuePair *q)
     qemu_mutex_unlock(&q->lock);
 }
 
+/* Must be run in the BDS's main AioContext */
 static void nvme_poll_queues(BDRVNVMeState *s)
 {
     int i;
@@ -669,6 +686,7 @@ static void nvme_poll_queues(BDRVNVMeState *s)
     }
 }
 
+/* Run as an event notifier in the BDS's main AioContext */
 static void nvme_handle_event(EventNotifier *n)
 {
     BDRVNVMeState *s = container_of(n, BDRVNVMeState,
@@ -722,6 +740,7 @@ out_error:
     return false;
 }
 
+/* Run as an event notifier in the BDS's main AioContext */
 static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
@@ -745,6 +764,7 @@ static bool nvme_poll_cb(void *opaque)
     return false;
 }
 
+/* Run as an event notifier in the BDS's main AioContext */
 static void nvme_poll_ready(EventNotifier *e)
 {
     BDRVNVMeState *s = container_of(e, BDRVNVMeState,
@@ -1050,7 +1070,7 @@ static int nvme_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
     return 0;
 }
 
-/* Called with s->dma_map_lock */
+/* Called with s->dma_map_lock, may be run in any AioContext */
 static coroutine_fn int nvme_cmd_unmap_qiov(BlockDriverState *bs,
                                             QEMUIOVector *qiov)
 {
@@ -1061,13 +1081,17 @@ static coroutine_fn int nvme_cmd_unmap_qiov(BlockDriverState *bs,
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
@@ -1180,6 +1204,7 @@ typedef struct {
     int ret;
 } NVMeCoData;
 
+/* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NVMeCoData *data = opaque;
-- 
2.51.1


