Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D98E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2y7-0007tT-RB; Tue, 10 Dec 2024 11:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xz-00076e-8T
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:07 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xw-0006d0-V4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:06 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54021daa6cbso1930375e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847603; x=1734452403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbaNen81XcZUkoDJ8z9fRGUGgulx7bfrXVNgwOgzEP4=;
 b=Fq3hRdZpGTsrfkkHBHNlg/BLRMQe+7pdaFRhva3v11arOAWg5KNbteRszBtKgro6hS
 wdDAAlnayhe6NQZUOMePGB2ke+9uXfYbXTKTnS/H+nyKX01XmRwFZo/3uC/OOSSeLxFg
 BhT+qSn4w+hCYDFUvWVDUp47Vw30X0X7dKuyHA/5QT/q2xUE9Nie4n137WMxlMPAG8zq
 Q8fX+CK5ZT7YqoMX+KV64J7+k7pQmlBVLovLYGJCRpR7xIPEO2dubR2kuFLYvAAhWXu+
 9HB0JbBNRoH9SAYuHhw0QiMOqDLuEJZGXL1hO4w7wKIYt7e0xUtPNF5Iy4cnDcaTYzO8
 HY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847603; x=1734452403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbaNen81XcZUkoDJ8z9fRGUGgulx7bfrXVNgwOgzEP4=;
 b=dKhTBzNKMc++Q0QXMg+zGEUBYxjLr6unwXZCTGUc/bU0dszoi/AH53DX9PCgaA6JLW
 ZN/ZznEjN6xP6bM5L3K6xMV2ccpsYa2WoNcyHkg37Pe4JXuX6sf0jxnVG+o4HGJ71IXb
 WNxD8CHLf7m2lKSA22YYI6gf2Bcavhrdu68uJEJxeoH53+FfbCjRojDuZV1ukAPokTx0
 8ju5gAJipFq+giFJp/+/SVF69738cby+AydL82c6GZu9c4gpqAkPzoDh4cJgwe0OUJkJ
 xMqR2PrvHEc4joIlY1zrw7fiKpJMmbr41fiqxTjcBUufC2xH840zgDXT8scbvwnXed91
 FVaQ==
X-Gm-Message-State: AOJu0YwCnVUw4/HZCGGdUNfzf2vFHM2MzpQ6guj2lDKOjyqENGo1z5lh
 oNIlhzt7WBRpt5Huirj8jtAJWzr+Oz2kMNoYNeo9fwb7/oZnRUSnVFBNeeXoGgO+txIpmfhTTOU
 d8gdx0Yhd
X-Gm-Gg: ASbGncvfymDpXzf5K4hnwP2CeYDmMdYEY8OIFJV4lttIujoQ4bUSY11WUn3R8yp88A6
 uRNdTMj2kjpvCCU7cCOh4Rwu6iH81TStszd4bsiO9izZksk0CQnerNHoJW/wxE5rMy2v6fLzbGk
 szYL7o4jbsDdjGSbTvyn/Gx66s4dr+IQR+k7LbpenBti3S96iUlHG+kKugwGz5wamGIPy2FLLzj
 i7fICqU+UrwRc6fXlw3a+I+WVHzKF2O9b4F7i6A/F5q9+00jOGNdJke53I=
X-Google-Smtp-Source: AGHT+IEzA7Dp1LAZZDlKBjftKRIWpNSm/nG9loYAYWoYWrBTyRGacIDz5y+Q0p5rsffZ2N4gX2SAJA==
X-Received: by 2002:a05:6512:230d:b0:540:20da:c34e with SMTP id
 2adb3069b0e04-540240be1f1mr1429379e87.21.1733847603011; 
 Tue, 10 Dec 2024 08:20:03 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:20:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 35/69] target/arm: Convert SQABS, SQNEG to decodetree
