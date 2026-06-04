Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AF3CD6E7E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHo9-0006gF-LY; Thu, 04 Jun 2026 19:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo6-0006c2-BA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:03 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo1-0007qz-Ky
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:02 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso9035175ad.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616936; x=1781221736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3ljH4kMaSmijfPNquzE2ziF+cSFEXG5x4lntN3n0PA=;
 b=GnQKKy1z7SWJAM9Atgha8CBzlpLOrB0uryHYwBioA9u3bo3/xRc2grAllmnE8uFszw
 +RGCuO0kShPt8ydDwurbokTW38m/E0B0UCJvv97n14FbyEq6uQophQW58EK+yBf9TZqk
 2wezmVoerdb+7d6a4oXFleinEyG3Osy9FbtmOzqLFlz9qLyzl//j7Bwmq7Jb8i50kOE6
 ehZnc5m+hVkYJ6E+WVvRBJzW7duZVEscVPVeXE4oePSKj4CdndLKSMSOhjrDy99Wpn7I
 7eIfl+3gK1oG0nLK8wHxLmBhppG0ZdLImbhZz1Kui8NGB7S821kgl/d7CM1zHNW1x1Gc
 TLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616936; x=1781221736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B3ljH4kMaSmijfPNquzE2ziF+cSFEXG5x4lntN3n0PA=;
 b=CxQomYzmQUb5kRFbut8IQUiOmo6XgIbpDge9KgBNR9fGyTqLdn1qVhSn3PactY104U
 pFOHFuekUv5uiQC5XD2YvqQksj591COKcXW6LcmqMiTyLJ4wvZvMcm4R2QrIW5SH19JH
 Dzfb0Ru+JW/aIRkVYD9pxEFAaPr9uXM5OiCSF7ZsZ9jkgPPL8Q/4r4oJCyt/3NpVlEmL
 y95YEbxzlk51RNeNExzyO3VqZK2ia495BOqGEAwPhGVcDLmQrXXB6k4QbpO6X1id4I5G
 7Zu3kKnCX8MPqunRkjoUxq6nATRWLvH8TDu35uAeF0Odw/PjUvPnhoIXhhDFURIaiDJi
 IHuw==
X-Gm-Message-State: AOJu0YwGmvaq8dBWBop45+jPziO/vfL+dJVa0vHi8Dbg5W68UmPQk7oz
 EmXnTKXzqXJRro7kvPy0aaDEoiDxnZb2D3uEEHGgSL9amet6b0TS2xe1WPHAWKSzO92vZfdfAG8
 aD5tO3rY=
X-Gm-Gg: Acq92OFAo2bLSV/GOOmCFnjTWtm+s1a/Orxh+vloG3gHKZspvB8S4qDgYgavP/mlyFz
 A4QWmZsZWBVSC7HLnY9Uy14HDmhGiDtop+3xkDxVyAG3xcgkpfL4O2KLpIOIIdNiiEBXJNGW0xE
 +W30/wioaFEVqAyeKmkOObj3OCLIqrxQZlFTae2PlzkTEjhpfKx9EXo1GHWhKxphndC6DjZO5jA
 K4c5zcROUqoWTJYiym3T28d3e+v9S0xXSlvmGK3opVlXOyFpZ9JgsfGeXmBjRc/JOzbGAmKUiVN
 Fsmv21tVz7JRUAMT7a6J0HhL6+I9aD6xmzPHnlIZ5y4sQZ4pZ/scY1C4n/SzNL3o+WmEaLhX8yM
 BDPnLoyGmvzVg9pgJARKUFNwo66UZXs7EK8vF7Z4utc4NA47I0y49dq9MCeBL/TsUOeacjpwaUR
 7aPve4wCmT3RhVmZF+GgVhMRFZt5vB5RsXJr87ep8=
X-Received: by 2002:a17:903:b84:b0:2bf:23c3:34ba with SMTP id
 d9443c01a7336-2c1e833c207mr7288345ad.28.1780616935699; 
 Thu, 04 Jun 2026 16:48:55 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:48:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/25] target/arm: Rename sve unary predicated patterns
