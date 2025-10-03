Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F3ECCA472
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jGv-0001WY-Vb; Fri, 03 Oct 2025 13:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGq-0001Tv-T9
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGP-0006Ee-Bx
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so20002895ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511286; x=1760116086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNpaLDZYgB8xbPGK/MOC8RoLRhYJfq+elYw9mU8atPA=;
 b=AwfqC7bi3GEEGSD4or+fSJtdp1ZjWKztSU3iENGQfbcaaIZHjHF77lsjp3nJEAmVPy
 ld0y6Dd3TwCGzB432B5mkVMEGfQZFqJGehW2WiC9NyW/SV3Bo6OvmWwtIl7z83oC8rmQ
 G486eiTzDJ7fboU1hHzjBdEuW4Yx+d7fu2Ki9I3YehjBhq7A3GcgnmEvpUznN3Gmhl0i
 7GPxvEJefRvNTkq/5uoIi9Ks1bD/v47k5H4HeTgHKMTwJ39Yz3rpUBJn0scPerX5tpAt
 W+LsyLRXH4Yvz2BLUya74uj8du0Uml2JeX7jcyo3ZUlzQ8xeZwiyg9bfnkVaUv4MhEKN
 zsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511286; x=1760116086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNpaLDZYgB8xbPGK/MOC8RoLRhYJfq+elYw9mU8atPA=;
 b=r1OaURgHEiUfUPgMglWqWb18PBkfnsrEGEpfBy+r4v8n8YAaP7uXh/NRfk1fvn45BM
 cco3uigcEhQlnWSz7yjZvfZ1rCjpspaDasSlclw3fILlmlSHxVIPHm9nghSWRzKRajma
 nKrMxmoLiDyOLlyNy4o7QUhwzK5GIEupyx+Or+pl9ye+MKZNrQOBU5sYZlqEK6q+ECdW
 kCSitp/rtuVH86wNPpWwVk4Vy1DK1kGOPR8TtL3Gce3CTS26YKI5kdX90wSUHj9DJ9YK
 VqXGnDFQi8Pf2f9A6f0vu//a2CS4kuEHK4LgGs8LDT4IVBIXJcOmTsofL1fQ4fCR0HoL
 UuvQ==
X-Gm-Message-State: AOJu0Yy+BVCuQxbC+XlkD540EvsUykuVnZesQNKE3ZVaMD2VBexD4B95
 uqVusg5gL4GmZJgtAzcw7KzwQPUY9Uhr4zLi/WFBAg+QDJM0scfTWvQMf4Uil+vgG7pEkdgdzYs
 YbVnufOM=
X-Gm-Gg: ASbGncuJbMNn/GPldyNTH6xDwnVPdmpchj9qCBBkUxzdfT8sf7+JSg4yXuChJxvrZwP
 GW/9Ald1633WgaVgro9S5j5kfErLPFti+v0AFAw09jdIYNRoDRdRz3vjMI9AyL0JXHOAOGDeQ5b
 k3JdZnvMjnJwzGLLQDQa7HSZ9SHgRhuq9l2jlCols0UaH2PNQniUYHunJbX7OlQ00KyFlSwo/83
 gUY49awsuhE2gk13yfsbxu8EakmpoH85iebZvpTHCifhl6rtpsnT79IBTtsLgdi+/7IORTKoqpq
 0jq/xkGeZx6zXz8ibFU3coaNg5AZ7W2cWsth9RjKBq7dpCv0qlx8p+9Ygg2u2hLmiEH0RKsnn8J
 ojpaWE+4RTJxgGrdWM+Bi49Z7HR5mfIDV04diI6xAxv+5gCY0pusPGA5S
X-Google-Smtp-Source: AGHT+IF16yWPPftN7uZmloYOlER/Djt+VCsEBJvmXMWr6Cn9UKB6Hru+snfPW0bT3MTvug62yGT0Fw==
X-Received: by 2002:a17:903:ac3:b0:267:f121:6a88 with SMTP id
 d9443c01a7336-28e9a6dc287mr44449255ad.42.1759511285638; 
 Fri, 03 Oct 2025 10:08:05 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 04/73] target/arm: Implement PIR_ELx, PIRE0_ELx,
 S2PIR_EL2 registers
