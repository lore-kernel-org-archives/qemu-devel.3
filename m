Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD28CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXxd-0007eX-IK; Fri, 22 May 2026 18:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxY-0007bj-SM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:12 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxW-0007gQ-Rt
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:12 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36a3aff302aso2206488a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487389; x=1780092189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLV/++7GOPxan22wzPWZY8hINYyGhnOVQ+d4bHJxmhQ=;
 b=q43NpuPhbm8QehiLh1+2eg2d3Ub5dmbAocHJJvsz2Wgxxta86JeR+U4xDgLaDCCuI4
 /YXYGMKak9fy3lQJvdz+GtnM4vDZrspVBJi666T2yQ2dlSWXO6wChsHXOAXilEwEQts/
 +0C/nsGQKujgYeNKo3qUIoHcgebRNse7HtmhEE6JjJaSlJxmNC0NmU7vlINZtD8b38ks
 pZin8sesGwOJqpnP4hbHOTzHyXr+xObDoNsd/1q+9ohFNKa3v+F++lObfQTUTVaReXd6
 STqVWU9u6B0sgFwfE9n97e5LUzV/ZQmEmc1ovBs8PaVWB5NR41GzjMaPJ0tZ7jNyccxw
 XBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487389; x=1780092189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sLV/++7GOPxan22wzPWZY8hINYyGhnOVQ+d4bHJxmhQ=;
 b=LASHSAJib5G408FDzrqgzftq8bTtMOOruBIVoZYznRDeF7R6MVCm2t467+mEEA2J+G
 ibjNsrCP/bk+mSuOG1zGOoOIV5+UphRITd21jjpUORzXvxU7v6z013O+2RnuF8A1AW/d
 YAdqdJLlQpEU/fzOYW6yxc+HvjFgYhRYAcZ/z1Z+iFKzFWrCHLnG5jrAFGCTgcIibFuV
 aNMPYhOq2ZU7x+WAh89rbyZu0Dl31ikFsGRUDi+Di1ah56tQMc1aao8ay7YXjfd+JliE
 8Fbt2IW3yTfXzpqUyCQEXtcc2/gbrXiN1Si0g44TNuV19dN9NM9GosPamwW/fkO+xtHM
 LHFQ==
X-Gm-Message-State: AOJu0YwQUsnhQC/dc/qyU5kZk7RZCz0UPFYDSUktFut/8XbY5UNBDoWl
 TI2NMdXT4Ik2lPwHTmfQ6Z6xhmmbzfdhwGzaI+/3XM+VxSDJkqW+D5djvAT9bOjpKOxEM2Hk1oD
 DnMTl
X-Gm-Gg: Acq92OHZLmNRBDe7mbD5ID4kJbeu4b4UAyLZoZLruHKal0c/XbQB/Zxb/pDgaoXkcI1
 gfY5eMMtX7r3i3kbCZHqVhb7uEtqNdAcmFZuYdYj/pvxWeHoxKhW7Y0dM1MrSplajZa8SPnnstQ
 rJFk12JkWw/00LZa/bTKr/+IvBVF0zWzdC7CBvkDW+KyAh+5oU/wAGWRuVLApa08dadRIaAYs77
 RvofV5D8D64c3/HIJ72GFnoRAKlQj6vE61nBH0pi+yCEywG5S9Yn6MTS8q9H4dMkkGmD+qW10Gi
 iqsmnTFpFLBiyQ7kObcD/0jwwu/gBtXea6H5f8URspkSa6EScHOXnejnlUWfp29KfkpUCiX3e5I
 bDmyKSv6//ktKfgG8VKID88M82Sr4ILCG9mo8uII9CjHNy8flFlTacUf4TfHbM14AUSS1BKBByd
 4UvE1aKQpYx8CRANrreEErPN8XfhGD
X-Received: by 2002:a17:90b:4ac4:b0:35f:b572:ece9 with SMTP id
 98e67ed59e1d1-36a6741dd7dmr4973096a91.5.1779487389281; 
 Fri, 22 May 2026 15:03:09 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 01/64] target/arm: Implement ID_AA64ISAR3
Date: Fri, 22 May 2026 15:02:03 -0700
Message-ID: <20260522220306.235200-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h    | 9 +++++++++
 target/arm/cpu.c             | 1 +
 target/arm/helper.c          | 8 ++++++--
 target/arm/cpu-sysregs.h.inc | 1 +
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4e44245a8b..50776347a5 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -244,6 +244,15 @@ FIELD(ID_AA64ISAR2, CSSC, 52, 4)
 FIELD(ID_AA64ISAR2, LUT, 56, 4)
 FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
 
+FIELD(ID_AA64ISAR3, CPA, 0, 4)
+FIELD(ID_AA64ISAR3, FAMINMAX, 4, 4)
+FIELD(ID_AA64ISAR3, TLBIW, 8, 4)
+FIELD(ID_AA64ISAR3, PACM, 12, 4)
+FIELD(ID_AA64ISAR3, LSFE, 16, 4)
+FIELD(ID_AA64ISAR3, OCCMO, 20, 4)
+FIELD(ID_AA64ISAR3, LSUI, 24, 4)
+FIELD(ID_AA64ISAR3, FPRCVT, 28, 4)
+
 FIELD(ID_AA64PFR0, EL0, 0, 4)
 FIELD(ID_AA64PFR0, EL1, 4, 4)
 FIELD(ID_AA64PFR0, EL2, 8, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c47b70ac69..e1ea41fdc5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1747,6 +1747,7 @@ static void arm_clear_aarch64_idregs(ARMCPU *cpu)
     SET_IDREG(&cpu->isar, ID_AA64ISAR0, 0);
     SET_IDREG(&cpu->isar, ID_AA64ISAR1, 0);
     SET_IDREG(&cpu->isar, ID_AA64ISAR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR3, 0);
     SET_IDREG(&cpu->isar, ID_AA64PFR0, 0);
     SET_IDREG(&cpu->isar, ID_AA64PFR1, 0);
     SET_IDREG(&cpu->isar, ID_AA64PFR2, 0);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8240f1b384..6ad01b345f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6519,11 +6519,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR2)},
-            { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64ISAR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR3) },
             { .name = "ID_AA64ISAR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6752,6 +6752,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ISAR2_BC_MASK |
                                R_ID_AA64ISAR2_RPRFM_MASK |
                                R_ID_AA64ISAR2_CSSC_MASK },
+            { .name = "ID_AA64ISAR3_EL1",
+              .exported_bits = R_ID_AA64ISAR3_FAMINMAX_MASK |
+                               R_ID_AA64ISAR3_LSFE_MASK |
+                               R_ID_AA64ISAR3_FPRCVT_MASK },
             { .name = "ID_AA64ISAR*_EL1_RESERVED",
               .is_glob = true },
         };
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 3d1ed40f04..b99579f773 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -10,6 +10,7 @@ DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
+DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
 DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
-- 
2.43.0


