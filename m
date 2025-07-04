Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A725C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUV-0004Jm-1F; Fri, 04 Jul 2025 10:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPR-0003CV-Cw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:03 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPN-0001hW-7Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:01 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2e9071e3706so780135fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639336; x=1752244136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5T+1eHIOj1e/WXmzoGFs0diz0NvQu4FPqr7ThUYeoc=;
 b=m2kSyiC6baoE8YIniNObHwdYorMZNu1o8o7CuqCpovjD7nvfyKyuJo+0OmcYGrqMrh
 q7xoOn3aBOCOl8C7zyhP3srgsHROOyJA5wGpAlmHN1YyFZSAsBnhAfkp11h/HSNWWuM4
 zaVcHwTA/33XvAIJIVeNfuv8DcrIfYgF7w0hz6m7LL44fQzQzXGgVzxhe/WPuTez97bk
 W2DR438zZ2bEVNx6OXXk7aHsPHr7W/hSyVQwQnWECUxuzCzO7T4zGoV75ri9kFVS1N9h
 7FMzMy2lm3TzUQgjRLwjbDvd5wKIfNzuZQ75FUSyNVjexRQBdaKvfWy+7YyEKLAe1O4H
 o7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639336; x=1752244136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5T+1eHIOj1e/WXmzoGFs0diz0NvQu4FPqr7ThUYeoc=;
 b=n6WlKjyzDf2510a3/r5M7hy1gmSXYd7YVqb2APUOto0qKiSjjz5T7PDIx/igvbU5Sh
 W4HzK3YLr1+1xqI+1QvMr8xG6byfxfA2Ew5OVW7/p0b61cnJYCwbwuOOcRu7oat22/Hp
 J2DbRN0Bf7rVH+wzofsmePYTz4G5AT6jIhHRfoX4D2QFHsxRTq9iEaMSnefptlqFieTy
 E4JAYxe3BIml11usPCvSXDpW1YYEcI9TEo1AV3Mgkz6snOo0wnbWYeU59liDWyHwlWmT
 Wp8JV1zWQRH1Y9Dn+ga9fSAgvgzk91lk07i4dKOCdk+0XLhPI67VnmApyyK/WLoMai2g
 AqyQ==
X-Gm-Message-State: AOJu0YyPu5oEwjNqMcHV71GU9Jpjl4rLN1lWoEq9ChsSZDALnQgJX9D8
 FVBj3DsBpvPUPpGNsZCV9zQUPiL5xoXwV2ab8awv7vxGAf9vbxX8AcLCGceiK8dKABOwYSD4zTe
 obcqeNOc=
X-Gm-Gg: ASbGncsS5TpdBCzupJUY3eJsVFlbadfzvbUQpP6WOKhDe7Ytxecqpe04pe7yxh9SOoL
 86hneu0gveJPC9bLurbiIU1s9YRucUamddmt4MYJa7rswq+kGveNwGvnA46rCtwz3Qp3yUMfuof
 2kdTQf+kWW9HZ2w2PMRfcqZA5CjVuCj7DBfIbsuDQetsrY8SA6PA+t8k8VbaRvNMJoaZdFT2mIH
 jhg4yhW0t01Ind2zqBsh3xArRLlZumAgLFwpCgSuJt12K/+OZsuW0BH6U+MmwELMv975155Qbdc
 UJdTIcNoHxekeVTnkye0gW2COn517a4B9rViVjXO/aNgT9w27dXMd5A3GtM1wS5A6cefrno5jmd
 qjmPY1ekivPdOwXI8TXch24Qnj5Li/fLojU7Bagi2rKObG+oI
X-Google-Smtp-Source: AGHT+IG585ekIsNAqk6zRB+WWAv+Db4z3C8ExP/tTcqLr3V0QMeQa678yfGAxA9vsj91nMpdcgan2A==
X-Received: by 2002:a05:6870:891e:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2f796caabfamr1731863fac.18.1751639335760; 
 Fri, 04 Jul 2025 07:28:55 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 097/108] target/arm: Implement {LD,
 ST}[234]Q for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 08:21:00 -0600
