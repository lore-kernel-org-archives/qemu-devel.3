Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E53CC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0u-0000EX-R3; Fri, 21 Aug 2026 07:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0t-000078-HW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0r-0007RY-2O
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so6243415e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310135; x=1787914935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=smnV1wjK+FUh9d+GL27blggvLZu2iZmcr7IWs4JiVv8=;
 b=ebHqXLOkqZzw/Q+/N6dpyrdHw5MSqy2lPpvQyOx0baWw+ouF44RvlcZgnMeia75e6C
 FLz9HZNiuXV3l8a2es0PBQ1to6nnekyZBR0HcnhgTrWUHV9hGMe8Hoeufk3Njt5j3tTV
 rsHYbe4A59/eb7FK7IwABhQHFzJds6fxMRrlQpRMyNQYAtSU2S5DFSIKmEOXdLfvkd0A
 GfJDtqb5YQ8IZoGHo89DCk8QXcpxh1KxIOw4oXWaLLrddjNnxC6McwfSGmSZNCYhIFPa
 UXNKafqouK/aRWLpuG353kOP15pSQLMUqfC7/wx21i0Na64vQqI2Q5L8daPBDGPJ33y9
 Caeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310135; x=1787914935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=smnV1wjK+FUh9d+GL27blggvLZu2iZmcr7IWs4JiVv8=;
 b=PjGsMjn/aAk5VxPDhqbMwLBc20FRC9mrWLmQENSroOOBpy/K24BMeyjKkbZPJ1tRE9
 KLS4StMPk+rSDRy8OmTxFBODC0EaA2EULcI36mDIEqVVlhWMGU4FJ+6C1d/y79gaCbTd
 TD4oy868D/Ory6sw9TUbO5yfnnFF/tU/6mTdCMUTkYj1oE09gZYNtFFGufZ3TbWa9QOV
 yP/f18mWMOTEcZKo6CZ/39vk9b4yLFKg4jX0Hyjxt9vk5d9Cnd8DB76r8NliaRndyio8
 NTKQJki6AfzCaGTp+IqXS4yXH/uz2uQF3Ufvbx+2EckjYcl/XHJWUgEX6Q8fUGQyynQp
 yL8w==
X-Gm-Message-State: AOJu0Ywerl/BU4GBgS51pwxEPd5t3RWJ7ir5qdqZqYTGHwdu/Zq4UWll
 E+B+8R26hsihi7Rc0RcBf05DRnN6yLhmiW1U4julRlo4HX3VjiPq/LIAzfqJzdY952qJFrUi7lO
 cdVND
X-Gm-Gg: AR+sD12IRfsu6oiLKjM5IpLEBl9ir57weBRQnG25kG7a0kENDmyACNSXOFfo/7nVw4Y
 OHMGQVHwHyLTTkOqD3lJY7gC5lWgOUswhbak4LrpdTxRO723tG0JHsXYPYgz9cYarYEG9BeERbw
 VwzMAc8VBzc0MQEWzo0MvZUPWIqaWlLCrUfMGY2ZsWzYypc2E8b+DJVHYHaD6EcMnWqjrDz9Rpl
 6UZcvP3Vww5t5xhz+FFqVSe+nBwLzWHLy4HwfTIrjUGAEATA18YGvdVG2HzslZjL9Xmp4sWp9wA
 44QMMgUWCYrvtl095XeMw051k+USG04LAh97quM+DsDBMzmfept778qcj5d8f1uLnppeI6R2ICT
 fQj+dPyRbo+h0330dTY356cqhvstDZ/kihhbd0IUgVQAlclkJjeTZPAllVQs++8b8gBZN/V0jWd
 mNfWo40UVZUkVjl9EnDc3cgmd6CqpQb+P4hJUrzFvJOl2E3S9eP1qGqjl4VAQkhisvsqW3x78KW
 29AlLril2/HZlUhgpzCsD6qfOQVJHhC+7Z733ZzbXsUZ4OP3lMywmHQiINEsRquSTV8uQ==
X-Received: by 2002:a05:600c:4744:b0:499:93b3:91ea with SMTP id
 5b1f17b1804b1-499b831c0b1mr72898275e9.15.1787310135333; 
 Fri, 21 Aug 2026 04:02:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/43] target/arm: Add new feature ARM_FEATURE_NEON_TRAPS
