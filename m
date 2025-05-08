Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA7CC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD29j-0005zo-Hs; Thu, 08 May 2025 10:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD29g-0005xH-SU
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD29d-0002LJ-Rc
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746714194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wN6VtIwhs5OmPkJP7AxfbghmIkMRhx785bAoyU3nXDU=;
 b=MmJszGtU4fdZIFgYdJWQiUc1MRJ4lKB86fmSctusnmMw0yRTKtR9lT5Ix0X/YHiufcjRYN
 GtZF6fgEX1Dm7noJwTGfYlwIB7tYbPNve5yXByt63S4vuAW9XPZW2DjCmBum5NiX25b+uw
 te2syrZB++ixrSnepuv2pHyWG4+r7Cs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-mSEYJsSvMLeP2rMN4N4QRw-1; Thu,
 08 May 2025 10:22:48 -0400
X-MC-Unique: mSEYJsSvMLeP2rMN4N4QRw-1
X-Mimecast-MFC-AGG-ID: mSEYJsSvMLeP2rMN4N4QRw_1746714163
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 111211800370; Thu,  8 May 2025 14:22:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 543C630001A1; Thu,  8 May 2025 14:22:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Farhan Ali <alifm@linux.ibm.com>
Subject: [PULL 3/3] block/nvme: Use host PCI MMIO API
Date: Thu,  8 May 2025 10:22:34 -0400
Message-ID: <20250508142234.44974-4-stefanha@redhat.com>
In-Reply-To: <20250508142234.44974-1-stefanha@redhat.com>
References: <20250508142234.44974-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

From: Farhan Ali <alifm@linux.ibm.com>

Use the host PCI MMIO functions to read/write
to NVMe registers, rather than directly accessing
them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Message-id: 20250430185012.2303-4-alifm@linux.ibm.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nvme.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index bbf7c23dcd..8df53ee4ca 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -18,6 +18,7 @@
 #include "qobject/qstring.h"
 #include "qemu/defer-call.h"
 #include "qemu/error-report.h"
+#include "qemu/host-pci-mmio.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
@@ -60,7 +61,7 @@ typedef struct {
     uint8_t  *queue;
     uint64_t iova;
     /* Hardware MMIO register */
-    volatile uint32_t *doorbell;
+    uint32_t *doorbell;
 } NVMeQueue;
 
 typedef struct {
@@ -100,7 +101,7 @@ struct BDRVNVMeState {
     QEMUVFIOState *vfio;
     void *bar0_wo_map;
     /* Memory mapped registers */
-    volatile struct {
+    struct {
         uint32_t sq_tail;
         uint32_t cq_head;
     } *doorbells;
@@ -292,7 +293,7 @@ static void nvme_kick(NVMeQueuePair *q)
     assert(!(q->sq.tail & 0xFF00));
     /* Fence the write to submission queue entry before notifying the device. */
     smp_wmb();
-    *q->sq.doorbell = cpu_to_le32(q->sq.tail);
+    host_pci_stl_le_p(q->sq.doorbell, q->sq.tail);
     q->inflight += q->need_kick;
     q->need_kick = 0;
 }
@@ -441,7 +442,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
     if (progress) {
         /* Notify the device so it can post more completions. */
         smp_mb_release();
-        *q->cq.doorbell = cpu_to_le32(q->cq.head);
+        host_pci_stl_le_p(q->cq.doorbell, q->cq.head);
         nvme_wake_free_req_locked(q);
     }
 
@@ -460,7 +461,7 @@ static void nvme_process_completion_bh(void *opaque)
      * so notify the device that it has space to fill in more completions now.
      */
     smp_mb_release();
-    *q->cq.doorbell = cpu_to_le32(q->cq.head);
+    host_pci_stl_le_p(q->cq.doorbell, q->cq.head);
     nvme_wake_free_req_locked(q);
 
     nvme_process_completion(q);
@@ -749,9 +750,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     int ret;
     uint64_t cap;
     uint32_t ver;
+    uint32_t cc;
     uint64_t timeout_ms;
     uint64_t deadline, now;
-    volatile NvmeBar *regs = NULL;
+    NvmeBar *regs = NULL;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -779,7 +781,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
-    cap = le64_to_cpu(regs->cap);
+    cap = host_pci_ldq_le_p(&regs->cap);
     trace_nvme_controller_capability_raw(cap);
     trace_nvme_controller_capability("Maximum Queue Entries Supported",
                                      1 + NVME_CAP_MQES(cap));
@@ -805,16 +807,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     bs->bl.request_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
 
-    ver = le32_to_cpu(regs->vs);
+    ver = host_pci_ldl_le_p(&regs->vs);
     trace_nvme_controller_spec_version(extract32(ver, 16, 16),
                                        extract32(ver, 8, 8),
                                        extract32(ver, 0, 8));
 
     /* Reset device to get a clean state. */
-    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
+    cc = host_pci_ldl_le_p(&regs->cc);
+    host_pci_stl_le_p(&regs->cc, cc & 0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
+    while (NVME_CSTS_RDY(host_pci_ldl_le_p(&regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -843,19 +846,21 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->queues[INDEX_ADMIN] = q;
     s->queue_count = 1;
     QEMU_BUILD_BUG_ON((NVME_QUEUE_SIZE - 1) & 0xF000);
-    regs->aqa = cpu_to_le32(((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
-                            ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
-    regs->asq = cpu_to_le64(q->sq.iova);
-    regs->acq = cpu_to_le64(q->cq.iova);
+    host_pci_stl_le_p(&regs->aqa,
+                        ((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
+                        ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
+    host_pci_stq_le_p(&regs->asq, q->sq.iova);
+    host_pci_stq_le_p(&regs->acq, q->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
-                           (ctz32(NVME_SQ_ENTRY_BYTES) << CC_IOSQES_SHIFT) |
-                           CC_EN_MASK);
+    host_pci_stl_le_p(&regs->cc,
+                      (ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
+                      (ctz32(NVME_SQ_ENTRY_BYTES) << CC_IOSQES_SHIFT) |
+                      CC_EN_MASK);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * SCALE_MS;
-    while (!NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
+    while (!NVME_CSTS_RDY(host_pci_ldl_le_p(&regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
-- 
2.49.0