Message-ID: <20250704142112.1018902-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  32 +++++++++
 target/arm/tcg/sve_helper.c    |   8 +++
 target/arm/tcg/translate-sve.c | 116 ++++++++++++++++++++++++---------
 target/arm/tcg/sve.decode      |  31 +++++++++
 4 files changed, 156 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 1999c4bb1f..ade76ff664 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1658,6 +1658,14 @@ DEF_HELPER_FLAGS_4(sve_ld2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1722,6 +1730,14 @@ DEF_HELPER_FLAGS_4(sve_ld2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1946,6 +1962,14 @@ DEF_HELPER_FLAGS_4(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1998,6 +2022,14 @@ DEF_HELPER_FLAGS_4(sve_st2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bh_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bd_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 91cd5970ee..360114ece2 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6421,6 +6421,10 @@ DO_LDN_2(2, dd, MO_64)
 DO_LDN_2(3, dd, MO_64)
 DO_LDN_2(4, dd, MO_64)
 
+DO_LDN_2(2, qq, MO_128)
+DO_LDN_2(3, qq, MO_128)
+DO_LDN_2(4, qq, MO_128)
+
 #undef DO_LDN_1
 #undef DO_LDN_2
 
@@ -6987,6 +6991,10 @@ DO_STN_2(4, dd, MO_64, MO_64)
 DO_STN_2(1, sq, MO_128, MO_32)
 DO_STN_2(1, dq, MO_128, MO_64)
 
+DO_STN_2(2, qq, MO_128, MO_128)
+DO_STN_2(3, qq, MO_128, MO_128)
+DO_STN_2(4, qq, MO_128, MO_128)
+
 #undef DO_STN_1
 #undef DO_STN_2
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8e945c5d2d..7dff028569 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -89,7 +89,7 @@ static inline int expand_imm_sh8u(DisasContext *s, int x)
  */
 static inline int msz_dtype(DisasContext *s, int msz)
 {
-    static const uint8_t dtype[4] = { 0, 5, 10, 15 };
+    static const uint8_t dtype[5] = { 0, 5, 10, 15, 18 };
     return dtype[msz];
 }
 
@@ -4886,7 +4886,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 }
 
 /* Indexed by [mte][be][dtype][nreg] */
-static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
+static gen_helper_gvec_mem * const ldr_fns[2][2][19][4] = {
     { /* mte inactive, little-endian */
       { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
           gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
@@ -4914,6 +4914,8 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_le_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_le_r, NULL, NULL, NULL },
+        { NULL,                      gen_helper_sve_ld2qq_le_r,
+          gen_helper_sve_ld3qq_le_r, gen_helper_sve_ld4qq_le_r },
       },
 
       /* mte inactive, big-endian */
@@ -4943,6 +4945,8 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_be_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_be_r, NULL, NULL, NULL },
+        { NULL,                      gen_helper_sve_ld2qq_be_r,
+          gen_helper_sve_ld3qq_be_r, gen_helper_sve_ld4qq_be_r },
       },
     },
 
@@ -4981,6 +4985,10 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_le_r_mte, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_le_r_mte, NULL, NULL, NULL },
+        { NULL,
+          gen_helper_sve_ld2qq_le_r_mte,
+          gen_helper_sve_ld3qq_le_r_mte,
+          gen_helper_sve_ld4qq_le_r_mte },
       },
 
       /* mte active, big-endian */
@@ -5018,6 +5026,10 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_be_r_mte, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_be_r_mte, NULL, NULL, NULL },
+        { NULL,
+          gen_helper_sve_ld2qq_be_r_mte,
+          gen_helper_sve_ld3qq_be_r_mte,
+          gen_helper_sve_ld4qq_be_r_mte },
       },
     },
 };
@@ -5042,16 +5054,26 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
         return false;
     }
 
