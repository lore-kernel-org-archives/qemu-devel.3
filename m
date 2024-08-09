Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6750EC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU30-0002Cb-Ee; Fri, 09 Aug 2024 14:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2y-00025s-NV
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:04 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2w-0007EF-OI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:04 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f0271b0ae9so23785321fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226941; x=1723831741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OTKwxuPziiy0+9qyVmM4AyVNPdnxPukHZnKDv7thDS0=;
 b=jegS4DYaDY0hCVV+NeObu9yuZEO/d6owZgQEwiAD7xMd0pbmj0bgSeYk0rQnV4VwB+
 de0oMGsEGw2nF2pdvEgAyfFpqPSKos4BLvf6i1FG0I87kAZDEfPwJjzwbccy3SkURde+
 n733lB3OY2HLVWD3zNHsFES+6TcrdVDMkPxKuCN8gY4H/Jc2vYgeE8iNFozApG8RkUuh
 aZ6ivFq5GKc7wbn19vw/efmm3rwkYb1uqPmMprBTw5gPZzPzPNrOFqD6workj3DbDyWl
 vo+V2+Zb30/P4T31jTVXygNJX0iqA+4WD5SjkVo0N6zMcYR3SQsfVrR5JW3rli2TOEyo
 GH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226941; x=1723831741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTKwxuPziiy0+9qyVmM4AyVNPdnxPukHZnKDv7thDS0=;
 b=bJCJtRQqSEUDBxx1UQ5d5KAVykx/RLWNucZlTmq39tuoigTf5qlnGsqhvILJKq4n5/
 g0VrsAT2kKWvtOPCDuYW+hQNIX9jSQ4IBq0oojGkjqzt4ZIGfGkb6GJxjkks66v4L4WO
 LLNqMR499yEkdBF6Kzw/k862FFMlUPGO1xobsam+rnRTADrFU//grdqXU+KzIh8q6csC
 v+Tkk3dTvHD890Ru4u70PtRotAJ1k2rIEyQw1n1HM9GAiNj2lqgyqhAKwrNftn1V0WZB
 NGtw3BbvadjNupbWWJhS91w63X8s6R6Z/SSAH6xjI3kEXQn19si0yrHPQyWWS0zugALl
 6e4g==
X-Gm-Message-State: AOJu0Yx6Vtq6GSda2ZF43YUD94eFxEaKqGDB+Ynwrg+ysAhV0mHfotAg
 X7WuU4gNk7VE/IacCtN1GRIx31W3spML35PizINl/oOYkNNz/Jm6YIb7fxBwAMirbf6X4Rpe9/f
 e
X-Google-Smtp-Source: AGHT+IGmz4CoUcJ5S5EgVqzAUXDlT0bafavuNsRmNwNytbLIxpdtTvSR+YvA7E+rdJFiLDGVr1YdyQ==
X-Received: by 2002:a05:651c:b29:b0:2ee:5ed4:792f with SMTP id
 38308e7fff4ca-2f1a6d0034amr18342261fa.2.1723226940590; 
 Fri, 09 Aug 2024 11:09:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.09.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:09:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] target/arm: add support for PMUv3 64-bit PMCCNTR in
 AArch32 mode
Date: Fri,  9 Aug 2024 19:08:33 +0100
Message-Id: <20240809180835.1243269-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

From: Alex Richardson <alexrichardson@google.com>

In the PMUv3, a new AArch32 64-bit (MCRR/MRRC) accessor for the
PMCCNTR was added. In QEMU we forgot to implement this, so only
provide the 32-bit accessor. Since we have a 64-bit PMCCNTR
sysreg for AArch64, adding the 64-bit AArch32 version is easy.

We add the PMCCNTR to the v8_cp_reginfo because PMUv3 was added
in the ARMv8 architecture. This is consistent with how we
handle the existing PMCCNTR support, where we always implement
it for all v7 CPUs. This is arguably something we should
clean up so it is gated on ARM_FEATURE_PMU and/or an ID
register check for the relevant PMU version, but we should
do that as its own tidyup rather than being inconsistent between
this PMCCNTR accessor and the others.

See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en

Signed-off-by: Alex Richardson <alexrichardson@google.com>
Message-id: 20240801220328.941866-1-alexrichardson@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8fb4b474e83..94900667c33 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .writefn = sdcr_write,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
+    { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
+      .cp = 15, .crm = 9, .opc1 = 0,
+      .access = PL0_RW, .resetvalue = 0, .fgt = FGT_PMCCNTR_EL0,
+      .readfn = pmccntr_read, .writefn = pmccntr_write,
+      .accessfn = pmreg_access_ccntr },
 };
 
 /* These are present only when EL1 supports AArch32 */
-- 
2.34.1


