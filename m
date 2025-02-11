Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F84AC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7k-0003Id-BA; Tue, 11 Feb 2025 11:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5v-0006iq-PR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:45 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5s-0003It-T7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:43 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dd0dc21b2so2293491f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291197; x=1739895997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yZnukXayhjIyF+uNWFu4pPQYEInV92zfwW326kTo7Sw=;
 b=a3gc+HsSBL7Rq1R1CDP8Jf3jHJjtJ34ud0BaWhXrxW2BVKuwCE25TS8dIJ9PJr/m76
 eAtsi8j/UvE7wGnXRsh8O6c2sfeInlBqLydwhuL1EfjTdhNpymsj+vPH76WcNZwrIQIl
 HHIYa7XthfUSXJin72Yrkdv+2shJ9VKTvcPZePb4YsoXT80DLaoTKpXCrasoHp1hdkdp
 G3vSbalUEQ/dysr7Kyq5pu8W6GNFGAta6EczmBAZX6J+t8elq63rbOv0ardqidcK30uT
 1nzNZW7gfrDxWEDr79BaPTJzChky0NYtIVreCGEm9xPOB5pn7frQ1n8/jaCD1lAgmbz2
 M1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291197; x=1739895997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZnukXayhjIyF+uNWFu4pPQYEInV92zfwW326kTo7Sw=;
 b=aO/u5uXwl4llVqA5xdy+CuZgv0jXwsRblRaMEmIDigrqKLOEg4eabX7lsnNX7c3bn0
 sMLc/M9EfjWUQ33b9yXgf6b//mn9gikTCWlcGk6oCruW1ElGFbOZ6Zxopj6BNt7xN6Qy
 nffPODXXnhtpnnvLAiU2QBAcndtBJgN1iRARwUX3fNDhc1Uj2YAHc5agvEQz7dCKgWml
 h5nCj3LH2yrqrVZJJulqsiEO9cAnuveAnGQykAKipamZEVyqnSrHUUWTvDkWGDb2Ev8+
 DhzIbq+IwKhXVWNLfrqai5UtOQmu639a2uDu5F8tQND26/7O3Tg5PRHlZ0DTkNyiN9uH
 5ZJw==
X-Gm-Message-State: AOJu0YyqbLpYTRTvId9b+ymLPN6HUf9esSW7Qx2g1FwSpInXYd8f8/cD
 6FfVF+/E17BgTGboxtrxWXjJQSMloJwnfDBuK9QX6fe9S9H7Y2GtQHZxRsdEkHOVjEK7QkL0+Ap
 R
X-Gm-Gg: ASbGnctc2KuaWdOD6cYHdGtS/keaFoRp/YrbWeqUf6T9hoP2zDlWfa6yVFR8jQ3dDnx
 AHbSIpEW1JVhTAc6uqNIu1wUs9ngHAZ782i4waOkLBpWDb3ADOS+appkATCon/suj5LhqbOALdo
 kGpfmBY7kOD6XsNbad/kS080ZCxtu1lUWMImW2CU7mrwopXa2/hItmwEja6n4n1TEvlOZu2T9EH
 wA8qjX0M1mkjgVSiCx6vb5u3/xP5O7HFud7nNNge6+VhRkoN8TmwxvdBe7LusC5E43XkLcb/IWD
 EAvkE/enfI67NJ1ztpHT
X-Google-Smtp-Source: AGHT+IF6jkIDviCKmSNx41xLVvDd/Z0HNVFW/8vEAUnAZNikv5voMV6VxQBpeZdocW4zcHXNXq5rcQ==
X-Received: by 2002:a5d:64ef:0:b0:38d:e078:43a4 with SMTP id
 ffacd0b85a97d-38de078468amr6386781f8f.31.1739291197170; 
 Tue, 11 Feb 2025 08:26:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/68] target/arm: Handle FPCR.AH in FRECPS and FRSQRTS vector
 insns
Date: Tue, 11 Feb 2025 16:25:25 +0000
Message-Id: <20250211162554.4135349-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
index 1b6d8598b8e..50c207c9a12 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5767,10 +5767,11 @@ static bool do_fp3_vector_2fn(DisasContext *s, arg_qrrr_e *a, int data,
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
 
@@ -5913,14 +5914,24 @@ static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
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


