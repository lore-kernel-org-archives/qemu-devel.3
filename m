Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B53E68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MiQ-0001OA-2L; Thu, 31 Oct 2024 00:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MiN-0001EF-EY
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:19 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MiL-0006tC-9U
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:19 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f8490856so524047e87.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348595; x=1730953395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILZUHyaOqbrv0aSt3tz0yBDXQDHRKNcl8J2Q6tBi0CQ=;
 b=i+e65IXiS31VT9RM6/qyPzCnEsneMyB98PTc2/Xva7KGcKkoYLGfya8cZ6aXC02YnC
 PxWCdiydUKivXIkash/AXWOAdaVHLBjx1d7Iid7xQQLQ84WghpIVKU+33q62a8CWgyT9
 MuMuGTKShTaJZOxd66pc83l3HL+4gH1r4HFfKbSah4H5quFx5PUAVZiO6HIcrLyiXdoG
 37ZLQSpfpPklmavGRKf9w2lK/RGKXEmFfqDmcElOXhfvXNbbzv0TmGxp0X4JdLQbbOUP
 6W06PhwH+duGSomSEwgrVLoW0NHvCtBOPgqnvhx8fh1rXTA54E0BNJ9SpzHWBI8dMgcD
 +DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348595; x=1730953395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILZUHyaOqbrv0aSt3tz0yBDXQDHRKNcl8J2Q6tBi0CQ=;
 b=c/PuAdSvHkuTb2dK2rHrkdBNhV1NO0p+4XIfJ+iOftQc65mu0x737jWUU5vQiBIaWM
 CwRRuFLfLa6B6cUkHBEBLZyGNA9qvSv/WMLfzuOSpvaPgTngFhi48TynWmBmNuKW0v/a
 3zg9hMUi3d38IlXVjuNeifI8ONshAwbR2cnRydyy09rz0s5BeethFrsTqlM5n8UWgTA8
 r4+OCJbvX8UzXnFjm1OIRYh3LDieCxaQmptv9FnCT8fYQs1VsBdRWnjiKEJTD6gdbSXF
 rKjk0+lyFDgd/sUkV1Pq9ZFpzP58UT6zdkrLevX3bokGKfv2ViJ+F5wPleHvQJ4eLtff
 joaQ==
X-Gm-Message-State: AOJu0YwMNTqJ96b/J7twKtoafnPjvnpSkkzOf8XysC/cNR0wl7UxpHW4
 75a6D4BV7hDamwaqskCJhX/IbIoU26NAHsg7+nqVCoXY1nK5LdkjnVtgaXCJ8tjJfzRUnpPULXN
 P
X-Google-Smtp-Source: AGHT+IFwRIXI9vnqA9ZxAF2hVsdOqiROTul1v/EYCYoOn1KpYDiMaU1NrrMie7+E4UgrrolEWRo1kg==
X-Received: by 2002:a05:6512:12d1:b0:539:f035:e158 with SMTP id
 2adb3069b0e04-53c79e322eamr777149e87.18.1730348594743; 
 Wed, 30 Oct 2024 21:23:14 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc961cfsm78333e87.23.2024.10.30.21.23.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:23:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] target/mips: Convert Loongson DDIV.G opcodes to
 decodetree
Date: Thu, 31 Oct 2024 01:21:22 -0300
Message-ID: <20241031042130.98450-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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
index 00000000000..53e4047cfa0
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
+    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd);
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
index ea7fb582f2a..fd91148df74 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,4 +1,6 @@
 gen = [
+  decodetree.process('godson2.decode', extra_args: ['--static-decode=decode_godson2']),
+  decodetree.process('loong-ext.decode', extra_args: ['--static-decode=decode_loong_ext']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
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


