Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA8BECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAU-0003tZ-Ue; Mon, 09 Sep 2024 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAT-0003mZ-Ly
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:09 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAQ-0007oN-Vg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2053f6b8201so43531065ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898986; x=1726503786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnpHSHy4OhdZDnvcij/STHIMTfFD3fwP5agNyx75sJI=;
 b=CtXSNLYWGIQxYQwccfnyo0aRcIbLcbuKbM+2EPjdy8vm8WXmXXM1ttTzy6VBGks+x4
 9fDMWb8FOu+P4GXnAn/XTfxxXgxYet3bd5WkMPrITIthgHd7zjEfzJSu27g+p5X6PfIz
 RERT8N+4go3Y2mrQ/p3AOKuCkNuReJjyw0borQki8M6zI2yPROh3un4LQ86f8qiTy1oc
 bMny+YY3A2xmSzBWRLFtqfX2HEr64UCemoaVWaXODh0g7h5p/Sr4kwDuFilsxdbUvJd/
 2rBPLvK50an6kQKP3F0uzVn1h2khLmKmzhQQOJWiA722Ge0K28Gi+QeTHJ6NUe25wVPY
 w4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898986; x=1726503786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnpHSHy4OhdZDnvcij/STHIMTfFD3fwP5agNyx75sJI=;
 b=unC7Mp76Z7rtV56jD9l/0HdhZBUQbi9v34tkSxhPPHnJG5oJFXxvgU+ci+ym6ixAOn
 EYUbvXDH54L6ygHCqNjMoONNy4MnuxeHkPLTdAbrCIICxKpxP4RGS24EwGvA56PljeQE
 OA720afd58PgRhw9ThJQBUMk1USZE0l9aP3X0wk6EjjMTUOsnNpjKhdd0pFt7NLN6XGO
 +xjRYkjWwwj1/p7MbiayxHSxziLOvsSyevtbPorlaOy2WblsJZX++QMiyKNI2om5VIJL
 OCfaqG0d0f/c4SMHn+BzbHEAxxhuRn/g1ymoAO0HZkhGzHxSFif8tl7iY5vaIWmsi1C3
 6IqQ==
X-Gm-Message-State: AOJu0YzWbGHAr7ybUXYjyHigoOumLm9c6jwltoxYgcVI7COpt1u0YMnX
 TTQCPM5vT05EHZ5AUyPAF2o/Zp71lt0bQFpY2177HxwWv3dpBzzRItrYfIbiMIWykXC0AStUXGv
 E
X-Google-Smtp-Source: AGHT+IEHGNqgPWm0N6/iyHZj9CWVF4ocDVo+EJHHStxKUbab9GNRfhBJET4FSFjctBxi/358y72E0g==
X-Received: by 2002:a17:903:32c5:b0:206:a239:de67 with SMTP id
 d9443c01a7336-206f04fe3c2mr140316605ad.18.1725898985606; 
 Mon, 09 Sep 2024 09:23:05 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:23:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 26/29] target/arm: Widen NeonGenNarrowEnvFn return to 64
 bits
Date: Mon,  9 Sep 2024 09:22:36 -0700
Message-ID: <20240909162240.647173-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

While these functions really do return a 32-bit value,
widening the return type means that we need do less
marshalling between TCG types.

Remove NeonGenNarrowEnvFn typedef; add NeonGenOne64OpEnvFn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 22 ++++++------
 target/arm/tcg/translate.h      |  2 +-
 target/arm/tcg/neon_helper.c    | 22 ++++++------
 target/arm/tcg/translate-a64.c  | 60 ++++++++++++++++++---------------
 target/arm/tcg/translate-neon.c | 44 ++++++++++++------------
 5 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b40589d329..58919b670e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -375,17 +375,17 @@ DEF_HELPER_3(neon_qrdmulh_s32, i32, env, i32, i32)
 DEF_HELPER_4(neon_qrdmlah_s32, i32, env, s32, s32, s32)
 DEF_HELPER_4(neon_qrdmlsh_s32, i32, env, s32, s32, s32)
 
