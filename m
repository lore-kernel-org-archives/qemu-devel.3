Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF199C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONM-00018P-W8; Tue, 01 Sep 2026 09:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONL-00017m-Fs
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:07 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONJ-0007Do-Iz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c25b3c641fbso165435566b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268683; x=1788873483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7nCu86uIH71VEpg4SZXh45cqWLSIYAjxtCKKK5rJ+SU=;
 b=IakM1W3Qe9pTcNob48FkqfBbM1M/NRyDOsQeqf0Ny861WuQ8rMhVeTXPfF8MdQsKNa
 s9nmJfR51XY5OmZfafNS0W5U3G4RatG8RjHA8IIvjY1muwy0eV3AV6bv96uSWX7ElqFC
 11Sg/OUNHduS+5Hdd6BkKp4c4hkQ4K6zir5u09gFcr/XZ+pN/+7cj+ENj1SYN4oG9FMz
 yt9zi23kZfsKpb29U9coy+8HFACogvXWSYqikpR2xwd38tRYS1nh1jAcv0WghA5eLXrP
 nxKPXtqSrIC9BfRN/DWxcEC0ZzmTBrFaVyYoKQ60SZDRBTQBIGo1zMXUBifYeqPzQpm7
 Ef1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268683; x=1788873483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7nCu86uIH71VEpg4SZXh45cqWLSIYAjxtCKKK5rJ+SU=;
 b=qAM/CB6NIrVsnQ1TUyxarBjelLbC6wWvx4GDUWZXCye0haNnUKw5HstJYFUNxd81rO
 sbYNO05KXqXVIcXBmCdDcOjtJUBA5Wrjb+Q1rTqgifY5B00yLBoiWZ4h+LCfkl3/TZvE
 RZg2DnhUMo/hTsbHMb7CIDVMcHQpDKbkkkCeqfOV+u3V+dX2/Q69r1S5h4ZkY1FrnAAA
 O0UjbpQaD3Po1Rsum7MbM9955Mx6chSwVSq7tp8Cc6kNJuKfIt07NvakF9C7Ac6uzhuA
 HfaMDWxhf9F9RwbniaSG/Ch4vN0neMaeuHOrS+rLg7+Aa0VhtPqQt0gYe2IEuhYZUHfR
 mz5w==
X-Gm-Message-State: AFuF++nQc8FSaZD424gc4xQF8UFR9Hnr/XmnkxsJt5RhNafwLfCOxxRx
 zzooL4ECNok7opDBvsqhhk+WOEoTnjK8hCVoWmsO6CMlRpDhrnwlmiPgr8CjIi/7egaytdgyjj3
 LbYfznCs=
X-Gm-Gg: AR+sD12AdYfkbW8TsNgkGIqhkA9cRUzgkFLtDxy5b45smX7tNdDHrYianfbZ17tei5z
 trnFCGrm9h8+Hb9tSb85nEYTxcSbC9cxcoCC4X4NGJ/dTRfUUAApnBjLEVioq/wbPQEQdUpyd/x
 btyHyy+l6BF0hsym4I7e0qW3E39t80LWPQjjVwGKvGX6tXMmluJLw4hb+yWQywe4q7h/4hXq2tk
 BkJe8vhs1AFktQpEOXJVsuAjSkO8P3R5+FBoysjo5TLPByHCm7JvW6ideQbED4E9b4VBcMtPAGR
 Bp/L8k+/cKdS4/KeIwfAMVK5R725Qd0pamom7X1PUiff1pUm4lmVmqdeFnYZVYvocPFOACTvMc9
 7aPYnWTiTgcgLlH8CGGoeh9mPFK/F9LyA7ukN9VyEu6ChTmGT07L9i2CvGrkti0IC6yCQ8KwiaV
 qHlXFBIG1TA9OzdrE5Yb/SBZY7AEZX9bR0Bd4fXtvqcjFGfa73YH8XrjI2ODnJA6wIUDhPn2zyu
 ij5yJGlZIbONK0SxPuKHmZvE3Ex+PJi/4EVyL1PxJvY57N6GrWGpDvG4ObI3rJLdsDVeeI=
X-Received: by 2002:a17:906:99d4:b0:c25:8c05:902f with SMTP id
 a640c23a62f3a-c25b3cc9a2amr476681166b.13.1788268682439; 
 Tue, 01 Sep 2026 06:18:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/58] target/arm: Add FGWTE3_EL3
Date: Tue,  1 Sep 2026 14:17:02 +0100
Message-ID: <20260901131732.2263947-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260806172709.333300-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h       |  1 +
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  2 +-
 target/arm/helper.c       | 20 ++++++++++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 391c0e322b7..34592679e49 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -385,6 +385,7 @@ typedef enum CPAccessResult {
 /* Indexes into fgt_write[] */
 #define FGTREG_HFGWTR 0
 #define FGTREG_HDFGWTR 1
+#define FGTREG_FGWTE3 2
 /* Indexes into fgt_exec[] */
 #define FGTREG_HFGITR 0
 
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 280ead6f9cb..3c8d7033dea 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1467,6 +1467,11 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
 }
 
+static inline bool isar_feature_aa64_fgwte3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, FGWTE3) != 0;
+}
+
 /*
  * Note the E2H0 ID fields is signed, increasingly negative as more
  * isn't implemented.
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e8dfc3179f2..e3f931dba26 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -553,7 +553,7 @@ typedef struct CPUArchState {
          * FEAT_FGT2 will add more elements to these arrays.
          */
         uint64_t fgt_read[2]; /* HFGRTR, HDFGRTR */
-        uint64_t fgt_write[2]; /* HFGWTR, HDFGWTR */
+        uint64_t fgt_write[3]; /* HFGWTR, HDFGWTR, FGWTE3 */
         uint64_t fgt_exec[1]; /* HFGITR */
 
         /* RME registers */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e10ec21a8cd..1b24aca2937 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6394,6 +6394,22 @@ static const ARMCPRegInfo fpmr_reginfo[] = {
     }
 };
 
+static void fgwte3_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    /* All bits are W1S and can only be cleared by cpu reset. */
+    env->cp15.fgt_write[FGTREG_FGWTE3] |= value;
+}
+
+static const ARMCPRegInfo fgwte3_reginfo[] = {
+    { .name = "FGWTE3_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 5,
+      .access = PL3_RW, .resetvalue = 0,
+      .writefn = fgwte3_write, .raw_writefn = raw_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.fgt_write[FGTREG_FGWTE3])
+    },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7705,6 +7721,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, ccsidr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_fgwte3, cpu)) {
+        define_arm_cp_regs(cpu, fgwte3_reginfo);
+    }
+
     define_pm_cpregs(cpu);
     define_gcs_cpregs(cpu);
 }
-- 
2.43.0


