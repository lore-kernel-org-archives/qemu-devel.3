Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0878CC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zn-0004Qb-6w; Fri, 31 May 2024 08:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zj-0004Os-Vr
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zf-0003Su-1w
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35dc7d0387cso2100380f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157061; x=1717761861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dKnLywDCleOjlF7AaEUcPDM4oPNQuzVqPTIukJeuF5c=;
 b=PH7HL9YRmOGW204IKhMoVfuJtqWv1QQfn+C+NbPyhEPBTsXXK5iZIuA33a/a/CuzOF
 mUzuv2vrBIphumKGIWOQRh3IYcelvXXIfxG2Vm7CDg9HhcpygjaLP8AQymbem4q1CH97
 A07wqSFp6ZANuxkRTVs6QQZ4n2k+Zc1eK4lKD6hBnAlBhtgrfrboscE2nQ0+eJOV/h0w
 9ZCF2e/YECoZVAlGYinWkYkgnuhZJj4AfLxkIAM5f55qhcLMMxchz5o/kn9RC5vi+C+f
 BHJOu5Vlzex84qf5FflRFj5BJoFlUyS32DMqIib1CbkjaDvUGk5UpmKkQDemJjhDYst0
 5QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157061; x=1717761861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKnLywDCleOjlF7AaEUcPDM4oPNQuzVqPTIukJeuF5c=;
 b=RkpODGUbIFlMfijkWtGac1SIlzvnQ2IXLE1I6IWCpRctSMXtce7QVJlYKnyXE2/8md
 WAszHIoUMXZC/3DSGV8nW+221qTXfGq8vnvcVBG05xo2f7ilaTwp/dQBt/7B/CrxsrrY
 g4lFG7zQS4w2lk4xDbwZXq4vy1WBxs+pW0DXKcp24k26nDZF93KKHabIw8r0lS1ffsHx
 lZ773u7I+dcQlYYV6D5t0MnqIR2HGBWN223MUsvwF/t6dnfOcelKB5AdfOrX75TXXWkb
 xuM92irOCsDGu8MN+EanK0nKFgVuVlUP4VXgFRyR/d/LiJWb4cwpDms2F8G72/U6sjGO
 xouQ==
X-Gm-Message-State: AOJu0YwBaCjoPAoyfOSF2v3zUih39kmbx2ISY+Rew2rbiCZN+R5daOCo
 eJY7Vp+2QlTTgrWPHGzoaku1Xamcst+JXxBVhiVuVISZ5sKMiAUoEcU+ixhJUzFD2Uc0fgfsTUX
 /
X-Google-Smtp-Source: AGHT+IHFqNgO6bwBdUCCL2U32tIhltkt3gRl4LqeEz+o8TXVw6L7X0cJNu+81m9ROmcWB51xc4WMmw==
X-Received: by 2002:a5d:6acf:0:b0:35d:cfe1:af82 with SMTP id
 ffacd0b85a97d-35e0f2686d2mr1509225f8f.17.1717157061063; 
 Fri, 31 May 2024 05:04:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/43] target/arm: Convert SHADD, UHADD to gvec
Date: Fri, 31 May 2024 13:03:43 +0100
Message-Id: <20240531120401.394550-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |   6 --
 target/arm/tcg/translate.h      |   5 ++
 target/arm/tcg/gengvec.c        | 144 ++++++++++++++++++++++++++++++++
 target/arm/tcg/neon_helper.c    |  27 ------
 target/arm/tcg/translate-a64.c  |  17 ++--
 target/arm/tcg/translate-neon.c |   4 +-
 6 files changed, 158 insertions(+), 45 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9a89c9cea74..b26bfcb079c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -268,12 +268,6 @@ DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
 DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
 
 /* neon_helper.c */
-DEF_HELPER_2(neon_hadd_s8, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_s16, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_u16, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_s32, s32, s32, s32)
-DEF_HELPER_2(neon_hadd_u32, i32, i32, i32)
 DEF_HELPER_2(neon_rhadd_s8, i32, i32, i32)
 DEF_HELPER_2(neon_rhadd_u8, i32, i32, i32)
 DEF_HELPER_2(neon_rhadd_s16, i32, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 048cb45ebe9..dd99d76bf24 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -472,6 +472,11 @@ void gen_neon_sqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_neon_uqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                      uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_shadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
 void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 2451d23823f..c0627a787bb 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1861,3 +1861,147 @@ void gen_gvec_uminp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_debug_assert(vece <= MO_32);
     tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
 }
