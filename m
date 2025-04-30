Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B68C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcq-0006SN-41; Wed, 30 Apr 2025 12:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcJ-0004z2-NR
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:07 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcH-0001uC-OL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:03 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af91fc1fa90so51661a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031740; x=1746636540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSX6D5vgzNk6RAgZyLyRqAirOJHp5W5gvXuRkK9XdPE=;
 b=EHPl3b09oMcEOcNw+JBFGkVAdb1cxBN71ZrJdqd3lgzASWumuBjx3XXABL1af1Bmlg
 gaLSJfgtbzjNJ4TRe6CEg0zR9xVNLBjKaL4OOYnJNz/sWbLK0ceqmlxsSmeV2yoT1G7V
 leKiigsPbmX02CGghHlnClWT5ogAmZI5Qo/6J4O3xBfB0TUp4Xri/xOK0ZlJS9UMeUSM
 oFIpqMLlrpUvoEm5mcaCdSR01aQ2eqnCJQrsOSgXMowYNeSkHUiGbD7SV1IbCMqgx6tU
 STS2qi39Eye/CV/N+PPvfbOpUGlM+zn5IxgtdvsqMenhr6tnn/lhZ/K23d+lnFi/d/GP
 0XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031740; x=1746636540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSX6D5vgzNk6RAgZyLyRqAirOJHp5W5gvXuRkK9XdPE=;
 b=llhATPR18TbxatbnDRejRxD6KsZSwJmeSHG2MLKXHD4iWM89zQufa+Rpl7Ql3zq5RK
 3QMkZWa4FkT3Wnx7mLnatjYDCOlD75lgaw7mB5UYiGXO1gc/eFnYiipEZFySLaqnmvaX
 dijzn7/49CjB8hnTe8i5/e1QGTaslAMWoYpuiJZ2tHuE/xkB3GKQEXJriZCG8KD3AM0L
 yk6EBivUqh5dsj4xep+z+7zebaiRHPVJqjMvt7nyRp8+naZtDCnw+C9pyJtmERV1ZSN5
 pb74u22xstrJmSXxr08DscBb2AOxBtka6VttDr6IxMp9g1X2CAVRIsgi7rBCYGC04I+p
 bUoA==
X-Gm-Message-State: AOJu0YyUS5cmAUMBhxPvRWCRfz8OL0NixOSvE/dUvKTu9G4693NoncHw
 FtGuMzjx8h5xcZL4GlJrZVW5lZWpq7E2FCOEZLnBY+4P7sfYfU8t3Elcp1ctuOXu+o4xdINoRX/
 j
X-Gm-Gg: ASbGncvHocD8wOmv2VXf/3qV9sxIpEl2DE2WlZ0hHezcGakJYUYc+ZBq3zXKF/n+OLU
 aQnHnbq0rYwfww3wVUvlADdXFAmQ1gVx0XGLcsBtHbB5PuONIwsbAh1oZfWG6KRGA+u4QWbCm4p
 aiEmNaqjqwQakw/bGPiRs+ulPp4ubVKr0UHUfoWzoUUjJ5/MdQx9EmQ+KLxY8puUoJVEQYIxtTp
 lTEfloWWKBO+Wq3UN1kCOKaj7h7AnyM/DIeJG8/ea+s+1SkKF+5YLDgL4JsVehFwSgFPXz8PH1Y
 jAheSwcEZqtt/j7O7v34KLdDXKzdZ6KWWjv94TkFvndvrN48Sea7fJI/X7h6tjQ6fL2QcK4vaTg
 =
X-Google-Smtp-Source: AGHT+IHwX52ET+cXJlMDflVEIME0PIbODaerdMhirkf2IpEJaiBRKupSSQboRJkfO7ovn20NihJnhA==
X-Received: by 2002:a05:6a20:7f87:b0:1f5:6680:82b6 with SMTP id
 adf61e73a8af0-20a8980df0bmr4897921637.38.1746031740371; 
 Wed, 30 Apr 2025 09:49:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:48:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 06/16] target/arm: Move cpu_get_tb_cpu_state to hflags.c
Date: Wed, 30 Apr 2025 09:48:44 -0700
Message-ID: <20250430164854.2233995-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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


