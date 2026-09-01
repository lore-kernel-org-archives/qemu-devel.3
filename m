Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E4AC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONW-0001CT-DD; Tue, 01 Sep 2026 09:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONU-0001Bq-Fp
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONS-0007IT-NH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a5e971c970so1675124a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268692; x=1788873492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YJOIgaRZDwkR50H996RKXkM8f2cLV0ecU72lwbIgo+U=;
 b=ysT2d+Uca0TUkECeqJrM5laaPTb+MpbawvtjQ3e5yRLdBgX2USHltMhR9utM7R2uT5
 T6bg4hSqgeKhtom++1tfieN3qLG0Qf62e4X2JUbFLsn8yf27NhtE4RdouRK+Axwlz8E4
 f/nhUjE1ygX0aWIE7jzExljvOxnN/IafNVB+vR+OlJsieU4lgqrjWy5o3qe60Cx8q6Vf
 96UHxzyzggC4YM4+bDx4ZnKyfiFlXRqjNZz6B45994K3PwxpGwtKLNlidFJufD1xzeEZ
 gJcjH+s+joOjHqw3GoSj2YWf/CiZYcgQyz4NsW7PSMe8v2mEIorM8XPcVUsyI6qDa0Ff
 ywGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268692; x=1788873492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YJOIgaRZDwkR50H996RKXkM8f2cLV0ecU72lwbIgo+U=;
 b=PC8dKl33N5obxAfcaC6kuxCdJu17Mel/R+JtLwroEnOu10Ws8KBBKvFsGRJ/ptxf95
 BkD6W0qts79cwAx+4tYJGF3qs+AyKMOGNcWEBOndU/079/OlVgQJdSUoLvLYfz+1WY9I
 hi/rr1szI0UQwK3n9XDnOzB3UPN9i8at78QmZWBgpT9R/umlN5MsV+2xiN75YpXBBfam
 HIOO/83lizBqP+xAkbhMjCtaR04N2yf+o8BsOEsoXerPmtkFO6PPmoqLAOuTbERDnneZ
 atx3DKkfc5M7YCO55iE4kkv/t6oZlMKAyjJ8dceQjFPMbHxXAtV82Pxj3FtzKJxpCSQG
 1xrQ==
X-Gm-Message-State: AFuF++lEXzxHwwqVA9wwbK4NKO6bIY55YxUY0nb0WWsaYSAJGJx+awkX
 wR0+vmddEDV0ztzwQK+eXgprauv0rsNo4DU4sUFn0FvwORswlMWuN6BmrWdWhV8T21HkfzaEgaM
 IgU31m10=
X-Gm-Gg: AR+sD13u6jfFXA2e0EvyFZnSps3/kLHkIfzJl+4H0n5vkCINkpzG4twxdXraru0ry1m
 0dwea21NL/oI1BwHqpxNbvAHXkFyYArYu7MfkUmPx+YHX0mj0k1QSIM55Q64JMdVQd4qm+mO1JD
 IgXZ6wNHYlUpJT62NzkZ4Qw70rK68JL7iBpts2ORkRhjKUe3AhpUnm7z59lFlwUUojiRwwaCbC1
 cZO9AusZ9Fxpsg/R7s8CBYcpBCzimPsWUMkoX0UmzODcV2uREjCkYR5lMK5kqkINcIi1yZp8TSE
 mgFVyfTHSwjfolaDipw6xo3LxmxqLF9CvO66f7q4ZeHRVWml1YmDhVQ0odzTM99WF0Oqg1x6Gk2
 X7PsaiRdOng2vUSG1PhsTOvL4OjKYhUlCWW4VMu6czEXSgaHy8vNjKdNxrFa04BFxfGTqVrzxFR
 Ws1bFlDQ9XUkH3S2mA+s2ZjSa30uuw2O5L+5Kh4EIcq3OmTbODzoeLEGWdVYWsem4Wo4IG25CgE
 JTl72lGg8VSU3kg34hOnGT+7TkAR3nVzFQPiFRC1PUkbhD5wtIvWhR93au2htZnXIWJcQ==
X-Received: by 2002:a17:906:fe44:b0:c25:8b1e:3750 with SMTP id
 a640c23a62f3a-c25b92651e2mr338439766b.12.1788268692158; 
 Tue, 01 Sep 2026 06:18:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/58] target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for -cpu
 max
Date: Tue,  1 Sep 2026 14:17:12 +0100
Message-ID: <20260901131732.2263947-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These features are tied together if both SVE and SME are enabled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 ++
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 5 +++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e342ebb4445..862341933ac 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -180,6 +180,7 @@ the following architecture extensions:
 - FEAT_SME (Scalable Matrix Extension)
 - FEAT_SME2 (Scalable Matrix Extension version 2)
 - FEAT_SME2p1 (Scalable Matrix Extension version 2.1)
+- FEAT_SME2p2 (Scalable Matrix Extension version 2.2)
 - FEAT_SME_B16B16 (Non-widening BFloat16 arithmetic for SME2)
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
@@ -204,6 +205,7 @@ the following architecture extensions:
 - FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
 - FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SVE2p1 (Scalable Vector Extension version 2.1)
+- FEAT_SVE2p2 (Scalable Vector Extension version 2.2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
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
index 2d48b736bc7..12270b42977 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1470,8 +1470,9 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* v9.2: FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 3);    /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
@@ -1498,7 +1499,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* v9.2: FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* v9.2: FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* v9.2: FEAT_SME_I16I64 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* v9.2: FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 3);   /* v9.4: FEAT_SME2p2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* v9.2: FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* v9.2: FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
-- 
2.43.0


