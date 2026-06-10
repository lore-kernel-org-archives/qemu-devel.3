Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9E5CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXP-0007bU-Ea; Wed, 10 Jun 2026 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXL-0007aJ-V4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXJ-0005Sy-O5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso3763064f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107932; x=1781712732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K4S4bsXMTOcs5tjuWo68a0UsKUsVT7dNcjRQ9DsvzTg=;
 b=GagITdjGNEudsU5fWYCOakM982sT0+S/pMTgprT2ks9xvvQO4TkyJNI8y6C8e4xVfH
 JNEzJ8fpIu4vfGqXMpvQuzjRjo1M4/Xxtbz7U3eNeFmHpOA2F8GOmMn1ZvXhucE6HDZ8
 mV9TG8eggZmE0l3NufJMFfd/ANjC/hSFcIcogSsiy7u40o1z3SMruwJGJ9NTbFrjoKd2
 oDjDixbsFEk0BzkkJoftFKHsNYxHFULtBj82rtziEeBxNFPbLVI49GKbyX+Onib6VRPv
 QGbCTatrtJ8sjQPXtqUDebdaVCj1dpoju8d/6QyIbw1FhuXNBPgjwIIIjlI5X5dPYY+f
 Wm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107932; x=1781712732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K4S4bsXMTOcs5tjuWo68a0UsKUsVT7dNcjRQ9DsvzTg=;
 b=aFp06kHOh7QZ0TUTe6SxzcqL7qMtmFpZ6f0XxmIOneTWQx+27ciqWVbfknAVMELutB
 Admg0pXlXBBbhFKCWCutzTDJWd7LQKiqomKPtdeb32jHKnqD8dm06uTRuVJEsSO6Pfrl
 7wHncOikbwav5nr8gifAGWwbSTW4rY4a+LHQs0A4W7prusnzHJMwidJKOLbHnDuQju4O
 XOv4pgrTPX9k4C6j6/oEyYsIjn4h+uqMddBSAGytvBrvhVUHsamIafFD409krzTkjypN
 tl87Mtu+vbQj8I8iB4QRv52Lziob0azKTac5TU2zy47XxdbmR5AP1VV+UK8TUMSCjnpv
 w9+A==
X-Gm-Message-State: AOJu0YzogJX9aJ9f4uRGEozq+v6P3YCHoOLZEoUprzE29DfEvK47FVmv
 BnXgE31qigu8fG4n8PCi/G3asmF47vk/JMM+AtkUCoitw9CSAgdnvqs3GbpTSgLW4is/N1Wi29d
 ZMK06
X-Gm-Gg: Acq92OGNuikYALuBgAj4kMiPzwgT7Tdp8NVlQscll9FZcA4smgWL0bjYN85HFhY9Jcy
 B/wsld7yPXOvOwoy3ONyBtLJwiNlOmJX5+L69qBrz9lxBJDbKib7SFijOZhROM+f45Jt06o9VZ4
 DgB0jaTaKpJfsrCAmo/WmgIUH6Buh/thWDdwThydokSzHOnQXbmuntMtAuphxu1imI8cdAbtup2
 q3ADLPAuUZkAW7x2F8FXD4+jqTl50eub5oADkLMecOvVkTqvcgZgh4MDsrHo67T2sC+nKqqMBVN
 o4Xw6SxpbQaN/HCe2vyg8kfWy3AguShEqlI1bmwv8M8stxcVz8B6ipXUw8LlLgnFA4FPoIb7iSU
 Os3QGUr61zRzt6g2d9nf8oUZqxy6dBb8N4g6QcTqWqkxvrOhswQuTAa4bW+CA21c+9kny39lIsV
 oGpO5eSzCGK+ffMMSstjNX6KOVN+3vjqmFnf6cvhSE6GmGElx9y6WxjkG9a1RqTQp2tbhRwwkti
 S8qllBZyRAY/zkzjeeLYi3r9PA21NsDN+maUV/n2ScvUE1APJJ3ng==
X-Received: by 2002:a05:600c:3e83:b0:490:af90:f9c2 with SMTP id
 5b1f17b1804b1-490c25b224dmr411369415e9.12.1781107932275; 
 Wed, 10 Jun 2026 09:12:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/71] target/arm: emit tag check when MTX without TBI
Date: Wed, 10 Jun 2026 17:10:57 +0100
Message-ID: <20260610161202.2235298-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

Previously, the TBI bit was used to mediate whether tag checks happened.
With MTE4, if the MTX bits are enabled, then tag checking happens even
if TBI is disabled. See AccessIsTagChecked.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-5-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h   |  5 +++++
 target/arm/helper.c         | 10 ++++++++++
 target/arm/internals.h      | 13 ++++++++-----
 target/arm/tcg/helper-a64.c |  7 ++++---
 target/arm/tcg/hflags.c     | 11 +++++++----
 target/arm/tcg/mte_helper.c |  9 ++++++---
 target/arm/tcg/sme_helper.c |  4 ++--
 target/arm/tcg/sve_helper.c |  6 +++---
 8 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 92400df649..13453bd8f4 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1201,6 +1201,11 @@ static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
 }
 
+static inline bool isar_feature_aa64_mte_mtx(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTEX) != 0;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb77cbae51..b989acd0f5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9661,6 +9661,16 @@ uint64_t arm_sctlr(CPUARMState *env, int el)
     return env->cp15.sctlr_el[el];
 }
 
