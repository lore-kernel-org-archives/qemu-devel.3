Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F8CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNuY-0001Kz-Ki; Sat, 30 Aug 2025 11:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELq-0005uL-2s
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELo-00047i-E1
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso2424037b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532527; x=1757137327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXa5bV+w2XJCtl1B6/zvOBxDKz3xDTsxv0W99xe/k2Q=;
 b=pst4cJJbuG/Q0EyAjeP5VulWTEOT9dl/ToQj08MWP/otUSItDWSVu5/RC4vwN10frw
 eO7zlfUk77bufeAcrfiSwaStw/1NMdJT4PpBkMtzUb4yLjoxncGUEaXtK3Vdv+xsyoPP
 frDS2Mo+gtIWBnsR5cgy+Dv+EM8fYFl0mlt+E0LM9iX9rd8gGFq4kaRfronh4Q0pkW2Q
 lD0uOWlQ4TIJYDUFyb2ZqZ1M//Yv4CiY+yUczNMTxUGWTw/zaR2Ve+yq+WjmTY4N0jRQ
 pS+QwnuKeblzbX470weTds25MXa1/nzqQLcT5h4pbqbAD3epUw2NNvURTL2ZkxDAhecD
 VPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532527; x=1757137327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXa5bV+w2XJCtl1B6/zvOBxDKz3xDTsxv0W99xe/k2Q=;
 b=Xx565KR8ldDyQVpQCbGaJxFRHQNzNMPCrqKtvyxziJVgvlMuzd8w2ld4sRD0rsCzJ7
 hodnqurcszsQe8AMBsznUVjDeOtTdY+p8x0RLQmORnZxoB3Ea+yM/DyxLKUsRL2wnmjh
 Uu3ZimWkShXr3LgJtR6Y78913Eztp4JNoEoBTyzrwfATpI3v4OI5uTvHqGlPXBOutjPm
 VR2XWeTmnNxkwWHt46E77pIRniGfaYv9NET8DQ+yAjwPPGx+1AY6G+8EUHoOo8qcImRH
 6r6B3x2TYF7z5QNPmYWDB4qCUuIYWX6MmOd/Kn5nrDlxVIiafzz9w7nLm6DTgD2bpbKr
 fq2A==
X-Gm-Message-State: AOJu0Yz0113by+Qi1RPfBCMh2mk+GajNk+Fmu/ffoQaqmk+zLPMpmUff
 Q79zgyQ40uK5Az1rYv1hSH8+08MZ1f8qUu/JeDC1uLL2oX65OA5pCPQ5vXx1Pu0WsqOIa4OGj/Y
 3JlPisZU=
X-Gm-Gg: ASbGncuT4Zu+uQ1CuKnGjcG6S8/x+KzYX4keSpyIjcLlsZoxhVomd7RDyeNoYD86Qj8
 t3nTrHBN1Jvd+Jn6a0cpq+XzH/R8D6jDL/PlKFUGM/eoQMvW3QzscQwm/GHInT8KRWCfCs7A53d
 trylyiNMT8ojwY1ESddhOVaiLmhZrbtUO1baQfn++fv2uVr5yUk2MGyn9ZphgSQ+e2r98NkPqVF
 zCA74zuL5EaSjnWylfZYh/b37oIAEPd7FuTj+E3Lk8vjKVJ8LSFKKy+dRXOBH5bKCQmvrnkivRb
 uJ5Cyt7mxl7PzfyvrTCBnnNEd2Ql7lRibsRRfmW+jDdqWwefNNq2JFoZlR/ud7OgE/0hySYxZC0
 mx88B30qvJeMURbzpyFQZcyepk+kvdM3k4sY+CdsHBK/QiV+GhcD1tHue2+ylZR547RFiHcE=
X-Google-Smtp-Source: AGHT+IH0JvavmGZhTPCRrrwZlEP9Syl5QvyE7VLPyyJkF1OngTWJLulwHz3xGEiYsS4dZo68u6R4Mw==
X-Received: by 2002:a05:6a20:3d07:b0:243:9587:a75c with SMTP id
 adf61e73a8af0-243d6f7ec6cmr1501092637.59.1756532526794; 
 Fri, 29 Aug 2025 22:42:06 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 12/84] target/arm: Implement FEAT_ATS1A
Date: Sat, 30 Aug 2025 15:40:16 +1000
Message-ID: <20250830054128.448363-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Implement FEAT_ATS1A and enable for -cpu max.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h           |  1 +
 target/arm/cpu-features.h     |  5 ++++
 target/arm/tcg/cpregs-at.c    | 44 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 docs/system/arm/emulation.rst |  1 +
 5 files changed, 52 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 1d103b577f..2a4826f5c4 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -854,6 +854,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
+    DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
 #undef DO_BIT
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e49e0ae3af..512eeaf551 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -619,6 +619,11 @@ static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, LUT);
 }
 
+static inline bool isar_feature_aa64_ats1a(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, ATS1A);
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index bebf168997..0e8f229aa7 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -488,6 +488,47 @@ static const ARMCPRegInfo ats1cp_reginfo[] = {
       .writefn = ats_write },
 };
 
+static void ats_s1e1a(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
+    ARMMMUIdx mmu_idx = regime_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_Stage1_E1;
+    ARMSecuritySpace ss = arm_security_space_below_el3(env);
+
+    env->cp15.par_el[1] = do_ats_write(env, value, 0, mmu_idx, ss);
+}
+
+static void ats_s1e2a(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    ARMMMUIdx mmu_idx = hcr_el2 & HCR_E2H ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
+    ARMSecuritySpace ss = arm_security_space_below_el3(env);
+
+    env->cp15.par_el[1] = do_ats_write(env, value, 0, mmu_idx, ss);
+}
+
+static void ats_s1e3a(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    env->cp15.par_el[1] = do_ats_write(env, value, 0, ARMMMUIdx_E3,
+                                       arm_security_space(env));
+}
+
+static const ARMCPRegInfo ats1a_reginfo[] = {
+    { .name = "AT_S1E1A", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 2,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E1A,
+      .accessfn = at_s1e01_access, .writefn = ats_s1e1a },
+    { .name = "AT_S1E2A", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 9, .opc2 = 2,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .accessfn = at_s1e2_access, .writefn = ats_s1e2a },
+    { .name = "AT_S1E3A", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 9, .opc2 = 2,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_s1e3a },
+};
+
 void define_at_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -509,4 +550,7 @@ void define_at_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa32_ats1e1, cpu)) {
         define_arm_cp_regs(cpu, ats1cp_reginfo);
     }
+    if (cpu_isar_feature(aa64_ats1a, cpu)) {
+        define_arm_cp_regs(cpu, ats1a_reginfo);
+    }
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b8b1981e70..abef6a246e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1179,6 +1179,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4e8aca8b5d..6b04c96c8c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -23,6 +23,7 @@ the following architecture extensions:
 - FEAT_AFP (Alternate floating-point behavior)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
+- FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
-- 
2.43.0


