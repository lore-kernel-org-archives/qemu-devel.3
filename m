Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B60CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdV4-0001WQ-0z; Thu, 11 Jun 2026 07:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdV2-0001Vd-CZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:23:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUx-000183-LE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:23:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so5479884f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781176978; x=1781781778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKDTof7hhx4rEM/ecDz8BbuNNqta8VjPAfvh6jFaR7A=;
 b=Ca4sG8bv7bxUgzKKgTTZEJzigk/zQp9ld0s780TgN6+tCOWPBggfLrB5Tjq0cBXMi6
 et4kzW/sA4u8nnFtrzG/p82mUF/B60veDNKHYVlcCKCGVuqURXTiUK/cHnjP4EeBkJYo
 nOMQlRT2zVENEEVZRkA4bG3ksaZoc4oJ2UO8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176978; x=1781781778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YKDTof7hhx4rEM/ecDz8BbuNNqta8VjPAfvh6jFaR7A=;
 b=lBd6xllEvrnrz0UeCS1cLLkMuvwgEXuprxQiiHOy/wo9YXdOZVnoOkqt3ssrLPm6b+
 6ZoCi5Agk5h+NZfNpGbZh7cauwnphjwIQthxkLs9qpOkOulCBlA80oCpckawXDIOA8mP
 oKWnD5oOpIqpWWYrRrn2xUje2IWGefEBi7qoILC+lkqA/MZ+MkuJzOQcRN+8jkF/yZK/
 3cWlK4sPXjbxhQLkDUA9ViOAdl9SIS7GIHp4c5H///8TjAO7ZciFcmVUhqPq6MbtTg9O
 9kL7DWgc506GxP71qes9q9CRv3sXGqIKvZ9Y53wWJ2aKMH5OkV08OZqvPixUwH+hFxPx
 ztTg==
X-Gm-Message-State: AOJu0Yy37zH1CcoFmkXPhhucweLTeu3bak7Yd5NbfhcaTf/p5G89H/U2
 zkUxUjNWXx2NYicJYEB2yQUC69dFD7epSgHSJqqHmocq/ZkSlUY8nkr3jTE5kZe/IndktdMrFLF
 qrKrcGCc=
X-Gm-Gg: Acq92OGichbvhMbwkRP6kmLNQ2pfeq+vsQMroXc8voB9rOkT5zF1Tp98PZL+ifUIrOc
 Mjw96yehlFsF+EKVl11BOBmiGevi8pU1ZfOpDjK2kBP5rsVEAL+jbte/ItH8ckFtEgAWB7FKHS/
 juAtbCtb9Hzxm4EHKRqdUlESHcUKND5pqdFwnhFPh08qsB8k7tVTCZ9AyhQTR8x+GKaK3jqB0LA
 ifxoGluf5ld7K9+4SjUn3fOJ+6Wd3RZY1onsxeDPPnanje6IiTiAWPk73bfMbG4Cbila/wfM4bc
 pN/DiJ5p3equowqTn3S74xnWsBYKFiEeld6CVKbuDrIxsUK/ZmWqCUCaWGbYkmdS75NiNDhDNCR
 tmjf08uemcD2ahO3oehfkQ/diIM9o2xYQ2s77QEkUTJbzqinebPj5nbEAKJVuowgyowncLqM5St
 Hvs4uQdpNoC2N/N6gq9d0wxZ2YxzlLGk21AC8ygbTFV4u1zJP0QEVTksOYm9tcSqND/U7/HVqSa
 V2yNZ/QTNjVO751ntPSkQiZxD9k2SKyUJAa4o8OJYAX
X-Received: by 2002:a05:6000:1449:b0:44a:247e:67b1 with SMTP id
 ffacd0b85a97d-4606746a051mr3719214f8f.5.1781176977667; 
 Thu, 11 Jun 2026 04:22:57 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006c26edf58ff062dc.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6c26:edf5:8ff0:62dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fb24sm86375554f8f.34.2026.06.11.04.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:22:57 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v9 6/8] hw/nvme: add basic live migration support
