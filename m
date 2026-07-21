Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F46C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFW1-0001RK-29; Tue, 21 Jul 2026 14:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUq-00014q-DJ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:18 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUo-0006eX-Nn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38e347638adso6784278a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659633; x=1785264433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c6mrzVYB+xtDItY8lKDVs1AxoyOlI3UFnV2AgjuH+h4=;
 b=mJsnECP0czWxdOCPMDs9vtPGpWwx3v5dTdtfC9yK2auBT2v09FStKpz0MLIhHZ8EeO
 qF3bNWii+TfYKhkmPSQdifTHt2b1QhB5W7syjJ0eTvGzSPuYXgCFaWjc7asyokSnRmMd
 34bru8Ut4oB+P18x3+Rd09B6pjnCLcCdMQ4kh+ooOiCqCJ5jDyXH38efGTTXGlFCLOcL
 k9epRHKPnOFnquHimSApx2PM6eyUsterR+VRVouvmDsad3nUlbmWSEa0ybyov+cVF9zE
 QsRoHh4DeFzwHFYoHn94SHMUkAtlxLdBY6o77UlQWCU5wsN3+653XHuzqggr47KKsqmy
 2SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659633; x=1785264433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c6mrzVYB+xtDItY8lKDVs1AxoyOlI3UFnV2AgjuH+h4=;
 b=galizdqnB4IjdRoLHNtSnxsEzNAQYTI/JPYxrb0h5pZC0bXmcfaEXsJ5cDebRSmbUG
 O2uGzB5mVK3FLRJjAy9GYD0dHZM6Gd6sNeQGKWrrcoViYATsvK0vKG2epA5efcykNQXs
 RJonYWzgHNH2hxggidDcvrpS7gCEELzhcrRuPWRY/0toN/sMDMgvjGu5xa5ntl+EEFZA
 ChAw2AG2a9+WOvMn4kOEmD/QLOlGlae7aXgQdKbfbWnZ8T3JXI4KSVx7RbY6TSTvlI2C
 WSO0FqeRw3fQEYFaLZBZEQzFnkeHw3aHHJeksNEnKyPMqH5lF8J9ecpMyoRPYEzZRAb7
 ds+w==
X-Gm-Message-State: AOJu0YwDdk5wve5LvUXq8moQXk8HrGw7uvz5r+9bJ0WwTTXtntuVAXD6
 KtDH5JQLobgKtb/6aPLmZRr7YY/aCeLzuWa/UbYonr7zGmT9CLSyJ6CIEQSUsakMPQJjcqu0mru
 UxPwK
X-Gm-Gg: AR+sD10fZdhHoWTFqhM/6B9Jv9xhjIbMZzrs7HSKNKMCGuZMhwnIjTARkdy8xh4CSIp
 5EBmj4AnVW2N7b9WPK2ugayZW0v1EOLmpPMC2G9iHjHcw/sYoeL52yk7TA2Bnr0nlbPIWqDcOai
 3qc0WbIN7dFTOw9x7xVrP8qVQyp5ppDV1olULPpXpD+EI1XS8UqMJR9a0PxUYM6BC7qPpe1QPFH
 /yxhcjkMUrLOHEishvTSLBngAfnvA6N8uq8hiX55OeswhZWBsubxWhxUZTlA2Hg908KFO7cmIIY
 GsXcOmmW5+Ek3hQ3YBMkeQolMostKPHaI8mmIahTOpSpcUmgqmvQnefwQ1CdABXz3fphHf8kN9b
 FkGf7fiJ0CWEL3RO5eiOBtQ1w+Z98oQUL3ZkJH6I0/we0NqsWUlQ+PYCxia0F4YpHpD3sBPeuwe
 G00hnrmAI=
X-Received: by 2002:a17:90b:5288:b0:38e:3542:212 with SMTP id
 98e67ed59e1d1-38e4b4462f1mr20084874a91.13.1784659633303; 
 Tue, 21 Jul 2026 11:47:13 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/20] target/arm: Rename isar_feature_aa64_sve_bitperm
Date: Tue, 21 Jul 2026 11:46:47 -0700
Message-ID: <20260721184656.530230-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Rename from isar_feature_aa64_sve2_bitperm to match
the feature name: FEAT_SVE_BITPERM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 target/arm/cpu-features.h          | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/tcg/translate-sve.c     | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 6f9d192b4f..818b6f690a 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -128,7 +128,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
-    GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
+    GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 750be9b1b1..857adf4ee0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1539,7 +1539,7 @@ static inline bool isar_feature_aa64_sve_pmull128(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 2;
 }
 
-static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_bitperm(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BITPERM) != 0;
 }
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 40c5e1dbd3..0569350e37 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -194,7 +194,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
-    GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
+    GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 03d97dcaf5..47986510e7 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7420,21 +7420,21 @@ static gen_helper_gvec_3 * const bext_fns[4] = {
     gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
     gen_helper_sve2_bext_s, gen_helper_sve2_bext_d,
 };
-TRANS_FEAT_NONSTREAMING(BEXT, aa64_sve2_bitperm, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(BEXT, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
                         bext_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bdep_fns[4] = {
     gen_helper_sve2_bdep_b, gen_helper_sve2_bdep_h,
     gen_helper_sve2_bdep_s, gen_helper_sve2_bdep_d,
 };
-TRANS_FEAT_NONSTREAMING(BDEP, aa64_sve2_bitperm, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(BDEP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
                         bdep_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bgrp_fns[4] = {
     gen_helper_sve2_bgrp_b, gen_helper_sve2_bgrp_h,
     gen_helper_sve2_bgrp_s, gen_helper_sve2_bgrp_d,
 };
-TRANS_FEAT_NONSTREAMING(BGRP, aa64_sve2_bitperm, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(BGRP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
                         bgrp_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const cadd_fns[4] = {
-- 
2.43.0


