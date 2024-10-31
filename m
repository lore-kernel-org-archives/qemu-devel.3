Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F296FE68958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mis-0002dm-Sw; Thu, 31 Oct 2024 00:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mir-0002cV-AL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mip-0006uY-3f
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:48 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb5740a03bso4296721fa.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348625; x=1730953425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gg/KjteIAWlAAHvFgfAU18N2daxBJnjbpffs+ITquTk=;
 b=cK9lWOs8i/lljXlYzJRrNauUFPHYb+9tZR12/wrAgwV+QYT0pJqSWwjEHigHFyJJkg
 Cxhdo9FDlM6yTWZbfxNKiKiequQhw47DwDqepmKyBAMQRh+BxGg/cOY3WaEtQVq1iKrQ
 OZAGQJGF089rLKzyg7SRGnl7Y7UiB92Lib0aZUviTF+O9JMbF1Sx3bPGOP7Mkhv45GYa
 /tzeP11u4hVFzeJ8Jq88DzMtmU5X83ZeshCx4UqFFGAL4id5Im4+5Yz5K1u8YcBVvJFr
 neo47DtSpYaIaUwm2jSFHOfeVe4+6PtSGbkXvUZLkFEXzWcWHyH1IcorCHPPump1Q/HO
 yx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348625; x=1730953425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gg/KjteIAWlAAHvFgfAU18N2daxBJnjbpffs+ITquTk=;
 b=wNOYlIxdLZfPrwr8jE4sCtQM3nLaTHoS33DTw/l9oCkwD6z1xq63gRZfe+Xr+EobP/
 jH96g8lDM1/mxvn1iCek8N5/xUmojUEbR4OnQhi6yz84I/zxmA5vXCoypWnyeaHAa1gK
 1roc3Of40SsYx80nLkRaM+g87bOFrHJASpGtyiepHJ5tOKU9shgsDKTevFovB9qQrKvX
 X8W9PQdoM3cCTbOmw2NVq6Wn2AzM2FvZSb+DM/jY+MlWLLyTDulXMpERNdr7BkejmPE8
 1ist1TiPRT/nxAB/Rx0B5XW0k4m03dnVrgSNTIAZaU7JG5Ceby5hMHtkRvaUJTXHCNCJ
 dXmA==
X-Gm-Message-State: AOJu0YwLQnCoLq9ggsWMOqLFrzo/Lc2Fc2sZujSclr5P7cmuf1bbB8FI
 zBI7oNyiMUVmCvJyLmg5XMQtLEW+/Fqc6I9PiIWhNNKPutpS0kvrkmerW6ZCs4i7S8bhPaLtsjO
 j
X-Google-Smtp-Source: AGHT+IElxwlpnWSuv5RRfxnGD5LDk8CoAgH0niI02NXLKBce/d7gaGIlHYLQXRcVuEtjxvPhRQAcXg==
X-Received: by 2002:a2e:5149:0:b0:2fc:9869:2e14 with SMTP id
 38308e7fff4ca-2fd0df91bb1mr21104061fa.45.1730348624792; 
 Wed, 30 Oct 2024 21:23:44 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef617ad0sm930571fa.67.2024.10.30.21.23.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:23:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] target/mips: Convert Loongson [D]DIVU.G opcodes to
 decodetree
Date: Thu, 31 Oct 2024 01:21:24 -0300
Message-ID: <20241031042130.98450-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Convert DIVU.G (divide 32-bit unsigned integers) and DDIVU.G
(divide 64-bit unsigned integers) opcodes to decodetree.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20241026175349.84523-7-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/godson2.decode    |  2 ++
 target/mips/tcg/loong-ext.decode  |  2 ++
 target/mips/tcg/loong_translate.c | 54 +++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       | 37 ---------------------
 4 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index cbf24ed88da..581cb9c8608 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -14,4 +14,6 @@
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
 DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
+DIVU_G          011111 ..... ..... ..... 00000 011011   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
+DDIVU_G         011111 ..... ..... ..... 00000 011111   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index 9397606beb6..e222167af56 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -16,3 +16,5 @@
 
 DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
+DIVU_G          011100 ..... ..... ..... 00000 010110   @rs_rt_rd
+DDIVU_G         011100 ..... ..... ..... 00000 010111   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index 7c405078795..903d242e7cc 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -87,6 +87,60 @@ static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
     return gen_lext_DIV_G(s, a->rt, a->rs, a->rd, true);
 }
 
+static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
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
+
+    tcg_gen_br(l2);
+    gen_set_label(l1);
+    tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+    gen_set_label(l2);
+
+    return true;
+}
+
+static bool trans_DIVU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIVU_G(s, a->rt, a->rs, a->rd, false);
+}
+
+static bool trans_DDIVU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIVU_G(s, a->rt, a->rs, a->rd, true);
+}
+
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
 {
     if (!decode_64bit_enabled(ctx)) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 1c38e893d31..53bbbb761f8 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -332,8 +332,6 @@ enum {
     OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
-    OPC_DIVU_G_2F   = 0x16 | OPC_SPECIAL2,
-    OPC_DDIVU_G_2F  = 0x17 | OPC_SPECIAL2,
     OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
     OPC_DMOD_G_2F   = 0x1d | OPC_SPECIAL2,
     OPC_MODU_G_2F   = 0x1e | OPC_SPECIAL2,
@@ -369,10 +367,8 @@ enum {
     /* Loongson 2E */
     OPC_MULT_G_2E   = 0x18 | OPC_SPECIAL3,
     OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
-    OPC_DIVU_G_2E   = 0x1B | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-    OPC_DDIVU_G_2E  = 0x1F | OPC_SPECIAL3,
     OPC_MOD_G_2E    = 0x22 | OPC_SPECIAL3,
     OPC_MODU_G_2E   = 0x23 | OPC_SPECIAL3,
     OPC_DMOD_G_2E   = 0x26 | OPC_SPECIAL3,
@@ -3611,22 +3607,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-    case OPC_DIVU_G_2E:
-    case OPC_DIVU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_ext32u_tl(t0, t0);
-            tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l2);
-        }
-        break;
     case OPC_MOD_G_2E:
     case OPC_MOD_G_2F:
         {
@@ -3672,19 +3652,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
     case OPC_DMULTU_G_2F:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
-    case OPC_DDIVU_G_2E:
-    case OPC_DDIVU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l2);
-        }
-        break;
     case OPC_DMOD_G_2E:
     case OPC_DMOD_G_2F:
         {
@@ -13574,7 +13541,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
-    case OPC_DIVU_G_2F:
     case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
     case OPC_MOD_G_2F:
@@ -13608,7 +13574,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DMULT_G_2F:
     case OPC_DMULTU_G_2F:
-    case OPC_DDIVU_G_2F:
     case OPC_DMOD_G_2F:
     case OPC_DMODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
@@ -13746,7 +13711,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_DIVU_G_2E:
     case OPC_MOD_G_2E:
     case OPC_MODU_G_2E:
     case OPC_MULT_G_2E:
@@ -14013,7 +13977,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DDIVU_G_2E:
     case OPC_DMULT_G_2E:
     case OPC_DMULTU_G_2E:
     case OPC_DMOD_G_2E:
-- 
2.45.2


