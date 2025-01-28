Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F02C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryx-0003nN-Mk; Tue, 28 Jan 2025 15:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcryB-0002S1-9R
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:14:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry7-0001gO-La
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361f796586so67914545e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095234; x=1738700034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AlvEv9Yo/SOOmobZo9A2KCwgktDKL4xNh3ZFljaISfc=;
 b=YrT0RQjkyYI6usvIae33uR5iCw1ZPmwd222AEiXXRPghw1vVzHh8ejuChfSrweTc8c
 DHyzNjwltGD1pX5JMiiHkf2am18Iw09tIWoOcpAUh3fJg5rtYJcyxGlKx0qzx2ZW66o4
 BvTNMkuK0Cj3MuMv0mCcS24TKxFom5K3+i2HMe4M3zkNDC50WlXfDGiNoczzglKX9xw9
 hVyy1C0tCkouEjlIq4Hw2YLwZxZbNJJz3VLjL352BOxehJAPhKUMIxBAo5x2spKhVAbW
 +0Zqb/W4VbKCXoWrxoL2soTT5Hh2aYMfk9F8mQB9cnbF3Vv5Kd/czBHLttbXSONiIWaV
 Pa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095234; x=1738700034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlvEv9Yo/SOOmobZo9A2KCwgktDKL4xNh3ZFljaISfc=;
 b=C3tusLY0y1PV5SSJ/cRSBl8320Nr8kug2lhntToUKZnWBA9pY06w69qzf6jXfKtUeo
 26a3gA8Io/2OtFOeawi3glL1B9mzTkimOFafHSXmcvfhrMB+8UPZLirKgKBbVqNpVvL0
 QgL85KFQMVVJMOn7EtlpXFD8aQ40f9Cu/HT8Bh7s3wsXCL+DsYswHvdsBFY9RVjkHj+L
 jYP345k5SgdnhjlPZPuXj0U1Kq3zSGgLS0GcKsCbmeBi7rWQvJQzqudq0a+LrHWEWFdi
 bF9qsdcK481/O9Zc8NTG6xwJa/W+9jYsEo9svPzLAY4yIpxmDw96E7ohjQPgQFenSkmv
 LlIg==
X-Gm-Message-State: AOJu0YwrhsUd/Now+nLFJDNQK8PWzx/3Jnd2PnxR1t/cySEamPTgdI+Y
 gihcmcDPwoynFlq1Cz5ccX6HkQHjmEhRifvP/UfzFpYjxxgfVieQ3iZIviYnODtDl0ltT05SUox
 v
X-Gm-Gg: ASbGncsPd1EvPThPESE/b34GBONkX63+zAj/6RCNOuN4FY5W1f9xsSkqQPlykqdiSU1
 V1CfKL9dpZJAIScLAVz+JlzL5f7+4KJnnQBNAfmQCimYR8wIDFc9NJSK9XyKQVKaUy4yIM8zYmu
 Y1WXaoSWyspVczdQgTW0EXir/wOh0mY8RXvyda22c3VjjPCK0G8lI0PHNzuiI8ziTrRn+SWPvwR
 VJ9SJunxsXnjkbDzlBRMpw6Prb/b18xbzZthZYd52dbxZngztZJdQspcmmPBuKtGMZp6NXScGCz
 J0PSpvQttFxFF1a8I0SQOQ==
X-Google-Smtp-Source: AGHT+IGWX7cT4qIlbFSiKH8scQUSFbhrgyTYSfNYMLZWetmKPvDnktO+xL1ddC5JcrOPJa6EdriudQ==
X-Received: by 2002:a05:600c:5486:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-438dc40d3fdmr2296295e9.21.1738095234231; 
 Tue, 28 Jan 2025 12:13:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/36] target/arm: Use FPST_A64_F16 for halfprec-to-other
 conversions
Date: Tue, 28 Jan 2025 20:13:13 +0000
Message-Id: <20250128201314.44038-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We should be using the F16-specific float_status for conversions from
half-precision, because halfprec inputs never set Input Denormal.

Without FEAT_AHP, using the wrong fpst here had no effect, because
the only difference between the A64_F16 and A64 fpst is its handling
of flush-to-zero on input and output, and the helper functions
vfp_fcvt_f16_to_* and vfp_fcvt_*_to_f16 all explicitly squash the
relevant flushing flags, and flush_inputs_to_zero was the only way
that IDC could be set.

With FEAT_AHP, the FPCR.AH=1 behaviour sets IDC for
input_denormal_used, which we will only ignore in
vfp_get_fpsr_from_host() for the A64_F16 fpst; so it matters that we
use that one for f16 inputs (and the normal one for single/double to
f16 conversions).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-27-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 9 ++++++---
 target/arm/tcg/translate-sve.c | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 703f265f20e..0b76a2cdb78 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8568,7 +8568,7 @@ static bool trans_FCVT_s_sh(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
-        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64);
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64_F16);
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
@@ -8582,7 +8582,7 @@ static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
         TCGv_i64 tcg_rd = tcg_temp_new_i64();
-        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64);
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64_F16);
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
@@ -9511,13 +9511,14 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_A64);
     if (a->esz == MO_64) {
         /* 32 -> 64 bit fp conversion */
         TCGv_i64 tcg_res[2];
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         int srcelt = a->q ? 2 : 0;
 
+        fpst = fpstatus_ptr(FPST_A64);
+
         for (pass = 0; pass < 2; pass++) {
             tcg_res[pass] = tcg_temp_new_i64();
             read_vec_element_i32(s, tcg_op, a->rn, srcelt + pass, MO_32);
@@ -9532,6 +9533,8 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         TCGv_i32 tcg_res[4];
         TCGv_i32 ahp = get_ahp_flag();
 
+        fpst = fpstatus_ptr(FPST_A64_F16);
+
         for (pass = 0; pass < 4; pass++) {
             tcg_res[pass] = tcg_temp_new_i32();
             read_vec_element_i32(s, tcg_res[pass], a->rn, srcelt + pass, MO_16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a7dbea5acd0..e1788330aa7 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3887,7 +3887,7 @@ TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
 TRANS_FEAT(FCVT_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_hs, a, 0, FPST_A64)
+           gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0, FPST_A64)
@@ -3895,7 +3895,7 @@ TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_hd, a, 0, FPST_A64)
+           gen_helper_sve_fcvt_hd, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVT_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-- 
2.34.1


