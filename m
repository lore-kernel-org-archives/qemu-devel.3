Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC8ED132AB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uhm-0001v9-4C; Mon, 04 Nov 2024 05:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uhj-0001uw-1s
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:53:03 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uhf-0003ip-LA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:53:02 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53a097aa3daso3693731e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730717577; x=1731322377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJ/L9dFPSPVFQVZy18IjLJxHNsXiBznVxbsWZ2vhz6A=;
 b=x4eW3cq0fb1jl5yR+XWikyVJXA0WuoYpf190jMQkLctDt9FZzqI+eTlcJJiLUbHb90
 peC+VsD3bp4Hr4eN/uD78mKZHTBbxAg/9ch3ZbixnrdfKnkJlfGxzDsNJI16NM8jhIuh
 qM1IMvkRaYxWlni8aBPii/4d0TyI5fSFVvPSfxgti+ka0Um0viKlfBGw8kS4Dcs4LEvx
 /hYdiWVo234Z7XyCN5cRAQZ/yYWj6LLMn4aqz78a2SdfpZqYSlx51HknE77NdcIZeSyC
 f6m1UoXJqdjFLEEY31jtqyJcH/FvgkLosilPMRtWOPVGRyzRuSoFY5GXLAXsNqE7Oj+W
 cpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717577; x=1731322377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJ/L9dFPSPVFQVZy18IjLJxHNsXiBznVxbsWZ2vhz6A=;
 b=n8Dr8l1DG2GLYMGG8yzuUYvXRSX6abySANY/1rNETnGD4LZatmakw95TRi9wwaGZxP
 Hv1R2w63YzNq+kxORZ2gQgTcAWwgoJ7/rTke2/8sK4QYGRyPJUQHh+ZiMaTqDGm0TTAC
 PZRzTi7Ia+nWL0GZzJU/VUtgcKKRUMKyH72yYsOmwmi0t6SIn9nRtGMs1YPxNf52m1JR
 ubNhYUQIByljQdNmCDigJmkkmLs3RGWj2hAiIYt7vNzD5KHNjce1wrxf4rNL6X0Qm6Zt
 B+DmY4TkqsfjTnNpH2vBPCEs7NLOn/unalohvQ2baxOQ1/EwX0zN8UJXVXLNPiGHQpgX
 89qA==
X-Gm-Message-State: AOJu0YywV0tL/n8j875WVzy4JABm6H/2Toj7WHGu3FJwTYwaHVBMX8Iq
 ZRiRpOA+oYh0pRq4EGbCb5ShxxB1ewbR1UXpnNiOyUH2W9ofGOKBL43RNjtJNHgZutDgdyG0QND
 +jeQ=
X-Google-Smtp-Source: AGHT+IFffErjvcL5Ibzr0seRFP7xLu1mjUBogyB/QrpkS0bngYZ935y2Un73rcte+YHRCVX3pDkWow==
X-Received: by 2002:a05:6512:280a:b0:537:a824:7e5 with SMTP id
 2adb3069b0e04-53d65df26afmr5021513e87.18.1730717577435; 
 Mon, 04 Nov 2024 02:52:57 -0800 (PST)
Received: from localhost.localdomain ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd947b2bsm184406465e9.25.2024.11.04.02.52.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Nov 2024 02:52:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] target/mips: Convert Loongson DDIV.G opcodes to
 decodetree
Date: Mon,  4 Nov 2024 11:52:45 +0100
Message-ID: <20241104105250.57818-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104105250.57818-1-philmd@linaro.org>
References: <20241104105250.57818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Introduce decode_loongson() to decode all Loongson vendor
specific opcodes. Start converting a single opcode: DDIV.G
(divide 64-bit signed integers).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20241026175349.84523-5-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h       |  1 +
 target/mips/tcg/godson2.decode    | 16 ++++++
 target/mips/tcg/loong-ext.decode  | 17 ++++++
 target/mips/tcg/loong_translate.c | 86 +++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       | 26 ++--------
 target/mips/tcg/meson.build       |  3 ++
 6 files changed, 126 insertions(+), 23 deletions(-)
 create mode 100644 target/mips/tcg/godson2.decode
 create mode 100644 target/mips/tcg/loong-ext.decode
 create mode 100644 target/mips/tcg/loong_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index ae6c25aa0c4..23a489c0f38 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -223,6 +223,7 @@ bool decode_64bit_enabled(DisasContext *ctx);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
