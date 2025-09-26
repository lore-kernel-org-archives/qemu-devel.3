Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D42CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29A5-0000nr-Ub; Fri, 26 Sep 2025 10:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299Z-0000Ia-NP
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298j-0005oO-7L
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:25 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so2297562f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895771; x=1759500571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HfRxq0U7zhd1tsQFSFudYaq3Tr4Dt63MO1uZEXfIFSY=;
 b=JHX+b+fj8n8FjALvOzjFpYpis9ukjkv9yfWsnVH1jih1S6L5Sp10pU7mLU9hoViJ0m
 XjeY2YRaD9o/8y0EubAyVcrj54D+n9IY6wZg1KT5GbVos3ZAs1H4TJMHw7SwPeKD3gR1
 d0uzcgOZknC/eESJZwdesQCxLRSqR9MbiR/GprlNOKAhj+6k1S6YkCX1fXQTyAZrf9sp
 KOd2zCPvCOv8Kw1xePYZgPZjV6vEdGeiactHS5r8nuZDUyLKyfOOlx6g5ugQ2MTsaPyW
 iShPlNnpl8bPWoYozsNUbDZ+xHCia/2F0ZaURVRh/k/rrPYFTLP0vFdAGl6/PHP6QwSV
 sjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895771; x=1759500571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfRxq0U7zhd1tsQFSFudYaq3Tr4Dt63MO1uZEXfIFSY=;
 b=EvSf01Ljn/k8uojz0UdeI1PRUFTZYv8sluBbh9BFcjrivZ4OueV+QATBWQDJAJDD8V
 4lin33dPp4oz1739jmn8SGyLt8KkHicYpQjAke8vkOsE2Uc+tg/ZvDqwuOg231Bi/d0M
 N0AJuM2taJ++FUL8XS1IzotLhxIJOSHi/PD4tZFXtOthe0nvZFTGUuE7CGpHJ+B3Rsi9
 b1vc+G0C4/DfzRMnnpLsx8bLaVpMqFBLhO2sN21QRRaosZ1zyK2SvZu9MxTQ9/ByEkJh
 70h36NUUuAhKQp/TN7vgyOSYhdJFzWHv9teFUL0m8IOUL9oWkzIo6qhvumfYwauAVyJ+
 mcCQ==
X-Gm-Message-State: AOJu0YwrS8tr7hKiLkaEdtbCrTBcLCPO4HjLLlSEKlz0NG8FclQOMdT4
 8+aTjPtt4Fmeneh89WxpRspuSIlanym3V/t2E70F6UYMHLAlIKeyS1AR29YPOSl0eV2RxZjebUS
 Zt5ZZ
X-Gm-Gg: ASbGncu1KuAOrR93ImMiKymcYnpXFTmOEnYU8h7bjh9cPUJPt/c5wbfPxkkl3wCwRu0
 y32Rv2yXQWYUn2j1I4IgXJRwKAYF9piAJ58SAOTV57OUX8g0PtR+8mmQgb0GQo99UJ73rcPo8bQ
 Vp6/u/4aujQAldwO/nxToqn/9huILPn+TT9raBTYzrbN8mlNRTc6ZqZep2y60E8B0CNB5vyhAxD
 CaMYTK2OyP5jOyMkoAYFmdcKCXTpkoCRYrQyU2k1EK47deRNTOKPs0K/4Al/GUtMwGY5lFL4ymU
 wfBrcW8sthy/u6ITFlNscMmRSbNBX+cTgCWxdxUNuTOT1nLp3U1QTcmi+hwIomgWcbMlynRY79m
 nlBkCuTXJwYcJqXc3b17JeOc1OHgXGKFSpg7Q1P4=
X-Google-Smtp-Source: AGHT+IFwxfofrZt1N9GKvBzoTJ2s3VeIA3llPtjGzHCbHdKspqNzi5lU4j7iDS94h0RBGOC+Xq5byg==
X-Received: by 2002:a5d:5f52:0:b0:3ee:b126:6b6 with SMTP id
 ffacd0b85a97d-40e4886df41mr6361997f8f.34.1758895771073; 
 Fri, 26 Sep 2025 07:09:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/44] target/arm: Implement ID_AA64PFR2_EL1
Date: Fri, 26 Sep 2025 15:08:44 +0100
Message-ID: <20250926140844.1493020-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Currently we define the ID_AA64PFR2_EL1 encoding as reserved (with
the required RAZ behaviour for unassigned system registers in the ID
register encoding space).  Newer architecture versions start to
define fields in this ID register, so define the appropriate
constants and implement it as an ID register backed by a field in
cpu->isar.  Since none of our CPUs set that isar field to non-zero,
there is no behavioural change here (other than the name exposed to
the user via the gdbstub), but this paves the way for implementing
the new features that use fields in this register.

The fields here are the ones documented in rev L.b of the Arm ARM.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h    | 5 +++++
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 6 ++++--
 target/arm/hvf/hvf.c         | 1 +
 target/arm/kvm.c             | 1 +
 target/arm/hvf/sysreg.c.inc  | 1 +
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index ad571e2ffee..602f6a88e53 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -277,6 +277,11 @@ FIELD(ID_AA64PFR1, MTEX, 52, 4)
 FIELD(ID_AA64PFR1, DF2, 56, 4)
 FIELD(ID_AA64PFR1, PFAR, 60, 4)
 
+FIELD(ID_AA64PFR2, MTEPERM, 0, 4)
+FIELD(ID_AA64PFR2, MTESTOREONLY, 4, 4)
+FIELD(ID_AA64PFR2, MTEFAR, 8, 4)
+FIELD(ID_AA64PFR2, FPMR, 32, 4)
+
 FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
 FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
 FIELD(ID_AA64MMFR0, BIGEND, 8, 4)
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index f48a9daa7c1..2bb2861c623 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
+DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
 DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
 DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a18d920ac18..aa730addf2f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6109,11 +6109,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64PFR1)},
-            { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64PFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64PFR2)},
             { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6341,6 +6341,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64PFR1_SSBS_MASK |
                                R_ID_AA64PFR1_MTE_MASK |
                                R_ID_AA64PFR1_SME_MASK },
+            { .name = "ID_AA64PFR2_EL1",
+              .exported_bits = 0 },
             { .name = "ID_AA64PFR*_EL1_RESERVED",
               .is_glob = true },
             { .name = "ID_AA64ZFR0_EL1",
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8b467b36638..0658a99a2d1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -744,6 +744,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     } regs[] = {
         { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
         { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
+        /* Add ID_AA64PFR2_EL1 here when HVF supports it */
         { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5a75ff59271..b8a1c071f57 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -324,6 +324,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err = 0;
     } else {
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR1_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR2_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64SMFR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64DFR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64DFR1_EL1_IDX);
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index f2276d534e6..067a8603fa7 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -92,6 +92,7 @@ DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 #endif
 
 DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
+/* Add ID_AA64PFR2_EL1 here when HVF supports it */
 DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
 DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
-- 
2.43.0


