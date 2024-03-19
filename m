Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F5CCD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbcs-0005Vt-Tm; Tue, 19 Mar 2024 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcq-0005Ug-GP
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbck-0004rH-9l
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41412e6b2cfso14948465e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863012; x=1711467812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpNrOmMKfl0DvRbVcOp4RsIWsRWfZfygeoHOWL6CLc0=;
 b=WLHb/r2SCxCGp+SHNgNkxz00nvzqclCxeFKGxhnyzrEyx/stYDVJFg/8VMHHDfjUxg
 0DeMNyjYwQ5xcT253p3Rb2XlOWq3O98qbltqKzA8NE5bM4XRoo5UsJCGiKebVxJBlDvE
 +n3d7JkllKHI0+EcBUTP7fCyguoZ73FzTPolSJkuTPYL/ryF55UYpHBKF6iiAo6yQQHO
 a6NR9B5rOAIZfGIf/1KCKP38IVgYqwBaTPqAoBAL3NMyaNcz7UTaId0W3GWbcV6s3ts2
 yPHTgGvwyD2gcUwdVnevAuOFTSwQHKO4yh4WW0Xgl3QVfKkFEpDKdKy77Am309w475Us
 QhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863012; x=1711467812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpNrOmMKfl0DvRbVcOp4RsIWsRWfZfygeoHOWL6CLc0=;
 b=nIOXpO3Pqfv26GH8vWGLGSd0teA4IsGEG5WZtOgDku7nwibwBTevkiYmg7sMieUwy2
 B0VrsE1RaQVgM4D7f15cQuA05hyHkkIx1OKh9avhG1nqlURVUUJ4epA99fVZc/EkqbUz
 iUyImUgR5rPr7jDzaT2wP7PZuD36YUJwutS/otQp14eKJJqmp654+0iAQlRLRb/d48Q0
 9kdBvtfF11kdqkb95fcQBCL/Pvsw0/B+GtH6ABZGi54oZQDEYnDBnBmKtHCNRru8xek5
 bJiuplF/XTKHkHgZU8gZegDjwEMM8A/K0bS8PUCymI7GEBBYW26NHuXaE+5sJikMiBPJ
 cjlQ==
X-Gm-Message-State: AOJu0YyNp8HAL22m6dgHk9tKFE9cP2EChRJZYsQ+lo3Xh8zVq/m/80Mj
 hQ+n4JhYK+YKTmWkg0zrSF7R7pzmQ8UAHeB/2GywfScWn/DjOBBX2m+UtQAsmb+jrrWaEgkzimn
 k
X-Google-Smtp-Source: AGHT+IErRBXKzRYXMMuqeMoxJpHBJ/FdksWdKkX2VXU6f6pKqOZw5EQ1YAtOnpP2vShxkzhnDOIUuQ==
X-Received: by 2002:a05:600c:4f53:b0:414:ed4:e959 with SMTP id
 m19-20020a05600c4f5300b004140ed4e959mr6134890wmq.41.1710863011795; 
 Tue, 19 Mar 2024 08:43:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c458800b0041409c1af05sm10579703wmo.21.2024.03.19.08.43.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 05/27] target/arm: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:34 +0100
Message-ID: <20240319154258.71206-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Move mve_no_pred() along because it is only used by
arm_get_cpu_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h         |   5 --
 target/arm/internals.h   |   2 +
 target/arm/cpu.c         | 110 +++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c      | 109 --------------------------------------
 target/arm/tcg-stubs.c   |   4 --
 target/arm/tcg/cpu-v7m.c |   1 +
 6 files changed, 113 insertions(+), 118 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d20e2bd90e..c563ff2b77 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3151,11 +3151,6 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
 }
 #endif
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
-
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
     QEMU_PSCI_CONDUIT_SMC = 1,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 087caaf2bd..5daef30569 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -353,6 +353,8 @@ void arm_translate_init(void);
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
                               const uint64_t *data);
+void arm_get_cpu_state(CPUARMState *env, vaddr *pc,
+                       uint64_t *cs_base, uint32_t *flags);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 #endif /* CONFIG_TCG */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab8d007a86..8e41e1c427 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -120,6 +120,115 @@ void arm_restore_state_to_opc(CPUState *cs,
         env->exception.syndrome = data[2] << ARM_INSN_START_WORD2_SHIFT;
     }
 }
