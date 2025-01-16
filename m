Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E87C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 23:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYYv3-0005x8-7m; Thu, 16 Jan 2025 18:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYv0-0005wf-R1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 18:04:55 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYuw-0004yS-IS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 18:04:54 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3863703258fso1688263f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068689; x=1737673489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPjOx0H12tn7DXUFgYo1Tt0K02gHKsqQSkcpThpt4FQ=;
 b=BwhJzjPSo6c3irdJWpz6Ovdtp9sDmn2xZn2uVm2PKA/K1jF8jzy7ylbOnsA1GyOLdg
 gxfagTXIeLeZ355uNJsRgqCJxlyi/oUFHI6pC/a/RJ+Ek9UvMpmq/eGlHo0OcaDVDbbc
 vb0qI8FiXhvReYxcfPeRx7pRikDUBE9HpOyUYLhPUr2lBn/wSU72+PaXWonrj+2L1p+t
 LfNzMtU/e4ULsr94m7Zur8H9rh/L74PJAgfHW+szPOsQCefnq19lsntI0bvPLzEOiUA+
 UL+rNnBWy78vsAuB+l8DcbCWaQ09S+1GG2iWKhlYuCLlIwLJ5yv59tUUQa/nKR0ZenFZ
 3QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068689; x=1737673489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPjOx0H12tn7DXUFgYo1Tt0K02gHKsqQSkcpThpt4FQ=;
 b=vpjcr9yaqH8aO0h6PxsKSBA54i2e2MEl+hJHlnc5RYWIv0CisxJ1K59ucxuQQSstIj
 MRXhs35j7AEi8puM33OM5BRrEQDQkJpD8XUN2O2Z7AS+cVmtESIJccLaWlqrQZ2aeBE9
 H8Myk5H/B6XwbPovLdIrNeyRFbuOuA480H+XqAA/nhlo2y2+dF8NFdf1vA8iZr25VTH0
 sB+oPCoKdl8eaWrCsmEUWJXXnD6Lk0RdTLwwOkC8c/8yz0pLj0jW3/QQ+kYK9t67x0oO
 ahkzQbZ6DZSYgw6J0GVdk1+uGP6v4QPNp6f4cspiDFHfUHBMfPbC3KdmGZjCthyyBI9D
 axKA==
X-Gm-Message-State: AOJu0YwC8S5zcDiYl8fD298qrR8BIreGp+n4JICnfenKVduEePlfmBtk
 iEp56T61vKv0YMMKUY17XSRIu/kqzdQyBXLM/0wmh+Vs+DqYBpI9qec5mMtYn87nLUT4lnKVwr6
 IZEQ=
X-Gm-Gg: ASbGnctYHDVglTwnIh1P9pGPJBxfKjfoUJ3im6KBRrrrVaq8y5UqDXhCrXqcSyLEnc6
 9PRHWi5Xbe4Xp/Rzh+/GD0Wimjj7iBNFo9DhYtA8XNxto/3+r1OsI9452JDZq2UBkvxbAktKiPv
 iECunfMmyDwbCEehWbULqbT5wkrZ5Evflxd73FVbA0pk6GP9IqP2XXAESAccDb3LtNgifySqv4e
 qIFZHZemFZR6H3gnrLvKwjfAGrAvA6qsCbXt/jTrQOWA5JhDCbTUIRDkuyMl/i24hVhjqMt7kp+
 q6DHWFrlTLkvftU94HU99InU3pLVUhI=
X-Google-Smtp-Source: AGHT+IESn3JHol9exc7anUTIuhn62s3HNCJlennqJogb6wbZwKHIR3mrotDvm+zFLtJZprV5sI/6iQ==
X-Received: by 2002:a05:6000:156f:b0:385:faf5:ebb8 with SMTP id
 ffacd0b85a97d-38bf5ad3801mr229419f8f.7.1737068688562; 
 Thu, 16 Jan 2025 15:04:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327e19fsm961025f8f.93.2025.01.16.15.04.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 15:04:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 2/2] target/arm: Constify lot of helpers taking
 CPUARMState argument
