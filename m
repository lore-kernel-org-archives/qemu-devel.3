Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C463FCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4G-0000Ke-Qm; Tue, 13 Oct 2026 04:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3P-00071e-S0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3K-0007dx-Gm
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so15777465e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880802; x=1792485602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gVXcihlenbO4kdBms1ArgyANCPh5orEbYliejO8EpDg=;
 b=Gu977fvhfOmxoMP+2BTvjXJr0WPZjnJK2C7p5h3oVMAUS9/GOSSuu6cYHe/X2Xf7DM
 mMH0WPF8AKESqgrPRF2sHf8XQeRAXZydDxcp6Ah2t3fOPXxZhcdtMJ6b/A4WnZPKHZuq
 3BDTVlMZxjmYz6vFZBl8PtJaQ7KdeXuHJj3M/o8tfhHHI/NXGOafExCNiAndGw7/Xxt4
 IoYCzid4EHWLZoj0n/0Ng0HHWdaCq0x4PCksoyZ1ieoPKXttY3nsBpRFU3RNoDcy49Ap
 AugDAio077CwdN2oWqKChwRxRXXzvYDDHigxVkmNVWzSVL8IIQQr5KeC5rmWc4HoKRpz
 8eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880802; x=1792485602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gVXcihlenbO4kdBms1ArgyANCPh5orEbYliejO8EpDg=;
 b=2C/S3TmsC9NmQKAE41bVvRPosQDodz1nkm1venwuwb9/ETda+wzmsmX3RgKyLqB04Y
 0vMRtnRMUw/onxBE0X3nlKgo90xs9L+hHkPOcu0DpRrQfR+wTxJOaz+4V4Se64d9UEHo
 oG7rD45n+zOmOWDKbej0hO0ypZsXUxPVYE3GViyDNM1w55ouIjLekbp4NqOlVYukb4W0
 lvwJyNWEB3BHq4cxYHcEFrxx/zxaGCAi/0M/O85ROyuouUVBjJXswMf4neVUF8Rm2/NK
 qFnA/3Bdq6UmmTYZiUW334xCfJMecds1N/9VVA7WP2Cw031IEs93s8zbLhuB5poDilve
 PLJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr4V3y/BDHUyh3+KdQOA5F547GanDRVHfA1Ty6/qnbZCGu02TsyXJLx7oEf8lhfqm0kjGB0XX12FZc@nongnu.org
X-Gm-Message-State: AFq9FYIr1s/5nhLZts5dl/BDsD6oh0yhSOEzzpYoYFzhK2y/QB+O2O43
 F5vd5M86lEMh7GmEuFa4ANoqZdmAlRDIkVcahHfZ06T2WleQoDOwmFqH+x1jSkHMuL4=
X-Gm-Gg: AYBFou1KmBi5Yh7IuRxE03SN3k2wagrS0b0e+C++a0XOj8RuyDusH3aSYTqZ9DVD1SE
 fs84Kx/hQmFSwVaUpImJJ8OPz6TWG40vV5tN+0zfOFBBLTBzIodwQI8+O4cgaFUov1YH9V10PCs
 9EgSEwtlf9h5cfiA3JuDBaBr1ZhFhpmETPASSR7v5iCFRwJlyjRDatYZbWNpSIbEONeS5XKqHZg
 GYtRVARWOntYFalaO27/PC5DmkLhRhNp8yoTIiZRhrVXhrl9Wh6UOtiRlIxHeVmtTUUHDw9Fb0p
 d9pY5h8YO81fkT06H1DLh9LZ4AtD/tAgQ0IXh02EzqKgTWGgTD7aWnWNcsfeddczND3b6SprC8z
 79YRqpNWPTvLX8IFUWGNLmFWeCa7c65iQTrWO4+02CYwNL/Q+cF7V7aS5YffajrkGqzsr8OBymz
 VhqglQYCNG55S80QULf9OBBMChWi52HNZkCegJdDvICpm1wKlZ95gY787MHXa4ZVNy6SJdZjoYE
 NzbEegYzsYn1StQXiHB7HCXfRGg1vGJyfxebNZhfdMFz3wrFlYquxb6Qy3e1ucrbn6JmjOTO6/m
 x6w=
