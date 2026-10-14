Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B564CCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyWO-00072T-5s; Wed, 14 Oct 2026 08:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu69-0006JE-P5; Wed, 14 Oct 2026 04:12:30 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu67-0000wn-Ll; Wed, 14 Oct 2026 04:12:29 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P7s2WZrz7VDHZ;
 Wed, 14 Oct 2026 16:12:25 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8CMAB000856;
 Wed, 14 Oct 2026 16:12:22 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140812.69E8CMAB000856@mse-fl2.zte.com.cn>
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 69E80JfF079397;
 Wed, 14 Oct 2026 16:00:19 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:21 +0800
X-Zmail-TransId: 3e816acf3694024-0e243
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
Subject: [RFC PATCH 04/14] hw/riscv/riscv-iommu: Expose RISCVIOMMUSpace and
 split its helpers
Date: Wed, 14 Oct 2026 15:59:55 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8CMAB000856
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:12:25 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF3969.000/4j4P7s2WZrz7VDHZ
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:58 -0400
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

Move the per-device IOMMU address space structure (RISCVIOMMUSpace)
into the public header and split its allocation into separate
lookup and init helpers, so the space management can be reused by
other devices without code duplication. No behavioural change.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 hw/riscv/riscv-iommu.c | 68 ++++++++++++++++++++++--------------------
 hw/riscv/riscv-iommu.h | 16 ++++++++++
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 2887336456..1b408a19ea 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -44,17 +44,6 @@
 
 typedef struct RISCVIOMMUEntry RISCVIOMMUEntry;
 
-/* Device assigned I/O address space */
-struct RISCVIOMMUSpace {
-    IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
-    AddressSpace iova_as;       /* IOVA address space for attached device */
-    RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
-    PCIBus *bus;                /* PCI bus of the requester */
-    uint8_t devfn;              /* Requester identifier, AKA device_id */
-    bool notifier;              /* IOMMU unmap notifier enabled */
-    QLIST_ENTRY(RISCVIOMMUSpace) list;
-};
-
 typedef enum RISCVIOMMUTransTag {
     RISCV_IOMMU_TRANS_TAG_BY,  /* Bypass */
     RISCV_IOMMU_TRANS_TAG_SS,  /* Single Stage */
@@ -1527,9 +1516,31 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
     }
 }
 
-/* Find or allocate address space for a given device */
-static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus,
-                                            int devfn)
+void riscv_iommu_init_space(RISCVIOMMUState *s, RISCVIOMMUSpace *as,
+                            PCIBus *bus, int devfn)
+{
+    char name[64];
+
+    as->iommu = s;
+    as->bus = bus;
+    as->devfn = devfn;
+
+    snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
+        pci_bus_num(bus), PCI_SLOT(devfn), PCI_FUNC(devfn));
+
+    /* IOVA address space, untranslated addresses */
+    memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
+        TYPE_RISCV_IOMMU_MEMORY_REGION,
+        OBJECT(s), "riscv_iommu", UINT64_MAX);
+    address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr), name);
+
+    QLIST_INSERT_HEAD(&s->spaces, as, list);
+
+    trace_riscv_iommu_new(s->parent_obj.id, pci_bus_num(bus),
+            PCI_SLOT(devfn), PCI_FUNC(devfn));
+}
+
+RISCVIOMMUSpace *riscv_iommu_get_space(RISCVIOMMUState *s, PCIBus *bus, int devfn)
 {
     RISCVIOMMUSpace *as;
 
@@ -1539,27 +1550,18 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus,
         }
     }
 
-    if (as == NULL) {
-        char name[64];
-        as = g_new0(RISCVIOMMUSpace, 1);
-
-        as->iommu = s;
-        as->bus = bus;
-        as->devfn = devfn;
-
-        snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
-            pci_bus_num(bus), PCI_SLOT(devfn), PCI_FUNC(devfn));
-
-        /* IOVA address space, untranslated addresses */
-        memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
-            TYPE_RISCV_IOMMU_MEMORY_REGION,
-            OBJECT(s), "riscv_iommu", UINT64_MAX);
-        address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr), name);
+    return as;
+}
 
-        QLIST_INSERT_HEAD(&s->spaces, as, list);
+/* Find or allocate address space for a given device */
+AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus, int devfn)
+{
+    RISCVIOMMUSpace *as;
 
-        trace_riscv_iommu_new(s->parent_obj.id, pci_bus_num(bus),
-                PCI_SLOT(devfn), PCI_FUNC(devfn));
+    as = riscv_iommu_get_space(s, bus, devfn);
+    if (as == NULL) {
+        as = g_new0(RISCVIOMMUSpace, 1);
+        riscv_iommu_init_space(s, as, bus, devfn);
     }
     return &as->iova_as;
 }
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 68e1cdd82d..ed8d1ee199 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -28,6 +28,17 @@
 
 typedef enum riscv_iommu_igs_modes riscv_iommu_igs_mode;
 
+/* Device assigned I/O address space */
+struct RISCVIOMMUSpace {
+    IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
+    AddressSpace iova_as;       /* IOVA address space for attached device */
+    RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
+    PCIBus *bus;                /* PCI bus of the requester */
+    uint8_t devfn;              /* Requester identifier, AKA device_id */
+    bool notifier;              /* IOMMU unmap notifier enabled */
+    QLIST_ENTRY(RISCVIOMMUSpace) list;
+};
+
 struct RISCVIOMMUState {
     /*< private >*/
     DeviceState parent_obj;
@@ -111,6 +122,11 @@ DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
                                     hwaddr addr, int base_irq,
                                     bool is_32_bit);
 
+void riscv_iommu_init_space(RISCVIOMMUState *s, RISCVIOMMUSpace *as,
+                            PCIBus *bus, int devfn);
+AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus, int devfn);
+RISCVIOMMUSpace *riscv_iommu_get_space(RISCVIOMMUState *s, PCIBus *bus, int devfn);
+
 typedef struct RISCVIOMMUContext RISCVIOMMUContext;
 /* Device translation context state. */
 struct RISCVIOMMUContext {
-- 
2.53.0


