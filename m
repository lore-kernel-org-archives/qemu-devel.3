Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F186F513E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHXh-0007jT-AP; Thu, 05 Mar 2026 17:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXf-0007fZ-0E
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:39 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXc-0008QN-1h
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ifX8l2AXnBhr9jX31MD23msSqzoVhJezEjl2DuYDoh0=; b=Bb+a/0srScFVqP0
 Ydt4XY6naCZodrbjcORbYjgmDEuKh+cW0fH8+kx2rmYwD3kQQP9gvmXfIx+BoQmngv/szq9rrmvUK
 fTnhhSwQijdFWLcRJj4DYq0YnvWxuSXjeLgXixzpHurgmQjSuKR6c6z9NltGaHFYD+MghOGW/mBkY
 S8=;
Date: Thu, 05 Mar 2026 23:54:21 +0100
Subject: [PATCH v6 2/3] hppa: Get physical address space bits from HPPACPUDef
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-hppa-c3600-v6-2-d51526e5269c@rev.ng>
References: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
In-Reply-To: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772751314; l=8538;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=pzPW+/suWpFmxbJncwZH5AV/5sxO/vSuDIBoNyJ+3E4=;
 b=F3lpF9XxeO8S1Oj7bcxT9dGVmWqEELdQNwBxqvxz+MzmvDq9ZCD+2Y9H5CvhkxZ7EJe8519AY
 7rXAVOlPVvtAxY2jz5Vf6N8dRfV9whJJU8qnG6sunYhixUAexBo9pfi
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/pci-host/astro.h |  2 ++
 target/hppa/cpu.h           | 11 ++++++++---
 hw/hppa/machine.c           | 15 ++++++++++-----
 hw/pci-host/astro.c         |  8 +++++++-
 target/hppa/cpu.c           |  5 +++++
 target/hppa/mem_helper.c    | 39 +++++++++++----------------------------
 6 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/include/hw/pci-host/astro.h b/include/hw/pci-host/astro.h
index 832125a05a..fce052c9f8 100644
--- a/include/hw/pci-host/astro.h
+++ b/include/hw/pci-host/astro.h
@@ -82,6 +82,8 @@ struct AstroState {
     uint64_t tlb_tcnfg;
     uint64_t tlb_pdir_base;
 
+    uint8_t phys_addr_bits;
+
     struct ElroyState *elroy[ELROY_NUM];
 
     MemoryRegion this_mem;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 43b4882fb4..7d47afe8ef 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -320,6 +320,11 @@ static inline const HPPACPUDef *hppa_def(CPUHPPAState *env)
     return HPPA_CPU_GET_CLASS(env_cpu(env))->def;
 }
 
+static inline uint8_t hppa_phys_addr_bits(CPUHPPAState *env)
+{
+    return hppa_def(env)->phys_addr_bits;
+}
+
 static inline bool hppa_is_pa20(CPUHPPAState *env)
 {
     return hppa_def(env)->is_pa20;
@@ -352,9 +357,9 @@ static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
     return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
 }
 
-hwaddr hppa_abs_to_phys_pa1x(vaddr addr);
-hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
-hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
+hwaddr hppa_abs_to_phys_pa1x(uint8_t phys_addr_bits, vaddr addr);
+hwaddr hppa_abs_to_phys_pa2_w0(uint8_t phys_addr_bits, vaddr addr);
+hwaddr hppa_abs_to_phys_pa2_w1(uint8_t phys_addr_bits, vaddr addr);
 
 /*
  * Since PSW_{I,CB} will never need to be in tb->flags, reuse them.
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5d0d4de09e..6b69a304c2 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -179,19 +179,21 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
     return addr;
 }
 
+static HPPACPU *cpu[HPPA_MAX_CPUS];
+static uint64_t firmware_entry;
+
 static uint64_t translate_pa10(void *dummy, uint64_t addr)
 {
-    return hppa_abs_to_phys_pa1x(addr);
+    const uint8_t pa_bits = hppa_phys_addr_bits(&cpu[0]->env);
+    return hppa_abs_to_phys_pa1x(pa_bits, addr);
 }
 
 static uint64_t translate_pa20(void *dummy, uint64_t addr)
 {
-    return hppa_abs_to_phys_pa2_w0(addr);
+    const uint8_t pa_bits = hppa_phys_addr_bits(&cpu[0]->env);
+    return hppa_abs_to_phys_pa2_w0(pa_bits, addr);
 }
 
-static HPPACPU *cpu[HPPA_MAX_CPUS];
-static uint64_t firmware_entry;
-
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
 {
@@ -685,6 +687,9 @@ static AstroState *astro_init(void)
     DeviceState *dev;
 
     dev = qdev_new(TYPE_ASTRO_CHIP);
+    object_property_set_int(OBJECT(dev), "phys-addr-bits",
+                            hppa_phys_addr_bits(&cpu[0]->env),
+                            &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return ASTRO_CHIP(dev);
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 00a904277c..626aa9ce22 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -303,7 +303,7 @@ static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
      * language which not-coincidentally matches the PSW.W=0 mapping.
      */
     if (addr <= UINT32_MAX) {
-        entry = hppa_abs_to_phys_pa2_w0(addr);
+        entry = hppa_abs_to_phys_pa2_w0(s->phys_addr_bits, addr);
     } else {
         entry = addr;
     }