Date: Tue, 10 Dec 2024 10:16:59 -0600
Message-ID: <20241210161733.1830573-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 123 +++++++++++++++++++++------------
 target/arm/tcg/a64.decode      |  11 +++
 2 files changed, 89 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7128e4fabe..c6260a272a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8817,6 +8817,78 @@ static bool trans_FMOV_xu(DisasContext *s, arg_rr *a)
     return true;
 }
 
+typedef struct ENVScalar1 {
+    NeonGenOneOpEnvFn *gen_bhs[3];
+    NeonGenOne64OpEnvFn *gen_d;
+} ENVScalar1;
+
+static bool do_env_scalar1(DisasContext *s, arg_rr_e *a, const ENVScalar1 *f)
+{
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    if (a->esz == MO_64) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        f->gen_d(t, tcg_env, t);
+        write_fp_dreg(s, a->rd, t);
+    } else {
+        TCGv_i32 t = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, t, a->rn, 0, a->esz);
+        f->gen_bhs[a->esz](t, tcg_env, t);
+        write_fp_sreg(s, a->rd, t);
+    }
+    return true;
+}
+
+static bool do_env_vector1(DisasContext *s, arg_qrr_e *a, const ENVScalar1 *f)
+{
+    if (a->esz == MO_64 && !a->q) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    if (a->esz == MO_64) {
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        for (int i = 0; i < 2; ++i) {
+            read_vec_element(s, t, a->rn, i, MO_64);
+            f->gen_d(t, tcg_env, t);
+            write_vec_element(s, t, a->rd, i, MO_64);
+        }
+    } else {
+        TCGv_i32 t = tcg_temp_new_i32();
+        int n = (a->q ? 16 : 8) >> a->esz;
+
+        for (int i = 0; i < n; ++i) {
+            read_vec_element_i32(s, t, a->rn, i, a->esz);
+            f->gen_bhs[a->esz](t, tcg_env, t);
+            write_vec_element_i32(s, t, a->rd, i, a->esz);
+        }
+    }
+    clear_vec_high(s, a->q, a->rd);
+    return true;
+}
+
+static const ENVScalar1 f_scalar_sqabs = {
+    { gen_helper_neon_qabs_s8,
+      gen_helper_neon_qabs_s16,
+      gen_helper_neon_qabs_s32 },
+    gen_helper_neon_qabs_s64,
+};
+TRANS(SQABS_s, do_env_scalar1, a, &f_scalar_sqabs)
+TRANS(SQABS_v, do_env_vector1, a, &f_scalar_sqabs)
+
+static const ENVScalar1 f_scalar_sqneg = {
+    { gen_helper_neon_qneg_s8,
+      gen_helper_neon_qneg_s16,
+      gen_helper_neon_qneg_s32 },
+    gen_helper_neon_qneg_s64,
+};
+TRANS(SQNEG_s, do_env_scalar1, a, &f_scalar_sqneg)
+TRANS(SQNEG_v, do_env_vector1, a, &f_scalar_sqneg)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9129,13 +9201,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
          */
         tcg_gen_not_i64(tcg_rd, tcg_rn);
         break;
-    case 0x7: /* SQABS, SQNEG */
-        if (u) {
-            gen_helper_neon_qneg_s64(tcg_rd, tcg_env, tcg_rn);
-        } else {
-            gen_helper_neon_qabs_s64(tcg_rd, tcg_env, tcg_rn);
-        }
-        break;
     case 0xa: /* CMLT */
         cond = TCG_COND_LT;
     do_cmop:
@@ -9198,6 +9263,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_helper_frint64_d(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     default:
+    case 0x7: /* SQABS, SQNEG */
         g_assert_not_reached();
     }
 }
@@ -9540,8 +9606,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x7: /* SQABS / SQNEG */
-        break;
     case 0xa: /* CMLT */
         if (u) {
             unallocated_encoding(s);
@@ -9640,6 +9704,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     default:
     case 0x3: /* USQADD / SUQADD */
+    case 0x7: /* SQABS / SQNEG */
         unallocated_encoding(s);
         return;
     }
