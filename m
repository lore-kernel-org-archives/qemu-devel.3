Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ADDD49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlad-0000N8-91; Sun, 01 Dec 2024 10:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaO-00083L-4k
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:14 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaJ-0005B1-PC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:11 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f1ecd0d9ecso1457214eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065805; x=1733670605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMhtfBuwPRg9Cp8ZBzyqrotyhkW2U1MLrVH4X39MPUc=;
 b=F+9wofSunGGzW/b63lM8IESAjEuCVirl/yejSk57+s3euwcbuVzY2+8Li5Wj0B+r7U
 19frTeee/QDKYW8frsVCXuws7c2PP9eVJkSej0qMVk1zR5v4p02u4b5g/Krom7j3ekSJ
 V5aiku7D+YjmVzc2Jlp1xRO47uPHo2hX8HuU1Sc22S0TeFx7yBn7bzlfCpd0e5IViwkt
 laDbQsFcsktL6nc1CdjaEk+ruEzdiplJBS/5/4r4/3XVBQv1MKdVOpC98EIZLkxQO3R3
 Zg7gZIYp58DLKqCxajniwKvgQDnmYCsShLKz18LdBFHF8MCKdGJMsEgpwA69Yyrmybxf
 jE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065805; x=1733670605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMhtfBuwPRg9Cp8ZBzyqrotyhkW2U1MLrVH4X39MPUc=;
 b=PunjLhDobGisnNGd5CwX+MnyYVrBYCuXOAiq5hcgdD8+QHInrvwwl4YRD5x7KPdc77
 OQ0jT8fBAXTzxKBVD0/BUUtzSWZ/MOD4jlJW0czluACCKXt2/fwTOP7ctnuAmzPM9k75
 4NBs98P8ngQItjawAZskKcQNHuhNbF1ZIXh/t2/zwolUMNkAXwZVw+6j6AQ6+r2xaWkT
 2HuXKSsiltdxGNZiOxKzXAMXdyh6HUpTEg1rUzavJPb8xhBg1hQM2cNgURaR0VUrnRTv
 gWI0zV4c3EpksIhod+Dx0n9kt9xLK3xGZ/2Ds8zWVrn4X1DZikCf99pyjNfD4q65SyNU
 E4jg==
X-Gm-Message-State: AOJu0Yxs9P5Em2gENATx8zYaCfypN8SizM0+kGLABqGPRnba+G70dF+M
 m0vO+TGc9SP/IumSEMk0NbWe8SZBYvkgPSyZScoa27+A70GctW5Dt8zUYSgbGbimebZrjBE2O0z
 lavs=
X-Gm-Gg: ASbGncvy1zmfLsbE52ntE0j/GmqMw8trDndqoAQM4Ht5IDcRNYe8P2xkzrmUrH6/25L
 GGNW8IJM7VK5quO1QHD2x4iPAKuvpbREgGFHHMsIZMB4MRCERn4F5Ee8cV20ESA6/Q4TvgUaWCb
 iH1xYEzpS3zhcI153rHTFkd4A7DM+dshCahhoFYnWq/1HKgTqqOGKckUNMuF0HuKTD7Jb67Okts
 /fd6YGESYyyZ1c+WmpLYdZcvYeIFd2FJjyIdYYKDnHmgGfEPdr1fdB+VaZL6RlkQ68nF7VBdrXt
 u/FQU5rlLhdP04RqbnPUE3z4GSWNskhyIIBV
X-Google-Smtp-Source: AGHT+IHntpjde9rSmlaFZ2WSyzTjGPZOkuRmcq+yktmaTiV9vvWBqBhx3l0o6dgaAV04SGDQNQOf5Q==
X-Received: by 2002:a05:6830:44a2:b0:71d:5484:9385 with SMTP id
 46e09a7af769-71d65c926bdmr16310081a34.7.1733065805656; 
 Sun, 01 Dec 2024 07:10:05 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 50/67] target/arm: Convert FCVTXN to decodetree
Date: Sun,  1 Dec 2024 09:05:49 -0600
Message-ID: <20241201150607.12812-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

Remove handle_2misc_narrow as this was the last insn decoded
by that function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 101 +++++++--------------------------
 target/arm/tcg/a64.decode      |   4 ++
 2 files changed, 24 insertions(+), 81 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8b76c307af..dd46749ac6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8979,6 +8979,24 @@ static ArithOneOp * const f_scalar_uqxtn[] = {
 };
 TRANS(UQXTN_s, do_2misc_narrow_scalar, a, f_scalar_uqxtn)
 
