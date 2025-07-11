Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B073CC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaERc-0007Uv-T8; Fri, 11 Jul 2025 10:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQt-00065p-MW
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:09:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQr-0005u0-1V
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:08:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-75001b1bd76so44230b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752242935; x=1752847735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXq6JDwmQdugL9yo6UYceXuTats6vvxMBcprOhccZiU=;
 b=EPt9Qn5Ya27Glm7ciAd50lgLhp5bkHVfdzITaR/ZKP2FyK7v6qD0DrDcQnQTjcxOnA
 hKKODUopXPKDPI0ZHQg7NSMtog7WnSkAu+5bRU8CkdP9aaqTpDB5KOU9v8IXFoSjAatz
 LJVT5+LO4m0pB2NxzaUm+Nd8uTdq04dd5++lx8l8LEvqtxmVSp3IXqazk9wuE9iKVeZf
 5idPZYKGaTdGRLUHDe7NXFkNi0ozLB4LeEOHln1nOWNJUufloTiPRgWBvQW9SEzlyA0e
 9MSCJL6QVMoJnDCGo5BwoKqMubVmm5zIdZVINPo1XApbBARQZq01UXIAweWJKmDmW5Jl
 t5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752242935; x=1752847735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXq6JDwmQdugL9yo6UYceXuTats6vvxMBcprOhccZiU=;
 b=S3KFRCOnvW9tHRw8FQec8M5kqV02qh+ZHjGaCqflwi7qXsxvy6xZoiDAE2aHMd/TSa
 QTrPCfc05fM0CDz6hbZ4k2eIeUKaYfesrAqzVxcyymC12dTc5y9q6GpFYmRbtGSHI5g7
 niD5O+eM1eZEf532vksVmMft+oDtOJcHgsKQxLZo3iO7KCHF8OHf7H3Z9F39V+gVS9s2
 iX64KGLtZyXMX9VpBmvzdGfcMcty/TW+xrV3DX8rR7jFeXB+nFTBeQe/dTWxIdaEASLE
 KTYEQOKqfhZUvbHYHsIUi0j6Pk41bV7SBsXICejsFuQgUFEtHBD1ijKRsiUxD6ZBE9zb
 Nfyw==
X-Gm-Message-State: AOJu0Yxy2ZLgn4m9gkgyfySH0BKxDgAzz22NGN5uc76EZ9ktYu+9RKes
 BCLmWYAJBmllJN8pwlQ+sSLHRzNy47b/nUgUDnTZBMbiaVuY44vNE3XNCr7kL0+gw44o0OgNwsh
 fiGpM++8=
X-Gm-Gg: ASbGnctooYxAP1apBy0+9S7AySDtJptv7+NuoAinNDLGO8r/CT19D15/FqPckCPpH/8
 ELoS0HFhBAE0Vj8kB2A5dqxGe3zOx57K1MfFXrZxBfj5HFaVFYarp2pavnUxKBjfrH9Vdwca+AK
 H68Xp2ctm53tIDb5E5JiADHleJ3I4L7jWXP9wwUSh0NPupz7WydPbFOIJwORe3sRr5wQLpHc+c0
 1Jo+S9mfDYasmZ/k5r7U6h8jS2Rj1JKI+droh+gliAMKad9szSlcHMs7XpfYmP63fEddKjMbCNZ
 JSNoGxY/rYqYyGfFxU4h3LcBDwr1XsGQ99rP77bHOTV7wIHPVyfVG5P2nU8U410CrwMNwQeU/lv
 bj5BlSruNzqcEoqezJHHlHvGkDPkV2RP2TJLHf/Z+KY2UentXvx5C0kfRkg==
X-Google-Smtp-Source: AGHT+IHIVLUj3oceGyhUjkEvKv8Ms1iltDPlo4nz/dBJUKTEVJeZoMpKgu2HtnZBAIJDBewlnyXRNQ==
X-Received: by 2002:a05:6a00:2352:b0:730:75b1:7219 with SMTP id
 d2e1a72fcca58-74ee2557a1fmr4174169b3a.12.1752242935399; 
 Fri, 11 Jul 2025 07:08:55 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5d3esm5702280b3a.4.2025.07.11.07.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:08:55 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v7 2/6] target/arm: Add FEAT_MEC registers
Date: Fri, 11 Jul 2025 14:08:24 +0000
Message-Id: <20250711140828.1714666-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711140828.1714666-1-gustavo.romero@linaro.org>
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x432.google.com
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

Add all FEAT_MEC registers.

To work properly, FEAT_MEC also depends on FEAT_SCTLR2 and FEAT_TCR2,
which are not implemented in this commit. The bits in SCTLR2 and TCR2
control which translation regimes use MECIDs, and determine which MECID
is selected and will be implemented in subsequent commits.

FEAT_MEC also requires two new cache management instructions, not
included in this commit, that will be implemented in a subsequent commit.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.c          |  3 ++
 target/arm/cpu.h          |  9 +++++
 target/arm/helper.c       | 70 +++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h    |  3 ++
 5 files changed, 90 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5876162428..72b6fd9b27 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -904,6 +904,11 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) >= 2;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 08c43f674a..8da8d13e4c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -645,6 +645,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_mec, cpu)) {
+                env->cp15.scr_el3 |= SCR_MECEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ffc91d6b49..e3975e687e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -576,6 +576,15 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+
+        /* MEC registers */
+        uint64_t mecid_p0_el2;
+        uint64_t mecid_a0_el2;
+        uint64_t mecid_p1_el2;
+        uint64_t mecid_a1_el2;
+        uint64_t mecid_rl_a_el3;
+        uint64_t vmecid_p_el2;
+        uint64_t vmecid_a_el2;
     } cp15;
 
     struct {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c1299ff84..bb974647ba 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5196,6 +5196,72 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 2) {
+        if (arm_security_space(env) != ARMSS_Realm) {
+	    return CP_ACCESS_UNDEFINED;
+	}
+
+        if (!(env->cp15.scr_el3 & SCR_MECEN)) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    value = extract64(value, 0, MECID_WIDTH);
+    raw_write(env, ri, value);
+}
+
+static const ARMCPRegInfo mec_reginfo[] = {
+    { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
+      .access = PL2_R, .type = ARM_CP_CONST, .resetvalue = MECID_WIDTH - 1 },
+    { .name = "MECID_P0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p0_el2) },
+    { .name = "MECID_A0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a0_el2) },
+    { .name = "MECID_P1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p1_el2) },
+    { .name = "MECID_A1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
+    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
+      .access = PL3_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
+    { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_p_el2) },
+    { .name = "VMECID_A_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+};
+
 #ifndef CONFIG_USER_ONLY
 /*
  * We don't know until after realize whether there's a GICv3
@@ -7223,6 +7289,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_mec, cpu)) {
+        define_arm_cp_regs(cpu, mec_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4765e4489..43cddd95b4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1987,4 +1987,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
 
+/* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
+#define MECID_WIDTH 16
+
 #endif
-- 
2.34.1


