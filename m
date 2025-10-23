Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE2CCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjX-0004km-4J; Thu, 23 Oct 2025 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjU-0004hP-JF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjS-0005Xr-Cd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso8919105e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231361; x=1761836161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zV2O1K9FAOj3weOgVlvfzjuE2Cy/rzQpAEyUU6aqb1I=;
 b=CUOEhymDu/God46eyMshKVD3DM/boc+hmEnoLtSPWyajlZzliJxAirj4Fx3kBgdWeY
 Sl6E0Xq9GHeFp8a6wwHA9sd+lMfxLNXUA1qdm4zKprXMzspEGk/fsWYfXH01wrZswu9J
 +TfsC/5bHYRIdf2xnlt+/sM8EYOORIMHl2sRYsSnI1ldZTslli48r8xJn5AA4K4iRops
 cxZYLSCMDWrl5xo8NTVtEf4UsGBmjBwtmJlwY9w4iEHowTPhu1BS7qOiVxtIYBYNHeOS
 FBGnGl6XWCBN53sN7e/9ypUGakMCSGC2jyJSJkrT5ElvAO5bVcrSCXhM0iCDCdtthvIw
 Z0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231361; x=1761836161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zV2O1K9FAOj3weOgVlvfzjuE2Cy/rzQpAEyUU6aqb1I=;
 b=ZL/az4nLM6pim8S8uwKbRz1jrWsPxLkSSOi+TDoym/++jlUkmFeMmVmjqzK22XouMq
 8SVpZyS8dh/vcR3X9lVYa66bbxOUzygKihNJ1656UgZ0UlLmOId0jpk3EkIBu7pzNJ5l
 Pe/0UFQV7Btgf192BsZHAa78hLZ4WZQgshvTW4auou/zvqrrAsnDX0V2BQoXzYZSdInq
 Xxh0Z9ztjlW+oHn7Z1z4MrEQEWTmMtA6Kc6IUzzJeHorFBqYtOAemGhxUlyA934LBo1K
 Q1qidtUCS7e7pKdSQGTY1EvxXecQ8JLxSwc+z1CTjHNiWKxOMMjOhs9BuHw/zpvUdBeY
 LyXw==
X-Gm-Message-State: AOJu0Yx52RY8InDhDRDRmT40Yc7vIVS4cbGUaLVO8xj+A9UOQRWPEmS/
 VDGyLJ6vuWCMSlQaIaXV1aeJhl1+Z54T6b82ZTeKJTHcEKxgXtyRA9SvhbJHzs+2jCS2fPqMXpV
 awJFV
X-Gm-Gg: ASbGncv7oslb1z0LHNd7kgB5xJ0Hag5d5thG64/bcumdwIC63jSjVC186mzK9arxhmH
 PEodqVGaTF8wml3BgmTOHkMcOKZJBq2Q3a/nKgJ23yQEJ7dEUm9nAVCQZ9XhM9zx0eHjs8oeswd
 E7MHE873+hqTED1BlYbpSlYWD3cFZcf+An4zZIk4BwaTKJiztnDfpdjyUy4k7/d1AHEAe+7M2y5
 ulE+VghqdTeqhDlARft1lDKuHVTmfk0uvtJdWniV0KnMjOPtjzZs/oJaHFppHh5O2jngKLa6igi
 ca/FATTF/XgekFpnxWJqa8yeop7VjtPW5badEggy8yuseT9ZlTF8ogm5cBRXtMD6oE00BDBmA0W
 9kwpLDz7ZnkVQJdzFI2/ZP7wr48JaR9IITXH4if9hXf0y2Z2OELxc6AO7OMy3si8Yp0Dr4X6RzL
 tUVz7nXm2dcfOeHlUX
X-Google-Smtp-Source: AGHT+IGQ++OACKOWsCfYi1J/IimjEUGOB1qlRqbwAZ5KLy/WQ4bSO2pNWs5jT66MXKslcJhrjn6HSg==
X-Received: by 2002:a05:600c:3e8f:b0:46e:4b89:13d9 with SMTP id
 5b1f17b1804b1-471177ad526mr181339875e9.0.1761231360708; 
 Thu, 23 Oct 2025 07:56:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.55.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:55:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] target/arm: Implement MAIR2_ELx and AMAIR2_ELx
Date: Thu, 23 Oct 2025 15:55:42 +0100
Message-ID: <20251023145554.2062752-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Enable the SCR.AIEn bit in scr_write, and test it in aien_access.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251014195017.421681-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h |  2 ++
 target/arm/cpu.h    |  5 +++-
 target/arm/cpu.c    |  3 +++
 target/arm/helper.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 763de5e051c..48a406a5fbc 100644
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
index bf221e6f973..7c226a112d5 100644
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
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3b556f1404e..d2fc17eab63 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -652,6 +652,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
                 cpu_isar_feature(aa64_s2pie, cpu)) {
                 env->cp15.scr_el3 |= SCR_PIEN;
             }
+            if (cpu_isar_feature(aa64_aie, cpu)) {
+                env->cp15.scr_el3 |= SCR_AIEN;
+            }
             if (cpu_isar_feature(aa64_mec, cpu)) {
                 env->cp15.scr_el3 |= SCR_MECEN;
             }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 167f2909b3f..e4d16514409 100644
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


