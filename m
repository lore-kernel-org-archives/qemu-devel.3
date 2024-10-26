Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C6D10C00
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4l04-0000c9-St; Sat, 26 Oct 2024 13:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4l01-0000UH-VA
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:54 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzz-0003oH-Tq
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:53 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so2230802a12.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965290; x=1730570090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Il4NobzlkpIyZd78R3cLrQgktTFWikb9QmSl/XdYSsQ=;
 b=arrFEwRJbeq06KaIUo/Aq7x37HftH4lGkeldl2PCAI3m9K+w5Eg5cnPzPvDDOHh1g4
 LnDze6zGmjON2OCOhlxFTvSHNO+ChAKBIDpL9jL4/8Jo9+19YHiYdhqW5OZeT/4Sgj2D
 tBkcDNcYm/S2ZCrNp4yKMR7q6hg5wKAnm/b79YMMzZZAG5y/DU0PYIirChmP6kXpMH7C
 wwgLWhae8hnd4/EPD51m5P98wn5uOcPfunHn+s7aQ0nTx5RnT6rgMAjBr3OiuTLLsHU4
 pXALgjZzJn65lsD4j+dIgrivN7FN4fAx1Oq1eoeJSZNpXg60zuwcQTHNKCTVLt52uoQQ
 lHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965290; x=1730570090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Il4NobzlkpIyZd78R3cLrQgktTFWikb9QmSl/XdYSsQ=;
 b=u8eeaM8A4+Ck4PHDGfwwOQgN17aysmCNEsxdAekLija5pwjbiRerOjjZRYmp+2TsWY
 bTFnRgBnRpRLoeIPqqCfr3mK2w90Fqv6LWBgUaP6x/rUkk01U3mEbVJLmnCZcQgR6muX
 lOtPw2M8nTZO9sjVa+XycEN4FvXZ/wlLeAI336aUMqmbAUoylql4M8SZ1RauLs2gMcqu
 sz0UGKrO+y+ppWOIF6tya8ngtP7ApaEMGSAK8bqN2CdocX/GGcbOLrkprEFqnPLp2zWM
 fm3entfoD+e7f3JaWWahwfJVU1eBjTZc6PWL7AloV1iNfegReEW7iP3sgZruoh2VFg50
 8rlw==
X-Gm-Message-State: AOJu0Yz3lDQkqQG7nMe4CVmJN3y3ijjPqgsYoZin+om1DozEjtSKNpRd
 Burct43pp4t4GLOqBoBD70OKbY5z69cu09Bbj0cXSg4OWqgO58Zmn4OTUBHs/FQpUbBHhrPRKib
 e
X-Google-Smtp-Source: AGHT+IHgYWL6MD8w+LirZsAPh+0dASTZcy78JsRHbiW7UfT1htYv2Qyv/QQuYkT2REnXYLcacFm1WQ==
X-Received: by 2002:a05:6a20:d808:b0:1d9:261c:5943 with SMTP id
 adf61e73a8af0-1d9a83a9044mr4452053637.10.1729965290118; 
 Sat, 26 Oct 2024 10:54:50 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a21933sm3067893b3a.173.2024.10.26.10.54.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:54:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 7/9] target/mips: Convert Loongson [D]MOD[U].G opcodes to
 decodetree
Date: Sat, 26 Oct 2024 14:53:47 -0300
Message-ID: <20241026175349.84523-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Convert the following opcodes to decodetree:

- MOD.G - mod 32-bit signed integers
- MODU.G - mod 32-bit unsigned integers
- DMOD.G - mod 64-bit signed integers
- DMODU.G - mod 64-bit unsigned integers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/godson2.decode    |   5 ++
 target/mips/tcg/loong-ext.decode  |   5 ++
 target/mips/tcg/loong_translate.c | 111 ++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       |  82 ----------------------
 4 files changed, 121 insertions(+), 82 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index 581cb9c8608..c03c8b717d9 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -17,3 +17,8 @@ DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
 DIVU_G          011111 ..... ..... ..... 00000 011011   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
 DDIVU_G         011111 ..... ..... ..... 00000 011111   @rs_rt_rd
+
+MOD_G           011111 ..... ..... ..... 00000 100010   @rs_rt_rd
+MODU_G          011111 ..... ..... ..... 00000 100011   @rs_rt_rd
+DMOD_G          011111 ..... ..... ..... 00000 100110   @rs_rt_rd
+DMODU_G         011111 ..... ..... ..... 00000 100111   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index e222167af56..f0fd36c9218 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -18,3 +18,8 @@ DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
 DIVU_G          011100 ..... ..... ..... 00000 010110   @rs_rt_rd
 DDIVU_G         011100 ..... ..... ..... 00000 010111   @rs_rt_rd
+
+MOD_G           011100 ..... ..... ..... 00000 011100   @rs_rt_rd
+DMOD_G          011100 ..... ..... ..... 00000 011101   @rs_rt_rd
+MODU_G          011100 ..... ..... ..... 00000 011110   @rs_rt_rd
+DMODU_G         011100 ..... ..... ..... 00000 011111   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index 903d242e7cc..76c1a8cef2d 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -141,6 +141,117 @@ static bool trans_DDIVU_G(DisasContext *s, arg_muldiv *a)
     return gen_lext_DIVU_G(s, a->rt, a->rs, a->rd, true);
 }
 
