Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE622C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATk-0008Cl-T3; Thu, 23 May 2024 11:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATi-00086E-2Q
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATZ-0002WI-Ku
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3550134ef25so451813f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478525; x=1717083325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u36BMo1/XthBmBmduugLrz/DtktnPYf3bY6p3WSWcjg=;
 b=esGZPT3K87804CoWKHxhC+jwFWQ1NMxnb/HOgvHYi0cnsOkYX93jhXUUY8AGxqfOjF
 CJyPEzQ44C92kXErHVtsEAKIca8xqYZHplnmQxqeR0dNuaGPbAA7ywVbQrQJpefXndry
 pvyzxJJWhRH51sJTzdJPvcoM4Rv23e2mLGERxe1nahE9fDqyoPbNkblHKMXqLOm/4zDm
 kGHTpnTr8uTK32ZMXxByBqIofv6AIxacSYCeY8dzh6sbzVhR3EqLCnjNVRXW3hIHrUwW
 IHDUYCOQmhxPfgFkYAalxAm92co0X6gzhD0zASaAj7xSzgvPQsJ3IN3kYYtu3RmL+GbL
 uBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478525; x=1717083325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u36BMo1/XthBmBmduugLrz/DtktnPYf3bY6p3WSWcjg=;
 b=AiN3rrV37c15RnUlo7OolYK8/1i1rVNpaxsTfDT9MZLVZrvf9cLO71v1EsiN6Im3fQ
 nLIPdUBlMWGqqFO8bss0gEuOmUFFR96PyFkMhsBpABFPKf8BddNWXooHTwsr4sF4wWRB
 Hne6PbZHoPdi0Ca4eTJJ4AoLXHMgN2TCIaMBAaO1Bx9cRCgeaCbdVIal4F5LG0KPmfHr
 CPKQqA/lk9NudouPHpnDyJAyE1z8sCs103BFC2nq6wRR6xzSXse6I54sUyt/JjYakC7B
 zX5UBnbUUpY9f86rXY0//0AA6KlYGHmL9MJdhnaMm7TBhTMpofxtxFCxwXhRGitjtcWQ
 fCjw==
X-Gm-Message-State: AOJu0Yx2az3cNd970yk7PliT+rtJx2loSrj00lU7/qkaWCmYuRcNmW0q
 zorU0kkVAmW1kIfqtC/mtjTWNIOyCr2HbocwS5JgT6XVSXlbPA4ETw83Fcm+620xFwamGc+8QN1
 u
X-Google-Smtp-Source: AGHT+IHr1e4eeSHgx7/0JB1ABUI4x225Radq7LcPBX/P2FIFhKTcIDdUMdouPv6eX/cUJTyZX4zywg==
X-Received: by 2002:a5d:500d:0:b0:354:fc1a:239b with SMTP id
 ffacd0b85a97d-354fc1a3b14mr1230435f8f.56.1716478525678; 
 Thu, 23 May 2024 08:35:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/37] target/arm: Convert disas_simd_3same_logic to decodetree
Date: Thu, 23 May 2024 16:35:05 +0100
Message-Id: <20240523153505.2900433-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

This includes AND, ORR, EOR, BIC, ORN, BSF, BIT, BIF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-30-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 10 +++++
 target/arm/tcg/translate-a64.c | 68 ++++++++++------------------------
 2 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7e993ed345f..f48adef5bba 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -55,6 +55,7 @@
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
 @qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
 @qrrr_e         . q:1 ...... esz:2 . rm:5 ...... rn:5 rd:5  &qrrr_e
@@ -847,6 +848,15 @@ SMINP_v         0.00 1110 ..1 ..... 10101 1 ..... ..... @qrrr_e
 UMAXP_v         0.10 1110 ..1 ..... 10100 1 ..... ..... @qrrr_e
 UMINP_v         0.10 1110 ..1 ..... 10101 1 ..... ..... @qrrr_e
 
