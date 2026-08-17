Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72EFC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwcA-0003e3-ST; Mon, 17 Aug 2026 08:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc6-0003cz-5L
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc3-0001EZ-V0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:49 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so23696745e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786970326; x=1787575126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=biHckXIZVXmOqgIJA8hHhBtu9umfyOhyxqSHPZkFM3U=;
 b=LhzN220n3eQDOGfOWdJ9dOhyzIhVd0gbamsxQ8ha8/HiM7kawe8ISQzfIm5j6J0cSj
 zSdkFqFMkh6iyQF8OQ22dQ8MmJpahO9ruExr5kpfJGIFq90CBMQdED696ssGiez5RZ2p
 VV5vyFY3uWWkxSYltGoieUALiF/WF/TUH6/vLX9AEqxT2CHTrRsnzigDWNsTSqYDJnha
 YPHRbYVrDeoh+iw/Kpylq7F2wl7zsT/sENbQpHORiGx8IwVLxWThqoF6aL0Cbyh2SO/3
 abP3xasImtDOxtrWVFl++i5WF7AUtHxTp4q1UUpJdW1cIZ3L9OpkjhMAmaHe3tEMtI8E
 FP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970326; x=1787575126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=biHckXIZVXmOqgIJA8hHhBtu9umfyOhyxqSHPZkFM3U=;
 b=nAm7p8l7D1buV4OZksS1R2dmij6w7okNylsML9fuGqUO/QssaD3YpTC9QuZsFgmZfC
 jI/cdcDHCkHYuK1OAzh16tkMJe9NLGw8cwZUVkhQBhz8chcZGL9eaI80RcmyszbsAfwl
 KTcTy08HunCVeThmQWXYJ35YEn5Bk0k1r1bChaWXonHRS1I1pnXM7yV3DgS41IRLW32s
 lul7AVUnGlmZ+2JZeAWrfpJ65+L32kUwDeDZPx3gughlB5IFkECsJ0/H+MdMtPw5hHMp
 rveMTo0qta/AH3TG6XbjcT3hjAcFW/P+Wifjer5KRv0MsvfJJHWtVL+ShAo8Itq72WKf
 zYeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEO2iq0uSE2eGAbljlf4dFeRZUJWmE+SrHW2xLhIMbD+vsmwx35KIkpgnMrPIVpahVHhPYlzZRrrKc@nongnu.org
X-Gm-Message-State: AOJu0YxFX1Ldxh7lL0tjtMGi4A+UGxJyxsi0RKlnSQA+Muxx5cur7CtE
 LaZzPjB1aiLPEG9DvPyV3zS3z+ZmTtIv0xinUH9DQCWMz6sQqoXF3oMK2R8WWlwjv48=
X-Gm-Gg: AR+sD13Ns7337CnQIx0rumPNVvabVNs6bbq6WCfLG3EYlIt1G/YAo/Ix/kWPreMMCOB
 d8GaizdVyPPfQu8PHvxPbt+mOtk72H1ZMKbj6oScaMYIURZZjcAOpyhL0EHdXAh2w/VCNzzXBzi
 WOZdzK1FaB5uuT2Qg1WTSaBFgd22iwJzZ1NN/pQ/HQqAsNWx2OJbwfKOcD6gnc6otoqWZ3EvXZx
 f4BMXNgWpUubHLmzQ9HQ6rU4e5KYSZWaZWXS+pTgZhfWU388fOSIjODimZYavenXlTZxFRmuJLk
 Mozs9yA7mF8oJqQckQchRXNmmNEJ0S9qMB3rQAKuimLFKg/5yvEuKjZs9TGxq2/2joex7wnm2Q6
 Hlh5TepqwlgTH8NDDPNIWLN0B6gsZnyMFJ25gszPxH8EfowSHvEPrC8RELq2nH8gzLEBAMAvbqI
 YiLAhd/yozN5NrwqGJ+O7HXTgT8YUAbWcI8sf/uBImcw72cx16/EzN5V7areuGYug0+hkToT75s
 OEszq3o0MkMIzpVAvo3ZLPlzl3R8R+MbGEw9yP4oUlnZjMIWHCp+ugmvaTwVHl1SgbHOA==
X-Received: by 2002:a05:600c:5754:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49987951a06mr234226565e9.7.1786970326419; 
 Mon, 17 Aug 2026 05:38:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998780397dsm120415055e9.3.2026.08.17.05.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:38:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/8] target/arm: Add new feature ARM_FEATURE_NEON_TRAPS
Date: Mon, 17 Aug 2026 13:38:34 +0100
Message-ID: <20260817123838.1578060-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817123838.1578060-1-peter.maydell@linaro.org>
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
---
We seem to be a little confused about whether ARM_FEATURE_NEON
means "AArch32 Neon" or "AArch32 Neon or AArch64 ASIMD". I have
not attempted to unpick that here. I have also not gone so far
as to set NEON_TRAPS for the accelerator CPUs, since they won't
be using the sysreg access functions anyway and (other than KVM)
they don't support AArch32.
---
 target/arm/cpu-max.c   |  1 +
 target/arm/cpu.h       |  7 +++++++
 target/arm/cpu64.c     |  1 +
 target/arm/helper.c    | 17 +++++++++++++++--
 target/arm/tcg/cpu32.c |  8 ++++++++
 target/arm/tcg/cpu64.c | 10 ++++++++++
 6 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 88b7c04633..84fdd64c18 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -25,6 +25,7 @@ void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_NEON_TRAPS);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     if (aarch64_enabled) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c0492c8dfb..4f07332543 100644
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
index 2816735577..65998d3c64 100644
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
index 91b872dc77..6f33b1ef5e 100644
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
index 8220d785f5..3df3ca38d6 100644
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
index 24f34947ec..820248cb9b 100644
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


