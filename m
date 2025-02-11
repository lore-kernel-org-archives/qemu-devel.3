Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F6EC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6C-0006mg-QY; Tue, 11 Feb 2025 11:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5Z-0006Tp-0U
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:21 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5W-00037g-5i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:20 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439554db49dso7728435e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291177; x=1739895977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z3YGmuarfBzTTyJth0EvutsVXIKFE4fV+5NakAnRC0I=;
 b=JCnDJCuAlmXFXg5mJhpwzR8XnUtBTlOgOpF79f08AhWATPBgkO4wn8DGYue6QcuIDE
 029U+mhmwFXUROLCdlnPTY+Vu5h++Ih+JraSGsKv4buu9ZvqAAaNYwmwfLmcOCvPKvj2
 mgc7BjKSceU3VWrL7LpyLi8i8zAvLoAgVel08En1TgHvfCLHpu4SLutnc5V4AYI8pVum
 YjQFJ7z9Rjeb8x0++sXi6SMZX0J0ZGjti7nYPZmcAqii6ZVO2fHtAdgMnfERsxNaqCax
 wU5lXhUqCdgoXr6LcQpAPeydi0hrwi9n1rj2Tc6Z1aedWKe1l8IzVC/1JG/wKq1f/8VA
 e9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291177; x=1739895977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3YGmuarfBzTTyJth0EvutsVXIKFE4fV+5NakAnRC0I=;
 b=DSyhVVZbGjvwcvS8SesqlZ84BYMDXF5WfhVRZA6WM+IDUDLJxVONCYF8DinP6iCevy
 At/VQvzLadrLiRaIvZyQuJOgc+TfrJWKcfs7bzR6Y1S4enJp13CUs2dN3YUNnUC3Ye1T
 19zZDinOXy++Wea63AwO7mdezz5cM4n0YPllQABY4PuYSHea3kJs5UclMeP+7pR36OVF
 orSLFbJLAXnHb5yFEbuIIbSighiZYdOrFOBagGM3XP4djl2wF3w4qLPJeirm6ICUSCrR
 gCVcngRR36t9P3cQko9S+TIbHuGt/r8PlL4Vq+4NUPH8gQnjwZe8lR5NrQnMqDPB+Cfh
 0khQ==
X-Gm-Message-State: AOJu0YyoPXCGnvJpgS6ktaUE+HQ8pBGQZsIV2k42sGYRkG7fYbt+bTTF
 VReIxjMO0JdNYpqOXu0YjT7un/mBJA0IW/S/KHrrp+I6EzF6axYQlyDBuwBqtnAimQYVXLfFMCj
 H
X-Gm-Gg: ASbGncvAVrUp/kyt+hLAIECP0B/VTV2iC+mWGh54xSUyGyjMRTg5q3VoDy20RO0cdwL
 KMfNqAM9kC2UFUBHEiLfKO1eN+aZinjidRh9YhJ+Vvpj9e0ZL78P+MzAJCzsBx8Ala8lrf7esaB
 iuJpG7t4h9j4osI6/M0PFZ0v/FH4G5nCYvv7TgXUNmakp1Xf0YZ6jfpiUehmBBZLyZSydY3q632
 a0W8mZ8/pHPAa36ZEzLAOpsc0hxJYviYb5AYwTCEqe6HX3iUdOzeWbIcpRMLQj/PSSydaLDG2A1
 RdcGPp5wGcUnAzQ3VxJR
X-Google-Smtp-Source: AGHT+IE+S/WGOKwOT0VPsweF0/pISrrKJKtmcIglPbQeSrkvVKDBgAQaawpqDVej3vkeKcSj6djfxw==
X-Received: by 2002:a05:600c:3d07:b0:439:4700:9eb3 with SMTP id
 5b1f17b1804b1-43947009ff1mr66057635e9.3.1739291176667; 
 Tue, 11 Feb 2025 08:26:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/68] target/arm: Handle FPCR.NEP for 1-input scalar operations
Date: Tue, 11 Feb 2025 16:25:04 +0000
Message-Id: <20250211162554.4135349-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
index 61ea2bb9f75..a5f59a94ec2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8509,17 +8509,17 @@ static bool do_fp1_scalar_with_fpsttype(DisasContext *s, arg_rr_e *a,
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
@@ -8640,7 +8640,7 @@ static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, fpst);
-        write_fp_dreg(s, a->rd, tcg_rd);
+        write_fp_dreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8653,8 +8653,8 @@ static bool trans_FCVT_s_hs(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-        /* write_fp_sreg is OK here because top half of result is zero */
-        write_fp_sreg(s, a->rd, tmp);
+        /* write_fp_hreg_merging is OK here because top half of result is zero */
+        write_fp_hreg_merging(s, a->rd, a->rd, tmp);
     }
     return true;
 }
@@ -8667,7 +8667,7 @@ static bool trans_FCVT_s_sd(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, fpst);
-        write_fp_sreg(s, a->rd, tcg_rd);
+        write_fp_sreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8681,8 +8681,8 @@ static bool trans_FCVT_s_hd(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
-        /* write_fp_sreg is OK here because top half of tcg_rd is zero */
-        write_fp_sreg(s, a->rd, tcg_rd);
+        /* write_fp_hreg_merging is OK here because top half of tcg_rd is zero */
+        write_fp_hreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8696,7 +8696,7 @@ static bool trans_FCVT_s_sh(DisasContext *s, arg_rr *a)
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-        write_fp_sreg(s, a->rd, tcg_rd);
+        write_fp_sreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8710,7 +8710,7 @@ static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-        write_fp_dreg(s, a->rd, tcg_rd);
+        write_fp_dreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8958,7 +8958,9 @@ static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
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


