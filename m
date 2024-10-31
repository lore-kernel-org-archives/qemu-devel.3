Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92C5E68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mic-0001to-Um; Thu, 31 Oct 2024 00:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mib-0001n8-6Z
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:33 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MiZ-0006te-4U
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:32 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb5111747cso4786121fa.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348609; x=1730953409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUVPOYnibuI4tuLgAdfBBa0UcfkSM7OlpkZB5VJi6MM=;
 b=zsWSnpnpllyxjprhZ0Y4j74gZDMupEaK0nCclsFpWBB1dFG55k+sZTpNcABfUW8Du6
 2ud6Y3LQfjJeKGLilvyTxY3iMmtTUk3cf4Y7KH3xXavqTPQrc90LdtSt0ssympvqkm5t
 FamUfE6Nx29C7le3shYzs+TWazjuy5DqkCM/oKQFwjoW1ss5watO/H8ejq+dSIh9VOwq
 sYXDO4x9TnFPjszL6Px2KFk0GLqbC0C9Iep0Zfforh2zIYcI2Ysqi7V6IToGhUxvGAum
 ZEuMaSEKfcmJtnaUUJqyttrj1AgKcFmF2ceqd4DnMb7RM000D2BYMEOF46oTcF0VTnbh
 RdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348609; x=1730953409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUVPOYnibuI4tuLgAdfBBa0UcfkSM7OlpkZB5VJi6MM=;
 b=sm3OiEGGikmRKzQ2yNqt0nVNAfoSHAZuiCSfHYtk84yPDIsiVJaZyZeGTAikU8wfQt
 fSc9tdx3DwU7v74j41x4f1ZIACrtVNmxaoLGucnLyqE0fTlxCpNA0Kq/iaXWpLHaje/k
 +T5HRO0FvF2ikwdWn9QZdMD8goM0O82la2XdNsylyCM9CuHfqx2vgekUo+QtmKGQOgWV
 vlblnvuLRTEM6bFzBMHhd2JyxZkH9NN8lJ7XW8pLMdbSfMzV1Q396Zm+xzRQLzo0pkWD
 /egka7fV5Bx/vgLYnd8LipS2I27uMdSlVnqR6e9yNOP4VhKuuVh051pzcJOjYNwSZIhY
 Vqgg==
X-Gm-Message-State: AOJu0YwKFMuE3InGsHtNzXaKUhyRNwtjdXlH1C08O2I+q7Yv6MfDPvIk
 sWy4OzECzKvMWHfp0MnS3JTOR5f5ylANtzV8kwMaA3mKaGD/hCfH2K1d7rHynQdVrq51Uo4XnOI
 N
X-Google-Smtp-Source: AGHT+IG8GnHKdiO03ETmWhkTYUB1dBD6jUNuKTCH/SVIVCLRJ3tFLj+1dxDrQjea7oJf5x2+wQkheA==
X-Received: by 2002:a05:6512:33c7:b0:539:ea49:d163 with SMTP id
 2adb3069b0e04-53c79e327d4mr871539e87.21.1730348608947; 
 Wed, 30 Oct 2024 21:23:28 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc9becasm77914e87.67.2024.10.30.21.23.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:23:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/14] target/mips: Convert Loongson DIV.G opcodes to decodetree
Date: Thu, 31 Oct 2024 01:21:23 -0300
Message-ID: <20241031042130.98450-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

DIV.G and DDIV.G are very similar. Provide gen_lext_DIV_G() a
'is_double' argument so it can generate DIV.G (divide 32-bit
signed integers).

With this commit we explicit the template used to generate
opcode for 32/64-bit word variants. Next commits will be less
verbose by providing both variants at once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20241026175349.84523-6-philmd@linaro.org>
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