+
+static bool mve_no_pred(CPUARMState *env)
+{
+    /*
+     * Return true if there is definitely no predication of MVE
+     * instructions by VPR or LTPSIZE. (Returning false even if there
+     * isn't any predication is OK; generated code will just be
+     * a little worse.)
+     * If the CPU does not implement MVE then this TB flag is always 0.
+     *
+     * NOTE: if you change this logic, the "recalculate s->mve_no_pred"
+     * logic in gen_update_fp_context() needs to be updated to match.
+     *
+     * We do not include the effect of the ECI bits here -- they are
+     * tracked in other TB flags. This simplifies the logic for
+     * "when did we emit code that changes the MVE_NO_PRED TB flag
+     * and thus need to end the TB?".
+     */
+    if (cpu_isar_feature(aa32_mve, env_archcpu(env))) {
+        return false;
+    }
+    if (env->v7m.vpr) {
+        return false;
+    }
+    if (env->v7m.ltpsize < 4) {
+        return false;
+    }
+    return true;
+}
+
+void arm_get_cpu_state(CPUARMState *env, vaddr *pc,
+                       uint64_t *cs_base, uint32_t *pflags)
+{
+    CPUARMTBFlags flags;
+
+    assert_hflags_rebuild_correctly(env);
+    flags = env->hflags;
+
+    if (EX_TBFLAG_ANY(flags, AARCH64_STATE)) {
+        *pc = env->pc;
+        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
+            DP_TBFLAG_A64(flags, BTYPE, env->btype);
+        }
+    } else {
+        *pc = env->regs[15];
+
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+                FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
+                != env->v7m.secure) {
+                DP_TBFLAG_M32(flags, FPCCR_S_WRONG, 1);
+            }
+
+            if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
+                (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
+                 (env->v7m.secure &&
+                  !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
+                /*
+                 * ASPEN is set, but FPCA/SFPA indicate that there is no
+                 * active FP context; we must create a new FP context before
+                 * executing any FP insn.
+                 */
+                DP_TBFLAG_M32(flags, NEW_FP_CTXT_NEEDED, 1);
+            }
+
+            bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+            if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
+                DP_TBFLAG_M32(flags, LSPACT, 1);
+            }
+
+            if (mve_no_pred(env)) {
+                DP_TBFLAG_M32(flags, MVE_NO_PRED, 1);
+            }
+        } else {
+            /*
+             * Note that XSCALE_CPAR shares bits with VECSTRIDE.
+             * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
+             */
+            if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+                DP_TBFLAG_A32(flags, XSCALE_CPAR, env->cp15.c15_cpar);
+            } else {
+                DP_TBFLAG_A32(flags, VECLEN, env->vfp.vec_len);
+                DP_TBFLAG_A32(flags, VECSTRIDE, env->vfp.vec_stride);
+            }
+            if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)) {
+                DP_TBFLAG_A32(flags, VFPEN, 1);
+            }
+        }
+
+        DP_TBFLAG_AM32(flags, THUMB, env->thumb);
+        DP_TBFLAG_AM32(flags, CONDEXEC, env->condexec_bits);
+    }
+
+    /*
+     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+     * states defined in the ARM ARM for software singlestep:
+     *  SS_ACTIVE   PSTATE.SS   State
+     *     0            x       Inactive (the TB flag for SS is always 0)
+     *     1            0       Active-pending
+     *     1            1       Active-not-pending
+     * SS_ACTIVE is set in hflags; PSTATE__SS is computed every TB.
+     */
+    if (EX_TBFLAG_ANY(flags, SS_ACTIVE) && (env->pstate & PSTATE_SS)) {
+        DP_TBFLAG_ANY(flags, PSTATE__SS, 1);
+    }
+
+    *pflags = flags.flags;
+    *cs_base = flags.flags2;
+}
 #endif /* CONFIG_TCG */
 
 static bool arm_cpu_has_work(CPUState *cs)
@@ -2479,6 +2588,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .get_cpu_state = arm_get_cpu_state,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f3a5b55d4..e50bec27d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12509,115 +12509,6 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
 