+int aa64_va_parameter_mtx(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 60, 2);
+    } else {
+        /* Replicate the single MTX bit so we always have 2 bits.  */
+        return extract64(tcr, 33, 1) * 3;
+    }
+}
+
 int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
 {
     if (regime_has_2_ranges(mmu_idx)) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f39a992012..3b60e4a469 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1445,6 +1445,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data,
                                    bool el1_is_aa32);
 
+int aa64_va_parameter_mtx(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tcma(uint64_t tcr, ARMMMUIdx mmu_idx);
@@ -1586,7 +1587,8 @@ FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, 32 - 12)  /* size - 1 */
+FIELD(MTEDESC, MTX,   12, 2)
+FIELD(MTEDESC, SIZEM1, 14, 32 - 14)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
@@ -1656,10 +1658,11 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
     return deposit64(ptr, 56, 4, rtag);
 }
 
-/* Return true if tbi bits mean that the access is checked.  */
-static inline bool tbi_check(uint32_t desc, int bit55)
+/* Return true if tbi or mtx bits mean that the access is tag checked.  */
+static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
 {
-    return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
+    uint32_t mask = (1u << R_MTEDESC_TBI_SHIFT) | (1u << R_MTEDESC_MTX_SHIFT);
+    return desc & (mask << bit55);
 }
 
 /* Return true if tcma bits mean that the access is unchecked.  */
@@ -1693,7 +1696,7 @@ static inline uint64_t useronly_maybe_clean_ptr(uint32_t desc, uint64_t ptr)
 {
 #ifdef CONFIG_USER_ONLY
     int64_t clean_ptr = sextract64(ptr, 0, 56);
-    if (tbi_check(desc, clean_ptr < 0)) {
+    if (tbi_or_mtx_check(desc, clean_ptr < 0)) {
         ptr = clean_ptr;
     }
 #endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 093c697e05..a0f9215f1c 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1054,7 +1054,7 @@ static int mops_sizereg(uint32_t syndrome)
 }
 
 /*
- * Return true if TCMA and TBI bits mean we need to do MTE checks.
+ * Return true if the TCMA, TBI, and MTX bits mean we need to do MTE checks.
  * We only need to do this once per MOPS insn, not for every page.
  */
 static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
@@ -1062,12 +1062,13 @@ static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
     int bit55 = extract64(ptr, 55, 1);
 
     /*
-     * Note that tbi_check() returns true for "access checked" but
+     * Note that tbi_or_mtx_check() return true for "access checked", but
      * tcma_check() returns true for "access unchecked".
      */
-    if (!tbi_check(desc, bit55)) {
+    if (!tbi_or_mtx_check(desc, bit55)) {
         return false;
     }
+
     return !tcma_check(desc, bit55, allocation_tag_from_addr(ptr));
 }
 
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 6be84b68ab..d9d783489c 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -283,13 +283,16 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     uint64_t tcr = regime_tcr(env, mmu_idx);
     uint64_t hcr = arm_hcr_el2_eff(env);
     uint64_t sctlr;
-    int tbii, tbid;
+    int tbii, tbid, mtx;
 
     DP_TBFLAG_ANY(flags, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
     tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
     tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
+    mtx = cpu_isar_feature(aa64_mte_mtx, env_archcpu(env)) ?
+          aa64_va_parameter_mtx(tcr, mmu_idx) :
+          0;
 
     DP_TBFLAG_A64(flags, TBII, tbii);
     DP_TBFLAG_A64(flags, TBID, tbid);
@@ -441,14 +444,14 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         /*
          * Set MTE_ACTIVE if any access may be Checked, and leave clear
          * if all accesses must be Unchecked:
-         * 1) If no TBI, then there are no tags in the address to check,
+         * 1) If TBI and MTX are both unset, accesses are Unchecked.
          * 2) If Tag Check Override, then all accesses are Unchecked,
          * 3) If Tag Check Fail == 0, then Checked access have no effect,
          * 4) If no Allocation Tag Access, then all accesses are Unchecked.
          */
         if (allocation_tag_access_enabled(env, el, sctlr)) {
             DP_TBFLAG_A64(flags, ATA, 1);
-            if (tbid
+            if ((tbid || mtx)
                 && !(env->pstate & PSTATE_TCO)
                 && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
                 DP_TBFLAG_A64(flags, MTE_ACTIVE, 1);
@@ -474,7 +477,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         /* And again for unprivileged accesses, if required.  */
         if (EX_TBFLAG_A64(flags, UNPRIV)
-            && tbid
+            && (tbid || mtx)
             && !(env->pstate & PSTATE_TCO)
             && (sctlr & SCTLR_TCF0)
             && allocation_tag_access_enabled(env, 0, sctlr)) {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bf35dc10ce..61cdf92c54 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -823,8 +823,11 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     bit55 = extract64(ptr, 55, 1);
     *fault = ptr;
 
-    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
+    /*
+     * If TBI and MTX are disabled, the access is unchecked, and ptr is not
+     * dirty.
+     */
+    if (unlikely(!tbi_or_mtx_check(desc, bit55))) {
         return -1;
     }
 
@@ -965,7 +968,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     bit55 = extract64(ptr, 55, 1);
 
     /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
+    if (unlikely(!tbi_or_mtx_check(desc, bit55))) {
         return ptr;
     }
 
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0055e97a2b..2bfb12c086 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -674,7 +674,7 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -856,7 +856,7 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a002006ea5..d05d8addfd 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6388,7 +6388,7 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -6750,7 +6750,7 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
@@ -7005,7 +7005,7 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     int bit55 = extract64(addr, 55, 1);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(mtedesc, bit55) ||
+    if (!tbi_or_mtx_check(mtedesc, bit55) ||
         tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
-- 
2.43.0


