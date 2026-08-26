Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D03C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdv-0008WK-1b; Wed, 26 Aug 2026 13:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdp-0008SE-RG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdn-0004kr-KU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8534d507f59so1407795b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766142; x=1788370942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V/TzolQ/cWgbzzqSGhsngN831gj0h+hUFm2am6qAF7c=;
 b=N/vwX8JXwzvJPd91VSYvxNSaQhmORzC5SLAi5KfsoIjE7iao549s5hBiapDF7Mj1/T
 WQV892g40QsJlPaOhD2fxelfQFJiCiIZcPYn/Px8cIHxn/s9BKkXQfRtCn9OV6If5bb1
 jxENt7iJsLvum4cCrp8rBksFPN3x4cbdrQa1ySWABLdGXDW+Boyf17o0nPicB5IeCf6g
 c/BB+hfX7f9YSF02ds8c/2tzHDVIhUoKkhQ+Z5ksvVBlH+EguD1dBxqeE1GWNZme9rdc
 YIZmaZoIMI4fK2rffjN/MSY7SbnuBlR7NEQJSyypypaZPEVul5Z9Dt6yR3aU++QgFGNQ
 gxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766142; x=1788370942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V/TzolQ/cWgbzzqSGhsngN831gj0h+hUFm2am6qAF7c=;
 b=ZcQS7VnXZ1R7of/DB9L6jAeB0M/93HqSiXgmDlPylZ4oB23oBf1SNW6GxQhTbpGpM9
 zCaZz3luP7bOMKjiumWFOiId53wmwfAscfEp1MBebTxGmDYAPdbrNzIHttWwhHPI2ZI2
 FZ0dQ8DL/17fxPfIbCF0ECNLssKuAqTCjL9s0w++OGI3qE2jSJxqiwTMevjfiYa88h3L
 y0vna7LTUR0X4ycvCZgIZV2KozGNidGcyTMU3E2HaIn7odWKylsKhuU8XwCHzM0gTAGN
 1BrVCNorAqlmwMgcROGriZVyQRcvuwArW+VHGnJsFDzF1ut27WWFjNOZznRrFHi6FIpI
 vNtw==
X-Gm-Message-State: AFuF++lCmDiE3K8xnDUwfizMatC12guUYn8d0OZ98r/1CjPP4rLj+4h3
 KxV06izeQBnex6P84jZbNdSIRibD3f60oVUlDFkw5b3Ra58f30JLWfWk9++RtX+vTWwF89/icUp
 ymZpAfGI=
X-Gm-Gg: AR+sD12hVI2T6mmgDMzQMNy+ICdv8VwtBR0lbWSI7D4IWaavI08HytJNdv+QY5GqvaK
 5EeqQwu/NtgDR8g+boxAeB70d8KF2YITGFE6QI6uecTxeOUeGehhy6wbQwAl9i4I/Kl6TKDzu5w
 oazz3gWAlXeoDnSensNUu+7OjwdBu2GvuaU3k68py2i29Jw6HXD+itSvfjb+pYgP1a426WXjZ9/
 j3zFkT7M8A0Ll7N8uiO/RPd6knf2ui/erDXJf9HRuNb9H6firczM4uViFWobZE862vSOj5mYcc7
 FlYmCOpAunE7kt8Pp6OQ/8de536MQ20z9lmfVdEppr4+t8kF/XZiU+hmNYlWB4dWBs+A3QGgqWt
 Ne7+lqBZuv0ATcJWTobZ5wWBa1892xV61wLl9ivVDK3vOcxEswLLLhd6LIkl1S+pUt1sCop9za1
 Y9wLgoGv09iktEUZrY6ZA7zJonCn74JF1RIUCEMf1QdF3FgPmo3uO4p3u58Od/1uNuytSjQn2hZ
 BUWR34DNJa0Hsy0G4Y=
X-Received: by 2002:a05:6300:44:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cf74e42f9bmr19332527637.3.1787766141968; 
 Wed, 26 Aug 2026 10:42:21 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 05/25] target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for
 -cpu max
Date: Wed, 26 Aug 2026 10:41:52 -0700
Message-ID: <20260826174213.614571-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

These features are tied together if both SVE and SME are enabled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 5 +++--
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 48be49580a2..c086548f7fd 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -178,6 +178,8 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
     GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
     GET_FEATURE_ID(aa64_sme_tmop, ARM_HWCAP_A64_SME_STMOP);
+    GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
+    GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4ef412a6575..7cad37ae61a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1469,8 +1469,9 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* v9.2: FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 3);    /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
@@ -1497,7 +1498,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* v9.2: FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* v9.2: FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* v9.2: FEAT_SME_I16I64 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* v9.2: FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 3);   /* v9.4: FEAT_SME2p2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* v9.2: FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* v9.2: FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index ff02435975b..eb22469bb36 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -179,6 +179,7 @@ the following architecture extensions:
 - FEAT_SME (Scalable Matrix Extension)
 - FEAT_SME2 (Scalable Matrix Extension version 2)
 - FEAT_SME2p1 (Scalable Matrix Extension version 2.1)
+- FEAT_SME2p2 (Scalable Matrix Extension version 2.2)
 - FEAT_SME_B16B16 (Non-widening BFloat16 arithmetic for SME2)
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
@@ -203,6 +204,7 @@ the following architecture extensions:
 - FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
 - FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SVE2p1 (Scalable Vector Extension version 2.1)
+- FEAT_SVE2p2 (Scalable Vector Extension version 2.2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
-- 
2.53.0


