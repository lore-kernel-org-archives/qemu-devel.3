Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFCCE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhB-0006x2-Ou; Wed, 11 Dec 2024 11:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPge-0005cZ-SB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:46 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgb-00021R-VU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:43 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so56943996d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934941; x=1734539741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/iknmh2RxNE48erNxUDBZGPs0IIWypQ3ATvKWQAmcA=;
 b=ddwPu1chCLIeocdORGSCo23y4OcwEEiIeURR2xtE5HTGCYYxQqepLJ2EHc4ueMxusK
 ivbq6j/KJViWdATPVZaQXzqjZ82CiM7ac181scg5wIpoq795+7oOBuXhzmPBGppAesvJ
 NaPzQKdiU0MG/pzf74F7UYPSPdy6wM7Kml7qnC1m8xNgam0QUuakiYgvtpbfrymvVEiW
 Gxo66TasISKklOtxUZcIKjQudt6fktnT7bBj3GKeRRkBNac7VvQEJylERtBN3QNvdvKt
 eTjTvU/7GOAuyoPwWg2gDDkecpRI9QyLM0c4UemyDhbSixQPbNhx3yBrO8k/uE3IMeJR
 rgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934941; x=1734539741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/iknmh2RxNE48erNxUDBZGPs0IIWypQ3ATvKWQAmcA=;
 b=l18SccQ5jbxCVOp50UbSSjxLdm9nzeePlssEuHupl/NRTEK0cIiGrkmArJ5DYLbmzp
 UBCJcyDL/nD/++EeIwzECMpqaF7Yk6RIgErF0bfxcVJPdcHJfPId1TLJ/72gIPJvSw/H
 co48OF6RF/lQoxqex/cozUQuF/L8hYmXdF1P3ogrlQUOsr1eX2Aw1CIwWMwhCAgBdW7G
 SjoZnSsL7aYUzTGGaAKedLqGDvadWDEQrCCAm8r0/79ACP9oWBUJJ7X/mctNoF7xUlib
 2dl2hHP7qBd08tZO2/S32UZ8gbRoGGn/T3zFfKVBFG8V7FqqfStKJ6Xwc175Y7xAYtSa
 jusg==
X-Gm-Message-State: AOJu0YxnbwWxym7MOBgRGt+e4aK9b2kFx+YNVn3F3D/WW3jK4koMqRSx
 MzPJbnGAa+heNG0hcavrw9LLLZuXuAqBjdO87nm8DCwclFPz8VFnRLUpIcMxpBvYSu59dfUToQi
 AqfATKsg+
X-Gm-Gg: ASbGncvgABK33zvAuQe9xugIkPfih7MeGGvI3ug/MT3BIvF1uC9k+nBhdgVAVsLLGsJ
 gLhO48WaSyk22W22xQi40Lan0lb0FOsC8p2I/8ZWqlEaoduGT7HzXKesnNCE32aTilYU9X9ibAS
 FrJ9jOG72fqMATFov+bGP3Z8elbbKQrmtJB9+pV4CaMxfp8ML02+hUMjnP9Myz/qdLy6ZIXR6LK
 E4BblKMsEEPrxlrdLyBU7p1t037JjBSkV2oZUKvKQgjmi72/0eCWyzCbwvdXQ==
X-Google-Smtp-Source: AGHT+IESkr0nEg/G4QlnXdf6Lq6YV/BXBHH57jbds7GkyXQNfl9R47ta1sCsWJ7uuV9kplzt1Df1HA==
X-Received: by 2002:ad4:5d61:0:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6d934b8f869mr59549106d6.30.1733934940557; 
 Wed, 11 Dec 2024 08:35:40 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:35:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 40/69] target/arm: Convert CNT, NOT,
 RBIT (vector) to decodetree
Date: Wed, 11 Dec 2024 10:30:07 -0600
Message-ID: <20241211163036.2297116-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 34 ++++++----------------------------
 target/arm/tcg/a64.decode      |  4 ++++
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e0c061b3c..aff1984a22 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8915,6 +8915,9 @@ static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 
 TRANS(ABS_v, do_gvec_fn2, a, tcg_gen_gvec_abs)
 TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
+TRANS(NOT_v, do_gvec_fn2, a, tcg_gen_gvec_not)
+TRANS(CNT_v, do_gvec_fn2, a, gen_gvec_cnt)
+TRANS(RBIT_v, do_gvec_fn2, a, gen_gvec_rbit)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -9229,12 +9232,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     TCGCond cond;
 
     switch (opcode) {
-    case 0x5: /* NOT */
-        /* This opcode is shared with CNT and RBIT but we have earlier
-         * enforced that size == 3 if and only if this is the NOT insn.
-         */
-        tcg_gen_not_i64(tcg_rd, tcg_rn);
-        break;
     case 0xa: /* CMLT */
         cond = TCG_COND_LT;
     do_cmop:
@@ -9291,6 +9288,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         break;
     default:
     case 0x4: /* CLS, CLZ */
+    case 0x5: /* NOT */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         g_assert_not_reached();
@@ -10072,19 +10070,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x1: /* REV16 */
         handle_rev(s, opcode, u, is_q, size, rn, rd);
         return;
-    case 0x5: /* CNT, NOT, RBIT */
-        if (u && size == 0) {
-            /* NOT */
-            break;
-        } else if (u && size == 1) {
-            /* RBIT */
-            break;
-        } else if (!u && size == 0) {
-            /* CNT */
-            break;
-        }
-        unallocated_encoding(s);
-        return;
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         if (size == 3) {
@@ -10302,6 +10287,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
+    case 0x5: /* CNT, NOT, RBIT */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
@@ -10324,15 +10310,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x5: /* CNT, NOT, RBIT */
-        if (!u) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cnt, 0);
-        } else if (size) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_rbit, 0);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
-        }
-        return;
     case 0x8: /* CMGT, CMGE */
         if (u) {
             gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
@@ -10351,6 +10328,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
     case 0x4: /* CLZ, CLS */
+    case 0x5: /* CNT, NOT, RBIT */
     case 0xb:
         g_assert_not_reached();
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 32355ee633..bac81eec7e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -71,6 +71,7 @@
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
@@ -1643,3 +1644,6 @@ ABS_v           0.00 1110 ..1 00000 10111 0 ..... .....     @qrr_e
 NEG_v           0.10 1110 ..1 00000 10111 0 ..... .....     @qrr_e
 CLS_v           0.00 1110 ..1 00000 01001 0 ..... .....     @qrr_e
 CLZ_v           0.10 1110 ..1 00000 01001 0 ..... .....     @qrr_e
+CNT_v           0.00 1110 001 00000 01011 0 ..... .....     @qrr_b
+NOT_v           0.10 1110 001 00000 01011 0 ..... .....     @qrr_b
+RBIT_v          0.10 1110 011 00000 01011 0 ..... .....     @qrr_b
-- 
2.43.0