Date: Fri, 21 Aug 2026 12:00:37 +0100
Message-ID: <20260821110101.3971391-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The traps configurable via CPACR.ASEDIS and HCPTR.TASE that trap only
Neon instructions are unfortunately IMPDEF about whether they are
implemented or not, and there is no ID register field that identifies
whether they are present.  In practice, they are present on every
implementation I have checked except for the Cortex-A8 (which was the
first CPU with Neon).

Add a new feature ARM_FEATURE_NEON_TRAPS which we set on every
ARM_FEATURE_NEON CPU except the Cortex-A8, and make the CPACR.ASEDIS
and HCPTR.TASE bits RAZ/WI unless the CPU has ARM_FEATURE_NEON and
ARM_FEATURE_NEON_TRAPS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-5-peter.maydell@linaro.org
---
 target/arm/cpu-max.c   |  1 +
 target/arm/cpu.h       |  7 +++++++
 target/arm/cpu64.c     |  1 +
 target/arm/helper.c    | 17 +++++++++++++++--
 target/arm/tcg/cpu32.c |  8 ++++++++
 target/arm/tcg/cpu64.c | 10 ++++++++++
 6 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 8d968336a8b..4df52bcb08e 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -23,6 +23,7 @@ void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     if (aarch64_enabled) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c0492c8dfbc..4f07332543d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2177,6 +2177,13 @@ enum arm_features {
      * CPU types added in future.
      */
     ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
+    /*
+     * ARM_FEATURE_NEON_TRAPS should be set if the CPU implements the
+     * CPACR.ASEDIS and HCPTR.TASE bits for trapping A32 Neon.  This
+     * is architecturally IMPDEF, but seems to be implemented by all
+     * ARM_FEATURE_NEON CPUs except the Cortex-A8.
+     */
+    ARM_FEATURE_NEON_TRAPS,
 };
 
 static inline int arm_feature(const CPUARMState *env, int feature)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index faaf3ab879d..4e8c4725308 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -699,6 +699,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a53";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7de38d82010..2dfbeae0efd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -573,14 +573,20 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          */
         if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
             /* VFP coprocessor: cp10 & cp11 [23:20] */
-            mask |= R_CPACR_ASEDIS_MASK |
-                    R_CPACR_D32DIS_MASK |
+            mask |= R_CPACR_D32DIS_MASK |
                     R_CPACR_CP11_MASK |
                     R_CPACR_CP10_MASK;
 
             if (!arm_feature(env, ARM_FEATURE_NEON)) {
                 /* ASEDIS [31] bit is RAO/WI */
                 value |= R_CPACR_ASEDIS_MASK;
+                mask |= R_CPACR_ASEDIS_MASK;
+            } else if (arm_feature(env, ARM_FEATURE_NEON_TRAPS)) {
+                /*
+                 * bit is present unless CPU doesn't implement ASEDIS
+                 * (in which case it is RAZ/WI; this is the Cortex-A8)
+                 */
+                mask |= R_CPACR_ASEDIS_MASK;
             }
 
             /*
@@ -4124,6 +4130,13 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
 static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    if (!arm_feature(env, ARM_FEATURE_NEON_TRAPS)) {
+        /*
+         * If CPU doesn't implement HCPTR.TASE it's RAZ/WI.  Note that
+         * NSACR.NSASEDIS being 1 overrides this.
+         */
+        value &= ~R_HCPTR_TASE_MASK;
+    }
     /*
      * For A-profile AArch32 EL3, if NSACR.CP10
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index d5dd2361528..724a9549347 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -251,6 +251,10 @@ static void cortex_a8_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a8";
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    /*
+     * The Cortex-A8 doesn't have CPACR.ASEDIS and HCPTR.TASE,
+     * so don't set ARM_FEATURE_NEON_TRAPS.
+     */
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -321,6 +325,7 @@ static void cortex_a9_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a9";
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
@@ -389,6 +394,7 @@ static void cortex_a7_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a7";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
@@ -439,6 +445,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a15";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
@@ -634,6 +641,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 9ce514dda81..b38c61ba623 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -37,6 +37,7 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a35";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -208,6 +209,7 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a55";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -281,6 +283,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a72";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -341,6 +344,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a76";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -415,6 +419,7 @@ static void aarch64_a78ae_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a78ae";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -488,6 +493,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->dtb_compatible = "arm,a64fx";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -662,6 +668,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->dtb_compatible = "arm,neoverse-n1";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -738,6 +745,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->dtb_compatible = "arm,neoverse-v1";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -965,6 +973,7 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a710";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -1067,6 +1076,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->dtb_compatible = "arm,neoverse-n2";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-- 
2.43.0


