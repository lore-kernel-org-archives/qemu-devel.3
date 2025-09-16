Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61456CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4X-00035b-S9; Tue, 16 Sep 2025 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4U-00033V-Cg
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4S-0001ak-G0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3e9042021faso2270394f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045987; x=1758650787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U5WkaCtDE6hB+ZTrL4FMHKfsJLEnw9EnHr7t9I7nEEw=;
 b=ycEIoMRtfCaiWaqKpbeUHIvBQ3j2g9PISjOcsvoXGpwD0831+tqon5Mg1Fmh4DNhPM
 6bKR5krq2A907EYJC7JnK2Dore4yKmw8WcHAYzKo7OuYSjL5LckQ8M5f1WDWyBikHfcF
 2sAHLCMx6uCgt1/NgBIdITc8WzdMqM5GlMrBV/QpZPFNlMz2e1OcWsaWcjTSv9HWR330
 mNXtz+FAbMI4Roi/uDOeXqEB0HGSuWEXRknNp9R897agaRvkMjqU44t42E48DhFXBtee
 k1qHeIj44OD+/u449j2+NC6Aw+lIGR0BI/M01fBXuDshXqWNqvYFXWJea2J7GcXK30Vb
 ecCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045987; x=1758650787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5WkaCtDE6hB+ZTrL4FMHKfsJLEnw9EnHr7t9I7nEEw=;
 b=nLGuNcNQ37ZHwUEP9F2pWRpYe8ID0XunHMYLLDUsyxE0mZTU1KI+SfWJzfNZ3xCk0z
 /gPmhVn5ljrHVygNMWtL6roCEbhuzG1OYVBzWu+UU6rJylCBk76RSogHhzgW0wvwE+es
 oJMo596EWvPt1kNBGhKlGERNtEyQ7ou3YOKzcketPxcZWkFpCHeGnuLMU22QMO/Ptqfc
 iFtKrlvqTyyTFIpydwHGIj6zqVxV3Wnx8R0GU9hMGfmf1kvG9o4dwKaFJHASflzM/JNi
 hkRdizkWOm74SxrdQtW8qkSOguChvjpKQ/nhqsaV/tKKOj5de5nw1kDb+9CbNjf7KuPl
 Kzag==
X-Gm-Message-State: AOJu0Yy07wB84uIjgWQk57NzDZYUagfmSJN9cN/JjForc3e2PrlKvaH/
 FtaIj0awtWWIygpvnI5Hct4Qf6E7QbpV1+6Sl4ti0zLYMBCQJM+dEgqsDvpri/+3WKcDB9b2uJt
 PFmlD
X-Gm-Gg: ASbGncuX8mGaCNch5MHPnreScZujYbqFllJ9NB4NvOqjAk8wZcmZcYUMZmns24dOSbA
 N51ZztfdlZFhioKA12dDDIAAvXTLUZP73CvjsExKSpVLh0Dg3fFO02xuAcU1Op+0cgLDZgc3YZh
 You5i39OwWYvNhboFfAuWrdzJ0KbeKHVf072k93B7hTFOGZLlDd5gflAGxFtf7RG2Izb0uLyzSd
 aQFKPMVaBbW/SGJeIbACbjjx8kL9eZQcuP633L1gqwSQZC8Rr2N5r2WMnja0NpS8ICznIAUeeGN
 2kk0nuPTSPtjhD+6gelNzsgw5QDtvj0AmErHZLEzXSTuKF/VhTPzA4f+8Uwn3339mkj8MJOIhK8
 uNrd71YNhnnswX/StGK/YLbsq7hS3yMw98dJm1gg=
X-Google-Smtp-Source: AGHT+IGZjMjkLH887yNnbk033Mg4Lza5UHfaMOYATFEYAzPLuwZSGYlxavMS1ZD/7Ap+usL9Hhncsw==
X-Received: by 2002:a05:6000:2084:b0:3ec:2529:b4e5 with SMTP id
 ffacd0b85a97d-3ec2529b4ffmr5139199f8f.38.1758045986832; 
 Tue, 16 Sep 2025 11:06:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/36] target/arm: Implement FEAT_ATS1A
Date: Tue, 16 Sep 2025 19:05:47 +0100
Message-ID: <20250916180611.1481266-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Implement FEAT_ATS1A and enable for -cpu max.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpregs.h           |  1 +
 target/arm/cpu-features.h     |  5 ++++
 target/arm/tcg/cpregs-at.c    | 44 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 5 files changed, 52 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4e8aca8b5d5..6b04c96c8c4 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -23,6 +23,7 @@ the following architecture extensions:
 - FEAT_AFP (Alternate floating-point behavior)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
+- FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 1d103b577f7..2a4826f5c4f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -854,6 +854,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
+    DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
 #undef DO_BIT
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e49e0ae3af0..512eeaf551e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -619,6 +619,11 @@ static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, LUT);
 }
 
+static inline bool isar_feature_aa64_ats1a(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, ATS1A);
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index bebf1689970..0e8f229aa7f 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -488,6 +488,47 @@ static const ARMCPRegInfo ats1cp_reginfo[] = {
       .writefn = ats_write },
 };
 
+static void ats_s1e1a(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
+    ARMMMUIdx mmu_idx = regime_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_Stage1_E1;
+    ARMSecuritySpace ss = arm_security_space_below_el3(env);
+
+    env->cp15.par_el[1] = do_ats_write(env, value, 0, mmu_idx, ss);
+}
+
+static void ats_s1e2a(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    ARMMMUIdx mmu_idx = hcr_el2 & HCR_E2H ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
+    ARMSecuritySpace ss = arm_security_space_below_el3(env);
+
+    env->cp15.par_el[1] = do_ats_write(env, value, 0, mmu_idx, ss);
+}
+
+static void ats_s1e3a(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    env->cp15.par_el[1] = do_ats_write(env, value, 0, ARMMMUIdx_E3,
+                                       arm_security_space(env));
+}
+
+static const ARMCPRegInfo ats1a_reginfo[] = {
+    { .name = "AT_S1E1A", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 2,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .fgt = FGT_ATS1E1A,
+      .accessfn = at_s1e01_access, .writefn = ats_s1e1a },
+    { .name = "AT_S1E2A", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 9, .opc2 = 2,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .accessfn = at_s1e2_access, .writefn = ats_s1e2a },
+    { .name = "AT_S1E3A", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 9, .opc2 = 2,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_s1e3a },
+};
+
 void define_at_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -509,4 +550,7 @@ void define_at_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa32_ats1e1, cpu)) {
         define_arm_cp_regs(cpu, ats1cp_reginfo);
     }
+    if (cpu_isar_feature(aa64_ats1a, cpu)) {
+        define_arm_cp_regs(cpu, ats1a_reginfo);
+    }
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b8b1981e702..abef6a246e8 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1179,6 +1179,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
-- 
2.43.0


