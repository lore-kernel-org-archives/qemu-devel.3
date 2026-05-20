Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA1BCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPleD-0007S5-QV; Wed, 20 May 2026 14:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcK-0004JB-TW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcB-00025s-3I
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ba0fc8b1f0so35731845ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301552; x=1779906352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnvL1dEdpYA1y9JJcxfkHku7n0bLCdQETh28Vu/3wxA=;
 b=xg3L1JL5NR84U0HzYQvIe8/RcC3eRrrrRIc3zfXcIHY3Ur03u2lZO7x9jkNp77rbrL
 LPRhqvFKeOZ6+Iz9i220ekhysuXtxBj6zcOs1hz2sMqolE4hyRpdheNgGfuSuMXlnoI2
 jlaCyxybgqa4A1iv9m7Dk2C/QrUOwMKDIo2UiOaGW6mRxnFjCPGEcUMtI6mdkFH2YZC5
 Z4K6tT0GtH+RFJdnYtixaBNZHYEwM1cXfPEegHzdeTjB/MMd5VSUCtq6NsiXEfGiLSwS
 HUQJPHyqguApdZUDJ2lh847aoGd+d4eDq7ZGNB47cFogzP4xD//gTlAmIYt20Mx5wo9D
 jU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301552; x=1779906352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnvL1dEdpYA1y9JJcxfkHku7n0bLCdQETh28Vu/3wxA=;
 b=duSsAGdzuezBqbmEX3bTs9jJ6sSAriHl5lpFVcb7YOexJkqDM+SYmpszSgmV6bMvHX
 qF3DNTbiB/jLHJAlgwGp+WSGDDAPm56pqu7hgTx9UWnYAa7zbN+5788msFNoYfphUPTI
 As6PUJQCwZPaDzvbpd+ayRfSX6vR90zDUv19we1OgOQxUh3hTxgMCcZ4gyDnFjYKFF6L
 crHoMBcjgxl1J1fMr5Xh/v7q3ucnHrtMFGTbc41gquTDBt7DAqFzwBI3MQ0xdvfH2zkS
 Wy5BfHPuRlmLVmrywHFzmTfGmUNP605f4i5HdjFV5613/N0fkcUtULj5sV//UicXL3pu
 D5Lw==
X-Gm-Message-State: AOJu0YzMmUFJORDcyUzQ4CLepYCAx6w09TM1dwbOPn5t3rIV2SizBjqW
 hZrjE9wJWg/FZbjQPFeem/8lJLKTwJhhPUxL4S+is1t2O+awXsEKI316h7iIInFsm4y88Bpe23X
 /1BzeaKk=
X-Gm-Gg: Acq92OHCJyK2ZyUXwcG+hN207rwXDh9R735PeeZjUoQziBDcUwx/uSZDrPoVoHVFVZC
 WawxQxDZCFqk6K2ifBuM4SLW4F6NBUd1WJpKfCkP1im4arQDg045QiASX9R4zqH4rODEpPRRvaq
 xXXSEEfx/rFd28kk37hrKVbJ+/3w0hDYIViFlBOuViohpm5mhqZ9Vn2JiY69E2dMvGJ0+0tkRhg
 kTvCmU9tPqOyi7WmkgXIiopam1/WHnbD+PNzgbPb5sg9wdCFZMCAM3syttvuMxzdq5iJS3OuLTv
 hohSRcq+mONibZNFSgy39HK1aBSDgh7aBs3x+Gmopudz4cIZcLFwpVNGx9GnpSYwXB6DxdwLqle
 3/T08NaSfYUskGJqyJ+xUTsnwnrKJznZgHwywYpZSeqw+5j5Z1w24xcvy2sZZc88+OBlNx3Bf8C
 MVKb1SVv6V5Qp2nE9Uz0CNEWWcosVa
X-Received: by 2002:a17:902:7c0e:b0:2ae:826f:2c50 with SMTP id
 d9443c01a7336-2bd7e8acabcmr173845895ad.12.1779301551767; 
 Wed, 20 May 2026 11:25:51 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 50/64] target/arm: Enable FEAT_FP8FMA,
 FEAT_SSVE_FP8FMA for -cpu max
Date: Wed, 20 May 2026 11:21:59 -0700
Message-ID: <20260520182213.872945-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 90214a355a..93cd7ee1a6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
@@ -1395,6 +1396,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0dd6b554a0..a6b48f9c60 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
@@ -159,6 +160,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


