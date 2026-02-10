Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD93EA8109
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnO5-0003zP-8u; Tue, 10 Feb 2026 08:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpnNi-0003rX-2W
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:02:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpnNf-0002rI-P7
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=z3ddyhImOBiQmW8TUvq1wPXGh+L3b2sHhaH1aUXyHik=; b=UUa2UrPuCq4d7zE
 pHqMEX6AFoHVFtWQq8vgSvsBS2oFHoqOMXCV2aWwoKauVplWmwB9nPqDkIdvvVMec5cdM/JjoM+ze
 rqN+tdHn4Ncb0VdXMH/22DYUhQUnj9hGT5lHxIf+bAQIKnhBr0l8atQM2T8YbYy7OfpfDpSG5jX+q
 fU=;
Date: Tue, 10 Feb 2026 14:04:57 +0100
Subject: [PATCH 3/4] hppa: Get physical address space bits from CPUHPPADef
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-hppa-c3600-v1-3-a17ec58f053f@rev.ng>
References: <20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng>
In-Reply-To: <20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/hppa/cpu.h        | 11 ++++++++---
 hw/hppa/machine.c        |  4 ++--
 hw/pci-host/astro.c      |  2 +-
 target/hppa/mem_helper.c | 40 ++++++++++++----------------------------
 4 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 43b4882fb4..487f0f5e9e 100644
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
+hwaddr hppa_abs_to_phys_pa1x(CPUHPPAState *env, vaddr addr);
+hwaddr hppa_abs_to_phys_pa2_w0(CPUHPPAState *env, vaddr addr);
+hwaddr hppa_abs_to_phys_pa2_w1(CPUHPPAState *env, vaddr addr);
 
 /*
  * Since PSW_{I,CB} will never need to be in tb->flags, reuse them.
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 6a0487c362..8246f6bf65 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -181,12 +181,12 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
 
 static uint64_t translate_pa10(void *dummy, uint64_t addr)
 {
-    return hppa_abs_to_phys_pa1x(addr);
+    return hppa_abs_to_phys_pa1x(cpu_env(first_cpu), addr);
 }
 
 static uint64_t translate_pa20(void *dummy, uint64_t addr)
 {
-    return hppa_abs_to_phys_pa2_w0(addr);
+    return hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
 }
 
 static HPPACPU *cpu[HPPA_MAX_CPUS];
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 00a904277c..d38f81e553 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -303,7 +303,7 @@ static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
      * language which not-coincidentally matches the PSW.W=0 mapping.
      */
     if (addr <= UINT32_MAX) {
-        entry = hppa_abs_to_phys_pa2_w0(addr);
+        entry = hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
     } else {
         entry = addr;
     }
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 9199d1e06a..4bd806a53f 100644
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
+hwaddr hppa_abs_to_phys_pa1x(CPUHPPAState *env, vaddr addr)
 {
-    return extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
+    return extract64(addr, 0, hppa_phys_addr_bits(env));
 }
 
-hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
+hwaddr hppa_abs_to_phys_pa2_w1(CPUHPPAState *env, vaddr addr)
 {
     /*
      * Figure H-8 "62-bit Absolute Accesses when PSW W-bit is 1" describes
@@ -64,11 +47,12 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
      * Since the supported physical address space is below 54 bits, the
      * H-8 algorithm is moot and all that is left is to truncate.
      */
-    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
-    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
+    const uint8_t pa = hppa_phys_addr_bits(env);
+    g_assert(pa <= 54);
+    return sextract64(addr, 0, pa);
 }
 
-hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
+hwaddr hppa_abs_to_phys_pa2_w0(CPUHPPAState *env, vaddr addr)
 {
     /*
      * See Figure H-10, "Absolute Accesses when PSW W-bit is 0",
@@ -89,7 +73,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
          * is what can be seen on physical machines too.
          */
         addr = (uint32_t)addr;
-        addr |= -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 4);
+        addr |= -1ull << (hppa_phys_addr_bits(env) - 4);
     }
     return addr;
 }
@@ -233,13 +217,13 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     if (MMU_IDX_MMU_DISABLED(mmu_idx)) {
         switch (mmu_idx) {
         case MMU_ABS_W_IDX:
-            phys = hppa_abs_to_phys_pa2_w1(addr);
+            phys = hppa_abs_to_phys_pa2_w1(env, addr);
             break;
         case MMU_ABS_IDX:
             if (hppa_is_pa20(env)) {
-                phys = hppa_abs_to_phys_pa2_w0(addr);
+                phys = hppa_abs_to_phys_pa2_w0(env, addr);
             } else {
-                phys = hppa_abs_to_phys_pa1x(addr);
+                phys = hppa_abs_to_phys_pa1x(env, addr);
             }
             break;
         default:
@@ -580,7 +564,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
     /* Align per the page size. */
     ent->pa &= TARGET_PAGE_MASK << mask_shift;
     /* Ignore the bits beyond physical address space. */
-    ent->pa = sextract64(ent->pa, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
+    ent->pa = sextract64(ent->pa, 0, hppa_phys_addr_bits(env));
 
     ent->t = extract64(r2, 61, 1);
     ent->d = extract64(r2, 60, 1);

-- 
2.52.0


