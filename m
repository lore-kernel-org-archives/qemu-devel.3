Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B7C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY3-0006BK-9J; Sat, 01 Feb 2025 11:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY1-00069O-Dq
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:45 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXz-00018D-Pk
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436341f575fso35238895e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428042; x=1739032842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=61ptv+5nrXEUL8nFsjMh+BQ+ZW8Vmtwab4IrUFxN1bA=;
 b=CosogPS7iHxoN4JFXe2h9myuxKjt6e2H+Lgv/kfwEE4rdGZCpJ3VqfE2Os3QQhFv6x
 0j5V+J4VWEaEBMmNwCGR11ANuN6brLiqP3XYRYHGzpLdb/VgLqhY6s5mCKQN+S+n9QmU
 XLZNX8ejwjYcYrxHzV012/sObDuXDTr1VrFMNeIZyroL7hEF4MvWBFQvPzmT8X9eXC9V
 o2rbD7lwnupeDV+f0mFfFdCAXgw3WhZiU25g3meC35OcD6PFj+l3G6UVSXBmlwAaSvR4
 lImrqXNw8rSuyY/RjcApNnAh5yMYMMxa0nUDexoBAX5dJjsJAGHiRWPpoFLF+Pt42T+R
 o1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428042; x=1739032842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61ptv+5nrXEUL8nFsjMh+BQ+ZW8Vmtwab4IrUFxN1bA=;
 b=cywV7bG7NZ4d9H7eC6bFB6U6whfSDBdad70n/mvgBn9bHim8EHxovl/h/DEMRZbkId
 HsFj9+TPTPo0vFDJOihxiL4DBOjXibvKDXYwLNRJQSJWA9rj7/Khr9orRXbYp2l0Kp8A
 FWrV1D29WZPWRIybBqDTceLNNap+MFINGUBVE6pxuuImNwpvGFr5EQNtBoPW4n5pThCf
 ZNFOgTYicu1HtuToTC8Or1Mkxgf8BR2p+05MYSLGlsxyw0/0886rCp1vQTMRofMOiVOo
 7OZi0vqrbeoSL3NVMZjd0Pz1Jj/I3+KYavqRjiY8OPtVrPTL4X/8oklYsOfiT+4oSJvH
 dMRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUka6oNs/sRc7bXtUnnuLe02rNnpE8x2c6YncwaOKOg58a8JhlKhDVbvttff76JQTqoA/493bFScnmo@nongnu.org
X-Gm-Message-State: AOJu0YyGWjCHwWNwfbSgvTl8aZDvpd4hGYK4kh38fHcT+xqkxz6J6Dlq
 Yn0EmkzuGIKKgjBFP8Ammna4Bp7Lj8zEzyVfF2ZusZvevIK0osQyZ1lJVuWma1XkhT/PBBA2bxH
 u
X-Gm-Gg: ASbGncszEkVgVwWTKdlJkMSYMXd+YIkl3EoUP/xwA4Z3UaN4gtU178if0byQr1MikUE
 mpVTpqTnTwyrOQoL59yuMm2x0kB/3Z0tWe+De+PFCvvT+mGKhGjFcv44dFxY0yuvp5N2fGWtZ46
 HRlMt2afq+f9G7M813mEZYPZmg7sgDGBpYfKLyszXW3v6PEReVbQIyxBUBbBBFEFt8PGG7zTrTw
 +7xtIGHkjooZx3Za2GWMHrNpIl8vO7bvjCZzZ1ibOHSSNFgHA2vdj2RnoppKL6uEcJvTvjkcWhU
 6lLrUZzHrvy/5rorc1gZ
X-Google-Smtp-Source: AGHT+IE0BDERPdHDb1JZ9+SLKGQ2lll1e0qDJsj0lAItfO/KVs0x+jmXMjJ0irwLgp95tX365UQplg==
X-Received: by 2002:a05:600c:b8c:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-438dc34ba8fmr181958275e9.0.1738428042370; 
 Sat, 01 Feb 2025 08:40:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 19/69] target/arm: Handle FPCR.NEP for 1-input scalar
 operations
Date: Sat,  1 Feb 2025 16:39:22 +0000
Message-Id: <20250201164012.1660228-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Handle FPCR.NEP for the 1-input scalar operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 030c5d99d78..21e68878c48 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8520,17 +8520,17 @@ static bool do_fp1_scalar_with_fpsttype(DisasContext *s, arg_rr_e *a,
     case MO_64:
         t64 = read_fp_dreg(s, a->rn);
         f->gen_d(t64, t64, fpst);
-        write_fp_dreg(s, a->rd, t64);
+        write_fp_dreg_merging(s, a->rd, a->rd, t64);
         break;
     case MO_32:
         t32 = read_fp_sreg(s, a->rn);
         f->gen_s(t32, t32, fpst);
-        write_fp_sreg(s, a->rd, t32);
+        write_fp_sreg_merging(s, a->rd, a->rd, t32);
         break;
     case MO_16:
         t32 = read_fp_hreg(s, a->rn);
         f->gen_h(t32, t32, fpst);
-        write_fp_sreg(s, a->rd, t32);
+        write_fp_hreg_merging(s, a->rd, a->rd, t32);
         break;
     default:
         g_assert_not_reached();
@@ -8651,7 +8651,7 @@ static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, fpst);
-        write_fp_dreg(s, a->rd, tcg_rd);
+        write_fp_dreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8664,8 +8664,8 @@ static bool trans_FCVT_s_hs(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-        /* write_fp_sreg is OK here because top half of result is zero */
-        write_fp_sreg(s, a->rd, tmp);
+        /* write_fp_hreg_merging is OK here because top half of result is zero */
+        write_fp_hreg_merging(s, a->rd, a->rd, tmp);
     }
     return true;
 }
@@ -8678,7 +8678,7 @@ static bool trans_FCVT_s_sd(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, fpst);
-        write_fp_sreg(s, a->rd, tcg_rd);
+        write_fp_sreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8692,8 +8692,8 @@ static bool trans_FCVT_s_hd(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
-        /* write_fp_sreg is OK here because top half of tcg_rd is zero */
-        write_fp_sreg(s, a->rd, tcg_rd);
+        /* write_fp_hreg_merging is OK here because top half of tcg_rd is zero */
+        write_fp_hreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8707,7 +8707,7 @@ static bool trans_FCVT_s_sh(DisasContext *s, arg_rr *a)
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-        write_fp_sreg(s, a->rd, tcg_rd);
+        write_fp_sreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8721,7 +8721,7 @@ static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-        write_fp_dreg(s, a->rd, tcg_rd);
+        write_fp_dreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8969,7 +8969,9 @@ static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
     do_fcvt_scalar(s, a->esz | (is_signed ? MO_SIGN : 0),
                    a->esz, tcg_int, a->shift, a->rn, rmode);
 
-    clear_vec(s, a->rd);
+    if (!s->fpcr_nep) {
+        clear_vec(s, a->rd);
+    }
     write_vec_element(s, tcg_int, a->rd, 0, a->esz);
     return true;
 }
-- 
2.34.1


