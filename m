Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64155C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLK-0007Je-GQ; Thu, 02 Jul 2026 14:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLG-0007Aq-0p
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:55 -0400
Received: from mail-wm2-x02.google.com ([2a00:1450:4864:31::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLB-0005Nz-Cn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:53 -0400
Received: by mail-wm2-x02.google.com with SMTP id
 5b1f17b1804b1-492367e8e16so4812095e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017631; x=1783622431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IxkLPpkuWBFt0maPO+rccTHi+xaiiG0f49ZbbzbsrTg=;
 b=EVbnb+uNaBnZBKPVLxECXHShJZLPwUwdjIo+IYL7HYNgFOU7rSXmYxeNmP7ZJOBKCG
 jVHZrLYhbIHs7J6+YVitQ003R0FGzo+YbHsO8XYz+M+xwS8WIaIubHH8yw4fEUwirP5u
 /w/rfHniri4Bzco/F13EFKX7m8Md+iU0jDPGl9FQ+8V+4sXXtloRKCqK/5Yhj+73CHrv
 DRb5RA5Q5fGKf7UQADAzB2+Fox1J4G23avFlbL6kuHM/nEypo94mLe86e+CH6XLeQxPT
 sreOl4mtlXsWDqkki6alL10kPA1x/4Ukdxkbfihc+oWlc1NlzWhnkhYc7gqM3IxO7nnZ
 njTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017631; x=1783622431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IxkLPpkuWBFt0maPO+rccTHi+xaiiG0f49ZbbzbsrTg=;
 b=scWqPhD6M7b+8bt4saPB5d/u3uCgbZyTzS+xNwVZDknLi2VQphrK+dXU1rpQ8c0/gY
 vUvi7T1BXXVzRgukes5Lz2G2mleAg5f2fQTfuI2bLM6g9kHLuIvA8bNdq0Cdtszguleo
 XdNdERE70pJt9VgAybscHqbBxpOGQOpTr981gybXm/4zFnt6aZWyBPin6FlUqjTn98tx
 lBC6DkZY0vyXTCHOALBDqCCcWyG2hYkxPQFnWsz8z5lJ8l2RKmfgY/YKPaKERcCN665Z
 yNSiBq3+DDoDy0Jfbp5DPqYK/1yFr6KIfO6Esik36uG7MclBkiIYQ2K9bqIyhXlNgO/D
 x5wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xmgkyix6s+AKx9uyGaxdmc6bmyicJX2DVU0ARkOLEEi3uMS/rprSNkW46WHTefsasxUffkPDb9mCY@nongnu.org
X-Gm-Message-State: AOJu0YyuU8DxSoMVtyvZax7pP0X87vlFwlNcNUfveqf9jaLPGInrJiSY
 8Rw72fkAIZDGNAhPyqZu5Qpf9wbqcmYbzpoxCs+DeWh0ADq2UyC/BfN80kOB6H7KMnXU6QHT8Hl
 fYhbMdeTkTf5e
X-Gm-Gg: AfdE7cm1nKaYuaUWOEx3Kvyq1XhtPRWVSUtikyUKQQqS92HTBWd0QtVE/EUORzBnMtJ
 N62xSk6S3x7psV7WcKFVUD3xXINwupWqNtRQGUBdYe+Nj15u1CEDziRAMN64QLav1Hr7D9laKuv
 dhRSy7ALqHnk1rrOrAoqbQy3+Ih7VWaxfKNN55FSpiby1VV4jKz5JF/H9TeMm3VcpfX7oEhllqG
 mM/2S/00H5lasoQ7BdkuNKuNbfMAyqBFzb/dU52pDJHuakRCz7Lr70RW83T4LI4Yd5IfjP+RnC7
 Yiw1a/qRjPhvhAHCWAyiHERDbH82rm5ON09f1uniAc5494iMPE9/6QsrLyxFI6gpLSIZHqqxoyT
 wd6rRsMlIz6C3v/ZlH5QdXEECkHC69anXNbhpqhwtLHK+PxytaD2cWxWbyC2Q4AEGA0fwEPXLgj
 qYBHyYof5GdMZo885GOVhfJP+Ip5P7vO7g3PAa7Qh+iIi7nc21IaIM1oLNPul0zLz2c/t1OiSMD
 LjCAkdANiCDuV2ZsqPTyw==
X-Received: by 2002:a05:600c:ac1:b0:492:490b:a604 with SMTP id
 5b1f17b1804b1-493c3df67c9mr61688505e9.37.1783017631078; 
 Thu, 02 Jul 2026 11:40:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/11] target/arm: Implement CPACR.D32DIS
Date: Thu,  2 Jul 2026 19:40:19 +0100
Message-ID: <20260702184019.3431139-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::2;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x02.google.com
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
---
 target/arm/cpu.h               |  4 ++++
 target/arm/helper.c            | 19 ++++++++++++++++---
 target/arm/tcg/cpu32-system.c  |  2 ++
 target/arm/tcg/hflags.c        | 20 ++++++++++++++++++++
 target/arm/tcg/translate-vfp.c |  4 ++--
 target/arm/tcg/translate.c     |  1 +
 target/arm/tcg/translate.h     |  1 +
 7 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1741f8e829..8477a376ad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2177,6 +2177,8 @@ enum arm_features {
      * Neon but not VFP. This seems to be true only for Cortex-A8.
      */
     ARM_FEATURE_NO_NEON_TRAPS,
+    /* Does the CPU implement CPACR.D32DIS ? */
+    ARM_FEATURE_D32DIS,
 };
 
 static inline int arm_feature(const CPUARMState *env, int feature)
@@ -2505,6 +2507,8 @@ FIELD(TBFLAG_A32, SME_TRAP_NONSTREAMING, 11, 1)
  * take precedence.
  */
 FIELD(TBFLAG_A32, NEONEXC_EL, 12, 2)
+/* Should VFP insns touching D16..D31 UNDEF? (CPACR.D32DIS) */
+FIELD(TBFLAG_A32, D32DIS, 14, 1)
 
 /*
  * Bit usage when in AArch32 state, for M-profile only.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ff7aa9c87..97467bc9d3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -570,8 +570,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          */
         if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
             /* VFP coprocessor: cp10 & cp11 [23:20] */
-            mask |= R_CPACR_D32DIS_MASK |
-                    R_CPACR_CP11_MASK |
+            mask |= R_CPACR_CP11_MASK |
                     R_CPACR_CP10_MASK;
 
             if (!arm_feature(env, ARM_FEATURE_NEON)) {
@@ -593,6 +592,13 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -602,7 +608,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
      * Similarly, if NSACR.NSASEDIS is 1 then CPACR.ASEDIS ignores writes
-     * and reads as 1.
+     * and reads as 1, and NSACR.NSD32DIS makes CPACR.D32DIS behave as RAO/WI.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
         !arm_is_secure(env)) {
@@ -614,6 +620,10 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
             mask = R_CPACR_ASEDIS_MASK;
             value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
         }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSD32DIS)) {
+            mask = R_CPACR_D32DIS_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
     }
 
     env->cp15.cpacr_el1 = value;
