Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE511C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwxV-0005C1-3c; Wed, 02 Jul 2025 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnN-0000Lr-7p
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:37 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn5-0003Gz-5N
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:35 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so4764059fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460137; x=1752064937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgYGKO1mW9qx6eZh3ncNiRkSWSekpPfz5Aqf+QGYTWw=;
 b=dmQ+C7a3UQNfG+Vtl/pOZC0Vja4GV8hwlBdL+RrViuX9Fks8kTZ4PhBvrahuX0rbY1
 5GjqeZ1CWqfXaMmwR/t4hefgkkHIr5IbbFoE/hQYuds49wGztWugqRIj/UhlWS0YlHic
 SCPX6T6xbUEkPHzOmKnZJPE40WIrAkbsC+/65oBrMpVYoFZCgAU7LtqmVNrG/Rxa/PiD
 a/1EKf2amANXfHrV6NaF1n39I0nz8SEtvHMiKNFqHtQi3nBpaWowiqH9+iooF6kcE3f1
 gOv/9lDXu+JCedJ+Bw7Baa1feVp+vJHLAPaOLwPzZZQGdbboKaaROVMzvtQl4bW96fUT
 8Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460137; x=1752064937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgYGKO1mW9qx6eZh3ncNiRkSWSekpPfz5Aqf+QGYTWw=;
 b=VEdwhdvC46mgzstnAporjmUhum42XV/1iJ/9BKsIlluCCLJ9iH5swVrRB6Vc/Qg3+5
 WAyY6EFajSiswP0uplQ087CjZ2AwSTFSp+xJzlFrQcbJOm2yBVpU+todjh7FCmRX95gB
 l9jPda0nNioNH4942Q3eW5ROT8dzpFyzXOg6pLlh+cNAUukJaDL2B/dy2BFW6cT7NXc2
 +DscY0ELQSvvrDFtt3MG/50ofJDEnNDItz8EmV/wFjBW53UOBhgDDMmjVe5jtAqFGJoz
 mhXq/XxqbLWNsO1aZpSDIgu8nliFEN3DngdzX+0loWrojOaPni3GbSj3uHLK2W6nyj/C
 mcVg==
X-Gm-Message-State: AOJu0YwLRGxNm8gyEMmKaa+aq1Ybiakh/x1+k7G32bDGRK2L7NUm1wd2
 AKUwL0ne6RDxDAkf+QBfs1tT+vfI8tEksjza6x4n9f8DqX7nSLNsTcNr3iXjryzeV5fTRKijyX1
 byHEiP3A=
X-Gm-Gg: ASbGnctlDAVhDtZKAHFebtcbF8Pn4e7maSNo3hzRo5dNTKnaGIOnPKD6wVjwXvbblZm
 IZVS3r4jmapNQ5vk1fQPeQCGWeIlzsaw1xXKlmn9nyhcMKAgyBAyMXPdRWaBnZFM6DK9F+Je8pN
 to2ORmVLJVdRW5UfJ8ZfdHd8YQ6f4rSXebtCHCdBrQjxF8xLOQLvRucRXHX/zXEMA88FHGSjnA5
 fECtEBirEkK7KamjQPdSBNHa8UtbgvsgkBB0VWgU8RJe3RuWn9IzETdi+9uQtkNzTmEAd1D9uER
 uOPaApDjo6OSRhN6jvui0C40yO8N9NdnWvEH6SSMfjA9gRgBzzUKTdkZ1R4T4JihCiGvzQ==
X-Google-Smtp-Source: AGHT+IF81P3JCDdPad+V/P9tRR+g7gnLb6kmSBjKhoYoq/TgubE1vb07veGZq6n6+8Xh2dPodKaO8w==
X-Received: by 2002:a05:6870:d0ca:b0:2e8:755d:b4e9 with SMTP id
 586e51a60fabf-2f6471df620mr1829692fac.1.1751460137477; 
 Wed, 02 Jul 2025 05:42:17 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 95/97] target/arm: Enable FEAT_SME2p1 on -cpu max
Date: Wed,  2 Jul 2025 06:34:08 -0600
Message-ID: <20250702123410.761208-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 10 ++++++++--
 docs/system/arm/emulation.rst |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5d8ed2794d..f73729926b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1194,7 +1194,7 @@ void aarch64_max_tcg_initfn(Object *obj)
      */
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     cpu->isar.id_aa64pfr1 = t;
@@ -1245,10 +1245,11 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64mmfr3 = t;
 
     t = cpu->isar.id_aa64zfr0;
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
@@ -1264,11 +1265,16 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64smfr0;
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     cpu->isar.id_aa64smfr0 = t;
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 78c2fd2113..890dc6fee2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -129,16 +129,22 @@ the following architecture extensions:
 - FEAT_SM3 (Advanced SIMD SM3 instructions)
 - FEAT_SM4 (Advanced SIMD SM4 instructions)
 - FEAT_SME (Scalable Matrix Extension)
+- FEAT_SME2 (Scalable Matrix Extension version 2)
+- FEAT_SME2p1 (Scalable Matrix Extension version 2.1)
+- FEAT_SME_B16B16 (Non-widening BFloat16 arithmetic for SME2)
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
+- FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
 - FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
 - FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
 - FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
 - FEAT_SVE2 (Scalable Vector Extension version 2)
+- FEAT_SVE2p1 (Scalable Vector Extension version 2.1)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
-- 
2.43.0


