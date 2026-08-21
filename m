Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43B1C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1E-0000rC-By; Fri, 21 Aug 2026 07:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN10-0000WX-9p
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0w-0007UE-2l
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4998590d392so7246685e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310140; x=1787914940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fRD0ITQlD3oXdf+X+13BjZ11mXjLBMrN4t7UM+TYT/4=;
 b=bLF6iYVpxHv+/iFxT67bCRPtTVnPCwqsO5Db2CFxvEKQHQ1tPTppj5wxcubLaLTg/X
 yRwSLaj01+fdMRrC8+PQDNLwuJULqOwf2oRO+8DtRZR+nnDw7D6xy4BmelrWLqPSVh62
 P94r1Fd/kVl8ISvt/762yM6HjkSKmKYclLX9eq1VkAimWu4T4r0sO+YkkXeApc3jKYha
 scgvPLzapZKHpiKm39PtQoz1uj1KCbZkqsV0m00LEnRJDbxp/eFDDKHA/Jql+NoDw2NU
 eO8xEFRRX/p+3WkFKprc+cMdh2ZFvBPSO+QDwpyhtABFOtJRr++p4f9xidREBPlKu/x9
 VM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310140; x=1787914940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fRD0ITQlD3oXdf+X+13BjZ11mXjLBMrN4t7UM+TYT/4=;
 b=sFWSnVNob8FTdzmojAN4A7xwdYECuveSs1H1y4CD9lts7CPKM4EVSQMqyu+3hheTEj
 rmL7XCdrOOTiybx+7tBxPtsGXsgQicrJ6HepN9V1HTcUOJ8h6C+D+Df9lMJqPjbZsZ5g
 UzqT+CXa8qrb/nSoFMQHzM2NjZcxSenkwItcRahBFKnJpZABT0QcpvpAIgQ3jg29NoVK
 Rl8JdqaCpilTwMVkLtfuYYArfa/2EKOP0Es5Yu2yvtlOLIE1t7RzkdWcqGYMcwmSwc7t
 gWv1UbGUbXN1fydwaup8avvwJKiVYyBqNvcD6yZGuG6I71WtOOYdcEsy/3Z4TFxvr8c6
 x3zw==
X-Gm-Message-State: AOJu0Yz/ubA/SaMmDsnvgpkIvKxN+oMVK7STs7eWb1v9xH6h0QUFquJQ
 bIPpLDKEUkQQ0su5qTTrZjkbmrnUKaLfg/N/IL8S30ybsLgCo9nhm+0P2EyGu0ZSMkU2/1nFnt3
 T93OX
X-Gm-Gg: AR+sD12hPHjXOpzdv3Kbhm24389Sf/wTz/V4KSYEHZovYmtDrAKUppmEmwhllS0NUm4
 LccKp3Plr8QLZ5KM404lNJsEyqS7hYIm3KNhF3En7CiSYlsl4jrCmsoUcpYGjPRVMY+p7IlPxXb
 XOn3Fu0CPdubVkPJnQG3wYfQxx2qQsDpKeQXVsa0t909Kn4Y0g0GmkrzbSyrb7GrDW9IApMkEeb
 /YrTs68pFJtCuPiaojnXijNRWv7X/5soNT4QFLj5idgkH1sdj0/4sAJQHU+UM7hZLe/rFeMlecm
 j9tj7kiYkZ9YTq/UsDt1DPZeLZe+7Kalnaow+bHs0WAtKZGeSalXFtV66U8BZUf4w1qDlnqqZY1
 fBrL/aOmIOrrpfOw0CW8QcWoY87j0UMhgi02YUoJR+4NsyBqE9Im1uhiSjMTGXfsrbfkCFzCNeC
 mmUL02uBkV9togUf4jO04G18chscqINXW2YTinHlhwc5axccfkxYwr95Qlg+2jXxMJHllWlIfcB
 DBE8fZx0vz/pDzyMu7QMPVZWTAMDxb3BOb1fIc/6VPxibpXFssOrj3vk6ZctQC+Q3Q9SA==
