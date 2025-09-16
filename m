Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFB6CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4v-00039F-NC; Tue, 16 Sep 2025 14:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4a-00037H-NF
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4Y-0001c5-Ll
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45f2313dd86so39834285e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045993; x=1758650793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aFlwhTu+WV4Da4c9Ts1Xd5fh6JlTMno61ShmjJipyoQ=;
 b=h+OYDVposlNtv2cp2hb+qGbqGv+G05AJ1e5MZKIjbC5TBwKuJPjeDfuRuhh8GJRJo6
 eLWNz6CXoSii7DKCLwbB/lUY9llQOZ94K2u4c/i25Yen7VkcJDuXG1b++3NLf8vUCtTC
 0lsUZ8ilyLddqTOnM74HkWGjxiO9SXlmSqMzDsOqbqCdHaGkzKPRhc6a/S1qNNL804m2
 OuFvXboqq6VQNIU43X+iHcwX264H3PbOwry7P/8Ce/IT5Qe5jNof60wTEb2I2kpLwPxP
 qEgrkTiaJgJZCo42PBcx8HaLjhLpWRPevvnvtrlUdJqlLcE5NLl5niQK+ilHvvq3Zjkr
 Em4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045993; x=1758650793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFlwhTu+WV4Da4c9Ts1Xd5fh6JlTMno61ShmjJipyoQ=;
 b=RdM9LLrstGEU1bRStR6Nu6fT1jGsNdAuvgbNLvwAEdCyOJDJ9ZXxWnLKKHjx4seMTJ
 mM8BlkOEyyuMc/2/ONzir7A7BhXOfjALQsobIYwcSatVgMmC6y1bnCleQTS4epQHraHy
 whjA/zOHedJl+SESClfUqiRBZWUcMbNM/+VQFhwdcfpOr/79dYzxXoSkBGU+WIPquyKP
 Mc14CKMhYh+TjtAlg+64o9MgbS+nCvhZoYNt4musylkHhVugcx/ZqCmRiKqWtDWogWa1
 Lm7Ge8fLOF509p7iUz62BO8robpJZrAs0kjx99TsP7WRICyI0xBx9VNVSip5N/mhVg27
 9aFw==
X-Gm-Message-State: AOJu0YxHzJpbjoiezHMSc+JSFLop4/Y8C6zeK0n++AdS7C4LGo3kwwIR
 qX4mRpq1Svzx4hvLJg6W/RBx25XVlGs47gakIGfR5CliU3sPbGm5GaGJGo1rfdrF8WylhRyw5aJ
 0tdQj
X-Gm-Gg: ASbGncueXiPmD7PSAhQFwMLqYKbtYSfevCXjTi/mJkJE9kKAUfjHykCjxOAKa5UOAHx
 3AYvptmjMtUPutl28TVGN2rdyjBzh/b7G7dt+GLgZKsULlt6a3iX7ybio/XkBKZoLbEbCl+5yTa
 5zQZK+2+t82v3/SonI8GlEy4tjOQ8VWsSLkpvkAmqpyOBaWyXVbJiOQ5ppWC2HfNx2xtCzunTBr
 cIHgnX8jB7ZiPK3opinPJD1SeFlnGOhlAnOekA9RRcVJlpbqtsoMIgRQKFZuphbvJsFanoPb+ug
 VBgkvgOfPPk7R0OCVQYbeGGgDEodnmflBhMunW7fV6BZLltRMo3uZ9BHFMOHhujUjCdbEqGtjbK
 BR5VI5RViem5AfPAxR9iZrcZfCUx4Xi4Pgmp0ouM=
X-Google-Smtp-Source: AGHT+IHOWsltYzx1lUTIYdfLU50A6gHqAmdVVR6zCWJ9DYXtd7JfST6SZsn9WF5xE0fyYp7l4bG9yA==
X-Received: by 2002:a05:600c:19c9:b0:45d:d50d:c0db with SMTP id
 5b1f17b1804b1-45f211dac1emr152370385e9.15.1758045993116; 
 Tue, 16 Sep 2025 11:06:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/36] target/arm: Drop ARM_FEATURE_XSCALE handling
