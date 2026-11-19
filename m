Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211A606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU1za-0006dC-TX; Thu, 19 Nov 2026 08:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xU1zW-0006ZM-JQ; Thu, 19 Nov 2026 08:15:54 -0500
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xU1zT-0005Sn-4q; Thu, 19 Nov 2026 08:15:54 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVf983YCyz4yjjR;
 Thu, 19 Nov 2026 21:15:40 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 6AJDFYeJ080019;
 Thu, 19 Nov 2026 21:15:34 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 19 Nov 2026 21:15:38 +0800
X-Zmail-TransId: 3e816afef67902f-556c5
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
 Cornelia Huck <cohuck@redhat.com>, Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Wu Fei <wu.fei9@sanechips.com.cn>,
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>
Subject: [RFC PATCH v3 04/15] hw/riscv/riscv-iommu: Expose RISCVIOMMUSpace and
 split its helpers
Date: Thu, 19 Nov 2026 21:15:13 +0800
Message-ID: <20261119131524.395861-5-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119131524.395861-1-gong.shuai@sanechips.com.cn>
References: <20261119131524.395861-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 6AJDFYeJ080019
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:15:40 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF67C.000/4jVf983YCyz4yjjR
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 6381986265..986921dd5e 100644
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
index cf2904c118..099faa9480 100644
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
@@ -112,6 +123,11 @@ DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
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


