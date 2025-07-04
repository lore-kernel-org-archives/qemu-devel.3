Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3015C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEw-0001lk-V4; Fri, 04 Jul 2025 12:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEY-0000jC-Jo
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEW-0006Jn-Fd
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso967255f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646351; x=1752251151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kGXXor5EEEpVe9xryP61c3df3Gl8oHv2WOCnLV9Hocg=;
 b=goQnhL6uySuuFzMK3Ug6JTg+RUfg/y0oeYPrjkozDrmHyw/m99pipGkaVZZgAezHJT
 8/QCUiXCtcgNHvToIJgwlzAl562LtGBm9bHKyAPbJ6rpoqTOEtCMpStlziBAxrCyl2rm
 1fUbNrrNFRiRpe9OS//LJwqKOP2DUOpTIJDlDGLV9qGIbsbuPMwQYjyz7Kc5VqcDMEH6
 CZsYBkZfV9CtifP9R6lo6olbGYtvRB3i1V4xUPTQ8lXnpQbTXxcX26vlNzkH1bTl2k3u
 koPvR0liUzRW2NAfMMcvmDq9DrBcU14uFRiMkkJxOvnPJLS71OjTweZJfEGvHdT2Ct54
 1vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646351; x=1752251151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGXXor5EEEpVe9xryP61c3df3Gl8oHv2WOCnLV9Hocg=;
 b=lNAY9M9wA7adSDh6xHScc+KaIEuMJdb3tyEkg7QHffbGlnwPqc+pBd34p+G51sdQAT
 ZNWg7/4ZpDpRSYS13/eSxW6AcoOwG5N11wCoF/9xnk4FbIRnxT5Fuq83S0xbfbvoa+y5
 ADmZ6MR9fP0gsTW19BldFwQxLXeHNy5yFlZ60DTJS+dDMrQcbJ8eRNrfqOV8oZZGZyE6
 Aeu5Lauqm1tarsTZRtWCdGR4GDHZRlmPc9QxQxlxhlsz2NmfYqVzqAM0X545jajNLrnN
 LJDEsiRdVFXVzNkFiq5auuPKOuv1JbyqG1DEpzfLVdI6RZEyfj3O2SQfxaUpzXTuYBmQ
 KX6g==
X-Gm-Message-State: AOJu0YxJE17u3pwBh6+vjRS6gONOzjw8k9z0tX/mDfe22YrIHdHIty89
 AjEGUqAvWsKqDJYHvOmTdSEkPVK/b+BRtDfYrq+3RDhFYzg/rxP9nwPgmKgbOQsmkJ6c7swkjgB
 cyW9R
X-Gm-Gg: ASbGnct16DCJ05CpK74KfMECjx80dCKjIZQz2uweOnWFozW/YNOhR2PGEyuE3+USzp4
 cWJu6ewqRu14aFkMP8IxLS9b5ybfsta2y5D/G5xv8gnt9pc3gulB5t06zvsftkfonzc7+G/o0bT
 Am7tQhesoMRtNvR42VCvWzElQ9nVkctujlHzKzff62+Fh9dz8r2t3KF03vr97bpY3oWy6taVwJD
 9Bdcabtwo2wold82vMXXaGsMGqtCRtJcvBoWCKzICf6xjsZNqjk0wvt7YUK35KT/JqwCOel74AI
 PnWxGOSDw3569c+uTtlpp8Vh0eykA2XSPhex5Zff596bHUm/IPjiDZJYsIz+MmCd7n1V
X-Google-Smtp-Source: AGHT+IEE+sgPrUQQoaUJIOr7EhPlVi2SxeqWz9Bx6i0YgG1Xsv7SLEi8Z6S/yuU0ZhD/157kSS2VCg==
X-Received: by 2002:a05:6000:188b:b0:3a4:cfbf:519b with SMTP id
 ffacd0b85a97d-3b49702e8a3mr2712725f8f.44.1751646350879; 
 Fri, 04 Jul 2025 09:25:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 052/119] target/arm: Rename helper_gvec_*dot_[bh] to *_4[bh]
