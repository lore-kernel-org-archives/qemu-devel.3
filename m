Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459E3E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPi9-0002v3-EH; Wed, 11 Dec 2024 11:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhZ-0000pf-VR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:42 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhX-0002G4-D3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:41 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8ece4937fso41959506d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934998; x=1734539798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXw5EgYm/QlB/9tdzLx0waJ4WcicDauHQbm0Q7cCLQY=;
 b=p+Jdv6WDXo5UdVBRptxKocOWwdOFKEZqSBNksq82V/wL8BmCOKhfvA+lyy7MWjnCIL
 3G7ZyIi/BcrC96gi/7wze/1vaBInjtBHuKlVY0MtqmisNGADlP0Y1yHKqjm0aob/WKKL
 LKdpljMe2xu3ti/V1ajYB41SBxv449NZvIInpV6DZ54foGehNSngnICQLuxY5yGwF5hG
 e9HQiDmG/cBUNiuNRQbZ1R8DPF2JlKqEn6PizxK+UBpfLUSRI7mRaBQRof1A154sNx/e
 mPbS5PdR0yCBKqbQG1yE77/snB3HCeE2IBoIIcHETMTvfnmXV31y0NIwaU5qWNmZHeBh
 yDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934998; x=1734539798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXw5EgYm/QlB/9tdzLx0waJ4WcicDauHQbm0Q7cCLQY=;
 b=ZuA6SwOU5JM9BjyZrB1ST5b7hKNScW6yuqagoC7GBTff/VHlwk0D1qdy3XozvyObPM
 APzXtvA+DsZMfRNc+348WQyte7kfN0Qv+v7DqqiYJSB+E2nIYbdYYAwp8r/VMeiqDPBk
 WAahQfqn91ivqAbQkIy8LX4U5G3vARjTrlFN+nWKQnx5gYzSrVFncdkEzAeMFcmlwUNq
 rHPlyv1vPC9xGYLLjLSJDmI1rdopBN7WQhzw2QjE7lD/DVzBmMb5aElf/a7mxXL8z9mX
 NqU+RkTygYQ4YMZoi3Z/9p2QfyQLBwqAZMhQp3dUDeLmyg0KofMtHotUPOVwigPKeq3M
 DHDw==
X-Gm-Message-State: AOJu0YzjQzqlXKi6RGs2NYAx4c0cQpfE1RgYLtH7OceJjE02VJNAssrt
 whbvLJDkuilEqxx60g32Hvz7a6O9wNAapgWFlbJ0YS9BQjPMEWi8ovX1jWrYLBEDWUaGCofC1hA
 WTTEr7oIG
X-Gm-Gg: ASbGncsnUwuXyn95lWZl+DPMhxLN0RV+fUuG5tXY2wcXOabaxk2u1t5SdyvzBI1jvg8
 BiBoAvZ/IHZUmU60LRKqGtPwWgpU6Wpji+6LmHS9DYuxWMGtnNNFMnDA1eC6WRKBQ6ztGsmwtNv
 oh77GiSzLw64ls5UbjOPLQuBfvD6iSfRn0OPWzHCfcJwRFGZbjGA+hZkx0T5O437AM25kT3ZMnX
 dLBicFoTJa2+2SuyNYH0mEJJ9G1opqcHTfq6GA6z/ogf8ox0bIsda1nVxeFYQ==
X-Google-Smtp-Source: AGHT+IEp7B0u23mVo8cNLXU0+b97al5nnji8xRZqGEpXpMnFjH5E7I3sw9rGMoCZhRTBm5OkWk+z/w==
X-Received: by 2002:a05:6214:238e:b0:6d3:fa03:23f1 with SMTP id
 6a1803df08f44-6d934aec6c9mr57285746d6.13.1733934998246; 
 Wed, 11 Dec 2024 08:36:38 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 57/69] target/arm: Convert FCVT* (vector,
 integer) scalar to decodetree
Date: Wed, 11 Dec 2024 10:30:24 -0600
Message-ID: <20241211163036.2297116-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2a.google.com
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

