Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD25E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mk-0007Mf-T0; Thu, 19 Feb 2026 05:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mg-0007IH-0J
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:34 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MX-00064l-9i
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:28 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43591b55727so786167f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497258; x=1772102058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=axcHvld9isZneOoWqSbrQxic/Tw4drSb949eZLUQ3O8=;
 b=MdJHfmh+GaSerBopOYbFhngb2YdY6LjRMSajhEJz8FfexQ4rd/RXGCOTm9MUANJr0E
 cBqP0rNnqBf4jk1Ilda/vUYMFPeA94gqAl6nhm9oUIwaB5Od6NFym4WaH8fGB5+xjkdb
 tFK0WGnQ1l6LlUhOfpFErvkTNDnsETl0xGcR7QQVVcrG4UhA/AY8kccSzDAy6itWa+n1
 0b6e3Ug9O6gRRrZhFn3RX4icelUJOedsC6y7uVXzZ37Vtfldq0gKt+nWJkeAWXaImRh6
 Jn95yJwZdiY2jcDcRTe8j+p/8k3jpma7HIIeKjFrpqRYfhMSUBgMUVrsYPoVPJogBn43
 Uc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497258; x=1772102058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=axcHvld9isZneOoWqSbrQxic/Tw4drSb949eZLUQ3O8=;
 b=j1b7BM93AAs4/HXgeAFmHSeEHJVGQdUNAqGG8+MWZjTOIO0lOMpvdVoNPmBE2MdvM9
 VzyUEuDgJbjmDuyeAYkJfNb5uSyROpXiTzL1HEIUC6isSebHAlyJGQPpEV3iSjoJrMNn
 yMyqaEAVUxmkGcS/8dGWhOSxVE0I7Lk1cbGESq5HCAkkxJWH0vhqgZroFCG8fpZfAS+T
 7sIP7Eho21INLLyMb5rc2RGHClRB3qhWHledGxZxCyqeESszthfyaHtD5artmFOw0PF1
 3CCMbiAsR+BNmJGsMVI54hMINmn2+X0n8Z75sBrlycvq/MyIHjGLst8DQ5zxpyaqjWs3
 ND7A==
X-Gm-Message-State: AOJu0YyojvI/klchFYHe0TZ2rnMB0cRhCogRqVv7VOJ9HYArpmv8lp/8
 42idyk1eqc8rh4gzrzGyResS6ifCfaBwg8PFFad5dkh9QuD/vj7VeiTcwDd3tqwdDEeJARnhmtW
 jCmDk
X-Gm-Gg: AZuq6aKxQWQbbvLF/p2ncI0/UWOKI/S/Ku/0e9TxIsDTwtxRL/GbohyoM2XzYzaTf82
 a+pme3JMEuLcRiaruQjTCSKbUGsklIHkzDPxyfu1jXMMXoOPOvGIXr7x1Ttsn+LDzsXPooJ5q50
 M4iOkvqqJRq9vmh7O9TGbbdhLBZjDk0hFpEuP1lOvaah3h3DCY4Dm70sbZ2xVdcUP7g8cReZag6
 JrmupuPKOusITxLrmF6iG1cwG9zkERa7kWb8YfzfJ1uS7DSGR06Wib+CeJKzieqQgt+M+32ieDl
 wpywNMKJWQP9FBXBn0vx9wvao5CsytMnwZ+Rfv/rAAw2Bn8Bw8e3xh4PSjN5L73D47GsvjYp1g4
 bQu7zfKIWPxs1obQYMPFbQV+coTxOb9elwiThi9/T3Qb4OB/4ZIx6UHn8Se3jPd+vGfbUmQSZQ4
 0KOCH5Qc2tP3tE/wj9W8qtbijB/q2SEe/Q22xV9kBTn6iyULiXear7D1u6QO/3EiF8rxCGBUx+e
 yfQA+J8cyuLHSaryDPVG4RYXus/L0NXEDmgbgRIDQ==
X-Received: by 2002:a05:600c:4eca:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-48379bfc3bamr286819495e9.29.1771497258311; 
 Thu, 19 Feb 2026 02:34:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/32] target/arm/tcg: Correct SVE/SME BF16 checks
Date: Thu, 19 Feb 2026 10:33:45 +0000
Message-ID: <20260219103405.3793357-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

As with I8MM, the BF16 field of ID_AA64ZFR0_EL1 is set when the
CPU implements FEAT_BF16 and either FEAT_SVE or FEAT_SME, so
we need to have separate checks for "(SVE || SME) && BF16"
and "SVE && BF16". Follow the same pattern as with I8MM:

 * aa64_sve_sme_bf16 means (SVE || SME) && BF16
 * aa64_sve_bf16 means (SVE && BF16)

BFMMLA is the only SVE BF16 insn that isn't in SME.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-13-peter.maydell@linaro.org
---
 target/arm/cpu-features.h      |  7 ++++++-
 target/arm/tcg/translate-sve.c | 16 ++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 40eb8cef17..83db3fd950 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1449,7 +1449,7 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BITPERM) != 0;
 }
 
-static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sme_sve_bf16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BFLOAT16) != 0;
 }
@@ -1563,6 +1563,11 @@ static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
 }
 
+static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_bf16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 53d35f6de9..956ddee123 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4430,7 +4430,7 @@ TRANS_FEAT(FCVT_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(FCVT_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
@@ -7818,7 +7818,7 @@ TRANS_FEAT(FCVTNT_sh, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(FCVTNT_ds, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
@@ -7875,9 +7875,9 @@ TRANS_FEAT(FDOT_zzzz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzzz,
 TRANS_FEAT(FDOT_zzxz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzxz,
            gen_helper_sme2_fdot_idx_h, a)
 
-TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
+TRANS_FEAT(BFDOT_zzzz, aa64_sme_sve_bf16, gen_gvec_env_arg_zzzz,
            gen_helper_gvec_bfdot, a, 0)
-TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
+TRANS_FEAT(BFDOT_zzxz, aa64_sme_sve_bf16, gen_gvec_env_arg_zzxz,
            gen_helper_gvec_bfdot_idx, a)
 
 TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
@@ -7890,8 +7890,8 @@ static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
                               s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
-TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
-TRANS_FEAT(BFMLALT_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, true)
+TRANS_FEAT(BFMLALB_zzzw, aa64_sme_sve_bf16, do_BFMLAL_zzzw, a, false)
+TRANS_FEAT(BFMLALT_zzzw, aa64_sme_sve_bf16, do_BFMLAL_zzzw, a, true)
 
 static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 {
@@ -7901,8 +7901,8 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
                               s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
-TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-TRANS_FEAT(BFMLALT_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, true)
+TRANS_FEAT(BFMLALB_zzxw, aa64_sme_sve_bf16, do_BFMLAL_zzxw, a, false)
+TRANS_FEAT(BFMLALT_zzxw, aa64_sme_sve_bf16, do_BFMLAL_zzxw, a, true)
 
 static bool do_BFMLSL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
-- 
2.43.0


