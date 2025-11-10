Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD17FCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9P-0007Fm-39; Mon, 10 Nov 2025 10:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU99-0006nA-Sg
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU97-0000zS-Tu
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wrcNkTgNRfkRNsQTS+diw+Pjtpi/kOJzRkxlDubojE=;
 b=V4AuciP/pQ4xS5azpYGHJJd0xAspnveUDHNJoQlPnH+mAbxXNkWv3QcToUl7Wt2Xd+iM+U
 1IfACPDo/evn/OF5lpZQH8QjLS86Pjg/sMtdwuDLtvDV3qFw3kXjgA4vDn80FRW4QOzoxN
 iQewf0HD57XHvZgA8F42dwFonJWRUVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-aH-y71qQP-iRPR3Lg-GL9w-1; Mon, 10 Nov 2025 10:49:31 -0500
X-MC-Unique: aH-y71qQP-iRPR3Lg-GL9w-1
X-Mimecast-MFC-AGG-ID: aH-y71qQP-iRPR3Lg-GL9w_1762789771
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c93a28ebso2418232f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789770; x=1763394570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wrcNkTgNRfkRNsQTS+diw+Pjtpi/kOJzRkxlDubojE=;
 b=eHPQ5H/AZ1BSBePOZ4JIeQFmnKWzsLYoqrQ32iWvd4Y3ICRf504o9AO2HyZ+1BKQLy
 o+7sZ/KemkoBwZwzRiP5GzP/AU2sR7OvAhhY+SiVuPGRGUSdonoX8IMh4Mz9WWOoVw5+
 +DQo2tCiBYQDua39i9gjdx8pBHVAUJhH0NErPGfRfjFg/z1EbMPNo4wEWJGvxQKUwM5y
 xjTJkRWra8qAaFXMgiHdNbEfT6KJ9C7nNdCUOcdDMi7ZHMoP6vXsJoDa2W46ue2izoPl
 nPpYcrceXsBePQtsVsGJ7ujP4Vj+0ZKsi0c15d6DesYF/y1iyr5Beir6V/1drrzt/AZg
 +uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789770; x=1763394570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8wrcNkTgNRfkRNsQTS+diw+Pjtpi/kOJzRkxlDubojE=;
 b=Uw7Eie/35gbqKbyh14nnog39ZCvFMqEfw17AKQSE3/Z6XTypoSu5uNC7mRwnrdBf7e
 uwa4y6NtbKRHQYESFY99Tb97PxDV8AzIdOiW/JRr50LjKR2FdoDpXrMnudcmi9HPWePC
 u5sT2REJ6Ukt0G7mYmyzQu29Gy80HPl/l92z35xIMq/2DUfXgwhi6Cl05n+juzsgWZsN
 RG6U8FlY2FPjKqwjsxOzo9zdTPaT797FWzEb0MP5WV3PB40kF0IoCzyYBgFLj4bLjNUF
 anxDbNGRZsVTcX2Fq41vPyEH3NAZr4uYl7lrqv2+7i6Ic1iWqKq67ULiqHrcGUJKt9g6
 6rqQ==
X-Gm-Message-State: AOJu0YyinLX7MXap/+m4hv7KzDt2P5Yd6VitZeybZZZjtUWNAjQm4cAM
 nEPEh1ThTCdHDUqAO+mcbpK7qXNSx/YCQXcsRBdHgCpq11um/eDFgW5fGDJxH9XWwhvtsZfpr3P
 eP66tOHhrxCW6CVEJali0cwwujhECaJd3r7C0CPFWSb2n5eSWJtVo0wwb
X-Gm-Gg: ASbGncv/DlU+HwkJU7mtduQdXFl1gEdmoHtgfG1KXMB9EoRg0P35NY7/6zIgEVF+YOc
 w8FtRyzhGypSwExArglPrqSYSlnvMlWvQLI1kFgusOUoiQyN5dp2JtA3msu6Ut2rQtQoq3xR+7s
 gitdnYo9RF+yq/v+CJIEjdsoBUsuwxzf6Oeqe2M2BiRU2GdeLEatxwnX2ngSQNQ3/aE9MMrF6LY
 lBtMGlw5wjHekOCI2EdTKZknydgmt1l0nGx+wwFYnFIjK4ZRUlCinRqwTSVsd+FefHBo3tSeNrg
 wArGi1BkwuZR70eIl5fU7wEyDVwRTXA/ga3F8sPCdBX6bfdfO4uakNOJGx+31cpk23HchhpBDqH
 iGbB178XTV96xFRyOOq9p/IUTctMCPNV2oopHscFt3QR+t1A/+PnW/VICgg==
X-Received: by 2002:a05:6000:42c9:b0:42b:2ea5:6191 with SMTP id
 ffacd0b85a97d-42b2ea564d3mr5113263f8f.60.1762789770412; 
 Mon, 10 Nov 2025 07:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnLHqU9xlVoNCGbuzgYZ9KKJEA5tebxpveycihmXe9VnGsql7xSia63o2KNUEY6B/kq4GawQ==
X-Received: by 2002:a05:6000:42c9:b0:42b:2ea5:6191 with SMTP id
 ffacd0b85a97d-42b2ea564d3mr5113229f8f.60.1762789769926; 
 Mon, 10 Nov 2025 07:49:29 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b35ad7c16sm10061281f8f.15.2025.11.10.07.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:28 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 09/19] nvme: Note in which AioContext some functions run
Date: Mon, 10 Nov 2025 16:48:44 +0100
Message-ID: <20251110154854.151484-10-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

Sprinkle comments throughout block/nvme.c noting for some functions
(where it may not be obvious) that they require a certain AioContext, or
in which AioContext they do happen to run (for callbacks, BHs, event
notifiers).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
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