Arm silliness with naming, the scalar insns described
as part of the vector instructions, as separate from
the "regular" scalar insns which output to general registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 133 ++++++++++++++-------------------
 target/arm/tcg/a64.decode      |  30 ++++++++
 2 files changed, 86 insertions(+), 77 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0f924b07dc..71f1d6f778 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8674,6 +8674,16 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
                                  tcg_shift, tcg_fpstatus);
             tcg_gen_extu_i32_i64(tcg_out, tcg_single);
             break;
+        case MO_16 | MO_SIGN:
+            gen_helper_vfp_toshh(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
+        case MO_16:
+            gen_helper_vfp_touhh(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -8717,6 +8727,42 @@ TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, false)
 TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
 TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
 
+/*
+ * FCVT* (vector), scalar version.
+ * Which sounds weird, but really just means output to fp register
+ * instead of output to general register.  Input and output element
+ * size are always equal.
+ */
+static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
+                      ARMFPRounding rmode, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = tcg_temp_new_i64();
+    do_fcvt_scalar(s, a->esz | (is_signed ? MO_SIGN : 0),
+                   a->esz, tcg_int, a->shift, a->rn, rmode);
+
+    clear_vec(s, a->rd);
+    write_vec_element(s, tcg_int, a->rd, 0, a->esz);
+    return true;
+}
+
+TRANS(FCVTNS_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, true)
+TRANS(FCVTNU_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, false)
+TRANS(FCVTPS_f, do_fcvt_f, a, FPROUNDING_POSINF, true)
+TRANS(FCVTPU_f, do_fcvt_f, a, FPROUNDING_POSINF, false)
+TRANS(FCVTMS_f, do_fcvt_f, a, FPROUNDING_NEGINF, true)
+TRANS(FCVTMU_f, do_fcvt_f, a, FPROUNDING_NEGINF, false)
+TRANS(FCVTZS_f, do_fcvt_f, a, FPROUNDING_ZERO, true)
+TRANS(FCVTZU_f, do_fcvt_f, a, FPROUNDING_ZERO, false)
+TRANS(FCVTAS_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, true)
+TRANS(FCVTAU_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, false)
+
 static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
 {
     if (!dc_isar_feature(aa64_jscvt, s)) {
@@ -9776,10 +9822,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 5);
     int size = extract32(insn, 22, 2);
     bool u = extract32(insn, 29, 1);
-    bool is_fcvt = false;
-    int rmode;
-    TCGv_i32 tcg_rmode;
-    TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
     case 0xc ... 0xf:
@@ -9824,15 +9866,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x5b: /* FCVTMU */
         case 0x7a: /* FCVTPU */
         case 0x7b: /* FCVTZU */
-            is_fcvt = true;
-            rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
-            break;
         case 0x1c: /* FCVTAS */
         case 0x5c: /* FCVTAU */
-            /* TIEAWAY doesn't fit in the usual rounding mode encoding */
-            is_fcvt = true;
-            rmode = FPROUNDING_TIEAWAY;
-            break;
         case 0x56: /* FCVTXN, FCVTXN2 */
         default:
             unallocated_encoding(s);
@@ -9851,59 +9886,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         unallocated_encoding(s);
         return;
     }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (is_fcvt) {
-        tcg_fpstatus = fpstatus_ptr(FPST_FPCR);
-        tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
-    } else {
-        tcg_fpstatus = NULL;
-        tcg_rmode = NULL;
-    }
-
-    if (size == 3) {
-        TCGv_i64 tcg_rn = read_fp_dreg(s, rn);
-        TCGv_i64 tcg_rd = tcg_temp_new_i64();
-
-        handle_2misc_64(s, opcode, u, tcg_rd, tcg_rn, tcg_rmode, tcg_fpstatus);
-        write_fp_dreg(s, rd, tcg_rd);
-    } else {
-        TCGv_i32 tcg_rn = tcg_temp_new_i32();
-        TCGv_i32 tcg_rd = tcg_temp_new_i32();
-
-        read_vec_element_i32(s, tcg_rn, rn, 0, size);
-
-        switch (opcode) {
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x1c: /* FCVTAS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-            gen_helper_vfp_tosls(tcg_rd, tcg_rn, tcg_constant_i32(0),
-                                 tcg_fpstatus);
-            break;
-        case 0x5a: /* FCVTNU */
-        case 0x5b: /* FCVTMU */
-        case 0x5c: /* FCVTAU */
-        case 0x7a: /* FCVTPU */
-        case 0x7b: /* FCVTZU */
-            gen_helper_vfp_touls(tcg_rd, tcg_rn, tcg_constant_i32(0),
-                                 tcg_fpstatus);
-            break;
-        default:
-        case 0x7: /* SQABS, SQNEG */
-            g_assert_not_reached();
-        }
-
-        write_fp_sreg(s, rd, tcg_rd);
-    }
-
-    if (is_fcvt) {
-        gen_restore_rmode(tcg_rmode, tcg_fpstatus);
-    }
+    g_assert_not_reached();
 }
 
 /* AdvSIMD shift by immediate
@@ -10391,30 +10374,26 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         TCGv_i32 tcg_res = tcg_temp_new_i32();
 
         switch (fpop) {
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x1c: /* FCVTAS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-            gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
-            break;
         case 0x3d: /* FRECPE */
             gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
         case 0x3f: /* FRECPX */
             gen_helper_frecpx_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
