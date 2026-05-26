Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CDACD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsoE-0002q5-CA; Tue, 26 May 2026 10:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsms-0001QK-NL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmq-0001Uf-WD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so2994107f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805779; x=1780410579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fyYDysEGjb/xns15lLPIe7SYd8K7mitMipemiUdM/H0=;
 b=K0lwldPQ4SDl0puztiY1lRhwu9oetE36tvfHXc8PtND9hERHuCV46ftQYF/iB5oHeG
 5wg2ovofRD3lPCmLt2eucj/OZw9YA05i8Lzr/LtYXQpd9zJ2wIVKNu19DbyY1wNj4KYA
 gZXT2fOaepBaRlMIqis+z7NVtQXt6mZ1sM/DfMZTSHUotG+7oQtVDWJOW3kD/HbZFUXp
 jZGa38Fkbe1Zoqdur8zwAoV1bwx7d0z5u4HwmVUC9olG8RBB8+zIeyLfy0xKuKeUG+a8
 hQ67tWEafZ08C6NspLuyKYjtfansHde9kSdWhxrSWzgnjMpUNiDoarARNV1FCYEgVfpi
 7WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805779; x=1780410579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fyYDysEGjb/xns15lLPIe7SYd8K7mitMipemiUdM/H0=;
 b=ktQ2hAfBqvYsQXHqePR4Ne3xL61q+LzehItlQM4SRvYi/+b3ik6pAfP7tlPpMSH4t3
 IWAlpNEkMbDN7q9jjNKIIKFOHp0lRxXGBok/0Wy2Ygfu+dyZ4nAtji8Zfbh660VdSSYk
 Ocr1iVpW4rg5mNz0G47EdtnR8gDqNlP0maCGnKRMD4NQZpv0xyth72v+3cP38ggy12Ds
 RGsfBrWOka2Ki7/VhGa6jLaY39aGA8WBvRSRJgYd7qbUAyAd9z+scyYci2f+zMdbmHE5
 UxpFbW6Tez9b9eE+sq+syYjW+fzbjI6ha1+8GvZ6r/oMj9Bt9o3h/INNxSQ/WscZpt8W
 rL5w==
X-Gm-Message-State: AOJu0YxcYQauTmL+XInwuZRl5wM84Dxj+Qr3hsM8jgTnEFRAFlm25hmO
 56Ga24C8l2TV0vI6Ev3FfrwiuwnNFN/yNoc+6gtYgT6dbSgLQq3p7e5cDy/I/eqH7z2VmDDGm83
 EBSJA
X-Gm-Gg: Acq92OHI1g4ptnD0HR2ofZA4q2+bOW1IYoUeEce9qOHvL2z4H3Mle1BuLt4Z2O0zp49
 TyaswAQGlQbmpmiW3UaMOyvmsS0RO+C3UkMf7zuqqFOPIoDYV1Dj6y5YsUUasS8MpaFl22sYkw6
 cekowh6ga3odLXpYDwLTK/su+27Kgf3UKhJ3UVQyJywELGklACpB+uVF0wEtuZkpHrjyI3W2KSZ
 9PVmYIkTENvrWEKSdtImX73MaCWvH2dIPgF2/KSiWsjab4s3XNCyX5rayqk9b0AEKPgfkTIzs3j
 tfKF/CamVYIouI+VcGhpej4hhtmfqjgOKT4iKqt9ghRULs4nuJXS8LqL+3D+CZwl1MmHsxFFHxa
 g7VM7eVk3npQAzKgp4EpWTZOOuulcM2mSAjO3W5Nc/QeO0SCzXADMk6f+K8RNDze+NI9+z7wYtF
 spVUS7FP9ajpeKIjD0Ezbyr2muPSYWm2kJBlOodnHX2tNZzPvivSGzNsEq9Em05nBis6mhkFSgv
 awUtKO7Eh1UAgVAjuUBX4lCpDaR9RNXqU5XwZ1eZA==
X-Received: by 2002:a05:6000:25c2:b0:45d:b14b:23f8 with SMTP id
 ffacd0b85a97d-45eb369044bmr33300787f8f.18.1779805779602; 
 Tue, 26 May 2026 07:29:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/54] target/arm: Implement ID_AA64FPFR0
Date: Tue, 26 May 2026 15:28:45 +0100
Message-ID: <20260526142850.2326589-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Message-id: 20260522220306.235200-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h    |  9 +++++++++
 target/arm/cpu-sysregs.h.inc |  1 +
 target/arm/cpu.c             |  1 +
 target/arm/helper.c          | 13 +++++++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e13c1c1331..1bb77d78da 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -410,6 +410,15 @@ FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
+FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
+FIELD(ID_AA64FPFR0, F8E4M3, 1, 1)
+FIELD(ID_AA64FPFR0, F8MM4, 26, 1)
+FIELD(ID_AA64FPFR0, F8MM8, 27, 1)
+FIELD(ID_AA64FPFR0, F8DP2, 28, 1)
+FIELD(ID_AA64FPFR0, F8DP4, 29, 1)
+FIELD(ID_AA64FPFR0, F8FMA, 30, 1)
+FIELD(ID_AA64FPFR0, F8CVT, 31, 1)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index b99579f773..6e8b335b8f 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -3,6 +3,7 @@ DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
 DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
 DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
 DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index facd4def38..a13e6dae2a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1768,6 +1768,7 @@ static void arm_clear_aarch64_idregs(ARMCPU *cpu)
     SET_IDREG(&cpu->isar, ID_AA64AFR1, 0);
     SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
     SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64FPFR0, 0);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3d6e7f1ccc..34487eeaa3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6477,11 +6477,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = 0 },
-            { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64FPFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64FPFR0) },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6712,6 +6712,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64SMFR0_I16I64_MASK |
                                R_ID_AA64SMFR0_SMEVER_MASK |
                                R_ID_AA64SMFR0_FA64_MASK },
+            { .name = "ID_AA64FPFR0_EL1",
+              .exported_bits = R_ID_AA64FPFR0_F8E5M2_MASK |
+                               R_ID_AA64FPFR0_F8E4M3_MASK |
+                               R_ID_AA64FPFR0_F8MM4_MASK |
+                               R_ID_AA64FPFR0_F8MM8_MASK |
+                               R_ID_AA64FPFR0_F8DP2_MASK |
+                               R_ID_AA64FPFR0_F8DP4_MASK |
+                               R_ID_AA64FPFR0_F8FMA_MASK |
+                               R_ID_AA64FPFR0_F8CVT_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
               .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
-- 
2.43.0