Date: Fri,  3 Oct 2025 10:06:51 -0700
Message-ID: <20251003170800.997167-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |  2 ++
 target/arm/cpu.h    |  4 +++
 target/arm/cpu.c    |  4 +++
 target/arm/helper.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 57fde5f57a..f48c4df30f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -781,6 +781,8 @@ typedef enum FGTBit {
     DO_BIT(HFGRTR, ERRIDR_EL1),
     DO_REV_BIT(HFGRTR, NSMPRI_EL1),
     DO_REV_BIT(HFGRTR, NTPIDR2_EL0),
+    DO_REV_BIT(HFGRTR, NPIRE0_EL1),
+    DO_REV_BIT(HFGRTR, NPIR_EL1),
 
     /* Trap bits in HDFGRTR_EL2 / HDFGWTR_EL2, starting from bit 0. */
     DO_BIT(HDFGRTR, DBGBCRN_EL1),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b9585dc80..55c00f484b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -368,6 +368,9 @@ typedef struct CPUArchState {
         uint64_t tcr2_el[3];
         uint64_t vtcr_el2; /* Virtualization Translation Control.  */
         uint64_t vstcr_el2; /* Secure Virtualization Translation Control. */
+        uint64_t pir_el[4]; /* PIRE0_EL1, PIR_EL1, PIR_EL2, PIR_EL3 */
+        uint64_t pire0_el2;
+        uint64_t s2pir_el2;
         uint32_t c2_data; /* MPU data cacheable bits.  */
         uint32_t c2_insn; /* MPU instruction cacheable bits.  */
         union { /* MMU domain access control register
@@ -1720,6 +1723,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
+#define SCR_PIEN              (1ULL << 45)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 30e29fd315..9bca1b8eae 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -641,6 +641,10 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
+            if (cpu_isar_feature(aa64_s1pie, cpu) ||
+                cpu_isar_feature(aa64_s2pie, cpu)) {
+                env->cp15.scr_el3 |= SCR_PIEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a2149c105a..c9a8012880 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -770,6 +770,10 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             valid_mask |= SCR_SCTLR2EN;
         }
+        if (cpu_isar_feature(aa64_s1pie, cpu) ||
+            cpu_isar_feature(aa64_s2pie, cpu)) {
+            valid_mask |= SCR_PIEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -5935,6 +5939,64 @@ static const ARMCPRegInfo tcr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[2]) },
 };
 
+static CPAccessResult pien_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_PIEN)
+        && arm_current_el(env) < 3) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult pien_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret == CP_ACCESS_OK) {
+        ret = pien_access(env, ri, isread);
+    }
+    return ret;
+}
+
+static const ARMCPRegInfo s1pie_reginfo[] = {
+    { .name = "PIR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL1_RW, .accessfn = pien_el1_access,
+      .fgt = FGT_NPIR_EL1, .nv2_redirect_offset = 0x2a0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 2, 3),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 2, 3),
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[1]) },
+    { .name = "PIR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[2]) },
+    { .name = "PIR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[3]) },
+    { .name = "PIRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 10, .crm = 2,
+      .access = PL1_RW, .accessfn = pien_el1_access,
+      .fgt = FGT_NPIRE0_EL1, .nv2_redirect_offset = 0x290 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 2, 2),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 2, 2),
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[0]) },
+    { .name = "PIRE0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.pire0_el2) },
+};
+
+static const ARMCPRegInfo s2pie_reginfo[] = {
+    { .name = "S2PIR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 5, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .nv2_redirect_offset = 0x2b0,
+      .fieldoffset = offsetof(CPUARMState, cp15.s2pir_el2) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7167,6 +7229,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, tcr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        define_arm_cp_regs(cpu, s1pie_reginfo);
+    }
+    if (cpu_isar_feature(aa64_s2pie, cpu)) {
+        define_arm_cp_regs(cpu, s2pie_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.43.0


