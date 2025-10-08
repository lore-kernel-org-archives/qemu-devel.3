Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E4BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cAt-0004jc-7v; Wed, 08 Oct 2025 17:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAI-0004Nk-TG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:47 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9E-0006jl-UK
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b555ab7fabaso237200a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960595; x=1760565395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFbNyG4YfCBdo56bpCMCa6afE/l+HQuO8gQVSOvXGws=;
 b=NE+qtevp07BUnoQ/IP8u/EG1yevtg9fy3ybCICQlw3yVwCqOqzAnFxe/BmSkKY450y
 kQC4t1nAiBLLc3qdFzyAZFB8Lx0O/tJGWcug27S8YOvhNb50f9GiFJ9PB/2fHM0T28I7
 retKZIozhq9wod4EELKz1vxKqcKGYGBxKquSFAnZEeyn0SLKm9QFr6z17Tt/1+cDOVSU
 7OG59BZkr+lHTXvCV53O+WBrcdHwbaczx0euB9uLZXCI+ksEgfRe/POpO1rrrKxt2foe
 iNpLdVMuALXXHWQ1U7ytDAj7ta3qm164TBFEOydvMV0VUKKiR3/IAaEtO7VM1+0g+v/P
 Tlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960595; x=1760565395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFbNyG4YfCBdo56bpCMCa6afE/l+HQuO8gQVSOvXGws=;
 b=dfjfIgS3Y00hPKDJfylTzhOP2tV0QoL0DZlXlG6/l4QbTnaaYrJeBpT8gZU0Fd8ey/
 bHOS9FrZSebL2+dF91stbx5BkAFlz++RP/qGBGM7lD1qjbSTY6HbMuXo6ZuaJVLHHhvk
 ThrEt7/w8r+AbD/5FA+b6crjqbowbDNU6ezkhBfbC8+2pStcTKja0L3u8TNEeA01sNxM
 nPlZY6/yKIfDW5lH4k/jOZ6ey5UxcOrSdUOerHdiBCrA7KugFTCDp1VUwEp1vJRkz4O4
 l0NW/svaoPvRtTWjFAi7pmj2V/lDZFe5TIMFZvFuWIUG9+7n3/FRx2O4mUNNhXEq71OB
 lcQg==
X-Gm-Message-State: AOJu0YyzOyq3vq0cRBtf8HdhZj8nQZ7FnQYsaopi0WGb6e4hN+R8yZoZ
 y/EEuRYqD38zZ3YguIaraF4yJ9maV/KM449haySjGDL8DSzeVYvgUVrNPdQe435kPExPTnXQi4x
 9+xH9ZCU=
X-Gm-Gg: ASbGncsXTd6P8kuefvQeEj0S9MYkqJUmwAqZ7QSjYHwZTpE0PjM79e0FqLDa5NCc5wO
 h2MH3BTyT52dl0SvkBfaOSFaIaDr63X73bnAuD5T5jUBcKuxvFHDLvT8q/Jz+TckijHGhgMrRBC
 ShP1O9vN3QmBLcgfDRFXKyFmbojEP2KEQQl3vRonRVypUrMwnVIQoz2XfDpUips2vg6u8JvPG/P
 aLbT2/1a92ldWsZciHQUZ9dJv9wxAHd6aK0lbioyn+s5DZKaTYF4VqodPkQW1Cyo1zEw1MX4+o1
 D6/Qd54JnM3e7W5wxSQmvMuYNNzv5ESQu9fA36QX470DMctssPOk6Raiuq9KdLSItoAENrkqKfV
 5/hNm3TeeFNyDds47DOx57IDduEQluVww74oYvDWViX3zgVhRlK2T7NVD
