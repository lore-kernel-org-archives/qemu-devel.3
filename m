Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA91C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufw1a-00078q-2k; Sun, 27 Jul 2025 03:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1Q-0006J6-WB
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:18 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1O-00015o-P0
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234c5b57557so28932605ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753602133; x=1754206933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNLo+7ALroGiAGWFemZWDAH0MuMwfSmyxDTl4Ftnsyk=;
 b=xach8I7WqyGRSMJnMnVgsSqO+MfKcM9vnTgjvVFrW9xDH9+BgFTgs3qTUQxyaF8AeW
 nBUV8C9mnAtoFRn4YhM/MqmDRgcOaFwwgaHWw63stNn1mSbjreFKPXFdzwOFm6vaaJPO
 XPpyHCDz2QX9+Vs0FBk89ir1ZHZeFsjqcvXma8jkRTn+U1AGF703ez0iaPHyFNPU50xJ
 weyTWqIQMKqyv6Nzf6P9cH6i9OrpmjuArG0C2JpoP4weg92hlO5OB5z/M78vMh12L6Gl
 QEYmOv01aBiFaO/QADO3gV8Xu0UCtZ92ATNC8of0Hp5dRFk4JITEpsiXYXAy9j8bEoq6
 VTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753602133; x=1754206933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNLo+7ALroGiAGWFemZWDAH0MuMwfSmyxDTl4Ftnsyk=;
 b=Xe6hTSO9u3QWM/QHcA80fjgLwBTYQivx1cw6OfjpgH/ubc7Aq/pWqxOyGTi/AyGhxW
 Y1Sv5WfT+ueSzt0C62mJrcKubi/bIeo0eI2PUSaRf8vf9EFMTrIofY31XdWiE+IIXyya
 Dq9lgnS7Q15dvTtj+70oj0G/TH+68oXnITafzBA3GOYwNEHvBCUS6pHXF3ieBmAnRfui
 /WnwQ4YqBkxbmDFdtZPJHA7uii+zFLEQ/g/23gozhQxdaP7KGZ6DbbH3cVYzowZ7vXQZ
 MLEbWCI2+2rTpimbsnM6LnlsXOfRDlhVsQLlMOGMq+p5azKp1C7dT6xtJlKUlWLhWuxw
 856g==
X-Gm-Message-State: AOJu0Yylkl6bFG4QHuPCY3C3XBcRdWBISOdLGu7sMc6l+5s3QtqNrxhl
 ImRPTPTyA0hyCFBGB8dfblwFmul0HQre5sMRqgTuRf7DjlHt6BHoYdMwYJEFuHEGJVb2NfSgvUD
 xOPou
X-Gm-Gg: ASbGncsvHGAtsM5v9CgLAFr+NA4WdEZHoZw7Ph4gwMO9s4L0Fg1rebQXa2+/O8Tk24o
 Vd3dvpRyyd590saqVw00C8jLPiBqhTSg/Z2FwDx5i0QlFnxVeXDiyzzeVR16kPrnrqeqtI4ZwaC
 IHyWT1Y+MP3DB5/gr/o3qXzrqO1gEthvgXqDnD/6BtL2b0C8wjeN1xfEor0nzFo3DOkaym58rpx
 TMthejDvYTc542rEoDS4xB4Xz/YIiH8okyE+1NuvcTNSPNgxzhJJPnJd9kDC8jESkpBI5Qg8Otz
 h758+23VyIaZ9wm/ZFbI5/1hqTqj613OmxEyNu+ZbC0WUY9jelQBMqZsXH1z9/LpXchYDLf2W3B
 SsWciq6PseUurS7gs73HSV2rNz0kTbsXlsG/BMEk1XEBWXaZpMm1UXu1rgQQkENEUWYrYI3cuSb
 JI2V1nUHbOvw==
X-Google-Smtp-Source: AGHT+IEC8IiuRfRARjtcDasZ7JhZ7r11NtCCH5OHeZD9z/ubYzvs7VirctSRGuq/3k+P7j/o4UMOdA==
X-Received: by 2002:a17:902:d487:b0:23f:af68:ae38 with SMTP id
 d9443c01a7336-23fb30b3006mr113060295ad.31.1753602133349; 
 Sun, 27 Jul 2025 00:42:13 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe53b546sm29633055ad.177.2025.07.27.00.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:42:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v9 4/6] target/arm: Implement FEAT_TCR2 and enable with -cpu
 max
Date: Sat, 26 Jul 2025 21:42:00 -1000
Message-ID: <20250727074202.83141-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727074202.83141-1-richard.henderson@linaro.org>
References: <20250727074202.83141-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add FEAT_TCR2, which introduces the TCR2_EL1 and TCR2_EL2 registers.
These registers are extensions of the TCR_ELx registers and provide
top-level control of the EL10 and EL20 translation regimes.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250711140828.1714666-5-gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Remove FEAT_MEC code; handle SCR and HCRX enable bits.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h     |  5 +++
 target/arm/cpu.h              |  2 +
 target/arm/internals.h        | 19 ++++++++++
 target/arm/cpu.c              |  3 ++
 target/arm/helper.c           | 71 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 docs/system/arm/emulation.rst |  1 +
 7 files changed, 102 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e372543bf3..8ec8c3feb3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -904,6 +904,11 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) >= 2;
 }
 
