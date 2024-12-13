Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6142DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YI-0000zM-3z; Fri, 13 Dec 2024 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xf-0007eP-2f
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:31 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xd-0001ej-6B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:30 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38637614567so945274f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111207; x=1734716007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r+6irQsu7a7MfQTQOqsZKNWF1gh530qvy8WNteFOOF8=;
 b=qrsYcKs5amSeM4aPSzTAM0SjoaoBl20byve0i64G6Wgs2zsgPGzlaZxmTbruxUNZqF
 I1id+Zra5adtB2K4xKyUJGQq61jmUisMq1ooh/rJQpwD25MLMR1VHIYgbwPhJIym4y/F
 3FYfmc2RRSGhnzvL2B/vKCQsU+e5//GHfXKBWNMNsv81pMte8aH79khU57TLK9/WtzDA
 Ziq2at+zsX/yJ67oL/dyoOJf8TLilgrTFIhutQbenTIDPIdH+m4o+xM/9yO2Aodj8kGV
 Y4zN98kuMKMWfCBVXgJw9xy6bAzofagXQx7s75cFyW25elm1mW9cAxIhVl8pFhwOJisw
 KoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111207; x=1734716007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+6irQsu7a7MfQTQOqsZKNWF1gh530qvy8WNteFOOF8=;
 b=PZHF0rU7VqKRdb7N9qklSTuGmqBuv5eC7XN7Eq2q/Lw5Jo4TflPzpdssslT/IQBNyk
 zniNuef0gcJ2DDeSeptkAIm6PUbQu56Bak9R+/wJRl/6E3VBZ4HyzmTizZ4d0z0K3dK9
 SM2xp/X5pDm3i4pPLXf9XwWc24pKqfTdSMnGr8MEp5jaMvkgrPWzE4Le90go+5YrwHeq
 SOuiBPw2TyCpGfIDYG1BXCU+WSau5sHzjaij8wvfRTntdacVlp9gHDBIsrkkd68IR2BN
 l2WxgqtdJcPdR8ip+BBgp+kOkEysNDZC42OkihtlAWbj39xzq4quZNKk34YE9wS4r7o9
 aOFQ==
X-Gm-Message-State: AOJu0Yy0uLFVqJ9UFUG0W2RuWF3ZlNaPmX4Mo71RghIE5U5rSJOBnAl6
 7gHkF2VuTpTQ1u7zKiAjdiiuS4uO1Q/eZkaW/vVAOvQ3aCGPjn0Ks8sq9BVYunbBB8VB4zyNUyE
 m
X-Gm-Gg: ASbGncuOV35ZfzxLxf9Iu7DAwKfS9EXvWn8ows/1xj0o+g6vWnwKFyQ3fd3tkaAPyUC
 ij2x51Kv+3lXhQmFPs0bJx+RMqCk99lBgogf594ZcD294SIOlk0vjEyhooVW0oFRVc/fYLTsw0A
 taOlNx0Pz1mw5ZQQXBF0enFJ7/mWZwu7VW6dG0fKIpQ+Awsro/SI+/Gh5bi4nhpzTZmet/dze7N
 c6HWo5Jew3GB2js3zC/ZWiTLP+S8wL5dUhDTBpX7UHpLo7yS209OR3McuTJ/g==
X-Google-Smtp-Source: AGHT+IGQfpo7xakPYAwByXEF+kZeq6EphHoaMMwoguJDYN4BLzv/QXVqXwVTlY1kzCqHCEiVpHOqnw==
X-Received: by 2002:a05:6000:471d:b0:385:f271:a22c with SMTP id
 ffacd0b85a97d-3888e0c23c2mr2385639f8f.59.1734111207257; 
 Fri, 13 Dec 2024 09:33:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/85] target/arm: Convert SHLL to decodetree
Date: Fri, 13 Dec 2024 17:31:56 +0000
Message-Id: <20241213173229.3308926-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-53-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 +
 target/arm/tcg/translate-a64.c | 75 +++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d8902dfb226..ec0d46a563c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1685,3 +1685,5 @@ UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
 FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
+
+SHLL_v          0.10 1110 ..1 00001 00111 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1c454a37f41..c5d456de3be 100644
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
-- 
2.34.1