Date: Fri,  4 Jul 2025 17:23:52 +0100
Message-ID: <20250704162501.249138-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Emphasize that these are 4-way dot products.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-41-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h         | 22 +++++++++++-----------
 target/arm/tcg/translate-a64.c  | 14 +++++++-------
 target/arm/tcg/translate-neon.c | 14 +++++++-------
 target/arm/tcg/translate-sve.c  | 18 +++++++++---------
 target/arm/tcg/vec_helper.c     | 22 +++++++++++-----------
 5 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index d8d389af2b9..a19955b872f 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -616,23 +616,23 @@ DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sdot_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sdot_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_usdot_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(gvec_sdot_idx_b, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_5(gvec_sdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_idx_b, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_5(gvec_udot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sdot_idx_h, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_5(gvec_sdot_idx_4h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_idx_h, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_5(gvec_udot_idx_4h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sudot_idx_b, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_5(gvec_sudot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usdot_idx_b, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_5(gvec_usdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d823036c96f..dbf47595dbe 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6114,9 +6114,9 @@ static bool do_dot_vector_env(DisasContext *s, arg_qrrr_e *a,
     return true;
 }
 
-TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
-TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
-TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
+TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_4b)
+TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_4b)
+TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_4b)
 TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector_env, a, gen_helper_gvec_bfdot)
 TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector_env, a, gen_helper_gvec_bfmmla)
 TRANS_FEAT(SMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_smmla_b)
@@ -6876,12 +6876,12 @@ static bool do_dot_vector_idx_env(DisasContext *s, arg_qrrx_e *a,
     return true;
 }
 
-TRANS_FEAT(SDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_sdot_idx_b)
-TRANS_FEAT(UDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_udot_idx_b)
+TRANS_FEAT(SDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_sdot_idx_4b)
+TRANS_FEAT(UDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_udot_idx_4b)
 TRANS_FEAT(SUDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
-           gen_helper_gvec_sudot_idx_b)
+           gen_helper_gvec_sudot_idx_4b)
 TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
-           gen_helper_gvec_usdot_idx_b)
+           gen_helper_gvec_usdot_idx_4b)
 TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx_env, a,
            gen_helper_gvec_bfdot_idx)
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index c4fecb8fd6c..ea043367976 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -271,7 +271,7 @@ static bool trans_VSDOT(DisasContext *s, arg_VSDOT *a)
         return false;
     }
     return do_neon_ddda(s, a->q * 7, a->vd, a->vn, a->vm, 0,
-                        gen_helper_gvec_sdot_b);
+                        gen_helper_gvec_sdot_4b);
 }
 
 static bool trans_VUDOT(DisasContext *s, arg_VUDOT *a)
@@ -280,7 +280,7 @@ static bool trans_VUDOT(DisasContext *s, arg_VUDOT *a)
         return false;
     }
     return do_neon_ddda(s, a->q * 7, a->vd, a->vn, a->vm, 0,
-                        gen_helper_gvec_udot_b);
+                        gen_helper_gvec_udot_4b);
 }
 
 static bool trans_VUSDOT(DisasContext *s, arg_VUSDOT *a)
@@ -289,7 +289,7 @@ static bool trans_VUSDOT(DisasContext *s, arg_VUSDOT *a)
         return false;
     }
     return do_neon_ddda(s, a->q * 7, a->vd, a->vn, a->vm, 0,
-                        gen_helper_gvec_usdot_b);
+                        gen_helper_gvec_usdot_4b);
 }
 
 static bool trans_VDOT_b16(DisasContext *s, arg_VDOT_b16 *a)
@@ -356,7 +356,7 @@ static bool trans_VSDOT_scalar(DisasContext *s, arg_VSDOT_scalar *a)
         return false;
     }
     return do_neon_ddda(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
-                        gen_helper_gvec_sdot_idx_b);
+                        gen_helper_gvec_sdot_idx_4b);
 }
 
 static bool trans_VUDOT_scalar(DisasContext *s, arg_VUDOT_scalar *a)
@@ -365,7 +365,7 @@ static bool trans_VUDOT_scalar(DisasContext *s, arg_VUDOT_scalar *a)
         return false;
     }
     return do_neon_ddda(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
-                        gen_helper_gvec_udot_idx_b);
+                        gen_helper_gvec_udot_idx_4b);
 }
 
 static bool trans_VUSDOT_scalar(DisasContext *s, arg_VUSDOT_scalar *a)
@@ -374,7 +374,7 @@ static bool trans_VUSDOT_scalar(DisasContext *s, arg_VUSDOT_scalar *a)
         return false;
     }
     return do_neon_ddda(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
-                        gen_helper_gvec_usdot_idx_b);
+                        gen_helper_gvec_usdot_idx_4b);
 }
 
 static bool trans_VSUDOT_scalar(DisasContext *s, arg_VSUDOT_scalar *a)