X-Received: by 2002:a05:600c:6989:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-499b82e84fdmr82969245e9.6.1787310140510; 
 Fri, 21 Aug 2026 04:02:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/43] target/arm: Implement CPACR.D32DIS
Date: Fri, 21 Aug 2026 12:00:40 +0100
Message-ID: <20260821110101.3971391-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

On some v7A CPUs, CPACR.D32DIS is a bit allowing the guest to make
VFP instructions that touch registers D16..D31 UNDEF.  Whether the
CPU implements this or not is IMPDEF, and the only two CPUs we
implement which have this are the Cortex-A7 and Cortex-A9.  In v8A
the bit is no longer defined at all.

Since the only kind of trapping that needs to be done is a simple
UNDEF, this is straightforward enough to implement.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1499
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-8-peter.maydell@linaro.org
---
 target/arm/cpu.h               |  4 ++++
 target/arm/helper.c            | 19 ++++++++++++++++---
 target/arm/tcg/cpu32.c         |  2 ++
 target/arm/tcg/hflags.c        | 20 ++++++++++++++++++++
 target/arm/tcg/translate-vfp.c |  7 ++-----
 target/arm/tcg/translate.c     |  6 ++++++
 target/arm/tcg/translate.h     |  1 +
 7 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index afc3fda3b83..e8dfc3179f2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2184,6 +2184,8 @@ enum arm_features {
      * ARM_FEATURE_NEON CPUs except the Cortex-A8.
      */
     ARM_FEATURE_NEON_TRAPS,
+    /* Does the CPU implement CPACR.D32DIS ? */
+    ARM_FEATURE_D32DIS,
 };
 
 static inline int arm_feature(const CPUARMState *env, int feature)
@@ -2512,6 +2514,8 @@ FIELD(TBFLAG_A32, SME_TRAP_NONSTREAMING, 11, 1)
  * take precedence.
  */
 FIELD(TBFLAG_A32, NEONEXC_EL, 12, 2)
+/* Should VFP insns touching D16..D31 UNDEF? (CPACR.D32DIS) */
+FIELD(TBFLAG_A32, D32DIS, 14, 1)
 
 /*
  * Bit usage when in AArch32 state, for M-profile only.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2dfbeae0efd..4f30a94ecd3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -573,8 +573,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          */
         if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
             /* VFP coprocessor: cp10 & cp11 [23:20] */
-            mask |= R_CPACR_D32DIS_MASK |
-                    R_CPACR_CP11_MASK |
+            mask |= R_CPACR_CP11_MASK |
                     R_CPACR_CP10_MASK;
 
             if (!arm_feature(env, ARM_FEATURE_NEON)) {
@@ -596,6 +595,13 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
             if (!cpu_isar_feature(aa32_simd_r32, env_archcpu(env))) {
                 /* D32DIS [30] is RAO/WI if D16-31 are not implemented. */
                 value |= R_CPACR_D32DIS_MASK;
+                mask |= R_CPACR_D32DIS_MASK;
+            } else if (arm_feature(env, ARM_FEATURE_D32DIS)) {
+                /*
+                 * Bit is present unless CPU doesn't implement D32DIS,
+                 * in which case it is RAZ/WI.
+                 */
+                mask |= R_CPACR_D32DIS_MASK;
             }
         }
         value &= mask;
@@ -605,7 +611,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
      * Similarly, if NSACR.NSASEDIS is 1 then CPACR.ASEDIS ignores writes
-     * and reads as 1.
+     * and reads as 1, and NSACR.NSD32DIS makes CPACR.D32DIS behave as RAO/WI.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
         !arm_is_secure(env)) {
@@ -617,6 +623,10 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
             mask = R_CPACR_ASEDIS_MASK;
             value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
         }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSD32DIS)) {
+            mask = R_CPACR_D32DIS_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
     }
 
     env->cp15.cpacr_el1 = value;