+
+static void gen_shadd8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_and_i64(t, a, b);
+    tcg_gen_vec_sar8i_i64(a, a, 1);
+    tcg_gen_vec_sar8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_add8_i64(d, a, b);
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_shadd16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_and_i64(t, a, b);
+    tcg_gen_vec_sar16i_i64(a, a, 1);
+    tcg_gen_vec_sar16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_add16_i64(d, a, b);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_shadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_and_i32(t, a, b);
+    tcg_gen_sari_i32(a, a, 1);
+    tcg_gen_sari_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_add_i32(d, a, b);
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_shadd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_and_vec(vece, t, a, b);
+    tcg_gen_sari_vec(vece, a, a, 1);
+    tcg_gen_sari_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_add_vec(vece, d, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_shadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen3 g[] = {
+        { .fni8 = gen_shadd8_i64,
+          .fniv = gen_shadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shadd16_i64,
+          .fniv = gen_shadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shadd_i32,
+          .fniv = gen_shadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    tcg_debug_assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_uhadd8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_and_i64(t, a, b);
+    tcg_gen_vec_shr8i_i64(a, a, 1);
+    tcg_gen_vec_shr8i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_add8_i64(d, a, b);
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_uhadd16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_and_i64(t, a, b);
+    tcg_gen_vec_shr16i_i64(a, a, 1);
+    tcg_gen_vec_shr16i_i64(b, b, 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_add16_i64(d, a, b);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_uhadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_and_i32(t, a, b);
+    tcg_gen_shri_i32(a, a, 1);
+    tcg_gen_shri_i32(b, b, 1);
+    tcg_gen_andi_i32(t, t, 1);
+    tcg_gen_add_i32(d, a, b);
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_uhadd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_and_vec(vece, t, a, b);
+    tcg_gen_shri_vec(vece, a, a, 1);
+    tcg_gen_shri_vec(vece, b, b, 1);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec_matching(d, vece, 1));
+    tcg_gen_add_vec(vece, d, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_uhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen3 g[] = {
+        { .fni8 = gen_uhadd8_i64,
+          .fniv = gen_uhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_uhadd16_i64,
+          .fniv = gen_uhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_uhadd_i32,
+          .fniv = gen_uhadd_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+    };
+    tcg_debug_assert(vece <= MO_32);
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
+}
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index b29a7c725f6..defd28a6f71 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -179,33 +179,6 @@ uint32_t HELPER(glue(neon_,name))(uint32_t arg) \
     return arg; \
 }
 
-#define NEON_FN(dest, src1, src2) dest = (src1 + src2) >> 1
-NEON_VOP(hadd_s8, neon_s8, 4)
-NEON_VOP(hadd_u8, neon_u8, 4)
-NEON_VOP(hadd_s16, neon_s16, 2)
-NEON_VOP(hadd_u16, neon_u16, 2)
-#undef NEON_FN
-
-int32_t HELPER(neon_hadd_s32)(int32_t src1, int32_t src2)
-{
-    int32_t dest;
-
-    dest = (src1 >> 1) + (src2 >> 1);
-    if (src1 & src2 & 1)
-        dest++;
-    return dest;
-}
-
-uint32_t HELPER(neon_hadd_u32)(uint32_t src1, uint32_t src2)
-{
-    uint32_t dest;
-
-    dest = (src1 >> 1) + (src2 >> 1);
-    if (src1 & src2 & 1)
-        dest++;
-    return dest;
-}
-
 #define NEON_FN(dest, src1, src2) dest = (src1 + src2 + 1) >> 1
 NEON_VOP(rhadd_s8, neon_s8, 4)
 NEON_VOP(rhadd_u8, neon_u8, 4)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3c6cfc29525..5f3423513d5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10965,6 +10965,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x00: /* SHADD, UHADD */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhadd, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shadd, size);
+        }
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11032,16 +11039,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
 
             switch (opcode) {
-            case 0x0: /* SHADD, UHADD */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_hadd_s8, gen_helper_neon_hadd_u8 },
-                    { gen_helper_neon_hadd_s16, gen_helper_neon_hadd_u16 },
-                    { gen_helper_neon_hadd_s32, gen_helper_neon_hadd_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x2: /* SRHADD, URHADD */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 5f1576393e2..29e5c4a0a39 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -841,6 +841,8 @@ DO_3SAME_NO_SZ_3(VPMAX_S, gen_gvec_smaxp)
 DO_3SAME_NO_SZ_3(VPMIN_S, gen_gvec_sminp)
 DO_3SAME_NO_SZ_3(VPMAX_U, gen_gvec_umaxp)
 DO_3SAME_NO_SZ_3(VPMIN_U, gen_gvec_uminp)
+DO_3SAME_NO_SZ_3(VHADD_S, gen_gvec_shadd)
+DO_3SAME_NO_SZ_3(VHADD_U, gen_gvec_uhadd)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -951,8 +953,6 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
         FUNC(d, tcg_env, n, m);                                         \
     }
 
-DO_3SAME_32(VHADD_S, hadd_s)
-DO_3SAME_32(VHADD_U, hadd_u)
 DO_3SAME_32(VHSUB_S, hsub_s)
 DO_3SAME_32(VHSUB_U, hsub_u)
 DO_3SAME_32(VRHADD_S, rhadd_s)
-- 
2.34.1