Date: Fri, 17 Jan 2025 00:04:35 +0100
Message-ID: <20250116230435.87580-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116230435.87580-1-philmd@linaro.org>
References: <20250116230435.87580-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When methods don't modify the CPUARMState* argument,
we can mark it const. This allow enforcing places where
the CPU env shouldn't be modified at all,

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I went via the "modify one and fix until it builds" path,
and the result seemed trivial enough, but can try to split
if requested.
---
 target/arm/cpu-features.h |  2 +-
 target/arm/cpu.h          | 71 ++++++++++++++++++++-------------------
 target/arm/internals.h    | 10 +++---
 target/arm/helper.c       | 25 +++++++-------
 target/arm/ptw.c          |  2 +-
 target/arm/tcg/m_helper.c |  8 ++---
 target/arm/vfp_helper.c   |  6 ++--
 7 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 30302d6c5b4..899b2cfb4b1 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1091,6 +1091,6 @@ static inline uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc,
  * Forward to the above feature tests given an ARMCPU pointer.
  */
 #define cpu_isar_feature(name, cpu) \
-    ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
+    ({ const ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9a6e8e589cc..de54ae6a211 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1267,7 +1267,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm);
 /* Likewise, but using @sm = PSTATE.SM. */
 uint32_t sve_vqm1_for_el(CPUARMState *env, int el);
 
-static inline bool is_a64(CPUARMState *env)
+static inline bool is_a64(const CPUARMState *env)
 {
     return env->aarch64;
 }
@@ -1503,7 +1503,7 @@ static inline unsigned int aarch64_pstate_mode(unsigned int el, bool handler)
  * interprocessing, so we don't attempt to sync with the cpsr state used by
  * the 32 bit decoder.
  */
-static inline uint32_t pstate_read(CPUARMState *env)
+static inline uint32_t pstate_read(const CPUARMState *env)
 {
     int ZF;
 
@@ -1525,7 +1525,7 @@ static inline void pstate_write(CPUARMState *env, uint32_t val)
 }
 
 /* Return the current CPSR value.  */
-uint32_t cpsr_read(CPUARMState *env);
+uint32_t cpsr_read(const CPUARMState *env);
 
 typedef enum CPSRWriteType {
     CPSRWriteByInstr = 0,         /* from guest MSR or CPS */
@@ -1545,7 +1545,7 @@ void cpsr_write(CPUARMState *env, uint32_t val, uint32_t mask,
                 CPSRWriteType write_type);
 
 /* Return the current xPSR value.  */
-static inline uint32_t xpsr_read(CPUARMState *env)
+static inline uint32_t xpsr_read(const CPUARMState *env)
 {
     int ZF;
     ZF = (env->ZF == 0);
@@ -1765,7 +1765,7 @@ QEMU_BUILD_BUG_ON(FPSCR_FPSR_MASK & FPSCR_FPCR_MASK);
  *
  * Return the current AArch64 FPSR value
  */
-uint32_t vfp_get_fpsr(CPUARMState *env);
+uint32_t vfp_get_fpsr(const CPUARMState *env);
 
 /**
  * vfp_get_fpcr: read the AArch64 FPCR
@@ -2445,7 +2445,7 @@ enum arm_features {
     ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
 };
 
-static inline int arm_feature(CPUARMState *env, int feature)
+static inline int arm_feature(const CPUARMState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
 }
@@ -2486,7 +2486,7 @@ static inline ARMSecuritySpace arm_secure_to_space(bool secure)
  * an exception return to those levels.  Unlike arm_security_space,
  * this doesn't care about the current EL.
  */
-ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env);
+ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env);
 
 /**
  * arm_is_secure_below_el3:
@@ -2495,14 +2495,14 @@ ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env);
  * Return true if exception levels below EL3 are in secure state,
  * or would be following an exception return to those levels.
  */
-static inline bool arm_is_secure_below_el3(CPUARMState *env)
+static inline bool arm_is_secure_below_el3(const CPUARMState *env)
 {
     ARMSecuritySpace ss = arm_security_space_below_el3(env);
     return ss == ARMSS_Secure;
 }
 
 /* Return true if the CPU is AArch64 EL3 or AArch32 Mon */
-static inline bool arm_is_el3_or_mon(CPUARMState *env)
+static inline bool arm_is_el3_or_mon(const CPUARMState *env)
 {
     assert(!arm_feature(env, ARM_FEATURE_M));
     if (arm_feature(env, ARM_FEATURE_EL3)) {
@@ -2524,7 +2524,7 @@ static inline bool arm_is_el3_or_mon(CPUARMState *env)
  *
  * Return the current security space of the cpu.
  */
-ARMSecuritySpace arm_security_space(CPUARMState *env);
+ARMSecuritySpace arm_security_space(const CPUARMState *env);
 
 /**
  * arm_is_secure:
@@ -2532,7 +2532,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env);
  *
  * Return true if the processor is in secure state.
  */
-static inline bool arm_is_secure(CPUARMState *env)
+static inline bool arm_is_secure(const CPUARMState *env)
 {
     return arm_space_is_secure(arm_security_space(env));
 }
@@ -2541,7 +2541,7 @@ static inline bool arm_is_secure(CPUARMState *env)
  * Return true if the current security state has AArch64 EL2 or AArch32 Hyp.
  * This corresponds to the pseudocode EL2Enabled().
  */
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+static inline bool arm_is_el2_enabled_secstate(const CPUARMState *env,
                                                ARMSecuritySpace space)
 {
     assert(space != ARMSS_Root);
@@ -2549,39 +2549,39 @@ static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
            && (space != ARMSS_Secure || (env->cp15.scr_el3 & SCR_EEL2));
 }
 
-static inline bool arm_is_el2_enabled(CPUARMState *env)
+static inline bool arm_is_el2_enabled(const CPUARMState *env)
 {
     return arm_is_el2_enabled_secstate(env, arm_security_space_below_el3(env));
 }
 
 #else
-static inline ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
+static inline ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)
 {
     return ARMSS_NonSecure;
 }
 
-static inline bool arm_is_secure_below_el3(CPUARMState *env)
+static inline bool arm_is_secure_below_el3(const CPUARMState *env)
 {
     return false;
 }
 
-static inline ARMSecuritySpace arm_security_space(CPUARMState *env)
+static inline ARMSecuritySpace arm_security_space(const CPUARMState *env)
 {
     return ARMSS_NonSecure;
 }
 
-static inline bool arm_is_secure(CPUARMState *env)
+static inline bool arm_is_secure(const CPUARMState *env)
 {
     return false;
 }
 
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+static inline bool arm_is_el2_enabled_secstate(const CPUARMState *env,
                                                ARMSecuritySpace space)
 {
     return false;
 }
 
-static inline bool arm_is_el2_enabled(CPUARMState *env)
+static inline bool arm_is_el2_enabled(const CPUARMState *env)
 {
     return false;
 }
@@ -2593,12 +2593,13 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
  * "for all purposes other than a direct read or write access of HCR_EL2."
  * Not included here is HCR_RW.
  */
-uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
-uint64_t arm_hcr_el2_eff(CPUARMState *env);
-uint64_t arm_hcrx_el2_eff(CPUARMState *env);
+uint64_t arm_hcr_el2_eff_secstate(const CPUARMState *env,
+                                  ARMSecuritySpace space);
+uint64_t arm_hcr_el2_eff(const CPUARMState *env);
+uint64_t arm_hcrx_el2_eff(const CPUARMState *env);
 
 /* Return true if the specified exception level is running in AArch64 state. */
-static inline bool arm_el_is_aa64(CPUARMState *env, int el)
+static inline bool arm_el_is_aa64(const CPUARMState *env, int el)
 {
     /* This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
      * and if we're not in EL0 then the state of EL0 isn't well defined.)
@@ -2637,7 +2638,7 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
  * it doesn't exist at all) then there is no register banking, and all
  * accesses are to the non-secure version.
  */
-static inline bool access_secure_reg(CPUARMState *env)
+static inline bool access_secure_reg(const CPUARMState *env)
 {
     bool ret = (arm_feature(env, ARM_FEATURE_EL3) &&
                 !arm_el_is_aa64(env, 3) &&
@@ -2677,7 +2678,7 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure);
 
 /* Return the highest implemented Exception Level */
-static inline int arm_highest_el(CPUARMState *env)
+static inline int arm_highest_el(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         return 3;
@@ -2689,7 +2690,7 @@ static inline int arm_highest_el(CPUARMState *env)
 }
 
 /* Return true if a v7M CPU is in Handler mode */
-static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
+static inline bool arm_v7m_is_handler_mode(const CPUARMState *env)
 {
     return env->v7m.exception != 0;
 }
@@ -2697,7 +2698,7 @@ static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
 /* Return the current Exception Level (as per ARMv8; note that this differs
  * from the ARMv7 Privilege Level).
  */
-static inline int arm_current_el(CPUARMState *env)
+static inline int arm_current_el(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_is_handler_mode(env) ||
@@ -3004,7 +3005,7 @@ static inline ARMSecuritySpace arm_phys_to_space(ARMMMUIdx idx)
     return idx - ARMMMUIdx_Phys_S;
 }
 
-static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
+static inline bool arm_v7m_csselr_razwi(const ARMCPU *cpu)
 {
     /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
      * CSSELR is RAZ/WI.
@@ -3012,7 +3013,7 @@ static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
     return (cpu->clidr & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
 }
 
-static inline bool arm_sctlr_b(CPUARMState *env)
+static inline bool arm_sctlr_b(const CPUARMState *env)
 {
     return
         /* We need not implement SCTLR.ITD in user-mode emulation, so
@@ -3025,9 +3026,9 @@ static inline bool arm_sctlr_b(CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
-uint64_t arm_sctlr(CPUARMState *env, int el);
+uint64_t arm_sctlr(const CPUARMState *env, int el);
 
-static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
+static inline bool arm_cpu_data_is_big_endian_a32(const CPUARMState *env,
                                                   bool sctlr_b)
 {
 #ifdef CONFIG_USER_ONLY
@@ -3057,7 +3058,7 @@ static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
 }
 
 /* Return true if the processor is in big-endian mode. */
-static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
+static inline bool arm_cpu_data_is_big_endian(const CPUARMState *env)
 {
     if (!is_a64(env)) {
         return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
@@ -3219,7 +3220,7 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
  *
  * Return the VL cached within env->hflags, in units of quadwords.
  */
-static inline int sve_vq(CPUARMState *env)
+static inline int sve_vq(const CPUARMState *env)
 {
     return EX_TBFLAG_A64(env->hflags, VL) + 1;
 }
@@ -3230,7 +3231,7 @@ static inline int sve_vq(CPUARMState *env)
  *
  * Return the SVL cached within env->hflags, in units of quadwords.
  */
-static inline int sme_vq(CPUARMState *env)
+static inline int sme_vq(const CPUARMState *env)
 {
     return EX_TBFLAG_A64(env->hflags, SVL) + 1;
 }
@@ -3252,7 +3253,7 @@ static inline bool bswap_code(bool sctlr_b)
 }
 
 #ifdef CONFIG_USER_ONLY
-static inline bool arm_cpu_bswap_data(CPUARMState *env)
+static inline bool arm_cpu_bswap_data(const CPUARMState *env)
 {
     return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 863a84edf81..06155816ab4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -832,7 +832,7 @@ static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
 int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
 
 /* Return the MMU index for a v7M CPU in the specified security state */
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate);
 
 /*
  * Return true if the stage 1 translation regime is using LPAE
@@ -1189,7 +1189,7 @@ void arm_cpu_update_vserr(ARMCPU *cpu);
  *
  * Return the full ARMMMUIdx for the translation regime for EL.
  */
-ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
+ARMMMUIdx arm_mmu_idx_el(const CPUARMState *env, int el);
 
 /**
  * arm_mmu_idx:
@@ -1197,7 +1197,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
  *
  * Return the full ARMMMUIdx for the current translation regime.
  */
-ARMMMUIdx arm_mmu_idx(CPUARMState *env);
+ARMMMUIdx arm_mmu_idx(const CPUARMState *env);
 
 /**
  * arm_stage1_mmu_idx:
@@ -1210,13 +1210,13 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
     return ARMMMUIdx_Stage1_E0;
 }
-static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
+static inline ARMMMUIdx arm_stage1_mmu_idx(const CPUARMState *env)
 {
     return ARMMMUIdx_Stage1_E0;
 }
 #else
 ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx);
-ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
+ARMMMUIdx arm_stage1_mmu_idx(const CPUARMState *env);
 #endif
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 63997678513..cf11a8c7736 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -264,7 +264,7 @@ void init_cpreg_list(ARMCPU *cpu)
     g_list_free(keys);
 }
 
-static bool arm_pan_enabled(CPUARMState *env)
+static bool arm_pan_enabled(const CPUARMState *env)
 {
     if (is_a64(env)) {
         if ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1)) {
@@ -5229,7 +5229,8 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
  * Bits that are not included here:
  * RW       (read from SCR_EL3.RW as needed)
  */
-uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
+uint64_t arm_hcr_el2_eff_secstate(const CPUARMState *env,
+                                  ARMSecuritySpace space)
 {
     uint64_t ret = env->cp15.hcr_el2;
 
@@ -5294,7 +5295,7 @@ uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
     return ret;
 }
 
-uint64_t arm_hcr_el2_eff(CPUARMState *env)
+uint64_t arm_hcr_el2_eff(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
         return 0;
@@ -5396,7 +5397,7 @@ static const ARMCPRegInfo hcrx_el2_reginfo = {
 };
 
 /* Return the effective value of HCRX_EL2.  */
-uint64_t arm_hcrx_el2_eff(CPUARMState *env)
+uint64_t arm_hcrx_el2_eff(const CPUARMState *env)
 {
     /*
      * The bits in this register behave as 0 for all purposes other than
@@ -5411,7 +5412,7 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
      */
     if (!arm_is_el2_enabled(env)) {
         uint64_t hcrx = 0;
-        if (cpu_isar_feature(aa64_mops, env_archcpu(env))) {
+        if (cpu_isar_feature(aa64_mops, const_env_archcpu(env))) {
             /* MSCEn behaves as 1 if EL2 is not enabled */
             hcrx |= HCRX_MSCEN;
         }
@@ -9333,7 +9334,7 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
     }
 }
 
-uint32_t cpsr_read(CPUARMState *env)
+uint32_t cpsr_read(const CPUARMState *env)
 {
     int ZF;
     ZF = (env->ZF == 0);
@@ -10703,7 +10704,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-uint64_t arm_sctlr(CPUARMState *env, int el)
+uint64_t arm_sctlr(const CPUARMState *env, int el)
 {
     /* Only EL0 needs to be adjusted for EL1&0 or EL2&0 or EL3&0 */
     if (el == 0) {
@@ -11127,7 +11128,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 }
 #endif
 
-ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
+ARMMMUIdx arm_mmu_idx_el(const CPUARMState *env, int el)
 {
     ARMMMUIdx idx;
     uint64_t hcr;
@@ -11180,7 +11181,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
     return idx;
 }
 
-ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+ARMMMUIdx arm_mmu_idx(const CPUARMState *env)
 {
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
@@ -11412,7 +11413,7 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 #endif
 
 #ifndef CONFIG_USER_ONLY
-ARMSecuritySpace arm_security_space(CPUARMState *env)
+ARMSecuritySpace arm_security_space(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_secure_to_space(env->v7m.secure);
@@ -11429,7 +11430,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env)
     /* Check for AArch64 EL3 or AArch32 Mon. */
     if (is_a64(env)) {
         if (extract32(env->pstate, 2, 2) == 3) {
-            if (cpu_isar_feature(aa64_rme, env_archcpu(env))) {
+            if (cpu_isar_feature(aa64_rme, const_env_archcpu(env))) {
                 return ARMSS_Root;
             } else {
                 return ARMSS_Secure;
@@ -11444,7 +11445,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env)
     return arm_security_space_below_el3(env);
 }
 
-ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
+ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)
 {
     assert(!arm_feature(env, ARM_FEATURE_M));
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 64bb6878a48..613d13b50be 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -158,7 +158,7 @@ ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
     }
 }
 
-ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
+ARMMMUIdx arm_stage1_mmu_idx(const CPUARMState *env)
 {
     return stage_1_mmu_idx(arm_mmu_idx(env));
 }
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f7354f3c6e0..2c792928944 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -156,14 +156,14 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     return 0;
 }
 
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate)
 {
     return ARMMMUIdx_MUser;
 }
 
 #else /* !CONFIG_USER_ONLY */
 
-static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+static ARMMMUIdx arm_v7m_mmu_idx_all(const CPUARMState *env,
                                      bool secstate, bool priv, bool negpri)
 {
     ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
@@ -183,7 +183,7 @@ static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
     return mmu_idx;
 }
 
-static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(const CPUARMState *env,
                                                        bool secstate, bool priv)
 {
     bool negpri = armv7m_nvic_neg_prio_requested(env->nvic, secstate);
@@ -192,7 +192,7 @@ static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
 }
 
 /* Return the MMU index for a v7M CPU in the specified security state */
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate)
 {
     bool priv = arm_v7m_is_handler_mode(env) ||
         !(env->v7m.control[secstate] & 1);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index fc20a567530..f1bb86832f9 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -59,7 +59,7 @@ static inline int vfp_exceptbits_from_host(int host_bits)
     return target_bits;
 }
 
-static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
+static uint32_t vfp_get_fpsr_from_host(const CPUARMState *env)
 {
     uint32_t i;
 
@@ -132,7 +132,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 
 #else
 
-static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
+static uint32_t vfp_get_fpsr_from_host(const CPUARMState *env)
 {
     return 0;
 }
@@ -162,7 +162,7 @@ uint32_t vfp_get_fpcr(CPUARMState *env)
     return fpcr;
 }
 
-uint32_t vfp_get_fpsr(CPUARMState *env)
+uint32_t vfp_get_fpsr(const CPUARMState *env)
 {
     uint32_t fpsr = env->vfp.fpsr;
     uint32_t i;
-- 
2.47.1