X-Received: by 2002:a05:600c:348d:b0:4a1:813f:2a63 with SMTP id
 5b1f17b1804b1-4a18e4aa26amr220016585e9.18.1791880801179; 
 Tue, 13 Oct 2026 01:40:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 19/86] target/arm: GICv5 cpuif: Mark GIC registers for
 fine-grained traps
Date: Tue, 13 Oct 2026 09:38:26 +0100
Message-ID: <20261013083933.1024405-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Annotate the GICv5 cpuif register cpreg structs with the
fine-grained trap information. This covers all the bits in
ICH_HFGRTR_EL2 and ICH_HFGWTR_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 55dc2e3b3b2..a829b90f334 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -855,17 +855,20 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     {   .name = "ICC_IDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 2,
         .access = PL1_R, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_IDRN_EL1,
         .resetvalue = QEMU_ICC_IDR0,
     },
     {   .name = "ICC_ICSR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 4,
         .access = PL1_RW, .type = ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_ICSR_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.icc_icsr_el1),
         .resetvalue = 0,
     },
     {   .name = "ICC_IAFFIDR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 5,
         .access = PL1_R, .type = ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_IAFFIDR_EL1,
         /* ICC_IAFFIDR_EL1 holds the IAFFID only, in its low bits */
         .fieldoffset = offsetof(CPUARMState, gicv5.iaffid),
         /*
@@ -877,83 +880,97 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     {   .name = "ICC_PPI_CACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 0,
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
         .writefn = gic_ppi_cactive_write,
     },
     {   .name = "ICC_PPI_CACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 1,
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
         .writefn = gic_ppi_cactive_write,
     },
     {   .name = "ICC_PPI_SACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 2,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
         .writefn = gic_ppi_sactive_write,
     },
     {   .name = "ICC_PPI_SACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 3,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
         .writefn = gic_ppi_sactive_write,
     },
     {   .name = "ICC_PPI_HMR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 0,
         .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_HMRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[0]),
         .resetvalue = PPI_HMR0_RESET,
     },
     {   .name = "ICC_PPI_HMR1_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 1,
         .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_HMRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
         .resetvalue = PPI_HMR1_RESET,
     },
     {   .name = "ICC_HPPIR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 3,
         .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_HPPIR_EL1,
         .readfn = gic_icc_hppir_el1_read,
     },
     {   .name = "ICC_PPI_ENABLER0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 6,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_ENABLERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_enable[0]),
         .writefn = gic_ppi_enable_write,
     },
     {   .name = "ICC_PPI_ENABLER1_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 7,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_ENABLERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_enable[1]),
         .writefn = gic_ppi_enable_write,
     },
     {   .name = "ICC_PPI_CPENDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 4,
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
         .writefn = gic_ppi_cpend_write,
     },
     {   .name = "ICC_PPI_CPENDR1_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 5,
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
         .writefn = gic_ppi_cpend_write,
     },
     {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 6,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
         .writefn = gic_ppi_spend_write,
     },
     {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 7,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
         .writefn = gic_ppi_spend_write,
     },
     {   .name = "ICC_APR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 0,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_APR_EL1,
         .readfn = gic_icc_apr_el1_read,
         .writefn = gic_icc_apr_el1_write,
         .resetfn = gic_icc_apr_el1_reset,
@@ -961,6 +978,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     {   .name = "ICC_CR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 1,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_CR0_EL1,
         .readfn = gic_icc_cr0_el1_read,
         .writefn = gic_icc_cr0_el1_write,
         .resetfn = gic_icc_cr0_el1_reset,
@@ -968,6 +986,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     {   .name = "ICC_PCR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 2,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fgt = FGT_ICC_PCR_EL1,
         .readfn = gic_icc_pcr_el1_read,
         .writefn = gic_icc_pcr_el1_write,
         .resetfn = gic_icc_pcr_el1_reset,
@@ -1102,6 +1121,7 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
                 .opc0 = 3, .opc1 = 0, .crn = 12,
                 .crm = 14 + (i >> 3), .opc2 = i & 7,
                 .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                .fgt = FGT_ICC_PPI_PRIORITYRN_EL1,
                 .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_priority[i]),
                 .writefn = gic_ppi_priority_write, .raw_writefn = raw_write,
             };
-- 
2.43.0


