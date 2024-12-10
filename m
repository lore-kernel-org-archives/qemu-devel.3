Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA6AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jx-0001DU-3H; Tue, 10 Dec 2024 11:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jv-0001Ci-Oa
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jt-0004cV-LS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:35 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434f80457a4so13664035e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846731; x=1734451531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8nynPx3tWIm4+NC6Di7DATXmApqhu8nde8oJibmdEmY=;
 b=Z+/uWGWYsRq3XuCUJfEkaEEWLF1wWk0I070FezQLY6BmDIrBNvHbKPHZhjzdjejCuP
 xFJrBKxW43iL8I7sv6YCdikBVq20pSZ6BxDgGDKuavDx+onhwzfAyjnH/rGrJ984PH6+
 Fe874oC8F4v8mWWxrrUmfOhJjxshh9RouCKJ0J0EzAMaObU9APfVqDf+69aFnJrNPK1B
 MBOxD2EiZWA+bxryl9TBtfZnet3RVDH5rGPoZWFNpdb2Oe8wEyxq8aetN1jAb0xTd1E3
 Vk7e+f+VQauoM4xVWee0Uj1KbNlY//UcNGPGb2HXYy3MijzDAr3VL3EgitDDE6reNhcd
 z2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846731; x=1734451531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nynPx3tWIm4+NC6Di7DATXmApqhu8nde8oJibmdEmY=;
 b=Yg9S7PGLnI2QqkuOO/cAJGsv9wlnlihSTVLlwgv+lsZgSgmMpDXw5tZ7Fgy2DpOQbF
 gEfRMn+uM8HbLsOdZghUHajTXDZtwetnC3Gw2FEgJgXfIsDFhRG5BTypYClPtX2OVyZT
 fDabrNPkLjabBQeI9fOB72jrAPpaCSNbhz4SjryA5OyXbuKCCfDfiiNCEGhHSNOTIbI+
 YV6G+ymyTXuLUnutLF6znKDvHbjIGjbP8aWvdyzJJDAMvb3j2jiQcIyRGW340aU5OhXn
 f7EZKuG5aMx7OQ5S0NwDhL8oTG/Zr4RSiHwOscyoN29phj/RUemK1IuUNCtjrX5wj/VB
 WMQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS+7R5JYzCekn+DtpSCE6Om45czkjSVertZrRo/VhlT0oZqvrfwLpzSuxl8ajuXIOSrN0ZWUOLKAA+@nongnu.org
X-Gm-Message-State: AOJu0YwW1Lgm3w8wji0qg8DP3+HZuX+x8jzfT8drFOR1olUCriCTIF5V
 o8zyD8/B6mHYnEK6DdT+YPCHTdkyaU96sCDIT+Ft1c0lOO6p5JQvqNJ2d7IFEEhrWpFkyTS0eHm
 f
X-Gm-Gg: ASbGncuKsGZ+jh54pUHEiZANGyXT3Aejsz6G2FZYHuvMgcqjlz+b59NhaBfN8oNCHez
 DddIUnEWdOi7vrweS2SlZXU/1wR3v7R80lLnVmcNCjgEFO+Iv3X5G4FCF2L/DLWe9H1fQoWUhYq
 n7U2KP8gg/f5b8AhkiXX/9C1b6AeAHdX+1IBEJ/hxpHHbH5uF9vh+V2MaIYvYmKPyy7qvFsjCb2
 CMQPkYRIjVKjSs2Y320Cxi5yG10//kpn5gf61IMJL68Vj1puhlwgUYgb7Im
X-Google-Smtp-Source: AGHT+IFoWF7jcMfEdTLc8RWVVdcoOejn6ed6Y4OYgWZvmL+bCENrLDaQ9a6KGq7ZEyxrZCU3j8myfA==
X-Received: by 2002:a05:600c:4ed2:b0:434:e69c:d338 with SMTP id
 5b1f17b1804b1-43502182706mr28229585e9.5.1733846726092; 
 Tue, 10 Dec 2024 08:05:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:05:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/10] target/arm: Move the TLBI OS insns to tlb-insns.c.
Date: Tue, 10 Dec 2024 16:04:49 +0000
Message-Id: <20241210160452.2427965-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Move the TLBI OS insns across to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


