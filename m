Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6266EA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Ru-0008F4-TU; Tue, 21 Apr 2026 01:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RC-0007xh-V2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3R8-0006MT-UJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so16746995ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748451; x=1777353251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQOANj7Y0pZJUmBoHVkVj+8tE/9rp7PAWdZqpVIG7Nk=;
 b=xWB4/M8Bq8Gb++OvtcFL6scYmNGcLlw86xswLecFcI3rcvTvc96+dhHxoxdDQtrs5F
 0XD/RgcXcYq4ezXB6BD5htkcLgZl7x2BYT09H4lBm8T64bEtzye7D27lraUoc/dv0rqH
 62NFi8sAtE+5FcE1PYJJeByhwyn2U465FmJKPjf2KkHwglJQOnKn2gkacU8QN+sZXKuF
 q5eTWOXqHqngfs04LvpaR0WWRHojJneQBUeI8IrOHdai5AAnCQZk1Z+/PD5s1oH5SjTU
 0sAAfelaV1uYclPqmYw8rNdKtvzFlH8zYcVHXNNUpfaEY9zNroPSyGoyT5a1BeSN8iNa
 B5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748451; x=1777353251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQOANj7Y0pZJUmBoHVkVj+8tE/9rp7PAWdZqpVIG7Nk=;
 b=dtPs/wPKZf+EOpwqQxDWUBAcvqIdP5+/Jj1nTg0atzDIqBsuCgBTcCfotiF6z6Tn77
 y2MzEFfthGFswbZnCn1BfnAFGQMQRoCjhXzvX8x32Qc4Ss4Q0/xvvnQotEV37/WmDz3A
 MLIVS6EHQ+KpovdnBSJYcZgtVLaKKMUHaDHOu6w/uY71YcN2yHkIcBMsbexcoCygb5pC
 IWwCOLyks281CQwGZk7ZPBq3TBJyaWo+9coNONQyYTiN6qxn0p5pTz5jB1dO58Wn5i5N
 dqSVE5kuu4y0uHsn1/xQlAv1qix/BKfhGg/j916bvtHQZr5NdrBlECNKfB12nfLjAiBN
 YntQ==
X-Gm-Message-State: AOJu0YwaKqMx0MZEw1r5RGlam6fef2e/Lw9Y3JIu83SfUS0cmanAtFS4
 WpOY1xWLOZcFniyyNLAUUPa62C8r5clfzF8V87M4UxWnhvIncPs5kDkw3A7Yd3slVyADH5DFWfn
 e63GQAEY=
X-Gm-Gg: AeBDieu15L3tYdAazd6fqoqn9oqmw0YHjcN5D+jNwCC/592eant5hyh8o6jx0JWbMC7
 6sg19ZIPkbArjp04TWCRfGz55qq+VcMNRhaFXoLGy/DvmzcsA+4gwigvaHasZLilc3RI7eUYkLh
 jNmJzshnQxS+5H6KIqioIzwqZGgLRWR6w2wNeG0N79gXlOKzsPNwrHBNNGeqdMeTyLID8q5IHD8
 HhnwHdYnztw5U8dtYnBuV2Z5TeRgAFjywqz3fW0NeG1GIJhjPvFU1xiHLK9I3BpmusZduj9ByLJ
 Gy22H2EfcOTqHikzZAoa3Ez3sc2lg45HvjddMRqQNe1p7/Q3WPbPXAnk8eKsBFhur1sg0XtKhGh
 5cdyqY5r7NALGppcuSBIwqAZf9HUb3tVZBjLKhIEgXFB5R8xnT/IHxomRFibUaRAUisb9xftuIH
 MjsbfwKrQZ2tMh7m+36jFo2J9su0331BckGzgWSdFA
X-Received: by 2002:a17:902:988a:b0:2b4:689a:e420 with SMTP id
 d9443c01a7336-2b5f9e7a9c1mr113132555ad.8.1776748451153; 
 Mon, 20 Apr 2026 22:14:11 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/37] target/arm: Introduce FPMR
Date: Tue, 21 Apr 2026 15:13:17 +1000
Message-ID: <20260421051346.41106-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
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
index 03631018d7..ddef6fbeb0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1173,6 +1173,11 @@ static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
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
index 6ec3845edf..38deea01bc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -692,6 +692,7 @@ typedef struct CPUArchState {
          */
         uint64_t fpsr;
         uint64_t fpcr;
+        uint64_t fpmr;
 
         uint32_t xregs[16];
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index b0f6bfa62c..944adc14e7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -286,6 +286,15 @@ FIELD(CNTHCTL, EVNTIS, 17, 1)
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
index 08285b69a7..1a0673a343 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6286,6 +6286,14 @@ static const ARMCPRegInfo aie_reginfo[] = {
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
@@ -7535,10 +7543,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
index b0e499515c..11e973e504 100644
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
@@ -1310,6 +1329,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_syndrome64,
         &vmstate_pstate64,
         &vmstate_event,
+        &vmstate_fpmr,
         NULL
     }
 };
-- 
2.43.0


