Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE093FD7075
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ReP-00020L-T8; Tue, 17 Mar 2026 06:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Re2-0001vz-9J
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdx-0006Wj-05
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48539d21b76so39600835e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773743238; x=1774348038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oDn1DyyxJp+kkjF+9H5BBpPByqnknuxzyFDSX/Voqs=;
 b=W+hDNJ6kLCzMvItAr2+HuFyZgFrTwCuFIwEG7cbZAmCHnYaYjHIaM8CRdpip4LZBxQ
 Tv2nWqDLHYv6whLLGRm2CVpXUpTyYE4YPzkWforoD0YgQNhEZVJ26LeaNv6YoMH53Aax
 XRxhTFyzPhKM238AkoOhlpNudj9LAtTHSqkLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743238; x=1774348038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5oDn1DyyxJp+kkjF+9H5BBpPByqnknuxzyFDSX/Voqs=;
 b=BI4JjX6mzyBxQ492/FRk5xxFLVjANtoIiMIl1GY7m6edxn4BILmGeVRFCe8ENsJtuP
 46R5hwaORhLpkj9pCoBF0QhM7G3Py1JN5DOxPYkPIgTa9av5gzNGAgfWQQ6HWqP4l1BC
 UH4Im/ZglFn1o8YT5Cjh1V/u1M6JImc3RJmVU5HJhzQ10BJUK4zpW9OkATfMMO9PJocW
 9EwZXHUdhPKP4Lj3vSWKsMJNjF+C1XB1VmrunpAet5cqV8mQ27z4CJJAW2L4hXuTSAwB
 ZTPbbojw850S5kE1MnIV1ZocJA2xueJYJvB2zpm65nyaRd6ES7NPKw67pyH1x/mN3FNV
 MaCA==
X-Gm-Message-State: AOJu0YzLArlpg/1yvgzuJOzxvMAFe+GaAE6d3W1KYODSoFpRnTS364OY
 vlBX0gq/d85XYzL+BghuZdFsjgLmTFv3c7ChACRXJqwMrcRLfcAOq5yNgAVdQI6aUR6uqqcN0Fo
 cqYyFGVc=
X-Gm-Gg: ATEYQzxH+SzoRG7dvMibnQ+Ur6mOzeBhBQDmhdlVTmPv6tkrkMfKB0IljMKoi8Qr6bD
 FPe09ujEOROuy+rtZOeu1qwJCKkBAKRhFVMSHTjT0uc4ZB3pREWm3oFCmQHyLqngZ7tHj6ntTEp
 31rzLGjFRM9/g4q87AB3+trKV/50C9yNLMcHIqT0tbPnfJDbsrmbX3tCc2sqK6JNqea9IU7Dl6/
 XT9MGZP0r/6XgUahXhzqksHchvdFwWv4+lDUIO4OBoMrmefILFjkiWUUnGNJnHbE5lPESKAV2FQ
 BmMsD3twCVDLgWLh403lcm/w/WMTXEGfKqtO32KFfyWbxC5O5U0bXNthqg8JKzHMxISHKNlayHF
 byqs+yKzG//d7g49MwzOY5aZFp31irxZO8wr2VegpqQ0cyA9FI8IZc9zalKZX5rum/I0xoEy8Ui
 nhDvzJ8KggnavjP8GtrrubTVtdX2yb6qjuSHodT3AVrlNFH9ZUbDqzs1KTxQoKN0jiS9BagDgxl
 m+zXy7hwN9KAaNFeqmSSH/iUyAGjh/1Vw==
X-Received: by 2002:a05:600c:4583:b0:485:439b:683f with SMTP id
 5b1f17b1804b1-48556700c23mr251512865e9.20.1773743237765; 
 Tue, 17 Mar 2026 03:27:17 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0051af80c54da1a9bc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:51af:80c5:4da1:a9bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c36bsm61977665e9.9.2026.03.17.03.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:27:17 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 7/8] hw/nvme: add basic live migration support
Date: Tue, 17 Mar 2026 11:27:07 +0100
Message-ID: <20260317102708.126725-8-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317102708.126725-1-alexander@mihalicyn.com>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

It has some limitations:
- only one NVMe namespace is supported
- SMART counters are not preserved
- CMB is not supported
- PMR is not supported
- SPDM is not supported
- SR-IOV is not supported

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
v2:
- AERs are now fully supported
---
 hw/nvme/ctrl.c       | 611 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/ns.c         | 160 +++++++++++
 hw/nvme/nvme.h       |   5 +
 hw/nvme/trace-events |  11 +
 4 files changed, 778 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 68ce9802505..e3030bfadcb 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -208,6 +208,7 @@
 #include "hw/pci/pcie_sriov.h"
 #include "system/spdm-socket.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -4903,6 +4904,25 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     __nvme_init_sq(sq);
 }
 
