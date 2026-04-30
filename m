Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19981FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9q-0006YM-9Y; Wed, 29 Apr 2026 20:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9V-0006Nc-3F
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9T-0006G4-ED
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-83177129e28so162057b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508470; x=1778113270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73otMSm/BuymaPP3YE3sIV7Wl7PcxvDt8khsJ+zToKU=;
 b=Tu7VGxMXw83S2Iu4tUFkFXu9MorQ7OxPXFZf2LUfKgtN6kgLoZj8TnBda880tdDsv3
 EksPOz3Bv/le7XNWm4Angpi/pmxs1VheF70T6jafruXV3xlzcRc5htR6utF4m8JnRhWS
 mUPQwEcWUdoX7axPZ7Nl4/bgIe/nZ1DAmWClDMO2Qc5DYKPSP/dfQYAdvLhaaqsyYT90
 5hXnnYZjHvvxtcpGoUBJ+hBu9mfUEI0Hc34upzIgrodVahCRisV6vWVNbo4ggGbDyNBa
 bfoa6N7fUlsjwLT+TrnFQmtZfmiCCkf9CC39NYn8wN6jsft+fFA3QwFXnxQrKvZFR0J7
 afgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508470; x=1778113270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=73otMSm/BuymaPP3YE3sIV7Wl7PcxvDt8khsJ+zToKU=;
 b=hR3GGgVa05YQvTgcuJ1U8kBQ+5SImny4P3H7QKTb3vvWsc64LWWvlL+ZQhc96pIhK7
 TgKnXtAb5lFxc5ZkoRDhZZPaHyxIXOmunLuAH5ourYEfH0iXrYB+7wOvNQak1ZzsT8yt
 NvF+yRulaZSl5Eenw79/+9ax+lCvM6UWGc2gn3BIJYLnMJ8cSgQQJEVf+j4xaJa5w4aL
 jDG1Hij4KWar2apvC/bX2xaPJNbPEZhNdfQjcfO+Wl1PNAi6waJWl9h6TzVQq/cGobGy
 v4ifnR+Lk7PfWx9rEouqK2yuqmYGj/tXc5o3C16vFcI+TiSnY65W1v4gLKXdmVQQSoZ2
 xpug==
X-Gm-Message-State: AOJu0YxV/DVWrfvDxfTdqRuKj3NvWgUjToql7k0QAxeTyScnMhuE69rW
 UjmWSNKPg/0LDDQ/2tO3hZidnhyscVX+StF1TwvuwSyAyS68bS8IxEOWpav/uvqRlSGAX2KSvck
 mU+XDfO4=
X-Gm-Gg: AeBDies87KRTcvV8zOdd9yf5GyIyX+y4tAZW+R32NgTulZxxON4qzHJ1pV/QjgYlNwQ
 4yagZ52RMp3RTXgGE9Dj86TPZsGcRcVJHKsCLfVJpfnLkgRGeUX4eOYGTTMDacVV5Y7uwkuNBI8
 9Br6lh/0eervmfg5Vsia4iR3OG8g4wSdIiDFZBLITtd/EPHdZ8eXWlpUPFPWz5+SJYaqvleQADr
 WIhwXyia9IZ6d4YewCKsMS+F5dl9B59ylyMlIydcD6Duqha4rcubUdd0/Rc25ndZdQzo8MLnRA7
 rum1fTN+/MPbgkIUQ32KdLmlGtUKgV2a9S+gAjmN80YqZvEjMEF7qgmRZpID1V/p+sS4TO2edYc
 7bg7ucfuDzjJjqfM/4WuACvhr0WmeW985h1iEAvyzyJcNSLR1M1ORJS86ebT1o/hx3LVikgwqPJ
 iQtI4yBG68QmNnwtRDuxYxnrOF+TH41Br6niSTt67BujzNjJUCQxU=
X-Received: by 2002:a05:6a00:a256:b0:82a:6de8:fa50 with SMTP id
 d2e1a72fcca58-834fdb87d67mr842175b3a.18.1777508469869; 
 Wed, 29 Apr 2026 17:21:09 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 08/47] target/arm: Introduce FPMR
Date: Thu, 30 Apr 2026 10:20:07 +1000
Message-ID: <20260430002046.59739-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce the special register FPMR and its fields.
Migrate it when present.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h       |  5 +++++
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  1 +
 target/arm/internals.h    |  9 +++++++++
 target/arm/helper.c       | 12 +++++++++++-
 target/arm/machine.c      | 20 ++++++++++++++++++++
 6 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f5ec7484c1..391c0e322b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -149,6 +149,11 @@ enum {
      * should not trap to EL2 when HCR_EL2.NV is set.
      */
     ARM_CP_NV_NO_TRAP            = 1 << 22,
+    /*
+     * Flag: Access check for this sysreg is constrained by the
+     * ARM pseudocode function CheckFPMREnabled().
+     */
+    ARM_CP_FPMR                  = 1 << 23,
 };
 
 /*
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5b1c0cf76d..35e281699c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1178,6 +1178,11 @@ static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
 }
 
+static inline bool isar_feature_aa64_fpmr(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, FPMR) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index da1b7fde1d..1a55275e80 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -692,6 +692,7 @@ typedef struct CPUArchState {
          */
         uint64_t fpsr;
         uint64_t fpcr;
+        uint64_t fpmr;
 
         uint32_t xregs[16];
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6376ae1ca3..08024943c3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -292,6 +292,15 @@ FIELD(CNTHCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
+FIELD(FPMR, F8S1, 0, 3)
+FIELD(FPMR, F8S2, 3, 3)
+FIELD(FPMR, F8D, 6, 3)
+FIELD(FPMR, OSM, 14, 1)
+FIELD(FPMR, OSC, 15, 1)
+FIELD(FPMR, LSCALE, 16, 7)
+FIELD(FPMR, NSCALE, 24, 8)
+FIELD(FPMR, LSCALE2, 32, 6)
+
 /* We use a few fake FSR values for internal purposes in M profile.
  * M profile cores don't have A/R format FSRs, but currently our
  * get_phys_addr() code assumes A/R profile and reports failures via
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66813bb298..304db1a479 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6209,6 +6209,14 @@ static const ARMCPRegInfo aie_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
+static const ARMCPRegInfo fpmr_reginfo[] = {
+    { .name = "FPMR", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 4, .opc2 = 2,
+      .access = PL0_RW, .type = ARM_CP_FPU | ARM_CP_FPMR,
+      .fieldoffset = offsetof(CPUARMState, vfp.fpmr),
+    }
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7481,10 +7489,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_arm_cp_regs(cpu, mec_mte_reginfo);
         }
     }
-
     if (cpu_isar_feature(aa64_aie, cpu)) {
         define_arm_cp_regs(cpu, aie_reginfo);
     }
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        define_arm_cp_regs(cpu, fpmr_reginfo);
+    }
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8dc766d322..58f8dfd53c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -960,6 +960,25 @@ static const VMStateDescription vmstate_syndrome64 = {
     },
 };
 
+static bool fpmr_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
+           && cpu_isar_feature(aa64_fpmr, cpu);
+}
+
+static const VMStateDescription vmstate_fpmr = {
+    .name = "cpu/fpmr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fpmr_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.vfp.fpmr, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1323,6 +1342,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_syndrome64,
         &vmstate_pstate64,
         &vmstate_event,
+        &vmstate_fpmr,
         NULL
     }
 };
-- 
2.43.0


