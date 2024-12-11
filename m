Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C423AE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNxm-000783-P0; Wed, 11 Dec 2024 09:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxK-0006sD-8O
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxH-0003ri-1d
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-435004228c0so29577255e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928285; x=1734533085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z7Wwz4+m7jwaNqLs/+a9euIZsSuuSSKkipHbZZdLh88=;
 b=mImTA1i/ax7yFynEpLzhC2H4IeziU8JS6cvtTrVB/7ZTt64b3kvYRaZbTgCCo9gQpc
 r2LeAn2vDKu2q6f9fM0PQ6Y988bB9N8oAS4Y2sRyZDlnraF0WguZIjnyPjDNrajPZeKn
 Ef7NlsJTRp98V+cMOn+IJ7ZGa1RaNFCQYSAYvx+En2JzQdWs0Eo93wqJVoJ1NTtB6X23
 q0RPAjbZG4BB55P4QmnpQzLNmam5cUlHkw/LqyeVG7XKxitXYySdvlmuv+N1iwvu8ZDT
 vyCK9ffhQRL5vulMX1ll94bs6cH4e2QyvEeuFQZH52BikFxTsDJ37kr8M4ehu0dUrh8B
 Bw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928285; x=1734533085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7Wwz4+m7jwaNqLs/+a9euIZsSuuSSKkipHbZZdLh88=;
 b=bH31aUgaFw2S2Y80WlVynsFVAj1MLC8OLP1RMMtLWG972Psw06Sd6e96kDuFcJlPGi
 4EUgZ5PxAD/YESWgtqK8XMN/TH6KimmvVJspk9ajuOkGpOPfKSPLGxPfZJY+pTavXxW1
 TvBaNs3PmExz3b/E4yvnCN2u7j12I+janZ7y9rRkBxhp5s3PPkRSCHP+jUwQV/of2lBq
 q7pIl9wR6Jgc+qsmIZY9FrExrOC+2QqPUa0h9dezqpiQVEerBNXOD3I4IR0nLNaoK/+T
 6I9rj9pBatGSmRVOnLZYjksGamq5/ac9mu7gSD8AIpYXlNhZ32BT0OAE4RVzXS/Gx9iX
 yanQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwjP2SwO/7YADtEie+IJMdukUz/zq91OI8+trLFsyM1kHTZ11zKiF2EAUO31fD3K26OEpOpHDv0uxX@nongnu.org
X-Gm-Message-State: AOJu0YxpWJpZIIgOcvSaLpeodgFudqABphoWrO4t+aYrkDmV+YSDYn1k
 T6+C5SJB0/3D1NO5cdEnJFj+LuCDn6fLQgjlnc7U9PcU47lN5F87D+ewIoselAA=
X-Gm-Gg: ASbGncsFhdZPFVs75fpFWPmisMiLlhpd80yqDjPOspN/gPBKspxd9PeDajfhH+lK7Tz
 O2MWk4NACGtKdUMzoOtlj0uQdzSEA/P0EGehoweQihvTK7rxpfonK17KWyIdLKy8f00hk1jWqH4
 zPlygRV2G0wPqsLcw6oFI82FJMar7z+MWWsb0MbEHDqw+SoacbquVWFb4LTMbEBBcwntm2SxTzy
 QD5VG6aYv9wbt2/0vuLd00RJilIWDDyi819GzwAo168mZ83T4st95mIbns4
X-Google-Smtp-Source: AGHT+IEH95jIYcGe5bMADH9R1pWThmTgQo9lPy2iTLO0QLX6tba8h5gWEHW/PP37U4dysSYifp9XFQ==
X-Received: by 2002:a05:600c:1f0d:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-4361c3c7155mr30554195e9.17.1733928285517; 
 Wed, 11 Dec 2024 06:44:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e54ef20sm19477685e9.5.2024.12.11.06.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:44:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] target/arm: Add ARM_CP_ADD_TLBI_NXS type flag to TLBI
 insns
Date: Wed, 11 Dec 2024 14:44:37 +0000
Message-Id: <20241211144440.2700268-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211144440.2700268-1-peter.maydell@linaro.org>
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
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

