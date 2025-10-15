Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D328CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t53-0008VF-7k; Wed, 15 Oct 2025 00:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t51-0008V0-0H; Wed, 15 Oct 2025 00:25:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t4y-0002fS-3B; Wed, 15 Oct 2025 00:25:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BF3E615D9C6;
 Wed, 15 Oct 2025 07:24:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5E98C29FE6F;
 Wed, 15 Oct 2025 07:25:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Damien Bergamini <damien.bergamini@eviden.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 01/11] pcie_sriov: Fix broken MMIO accesses from
 SR-IOV VFs
Date: Wed, 15 Oct 2025 07:25:05 +0300
Message-ID: <20251015042520.68556-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
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

From: Damien Bergamini <damien.bergamini@eviden.com>

Starting with commit cab1398a60eb, SR-IOV VFs are realized as soon as
pcie_sriov_pf_init() is called.  Because pcie_sriov_pf_init() must be
called before pcie_sriov_pf_init_vf_bar(), the VF BARs types won't be
known when the VF realize function calls pcie_sriov_vf_register_bar().

This breaks the memory regions of the VFs (for instance with igbvf):

$ lspci
...
    Region 0: Memory at 281a00000 (64-bit, prefetchable) [virtual] [size=16K]
    Region 3: Memory at 281a20000 (64-bit, prefetchable) [virtual] [size=16K]

$ info mtree
...
address-space: pci_bridge_pci_mem
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    0000000081a00000-0000000081a03fff (prio 1, i/o): igbvf-mmio
    0000000081a20000-0000000081a23fff (prio 1, i/o): igbvf-msix

and causes MMIO accesses to fail:

    Invalid write at addr 0x281A01520, size 4, region '(null)', reason: rejected
    Invalid read at addr 0x281A00C40, size 4, region '(null)', reason: rejected

To fix this, VF BARs are now registered with pci_register_bar() which
has a type parameter and pcie_sriov_vf_register_bar() is removed.

Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")
Signed-off-by: Damien Bergamini <damien.bergamini@eviden.com>
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901151314.1038020-1-clement.mathieu--drif@eviden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2e54e5fda779a7ba45578884276dca62462f7a06)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index ab2142807f..00d7bd93fd 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -72,8 +72,7 @@ setting up a BAR for a VF.
 2) Similarly in the implementation of the virtual function, you need to
    make it a PCI Express device and add a similar set of capabilities
    except for the SR/IOV capability. Then you need to set up the VF BARs as
-   subregions of the PFs SR/IOV VF BARs by calling
-   pcie_sriov_vf_register_bar() instead of the normal pci_register_bar() call:
+   subregions of the PFs SR/IOV VF BARs by calling pci_register_bar():
 
    pci_your_vf_dev_realize( ... )
    {
@@ -83,7 +82,7 @@ setting up a BAR for a VF.
       pcie_ari_init(d, 0x100);
       ...
       memory_region_init(mr, ... )
-      pcie_sriov_vf_register_bar(d, bar_nr, mr);
+      pci_register_bar(d, bar_nr, bar_type, mr);
       ...
    }
 
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 31d72c4977..9b0db8f841 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -251,10 +251,12 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &mmio_ops, s, "igbvf-mmio",
         IGBVF_MMIO_SIZE);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MMIO_BAR_IDX, &s->mmio);
+    pci_register_bar(dev, IGBVF_MMIO_BAR_IDX, PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &s->mmio);
 
     memory_region_init(&s->msix, OBJECT(dev), "igbvf-msix", IGBVF_MSIX_SIZE);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MSIX_BAR_IDX, &s->msix);
+    pci_register_bar(dev, IGBVF_MSIX_BAR_IDX, PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &s->msix);
 
     ret = msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_IDX, 0,
         &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..cd81f73997 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8708,12 +8708,8 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
                               msix_table_offset);
         memory_region_add_subregion(&n->bar0, 0, &n->iomem);
 
-        if (pci_is_vf(pci_dev)) {
-            pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
-        } else {
-            pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
-                             PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
-        }
+        pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
 
         ret = msix_init(pci_dev, nr_vectors,
                         &n->bar0, 0, msix_table_offset,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..4fe2626f9e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1490,9 +1490,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         : pci_get_bus(pci_dev)->address_space_mem;
 
     if (pci_is_vf(pci_dev)) {
-        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;
-        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);
-
         r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);
         if (r->addr != PCI_BAR_UNMAPPED) {
             memory_region_add_subregion_overlap(r->address_space,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 8a4bf0d6f7..29474d749a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -242,17 +242,6 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
     dev->exp.sriov_pf.vf_bar_type[region_num] = type;
 }
 
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory)
-{
-    uint8_t type;
-
-    assert(dev->exp.sriov_vf.pf);
-    type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
-
-    return pci_register_bar(dev, region_num, type, memory);
-}
-
 static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
 {
     return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aeaa38cf34..b0ea6a62c7 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -37,10 +37,6 @@ void pcie_sriov_pf_exit(PCIDevice *dev);
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
                                uint8_t type, dma_addr_t size);
 
-/* Instantiate a bar for a VF */
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory);
-
 /**
  * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
  *                                              VFs, adding ARI to PF
-- 
2.47.3


