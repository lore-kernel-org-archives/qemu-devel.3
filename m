Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D22C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUp-0001bZ-W5; Tue, 28 May 2024 10:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUo-0001ag-63
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUl-00073p-He
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-355080e6ff9so771308f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905285; x=1717510085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VyVyKHqgPj/49154pa++4vUGSFOhznrmsFlJvMnj4KY=;
 b=S3ebgitnQEWCAFTCU5LSvtD+3Ii+ZM6XKuI+anIx9MjhMsESPXp9299Q2WSrRjrBRT
 EO2yJ5hACLdObBIdoGDDptmamG+GgovXuf87gCyhT40cxDXvOKbvw92zGOcExMV2HUFK
 P9n4vtUErRMHQPYXcvxCzQxtq0DcIh85saxmDufh9diIBZNmW7dXFldkpMw7cU1AOQK9
 XQRyJwqgpAvC8essKFM3rDNslqVFse565KiB5v0yH1VZwLmQcI0hMiOf6YH6SodEFvp0
 R0+PGAah8MuaMcX6zomdmjcgHmLG7YF0dY7+EKhJnl49+H+0zctcyPNcHLtT7a6e2X6o
 gH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905285; x=1717510085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyVyKHqgPj/49154pa++4vUGSFOhznrmsFlJvMnj4KY=;
 b=roW9arCsvV5b4rKiU8+I6ha58EHMfW7Zq2Hugc24SGGjMbuUagWVXc6wnekMiQ+ukn
 vh0pRXpwaG2W2ww2I7lVjVZ6sZwJ7+Ds13+iyi6YVjLGAwewGy3Om6QMVR7Y0paIFQgv
 nwMzaB4uATb6suEiPUA0ng9bmAJxauWKV8RjlueBqiFTxYteX4F+V8gCWGa8h0cv/LoA
 pdVmRZB6OMr1vhZFgquMs3sXede0Gq3JcqYNK5p0g6jGVhCfVJdaqSEmzLPJkahxPAjw
 0j90zpRac2mhJUfWhG3C1S4pcqRojHAW1eXGq58MBqVl6Bsmhs+qzke/Q+Uobw9eo8V/
 kWCg==
X-Gm-Message-State: AOJu0Yz9KSktCRvOzv+aGIFd6RbZQmoTbzxaWHXpUlnRA/TBZP5KpZMA
 JKLeTvL6zlkMAiUPdwaZyzleHRNa/M3Lh+x1MV6h5YVxRAu0zvmtx9dqe6bIEY4il7rsSv2JF/U
 Y
X-Google-Smtp-Source: AGHT+IFAavNJNmzsZrmgdVpD8ry5p/9HKmtR2TQq3hcFSCpJoQWzTuSKZs5GaofDRZapPfBTPruBJQ==
X-Received: by 2002:a5d:4f04:0:b0:351:c7c7:985f with SMTP id
 ffacd0b85a97d-3552fe19145mr8542101f8f.53.1716905285246; 
 Tue, 28 May 2024 07:08:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/42] target/arm: Convert Cryptographic 3-register SHA to
 decodetree
Date: Tue, 28 May 2024 15:07:27 +0100
Message-Id: <20240528140753.3620597-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-id: 20240524232121.284515-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 11 +++++
 target/arm/tcg/translate-a64.c | 78 +++++-----------------------------
 2 files changed, 21 insertions(+), 68 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1de09903dc4..7590659ee68 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -30,6 +30,7 @@
 
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
+@rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
 
 ### Data Processing - Immediate
 
@@ -603,3 +604,13 @@ AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
 AESD            01001110 00 10100 00101 10 ..... .....  @r2r_q1e0
 AESMC           01001110 00 10100 00110 10 ..... .....  @rr_q1e0
 AESIMC          01001110 00 10100 00111 10 ..... .....  @rr_q1e0
+
+### Cryptographic three-register SHA
+
+SHA1C           0101 1110 000 ..... 000000 ..... .....  @rrr_q1e0
+SHA1P           0101 1110 000 ..... 000100 ..... .....  @rrr_q1e0
+SHA1M           0101 1110 000 ..... 001000 ..... .....  @rrr_q1e0
+SHA1SU0         0101 1110 000 ..... 001100 ..... .....  @rrr_q1e0
+SHA256H         0101 1110 000 ..... 010000 ..... .....  @rrr_q1e0
+SHA256H2        0101 1110 000 ..... 010100 ..... .....  @rrr_q1e0
+SHA256SU1       0101 1110 000 ..... 011000 ..... .....  @rrr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3894db4bee2..5bef39d4e7d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4589,7 +4589,7 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
 }
 
 /*
- * Cryptographic AES
+ * Cryptographic AES, SHA
  */
 
 TRANS_FEAT(AESE, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aese)
@@ -4597,6 +4597,15 @@ TRANS_FEAT(AESD, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aesd)
 TRANS_FEAT(AESMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesmc)
 TRANS_FEAT(AESIMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesimc)
 
+TRANS_FEAT(SHA1C, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1c)
+TRANS_FEAT(SHA1P, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1p)
+TRANS_FEAT(SHA1M, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1m)
+TRANS_FEAT(SHA1SU0, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1su0)
+
+TRANS_FEAT(SHA256H, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h)
+TRANS_FEAT(SHA256H2, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h2)
+TRANS_FEAT(SHA256SU1, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256su1)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13497,72 +13506,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto three-reg SHA
- *  31             24 23  22  21 20  16  15 14    12 11 10 9    5 4    0
- * +-----------------+------+---+------+---+--------+-----+------+------+
- * | 0 1 0 1 1 1 1 0 | size | 0 |  Rm  | 0 | opcode | 0 0 |  Rn  |  Rd  |
- * +-----------------+------+---+------+---+--------+-----+------+------+
- */
-static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 3);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_3 *genfn;
-    bool feature;
-
-    if (size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA1C */
-        genfn = gen_helper_crypto_sha1c;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 1: /* SHA1P */
-        genfn = gen_helper_crypto_sha1p;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 2: /* SHA1M */
-        genfn = gen_helper_crypto_sha1m;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 3: /* SHA1SU0 */
-        genfn = gen_helper_crypto_sha1su0;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 4: /* SHA256H */
-        genfn = gen_helper_crypto_sha256h;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    case 5: /* SHA256H2 */
-        genfn = gen_helper_crypto_sha256h2;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    case 6: /* SHA256SU1 */
-        genfn = gen_helper_crypto_sha256su1;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!feature) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-    gen_gvec_op3_ool(s, true, rd, rn, rm, 0, genfn);
-}
-
 /* Crypto two-reg SHA
  *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----------------+------+-----------+--------+-----+------+------+
@@ -13906,7 +13849,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
-- 
2.34.1