Date: Thu, 11 Jun 2026 13:22:47 +0200
Message-ID: <20260611112249.165012-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611112249.165012-1-alexander@mihalicyn.com>
References: <20260611112249.165012-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
v2:
- AERs are now fully supported
v6:
- handle full CQ case
v7:
- renamed copy_cq_req_list to move_cq_req_list
- validate incoming migration stream better
v9:
- trivial check-patch fixes
---
 hw/nvme/ctrl.c       | 760 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/ns.c         | 164 ++++++++++
 hw/nvme/nvme.h       |   9 +
 hw/nvme/trace-events |  10 +
 4 files changed, 934 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c65b43a04ca..ced394276d3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -210,6 +210,7 @@
 #include "hw/pci/pcie_sriov.h"
 #include "system/spdm-socket.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -1520,6 +1521,18 @@ static void nvme_post_cqes(void *opaque)
             break;
         }
 
+        /*
+         * Here we take the following fields from NvmeRequest structure
+         * and write cqe to the guest RAM based on them:
+         * - req->sq
+         * - req->status
+         * - req->cqe
+         *
+         * If you change this code and more fields from NvmeRequest are
+         * used, please make sure that you have handled this in:
+         * nvme_vmstate_request and nvme_ctrl_pre_save().
+         */
+
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_head = cpu_to_le16(sq->head);
@@ -4905,6 +4918,25 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
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
@@ -5607,6 +5639,39 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     __nvme_init_cq(cq);
 }
 
+static void move_cq_req_list(NvmeCQueue *cq_to, NvmeCQueue *cq_from)
+{
+    NvmeRequest *req, *next;
+
+    QTAILQ_FOREACH_SAFE(req, &cq_from->req_list, entry, next) {
+        QTAILQ_REMOVE(&cq_from->req_list, req, entry);
+        QTAILQ_INSERT_TAIL(&cq_to->req_list, req, entry);
+    }
+}
+
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
+        QTAILQ_INIT(&cq->req_list);
+        move_cq_req_list(cq, cq_from);
+    }
+
+    __nvme_init_cq(cq);
+}
+
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
@@ -7297,7 +7362,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     n->dbbuf_eis = eis_addr;
     n->dbbuf_enabled = true;
 
