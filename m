Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F68E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2y2-0007Sc-7x; Tue, 10 Dec 2024 11:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xw-0006ek-0S
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:04 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xt-0006bF-1g
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:03 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5401c52000dso2585721e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847599; x=1734452399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UELUc/4Dw3Vx9AqPdOZATxZaSuazTpDkae/a8W/pq2E=;
 b=Zc+cjXMGtZQwegU6JPpaBhS/85CEvo/6tORiZQVEh9ncCu6EgRjqfURe2KVYDOwmzI
 cVVKUaX/Z7XZFLnsCtH1HBQ85JUVyhNOV+zm91MVw83Weds/cYNK4wv2g0AbEu/mckya
 Kbg0XYZbKe3IrR5GY4w0RBFC3Q0FMm7+9wUs99aZGuo66jFUILSOdSEqxhjgt1qhILwt
 M/7lnBmP4diIAV5LWFWar3JCcGYYBGnVXY/o3pOZabnLACSTcsGtIH5CYJuQ3GW2IdhB
 A7QLPzS373Oi4vDbBdodUEdXGmQghZ8hzd3IMpueYpvcgg3I+ynLT3q5mKVVQGOkrNYb
 IsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847599; x=1734452399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UELUc/4Dw3Vx9AqPdOZATxZaSuazTpDkae/a8W/pq2E=;
 b=Je/A4SFLw5zNNVap5CKrjz/KgpiyAGfpF3bVmPwXzRgoR7rtmkQBT6Bmqpvo5Vdyg9
 ZMev7Mi1eL3se/qm9l8gZ0MCLZEcmsNkqLyVJIQ5jY79zfwXhDIE9qOvYiH9YojBz16v
 5EB/LwS7P+eHaA9IExGa0Xte1nNlINEOJpSY2sPmibJZ4IvhJjL3INX8fmKDKxWp1jX6
 DdoHAj0guPlMVUwTP6jAUV56565hGyWXjPyiox3dHmY8qGTZJm/9ooeI66v2E/9gHzRh
 vA9wPW8uiWZcO4iFKl/E+G1PdIa8YUAwXvzOv9mvKNxQIxOrSyf+Zst8jAT2c1oZBdkq
 Hmpg==
X-Gm-Message-State: AOJu0Yyd3YydP4LiYY/y1L+JGF47s4sKXsqly+XjTASy8x+hRkYp5A3s
 SSxx8WGRKu0E2xXVN05xfmJeSwa2kHcN5UBP+mRpGzuVxWo12fFkSl8nQ4llO/GMxwUili/uXww
 RaAAeRpJ+
X-Gm-Gg: ASbGncsXxqKIV8suQYYv8tqc5t5XTzOSmfBk6ki94DwvOIOlSh0TkQLPc+FXAxKxK1d
 garwLqiU2A5ATjI9vMtpks16avk3LvyZEqrrwhuQhd+5vzgJApTr7G+uifmhKUg6nGBTiL7sveQ
 RNot2D8Z/hHj4CX8dV6MV0dwbEknR2FxH0krt+/hcQO36eM8wte4XPGd//VXeHsRB/HWb//Pjus
 ZEc0YGbLsAYYxxaXfkf9EeMPTHW4m+vHqz8XHmzJVROFGH+sO7SMPUrGqI=
X-Google-Smtp-Source: AGHT+IHN3LxLKWX0WsjZV2SoBNrkPwvUauUUT4r2fTWRSxdgTlL+xjpXiXaxl+g9xKIv8eKrdqq6iw==
X-Received: by 2002:a05:6512:3d0e:b0:540:22e0:1f80 with SMTP id
 2adb3069b0e04-54022e02207mr2395540e87.20.1733847599302; 
 Tue, 10 Dec 2024 08:19:59 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 34/69] target/arm: Convert handle_fmov to decodetree
Date: Tue, 10 Dec 2024 10:16:58 -0600
Message-ID: <20241210161733.1830573-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
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

Remove disas_fp_int_conv and disas_data_proc_fp as these
were the last insns decoded by those functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 232 ++++++++++-----------------------
 target/arm/tcg/a64.decode      |  14 ++
 2 files changed, 86 insertions(+), 160 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 152bb4b1b3..7128e4fabe 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8734,175 +8734,87 @@ static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
     return true;
 }
 
