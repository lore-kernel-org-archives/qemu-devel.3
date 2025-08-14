Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794AFCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXn-0001VY-B7; Thu, 14 Aug 2025 08:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXj-0001Um-KO
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:55 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXa-0004FW-0i
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:52 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4716f92a0aso552178a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176320; x=1755781120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHSDdWTCh8t1tRyRbP9Lg4R3+bQUPTmxLzxlpsJeaKQ=;
 b=PQTzIHM1X7puemPNKrcLyET4wfCzQIvhZ/hvEVqnexxFj9Jw6060EMeTquIsRu/upv
 oYJKXo2LdH0y84/ZRUcoWmGgaMi3i6leC7Q8dzZyJDpmRqYc7GJJoi10I5ruL0YSuUp4
 pQM9i94COp+Sxx0f5BrmxNHeQZKzvz9wG3KsNkPxZjM1eV5l+WI7VXrovH0vLVX9OXzM
 39JFoPz4KpD1twMRHNyHBwFdaq6aZ+BSCSUksdkK23EYwRj1cA2kipsqtM5XzuvPAtGs
 5KB0XtitDw2lupvh6kcawJoy9dHCGfrEkkI0mClM4B3x0PhEM3OnjSAP2ftWOfhJfGFh
 Q+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176320; x=1755781120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHSDdWTCh8t1tRyRbP9Lg4R3+bQUPTmxLzxlpsJeaKQ=;
 b=FIb+p8uBPRbHbCc4VQF9NnqBGbSGIcdXPbYnvXm/JKeEcmnQmR/gNJMxxTwPhHi5RY
 PZkpAEyq0iZAqzv/JrVBIxVtft6gZPs0SOUC8V9acvb4QNepTdP/aICCTTVMZy9U6j6Q
 t5dp6qWApTJyHS9ua6By1PE/sGoat6o7XFiyO6TsefvLukdeJ3ohP1Um4pc7ytMzsQVc
 swxYap5J/+t82tPgD3fEuHu1PfXak8J9R2972J2Z5hJ1wgWm82UkfNzF0JSYk/YiUfMr
 C86W91gritF1MqpHF2A59AOeHjh3VO5gxCndMyZ7tIrjSPKaplwW2oTinXPuPtmZybLL
 l+8g==
X-Gm-Message-State: AOJu0Yw7rYt43j5zos91Yg6MbINdBNIHtclzhIBUx6hv6xSnhHH2Ff3H
 CQYdZ/xExUlrXQrsNmEY1PVLNlvkJLmpsx1+XOMEcZ1tfJ1KUrgooIM9oA4AAuxRiBWXGBlE4cK
 pail7W6k=
X-Gm-Gg: ASbGncvlgUMg1M5gu7K1reU8pCPwxzlntPTHQ4yZP5RvO+QrjxwRF7hJGhL6jSgXz0L
 NNX3eQWnh/p+ldV/tDv2ZQHRJ4WYzoOjv/krMmVzv1GDOsbrd2SUia2KhAe+ndW7O1MadGsplJQ
 Wx7w+lmvnaH86AfgrA0ujYFpH3yhXSv0egvVW/6XcgKmrmYc4SnfI5wkJZrPCsk+d9sg46RbRNn
 ei/RhD15wQH8FX3BOjIiraaAPeTdSphufD+cVzC/7hxIsqPYKl2zb65sNvMMbuMqpMKQcQ/Wiio
 6Fxc4dbWAVNm9gxMBGcfif41F14ylm0VBYT8qSxrvqgfTfa3Y3p/mB1L+TfENiK77qqnPmZBQVC
 c92ggCxPDORZTcIyn7lZXBIsAeAYNY5cjozEtQpB6O/zgRho=
X-Google-Smtp-Source: AGHT+IFGW6z2+qhpPP18yxumJxky4jsPk1WbluDtVucS3hjxYl3kze5/axHu1yqLi/XJyjupWOt/WQ==
X-Received: by 2002:a17:90b:17cc:b0:321:4182:2b9e with SMTP id
 98e67ed59e1d1-32327ab2df2mr4999422a91.12.1755176320026; 
 Thu, 14 Aug 2025 05:58:40 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 12/85] target/arm: Implement FEAT_ATS1A
Date: Thu, 14 Aug 2025 22:56:39 +1000
Message-ID: <20250814125752.164107-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Implement FEAT_ATS1A and enable for -cpu max.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