X-Google-Smtp-Source: AGHT+IEVFXkc6uJwr2CVWiwXgnfe5GWiTo0AfYSKkthsPtkpWe5LUNDK2vNY4oB8/dwjerPBi1R/yQ==
X-Received: by 2002:a17:902:e78f:b0:24b:182b:7144 with SMTP id
 d9443c01a7336-290273565bdmr64092385ad.7.1759960594652; 
 Wed, 08 Oct 2025 14:56:34 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 31/73] target/arm: Add GCS cpregs
Date: Wed,  8 Oct 2025 14:55:31 -0700
Message-ID: <20251008215613.300150-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Add isar_feature_aa64_gcs.
Enable SCR_GCSEN in scr_write.
Enable HCRX_GCSEN in hcrx_write.
Default HCRX_GCSEN on if EL2 disabled.
Add the GCSCR* and GCSPR* registers.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h       |  2 +
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.h          | 12 +++++
 target/arm/internals.h    |  3 ++
 target/arm/cpregs-gcs.c   | 95 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c          |  3 ++
 target/arm/helper.c       | 10 +++++
 target/arm/meson.build    |  2 +
 8 files changed, 132 insertions(+)
 create mode 100644 target/arm/cpregs-gcs.c

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f48c4df30f..bd2121a336 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -779,6 +779,8 @@ typedef enum FGTBit {
     DO_BIT(HFGRTR, VBAR_EL1),
     DO_BIT(HFGRTR, ICC_IGRPENN_EL1),
     DO_BIT(HFGRTR, ERRIDR_EL1),
+    DO_REV_BIT(HFGRTR, NGCS_EL0),
+    DO_REV_BIT(HFGRTR, NGCS_EL1),
     DO_REV_BIT(HFGRTR, NSMPRI_EL1),
     DO_REV_BIT(HFGRTR, NTPIDR2_EL0),
     DO_REV_BIT(HFGRTR, NPIRE0_EL1),
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f3e90408f7..0f0a112c21 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1149,6 +1149,11 @@ static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, NMI) != 0;
 }
 
