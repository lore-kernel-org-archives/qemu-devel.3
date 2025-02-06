Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C2DC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80x-0000Bi-Pe; Thu, 06 Feb 2025 14:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80S-0007K8-98
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:48 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80O-0000bg-Uv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:47 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f48ab13d5so13349285ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871863; x=1739476663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwujLuKrAT016DsMtaUp3yJjszEy26zde2eg4IVLOrI=;
 b=I5sySLi8aTXg6WBP2GvCqkXrwdfWg42FzkcYcBJX9IA53NwMBx/FgEpxk+ed5a3oI7
 picR74VX0JzuHKymIDFQz4bSfzyNWFuJPZkrg7eN3dJ2KzZAoAIaO46lHSZOHnGoNZnU
 hBli8pls1EsdaaNaku0bNJ/5RSsq3YQ9XF37F7WyKJwfE7CzvYlKAXdnTXew05UJHpRS
 x90swS7W9oes7BKg2vOeh70T+gPKttl6RDTm/gfT1TWwLIY70qQwkwuGCDtnpPDqh+rF
 77UdGdr97/dflVHQ8Lf0zSAGkZqGjI+OL6hNk6Yf+b0PbPk26/K/VV+miXZ/00FJoVL5
 2vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871863; x=1739476663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwujLuKrAT016DsMtaUp3yJjszEy26zde2eg4IVLOrI=;
 b=gP3C6QZGP5KxcdRj00cq36DBRovyDKi6lQ4SVAtP/LZIHXce9397gXa8Y/9OrVeaQS
 F3aGKf5OG587Mn4gXTr36PicCZoErXoUDCslfkbreSJwRrLVmdL5IQTbp772xe+6CeC8
 4yNTfvzCpFoRbRXicrJh/dA9jKyVYayuyWcYONFFGmY/QXyacZhTNX/PZS7e+eCuopBJ
 Ms9VVZPcjlMuUnb/8U1Df7MyyPPkWibXZDOX2lAsXoRIeN5vw7u2tVd3UiR6oFsRv42Y
 T02zHh0qRx1oRjS4pqtVz7TGFecax4B0uUukUNagXz18xfkkAZKuqLI6KffVrqxzZ2jp
 1XEw==
X-Gm-Message-State: AOJu0YyIJLj2A9HCyGD2eohucwetAsSnS24pajEXUQJwB9rcQMGpXQii
 IVyAPTve4jNJvfLezyM7i/+Y0RfFFPkLwZgWQH2oKCt33j0wWSGkBizBIVLLEck3X/J2DcxOHkQ
 m
X-Gm-Gg: ASbGnctOogtRij+JUhv37TfP5mqKA5es2aEavBDBSIGRx75VrbcSmWRCgHLqXq1uawj
 hjOF+JY/Ro6EzgXwfFXX2oun+5dA61wTb5wVHIG4H/rgl+ttUNHruPbF2LQovzXXjkbgZBJwuWY
 Sq2XTbbrnvg4HNwlvqRagOK9R8j8i/Mo20ynP9X4ntdtUK9lAWioFY7FwAiZe5zw+fT7NfRtNXN
 PKQqeWfInsnQw41W/FtFosWrrHgsLoMUhSZyNUgzqy2H2b3/IZgnX7vx4JIGrHcPcPDE7dRZykp
 dj+BgXXA0/2VkMMqby1VyYF4mZD5X7tTcZfWw7W6fYEVTgs=
X-Google-Smtp-Source: AGHT+IG0VrWJSCQhzYqIPPVs/EJR3EDVWhSN+To7rzwLPVUhkC/Q+TRGJ93RyyWQj9+0z2AWtb9Axg==
X-Received: by 2002:a05:6a00:420b:b0:725:e499:5b8a with SMTP id
 d2e1a72fcca58-7305d505b69mr866939b3a.15.1738871862695; 
 Thu, 06 Feb 2025 11:57:42 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 35/61] target/arm: Rename helper_gvec_*dot_[bh] to *_4[bh]
Date: Thu,  6 Feb 2025 11:56:49 -0800
Message-ID: <20250206195715.2150758-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Emphasize that these are 4-way dot products.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 22 +++++++++++-----------
 target/arm/tcg/translate-a64.c  | 14 +++++++-------
 target/arm/tcg/translate-neon.c | 14 +++++++-------
 target/arm/tcg/translate-sve.c  | 18 +++++++++---------
 target/arm/tcg/vec_helper.c     | 22 +++++++++++-----------
 5 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e64ddd68b2..5772ea98bd 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -606,23 +606,23 @@ DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
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
index bc96cee273..46c378fd08 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6118,9 +6118,9 @@ static bool do_dot_vector_env(DisasContext *s, arg_qrrr_e *a,
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
@@ -6880,12 +6880,12 @@ static bool do_dot_vector_idx_env(DisasContext *s, arg_qrrx_e *a,
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
index c4fecb8fd6..ea04336797 100644
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
index e56ef6ad68..3c8c018af3 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3385,8 +3385,8 @@ DO_ZZI(UMIN, umin)
 #undef DO_ZZI
 
 static gen_helper_gvec_4 * const dot_fns[2][2] = {
-    { gen_helper_gvec_sdot_b, gen_helper_gvec_sdot_h },
-    { gen_helper_gvec_udot_b, gen_helper_gvec_udot_h }
+    { gen_helper_gvec_sdot_4b, gen_helper_gvec_sdot_4h },
+    { gen_helper_gvec_udot_4b, gen_helper_gvec_udot_4h }
 };
 TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
            dot_fns[a->u][a->sz], a->rd, a->rn, a->rm, a->ra, 0)
@@ -3396,18 +3396,18 @@ TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
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
@@ -7106,7 +7106,7 @@ TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
 TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
-           a->esz == 2 ? gen_helper_gvec_usdot_b : NULL, a, 0)
+           a->esz == 2 ? gen_helper_gvec_usdot_4b : NULL, a, 0)
 
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index cfd219ed13..8beace8147 100644
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


