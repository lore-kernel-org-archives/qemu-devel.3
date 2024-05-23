Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2635BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATp-0008Pd-If; Thu, 23 May 2024 11:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATg-00084x-P5
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATZ-0002Tr-KK
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42100fa9dd6so6145015e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478514; x=1717083314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FY7bVObJBW4qu4CTA5HjKUlXl0mzE7SbKvdFK6oEsjo=;
 b=PM6HU4wHOs6UmB6vMQa1SEYyK9EPQbsWh5t18tPn9D5dZl7sY41Lgt1NK5JcOWY8WZ
 9fuTIozkvJ6mtdoJFWlEzh+HDjBrW59Tw8dYz3fUpbROk0srqo4JZgGYrvIf+FXwiMgo
 oWgo5oSXflZjhtqCoFWp6jiC9P9h6palXS7oZNPn9Gkl2otOh4qfB/BqvWJ1tWZi3SXS
 woJmvf1F6l4z46OCYr3w6myAE01DY5/8euta9xxwWZXWOUrY8O5jQE+wUFgLoqFLNzid
 QvFl08OtlqM6kLPaFv2R0XNvSGkMiT2HTXw6Nf1UCroQIerlTBvjtfcv17lwYOqhXIOo
 JD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478514; x=1717083314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FY7bVObJBW4qu4CTA5HjKUlXl0mzE7SbKvdFK6oEsjo=;
 b=sSeRiA+E0PSO7fNSOBo9S8+6TGK53/ndphSQR6Gt/+tlVvMjlonywAxAA2iW7wCRZr
 NEma0IkwI18GpwSEB6spzcyosN9sKYzyQG72JZsmIpluywn+roudhBPbZg/EJlCZMCQp
 /21QVCcyXrGv4YOvDL3Ktp4u1vnLTIXb32PGkcSBB9YOote1h4Le7iEq9goVg20IaWcT
 HLzK4iV/ljbr2xvMkbFw56K8bEHffXg7ZZFcVpP49d8gdy5zdSAaFBUSuW2zISA5FrWq
 VyKbXZYiXwR4yX8BgUhLrVx4Pw2GlXvm64PD03Y7HdJrhvX+MLg81ljpHlsGrGFRdbBS
 Mwrg==
X-Gm-Message-State: AOJu0Yx69brWfIBgNL2iFIH26+8sluAglXJf03dloNYi9ga6y0PCIrAo
 U4oeAOT7tcaiAlIMbRFOaPNJ4EGdAr+Dr2ahYdejZeKwEBhx91+AkIC/N+RtiJ9vhbkONbd33vK
 a
X-Google-Smtp-Source: AGHT+IGnlT7nfggh9yVEOhnjULM658NwP8S3LjcT/XsGSpCxUYHmuynjJu+ykT6+S0IcZF8yGYTs3A==
X-Received: by 2002:a5d:604f:0:b0:34e:81ab:463f with SMTP id
 ffacd0b85a97d-354f7521a72mr2274180f8f.20.1716478513779; 
 Thu, 23 May 2024 08:35:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/37] target/arm: Convert Cryptographic 2-register SHA to
 decodetree
Date: Thu, 23 May 2024 16:34:41 +0100
Message-Id: <20240523153505.2900433-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 54 +++-------------------------------
 2 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7590659ee68..350afabc779 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -614,3 +614,9 @@ SHA1SU0         0101 1110 000 ..... 001100 ..... .....  @rrr_q1e0
 SHA256H         0101 1110 000 ..... 010000 ..... .....  @rrr_q1e0
 SHA256H2        0101 1110 000 ..... 010100 ..... .....  @rrr_q1e0
 SHA256SU1       0101 1110 000 ..... 011000 ..... .....  @rrr_q1e0
+
+### Cryptographic two-register SHA
+
+SHA1H           0101 1110 0010 1000 0000 10 ..... ..... @rr_q1e0
+SHA1SU1         0101 1110 0010 1000 0001 10 ..... ..... @rr_q1e0
+SHA256SU0       0101 1110 0010 1000 0010 10 ..... ..... @rr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9b941451036..11a25158f62 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4606,6 +4606,10 @@ TRANS_FEAT(SHA256H, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256
 TRANS_FEAT(SHA256H2, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h2)
 TRANS_FEAT(SHA256SU1, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256su1)
 
+TRANS_FEAT(SHA1H, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1h)
+TRANS_FEAT(SHA1SU1, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1su1)
+TRANS_FEAT(SHA256SU0, aa64_sha256, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha256su0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13499,55 +13503,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto two-reg SHA
- *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
- * +-----------------+------+-----------+--------+-----+------+------+
- * | 0 1 0 1 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +-----------------+------+-----------+--------+-----+------+------+
- */
-static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_2 *genfn;
-    bool feature;
-
-    if (size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA1H */
-        feature = dc_isar_feature(aa64_sha1, s);
-        genfn = gen_helper_crypto_sha1h;
-        break;
-    case 1: /* SHA1SU1 */
-        feature = dc_isar_feature(aa64_sha1, s);
-        genfn = gen_helper_crypto_sha1su1;
-        break;
-    case 2: /* SHA256SU0 */
-        feature = dc_isar_feature(aa64_sha256, s);
-        genfn = gen_helper_crypto_sha256su0;
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
-    gen_gvec_op2_ool(s, true, rd, rn, 0, genfn);
-}
-
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
@@ -13842,7 +13797,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
-- 
2.34.1


