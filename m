Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8E0D0C604
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kzq-00009G-VD; Sat, 26 Oct 2024 13:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzl-0008SR-Ec
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzj-0003nR-NU
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so2213291b3a.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965274; x=1730570074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KBvUzE3FvkNEc6QOdcBPvo3b06MwM+iF0QLuALYnNs=;
 b=dO84m7v3p/UBEvcQFeZl9pBtNdTRc3O+ZY70Dkj166n7mHz7HrSaZYFGFjWFPWcJUi
 rOV1LPxWlZNMZwifrcLHklCB+hK2nFswjGnCSn13k/hQmhCpw5sORarXtDgjYXBkS8uD
 4cvg3Xj5sL7YW+eEgzVoJOL1thyBN08OebDCAIf0de4+VKJwtl1dnI1IlW7amsoouI9n
 SktPr2pj/4BbcDYqh8rXc9SHllOSUhBflsKVRY9tT4bkHBUcq2iyaYct+Lw7TIBhVnuP
 MYAVDrUc4Xo9VRlXsglAxIItxTgwPOZrNl3mOVQOJjQaDxmp7P57w9EnqFxfGyiGsPWq
 bgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965274; x=1730570074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KBvUzE3FvkNEc6QOdcBPvo3b06MwM+iF0QLuALYnNs=;
 b=EGI4hgU4NOdU/YKg3tgcpusia7TvG2VgSHPEr8miV7RY4ahhb/hIRhKGhR/wO6nGir
 rH+MA2A4q3Ie3rdFIGMvYOh6F7HsnT1dXvcuIoGSf+CqukQd4xoD5Ww4Ui6riMiodzWS
 W8k0tc7l31b80mk0GqyFABF75nZYOqSSq54lyXTN8zcA3Ge3TmlO75iEcIplEQgLMKqn
 n0MbdF69fHj4Yp3CvEk1uQlmi6NDjNDrJq9ZOcIG8+x+OxUe3p+/cFiMfuzflBmkscxD
 61GDFsawB+tTBsHxKcl38FoGTxf0N3Eg1QBbtE4B4vUZxYCRzy+7neG3BbwVp9bYI0ir
 4ibA==
X-Gm-Message-State: AOJu0YyxYCVPcYVfKfDYLkoHOweR+jowCGjRsyUkZS2xLFiUb8RsE3YK
 EYaxYlV6IIssTL8lkDiUAEc1cuJbv/E0xcwy6/aAvZvjVeYEN6oCJI7+PhlcK5hwJYgHfbAuN2e
 P
X-Google-Smtp-Source: AGHT+IHR9pebrGClHycLKi7HtSdYHR308P1w7n77crPlLxcWXhBIMlR42V5ma0BPApzf4drs37BjYQ==
X-Received: by 2002:a05:6a00:2e25:b0:71e:1722:d019 with SMTP id
 d2e1a72fcca58-7206306e03cmr5554786b3a.22.1729965273791; 
 Sat, 26 Oct 2024 10:54:33 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a0df99sm2981983b3a.118.2024.10.26.10.54.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:54:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/9] target/mips: Convert Loongson DIV.G opcodes to
 decodetree
Date: Sat, 26 Oct 2024 14:53:45 -0300
Message-ID: <20241026175349.84523-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42f.google.com
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

DIV.G and DDIV.G are very similar. Provide gen_lext_DIV_G() a
'is_double' argument so it can generate DIV.G (divide 32-bit
signed integers).

With this commit we explicit the template used to generate
opcode for 32/64-bit word variants. Next commits will be less
verbose by providing both variants at once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/godson2.decode    |  1 +
 target/mips/tcg/loong-ext.decode  |  1 +
 target/mips/tcg/loong_translate.c | 28 ++++++++++++++++++++++------
 target/mips/tcg/translate.c       | 26 --------------------------
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index 47ea5a1c438..cbf24ed88da 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -13,4 +13,5 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index 8b78ec48599..9397606beb6 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -14,4 +14,5 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index 53e4047cfa0..7c405078795 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -25,15 +25,18 @@
  * one result into general-purpose registers.
  */
 
-static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt)
+static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
+                           bool is_double)
 {
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (TARGET_LONG_BITS != 64) {
-        return false;
+    if (is_double) {
+        if (TARGET_LONG_BITS != 64) {
+            return false;
+        }
+        check_mips_64(s);
     }
-    check_mips_64(s);
 
     if (rd == 0) {
         /* Treat as NOP. */
@@ -49,26 +52,39 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt)
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
 
+    if (!is_double) {
+        tcg_gen_ext32s_tl(t0, t0);
+        tcg_gen_ext32s_tl(t1, t1);
+    }
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
     tcg_gen_movi_tl(cpu_gpr[rd], 0);
     tcg_gen_br(l3);
     gen_set_label(l1);
 
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
+                                        ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     tcg_gen_mov_tl(cpu_gpr[rd], t0);
 
     tcg_gen_br(l3);
     gen_set_label(l2);
     tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
     gen_set_label(l3);
 
     return true;
 }
 
+static bool trans_DIV_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd, false);
+}
+
 static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
 {
-    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd);
+    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd, true);
 }
 
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 73445dd9074..1c38e893d31 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -332,7 +332,6 @@ enum {
     OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
-    OPC_DIV_G_2F    = 0x14 | OPC_SPECIAL2,
     OPC_DIVU_G_2F   = 0x16 | OPC_SPECIAL2,
     OPC_DDIVU_G_2F  = 0x17 | OPC_SPECIAL2,
     OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
@@ -370,7 +369,6 @@ enum {
     /* Loongson 2E */
     OPC_MULT_G_2E   = 0x18 | OPC_SPECIAL3,
     OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
-    OPC_DIV_G_2E    = 0x1A | OPC_SPECIAL3,
     OPC_DIVU_G_2E   = 0x1B | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
@@ -3613,28 +3611,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-    case OPC_DIV_G_2E:
-    case OPC_DIV_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_ext32s_tl(t0, t0);
-            tcg_gen_ext32s_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, INT_MIN, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1, l2);
-            tcg_gen_mov_tl(cpu_gpr[rd], t0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l3);
-        }
-        break;
     case OPC_DIVU_G_2E:
     case OPC_DIVU_G_2F:
         {
@@ -13598,7 +13574,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
-    case OPC_DIV_G_2F:
     case OPC_DIVU_G_2F:
     case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
@@ -13771,7 +13746,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_DIV_G_2E:
     case OPC_DIVU_G_2E:
     case OPC_MOD_G_2E:
     case OPC_MODU_G_2E:
-- 
2.45.2


