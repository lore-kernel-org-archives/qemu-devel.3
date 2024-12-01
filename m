Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069CAD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbI-0003bt-DP; Sun, 01 Dec 2024 10:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaN-00083D-T5
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:14 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaG-0005AH-JY
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:08 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f1f5075cf2so1557174eaf.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065803; x=1733670603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOnlt+F3jeWmXtP80T/8bMkoX1mFTpy2BWXybos70VE=;
 b=b/Qo2tb63UV5gSRu1lZXeWM2NzWNwfNhIb3sGbvMn8kGSGl1ekwvYbxWpyhgnBXyaA
 dBYgPMDAWijqMh+C5nyNeO+az2Dfy5Z5QRkhaKv4ytuuPG6pz2cuW3QNyKmpRm9B6Vey
 Ca7fuqPxpbGc1zOA+Er+yXARPD6JtRGt9CaydsBKmoFwhmnU/fc2RPxEBz8ifZocxUfh
 uJ+uPUcOQvzuFcEcGA2T4CXdipwA4SJFccao0aQX/c1cUncolevYhhHoDYnEZd+W0t+M
 aafBxCKLymFJEtBZfm0qTyCWTnVbKoLCNNASjaSqC2bmfXu+j4de0rldMsDAykug/6y1
 64Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065803; x=1733670603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOnlt+F3jeWmXtP80T/8bMkoX1mFTpy2BWXybos70VE=;
 b=rjO5aQ6Xb51Ar6yEu2RNgqKETK1b2YXFJJCFunmjphMo406SVDxI3oog6GIUJx9578
 2+ZRWHN5VbwXBJj8CCuUIsFw0iUQTZZ92brbhBCCOeZed0l3RzMdVoVOWbbNjcVy9NQ6
 PGprCagdGrb9UW1g7imsUxOKjJJ92K3NGnP8Frjdob4HPN86/a+fULPL6pWi24vYZUMa
 +MSfklkrtjenpPoII2nyds+hX00XvP9IbLTxpuxs6UzIWfcFDy5B0w6pRBp5QtmtIoC3
 vmt2tbTiIfoWPMoz9c6X4lvY884y1nWydvx3GpjZIAOvt13dkzLaj74SCxZsqhdeoJXV
 Zhbg==
X-Gm-Message-State: AOJu0YxiftTMI1vPcU/zxLj7vdS7lXtZvc2za/R8w3gwxEiNBEbYNnsK
 nZXtGkaer5EMiChx6CofxHYfrt1pZS71hnYp9mxQ/PadukQg3pgseIS1JPcZvcdosbBV0bn2HGq
 rdlk=
X-Gm-Gg: ASbGnctO0u+RJrIX4nue32LEv1AqYgEuP3EA29xcCLICSomeIWJeBeqXwOJG1NxoPlC
 P6s7PM+gra9u+otOoqSamcCYLz0V8aRbnyaA6M7jC74JNcFG638oZgKQqSTqOoe4y3c4N4ywmJd
 lk4SHnU5yV9s0j+TOXFFt0WwwV4DIhQg7dt2WGFVZVjKkm/YgT4rVJffq/wZeHfVqIT4is+0IYq
 p4J5Zhc1ssGMWElfN+iwy6z+pN6x+9ADkCpa++BoDJF6uVGK5OydJ+xv3NwYQZUeBJZRycIr1Ph
 Xk8LmtaOwwKul3MJIcTCGXFUkDb41TmsayQ8
X-Google-Smtp-Source: AGHT+IF1PqxrK1ksF9jtfjsmEpkWn3/SrPCGjIJpD8l1U7AZi+CoVZDrV5jONJG5G/pHJc+WHSRs5w==
X-Received: by 2002:a05:6820:2188:b0:5ee:e029:f797 with SMTP id
 006d021491bc7-5f20a24555amr14112031eaf.6.1733065803550; 
 Sun, 01 Dec 2024 07:10:03 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 48/67] target/arm: Convert XTN, SQXTUN, SQXTN,
 UQXTN to decodetree
