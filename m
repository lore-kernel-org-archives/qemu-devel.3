Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3FBD132AC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ui5-0002IQ-OA; Mon, 04 Nov 2024 05:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7ui3-0002Hz-N8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:53:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7ui0-0003lB-6s
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:53:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so32797935e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730717598; x=1731322398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Om9Q9PGKk/UF65qdPUh6d8av12A8OcOH/KLRvQy/nCI=;
 b=oJUGLPQHulLVIcR0W5IXzWRioBuZCIUjE8d7vC3jPed5wayJBXwIL7Sj/P1nwF65O4
 OC+2qsTZYZWeImO7K/xmmNIKLg5FN1C3nR+kq07m17e+Nx7ARne2yDE6viUekDVQD9Y7
 KaeeF1mBNvQ4Y4NjIAvRSxVnOxJ7yUJqhXJG7Th0Iaoj1C9OsZ8d4T8fxVt78qmM5Oza
 unc3IA9GSiaSnn25qLlGsb0UzFcVTUzCQrpiNG8KJqOKFopHdc5fJxbZxo+4RVpyTyO5
 PcvJPKpOl2CAOezkETpYQlEXY7Z7n5vOAcb4aw2UKiFGthnHRaJB035BB5ejMDPPom0P
 zI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717598; x=1731322398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Om9Q9PGKk/UF65qdPUh6d8av12A8OcOH/KLRvQy/nCI=;
 b=JIPw3SEQirxhX8fd9V76nt/n5UI4RovtkoTGk4A+s8S5tVYht5TQGgTA4QG8N00wwH
 woRe1i9COQW1UTlMddOh20hKZ4pNkBlMO8B09LA8gATYzjIWAvM2oCyd+NopOdiQLf9b
 aPGRupn85VkQ1lf55O5zHedAHpxQv1hWczFEE4Y/tzrpULy5Ysbl1J0SkYso/n60EHaH
 rc2w2RimvB5bQVjrFwCT8Ol5o7DrsKKZ3rhQr3sgiv1f72pbVHBRcHDmOPE3z+ToTuN0
 rJIy8113BqXKsTtiGo3RvxYx9A/zkQdkX9CoAhGWxg3o1brXDrAT/pzll3/oSupPFFX8
 u9mg==
X-Gm-Message-State: AOJu0YzO8bK2XdtrmlaCli1sK4zNBrR4FGW6NEGba6IFYWDAjzVYGDPh
 OT7rUHl+cQLWe7rfIMlACJvXcAAvvc4Q4bi22AF5+fpxyRikzIE3ryXdd5xO9qKh6KhwcgfbDtE
 81H0=
X-Google-Smtp-Source: AGHT+IGwK5E+m08LuG1aMGxi5UxuDMEGqz6Y1IEYIe86D8SvmFAOw9TFwgzJURK6Iotg7554N3ZOfg==
X-Received: by 2002:a05:600c:3c9d:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-4328327e6ddmr95363705e9.27.1730717598256; 
 Mon, 04 Nov 2024 02:53:18 -0800 (PST)
Received: from localhost.localdomain ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a99d3sm180550005e9.38.2024.11.04.02.53.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Nov 2024 02:53:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/14] target/mips: Convert Loongson [D]MULT[U].G opcodes to
 decodetree
Date: Mon,  4 Nov 2024 11:52:49 +0100
Message-ID: <20241104105250.57818-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104105250.57818-1-philmd@linaro.org>
References: <20241104105250.57818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

- MULT.G - multiply 32-bit signed integers
- MULTU.G - multiply 32-bit unsigned integers
- DMULT.G - multiply 64-bit signed integers
- DMULTU.G - multiply 64-bit unsigned integers

Now that all opcodes from the extension have been converted, we
can remove completely gen_loongson_integer() and its 2 calls in
decode_opc_special2_legacy() and decode_opc_special3_legacy().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241026175349.84523-9-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/godson2.decode    |  3 ++
 target/mips/tcg/loong-ext.decode  |  3 ++
 target/mips/tcg/loong_translate.c | 41 +++++++++++++++++
 target/mips/tcg/translate.c       | 73 +------------------------------
 4 files changed, 49 insertions(+), 71 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index c03c8b717d9..25b396b6822 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -13,6 +13,9 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+MULTu_G         011111 ..... ..... ..... 00000 01100-   @rs_rt_rd
+DMULTu_G        011111 ..... ..... ..... 00000 01110-   @rs_rt_rd
+
 DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
 DIVU_G          011111 ..... ..... ..... 00000 011011   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index f0fd36c9218..b43979d0ef5 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -14,6 +14,9 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+MULTu_G         011100 ..... ..... ..... 00000 0100-0   @rs_rt_rd
