Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE315C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufw1a-0007GN-PG; Sun, 27 Jul 2025 03:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1U-0006S3-2t
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:20 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1R-00016E-Vn
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:19 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b390136ed88so2609271a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753602135; x=1754206935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZEiredJhDqkeFwlGWRs9PoM2IRfxTwE098IMi+CROg=;
 b=Ieogk1CU26FotQWi6k0KO91QMTswGgwiQNHzYu/QNDP7uAZnjNKoqEzUqwYuM8dkF2
 M7QrZ2/+fcmo05IyvAhZuYKwropQBF4a0XxkutawT4JCHoSifGbZKa7pWD3G+iyHMpCm
 no6ahfGyJNgiJK1x4/OZZH/xFl+FWSgw1urxKfWwou9XKrm8lsAZtmtHYvDx0V5tC01s
 endK9T4oiIoI6k+EnPLNeu4q+I7r0NgvEZJv/srKicT8SPWRuVm1sp7/wihnzn0gMm3m
 umG9wEqWzR0JaVnENb1P/xanFEY6FSc0JeoXS1RhPo6kK0kVaa/PC9UnWQZx4wnexofK
 oTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753602135; x=1754206935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZEiredJhDqkeFwlGWRs9PoM2IRfxTwE098IMi+CROg=;
 b=JOrLITJwT6rN0eRE6LnLNxH26V7fUUtgaOxcmjAKH8MfZHJaxe7Zu5pPvEHSQ4FrOq
 4BBrrXJ+1zlSSxuIO6Q8Lc/8horbINY9RV3W4cqZOgWobBYMZExf1MUnQ1kd7gJSgas0
 wdevjCGQaXEE7/DY68LfhH0SNeLkCVG9ajGEUB308fhgAEMkHccRIkMCm7WA4Nd9yL89
 iIrN7idVpgURA48o16BXog9sG+2C8L/YHA5hXDft/LqW3BENVP1LzRLrw01Pv1DXysX1
 SO1aMrzGMmFNBWkfjWbBweVQftn8eRwKBLfsAoE+2nFU/EpoNLxnCN904PD3k2H49SmP
 ewbg==
X-Gm-Message-State: AOJu0YxPaDB78vrA5J2nrx4qhKfyoFD0svuEA1n1PDE6I61SYOD7UZLx
 G/86sdkHZIPUPHSzRe08DQho1BxAUzmuHxLZAJCDZyxcE9CeEV8+gnlo3bgUrksufIrJgkwZzZr
 Q3Azm
X-Gm-Gg: ASbGncuQ3YtZor9dV8svn6BSP2e6O/uw/vyLx0LJqm/QXxlQrN+pZ+2W2lWZMwCHqGn
 WR4+iK18KWcIruXO7AODQQNFddm1+Yni+NVPnRWQKKu9c9NQr21ym51c6bxImLZ1c56wgswKd6E
 DDAjcS/GlsYFBEzCruleW6D2jojgFJzoJ1s/JzclZNZr9lpkrbsPk+RGETLKw5ITTZrr0rTpzCF
 35Dx8JEpTHTa/ZYovH3JGzDXk8qePfHsX4OsZM17bAljuF0wFgiwYVRNKw+JPmCUvjhRFAb3vgx
 LRqYwKD8ZNhv1Z5J9jr/fkhP7vsecApH3dcdWYesdLPBECb3zPjIwVQEyFpDkllMFc9kYfivtO6
 f833OA89/GvCiabF4RdeEEg09ddEiCK5J51pj7C4c08O1YbinsvNB0AXLwgsRwhLAvahaIspZgb
 /8a/0q9BBZLQ==
X-Google-Smtp-Source: AGHT+IHlnv3cRavrG/Z+dmdJIbWIeUqVaf/04dVWIjo/GK8lSsQasIEfOjU6+ZkzrLZyZWdTBOeeuQ==
X-Received: by 2002:a17:903:32d1:b0:234:ef42:5d75 with SMTP id
 d9443c01a7336-23fb3032327mr109497715ad.20.1753602135264; 
 Sun, 27 Jul 2025 00:42:15 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe53b546sm29633055ad.177.2025.07.27.00.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:42:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v9 5/6] target/arm: Implement FEAT_MEC registers
Date: Sat, 26 Jul 2025 21:42:01 -1000
Message-ID: <20250727074202.83141-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727074202.83141-1-richard.henderson@linaro.org>
References: <20250727074202.83141-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Add all FEAT_MEC registers.  Enable access to the registers via the
SCTLR2 and TCR2 control bits.  Add the two new cache management
instructions, which are nops in QEMU because we do not model caches.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250711140828.1714666-3-gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Squash 3 patches to add all registers at once.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h |   5 ++
 target/arm/cpu.h          |  10 ++++
 target/arm/internals.h    |   3 ++
 target/arm/cpu.c          |   3 ++
 target/arm/helper.c       | 106 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8ec8c3feb3..9579d93cec 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -914,6 +914,11 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c15d79a106..defe2852f2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -578,6 +578,15 @@ typedef struct CPUArchState {
 
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
@@ -1730,6 +1739,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ffc981c3b6..118659815f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2001,4 +2001,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
 
+/* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
+#define MECID_WIDTH 16
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 27a4610da5..f0545a276e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -650,6 +650,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
+            if (cpu_isar_feature(aa64_mec, cpu)) {
+                env->cp15.scr_el3 |= SCR_MECEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5a219703ae..20b69a12df 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -747,6 +747,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             valid_mask |= SCR_SCTLR2EN;
         }
+        if (cpu_isar_feature(aa64_mec, cpu)) {
+            valid_mask |= SCR_MECEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -5215,6 +5218,93 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 2) {
+        if (arm_security_space(env) != ARMSS_Realm) {
+            return CP_ACCESS_UNDEFINED;
+        }
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
+static CPAccessResult cipae_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    switch (arm_security_space(env)) {
+    case ARMSS_Root:  /* EL3 */
+    case ARMSS_Realm: /* Realm EL2 */
+        return CP_ACCESS_OK;
+    default:
+        return CP_ACCESS_UNDEFINED;
+    }
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
+    { .name = "DC_CIPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 0,
+      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
+};
+
+static const ARMCPRegInfo mec_mte_reginfo[] = {
+    { .name = "DC_CIGDPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 7,
+      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
+};
+
 #ifndef CONFIG_USER_ONLY
 /*
  * We don't know until after realize whether there's a GICv3
@@ -6053,6 +6143,9 @@ static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6062,6 +6155,9 @@ static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6122,6 +6218,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -7377,6 +7476,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, tcr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_mec, cpu)) {
+        define_arm_cp_regs(cpu, mec_reginfo);
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            define_arm_cp_regs(cpu, mec_mte_reginfo);
+        }
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.43.0