@@ -383,7 +383,7 @@ static bool trans_VSUDOT_scalar(DisasContext *s, arg_VSUDOT_scalar *a)
         return false;
     }
     return do_neon_ddda(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
-                        gen_helper_gvec_sudot_idx_b);
+                        gen_helper_gvec_sudot_idx_4b);
 }
 
 static bool trans_VDOT_b16_scal(DisasContext *s, arg_VDOT_b16_scal *a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 4acd22f55e8..1564ee2558f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3402,8 +3402,8 @@ DO_ZZI(UMIN, umin)
 #undef DO_ZZI
 
 static gen_helper_gvec_4 * const dot_fns[2][2] = {
-    { gen_helper_gvec_sdot_b, gen_helper_gvec_sdot_h },
-    { gen_helper_gvec_udot_b, gen_helper_gvec_udot_h }
+    { gen_helper_gvec_sdot_4b, gen_helper_gvec_sdot_4h },
+    { gen_helper_gvec_udot_4b, gen_helper_gvec_udot_4h }
 };
 TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
            dot_fns[a->u][a->sz], a->rd, a->rn, a->rm, a->ra, 0)
@@ -3413,18 +3413,18 @@ TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
  */
 
 TRANS_FEAT(SDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
-           gen_helper_gvec_sdot_idx_b, a)
+           gen_helper_gvec_sdot_idx_4b, a)
 TRANS_FEAT(SDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
-           gen_helper_gvec_sdot_idx_h, a)
+           gen_helper_gvec_sdot_idx_4h, a)
 TRANS_FEAT(UDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
-           gen_helper_gvec_udot_idx_b, a)
+           gen_helper_gvec_udot_idx_4b, a)
 TRANS_FEAT(UDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
-           gen_helper_gvec_udot_idx_h, a)
+           gen_helper_gvec_udot_idx_4h, a)
 
 TRANS_FEAT(SUDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
-           gen_helper_gvec_sudot_idx_b, a)
+           gen_helper_gvec_sudot_idx_4b, a)
 TRANS_FEAT(USDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
-           gen_helper_gvec_usdot_idx_b, a)
+           gen_helper_gvec_usdot_idx_4b, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
@@ -7152,7 +7152,7 @@ TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
 TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
-           a->esz == 2 ? gen_helper_gvec_usdot_b : NULL, a, 0)
+           a->esz == 2 ? gen_helper_gvec_usdot_4b : NULL, a, 0)
 
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 616f4050e47..f18d1675b50 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -825,11 +825,11 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
     clear_tail(d, opr_sz, simd_maxsz(desc));                              \
 }
 
-DO_DOT(gvec_sdot_b, int32_t, int8_t, int8_t)
-DO_DOT(gvec_udot_b, uint32_t, uint8_t, uint8_t)
-DO_DOT(gvec_usdot_b, uint32_t, uint8_t, int8_t)
-DO_DOT(gvec_sdot_h, int64_t, int16_t, int16_t)
-DO_DOT(gvec_udot_h, uint64_t, uint16_t, uint16_t)
+DO_DOT(gvec_sdot_4b, int32_t, int8_t, int8_t)
+DO_DOT(gvec_udot_4b, uint32_t, uint8_t, uint8_t)
+DO_DOT(gvec_usdot_4b, uint32_t, uint8_t, int8_t)
+DO_DOT(gvec_sdot_4h, int64_t, int16_t, int16_t)
+DO_DOT(gvec_udot_4h, uint64_t, uint16_t, uint16_t)
 
 #define DO_DOT_IDX(NAME, TYPED, TYPEN, TYPEM, HD) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
@@ -865,12 +865,12 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
     clear_tail(d, opr_sz, simd_maxsz(desc));                              \
 }
 
-DO_DOT_IDX(gvec_sdot_idx_b, int32_t, int8_t, int8_t, H4)
-DO_DOT_IDX(gvec_udot_idx_b, uint32_t, uint8_t, uint8_t, H4)
-DO_DOT_IDX(gvec_sudot_idx_b, int32_t, int8_t, uint8_t, H4)
-DO_DOT_IDX(gvec_usdot_idx_b, int32_t, uint8_t, int8_t, H4)
-DO_DOT_IDX(gvec_sdot_idx_h, int64_t, int16_t, int16_t, H8)
-DO_DOT_IDX(gvec_udot_idx_h, uint64_t, uint16_t, uint16_t, H8)
+DO_DOT_IDX(gvec_sdot_idx_4b, int32_t, int8_t, int8_t, H4)
+DO_DOT_IDX(gvec_udot_idx_4b, uint32_t, uint8_t, uint8_t, H4)
+DO_DOT_IDX(gvec_sudot_idx_4b, int32_t, int8_t, uint8_t, H4)
+DO_DOT_IDX(gvec_usdot_idx_4b, int32_t, uint8_t, int8_t, H4)
+DO_DOT_IDX(gvec_sdot_idx_4h, int64_t, int16_t, int16_t, H8)
+DO_DOT_IDX(gvec_udot_idx_4h, uint64_t, uint16_t, uint16_t, H8)
 
 void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
                          float_status *fpst, uint32_t desc)
-- 
2.43.0


