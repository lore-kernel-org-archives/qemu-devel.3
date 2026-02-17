Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9712AE909D2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNMC-0002KI-JJ; Tue, 17 Feb 2026 10:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx6-0003c9-Pi
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:28 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx3-0005g1-K0
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso50903015e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1771341924; x=1771946724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9nhnmahfRPZOwCo/9FB5xouigszThFTho5JgnvAt7o=;
 b=YtQ/qOrEgM+XhqSCCTiCiGqNNSMvZgR0GiEG7WCG8oEWDfJyDDS2TlMgqg6vhtoN8j
 ueu7DzgTxbmbSyjibDWpGxr3xewzshRDvUdaVZ3wBlVlo0aAl3FBNd1Mjwab+bHgk0Ne
 chdj3d4bsu93C7Hm2uSLy09hRy71wdGhL8b2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771341924; x=1771946724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X9nhnmahfRPZOwCo/9FB5xouigszThFTho5JgnvAt7o=;
 b=OCdcz9/yHmpSmGeRX0sRUZIg/pZL782t0s19pQt31acoe0TyXCcZbQeGX7PWP5kr6C
 GL9XyMgghFI0N4hUXfytDJoHPNAmxp9PmXq4LkwZFYoczdIlT6zm50HK2NS30xFoCUe3
 nUojTWLFgFDBIMASGv/fIRYusJnBGO3SoPqPNUUPHWc7T9bnfMnfkuA3pNPdyMvZazqp
 gjqSmJzUi2wyOlITXKl5Z9l+vaS38Rz+B2r8Dgg+OzWDdoOmMMuSQFA/YDyGxtAOS+tX
 hNKOdMU0oBPmp0GJO3UpO1gWVeiFDKtlwAWxGvpgKj6y8YQKBz/iBzaPrzgDhmktSGte
 C+Xw==
X-Gm-Message-State: AOJu0YyUC82PDZC1FS10Xa46ut+CR5FZJv/0xUxbc0vFz6RHjjTt39Tc
 KSHu+iIMHhvOkKepIGmjkuvlXDEDaxxb17rFw4wtOCGeuk2H2Kc/ikNXmH1+UkwWs9XDAbRwq8n
 20nYw
X-Gm-Gg: AZuq6aL4CUEZTJ3FpYHB63RqB/5oAzDmDIvYEkP4Sy92oWoPufnRJhzGxjOaVemvFrh
 BBzRBZlR32fvSZ2IgsQie4F+C9lHWRsAgpOZ+Q9uG4q7SESf9yqohIf7dH4Asw2LEtYfdCiBFcw
 1AJ9A9lMnUD/i+8IOXX3oq0CXUEjpMgoEXvVBdif20B8SrkLuJWjd6o+7P+sk4BVdho0wLV8T4T
 OU6ZgCvvu6IlP6MPnZy9tBQsrqocrtye1nrW3qsJMe1veqFYTuOwdDZgpkJEmijpqDhpNaV2zDX
 POaXAJRhnL1hHsUeyHymPN2nr0LtwpIA1lF0K+IlEaLKKu1Ec84Fc/DWL9AOGIeOpgwbsZRkaaY
 fSYRWKgeG/nLhFq7CuD1TxXXHwTaLGgbujXXGz+X2TAI5ppP3gWHk51x5gzez41FCVJQ+qLMsp2
 vjCVtFQOyiZzoyvvofH2HVJzA4/qyKl/Oq8UtSF0xee7BjdkhRURnu1zeZ1zzcl9ZrnprlSInnV
 n9i/y+EFN5/paaY2/LHTXQ=
X-Received: by 2002:a05:600c:8b61:b0:47e:e78a:c832 with SMTP id
 5b1f17b1804b1-48379c286d4mr184174245e9.37.1771341924129; 
 Tue, 17 Feb 2026 07:25:24 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf574bcf00ffb15ba913f79a3b.dip0.t-ipconnect.de.
 [2003:cf:574b:cf00:ffb1:5ba9:13f7:9a3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm519169015e9.14.2026.02.17.07.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:25:23 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 4/4] hw/nvme: add basic live migration support