+static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6773676973..e55524ae10 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -580,6 +580,9 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+
+        uint64_t gcscr_el[4];   /* GCSCRE0_EL1, GCSCR_EL[123] */
+        uint64_t gcspr_el[4];   /* GCSPR_EL[0123] */
     } cp15;
 
     struct {
@@ -1717,6 +1720,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_ENAS0             (1ULL << 36)
 #define SCR_ADEN              (1ULL << 37)
 #define SCR_HXEN              (1ULL << 38)
+#define SCR_GCSEN             (1ULL << 39)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_TCR2EN            (1ULL << 43)
@@ -1725,6 +1729,14 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
 
+/* GCSCR_ELx fields */
+#define GCSCR_PCRSEL    (1ULL << 0)
+#define GCSCR_RVCHKEN   (1ULL << 5)
+#define GCSCR_EXLOCKEN  (1ULL << 6)
+#define GCSCR_PUSHMEN   (1ULL << 8)
+#define GCSCR_STREN     (1ULL << 9)
+#define GCSCRE0_NTR     (1ULL << 10)
+
 /* Return the current FPSCR value.  */
 uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 591b509e68..109aa104bf 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -251,6 +251,7 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_MSCEN    (1ULL << 11)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
+#define HCRX_GCSEN    (1ULL << 22)
 
 #define HPFAR_NS      (1ULL << 63)
 
@@ -1783,6 +1784,8 @@ void define_tlb_insn_regs(ARMCPU *cpu);
 void define_at_insn_regs(ARMCPU *cpu);
 /* Add the cpreg definitions for PM cpregs */
 void define_pm_cpregs(ARMCPU *cpu);
+/* Add the cpreg definitions for GCS cpregs */
+void define_gcs_cpregs(ARMCPU *cpu);
 
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
new file mode 100644
index 0000000000..1ff041811d
--- /dev/null
+++ b/target/arm/cpregs-gcs.c
@@ -0,0 +1,95 @@
+/*
+ * QEMU ARM CP Register GCS regiters and instructions
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "exec/icount.h"
+#include "hw/irq.h"
+#include "cpu.h"
+#include "cpu-features.h"
+#include "cpregs.h"
+#include "internals.h"
+
+
+static CPAccessResult access_gcs(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (arm_current_el(env) < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_GCSEN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_gcs_el0(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    if (arm_current_el(env) == 0 && !(env->cp15.gcscr_el[0] & GCSCRE0_NTR)) {
+        return CP_ACCESS_TRAP_EL1;
+    }
+    return access_gcs(env, ri, isread);
+}
+
+static void gcspr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    /*
+     * Bits [2:0] are RES0, so we might as well clear them now,
+     * rather than upon each usage a-la GetCurrentGCSPointer.
+     */
+    raw_write(env, ri, value & ~7);
+}
+
+static const ARMCPRegInfo gcs_reginfo[] = {
+    { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_gcs, .fgt = FGT_NGCS_EL0,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[0]) },
+    { .name = "GCSCR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_gcs, .fgt = FGT_NGCS_EL1,
+      .nv2_redirect_offset = 0x8d0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 5, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 5, 0),
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[1]) },
+    { .name = "GCSCR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 5, .opc2 = 0,
+      .access = PL2_RW, .accessfn = access_gcs,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[2]) },
+    { .name = "GCSCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 0,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[3]) },
+
+    { .name = "GCSPR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL0_R | PL1_W, .accessfn = access_gcs_el0,
+      .fgt = FGT_NGCS_EL0, .writefn = gcspr_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[0]) },
+    { .name = "GCSPR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_gcs,
+      .fgt = FGT_NGCS_EL1, .writefn = gcspr_write,
+      .nv2_redirect_offset = 0x8c0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 5, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 5, 1),
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[1]) },
+    { .name = "GCSPR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL2_RW, .accessfn = access_gcs, .writefn = gcspr_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+    { .name = "GCSPR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL3_RW, .writefn = gcspr_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+};
+
+void define_gcs_cpregs(ARMCPU *cpu)
+{
+    if (cpu_isar_feature(aa64_gcs, cpu)) {
+        define_arm_cp_regs(cpu, gcs_reginfo);
+    }
+}
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9bca1b8eae..4d649bb69c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -635,6 +635,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_gcs, cpu)) {
+               env->cp15.scr_el3 |= SCR_GCSEN;
+            }
             if (cpu_isar_feature(aa64_tcr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_TCR2EN;
             }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6642cae0cc..64b6c21aef 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -766,6 +766,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_ecv, cpu)) {
             valid_mask |= SCR_ECVEN;
         }
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            valid_mask |= SCR_GCSEN;
+        }
         if (cpu_isar_feature(aa64_tcr2, cpu)) {
             valid_mask |= SCR_TCR2EN;
         }
@@ -3953,6 +3956,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_sctlr2, cpu)) {
         valid_mask |= HCRX_SCTLR2EN;
     }
+    if (cpu_isar_feature(aa64_gcs, cpu)) {
+        valid_mask |= HCRX_GCSEN;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4023,6 +4029,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             hcrx |= HCRX_SCTLR2EN;
         }
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            hcrx |= HCRX_GCSEN;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
@@ -7260,6 +7269,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
     define_pm_cpregs(cpu);
+    define_gcs_cpregs(cpu);
 }
 
 /*
diff --git a/target/arm/meson.build b/target/arm/meson.build
index f9f0beef05..3df7e03654 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -27,6 +27,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c',
 ))
 arm_user_ss.add(files(
+  'cpregs-gcs.c',
   'cpregs-pmu.c',
   'debug_helper.c',
   'helper.c',
@@ -47,6 +48,7 @@ arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
   'cortex-regs.c',
+  'cpregs-gcs.c',
   'cpregs-pmu.c',
   'cpu-irq.c',
   'debug_helper.c',
-- 
2.43.0


