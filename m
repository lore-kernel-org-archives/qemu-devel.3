Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB95CD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrd-0000Wa-UL; Sat, 30 May 2026 19:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrZ-0000Sx-PW
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:05 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrX-0007dA-SZ
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:05 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8588ec1b44so602731a12.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182782; x=1780787582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwhrK5xY8MqHIVp+UxD/XyCeJ7xCC3dcRnmxkpZ4IXA=;
 b=GjULeUZa0VCzBQX6aQGign8ZJN+PezSymBIzkPPPuI8x/5RJtIElSLCRYfmO/j2Yjz
 PfcfrUTlFgOeTaQhtp8vtxefp0VRgzkerTqH7zelaIHGLxqDuOrfHVeUnKF83jKncOyx
 ziVWd7JK1DyabGaJ6BTBGVjUuLRD6qlaNNkAwtznhhEKWyDy1yuM016FB7j6CVNauoi6
 KtLASHiArPncbxuh8fRQOMPLb173EOrG+XRgK+SJJy1DTXmJNt5jLpLIfs+Dz6oLdxWq
 2+gRiFeQMThtvzaVWmSIkYQbfyoFrtk7R4Jh0yed5aeQI4keK+i0BjN91oRrDGeIz3ih
 8t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182782; x=1780787582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwhrK5xY8MqHIVp+UxD/XyCeJ7xCC3dcRnmxkpZ4IXA=;
 b=s7cE3yvJ/3fnNFPhBl/ZkUTthKH6BC61Ee/hU9EbKY18+LAIwejyLDkRylOyuknxpd
 KQIQF0Ft/JGPX1MFdc1zBLmsI2epOtonnU/oRPzW1j9FDVsMg3xpJSIih4KOAQClPxlf
 4Da0lcLwoOMKEv58XSAkl01yb/WWgYxA9yUKOCzVNYqQCh/2v7enTu4ApAEMBWVwYwYs
 DKky/QfT0I2iHf6jRv3sGybdbboHnBdkMnuCUxteiNEw+YbE1qInstz0Wi7Y9W1foweZ
 Kv0hv6mD0P+/L4QgTRYhEQdRReKfkNLTohmqGAeN9xUBZtdwLt0bA6nDqJWU6UyFLQ0c
 1TjA==
X-Gm-Message-State: AOJu0YxbZYV3Ebhfd63C5Gk4zPxT9CoumB92dNawG3aQ8FPbwahT+3qN
 h0axSzbkiuM2nkQj6O4RuvI/gkWopS5/ebPwO+RnaIR3sXk7z0HyC7MHfx6vUHT0sSeA793/0Zf
 63PSID84=
X-Gm-Gg: Acq92OEPLkx79XNY8C1563OR6oZzFjYYG55vvmbRuP2nSFMbQTGXqZ3CUVWEDLAfsAJ
 ggDUpFApl1oAMenWs2iNCDaF1VCXFqw0jqUaQQg/eNKAdafUvY/ZVhhpl76KtaC1MazZyO+1xj2
 /B6WsbWyI8vLbO7RENh+Sr0+puWKHqUmPSH0s+AQAu0Uvm9aUzHmL50ifg1aKcSwuwpDdeC5XQN
 K/yESHaLNf0tZ2hEjCtku8hqUcFqcvTRclDaoAyZalgjf6ZS8R8nsmZ2+gSvW66CAW5spBWKuYg
 s7dAZTpyLZJNmtQDmWMfuMI5KbzVZEt4gA0ddqVdcIl5yPrn52eP5bcRiHmV9x/+esJrOGBM5ug
 Z0W1cagJe96TOw+91W/vXPCTGNPn6xHNyMgfhFiC6mOMOlxZP7xX2ribM4NbbRWqNc9wDqb7jIM
 Qkna/Okk1c3Q2ysE8asdGjQpyQa8sS20g+wDTj0oWH1Q9sv51KBw==
X-Received: by 2002:a05:6a20:c709:b0:3b3:bdf5:117f with SMTP id
 adf61e73a8af0-3b4281daa25mr5363619637.40.1780182781897; 
 Sat, 30 May 2026 16:13:01 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:13:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 35/41] target/arm: Enable FEAT_FP8DOT2,
 FEAT_SSVE_FP8DOT2 for -cpu max
Date: Sat, 30 May 2026 16:12:23 -0700
Message-ID: <20260530231229.400441-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index be33fede6b..d40e39169b 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -228,8 +228,10 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
                                ARM_HWCAP2_A64_F8E5M2);
     GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
     GET_FEATURE_ID(aa64_f8dp4, ARM_HWCAP2_A64_F8DP4);
+    GET_FEATURE_ID(aa64_f8dp2, ARM_HWCAP2_A64_F8DP2);
     GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
     GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
+    GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1e2d1311b9..893e20f0eb 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1378,6 +1378,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
@@ -1398,6 +1399,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8d786f9dae..f1c8f5aa68 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -76,6 +76,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT2 (FP8 2-way dot product to half-precision instructions)
 - FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
@@ -163,6 +164,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
-- 
2.43.0


