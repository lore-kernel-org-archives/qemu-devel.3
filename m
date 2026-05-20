Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBB4CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZ9-0007Mp-Sq; Wed, 20 May 2026 14:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYm-0006se-Hl
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:24 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYj-0000UE-Qt
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36a35e4eefeso463277a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301340; x=1779906140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UT8d/Ri4vaH+9l8soed8vmW38AzAn5sreMEwwUXqNdw=;
 b=GVZCdlU1zs63fb8v64a3JgYJl6xqoVRobNBnoJCT3z+4qwVhIZW5PQ6ZhARs1Ht50S
 a/pb6coi5orfrtShKpxVYEoNY/ziRjZppaJdy4Sf1H/LKhVBlgKkDCq5Nsc2HXGGCO6y
 vWtJLSoiO9iqR4iYik9BGybdzcvVndRxTDT8RKeOD6Ju3gehzrdZ3KXyZM3e6m5r3/ys
 uMlI4HqnkbdnvwUp3XTBCVh8QEwnzCDRqWn0dgw8LsNPv8kmyD/zmEIuUQWOGnKAZ9GQ
 ByQbp66lItgf/cYmii6wqVlqygOWIAQ88Ji5c0jYlPa6UO9fNt+aaoWlsCNbXBY/DhE/
 z9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301340; x=1779906140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UT8d/Ri4vaH+9l8soed8vmW38AzAn5sreMEwwUXqNdw=;
 b=SZJ7sQjrjeZ73qXE/Z+YoMWM5S03U1N0AJdCpVqFXVZb5UvfXQyUeh1hm1XoJsp5fw
 YFz/vw8zvGkFQzaTbi1T+Nn0zPpJE0gc9Mu4IWFe2iuk1fqovqFYf2BAaLDWAzE48oc4
 ju3TmjtNy0tHpvSF0KsHFKzS3J+Yeel1CtCgCi50Qqf21L0ZfgCBRQ4Nki7ljZdPTLww
 cm53wdBZzA8L8+1C8Ag9/bnZc2VUpXMJEsNaKKHocu5M5Akpkj17gpYlFRE59mR6OAZ3
 ylaBmJUG5j0OoHukF0wf1Yk3HWqDTibu3rvf9GV8TRo9ovuGe5f+1h4n5HOJKpK7AadJ
 aUbA==
X-Gm-Message-State: AOJu0Yyn9r0uREO2QLrAILDwiazU6PvXLzbWNfXYF5M/WgiFOzOIT02G
 Pq4gXoTZ+nuXYfn5DQBDzprCRh5gBXqv4wGd1/ItDMhGn5y8QJ0pKrLu9qnhdJj6LDeBOhygeu5
 2Y6pD5ao=
X-Gm-Gg: Acq92OF3Hf3tCdLqXML3E01z2ZCq6osTtyXaOuLq+KVeR6KNPmpGu0xVMyUliByttFD
 PHJiLPJ4ywXXyJJgBhprvCTTz832CryYSDvsqrRH8HvaLCufMilEl0E56ty3Z+oEL7kc7tRetKH
 pMQRJeK1bkx1rx/HyYl04i6nC/wKD/MmpnhifvMhzzm3G7fVbALKfeMQBQvH1672OlEqlw/Azop
 U6bBSK3+i5dOXBoSCDPg3LLjKqya8GhGzll+ZGoNrn573Hx35aF6OGAkSGYDzLH2hKsK9Ytyv0+
 +K7GXIF7Do6PwhvtYcgS6ZJlSSuyGRpSybHaNo1rlTi3q8lgn8Xc1oLOK+5kfwbc2kUlVpWK5oK
 nd7x+vCzxGxH/sRCRhfCz5/Vwj31AIsQgcJMBSjw+OGejE4wiEIMAp1yhRSHqaZmHOSzgzIoNfI
 8UufLq4g/LMeS5itXOG4FABGVByPiNWyPM4+bUpxc=
X-Received: by 2002:a17:90b:38c6:b0:366:2e1f:393 with SMTP id
 98e67ed59e1d1-36951b860a0mr24956674a91.21.1779301339991; 
 Wed, 20 May 2026 11:22:19 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 08/64] target/arm: Introduce FPMR
Date: Wed, 20 May 2026 11:21:17 -0700
Message-ID: <20260520182213.872945-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/arm/internals.h    | 10 ++++++++++
 target/arm/helper.c       | 12 +++++++++++-
 target/arm/machine.c      | 20 ++++++++++++++++++++
 6 files changed, 52 insertions(+), 1 deletion(-)

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
index a7ab7e2a31..e13c1c1331 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1192,6 +1192,11 @@ static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
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
index 0a11dd9002..498af7db08 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -713,6 +713,7 @@ typedef struct CPUArchState {
          */
         uint64_t fpsr;
         uint64_t fpcr;
+        uint64_t fpmr;
 
         uint32_t xregs[16];
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f02d3c6a71..b6efc4433d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -292,6 +292,16 @@ FIELD(CNTHCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
+FIELD(FPMR, F8S1, 0, 3)
+FIELD(FPMR, F8S2, 3, 3)
+FIELD(FPMR, F8D, 6, 3)
+FIELD(FPMR, OSM, 14, 1)
+FIELD(FPMR, OSC, 15, 1)
+FIELD(FPMR, LSCALE, 16, 7)
+FIELD(FPMR, NSCALE, 24, 8)
+FIELD(FPMR, NSCALE_F16, 24, 5)
+FIELD(FPMR, LSCALE2, 32, 6)
+
 /* We use a few fake FSR values for internal purposes in M profile.
  * M profile cores don't have A/R format FSRs, but currently our
  * get_phys_addr() code assumes A/R profile and reports failures via
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6ad01b345f..ae1dd42dc4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6229,6 +6229,14 @@ static const ARMCPRegInfo aie_reginfo[] = {
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
@@ -7502,10 +7510,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


