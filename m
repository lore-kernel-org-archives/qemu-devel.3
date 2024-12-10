Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF5AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2y7-0007vD-RG; Tue, 10 Dec 2024 11:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2y2-0007cS-VO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:11 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2y0-0006oL-H6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:10 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so6638474e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847607; x=1734452407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLDdVIEyiQ83QEn5t6ocELqe/4+cBzBoAHlegW6lApE=;
 b=ONaWte9oQ7G6Cskcg1u7otwc5K8lFEosz4OJky4HEcz8FQn7Yi1D9r3sme9QqbBk/S
 p+3e1phJa3tlFZ50s49g+iPeHuQUfOozdWRbeXvgKpzNu91koRni99dDTF0E6hPRRZKg
 T6upWC2VFgvSzTYSHw7Bo+4zCxnGi6v/bGTFYmicdZ1tPl0aMRPcFulyy4tRd/0LxKm2
 1eNZG0qYvurisfqMpBFrNM0/tZEJc96DoBX2sS23G9H3wRBsdme9b2ZCmjboQBfxytQF
 1doot+r4VhLUD0KQQ9msc1Q45KKajjoCkm2rpSSuRqW5pW2HpPC2AazQ1hp07RuOOErV
 XifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847607; x=1734452407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLDdVIEyiQ83QEn5t6ocELqe/4+cBzBoAHlegW6lApE=;
 b=IxAAoseD49LKLNYjNZ2r4xp1+YM3JQ8n8bA89bzzhD8dchTatIwMwRf0C/z+nvYg7l
 6ItzRJOuI165GqB0J7uHDZQZkZzTVm6BUrL6IKfYUkFZPrmSAYx6sTemmagfaS0l/Vhj
 s5ABwMRoMR/CVKrUYhahDMLTFw8LBozUg1HN17MKp4JMlpyFWWwTFrb22Ky8ctfvKTuu
 /bqMDOvVBVbSlg/yRyUGoiZnOLChw/qjw7gbmd3JwnqW/wVTt97COKC9v/MAeLm2dGn8
 ANinAw5WkpasiG97hFJezfN4mYQ1O7zTABR4hqp5HrK5SSG1V7DxErflTZ6oQfkkcmg4
 ZSQw==
X-Gm-Message-State: AOJu0YzNgHJ4EhAlFraHjOwDQ/tqOKfpF+8kB2LT+cjx86YZgp+Dw1PC
 /vfB5SMjQcmnWnEmbvveMV4PVqQ4kmGd7ZwdNCjkwPsL4ANUBIcskmDQRrmW5nA70U+cLmaMr6Q
 1HwA54Rfi
X-Gm-Gg: ASbGncujod68A7pizGd8y0P0hYUuiYbN0/4N1Cw9OwkSiqeksFXpSM8nF/2kshhPyoy
 z9UrMtiUoRYz5z0kekPqNvaoHpcpIUu6CpQI+LWYt3kFfdaZI7QNoXALKhjdnyoSGf6vlD0Ic3K
 jB2DX+LfZ35mu02N3bneKofH2N24cZLJK2emDU+U1MShGLSFLGgDHVNcyQ6Bs+qx+1mgDEY/7Pg
 L6QOj7AQgdVdrnAX5uQMG3snKtHmq/EqnbRn8PbBSQcJjjMwXPYlYXNblE=
X-Google-Smtp-Source: AGHT+IHEMKXJ1L3gykws+pFRtWVZkZj/4Dw3dzvEEIEv+Ne4ifqDUlQYmyhPKAMPA6MDGut42FKCNg==
X-Received: by 2002:a05:6512:3503:b0:540:19d8:148f with SMTP id
 2adb3069b0e04-54019d81704mr4561952e87.32.1733847606746; 
 Tue, 10 Dec 2024 08:20:06 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:20:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 36/69] target/arm: Convert ABS, NEG to decodetree
Date: Tue, 10 Dec 2024 10:17:00 -0600
Message-ID: <20241210161733.1830573-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x136.google.com
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
 target/arm/tcg/translate-a64.c | 46 +++++++++++++++++++++++-----------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c6260a272a..bdbdc466ac 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8889,6 +8889,33 @@ static const ENVScalar1 f_scalar_sqneg = {
 TRANS(SQNEG_s, do_env_scalar1, a, &f_scalar_sqneg)
 TRANS(SQNEG_v, do_env_vector1, a, &f_scalar_sqneg)
 
+static bool do_scalar1_d(DisasContext *s, arg_rr *a, ArithOneOp *f)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        f(t, t);
+        write_fp_dreg(s, a->rd, t);
+    }
+    return true;
+}
+
+TRANS(ABS_s, do_scalar1_d, a, tcg_gen_abs_i64)
+TRANS(NEG_s, do_scalar1_d, a, tcg_gen_neg_i64)
+
+static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_fn2(s, a->q, a->rd, a->rn, fn, a->esz);
+    }
+    return true;
+}
+
+TRANS(ABS_v, do_gvec_fn2, a, tcg_gen_gvec_abs)
+TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9213,13 +9240,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* CMEQ, CMLE */
         cond = u ? TCG_COND_LE : TCG_COND_EQ;
         goto do_cmop;
-    case 0xb: /* ABS, NEG */
-        if (u) {
-            tcg_gen_neg_i64(tcg_rd, tcg_rn);
-        } else {
-            tcg_gen_abs_i64(tcg_rd, tcg_rn);
-        }
-        break;
     case 0x2f: /* FABS */
         gen_vfp_absd(tcg_rd, tcg_rn);
         break;
@@ -9264,6 +9284,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         break;
     default:
     case 0x7: /* SQABS, SQNEG */
+    case 0xb: /* ABS, NEG */
         g_assert_not_reached();
     }
 }
@@ -9614,7 +9635,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         /* fall through */
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
-    case 0xb: /* ABS, NEG */
         if (size != 3) {
             unallocated_encoding(s);
             return;
@@ -9705,6 +9725,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* USQADD / SUQADD */
     case 0x7: /* SQABS / SQNEG */
+    case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
     }
@@ -10103,7 +10124,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         /* fall through */
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
-    case 0xb: /* ABS, NEG */
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
             return;
@@ -10280,6 +10300,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* SUQADD, USQADD */
     case 0x7: /* SQABS, SQNEG */
+    case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
     }
@@ -10324,12 +10345,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
     case 0xb:
-        if (u) { /* ABS, NEG */
-            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_neg, size);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_abs, size);
-        }
-        return;
+        g_assert_not_reached();
     }
 
     if (size == 3) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 17ecdac9db..f112951df7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1632,8 +1632,12 @@ SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_s
 
 SQABS_s         0101 1110 ..1 00000 01111 0 ..... .....     @rr_e
 SQNEG_s         0111 1110 ..1 00000 01111 0 ..... .....     @rr_e
+ABS_s           0101 1110 111 00000 10111 0 ..... .....     @rr
+NEG_s           0111 1110 111 00000 10111 0 ..... .....     @rr
 
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
 SQNEG_v         0.10 1110 ..1 00000 01111 0 ..... .....     @qrr_e
+ABS_v           0.00 1110 ..1 00000 10111 0 ..... .....     @qrr_e
+NEG_v           0.10 1110 ..1 00000 10111 0 ..... .....     @qrr_e
-- 
2.43.0


