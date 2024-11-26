Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22D3D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvQE-0007vk-Ds; Tue, 26 Nov 2024 08:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQB-0007uo-6d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:04 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQ6-0003Y9-Sj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43494a20379so24195785e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626957; x=1733231757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dn3u5hvx4ZY/sHn5P2fZV7LoRqZ/UcBOOwFKeqFk5wk=;
 b=T+WPKfuWCI5AX7HEwSjVWrY5qDHVNuvjCI99KWf1cfvW3tFqNx5TXf3vyhhH/Th+KR
 JY9nUKA58iq2qTdonAd8SsJ2aaYEiYeZUyLJaoxxdyKAOXCH/hnkaeWDc/344p6NTHMZ
 Ke1ju+vOEGam2qpQ06zUBpMvu5zz5ueJsNYjjuxQK5s84fZZhAVpsjmn9zvWoNgyj8pu
 IG1PvLy5xDQOBkfflYessaLJSuRkm/x/wuerFyOJrzaykH9yDGCmPn/GbOY33INlEpma
 c+BZ1z1ZTOtjnIwgJdd0WOHTUpWnFHMeaq8WNuG2qMX+1Bv9Dvu7kHP82zyiTsDQ2tZ5
 c9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626957; x=1733231757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dn3u5hvx4ZY/sHn5P2fZV7LoRqZ/UcBOOwFKeqFk5wk=;
 b=WqMO7cpxycTjfaSSYzIEIwnc5cS/0EUmGPplgJxmsUt1VZfe5qPkHMHXT4B5qmbd7b
 uVqP0ubY3r1jjxzlVH6X4Cdt+NDdfCrLLXKz5fQF/JJUz2OPuNSFaz8MF5cEehhXj063
 mmjmVInxV5G/0uyR3/p44Uv99jI6q6OsWHXgha4BXI7SeTaRCiHoYJ+PpVNbI1mQP3Ov
 D5ZPRFeHjxCWSsYg38lFNWoJnSQMmuk+Qr6j3S88O4C1fNY5nUMi86vRNGyabQcRWnbW
 mHYPP1D/LaIk4ZIC2JGq43+XFXEQPL7+ocfgzJXnV6n8ZYe/jpU8FrkM5uGqr/RjGeAB
 yOQA==
X-Gm-Message-State: AOJu0YzLNp+VRmG4B3+SO1kydAn8v4YDSm2xJAROMI/nbSaew5dk9/FG
 h4wcX1BjfGvNhL7mNbsQIO8E3Y1nqlCGkU4EHgRbLWt9sZdbaqDVT9QCNf/Pmx7aS2Nfy3BxOOv
 J
X-Gm-Gg: ASbGncseMnqGY25YdcBSc2cnO22m3CriTY7YonyCCmb1VMoA13FCufLTDnP/yO+BUFY
 n/+diruxYnmmW3+otKXxvH/F+N+FYZPXcwHK+IikKw3M67WbrC/LwSUJBuVcRtWOeo3WbcCjYn2
 W5y4AVFtioQ3Rt1Wn3q9HVBg2rpG/bwYqSSAF4XfqzAXnUlCiWLu1D5DeekFwXwIE1sPoq0WWLS
 vjcdeEALKSSUmcSUHQ5ELPi9wkpn9Jp0302MnrWm5ZZReZpqLSlTtF4BYn5ZChvkV5busvY
X-Google-Smtp-Source: AGHT+IH0JaWdv6Tx4juuUcigWC6/Gkha+yGAROHfAEkhsey3PWnNVBd/wqHqCoLzca2kJyvsXKXZtA==
X-Received: by 2002:a05:600c:34cb:b0:434:a59c:43c6 with SMTP id
 5b1f17b1804b1-434a59c47bdmr23077335e9.26.1732626955979; 
 Tue, 26 Nov 2024 05:15:55 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4642b8dsm229684175e9.41.2024.11.26.05.15.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:15:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 01/13] target/mips: Rename gen_load_gpr() -> gen_load_gpr_tl()
Date: Tue, 26 Nov 2024 14:15:33 +0100
Message-ID: <20241126131546.66145-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

MIPS gen_load_gpr() takes a target-specific TCGv argument.
Rename it as gen_load_gpr_tl() to clarify, like other TCG
core helpers.

Mechanical change doing:

  $ sed -i -e 's/gen_load_gpr/gen_load_gpr_tl/' \
    $(git grep -l gen_load_gpr)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h               |   2 +-
 target/mips/tcg/lcsr_translate.c          |   8 +-
 target/mips/tcg/loong_translate.c         |  20 +--
 target/mips/tcg/msa_translate.c           |   2 +-
 target/mips/tcg/mxu_translate.c           |  48 ++---
 target/mips/tcg/octeon_translate.c        |  22 +--
 target/mips/tcg/translate.c               | 206 +++++++++++-----------
 target/mips/tcg/translate_addr_const.c    |   8 +-
 target/mips/tcg/tx79_translate.c          |  26 +--
 target/mips/tcg/vr54xx_translate.c        |   4 +-
 target/mips/tcg/micromips_translate.c.inc |  14 +-
 target/mips/tcg/mips16e_translate.c.inc   |  12 +-
 target/mips/tcg/nanomips_translate.c.inc  | 120 ++++++-------
 13 files changed, 246 insertions(+), 246 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d1838..f1aa706a357 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -155,7 +155,7 @@ void check_cop1x(DisasContext *ctx);
 void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
 void gen_move_low32(TCGv ret, TCGv_i64 arg);
 void gen_move_high32(TCGv ret, TCGv_i64 arg);
-void gen_load_gpr(TCGv t, int reg);
+void gen_load_gpr_tl(TCGv t, int reg);
 void gen_store_gpr(TCGv t, int reg);
 #if defined(TARGET_MIPS64)
 void gen_load_gpr_hi(TCGv_i64 t, int reg);
diff --git a/target/mips/tcg/lcsr_translate.c b/target/mips/tcg/lcsr_translate.c
index 352b0f43282..193b211049c 100644
--- a/target/mips/tcg/lcsr_translate.c
+++ b/target/mips/tcg/lcsr_translate.c
@@ -21,7 +21,7 @@ static bool trans_CPUCFG(DisasContext *ctx, arg_CPUCFG *a)
     TCGv dest = tcg_temp_new();
     TCGv src1 = tcg_temp_new();
 
-    gen_load_gpr(src1, a->rs);
+    gen_load_gpr_tl(src1, a->rs);
     gen_helper_lcsr_cpucfg(dest, tcg_env, src1);
     gen_store_gpr(dest, a->rd);
 
