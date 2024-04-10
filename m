Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CB5CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQnw-0001F5-I6; Wed, 10 Apr 2024 01:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQmN-0005QT-KT; Wed, 10 Apr 2024 01:45:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQmL-0001iP-K8; Wed, 10 Apr 2024 01:45:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD1825D4E9;
 Wed, 10 Apr 2024 08:46:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 81605B0150;
 Wed, 10 Apr 2024 08:44:17 +0300 (MSK)
Received: (nullmailer pid 4182052 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 17/41] hw/nvme: generalize the mbar size helper
Date: Wed, 10 Apr 2024 08:43:38 +0300
Message-Id: <20240410054416.4181891-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Klaus Jensen <k.jensen@samsung.com>

Generalize the mbar size helper such that it can handle cases where the
MSI-X table and PBA are expected to be in an exclusive bar.

Cc: qemu-stable@nongnu.org
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit ee7bda4d38cda3eaf114c850a723dd12e23d3abc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c2c0fc991d..32df214762 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7221,13 +7221,18 @@ static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
     memory_region_set_enabled(&n->pmr.dev->mr, false);
 }
 
-static uint64_t nvme_bar_size(unsigned total_queues, unsigned total_irqs,
-                              unsigned *msix_table_offset,
-                              unsigned *msix_pba_offset)
+static uint64_t nvme_mbar_size(unsigned total_queues, unsigned total_irqs,
+                               unsigned *msix_table_offset,
+                               unsigned *msix_pba_offset)
 {
-    uint64_t bar_size, msix_table_size, msix_pba_size;
+    uint64_t bar_size, msix_table_size;
 
     bar_size = sizeof(NvmeBar) + 2 * total_queues * NVME_DB_SIZE;
+
+    if (total_irqs == 0) {
+        goto out;
+    }
+
     bar_size = QEMU_ALIGN_UP(bar_size, 4 * KiB);
 
     if (msix_table_offset) {
@@ -7242,11 +7247,10 @@ static uint64_t nvme_bar_size(unsigned total_queues, unsigned total_irqs,
         *msix_pba_offset = bar_size;
     }
 
-    msix_pba_size = QEMU_ALIGN_UP(total_irqs, 64) / 8;
-    bar_size += msix_pba_size;
+    bar_size += QEMU_ALIGN_UP(total_irqs, 64) / 8;
 
-    bar_size = pow2ceil(bar_size);
-    return bar_size;
+out:
+    return pow2ceil(bar_size);
 }
 
 static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
@@ -7254,7 +7258,7 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
-    uint64_t bar_size = nvme_bar_size(le16_to_cpu(cap->vqfrsm),
+    uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
@@ -7293,7 +7297,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     ERRP_GUARD();
     uint8_t *pci_conf = pci_dev->config;
     uint64_t bar_size;
-    unsigned msix_table_offset, msix_pba_offset;
+    unsigned msix_table_offset = 0, msix_pba_offset = 0;
     int ret;
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
@@ -7316,8 +7320,8 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
-    bar_size = nvme_bar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
-                             &msix_table_offset, &msix_pba_offset);
+    bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
+                              &msix_table_offset, &msix_pba_offset);
 
     memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
-- 
2.39.2