Date: Thu,  4 Jun 2026 16:48:29 -0700
Message-ID: <20260604234852.573178-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Add an "_m" suffix to indicate merging, in preparation for
adding new predicated zeroing instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 169 +++++++++++++++++----------------
 target/arm/tcg/sve.decode      | 152 ++++++++++++++---------------
 2 files changed, 165 insertions(+), 156 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9a1bf71577..8b4a06a060 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -783,14 +783,14 @@ TRANS_FEAT(SEL_zpzz, aa64_sme_or_sve, do_sel_z, a->rd, a->rn, a->rm, a->pg, a->e
     };                                                              \
     TRANS_FEAT(NAME, FEAT, gen_gvec_ool_arg_zpz, name##_fns[a->esz], a, 0)
 
-DO_ZPZ(CLS, aa64_sme_or_sve, sve_cls)
-DO_ZPZ(CLZ, aa64_sme_or_sve, sve_clz)
-DO_ZPZ(CNT_zpz, aa64_sme_or_sve, sve_cnt_zpz)
-DO_ZPZ(CNOT, aa64_sme_or_sve, sve_cnot)
-DO_ZPZ(NOT_zpz, aa64_sme_or_sve, sve_not_zpz)
-DO_ZPZ(ABS, aa64_sme_or_sve, sve_abs)
-DO_ZPZ(NEG, aa64_sme_or_sve, sve_neg)
-DO_ZPZ(RBIT, aa64_sme_or_sve, sve_rbit)
+DO_ZPZ(CLS_m, aa64_sme_or_sve, sve_cls)
+DO_ZPZ(CLZ_m, aa64_sme_or_sve, sve_clz)
+DO_ZPZ(CNT_zpz_m, aa64_sme_or_sve, sve_cnt_zpz)
+DO_ZPZ(CNOT_m, aa64_sme_or_sve, sve_cnot)
+DO_ZPZ(NOT_zpz_m, aa64_sme_or_sve, sve_not_zpz)
+DO_ZPZ(ABS_m, aa64_sme_or_sve, sve_abs)
+DO_ZPZ(NEG_m, aa64_sme_or_sve, sve_neg)
+DO_ZPZ(RBIT_m, aa64_sme_or_sve, sve_rbit)
 DO_ZPZ(ORQV, aa64_sme2p1_or_sve2p1, sve2p1_orqv)
 DO_ZPZ(EORQV, aa64_sme2p1_or_sve2p1, sve2p1_eorqv)
 DO_ZPZ(ANDQV, aa64_sme2p1_or_sve2p1, sve2p1_andqv)
@@ -803,7 +803,7 @@ static gen_helper_gvec_3 * const fabs_ah_fns[4] = {
     NULL,                  gen_helper_sve_ah_fabs_h,
     gen_helper_sve_ah_fabs_s, gen_helper_sve_ah_fabs_d,
 };
-TRANS_FEAT(FABS, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(FABS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fabs_ah_fns[a->esz] : fabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const fneg_fns[4] = {
@@ -814,34 +814,38 @@ static gen_helper_gvec_3 * const fneg_ah_fns[4] = {
     NULL,                  gen_helper_sve_ah_fneg_h,
     gen_helper_sve_ah_fneg_s, gen_helper_sve_ah_fneg_d,
 };
-TRANS_FEAT(FNEG, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(FNEG_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxtb_fns[4] = {
     NULL,                  gen_helper_sve_sxtb_h,
     gen_helper_sve_sxtb_s, gen_helper_sve_sxtb_d,
 };
-TRANS_FEAT(SXTB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sxtb_fns[a->esz], a, 0)
+TRANS_FEAT(SXTB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           sxtb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const uxtb_fns[4] = {
     NULL,                  gen_helper_sve_uxtb_h,
     gen_helper_sve_uxtb_s, gen_helper_sve_uxtb_d,
 };
-TRANS_FEAT(UXTB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, uxtb_fns[a->esz], a, 0)
+TRANS_FEAT(UXTB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           uxtb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxth_fns[4] = {
     NULL, NULL, gen_helper_sve_sxth_s, gen_helper_sve_sxth_d
 };
-TRANS_FEAT(SXTH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sxth_fns[a->esz], a, 0)
+TRANS_FEAT(SXTH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           sxth_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const uxth_fns[4] = {
     NULL, NULL, gen_helper_sve_uxth_s, gen_helper_sve_uxth_d
 };
-TRANS_FEAT(UXTH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, uxth_fns[a->esz], a, 0)
+TRANS_FEAT(UXTH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           uxth_fns[a->esz], a, 0)
 
-TRANS_FEAT(SXTW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(SXTW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_sxtw_d : NULL, a, 0)
-TRANS_FEAT(UXTW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(UXTW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_uxtw_d : NULL, a, 0)
 
 static gen_helper_gvec_3 * const addqv_fns[4] = {
@@ -2984,17 +2988,19 @@ static gen_helper_gvec_3 * const revb_fns[4] = {
     NULL,                  gen_helper_sve_revb_h,
     gen_helper_sve_revb_s, gen_helper_sve_revb_d,
 };
-TRANS_FEAT(REVB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revb_fns[a->esz], a, 0)
+TRANS_FEAT(REVB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           revb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const revh_fns[4] = {
     NULL, NULL, gen_helper_sve_revh_s, gen_helper_sve_revh_d,
 };
-TRANS_FEAT(REVH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revh_fns[a->esz], a, 0)
+TRANS_FEAT(REVH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           revh_fns[a->esz], a, 0)
 
-TRANS_FEAT(REVW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(REVW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 0)
 
-TRANS_FEAT(REVD, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(REVD_m, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
            gen_helper_sme_revd_q, a, 0)
 
 TRANS_FEAT(SPLICE, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,
@@ -4491,53 +4497,53 @@ TRANS_FEAT(FCMLA_zzxz, aa64_sme_or_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz
  *** SVE Floating Point Unary Operations Predicated Group
  */
 
-TRANS_FEAT(FCVT_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_sh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_hs_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(BFCVT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVT_m, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
-TRANS_FEAT(FCVT_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_dh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_hd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hd, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVT_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTZS_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZS_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hs_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hs_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZS_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hd, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hd, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(FCVTZS_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ss, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_ss, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZS_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_sd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_sd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZS_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ds, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTZS_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_dd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_dd, a, 0, FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frint_fns[] = {
@@ -4546,8 +4552,9 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_s,
     gen_helper_sve_frint_d
 };
-TRANS_FEAT(FRINTI, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FRINTI_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           frint_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -4555,8 +4562,9 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_s,
     gen_helper_sve_frintx_d
 };
-TRANS_FEAT(FRINTX, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+TRANS_FEAT(FRINTX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           frintx_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
@@ -4585,63 +4593,64 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     return true;
 }
 
-TRANS_FEAT(FRINTN, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTN_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEEVEN, frint_fns[a->esz])
-TRANS_FEAT(FRINTP, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTP_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_POSINF, frint_fns[a->esz])
-TRANS_FEAT(FRINTM, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTM_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_NEGINF, frint_fns[a->esz])
-TRANS_FEAT(FRINTZ, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTZ_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_ZERO, frint_fns[a->esz])
-TRANS_FEAT(FRINTA, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTA_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEAWAY, frint_fns[a->esz])
 
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
-TRANS_FEAT(FRECPX, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
-           a, 0, select_ah_fpst(s, a->esz))
+TRANS_FEAT(FRECPX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           frecpx_fns[a->esz], a, 0, select_ah_fpst(s, a->esz))
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
-TRANS_FEAT(FSQRT, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FSQRT_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           fsqrt_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
-TRANS_FEAT(SCVTF_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(SCVTF_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_sh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_sh, a, 0, FPST_A64_F16)
-TRANS_FEAT(SCVTF_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_dh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dh, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(SCVTF_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ss, a, 0, FPST_A64)
-TRANS_FEAT(SCVTF_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(SCVTF_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_sd, a, 0, FPST_A64)
-TRANS_FEAT(SCVTF_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dd, a, 0, FPST_A64)
 
-TRANS_FEAT(UCVTF_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(UCVTF_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_sh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_sh, a, 0, FPST_A64_F16)
-TRANS_FEAT(UCVTF_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_dh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dh, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(UCVTF_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ss, a, 0, FPST_A64)
-TRANS_FEAT(UCVTF_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ds, a, 0, FPST_A64)
-TRANS_FEAT(UCVTF_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(UCVTF_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dd, a, 0, FPST_A64)
 
 /*
@@ -6691,23 +6700,23 @@ TRANS_FEAT(UADALP_zpzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzz,
  * SVE2 integer unary operations (predicated)
  */
 
-TRANS_FEAT(URECPE, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(URECPE_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_urecpe_s : NULL, a, 0)
 
-TRANS_FEAT(URSQRTE, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(URSQRTE_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_ursqrte_s : NULL, a, 0)
 
 static gen_helper_gvec_3 * const sqabs_fns[4] = {
     gen_helper_sve2_sqabs_b, gen_helper_sve2_sqabs_h,
     gen_helper_sve2_sqabs_s, gen_helper_sve2_sqabs_d,
 };
-TRANS_FEAT(SQABS, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 0)
+TRANS_FEAT(SQABS_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sqneg_fns[4] = {
     gen_helper_sve2_sqneg_b, gen_helper_sve2_sqneg_h,
     gen_helper_sve2_sqneg_s, gen_helper_sve2_sqneg_d,
 };
-TRANS_FEAT(SQNEG, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
+TRANS_FEAT(SQNEG_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
 
 DO_ZPZZ(SQSHL, aa64_sme_or_sve2, sve2_sqshl)
 DO_ZPZZ(SQRSHL, aa64_sme_or_sve2, sve2_sqrshl)
@@ -7879,30 +7888,30 @@ static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
     return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
 }
 
-TRANS_FEAT(FCVTNT_sh, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-TRANS_FEAT(FCVTNT_ds, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTNT_ds_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVTNT_m, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
-TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTLT_hs_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTLT_sd_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTX_ds, aa64_sme_or_sve2, do_frint_mode, a,
+TRANS_FEAT(FCVTX_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve_fcvt_ds)
-TRANS_FEAT(FCVTXNT_ds, aa64_sme_or_sve2, do_frint_mode, a,
+TRANS_FEAT(FCVTXNT_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve2_fcvtnt_ds)
 
 static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
     gen_helper_flogb_s, gen_helper_flogb_d
 };
-TRANS_FEAT(FLOGB, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
+TRANS_FEAT(FLOGB_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
            a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b53fe6a58f..c7e633ec4f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -392,24 +392,24 @@ LSL_zpzw        00000100 .. 011 011 100 ... ..... .....         @rdn_pg_rm
 
 # SVE unary bit operations (predicated)
 # Note esz != 0 for FABS and FNEG.
-CLS             00000100 .. 011 000 101 ... ..... .....         @rd_pg_rn
-CLZ             00000100 .. 011 001 101 ... ..... .....         @rd_pg_rn
-CNT_zpz         00000100 .. 011 010 101 ... ..... .....         @rd_pg_rn
-CNOT            00000100 .. 011 011 101 ... ..... .....         @rd_pg_rn
-NOT_zpz         00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
-FABS            00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
-FNEG            00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn
+CLS_m           00000100 .. 011 000 101 ... ..... .....         @rd_pg_rn
+CLZ_m           00000100 .. 011 001 101 ... ..... .....         @rd_pg_rn
+CNT_zpz_m       00000100 .. 011 010 101 ... ..... .....         @rd_pg_rn
+CNOT_m          00000100 .. 011 011 101 ... ..... .....         @rd_pg_rn
+NOT_zpz_m       00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
+FABS_m          00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
+FNEG_m          00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn
 
 # SVE integer unary operations (predicated)
 # Note esz > original size for extensions.
-ABS             00000100 .. 010 110 101 ... ..... .....         @rd_pg_rn
-NEG             00000100 .. 010 111 101 ... ..... .....         @rd_pg_rn
-SXTB            00000100 .. 010 000 101 ... ..... .....         @rd_pg_rn
-UXTB            00000100 .. 010 001 101 ... ..... .....         @rd_pg_rn
-SXTH            00000100 .. 010 010 101 ... ..... .....         @rd_pg_rn
-UXTH            00000100 .. 010 011 101 ... ..... .....         @rd_pg_rn
-SXTW            00000100 .. 010 100 101 ... ..... .....         @rd_pg_rn
-UXTW            00000100 .. 010 101 101 ... ..... .....         @rd_pg_rn
+ABS_m           00000100 .. 010 110 101 ... ..... .....         @rd_pg_rn
+NEG_m           00000100 .. 010 111 101 ... ..... .....         @rd_pg_rn
+SXTB_m          00000100 .. 010 000 101 ... ..... .....         @rd_pg_rn
+UXTB_m          00000100 .. 010 001 101 ... ..... .....         @rd_pg_rn
+SXTH_m          00000100 .. 010 010 101 ... ..... .....         @rd_pg_rn
+UXTH_m          00000100 .. 010 011 101 ... ..... .....         @rd_pg_rn
+SXTW_m          00000100 .. 010 100 101 ... ..... .....         @rd_pg_rn
+UXTW_m          00000100 .. 010 101 101 ... ..... .....         @rd_pg_rn
 
 ### SVE Floating Point Compare - Vectors Group
 
@@ -707,11 +707,11 @@ CPY_m_r         00000101 .. 101000 101 ... ..... .....          @rd_pg_rn
 
 # SVE reverse within elements
 # Note esz >= operation size
-REVB            00000101 .. 1001 00 100 ... ..... .....         @rd_pg_rn
-REVH            00000101 .. 1001 01 100 ... ..... .....         @rd_pg_rn
-REVW            00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
-RBIT            00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
-REVD            00000101 00 1011 10 100 ... ..... .....         @rd_pg_rn_e0
+REVB_m          00000101 .. 1001 00 100 ... ..... .....         @rd_pg_rn
+REVH_m          00000101 .. 1001 01 100 ... ..... .....         @rd_pg_rn
+REVW_m          00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
+RBIT_m          00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
+REVD_m          00000101 00 1011 10 100 ... ..... .....         @rd_pg_rn_e0
 
 # SVE vector splice (predicated, destructive)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
@@ -1184,59 +1184,59 @@ FNMLS_zpzzz     01100101 .. 1 ..... 111 ... ..... .....         @rdn_pg_rm_ra
 ### SVE FP Unary Operations Predicated Group
 
 # SVE floating-point convert precision
-FCVT_sh         01100101 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_hs         01100101 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
-BFCVT           01100101 10 0010 10 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_dh         01100101 11 0010 00 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_hd         01100101 11 0010 01 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_ds         01100101 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_sd         01100101 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_sh_m       01100101 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_hs_m       01100101 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
+BFCVT_m         01100101 10 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_dh_m       01100101 11 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_hd_m       01100101 11 0010 01 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_ds_m       01100101 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_sd_m       01100101 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
 
 # SVE floating-point convert to integer
-FCVTZS_hh       01100101 01 011 01 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_hh       01100101 01 011 01 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_hs       01100101 01 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_hs       01100101 01 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_hd       01100101 01 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_hd       01100101 01 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_ss       01100101 10 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_ss       01100101 10 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_ds       01100101 11 011 00 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_ds       01100101 11 011 00 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_sd       01100101 11 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_sd       01100101 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_dd       01100101 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_dd       01100101 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hh_m     01100101 01 011 01 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hh_m     01100101 01 011 01 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hs_m     01100101 01 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hs_m     01100101 01 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hd_m     01100101 01 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hd_m     01100101 01 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ss_m     01100101 10 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ss_m     01100101 10 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ds_m     01100101 11 011 00 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ds_m     01100101 11 011 00 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_sd_m     01100101 11 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_sd_m     01100101 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_dd_m     01100101 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_dd_m     01100101 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
 # SVE floating-point round to integral value
-FRINTN          01100101 .. 000 000 101 ... ..... .....         @rd_pg_rn
-FRINTP          01100101 .. 000 001 101 ... ..... .....         @rd_pg_rn
-FRINTM          01100101 .. 000 010 101 ... ..... .....         @rd_pg_rn
-FRINTZ          01100101 .. 000 011 101 ... ..... .....         @rd_pg_rn
-FRINTA          01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
-FRINTX          01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
-FRINTI          01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
+FRINTN_m        01100101 .. 000 000 101 ... ..... .....         @rd_pg_rn
+FRINTP_m        01100101 .. 000 001 101 ... ..... .....         @rd_pg_rn
+FRINTM_m        01100101 .. 000 010 101 ... ..... .....         @rd_pg_rn
+FRINTZ_m        01100101 .. 000 011 101 ... ..... .....         @rd_pg_rn
+FRINTA_m        01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
+FRINTX_m        01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
+FRINTI_m        01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
 
 # SVE floating-point unary operations
-FRECPX          01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
-FSQRT           01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
+FRECPX_m        01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
+FSQRT_m         01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
 
 # SVE integer convert to floating-point
-SCVTF_hh        01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_sh        01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_dh        01100101 01 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_ss        01100101 10 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_sd        01100101 11 010 00 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_ds        01100101 11 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_dd        01100101 11 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_hh_m      01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sh_m      01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dh_m      01100101 01 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ss_m      01100101 10 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sd_m      01100101 11 010 00 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ds_m      01100101 11 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dd_m      01100101 11 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
 
-UCVTF_hh        01100101 01 010 01 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_sh        01100101 01 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_dh        01100101 01 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_ss        01100101 10 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_sd        01100101 11 010 00 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_ds        01100101 11 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_dd        01100101 11 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_hh_m      01100101 01 010 01 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sh_m      01100101 01 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dh_m      01100101 01 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ss_m      01100101 10 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sd_m      01100101 11 010 00 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ds_m      01100101 11 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dd_m      01100101 11 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
@@ -1517,10 +1517,10 @@ UADALP_zpzz     01000100 .. 000 101 101 ... ..... .....  @rdm_pg_rn
 
 ### SVE2 integer unary operations (predicated)
 
-URECPE          01000100 .. 000 000 101 ... ..... .....  @rd_pg_rn
-URSQRTE         01000100 .. 000 001 101 ... ..... .....  @rd_pg_rn
-SQABS           01000100 .. 001 000 101 ... ..... .....  @rd_pg_rn
-SQNEG           01000100 .. 001 001 101 ... ..... .....  @rd_pg_rn
+URECPE_m        01000100 .. 000 000 101 ... ..... .....  @rd_pg_rn
+URSQRTE_m       01000100 .. 000 001 101 ... ..... .....  @rd_pg_rn
+SQABS_m         01000100 .. 001 000 101 ... ..... .....  @rd_pg_rn
+SQNEG_m         01000100 .. 001 001 101 ... ..... .....  @rd_pg_rn
 
 ### SVE2 saturating/rounding bitwise shift left (predicated)
 
@@ -1847,16 +1847,16 @@ SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
 
 ### SVE2 floating-point convert precision odd elements
-FCVTXNT_ds      01100100 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTX_ds        01100101 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTNT_sh       01100100 10 0010 00 101 ... ..... .....  @rd_pg_rn_e0
-BFCVTNT         01100100 10 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTLT_hs       01100100 10 0010 01 101 ... ..... .....  @rd_pg_rn_e0
-FCVTNT_ds       01100100 11 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
+FCVTXNT_ds_m    01100100 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTX_ds_m      01100101 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_sh_m     01100100 10 0010 00 101 ... ..... .....  @rd_pg_rn_e0
+BFCVTNT_m       01100100 10 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_hs_m     01100100 10 0010 01 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_ds_m     01100100 11 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_sd_m     01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
 
 ### SVE2 floating-point convert to integer
-FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
+FLOGB_m         01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
 
 ### SVE2 floating-point multiply-add long (vectors)
 FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
-- 
2.43.0


