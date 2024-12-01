Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC0D49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlXJ-0001iU-8z; Sun, 01 Dec 2024 10:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlXE-0001fK-3i
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:56 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlXC-0004QP-4b
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:55 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71d5ecf9556so1339590a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065613; x=1733670413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxGGo7JOGQa+HJl4RW+NqfI5tsWT04nNX0044Pz+15U=;
 b=HsuPUq58/aKsgKi1fmX8Ko3/kTT3eFwvo0CEZ0Eht3mS17mTEzdh987eQd1TULJWj/
 sFEaVfO+BzeoOLrz3CnFnwwapZclfrGKrYqK+wyP25x5ojWN7MkLP/dEkL9evOn4g0P1
 XbMY6CgD3O951RxHrestRWOBrk1b/yI1VoXJYHFxTgCWLQgVPaLAoacOOiTh4irSSLG1
 qibpMC9PK5l1K68nwEkwkVmX6vDQ3N2lcxQOkLpzxuo5TrcayfD8wYpBh33JJw4YU+38
 /njgZ6iu17O3+Jpvm2xrF36rq7eSIRHEbAkVw9MH0RZgA6aHx1y2VGnvG8UPtX7bXPYM
 o5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065613; x=1733670413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxGGo7JOGQa+HJl4RW+NqfI5tsWT04nNX0044Pz+15U=;
 b=hpBkPHyYdLoAAMBJt/8ZFggMbiSq3WKvTy6U6Of+Tj62H14aD2FcAGnNgNH1MmnuJC
 n8jsApBywROpSV5zBcwp+vMOZzXCYlxqRzOcuV/Z3CW6FjxNVRfVynRY6faXKO2K+o/J
 p77o8gTlzrvPNHJ23OIQUkldujaMMaJdP6KaL5NU+lRRme0spMSXDuOlC6u+dZPrn5xs
 gMlGTSHX1FLpp/nLGZqvS5zLAr6dxIwmgZQozeB1RxeWW7kN97pNkyU1R2N4KeCxQUpt
 siVAtaZS/Jy/9WsH+FbeezDL7Jf/PrQ4/sizG+oXUmAWLKZtWnsTjUMpuDeBmyxcZ47w
 GaJg==
X-Gm-Message-State: AOJu0Yz4vGZkU2EJshEVavAkVLmvn3KxblZxc7e7CzJYOhI3QkL/Qj1D
 02H8sarOT0CgMPUlXQG+Zkj2IaUl9Rb0C7jyHhMfeM/O0BVyfofYYfOyWevejBSss2RWezjINe3
 93gg=
X-Gm-Gg: ASbGncuyZi3Als5xMXOJNouqeK8lEuIYFePWmSFaIQPFuIXQSLxCOtUEqanmxneBwa9
 by1Wai2lDik//lFqOcb7UcuknyFujptjXtSHG422p58cxxOtZds0NNjb65/HjaavZkfbfj0+uwg
 AfPnekjO+G6PIStJkXStcco6fMWYb/wNBMKPEYW1MHb3ouOnQ2RPJWMbBk3SEZSG05FvHpGngPn
 3Eb+sQYPb5uZ9yVTVc8MncG2335fngFZ1XWIG4a/RVULVGxxKksjWXOD9v7V5n/MLgugriMqUNC
 5c4rTfsunt3qEK7BgiWActfxdfWe6dTa3yzo
X-Google-Smtp-Source: AGHT+IFLzmcX3BhwXeTczCzcoWt+OThgyLwZbeYIVDSlRzKNpS4rk3/7apnibc6R7AuzsF+im2Utjg==
X-Received: by 2002:a05:6830:3689:b0:718:6cc:b5a2 with SMTP id
 46e09a7af769-71d65cf63b8mr14336574a34.20.1733065612931; 
 Sun, 01 Dec 2024 07:06:52 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 39/67] target/arm: Convert CNT, NOT,
 RBIT (vector) to decodetree
Date: Sun,  1 Dec 2024 09:05:38 -0600
Message-ID: <20241201150607.12812-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 34 ++++++----------------------------
 target/arm/tcg/a64.decode      |  4 ++++
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f96b29e5a9..3d08c6e09b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8919,6 +8919,9 @@ static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 
 TRANS(ABS_v, do_gvec_fn2, a, tcg_gen_gvec_abs)
 TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
+TRANS(NOT_v, do_gvec_fn2, a, tcg_gen_gvec_not)
+TRANS(CNT_v, do_gvec_fn2, a, gen_gvec_cnt)
+TRANS(RBIT_v, do_gvec_fn2, a, gen_gvec_rbit)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -9233,12 +9236,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
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
@@ -9295,6 +9292,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         break;
     default:
     case 0x4: /* CLS, CLZ */
+    case 0x5: /* NOT */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         g_assert_not_reached();
@@ -10076,19 +10074,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10306,6 +10291,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
+    case 0x5: /* CNT, NOT, RBIT */
     case 0x7: /* SQABS, SQNEG */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
@@ -10328,15 +10314,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10355,6 +10332,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
     case 0x4: /* CLZ, CLS */
+    case 0x5: /* CNT, NOT, RBIT */
     case 0xb:
         g_assert_not_reached();
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c3acb5dc37..29f7741bfb 100644
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


