Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34ED49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbZ-0004Gm-N0; Sun, 01 Dec 2024 10:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaQ-00083t-CW
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:17 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaL-0005BY-Ov
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:13 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f1e7639391so1052234eaf.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065807; x=1733670607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jirvMYWLrzfzJcSlhAKw0Jy0R+/a61tPvxbnid6ji/8=;
 b=n6MMzVSEGrmLcayWI1Qr15osQJF/VVYPoxgW3RRSQpJ6kgGcr/4rS8uBMx1rmBWo+a
 U8gXKpI8y9oqF2c6BE1FSiR1BkqASj96pf7gusU0RPFvhbXdkX5lIzmti5wZ1DGK7IIP
 1A+d2GgAw7z+7/8a7pjZUynk9NnoSdGOKalW2I9H4v/s3YM2uLrmT/6EE1YdNWbR0IYK
 R66JPvPTI34B4j0lAvl5Np+rIK5YbcA8lbBbqQMnRAfFKsGrbVuE/cHAW+6mg3EQ7+UJ
 ouCpwF5/wgNdAKL/7Vjl5cR9VZGt6+EkcP1FzLp0qpn8/6fQYpPtoFTL+YpmWBWjs5G2
 7gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065807; x=1733670607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jirvMYWLrzfzJcSlhAKw0Jy0R+/a61tPvxbnid6ji/8=;
 b=JiyPpXpoZ9/A+tj2xUnvQuPHfzZEuMrhf5m18cmBHHcPHJICjtOD8nML24p9NRtgFu
 7xzLGHn/e4JVKPez7eBikgeq6Csl1X986du2CZsR88uAmPmDshJPgqiW7Laz7OR1skLg
 sN2g2Tm3gE+9BT9ihb7O9B1qAl3XN4528VwxsR+m6FSQZl3k4jLjxkkzPNJOEk2n0p9+
 mJFNtqtdnLHc4blWVjT8TDaYh9bziub2Bpz1RWgxLnndGf/7hKCIbZmWIYCI3qFsfsPE
 w2AF7dMT3AB1gQgZ6ttQwOuR94lzqk57zigibnOjg8NkpERotnw58hYczPx2BnnL5Pe5
 7DUA==
X-Gm-Message-State: AOJu0YzzuzfPfgvgZP3lrNw/yNmSCq61Blm4kbSOURHowUtb3FOnUfoa
 QKMnQolSk2WqsD9NiBIPTBAZYsnqaNM1AAfpIokVfoGFtA7/RS22eYQcFazLg6QKz89HYKwS+N1
 umhk=
X-Gm-Gg: ASbGnct4RfcS2czpZiy1qzginI2h9pJIoNiN3J3iefX2neB/GhDuEQrLjNQCfy8r7P9
 16DbppoaocLJUjbuFcoj6j7o8UqCVvBYg0rKnzOYRlRzNVa8nFRE2+Yvzlt8rEH4Qc4zvrImb3J
 CEwg7/qGEfwMzZJh/uedGdVF8ezF7dFcctPKnVLZ2l4xAhQvrNBOoUrQEVe3vv7u+G3fWX+tlfp
 RUYqeumk8jmB2C8ZTmkro1cTq6e9Krrf1hhRte9SaL2jKOJPUue3sUy7xr6uedAFi6ViaQ2DcVa
 7onUYnIi8JHwly/hRHutTRBTZNUwCUcKe2wF
X-Google-Smtp-Source: AGHT+IF8KCuqoaQvi/LjGW1Q4efv6XdiRL0jxRX8pK6NDEBWepv1nQypWqmVqZhZOhptyZ1LDMj4og==
X-Received: by 2002:a4a:ee0f:0:b0:5ee:e2eb:ea57 with SMTP id
 006d021491bc7-5f209fc7ea5mr12761594eaf.0.1733065806814; 
 Sun, 01 Dec 2024 07:10:06 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 51/67] target/arm: Convert SHLL to decodetree
Date: Sun,  1 Dec 2024 09:05:50 -0600
Message-ID: <20241201150607.12812-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 75 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  2 +
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dd46749ac6..613dcdb9a2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9117,6 +9117,43 @@ static ArithOneOp * const f_vector_bfcvtn[] = {
 };
 TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a, f_vector_bfcvtn)
 
+static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
+{
+    static NeonGenWidenFn * const widenfns[3] = {
+        gen_helper_neon_widen_u8,
+        gen_helper_neon_widen_u16,
+        tcg_gen_extu_i32_i64,
+    };
+    NeonGenWidenFn *widenfn;
+    TCGv_i64 tcg_res[2];
+    TCGv_i32 tcg_op;
+    int part, pass;
+
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    tcg_op = tcg_temp_new_i32();
+    widenfn = widenfns[a->esz];
+    part = a->q ? 2 : 0;
+
+    for (pass = 0; pass < 2; pass++) {
+        read_vec_element_i32(s, tcg_op, a->rn, part + pass, MO_32);
+        tcg_res[pass] = tcg_temp_new_i64();
+        widenfn(tcg_res[pass], tcg_op);
+        tcg_gen_shli_i64(tcg_res[pass], tcg_res[pass], 8 << a->esz);
+    }
+
+    for (pass = 0; pass < 2; pass++) {
+        write_vec_element(s, tcg_res[pass], a->rd, pass, MO_64);
+    }
+    return true;
+}
+
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9905,33 +9942,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
     }
 }
 
-static void handle_shll(DisasContext *s, bool is_q, int size, int rn, int rd)
-{
-    /* Implement SHLL and SHLL2 */
-    int pass;
-    int part = is_q ? 2 : 0;
-    TCGv_i64 tcg_res[2];
-
-    for (pass = 0; pass < 2; pass++) {
-        static NeonGenWidenFn * const widenfns[3] = {
-            gen_helper_neon_widen_u8,
-            gen_helper_neon_widen_u16,
-            tcg_gen_extu_i32_i64,
-        };
-        NeonGenWidenFn *widenfn = widenfns[size];
-        TCGv_i32 tcg_op = tcg_temp_new_i32();
-
-        read_vec_element_i32(s, tcg_op, rn, part + pass, MO_32);
-        tcg_res[pass] = tcg_temp_new_i64();
-        widenfn(tcg_res[pass], tcg_op);
-        tcg_gen_shli_i64(tcg_res[pass], tcg_res[pass], 8 << size);
-    }
-
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-    }
-}
-
 /* AdvSIMD two reg misc
  *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
@@ -9952,16 +9962,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x13: /* SHLL, SHLL2 */
-        if (u == 0 || size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_shll(s, is_q, size, rn, rd);
-        return;
     case 0xc ... 0xf:
     case 0x16 ... 0x1f:
     {
@@ -10122,6 +10122,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
+    case 0x13: /* SHLL, SHLL2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         unallocated_encoding(s);
         return;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bc87dd4a03..8f91b9af1a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1685,3 +1685,5 @@ UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
 FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
+
+SHLL_v          0.10 1110 ..1 00001 00111 0 ..... .....     @qrr_e
-- 
2.43.0


