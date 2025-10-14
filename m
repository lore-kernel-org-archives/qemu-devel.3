Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6516DCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8l2j-0001eV-00; Tue, 14 Oct 2025 15:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2X-0001a3-HL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2R-0003PI-T8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-781251eec51so4779235b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471422; x=1761076222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLWvUqmmBANKsaF5zaX5lQHObBvuZy86Gts19KQtK6w=;
 b=siwZYPlEVlKtEU4zyVBrILUXVepO+jkn2qg/184Htwk+k4HZ8iPHtMTsfcta2IOXx3
 BZdjl0uAisliXeH/wQHDo3X8O8x6U66cQ+Ewlr7FE7Ftwunn8QcNElLMe8wJ+H7I50On
 y/gU0+rymb4NmKZTlqBZ6KsdqGenashFS+6aj53vs03umB8HdpUq+tuH/C4FAQZLdtvZ
 zuAdPqBa4nlAQFfP1TFUN5scqKA7SjrplfERtHE/ImnUeL3oSV6zIQmIRKYtUgMhr1EE
 LIxymcVOFqIowYhJ78/VOylDngr29Y1FAbcSK3ADfkMhU44I4iZFzyuTxZfCH8ANEfn3
 WV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471422; x=1761076222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLWvUqmmBANKsaF5zaX5lQHObBvuZy86Gts19KQtK6w=;
 b=iRyYW3nqF/G9Ps0wn8uhzxYSvwuRFr34uTDx5vE1K36jvkj2xUdj/TjMJTF1AFl0Uw
 BUfDWToKODogxre99CnitHA3WtfEfpFRx6DAq1c7o2oC9hSvNmB3bpUe7O8+HFU6LHYQ
 ZntcEhhcouJFAb0UfSeCrsI8oAn9HGXQPn3zHLZ9oUz7bQZnHA6XWgIE3V6NB3OMerIk
 ReT7OqWY7hhf0QGtRyx7S5y2El1PgRE4usc2/O827TH+sBn5Gna9diM97iDB2VP0HP/4
 IGTnsmsXxtdII2fvJRfltDv/e/d8c1VXlrdhYZD6bHTGmW7rzhnX57CkeL9sD3FmX84W
 m3HQ==
X-Gm-Message-State: AOJu0YwZIWJhy9Brr3pTFqt5APjqKYcTbqkox3rtQqSvw/Ox5bYb4j9E
 yYX8UOr/I3ZavhYxbaeotjwW8nbxSbrdPyZ4nffYo8EAmKwZiyt71FbA71nneTs0MDcMxMMyhhM
 z+U/y25w=
X-Gm-Gg: ASbGnct8fDmRbe0v1W1sjCWKj7jrk711i3nFl+Nyhvs7fXt4FWS+Gn4sx0LXcKiqFKa
 ke973i8PfKdfR8EYU/+jnQGk8PIPMR5L/9d8JkcjzQM6WRAzK3giIB4AKvuAAesY2eXaXCG6czG
 zHunKK6u3UvuW8MK8iwrti5Ww7XqC+QoTZs7gQZWnQoZboKmyl7hXXr+4cx4hOXNeUlcLjm+gNN
 tyQLcWcc0BaS1Cvd0GblLQRTEDBAnHjAidOBOg39D6nQ0Azg4z4UZ4DgqLauWSvwr1/dOgAbmHl
 /Eld/z4CuH3BAzRNvSoWnEe1/ul9twsc+G7XMOzbx5iN9HSgAoZor7rVfeab2rz6XrAN9x1ti9W
 YH/hwbX2xqyWRVK3HcVwJco5k8otbjfeGAk5ztCTLsLhYHoEjdvw=
X-Google-Smtp-Source: AGHT+IFO+jcUMFNDnlWEPK/csFK/QMM1pst4KCKWDs40eylcmd6uLUfhUUPiUV4sgNL1nYfLbGs65w==
X-Received: by 2002:a05:6a20:a123:b0:243:d1bd:fbc9 with SMTP id
 adf61e73a8af0-32da8462b41mr36584149637.56.1760471421934; 
 Tue, 14 Oct 2025 12:50:21 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b63a03dsm15918727b3a.19.2025.10.14.12.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:50:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/7] target/arm: Implement MAIR2_ELx and AMAIR2_ELx
Date: Tue, 14 Oct 2025 12:50:12 -0700
Message-ID: <20251014195017.421681-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014195017.421681-1-richard.henderson@linaro.org>
References: <20251014195017.421681-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |  2 ++
 target/arm/cpu.h    |  5 +++-
 target/arm/cpu.c    |  3 +++
 target/arm/helper.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)

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
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3b556f1404..d2fc17eab6 100644
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