+AND_v           0.00 1110 001 ..... 00011 1 ..... ..... @qrrr_b
+BIC_v           0.00 1110 011 ..... 00011 1 ..... ..... @qrrr_b
+ORR_v           0.00 1110 101 ..... 00011 1 ..... ..... @qrrr_b
+ORN_v           0.00 1110 111 ..... 00011 1 ..... ..... @qrrr_b
+EOR_v           0.10 1110 001 ..... 00011 1 ..... ..... @qrrr_b
+BSL_v           0.10 1110 011 ..... 00011 1 ..... ..... @qrrr_b
+BIT_v           0.10 1110 101 ..... 00011 1 ..... ..... @qrrr_b
+BIF_v           0.10 1110 111 ..... 00011 1 ..... ..... @qrrr_b
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 11afa5c4f6a..6680b7b2f23 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5280,6 +5280,24 @@ TRANS(SMINP_v, do_gvec_fn3_no64, a, gen_gvec_sminp)
 TRANS(UMAXP_v, do_gvec_fn3_no64, a, gen_gvec_umaxp)
 TRANS(UMINP_v, do_gvec_fn3_no64, a, gen_gvec_uminp)
 
+TRANS(AND_v, do_gvec_fn3, a, tcg_gen_gvec_and)
+TRANS(BIC_v, do_gvec_fn3, a, tcg_gen_gvec_andc)
+TRANS(ORR_v, do_gvec_fn3, a, tcg_gen_gvec_or)
+TRANS(ORN_v, do_gvec_fn3, a, tcg_gen_gvec_orc)
+TRANS(EOR_v, do_gvec_fn3, a, tcg_gen_gvec_xor)
+
+static bool do_bitsel(DisasContext *s, bool is_q, int d, int a, int b, int c)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_fn4(s, is_q, d, a, b, c, tcg_gen_gvec_bitsel, 0);
+    }
+    return true;
+}
+
+TRANS(BSL_v, do_bitsel, a->q, a->rd, a->rd, a->rn, a->rm)
+TRANS(BIT_v, do_bitsel, a->q, a->rd, a->rm, a->rn, a->rd)
+TRANS(BIF_v, do_bitsel, a->q, a->rd, a->rm, a->rd, a->rn)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10894,52 +10912,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Logic op (opcode == 3) subgroup of C3.6.16. */
-static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 22, 2);
-    bool is_u = extract32(insn, 29, 1);
-    bool is_q = extract32(insn, 30, 1);
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (size + 4 * is_u) {
-    case 0: /* AND */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_and, 0);
-        return;
-    case 1: /* BIC */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_andc, 0);
-        return;
-    case 2: /* ORR */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
-        return;
-    case 3: /* ORN */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_orc, 0);
-        return;
-    case 4: /* EOR */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_xor, 0);
-        return;
-
-    case 5: /* BSL bitwise select */
-        gen_gvec_fn4(s, is_q, rd, rd, rn, rm, tcg_gen_gvec_bitsel, 0);
-        return;
-    case 6: /* BIT, bitwise insert if true */
-        gen_gvec_fn4(s, is_q, rd, rm, rn, rd, tcg_gen_gvec_bitsel, 0);
-        return;
-    case 7: /* BIF, bitwise insert if false */
-        gen_gvec_fn4(s, is_q, rd, rm, rd, rn, tcg_gen_gvec_bitsel, 0);
-        return;
-
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
@@ -11205,12 +11177,10 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 11, 5);
 
     switch (opcode) {
-    case 0x3: /* logic ops */
-        disas_simd_3same_logic(s, insn);
-        break;
     default:
         disas_simd_3same_int(s, insn);
         break;
+    case 0x3: /* logic ops */
     case 0x14: /* SMAXP, UMAXP */
     case 0x15: /* SMINP, UMINP */
     case 0x17: /* ADDP */
-- 
2.34.1