@@ -9669,18 +9734,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         read_vec_element_i32(s, tcg_rn, rn, 0, size);
 
         switch (opcode) {
-        case 0x7: /* SQABS, SQNEG */
-        {
-            NeonGenOneOpEnvFn *genfn;
-            static NeonGenOneOpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_qabs_s8, gen_helper_neon_qneg_s8 },
-                { gen_helper_neon_qabs_s16, gen_helper_neon_qneg_s16 },
-                { gen_helper_neon_qabs_s32, gen_helper_neon_qneg_s32 },
-            };
-            genfn = fns[size][u];
-            genfn(tcg_rd, tcg_env, tcg_rn);
-            break;
-        }
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
         case 0x1c: /* FCVTAS */
@@ -9698,6 +9751,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
                                  tcg_fpstatus);
             break;
         default:
+        case 0x7: /* SQABS, SQNEG */
             g_assert_not_reached();
         }
 
@@ -10055,12 +10109,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             return;
         }
         break;
-    case 0x7: /* SQABS, SQNEG */
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0xc ... 0xf:
     case 0x16 ... 0x1f:
     {
@@ -10231,6 +10279,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
     default:
     case 0x3: /* SUQADD, USQADD */
+    case 0x7: /* SQABS, SQNEG */
         unallocated_encoding(s);
         return;
     }
@@ -10321,13 +10370,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                         tcg_gen_clrsb_i32(tcg_res, tcg_op);
                     }
                     break;
-                case 0x7: /* SQABS, SQNEG */
-                    if (u) {
-                        gen_helper_neon_qneg_s32(tcg_res, tcg_env, tcg_op);
-                    } else {
-                        gen_helper_neon_qabs_s32(tcg_res, tcg_env, tcg_op);
-                    }
-                    break;
                 case 0x2f: /* FABS */
                     gen_vfp_abss(tcg_res, tcg_op);
                     break;
@@ -10376,6 +10418,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_frint64_s(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 default:
+                case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
                 }
             } else {
@@ -10391,17 +10434,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                         gen_helper_neon_cnt_u8(tcg_res, tcg_op);
                     }
                     break;
-                case 0x7: /* SQABS, SQNEG */
-                {
-                    NeonGenOneOpEnvFn *genfn;
-                    static NeonGenOneOpEnvFn * const fns[2][2] = {
-                        { gen_helper_neon_qabs_s8, gen_helper_neon_qneg_s8 },
-                        { gen_helper_neon_qabs_s16, gen_helper_neon_qneg_s16 },
-                    };
-                    genfn = fns[size][u];
-                    genfn(tcg_res, tcg_env, tcg_op);
-                    break;
-                }
                 case 0x4: /* CLS, CLZ */
                     if (u) {
                         if (size == 0) {
@@ -10418,6 +10450,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     }
                     break;
                 default:
+                case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
                 }
             }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5b9f7caa7f..17ecdac9db 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -47,6 +47,7 @@
 @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
 @rr_s           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=2
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
+@rr_e           ........ esz:2 . ..... ...... rn:5 rd:5 &rr_e
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 @rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
 
@@ -1626,3 +1627,13 @@ UQRSHRN_si      0111 11110 .... ... 10011 1 ..... .....     @shri_s
 SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_b
 SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_h
 SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_s
+
+# Advanced SIMD scalar two-register miscellaneous
+
+SQABS_s         0101 1110 ..1 00000 01111 0 ..... .....     @rr_e
+SQNEG_s         0111 1110 ..1 00000 01111 0 ..... .....     @rr_e
+
+# Advanced SIMD two-register miscellaneous
+
+SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
+SQNEG_v         0.10 1110 ..1 00000 01111 0 ..... .....     @qrr_e
-- 
2.43.0


