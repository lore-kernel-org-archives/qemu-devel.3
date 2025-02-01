Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FFAC02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYT-0006rF-IZ; Sat, 01 Feb 2025 11:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYR-0006jZ-Bl
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYO-0001FY-Qf
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:11 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so29998275e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428067; x=1739032867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JASE9FZ9gXaiotUq5MUGIEN50RcRidaxeCz9uR3kqL8=;
 b=noga74G8ZlI6BGH74SDRwUOQ+nBOqQuiqQTeFGaM5wwcURRW3WaSIJwnpGAuPiwma6
 o0fBDoOnFKpVLcvdqJUA/DFm85CHSeWAwezISuQTFe074cP6IDhGBwCE0KHXcIt6vH8o
 MXIUrxR85YU0cVwiE/aQ3K9KQxAPVPM/WLd2h7ocza6ljphbpQl4+frezu7uDEIHTb/Y
 pHfFwS6fCeOdqEsWdloSKEl5CJAihG3Gk7NqvDeRzJfhKsy1aL8Vgl5wKQfqfn9Vpg9i
 KEDESmv9Lnk2qFFK8iRO81W+1MYu/qcczqUrXefTcJIFaySHeU+VVO/XN6yaBnp6K/hD
 Y8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428067; x=1739032867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JASE9FZ9gXaiotUq5MUGIEN50RcRidaxeCz9uR3kqL8=;
 b=nKfTHAROj3bt7GLm0s4TyNJ6H50cq1MivNZcCyzJevgMhCUQYVju+JHb0U8IVwUQiR
 qP1DG/pSh5+FcJO7WJfeYV8nsvoQsmOepOrPMx6SCsbb0REI90x3HSAiG3CvGGYdug+z
 ciiK71AysSGGbDst0ZFZYWv4/VEK21fYMC9pXOfN8ne7RL9Kyk60Cjm7D3F4+fh+G+sz
 qxYPEoHVW72E2yiIsdFIJIw2HefXdQA8LZ24zsWertiMHa9lFrROkXIv6+M64hD/kHHQ
 8ZSF/MvkDG3DZMXUH/sWNZ56kLfA1o31anhaB/ZQ0/DynbY3S1niVKFnQNtiyiu99aGB
 OMgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8wxTeoFHRDd4q1pggvPE/xiyXm1S6vt3ewSNBmBjIt2VoAva2EvRqJ+LEy/XW033df7/OH/6Wko/Q@nongnu.org
X-Gm-Message-State: AOJu0YwFbmdrZNDFLcWlyn58sik2SWOG7dmt8mR/2FTiBcQczIdn5Hh+
 HprmRukFeVW0HBxV7UZXLcPGgPzhmCUf05DdZWbO3vQyKXJYUNHpj9IEDrDSvuM=
X-Gm-Gg: ASbGnctjqYrwh3Sj07PuDPh93fDBqOgIyGoKAzsIe6FhpEGkSi3vSC0RoB70x7ntO7T
 bp7I5L1y9JGh62mub952oq/pL5O6sG7J+haqVLSkRO71r5xcTaIbL6TgpAcckSc4QgvVIaxhQXB
 ZWd6zGRl4beMf9IMElWGVLo4xGTQc2Qv39rLTEfNgcrNYETMXPiQzOzgy6oAEYYwLHqHOmp2Ues
 Th3ilKbR/FlGIAjYmbmRbQt4y+vSvlAzRdm5F+mMxLLvP3d2yxt/ced0kVvpg0tKjMFK3lfSxOD
 aSkzw2EhT21nZtr1aXDs
X-Google-Smtp-Source: AGHT+IGIqQ7DzCIPk7vdpUOdWmKQiBp0gD55xkPDc4JOIzSppaHfCioPSm5ZTpyOzEDgVct6KLL0cg==
X-Received: by 2002:a05:600c:1d1e:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-438dc3bf129mr134389725e9.12.1738428067129; 
 Sat, 01 Feb 2025 08:41:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 40/69] target/arm: Handle FPCR.AH in FRECPS and FRSQRTS
 vector insns