+        case 0x7d: /* FRSQRTE */
+            gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
+            break;
+        default:
+        case 0x1a: /* FCVTNS */
+        case 0x1b: /* FCVTMS */
+        case 0x1c: /* FCVTAS */
+        case 0x3a: /* FCVTPS */
+        case 0x3b: /* FCVTZS */
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x5c: /* FCVTAU */
         case 0x7a: /* FCVTPU */
         case 0x7b: /* FCVTZU */
-            gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
-            break;
-        case 0x7d: /* FRSQRTE */
-            gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
-            break;
-        default:
             g_assert_not_reached();
         }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5e02144f65..f7fcc32adc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1652,6 +1652,36 @@ UQXTN_s         0111 1110 ..1 00001 01001 0 ..... .....     @rr_e
 
 FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
 
+@icvt_h         . ....... .. ...... ...... rn:5 rd:5 \
+                &fcvt sf=0 esz=1 shift=0
+@icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
+                &fcvt sf=0 esz=%esz_sd shift=0
+
+FCVTNS_f        0101 1110 011 11001 10101 0 ..... .....     @icvt_h
+FCVTNS_f        0101 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
+FCVTNU_f        0111 1110 011 11001 10101 0 ..... .....     @icvt_h
+FCVTNU_f        0111 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
+
+FCVTPS_f        0101 1110 111 11001 10101 0 ..... .....     @icvt_h
+FCVTPS_f        0101 1110 1.1 00001 10101 0 ..... .....     @icvt_sd
+FCVTPU_f        0111 1110 111 11001 10101 0 ..... .....     @icvt_h
+FCVTPU_f        0111 1110 1.1 00001 10101 0 ..... .....     @icvt_sd
+
+FCVTMS_f        0101 1110 011 11001 10111 0 ..... .....     @icvt_h
+FCVTMS_f        0101 1110 0.1 00001 10111 0 ..... .....     @icvt_sd
+FCVTMU_f        0111 1110 011 11001 10111 0 ..... .....     @icvt_h
+FCVTMU_f        0111 1110 0.1 00001 10111 0 ..... .....     @icvt_sd
+
+FCVTZS_f        0101 1110 111 11001 10111 0 ..... .....     @icvt_h
+FCVTZS_f        0101 1110 1.1 00001 10111 0 ..... .....     @icvt_sd
+FCVTZU_f        0111 1110 111 11001 10111 0 ..... .....     @icvt_h
+FCVTZU_f        0111 1110 1.1 00001 10111 0 ..... .....     @icvt_sd
+
+FCVTAS_f        0101 1110 011 11001 11001 0 ..... .....     @icvt_h
+FCVTAS_f        0101 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
+FCVTAU_f        0111 1110 011 11001 11001 0 ..... .....     @icvt_h
+FCVTAU_f        0111 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
-- 
2.43.0