Date: Tue, 17 Feb 2026 16:25:17 +0100
Message-ID: <20260217152517.271422-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217152517.271422-1-alexander@mihalicyn.com>
References: <20260217152517.271422-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Feb 2026 10:51:21 -0500
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
- AERs are not fully supported

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c       | 413 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h       |   2 +
 hw/nvme/trace-events |   9 +
 3 files changed, 415 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 89cc26d745b..a92837844df 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -208,6 +208,7 @@
 #include "hw/pci/pcie_sriov.h"
 #include "system/spdm-socket.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -4901,6 +4902,25 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
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
@@ -5603,6 +5623,27 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
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
@@ -7291,7 +7332,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     n->dbbuf_eis = eis_addr;
     n->dbbuf_enabled = true;
 
-    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 0; i < n->num_queues; i++) {
         NvmeSQueue *sq = n->sq[i];
         NvmeCQueue *cq = n->cq[i];
 
@@ -7731,7 +7772,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
     /*
      * Walk the queues to see if there are any atomic conflicts.
      */
-    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 1; i < n->num_queues; i++) {
         NvmeSQueue *sq;
         NvmeRequest *req;
         NvmeRwCmd *req_rw;
@@ -7801,6 +7842,10 @@ static void nvme_process_sq(void *opaque)
     NvmeCmd cmd;
     NvmeRequest *req;
 
+    if (qatomic_read(&n->stop_processing_sq)) {
+        return;
+    }
+
     if (n->dbbuf_enabled) {
         nvme_update_sq_tail(sq);
     }
@@ -7809,6 +7854,10 @@ static void nvme_process_sq(void *opaque)
         NvmeAtomic *atomic;
         bool cmd_is_atomic;
 
+        if (qatomic_read(&n->stop_processing_sq)) {
+            return;
+        }
+
         addr = sq->dma_addr + (sq->head << NVME_SQES);
         if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
             trace_pci_nvme_err_addr_read(addr);
@@ -7917,12 +7966,12 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
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
@@ -8592,6 +8641,8 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         params->max_ioqpairs = params->num_queues - 1;
     }
 
+    n->num_queues = params->max_ioqpairs + 1;
+
     if (n->namespace.blkconf.blk && n->subsys) {
         error_setg(errp, "subsystem support is unavailable with legacy "
                    "namespace ('drive' property)");
@@ -8746,8 +8797,8 @@ static void nvme_init_state(NvmeCtrl *n)
         n->conf_msix_qsize = n->params.msix_qsize;
     }
 
-    n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
-    n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+    n->sq = g_new0(NvmeSQueue *, n->num_queues);
+    n->cq = g_new0(NvmeCQueue *, n->num_queues);
     n->temperature = NVME_TEMPERATURE;
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
@@ -8990,7 +9041,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
-        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, 0, NULL, NULL);
+        bar_size = nvme_mbar_size(n->num_queues, 0, NULL, NULL);
         memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
                               bar_size);
         pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -9002,7 +9053,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         /* add one to max_ioqpairs to account for the admin queue pair */
         if (!pci_is_vf(pci_dev)) {
             nr_vectors = n->params.msix_qsize;
-            bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
+            bar_size = nvme_mbar_size(n->num_queues,
                                       nr_vectors, &msix_table_offset,
                                       &msix_pba_offset);
         } else {
@@ -9552,9 +9603,353 @@ static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
     return pci_default_read_config(dev, address, len);
 }
 
