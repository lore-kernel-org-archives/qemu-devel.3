Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24EDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32v-00012L-6j; Tue, 10 Dec 2024 11:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32N-0007ti-50
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:41 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32G-0007Ws-8v
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:35 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5401c52000dso2590103e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847866; x=1734452666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2MkVYunVkKmUvj6RPjfdhN6vrB0UjSjV1F2stZxQnk=;
 b=lzimNxu+wkyI4KJwFuMYWiVtg0YKRxDmX1nRBkJsGLLy8KnFq8WhJrAyXSu8zNz1to
 skQZ0prioMFVVLBoQsXiK6zVpEKIKOpV/XOruBXfdxVh0TRshoU+Ey+yhWH+1KV1be2d
 SI9dH/dKEfJmaIWp01uNoeT+BAoafBktMqOuC4+PczI/4gNQ+KMR81EtLG3fx+A95i/u
 AKHTMQK4BIe//dJE4RTlYtuZaSNVmVlDPoE9NxHUalTD88PaXrDWO0Djkmj5vnPitnUw
 JqTA1qapfKi1NdgEBE8Fh/UciinBUbx8FEGeaYy9vk62w6XTNavj7ZnDtynB8ZWZmz5D
 WpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847866; x=1734452666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2MkVYunVkKmUvj6RPjfdhN6vrB0UjSjV1F2stZxQnk=;
 b=bTk4X17HpE3x7TgW47tXnchWqc6mUBMhjVcnj2NQlvL21ulin4iqS4q/lQtqMjzyqZ
 wysgzL8vcBWa0FJJHgEhiUySDm0LZaNPSTXrYe/inurq7sZLs/Lc65uqCzYxqTk+fDA0
 PNFb1SeD7Zhy3zIl6uTbuX2UkcMJu8Fh8FnwHrtKo94h+1TA1eyA1uqa5W2rDOyagv8X
 Rmui5Fo5w1FE5LB+NlyLUyD8VZKzBbXD2YAh1wlSN2BCLhXJ6cttRmJEyatU1F8e4AxJ
 En5ANN9GXzZonuAeTzicgg1fFTDKWamW6RQioMs6+lHH5XF5HiSC5xeTEKiJIlSlx+0U
 6J/g==
X-Gm-Message-State: AOJu0YzjXTVq9yBwU6nRsjtwQODLxxiEOsorFcT/5SeWznizVpEP9VUE
 AKA6nCVIyt5INajdzwZKbTvWXbsr/kTlDzseDlCE08tb2pJ6BPOfEBQf4f0+LoByGlXf3ogrSO7
 nfmlDFWGz
X-Gm-Gg: ASbGncu4WGPeHOcLP5kRET2+NzvMrr9iHohPrrijxW0h8fqw+MMr8sDygoPZ4jMQTPK
 ymN1auVXZlLrlESwUG2RJFhhjf1qngxSKgvhwE/P85PF7971bnwAbvAkQog5EILqO2E5hp0Sqw7
 4LinKEzVh1f3CDU81rzSSPKPRblSP7MXVhBR/PyiBCWOV7vSIE3Ft+FnFUVozaDXpkzcXb9u3NM
 A1xTP9h+qKjIotHFeLUsAXCslaDuGm9BbktTHUb2IE0bWQ+IRUKTQU5mmg=
X-Google-Smtp-Source: AGHT+IHwhrBFaqjPfr2e7xn+Nn2Reaju9bQpwVmztCkot7vTfho1uoy8wFx4FVj/xLittdXy6DjfXw==
X-Received: by 2002:a05:6512:124f:b0:540:1dac:c032 with SMTP id
 2adb3069b0e04-5401dacc1bbmr3140318e87.6.1733847866249; 
 Tue, 10 Dec 2024 08:24:26 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 55/69] target/arm: Convert FSQRT (vector) to decodetree