-static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
+static bool trans_FMOV_hx(DisasContext *s, arg_rr *a)
 {
-    /* FMOV: gpr to or from float, double, or top half of quad fp reg,
-     * without conversion.
-     */
-
-    if (itof) {
-        TCGv_i64 tcg_rn = cpu_reg(s, rn);
-        TCGv_i64 tmp;
-
-        switch (type) {
-        case 0:
-            /* 32 bit */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_ext32u_i64(tmp, tcg_rn);
-            write_fp_dreg(s, rd, tmp);
-            break;
-        case 1:
-            /* 64 bit */
-            write_fp_dreg(s, rd, tcg_rn);
-            break;
-        case 2:
-            /* 64 bit to top half. */
-            tcg_gen_st_i64(tcg_rn, tcg_env, fp_reg_hi_offset(s, rd));
-            clear_vec_high(s, true, rd);
-            break;
-        case 3:
-            /* 16 bit */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_ext16u_i64(tmp, tcg_rn);
-            write_fp_dreg(s, rd, tmp);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        TCGv_i64 tcg_rd = cpu_reg(s, rd);
-
-        switch (type) {
-        case 0:
-            /* 32 bit */
-            tcg_gen_ld32u_i64(tcg_rd, tcg_env, fp_reg_offset(s, rn, MO_32));
-            break;
-        case 1:
-            /* 64 bit */
-            tcg_gen_ld_i64(tcg_rd, tcg_env, fp_reg_offset(s, rn, MO_64));
-            break;
-        case 2:
-            /* 64 bits from top half */
-            tcg_gen_ld_i64(tcg_rd, tcg_env, fp_reg_hi_offset(s, rn));
-            break;
-        case 3:
-            /* 16 bit */
-            tcg_gen_ld16u_i64(tcg_rd, tcg_env, fp_reg_offset(s, rn, MO_16));
-            break;
-        default:
-            g_assert_not_reached();
-        }
+    if (!dc_isar_feature(aa64_fp16, s)) {
+        return false;
     }
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        tcg_gen_ext16u_i64(tmp, tcg_rn);
+        write_fp_dreg(s, a->rd, tmp);
+    }
+    return true;
 }
 
-/* Floating point <-> integer conversions
- *   31   30  29 28       24 23  22  21 20   19 18 16 15         10 9  5 4  0
- * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
- * | sf | 0 | S | 1 1 1 1 0 | type | 1 | rmode | opc | 0 0 0 0 0 0 | Rn | Rd |
- * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
- */
-static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
+static bool trans_FMOV_sw(DisasContext *s, arg_rr *a)
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 16, 3);
-    int rmode = extract32(insn, 19, 2);
-    int type = extract32(insn, 22, 2);
-    bool sbit = extract32(insn, 29, 1);
-    bool sf = extract32(insn, 31, 1);
-    bool itof = false;
-
-    if (sbit) {
-        goto do_unallocated;
-    }
-
-    switch (opcode) {
-    case 2: /* SCVTF */
-    case 3: /* UCVTF */
-    case 4: /* FCVTAS */
-    case 5: /* FCVTAU */
-    case 0: /* FCVT[NPMZ]S */
-    case 1: /* FCVT[NPMZ]U */
-        goto do_unallocated;
-
-    default:
-        switch (sf << 7 | type << 5 | rmode << 3 | opcode) {
-        case 0b01100110: /* FMOV half <-> 32-bit int */
-        case 0b01100111:
-        case 0b11100110: /* FMOV half <-> 64-bit int */
-        case 0b11100111:
-            if (!dc_isar_feature(aa64_fp16, s)) {
-                goto do_unallocated;
-            }
-            /* fallthru */
-        case 0b00000110: /* FMOV 32-bit */
-        case 0b00000111:
-        case 0b10100110: /* FMOV 64-bit */
-        case 0b10100111:
-        case 0b11001110: /* FMOV top half of 128-bit */
-        case 0b11001111:
-            if (!fp_access_check(s)) {
-                return;
-            }
-            itof = opcode & 1;
-            handle_fmov(s, rd, rn, type, itof);
-            break;
-
-        case 0b00111110: /* FJCVTZS */
-        default:
-        do_unallocated:
-            unallocated_encoding(s);
-            return;
-        }
-        break;
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        tcg_gen_ext32u_i64(tmp, tcg_rn);
+        write_fp_dreg(s, a->rd, tmp);
     }
+    return true;
 }
 
