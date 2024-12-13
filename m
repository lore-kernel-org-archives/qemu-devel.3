Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3092E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aX-0001As-9v; Fri, 13 Dec 2024 12:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YG-0000vi-M9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:08 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YA-0001nD-En
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:08 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1352288f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111240; x=1734716040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y+wOBXQ4nR4PSgQu/QW17WIQZdSFhMR8jDryGS5FwMg=;
 b=rT53OYUpZdYsqWrRuyJPm1qgaFncWevaxpAqi1494FH+oRTEaHhmeaJ8EUfPKqgxNQ
 /mQSgdsmRiUf0Y76/pw5dvR3WYWVJr+qU0EILTIQPoYuX5UJmgtOvABRCMAdGTVPjf4P
 ykYkvn0Q6EZPSPIiXuS04Ot4/BRh/xNCpRMMzJzQJUOmk3AUAzqUlrFeSUhPW1p78WJk
 TGaTqLpXfQaMwq5gCMNey/AjjSA1MFV22wXz6JALjN/0h/2ctO9lGGwzyx/GTsg3SZdo
 RM4LUDZjVC+XUb0sjvz/HvlyGfZ2fgriBvLF+NVjz0nKGyTJAWd5wquAvv5dqADo0JZx
 C+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111240; x=1734716040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+wOBXQ4nR4PSgQu/QW17WIQZdSFhMR8jDryGS5FwMg=;
 b=w0lPPFzibLjSW6Xo319nYmMxqC07m5u2THxD4Xbtl8N1QB/F1cF2rfwJWj4TJ8Ya+X
 tW8q0n+2wVgHPfCjVIoXODJkTzyuuDs7PraVI5UPywTxIRDWlnrLFXoJOBHU5MP/CuqH
 3oG3AObe2CHj8MKLFldyJg9zI53Z270RL6DQqqHv+WVaf1YZPcV2BlHxUrHGcBJMZIRr
 OLMAFC2arbm+vu5WIZPlq8IBRi1F9wgqKQy9ApHQPN0WZDVtSQKDgno5L2xhhY3wCTbb
 nEnPR1sf+pdy3HozI+GwicT9zZ6mAkCGzwVP0zEqoDsximsZk9bOF/h3el4HLKIPhmh1
 fqpg==
X-Gm-Message-State: AOJu0YwgFFXvGD3V0d25jj+ouDM7sWhG4eTLrNuxb3VX2QFZtsDZRclF
 W1Or6+msaSMlO/RCGCrdl2+zRVk7IevltTFY1cch/v0TQTD6arxhpjBkx1ah1v8xEoa+GfaT89V
 f
X-Gm-Gg: ASbGnctgCqzU1sUjUpo4DBPugJCNAqYp9dE5pT3i0guDAYeSJAXCZdpmZRvrOw6mxVP
 3fvB9GjaMB4dZaI8Q3pd28RnkpwbLcyfFoBVZ2JibStizdrvsiwC94Wwem1TZHENa7uwDxvISpl
 WADkaG8yBOEjvPX8Hw2DLlmRyWLRuJMcDM1w03y4Brrf6mXbsCl3f8HrlA+fPQ1yFk7wYVBFR6H
 yAcQIw7L/o27kVaqH/1XHoWbAPr6X4iajar8dHErA239dq+wy+fObX2ELUTPQ==
X-Google-Smtp-Source: AGHT+IH7gE5whaLd4EQJhnA/45/5fd1DiZYRHadV+nZg0EkttDoVU1iVwNkiyU9GCSK9h/4muCeJVA==
X-Received: by 2002:a05:6000:70e:b0:385:e8e7:d09a with SMTP id
 ffacd0b85a97d-388c3645ec2mr2888973f8f.2.1734111239685; 
 Fri, 13 Dec 2024 09:33:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 83/85] target/arm: Move small helper functions to tlb-insns.c
Date: Fri, 13 Dec 2024 17:32:27 +0000
Message-Id: <20241213173229.3308926-84-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The remaining functions that we temporarily made global are now
used only from callsits in tlb-insns.c; move them across and
make them file-local again.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241210160452.2427965-9-peter.maydell@linaro.org
---
 target/arm/cpregs.h        |  34 ------
 target/arm/helper.c        | 220 -------------------------------------
 target/arm/tcg/tlb-insns.c | 220 +++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 254 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index fe838bcfd97..cc7c54378f4 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1134,38 +1134,4 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
     return ri->opc1 == 4 || ri->opc1 == 5;
 }
 