+static int nvme_ctrl_pre_save(void *opaque)
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
+     * It is a bit tricky, because AER can be queued
+     * (added to n->aer_queue) when something happens,
+     * but then we need to wait until guest submits
+     * NVME_ADM_CMD_ASYNC_EV_REQ, only after this
+     * we can get remove it from aer_queue and produce
+     * CQE on that NVME_ADM_CMD_ASYNC_EV_REQ command.
+     *
+     * If we are unlucky, and guest haven't submited
+     * NVME_ADM_CMD_ASYNC_EV_REQ recently, but there
+     * are a few events in aer_queue, then nvme_process_aers()
+     * is useless. But we should at least try.
+     */
+    nvme_process_aers(n);
+
+    /*
+     * Now we go in a hard way:
+     * 1. Remove all queued events.
+     * 2. Abort all NVME_ADM_CMD_ASYNC_EV_REQ requests.
+     *
+     * TODO: dump/restore this stuff?
+     */
+    while (!QTAILQ_EMPTY(&n->aer_queue)) {
+        NvmeAsyncEvent *event = QTAILQ_FIRST(&n->aer_queue);
+        QTAILQ_REMOVE(&n->aer_queue, event, entry);
+        n->aer_queued--;
+        g_free(event);
+    }
+
+    for (i = 0; i < n->outstanding_aers; i++) {
+        NvmeRequest *re = n->aer_reqs[i];
+        memmove(n->aer_reqs + i, n->aer_reqs + i + 1,
+                    (n->outstanding_aers - i - 1) * sizeof(NvmeRequest *));
+        n->outstanding_aers--;
+        re->status = NVME_CMD_ABORT_REQ;
+        nvme_enqueue_req_completion(&n->admin_cq, re);
+    }
+
+    /*
+     * nvme_enqueue_req_completion() will schedule BH for Admin CQ,
+     * but we are under BQL and this scheduled BH won't be executed.
+     * Let's manually call nvme_post_cqes().
+     */
+    qemu_bh_cancel(n->admin_cq.bh);
+    nvme_post_cqes(&n->admin_cq);
+
+    if (n->aer_queued != 0 || n->outstanding_aers != 0 || !QTAILQ_EMPTY(&n->aer_queue)) {
+        error_report("%s: AERs migrations is not supported aer_queued=%d outstanding_aers=%d qtailq_empty=%d",
+            __func__, n->aer_queued, n->outstanding_aers, QTAILQ_EMPTY(&n->aer_queue));
+        goto err;
+    }
+
+    /* wait when all in-flight IO requests are processed */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+
+        if (!sq)
+            continue;
+
+        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->head, sq->tail, sq->size);
+
+        while (!QTAILQ_EMPTY(&sq->out_req_list)) {
+            cpu_relax();
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
+                error_report("%s: no free space in CQ (not supported)", __func__);
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
+            error_report("%s: only one NVMe namespace is supported for migration", __func__);
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    /* restore sq processing back to normal */
+    qatomic_set(&n->stop_processing_sq, false);
+    return -1;
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
 static const VMStateDescription nvme_vmstate = {
     .name = "nvme",
-    .unmigratable = 1,
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .pre_save = nvme_ctrl_pre_save,
+    .post_load_errp = nvme_ctrl_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, NvmeCtrl),
+        VMSTATE_MSIX(parent_obj, NvmeCtrl),
+        VMSTATE_STRUCT(bar, NvmeCtrl, 0, nvme_vmstate_bar, NvmeBar),
+
+        VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC(
+            sq, NvmeCtrl, num_queues, 0, nvme_vmstate_squeue, NvmeSQueue),
+        VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC(
+            cq, NvmeCtrl, num_queues, 0, nvme_vmstate_cqueue, NvmeCQueue),
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
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static void nvme_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 457b6637249..9c5f53c688c 100644
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
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 6be0bfa1c1f..b9c5868a942 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -7,6 +7,15 @@ pci_nvme_dbbuf_config(uint64_t dbs_addr, uint64_t eis_addr) "dbs_addr=0x%"PRIx64
 pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
+pci_nvme_pre_save_enter(void *n) "n=%p"
+pci_nvme_pre_save_ns_drain(void *n, int i) "n=%p i=%d"
+pci_nvme_pre_save_sq_out_req_drain_wait(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_pre_save_sq_out_req_drain_wait_end(void *n, int i, uint32_t head, uint32_t tail) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32""
+pci_nvme_pre_save_cq_req_drain_wait(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_pre_save_cq_req_drain_wait_end(void *n, int i, uint32_t head, uint32_t tail) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32""
+pci_nvme_post_load_enter(void *n) "n=%p"
+pci_nvme_post_load_restore_cq(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_post_load_restore_sq(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
 pci_nvme_map_sgl(uint8_t typ, uint64_t len) "type 0x%"PRIx8" len %"PRIu64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid 0x%"PRIx32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
-- 
2.47.3


