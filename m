Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CABC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 10:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOZx0-0004hw-TJ; Mon, 09 Jun 2025 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOZwz-0004gt-9K
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 06:41:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOZwv-0003YW-6k
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 06:41:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a53ee6fcd5so899741f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749465711; x=1750070511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=52gr5M5SFmOHw+i122yQNuFbbPQGmzrUxN40XN5i4Uw=;
 b=AMxeBEHmkItNg9REAtDl7e7fiP7jFRDBXWr6yLr2tIIx3sPJaSiR/SJqIzZcI98S7x
 ZGhpiQk5vcDhVef6wfuRq+aoaTBRAK6oprzhkVPOn9UkLdxfTP0h5EvD8Zh3PotUTXSD
 U+G+mI4pRcebAF15WhRbdZSSd+MVdTKfrAXAWaXZcCIfNaOArYU1vbAGrOtZGTd70Nzw
 5i+qfUrpFTBRz3SxE9OIjVfjBIl9kMd0KOMLACk4Fel29RUaUP7Jx0G4QpnhwgixLQJO
 HAfOEBgObqS5jjCvAWnK6sGhJLoqsAqPbYzfVqHK02hP704YqXtAMC8KjSgPlHEcoJ+w
 vj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749465711; x=1750070511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52gr5M5SFmOHw+i122yQNuFbbPQGmzrUxN40XN5i4Uw=;
 b=V2q5iBx8T1AEi19AGrZ2C2zd79t223iSn/idgpWVwm4VR+r7crkekBYEtbSedf+86T
 YVM642zV6vg3T23sxOZfw5j1WhP6hRK2ekZhq8+VnSe7/7nSe2OyYMShXll4VzetkTvu
 hH7tJ7DhZtsFGaumOPnGHNBEdaVzoaBMs762nXT5UXiVrJ7V2bmb9353BXj4CkX0OQxt
 vA+plM1mLwfSYqYoAPq7tte/mtFbjOXpg/RODl/GDR83xM3ZXWpwm5njI5PrB1E5anyv
 h6yeFZnU6ftsQc+2QGUaQR9YiOvlhv52EbTb/AZ3D3JSVxZWSVurCPwQSAm3JDw1+Kyg
 BZTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Ut0eOGLQ6yY3M+sUgXrBJhUYabhDymJE67X/DoJyB56MtSxZmkGmYDtMkh7pQ+tUOgDvmI4/I0ol@nongnu.org
X-Gm-Message-State: AOJu0Yy6928E1cIK3iDOVN5oIvqQvvFnytQLuodIAckjTTsnWOE88uzg
 4Wrf6HewpPmEq7HAHbGayeotC5qZFbXqB2WMFMSHO04oIuQrYuXUtGWmyPm1GwTwLmw=
X-Gm-Gg: ASbGncth0Ucsw19BbrUgtsjuAuM2MKWWKtk9hCv3dMNBFYptgGrtzC7SmyHTW6bQHx2
 tC33pT01mKMqrmvFd6uUEnxoPcgiIA37ZirwYtrcRD8oOAsuytqifUe2bWvaJhFH+45ooQdsG5A
 6exPO0qKYs/+09B1wiJXhavqAy7HpETTwt2kMN8CHPUdU1+X/Qp4+bI0vqJWod5PdOl2rdVVxTD
 HgOMqkyES1ltsb4UPL8HtImAtDFCPl3coKknEuVr34nd3+naOXDBFE4B0ZezXihyULgm4961bdz
 E7dKWcdnh3Cb0b6vDLI1XsZ955eSRCorhMDbbl5iI4OhQy0g8IcIhLzing==
X-Google-Smtp-Source: AGHT+IG84Jkoahy/bleMnZnQQ2BzLyNQMfnya79Gn+gcNT9jsJ89S2MhWjJsbGfRU3v6GbCNVRmfqg==
X-Received: by 2002:a05:6000:18a2:b0:3a5:2208:41e3 with SMTP id
 ffacd0b85a97d-3a5319ba177mr8064150f8f.4.1749465711551; 
 Mon, 09 Jun 2025 03:41:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324361ffsm9098991f8f.47.2025.06.09.03.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 03:41:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: Implement ID_AA64PFR2_EL1
Date: Mon,  9 Jun 2025 11:41:46 +0100
Message-ID: <20250609104146.1547437-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609104146.1547437-1-peter.maydell@linaro.org>
References: <20250609104146.1547437-1-peter.maydell@linaro.org>
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

Currently we define the ID_AA64PFR2_EL1 encoding as reserved (with
the required RAZ behaviour for unassigned system registers in the ID
register encoding space).  Newer architecture versions start to
define fields in this ID register, so define the appropriate
constants and implement it as an ID register backed by a field in
cpu->isar.  Since none of our CPUs set that isar field to non-zero,
there is no behavioural change here (other than the name exposed to
the user via the gdbstub), but this paves the way for implementing
the new features that use fields in this register.

The fields here are the ones documented in rev L.a of the Arm ARM.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/cpu.h          | 1 +
 target/arm/helper.c       | 6 ++++--
 target/arm/hvf/hvf.c      | 2 ++
 target/arm/kvm.c          | 2 ++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index db80ea1cc67..a8a94ee9d96 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -275,6 +275,11 @@ FIELD(ID_AA64PFR1, MTEX, 52, 4)
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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9364d221744..93e055e34fd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1031,6 +1031,7 @@ struct ArchCPU {
         uint64_t id_aa64isar2;
         uint64_t id_aa64pfr0;
         uint64_t id_aa64pfr1;
+        uint64_t id_aa64pfr2;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
         uint64_t id_aa64mmfr2;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 76312102879..31b667b7e05 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7927,11 +7927,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64pfr1},
-            { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64PFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64pfr2 },
             { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -8179,6 +8179,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64PFR1_SSBS_MASK |
                                R_ID_AA64PFR1_MTE_MASK |
                                R_ID_AA64PFR1_SME_MASK },
+            { .name = "ID_AA64PFR2_EL1",
+              .exported_bits = 0 },
             { .name = "ID_AA64PFR*_EL1_RESERVED",
               .is_glob = true },
             { .name = "ID_AA64ZFR0_EL1",
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 42258cc2d88..b4f2b743901 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -493,6 +493,7 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
     { HV_SYS_REG_ID_AA64PFR0_EL1, HVF_SYSREG(0, 4, 3, 0, 0) },
 #endif
     { HV_SYS_REG_ID_AA64PFR1_EL1, HVF_SYSREG(0, 4, 3, 0, 1) },
+    /* Add ID_AA64PFR2_EL1 here when HVF supports it */
     { HV_SYS_REG_ID_AA64DFR0_EL1, HVF_SYSREG(0, 5, 3, 0, 0) },
     { HV_SYS_REG_ID_AA64DFR1_EL1, HVF_SYSREG(0, 5, 3, 0, 1) },
     { HV_SYS_REG_ID_AA64ISAR0_EL1, HVF_SYSREG(0, 6, 3, 0, 0) },
@@ -864,6 +865,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     } regs[] = {
         { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.id_aa64pfr0 },
         { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.id_aa64pfr1 },
+        /* Add ID_AA64PFR2_EL1 here when HVF supports it */
         { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.id_aa64dfr0 },
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 74fda8b8090..915fc04e54e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -292,6 +292,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     } else {
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
                               ARM64_SYS_REG(3, 0, 0, 4, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr2,
+                              ARM64_SYS_REG(3, 0, 0, 4, 2));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
                               ARM64_SYS_REG(3, 0, 0, 4, 5));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
-- 
2.43.0