-/*
- * Temporary declarations of functions until the move to tlb_insn_helper.c
- * is complete and we can make the functions static again
- */
-CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
-                           bool isread);
-CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
-                             bool isread);
-CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
-                             bool isread);
-bool tlb_force_broadcast(CPUARMState *env);
-int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
-                       uint64_t addr);
-int vae1_tlbbits(CPUARMState *env, uint64_t addr);
-int vae2_tlbbits(CPUARMState *env, uint64_t addr);
-int vae1_tlbmask(CPUARMState *env);
-int vae2_tlbmask(CPUARMState *env);
-int ipas2e1_tlbmask(CPUARMState *env, int64_t value);
-int e2_tlbmask(CPUARMState *env);
-void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                               uint64_t value);
-void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value);
-void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value);
-void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value);
-void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value);
-void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value);
-void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value);
-
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f7d56e809f..cd9f8650316 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -365,40 +365,6 @@ static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-/* Check for traps from EL1 due to HCR_EL2.TTLB. */
-CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
-                           bool isread)
-{
-    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TTLB)) {
-        return CP_ACCESS_TRAP_EL2;
-    }
-    return CP_ACCESS_OK;
-}
-
-/* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBIS. */
-CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
-                             bool isread)
-{
-    if (arm_current_el(env) == 1 &&
-        (arm_hcr_el2_eff(env) & (HCR_TTLB | HCR_TTLBIS))) {
-        return CP_ACCESS_TRAP_EL2;
-    }
-    return CP_ACCESS_OK;
-}
-
-#ifdef TARGET_AARCH64
-/* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBOS. */
-CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
-                             bool isread)
-{
-    if (arm_current_el(env) == 1 &&
-        (arm_hcr_el2_eff(env) & (HCR_TTLB | HCR_TTLBOS))) {
-        return CP_ACCESS_TRAP_EL2;
-    }
-    return CP_ACCESS_OK;
-}
-#endif
-
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -455,16 +421,6 @@ int alle1_tlbmask(CPUARMState *env)
             ARMMMUIdxBit_Stage2_S);
 }
 