-/* FP-specific subcases of table C3-6 (SIMD and FP data processing)
- *   31  30  29 28     25 24                          0
- * +---+---+---+---------+-----------------------------+
- * |   | 0 |   | 1 1 1 1 |                             |
- * +---+---+---+---------+-----------------------------+
- */
-static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
+static bool trans_FMOV_dx(DisasContext *s, arg_rr *a)
 {
-    if (extract32(insn, 24, 1)) {
-        unallocated_encoding(s); /* in decodetree */
-    } else if (extract32(insn, 21, 1) == 0) {
-        /* Floating point to fixed point conversions */
-        unallocated_encoding(s); /* in decodetree */
-    } else {
-        switch (extract32(insn, 10, 2)) {
-        case 1: /* Floating point conditional compare */
-        case 2: /* Floating point data-processing (2 source) */
-        case 3: /* Floating point conditional select */
-            unallocated_encoding(s); /* in decodetree */
-            break;
-        case 0:
-            switch (ctz32(extract32(insn, 12, 4))) {
-            case 0: /* [15:12] == xxx1 */
-                /* Floating point immediate */
-                unallocated_encoding(s); /* in decodetree */
-                break;
-            case 1: /* [15:12] == xx10 */
-                /* Floating point compare */
-                unallocated_encoding(s); /* in decodetree */
-                break;
-            case 2: /* [15:12] == x100 */
-                /* Floating point data-processing (1 source) */
-                unallocated_encoding(s); /* in decodetree */
-                break;
-            case 3: /* [15:12] == 1000 */
-                unallocated_encoding(s);
-                break;
-            default: /* [15:12] == 0000 */
-                /* Floating point <-> integer conversions */
-                disas_fp_int_conv(s, insn);
-                break;
-            }
-            break;
-        }
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+        write_fp_dreg(s, a->rd, tcg_rn);
     }
+    return true;
+}
+
+static bool trans_FMOV_ux(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+        tcg_gen_st_i64(tcg_rn, tcg_env, fp_reg_hi_offset(s, a->rd));
+        clear_vec_high(s, true, a->rd);
+    }
+    return true;
+}
+
+static bool trans_FMOV_xh(DisasContext *s, arg_rr *a)
+{
+    if (!dc_isar_feature(aa64_fp16, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+        tcg_gen_ld16u_i64(tcg_rd, tcg_env, fp_reg_offset(s, a->rn, MO_16));
+    }
+    return true;
+}
+
+static bool trans_FMOV_ws(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+        tcg_gen_ld32u_i64(tcg_rd, tcg_env, fp_reg_offset(s, a->rn, MO_32));
+    }
+    return true;
+}
+
+static bool trans_FMOV_xd(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+        tcg_gen_ld_i64(tcg_rd, tcg_env, fp_reg_offset(s, a->rn, MO_64));
+    }
+    return true;
+}
+
+static bool trans_FMOV_xu(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+        tcg_gen_ld_i64(tcg_rd, tcg_env, fp_reg_hi_offset(s, a->rn));
+    }
+    return true;
 }
 
 /* Common vector code for handling integer to FP conversion */
@@ -10819,7 +10731,7 @@ static void disas_data_proc_simd(DisasContext *s, uint32_t insn)
 static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
 {
     if (extract32(insn, 28, 1) == 1 && extract32(insn, 30, 1) == 0) {
-        disas_data_proc_fp(s, insn);
+        unallocated_encoding(s); /* in decodetree */
     } else {
         /* SIMD, including crypto */
         disas_data_proc_simd(s, insn);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index cd10961618..5b9f7caa7f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1365,6 +1365,20 @@ FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
 
 FJCVTZS         0 0011110 01 111110 000000 ..... .....  @rr
 
+FMOV_ws         0 0011110 00 100110 000000 ..... .....  @rr
+FMOV_sw         0 0011110 00 100111 000000 ..... .....  @rr
+
+FMOV_xd         1 0011110 01 100110 000000 ..... .....  @rr
+FMOV_dx         1 0011110 01 100111 000000 ..... .....  @rr
+
+# Move to/from upper half of 128-bit
+FMOV_xu         1 0011110 10 101110 000000 ..... .....  @rr
+FMOV_ux         1 0011110 10 101111 000000 ..... .....  @rr
+
+# Half-precision allows both sf=0 and sf=1 with identical results
+FMOV_xh         - 0011110 11 100110 000000 ..... .....  @rr
+FMOV_hx         - 0011110 11 100111 000000 ..... .....  @rr
+
 # Floating-point data processing (1 source)
 
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
-- 
2.43.0