@@ -36,7 +36,7 @@ static bool gen_rdcsr(DisasContext *ctx, arg_r *a,
     TCGv src1 = tcg_temp_new();
 
     check_cp0_enabled(ctx);
-    gen_load_gpr(src1, a->rs);
+    gen_load_gpr_tl(src1, a->rs);
     func(dest, tcg_env, src1);
     gen_store_gpr(dest, a->rd);
 
@@ -50,8 +50,8 @@ static bool gen_wrcsr(DisasContext *ctx, arg_r *a,
     TCGv addr = tcg_temp_new();
 
     check_cp0_enabled(ctx);
-    gen_load_gpr(addr, a->rs);
-    gen_load_gpr(val, a->rd);
+    gen_load_gpr_tl(addr, a->rs);
+    gen_load_gpr_tl(val, a->rd);
     func(tcg_env, addr, val);
 
     return true;
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index 7d74cc34f8a..f527069cfb7 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -42,8 +42,8 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
     l2 = gen_new_label();
     l3 = gen_new_label();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     if (!is_double) {
         tcg_gen_ext32s_tl(t0, t0);
@@ -95,8 +95,8 @@ static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
     l1 = gen_new_label();
     l2 = gen_new_label();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     if (!is_double) {
         tcg_gen_ext32u_tl(t0, t0);
@@ -143,8 +143,8 @@ static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
     l2 = gen_new_label();
     l3 = gen_new_label();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     if (!is_double) {
         tcg_gen_ext32u_tl(t0, t0);
@@ -192,8 +192,8 @@ static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
     l1 = gen_new_label();
     l2 = gen_new_label();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     if (!is_double) {
         tcg_gen_ext32u_tl(t0, t0);
@@ -235,8 +235,8 @@ static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
     if (!is_double) {
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 75cf80a20ed..6f6eaab93aa 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -536,7 +536,7 @@ static bool trans_CTCMSA(DisasContext *ctx, arg_msa_elm *a)
 
     telm = tcg_temp_new();
 
-    gen_load_gpr(telm, a->ws);
+    gen_load_gpr_tl(telm, a->ws);
     gen_helper_msa_ctcmsa(tcg_env, telm, tcg_constant_i32(a->wd));
 
     return true;
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 35ebb0397da..002447a10d7 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -679,7 +679,7 @@ static void gen_mxu_s32i2m(DisasContext *ctx)
     XRa = extract32(ctx->opcode, 6, 5);
     Rb = extract32(ctx->opcode, 16, 5);
 
-    gen_load_gpr(t0, Rb);
+    gen_load_gpr_tl(t0, Rb);
     if (XRa <= 15) {
         gen_store_mxu_gpr(t0, XRa);
     } else if (XRa == 16) {
@@ -728,7 +728,7 @@ static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
     optn3 = extract32(ctx->opcode, 18, 3);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_gpr(t0, Rb);
+    gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, (int8_t)s8);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
@@ -813,7 +813,7 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
         return;
     }
 
-    gen_load_gpr(t0, Rb);
+    gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, (int8_t)s8);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
@@ -862,7 +862,7 @@ static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
     optn2 = extract32(ctx->opcode,  19, 2);
     Rb    = extract32(ctx->opcode,  21, 5);
 
-    gen_load_gpr(t0, Rb);
+    gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, s10);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
@@ -921,7 +921,7 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
         return;
     }
 
-    gen_load_gpr(t0, Rb);
+    gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, s10);
     if (postmodify) {
         gen_store_gpr(t0, Rb);
@@ -968,8 +968,8 @@ static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
         tcg_gen_movi_tl(t0, 0);
         tcg_gen_movi_tl(t1, 0);
     } else {
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t0, rs);
+        gen_load_gpr_tl(t1, rt);
 
         if (mulu) {
             tcg_gen_mulu2_tl(t0, t1, t0, t1);
@@ -1528,7 +1528,7 @@ static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
     s12 = sextract32(ctx->opcode, 10, 10);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_gpr(t0, Rb);
+    gen_load_gpr_tl(t0, Rb);
     tcg_gen_movi_tl(t1, s12 * 4);
     tcg_gen_add_tl(t0, t0, t1);
 
@@ -1563,7 +1563,7 @@ static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
     s12 = sextract32(ctx->opcode, 10, 10);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_gpr(t0, Rb);
+    gen_load_gpr_tl(t0, Rb);
     tcg_gen_movi_tl(t1, s12 * 4);
     tcg_gen_add_tl(t0, t0, t1);
 
@@ -1599,8 +1599,8 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
     Rc = extract32(ctx->opcode, 16, 5);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_gpr(t0, Rb);
-    gen_load_gpr(t1, Rc);
+    gen_load_gpr_tl(t0, Rb);
+    gen_load_gpr_tl(t1, Rc);
     tcg_gen_shli_tl(t1, t1, strd2);
     tcg_gen_add_tl(t0, t0, t1);
 
@@ -1637,8 +1637,8 @@ static void gen_mxu_lxx(DisasContext *ctx, uint32_t strd2, MemOp mop)
     Rc = extract32(ctx->opcode, 16, 5);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_gpr(t0, Rb);
-    gen_load_gpr(t1, Rc);
+    gen_load_gpr_tl(t0, Rb);
+    gen_load_gpr_tl(t1, Rc);
     tcg_gen_shli_tl(t1, t1, strd2);
     tcg_gen_add_tl(t0, t0, t1);
 
@@ -1668,8 +1668,8 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
     Rc = extract32(ctx->opcode, 16, 5);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_gpr(t0, Rb);
-    gen_load_gpr(t1, Rc);
+    gen_load_gpr_tl(t0, Rb);
+    gen_load_gpr_tl(t1, Rc);
     tcg_gen_shli_tl(t1, t1, strd2);
     tcg_gen_add_tl(t0, t0, t1);
 
@@ -1906,7 +1906,7 @@ static void gen_mxu_d32sxxv(DisasContext *ctx, bool right, bool arithmetic)
 
     gen_load_mxu_gpr(t0, XRa);
     gen_load_mxu_gpr(t1, XRd);
-    gen_load_gpr(t2, rs);
+    gen_load_gpr_tl(t2, rs);
     tcg_gen_andi_tl(t2, t2, 0x0f);
 
     if (right) {
@@ -1954,7 +1954,7 @@ static void gen_mxu_d32sarl(DisasContext *ctx, bool sarw)
             /* Make SFT4 from rb field */
             tcg_gen_movi_tl(t2, rb >> 1);
         } else {
-            gen_load_gpr(t2, rb);
+            gen_load_gpr_tl(t2, rb);
             tcg_gen_andi_tl(t2, t2, 0x0f);
         }
         gen_load_mxu_gpr(t0, XRb);
@@ -2060,7 +2060,7 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
 
     gen_load_mxu_gpr(t0, XRa);
     gen_load_mxu_gpr(t2, XRd);
-    gen_load_gpr(t5, rs);
+    gen_load_gpr_tl(t5, rs);
     tcg_gen_andi_tl(t5, t5, 0x0f);
 
 
@@ -3659,7 +3659,7 @@ static void gen_mxu_s32extr(DisasContext *ctx)
 
         gen_load_mxu_gpr(t0, XRd);
         gen_load_mxu_gpr(t1, XRa);
-        gen_load_gpr(t2, rs);
+        gen_load_gpr_tl(t2, rs);
         tcg_gen_andi_tl(t2, t2, 0x1f);
         tcg_gen_subfi_tl(t2, 32, t2);
         tcg_gen_brcondi_tl(TCG_COND_GE, t2, bits5, l_xra_only);
@@ -3709,8 +3709,8 @@ static void gen_mxu_s32extrv(DisasContext *ctx)
     /* {tmp} = {XRa:XRd} >> (64 - rs - rt) */
     gen_load_mxu_gpr(t0, XRd);
     gen_load_mxu_gpr(t1, XRa);
-    gen_load_gpr(t2, rs);
-    gen_load_gpr(t4, rt);
+    gen_load_gpr_tl(t2, rs);
+    gen_load_gpr_tl(t4, rt);
     tcg_gen_brcondi_tl(TCG_COND_EQ, t4, 0, l_zero);
     tcg_gen_andi_tl(t2, t2, 0x1f);
     tcg_gen_subfi_tl(t2, 32, t2);
@@ -4303,7 +4303,7 @@ static void gen_mxu_S32ALN(DisasContext *ctx)
 
         gen_load_mxu_gpr(t0, XRb);
         gen_load_mxu_gpr(t1, XRc);
-        gen_load_gpr(t2, rs);
+        gen_load_gpr_tl(t2, rs);
         tcg_gen_andi_tl(t2, t2, 0x07);
 
         /* do nothing for undefined cases */
@@ -4364,8 +4364,8 @@ static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
         TCGv_i64 t2 = tcg_temp_new_i64();
         TCGv_i64 t3 = tcg_temp_new_i64();
 
-        gen_load_gpr(t0, Rb);
-        gen_load_gpr(t1, Rc);
+        gen_load_gpr_tl(t0, Rb);
+        gen_load_gpr_tl(t1, Rc);
 
         if (uns) {
             tcg_gen_extu_tl_i64(t2, t0);
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e25c4cbaa06..6b0dbf946d8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -26,7 +26,7 @@ static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 
     /* Load needed operands */
     TCGv t0 = tcg_temp_new();
-    gen_load_gpr(t0, a->rs);
+    gen_load_gpr_tl(t0, a->rs);
 
     p = tcg_constant_tl(1ULL << a->p);
     if (a->set) {
@@ -52,8 +52,8 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
-    gen_load_gpr(t0, a->rs);
-    gen_load_gpr(t1, a->rt);
+    gen_load_gpr_tl(t0, a->rs);
+    gen_load_gpr_tl(t1, a->rt);
 
     tcg_gen_add_tl(t0, t0, t1);
     tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
@@ -71,8 +71,8 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
-    gen_load_gpr(t0, a->rs);
-    gen_load_gpr(t1, a->rt);
+    gen_load_gpr_tl(t0, a->rs);
+    gen_load_gpr_tl(t1, a->rt);
 
     tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
     return true;
@@ -88,7 +88,7 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
     }
 
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, a->rs);
+    gen_load_gpr_tl(t0, a->rs);
     tcg_gen_sextract_tl(t0, t0, a->p, a->lenm1 + 1);
     gen_store_gpr(t0, a->rt);
     return true;
@@ -104,7 +104,7 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
     }
 
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, a->rs);
+    gen_load_gpr_tl(t0, a->rs);
     tcg_gen_deposit_z_tl(t0, t0, a->p, a->lenm1 + 1);
     gen_store_gpr(t0, a->rt);
     return true;
@@ -120,7 +120,7 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
     }
 
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, a->rs);
+    gen_load_gpr_tl(t0, a->rs);
     if (!a->dw) {
         tcg_gen_andi_i64(t0, t0, 0xffffffff);
     }
