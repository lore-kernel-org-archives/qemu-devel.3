Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A972CC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMbD-0001Yl-3j; Fri, 11 Jul 2025 18:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYu-0007cf-DG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:52 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYc-00005c-13
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:31 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40a7322f081so818512b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274169; x=1752878969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2EtIwYhWBdunEnHZqFFjPpeIhDqDk+A7MtfcXFRuII=;
 b=PfDOkud/4TKpgDnaztEFd/Fwhk2EFXCdE67D5oHWDXsbGAXt+QN6+bgKRD51U10zph
 k8nBNgyM+VIKDaa1g78+6L/XWL6fWEyAJ99SIzzXo5VLvQ3OZex5FBshEJFPcwObvUED
 XhRpNUfQ2BezdmHvWDXlysIaKDSZuTHcw7hv45fuuwmutxvhtGQxQe8RMSPtw7liMiWU
 DBeyHrTKnJjuycNzKKiA4mvrEiTEzl0zf2j0c8GV/R7woDpGN8V+hgRB5f93/LAI7G5o
 CXwJ2L5fYyNMj3rCwDtjKl25fOe3vTHS5kOaIdkkL/H3Wm/GhQkocWmY7THgQM5LiMEe
 Bokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274169; x=1752878969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d2EtIwYhWBdunEnHZqFFjPpeIhDqDk+A7MtfcXFRuII=;
 b=iyILhyEC/vjRE7IDaXPt8OgqfoS+2hNd4RAhZG1R7NkcssVTNxNbnycjWf6xcRzYcO
 230y1fuKd/YTlaxSNUY3b76l0TzvqDwbCGDnxQy+64vtvgRYFFwrrl20OrEe25o3bu1i
 FshHPpBdzu3bscQX2lqg7fJOsGh3wsDiWMouXgnfctUvfVaBmvsw+sE9sXebyFx5oXfc
 mZfXruSwpSSRg2W5bgkAqKPdVqmBK4no+9viLCjrv++3LfCkODa8ZrOFZoShX7R9sOrq
 SQqjHiqZupiG08oUum0envXCnK40oG0RKJakzQkUE+vwXyaemcUenZCzr7E9HHqRezHK
 00vg==
X-Gm-Message-State: AOJu0Yym1mAVnNFfmQPMYsd6cUAlqHVC/Gq/BrV5+5H9t8wDPFP+UYi9
 S7iXAwoOVs847NbP1JH5F2NS3J2xiFatD2E62APkAladW7tQeG3pds8DeM863IEahpQk1Z9vl35
 3rsbvmz0=
X-Gm-Gg: ASbGnctiG6/pZ9fErnXOFiHZwc3lUfj6fXVMpG/UaSdYMje4EWRY0IPzfX1kRUcFl2A
 wQ3LRVbqSQVrPuJC6a9Gv7CgupUuqC6fUBOqx+i8qiUN2h48oPLaQDhk17rmaxN31oOFQCx94ll
 CmzvPSMraGkfc1N4a7e8sYOkd0uPmOj9WA4HL0BBtcSt+95IywVrjutixKvjejZkgt5DZnA5nLl
 kPW8Wtwpi3BoLQxPu+LY3mostYkTYf5P96mYvMGX8luFyY/YR1cexfjS5ivA7Sb/DvweuSEsNwe
 d/NTb4nDHgiuMNMnLc2KBC+ScAbCwtDGh/G9ZjeWTHOH7q0LtnyeBHVUrvSfOd/iMCfWMZEnHT2
 XG2/apBfDEidOVNQPPxIyh8gs8oOIkDQ9XGChPmEn8kpsRfM9uhJ+P6/hRvUFXybsPtIvx0Ae7C
 jOMVn8zZXb
X-Google-Smtp-Source: AGHT+IEn/PA3k57CrwemTqq2CSfrbk3qBl1ec7azLVYMydFm5oq1w6HJu3mW8OigkDbfRVb/jEA7qg==
X-Received: by 2002:a05:6808:3505:b0:401:16e:918e with SMTP id
 5614622812f47-4150d645624mr4272202b6e.8.1752274168766; 
 Fri, 11 Jul 2025 15:49:28 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 9/9] target/arm: Implement FEAT_ATS1A
Date: Fri, 11 Jul 2025 16:49:15 -0600
Message-ID: <20250711224915.62369-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711224915.62369-1-richard.henderson@linaro.org>
References: <20250711224915.62369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

Implement FEAT_ATS1A and enable for -cpu max.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h           |  1 +
 target/arm/cpu-features.h     |  5 ++++
 target/arm/tcg/cpregs-at.c    | 44 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 docs/system/arm/emulation.rst |  1 +
 5 files changed, 52 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 1d103b577f..2a4826f5c4 100644
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
index 9579d93cec..7f2ca51b4c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -609,6 +609,11 @@ static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
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
index bebf168997..0e8f229aa7 100644
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
index c54aa528c6..22ccc4f697 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1178,6 +1178,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index d207a9f266..1489c262b8 100644
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
-- 
2.43.0


