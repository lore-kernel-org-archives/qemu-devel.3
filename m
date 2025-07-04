Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB50FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXi8H-00029e-Lw; Fri, 04 Jul 2025 11:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi8C-00025w-Su
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:17 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi8A-0004e0-M7
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:16 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-702b5559bbdso4842976d6.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751642113; x=1752246913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mp+FS8nNFswUhOtJAecxTCYZShRBLW2IyvTVb/fmyBo=;
 b=RuMTU4fQxadogE34xE8XNAoJsnXwZ6RKCEWswdv6ZI2M2H2hKFFfSRm1OJqEYJZrlg
 fuSwch+iK8RYhbSkLZpVqxfg945jhzO2JjM+a5Htq24R42LgU+SMHvlfwKe8/ssvMKRB
 iXAPt7eJAafb3qJ2WCJHJIwl0P1i0C63PcrWn0VfWzxLPSaLsNLEeGaRjELSA4tbvzTG
 v3Emc4vBZDnlqMD4KC+xOWZO595iBox+At7WzltXgH6WWh8avKEdOI7v7n/XPEzbkzE5
 wWkRXzwbxP5/Voa2iF7YXOaJY0a8r+Bnj3WNNSHkBAK47DjLu/XY2HrL7TGvvh5nlIAT
 3V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751642113; x=1752246913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mp+FS8nNFswUhOtJAecxTCYZShRBLW2IyvTVb/fmyBo=;
 b=pa9SYtrfidE/8QfyWV9h6WGmOJLv5J3xT3se96QIpzhzK9mQpApdjOn2RBEOOw7GK5
 wYodY7AAEB4ZYPyGlcg47VYXsiZHgp1LM20hZOuYPBXo4w4XTrzA8pwHEG6pXO7ftsgJ
 Lu5dGUmVehWsBa2OPTtjsl88zmf+wKv1btvm4k2Dgi+xDT1YXv3vErSNW7v5jb5rU2kP
 TxurmB6dDPt4b/ZZVRFFXzTQceD5w9o35EeEYv54lrWOiMl8C2SgsQgif3nT/QJiuWTC
 Gylw5Ud3uS2J8nWk8JnHNSN7AVgdwTrQtGL30Iy3LHd/fBDews8qmhLpay67nIFjLsNw
 P5dw==
X-Gm-Message-State: AOJu0YzGSQ+JQLt7H5WYJAu5SxCka1QDqtEG+UvdOUE6yceLaVlk7vrC
 /auLPjHjr4frmtgALZy5Zn5kzLh5/VKqlwDNArIBsnzKpHp/4jtlb026v/v97tznzAw=
X-Gm-Gg: ASbGncul0vdBWVX2gfbsnxW0DRdNvRuNLQoHHBcHMXxBpi4LXQCT/JNQ8h12q4FdUM5
 klEPLL2pkkR88dQEbW/73P6z4MAosIfPBO0AdNFTk6gssuLCURJwVYa7kl43gf1xleaLwttg9jk
 ESwDX0JONdv6gnIrc38fMeF0tyfIVJrHSPqx7Xp8Oxd0DFAKTg4fg0zwpfAIRYds4EpjCb2dulY
 PIy63RBV5x1vnKoxu97Q4rStNWtiPQ23MI9VGYSydl5hKrMNR6t5nUzVZXPq73EccuLTe6xINn2
 YEbtXCKCGmTpEL9ITlT1deWyZjEPcWIgT38nki4FrwHEDgCA+4RzS/KaT8hi0WigypVCajK7ILg
 9ug==
X-Google-Smtp-Source: AGHT+IGnPSYZa7NKK/KNBH2+GrMrOd8yqr+MDF3k1dQh6bc7B4U5EVpM8oPAZSh2FEpcPsy+qHCMTw==
X-Received: by 2002:a05:6214:4993:b0:6fa:980d:52f with SMTP id
 6a1803df08f44-702c8bcec02mr31874706d6.23.1751642112712; 
 Fri, 04 Jul 2025 08:15:12 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d6039fsm13658666d6.111.2025.07.04.08.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:15:12 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [WIP-for-10.1 v2 4/5] target/arm: Add FEAT_TCR2
Date: Fri,  4 Jul 2025 15:14:30 +0000
Message-Id: <20250704151431.1033520-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704151431.1033520-1-gustavo.romero@linaro.org>
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf31.google.com
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

Add FEAT_TCR2, which introduces TCR2_EL1 and TCR2_EL2 registers. These
registers are extensions of the TCR_ELx registers and provide top-level
control of the EL10 and EL20 translation regimes.

Since the bits in these registers depend on other CPU features, and only
FEAT_MEC is supported at the moment, the FEAT_TCR2 registers only
implement the bits related to FEAT_MEC for now.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 +++++
 target/arm/cpu.h              |  1 +
 target/arm/helper.c           | 40 +++++++++++++++++++++++++++++++++++
 target/arm/internals.h        | 18 ++++++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 5a82c602f2..611d7385d8 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -143,6 +143,7 @@ the following architecture extensions:
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
+- FEAT_TCR2 (Support for TCR2_ELx)
 - FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
 - FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
 - FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a42d1133c2..e6a731472f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -485,6 +485,11 @@ static inline bool isar_feature_aa64_xs(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, XS) != 0;
 }
 
+static inline bool isar_feature_aa64_tcr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr3, ID_AA64MMFR3, TCRX) != 0;
+}
+
 /*
  * These are the values from APA/API/APA3.
  * In general these must be compared '>=', per the normal Arm ARM
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ac38306873..6fd984a22f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -355,6 +355,7 @@ typedef struct CPUArchState {
         uint64_t vsttbr_el2; /* Secure Virtualization Translation Table. */
         /* MMU translation table base control. */
         uint64_t tcr_el[4];
+        uint64_t tcr2_el[3];
         uint64_t vtcr_el2; /* Virtualization Translation Control.  */
         uint64_t vstcr_el2; /* Secure Virtualization Translation Control. */
         uint32_t c2_data; /* MPU data cacheable bits.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 413672174b..c34aa18ee3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7887,6 +7887,42 @@ static const ARMCPRegInfo sctlr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
 };
 
+static CPAccessResult tcr2_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    return CP_ACCESS_OK;
+};
+
+static void tcr2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                       uint64_t value)
+{
+    int el = arm_current_el(env);
+    uint64_t valid_mask = 0ULL;
+
+    valid_mask |= TCR2_AMEC0;
+    if (el_is_in_host(env, el)) {
+        if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+            valid_mask |= TCR2_AMEC1;
+	}
+    }
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static const ARMCPRegInfo tcr2_reginfo[] = {
+    { .name = "TCR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 2, .crm = 0,
+      .access = PL1_RW, .accessfn = tcr2_access,
+      .writefn = tcr2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[1]) },
+    { .name = "TCR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 2, .crm = 0,
+      .access = PL2_RW, .accessfn = tcr2_access,
+      .writefn = tcr2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[2]) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -9157,6 +9193,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, sctlr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_tcr2, cpu)) {
+        define_arm_cp_regs(cpu, tcr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3360de9150..a4886f9406 100644
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
-- 
2.34.1