+DMULTu_G        011100 ..... ..... ..... 00000 0100-1   @rs_rt_rd
+
 DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
 DIVU_G          011100 ..... ..... ..... 00000 010110   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index 39afed7d5f8..87e7122b9a1 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -252,6 +252,47 @@ static bool trans_DMODU_G(DisasContext *s, arg_muldiv *a)
     return gen_lext_MODU_G(s, a->rd, a->rs, a->rt, true);
 }
 
+static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
+                            bool is_double)
+{
+    TCGv t0, t1;
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
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+
+    return true;
+}
+
+static bool trans_MULTu_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MULT_G(s, a->rd, a->rs, a->rt, false);
+}
+
+static bool trans_DMULTu_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MULT_G(s, a->rd, a->rs, a->rt, true);
+}
+
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
 {
     if (!decode_64bit_enabled(ctx)) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 4abc30a6a5f..2d01f5c4a8b 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -327,11 +327,6 @@ enum {
     OPC_MUL      = 0x02 | OPC_SPECIAL2,
     OPC_MSUB     = 0x04 | OPC_SPECIAL2,
     OPC_MSUBU    = 0x05 | OPC_SPECIAL2,
-    /* Loongson 2F */
-    OPC_MULT_G_2F   = 0x10 | OPC_SPECIAL2,
-    OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
-    OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
-    OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
     /* Misc */
     OPC_CLZ      = 0x20 | OPC_SPECIAL2,
     OPC_CLO      = 0x21 | OPC_SPECIAL2,
@@ -360,12 +355,6 @@ enum {
     OPC_RDHWR    = 0x3B | OPC_SPECIAL3,
     OPC_GINV     = 0x3D | OPC_SPECIAL3,
 
-    /* Loongson 2E */
-    OPC_MULT_G_2E   = 0x18 | OPC_SPECIAL3,
-    OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
-    OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
-    OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-
     /* MIPS DSP Load */
     OPC_LX_DSP         = 0x0A | OPC_SPECIAL3,
     /* MIPS DSP Arithmetic */
@@ -3572,46 +3561,6 @@ static void gen_cl(DisasContext *ctx, uint32_t opc,
     }
 }
 
-/* Godson integer instructions */
-static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
-                                 int rd, int rs, int rt)
-{
-    TCGv t0, t1;
-
-    if (rd == 0) {
-        /* Treat as NOP. */
-        return;
-    }
-
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
-
-    switch (opc) {
-    case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-        break;
-    case OPC_MULTU_G_2E:
-    case OPC_MULTU_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-        break;
-#if defined(TARGET_MIPS64)
-    case OPC_DMULT_G_2E:
-    case OPC_DMULT_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        break;
-    case OPC_DMULTU_G_2E:
-    case OPC_DMULTU_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        break;
-#endif
-    }
-}
-
 /* Loongson multimedia instructions */
 static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 {
@@ -13467,11 +13416,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
-    case OPC_MULT_G_2F:
-    case OPC_MULTU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
-        gen_loongson_integer(ctx, op1, rd, rs, rt);
-        break;
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS_R1);
@@ -13496,11 +13440,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         check_mips_64(ctx);
         gen_cl(ctx, op1, rd, rs);
         break;
-    case OPC_DMULT_G_2F:
-    case OPC_DMULTU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
-        gen_loongson_integer(ctx, op1, rd, rs, rt);
-        break;
 #endif
     default:            /* Invalid */
         MIPS_INVAL("special2_legacy");
@@ -13633,10 +13572,9 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_MULT_G_2E:
-    case OPC_MULTU_G_2E:
+    case OPC_MUL_PH_DSP:
         /*
-         * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
+         * OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
          * the same mask and op1.
          */
         if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MUL_PH_DSP)) {
@@ -13667,8 +13605,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
                 gen_reserved_instruction(ctx);
                 break;
             }
-        } else if (ctx->insn_flags & INSN_LOONGSON2E) {
-            gen_loongson_integer(ctx, op1, rd, rs, rt);
         } else {
             gen_reserved_instruction(ctx);
         }
@@ -13897,11 +13833,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DMULT_G_2E:
-    case OPC_DMULTU_G_2E:
-        check_insn(ctx, INSN_LOONGSON2E);
-        gen_loongson_integer(ctx, op1, rd, rs, rt);
-        break;
     case OPC_ABSQ_S_QH_DSP:
         op2 = MASK_ABSQ_S_QH(ctx->opcode);
         switch (op2) {
-- 
2.45.2