Date: Tue, 16 Sep 2025 19:05:52 +0100
Message-ID: <20250916180611.1481266-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

We have now removed all the CPU types which had the Intel XScale
extensions indicated via ARM_FEATURE_XSCALE, so this feature bit
is never set. Remove all the code that can only be reached when
using this flag.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250828140422.3271703-5-peter.maydell@linaro.org
---
 target/arm/cpu.h           |  3 ---
 target/arm/cpu.c           | 13 ---------
 target/arm/helper.c        | 54 --------------------------------------
 target/arm/ptw.c           |  7 +++--
 target/arm/tcg/op_helper.c |  6 -----
 5 files changed, 3 insertions(+), 80 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f56fa6df8dd..92fcb96671e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -341,7 +341,6 @@ typedef struct CPUArchState {
         uint64_t vsctlr; /* Virtualization System control register. */
         uint64_t cpacr_el1; /* Architectural feature access control register */
         uint64_t cptr_el[4];  /* ARMv8 feature trap registers */
-        uint32_t c1_xscaleauxcr; /* XScale auxiliary control register.  */
         uint64_t sder; /* Secure debug enable register. */
         uint32_t nsacr; /* Non-secure access control register. */
         union { /* MMU translation table base 0. */
@@ -513,7 +512,6 @@ typedef struct CPUArchState {
         uint64_t cntvoff_el2; /* Counter Virtual Offset register */
         uint64_t cntpoff_el2; /* Counter Physical Offset register */
         ARMGenericTimer c14_timer[NUM_GTIMERS];
-        uint32_t c15_cpar; /* XScale Coprocessor Access Register */
         uint32_t c15_ticonfig; /* TI925T configuration byte.  */
         uint32_t c15_i_max; /* Maximum D-cache dirty line index.  */
         uint32_t c15_i_min; /* Minimum D-cache dirty line index.  */
@@ -2444,7 +2442,6 @@ QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
  */
 enum arm_features {
     ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
-    ARM_FEATURE_XSCALE, /* Intel XScale extensions.  */
     ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
     ARM_FEATURE_V6,
     ARM_FEATURE_V6K,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d0f6fcdfcea..9781055bdc1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -349,11 +349,6 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     env->uncached_cpsr = ARM_CPU_MODE_USR;
     /* For user mode we must enable access to coprocessors */
     env->vfp.xregs[ARM_VFP_FPEXC] = 1 << 30;
-    if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
-        env->cp15.c15_cpar = 3;
-    } else if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-        env->cp15.c15_cpar = 1;
-    }
 #else
 
     /*
@@ -2259,14 +2254,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 
-    /*
-     * We rely on no XScale CPU having VFP so we can use the same bits in the
-     * TB flags field for VECSTRIDE and XSCALE_CPAR.
-     */
-    assert(arm_feature(env, ARM_FEATURE_AARCH64) ||
-           !cpu_isar_feature(aa32_vfp_simd, cpu) ||
-           !arm_feature(env, ARM_FEATURE_XSCALE));
-
 #ifndef CONFIG_USER_ONLY
     {
         int pagebits;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b641229ba0c..fa8dfac2998 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2923,39 +2923,6 @@ static const ARMCPRegInfo omap_cp_reginfo[] = {
       .type = ARM_CP_CONST | ARM_CP_OVERRIDE, .resetvalue = 0 },
 };
 
-static void xscale_cpar_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                              uint64_t value)
-{
-    env->cp15.c15_cpar = value & 0x3fff;
-}
-
-static const ARMCPRegInfo xscale_cp_reginfo[] = {
-    { .name = "XSCALE_CPAR",
-      .cp = 15, .crn = 15, .crm = 1, .opc1 = 0, .opc2 = 0, .access = PL1_RW,
-      .fieldoffset = offsetof(CPUARMState, cp15.c15_cpar), .resetvalue = 0,
-      .writefn = xscale_cpar_write, },
-    { .name = "XSCALE_AUXCR",
-      .cp = 15, .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 1, .access = PL1_RW,
-      .fieldoffset = offsetof(CPUARMState, cp15.c1_xscaleauxcr),
-      .resetvalue = 0, },
-    /*
-     * XScale specific cache-lockdown: since we have no cache we NOP these
-     * and hope the guest does not really rely on cache behaviour.
-     */
-    { .name = "XSCALE_LOCK_ICACHE_LINE",
-      .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NOP },
-    { .name = "XSCALE_UNLOCK_ICACHE",
-      .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NOP },
-    { .name = "XSCALE_DCACHE_LOCK",
-      .cp = 15, .opc1 = 0, .crn = 9, .crm = 2, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_NOP },
-    { .name = "XSCALE_UNLOCK_DCACHE",
-      .cp = 15, .opc1 = 0, .crn = 9, .crm = 2, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NOP },
-};
-
 static const ARMCPRegInfo dummy_c15_cp_reginfo[] = {
     /*
      * RAZ/WI the whole crn=15 space, when we don't have a more specific
@@ -3346,16 +3313,6 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* This may enable/disable the MMU, so do a TLB flush.  */
     tlb_flush(CPU(cpu));
-
-    if (tcg_enabled() && ri->type & ARM_CP_SUPPRESS_TB_END) {
-        /*
-         * Normally we would always end the TB on an SCTLR write; see the
-         * comment in ARMCPRegInfo sctlr initialization below for why Xscale
-         * is special.  Setting ARM_CP_SUPPRESS_TB_END also stops the rebuild
-         * of hflags from the translator, so do it here.
-         */
-        arm_rebuild_hflags(env);
-    }
 }
 
 static void mdcr_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6894,9 +6851,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_STRONGARM)) {
         define_arm_cp_regs(cpu, strongarm_cp_reginfo);
     }