@@ -910,6 +910,10 @@ static void astro_realize(DeviceState *obj, Error **errp)
     }
 }
 
+static const Property astro_props[] = {
+    DEFINE_PROP_UINT8("phys-addr-bits", AstroState, phys_addr_bits, 32),
+};
+
 static void astro_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -922,6 +926,8 @@ static void astro_class_init(ObjectClass *klass, const void *data)
      * be created without that hardware
      */
     dc->user_creatable = false;
+
+    device_class_set_props(dc, astro_props);
 }
 
 static const TypeInfo astro_chip_info = {
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index cc755da8be..5895b9d7c0 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -283,6 +283,11 @@ static void hppa_cpu_class_base_init(ObjectClass *oc, const void *data)
     /* Make sure all CPU models define a HPPACPUDef */
     g_assert(!object_class_is_abstract(oc) && data != NULL);
     acc->def = data;
+    /*
+     * Verify assumptions made in hppa_abs_to_phys_pa2_w1() on the size
+     * of the physical address space.
+     */
+    g_assert(acc->def->phys_addr_bits <= 54);
 }
 
 static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 9199d1e06a..a4b382069d 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -29,29 +29,12 @@
 #include "hw/core/cpu.h"
 #include "trace.h"
 
-/*
- * 64-bit (PA-RISC 2.0) machines are assumed to run PA-8700, and 32-bit
- * machines 7300LC.  This should give 44 and 32 bits of physical address
- * space respectively.
- *
- *   CPU model        Physical address space bits
- *   PA-7000--7300LC  32
- *   PA-8000--8600    40
- *   PA-8700--8900    44
- *
- * FIXME: However, the SeaBIOS firmware that is that tested against
- * uses 40-bit physical addresses, despite supposedly running a C3700
- * with a PA-8700 cpu, so use 40-bits for 64-bit.
- */
-#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 40
-#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
-
-hwaddr hppa_abs_to_phys_pa1x(vaddr addr)
+hwaddr hppa_abs_to_phys_pa1x(uint8_t phys_addr_bits, vaddr addr)
 {
-    return extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
+    return extract64(addr, 0, phys_addr_bits);
 }
 
-hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
+hwaddr hppa_abs_to_phys_pa2_w1(uint8_t phys_addr_bits, vaddr addr)
 {
     /*
      * Figure H-8 "62-bit Absolute Accesses when PSW W-bit is 1" describes
@@ -64,11 +47,10 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
      * Since the supported physical address space is below 54 bits, the
      * H-8 algorithm is moot and all that is left is to truncate.
      */
-    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
-    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
+    return sextract64(addr, 0, phys_addr_bits);
 }
 
-hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
+hwaddr hppa_abs_to_phys_pa2_w0(uint8_t phys_addr_bits, vaddr addr)
 {
     /*
      * See Figure H-10, "Absolute Accesses when PSW W-bit is 0",
@@ -89,7 +71,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
          * is what can be seen on physical machines too.
          */
         addr = (uint32_t)addr;
-        addr |= -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 4);
+        addr |= -1ull << (phys_addr_bits - 4);
     }
     return addr;
 }
@@ -231,15 +213,16 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     /* Virtual translation disabled.  Map absolute to physical.  */
     if (MMU_IDX_MMU_DISABLED(mmu_idx)) {
+        const uint8_t phys_addr_bits = hppa_phys_addr_bits(env);
         switch (mmu_idx) {
         case MMU_ABS_W_IDX:
-            phys = hppa_abs_to_phys_pa2_w1(addr);
+            phys = hppa_abs_to_phys_pa2_w1(phys_addr_bits, addr);
             break;
         case MMU_ABS_IDX:
             if (hppa_is_pa20(env)) {
-                phys = hppa_abs_to_phys_pa2_w0(addr);
+                phys = hppa_abs_to_phys_pa2_w0(phys_addr_bits, addr);
             } else {
-                phys = hppa_abs_to_phys_pa1x(addr);
+                phys = hppa_abs_to_phys_pa1x(phys_addr_bits, addr);
             }
             break;
         default:
@@ -580,7 +563,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
     /* Align per the page size. */
     ent->pa &= TARGET_PAGE_MASK << mask_shift;
     /* Ignore the bits beyond physical address space. */
-    ent->pa = sextract64(ent->pa, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
+    ent->pa = sextract64(ent->pa, 0, hppa_phys_addr_bits(env));
 
     ent->t = extract64(r2, 61, 1);
     ent->d = extract64(r2, 60, 1);

-- 
2.52.0


