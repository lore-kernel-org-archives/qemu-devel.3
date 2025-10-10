Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF94CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 20:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Jac-0000Uc-0h; Fri, 10 Oct 2025 16:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaK-0000Pc-KQ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaF-0002lg-0W
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-78125ed4052so2967183b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760127560; x=1760732360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tcvXe/+zrpnYYwFhuufS2LXIH9ZUA9oPOxweSPI5bU=;
 b=EnGgf9H2ZY4Eg2KFcPlBqfVqVKU2tVmarGtwYkoknBsNkrtUwsLsGWN0/rxtP3iph4
 b/xQjJ37N2iHRLpaXNzqe/NLNg4o0q5Q44FpzuwCEXmhmJ0syrmPsoclIAInmfGdNB5q
 EmDTSEUm874eb/4ZzMovNIzVV7cvLazyUdDKpESKETTO9e1APzJ2e/TK6VMQ4bBQ+j6S
 8cuUPWYTdpC83jkb6z8vSNayWU9S6oVrH0EXh7e8Ps9sWZBo+eORMCaga1E/F3wENiMJ
 Vb1EG9WsSHNl+bhXiYjdCwqQd2kfka5iC2CQUDZejr0/+dZh4IXMAoD4UY4ZKNPiwZ6j
 2bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760127560; x=1760732360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/tcvXe/+zrpnYYwFhuufS2LXIH9ZUA9oPOxweSPI5bU=;
 b=nox4X+/37CeArH01/WMWahGx5U3s8lXymN2WK0JGNABhzPO6guzh75WlIVHmjgvNzO
 d7vRbyiksAtbSMj7rsPHTCL6neN1/v0eyodPooCF6PCkGWVHjmXXgSBmyMRUFXdiJOwx
 34RmlTS/zn+wQB9m5DK+30V+041Q1OS2qis67sNCHTdkmNSxprsGsDQOKbXOoUW8/HVQ
 tTdYuhvG8AcfJ9pwN3ksEG5LsfizQvNSsUcj+nvk4BDWEKVhA0jVL+dPqWUUa957lBOv
 /GKyH0bIMJHNM7400Wen224MsZgLQVvSK3xgqxbux75vkEKCyEyIaeBB4a0b2C3Q4Psx
 BeEQ==
X-Gm-Message-State: AOJu0Yz9hO/pwIaylMuhW0l84kaOMTiwroXB42GhTIbLlUoL/QMuk5QB
 mYk4wbUkmSD5BW+awbldKFBM5rOWOjHqrEtodxDEn7z1C2kb1X9OPsJRbldNdyC6JSLousXJzrm
 Keym/06A=
X-Gm-Gg: ASbGncvm27JAd2C+6mSgtE32SRPAT6BCPkzkISqaFSgVL+DLXYOcKIQljbAcK0XjJ/P
 kXFodeIctsjKEp3Z/IO+qPra6C6F+qEUCeQgb5si8zFUHf8VvTGg3jkpg83hvugaH1l70hq7ZVL
 Xtmb+wodENmtENjyJYtOyMKe3AEBJdnWcZQMDwAVOiBBPK65GeykGe356gesjoVY6a7sVOwAh/Y
 YKZqC2ZVpYAPzQ632xfpC4k2pcXNHwVEANDCCvsZqZbmjBPCHJUxMBdS7WRu/qSrZwW7kWumfyl
 36agR+DDVPDh2p9ICdtSy1HscsAxyjWzRkGNpGlvPk3vtNEQDL3B6sy229pNPLHNNQ3p7AP9Y80
 uCohHs/UVtzj3em2KAVMzQ5MEOl7DOCTXaZMyKsTYgYONJSn5Ya0SoGvqcbnhzA==
X-Google-Smtp-Source: AGHT+IHmRe3uENi2PItqGA61GOOwz89E7hPW2mPCuJ8gd39gfYXpldNKg+71rAPSI4863oRT2BT7Bg==
X-Received: by 2002:a05:6a00:234b:b0:781:8680:3175 with SMTP id
 d2e1a72fcca58-79387146c19mr15880335b3a.21.1760127560209; 
 Fri, 10 Oct 2025 13:19:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992dd7ee5bsm3764830b3a.85.2025.10.10.13.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 13:19:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/7] target/arm: Implement MAIR2_ELx and AMAIR2_ELx