-    /* dtypes 16 and 17 are artificial, representing 128-bit element */
-    if (a->dtype < 16) {
+    /* dtypes 16-18 are artificial, representing 128-bit element */
+    switch (a->dtype) {
+    case 0 ... 15:
         if (!dc_isar_feature(aa64_sve, s)) {
             return false;
         }
-    } else {
+        break;
+    case 16: case 17:
         if (!dc_isar_feature(aa64_sve2p1, s)) {
             return false;
         }
         s->is_nonstreaming = true;
+        break;
+    case 18:
+        if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     if (sve_access_check(s)) {
@@ -5065,16 +5087,26 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
 
 static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    /* dtypes 16 and 17 are artificial, representing 128-bit element */
-    if (a->dtype < 16) {
+    /* dtypes 16-18 are artificial, representing 128-bit element */
+    switch (a->dtype) {
+    case 0 ... 15:
         if (!dc_isar_feature(aa64_sve, s)) {
             return false;
         }
-    } else {
+        break;
+    case 16: case 17:
         if (!dc_isar_feature(aa64_sve2p1, s)) {
             return false;
         }
         s->is_nonstreaming = true;
+        break;
+    case 18:
+        if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     if (sve_access_check(s)) {
@@ -5586,55 +5618,67 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
               gen_helper_sve_st1dd_be_r_mte,
               gen_helper_sve_st1dq_be_r_mte } } },
     };
-    static gen_helper_gvec_mem * const fn_multiple[2][2][3][4] = {
+    static gen_helper_gvec_mem * const fn_multiple[2][2][3][5] = {
         { { { gen_helper_sve_st2bb_r,
               gen_helper_sve_st2hh_le_r,
               gen_helper_sve_st2ss_le_r,
-              gen_helper_sve_st2dd_le_r },
+              gen_helper_sve_st2dd_le_r,
+              gen_helper_sve_st2qq_le_r },
             { gen_helper_sve_st3bb_r,
               gen_helper_sve_st3hh_le_r,
               gen_helper_sve_st3ss_le_r,
-              gen_helper_sve_st3dd_le_r },
+              gen_helper_sve_st3dd_le_r,
+              gen_helper_sve_st3qq_le_r },
             { gen_helper_sve_st4bb_r,
               gen_helper_sve_st4hh_le_r,
               gen_helper_sve_st4ss_le_r,
-              gen_helper_sve_st4dd_le_r } },
+              gen_helper_sve_st4dd_le_r,
+              gen_helper_sve_st4qq_le_r } },
           { { gen_helper_sve_st2bb_r,
               gen_helper_sve_st2hh_be_r,
               gen_helper_sve_st2ss_be_r,
-              gen_helper_sve_st2dd_be_r },
+              gen_helper_sve_st2dd_be_r,
+              gen_helper_sve_st2qq_be_r },
             { gen_helper_sve_st3bb_r,
               gen_helper_sve_st3hh_be_r,
               gen_helper_sve_st3ss_be_r,
-              gen_helper_sve_st3dd_be_r },
+              gen_helper_sve_st3dd_be_r,
+              gen_helper_sve_st3qq_be_r },
             { gen_helper_sve_st4bb_r,
               gen_helper_sve_st4hh_be_r,
               gen_helper_sve_st4ss_be_r,
-              gen_helper_sve_st4dd_be_r } } },
+              gen_helper_sve_st4dd_be_r,
+              gen_helper_sve_st4qq_be_r } } },
         { { { gen_helper_sve_st2bb_r_mte,
               gen_helper_sve_st2hh_le_r_mte,
               gen_helper_sve_st2ss_le_r_mte,
-              gen_helper_sve_st2dd_le_r_mte },
+              gen_helper_sve_st2dd_le_r_mte,
+              gen_helper_sve_st2qq_le_r_mte },
             { gen_helper_sve_st3bb_r_mte,
               gen_helper_sve_st3hh_le_r_mte,
               gen_helper_sve_st3ss_le_r_mte,
-              gen_helper_sve_st3dd_le_r_mte },
+              gen_helper_sve_st3dd_le_r_mte,
+              gen_helper_sve_st3qq_le_r_mte },
             { gen_helper_sve_st4bb_r_mte,
               gen_helper_sve_st4hh_le_r_mte,
               gen_helper_sve_st4ss_le_r_mte,
-              gen_helper_sve_st4dd_le_r_mte } },
+              gen_helper_sve_st4dd_le_r_mte,
+              gen_helper_sve_st4qq_le_r_mte } },
           { { gen_helper_sve_st2bb_r_mte,
               gen_helper_sve_st2hh_be_r_mte,
               gen_helper_sve_st2ss_be_r_mte,
-              gen_helper_sve_st2dd_be_r_mte },
+              gen_helper_sve_st2dd_be_r_mte,
+              gen_helper_sve_st2qq_be_r_mte },
             { gen_helper_sve_st3bb_r_mte,
               gen_helper_sve_st3hh_be_r_mte,
               gen_helper_sve_st3ss_be_r_mte,
-              gen_helper_sve_st3dd_be_r_mte },
+              gen_helper_sve_st3dd_be_r_mte,
+              gen_helper_sve_st3qq_be_r_mte },
             { gen_helper_sve_st4bb_r_mte,
               gen_helper_sve_st4hh_be_r_mte,
               gen_helper_sve_st4ss_be_r_mte,
-              gen_helper_sve_st4dd_be_r_mte } } },
+              gen_helper_sve_st4dd_be_r_mte,
+              gen_helper_sve_st4qq_be_r_mte } } },
     };
     gen_helper_gvec_mem *fn;
     int be = s->be_data == MO_BE;
@@ -5663,12 +5707,17 @@ static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
         }
         break;
     case MO_128:
-        assert(a->msz < a->esz);
-        assert(a->nreg == 0);
-        if (!dc_isar_feature(aa64_sve2p1, s)) {
-            return false;
+        if (a->nreg == 0) {
+            assert(a->msz < a->esz);
+            if (!dc_isar_feature(aa64_sve2p1, s)) {
+                return false;
+            }
+            s->is_nonstreaming = true;
+        } else {
+            if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+                return false;
+            }
         }
-        s->is_nonstreaming = true;
         break;
     default:
         g_assert_not_reached();
@@ -5695,12 +5744,17 @@ static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a)
         }
         break;
     case MO_128:
-        assert(a->msz < a->esz);
-        assert(a->nreg == 0);
-        if (!dc_isar_feature(aa64_sve2p1, s)) {
-            return false;
+        if (a->nreg == 0) {
+            assert(a->msz < a->esz);
+            if (!dc_isar_feature(aa64_sve2p1, s)) {
+                return false;
+            }
+            s->is_nonstreaming = true;
+        } else {
+            if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+                return false;
+            }
         }
-        s->is_nonstreaming = true;
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index bf33bc305f..3eda029146 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -229,6 +229,9 @@
 @rprr_load_dt   ....... dtype:4 rm:5 ... pg:3 rn:5 rd:5         &rprr_load
 @rpri_load_dt   ....... dtype:4 . imm:s4 ... pg:3 rn:5 rd:5     &rpri_load
 
+@rprr_load      ....... .... rm:5 ... pg:3 rn:5 rd:5            &rprr_load
+@rpri_load      ....... .... . imm:s4 ... pg:3 rn:5 rd:5        &rpri_load
+
 @rprr_load_msz  ....... .... rm:5 ... pg:3 rn:5 rd:5 \
                 &rprr_load dtype=%msz_dtype
 @rpri_load_msz  ....... .... . imm:s4 ... pg:3 rn:5 rd:5 \
@@ -1267,12 +1270,26 @@ LDNF1_zpri      1010010 .... 1.... 101 ... ..... .....    @rpri_load_dt nreg=0
 # SVE load multiple structures (scalar plus scalar)
 # LD2B, LD2H, LD2W, LD2D; etc.
 LD_zprr         1010010 .. nreg:2 ..... 110 ... ..... .....     @rprr_load_msz
+# LD[234]Q
+LD_zprr         1010010 01 01     ..... 100 ... ..... ..... \
+                @rprr_load dtype=18 nreg=1
+LD_zprr         1010010 10 01     ..... 100 ... ..... ..... \
+                @rprr_load dtype=18 nreg=2
+LD_zprr         1010010 11 01     ..... 100 ... ..... ..... \
+                @rprr_load dtype=18 nreg=3
 
 # SVE contiguous non-temporal load (scalar plus immediate)
 # LDNT1B, LDNT1H, LDNT1W, LDNT1D
 # SVE load multiple structures (scalar plus immediate)
 # LD2B, LD2H, LD2W, LD2D; etc.
 LD_zpri         1010010 .. nreg:2 0.... 111 ... ..... .....     @rpri_load_msz
+# LD[234]Q
+LD_zpri         1010010 01 001 .... 111 ... ..... .....         \
+                @rpri_load dtype=18 nreg=1
+LD_zpri         1010010 10 001 .... 111 ... ..... .....         \
+                @rpri_load dtype=18 nreg=2
+LD_zpri         1010010 11 001 .... 111 ... ..... .....         \
+                @rpri_load dtype=18 nreg=3
 
 # SVE load and broadcast quadword (scalar plus scalar)
 LD1RQ_zprr      1010010 .. 00 ..... 000 ... ..... ..... \
@@ -1383,11 +1400,25 @@ ST_zprr         1110010 11 10     ..... 010 ... ..... ..... \
 # SVE store multiple structures (scalar plus immediate)      (nreg != 0)
 ST_zpri         1110010 .. nreg:2 1.... 111 ... ..... ..... \
                 @rpri_store msz=%size_23 esz=%size_23
+# ST[234]Q
+ST_zpri         11100100 01 00 .... 000 ... ..... ..... \
+                @rpri_store msz=4 esz=4 nreg=1
+ST_zpri         11100100 10 00 .... 000 ... ..... ..... \
+                @rpri_store msz=4 esz=4 nreg=2
+ST_zpri         11100100 11 00 .... 000 ... ..... ..... \
+                @rpri_store msz=4 esz=4 nreg=3
 
 # SVE contiguous non-temporal store (scalar plus scalar)     (nreg == 0)
 # SVE store multiple structures (scalar plus scalar)         (nreg != 0)
 ST_zprr         1110010 .. nreg:2 ..... 011 ... ..... ..... \
                 @rprr_store msz=%size_23 esz=%size_23
+# ST[234]Q
+ST_zprr         11100100 01 1 ..... 000 ... ..... ..... \
+                @rprr_store msz=4 esz=4 nreg=1
+ST_zprr         11100100 10 1 ..... 000 ... ..... ..... \
+                @rprr_store msz=4 esz=4 nreg=2
+ST_zprr         11100100 11 1 ..... 000 ... ..... ..... \
+                @rprr_store msz=4 esz=4 nreg=3
 
 # SVE 32-bit scatter store (scalar plus 32-bit scaled offsets)
 # Require msz > 0 && msz <= esz.
-- 
2.43.0