@@ -636,6 +646,9 @@ static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
             value |= R_CPACR_ASEDIS_MASK;
         }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSD32DIS)) {
+            value |= R_CPACR_D32DIS_MASK;
+        }
     }
     return value;
 }
diff --git a/target/arm/tcg/cpu32-system.c b/target/arm/tcg/cpu32-system.c
index b7aebd05d0..5507967075 100644
--- a/target/arm/tcg/cpu32-system.c
+++ b/target/arm/tcg/cpu32-system.c
@@ -327,6 +327,7 @@ static void cortex_a9_initfn(Object *obj)
      */
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_CBAR);
+    set_feature(&cpu->env, ARM_FEATURE_D32DIS);
     cpu->midr = 0x410fc090;
     cpu->reset_fpsid = 0x41033090;
     cpu->isar.mvfr0 = 0x11110222;
@@ -393,6 +394,7 @@ static void cortex_a7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
+    set_feature(&cpu->env, ARM_FEATURE_D32DIS);
     cpu->midr = 0x410fc075;
     cpu->reset_fpsid = 0x41023075;
     cpu->isar.mvfr0 = 0x10110222;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index ec1b4d78f5..3a1159a4f0 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -235,6 +235,24 @@ static int neon_exception_el(CPUARMState *env, int cur_el)
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
@@ -282,6 +300,8 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
 
     DP_TBFLAG_A32(flags, NEONEXC_EL, neon_exception_el(env, el));
 
+    DP_TBFLAG_A32(flags, D32DIS, arm_d32dis(env, el));
+
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 3d6c67efb9..bbf489a5a6 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -210,12 +210,12 @@ static void gen_update_fp_context(DisasContext *s)
 /*
  * Return true if a VFP insn is OK to access D16..D31, false if
  * it should UNDEF. This checks whether the D16-D31 regs are
- * implemented by the CPU. Eventually we will also check CPACR.D32DIS.
+ * implemented by the CPU, and whether CPACR.D32DIS permits access.
  * Note that Neon insns accessing D16..D31 do not need to check D32DIS.
  */
 static bool vfp_d16_d31_ok(DisasContext *s)
 {
-    return dc_isar_feature(aa32_simd_r32, s);
+    return dc_isar_feature(aa32_simd_r32, s) && !s->d32dis;
 }
 
 /*
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 587ef09d48..5c567d839e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6376,6 +6376,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
         dc->neon_excp_el = EX_TBFLAG_A32(tb_flags, NEONEXC_EL);
+        dc->d32dis = EX_TBFLAG_A32(tb_flags, D32DIS);
     }
     dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 2eebef76bb..45ad6a3974 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -94,6 +94,7 @@ typedef struct DisasContext {
     int max_svl;     /* maximum implemented streaming vector length */
     int max_any_vl;  /* maximum implemented vector length */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
+    bool d32dis; /* VFP D16-D31 disabled via CPACR.D32DIS */
     int vec_len;
     int vec_stride;
     bool v7m_handler_mode;
-- 
2.43.0


