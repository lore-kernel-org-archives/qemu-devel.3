Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E266606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4nN-0002xH-67; Thu, 22 Oct 2026 22:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xK4nI-0002vP-Pf; Thu, 22 Oct 2026 22:14:08 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xK4nF-0000Cf-3L; Thu, 22 Oct 2026 22:14:08 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4j9mm13BRhz5B162;
 Fri, 23 Oct 2026 10:13:53 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 69N2DpJT012810;
 Fri, 23 Oct 2026 10:13:51 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Fri, 23 Oct 2026 10:13:52 +0800
X-Zmail-TransId: 3e816adac2df026-69346
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Wang Yechao <wang.yechao255@zte.com.cn>,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
Subject: [PATCH v4 3/4] hw/intc/imsic: Add in-kernel imsic save and restore
 function
Date: Fri, 23 Oct 2026 10:12:29 +0800
Message-ID: <20261023021237.486091-4-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69N2DpJT012810
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 23 Oct 2026 10:13:53 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ADAC2E1.000/4j9mm13BRhz5B162
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Add save and restore funtction if kvm_irqchip_in_kernel() return
true, it is to get and set IMSIC irqchip state from KVM kernel.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 hw/intc/riscv_imsic.c         | 180 +++++++++++++++++++++++++++++++---
 include/hw/intc/riscv_imsic.h |   3 +
 include/qemu/bitops.h         |   1 +
 migration/vmstate-types.c     |   1 -
 4 files changed, 170 insertions(+), 15 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index cb9ce9612c..43e4d11426 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -34,6 +34,7 @@
 #include "system/system.h"
 #include "system/kvm.h"
 #include "migration/vmstate.h"
+#include "kvm/kvm_riscv.h"
 
 #define IMSIC_MMIO_PAGE_LE             0x00
 #define IMSIC_MMIO_PAGE_BE             0x04
@@ -408,11 +409,16 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
 
         imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
-        imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
-        imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
         imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
+    } else {
+        imsic->nr_eix = 2 * BITS_TO_U64S(imsic->num_irqs);
+        imsic->eie = g_new0(uint32_t, imsic->nr_eix);
+        imsic->eip = g_new0(uint32_t, imsic->nr_eix);
     }
 
+    imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
+    imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
+
     memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
                           imsic, TYPE_RISCV_IMSIC,
                           IMSIC_MMIO_SIZE(imsic->num_pages));
@@ -443,23 +449,17 @@ static const Property riscv_imsic_properties[] = {
     DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
 };
 
-static bool riscv_imsic_state_needed(void *opaque)
+static bool riscv_emulated_imsic_state_needed(void *opaque)
 {
     return !kvm_irqchip_in_kernel();
 }
 
