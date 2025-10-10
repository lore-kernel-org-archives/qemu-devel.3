Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A5FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 04:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75CE-0001tn-Qw; Fri, 10 Oct 2025 00:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v75CD-0001tW-Ce; Fri, 10 Oct 2025 00:57:37 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v75C8-00010z-P3; Fri, 10 Oct 2025 00:57:36 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59A4uCoX010896
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 13:56:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+h4w5lSOwAHTy3Gp/c5xxD+Vq2j50hhhIAyncRpnBd8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1760072182; v=1;
 b=r4HwXoOegQR8vMQbhZZM5DrFQaeqiRSYq246IJn5ktHeV7eBMbpaPMaZDKojbJEV
 firHQ/AiUzDe7AmK5NHYhvAl85jo5pHQWFufdUJc12prFXaXrLPIAftfyBsdUFX0
 1sY9XCoiTUo7SU4Di4Z9r65R2PwSatLq8t8usmRcD84XGk0ALU7/Hs+60zQWFElP
 LSgfr5R3A1rYEbjzYkqyODGrPIOTM5qNMx1yHc8y9NywUZEgQb5lFQtqdKy5eOSe
 tp3gKobsJShbL49fWqOAH0ZVuvv3wG3qErvHJ/jsnSRp1d75eKVZ8sAtmsHp+yJw
 MxITOtfzNekpx+mQRbXKaA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Oct 2025 13:55:55 +0900
Subject: [PATCH for-10.0] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-bar-v1-1-b10ab5198da5@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIANqR6GgC/x3MMQqAMAxA0auUzFaSUtF6FXGommoWlRREEO9uc
 Xzw+Q9kVuEMvXlA+ZIsx15AlYF5i/vKVpZicOgaQkI7RbUBUxvIEwbfQSlP5ST3fxkgHWoJa4T
 xfT9wwyC8XwAAAA==
X-Change-ID: 20251010-bar-90f791410948
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Damien Bergamini <damien.bergamini@eviden.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
This backports commit 2e54e5fda779.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 docs/pcie_sriov.txt         |  5 ++---
 include/hw/pci/pcie_sriov.h |  4 ----
 hw/net/igbvf.c              |  6 ++++--
 hw/nvme/ctrl.c              |  8 ++------
 hw/pci/pci.c                | 40 ++++++++++++++++++++++++----------------
 hw/pci/pcie_sriov.c         | 36 ------------------------------------
 6 files changed, 32 insertions(+), 67 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index ab2142807f79..00d7bd93fdff 100644
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
 
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index c5d2d318d330..e9cb0a3248fd 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -36,10 +36,6 @@ void pcie_sriov_pf_exit(PCIDevice *dev);
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
                                uint8_t type, dma_addr_t size);
 
-/* Instantiate a bar for a VF */
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory);
-
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 21a97d4d61de..575410d6cc61 100644
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
index 67cb95c80952..c93039ba2363 100644
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
index 503a897528dc..57c608c36829 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1470,7 +1470,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     pcibus_t size = memory_region_size(memory);
     uint8_t hdr_type;
 
-    assert(!pci_is_vf(pci_dev)); /* VFs must use pcie_sriov_vf_register_bar */
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
@@ -1482,7 +1481,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
 
     r = &pci_dev->io_regions[region_num];
     assert(!r->size);
-    r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
     r->memory = memory;
@@ -1490,22 +1488,32 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         ? pci_get_bus(pci_dev)->address_space_io
                         : pci_get_bus(pci_dev)->address_space_mem;
 
-    wmask = ~(size - 1);
-    if (region_num == PCI_ROM_SLOT) {
-        /* ROM enable bit is writable */
-        wmask |= PCI_ROM_ADDRESS_ENABLE;
-    }
+    if (pci_is_vf(pci_dev)) {
+        r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);
+        if (r->addr != PCI_BAR_UNMAPPED) {
+            memory_region_add_subregion_overlap(r->address_space,
+                                                r->addr, r->memory, 1);
+        }
+    } else {
+        r->addr = PCI_BAR_UNMAPPED;
 
-    addr = pci_bar(pci_dev, region_num);
-    pci_set_long(pci_dev->config + addr, type);
+        wmask = ~(size - 1);
+        if (region_num == PCI_ROM_SLOT) {
+            /* ROM enable bit is writable */
+            wmask |= PCI_ROM_ADDRESS_ENABLE;
+        }
 
-    if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
-        r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-        pci_set_quad(pci_dev->wmask + addr, wmask);
-        pci_set_quad(pci_dev->cmask + addr, ~0ULL);
-    } else {
-        pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
-        pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        addr = pci_bar(pci_dev, region_num);
+        pci_set_long(pci_dev->config + addr, type);
+
+        if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
+            r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+            pci_set_quad(pci_dev->wmask + addr, wmask);
+            pci_set_quad(pci_dev->cmask + addr, ~0ULL);
+        } else {
+            pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
+            pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        }
     }
 }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index dd4fbaea4611..7f3ef00d6eb1 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -143,42 +143,6 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
     dev->exp.sriov_pf.vf_bar_type[region_num] = type;
 }
 
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory)
-{
-    PCIIORegion *r;
-    PCIBus *bus = pci_get_bus(dev);
-    uint8_t type;
-    pcibus_t size = memory_region_size(memory);
-
-    assert(pci_is_vf(dev)); /* PFs must use pci_register_bar */
-    assert(region_num >= 0);
-    assert(region_num < PCI_NUM_REGIONS);
-    type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
-
-    if (!is_power_of_2(size)) {
-        error_report("%s: PCI region size must be a power"
-                     " of two - type=0x%x, size=0x%"FMT_PCIBUS,
-                     __func__, type, size);
-        exit(1);
-    }
-
-    r = &dev->io_regions[region_num];
-    r->memory = memory;
-    r->address_space =
-        type & PCI_BASE_ADDRESS_SPACE_IO
-        ? bus->address_space_io
-        : bus->address_space_mem;
-    r->size = size;
-    r->type = type;
-
-    r->addr = pci_bar_address(dev, region_num, r->type, r->size);
-    if (r->addr != PCI_BAR_UNMAPPED) {
-        memory_region_add_subregion_overlap(r->address_space,
-                                            r->addr, r->memory, 1);
-    }
-}
-
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;

---
base-commit: 918d584db4e8adb9db424640c51db9141b44ab5a
change-id: 20251010-bar-90f791410948

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


