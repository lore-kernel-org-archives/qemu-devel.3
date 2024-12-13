Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40703E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Zc-0007CR-1Q; Fri, 13 Dec 2024 12:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xm-0007rd-I2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:39 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xk-0001h3-Ov
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:38 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1352034f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111215; x=1734716015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=59ZvNHRjbkXZRNQSQ5QVDZjUuqRFFa7W8p2pL9z93/k=;
 b=LHlbrTei4tFAJmJiwrlX8p+3Qq9kv1Hj4DdZzT9w4toaIW4j16nmp0CsNBrYM9DCqc
 3pI2GgS/F8g62KAxMnZMK8w8gShT3LqeNNtX54i0CpfgxSCBl0oZhnfuBLnU1br09nIw
 PJ6EL/D/bbD3r5VhQflHilK1yd7gl6JvTxCvbAnvw+4GfYQkbCbGT4LibxTA6SSHoPeU
 8il9CaHVtjmFhu+XzqG7PYN8MxFgYM8ovDJJKHPmra7cCEpFm0Y9JNlbF7Pi3bHUsrTA
 MyZCcxLyU27bdm/YBYhxqVU3T1WBkpOFgxpPrMQHJJXBae1yQm83x3A91Cm9YccpZZFO
 ljDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111215; x=1734716015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59ZvNHRjbkXZRNQSQ5QVDZjUuqRFFa7W8p2pL9z93/k=;
 b=nKpGCE+dHyZHNWrdmfhs7R48oSNJZzM9kqUNTkmb7ZUvYlktl+KynPvgK3++NTP2cE
 8YDiIdL3js2tjc71HwL7i6Ah5GHsm8zArCKkmceG/z1sj+CsBn01yegXzMlc6lojQc9F
 MHMFTfC4vNmXWowjAPa54yWhtUpBAZ0xFykWl7i8yQ1xHtwHb0ZwwtykqJV34URfHpe7
 ATI5MLJk+s0g4/FtFGG6FZ12Mp+ZaII+FaZiZHzW6pyGcRVNSacypg+xCxoMdeDQtbDa
 D6qL5aDGbAK/p3Vynv0kOp9aJOjHNoJXqeIhLmIU++b8PHH/s63RuHz0VjXRFu5mm1Cs
 xk2w==
X-Gm-Message-State: AOJu0Yy5vBzpirf3irZ2aQYsfNO6oY5HtiHDnjCh77KXxDtkUAnpyPOY
 eBulNar8etAw2Y/Ohe6SGNb4H/hax4njXQtImkEQhbGfo8PLhodaOmpFYkAvxpAKQrQ0oPJKEcc
 A
X-Gm-Gg: ASbGncs0HO8mBV32kBj7Ggq5v5RwnwZ5Eau8gdh41h7tqPssNmltgvGM2rQ0Ba+J6Ho
 nooljAEowp0S4FRTIwsz/uc+FNTeFk8qVfgvpXghj8ndfAVGDbd92QiiWXISy1TbIS0YiOgaLwS
 XuJvPxEi5YszV+2xrzihlTsyAsRaHEFiCqCTUZ9ua928KNofsUBQNpekUfJqGCqxeVF5MKsW4aS
 hgdpvygaq0q8Hj86MeWY3EqXY75XdubSuhe1a/mnPNuJDhVINSUAxOBKz4V7Q==
X-Google-Smtp-Source: AGHT+IGMf67basY0/fYiokaDkdNF9akZ5WgNMgOXYC/LTvrk3IYhlWyCq1uuJnDAPz8SSuqa7MmAIQ==
X-Received: by 2002:a05:6000:1fad:b0:386:42b1:d7e4 with SMTP id
 ffacd0b85a97d-3878884729bmr6676477f8f.19.1734111215378; 
 Fri, 13 Dec 2024 09:33:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/85] target/arm: Convert [US]CVTF (vector,
 fixed-point) scalar to decodetree
Date: Fri, 13 Dec 2024 17:32:04 +0000
Message-Id: <20241213173229.3308926-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Remove disas_simd_scalar_shift_imm as these were the
last insns decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-61-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 ++++++
 target/arm/tcg/translate-a64.c | 47 ----------------------------------
 2 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 146500d9c4b..30e1834d998 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1699,6 +1699,14 @@ FCVTAU_f        0111 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
 @fcvt_fixed_d   .... .... . 1 ...... ...... rn:5 rd:5       \
                 &fcvt sf=0 esz=3 shift=%fcvt_f_sh_d
 
+SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_h
+SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_s
+SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_d
+
+UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_h
+UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_s
+UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_d
+
 FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_h
 FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_s
 FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_d
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6e9d040ebfb..08f24908a45 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9531,52 +9531,6 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
     gen_restore_rmode(tcg_rmode, tcg_fpstatus);
 }
 
-/* AdvSIMD scalar shift by immediate
- *  31 30  29 28         23 22  19 18  16 15    11  10 9    5 4    0
- * +-----+---+-------------+------+------+--------+---+------+------+
- * | 0 1 | U | 1 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
- * +-----+---+-------------+------+------+--------+---+------+------+
- *
- * This is the scalar version so it works on a fixed sized registers
- */
-static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 5);
-    int immb = extract32(insn, 16, 3);
-    int immh = extract32(insn, 19, 4);
-    bool is_u = extract32(insn, 29, 1);
-
-    if (immh == 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0x1c: /* SCVTF, UCVTF */
-        handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
-                                     opcode, rn, rd);
-        break;
-    default:
-    case 0x00: /* SSHR / USHR */
-    case 0x02: /* SSRA / USRA */
-    case 0x04: /* SRSHR / URSHR */
-    case 0x06: /* SRSRA / URSRA */
-    case 0x08: /* SRI */
-    case 0x0a: /* SHL / SLI */
-    case 0x0c: /* SQSHLU */
-    case 0x0e: /* SQSHL, UQSHL */
-    case 0x10: /* SQSHRUN */
-    case 0x11: /* SQRSHRUN */
-    case 0x12: /* SQSHRN, UQSHRN */
-    case 0x13: /* SQRSHRN, UQRSHRN */
-    case 0x1f: /* FCVTZS, FCVTZU */
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 static void handle_2misc_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
                             TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
@@ -10476,7 +10430,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
-    { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
-- 
2.34.1


