Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76080C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhWm-0008Au-Sx; Fri, 04 Jul 2025 10:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPd-0003av-Aq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:14 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPY-00024S-Q8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:13 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so1155794fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639347; x=1752244147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TuRlMWp4S2tbggCNreOTfPefIPHrwsyeWu0fbRw453U=;
 b=ZuVrL5al/aauGArSTUyV/O6L7zy9NjHHG13+A3Se+axYfK5kJdnUbtGjX0+M8tjw1L
 rYWa+m5lgdEKiDwXz4Jbv6g/9CjexzwOLPmkPJiU+TB8Rp/NAgQ9zNLfVQY0vT9YS35U
 EJ/vb7twqkzhxNd+F/bmot1jxfqfOlOTI/t4d6uwgGdKePR7J6T3d8AGNA55FEFbX1Ts
 1wUEmQXdgmcEb6lgYsBxRn/4nY5s51sGi+NE87KkoJbEWk71/fwFgb9jyVjN+5JxY6Dm
 gFPCackCCTT/gUygB13mMpqD6e+luSug5JjXmrk/Ud8EXd1upGsltv0E19++StLXO5x9
 y/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639347; x=1752244147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuRlMWp4S2tbggCNreOTfPefIPHrwsyeWu0fbRw453U=;
 b=vx4yQQiVfLTkG7FgGKWpk6okdptCHBYCGB6Si0D+Np7amgQzEML63FdyMuwaniu3N/
 fDEH/QqdR6EgADktQNUewE+iUIvRqjnOUJlZDmW8+ISDY8tnztiHPE4K7dsBlcYawaba
 n/tF9wQZ9Ug7rN7p5ErYObNaYytnSlLZyTiKboT2hCF2DJZaUig7msMjXEF+CLZ4AO2W
 PQ0RD7QyOktbmnJkdd8mvLPwTR1Ecfk8MjC6CSK92a7WoNXGcBodjh5yXdERA8C2ZoR+
 EfKBrR7eJpbf3rciMwiCJijNbTPsAozZQrAl2JSo5EsxXwDlkZYyt2JabvF7OrPciF1i
 MSMw==
X-Gm-Message-State: AOJu0YyEYm4TCcwYegAzWoSRE6AlAUo4fYHOw6stZBhsaHRF6Fqldman
 mMM+eK7byIPUJRH5Q1TfkFeNCNihOjUNc9cFJE1+4VuwfQ84jKM4ZbJyPOiF4PXUnih0n57rv/s
 94cCjCDM=
X-Gm-Gg: ASbGnct6c9vMBs/XBRLI5Aqukhxs618HpB+Vy61Zj7sa9F40gIiLqhfqZcO0IsoBawR
 QViyOefmGMUqNgTIE6WP4v4Qs3yqE85tFxveybktc7+SdhDVGBOo6PficltCdSNkcJnqOg40bLg
 YSgg3v8yoBWqC2jK8ze7tRuuIB3i26aqUpAw2NkizgCFXUheLYKOcOcaMkm+9Wnv9DiV7+yoN4B
 bzxIYHAoD8uPvL9PJSsGb8pVafeF59vQTLRdUsW8W1FZrH9t4hBdimbe+g5gYK52Qi4s8dbLMpU
 y0V2Pk9EAMzABwvcojoxQSsfm9t8X+nvaXkgwm2VqFMHch2CkEXdzHvrcO6lLniq35QSBhp1CYe
 dS6u8mpDtYu0Mjf6vxPP9njh9FkIRZoN6J/fSkc4Aa7FpvLHM
X-Google-Smtp-Source: AGHT+IHg1vB5BJkTuQw543dt4PK9JYlj/K+XRuFLOhOW0izujdlGU86HpTgu4XVO6J7tfj39yK5ipA==
X-Received: by 2002:a05:6870:a982:b0:2e9:e2e6:4a20 with SMTP id
 586e51a60fabf-2f796adb07amr1682936fac.16.1751639346824; 
 Fri, 04 Jul 2025 07:29:06 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 106/108] target/arm: Enable FEAT_SME2p1 on -cpu max
Date: Fri,  4 Jul 2025 08:21:09 -0600
Message-ID: <20250704142112.1018902-107-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 10 ++++++++--
 docs/system/arm/emulation.rst |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 937f29e253..d0df50a2f3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1201,7 +1201,7 @@ void aarch64_max_tcg_initfn(Object *obj)
      */
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     SET_IDREG(isar, ID_AA64PFR1, t);
@@ -1250,10 +1250,11 @@ void aarch64_max_tcg_initfn(Object *obj)
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
@@ -1269,11 +1270,16 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
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
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
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