@@ -639,6 +649,9 @@ static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
             value |= R_CPACR_ASEDIS_MASK;
         }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSD32DIS)) {
+            value |= R_CPACR_D32DIS_MASK;
+        }
     }
     return value;
 }
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 724a9549347..bc07e33877a 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -336,6 +336,7 @@ static void cortex_a9_initfn(Object *obj)
      */
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_CBAR);
+    set_feature(&cpu->env, ARM_FEATURE_D32DIS);
     cpu->midr = 0x410fc090;
     cpu->reset_fpsid = 0x41033090;
     cpu->isar.mvfr0 = 0x11110222;
@@ -403,6 +404,7 @@ static void cortex_a7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
+    set_feature(&cpu->env, ARM_FEATURE_D32DIS);
     cpu->midr = 0x410fc075;
     cpu->reset_fpsid = 0x41023075;
     cpu->isar.mvfr0 = 0x10110222;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 14824e3dff1..296ec8101ab 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -244,6 +244,24 @@ static int neon_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
+static bool arm_d32dis(CPUARMState *env, int cur_el)
+{
+    bool cpacr_d32dis = FIELD_EX64(env->cp15.cpacr_el1, CPACR, D32DIS);
+
+    if (!arm_feature(env, ARM_FEATURE_D32DIS)) {
+        return false;
+    }
+
+    /* If NSACR.NSD32DIS is set, CPACR.D32DIS acts as 1 in NonSecure */
+    if ((arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+         cur_el <= 2 && !arm_is_secure_below_el3(env))) {
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSD32DIS)) {
+            cpacr_d32dis = true;
+        }
+    }
+    return cpacr_d32dis;
+}
+
 static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -291,6 +309,8 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
 
     DP_TBFLAG_A32(flags, NEONEXC_EL, neon_exception_el(env, el));
 
+    DP_TBFLAG_A32(flags, D32DIS, arm_d32dis(env, el));
+
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index a8d470ec49c..0a87a0165bd 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -210,8 +210,7 @@ static void gen_update_fp_context(DisasContext *s)
 /*
  * Return true if a VFP insn is OK to access the registers indicated
  * by regmask, false if it should UNDEF. This checks whether the
- * D16-D31 regs are implemented by the CPU. Eventually we will also check
- * CPACR.D32DIS.
+ * D16-D31 regs are implemented by the CPU and not disabled by CPACR.D32DIS.
  * Note that Neon insns accessing D16..D31 do not need to check D32DIS,
  * so this function is for VFP insns only.
  *
@@ -219,9 +218,7 @@ static void gen_update_fp_context(DisasContext *s)
  */
 static bool vfp_dregs_ok(DisasContext *s, int dregmask)
 {
-    int invalid_dreg_mask = dc_isar_feature(aa32_simd_r32, s) ? 0 : 0x10;
-
-    return !(dregmask & invalid_dreg_mask);
+    return !(dregmask & s->invalid_vfp_dreg_mask);
 }
 
 /*
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7306a1389cc..90eb6f30058 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6342,6 +6342,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ARMCPU *cpu = env_archcpu(env);
     CPUARMTBFlags tb_flags = arm_tbflags_from_tb(dc->base.tb);
     uint32_t condexec, core_mmu_idx;
+    bool d32dis = false;
 
     dc->isar = &cpu->isar;
     dc->condjmp = 0;
@@ -6404,7 +6405,12 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
         dc->neon_excp_el = EX_TBFLAG_A32(tb_flags, NEONEXC_EL);
+        d32dis = EX_TBFLAG_A32(tb_flags, D32DIS);
     }
+
+    dc->invalid_vfp_dreg_mask =
+        (d32dis || !dc_isar_feature(aa32_simd_r32, dc)) ? 0x10 : 0;
+
     dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index cce84f29c46..b08bded3981 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -94,6 +94,7 @@ typedef struct DisasContext {
     int max_svl;     /* maximum implemented streaming vector length */
     int max_any_vl;  /* maximum implemented vector length */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
+    int invalid_vfp_dreg_mask; /* mask for whether VFP D16..D31 should UNDEF */
     int vec_len;
     int vec_stride;
     bool v7m_handler_mode;
-- 
2.43.0


