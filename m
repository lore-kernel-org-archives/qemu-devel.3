Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1ABCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2P-0000iP-DC; Fri, 22 May 2026 18:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1L-0006qN-Dk
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1G-0002nJ-1W
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b9e9a6802aso33869695ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487620; x=1780092420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXGx/WBGcKnMUpqhswWDYQkiKp/kmHzrTzXs8KT+qHU=;
 b=kbE2hi9lo7s44HxvFG2nJenN0IrRry7yZlEW+hpYRr3Pp0KqsxieG3OCu1SQD5b2zL
 OSmMfLusVWt54MSEdPhaBuOndf+Lt9erRp30TuTZRHPrX6UydgVy9s3UXy/A7BSSdX6s
 bXzn262sIkBPmmP2PVqwt3EiRZuObFddLOFMDEHa2p0tUSlsaj003g5DsWNEfoCxAswg
 nzThXGaLllGeXVzpGmRSHMGon3XBuSYdl0+vmA6gm1mW37qYZFDqJlWVxPU54Wu6IZ04
 UeJTxox3jdCXP/3RWS4fxkERoc+LyvijL1OI0GZ7iJKnSosCDYzPJg3uWHYkdUa/lQtL
 rVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487620; x=1780092420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DXGx/WBGcKnMUpqhswWDYQkiKp/kmHzrTzXs8KT+qHU=;
 b=HTX9AMmQ1qzOaywXsXCaz3U6AGFsPht4RxKaMn0Y5D9u2NV0gjbfS1kcjdXrZKxLuP
 IJXi+js2c0fkaLHic8PkM3BK4JydiI5QKKB1xlmes8HvEQHPi12z1jMOUs5CoIrymevb
 t+YuAPwJyKQN9//Ln2t2894/0P6g/h1tfXMuhxk30apu7N3UMbzA0mK0lGtTp7JArr3O
 ts5WFXiNAry1v/drWdYJ/DEp2c0vN7bjE34NyDatZWScoBdcCegRBGO+UKXyNXdBCtVv
 EUmmkg3fAZ+rCOmr9QuNpzcucb3f+vtFKwML220a0W1zHNHfocQ5iaTM2nqf1PQIkXi8
 WA1g==
X-Gm-Message-State: AOJu0Yz8tO22/BROCs0U3szmFncalDII3Tpv+wcQ6TiikZ8yUSwjgLbM
 Qe8KaftiDYMa5lOhLALXqTppjMXwBRIkwt+o9nuaT8cFE9Boj/ncw7fMtQrWC3pE672EIy3E/co
 sOEw6
X-Gm-Gg: Acq92OHTMfj9L/tpyqyUawp5rQbt8Xdd0PXt7g+kEbc2xZfdLY819jAgbj5O5DX3jBA
 PBlUXU8hLiHn6R8HL8jmmh92PIHjsHm2uscRMGFFa0MGOmO/SzwOJHGjrzcKAGl/sWu50Ci8c7i
 oaX417BWIOmmHT2K8gpjCWF0+qRB1tzEq7dHXCmc0fiWFgaEJjFoYJhKkyo01h89VeeG0vj4dRy
 8/m8fMljfg+B8zDUZdoYdJl6mtpmB1YQt3I1fqowptm9F9bd6EU7pknD9bV4tbH0SC49evxUY+N
 bg9Dvk3FxBh6gzhPV3HCqXTCwUb3TnHrqmPNPch9VGEBna4VNIKmbnWRHtECH+zZR0SmlCI1DMw
 hFKRH0rM/vCAWO2Ji4LYaUSOOIgCiOucmcJI61FU/EU/lz+WQXGIKd0d6UyIwfbTa1Kw7Y/tHb0
 UQ3PEOALwk5/lxiNBf4r3Pxg4jB5Rfh9ZNKSs4oEo=
X-Received: by 2002:a17:903:2290:b0:2bd:5a99:f293 with SMTP id
 d9443c01a7336-2beb0631928mr56103615ad.21.1779487619515; 
 Fri, 22 May 2026 15:06:59 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 55/64] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
Date: Fri, 22 May 2026 15:02:57 -0700
Message-ID: <20260522220306.235200-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 2fb43d51e1..eb3db355f0 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -226,7 +226,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
     GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_f8dp4, ARM_HWCAP2_A64_F8DP4);
     GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 93cd7ee1a6..6dec7e045d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
@@ -1396,6 +1397,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index c7128f1cec..31f637fb1b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
@@ -160,6 +161,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
-- 
2.43.0