+static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    /*
+     * 64 bit to 32 bit float conversion
+     * with von Neumann rounding (round to odd)
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_fcvtx_f64_to_f32(tmp, n, tcg_env);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_scalar_fcvtxn[] = {
+    NULL,
+    NULL,
+    gen_fcvtxn_sd,
+};
+TRANS(FCVTXN_s, do_2misc_narrow_scalar, a, f_scalar_fcvtxn)
+
 #undef WRAP_ENV
 
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
@@ -9082,6 +9100,7 @@ static ArithOneOp * const f_vector_fcvtn[] = {
     gen_fcvtn_sd,
 };
 TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
+TRANS(FCVTXN_v, do_2misc_narrow_vector, a, f_scalar_fcvtxn)
 
 static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 {
@@ -9651,68 +9670,6 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
     }
 }
 
-static void handle_2misc_narrow(DisasContext *s, bool scalar,
-                                int opcode, bool u, bool is_q,
-                                int size, int rn, int rd)
-{
-    /* Handle 2-reg-misc ops which are narrowing (so each 2*size element
-     * in the source becomes a size element in the destination).
-     */
-    int pass;
-    TCGv_i64 tcg_res[2];
-    int destelt = is_q ? 2 : 0;
-    int passes = scalar ? 1 : 2;
-
-    if (scalar) {
-        tcg_res[1] = tcg_constant_i64(0);
-    }
-
-    for (pass = 0; pass < passes; pass++) {
-        TCGv_i64 tcg_op = tcg_temp_new_i64();
-        NeonGenOne64OpFn *genfn = NULL;
-        NeonGenOne64OpEnvFn *genenvfn = NULL;
-
-        if (scalar) {
-            read_vec_element(s, tcg_op, rn, pass, size + 1);
-        } else {
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-        }
-        tcg_res[pass] = tcg_temp_new_i64();
-
-        switch (opcode) {
-        case 0x56:  /* FCVTXN, FCVTXN2 */
-            {
-                /*
-                 * 64 bit to 32 bit float conversion
-                 * with von Neumann rounding (round to odd)
-                 */
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                assert(size == 2);
-                gen_helper_fcvtx_f64_to_f32(tmp, tcg_op, tcg_env);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            }
-            break;
-        default:
-        case 0x12: /* XTN, SQXTUN */
-        case 0x14: /* SQXTN, UQXTN */
-        case 0x16: /* FCVTN, FCVTN2 */
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            g_assert_not_reached();
-        }
-
-        if (genfn) {
-            genfn(tcg_res[pass], tcg_op);
-        } else if (genenvfn) {
-            genenvfn(tcg_res[pass], tcg_env, tcg_op);
-        }
-    }
-
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, destelt + pass, MO_32);
-    }
-    clear_vec_high(s, is_q, rd);
-}
-
 /* AdvSIMD scalar two reg misc
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
@@ -9784,15 +9741,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
             rmode = FPROUNDING_TIEAWAY;
             break;
         case 0x56: /* FCVTXN, FCVTXN2 */
-            if (size == 2) {
-                unallocated_encoding(s);
-                return;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_narrow(s, true, opcode, u, false, size - 1, rn, rd);
-            return;
         default:
             unallocated_encoding(s);
             return;
@@ -10105,16 +10053,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             handle_2misc_reciprocal(s, opcode, false, u, is_q, size, rn, rd);
             return;
-        case 0x56: /* FCVTXN, FCVTXN2 */
-            if (size == 2) {
-                unallocated_encoding(s);
-                return;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_narrow(s, false, opcode, 0, is_q, size - 1, rn, rd);
-            return;
         case 0x17: /* FCVTL, FCVTL2 */
             if (!fp_access_check(s)) {
                 return;
@@ -10164,6 +10102,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         default:
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
+        case 0x56: /* FCVTXN, FCVTXN2 */
             unallocated_encoding(s);
             return;
         }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1412b99241..bc87dd4a03 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -74,6 +74,7 @@
 
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
+@qrr_s          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=2
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
@@ -1648,6 +1649,8 @@ SQXTUN_s        0111 1110 ..1 00001 00101 0 ..... .....     @rr_e
 SQXTN_s         0101 1110 ..1 00001 01001 0 ..... .....     @rr_e
 UQXTN_s         0111 1110 ..1 00001 01001 0 ..... .....     @rr_e
 
+FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
@@ -1680,4 +1683,5 @@ SQXTN_v         0.00 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 
 FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
+FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
-- 
2.43.0


