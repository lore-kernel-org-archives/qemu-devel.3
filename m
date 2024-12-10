Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7D1E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32d-0008G9-2J; Tue, 10 Dec 2024 11:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32F-0007t7-DY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:35 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL322-0007Vg-VP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:21 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3003e203acaso29793471fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847857; x=1734452657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzySngICOAtOAYkigRVd8AIybGWb+hn87I8nJlSebK0=;
 b=DThJEViGRV5TG5gz2Zk5oLILRvr6Xx2gSs0yX3X4YRyVM017zuTEIh5ZBB/JnwMU+K
 U9HAC6sMZM+naoTFJsZMSY/zo8IKCxk6hjZZVEPKgmP3/5n5rj0njQ6nSKj1lcXkNvnG
 KWSUk3Dqp74k5GwJsZFvWmYgibEdxebT/bNv41Cno8pNtgu8319IswJ2ljAPV+1W8M/m
 Qh+LT512CDHyIufVBuUfGUxux56BPQKxoINwpfRbOPPU6bopt9cQGQHrK6JINFaB3f/r
 QpOVh4gspFgHQKG0mRmb7S1v4/xOiS5oYUjFq2BcQq23Nu0tpvL+Mj70JQzxGqSSK/5o
 3cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847857; x=1734452657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzySngICOAtOAYkigRVd8AIybGWb+hn87I8nJlSebK0=;
 b=Dy7UBns/Mz+KCEMf57JACkwGb8R5WScv7QZhP5SnjICqnvKgkFnTlaV9kmU4fjN9J/
 0X+0eImNGDiXsCVtIJebhWSuDYpCdTY2EmStOT4r4UpnUxar/0JmuJS1U7E6YsEQyGvi
 oxu0CQqEYCHoPe3VyW1bVinV3RvnE9Rfc85C85AWIPSz+o1LNPwkSPsrCzT4Jprmtgnz
 CKT2nDC8PYbtGX7gM5jb519PS07wBY0WhaTbfwQ/Bylt/nEwGNXUgzH0jYcl4bG7VCBO
 j6MV2aId+yyyz3yWjZiGuiathC/o6UwLTlthLL7g80lknO898FKbeAeUIuE69VOoR6Rj
 ycYg==
X-Gm-Message-State: AOJu0Yzznyb2dK1EMZDKOtfE1vF7/vx7uTf6fr1oBXmco/JBR6TMdRH3
 Qjh6GO8VzoT8rh5/drh/SZ5dvrEVBnU+Mj6IZiLO4yZgvIzDI8O2LQ1buXJk+TpwjGiBYyTWrgf
 gHRz6xWey
X-Gm-Gg: ASbGnctdpn44LWFXhpmDvRtGWgH1nlciH1Shvzw+QRzqqOqGUj5sZ3qiPcsIhumyNG+
 OSjRz+wLDNae0x720Ws9V5hns/HCcd8JuT31oywLQSWZ/wxGW91Dt/uMKaaCzr/9LeB2ed6Wl4o
 CJLSizJYNlrp/6625nLCmGapNN1lytg0LZAjc4GzXRAHYOmnr9x8L38BIrl2u19eDPolIwm/ZxY
 3pxsmfTfh68kaWRBJ6xljnwhtnLzHOjHHvOyOPyv+dQeqDcRsrlFEkkEM8=
X-Google-Smtp-Source: AGHT+IHQY/241HPn3mQ/6gr/YLid5tN6QZAQDcl4bSaTKmsNxGPTAKxCg6TuqaXgNvgGt4+yt01EVQ==
X-Received: by 2002:a05:6512:3d18:b0:53e:2c74:d65a with SMTP id
 2adb3069b0e04-5402410f85amr2088384e87.41.1733847857210; 
 Tue, 10 Dec 2024 08:24:17 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 52/69] target/arm: Convert SHLL to decodetree
Date: Tue, 10 Dec 2024 10:17:16 -0600
Message-ID: <20241210161733.1830573-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22c.google.com
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
 target/arm/tcg/translate-a64.c | 75 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  2 +
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7bbfd64eba..397420a141 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9113,6 +9113,43 @@ static ArithOneOp * const f_vector_bfcvtn[] = {
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
@@ -9901,33 +9938,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
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
@@ -9948,16 +9958,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10118,6 +10118,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
+    case 0x13: /* SHLL, SHLL2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         unallocated_encoding(s);
         return;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d8902dfb22..ec0d46a563 100644
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