-    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 0; i < n->num_queues; i++) {
         NvmeSQueue *sq = n->sq[i];
         NvmeCQueue *cq = n->cq[i];
 
@@ -7741,7 +7806,7 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
     /*
      * Walk the queues to see if there are any atomic conflicts.
      */
-    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
+    for (i = 1; i < n->num_queues; i++) {
         NvmeSQueue *sq;
         NvmeRequest *req;
         NvmeRwCmd *req_rw;
@@ -7811,6 +7876,12 @@ static void nvme_process_sq(void *opaque)
     NvmeCmd cmd;
     NvmeRequest *req;
 
+    /*
+     * We don't want to have a race with nvme_ctrl_pre_save().
+     * What implicitly protects us from this is BQL.
+     */
+    assert(bql_locked());
+
     if (n->dbbuf_enabled) {
         nvme_update_sq_tail(sq);
     }
@@ -7928,12 +7999,12 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
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
@@ -8603,6 +8674,8 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         params->max_ioqpairs = params->num_queues - 1;
     }
 
+    n->num_queues = params->max_ioqpairs + 1;
+
     if (n->namespace.blkconf.blk && n->subsys) {
         error_setg(errp, "subsystem support is unavailable with legacy "
                    "namespace ('drive' property)");
@@ -8776,8 +8849,8 @@ static void nvme_init_state(NvmeCtrl *n)
         n->conf_msix_qsize = n->params.msix_qsize;
     }
 
-    n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
-    n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+    n->sq = g_new0(NvmeSQueue *, n->num_queues);
+    n->cq = g_new0(NvmeCQueue *, n->num_queues);
     n->temperature = NVME_TEMPERATURE;
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
@@ -9012,7 +9085,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
-        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, 0, NULL, NULL);
+        bar_size = nvme_mbar_size(n->num_queues, 0, NULL, NULL);
         memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
                               bar_size);
         pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -9024,7 +9097,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         /* add one to max_ioqpairs to account for the admin queue pair */
         if (!pci_is_vf(pci_dev)) {
             nr_vectors = n->params.msix_qsize;
-            bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
+            bar_size = nvme_mbar_size(n->num_queues,
                                       nr_vectors, &msix_table_offset,
                                       &msix_pba_offset);
         } else {
@@ -9756,9 +9829,678 @@ static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
     return pci_default_read_config(dev, address, len);
 }
 
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
+        VMSTATE_STRUCT(sgl, NvmeCmdDptr, 0,
+                       nvme_vmstate_cmd_dptr_sgl, NvmeSglDescriptor),
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
+static bool nvme_req_pre_load(void *opaque, Error **errp)
+{
+    memset(opaque, 0x0, sizeof(NvmeRequest));
+    return true;
+}
+
+static const VMStateDescription nvme_vmstate_request = {
+    .name = "nvme-request",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load_errp = nvme_req_pre_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(status, NvmeRequest),
+        VMSTATE_STRUCT(cqe, NvmeRequest, 0, nvme_vmstate_cqe, NvmeCqe),
+        VMSTATE_STRUCT(cmd, NvmeRequest, 0, nvme_vmstate_cmd, NvmeCmd),
+        VMSTATE_END_OF_LIST()
+    }
+};
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
+static bool nvme_cqueue_pre_load(void *opaque, Error **errp)
+{
+    NvmeCQueue *cq = opaque;
+
+    QTAILQ_INIT(&cq->req_list);
+    return true;
+}
+
+static const VMStateDescription nvme_vmstate_cqueue = {
+    .name = "nvme-cq",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load_errp = nvme_cqueue_pre_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(phase, NvmeCQueue),
+        VMSTATE_UINT16(cqid, NvmeCQueue),
+        VMSTATE_UINT16(irq_enabled, NvmeCQueue),
+        VMSTATE_UINT32(head, NvmeCQueue),
+        VMSTATE_UINT32(tail, NvmeCQueue),
+        VMSTATE_UINT32(vector, NvmeCQueue),
+        VMSTATE_UINT32(size, NvmeCQueue),
+        VMSTATE_UINT64(dma_addr, NvmeCQueue),
+
+        VMSTATE_QTAILQ_V(req_list, NvmeCQueue, 1, nvme_vmstate_request,
+                         NvmeRequest, entry),
+
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
+        VMSTATE_STRUCT(result, NvmeAsyncEvent, 0,
+                       nvme_vmstate_async_event_result, NvmeAerResult),
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
+static bool pre_save_validate_aer_req(NvmeRequest *req, Error **errp)
+{
+    /*
+     * Can't use assert() here, because we don't want
+     * to just crash QEMU when user requests a migration.
+     */
+    if (!(req->cmd.opcode == NVME_ADM_CMD_ASYNC_EV_REQ)) {
+        error_setg(errp, "req->cmd.opcode (%u) != NVME_ADM_CMD_ASYNC_EV_REQ",
+                   req->cmd.opcode);
+        return false;
+    }
+
+    if (!(req->ns == NULL)) {
+        error_setg(errp, "req->ns != NULL");
+        return false;
+    }
+
+    if (!(req->sq == &req->sq->ctrl->admin_sq)) {
+        error_setg(errp, "req->sq != &req->sq->ctrl->admin_sq");
+        return false;
+    }
+
+    if (!(req->aiocb == NULL)) {
+        error_setg(errp, "req->aiocb != NULL");
+        return false;
+    }
+
+    if (!(req->opaque == NULL)) {
+        error_setg(errp, "req->opaque != NULL");
+        return false;
+    }
+
+    if (!(req->atomic_write == false)) {
+        error_setg(errp, "req->atomic_write != false");
+        return false;
+    }
+
+    if (req->sg.flags & NVME_SG_ALLOC) {
+        error_setg(errp, "unexpected NVME_SG_ALLOC flag in req->sg.flags");
+        return false;
+    }
+
+    return true;
+}
+
+static bool pre_save_validate_cq_req(NvmeRequest *req, Error **errp)
+{
+    if (!(req->ns == NULL)) {
+        error_setg(errp, "req->ns != NULL");
+        return false;
+    }
+
+    if (!(req->aiocb == NULL)) {
+        error_setg(errp, "req->aiocb != NULL");
+        return false;
+    }
+
+    if (!(req->opaque == NULL)) {
+        error_setg(errp, "req->opaque != NULL");
+        return false;
+    }
+
+    if (!(req->atomic_write == false)) {
+        error_setg(errp, "req->atomic_write != false");
+        return false;
+    }
+
+    if (req->sg.flags & NVME_SG_ALLOC) {
+        error_setg(errp, "unexpected NVME_SG_ALLOC flag in req->sg.flags");
+        return false;
+    }
+
+    return true;
+}
+
+static bool nvme_ctrl_pre_save(void *opaque, Error **errp)
+{
+    NvmeCtrl *n = opaque;
+    int i;
+
+    trace_pci_nvme_pre_save_enter(n);
+
+    /*
+     * We don't want to have a race with nvme_process_sq().
+     * What implicitly protects us from this is BQL.
+     */
+    assert(bql_locked());
+
+    /* cancel all SQ processing BHs */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+
+        if (!sq) {
+            continue;
+        }
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
+     * We must be really careful here, because in case of further
+     * QEMU NVMe changes, we may break migration without noticing it, or worse,
+     * introduce silent data corruption during migration.
+     */
+    if (n->aer_queued) {
+        NvmeAsyncEvent *event;
+
+        QTAILQ_FOREACH(event, &n->aer_queue, entry) {
+            trace_pci_nvme_pre_save_aer(event->result.event_type,
+                                        event->result.event_info,
+                                        event->result.log_page);
+        }
+    }
+
+    for (i = 0; i < n->outstanding_aers; i++) {
+        NvmeRequest *req = n->aer_reqs[i];
+
+        if (!pre_save_validate_aer_req(req, errp)) {
+            return false;
+        }
+    }
+
+    /*
+     * Make sure that all in-flight IO requests
+     * (except NVME_ADM_CMD_ASYNC_EV_REQ) are processed.
+     */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeRequest *req;
+        NvmeSQueue *sq = n->sq[i];
+
+        if (!sq) {
+            continue;
+        }
+
+        trace_pci_nvme_pre_save_sq_out_req_check(n, i,
+                                                 sq->head, sq->tail, sq->size);
+
+        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
+            assert(req->cmd.opcode == NVME_ADM_CMD_ASYNC_EV_REQ);
+        }
+    }
+
+    /* wait when all IO requests completions are written to guest memory */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeCQueue *cq = n->cq[i];
+
+        if (!cq) {
+            continue;
+        }
+
+        qemu_bh_cancel(cq->bh);
+        /* this should empty cq->req_list unless CQ is full */
+        nvme_post_cqes(cq);
+
+        trace_pci_nvme_pre_save_cq_req_check(n, i,
+                                             cq->head, cq->tail, cq->size);
+
+        if (!QTAILQ_EMPTY(&cq->req_list)) {
+            NvmeRequest *req;
+
+            assert(nvme_cq_full(cq));
+
+            QTAILQ_FOREACH(req, &cq->req_list, entry) {
+                trace_pci_nvme_pre_save_cq_unposted_cqe(
+                                            n, i, nvme_cid(req),
+                                            nvme_nsid(req->ns),
+                                            le32_to_cpu(req->cqe.result),
+                                            le32_to_cpu(req->cqe.dw1),
+                                            req->status, req->cmd.opcode);
+                if (!pre_save_validate_cq_req(req, errp)) {
+                    return false;
+                }
+            }
+        }
+    }
+
+    for (uint32_t nsid = 0; nsid <= NVME_MAX_NAMESPACES; nsid++) {
+        NvmeNamespace *ns = n->namespaces[nsid];
+
+        if (!ns) {
+            continue;
+        }
+
+        if (ns != &n->namespace) {
+            error_setg(errp,
+                       "only one NVMe namespace is supported for migration");
+            return false;
+        }
+    }
+
+    return true;
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
+        if (!cq) {
+            continue;
+        }
+
+        if (cq->cqid != i) {
+            error_setg(errp, "inconsistent migration stream (cq->cqid != i)");
+            return false;
+        }
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
+        if (!sq) {
+            continue;
+        }
+
+        if (sq->sqid != i) {
+            error_setg(errp, "inconsistent migration stream (sq->sqid != i)");
+            return false;
+        }
+
+        if (!n->cq[sq->cqid]) {
+            error_setg(errp,
+                       "inconsistent migration stream (n->cq[sq->cqid] is NULL)");
+            return false;
+        }
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
+    /* restore cq->req_list-s */
+    for (i = 0; i < n->num_queues; i++) {
+        NvmeRequest *req_from, *next;
+        typeof_field(NvmeCQueue, req_list) req_list;
+        NvmeCQueue *cq = n->cq[i];
+
+        if (!cq || QTAILQ_EMPTY(&cq->req_list)) {
+            continue;
+        }
+
+        /*
+         * We use nvme_vmstate_request VMStateDescription to save/restore
+         * NvmeRequest structures, but tricky thing here is that
+         * memory for each cq->req_list item is allocated separately
+         * during restore. It doesn't work for us. We need to take
+         * an existing NvmeRequest structure from SQ's req_list pool
+         * and fill it with data from the newly allocated one (req_from).
+         * Then, we can safely release allocated memory for it.
+         */
+
+        /* make a copy of cq->req_list (QTAILQ head) and clean cq->req_list */
+        QTAILQ_INIT(&req_list);
+        QTAILQ_FOREACH_SAFE(req_from, &cq->req_list, entry, next) {
+            QTAILQ_REMOVE(&cq->req_list, req_from, entry);
+            QTAILQ_INSERT_TAIL(&req_list, req_from, entry);
+        }
+        QTAILQ_INIT(&cq->req_list);
+
+        QTAILQ_FOREACH_SAFE(req_from, &req_list, entry, next) {
+            uint16_t sqid = le16_to_cpu(req_from->cqe.sq_id);
+            NvmeRequest *req;
+            NvmeSQueue *sq;
+
+            assert(!nvme_check_sqid(n, sqid));
+            sq = n->sq[sqid];
+
+            req = QTAILQ_FIRST(&sq->req_list);
+            QTAILQ_REMOVE(&sq->req_list, req, entry);
+            QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
+            nvme_req_clear(req);
+
+            /* copy data from the source NvmeRequest */
+            req->status = req_from->status;
+            memcpy(&req->cqe, &req_from->cqe, sizeof(NvmeCqe));
+            memcpy(&req->cmd, &req_from->cmd, sizeof(NvmeCmd));
+
+            QTAILQ_REMOVE(&req_list, req_from, entry);
+            g_free(req_from);
+        }
+
+        qemu_bh_schedule(cq->bh);
+    }
+
+    if (n->aer_queued) {
+        NvmeAsyncEvent *event;
+
+        QTAILQ_FOREACH(event, &n->aer_queue, entry) {
+            trace_pci_nvme_post_load_aer(event->result.event_type,
+                                         event->result.event_info,
+                                         event->result.log_page);
+        }
+    }
+
+    for (i = 0; i < n->outstanding_aers; i++) {
+        NvmeSQueue *sq = &n->admin_sq;
+        NvmeRequest *req_from = n->aer_reqs[i];
+        NvmeRequest *req;
+
+        /* Idea here is the same as for "restore cq->req_list-s" step */
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
+        if (!sq) {
+            continue;
+        }
+
+        qemu_bh_schedule(sq->bh);
+    }
+
+    return true;
+}
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
+            aer_reqs, NvmeCtrl, outstanding_aers, 0,
+            nvme_vmstate_request, NvmeRequest),
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
+        VMSTATE_STRUCT(features.hbs, NvmeCtrl, 0,
+                       nvme_vmstate_hbs, NvmeHostBehaviorSupport),
+
+        VMSTATE_UINT32(dn, NvmeCtrl),
+        VMSTATE_STRUCT(atomic, NvmeCtrl, 0, nvme_vmstate_atomic, NvmeAtomic),
+
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static void nvme_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index b0106eaa5c8..4caab590977 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "system/system.h"
 #include "system/block-backend.h"