Date: Fri, 10 Oct 2025 13:19:12 -0700
Message-ID: <20251010201917.685716-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010201917.685716-1-richard.henderson@linaro.org>
References: <20251010201917.685716-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Enable the SCR.AIEn bit in scr_write, and test it in aien_access.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |  2 ++
 target/arm/cpu.h    |  5 +++-
 target/arm/helper.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 763de5e051..48a406a5fb 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -806,6 +806,8 @@ typedef enum FGTBit {
     DO_REV_BIT(HFGRTR, NTPIDR2_EL0),
     DO_REV_BIT(HFGRTR, NPIRE0_EL1),
     DO_REV_BIT(HFGRTR, NPIR_EL1),
+    DO_REV_BIT(HFGRTR, NMAIR2_EL1),
+    DO_REV_BIT(HFGRTR, NAMAIR2_EL1),
 
     /* Trap bits in HDFGRTR_EL2 / HDFGWTR_EL2, starting from bit 0. */
     DO_BIT(HDFGRTR, DBGBCRN_EL1),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1d4e13320c..e21612b898 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -447,7 +447,8 @@ typedef struct CPUArchState {
         uint64_t c9_pmuserenr; /* perf monitor user enable */
         uint64_t c9_pmselr; /* perf monitor counter selection register */
         uint64_t c9_pminten; /* perf monitor interrupt enables */
-        union { /* Memory attribute redirection */
+        /* Memory attribute redirection */
+        union {
             struct {
 #if HOST_BIG_ENDIAN
                 uint64_t _unused_mair_0;
@@ -467,6 +468,7 @@ typedef struct CPUArchState {
             };
             uint64_t mair_el[4];
         };
+        uint64_t mair2_el[4];
         union { /* vector base address register */
             struct {
                 uint64_t _unused_vbar;
@@ -1736,6 +1738,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_PIEN              (1ULL << 45)
+#define SCR_AIEN              (1ULL << 46)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 167f2909b3..e4d1651440 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -779,6 +779,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             cpu_isar_feature(aa64_s2pie, cpu)) {
             valid_mask |= SCR_PIEN;
         }
+        if (cpu_isar_feature(aa64_aie, cpu)) {
+            valid_mask |= SCR_AIEN;
+        }
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |= SCR_MECEN;
         }
@@ -6189,6 +6192,61 @@ static const ARMCPRegInfo s2pie_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.s2pir_el2) },
 };
 
+static CPAccessResult aien_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_AIEN)
+        && arm_current_el(env) < 3) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult aien_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret == CP_ACCESS_OK) {
+        ret = aien_access(env, ri, isread);
+    }
+    return ret;
+}
+
+static const ARMCPRegInfo aie_reginfo[] = {
+    { .name = "MAIR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 1,
+      .access = PL1_RW, .accessfn = aien_el1_access,
+      .fgt = FGT_NMAIR2_EL1, .nv2_redirect_offset = 0x280 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 1, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 2, 1),
+      .fieldoffset = offsetof(CPUARMState, cp15.mair2_el[1]) },
+    { .name = "MAIR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 1, .opc2 = 1,
+      .access = PL2_RW, .accessfn = aien_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.mair2_el[2]) },
+    { .name = "MAIR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 1, .opc2 = 1,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.mair2_el[3]) },
+
+    { .name = "AMAIR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 3, .opc2 = 1,
+      .access = PL1_RW, .accessfn = aien_el1_access,
+      .fgt = FGT_NAMAIR2_EL1, .nv2_redirect_offset = 0x288 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 3, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 3, 1),
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "AMAIR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
+      .access = PL2_RW, .accessfn = aien_access,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "AMAIR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 3, .opc2 = 1,
+      .access = PL3_RW,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7434,6 +7492,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
     }
 
+    if (cpu_isar_feature(aa64_aie, cpu)) {
+        define_arm_cp_regs(cpu, aie_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.43.0