+bool decode_ext_loongson(DisasContext *ctx, uint32_t insn);
 #if defined(TARGET_MIPS64)
 bool decode_ase_lcsr(DisasContext *ctx, uint32_t insn);
 bool decode_ext_tx79(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
new file mode 100644
index 00000000000..47ea5a1c438
--- /dev/null
+++ b/target/mips/tcg/godson2.decode
@@ -0,0 +1,16 @@
+# Godson2 64-bit Integer instructions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference:
+#       Godson-2E Software Manual
+#       (Document Number: godson2e-user-manual-V0.6)
+#
+
+&muldiv         rs rt rd
+
+@rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
+
+DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
new file mode 100644
index 00000000000..8b78ec48599
--- /dev/null
+++ b/target/mips/tcg/loong-ext.decode
@@ -0,0 +1,17 @@
+# Loongson 64-bit Extension instructions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference:
+#       STLS2F01 User Manual
+#       Appendix A: new integer instructions
+#       (Document Number: UM0447)
+#
+
+&muldiv         rs rt rd !extern
+
+@rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
+
+DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
new file mode 100644
index 00000000000..55adc0f6fc4
--- /dev/null
+++ b/target/mips/tcg/loong_translate.c
@@ -0,0 +1,86 @@
+/*
+ * MIPS Loongson 64-bit translation routines
+ *
+ *  Copyright (c) 2004-2005 Jocelyn Mayer
+ *  Copyright (c) 2006 Marius Groeger (FPU operations)
+ *  Copyright (c) 2006 Thiemo Seufer (MIPS32R2 support)
+ *  Copyright (c) 2011 Richard Henderson <rth@twiddle.net>
+ *  Copyright (c) 2021 Philippe Mathieu-Daudé
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+/* Include the auto-generated decoder.  */
+#include "decode-godson2.c.inc"
+#include "decode-loong-ext.c.inc"
+
+/*
+ * Word or double-word Fixed-point instructions.
+ * ---------------------------------------------
+ *
+ * Fixed-point multiplies and divisions write only
+ * one result into general-purpose registers.
+ */
+
+static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt)
+{
+    TCGv t0, t1;
+    TCGLabel *l1, *l2, *l3;
+
+    if (TARGET_LONG_BITS != 64) {
+        return false;
+    }
+    check_mips_64(s);
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
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
+    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_br(l3);
+    gen_set_label(l1);
+
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
+    tcg_gen_mov_tl(cpu_gpr[rd], t0);
+
+    tcg_gen_br(l3);
+    gen_set_label(l2);
+    tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
+    gen_set_label(l3);
+
+    return true;
+}
+
+static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIV_G(s, a->rd, a->rs, a->rt);
+}
+
+bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
+{
+    if (!decode_64bit_enabled(ctx)) {
+        return false;
+    }
+    if ((ctx->insn_flags & INSN_LOONGSON2E) && decode_godson2(ctx, ctx->opcode)) {
+        return true;
+    }
+    if ((ctx->insn_flags & ASE_LEXT) && decode_loong_ext(ctx, ctx->opcode)) {
+        return true;
+    }
+    return false;
+}
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 509488fdc7a..73445dd9074 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -333,7 +333,6 @@ enum {
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
     OPC_DIV_G_2F    = 0x14 | OPC_SPECIAL2,
-    OPC_DDIV_G_2F   = 0x15 | OPC_SPECIAL2,
     OPC_DIVU_G_2F   = 0x16 | OPC_SPECIAL2,
     OPC_DDIVU_G_2F  = 0x17 | OPC_SPECIAL2,
     OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
@@ -375,7 +374,6 @@ enum {
     OPC_DIVU_G_2E   = 0x1B | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-    OPC_DDIV_G_2E   = 0x1E | OPC_SPECIAL3,
     OPC_DDIVU_G_2E  = 0x1F | OPC_SPECIAL3,
     OPC_MOD_G_2E    = 0x22 | OPC_SPECIAL3,
     OPC_MODU_G_2E   = 0x23 | OPC_SPECIAL3,
@@ -3698,25 +3696,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
     case OPC_DMULTU_G_2F:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
-    case OPC_DDIV_G_2E:
-    case OPC_DDIV_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
-            tcg_gen_mov_tl(cpu_gpr[rd], t0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l3);
-        }
-        break;
     case OPC_DDIVU_G_2E:
     case OPC_DDIVU_G_2F:
         {
@@ -13654,7 +13633,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DMULT_G_2F:
     case OPC_DMULTU_G_2F:
-    case OPC_DDIV_G_2F:
     case OPC_DDIVU_G_2F:
     case OPC_DMOD_G_2F:
     case OPC_DMODU_G_2F:
@@ -14061,7 +14039,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DDIV_G_2E:
     case OPC_DDIVU_G_2E:
     case OPC_DMULT_G_2E:
     case OPC_DMULTU_G_2E:
@@ -15262,6 +15239,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     if (cpu_supports_isa(env, INSN_VR54XX) && decode_ext_vr54xx(ctx, ctx->opcode)) {
         return;
     }
+    if (TARGET_LONG_BITS == 64 && decode_ext_loongson(ctx, ctx->opcode)) {
+        return;
+    }
 #if defined(TARGET_MIPS64)
     if (ase_lcsr_available(env) && decode_ase_lcsr(ctx, ctx->opcode)) {
         return;
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index ea7fb582f2a..7b18e6c4c8b 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -5,6 +5,8 @@ gen = [
   decodetree.process('vr54xx.decode', extra_args: '--decode=decode_ext_vr54xx'),
   decodetree.process('octeon.decode', extra_args: '--decode=decode_ext_octeon'),
   decodetree.process('lcsr.decode', extra_args: '--decode=decode_ase_lcsr'),
+  decodetree.process('godson2.decode', extra_args: ['--static-decode=decode_godson2']),
+  decodetree.process('loong-ext.decode', extra_args: ['--static-decode=decode_loong_ext']),
 ]
 
 mips_ss.add(gen)
@@ -28,6 +30,7 @@ mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
   'tx79_translate.c',
   'octeon_translate.c',
   'lcsr_translate.c',
+  'loong_translate.c',
 ), if_false: files(
   'mxu_translate.c',
 ))
-- 
2.45.2


