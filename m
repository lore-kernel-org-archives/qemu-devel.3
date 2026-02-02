Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04878E7316D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu4K-0007Em-Ba; Mon, 02 Feb 2026 08:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4F-00075t-LW
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:15 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4A-0002hL-2r
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso38006445e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039249; x=1770644049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1D5gDxMSdzziaFg9/E0uX86KkUPhS7bg4mwduipKGMc=;
 b=N2e4EL+Y2T0tJQiOLENfu5DicTJAX2/vg8abiJhHtEyJqsMHxIaz1HiwddEvU6pUs5
 HWQ+C2s3v2TIbq59U4qrDCQtPowdA342heSaxITT4kAnHDWzd+UvBFMm/GboYwyPwn88
 0OheW6dDPEUR96/QbPd9REosyE491XbUcp0eBd++CkdgfuXh1G0zEHgP2N6yXv6UpOkD
 Pe+DSH91Qywmpq4qpKkobyCQKBVcnibeDY+dkdLbY098YTFVBP5dG3ZQRKUoAbk843JV
 REHB7ry49S9lzfXCyjVJjhGIan/i2qkr8IRjZNSibogWqXB3Sk0XWMxI6GHq8mBIzuik
 uaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039249; x=1770644049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1D5gDxMSdzziaFg9/E0uX86KkUPhS7bg4mwduipKGMc=;
 b=PsJgdgTWcuWVzg3htYJc3YMphNZY3pNOmewdPJydMKgITpghYBphSDnccbJ7h7Bac4
 P+etPE4Yg8xZInk4vth8a7dM0kaT/VfoZLS5wS4CSWE95F3mV/LGGg9zjE+f6sBY6Sby
 hplmBN0k+peXE5WvSzclDmEjzIUcybLRYE+7RZGOGf6pD2ubYiNhrdtmiKhcfVcJYkDB
 8K4FzWRUW1rby1C32k5R2Y3YJzSyX5CMXZ/zzbNKhq4A8uGiET/Xq5654etW68SJIWKW
 8/Nr0I0f9poAef8pbdMtN2XQZCpI9OyL+6BvyVA9gKV/bFMwTUFz9Zar5RJ77rp45krW
 OoFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVurZZD+JacGXDFhFP53aG+TiNujYukqwRgluKIyqx+psTrWyoONtsc7eKsNPCdSd0UwGxFOgTLRbyD@nongnu.org
X-Gm-Message-State: AOJu0YwOueU793AqkTqmV8WpU4MFLYb4hilELSSwdOk1kHhPzhAiUSoV
 d+XEd2yWC8qzNnqcHT3cY6hPJHwPtQhZ/kn/1mBFJVxhDAWu5fS4LWyGOdiQGLjQdTQ=
X-Gm-Gg: AZuq6aLNHEvk3YznKStQ1wlniKo/n1U+ZwNrea3u8LSHm67nfQZrBylEOX7TbVjeps9
 lLWEVROe10ADy2/zLW31tAIiP7vj7SUhnW12M+7FaysNJmmbJhAVB2KfoKvGL2twyOU2TT0Bnk1
 nQwcEa4kDkvwALj0TlO24OSEIX76LYux3+v311snuCZJBrqWV2Sly8h9kjcXaSbB6N3+KbgrHQB
 JeEqZ9VofWCRQP4fY1LRhTbw0GvdlIoaSO1JTrkDDsSJSVhWpJNoP3iO9JCpjmOY4ustxfUdjiG
 vghkcENvdsV0SsGm3IOpmDwpjT0KzvQ+YShVvlvSmOL/3kCQejlCd3bmKu5IgKRrRKH2laAt5Ee
 A/hLfu7tQrDqrBNt6KEWm1xMhnwPsKvDnLg4nEueedluD3zkcsUSxTREKpkZDi2Jd3kpjWjE9/X
 nNP6sXx3t/Af8XHMQK6FDx2BgSxzEoDw==
X-Received: by 2002:a05:600c:1f94:b0:480:3338:292d with SMTP id
 5b1f17b1804b1-482db492928mr161880355e9.31.1770039248579; 
 Mon, 02 Feb 2026 05:34:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 11/15] target/arm/tcg: Correct SVE/SME I8MM checks
Date: Mon,  2 Feb 2026 13:33:49 +0000
Message-ID: <20260202133353.2231685-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The I8MM field of ID_AA64ZFR0_EL1 is set when the CPU implements
FEAT_I8MM and either FEAT_SVE or FEAT_SME. Currently we assume
that it is only set for FEAT_SVE. Update the feature checks:
 * we rename the existing feature check function to sve_sme_i8mm
   to indicate that it is true for either SVE or SME I8MM
 * we add a new check function for FEAT_SVE && FEAT_I8MM (giving
   it the sve_i8mm name that the old function used to have)
 * the instructions which are (SVE || SME) && I8MM need their
   checks updating to sve_sme_i8mm: these are SUDOT, USDOT
 * instructions which are SVE && I8MM (i.e. really SVE-only) stay
   unchanged with sve_i8mm: these are SMMLA, USMMLA, UMMLA

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      | 8 +++++++-
 target/arm/tcg/translate-sve.c | 6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 40393d88f0..8b8de5db04 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1449,7 +1449,8 @@ static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SM4) != 0;
 }
 
-static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
+/* Note that this is true if either SVE or SME are implemented with I8MM */
+static inline bool isar_feature_aa64_sme_sve_i8mm(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, I8MM) != 0;
 }
@@ -1542,6 +1543,11 @@ static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 44eda7b07d..53d35f6de9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3758,9 +3758,9 @@ TRANS_FEAT(UDOT_zzxw_4s, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
 TRANS_FEAT(UDOT_zzxw_4d, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4h, a)
 
-TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SUDOT_zzxw_4s, aa64_sme_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sudot_idx_4b, a)
-TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(USDOT_zzxw_4s, aa64_sme_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
 TRANS_FEAT(SDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
@@ -7778,7 +7778,7 @@ static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
 TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sme_or_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
-TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(USDOT_zzzz_4s, aa64_sme_sve_i8mm, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_usdot_4b, a, 0)
 
 TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
-- 
2.43.0