-/*
- * Non-IS variants of TLB operations are upgraded to
- * IS versions if we are at EL1 and HCR_EL2.FB is effectively set to
- * force broadcast of these operations.
- */
-bool tlb_force_broadcast(CPUARMState *env)
-{
-    return arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_FB);
-}
-
 static const ARMCPRegInfo cp_reginfo[] = {
     /*
      * Define the secure and non-secure FCSE identifier CP registers
@@ -4680,182 +4636,6 @@ static CPAccessResult access_tocu(CPUARMState *env, const ARMCPRegInfo *ri,
     return do_cacheop_pou_access(env, HCR_TOCU | HCR_TPU);
 }
 
-/*
- * See: D4.7.2 TLB maintenance requirements and the TLB maintenance instructions
- * Page D4-1736 (DDI0487A.b)
- */
-
-int vae1_tlbmask(CPUARMState *env)
-{
-    uint64_t hcr = arm_hcr_el2_eff(env);
-    uint16_t mask;
-
-    assert(arm_feature(env, ARM_FEATURE_AARCH64));
-
-    if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
-        mask = ARMMMUIdxBit_E20_2 |
-               ARMMMUIdxBit_E20_2_PAN |
-               ARMMMUIdxBit_E20_0;
-    } else {
-        /* This is AArch64 only, so we don't need to touch the EL30_x TLBs */
-        mask = ARMMMUIdxBit_E10_1 |
-               ARMMMUIdxBit_E10_1_PAN |
-               ARMMMUIdxBit_E10_0;
-    }
-    return mask;
-}
-
-int vae2_tlbmask(CPUARMState *env)
-{
-    uint64_t hcr = arm_hcr_el2_eff(env);
-    uint16_t mask;
-
-    if (hcr & HCR_E2H) {
-        mask = ARMMMUIdxBit_E20_2 |
-               ARMMMUIdxBit_E20_2_PAN |
-               ARMMMUIdxBit_E20_0;
-    } else {
-        mask = ARMMMUIdxBit_E2;
-    }
-    return mask;
-}
-
-/* Return 56 if TBI is enabled, 64 otherwise. */
-int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
-                       uint64_t addr)
-{
-    uint64_t tcr = regime_tcr(env, mmu_idx);
-    int tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
-    int select = extract64(addr, 55, 1);
-
-    return (tbi >> select) & 1 ? 56 : 64;
-}
-
-int vae1_tlbbits(CPUARMState *env, uint64_t addr)
-{
-    uint64_t hcr = arm_hcr_el2_eff(env);
-    ARMMMUIdx mmu_idx;
-
-    assert(arm_feature(env, ARM_FEATURE_AARCH64));
-
-    /* Only the regime of the mmu_idx below is significant. */
-    if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
-        mmu_idx = ARMMMUIdx_E20_0;
-    } else {
-        mmu_idx = ARMMMUIdx_E10_0;
-    }
-
-    return tlbbits_for_regime(env, mmu_idx, addr);
-}
-
-int vae2_tlbbits(CPUARMState *env, uint64_t addr)
-{
-    uint64_t hcr = arm_hcr_el2_eff(env);
-    ARMMMUIdx mmu_idx;
-
-    /*
-     * Only the regime of the mmu_idx below is significant.
-     * Regime EL2&0 has two ranges with separate TBI configuration, while EL2
-     * only has one.
-     */
-    if (hcr & HCR_E2H) {
-        mmu_idx = ARMMMUIdx_E20_2;
-    } else {
-        mmu_idx = ARMMMUIdx_E2;
-    }
-
-    return tlbbits_for_regime(env, mmu_idx, addr);
-}
-
-void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                               uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = vae1_tlbmask(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
-}
-
-int e2_tlbmask(CPUARMState *env)
-{
-    return (ARMMMUIdxBit_E20_0 |
-            ARMMMUIdxBit_E20_2 |
-            ARMMMUIdxBit_E20_2_PAN |
-            ARMMMUIdxBit_E2);
-}
-
-void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = alle1_tlbmask(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
-}
-
-void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = e2_tlbmask(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
-}
-
-void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E3);
-}
-
-void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = vae1_tlbmask(env);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-    int bits = vae1_tlbbits(env, pageaddr);
-
-    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
-}
-
-void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = vae2_tlbmask(env);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-    int bits = vae2_tlbbits(env, pageaddr);
-
-    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
-}
-
-void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-    int bits = tlbbits_for_regime(env, ARMMMUIdx_E3, pageaddr);
-
-    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                  ARMMMUIdxBit_E3, bits);
-}
-
-int ipas2e1_tlbmask(CPUARMState *env, int64_t value)
-{
-    /*
-     * The MSB of value is the NS field, which only applies if SEL2
-     * is implemented and SCR_EL3.NS is not set (i.e. in secure mode).
-     */
-    return (value >= 0
-            && cpu_isar_feature(aa64_sel2, env_archcpu(env))
-            && arm_is_secure_below_el3(env)
-            ? ARMMMUIdxBit_Stage2_S
-            : ARMMMUIdxBit_Stage2);
-}
-
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 45ebfc512f9..51b4756e31e 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -13,6 +13,40 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 
+/* Check for traps from EL1 due to HCR_EL2.TTLB. */
+static CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TTLB)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
+/* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBIS. */
+static CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    bool isread)
+{
+    if (arm_current_el(env) == 1 &&
+        (arm_hcr_el2_eff(env) & (HCR_TTLB | HCR_TTLBIS))) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
+#ifdef TARGET_AARCH64
+/* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBOS. */
+static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    bool isread)
+{
+    if (arm_current_el(env) == 1 &&
+        (arm_hcr_el2_eff(env) & (HCR_TTLB | HCR_TTLBOS))) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+#endif
+
 /* IS variants of TLB operations must affect all cores */
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
@@ -46,6 +80,16 @@ static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
 }
 
+/*
+ * Non-IS variants of TLB operations are upgraded to
+ * IS versions if we are at EL1 and HCR_EL2.FB is effectively set to
+ * force broadcast of these operations.
+ */
+static bool tlb_force_broadcast(CPUARMState *env)
+{
+    return arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_FB);
+}
+
 static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