+static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
+                           bool is_double)
+{
+    TCGv t0, t1;
+    TCGLabel *l1, *l2, *l3;
+
+    if (is_double) {
+        if (TARGET_LONG_BITS != 64) {
+            return false;
+        }
+        check_mips_64(s);
+    }
+
+    if (rd == 0) {
+        /* Treat as NOP. */
+        return true;
+    }
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    l1 = gen_new_label();
+    l2 = gen_new_label();
+    l3 = gen_new_label();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    if (!is_double) {
+        tcg_gen_ext32u_tl(t0, t0);
+        tcg_gen_ext32u_tl(t1, t1);
+    }
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
+                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
+    gen_set_label(l1);
+    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_br(l3);
+    gen_set_label(l2);
+    tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+    gen_set_label(l3);
+
+    return true;
+}
+
+static bool trans_MOD_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MOD_G(s, a->rt, a->rs, a->rd, false);
+}
+
+static bool trans_DMOD_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MOD_G(s, a->rt, a->rs, a->rd, true);
+}
+
+static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
+                            bool is_double)
+{
+    TCGv t0, t1;
+    TCGLabel *l1, *l2;
+
+    if (is_double) {
+        if (TARGET_LONG_BITS != 64) {
+            return false;
+        }
+        check_mips_64(s);
+    }
+
+    if (rd == 0) {
+        /* Treat as NOP. */
+        return true;
+    }
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    l1 = gen_new_label();
+    l2 = gen_new_label();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    if (!is_double) {
+        tcg_gen_ext32u_tl(t0, t0);
+        tcg_gen_ext32u_tl(t1, t1);
+    }
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
+    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_br(l2);
+    gen_set_label(l1);
+    tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+    gen_set_label(l2);
+
+    return true;
+}
+
+static bool trans_MODU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MODU_G(s, a->rt, a->rs, a->rd, false);
+}
+
+static bool trans_DMODU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MODU_G(s, a->rt, a->rs, a->rd, true);
+}
+
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
 {
     if (!decode_64bit_enabled(ctx)) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 53bbbb761f8..4abc30a6a5f 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -332,10 +332,6 @@ enum {
     OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
-    OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
-    OPC_DMOD_G_2F   = 0x1d | OPC_SPECIAL2,
-    OPC_MODU_G_2F   = 0x1e | OPC_SPECIAL2,
-    OPC_DMODU_G_2F  = 0x1f | OPC_SPECIAL2,
     /* Misc */
     OPC_CLZ      = 0x20 | OPC_SPECIAL2,
     OPC_CLO      = 0x21 | OPC_SPECIAL2,
@@ -369,10 +365,6 @@ enum {
     OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-    OPC_MOD_G_2E    = 0x22 | OPC_SPECIAL3,
-    OPC_MODU_G_2E   = 0x23 | OPC_SPECIAL3,
-    OPC_DMOD_G_2E   = 0x26 | OPC_SPECIAL3,
-    OPC_DMODU_G_2E  = 0x27 | OPC_SPECIAL3,
 
     /* MIPS DSP Load */
     OPC_LX_DSP         = 0x0A | OPC_SPECIAL3,
@@ -3607,42 +3599,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-    case OPC_MOD_G_2E:
-    case OPC_MOD_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_ext32u_tl(t0, t0);
-            tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, INT_MIN, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1, l2);
-            gen_set_label(l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l3);
-        }
-        break;
-    case OPC_MODU_G_2E:
-    case OPC_MODU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_ext32u_tl(t0, t0);
-            tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l2);
-        }
-        break;
 #if defined(TARGET_MIPS64)
     case OPC_DMULT_G_2E:
     case OPC_DMULT_G_2F:
@@ -3652,36 +3608,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
     case OPC_DMULTU_G_2F:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
-    case OPC_DMOD_G_2E:
-    case OPC_DMOD_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
-            gen_set_label(l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l3);
-        }
-        break;
-    case OPC_DMODU_G_2E:
-    case OPC_DMODU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l2);
-        }
-        break;
 #endif
     }
 }
@@ -13543,8 +13469,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
-    case OPC_MOD_G_2F:
-    case OPC_MODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
@@ -13574,8 +13498,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DMULT_G_2F:
     case OPC_DMULTU_G_2F:
-    case OPC_DMOD_G_2F:
-    case OPC_DMODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
@@ -13711,8 +13633,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_MOD_G_2E:
-    case OPC_MODU_G_2E:
     case OPC_MULT_G_2E:
     case OPC_MULTU_G_2E:
         /*
@@ -13979,8 +13899,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 #if defined(TARGET_MIPS64)
     case OPC_DMULT_G_2E:
     case OPC_DMULTU_G_2E:
-    case OPC_DMOD_G_2E:
-    case OPC_DMODU_G_2E:
         check_insn(ctx, INSN_LOONGSON2E);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
-- 
2.45.2


