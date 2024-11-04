Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCB4D132AC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uhy-00028z-R2; Mon, 04 Nov 2024 05:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uhx-00025X-AB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:53:17 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uhv-0003kX-5F
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:53:17 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53c779ef19cso4656803e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730717593; x=1731322393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgccnnP+UjvTX7aelAiFn+L5m3xGf23vKE71VUw8sm8=;
 b=jOyuHkB5AxtG0eqJeOgUE2tpRjBaBphBb1CTxBUNWTpQUddGJn50/Ismp5l2IgQSKH
 83CrH603lsUhJfe8/8t4Si4pVphJJnve7ADivICOU8Fg0ARF6fUA2c3OAcbqGyc1mnRV
 Ww/WMN/CYn8s5j6omEeSCfmLJSlOQilxLE6mXjpyP09/v6SZT6TpEgYUgEsiYYK4vStk
 miKFxR+YukPItpQoho2i9FlMp+4yuT9UVpeJqFxNWbIXA6mgphaUJPy/3tALOo6ww7yg
 81GXbbr39uLQTd3G3khIy+v+WEjN22f7XW51T6Ze/Jzwt6IKUd8Qpm4zlUaMBu0ygzJZ
 XM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717593; x=1731322393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgccnnP+UjvTX7aelAiFn+L5m3xGf23vKE71VUw8sm8=;
 b=nvCG0i9xqomytLtobBqScLcYFUH12pswqZSI8dVbPsW6Yrmt6byODQlqRIG0gCpjFB
 h7vU/66QCjXRoGJAIBbcECKFa/N53O/wYv4ClhsyzgmEMb5P3K3qQVaWjui9oMaGklPP
 9RFNTQ0ljK2kMr3a8+wVAb4do2KqJ/V3I/OTHXg8feXPLgaIl3COQNh6UWvXGBJubWm6
 GK+47LMX+r+dT0wJAS1ZyJHFyHKuf8gFNrGu6TrJA5itXdZ4zHoX7RKSbk9OUFXUgEvG
 QXr/j425rcQewfiquk1MQdFHnij40RSDaVYI5H30IKe0oAAnCuSPa+/5Kcp5o0JXSiiD
 Rjcw==
X-Gm-Message-State: AOJu0YwY+FIpoy5H6v3k9/kYf39d4Fzz8Y2kxiqLMQNr+jAriP+TQ6jA
 Mv/2Uk74Lg9304Aa3EsZL0BxAb92yX0keAxdpolpBSqGAY1BRTIyYhazZUmTGyxL/B7x+WYCBIW
 PkS0=
X-Google-Smtp-Source: AGHT+IHt4BkP7NW8/lWFMsCN90Bj0qwvkYQoS0v+HqkV1QZkQzqp5lanLIDwZuG/aj2PTH21WrfRcQ==
X-Received: by 2002:a05:6512:12d3:b0:536:54db:ddd0 with SMTP id
 2adb3069b0e04-53c79c976aamr6560917e87.0.1730717593063; 
 Mon, 04 Nov 2024 02:53:13 -0800 (PST)
Received: from localhost.localdomain ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983f6sm153743505e9.45.2024.11.04.02.53.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Nov 2024 02:53:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/14] target/mips: Convert Loongson [D]MOD[U].G opcodes to
 decodetree
Date: Mon,  4 Nov 2024 11:52:48 +0100
Message-ID: <20241104105250.57818-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104105250.57818-1-philmd@linaro.org>
References: <20241104105250.57818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Convert the following opcodes to decodetree:

- MOD.G - mod 32-bit signed integers
- MODU.G - mod 32-bit unsigned integers
- DMOD.G - mod 64-bit signed integers
- DMODU.G - mod 64-bit unsigned integers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20241026175349.84523-8-philmd@linaro.org>
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
index 2484b8a68df..39afed7d5f8 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -141,6 +141,117 @@ static bool trans_DDIVU_G(DisasContext *s, arg_muldiv *a)
     return gen_lext_DIVU_G(s, a->rd, a->rs, a->rt, true);
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
+    return gen_lext_MOD_G(s, a->rd, a->rs, a->rt, false);
+}
+
+static bool trans_DMOD_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MOD_G(s, a->rd, a->rs, a->rt, true);
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
+    return gen_lext_MODU_G(s, a->rd, a->rs, a->rt, false);
+}
+
+static bool trans_DMODU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MODU_G(s, a->rd, a->rs, a->rt, true);
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


