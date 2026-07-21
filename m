Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303B2C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFW6-0001Tx-Lz; Tue, 21 Jul 2026 14:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUs-00014x-5h
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:21 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUq-0006fB-H0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:17 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so10880850a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659635; x=1785264435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fbKvURaUToW+MLge/0h1mbq5aOuncglQwXEaMVLIT3g=;
 b=xPIU4COHUh5jb8kTj3pdOJSfunuPQlt1ubrZQFIVbrhFgicsZkg9omrOSkfFbpD76r
 Gpo1LGz7c7DxUMkpHSycqKWsDh7fpK0HUIptir8YnUkl6UVMvZcESIy9QJ0nMSQtOhyl
 dJoyELD7A9k5sqCcuJpPVGQldNOHNte+jMc+KBLfU1hx4XQCDj3SuRPcM64OyJgqaT44
 Y5nhRGDg7MZjmZFjnPeBmncrFRxnmj2MmoOAdC9EjdwNWDXk9HvhbidlSCK0u5yNLP7o
 NZ/ZCtuh/rBejtgW4myAHXEMrbxqcnFxDM27qqUjDaLdvIsDcQ5a6GvCqjyAn0hEEPDQ
 aAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659635; x=1785264435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fbKvURaUToW+MLge/0h1mbq5aOuncglQwXEaMVLIT3g=;
 b=hw+MUprXqvAxr6FtlhLc8vf3dSKlDElXMj6TGcygZnVe6My9mBC14Zv2pIDv6Y2bph
 Eqqn8kRhWQooKaMjTQnuN6c0Ou/yshkyhXW5yLBqiY6wV2ceTMqMPFdBSQkkzaPAxui8
 Vk0kxwLD0Vyw8BvQjBpzzy1L6bIsv0lF5Xa3znYgr0kZSIys2tKnviYOKXjRZNYPpcGU
 KzFAAmjgD3dT0SjW421hpWcZo6AaoE1lBBEAKuoM5wNg4Yrr75bptwtcuqSGu5jzxNjo
 t9Z3uXfuXCZYBXseSPsdNNBcVzHZiLllltxqTFC4fSShKdnGqDbFzbhnTz5qt58aZ9Aw
 OjQA==
X-Gm-Message-State: AOJu0Yylmw51bRipvNAz9F5XqQ7cGj8Ng4AytpybwY2CTWiGvlq5jqZk
 oNclFwgE1CiGiY5+fOQhaEEHOTaiMfVzXY+WfSIa8Q6SsUddBrIimpBcdAkNSY7qaXZM17wb4Bp
 oGZk9
X-Gm-Gg: AR+sD13FVCPFSysoXanC8WP6e6kumYN1uk75lDIV2vSwzSlXZZwm30HHRen4PSfGsWE
 Vjvo+RGOtHBxsOmmRdh+OFXx5DVMulLBmXx2iLZN+dO0h3hOKKBZezbOHSnoIctl/VjJ19xtpJU
 uLU2gFEqvGUrhtd1tRMpZDfpTtYHSB5HZuOlPynMeYVRoUj3DwNe64GUk/AS+ag3IQK3xyPxobb
 6qbSpknHrJ7dtssgih2XwIc7nKsVnGzgKHPFmp9Icxd45J6Ny6HWM6q2rygWTnx4ERMcDBzw/rE
 V9aKqhtheK7THkHdLDg7GLoA4BN/Eyh/b7xnjePE9H/pUVzoZf9F240CVPJyBiT5wOngRMRY0Ut
 +ZXifb5/mzcrU7BldKrY9tp9WL1EnfudOYMrMeDSfUnmSdKXbrP1W8skaj9zXA0g5dV/4o45QuT
 C/I3cErs8=
X-Received: by 2002:a17:90a:d40f:b0:37f:eda5:5169 with SMTP id
 98e67ed59e1d1-38e4b4474f6mr21353737a91.13.1784659634836; 
 Tue, 21 Jul 2026 11:47:14 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/20] target/arm: Rename isar_feature_aa64_sve_sha3
Date: Tue, 21 Jul 2026 11:46:48 -0700
Message-ID: <20260721184656.530230-13-richard.henderson@linaro.org>
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

Rename from isar_feature_aa64_sve2_sha3 to match
the feature name: FEAT_SVE_SHA3.

Reorg trans_RAX1 to use TRANS_FEAT_STREAMING_IF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h |  2 +-
 target/arm/cpu-features.h          |  2 +-
 linux-user/aarch64/elfload.c       |  2 +-
 target/arm/tcg/translate-sve.c     | 13 ++-----------
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 818b6f690a..8669f3f833 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -129,7 +129,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
-    GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
+    GET_FEATURE_ID(aa64_sve_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 857adf4ee0..f94e8efe47 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1549,7 +1549,7 @@ static inline bool isar_feature_aa64_sme_sve_bf16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BFLOAT16) != 0;
 }
 
-static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_sha3(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SHA3) != 0;
 }
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 0569350e37..83791768c6 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -195,7 +195,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
-    GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
+    GET_FEATURE_ID(aa64_sve_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 47986510e7..be7ff74add 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8297,17 +8297,8 @@ TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
 TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4ekey, a, 0)
 
-static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
-{
-    if (!dc_isar_feature(aa64_sve2_sha3, s)) {
-        return false;
-    }
-    if (!dc_isar_feature(aa64_sme2p1, s)) {
-        /* SME2p1 adds this as valid in streaming SVE mode */
-        s->is_nonstreaming = true;
-    }
-    return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
-}
+TRANS_FEAT_STREAMING_IF(RAX1, aa64_sve_sha3, aa64_sme2p1,
+                        gen_gvec_fn_arg_zzz, gen_gvec_rax1, a)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-- 
2.43.0


