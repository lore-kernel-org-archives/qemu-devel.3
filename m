Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCD1CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmn-00011k-51; Tue, 26 May 2026 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmk-0000w1-2G
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmi-0001O1-7s
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so112135505e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805771; x=1780410571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2/oXsXz6f50ENeJfUqlZ2SkVo/jqaVvPr1Wk5eRyyaM=;
 b=vQXRKSK/nhAf9wk+pOs+PYjJquIXO6xr9cKW3DplETcGl1daAarT1YeN8rcB2HF57M
 VH8X4rV1/5f7ZSECJHhqHUXCyN5aFK0Z7kDUh/B4m+xYCxHU8gHYp+QTO0OtPOuzFylo
 vW0P3bAoABkew6/f5hS6KNjhAHWBz4p3FNCfz8xlIS8NQ4iWawqTdWJGDoCeKOdjhXF/
 mibEn1mgfqrCJQ21kquBu6Yu+fD7zV65d0aO+KNiTm42plS0781cMFXY0CqJFbIGz9AA
 DZPVjrTsIlFdB3xBCBdUGGmfJc8NTfrpHDcJJFglyDgwLVSlgWFwxFovjhtV+ZXWqgVl
 NV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805771; x=1780410571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2/oXsXz6f50ENeJfUqlZ2SkVo/jqaVvPr1Wk5eRyyaM=;
 b=N5seuIJpy4EyOFwbCjD3WppPgLtiAJOa8cZnvoMETFYiM40l23kWOLujt1s+yNeCWA
 WeMyKlkNmIAbpgMQNLdqviqrHgvKPjvebVwKN7wWrrUIjrqA1GcQpf63nlZHdWh24K0z
 V6UPesftKiUnuMpayjgTF/jEJVbbal0htszcL5Ts/ubc/XlJWNPR/HAJhBUKzKT9gX7u
 /zLDZChFkxTiNXW9utIU/kqNVj6N2esBD4+5SCRh1b6rjyU4goboQfcfU4Gzoy7eQUNQ
 wIZCxAiS+9CcK/xqvC3UFwmGOLo7lj6DCjpFi8nnMgLQR7ub6jSRj1xmwQAONsr+aFkz
 4B5g==
X-Gm-Message-State: AOJu0YzRSUt+hcHTkuEwdfYJ5wWAGJdKBkMzBnlxOX6whYipwEZt9waO
 6vD6UfFYMnzCj5fh1cg9Qn3ZWqWxLOgtIXPbN9ZP4QjAm5I+ZYO7+/mdCof76MVEn0hbJaVqDfV
 RVvyt
X-Gm-Gg: Acq92OHWhxdxtMu9pL5RCmjzRwZN/akYQ6fyZKQ1E2FsUEHQbG2lwhUYMlhXlLwDRH8
 uZjjfBOB8lJ2pf11ixFvDTpirraqylDpd/o7fow7TwPtwcVRXDRtA4cSGUFN6OK8WlQyiyYEbbr
 7R81mJKX/VXaJOn0IolqCplo4RUG9mnUsIt7oVcOirAowjtDy2U/8Z8/jiqxANx2JcGPBiFte0a
 mTbutK0mKyj/je2pe3vGQOpH1M4QdRoslL/8fcpe+Z+PocgU1pgK+3OxTTtdvcLaa39wdB9m3p8
 Vf6Kkeu635+gW9UWo/Gu5MQTr9XCwvpyGih+rrTQNbCxiT2RPLYmdVjbzDoiglyERwzstW15+ES
 ZawDkNOaZqj5SgHGcjGT4G6oPTfWT87MqUtP7Er+lBhpMr1g9bnN66zPeHqhiet75IhbFcPZV5T
 +23zmhD5bODXudm6ph+BXcsmGoY8sF4pVqxEEwlq/JQ08XswR+N+nj9CR7jk8pYPW7A9HUgi+iz
 uhjSalwWWd+ElEONbk08JCzlcl290c=
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-49050580a91mr247315335e9.11.1779805770618; 
 Tue, 26 May 2026 07:29:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/54] target/arm: Introduce FPMR
Date: Tue, 26 May 2026 15:28:35 +0100
Message-ID: <20260526142850.2326589-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Introduce the special register FPMR and its fields.
Migrate it when present.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h       |  5 +++++
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  1 +
 target/arm/helper.c       | 12 +++++++++++-
 target/arm/internals.h    | 10 ++++++++++
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
index 3c2bf476b2..a549a50b7d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -713,6 +713,7 @@ typedef struct CPUArchState {
          */
         uint64_t fpsr;
         uint64_t fpcr;
+        uint64_t fpmr;
 
         uint32_t xregs[16];
 
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
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0a9b4d41af..5a2263799c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -293,6 +293,16 @@ FIELD(CNTHCTL, EVNTIS, 17, 1)
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