Add the ARM_CP_ADD_TLBI_NXS to the TLBI insns with an NXS variant.
This is every AArch64 TLBI encoding except for the four FEAT_RME TLBI
insns.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 202 +++++++++++++++++++++++--------------
 1 file changed, 124 insertions(+), 78 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 0f67294edc4..fadc61a76e9 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -617,95 +617,107 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
     /* AArch64 TLBI operations */
     { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVMALLE1IS,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAE1IS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_ASIDE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIASIDE1IS,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAAE1IS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVALE1IS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VAALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAALE1IS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VMALLE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVMALLE1,
       .writefn = tlbi_aa64_vmalle1_write },
     { .name = "TLBI_VAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAE1,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_ASIDE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIASIDE1,
       .writefn = tlbi_aa64_vmalle1_write },
     { .name = "TLBI_VAAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAAE1,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_VALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVALE1,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_VAALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAALE1,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ipas2e1is_write },
     { .name = "TLBI_IPAS2LE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ipas2e1is_write },
     { .name = "TLBI_ALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_VMALLS12E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_IPAS2E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ipas2e1_write },
     { .name = "TLBI_IPAS2LE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ipas2e1_write },
     { .name = "TLBI_ALLE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle1_write },
     { .name = "TLBI_VMALLS12E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle1is_write },
 };
 
@@ -732,54 +744,60 @@ static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
       .writefn = tlbimva_hyp_is_write },
     { .name = "TLBI_ALLE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_alle2_write },
     { .name = "TLBI_VAE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_vae2_write },
     { .name = "TLBI_VALE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_vae2_write },
     { .name = "TLBI_ALLE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_alle2is_write },
     { .name = "TLBI_VAE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_vae2is_write },
     { .name = "TLBI_VALE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_vae2is_write },
 };
 
 static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
     { .name = "TLBI_ALLE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle3is_write },
     { .name = "TLBI_VAE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_vae3is_write },
     { .name = "TLBI_VALE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_vae3is_write },
     { .name = "TLBI_ALLE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle3_write },
     { .name = "TLBI_VAE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_vae3_write },
     { .name = "TLBI_VALE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_vae3_write },
 };
 
@@ -981,204 +999,232 @@ static void tlbi_aa64_ripas2e1is_write(CPUARMState *env,
 static const ARMCPRegInfo tlbirange_reginfo[] = {
     { .name = "TLBI_RVAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAE1IS,
       .writefn = tlbi_aa64_rvae1is_write },
     { .name = "TLBI_RVAAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAAE1IS,
       .writefn = tlbi_aa64_rvae1is_write },
    { .name = "TLBI_RVALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVALE1IS,
       .writefn = tlbi_aa64_rvae1is_write },
     { .name = "TLBI_RVAALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAALE1IS,
       .writefn = tlbi_aa64_rvae1is_write },
     { .name = "TLBI_RVAE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAE1OS,
       .writefn = tlbi_aa64_rvae1is_write },
     { .name = "TLBI_RVAAE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAAE1OS,
       .writefn = tlbi_aa64_rvae1is_write },
    { .name = "TLBI_RVALE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVALE1OS,
       .writefn = tlbi_aa64_rvae1is_write },
     { .name = "TLBI_RVAALE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAALE1OS,
       .writefn = tlbi_aa64_rvae1is_write },
     { .name = "TLBI_RVAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAE1,
       .writefn = tlbi_aa64_rvae1_write },
     { .name = "TLBI_RVAAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAAE1,
       .writefn = tlbi_aa64_rvae1_write },
    { .name = "TLBI_RVALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVALE1,
       .writefn = tlbi_aa64_rvae1_write },
     { .name = "TLBI_RVAALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIRVAALE1,
       .writefn = tlbi_aa64_rvae1_write },
     { .name = "TLBI_RIPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 2,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ripas2e1is_write },
     { .name = "TLBI_RIPAS2LE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ripas2e1is_write },
     { .name = "TLBI_RVAE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_rvae2is_write },
    { .name = "TLBI_RVALE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_rvae2is_write },
     { .name = "TLBI_RIPAS2E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 2,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ripas2e1_write },
     { .name = "TLBI_RIPAS2LE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_ripas2e1_write },
    { .name = "TLBI_RVAE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_rvae2is_write },
    { .name = "TLBI_RVALE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_rvae2is_write },
     { .name = "TLBI_RVAE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_rvae2_write },
    { .name = "TLBI_RVALE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_rvae2_write },
    { .name = "TLBI_RVAE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_rvae3is_write },
    { .name = "TLBI_RVALE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_rvae3is_write },
    { .name = "TLBI_RVAE3OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_rvae3is_write },
    { .name = "TLBI_RVALE3OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_rvae3is_write },
    { .name = "TLBI_RVAE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_rvae3_write },
    { .name = "TLBI_RVALE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_rvae3_write },
 };
 
 static const ARMCPRegInfo tlbios_reginfo[] = {
     { .name = "TLBI_VMALLE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 0,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVMALLE1OS,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 1,
       .fgt = FGT_TLBIVAE1OS,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_ASIDE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 2,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIASIDE1OS,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAAE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAAE1OS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VALE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVALE1OS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VAALE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .fgt = FGT_TLBIVAALE1OS,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_ALLE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_alle2is_write },
     { .name = "TLBI_VAE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_vae2is_write },
    { .name = "TLBI_ALLE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_VALE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
       .writefn = tlbi_aa64_vae2is_write },
     { .name = "TLBI_VMALLS12E1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_IPAS2E1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NOP },
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_ADD_TLBI_NXS },
     { .name = "TLBI_RIPAS2E1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 3,
-      .access = PL2_W, .type = ARM_CP_NOP },
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_ADD_TLBI_NXS },
     { .name = "TLBI_IPAS2LE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NOP },
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_ADD_TLBI_NXS },
     { .name = "TLBI_RIPAS2LE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 7,
-      .access = PL2_W, .type = ARM_CP_NOP },
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_ADD_TLBI_NXS },
     { .name = "TLBI_ALLE3OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_alle3is_write },
     { .name = "TLBI_VAE3OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_vae3is_write },
     { .name = "TLBI_VALE3OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
       .writefn = tlbi_aa64_vae3is_write },
 };
 
-- 
2.34.1