-DEF_HELPER_1(neon_narrow_u8, i32, i64)
-DEF_HELPER_1(neon_narrow_u16, i32, i64)
-DEF_HELPER_2(neon_unarrow_sat8, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u8, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s8, i32, env, i64)
-DEF_HELPER_2(neon_unarrow_sat16, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u16, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s16, i32, env, i64)
-DEF_HELPER_2(neon_unarrow_sat32, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u32, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s32, i32, env, i64)
+DEF_HELPER_1(neon_narrow_u8, i64, i64)
+DEF_HELPER_1(neon_narrow_u16, i64, i64)
+DEF_HELPER_2(neon_unarrow_sat8, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u8, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s8, i64, env, i64)
+DEF_HELPER_2(neon_unarrow_sat16, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u16, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s16, i64, env, i64)
+DEF_HELPER_2(neon_unarrow_sat32, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u32, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s32, i64, env, i64)
 DEF_HELPER_1(neon_narrow_high_u8, i32, i64)
 DEF_HELPER_1(neon_narrow_high_u16, i32, i64)
 DEF_HELPER_1(neon_narrow_round_high_u8, i32, i64)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 7721c627e9..5a2e10d64d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -605,13 +605,13 @@ typedef void NeonGenThreeOpEnvFn(TCGv_i32, TCGv_env, TCGv_i32,
 typedef void NeonGenTwo64OpFn(TCGv_i64, TCGv_i64, TCGv_i64);
 typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
 typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
-typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
 typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
 typedef void NeonGenOneSingleOpFn(TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoSingleOpFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOne64OpFn(TCGv_i64, TCGv_i64);
+typedef void NeonGenOne64OpEnvFn(TCGv_i64, TCGv_env, TCGv_i64);
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 739e16e441..632df84a91 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -598,13 +598,13 @@ NEON_VOP_ENV(qrdmulh_s32, neon_s32, 1)
 #undef NEON_FN
 #undef NEON_QDMULH32
 
-uint32_t HELPER(neon_narrow_u8)(uint64_t x)
+uint64_t HELPER(neon_narrow_u8)(uint64_t x)
 {
     return (x & 0xffu) | ((x >> 8) & 0xff00u) | ((x >> 16) & 0xff0000u)
            | ((x >> 24) & 0xff000000u);
 }
 
-uint32_t HELPER(neon_narrow_u16)(uint64_t x)
+uint64_t HELPER(neon_narrow_u16)(uint64_t x)
 {
     return (x & 0xffffu) | ((x >> 16) & 0xffff0000u);
 }
@@ -635,7 +635,7 @@ uint32_t HELPER(neon_narrow_round_high_u16)(uint64_t x)
     return ((x >> 16) & 0xffff) | ((x >> 32) & 0xffff0000);
 }
 
-uint32_t HELPER(neon_unarrow_sat8)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_unarrow_sat8)(CPUARMState *env, uint64_t x)
 {
     uint16_t s;
     uint8_t d;
@@ -662,7 +662,7 @@ uint32_t HELPER(neon_unarrow_sat8)(CPUARMState *env, uint64_t x)
     return res;
 }
 
-uint32_t HELPER(neon_narrow_sat_u8)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_narrow_sat_u8)(CPUARMState *env, uint64_t x)
 {
     uint16_t s;
     uint8_t d;
@@ -685,7 +685,7 @@ uint32_t HELPER(neon_narrow_sat_u8)(CPUARMState *env, uint64_t x)
     return res;
 }
 
-uint32_t HELPER(neon_narrow_sat_s8)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_narrow_sat_s8)(CPUARMState *env, uint64_t x)
 {
     int16_t s;
     uint8_t d;
@@ -708,7 +708,7 @@ uint32_t HELPER(neon_narrow_sat_s8)(CPUARMState *env, uint64_t x)
     return res;
 }
 
-uint32_t HELPER(neon_unarrow_sat16)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_unarrow_sat16)(CPUARMState *env, uint64_t x)
 {
     uint32_t high;
     uint32_t low;
@@ -731,7 +731,7 @@ uint32_t HELPER(neon_unarrow_sat16)(CPUARMState *env, uint64_t x)
     return low | (high << 16);
 }
 
-uint32_t HELPER(neon_narrow_sat_u16)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_narrow_sat_u16)(CPUARMState *env, uint64_t x)
 {
     uint32_t high;
     uint32_t low;
@@ -748,7 +748,7 @@ uint32_t HELPER(neon_narrow_sat_u16)(CPUARMState *env, uint64_t x)
     return low | (high << 16);
 }
 
-uint32_t HELPER(neon_narrow_sat_s16)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_narrow_sat_s16)(CPUARMState *env, uint64_t x)
 {
     int32_t low;
     int32_t high;
@@ -765,7 +765,7 @@ uint32_t HELPER(neon_narrow_sat_s16)(CPUARMState *env, uint64_t x)
     return (uint16_t)low | (high << 16);
 }
 
