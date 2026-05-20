Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C96FCD5BAE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZH-0007gM-JA; Wed, 20 May 2026 14:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYu-00079N-4V
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:35 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYq-0000Xr-W6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:31 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so5462546a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301346; x=1779906146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGCvxGAP+SJVq2oNHJQ8ObdWRbCOzKV7LFFW7Nyer9U=;
 b=PULPF/nNpJT6iiDlMT4C53LINmTlhrWyPY9ZnmsTKESmHhYD9GVVdeKsje2j4PiM1p
 hXD4LCWEDLE6IcWBYMq3ErbFZzRuA0fPfPGrnhvb3Ovm2foR70GY+s+wQo7beDWxWBTa
 wjfc5WAzT1Xcx7LQ3syiKjcjAl4Px9o3yJmfy13nwAqcFpGH1XjhQM6EwXR1riQapcC8
 RKV/CCqPc6KSw5/1yLF6J/6Nu/0UeKa/nIjuv0Kse9IVRCliEqD1SgQ1U69nxnMrIXj/
 i4k367OrDrlYm8sR2GCK2d3Oyc2p1bBrUBhf7tyscsPuKaughQRr/u4oW0KKeO7GlF/r
 EFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301346; x=1779906146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mGCvxGAP+SJVq2oNHJQ8ObdWRbCOzKV7LFFW7Nyer9U=;
 b=mE9H7FHhk3eL6HJU3ZHnRZ484zt8XIcpbXGWidpAeXiFwVxTuagkKZ+kL/VrwOhCIw
 gTjDTr+aup1dWoLg1tuDlPiFhkdnh2qTzcMCy4QZPoWr5vHwKcDRg74WHKBLTYNCCmpb
 Ym7c4MOJbySHRmVwWwuvulTYxT7l/stV3vEtPQuKpi9nT6HjS6dMgD/xd/Soe4OOQHgG
 u2u6aE+sJHvnWa5dZh+Lh6v2RyExRJuIDklePAf/Is0vGNHOsVshrWQbt6YgdtGGqtMF
 H7IRtqAAKqcQSBfLCFWXtv3RTE08mXszjUHZBHXOgT+o2MLV6GFUjEwqMjo4e+MLComn
 a9oQ==
X-Gm-Message-State: AOJu0YyTqPsMqn8lA9H+KyUwr2selOOcwiwmJgcfB6BoG1+olcZhH6tY
 0Y/n5MUoN8vmWbPNOzBE/UWeKoiE5x/choIuj8IIpZPDyFr8pbTELs1DV53ut2QPWp/S+k+b3a/
 nIlq9vRE=
X-Gm-Gg: Acq92OGrjjNjTq/QVSn48S7ylVe9bmyE/5wOzpiKqwAjzYExu7wMateh0IMu25cJJEf
 BWUpdhXsqeQ50cKwzRFEITdnLznUOwfTb84UKZGwt5vcDsGt03zHx2GD1uQlSrMihhysQyddLPR
 EkYj2p9NVfv2048xkfn6RlOqerZAnWBwT15tc37iZ9Z0IWd82pEq3HhwPyH5C2WPdDZ9rQ44xiL
 BLGiKIOvQ8Z/V5X2Xl8w5uDQeDeCGQF+oTFoPQUP5bNzd7k6Qey++KRofVs/eBZD/nc5ajFMWbq
 WBPRgMDZqz2hC8MkfuRs6yA3kBbAlPmD9278NdtC3855DecJnyS8NzVymwc0ZGYrTVVVBNRcZ7U
 s32cpOBtabBpIj9gp+IcsEF4D3BKqMJk2HWFOzpwjmo2CiNwBm3ylB1gd3AuR1QtEd3I+RX8Ql8
 IxqqlVR6meT3hfBRsVBI7xSQZ4QoC0
X-Received: by 2002:a17:90b:4b8f:b0:367:c442:3f20 with SMTP id
 98e67ed59e1d1-36951b90f8dmr22493072a91.19.1779301346197; 
 Wed, 20 May 2026 11:22:26 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 17/64] target/arm: Implement ID_AA64FPFR0
Date: Wed, 20 May 2026 11:21:26 -0700
Message-ID: <20260520182213.872945-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h    |  9 +++++++++
 target/arm/helper.c          | 13 +++++++++++--
 target/arm/cpu-sysregs.h.inc |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

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
-- 
2.43.0


