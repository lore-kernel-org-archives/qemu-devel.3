Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74704CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBS-0002Tg-2g; Thu, 28 Aug 2025 13:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdEz-0003r3-5q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:04:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdEu-0002th-9V
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:04:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3c84925055aso764522f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756389870; x=1756994670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fugM9PHy2tclelvvYQOdAG0IRRSDsWvkqc8Uh7CBDc8=;
 b=FOqhcx57qaHpJWU+CGihKfigV+0CRpG4ItIIja2nJjLAVfFz1tc5AoQ79hwdxpL4jy
 FBievLgySGCuPBcB6FEyvS7KxDtuLAzmAoLvyuqJBNt5rI4+6TY4/0Ow7TB9mTJUq7/L
 UjaAtXG8S+0cSp9BYi8BmSR/JHSmkGxcqicZrPGwfXnM+kM5N97Dld3GleZWNJCkmMkQ
 GXrHaKxWsiG/+uxloyNLoO0kayvEVkIveb8Iji5zYT7eAISOK30nq2DWv59GGAzSvXG1
 9FRU0upEGDNRHgK1Hwje/fsYJ2gQDEVvYtKsH/M39TAUBsaZBXRCZSQz8lOU6E4+NwpI
 iUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756389870; x=1756994670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fugM9PHy2tclelvvYQOdAG0IRRSDsWvkqc8Uh7CBDc8=;
 b=mggHkOJ8iXUQeNJllRUZ0dL3u9wIyzs63m1czci2qH7yOzuUs9AT4JWWQ1Sl/2yF8s
 Hy0CcOL3nz9X/KpLGVRix018Pvos7U7VQtBfxLmwcXD0d/IKO6o5bx94MgrWkt6/yp5g
 /2U8twzZ96uKvDzVkb1kHMelui3N9MSaNTiem0BzCTfVOzM2ZM4sZyVNQl+UotZ71y9V
 bGE1H1sUwNcvTxMEFQUDzVZznnQsdxrTneGwIXggKzuZxgE2kq8OiiShZaecEq6rlnbk
 xboz8eCqD0TCb7tFKPhl+8ZUAtAn56zvhOpqeKaaiarsrrkGfxBJtzZ1QDPOTfvAviKL
 A+sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNaVWmi/L6vcTEnLpCQdadCJJcVPpyeF1SP57lyFJgTWJWf7TlN9vIbz3k9SUvsx5hudbhnmGUyvm7@nongnu.org
X-Gm-Message-State: AOJu0Yy26SYpEFLt++tkNImUraK2sw1uHkw52Fwfi0BVSSgZ7VSNPnBB
 wLRpyePlByW2aHkZRXLlGRXb/spMoYGTZZobWyMS9KUIBhMe/q2nMkdj/RO+ByYa/CM=
X-Gm-Gg: ASbGncvcvaxYy9f68JKVAQdi1f6l2M1IhR6/Y/vj5Zo1S4hRRM4s7OO/TU2PvjYOtzv
 TgsXR2qgcZ6ayt/Tx2gtTa7hsLEfbv0sKErRa2/TbzNdtVRBb8OKf/KIHT47lPLvpwrBE6QD3u+
 xS+tXwtK7OHxiGFLjYyOd+bAfVWF89SQ12q0/W2pE0U0p8DtnVOBR+CVcDiVG6R3htfcfo0KTba
 qBlCKAfzNVm3FLpiKYy6FVIIiOMpY0WzckE7f9FdaiCLw9ixIXRpjgoPQb0IlDiz2j+jBkDMWk4
 Ypp0DeKj8R8WYWZEX0SsFrlZx7XZ4rGgMUha8jYfNGZbXMZ3VK6rAb1UpsqMtoMIh4XNdtZeAPv
 CGkJwiub8GzJG5Lw/7GbUNzSk2TqkijJOvARxJJM=
X-Google-Smtp-Source: AGHT+IH7E+ywXeCVND5fc2Q87QhfOnCVshrj6Px4I2XmLpRupFCVcId7dN352tcHgOZud6lAKghT2g==
X-Received: by 2002:a5d:4392:0:b0:3cc:3d4b:7fb1 with SMTP id
 ffacd0b85a97d-3cc3d4b813emr4256767f8f.49.1756389870134; 
 Thu, 28 Aug 2025 07:04:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cce1724939sm6947712f8f.26.2025.08.28.07.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:04:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/arm: Drop ARM_FEATURE_XSCALE handling
Date: Thu, 28 Aug 2025 15:04:21 +0100
Message-ID: <20250828140422.3271703-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828140422.3271703-1-peter.maydell@linaro.org>
References: <20250828140422.3271703-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

We have now removed all the CPU types which had the Intel XScale
extensions indicated via ARM_FEATURE_XSCALE, so this feature bit
is never set. Remove all the code that can only be reached when
using this flag.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  3 ---
 target/arm/cpu.c           | 13 ---------
 target/arm/helper.c        | 54 --------------------------------------
 target/arm/ptw.c           |  7 +++--
 target/arm/tcg/op_helper.c |  6 -----
 5 files changed, 3 insertions(+), 80 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d6e8e99f191..0cfe23c1238 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -340,7 +340,6 @@ typedef struct CPUArchState {
         uint64_t vsctlr; /* Virtualization System control register. */
         uint64_t cpacr_el1; /* Architectural feature access control register */
         uint64_t cptr_el[4];  /* ARMv8 feature trap registers */
-        uint32_t c1_xscaleauxcr; /* XScale auxiliary control register.  */
         uint64_t sder; /* Secure debug enable register. */
         uint32_t nsacr; /* Non-secure access control register. */
         union { /* MMU translation table base 0. */
@@ -511,7 +510,6 @@ typedef struct CPUArchState {
         uint64_t cntvoff_el2; /* Counter Virtual Offset register */
         uint64_t cntpoff_el2; /* Counter Physical Offset register */
         ARMGenericTimer c14_timer[NUM_GTIMERS];
-        uint32_t c15_cpar; /* XScale Coprocessor Access Register */
         uint32_t c15_ticonfig; /* TI925T configuration byte.  */
         uint32_t c15_i_max; /* Maximum D-cache dirty line index.  */
         uint32_t c15_i_min; /* Minimum D-cache dirty line index.  */
@@ -2427,7 +2425,6 @@ QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
  */
 enum arm_features {
     ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
-    ARM_FEATURE_XSCALE, /* Intel XScale extensions.  */
     ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
     ARM_FEATURE_V6,
     ARM_FEATURE_V6K,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399c..ad39b216a44 100644
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
@@ -2253,14 +2248,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
index 0c1299ff841..746eb1d51ef 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2917,39 +2917,6 @@ static const ARMCPRegInfo omap_cp_reginfo[] = {
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
@@ -3340,16 +3307,6 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
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
@@ -6753,9 +6710,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_STRONGARM)) {
         define_arm_cp_regs(cpu, strongarm_cp_reginfo);
     }
-    if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-        define_arm_cp_regs(cpu, xscale_cp_reginfo);
-    }
     if (arm_feature(env, ARM_FEATURE_DUMMY_C15_REGS)) {
         define_arm_cp_regs(cpu, dummy_c15_cp_reginfo);
     }
@@ -7104,14 +7058,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
index 561bf2678e5..440daffff60 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1061,11 +1061,10 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
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


