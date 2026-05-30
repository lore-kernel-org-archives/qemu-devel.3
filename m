Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CB8CD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrY-0000P0-Bw; Sat, 30 May 2026 19:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrV-0000ML-8z
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:01 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrT-0007b6-HG
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:01 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36baec934b6so1152059a91.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182778; x=1780787578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNC9uxOlge1Zc9qz5XYFu2TueBOfJcxpuXKeADefLUQ=;
 b=fxBf+cpryuAcRWbXEtCd9h7HKu58IIakWU7mIajTcW3akyTGH0e1RCs/G/wzGAMzB9
 7cT0JVtzkJwoxMaHljksMThlOmCryW3BhQI+NgvvffG8f/T++m6gAp5jsvULabzRuLko
 BE3ybQnxHXYTa8/tQPhvrxt5OcyFXPixItMxit2hKQb8O6/q2aNaooCVw4W4g2E1M2II
 iNLk2H5W/WAxlOMXITGEpjkvYx8MQchueTtSZWG3Rlx3qPsn6tdeuf4gOrCLDP/tOT6Y
 oK38BAriylx2ZYT7CPzn5REzHy4arsyX5kyoFiNbQifoNrPLiOe2iNcVkJUwYCYsxxgo
 cZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182778; x=1780787578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZNC9uxOlge1Zc9qz5XYFu2TueBOfJcxpuXKeADefLUQ=;
 b=VWMhovt9dv41+CVblBluBkXLirsxFsjaXpREo3ex4q0C0jypFn63/0C0+yEMcxdkDe
 ogvKwaKAseHYrjHFMKYRmjl5v6lfg45KM6bKf6GnY0pd27BxUOpRwlvaSWGADOx/rKs6
 I49xarjsk/xtE9H0IuQHyTAmNeZVZ8EXXRV632gW7fJ2a3vbMvVruvYiVapp3rahHtQW
 sFeS+gGczpcSSpEatj3y2JbZZEdg1l6m+OTc+/c/jotceyYP1/F1ayqd1k21qHUV9QNX
 gLZU1MS6gHXwhsiVt2mpZ5kRhKwM+TaS7+FgMjsKi4otTHc++OCndZFXQbP0bW8tjJa6
 62QA==
X-Gm-Message-State: AOJu0YxC6xqTBtfZ4r3hXR86v8nQM766B7zDI+AREibnvPSJcdXHK/Wj
 cOEehGSFA0ic8p9mRKkTBHVz/jxLOfIFpK4Mj4oodqd3SrsyN8pBsp+S9atthGPDu88QvkIul8f
 zAEnyRSQ=
X-Gm-Gg: Acq92OEc1ntXmu3agxJFukuOXBzrLBeEuxjV4VRJoVCgM5FyVHbaHWynJsSeaNM7VZh
 NKimbb20xiT3Qn+XLoVxMgHrsVh/CK3jURWy7M0z/oO7+T7BhS+V5dmaM9lFs4DluuijB+TXGa2
 whOKTjuVJTUC832jAy5c5+Djpfn7VhCkcoeJZmUjK901KQfKNoFYp2TF2vUnlH30oOcmmFNomZQ
 kC+NeqeM3i4QOhe6kR0mYw1limeAnBuC5bzL/jRsRhvQKaY96bCDrV4b8bT+8wUHtvNyrwzxaiY
 3+UnlEIhQ2untirrASzU6nXGPHMEqDZZ5mk1fxdpXv4upTobbHgqTLDKdVj8OuTt7a7pluv5V7w
 jAlnjc0DqXFdqwdHEmMxTxvitvTkRLIm67RHKH+6eWyd68BhksYmXZ65R5ZxZ0pjjLzJZtMgQr0
 MUh7PirR/dt/9lYylXJIHC1Y80rVp70ri8k+hH3m0=
X-Received: by 2002:a05:6a20:144f:b0:3b2:b1e9:f1f2 with SMTP id
 adf61e73a8af0-3b4266e645dmr4420952637.4.1780182777928; 
 Sat, 30 May 2026 16:12:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 29/41] target/arm: Enable FEAT_FP8FMA,
 FEAT_SSVE_FP8FMA for -cpu max
Date: Sat, 30 May 2026 16:12:17 -0700
Message-ID: <20260530231229.400441-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index 06c14e82ea..a82d65a681 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -226,6 +226,8 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
+    GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e466ab5b8a..6ad841c51b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1378,6 +1378,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
@@ -1396,6 +1397,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 41fa9bfca3..78d1938656 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -76,6 +76,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
@@ -161,6 +162,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