Date: Tue, 10 Dec 2024 10:17:19 -0600
Message-ID: <20241210161733.1830573-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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
 target/arm/tcg/translate-a64.c | 67 +++++++++++++++++++++++++---------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f810e31ccc..287e9338a4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9164,6 +9164,51 @@ static bool do_fabs_fneg_v(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 TRANS(FABS_v, do_fabs_fneg_v, a, gen_gvec_fabs)
 TRANS(FNEG_v, do_fabs_fneg_v, a, gen_gvec_fneg)
 
+static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
+                          const FPScalar1 *f, int rmode)
+{
+    TCGv_i32 tcg_rmode = NULL;
+    TCGv_ptr fpst;
+    int check = fp_access_check_vector_hsd(s, a->q, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    if (rmode >= 0) {
+        tcg_rmode = gen_set_rmode(rmode, fpst);
+    }
+
+    if (a->esz == MO_64) {
+        TCGv_i64 t64 = tcg_temp_new_i64();
+
+        for (int pass = 0; pass < 2; ++pass) {
+            read_vec_element(s, t64, a->rn, pass, MO_64);
+            f->gen_d(t64, t64, fpst);
+            write_vec_element(s, t64, a->rd, pass, MO_64);
+        }
+    } else {
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        void (*gen)(TCGv_i32, TCGv_i32, TCGv_ptr)
+            = (a->esz == MO_16 ? f->gen_h : f->gen_s);
+
+        for (int pass = 0, n = (a->q ? 16 : 8) >> a->esz; pass < n; ++pass) {
+            read_vec_element_i32(s, t32, a->rn, pass, a->esz);
+            gen(t32, t32, fpst);
+            write_vec_element_i32(s, t32, a->rd, pass, a->esz);
+        }
+    }
+    clear_vec_high(s, a->q, a->rd);
+
+    if (rmode >= 0) {
+        gen_restore_rmode(tcg_rmode, fpst);
+    }
+    return true;
+}
+
+TRANS(FSQRT_v, do_fp1_vector, a, &f_scalar_fsqrt, -1)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9461,9 +9506,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
      * requires them.
      */
     switch (opcode) {
-    case 0x7f: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
     case 0x1a: /* FCVTNS */
     case 0x1b: /* FCVTMS */
     case 0x1c: /* FCVTAS */
@@ -9507,6 +9549,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0xb: /* ABS, NEG */
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
+    case 0x7f: /* FSQRT */
         g_assert_not_reached();
     }
 }
@@ -10004,13 +10047,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
-        case 0x7f: /* FSQRT */
-            need_fpstatus = true;
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
         case 0x3a: /* FCVTPS */
@@ -10104,6 +10140,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x56: /* FCVTXN, FCVTXN2 */
         case 0x2f: /* FABS */
         case 0x6f: /* FNEG */
+        case 0x7f: /* FSQRT */
             unallocated_encoding(s);
             return;
         }
@@ -10176,9 +10213,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x7f: /* FSQRT */
-                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
                 case 0x1a: /* FCVTNS */
                 case 0x1b: /* FCVTMS */
                 case 0x1c: /* FCVTAS */
@@ -10221,6 +10255,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 case 0x7: /* SQABS, SQNEG */
                 case 0x2f: /* FABS */
                 case 0x6f: /* FNEG */
+                case 0x7f: /* FSQRT */
                     g_assert_not_reached();
                 }
             }
@@ -10364,11 +10399,11 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         rmode = FPROUNDING_ZERO;
         break;
     case 0x7d: /* FRSQRTE */
-    case 0x7f: /* FSQRT (vector) */
         break;
     default:
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
+    case 0x7f: /* FSQRT (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10473,12 +10508,10 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x7f: /* FSQRT */
-                gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
-                break;
             default:
             case 0x2f: /* FABS */
             case 0x6f: /* FNEG */
+            case 0x7f: /* FSQRT */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f46bd1a715..1e0eb4a748 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1694,3 +1694,6 @@ FABS_v          0.00 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
 
 FNEG_v          0.10 1110 111 11000 11111 0 ..... .....     @qrr_h
 FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
+
+FSQRT_v         0.10 1110 111 11001 11111 0 ..... .....     @qrr_h
+FSQRT_v         0.10 1110 1.1 00001 11111 0 ..... .....     @qrr_sd
-- 
2.43.0