-uint32_t HELPER(neon_unarrow_sat32)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_unarrow_sat32)(CPUARMState *env, uint64_t x)
 {
     if (x & 0x8000000000000000ull) {
         SET_QC();
@@ -778,7 +778,7 @@ uint32_t HELPER(neon_unarrow_sat32)(CPUARMState *env, uint64_t x)
     return x;
 }
 
-uint32_t HELPER(neon_narrow_sat_u32)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_narrow_sat_u32)(CPUARMState *env, uint64_t x)
 {
     if (x > 0xffffffffu) {
         SET_QC();
@@ -787,7 +787,7 @@ uint32_t HELPER(neon_narrow_sat_u32)(CPUARMState *env, uint64_t x)
     return x;
 }
 
-uint32_t HELPER(neon_narrow_sat_s32)(CPUARMState *env, uint64_t x)
+uint64_t HELPER(neon_narrow_sat_s32)(CPUARMState *env, uint64_t x)
 {
     if ((int64_t)x != (int32_t)x) {
         SET_QC();
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 934746d2f2..7918720d9b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9439,11 +9439,9 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
     int elements = is_scalar ? 1 : (64 / esize);
     bool round = extract32(opcode, 0, 1);
     MemOp ldop = (size + 1) | (is_u_shift ? 0 : MO_SIGN);
-    TCGv_i64 tcg_rn, tcg_rd;
-    TCGv_i32 tcg_rd_narrowed;
-    TCGv_i64 tcg_final;
+    TCGv_i64 tcg_rn, tcg_rd, tcg_final;
 
-    static NeonGenNarrowEnvFn * const signed_narrow_fns[4][2] = {
+    static NeonGenOne64OpEnvFn * const signed_narrow_fns[4][2] = {
         { gen_helper_neon_narrow_sat_s8,
           gen_helper_neon_unarrow_sat8 },
         { gen_helper_neon_narrow_sat_s16,
@@ -9452,13 +9450,13 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
           gen_helper_neon_unarrow_sat32 },
         { NULL, NULL },
     };
-    static NeonGenNarrowEnvFn * const unsigned_narrow_fns[4] = {
+    static NeonGenOne64OpEnvFn * const unsigned_narrow_fns[4] = {
         gen_helper_neon_narrow_sat_u8,
         gen_helper_neon_narrow_sat_u16,
         gen_helper_neon_narrow_sat_u32,
         NULL
     };
-    NeonGenNarrowEnvFn *narrowfn;
+    NeonGenOne64OpEnvFn *narrowfn;
 
     int i;
 
@@ -9481,15 +9479,13 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
 
     tcg_rn = tcg_temp_new_i64();
     tcg_rd = tcg_temp_new_i64();
-    tcg_rd_narrowed = tcg_temp_new_i32();
     tcg_final = tcg_temp_new_i64();
 
     for (i = 0; i < elements; i++) {
         read_vec_element(s, tcg_rn, rn, i, ldop);
         handle_shri_with_rndacc(tcg_rd, tcg_rn, round,
                                 false, is_u_shift, size+1, shift);
-        narrowfn(tcg_rd_narrowed, tcg_env, tcg_rd);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_rd_narrowed);
+        narrowfn(tcg_rd, tcg_env, tcg_rd);
         if (i == 0) {
             tcg_gen_extract_i64(tcg_final, tcg_rd, 0, esize);
         } else {
@@ -10228,35 +10224,35 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
      * in the source becomes a size element in the destination).
      */
     int pass;
-    TCGv_i32 tcg_res[2];
+    TCGv_i64 tcg_res[2];
     int destelt = is_q ? 2 : 0;
     int passes = scalar ? 1 : 2;
 
     if (scalar) {
-        tcg_res[1] = tcg_constant_i32(0);
+        tcg_res[1] = tcg_constant_i64(0);
     }
 
     for (pass = 0; pass < passes; pass++) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
-        NeonGenNarrowFn *genfn = NULL;
-        NeonGenNarrowEnvFn *genenvfn = NULL;
+        NeonGenOne64OpFn *genfn = NULL;
+        NeonGenOne64OpEnvFn *genenvfn = NULL;
 
         if (scalar) {
             read_vec_element(s, tcg_op, rn, pass, size + 1);
         } else {
             read_vec_element(s, tcg_op, rn, pass, MO_64);
         }
-        tcg_res[pass] = tcg_temp_new_i32();
+        tcg_res[pass] = tcg_temp_new_i64();
 
         switch (opcode) {
         case 0x12: /* XTN, SQXTUN */
         {
-            static NeonGenNarrowFn * const xtnfns[3] = {
+            static NeonGenOne64OpFn * const xtnfns[3] = {
                 gen_helper_neon_narrow_u8,
                 gen_helper_neon_narrow_u16,
-                tcg_gen_extrl_i64_i32,
+                tcg_gen_ext32u_i64,
             };
-            static NeonGenNarrowEnvFn * const sqxtunfns[3] = {
+            static NeonGenOne64OpEnvFn * const sqxtunfns[3] = {
                 gen_helper_neon_unarrow_sat8,
                 gen_helper_neon_unarrow_sat16,
                 gen_helper_neon_unarrow_sat32,
@@ -10270,7 +10266,7 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         }
         case 0x14: /* SQXTN, UQXTN */
         {
-            static NeonGenNarrowEnvFn * const fns[3][2] = {
+            static NeonGenOne64OpEnvFn * const fns[3][2] = {
                 { gen_helper_neon_narrow_sat_s8,
                   gen_helper_neon_narrow_sat_u8 },
                 { gen_helper_neon_narrow_sat_s16,
@@ -10284,7 +10280,9 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         case 0x16: /* FCVTN, FCVTN2 */
             /* 32 bit to 16 bit or 64 bit to 32 bit float conversion */
             if (size == 2) {
-                gen_helper_vfp_fcvtsd(tcg_res[pass], tcg_op, tcg_env);
+                TCGv_i32 tmp = tcg_temp_new_i32();
+                gen_helper_vfp_fcvtsd(tmp, tcg_op, tcg_env);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
             } else {
                 TCGv_i32 tcg_lo = tcg_temp_new_i32();
                 TCGv_i32 tcg_hi = tcg_temp_new_i32();
@@ -10294,21 +10292,29 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
                 tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
                 gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
                 gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
-                tcg_gen_deposit_i32(tcg_res[pass], tcg_lo, tcg_hi, 16, 16);
+                tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tcg_lo);
             }
             break;
         case 0x36: /* BFCVTN, BFCVTN2 */
             {
                 TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                gen_helper_bfcvt_pair(tcg_res[pass], tcg_op, fpst);
+                TCGv_i32 tmp = tcg_temp_new_i32();
+                gen_helper_bfcvt_pair(tmp, tcg_op, fpst);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
             }
             break;
         case 0x56:  /* FCVTXN, FCVTXN2 */
-            /* 64 bit to 32 bit float conversion
-             * with von Neumann rounding (round to odd)
-             */
-            assert(size == 2);
-            gen_helper_fcvtx_f64_to_f32(tcg_res[pass], tcg_op, tcg_env);
+            {
+                /*
+                 * 64 bit to 32 bit float conversion
+                 * with von Neumann rounding (round to odd)
+                 */
+                TCGv_i32 tmp = tcg_temp_new_i32();
+                assert(size == 2);
+                gen_helper_fcvtx_f64_to_f32(tmp, tcg_op, tcg_env);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
+            }
             break;
         default:
             g_assert_not_reached();
@@ -10322,7 +10328,7 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
     }
 
     for (pass = 0; pass < 2; pass++) {
-        write_vec_element_i32(s, tcg_res[pass], rd, destelt + pass, MO_32);
+        write_vec_element(s, tcg_res[pass], rd, destelt + pass, MO_32);
     }
     clear_vec_high(s, is_q, rd);
 }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 6dd70d1c53..9c8829ad7d 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1107,11 +1107,10 @@ DO_2SH(VQSHL_S, gen_neon_sqshli)
 
 static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
                                 NeonGenTwo64OpFn *shiftfn,
-                                NeonGenNarrowEnvFn *narrowfn)
+                                NeonGenOne64OpEnvFn *narrowfn)
 {
     /* 2-reg-and-shift narrowing-shift operations, size == 3 case */
-    TCGv_i64 constimm, rm1, rm2;
-    TCGv_i32 rd;
+    TCGv_i64 constimm, rm1, rm2, rd;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -1138,7 +1137,7 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
     constimm = tcg_constant_i64(-a->shift);
     rm1 = tcg_temp_new_i64();
     rm2 = tcg_temp_new_i64();
-    rd = tcg_temp_new_i32();
+    rd = tcg_temp_new_i64();
 
     /* Load both inputs first to avoid potential overwrite if rm == rd */
     read_neon_element64(rm1, a->vm, 0, MO_64);
@@ -1146,18 +1145,18 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
 
     shiftfn(rm1, rm1, constimm);
     narrowfn(rd, tcg_env, rm1);
-    write_neon_element32(rd, a->vd, 0, MO_32);
+    write_neon_element64(rd, a->vd, 0, MO_32);
 
     shiftfn(rm2, rm2, constimm);
     narrowfn(rd, tcg_env, rm2);
-    write_neon_element32(rd, a->vd, 1, MO_32);
+    write_neon_element64(rd, a->vd, 1, MO_32);
 
     return true;
 }
 
 static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
                                 NeonGenTwoOpFn *shiftfn,
-                                NeonGenNarrowEnvFn *narrowfn)
+                                NeonGenOne64OpEnvFn *narrowfn)
 {
     /* 2-reg-and-shift narrowing-shift operations, size < 3 case */
     TCGv_i32 constimm, rm1, rm2, rm3, rm4;
@@ -1212,16 +1211,16 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
 
     tcg_gen_concat_i32_i64(rtmp, rm1, rm2);
 
-    narrowfn(rm1, tcg_env, rtmp);
-    write_neon_element32(rm1, a->vd, 0, MO_32);
+    narrowfn(rtmp, tcg_env, rtmp);
+    write_neon_element64(rtmp, a->vd, 0, MO_32);
 
     shiftfn(rm3, rm3, constimm);
     shiftfn(rm4, rm4, constimm);
 
     tcg_gen_concat_i32_i64(rtmp, rm3, rm4);
 
-    narrowfn(rm3, tcg_env, rtmp);
-    write_neon_element32(rm3, a->vd, 1, MO_32);
+    narrowfn(rtmp, tcg_env, rtmp);
+    write_neon_element64(rtmp, a->vd, 1, MO_32);
     return true;
 }
 
@@ -1236,17 +1235,17 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
         return do_2shift_narrow_32(s, a, FUNC, NARROWFUNC);             \
     }
 
-static void gen_neon_narrow_u32(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+static void gen_neon_narrow_u32(TCGv_i64 dest, TCGv_ptr env, TCGv_i64 src)
 {
-    tcg_gen_extrl_i64_i32(dest, src);
+    tcg_gen_ext32u_i64(dest, src);
 }
 
-static void gen_neon_narrow_u16(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+static void gen_neon_narrow_u16(TCGv_i64 dest, TCGv_ptr env, TCGv_i64 src)
 {
     gen_helper_neon_narrow_u16(dest, src);
 }
 
-static void gen_neon_narrow_u8(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+static void gen_neon_narrow_u8(TCGv_i64 dest, TCGv_ptr env, TCGv_i64 src)
 {
     gen_helper_neon_narrow_u8(dest, src);
 }
@@ -2837,10 +2836,9 @@ static bool trans_VZIP(DisasContext *s, arg_2misc *a)
 }
 
 static bool do_vmovn(DisasContext *s, arg_2misc *a,
-                     NeonGenNarrowEnvFn *narrowfn)
+                     NeonGenOne64OpEnvFn *narrowfn)
 {
-    TCGv_i64 rm;
-    TCGv_i32 rd0, rd1;
+    TCGv_i64 rm, rd0, rd1;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -2865,22 +2863,22 @@ static bool do_vmovn(DisasContext *s, arg_2misc *a,
     }
 
     rm = tcg_temp_new_i64();
-    rd0 = tcg_temp_new_i32();
-    rd1 = tcg_temp_new_i32();
+    rd0 = tcg_temp_new_i64();
+    rd1 = tcg_temp_new_i64();
 
     read_neon_element64(rm, a->vm, 0, MO_64);
     narrowfn(rd0, tcg_env, rm);
     read_neon_element64(rm, a->vm, 1, MO_64);
     narrowfn(rd1, tcg_env, rm);
-    write_neon_element32(rd0, a->vd, 0, MO_32);
-    write_neon_element32(rd1, a->vd, 1, MO_32);
+    write_neon_element64(rd0, a->vd, 0, MO_32);
+    write_neon_element64(rd1, a->vd, 1, MO_32);
     return true;
 }
 
 #define DO_VMOVN(INSN, FUNC)                                    \
     static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
     {                                                           \
-        static NeonGenNarrowEnvFn * const narrowfn[] = {        \
+        static NeonGenOne64OpEnvFn * const narrowfn[] = {       \
             FUNC##8,                                            \
             FUNC##16,                                           \
             FUNC##32,                                           \
-- 
2.43.0


