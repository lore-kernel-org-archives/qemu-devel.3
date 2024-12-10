Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D934DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL31o-0006rJ-DQ; Tue, 10 Dec 2024 11:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31h-0006Kc-D2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:23:58 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31e-0007P7-W8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:23:57 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53f22fd6887so3125166e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847828; x=1734452628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zG86Y19MBGCwLzxG+giH5jIu2mrSyv/3KKPj8MjTGI=;
 b=WRU+fCwaOtUJDmR4HUgnjOKeG+TatBZLjS6Er3eziW1u/EmrpqG9uipw8QnUW8t43T
 Ntz/J1Y95rMo6oirbxWbFrnFcN5my9082xR6M+zUoBjNOuEkukX801FxSDKpZ3D72r3L
 /q60sP1BG0faf03iWJZB62M9l7j5GGfQaLfkVC0+RTry1BGrfzXmUwfRKYpYOgFGshKM
 eNTf1UDk495aB11o7vJHG6vdoH1edMTECWwjCJskZTuHowEL1PWf1tQCecyWVfIfkboH
 x5DjlZ3DoJ4T2ssG/JJ6TJJZDgpNK2p1kTcsr0Kp5aB61cvKv0E2FDdO5iXwuQ/20Sej
 8oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847828; x=1734452628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zG86Y19MBGCwLzxG+giH5jIu2mrSyv/3KKPj8MjTGI=;
 b=KEdpQW6jj2G17DbnXWu+CRDW7x6W3wSYs4nNAuDMpaSVxMaztF8JISI6jyH0KCRe4W
 ljFfQM6oY7r1WcMGst5eTntZarYRSVBZhMKLHylRTkmmb01ivzNu+RBAnQci0nfO3LNk
 ekJWS8YWR6n2uYSFyIf6RMMHTsEndYS0fHjYQT/VaNgkjJvTP48zK3fCiLLfE60v162q
 1tJsPgM0NjFi4LwBiH9j5j11sjs6RsBE4/q2hxWiL7JXs5SpLoZ8VesBPNeJbmZWzU2m
 g/vjJ4VGyPC9uJXe/1UzwCAhUvKnaijIIZIiYOhG9I/Kuxv7gKWyIOmbzwhS5Zm1SIiM
 kgHQ==
X-Gm-Message-State: AOJu0Yxsf2hD+I3U859rayA9FRI260E+FaPmcf/1wgDYiUJY6Mm77o2E
 SGDnTSPvUV2SJj9VzlVamwezjIxepGjaEES9D8Luvi2WvkLK4i21YA9xWNa0kB/EBS3nBlSoYVO
 EGYqFMoRE
X-Gm-Gg: ASbGncsGyQldh5Ef+qcUzeQLmn9GqJwSgtcAr+9liTggx7rxddLUyPdBTR93iePwQhA
 vhFF7vNW0NBGdyY54qmJeKlvBYCJiLwimVXS4Hu6o5VdfuHXGInFeObRLTijtv0jyihwDXhvW0V
 H4g2L9KPmdA6zTeC61reKyTMrxyIPYDmcUHyWWdvKFuxT4adl6yzBxR8ozm70YmcGW4+SmUlhZi
 dkKjmP0dRMgED0dudL1i7K0h5T7zKVDdtINoGoMF9kmn2GgisTrabqjlnA=
X-Google-Smtp-Source: AGHT+IFa5RHkgJJ3trOKA/yjLw0v69kUCHin1c3CVb9RkG2Zm7QK7xd9CL5oXw2YNR+/V0hB8//Dew==
X-Received: by 2002:a05:6512:2384:b0:53e:37a5:4caf with SMTP id
 2adb3069b0e04-53e37a54f91mr5909980e87.11.1733847827956; 
 Tue, 10 Dec 2024 08:23:47 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:23:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 45/69] target/arm: Introduce gen_gvec_{s,u}{add,ada}lp