@@ -170,6 +214,102 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
+/*
+ * See: D4.7.2 TLB maintenance requirements and the TLB maintenance instructions
+ * Page D4-1736 (DDI0487A.b)
+ */
+
+static int vae1_tlbmask(CPUARMState *env)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    uint16_t mask;
+
+    assert(arm_feature(env, ARM_FEATURE_AARCH64));
+
+    if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+        mask = ARMMMUIdxBit_E20_2 |
+               ARMMMUIdxBit_E20_2_PAN |
+               ARMMMUIdxBit_E20_0;
+    } else {
+        /* This is AArch64 only, so we don't need to touch the EL30_x TLBs */
+        mask = ARMMMUIdxBit_E10_1 |
+               ARMMMUIdxBit_E10_1_PAN |
+               ARMMMUIdxBit_E10_0;
+    }
+    return mask;
+}
+
+static int vae2_tlbmask(CPUARMState *env)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    uint16_t mask;
+
+    if (hcr & HCR_E2H) {
+        mask = ARMMMUIdxBit_E20_2 |
+               ARMMMUIdxBit_E20_2_PAN |
+               ARMMMUIdxBit_E20_0;
+    } else {
+        mask = ARMMMUIdxBit_E2;
+    }
+    return mask;
+}
+
+/* Return 56 if TBI is enabled, 64 otherwise. */
+static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
+                       uint64_t addr)
+{
+    uint64_t tcr = regime_tcr(env, mmu_idx);
+    int tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+    int select = extract64(addr, 55, 1);
+
+    return (tbi >> select) & 1 ? 56 : 64;
+}
+
+static int vae1_tlbbits(CPUARMState *env, uint64_t addr)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    ARMMMUIdx mmu_idx;
+
+    assert(arm_feature(env, ARM_FEATURE_AARCH64));
+
+    /* Only the regime of the mmu_idx below is significant. */
+    if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+        mmu_idx = ARMMMUIdx_E20_0;
+    } else {
+        mmu_idx = ARMMMUIdx_E10_0;
+    }
+
+    return tlbbits_for_regime(env, mmu_idx, addr);
+}
+
+static int vae2_tlbbits(CPUARMState *env, uint64_t addr)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    ARMMMUIdx mmu_idx;
+
+    /*
+     * Only the regime of the mmu_idx below is significant.
+     * Regime EL2&0 has two ranges with separate TBI configuration, while EL2
+     * only has one.
+     */
+    if (hcr & HCR_E2H) {
+        mmu_idx = ARMMMUIdx_E20_2;
+    } else {
+        mmu_idx = ARMMMUIdx_E2;
+    }
+
+    return tlbbits_for_regime(env, mmu_idx, addr);
+}
+
+static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
+}
+
 static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
@@ -183,6 +323,14 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static int e2_tlbmask(CPUARMState *env)
+{
+    return (ARMMMUIdxBit_E20_0 |
+            ARMMMUIdxBit_E20_2 |
+            ARMMMUIdxBit_E20_2_PAN |
+            ARMMMUIdxBit_E2);
+}
+
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
@@ -210,6 +358,32 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E3);
 }
 
+static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = alle1_tlbmask(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
+}
+
+static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = e2_tlbmask(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
+}
+
+static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E3);
+}
+
 static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -241,6 +415,17 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E3);
 }
 
+static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = vae1_tlbbits(env, pageaddr);
+
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
+}
+
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -262,6 +447,41 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = vae2_tlbbits(env, pageaddr);
+
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
+}
+
+static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = tlbbits_for_regime(env, ARMMMUIdx_E3, pageaddr);
+
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
+                                                  ARMMMUIdxBit_E3, bits);
+}
+
+static int ipas2e1_tlbmask(CPUARMState *env, int64_t value)
+{
+    /*
+     * The MSB of value is the NS field, which only applies if SEL2
+     * is implemented and SCR_EL3.NS is not set (i.e. in secure mode).
+     */
+    return (value >= 0
+            && cpu_isar_feature(aa64_sel2, env_archcpu(env))
+            && arm_is_secure_below_el3(env)
+            ? ARMMMUIdxBit_Stage2_S
+            : ARMMMUIdxBit_Stage2);
+}
+
 static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-- 
2.34.1