+static void nvme_restore_sq(NvmeSQueue *sq_from)
+{
+    NvmeCtrl *n = sq_from->ctrl;
+    NvmeSQueue *sq = sq_from;
+
+    if (sq_from->sqid == 0) {
+        sq = &n->admin_sq;
+        sq->ctrl = n;
+        sq->dma_addr = sq_from->dma_addr;
+        sq->sqid = sq_from->sqid;
+        sq->size = sq_from->size;
+        sq->cqid = sq_from->cqid;
+        sq->head = sq_from->head;
+        sq->tail = sq_from->tail;
+    }
+
+    __nvme_init_sq(sq);
+}
+
 static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeSQueue *sq;
@@ -5605,6 +5625,27 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     __nvme_init_cq(cq);
 }
 
+static void nvme_restore_cq(NvmeCQueue *cq_from)
+{
+    NvmeCtrl *n = cq_from->ctrl;
+    NvmeCQueue *cq = cq_from;
+
+    if (cq_from->cqid == 0) {
+        cq = &n->admin_cq;
+        cq->ctrl = n;
+        cq->cqid = cq_from->cqid;
+        cq->size = cq_from->size;
+        cq->dma_addr = cq_from->dma_addr;
+        cq->phase = cq_from->phase;
+        cq->irq_enabled = cq_from->irq_enabled;
+        cq->vector = cq_from->vector;
+        cq->head = cq_from->head;
+        cq->tail = cq_from->tail;
+    }
+
+    __nvme_init_cq(cq);
+}
+
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
@@ -7293,7 +7334,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     n->dbbuf_eis = eis_addr;
     n->dbbuf_enabled = true;
 
-    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 0; i < n->num_queues; i++) {
         NvmeSQueue *sq = n->sq[i];
         NvmeCQueue *cq = n->cq[i];
 
@@ -7737,7 +7778,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
     /*
      * Walk the queues to see if there are any atomic conflicts.
      */
-    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 1; i < n->num_queues; i++) {
         NvmeSQueue *sq;
         NvmeRequest *req;
         NvmeRwCmd *req_rw;
@@ -7807,6 +7848,10 @@ static void nvme_process_sq(void *opaque)
     NvmeCmd cmd;
     NvmeRequest *req;
 
+    if (qatomic_read(&n->stop_processing_sq)) {
+        return;
+    }
+
     if (n->dbbuf_enabled) {
         nvme_update_sq_tail(sq);
     }
@@ -7815,6 +7860,10 @@ static void nvme_process_sq(void *opaque)
         NvmeAtomic *atomic;
         bool cmd_is_atomic;
 
+        if (qatomic_read(&n->stop_processing_sq)) {
+            return;
+        }
+
         addr = sq->dma_addr + (sq->head << NVME_SQES);
         if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
             trace_pci_nvme_err_addr_read(addr);
@@ -7923,12 +7972,12 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
         nvme_ns_drain(ns);
     }
 
-    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 0; i < n->num_queues; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
         }
     }
-    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 0; i < n->num_queues; i++) {
         if (n->cq[i] != NULL) {
             nvme_free_cq(n->cq[i], n);
         }
@@ -8598,6 +8647,8 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         params->max_ioqpairs = params->num_queues - 1;
     }
 
+    n->num_queues = params->max_ioqpairs + 1;
+
     if (n->namespace.blkconf.blk && n->subsys) {
         error_setg(errp, "subsystem support is unavailable with legacy "
                    "namespace ('drive' property)");
@@ -8752,8 +8803,8 @@ static void nvme_init_state(NvmeCtrl *n)
         n->conf_msix_qsize = n->params.msix_qsize;
     }
 
-    n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
-    n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+    n->sq = g_new0(NvmeSQueue *, n->num_queues);
+    n->cq = g_new0(NvmeCQueue *, n->num_queues);
     n->temperature = NVME_TEMPERATURE;
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
@@ -8988,7 +9039,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
-        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, 0, NULL, NULL);
+        bar_size = nvme_mbar_size(n->num_queues, 0, NULL, NULL);
         memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
                               bar_size);
         pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -9000,7 +9051,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         /* add one to max_ioqpairs to account for the admin queue pair */
         if (!pci_is_vf(pci_dev)) {
             nr_vectors = n->params.msix_qsize;
-            bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
+            bar_size = nvme_mbar_size(n->num_queues,
                                       nr_vectors, &msix_table_offset,
                                       &msix_pba_offset);
         } else {
@@ -9723,9 +9774,551 @@ static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
     return pci_default_read_config(dev, address, len);
 }
 