-static bool mve_no_pred(CPUARMState *env)
-{
-    /*
-     * Return true if there is definitely no predication of MVE
-     * instructions by VPR or LTPSIZE. (Returning false even if there
-     * isn't any predication is OK; generated code will just be
-     * a little worse.)
-     * If the CPU does not implement MVE then this TB flag is always 0.
-     *
-     * NOTE: if you change this logic, the "recalculate s->mve_no_pred"
-     * logic in gen_update_fp_context() needs to be updated to match.
-     *
-     * We do not include the effect of the ECI bits here -- they are
-     * tracked in other TB flags. This simplifies the logic for
-     * "when did we emit code that changes the MVE_NO_PRED TB flag
-     * and thus need to end the TB?".
-     */
-    if (cpu_isar_feature(aa32_mve, env_archcpu(env))) {
-        return false;
-    }
-    if (env->v7m.vpr) {
-        return false;
-    }
-    if (env->v7m.ltpsize < 4) {
-        return false;
-    }
-    return true;
-}
-
-void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
-{
-    CPUARMTBFlags flags;
-
-    assert_hflags_rebuild_correctly(env);
-    flags = env->hflags;
-
-    if (EX_TBFLAG_ANY(flags, AARCH64_STATE)) {
-        *pc = env->pc;
-        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
-            DP_TBFLAG_A64(flags, BTYPE, env->btype);
-        }
-    } else {
-        *pc = env->regs[15];
-
-        if (arm_feature(env, ARM_FEATURE_M)) {
-            if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
-                FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
-                != env->v7m.secure) {
-                DP_TBFLAG_M32(flags, FPCCR_S_WRONG, 1);
-            }
-
-            if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
-                (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
-                 (env->v7m.secure &&
-                  !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
-                /*
-                 * ASPEN is set, but FPCA/SFPA indicate that there is no
-                 * active FP context; we must create a new FP context before
-                 * executing any FP insn.
-                 */
-                DP_TBFLAG_M32(flags, NEW_FP_CTXT_NEEDED, 1);
-            }
-
-            bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
-            if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
-                DP_TBFLAG_M32(flags, LSPACT, 1);
-            }
-
-            if (mve_no_pred(env)) {
-                DP_TBFLAG_M32(flags, MVE_NO_PRED, 1);
-            }
-        } else {
-            /*
-             * Note that XSCALE_CPAR shares bits with VECSTRIDE.
-             * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
-             */
-            if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-                DP_TBFLAG_A32(flags, XSCALE_CPAR, env->cp15.c15_cpar);
-            } else {
-                DP_TBFLAG_A32(flags, VECLEN, env->vfp.vec_len);
-                DP_TBFLAG_A32(flags, VECSTRIDE, env->vfp.vec_stride);
-            }
-            if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)) {
-                DP_TBFLAG_A32(flags, VFPEN, 1);
-            }
-        }
-
-        DP_TBFLAG_AM32(flags, THUMB, env->thumb);
-        DP_TBFLAG_AM32(flags, CONDEXEC, env->condexec_bits);
-    }
-
-    /*
-     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-     * states defined in the ARM ARM for software singlestep:
-     *  SS_ACTIVE   PSTATE.SS   State
-     *     0            x       Inactive (the TB flag for SS is always 0)
-     *     1            0       Active-pending
-     *     1            1       Active-not-pending
-     * SS_ACTIVE is set in hflags; PSTATE__SS is computed every TB.
-     */
-    if (EX_TBFLAG_ANY(flags, SS_ACTIVE) && (env->pstate & PSTATE_SS)) {
-        DP_TBFLAG_ANY(flags, PSTATE__SS, 1);
-    }
-
-    *pflags = flags.flags;
-    *cs_base = flags.flags2;
-}
-
 #ifdef TARGET_AARCH64
 /*
  * The manual says that when SVE is enabled and VQ is widened the
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 152b172e24..1a7ddb3664 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -21,7 +21,3 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
 {
     g_assert_not_reached();
 }
-/* Temporarily while cpu_get_tb_cpu_state() is still in common code */
-void assert_hflags_rebuild_correctly(CPUARMState *env)
-{
-}
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c059c681e9..de4a1ff81b 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -237,6 +237,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .get_cpu_state = arm_get_cpu_state,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
-- 
2.41.0