+#include "migration/vmstate.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -886,6 +887,168 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
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
+    blk_set_enable_write_cache(tns->parent->blkconf.blk,
+                               tns->enable_write_cache);
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
+        VMSTATE_STRUCT(id_ns_nvm, NvmeNamespace, 0,
+                       nvme_vmstate_id_ns_nvm, NvmeIdNsNvm),
+        VMSTATE_STRUCT(id_ns_ind, NvmeNamespace, 0,
+                       nvme_vmstate_id_ns_ind, NvmeIdNsInd),
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
+        VMSTATE_STRUCT(atomic, NvmeNamespace, 0,
+                       nvme_vmstate_atomic, NvmeAtomic),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_BOOL("detached", NvmeNamespace, params.detached, false),
@@ -937,6 +1100,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
     dc->bus_type = TYPE_NVME_BUS;
     dc->realize = nvme_ns_realize;
     dc->unrealize = nvme_ns_unrealize;
+    dc->vmsd = &nvme_vmstate_ns;
     device_class_set_props(dc, nvme_ns_props);
     dc->desc = "Virtual NVMe namespace";
 }
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 05aee24a15c..78a6eaa1774 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -444,6 +444,11 @@ typedef struct NvmeRequest {
     NvmeSg                  sg;
     bool                    atomic_write;
     QTAILQ_ENTRY(NvmeRequest)entry;
+    /*
+     * If you add a new field here, please make sure to update
+     * nvme_vmstate_request, pre_save_validate_aer_req() and
+     * pre_save_validate_cq_req().
+     */
 } NvmeRequest;
 
 typedef struct NvmeBounceContext {
@@ -640,6 +645,7 @@ typedef struct NvmeCtrl {
 
     NvmeNamespace   namespace;
     NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES + 1];
+    uint32_t        num_queues;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
@@ -751,4 +757,7 @@ void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
 void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
                                        uint16_t nabspf, NvmeAtomic *atomic);
 
+extern const VMStateDescription nvme_vmstate_atomic;
+extern const VMStateDescription nvme_vmstate_ns;
+
 #endif /* HW_NVME_NVME_H */
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 6be0bfa1c1f..f97a6a11f36 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -7,6 +7,16 @@ pci_nvme_dbbuf_config(uint64_t dbs_addr, uint64_t eis_addr) "dbs_addr=0x%"PRIx64
 pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
+pci_nvme_pre_save_enter(void *n) "n=%p"
+pci_nvme_pre_save_ns_drain(void *n, int i) "n=%p i=%d"
+pci_nvme_pre_save_sq_out_req_check(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_pre_save_cq_req_check(void *n, int i, uint32_t head, uint32_t tail, uint32_t size) "n=%p i=%d head=0x%"PRIx32" tail=0x%"PRIx32" size=0x%"PRIx32""
+pci_nvme_pre_save_cq_unposted_cqe(void *n, int i, uint16_t cid, uint32_t nsid, uint32_t dw0, uint32_t dw1, uint16_t status, uint8_t opc) "n=%p i=%d cid %"PRIu16" nsid %"PRIu32" dw0 0x%"PRIx32" dw1 0x%"PRIx32" status 0x%"PRIx16" opc 0x%"PRIx8""
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


