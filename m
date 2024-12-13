Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDEEE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aO-0000XL-4r; Fri, 13 Dec 2024 12:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YB-0000RU-Hu
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y8-0001n5-9W
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e2880606so1928465f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111239; x=1734716039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HbH6mKs94rPic6KcGRGG3fOmwu2HnUwrKyb75JHn04c=;
 b=SQIjs+L6YGrJHgAU1OQSx92ysQmyuSVUQ/Opwk6gylrFM5nQqrHTJtRTUGj/jsRWMR
 X3HgHrNloKaK76Tix/cgKxgCa6tdCJZL8RInjVVimSnJeIdQclzNdshoEW6xPvdrqjDD
 pKzd0iUNGYJhKe3tnhxW7aHN5d7VjcQsvJO4n+wFBEqDwWH0qqo/kAa0pqsyJZdWw0SD
 SnInlPxqx+IISuLHxFhtcHEL25qe6jgmvZOygsurtvGl55IfYHd3dxQurmA+z/98KYN0
 b3qnfyvUTYeg2bT31/7uzCF+E8OFu4DB/5yc/c1M20dWMIR3jVcYJcoXKBsvmvfEdel1
 3trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111239; x=1734716039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbH6mKs94rPic6KcGRGG3fOmwu2HnUwrKyb75JHn04c=;
 b=AuJN6wM5d5Xoi0Mx/J3aybhdTmnJcHhPdNLiFJgk8Y+YV517tn09Q7rfF5FkMDjwV1
 feEqdrTXHSQjgrxoKeednZSjmsITZpVJSuTEyVactj8aHuO4JrTckkmgTjZu9tX2ewrp
 tb6Y5g2ImG+QVyl0xYiX7sODLnsZVmsAfnJO1U2lSG6WB7fwbZv25VIiX8xLHmjXyLfV
 FyHGaa/vR/Ex87ChsiuRiKvLGxiaD5mi342V+/CjBT6ymwEVNohXkuEYFpN/k51eetH8
 0/XNfEefCuoZRBHHQo2Ha4u0219hp2MUrq3BchVfIRnNjNLtZ9nlqj8PBuNL0qdvy6+x
 SGCw==
X-Gm-Message-State: AOJu0YxiIE+GehLTd0XKbQLF9kTdIbhhoTepVd9sxJf/Xln3cp0tTv16
 2gMGp0aA9LewvYmrbjksFzHckD0rGGLDrjRCRiQgXLv70QCLS2Aky4ybChuDVLQDYIwQjQYiefH
 J
X-Gm-Gg: ASbGncvLVk48troUav6PP8B6wI2A6D9F3ut28RbF8d3MzB4BZNuocoXP0wwC7uALCxf
 TDZ7elwrW8oqpIQpZGswg88rqcnXBQNX3b5YqKeM0BBYQhYMJ+m0XMCGMVDB1Aukyt04E/nHbIo
 nyY81ydK09G/71tVQHxbBcezknNCS4A3HgWaNF2ALJtsfGXWfByvV3svuOOkeO6cyAgcbETgoLq
 KTnEfGepYd3dpLD7kLqCrFfrExckdcxV+wH36NZPubH7MnmUfk5lGHUa5v5Ug==
X-Google-Smtp-Source: AGHT+IHm2zNGr3i1Wi1op9upFRSQLuzA/2qUVR+6/Kirg+w/2WeX8EdqiOQFnyOLL7Wge6KF+i5hMQ==
X-Received: by 2002:a5d:588b:0:b0:385:f062:c2d4 with SMTP id
 ffacd0b85a97d-3888e0b87d6mr3065477f8f.37.1734111238730; 
 Fri, 13 Dec 2024 09:33:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 82/85] target/arm: Move the TLBI OS insns to tlb-insns.c.
Date: Fri, 13 Dec 2024 17:32:26 +0000
Message-Id: <20241213173229.3308926-83-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Move the TLBI OS insns across to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241210160452.2427965-8-peter.maydell@linaro.org
---
 target/arm/helper.c        | 80 --------------------------------------
 target/arm/tcg/tlb-insns.c | 80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 376aa9aecd5..3f7d56e809f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7116,83 +7116,6 @@ static const ARMCPRegInfo pauth_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, keys.apib.hi) },
 };
 
-static const ARMCPRegInfo tlbios_reginfo[] = {
-    { .name = "TLBI_VMALLE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 0,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVMALLE1OS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 1,
-      .fgt = FGT_TLBIVAE1OS,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_ASIDE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 2,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIASIDE1OS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAAE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAAE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VALE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVALE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VAALE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAALE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_ALLE2OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_alle2is_write },
-    { .name = "TLBI_VAE2OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
-   { .name = "TLBI_ALLE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_VALE2OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
-    { .name = "TLBI_VMALLS12E1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_IPAS2E1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_RIPAS2E1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 3,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_IPAS2LE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_RIPAS2LE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 7,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_ALLE3OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle3is_write },
-    { .name = "TLBI_VAE3OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3is_write },
-    { .name = "TLBI_VALE3OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3is_write },
-};
-
 static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     Error *err = NULL;
@@ -9066,9 +8989,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rndr, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }
-    if (cpu_isar_feature(aa64_tlbios, cpu)) {
-        define_arm_cp_regs(cpu, tlbios_reginfo);
-    }
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index a273c6f4b58..45ebfc512f9 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -884,6 +884,83 @@ static const ARMCPRegInfo tlbirange_reginfo[] = {
       .access = PL3_W, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_rvae3_write },
 };
+
+static const ARMCPRegInfo tlbios_reginfo[] = {
+    { .name = "TLBI_VMALLE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 0,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVMALLE1OS,
+      .writefn = tlbi_aa64_vmalle1is_write },
+    { .name = "TLBI_VAE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 1,
+      .fgt = FGT_TLBIVAE1OS,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_ASIDE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 2,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIASIDE1OS,
+      .writefn = tlbi_aa64_vmalle1is_write },
+    { .name = "TLBI_VAAE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 3,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAAE1OS,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_VALE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVALE1OS,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_VAALE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 7,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAALE1OS,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_ALLE2OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 0,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_alle2is_write },
+    { .name = "TLBI_VAE2OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_vae2is_write },
+   { .name = "TLBI_ALLE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 4,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle1is_write },
+    { .name = "TLBI_VALE2OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_vae2is_write },
+    { .name = "TLBI_VMALLS12E1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 6,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle1is_write },
+    { .name = "TLBI_IPAS2E1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 0,
+      .access = PL2_W, .type = ARM_CP_NOP },
+    { .name = "TLBI_RIPAS2E1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 3,
+      .access = PL2_W, .type = ARM_CP_NOP },
+    { .name = "TLBI_IPAS2LE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 4,
+      .access = PL2_W, .type = ARM_CP_NOP },
+    { .name = "TLBI_RIPAS2LE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 7,
+      .access = PL2_W, .type = ARM_CP_NOP },
+    { .name = "TLBI_ALLE3OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 0,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle3is_write },
+    { .name = "TLBI_VAE3OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_vae3is_write },
+    { .name = "TLBI_VALE3OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 5,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_vae3is_write },
+};
 #endif
 
 void define_tlb_insn_regs(ARMCPU *cpu)
@@ -919,5 +996,8 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbirange, cpu)) {
         define_arm_cp_regs(cpu, tlbirange_reginfo);
     }
+    if (cpu_isar_feature(aa64_tlbios, cpu)) {
+        define_arm_cp_regs(cpu, tlbios_reginfo);
+    }
 #endif
 }
-- 
2.34.1