-static const VMStateDescription vmstate_riscv_imsic = {
-    .name = "riscv_imsic",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .needed = riscv_imsic_state_needed,
+static const VMStateDescription vmstate_emulated_imsic_state = {
+    .name = "riscv_imsic/emulated_imsic_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = riscv_emulated_imsic_state_needed,
     .fields = (const VMStateField[]) {
-            VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
-                                  num_pages, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
-                                  num_pages, 0,
-                                  vmstate_info_uint32, uint32_t),
             VMSTATE_VARRAY_UINT32(eistate, RISCVIMSICState,
                                   num_eistate, 0,
                                   vmstate_info_uint32, uint32_t),
@@ -467,6 +467,158 @@ static const VMStateDescription vmstate_riscv_imsic = {
         }
 };
 
+#ifdef CONFIG_KVM
+static bool kvm_riscv_imsic_state_needed(void *opaque)
+{
+    return kvm_irqchip_in_kernel();
+}
+
+static int kvm_riscv_imsic_state_pre_save(void *opaque)
+{
+    RISCVIMSICState *imsic = opaque;
+    RISCVCPU *rcpu = RISCV_CPU(cpu_by_arch_id(imsic->hartid));
+    bool is_32bit = riscv_cpu_is_32bit(rcpu);
+    uint32_t inc = 2;
+    uint64_t attr;
+
+    if (is_32bit) {
+        inc = 1;
+    }
+
+    for (uint32_t i = 0; i < imsic->nr_eix; i += inc) {
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIE0 + i);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eie + i, false);
+
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIP0 + i);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eip + i, false);
+    }
+
+    return 0;
+}
+
+static int kvm_riscv_imsic_state_post_load(void *opaque, int version_id)
+{
+    RISCVIMSICState *imsic = opaque;
+    RISCVCPU *rcpu = RISCV_CPU(cpu_by_arch_id(imsic->hartid));
+    bool is_32bit = riscv_cpu_is_32bit(rcpu);
+    uint32_t inc = 2;
+    uint64_t attr;
+
+    if (is_32bit) {
+        inc = 1;
+    }
+
+    for (uint32_t i = 0; i < imsic->nr_eix; i += inc) {
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIE0 + i);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eie + i, true);
+
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIP0 + i);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eip + i, true);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_kvm_imsic_state = {
+    .name = "riscv_imsic/kvm_imsic_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_riscv_imsic_state_needed,
+    .pre_save = kvm_riscv_imsic_state_pre_save,
+    .post_load = kvm_riscv_imsic_state_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(eie, RISCVIMSICState,
+                              nr_eix, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(eip, RISCVIMSICState,
+                              nr_eix, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int riscv_imsic_pre_save(void *opaque)
+{
+    RISCVIMSICState *imsic = opaque;
+    uint64_t attr;
+
+    if (kvm_irqchip_in_kernel()) {
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIDELIVERY);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eidelivery, false);
+
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EITHRESHOLD);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eithreshold, false);
+   }
+
+    return 0;
+}
+
+static int riscv_imsic_post_load(void *opaque, int version_id)
+{
+    RISCVIMSICState *imsic = opaque;
+    uint64_t attr;
+
+    if (kvm_irqchip_in_kernel()) {
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIDELIVERY);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eidelivery, true);
+
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EITHRESHOLD);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eithreshold, true);
+   }
+
+    return 0;
+}
+#else
+static int riscv_imsic_pre_save(void *opaque)
+{
+    return 0;
+}
+static int riscv_imsic_post_load(void *opaque, int version_id)
+{
+    return 0;
+}
+#endif
+
+static const VMStateDescription vmstate_riscv_imsic = {
+    .name = "riscv_imsic",
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .pre_save = riscv_imsic_pre_save,
+    .post_load = riscv_imsic_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
+                              num_pages, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
+                              num_pages, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_emulated_imsic_state,
+#ifdef CONFIG_KVM
+        &vmstate_kvm_imsic_state,
+#endif
+        NULL
+    }
+};
+
 static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index 0a1df1c2f8..b61820fd29 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -54,12 +54,15 @@ struct RISCVIMSICState {
     uint32_t *eidelivery;
     uint32_t *eithreshold;
     uint32_t *eistate;
+    uint32_t *eip;
+    uint32_t *eie;
 
     /* config */
     bool mmode;
     uint32_t hartid;
     uint32_t num_pages;
     uint32_t num_irqs;
+    uint32_t nr_eix;
 };
 
 DeviceState *riscv_imsic_create(MemoryRegion *container, hwaddr addr,
diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index f7363a5479..383648fe59 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -20,6 +20,7 @@
 #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #define BITS_TO_U32S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint32_t))
+#define BITS_TO_U64S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint64_t))
 
 #define BIT(nr)                 (1UL << (nr))
 #define BIT_ULL(nr)             (1ULL << (nr))
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index c2d4645f31..d0d3a0e384 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -597,7 +597,6 @@ const VMStateInfo vmstate_info_tmp = {
  * is an array of 'unsigned long', which may be either 32 or 64 bits.
  */
 /* This is the number of 64 bit words sent over the wire */
-#define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
 static bool load_bitmap(QEMUFile *f, void *pv, size_t size,
                         const VMStateField *field, Error **errp)
 {
-- 
2.47.3