@@ -141,8 +141,8 @@ static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, a->rs);
-    gen_load_gpr(t1, a->rt);
+    gen_load_gpr_tl(t0, a->rs);
+    gen_load_gpr_tl(t1, a->rt);
 
     if (a->ne) {
         tcg_gen_setcond_tl(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
@@ -163,7 +163,7 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
 
     t0 = tcg_temp_new();
 
-    gen_load_gpr(t0, a->rs);
+    gen_load_gpr_tl(t0, a->rs);
 
     /* Sign-extend to 64 bit value */
     target_ulong imm = a->imm;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index de7045874dd..13fbe5d378f 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1188,7 +1188,7 @@ static const char regnames_LO[][4] = {
 };
 
 /* General purpose registers moves. */
-void gen_load_gpr(TCGv t, int reg)
+void gen_load_gpr_tl(TCGv t, int reg)
 {
     assert(reg >= 0 && reg <= ARRAY_SIZE(cpu_gpr));
     if (reg == 0) {
@@ -1256,7 +1256,7 @@ static inline void gen_store_srsgpr(int from, int to)
         TCGv_i32 t2 = tcg_temp_new_i32();
         TCGv_ptr addr = tcg_temp_new_ptr();
 
-        gen_load_gpr(t0, from);
+        gen_load_gpr_tl(t0, from);
         tcg_gen_ld_i32(t2, tcg_env, offsetof(CPUMIPSState, CP0_SRSCtl));
         tcg_gen_shri_i32(t2, t2, CP0SRSCtl_PSS);
         tcg_gen_andi_i32(t2, t2, 0xf);
@@ -1949,7 +1949,7 @@ void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset)
     if (base == 0) {
         tcg_gen_movi_tl(addr, offset);
     } else if (offset == 0) {
-        gen_load_gpr(addr, base);
+        gen_load_gpr_tl(addr, base);
     } else {
         tcg_gen_movi_tl(addr, offset);
         gen_op_addr_add(ctx, addr, cpu_gpr[base], addr);
@@ -2063,13 +2063,13 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LDL:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         gen_lxl(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UQ);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LDR:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UQ);
         gen_store_gpr(t1, rt);
         break;
@@ -2129,7 +2129,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         /* fall through */
     case OPC_LWL:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         gen_lxl(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
@@ -2139,7 +2139,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         /* fall through */
     case OPC_LWR:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
@@ -2164,7 +2164,7 @@ static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
     int mem_idx = ctx->mem_idx;
 
     gen_base_offset_addr(ctx, t0, base, offset);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t1, rt);
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_SD:
@@ -2233,7 +2233,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
     gen_set_label(l1);
     /* generate cmpxchg */
     val = tcg_temp_new();
-    gen_load_gpr(val, rt);
+    gen_load_gpr_tl(val, rt);
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval, val,
                               eva ? MIPS_HFLAG_UM : ctx->mem_idx, tcg_mo);
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_llval);
@@ -2332,7 +2332,7 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
             TCGv t2 = tcg_temp_new();
             TCGLabel *l1 = gen_new_label();
 
-            gen_load_gpr(t1, rs);
+            gen_load_gpr_tl(t1, rs);
             tcg_gen_addi_tl(t0, t1, uimm);
             tcg_gen_ext32s_tl(t0, t0);
 
@@ -2363,7 +2363,7 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
             TCGv t2 = tcg_temp_new();
             TCGLabel *l1 = gen_new_label();
 
-            gen_load_gpr(t1, rs);
+            gen_load_gpr_tl(t1, rs);
             tcg_gen_addi_tl(t0, t1, uimm);
 
             tcg_gen_xori_tl(t1, t1, ~uimm);
@@ -2447,7 +2447,7 @@ static void gen_slt_imm(DisasContext *ctx, uint32_t opc,
         return;
     }
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
+    gen_load_gpr_tl(t0, rs);
     switch (opc) {
     case OPC_SLTI:
         tcg_gen_setcondi_tl(TCG_COND_LT, cpu_gpr[rt], t0, uimm);
@@ -2471,7 +2471,7 @@ static void gen_shift_imm(DisasContext *ctx, uint32_t opc,
     }
 
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
+    gen_load_gpr_tl(t0, rs);
     switch (opc) {
     case OPC_SLL:
         tcg_gen_shli_tl(t0, t0, uimm);
@@ -2553,8 +2553,8 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
             TCGv t2 = tcg_temp_new();
             TCGLabel *l1 = gen_new_label();
 
-            gen_load_gpr(t1, rs);
-            gen_load_gpr(t2, rt);
+            gen_load_gpr_tl(t1, rs);
+            gen_load_gpr_tl(t2, rt);
             tcg_gen_add_tl(t0, t1, t2);
             tcg_gen_ext32s_tl(t0, t0);
             tcg_gen_xor_tl(t1, t1, t2);
@@ -2586,8 +2586,8 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
             TCGv t2 = tcg_temp_new();
             TCGLabel *l1 = gen_new_label();
 
-            gen_load_gpr(t1, rs);
-            gen_load_gpr(t2, rt);
+            gen_load_gpr_tl(t1, rs);
+            gen_load_gpr_tl(t2, rt);
             tcg_gen_sub_tl(t0, t1, t2);
             tcg_gen_ext32s_tl(t0, t0);
             tcg_gen_xor_tl(t2, t1, t2);
@@ -2624,8 +2624,8 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
             TCGv t2 = tcg_temp_new();
             TCGLabel *l1 = gen_new_label();
 
-            gen_load_gpr(t1, rs);
-            gen_load_gpr(t2, rt);
+            gen_load_gpr_tl(t1, rs);
+            gen_load_gpr_tl(t2, rt);
             tcg_gen_add_tl(t0, t1, t2);
             tcg_gen_xor_tl(t1, t1, t2);
             tcg_gen_xor_tl(t2, t0, t2);
@@ -2655,8 +2655,8 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
             TCGv t2 = tcg_temp_new();
             TCGLabel *l1 = gen_new_label();
 
-            gen_load_gpr(t1, rs);
-            gen_load_gpr(t2, rt);
+            gen_load_gpr_tl(t1, rs);
+            gen_load_gpr_tl(t2, rt);
             tcg_gen_sub_tl(t0, t1, t2);
             tcg_gen_xor_tl(t2, t1, t2);
             tcg_gen_xor_tl(t1, t0, t1);
@@ -2706,10 +2706,10 @@ static void gen_cond_move(DisasContext *ctx, uint32_t opc,
     }
 
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, rt);
+    gen_load_gpr_tl(t0, rt);
     t1 = tcg_constant_tl(0);
     t2 = tcg_temp_new();
-    gen_load_gpr(t2, rs);
+    gen_load_gpr_tl(t2, rs);
     switch (opc) {
     case OPC_MOVN:
         tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[rd], t0, t1, t2, cpu_gpr[rd]);
@@ -2792,8 +2792,8 @@ static void gen_slt(DisasContext *ctx, uint32_t opc,
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
     switch (opc) {
     case OPC_SLT:
         tcg_gen_setcond_tl(TCG_COND_LT, cpu_gpr[rd], t0, t1);
@@ -2820,8 +2820,8 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
     switch (opc) {
     case OPC_SLLV:
         tcg_gen_andi_tl(t0, t0, 0x1f);
@@ -3018,8 +3018,8 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     switch (opc) {
     case R6_OPC_DIV:
@@ -3189,8 +3189,8 @@ static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     switch (opc) {
     case MMI_OPC_DIV1:
@@ -3240,8 +3240,8 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     if (acc != 0) {
         check_dsp(ctx);
@@ -3431,8 +3431,8 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
     TCGv t1 = tcg_temp_new();
     int acc = 0;
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     switch (opc) {
     case MMI_OPC_MULT1:
@@ -3528,7 +3528,7 @@ static void gen_cl(DisasContext *ctx, uint32_t opc,
         return;
     }
     t0 = cpu_gpr[rd];
-    gen_load_gpr(t0, rs);
+    gen_load_gpr_tl(t0, rs);
 
     switch (opc) {
     case OPC_CLO:
@@ -3966,11 +3966,11 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
     case OPC_GSSQ:
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
-        gen_load_gpr(t1, lsq_rt1);
+        gen_load_gpr_tl(t1, lsq_rt1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
@@ -4190,25 +4190,25 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
 #endif
     case OPC_GSSBX:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_SB);
         break;
     case OPC_GSSHX:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UW |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_GSSWX:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSSDX:
         t1 = tcg_temp_new();
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t1, rt);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
@@ -4251,8 +4251,8 @@ static void gen_trap(DisasContext *ctx, uint32_t opc,
     case OPC_TNE:
         /* Compare two registers */
         if (rs != rt) {
-            gen_load_gpr(t0, rs);
-            gen_load_gpr(t1, rt);
+            gen_load_gpr_tl(t0, rs);
+            gen_load_gpr_tl(t1, rt);
             cond = 1;
         }
         break;
@@ -4264,7 +4264,7 @@ static void gen_trap(DisasContext *ctx, uint32_t opc,
     case OPC_TNEI:
         /* Compare register to immediate */
         if (rs != 0 || imm != 0) {
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
             tcg_gen_movi_tl(t1, (int32_t)imm);
             cond = 1;
         }
@@ -4382,8 +4382,8 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
     case OPC_BNEL:
         /* Compare two registers */
         if (rs != rt) {
-            gen_load_gpr(t0, rs);
-            gen_load_gpr(t1, rt);
+            gen_load_gpr_tl(t0, rs);
+            gen_load_gpr_tl(t1, rt);
             bcond_compute = 1;
         }
         btgt = ctx->base.pc_next + insn_bytes + offset;
@@ -4402,7 +4402,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
     case OPC_BLTZL:
         /* Compare to zero */
         if (rs != 0) {
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
             bcond_compute = 1;
         }
         btgt = ctx->base.pc_next + insn_bytes + offset;
@@ -4444,7 +4444,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
             gen_reserved_instruction(ctx);
             goto out;
         }
-        gen_load_gpr(btarget, rs);
+        gen_load_gpr_tl(btarget, rs);
         break;
     default:
         MIPS_INVAL("branch/jump");
@@ -4622,7 +4622,7 @@ static void gen_bitops(DisasContext *ctx, uint32_t opc, int rt,
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_load_gpr(t1, rs);
+    gen_load_gpr_tl(t1, rs);
     switch (opc) {
     case OPC_EXT:
         if (lsb + msb > 31) {
@@ -4657,7 +4657,7 @@ static void gen_bitops(DisasContext *ctx, uint32_t opc, int rt,
         if (lsb > msb) {
             goto fail;
         }
-        gen_load_gpr(t0, rt);
+        gen_load_gpr_tl(t0, rt);
         tcg_gen_deposit_tl(t0, t0, t1, lsb, msb - lsb + 1);
         tcg_gen_ext32s_tl(t0, t0);
         break;
@@ -4672,7 +4672,7 @@ static void gen_bitops(DisasContext *ctx, uint32_t opc, int rt,
         if (lsb > msb) {
             goto fail;
         }
-        gen_load_gpr(t0, rt);
+        gen_load_gpr_tl(t0, rt);
         tcg_gen_deposit_tl(t0, t0, t1, lsb, msb - lsb + 1);
         break;
 #endif
@@ -4695,7 +4695,7 @@ static void gen_bshfl(DisasContext *ctx, uint32_t op2, int rt, int rd)
     }
 
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, rt);
+    gen_load_gpr_tl(t0, rt);
     switch (op2) {
     case OPC_WSBH:
         {
@@ -4763,9 +4763,9 @@ static void gen_align_bits(DisasContext *ctx, int wordsz, int rd, int rs,
     t0 = tcg_temp_new();
     if (bits == 0 || bits == wordsz) {
         if (bits == 0) {
-            gen_load_gpr(t0, rt);
+            gen_load_gpr_tl(t0, rt);
         } else {
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
         }
         switch (wordsz) {
         case 32:
@@ -4779,8 +4779,8 @@ static void gen_align_bits(DisasContext *ctx, int wordsz, int rd, int rs,
         }
     } else {
         TCGv t1 = tcg_temp_new();
-        gen_load_gpr(t0, rt);
-        gen_load_gpr(t1, rs);
+        gen_load_gpr_tl(t0, rt);
+        gen_load_gpr_tl(t1, rs);
         switch (wordsz) {
         case 32:
             {
@@ -4814,7 +4814,7 @@ static void gen_bitswap(DisasContext *ctx, int opc, int rd, int rt)
         return;
     }
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, rt);
+    gen_load_gpr_tl(t0, rt);
     switch (opc) {
     case OPC_BITSWAP:
         gen_helper_bitswap(cpu_gpr[rd], t0);
@@ -8290,7 +8290,7 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     TCGv t0 = tcg_temp_new();
 
-    gen_load_gpr(t0, rt);
+    gen_load_gpr_tl(t0, rt);
     if ((env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) == 0 &&
         ((env->tcs[other_tc].CP0_TCBind & (0xf << CP0TCBd_CurVPE)) !=
          (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE)))) {
@@ -8504,7 +8504,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         {
             TCGv t0 = tcg_temp_new();
 
-            gen_load_gpr(t0, rt);
+            gen_load_gpr_tl(t0, rt);
             gen_mtc0(ctx, t0, rd, ctx->opcode & 0x7);
         }
         opn = "mtc0";
@@ -8524,7 +8524,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         {
             TCGv t0 = tcg_temp_new();
 
-            gen_load_gpr(t0, rt);
+            gen_load_gpr_tl(t0, rt);
             gen_dmtc0(ctx, t0, rd, ctx->opcode & 0x7);
         }
         opn = "dmtc0";
@@ -8543,7 +8543,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         check_mvh(ctx);
         {
             TCGv t0 = tcg_temp_new();
-            gen_load_gpr(t0, rt);
+            gen_load_gpr_tl(t0, rt);
             gen_mthc0(ctx, t0, rd, ctx->opcode & 0x7);
         }
         opn = "mthc0";
@@ -9051,7 +9051,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
         gen_store_gpr(t0, rt);
         break;
     case OPC_MTC1:
-        gen_load_gpr(t0, rt);
+        gen_load_gpr_tl(t0, rt);
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
 
@@ -9064,7 +9064,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
         gen_store_gpr(t0, rt);
         break;
     case OPC_CTC1:
-        gen_load_gpr(t0, rt);
+        gen_load_gpr_tl(t0, rt);
         save_cpu_state(ctx, 0);
         gen_helper_0e2i(ctc1, t0, tcg_constant_i32(fs), rt);
         /* Stop translation as we may have changed hflags */
@@ -9076,7 +9076,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
         gen_store_gpr(t0, rt);
         break;
     case OPC_DMTC1:
-        gen_load_gpr(t0, rt);
+        gen_load_gpr_tl(t0, rt);
         gen_store_fpr64(ctx, t0, fs);
         break;
 #endif
@@ -9090,7 +9090,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
         gen_store_gpr(t0, rt);
         break;
     case OPC_MTHC1:
-        gen_load_gpr(t0, rt);
+        gen_load_gpr_tl(t0, rt);
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
 
@@ -9126,7 +9126,7 @@ static void gen_movci(DisasContext *ctx, int rd, int rs, int cc, int tf)
     t0 = tcg_temp_new_i32();
     tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc));
     tcg_gen_brcondi_i32(cond, t0, 0, l1);
-    gen_load_gpr(cpu_gpr[rd], rs);
+    gen_load_gpr_tl(cpu_gpr[rd], rs);
     gen_set_label(l1);
 }
 
@@ -10546,9 +10546,9 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
     TCGv t0 = tcg_temp_new();
 
     if (base == 0) {
-        gen_load_gpr(t0, index);
+        gen_load_gpr_tl(t0, index);
     } else if (index == 0) {
-        gen_load_gpr(t0, base);
+        gen_load_gpr_tl(t0, base);
     } else {
         gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
     }
@@ -10628,7 +10628,7 @@ static void gen_flt3_arith(DisasContext *ctx, uint32_t opc,
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
 
-            gen_load_gpr(t0, fr);
+            gen_load_gpr_tl(t0, fr);
             tcg_gen_andi_tl(t0, t0, 0x7);
 
             tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0, l1);
@@ -11006,8 +11006,8 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
     /* compact branch */
     case OPC_BOVC: /* OPC_BEQZALC, OPC_BEQC */
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC */
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t0, rs);
+        gen_load_gpr_tl(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         if (rs <= rt && rs == 0) {
@@ -11017,8 +11017,8 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_BLEZC: /* OPC_BGEZC, OPC_BGEC */
     case OPC_BGTZC: /* OPC_BLTZC, OPC_BLTC */
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t0, rs);
+        gen_load_gpr_tl(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
@@ -11029,8 +11029,8 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
             /* OPC_BGTZALC, OPC_BLTZALC */
             tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4 + m16_lowbit);
         }
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t0, rs);
+        gen_load_gpr_tl(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
@@ -11042,14 +11042,14 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
     case OPC_BNEZC:
         if (rs != 0) {
             /* OPC_BEQZC, OPC_BNEZC */
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
             bcond_compute = 1;
             ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         } else {
             /* OPC_JIC, OPC_JIALC */
             TCGv tbase = tcg_temp_new();
 
-            gen_load_gpr(tbase, rt);
+            gen_load_gpr_tl(tbase, rt);
             gen_op_addr_addi(ctx, btarget, tbase, offset);
         }
         break;
@@ -11145,8 +11145,8 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
                 TCGv t4 = tcg_temp_new();
                 TCGv input_overflow = tcg_temp_new();
 
-                gen_load_gpr(t0, rs);
-                gen_load_gpr(t1, rt);
+                gen_load_gpr_tl(t0, rs);
+                gen_load_gpr_tl(t1, rt);
                 tcg_gen_ext32s_tl(t2, t0);
                 tcg_gen_setcond_tl(TCG_COND_NE, input_overflow, t2, t0);
                 tcg_gen_ext32s_tl(t3, t1);
@@ -11248,10 +11248,10 @@ void gen_ldxs(DisasContext *ctx, int base, int index, int rd)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, base);
+    gen_load_gpr_tl(t0, base);
 
     if (index != 0) {
-        gen_load_gpr(t1, index);
+        gen_load_gpr_tl(t1, index);
         tcg_gen_shli_tl(t1, t1, 2);
         gen_op_addr_add(ctx, t0, t1, t0);
     }
@@ -11334,9 +11334,9 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
     t0 = tcg_temp_new();
 
     if (base == 0) {
-        gen_load_gpr(t0, offset);
+        gen_load_gpr_tl(t0, offset);
     } else if (offset == 0) {
-        gen_load_gpr(t0, base);
+        gen_load_gpr_tl(t0, base);
     } else {
         gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[offset]);
     }
@@ -11377,8 +11377,8 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
     v1_t = tcg_temp_new();
     v2_t = tcg_temp_new();
 
-    gen_load_gpr(v1_t, v1);
-    gen_load_gpr(v2_t, v2);
+    gen_load_gpr_tl(v1_t, v1);
+    gen_load_gpr_tl(v2_t, v2);
 
     switch (op1) {
     case OPC_ADDUH_QB_DSP:
@@ -11822,8 +11822,8 @@ static void gen_mipsdsp_shift(DisasContext *ctx, uint32_t opc,
     v2_t = tcg_temp_new();
 
     tcg_gen_movi_tl(t0, v1);
-    gen_load_gpr(v1_t, v1);
-    gen_load_gpr(v2_t, v2);
+    gen_load_gpr_tl(v1_t, v1);
+    gen_load_gpr_tl(v2_t, v2);
 
     switch (opc) {
     case OPC_SHLL_QB_DSP:
@@ -12060,8 +12060,8 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
     v2_t = tcg_temp_new();
 
     tcg_gen_movi_i32(t0, ret);
-    gen_load_gpr(v1_t, v1);
-    gen_load_gpr(v2_t, v2);
+    gen_load_gpr_tl(v1_t, v1);
+    gen_load_gpr_tl(v2_t, v2);
 
     switch (op1) {
     case OPC_MUL_PH_DSP:
@@ -12359,7 +12359,7 @@ static void gen_mipsdsp_bitinsn(DisasContext *ctx, uint32_t op1, uint32_t op2,
 
     t0 = tcg_temp_new();
     val_t = tcg_temp_new();
-    gen_load_gpr(val_t, val);
+    gen_load_gpr_tl(val_t, val);
 
     switch (op1) {
     case OPC_ABSQ_S_PH_DSP:
@@ -12498,8 +12498,8 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext *ctx,
     v1_t = tcg_temp_new();
     v2_t = tcg_temp_new();
 
-    gen_load_gpr(v1_t, v1);
-    gen_load_gpr(v2_t, v2);
+    gen_load_gpr_tl(v1_t, v1);
+    gen_load_gpr_tl(v2_t, v2);
 
     switch (op1) {
     case OPC_CMPU_EQ_QB_DSP:
@@ -12676,7 +12676,7 @@ static void gen_mipsdsp_append(CPUMIPSState *env, DisasContext *ctx,
     }
 
     t0 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
+    gen_load_gpr_tl(t0, rs);
 
     switch (op1) {
     case OPC_APPEND_DSP:
@@ -12768,7 +12768,7 @@ static void gen_mipsdsp_accinsn(DisasContext *ctx, uint32_t op1, uint32_t op2,
     t1 = tcg_temp_new();
     v1_t = tcg_temp_new();
 
-    gen_load_gpr(v1_t, v1);
+    gen_load_gpr_tl(v1_t, v1);
 
     switch (op1) {
     case OPC_EXTR_W_DSP:
@@ -13785,8 +13785,8 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
                 t0 = tcg_temp_new();
                 t1 = tcg_temp_new();
 
-                gen_load_gpr(t0, rt);
-                gen_load_gpr(t1, rs);
+                gen_load_gpr_tl(t0, rt);
+                gen_load_gpr_tl(t1, rs);
 
                 gen_helper_insv(cpu_gpr[rt], tcg_env, t1, t0);
                 break;
@@ -14045,8 +14045,8 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
             t0 = tcg_temp_new();
             t1 = tcg_temp_new();
 
-            gen_load_gpr(t0, rt);
-            gen_load_gpr(t1, rs);
+            gen_load_gpr_tl(t0, rt);
+            gen_load_gpr_tl(t1, rs);
 
             gen_helper_dinsv(cpu_gpr[rt], tcg_env, t1, t0);
             break;
@@ -14272,8 +14272,8 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
 
-            gen_load_gpr(t0, rt);
-            gen_load_gpr(t1, rs);
+            gen_load_gpr_tl(t0, rt);
+            gen_load_gpr_tl(t1, rs);
             gen_helper_fork(t0, t1);
         }
         break;
@@ -14282,7 +14282,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         {
             TCGv t0 = tcg_temp_new();
 
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
             gen_helper_yield(t0, tcg_env, t0);
             gen_store_gpr(t0, rd);
         }
@@ -14973,7 +14973,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
                 generate_exception(ctx, EXCP_RI);
             } else if (rt != 0) {
                 TCGv t0 = tcg_temp_new();
-                gen_load_gpr(t0, rs);
+                gen_load_gpr_tl(t0, rs);
                 tcg_gen_addi_tl(cpu_gpr[rt], t0, imm << 16);
             }
 #else
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 6f4b39f715b..e66361c97dd 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -24,8 +24,8 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     }
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
     tcg_gen_shli_tl(t0, t0, sa + 1);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
@@ -45,8 +45,8 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     }
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
     tcg_gen_shli_tl(t0, t0, sa + 1);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     return true;
diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index ae3f5e19c43..9a204a2d884 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -78,14 +78,14 @@ static bool trans_MFLO1(DisasContext *ctx, arg_r *a)
 
 static bool trans_MTHI1(DisasContext *ctx, arg_r *a)
 {
-    gen_load_gpr(cpu_HI[1], a->rs);
+    gen_load_gpr_tl(cpu_HI[1], a->rs);
 
     return true;
 }
 
 static bool trans_MTLO1(DisasContext *ctx, arg_r *a)
 {
-    gen_load_gpr(cpu_LO[1], a->rs);
+    gen_load_gpr_tl(cpu_LO[1], a->rs);
 
     return true;
 }
@@ -128,8 +128,8 @@ static bool trans_parallel_arith(DisasContext *ctx, arg_r *a,
     bx = tcg_temp_new_i64();
 
     /* Lower half */
-    gen_load_gpr(ax, a->rs);
-    gen_load_gpr(bx, a->rt);
+    gen_load_gpr_tl(ax, a->rs);
+    gen_load_gpr_tl(bx, a->rt);
     gen_logic_i64(cpu_gpr[a->rd], ax, bx);
 
     /* Upper half */
@@ -250,8 +250,8 @@ static bool trans_parallel_compare(DisasContext *ctx, arg_r *a,
     t2 = tcg_temp_new_i64();
 
     /* Lower half */
-    gen_load_gpr(ax, a->rs);
-    gen_load_gpr(bx, a->rt);
+    gen_load_gpr_tl(ax, a->rs);
+    gen_load_gpr_tl(bx, a->rt);
     for (int i = 0; i < (64 / wlen); i++) {
         tcg_gen_sextract_i64(t0, ax, wlen * i, wlen);
         tcg_gen_sextract_i64(t1, bx, wlen * i, wlen);
@@ -363,7 +363,7 @@ static bool trans_SQ(DisasContext *ctx, arg_i *a)
     tcg_gen_andi_tl(addr, addr, ~0xf);
 
     /* Lower half */
-    gen_load_gpr(t0, a->rt);
+    gen_load_gpr_tl(t0, a->rt);
     tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
 
     /* Upper half */
@@ -427,8 +427,8 @@ static bool trans_PPACW(DisasContext *ctx, arg_r *a)
     b0 = tcg_temp_new_i64();
     t0 = tcg_temp_new_i64();
 
-    gen_load_gpr(a0, a->rs);
-    gen_load_gpr(b0, a->rt);
+    gen_load_gpr_tl(a0, a->rs);
+    gen_load_gpr_tl(b0, a->rt);
 
     gen_load_gpr_hi(t0, a->rt); /* b1 */
     tcg_gen_deposit_i64(cpu_gpr[a->rd], b0, t0, 32, 32);
@@ -457,8 +457,8 @@ static bool trans_PEXTLx(DisasContext *ctx, arg_r *a, unsigned wlen)
     ax = tcg_temp_new_i64();
     bx = tcg_temp_new_i64();
 
-    gen_load_gpr(ax, a->rs);
-    gen_load_gpr(bx, a->rt);
+    gen_load_gpr_tl(ax, a->rs);
+    gen_load_gpr_tl(bx, a->rt);
 
     /* Lower half */
     for (int i = 0; i < 64 / (2 * wlen); i++) {
@@ -506,8 +506,8 @@ static bool trans_PEXTLW(DisasContext *ctx, arg_r *a)
     ax = tcg_temp_new_i64();
     bx = tcg_temp_new_i64();
 
-    gen_load_gpr(ax, a->rs);
-    gen_load_gpr(bx, a->rt);
+    gen_load_gpr_tl(ax, a->rs);
+    gen_load_gpr_tl(bx, a->rt);
     gen_pextw(cpu_gpr[a->rd], cpu_gpr_hi[a->rd], ax, bx);
     return true;
 }
diff --git a/target/mips/tcg/vr54xx_translate.c b/target/mips/tcg/vr54xx_translate.c
index c877ede76e9..d1e9f0e51cd 100644
--- a/target/mips/tcg/vr54xx_translate.c
+++ b/target/mips/tcg/vr54xx_translate.c
@@ -40,8 +40,8 @@ static bool trans_mult_acc(DisasContext *ctx, arg_r *a,
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, a->rs);
-    gen_load_gpr(t1, a->rt);
+    gen_load_gpr_tl(t0, a->rs);
+    gen_load_gpr_tl(t1, a->rt);
 
     gen_helper_mult_acc(t0, tcg_env, t0, t1);
 
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index c479bec1081..fd85977bb8b 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -861,8 +861,8 @@ static inline void gen_movep(DisasContext *ctx, int enc_dest, int enc_rt,
 
     rd = rd_enc[enc_dest];
     re = re_enc[enc_dest];
-    gen_load_gpr(cpu_gpr[rd], rs_rt_enc[enc_rs]);
-    gen_load_gpr(cpu_gpr[re], rs_rt_enc[enc_rt]);
+    gen_load_gpr_tl(cpu_gpr[rd], rs_rt_enc[enc_rs]);
+    gen_load_gpr_tl(cpu_gpr[re], rs_rt_enc[enc_rt]);
 }
 
 static void gen_pool16c_r6_insn(DisasContext *ctx)
@@ -986,11 +986,11 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_store_gpr(t1, rd + 1);
         break;
     case SWP:
-        gen_load_gpr(t1, rd);
+        gen_load_gpr_tl(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         gen_op_addr_addi(ctx, t0, t0, 4);
-        gen_load_gpr(t1, rd + 1);
+        gen_load_gpr_tl(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
@@ -1009,11 +1009,11 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_store_gpr(t1, rd + 1);
         break;
     case SDP:
-        gen_load_gpr(t1, rd);
+        gen_load_gpr_tl(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_op_addr_addi(ctx, t0, t0, 8);
-        gen_load_gpr(t1, rd + 1);
+        gen_load_gpr_tl(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
@@ -1064,7 +1064,7 @@ static void gen_pool32axf(CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
         {
             TCGv t0 = tcg_temp_new();
 
-            gen_load_gpr(t0, rt);
+            gen_load_gpr_tl(t0, rt);
             gen_mtc0(ctx, t0, rs, (ctx->opcode >> 11) & 0x7);
         }
         break;
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index a9af8f1e74a..52a34b3c4b9 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -132,7 +132,7 @@ static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
     TCGv t1 = tcg_temp_new();
 
     gen_op_addr_addi(ctx, t0, t0, -4);
-    gen_load_gpr(t1, regidx);
+    gen_load_gpr_tl(t1, regidx);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                        ctx->default_tcg_memop_mask);
 }
@@ -180,30 +180,30 @@ static void gen_mips16_save(DisasContext *ctx,
     switch (args) {
     case 4:
         gen_base_offset_addr(ctx, t0, 29, 12);
-        gen_load_gpr(t1, 7);
+        gen_load_gpr_tl(t1, 7);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 3:
         gen_base_offset_addr(ctx, t0, 29, 8);
-        gen_load_gpr(t1, 6);
+        gen_load_gpr_tl(t1, 6);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 2:
         gen_base_offset_addr(ctx, t0, 29, 4);
-        gen_load_gpr(t1, 5);
+        gen_load_gpr_tl(t1, 5);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 1:
         gen_base_offset_addr(ctx, t0, 29, 0);
-        gen_load_gpr(t1, 4);
+        gen_load_gpr_tl(t1, 4);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
     }
 
-    gen_load_gpr(t0, 29);
+    gen_load_gpr_tl(t0, 29);
 
     if (do_ra) {
         decr_and_store(ctx, 31, t0);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 1e274143bbd..99ce1f96564 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1029,8 +1029,8 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
     tcg_gen_ld_tl(lladdr, tcg_env, offsetof(CPUMIPSState, lladdr));
     tcg_gen_brcond_tl(TCG_COND_NE, taddr, lladdr, lab_fail);
 
-    gen_load_gpr(tmp1, reg1);
-    gen_load_gpr(tmp2, reg2);
+    gen_load_gpr_tl(tmp1, reg1);
+    gen_load_gpr_tl(tmp2, reg2);
 
     if (disas_is_bigendian(ctx)) {
         tcg_gen_concat_tl_i64(tval, tmp2, tmp1);
@@ -1073,7 +1073,7 @@ static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
         int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
         int this_offset = -((counter + 1) << 2);
         gen_base_offset_addr(ctx, va, 29, this_offset);
-        gen_load_gpr(t0, this_rt);
+        gen_load_gpr_tl(t0, this_rt);
         tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
                           mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask);
         counter++;
@@ -1121,8 +1121,8 @@ static void gen_compute_branch_nm(DisasContext *ctx, uint32_t opc,
     case OPC_BNE:
         /* Compare two registers */
         if (rs != rt) {
-            gen_load_gpr(t0, rs);
-            gen_load_gpr(t1, rt);
+            gen_load_gpr_tl(t0, rs);
+            gen_load_gpr_tl(t1, rt);
             bcond_compute = 1;
         }
         btgt = ctx->base.pc_next + insn_bytes + offset;
@@ -1130,7 +1130,7 @@ static void gen_compute_branch_nm(DisasContext *ctx, uint32_t opc,
     case OPC_BGEZAL:
         /* Compare to zero */
         if (rs != 0) {
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
             bcond_compute = 1;
         }
         btgt = ctx->base.pc_next + insn_bytes + offset;
@@ -1152,7 +1152,7 @@ static void gen_compute_branch_nm(DisasContext *ctx, uint32_t opc,
             gen_reserved_instruction(ctx);
             goto out;
         }
-        gen_load_gpr(btarget, rs);
+        gen_load_gpr_tl(btarget, rs);
         break;
     default:
         MIPS_INVAL("branch/jump");
@@ -1358,8 +1358,8 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
             TCGv t1 = tcg_temp_new();
             TCGv t2 = tcg_temp_new();
 
-            gen_load_gpr(t1, rs);
-            gen_load_gpr(t2, rt);
+            gen_load_gpr_tl(t1, rs);
+            gen_load_gpr_tl(t2, rt);
             tcg_gen_add_tl(t0, t1, t2);
             tcg_gen_ext32s_tl(t0, t0);
             tcg_gen_xor_tl(t1, t1, t2);
@@ -1409,7 +1409,7 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         {
             TCGv t0 = tcg_temp_new();
 
-            gen_load_gpr(t0, rt);
+            gen_load_gpr_tl(t0, rt);
             gen_mtc0(ctx, t0, rs, extract32(ctx->opcode, 11, 3));
         }
         break;
@@ -1458,8 +1458,8 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
 
-            gen_load_gpr(t0, rt);
-            gen_load_gpr(t1, rs);
+            gen_load_gpr_tl(t0, rt);
+            gen_load_gpr_tl(t1, rs);
             gen_helper_fork(t0, t1);
         }
         break;
@@ -1484,7 +1484,7 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         {
             TCGv t0 = tcg_temp_new();
 
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
             gen_helper_yield(t0, tcg_env, t0);
             gen_store_gpr(t0, rt);
         }
@@ -1511,8 +1511,8 @@ static void gen_pool32axf_1_5_nanomips_insn(DisasContext *ctx, uint32_t opc,
 
     tcg_gen_movi_i32(t0, v2 >> 3);
 
-    gen_load_gpr(v0_t, ret);
-    gen_load_gpr(v1_t, v1);
+    gen_load_gpr_tl(v0_t, ret);
+    gen_load_gpr_tl(v1_t, v1);
 
     switch (opc) {
     case NM_MAQ_S_W_PHR:
@@ -1545,7 +1545,7 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
     TCGv t0 = tcg_temp_new();
     TCGv v0_t = tcg_temp_new();
 
-    gen_load_gpr(v0_t, v1);
+    gen_load_gpr_tl(v0_t, v1);
 
     switch (opc) {
     case NM_POOL32AXF_1_0:
@@ -1588,7 +1588,7 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
             gen_store_gpr(t0, ret);
             break;
         case NM_WRDSP:
-            gen_load_gpr(t0, ret);
+            gen_load_gpr_tl(t0, ret);
             gen_helper_wrdsp(t0, tcg_constant_tl(imm), tcg_env);
             break;
         case NM_EXTP:
@@ -1776,8 +1776,8 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
     TCGv v0_t = tcg_temp_new();
     TCGv v1_t = tcg_temp_new();
 
-    gen_load_gpr(v0_t, rt);
-    gen_load_gpr(v1_t, rs);
+    gen_load_gpr_tl(v0_t, rt);
+    gen_load_gpr_tl(v1_t, rs);
 
     switch (opc) {
     case NM_POOL32AXF_2_0_7:
@@ -1791,7 +1791,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_BALIGN:
             check_dsp_r2(ctx);
             if (rt != 0) {
-                gen_load_gpr(t0, rs);
+                gen_load_gpr_tl(t0, rs);
                 rd &= 3;
                 if (rd != 0 && rd != 2) {
                     tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 8 * rd);
@@ -1809,8 +1809,8 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 TCGv_i64 t2 = tcg_temp_new_i64();
                 TCGv_i64 t3 = tcg_temp_new_i64();
 
-                gen_load_gpr(t0, rt);
-                gen_load_gpr(t1, rs);
+                gen_load_gpr_tl(t0, rt);
+                gen_load_gpr_tl(t1, rs);
                 tcg_gen_ext_tl_i64(t2, t0);
                 tcg_gen_ext_tl_i64(t3, t1);
                 tcg_gen_mul_i64(t2, t2, t3);
@@ -1830,8 +1830,8 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 if (acc || ctx->insn_flags & ISA_MIPS_R6) {
                     check_dsp_r2(ctx);
                 }
-                gen_load_gpr(t0, rs);
-                gen_load_gpr(t1, rt);
+                gen_load_gpr_tl(t0, rs);
+                gen_load_gpr_tl(t1, rt);
                 tcg_gen_trunc_tl_i32(t2, t0);
                 tcg_gen_trunc_tl_i32(t3, t1);
                 tcg_gen_muls2_i32(t2, t3, t2, t3);
@@ -1841,7 +1841,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTRV_W:
             check_dsp(ctx);
-            gen_load_gpr(v1_t, rs);
+            gen_load_gpr_tl(v1_t, rs);
             gen_helper_extr_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
@@ -1862,8 +1862,8 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 TCGv_i64 t2 = tcg_temp_new_i64();
                 TCGv_i64 t3 = tcg_temp_new_i64();
 
-                gen_load_gpr(t0, rs);
-                gen_load_gpr(t1, rt);
+                gen_load_gpr_tl(t0, rs);
+                gen_load_gpr_tl(t1, rt);
                 tcg_gen_ext32u_tl(t0, t0);
                 tcg_gen_ext32u_tl(t1, t1);
                 tcg_gen_extu_tl_i64(t2, t0);
@@ -1885,8 +1885,8 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 if (acc || ctx->insn_flags & ISA_MIPS_R6) {
                     check_dsp_r2(ctx);
                 }
-                gen_load_gpr(t0, rs);
-                gen_load_gpr(t1, rt);
+                gen_load_gpr_tl(t0, rs);
+                gen_load_gpr_tl(t1, rt);
                 tcg_gen_trunc_tl_i32(t2, t0);
                 tcg_gen_trunc_tl_i32(t3, t1);
                 tcg_gen_mulu2_i32(t2, t3, t2, t3);
@@ -1925,8 +1925,8 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 TCGv_i64 t2 = tcg_temp_new_i64();
                 TCGv_i64 t3 = tcg_temp_new_i64();
 
-                gen_load_gpr(t0, rs);
-                gen_load_gpr(t1, rt);
+                gen_load_gpr_tl(t0, rs);
+                gen_load_gpr_tl(t1, rt);
                 tcg_gen_ext_tl_i64(t2, t0);
                 tcg_gen_ext_tl_i64(t3, t1);
                 tcg_gen_mul_i64(t2, t2, t3);
@@ -1964,8 +1964,8 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 TCGv_i64 t2 = tcg_temp_new_i64();
                 TCGv_i64 t3 = tcg_temp_new_i64();
 
-                gen_load_gpr(t0, rs);
-                gen_load_gpr(t1, rt);
+                gen_load_gpr_tl(t0, rs);
+                gen_load_gpr_tl(t1, rt);
                 tcg_gen_ext32u_tl(t0, t0);
                 tcg_gen_ext32u_tl(t1, t1);
                 tcg_gen_extu_tl_i64(t2, t0);
@@ -1997,7 +1997,7 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
     TCGv t0 = tcg_temp_new();
     TCGv v0_t = tcg_temp_new();
 
-    gen_load_gpr(v0_t, rs);
+    gen_load_gpr_tl(v0_t, rs);
 
     switch (opc) {
     case NM_ABSQ_S_QB:
@@ -2096,7 +2096,7 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
         {
             TCGv tv0 = tcg_temp_new();
 
-            gen_load_gpr(tv0, rt);
+            gen_load_gpr_tl(tv0, rt);
             gen_helper_insv(v0_t, tcg_env, v0_t, tv0);
             gen_store_gpr(v0_t, ret);
         }
@@ -2132,7 +2132,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
     TCGv t0 = tcg_temp_new();
     TCGv rs_t = tcg_temp_new();
 
-    gen_load_gpr(rs_t, rs);
+    gen_load_gpr_tl(rs_t, rs);
 
     switch (opc) {
     case NM_SHRA_R_QB:
@@ -2289,7 +2289,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
     TCGv t0 = tcg_temp_new();
     TCGv timm = tcg_constant_tl(imm);
 
-    gen_load_gpr(t0, rt);
+    gen_load_gpr_tl(t0, rt);
     ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
 
     /* Load needed operands and calculate btarget */
@@ -2389,7 +2389,7 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
     TCGv t0 = tcg_temp_new();
 
     /* load rs */
-    gen_load_gpr(t0, rs);
+    gen_load_gpr_tl(t0, rs);
 
     /* link */
     if (rt != 0) {
@@ -2422,8 +2422,8 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
     /* compact branch */
     case OPC_BGEC:
     case OPC_BLTC:
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t0, rs);
+        gen_load_gpr_tl(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
@@ -2434,8 +2434,8 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
             /* OPC_BGTZALC, OPC_BLTZALC */
             tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4);
         }
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+        gen_load_gpr_tl(t0, rs);
+        gen_load_gpr_tl(t1, rt);
         bcond_compute = 1;
         ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         break;
@@ -2445,14 +2445,14 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
     case OPC_BEQZC:
         if (rs != 0) {
             /* OPC_BEQZC, OPC_BNEZC */
-            gen_load_gpr(t0, rs);
+            gen_load_gpr_tl(t0, rs);
             bcond_compute = 1;
             ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
         } else {
             /* OPC_JIC, OPC_JIALC */
             TCGv tbase = tcg_temp_new();
 
-            gen_load_gpr(tbase, rt);
+            gen_load_gpr_tl(tbase, rt);
             gen_op_addr_addi(ctx, btarget, tbase, offset);
         }
         break;
@@ -2587,8 +2587,8 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
+    gen_load_gpr_tl(t0, rs);
+    gen_load_gpr_tl(t1, rt);
 
     if ((extract32(ctx->opcode, 6, 1)) == 1) {
         /* PP.LSXS instructions require shifting */
@@ -2648,20 +2648,20 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
         break;
     case NM_SBX:
         check_nms(ctx);
-        gen_load_gpr(t1, rd);
+        gen_load_gpr_tl(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_8);
         break;
     case NM_SHX:
     /*case NM_SHXS:*/
         check_nms(ctx);
-        gen_load_gpr(t1, rd);
+        gen_load_gpr_tl(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                         mo_endian(ctx) | MO_UW | ctx->default_tcg_memop_mask);
         break;
     case NM_SWX:
     /*case NM_SWXS:*/
         check_nms(ctx);
-        gen_load_gpr(t1, rd);
+        gen_load_gpr_tl(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                         mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask);
         break;
@@ -3010,8 +3010,8 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     TCGv v1_t = tcg_temp_new();
     TCGv v2_t = tcg_temp_new();
 
-    gen_load_gpr(v1_t, rs);
-    gen_load_gpr(v2_t, rt);
+    gen_load_gpr_tl(v1_t, rs);
+    gen_load_gpr_tl(v2_t, rt);
 
     switch (opc) {
     case NM_CMP_EQ_PH:
@@ -3386,7 +3386,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         break;
     case NM_APPEND:
         check_dsp_r2(ctx);
-        gen_load_gpr(t0, rs);
+        gen_load_gpr_tl(t0, rs);
         if (rd != 0) {
             tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd);
         }
@@ -3722,7 +3722,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
                                                 addr_off);
 
-                    gen_load_gpr(t1, rt);
+                    gen_load_gpr_tl(t1, rt);
 
                     tcg_gen_qemu_st_tl(t1, tcg_constant_tl(addr), ctx->mem_idx,
                                        mo_endian(ctx) | MO_UL
@@ -3785,7 +3785,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 TCGv t0 = tcg_temp_new();
 
                 imm = extract32(ctx->opcode, 0, 12);
-                gen_load_gpr(t0, rs);
+                gen_load_gpr_tl(t0, rs);
                 tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, imm);
                 gen_store_gpr(t0, rt);
             }
@@ -3843,7 +3843,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 TCGv_i32 stripe =
                     tcg_constant_i32(extract32(ctx->opcode, 6, 1));
 
-                gen_load_gpr(t0, rs);
+                gen_load_gpr_tl(t0, rs);
                 gen_helper_rotx(cpu_gpr[rt], t0, shift, shiftx, stripe);
             }
             break;
@@ -4109,7 +4109,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                             gen_store_gpr(t0, rt);
                             break;
                         case NM_UASH:
-                            gen_load_gpr(t1, rt);
+                            gen_load_gpr_tl(t1, rt);
                             tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                                             mo_endian(ctx) | MO_UW | MO_UNALN);
                             break;
@@ -4300,7 +4300,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                             break;
                         case NM_SWM:
                             this_rt = (rt == 0) ? 0 : this_rt;
-                            gen_load_gpr(t1, this_rt);
+                            gen_load_gpr_tl(t1, this_rt);
                             tcg_gen_qemu_st_tl(t1, va, ctx->mem_idx,
                                                memop | mo_endian(ctx) | MO_UL);
                             break;
@@ -4324,7 +4324,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             rd = (extract32(ctx->opcode, 24, 1)) == 0 ? 4 : 5;
             rt = decode_gpr_gpr4_zero(extract32(ctx->opcode, 25, 1) << 3 |
                             extract32(ctx->opcode, 21, 3));
-            gen_load_gpr(t0, rt);
+            gen_load_gpr_tl(t0, rt);
             tcg_gen_mov_tl(cpu_gpr[rd], t0);
             gen_compute_branch_nm(ctx, OPC_BGEZAL, 4, 0, 0, s);
         }
@@ -4808,8 +4808,8 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
                 rs = r1;
                 rt = r2;
             }
-            gen_load_gpr(t0, rs);
-            gen_load_gpr(t1, rt);
+            gen_load_gpr_tl(t0, rs);
+            gen_load_gpr_tl(t1, rt);
             tcg_gen_mov_tl(cpu_gpr[rd], t0);
             tcg_gen_mov_tl(cpu_gpr[re], t1);
         }
-- 
2.45.2