Date: Sun,  1 Dec 2024 09:05:47 -0600
Message-ID: <20241201150607.12812-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 153 ++++++++++++++++++++-------------
 target/arm/tcg/a64.decode      |   9 ++
 2 files changed, 102 insertions(+), 60 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9b2ff20413..6c44e9d8a1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8925,6 +8925,62 @@ TRANS(CMLE0_s, do_cmop0_d, a, TCG_COND_LE)
 TRANS(CMLT0_s, do_cmop0_d, a, TCG_COND_LT)
 TRANS(CMEQ0_s, do_cmop0_d, a, TCG_COND_EQ)
 
+static bool do_2misc_narrow_scalar(DisasContext *s, arg_rr_e *a,
+                                   ArithOneOp * const fn[3])
+{
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        read_vec_element(s, t, a->rn, 0, a->esz + 1);
+        fn[a->esz](t, t);
+        clear_vec(s, a->rd);
+        write_vec_element(s, t, a->rd, 0, a->esz);
+    }
+    return true;
+}
+
+#define WRAP_ENV(NAME) \
+    static void gen_##NAME(TCGv_i64 d, TCGv_i64 n) \
+    { gen_helper_##NAME(d, tcg_env, n); }
+
+WRAP_ENV(neon_unarrow_sat8)
+WRAP_ENV(neon_unarrow_sat16)
+WRAP_ENV(neon_unarrow_sat32)
+
+static ArithOneOp * const f_scalar_sqxtun[] = {
+    gen_neon_unarrow_sat8,
+    gen_neon_unarrow_sat16,
+    gen_neon_unarrow_sat32,
+};
+TRANS(SQXTUN_s, do_2misc_narrow_scalar, a, f_scalar_sqxtun)
+
+WRAP_ENV(neon_narrow_sat_s8)
+WRAP_ENV(neon_narrow_sat_s16)
+WRAP_ENV(neon_narrow_sat_s32)
+
+static ArithOneOp * const f_scalar_sqxtn[] = {
+    gen_neon_narrow_sat_s8,
+    gen_neon_narrow_sat_s16,
+    gen_neon_narrow_sat_s32,
+};
+TRANS(SQXTN_s, do_2misc_narrow_scalar, a, f_scalar_sqxtn)
+
+WRAP_ENV(neon_narrow_sat_u8)
+WRAP_ENV(neon_narrow_sat_u16)
+WRAP_ENV(neon_narrow_sat_u32)
+
+static ArithOneOp * const f_scalar_uqxtn[] = {
+    gen_neon_narrow_sat_u8,
+    gen_neon_narrow_sat_u16,
+    gen_neon_narrow_sat_u32,
+};
+TRANS(UQXTN_s, do_2misc_narrow_scalar, a, f_scalar_uqxtn)
+
+#undef WRAP_ENV
+
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
     if (!a->q && a->esz == MO_64) {
@@ -8968,6 +9024,37 @@ TRANS(UADDLP_v, do_gvec_fn2_bhs, a, gen_gvec_uaddlp)
 TRANS(SADALP_v, do_gvec_fn2_bhs, a, gen_gvec_sadalp)
 TRANS(UADALP_v, do_gvec_fn2_bhs, a, gen_gvec_uadalp)
 
+static bool do_2misc_narrow_vector(DisasContext *s, arg_qrr_e *a,
+                                   ArithOneOp * const fn[3])
+{
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
+        read_vec_element(s, t0, a->rn, 0, MO_64);
+        read_vec_element(s, t1, a->rn, 1, MO_64);
+        fn[a->esz](t0, t0);
+        fn[a->esz](t1, t1);
+        write_vec_element(s, t0, a->rd, a->q ? 2 : 0, MO_32);
+        write_vec_element(s, t1, a->rd, a->q ? 3 : 1, MO_32);
+        clear_vec_high(s, a->q, a->rd);
+    }
+    return true;
+}
+
+static ArithOneOp * const f_scalar_xtn[] = {
+    gen_helper_neon_narrow_u8,
+    gen_helper_neon_narrow_u16,
+    tcg_gen_ext32u_i64,
+};
+TRANS(XTN, do_2misc_narrow_vector, a, f_scalar_xtn)
+TRANS(SQXTUN_v, do_2misc_narrow_vector, a, f_scalar_sqxtun)
+TRANS(SQXTN_v, do_2misc_narrow_vector, a, f_scalar_sqxtn)
+TRANS(UQXTN_v, do_2misc_narrow_vector, a, f_scalar_uqxtn)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9550,38 +9637,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         tcg_res[pass] = tcg_temp_new_i64();
 
         switch (opcode) {
-        case 0x12: /* XTN, SQXTUN */
-        {
-            static NeonGenOne64OpFn * const xtnfns[3] = {
-                gen_helper_neon_narrow_u8,
-                gen_helper_neon_narrow_u16,
-                tcg_gen_ext32u_i64,
-            };
-            static NeonGenOne64OpEnvFn * const sqxtunfns[3] = {
-                gen_helper_neon_unarrow_sat8,
-                gen_helper_neon_unarrow_sat16,
-                gen_helper_neon_unarrow_sat32,
-            };
-            if (u) {
-                genenvfn = sqxtunfns[size];
-            } else {
-                genfn = xtnfns[size];
-            }
-            break;
-        }
-        case 0x14: /* SQXTN, UQXTN */
-        {
-            static NeonGenOne64OpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_narrow_sat_s8,
-                  gen_helper_neon_narrow_sat_u8 },
-                { gen_helper_neon_narrow_sat_s16,
-                  gen_helper_neon_narrow_sat_u16 },
-                { gen_helper_neon_narrow_sat_s32,
-                  gen_helper_neon_narrow_sat_u32 },
-            };
-            genenvfn = fns[size][u];
-            break;
-        }
         case 0x16: /* FCVTN, FCVTN2 */
             /* 32 bit to 16 bit or 64 bit to 32 bit float conversion */
             if (size == 2) {
@@ -9622,6 +9677,8 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
             }
             break;
         default:
+        case 0x12: /* XTN, SQXTUN */
+        case 0x14: /* SQXTN, UQXTN */
             g_assert_not_reached();
         }
 
@@ -9657,22 +9714,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x12: /* SQXTUN */
-        if (!u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x14: /* SQXTN, UQXTN */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_2misc_narrow(s, true, opcode, u, false, size, rn, rd);
-        return;
     case 0xc ... 0xf:
     case 0x16 ... 0x1d:
     case 0x1f:
@@ -9746,6 +9787,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x9: /* CMEQ, CMLE */
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
+    case 0x12: /* SQXTUN */
+    case 0x14: /* SQXTN, UQXTN */
         unallocated_encoding(s);
         return;
     }
@@ -9943,18 +9986,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
-    case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-
-        handle_2misc_narrow(s, false, opcode, u, is_q, size, rn, rd);
-        return;
     case 0x13: /* SHLL, SHLL2 */
         if (u == 0 || size == 3) {
             unallocated_encoding(s);
@@ -10146,6 +10177,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x9: /* CMEQ, CMLE */
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
+    case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
+    case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 77020bb175..9a01037446 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1642,6 +1642,10 @@ CMEQ0_s         0101 1110 111 00000 10011 0 ..... .....     @rr
 CMLE0_s         0111 1110 111 00000 10011 0 ..... .....     @rr
 CMLT0_s         0101 1110 111 00000 10101 0 ..... .....     @rr
 
+SQXTUN_s        0111 1110 ..1 00001 00101 0 ..... .....     @rr_e
+SQXTN_s         0101 1110 ..1 00001 01001 0 ..... .....     @rr_e
+UQXTN_s         0111 1110 ..1 00001 01001 0 ..... .....     @rr_e
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
@@ -1667,3 +1671,8 @@ SADDLP_v        0.00 1110 ..1 00000 00101 0 ..... .....     @qrr_e
 UADDLP_v        0.10 1110 ..1 00000 00101 0 ..... .....     @qrr_e
 SADALP_v        0.00 1110 ..1 00000 01101 0 ..... .....     @qrr_e
 UADALP_v        0.10 1110 ..1 00000 01101 0 ..... .....     @qrr_e
+
+XTN             0.00 1110 ..1 00001 00101 0 ..... .....     @qrr_e
+SQXTUN_v        0.10 1110 ..1 00001 00101 0 ..... .....     @qrr_e
+SQXTN_v         0.00 1110 ..1 00001 01001 0 ..... .....     @qrr_e
+UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
-- 
2.43.0


