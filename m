Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9092C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLs-00014D-HU; Thu, 01 May 2025 17:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLj-0000xO-5v
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:43 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLg-0001YJ-HG
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:42 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3031354f134so1210289a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134499; x=1746739299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nczjiIFvdSzyLMIbhTUNpKK45zc/zVkUXURaYA2dGhw=;
 b=IEdSZhLMNRp8CjokkuErsjHfOlUl3V3jXXFx3+VeTbVUIc2gO2UuizEAWhWU1oiIsW
 73OSydTcCRhqsWWVH25qfB8WhzSuEVBGnJrWg/lmxe6PpsZNUda/MSx1ksgLe5lie2EJ
 h80LylwbZX42WI5ej95vvoOTmEgRkiBkqO9/piDI9Xx370S2SqliwUwcrh+a6sjJOUK4
 ULDqe+506wrqwCR3WpE8Pn136xI/2MLxJv7YuZhNQmzBNFBH1jZ71st0sKLG9bHerIjo
 D16UndybfU09I6J3SixCFI2N11myRzWnaxAyEQRBE67SRiKbNw+jEAjlLNCy3CoIW5xR
 /EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134499; x=1746739299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nczjiIFvdSzyLMIbhTUNpKK45zc/zVkUXURaYA2dGhw=;
 b=jP3twuXApU/gg/PxV4Sin6T5Ph+FzSAnR/YrHJ+YBcLKEtytvazmZAj8aT9uFA87aW
 2UaoaJo/4ctFcrlb+dYO72dP7NsqVFpHzLfBxeJKuojtUz8+QEZX943Aae9ZlYHWe7CE
 V7eghc29Y3bgxP0QS/hb2Rt4X2i0qgcWKD69NKLsmPcYrOjxGlGnfMLNWAgBJQ9/87PC
 hgHc049l3/xM7QlEd8nH/nMUU4dqgCd1e2J9suHB53Kw1FOi2kWu9DCKx13THSkBRKQB
 P8sb08i70MsASoge6iOj+2cTSxwHqJFzisRnlITRx5AnY8xf0ZhrWkQRWFcifsqTDQbQ
 OvRg==
X-Gm-Message-State: AOJu0Ywdl0C8B8TanwcPJIvn9eYIkQl3VRvlxVNf4LdxBSyKTIadSLlD
 jlHus09VU8q71prcY5PfuXQualYdGBp86+RjefqwY6h/nYt3Bheli0aFOEDzUc6OtkxLavbCgV+
 f
X-Gm-Gg: ASbGnct3poxVu/eWU4g91vlYdSRZz3Ywc51rX9qAjVgImA01zyeqcmzIfpSjxbpuW7u
 Hl4mkyckm9B1WnDRl7DP2mFOCcOLcLAAVxbFRf8Lzc5qV7mmMkNOgyxWEEz/mjSpJ9ACrfiMjiP
 WVi7jDe5aTJyeM1NDz0EqjU5EQlsWDi6NnGlgPK14j1RbDweIRU0MRXTBOvYyaak2yFeyk1W3nO
 Vs//BZrCJrZbpQAQaXgpjRnYkRIaOUR9tt8iR0X0Uycf9GleMpTEdM9Yr+TqxZuMfLNoQPJztkg
 P79sjixBrjXn9O9A+EAOWW/378qo1IZY+DZQMCH6FJroYaa3sIDmcYZPbhH08JIoII8Ftqfg6rs
 =
X-Google-Smtp-Source: AGHT+IE/FNd6SveUji4kNpVfawZU2S/hKexGZjYhepde27Kyc7zNmlr844vlyTqBCLSLJfS4c7TM4g==
X-Received: by 2002:a17:90b:5848:b0:305:5f32:d9f5 with SMTP id
 98e67ed59e1d1-30a4e55aebfmr921746a91.7.1746134499030; 
 Thu, 01 May 2025 14:21:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 29/59] target/arm: Move cpu_get_tb_cpu_state to hflags.c
Date: Thu,  1 May 2025 14:20:43 -0700
Message-ID: <20250501212113.2961531-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

This is a tcg-specific function, so move it to a tcg file.
Also move mve_no_pred, a static function only used within
cpu_get_tb_cpu_state.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c     | 110 ----------------------------------------
 target/arm/tcg/hflags.c | 110 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 98adeb7086..360e6ac0f5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -30,7 +30,6 @@
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/probe.h"
-#include "accel/tcg/cpu-ops.h"
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
@@ -11424,115 +11423,6 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
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
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index e51d9f7b15..e530f65ed7 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -10,6 +10,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/helper-proto.h"
+#include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
 static inline bool fgt_svc(CPUARMState *env, int el)
@@ -513,3 +514,112 @@ void assert_hflags_rebuild_correctly(CPUARMState *env)
     }
 #endif
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
+void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
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
-- 
2.43.0


