Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAC5C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwcM-0003h7-4m; Mon, 17 Aug 2026 08:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwcC-0003f9-Ua
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc9-0001Fo-25
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so17329775e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 05:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786970330; x=1787575130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UC2VfuEnRS7vtJW9dbldA5VEOCwlt4wt3TaapGzwBc4=;
 b=YokIhS9DtdCmcY6bryit+VuptWJzynB0nASNCA+7XOGO3NEuqYL4SI+T3L8SMcz359
 peHRT26Z97bB/gwas/Rgb47/BMhQrRykLVCtnEcemCKM1HbN9zIZKQZRXGbEseFK/R2n
 VjcfSvsjVn3GEBQvNjdhbN0i2c8XmPu6Bm4apVzGN/wfKMgogRwuLWgJmxL15KYJqQOT
 791JRm+n9FDNakCxUa++OMOxt1dTNLxfea1sPRBaKTVywunUVdfD413ad8ZVM9y43D7q
 EYHAE9wrgdf9P13aO8SdJwhhhM/UyJ+VxDeRFHvXSPkn+N6SfgKIM+PSHkOKHStutMaS
 WD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970330; x=1787575130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UC2VfuEnRS7vtJW9dbldA5VEOCwlt4wt3TaapGzwBc4=;
 b=j/RmoVrjsZfjmeMOgA8jutV4/umHDyUbmKxEiIFV8ALuh5vwuCjPDpd8bjksDT9PQ2
 gcekbwn6XgKbpHBtzvOWpa/f8CiJ0Atf0gHYp69ODzMEmDH1jPrXuhR4/a7mKV/7ksK0
 6d6lps7PZJYlLAMyybIniOsVsXClS7fwu2JJl9Z3SBaUj925OBmcCQVs2Oay0piZksZ6
 WWcGhs/vlHi0Ibqt2PtEy4x9rHGUA2xby5q3Qh9fMuDhTLcgXn7YoOgYGz0Yf/v4MsFg
 CJi3nopJA9fL92wjhviwidU5JHaPaQOXBerhfqV740KXzS7EbjUAS4c27sc6wvzTRH4Z
 pg9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rptu7qy5U35HXO/FjvE6MVs/Z/isK6Mic6O4PORrBk3foFUiHv61mhVmHQRktoQiXAMuWX3xxRhZ7X9@nongnu.org
X-Gm-Message-State: AOJu0YzXu7IxDtLaRUTn+vpgyM+6qhJk/X5rxmp/KupvKPcI4Sopz/E3
 Y/K7Z9p0WxKLmJvFHVIzqiO3iVaZoLoqTaKsiAI9jzVXnVwKKzO9PSfdeRJsS6aUwpBszRwlLzq
 ufiGA
X-Gm-Gg: AR+sD13UjGdMWtTZ9pAAl5PJqa+6GxQQ3ILe99TQAMxYOiKCLu04qQNzybHDFQBwLKD
 AUTNbDjT+6R7JkNat9W2pGZDyqUpv7HXjoBKB/KhRtJ4/O+Xg5Gd8Ny9bz43xgIN7U4tATLI2FT
 6+qtaXq6kuZlHaxLL+FIwHsiq1eDbq5RTvjkkvYVRtOY1QkmrgCt97hZbPjSSDo1ccYDgwWEuuU
 NPwlIf2gYAV7wX6k2QSr0ugHKfMhYngCDcCUr30+1qXDaEcm2Q42k3ecZIsgU3KUacQaYDuEcHT
 kNkFfq27hQejskATLOOc7X+ULe89v/lEoS+ZORi3g0BbX6I7yDYG7tM5K+SX2dOT66djwJi3m/6
 niMwrajChtccMcF2s59eXd2hJxZG0QRRSyvbO2Gyw2cUOIw0EV7hgqe00Y/5IKfyJjqZA4uAPS9
 OADow6an1pcFibaMqpoWgFPkf8DwZPDg1MgSrnqmFmmTwo5eN/UCrQFlQO/9aMFWAm6eu/XYTbF
 YRYkOT2/XQaNmBo6w0Apg+TrrsmTOMkYey1M/aJ0w/R9fs3DK4ToS0cUCD5ROe3Ziwyiw==
X-Received: by 2002:a7b:c3c4:0:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-4998793bdf2mr290478965e9.7.1786970329632; 
 Mon, 17 Aug 2026 05:38:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998780397dsm120415055e9.3.2026.08.17.05.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:38:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 7/8] target/arm: Implement CPACR.D32DIS
Date: Mon, 17 Aug 2026 13:38:37 +0100
Message-ID: <20260817123838.1578060-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817123838.1578060-1-peter.maydell@linaro.org>
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
 target/arm/tcg/cpu32.c         |  2 ++
 target/arm/tcg/hflags.c        | 20 ++++++++++++++++++++
 target/arm/tcg/translate-vfp.c |  7 ++-----
 target/arm/tcg/translate.c     |  6 ++++++
 target/arm/tcg/translate.h     |  1 +
 7 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index afc3fda3b8..e8dfc3179f 100644
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
index 6f33b1ef5e..3aaeb2dd02 100644
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
index 3df3ca38d6..34436ad6ec 100644
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
index 14824e3dff..296ec8101a 100644
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
index a8d470ec49..0a87a0165b 100644
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
index ebd917f16c..1bf9d61035 100644
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
index cce84f29c4..b08bded398 100644
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


