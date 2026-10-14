Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58835CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyWL-0006yf-Jt; Wed, 14 Oct 2026 08:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu7b-0006VT-Md; Wed, 14 Oct 2026 04:13:59 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu7Y-00017t-MP; Wed, 14 Oct 2026 04:13:59 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P9Y4xcfz4yjjN;
 Wed, 14 Oct 2026 16:13:53 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8DpZb006146;
 Wed, 14 Oct 2026 16:13:51 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140813.69E8DpZb006146@mse-fl2.zte.com.cn>
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 69E80Li4093686;
 Wed, 14 Oct 2026 16:00:21 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:23 +0800
X-Zmail-TransId: 3e816acf3697024-0e28c
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 08/14] hw/riscv/riscv-iommu-accel: Restrict accelerated
 IOMMU to vfio-pci endpoints with iommufd
Date: Wed, 14 Oct 2026 15:59:59 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8DpZb006146
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:13:53 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF39C1.000/4j4P9Y4xcfz4yjjN
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:55:01 -0400
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

From: Wu Fei <wu.fei9@sanechips.com.cn>

The accelerated mode is only meaningful for devices that can use the
host IOMMU in nested mode (S1+S2). Following the ARM SMMUv3 accel
device, restrict it to vfio-pci endpoints using the iommufd backend,
and to PCIe bridges/root ports so endpoints can sit downstream.
vfio-pci endpoints get the shared system address space so the VFIO
core builds the stage-2 mappings for the nesting parent HWPT; all
other devices get the IOMMU address space.

Unlike ARM, where the SMMUv3 is a system device, the RISC-V IOMMU
can also be exposed as a PCI device. It must stay usable in
accelerated mode, so it is exempted from the restrictions and its
address space lookup bypasses the IOMMU, returning the target
address space as the default path does.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu-accel.c | 90 +++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.c       |  5 --
 hw/riscv/riscv-iommu.h       |  6 ++-
 3 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
index a843cf9d01..7bb725d957 100644
--- a/hw/riscv/riscv-iommu-accel.c
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -5,6 +5,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/vfio/pci.h"
 
 #include "riscv-iommu.h"
 #include "riscv-iommu-accel.h"
@@ -36,18 +41,101 @@ static RISCVIOMMUAccelDevice *riscv_iommu_accel_get_dev(RISCVIOMMUState *s,
     return accel_dev;
 }
 
+/*
+ * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
+ * endpoints can sit downstream, and the RISC-V IOMMU PCI device
+ * itself. Unlike ARM, the RISC-V IOMMU can be exposed as a PCI device;
+ * it must stay usable in accelerated mode, but it is never translated
+ * and is handed its target address space directly.
+ * Accelerated IOMMU requires a vfio-pci endpoint using the iommufd
+ * backend; all other device types are rejected. This avoids supporting
+ * emulated endpoints, which would complicate IOTLB invalidation and
+ * hurt performance.
+ */
+static bool riscv_iommu_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
+{
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_PXB_PCIE_DEV) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_GPEX_ROOT_DEVICE) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_RISCV_IOMMU_PCI)) {
+        return true;
+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI))) {
+        *vfio_pci = true;
+        if (object_property_get_link(OBJECT(pdev), "iommufd", NULL)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool riscv_iommu_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
+                                          Error **errp)
+{
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+    bool vfio_pci = false;
+
+    if (pdev && !riscv_iommu_accel_pdev_allowed(pdev, &vfio_pci)) {
+        if (vfio_pci) {
+            error_setg(errp, "vfio-pci endpoint devices without an iommufd "
+                       "backend not allowed when using riscv_iommu accel=on");
+        } else {
+            error_setg(errp, "Emulated endpoint devices are not allowed when "
+                       "using riscv_iommu accel=on");
+        }
+        return false;
+    }
+    return true;
+}
+
 static AddressSpace *riscv_iommu_accel_find_as(PCIBus *bus, void *opaque,
                                                int devfn)
 {
     RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+
+    /*
+     * The riscv-iommu-pci itself is not a translated endpoint; hand out its
+     * target address space as the default path does.
+     */
+    if (pdev && pci_is_iommu(pdev)) {
+        return s->target_as;
+    }
 
     RISCVIOMMUAccelDevice *accel_dev = riscv_iommu_accel_get_dev(s, bus, devfn);
     RISCVIOMMUSpace *as = &accel_dev->as;
 
-    return &as->iova_as;
+    bool vfio_pci = false;
+
+    if (pdev && !riscv_iommu_accel_pdev_allowed(pdev, &vfio_pci)) {
+        /* Should never be here: supports_address_space() filters these out */
+        g_assert_not_reached();
+    }
+
+    /*
+     * In the accelerated mode, a vfio-pci device attached via the iommufd
+     * backend must remain in the system address space. Such a device is
+     * always translated by its physical IOMMU (using either stage-2-only
+     * or nested S1+S2 translation), where the parent stage-2 page table
+     * is allocated by the VFIO core to back the system address space.
+     *
+     * Return the shared_as_sysmem aliased to the global system memory in
+     * this case. Sharing a single system address space also lets devices
+     * behind different accelerated IOMMU instances in the same VM reuse a
+     * single nesting parent HWPT in the VFIO core.
+     *
+     * For the remaining allowed devices, such as PCIe root ports and
+     * bridges, which use the normal emulated translation path and software
+     * IOTLBs, return the IOMMU address space.
+     */
+    if (vfio_pci) {
+        return shared_as_sysmem;
+    } else {
+        return &as->iova_as;
+    }
 }
 
 static const PCIIOMMUOps riscv_iommu_accel_ops = {
+    .supports_address_space = riscv_iommu_accel_supports_as,
     .get_address_space = riscv_iommu_accel_find_as,
 };
 
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index bdbb4aece1..e43cf656db 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2961,11 +2961,6 @@ static int riscv_iommu_memory_region_notify(
     return 0;
 }
 
-static inline bool pci_is_iommu(PCIDevice *pdev)
-{
-    return pci_get_word(pdev->config + PCI_CLASS_DEVICE) == 0x0806;
-}
-
 static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
 {
     RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 0d8613a8b1..5544de595c 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -24,7 +24,7 @@
 #include "system/dma.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
-#include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
 
 typedef enum riscv_iommu_igs_modes riscv_iommu_igs_mode;
 
@@ -150,6 +150,10 @@ int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, unsigned devid,
                           unsigned process_id, RISCVIOMMUContext *ctx);
 
 /* private helpers */
+static inline bool pci_is_iommu(PCIDevice *pdev)
+{
+    return pci_get_word(pdev->config + PCI_CLASS_DEVICE) == 0x0806;
+}
 
 /* Register helper functions */
 static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
-- 
2.53.0