+static inline bool isar_feature_aa64_tcr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, TCRX) != 0;
+}
+
 static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08a29802e1..c15d79a106 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -366,6 +366,7 @@ typedef struct CPUArchState {
         uint64_t vsttbr_el2; /* Secure Virtualization Translation Table. */
         /* MMU translation table base control. */
         uint64_t tcr_el[4];
+        uint64_t tcr2_el[3];
         uint64_t vtcr_el2; /* Virtualization Translation Control.  */
         uint64_t vstcr_el2; /* Secure Virtualization Translation Control. */
         uint32_t c2_data; /* MPU data cacheable bits.  */
@@ -1726,6 +1727,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ea485835fa..ffc981c3b6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -201,6 +201,24 @@ FIELD(CPTR_EL3, TCPAC, 31, 1)
 #define TTBCR_SH1    (1U << 28)
 #define TTBCR_EAE    (1U << 31)
 
+#define TCR2_PNCH    (1ULL << 0)
+#define TCR2_PIE     (1ULL << 1)
+#define TCR2_E0POE   (1ULL << 2)
+#define TCR2_POE     (1ULL << 3)
+#define TCR2_AIE     (1ULL << 4)
+#define TCR2_D128    (1ULL << 5)
+#define TCR2_PTTWI   (1ULL << 10)
+#define TCR2_HAFT    (1ULL << 11)
+#define TCR2_AMEC0   (1ULL << 12)
+#define TCR2_AMEC1   (1ULL << 13)
+#define TCR2_DISCH0  (1ULL << 14)
+#define TCR2_DISCH1  (1ULL << 15)
+#define TCR2_A2      (1ULL << 16)
+#define TCR2_FNG0    (1ULL << 17)
+#define TCR2_FNG1    (1ULL << 18)
+#define TCR2_FNGNA0  (1ULL << 20)
+#define TCR2_FNGNA1  (1ULL << 21)
+
 FIELD(VTCR, T0SZ, 0, 6)
 FIELD(VTCR, SL0, 6, 2)
 FIELD(VTCR, IRGN0, 8, 2)
@@ -232,6 +250,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define HCRX_CMOW     (1ULL << 9)
 #define HCRX_MCE2     (1ULL << 10)
 #define HCRX_MSCEN    (1ULL << 11)
+#define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 
 #define HPFAR_NS      (1ULL << 63)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2ab04cb5f7..27a4610da5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -644,6 +644,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_tcr2, cpu)) {
+                env->cp15.scr_el3 |= SCR_TCR2EN;
+            }
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 11ddeabb13..5a219703ae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -741,6 +741,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_ecv, cpu)) {
             valid_mask |= SCR_ECVEN;
         }
+        if (cpu_isar_feature(aa64_tcr2, cpu)) {
+            valid_mask |= SCR_TCR2EN;
+        }
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             valid_mask |= SCR_SCTLR2EN;
         }
@@ -3922,6 +3925,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_xs, cpu)) {
         valid_mask |= HCRX_FGTNXS | HCRX_FNXS;
     }
+    if (cpu_isar_feature(aa64_tcr2, cpu)) {
+        valid_mask |= HCRX_TCR2EN;
+    }
     if (cpu_isar_feature(aa64_sctlr2, cpu)) {
         valid_mask |= HCRX_SCTLR2EN;
     }
@@ -3989,6 +3995,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_mops, cpu)) {
             hcrx |= HCRX_MSCEN;
         }
+        if (cpu_isar_feature(aa64_tcr2, cpu)) {
+            hcrx |= HCRX_TCR2EN;
+        }
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             hcrx |= HCRX_SCTLR2EN;
         }
@@ -4529,6 +4538,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
           "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
         { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
           "TCR_EL1", "TCR_EL2", "TCR_EL12" },
+        { K(3, 0,  2, 0, 3), K(3, 4,  2, 0, 3), K(3, 5, 2, 0, 3),
+          "TCR2_EL1", "TCR2_EL2", "TCR2_EL12", isar_feature_aa64_tcr2 },
         { K(3, 0,  4, 0, 0), K(3, 4,  4, 0, 0), K(3, 5, 4, 0, 0),
           "SPSR_EL1", "SPSR_EL2", "SPSR_EL12" },
         { K(3, 0,  4, 0, 1), K(3, 4,  4, 0, 1), K(3, 5, 4, 0, 1),
@@ -6073,6 +6084,62 @@ static const ARMCPRegInfo sctlr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
 };
 
+static CPAccessResult tcr2_el2_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_TCR2EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult tcr2_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret != CP_ACCESS_OK) {
+        return ret;
+    }
+    if (arm_current_el(env) < 2 && !(arm_hcrx_el2_eff(env) & HCRX_TCR2EN)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return tcr2_el2_access(env, ri, isread);
+}
+
+static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static const ARMCPRegInfo tcr2_reginfo[] = {
+    { .name = "TCR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 2, .crm = 0,
+      .access = PL1_RW, .accessfn = tcr2_el1_access,
+      .writefn = tcr2_el1_write, .fgt = FGT_TCR_EL1,
+      .nv2_redirect_offset = 0x270 | NV2_REDIR_NV1,
+      .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[1]) },
+    { .name = "TCR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 2, .crm = 0,
+      .access = PL2_RW, .accessfn = tcr2_el2_access,
+      .writefn = tcr2_el2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[2]) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7306,6 +7373,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, sctlr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_tcr2, cpu)) {
+        define_arm_cp_regs(cpu, tcr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f4efff03a5..4eb51420ef 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1248,6 +1248,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 66043b0747..1c597d8673 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -149,6 +149,7 @@ the following architecture extensions:
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
+- FEAT_TCR2 (Support for TCR2_ELx)
 - FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
 - FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
 - FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)
-- 
2.43.0


