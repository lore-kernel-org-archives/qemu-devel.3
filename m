Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66302E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL33B-0001ZG-FA; Tue, 10 Dec 2024 11:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32Q-0007uM-9l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:44 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32J-0007Wa-HC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:41 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54021daa6cbso1934576e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847863; x=1734452663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2U87xV0PneFZ0LP+4k0VFCAsx+oD0LRoCH5ryjoGxM=;
 b=SapsFqLqGCjwA8GS3OYSyTVAV0dZWvUZPo+0itr2DC/P2crvlZldpu9tKo9KA0SZIk
 QfWAdycuQx42eKq76Imy0q2sT643jaEGbIJl3BQ+jMLtSSUsUGAm1dTTSU2qOu12nYsB
 UtMueasODyvmjTIsoTgjgA0ZPpBXprfcFxc9xQeVtkoSZs4v+lrFyRQXyREseto9/lcz
 C4fpCgbIJVU4IMPfgD15c5miTB455z9G6bfGuAZeedh3zOPWG3UELZlTnR+G7/Q8+k39
 BPjnlplPLTBF6phbjchA+Jcg/0IjrEQY5CszskB7Aku36hn+i0/mKdUUtCJIOYgA9aeY
 I7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847863; x=1734452663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2U87xV0PneFZ0LP+4k0VFCAsx+oD0LRoCH5ryjoGxM=;
 b=JeUsGWLShIyLra8tFjIyX/SheHczmB7pN9oeuQSrKEi61gDjHnz8sM5vhr4izZSgj3
 TeC4wASVjXnP/1at16k+ZsZaTSaUAn9RIA5AG+RHneRf8Fv6kTNZYzuW9wXXIzKEkCmH
 UHnHg/2PcuVrxiX4D8NneT3t1LM/xJO4jnDz1Lnl5on+ZQIt3GmS/zRdYP4cwMyfP9PW
 qvMcaus4CbeVCJNmuq3G/DeSA03p8HHMPw/xuJWEf1XHZtaHWCOW9pjVZ8UF4pCruCsx
 ImOzUhd3MD0JTwMyubSOEuhl4gzTgwIClPIczFaf9C6w+kmuLXzO2Mwgu09JSkr90rXE
 0hgg==
X-Gm-Message-State: AOJu0YxaaCJ/GE6pGfPcuXIMNvOeT3RLEdvBwyos/3DV2vW8dgXbR6Tn
 bdqg807jUr6Th/Wxuc/g23wiubizuxVYgPfu9YvW48XvB0BvAJ9tbCyF8uN4fTsCqj8QOQKMxmX
 vu6bToDM0
X-Gm-Gg: ASbGncvLoAD8lYOmkhN8Vbueq30NwM3b/HSYV3Jydh5kpMlYsJzmFD4jiidGnzNXP7V
 /JjuBcM8cCcb6/DqtmknTC3lh9OSK8GEt+i7EBD2lH6LTp7auixZGUDSakK0NPtHbwCEwd0kgPw
 zrVLSkw5EdsnhWyolqX11LE03smadVezpJNuvec7X4DIhtMOHD/cW6MqVSVgn/a2yJhQO4GJIIa
 kYpI3EtCS9GfGAiNeeVt6lTKxE01M/qjueK5YQS4RGwTLgQNT5hSe4g11Y=
X-Google-Smtp-Source: AGHT+IG1cv8AT8pZplQTjuIab6sB7U3Wu+sF3guuD0rO8IJO/LKfeZBdm4dgcHjWcbzKJksVA1lmwA==
X-Received: by 2002:a05:6512:6cc:b0:53f:22f8:74f with SMTP id
 2adb3069b0e04-54024107643mr2085047e87.44.1733847863413; 
 Tue, 10 Dec 2024 08:24:23 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 54/69] target/arm: Convert FABS, FNEG (vector) to decodetree
