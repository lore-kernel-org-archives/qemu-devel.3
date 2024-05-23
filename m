Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F30C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATf-00082P-Jh; Thu, 23 May 2024 11:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATW-0007sp-Hg
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATK-0002TM-MV
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3504f34a086so5185916f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478513; x=1717083313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NN4melZkOea4pQl52tOTY+Fb0MOTQWFFPhL/QJWOtVg=;
 b=lKfX/x8Dhp1+qJaxajHTchbeC+IsD1cSYHXb4Gj+AN73Y2osRuyGEQQJqZycK8NyX8
 wWXoFF29xgVm5U7Rm2JipfD2wMeV+JQIvwUGqeFK2ltglvfCc5AJ/64lqAO7frfPYX08
 kvZa4nGek5zSOxCKOwfjLjbyQ7jl4Tcvg7Mf+9X4ZzPBI47AhQFKF4L7M5sKYQye1cxa
 moMjNlk9WOjppxBhrMFnUQJsXOMKle+bK3sEYxDu6L26pRDbAYo3VkKVrHz1Cq8lCbnr
 4cGUV0SbBne/9Bumb5g5SqVZmwq3yuBKrhsslVm/RHPFznssAqgYk2otekLgrGdztckF
 7R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478513; x=1717083313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NN4melZkOea4pQl52tOTY+Fb0MOTQWFFPhL/QJWOtVg=;
 b=Rwz78paBPYoCXEcdQOx+HgYNSjDZ5LUVslwuc3XJxMgC3joz7B60xb+wcw3f/dfFzo
 zlLNaFZeMTo9UBxMpxvrujiKq0RuKYybOpp3iOxmpLvnapwlwW6DePL3SJlSXrme0K8u
 4B5UNtQ+++ky4PJ+xag+0MD8bQ9Mah26fU038cvRcuuUcz9s/D8zOMgpmJhg0SA25cnK
 LGtYVnPMEoLbIU3+WC10aalxILRu7f+HiX8THAtvkLEEvydzZ3aM9DGdysj+Tq3bQqPN
 cTFsQ4WOXpU6CBaFuAUzLiLp2lSs66k6dDlilYZZPIDkpklZJIeRgVzLHp0GdULmn//B
 Ng4g==
X-Gm-Message-State: AOJu0YxjjIYwivkewowo9BA0ayvIx0ewQTexcW8RytfZcX7eXRdaOSyW
 w6fbRlMo9GmaGVjDEK180GF0tQb0TC+qzJX4J4H9ldZ/2oh7HiViA71VpDtK8jTeRN7QD6311KW
 D
X-Google-Smtp-Source: AGHT+IHtYC/KMp0EwcxhQCVyXTFgelSHmv2UH0ge2CBGHIBZQV4nehnUiqABhurGSsVzDJdIwaGedA==
X-Received: by 2002:a05:6000:1378:b0:354:f4a9:a490 with SMTP id
 ffacd0b85a97d-354f4a9a625mr2715557f8f.58.1716478512791; 
 Thu, 23 May 2024 08:35:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/37] target/arm: Convert Cryptographic AES to decodetree
Date: Thu, 23 May 2024 16:34:39 +0100
Message-Id: <20240523153505.2900433-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Message-id: 20240506010403.6204-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 21 +++++++--
 target/arm/tcg/translate-a64.c | 86 +++++++++++++++-------------------
 2 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0e7656fd158..1de09903dc4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -19,11 +19,17 @@
 # This file is processed by scripts/decodetree.py
 #
 
-&r               rn
-&ri              rd imm
-&rri_sf          rd rn imm sf
-&i               imm
+%rd             0:5
 
+&r              rn
+&ri             rd imm
+&rri_sf         rd rn imm sf
+&i              imm
+&qrr_e          q rd rn esz
+&qrrr_e         q rd rn rm esz
+
+@rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
+@r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
 
 ### Data Processing - Immediate
 
@@ -590,3 +596,10 @@ CPYFE           00 011 0 01100 ..... .... 01 ..... ..... @cpy
 CPYP            00 011 1 01000 ..... .... 01 ..... ..... @cpy
 CPYM            00 011 1 01010 ..... .... 01 ..... ..... @cpy
 CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
+
+### Cryptographic AES
+
+AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
+AESD            01001110 00 10100 00101 10 ..... .....  @r2r_q1e0
+AESMC           01001110 00 10100 00110 10 ..... .....  @rr_q1e0
+AESIMC          01001110 00 10100 00111 10 ..... .....  @rr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 29905fa4707..57a333fe6fc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1313,6 +1313,34 @@ bool sme_enabled_check_with_svcr(DisasContext *s, unsigned req)
     return true;
 }
 
+/*
+ * Expanders for AdvSIMD translation functions.
+ */
+
+static bool do_gvec_op2_ool(DisasContext *s, arg_qrr_e *a, int data,
+                            gen_helper_gvec_2 *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op2_ool(s, a->q, a->rd, a->rn, data, fn);
+    }
+    return true;
+}
+
+static bool do_gvec_op3_ool(DisasContext *s, arg_qrrr_e *a, int data,
+                            gen_helper_gvec_3 *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op3_ool(s, a->q, a->rd, a->rn, a->rm, data, fn);
+    }
+    return true;
+}
+
 /*
  * This utility function is for doing register extension with an
  * optional shift. You will likely want to pass a temporary for the
@@ -4560,6 +4588,15 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
     return true;
 }
 
+/*
+ * Cryptographic AES
+ */
+
+TRANS_FEAT(AESE, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aese)
+TRANS_FEAT(AESD, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aesd)
+TRANS_FEAT(AESMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesmc)
+TRANS_FEAT(AESIMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesimc)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13453,54 +13490,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto AES
- *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
- * +-----------------+------+-----------+--------+-----+------+------+
- * | 0 1 0 0 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +-----------------+------+-----------+--------+-----+------+------+
- */
-static void disas_crypto_aes(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_2 *genfn2 = NULL;
-    gen_helper_gvec_3 *genfn3 = NULL;
-
-    if (!dc_isar_feature(aa64_aes, s) || size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0x4: /* AESE */
-        genfn3 = gen_helper_crypto_aese;
-        break;
-    case 0x6: /* AESMC */
-        genfn2 = gen_helper_crypto_aesmc;
-        break;
-    case 0x5: /* AESD */
-        genfn3 = gen_helper_crypto_aesd;
-        break;
-    case 0x7: /* AESIMC */
-        genfn2 = gen_helper_crypto_aesimc;
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-    if (genfn2) {
-        gen_gvec_op2_ool(s, true, rd, rn, 0, genfn2);
-    } else {
-        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, genfn3);
-    }
-}
-
 /* Crypto three-reg SHA
  *  31             24 23  22  21 20  16  15 14    12 11 10 9    5 4    0
  * +-----------------+------+---+------+---+--------+-----+------+------+
@@ -13910,7 +13899,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x4e280800, 0xff3e0c00, disas_crypto_aes },
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
-- 
2.34.1