+static bool nvme_ctrl_pre_save(void *opaque, Error **errp)
+{
+    NvmeCtrl *n = opaque;
+    int i;
+
+    trace_pci_nvme_pre_save_enter(n);
+
+    /* ask SQ processing code not to take new requests */
+    qatomic_set(&n->stop_processing_sq, true);
+
+    /* prevent new in-flight IO from appearing */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+
+        if (!sq)
+            continue;
+
+        qemu_bh_cancel(sq->bh);
+    }
+
+    /* drain all IO */
+    for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        NvmeNamespace *ns;
+
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        trace_pci_nvme_pre_save_ns_drain(n, i);
+        nvme_ns_drain(ns);
+    }
+
+    /*
+     * Now, we should take care of AERs.
+     *
+     * 1. Save all queued events (n->aer_queue).
+     *    This is done automatically, see nvme_vmstate VMStateDescription.
+     *    Here we only need to print them for debugging purpose.
+     * 2. Go over outstanding AER requests (n->aer_reqs) and check they are
+     *    all have expected opcode (NVME_ADM_CMD_ASYNC_EV_REQ) and other fields.
+     *
+     * We must be really careful here, because in case of further QEMU NVMe changes,
+     * we may break migration without noticing it, or worse, introduce silent
+     * data corruption during migration.
+     */
+    if (n->aer_queued) {
+        NvmeAsyncEvent *event;
+
+        QTAILQ_FOREACH(event, &n->aer_queue, entry) {
+            trace_pci_nvme_pre_save_aer(event->result.event_type, event->result.event_info,
+                                        event->result.log_page);
+        }
+    }
+
+    for (i = 0; i < n->outstanding_aers; i++) {
+        NvmeRequest *re = n->aer_reqs[i];
+
+        /*
+         * Can't use assert() here, because we don't want
+         * to just crash QEMU when user requests a migration.
+         */
+        if (!(re->cmd.opcode == NVME_ADM_CMD_ASYNC_EV_REQ)) {
+            error_setg(errp, "re->cmd.opcode (%u) != NVME_ADM_CMD_ASYNC_EV_REQ", re->cmd.opcode);
+            goto err;
+        }
+
+        if (!(re->ns == NULL)) {
+            error_setg(errp, "re->ns != NULL");
+            goto err;
+        }
+
+        if (!(re->sq == &n->admin_sq)) {
+            error_setg(errp, "re->sq != &n->admin_sq");
+            goto err;
+        }
+
+        if (!(re->aiocb == NULL)) {
+            error_setg(errp, "re->aiocb != NULL");
+            goto err;
+        }
+
+        if (!(re->opaque == NULL)) {
+            error_setg(errp, "re->opaque != NULL");
+            goto err;
+        }
+
+        if (!(re->atomic_write == false)) {
+            error_setg(errp, "re->atomic_write != false");
+            goto err;
+        }
+
+        if (re->sg.flags & NVME_SG_ALLOC) {
+            error_setg(errp, "unexpected NVME_SG_ALLOC flag in re->sg.flags");
+            goto err;
+        }
+    }
+
+    /* wait when all in-flight IO requests (except NVME_ADM_CMD_ASYNC_EV_REQ) are processed */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeRequest *req;
+        NvmeSQueue *sq = n->sq[i];
+
+        if (!sq)
+            continue;
+
+        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->head, sq->tail, sq->size);
+
+wait_out_reqs:
+        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
+            if (req->cmd.opcode != NVME_ADM_CMD_ASYNC_EV_REQ) {
+                cpu_relax();
+                goto wait_out_reqs;
+            }
+        }
+
+        trace_pci_nvme_pre_save_sq_out_req_drain_wait_end(n, i, sq->head, sq->tail);
+    }
+
+    /* wait when all IO requests completions are written to guest memory */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeCQueue *cq = n->cq[i];
+
+        if (!cq)
+            continue;
+
+        trace_pci_nvme_pre_save_cq_req_drain_wait(n, i, cq->head, cq->tail, cq->size);
+
+        while (!QTAILQ_EMPTY(&cq->req_list)) {
+            /*
+             * nvme_post_cqes() can't do its job of cleaning cq->req_list
+             * when CQ is full, it means that we need to save what we have in
+             * cq->req_list and restore it back on VM resume.
+             *
+             * Good thing is that this can only happen when guest hasn't
+             * processed CQ for a long time and at the same time, many SQEs
+             * are in flight.
+             *
+             * For now, let's just block migration in this rare case.
+             */
+            if (nvme_cq_full(cq)) {
+                error_setg(errp, "no free space in CQ (not supported)");
+                goto err;
+            }
+
+            cpu_relax();
+        }
+
+        trace_pci_nvme_pre_save_cq_req_drain_wait_end(n, i, cq->head, cq->tail);
+    }
+
+    for (uint32_t nsid = 0; nsid <= NVME_MAX_NAMESPACES; nsid++) {
+        NvmeNamespace *ns = n->namespaces[nsid];
+
+        if (!ns)
+            continue;
+
+        if (ns != &n->namespace) {
+            error_setg(errp, "only one NVMe namespace is supported for migration");
+            goto err;
+        }
+    }
+
+    return true;
+
+err:
+    /* restore sq processing back to normal */
+    qatomic_set(&n->stop_processing_sq, false);
+    return false;
+}
+
+static bool nvme_ctrl_post_load(void *opaque, int version_id, Error **errp)
+{
+    NvmeCtrl *n = opaque;
+    int i;
+
+    trace_pci_nvme_post_load_enter(n);
+
+    /* restore CQs first */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeCQueue *cq = n->cq[i];
+
+        if (!cq)
+            continue;
+
+        cq->ctrl = n;
+        nvme_restore_cq(cq);
+        trace_pci_nvme_post_load_restore_cq(n, i, cq->head, cq->tail, cq->size);
+
+        if (i == 0) {
+            /*
+             * Admin CQ lives in n->admin_cq, we don't need
+             * memory allocated for it in get_ptrs_array_entry() anymore.
+             *
+             * nvme_restore_cq() also takes care of:
+             * n->cq[0] = &n->admin_cq;
+             * so n->cq[0] remains valid.
+             */
+            g_free(cq);
+        }
+    }
+
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+
+        if (!sq)
+            continue;
+
+        sq->ctrl = n;
+        nvme_restore_sq(sq);
+        trace_pci_nvme_post_load_restore_sq(n, i, sq->head, sq->tail, sq->size);
+
+        if (i == 0) {
+            /* same as for CQ */
+            g_free(sq);
+        }
+    }
+
+    if (n->aer_queued) {
+        NvmeAsyncEvent *event;
+
+        QTAILQ_FOREACH(event, &n->aer_queue, entry) {
+            trace_pci_nvme_post_load_aer(event->result.event_type, event->result.event_info,
+                                         event->result.log_page);
+        }
+    }
+
+    for (i = 0; i < n->outstanding_aers; i++) {
+        NvmeSQueue *sq = &n->admin_sq;
+        NvmeRequest *req_from = n->aer_reqs[i];
+        NvmeRequest *req;
+
+        /*
+         * We use nvme_vmstate VMStateDescription to save/restore
+         * NvmeRequest structures, but tricky thing here is that
+         * memory for each n->aer_reqs[i] will be allocated separately
+         * during restore. It doesn't work for us. We need to take
+         * an existing NvmeRequest structure from SQ's req_list
+         * and fill it with data from the newly allocated one (req_from).
+         * Then, we can safely release allocated memory for it.
+         */
+
+        /* take an NvmeRequest struct from SQ */
+        req = QTAILQ_FIRST(&sq->req_list);
+        QTAILQ_REMOVE(&sq->req_list, req, entry);
+        QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
+        nvme_req_clear(req);
+
+        /* copy data from the source NvmeRequest */
+        req->status = req_from->status;
+        memcpy(&req->cqe, &req_from->cqe, sizeof(NvmeCqe));
+        memcpy(&req->cmd, &req_from->cmd, sizeof(NvmeCmd));
+
+        n->aer_reqs[i] = req;
+        g_free(req_from);
+    }
+
+    /*
+     * We need to attach namespaces (currently, only one namespace is
+     * supported for migration).
+     * This logic comes from nvme_start_ctrl().
+     */
+    for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+
+        if (!ns || (!ns->params.shared && ns->ctrl != n)) {
+            continue;
+        }
+
+        if (nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
+            if (!ns->attached || ns->params.shared) {
+                nvme_attach_ns(n, ns);
+            }
+        }
+    }
+
+    /* schedule SQ processing */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+
+        if (!sq)
+            continue;
+
+        qemu_bh_schedule(sq->bh);
+    }
+
+    /*
+     * We ensured in pre_save() that cq->req_list was empty,
+     * so we don't need to schedule BH for CQ processing.
+     */
+
+    return true;
+}
+
+static const VMStateDescription nvme_vmstate_bar = {
+    .name = "nvme-bar",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(cap, NvmeBar),
+        VMSTATE_UINT32(vs, NvmeBar),
+        VMSTATE_UINT32(intms, NvmeBar),
+        VMSTATE_UINT32(intmc, NvmeBar),
+        VMSTATE_UINT32(cc, NvmeBar),
+        VMSTATE_UINT8_ARRAY(rsvd24, NvmeBar, 4),
+        VMSTATE_UINT32(csts, NvmeBar),
+        VMSTATE_UINT32(nssr, NvmeBar),
+        VMSTATE_UINT32(aqa, NvmeBar),
+        VMSTATE_UINT64(asq, NvmeBar),
+        VMSTATE_UINT64(acq, NvmeBar),
+        VMSTATE_UINT32(cmbloc, NvmeBar),
+        VMSTATE_UINT32(cmbsz, NvmeBar),
+        VMSTATE_UINT32(bpinfo, NvmeBar),
+        VMSTATE_UINT32(bprsel, NvmeBar),
+        VMSTATE_UINT64(bpmbl, NvmeBar),
+        VMSTATE_UINT64(cmbmsc, NvmeBar),
+        VMSTATE_UINT32(cmbsts, NvmeBar),
+        VMSTATE_UINT8_ARRAY(rsvd92, NvmeBar, 3492),
+        VMSTATE_UINT32(pmrcap, NvmeBar),
+        VMSTATE_UINT32(pmrctl, NvmeBar),
+        VMSTATE_UINT32(pmrsts, NvmeBar),
+        VMSTATE_UINT32(pmrebs, NvmeBar),
+        VMSTATE_UINT32(pmrswtp, NvmeBar),
+        VMSTATE_UINT32(pmrmscl, NvmeBar),
+        VMSTATE_UINT32(pmrmscu, NvmeBar),
+        VMSTATE_UINT8_ARRAY(css, NvmeBar, 484),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription nvme_vmstate_cqueue = {
+    .name = "nvme-cq",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(phase, NvmeCQueue),
+        VMSTATE_UINT16(cqid, NvmeCQueue),
+        VMSTATE_UINT16(irq_enabled, NvmeCQueue),
+        VMSTATE_UINT32(head, NvmeCQueue),
+        VMSTATE_UINT32(tail, NvmeCQueue),
+        VMSTATE_UINT32(vector, NvmeCQueue),
+        VMSTATE_UINT32(size, NvmeCQueue),
+        VMSTATE_UINT64(dma_addr, NvmeCQueue),
+        /* db_addr, ei_addr, etc will be recalculated */
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_squeue = {
+    .name = "nvme-sq",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(sqid, NvmeSQueue),
+        VMSTATE_UINT16(cqid, NvmeSQueue),
+        VMSTATE_UINT32(head, NvmeSQueue),
+        VMSTATE_UINT32(tail, NvmeSQueue),
+        VMSTATE_UINT32(size, NvmeSQueue),
+        VMSTATE_UINT64(dma_addr, NvmeSQueue),
+        /* db_addr, ei_addr, etc will be recalculated */
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_async_event_result = {
+    .name = "nvme-async-event-result",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(event_type, NvmeAerResult),
+        VMSTATE_UINT8(event_info, NvmeAerResult),
+        VMSTATE_UINT8(log_page, NvmeAerResult),
+        VMSTATE_UINT8(resv, NvmeAerResult),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_async_event = {
+    .name = "nvme-async-event",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(result, NvmeAsyncEvent, 0, nvme_vmstate_async_event_result, NvmeAerResult),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_cqe = {
+    .name = "nvme-cqe",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(result, NvmeCqe),
+        VMSTATE_UINT32(dw1, NvmeCqe),
+        VMSTATE_UINT16(sq_head, NvmeCqe),
+        VMSTATE_UINT16(sq_id, NvmeCqe),
+        VMSTATE_UINT16(cid, NvmeCqe),
+        VMSTATE_UINT16(status, NvmeCqe),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_cmd_dptr_sgl = {
+    .name = "nvme-request-cmd-dptr-sgl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(addr, NvmeSglDescriptor),
+        VMSTATE_UINT32(len, NvmeSglDescriptor),
+        VMSTATE_UINT8_ARRAY(rsvd, NvmeSglDescriptor, 3),
+        VMSTATE_UINT8(type, NvmeSglDescriptor),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_cmd_dptr = {
+    .name = "nvme-request-cmd-dptr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(prp1, NvmeCmdDptr),
+        VMSTATE_UINT64(prp2, NvmeCmdDptr),
+        VMSTATE_STRUCT(sgl, NvmeCmdDptr, 0, nvme_vmstate_cmd_dptr_sgl, NvmeSglDescriptor),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_cmd = {
+    .name = "nvme-request-cmd",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(opcode, NvmeCmd),
+        VMSTATE_UINT8(flags, NvmeCmd),
+        VMSTATE_UINT16(cid, NvmeCmd),
+        VMSTATE_UINT32(nsid, NvmeCmd),
+        VMSTATE_UINT64(res1, NvmeCmd),
+        VMSTATE_UINT64(mptr, NvmeCmd),
+        VMSTATE_STRUCT(dptr, NvmeCmd, 0, nvme_vmstate_cmd_dptr, NvmeCmdDptr),
+        VMSTATE_UINT32(cdw10, NvmeCmd),
+        VMSTATE_UINT32(cdw11, NvmeCmd),
+        VMSTATE_UINT32(cdw12, NvmeCmd),
+        VMSTATE_UINT32(cdw13, NvmeCmd),
+        VMSTATE_UINT32(cdw14, NvmeCmd),
+        VMSTATE_UINT32(cdw15, NvmeCmd),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_request = {
+    .name = "nvme-request",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(status, NvmeRequest),
+        VMSTATE_STRUCT(cqe, NvmeRequest, 0, nvme_vmstate_cqe, NvmeCqe),
+        VMSTATE_STRUCT(cmd, NvmeRequest, 0, nvme_vmstate_cmd, NvmeCmd),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_hbs = {
+    .name = "nvme-hbs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(acre, NvmeHostBehaviorSupport),
+        VMSTATE_UINT8(etdas, NvmeHostBehaviorSupport),
+        VMSTATE_UINT8(lbafee, NvmeHostBehaviorSupport),
+        VMSTATE_UINT8(rsvd3, NvmeHostBehaviorSupport),
+        VMSTATE_UINT16(cdfe, NvmeHostBehaviorSupport),
+        VMSTATE_UINT8_ARRAY(rsvd6, NvmeHostBehaviorSupport, 506),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription nvme_vmstate_atomic = {
+    .name = "nvme-atomic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(atomic_max_write_size, NvmeAtomic),
+        VMSTATE_UINT64(atomic_boundary, NvmeAtomic),
+        VMSTATE_UINT64(atomic_nabo, NvmeAtomic),
+        VMSTATE_BOOL(atomic_writes, NvmeAtomic),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription nvme_vmstate = {
     .name = "nvme",
-    .unmigratable = 1,
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .pre_save_errp = nvme_ctrl_pre_save,
+    .post_load_errp = nvme_ctrl_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, NvmeCtrl),
+        VMSTATE_MSIX(parent_obj, NvmeCtrl),
+        VMSTATE_STRUCT(bar, NvmeCtrl, 0, nvme_vmstate_bar, NvmeBar),
+
+        VMSTATE_BOOL(qs_created, NvmeCtrl),
+        VMSTATE_UINT32(page_size, NvmeCtrl),
+        VMSTATE_UINT16(page_bits, NvmeCtrl),
+        VMSTATE_UINT16(max_prp_ents, NvmeCtrl),
+        VMSTATE_UINT32(max_q_ents, NvmeCtrl),
+        VMSTATE_UINT8(outstanding_aers, NvmeCtrl),
+        VMSTATE_UINT32(irq_status, NvmeCtrl),
+        VMSTATE_INT32(cq_pending, NvmeCtrl),
+
+        VMSTATE_UINT64(host_timestamp, NvmeCtrl),
+        VMSTATE_UINT64(timestamp_set_qemu_clock_ms, NvmeCtrl),
+        VMSTATE_UINT64(starttime_ms, NvmeCtrl),
+        VMSTATE_UINT16(temperature, NvmeCtrl),
+        VMSTATE_UINT8(smart_critical_warning, NvmeCtrl),
+
+        VMSTATE_UINT32(conf_msix_qsize, NvmeCtrl),
+        VMSTATE_UINT32(conf_ioqpairs, NvmeCtrl),
+        VMSTATE_UINT64(dbbuf_dbs, NvmeCtrl),
+        VMSTATE_UINT64(dbbuf_eis, NvmeCtrl),
+        VMSTATE_BOOL(dbbuf_enabled, NvmeCtrl),
+
+        VMSTATE_UINT8(aer_mask, NvmeCtrl),
+        VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(
+            aer_reqs, NvmeCtrl, outstanding_aers, 0, nvme_vmstate_request, NvmeRequest),
+        VMSTATE_QTAILQ_V(aer_queue, NvmeCtrl, 1, nvme_vmstate_async_event,
+                         NvmeAsyncEvent, entry),
+        VMSTATE_INT32(aer_queued, NvmeCtrl),
+
+        VMSTATE_STRUCT(namespace, NvmeCtrl, 0, nvme_vmstate_ns, NvmeNamespace),
+
+        VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(
+            sq, NvmeCtrl, num_queues, 0, nvme_vmstate_squeue, NvmeSQueue),
+        VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(
+            cq, NvmeCtrl, num_queues, 0, nvme_vmstate_cqueue, NvmeCQueue),
+
+        VMSTATE_UINT16(features.temp_thresh_hi, NvmeCtrl),
+        VMSTATE_UINT16(features.temp_thresh_low, NvmeCtrl),
+        VMSTATE_UINT32(features.async_config, NvmeCtrl),
+        VMSTATE_STRUCT(features.hbs, NvmeCtrl, 0, nvme_vmstate_hbs, NvmeHostBehaviorSupport),
+
+        VMSTATE_UINT32(dn, NvmeCtrl),
+        VMSTATE_STRUCT(atomic, NvmeCtrl, 0, nvme_vmstate_atomic, NvmeAtomic),
+
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static void nvme_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 38f86a17268..dd374677078 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "system/system.h"
 #include "system/block-backend.h"
+#include "migration/vmstate.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -886,6 +887,164 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static const VMStateDescription nvme_vmstate_lbaf = {
+    .name = "nvme_lbaf",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(ms, NvmeLBAF),
+        VMSTATE_UINT8(ds, NvmeLBAF),
+        VMSTATE_UINT8(rp, NvmeLBAF),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_id_ns = {
+    .name = "nvme_id_ns",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(nsze, NvmeIdNs),
+        VMSTATE_UINT64(ncap, NvmeIdNs),
+        VMSTATE_UINT64(nuse, NvmeIdNs),
+        VMSTATE_UINT8(nsfeat, NvmeIdNs),
+        VMSTATE_UINT8(nlbaf, NvmeIdNs),
+        VMSTATE_UINT8(flbas, NvmeIdNs),
+        VMSTATE_UINT8(mc, NvmeIdNs),
+        VMSTATE_UINT8(dpc, NvmeIdNs),
+        VMSTATE_UINT8(dps, NvmeIdNs),
+        VMSTATE_UINT8(nmic, NvmeIdNs),
+        VMSTATE_UINT8(rescap, NvmeIdNs),
+        VMSTATE_UINT8(fpi, NvmeIdNs),
+        VMSTATE_UINT8(dlfeat, NvmeIdNs),
+        VMSTATE_UINT16(nawun, NvmeIdNs),
+        VMSTATE_UINT16(nawupf, NvmeIdNs),
+        VMSTATE_UINT16(nacwu, NvmeIdNs),
+        VMSTATE_UINT16(nabsn, NvmeIdNs),
+        VMSTATE_UINT16(nabo, NvmeIdNs),
+        VMSTATE_UINT16(nabspf, NvmeIdNs),
+        VMSTATE_UINT16(noiob, NvmeIdNs),
+        VMSTATE_UINT8_ARRAY(nvmcap, NvmeIdNs, 16),
+        VMSTATE_UINT16(npwg, NvmeIdNs),
+        VMSTATE_UINT16(npwa, NvmeIdNs),
+        VMSTATE_UINT16(npdg, NvmeIdNs),
+        VMSTATE_UINT16(npda, NvmeIdNs),
+        VMSTATE_UINT16(nows, NvmeIdNs),
+        VMSTATE_UINT16(mssrl, NvmeIdNs),
+        VMSTATE_UINT32(mcl, NvmeIdNs),
+        VMSTATE_UINT8(msrc, NvmeIdNs),
+        VMSTATE_UINT8_ARRAY(rsvd81, NvmeIdNs, 18),
+        VMSTATE_UINT8(nsattr, NvmeIdNs),
+        VMSTATE_UINT16(nvmsetid, NvmeIdNs),
+        VMSTATE_UINT16(endgid, NvmeIdNs),
+        VMSTATE_UINT8_ARRAY(nguid, NvmeIdNs, 16),
+        VMSTATE_UINT64(eui64, NvmeIdNs),
+        VMSTATE_STRUCT_ARRAY(lbaf, NvmeIdNs, NVME_MAX_NLBAF, 1,
+                             nvme_vmstate_lbaf, NvmeLBAF),
+        VMSTATE_UINT8_ARRAY(vs, NvmeIdNs, 3712),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_id_ns_nvm = {
+    .name = "nvme_id_ns_nvm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(lbstm, NvmeIdNsNvm),
+        VMSTATE_UINT8(pic, NvmeIdNsNvm),
+        VMSTATE_UINT8_ARRAY(rsvd9, NvmeIdNsNvm, 3),
+        VMSTATE_UINT32_ARRAY(elbaf, NvmeIdNsNvm, NVME_MAX_NLBAF),
+        VMSTATE_UINT32(npdgl, NvmeIdNsNvm),
+        VMSTATE_UINT32(nprg, NvmeIdNsNvm),
+        VMSTATE_UINT32(npra, NvmeIdNsNvm),
+        VMSTATE_UINT32(nors, NvmeIdNsNvm),
+        VMSTATE_UINT32(npdal, NvmeIdNsNvm),
+        VMSTATE_UINT8_ARRAY(rsvd288, NvmeIdNsNvm, 3808),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription nvme_vmstate_id_ns_ind = {
+    .name = "nvme_id_ns_ind",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(nsfeat, NvmeIdNsInd),
+        VMSTATE_UINT8(nmic, NvmeIdNsInd),
+        VMSTATE_UINT8(rescap, NvmeIdNsInd),
+        VMSTATE_UINT8(fpi, NvmeIdNsInd),
+        VMSTATE_UINT32(anagrpid, NvmeIdNsInd),
+        VMSTATE_UINT8(nsattr, NvmeIdNsInd),
+        VMSTATE_UINT8(rsvd9, NvmeIdNsInd),
+        VMSTATE_UINT16(nvmsetid, NvmeIdNsInd),
+        VMSTATE_UINT16(endgrpid, NvmeIdNsInd),
+        VMSTATE_UINT8(nstat, NvmeIdNsInd),
+        VMSTATE_UINT8_ARRAY(rsvd15, NvmeIdNsInd, 4081),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+typedef struct TmpNvmeNamespace {
+    NvmeNamespace *parent;
+    bool enable_write_cache;
+} TmpNvmeNamespace;
+
+static bool nvme_ns_tmp_pre_save(void *opaque, Error **errp)
+{
+    struct TmpNvmeNamespace *tns = opaque;
+
+    tns->enable_write_cache = blk_enable_write_cache(tns->parent->blkconf.blk);
+
+    return true;
+}
+
+static bool nvme_ns_tmp_post_load(void *opaque, int version_id, Error **errp)
+{
+    struct TmpNvmeNamespace *tns = opaque;
+
+    blk_set_enable_write_cache(tns->parent->blkconf.blk, tns->enable_write_cache);
+
+    return true;
+}
+
+static const VMStateDescription nvme_vmstate_ns_tmp = {
+    .name = "nvme_ns_tmp",
+    .pre_save_errp = nvme_ns_tmp_pre_save,
+    .post_load_errp = nvme_ns_tmp_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(enable_write_cache, TmpNvmeNamespace),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription nvme_vmstate_ns = {
+    .name = "nvme_ns",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_WITH_TMP(NvmeNamespace, TmpNvmeNamespace, nvme_vmstate_ns_tmp),
+
+        VMSTATE_STRUCT(id_ns, NvmeNamespace, 0, nvme_vmstate_id_ns, NvmeIdNs),
+        VMSTATE_STRUCT(id_ns_nvm, NvmeNamespace, 0, nvme_vmstate_id_ns_nvm, NvmeIdNsNvm),
+        VMSTATE_STRUCT(id_ns_ind, NvmeNamespace, 0, nvme_vmstate_id_ns_ind, NvmeIdNsInd),
+        VMSTATE_STRUCT(lbaf, NvmeNamespace, 0, nvme_vmstate_lbaf, NvmeLBAF),
+        VMSTATE_UINT32(nlbaf, NvmeNamespace),
+        VMSTATE_UINT8(csi, NvmeNamespace),
+        VMSTATE_UINT16(status, NvmeNamespace),
+        VMSTATE_UINT8(pif, NvmeNamespace),
+
+        VMSTATE_UINT16(zns.zrwas, NvmeNamespace),
+        VMSTATE_UINT16(zns.zrwafg, NvmeNamespace),
+        VMSTATE_UINT32(zns.numzrwa, NvmeNamespace),
+
+        VMSTATE_UINT32(features.err_rec, NvmeNamespace),
+        VMSTATE_STRUCT(atomic, NvmeNamespace, 0, nvme_vmstate_atomic, NvmeAtomic),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_BOOL("detached", NvmeNamespace, params.detached, false),
@@ -937,6 +1096,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
     dc->bus_type = TYPE_NVME_BUS;
     dc->realize = nvme_ns_realize;
     dc->unrealize = nvme_ns_unrealize;
+    dc->vmsd = &nvme_vmstate_ns;
     device_class_set_props(dc, nvme_ns_props);
     dc->desc = "Virtual NVMe namespace";
 }
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 457b6637249..03d6aecb7d7 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -638,6 +638,7 @@ typedef struct NvmeCtrl {
 
     NvmeNamespace   namespace;
     NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES + 1];
+    uint32_t        num_queues;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
@@ -669,6 +670,7 @@ typedef struct NvmeCtrl {
 
     /* Migration-related stuff */
     Error *migration_blocker;
+    bool stop_processing_sq;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
@@ -749,4 +751,7 @@ void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
 void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
                                        uint16_t nabspf, NvmeAtomic *atomic);
 
+extern const VMStateDescription nvme_vmstate_atomic;
+extern const VMStateDescription nvme_vmstate_ns;
+
 #endif /* HW_NVME_NVME_H */
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 6be0bfa1c1f..8e5544e0008 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -7,6 +7,17 @@ pci_nvme_dbbuf_config(uint64_t dbs_addr, uint64_t eis_addr) "dbs_addr=0x%"PRIx64
 pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
+pci_nvme_pre_save_enter(void *n) "n=%p"
+pci_nvme_pre_save_ns_drain(void *n, int i) "n=%p i=%d"
+pci_nvme_pre_save_sq_out_req_drain_wait(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_pre_save_sq_out_req_drain_wait_end(void *n, int i, uint32_t head, uint32_t tail) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32""
+pci_nvme_pre_save_cq_req_drain_wait(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_pre_save_cq_req_drain_wait_end(void *n, int i, uint32_t head, uint32_t tail) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32""
+pci_nvme_pre_save_aer(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+pci_nvme_post_load_enter(void *n) "n=%p"
+pci_nvme_post_load_restore_cq(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_post_load_restore_sq(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_post_load_aer(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 pci_nvme_map_sgl(uint8_t typ, uint64_t len) "type 0x%"PRIx8" len %"PRIu64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid 0x%"PRIx32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
-- 
2.47.3