Date: Tue, 10 Dec 2024 10:17:09 -0600
Message-ID: <20241210161733.1830573-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

Pairwise addition with and without accumulation.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |   2 -
 target/arm/tcg/translate.h      |   9 ++
 target/arm/tcg/gengvec.c        | 230 ++++++++++++++++++++++++++++++++
 target/arm/tcg/neon_helper.c    |  22 ---
 target/arm/tcg/translate-neon.c | 150 +--------------------
 5 files changed, 243 insertions(+), 170 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 57e0ce387b..6369d07d05 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -397,8 +397,6 @@ DEF_HELPER_1(neon_widen_s16, i64, i32)
 
 DEF_HELPER_2(neon_addl_u16, i64, i64, i64)
 DEF_HELPER_2(neon_addl_u32, i64, i64, i64)
-DEF_HELPER_2(neon_paddl_u16, i64, i64, i64)
-DEF_HELPER_2(neon_paddl_u32, i64, i64, i64)
 DEF_HELPER_FLAGS_1(neon_addlp_s8, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(neon_addlp_s16, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(neon_subl_u16, i64, i64, i64)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 342ebedafc..edd775d564 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -593,6 +593,15 @@ void gen_gvec_rev32(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_rev64(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_saddlp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uaddlp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 33c0a94958..2755da8ac7 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2467,3 +2467,233 @@ void gen_gvec_rev64(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
         g_assert_not_reached();
     }
 }
+
+static void gen_saddlp_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    int half = 4 << vece;
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_shli_vec(vece, t, n, half);
+    tcg_gen_sari_vec(vece, d, n, half);
+    tcg_gen_sari_vec(vece, t, t, half);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+static void gen_saddlp_s_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_ext32s_i64(t, n);
+    tcg_gen_sari_i64(d, n, 32);
+    tcg_gen_add_i64(d, d, t);
+}
+
+void gen_gvec_saddlp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_shli_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2 g[] = {
+        { .fniv = gen_saddlp_vec,
+          .fni8 = gen_helper_neon_addlp_s8,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fniv = gen_saddlp_vec,
+          .fni8 = gen_helper_neon_addlp_s16,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fniv = gen_saddlp_vec,
+          .fni8 = gen_saddlp_s_i64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_sadalp_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    gen_saddlp_vec(vece, t, n);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+static void gen_sadalp_b_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_helper_neon_addlp_s8(t, n);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_sadalp_h_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_helper_neon_addlp_s16(t, n);
+    tcg_gen_vec_add32_i64(d, d, t);
+}
+
+static void gen_sadalp_s_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_saddlp_s_i64(t, n);
+    tcg_gen_add_i64(d, d, t);
+}
+
+void gen_gvec_sadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_shli_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2 g[] = {
+        { .fniv = gen_sadalp_vec,
+          .fni8 = gen_sadalp_b_i64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fniv = gen_sadalp_vec,
+          .fni8 = gen_sadalp_h_i64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fniv = gen_sadalp_vec,
+          .fni8 = gen_sadalp_s_i64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_uaddlp_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    int half = 4 << vece;
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_constant_vec_matching(d, vece, MAKE_64BIT_MASK(0, half));
+
+    tcg_gen_shri_vec(vece, t, n, half);
+    tcg_gen_and_vec(vece, d, n, m);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+static void gen_uaddlp_b_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_16, 0xff));
+
+    tcg_gen_shri_i64(t, n, 8);
+    tcg_gen_and_i64(d, n, m);
+    tcg_gen_and_i64(t, t, m);
+    /* No carry between widened unsigned elements. */
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_uaddlp_h_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_32, 0xffff));
+
+    tcg_gen_shri_i64(t, n, 16);
+    tcg_gen_and_i64(d, n, m);
+    tcg_gen_and_i64(t, t, m);
+    /* No carry between widened unsigned elements. */
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_uaddlp_s_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_ext32u_i64(t, n);
+    tcg_gen_shri_i64(d, n, 32);
+    tcg_gen_add_i64(d, d, t);
+}
+
+void gen_gvec_uaddlp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2 g[] = {
+        { .fniv = gen_uaddlp_vec,
+          .fni8 = gen_uaddlp_b_i64,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fniv = gen_uaddlp_vec,
+          .fni8 = gen_uaddlp_h_i64,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fniv = gen_uaddlp_vec,
+          .fni8 = gen_uaddlp_s_i64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_uadalp_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    gen_uaddlp_vec(vece, t, n);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+static void gen_uadalp_b_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_uaddlp_b_i64(t, n);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_uadalp_h_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_uaddlp_h_i64(t, n);
+    tcg_gen_vec_add32_i64(d, d, t);
+}
+
+static void gen_uadalp_s_i64(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_uaddlp_s_i64(t, n);
+    tcg_gen_add_i64(d, d, t);
+}
+
+void gen_gvec_uadalp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2 g[] = {
+        { .fniv = gen_uadalp_vec,
+          .fni8 = gen_uadalp_b_i64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fniv = gen_uadalp_vec,
+          .fni8 = gen_uadalp_h_i64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fniv = gen_uadalp_vec,
+          .fni8 = gen_uadalp_s_i64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index b92ddd4914..1a22857b5e 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -844,28 +844,6 @@ uint64_t HELPER(neon_addl_u32)(uint64_t a, uint64_t b)
     return (a + b) ^ mask;
 }
 
-uint64_t HELPER(neon_paddl_u16)(uint64_t a, uint64_t b)
-{
-    uint64_t tmp;
-    uint64_t tmp2;
-
-    tmp = a & 0x0000ffff0000ffffull;
-    tmp += (a >> 16) & 0x0000ffff0000ffffull;
-    tmp2 = b & 0xffff0000ffff0000ull;
-    tmp2 += (b << 16) & 0xffff0000ffff0000ull;
-    return    ( tmp         & 0xffff)
-            | ((tmp  >> 16) & 0xffff0000ull)
-            | ((tmp2 << 16) & 0xffff00000000ull)
-            | ( tmp2        & 0xffff000000000000ull);
-}
-
-uint64_t HELPER(neon_paddl_u32)(uint64_t a, uint64_t b)
-{
-    uint32_t low = a + (a >> 32);
-    uint32_t high = b + (b >> 32);
-    return low + ((uint64_t)high << 32);
-}
-
 /* Pairwise long add: add pairs of adjacent elements into
  * double-width elements in the result (eg _s8 is an 8x8->16 op)
  */
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index ca6f5578b4..19a18018f1 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -2565,152 +2565,6 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
     return true;
 }
 
-static bool do_2misc_pairwise(DisasContext *s, arg_2misc *a,
-                              NeonGenWidenFn *widenfn,
-                              NeonGenTwo64OpFn *opfn,
-                              NeonGenTwo64OpFn *accfn)
-{
-    /*
-     * Pairwise long operations: widen both halves of the pair,
-     * combine the pairs with the opfn, and then possibly accumulate
-     * into the destination with the accfn.
-     */
-    int pass;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vd | a->vm) & a->q) {
-        return false;
-    }
-
-    if (!widenfn) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    for (pass = 0; pass < a->q + 1; pass++) {
-        TCGv_i32 tmp;
-        TCGv_i64 rm0_64, rm1_64, rd_64;
-
-        rm0_64 = tcg_temp_new_i64();
-        rm1_64 = tcg_temp_new_i64();
-        rd_64 = tcg_temp_new_i64();
-
-        tmp = tcg_temp_new_i32();
-        read_neon_element32(tmp, a->vm, pass * 2, MO_32);
-        widenfn(rm0_64, tmp);
-        read_neon_element32(tmp, a->vm, pass * 2 + 1, MO_32);
-        widenfn(rm1_64, tmp);
-
-        opfn(rd_64, rm0_64, rm1_64);
-
-        if (accfn) {
-            TCGv_i64 tmp64 = tcg_temp_new_i64();
-            read_neon_element64(tmp64, a->vd, pass, MO_64);
-            accfn(rd_64, tmp64, rd_64);
-        }
-        write_neon_element64(rd_64, a->vd, pass, MO_64);
-    }
-    return true;
-}
-
-static bool trans_VPADDL_S(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenWidenFn * const widenfn[] = {
-        gen_helper_neon_widen_s8,
-        gen_helper_neon_widen_s16,
-        tcg_gen_ext_i32_i64,
-        NULL,
-    };
-    static NeonGenTwo64OpFn * const opfn[] = {
-        gen_helper_neon_paddl_u16,
-        gen_helper_neon_paddl_u32,
-        tcg_gen_add_i64,
-        NULL,
-    };
-
-    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size], NULL);
-}
-
-static bool trans_VPADDL_U(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenWidenFn * const widenfn[] = {
-        gen_helper_neon_widen_u8,
-        gen_helper_neon_widen_u16,
-        tcg_gen_extu_i32_i64,
-        NULL,
-    };
-    static NeonGenTwo64OpFn * const opfn[] = {
-        gen_helper_neon_paddl_u16,
-        gen_helper_neon_paddl_u32,
-        tcg_gen_add_i64,
-        NULL,
-    };
-
-    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size], NULL);
-}
-
-static bool trans_VPADAL_S(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenWidenFn * const widenfn[] = {
-        gen_helper_neon_widen_s8,
-        gen_helper_neon_widen_s16,
-        tcg_gen_ext_i32_i64,
-        NULL,
-    };
-    static NeonGenTwo64OpFn * const opfn[] = {
-        gen_helper_neon_paddl_u16,
-        gen_helper_neon_paddl_u32,
-        tcg_gen_add_i64,
-        NULL,
-    };
-    static NeonGenTwo64OpFn * const accfn[] = {
-        gen_helper_neon_addl_u16,
-        gen_helper_neon_addl_u32,
-        tcg_gen_add_i64,
-        NULL,
-    };
-
-    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size],
-                             accfn[a->size]);
-}
-
-static bool trans_VPADAL_U(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenWidenFn * const widenfn[] = {
-        gen_helper_neon_widen_u8,
-        gen_helper_neon_widen_u16,
-        tcg_gen_extu_i32_i64,
-        NULL,
-    };
-    static NeonGenTwo64OpFn * const opfn[] = {
-        gen_helper_neon_paddl_u16,
-        gen_helper_neon_paddl_u32,
-        tcg_gen_add_i64,
-        NULL,
-    };
-    static NeonGenTwo64OpFn * const accfn[] = {
-        gen_helper_neon_addl_u16,
-        gen_helper_neon_addl_u32,
-        tcg_gen_add_i64,
-        NULL,
-    };
-
-    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size],
-                             accfn[a->size]);
-}
-
 typedef void ZipFn(TCGv_ptr, TCGv_ptr);
 
 static bool do_zip_uzp(DisasContext *s, arg_2misc *a,
@@ -3071,6 +2925,10 @@ DO_2MISC_VEC(VCLT0, gen_gvec_clt0)
 DO_2MISC_VEC(VCLS, gen_gvec_cls)
 DO_2MISC_VEC(VCLZ, gen_gvec_clz)
 DO_2MISC_VEC(VREV64, gen_gvec_rev64)
+DO_2MISC_VEC(VPADDL_S, gen_gvec_saddlp)
+DO_2MISC_VEC(VPADDL_U, gen_gvec_uaddlp)
+DO_2MISC_VEC(VPADAL_S, gen_gvec_sadalp)
+DO_2MISC_VEC(VPADAL_U, gen_gvec_uadalp)
 
 static bool trans_VMVN(DisasContext *s, arg_2misc *a)
 {
-- 
2.43.0