-    if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-        define_arm_cp_regs(cpu, xscale_cp_reginfo);
-    }
     if (arm_feature(env, ARM_FEATURE_DUMMY_C15_REGS)) {
         define_arm_cp_regs(cpu, dummy_c15_cp_reginfo);
     }
@@ -7245,14 +7199,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .writefn = sctlr_write, .resetvalue = cpu->reset_sctlr,
             .raw_writefn = raw_write,
         };
-        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-            /*
-             * Normally we would always end the TB on an SCTLR write, but Linux
-             * arch/arm/mach-pxa/sleep.S expects two instructions following
-             * an MMU enable to execute from cache.  Imitate this behaviour.
-             */
-            sctlr.type |= ARM_CP_SUPPRESS_TB_END;
-        }
         define_one_arm_cp_reg(cpu, &sctlr);
 
         if (arm_feature(env, ARM_FEATURE_PMSA) &&
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 089eeff845c..6344971fa64 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1074,11 +1074,10 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
             ap = (desc >> (4 + ((address >> 9) & 6))) & 3;
             result->f.lg_page_size = 12;
             break;
-        case 3: /* 1k page, or ARMv6/XScale "extended small (4k) page" */
+        case 3: /* 1k page, or ARMv6 "extended small (4k) page" */
             if (type == 1) {
-                /* ARMv6/XScale extended small page format */
-                if (arm_feature(env, ARM_FEATURE_XSCALE)
-                    || arm_feature(env, ARM_FEATURE_V6)) {
+                /* ARMv6 extended small page format */
+                if (arm_feature(env, ARM_FEATURE_V6)) {
                     phys_addr = (desc & 0xfffff000) | (address & 0xfff);
                     result->f.lg_page_size = 12;
                 } else {
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 575e566280b..5373e0e998c 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -768,12 +768,6 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
 
     assert(ri != NULL);
 
-    if (arm_feature(env, ARM_FEATURE_XSCALE) && ri->cp < 14
-        && extract32(env->cp15.c15_cpar, ri->cp, 1) == 0) {
-        res = CP_ACCESS_UNDEFINED;
-        goto fail;
-    }
-
     if (ri->accessfn) {
         res = ri->accessfn(env, ri, isread);
     }
-- 
2.43.0