Date: Tue, 10 Dec 2024 10:17:18 -0600
Message-ID: <20241210161733.1830573-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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
 target/arm/tcg/translate-a64.c | 54 +++++++++++++++-------------------
 target/arm/tcg/a64.decode      |  7 +++++
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 397420a141..f810e31ccc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9149,6 +9149,20 @@ static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
     return true;
 }
 
+static bool do_fabs_fneg_v(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
+{
+    int check = fp_access_check_vector_hsd(s, a->q, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    gen_gvec_fn2(s, a->q, a->rd, a->rn, fn, a->esz);
+    return true;
+}
+
+TRANS(FABS_v, do_fabs_fneg_v, a, gen_gvec_fabs)
+TRANS(FNEG_v, do_fabs_fneg_v, a, gen_gvec_fneg)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9447,12 +9461,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
      * requires them.
      */
     switch (opcode) {
-    case 0x2f: /* FABS */
-        gen_vfp_absd(tcg_rd, tcg_rn);
-        break;
-    case 0x6f: /* FNEG */
-        gen_vfp_negd(tcg_rd, tcg_rn);
-        break;
     case 0x7f: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
@@ -9497,6 +9505,8 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* CMEQ, CMLE */
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
+    case 0x2f: /* FABS */
+    case 0x6f: /* FNEG */
         g_assert_not_reached();
     }
 }
@@ -9968,13 +9978,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = is_double ? 3 : 2;
         switch (opcode) {
-        case 0x2f: /* FABS */
-        case 0x6f: /* FNEG */
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x1d: /* SCVTF */
         case 0x5d: /* UCVTF */
         {
@@ -10099,6 +10102,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
         case 0x56: /* FCVTXN, FCVTXN2 */
+        case 0x2f: /* FABS */
+        case 0x6f: /* FNEG */
             unallocated_encoding(s);
             return;
         }
@@ -10171,12 +10176,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x2f: /* FABS */
-                    gen_vfp_abss(tcg_res, tcg_op);
-                    break;
-                case 0x6f: /* FNEG */
-                    gen_vfp_negs(tcg_res, tcg_op);
-                    break;
                 case 0x7f: /* FSQRT */
                     gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
                     break;
@@ -10220,6 +10219,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     break;
                 default:
                 case 0x7: /* SQABS, SQNEG */
+                case 0x2f: /* FABS */
+                case 0x6f: /* FNEG */
                     g_assert_not_reached();
                 }
             }
@@ -10362,15 +10363,12 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x7b: /* FCVTZU */
         rmode = FPROUNDING_ZERO;
         break;
-    case 0x2f: /* FABS */
-    case 0x6f: /* FNEG */
-        only_in_vector = true;
-        need_fpst = false;
-        break;
     case 0x7d: /* FRSQRTE */
     case 0x7f: /* FSQRT (vector) */
         break;
     default:
+    case 0x2f: /* FABS */
+    case 0x6f: /* FNEG */
         unallocated_encoding(s);
         return;
     }
@@ -10472,12 +10470,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x59: /* FRINTX */
                 gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x2f: /* FABS */
-                tcg_gen_andi_i32(tcg_res, tcg_op, 0x7fff);
-                break;
-            case 0x6f: /* FNEG */
-                tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
-                break;
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
@@ -10485,6 +10477,8 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             default:
+            case 0x2f: /* FABS */
+            case 0x6f: /* FNEG */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ec0d46a563..f46bd1a715 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -77,6 +77,7 @@
 @qrr_s          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=2
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
+@qrr_sd         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_sd
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1687,3 +1688,9 @@ FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
 
 SHLL_v          0.10 1110 ..1 00001 00111 0 ..... .....     @qrr_e
+
+FABS_v          0.00 1110 111 11000 11111 0 ..... .....     @qrr_h
+FABS_v          0.00 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
+
+FNEG_v          0.10 1110 111 11000 11111 0 ..... .....     @qrr_h
+FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
-- 
2.43.0