Date: Sat,  1 Feb 2025 16:39:43 +0000
Message-Id: <20250201164012.1660228-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics
in the vector versions of FRECPS and FRSQRTS, by implementing
new vector wrappers that call the _ah_ scalar helpers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 21 ++++++++++++++++-----
 target/arm/tcg/translate-sve.c |  7 ++++++-
 target/arm/tcg/vec_helper.c    |  8 ++++++++
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 29c70f054af..a2e96a498dd 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -980,6 +980,20 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_recps_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_recps_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_recps_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ah_rsqrts_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_rsqrts_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_rsqrts_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ah_fmax_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ah_fmax_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a3404c9e68c..03b629e0ba0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5778,10 +5778,11 @@ static bool do_fp3_vector_2fn(DisasContext *s, arg_qrrr_e *a, int data,
     return do_fp3_vector(s, a, data, s->fpcr_ah ? fah : fnormal);
 }
 
-static bool do_fp3_vector_ah(DisasContext *s, arg_qrrr_e *a, int data,
-                             gen_helper_gvec_3_ptr * const f[3])
+static bool do_fp3_vector_ah_2fn(DisasContext *s, arg_qrrr_e *a, int data,
+                                 gen_helper_gvec_3_ptr * const fnormal[3],
+                                 gen_helper_gvec_3_ptr * const fah[3])
 {
-    return do_fp3_vector_with_fpsttype(s, a, data, f,
+    return do_fp3_vector_with_fpsttype(s, a, data, s->fpcr_ah ? fah : fnormal,
                                        select_ah_fpst(s, a->esz));
 }
 
@@ -5924,14 +5925,24 @@ static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_s,
     gen_helper_gvec_recps_d,
 };
-TRANS(FRECPS_v, do_fp3_vector_ah, a, 0, f_vector_frecps)
+static gen_helper_gvec_3_ptr * const f_vector_ah_frecps[3] = {
+    gen_helper_gvec_ah_recps_h,
+    gen_helper_gvec_ah_recps_s,
+    gen_helper_gvec_ah_recps_d,
+};
+TRANS(FRECPS_v, do_fp3_vector_ah_2fn, a, 0, f_vector_frecps, f_vector_ah_frecps)
 
 static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
     gen_helper_gvec_rsqrts_h,
     gen_helper_gvec_rsqrts_s,
     gen_helper_gvec_rsqrts_d,
 };
-TRANS(FRSQRTS_v, do_fp3_vector_ah, a, 0, f_vector_frsqrts)
+static gen_helper_gvec_3_ptr * const f_vector_ah_frsqrts[3] = {
+    gen_helper_gvec_ah_rsqrts_h,
+    gen_helper_gvec_ah_rsqrts_s,
+    gen_helper_gvec_ah_rsqrts_d,
+};
+TRANS(FRSQRTS_v, do_fp3_vector_ah_2fn, a, 0, f_vector_frsqrts, f_vector_ah_frsqrts)
 
 static gen_helper_gvec_3_ptr * const f_vector_faddp[3] = {
     gen_helper_gvec_faddp_h,
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7816b5801af..50f16d5affa 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3741,7 +3741,12 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
         NULL, gen_helper_gvec_##name##_h,                           \
         gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
     };                                                              \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_ah_arg_zzz, name##_fns[a->esz], a, 0)
+    static gen_helper_gvec_3_ptr * const name##_ah_fns[4] = {       \
+        NULL, gen_helper_gvec_ah_##name##_h,                        \
+        gen_helper_gvec_ah_##name##_s, gen_helper_gvec_ah_##name##_d    \
+    };                                                              \
+    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_ah_arg_zzz,            \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], a, 0)
 
 DO_FP3(FADD_zzz, fadd)
 DO_FP3(FSUB_zzz, fsub)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b181b9734d4..e4c519f9e33 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1477,6 +1477,14 @@ DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
 DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
 DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
 
+DO_3OP(gvec_ah_recps_h, helper_recpsf_ah_f16, float16)
+DO_3OP(gvec_ah_recps_s, helper_recpsf_ah_f32, float32)
+DO_3OP(gvec_ah_recps_d, helper_recpsf_ah_f64, float64)
+
+DO_3OP(gvec_ah_rsqrts_h, helper_rsqrtsf_ah_f16, float16)
+DO_3OP(gvec_ah_rsqrts_s, helper_rsqrtsf_ah_f32, float32)
+DO_3OP(gvec_ah_rsqrts_d, helper_rsqrtsf_ah_f64, float64)
+
 DO_3OP(gvec_ah_fmax_h, helper_vfp_ah_maxh, float16)
 DO_3OP(gvec_ah_fmax_s, helper_vfp_ah_maxs, float32)
 DO_3OP(gvec_ah_fmax_d, helper_vfp_ah_maxd, float64)
-- 
2.34.1


