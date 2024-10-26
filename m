Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4D1D10C00
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kzy-0000HN-30; Sat, 26 Oct 2024 13:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzs-0000FM-VN
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzr-0003np-8g
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so2213317b3a.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965282; x=1730570082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iV54wQsewAL+j9xIJrgm9X//KUANhnDc29VNVi92QVg=;
 b=nPKX+Fs+RFWHgnOH4YxEQ64xuXwpNi4IDDIi7h8IYLBr3/eAHqhdkmmagEn06GtJI9
 vqu/I9/nqVYdJUD9mVRC6dy5ylPB60eJwkBkTfV7QA/0AO9k9EcWOchsT/gSmq6lT61T
 ++nOq3YxgfGs6yZbV32NF5RKF4FygdJYjMivmAss9G1HE0LfpvZUAEWO6JnObG1MydnP
 zL2MMXssC9P43nw0xSADq8QhaPhxWPgUNiwb1o98q4b0gr2AjMy14PqOotkngmAZarQu
 7FgMoJtwUYbClTkHBKdawnJoTniADaCNyOHnccv34GFRhbJpdeIPDU2DgOJtZ74fZQ0L
 MXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965282; x=1730570082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iV54wQsewAL+j9xIJrgm9X//KUANhnDc29VNVi92QVg=;
 b=E3VYc2N7rDwj9JDVHad+VSwQqcnCpsXqAJjdIEC+MnuN0dFVcMi0MfEk3OlbdK5QPu
 /UeBSI7MBc2dNuTWbCsu0Sm/ghgulpKbH/8p/mgA69u6YWVaA+uXuDoJ6Uun13IPqfzZ
 o7TGbK1Bv+nZ+q7TTJoyakk4kVnH45NGZc3ybd6nF2aKq4JpK31xZHfDujjpx5UVR5Kf
 NpkWfnDdpng/zOD4gHPvMPUUI7tLCHkVeD6joUpwIWWidKeQOadw6DlK5BVd98ZCuVVx
 aCD/kQRB5RTGaZDiw8U5dsMHJ8JMWiRll+gNrYBkYkONVxdEkKOS/NFVFkLoI1TKZTxk
 8TWg==
X-Gm-Message-State: AOJu0Yy9Q/nSDVAPZCcA3ejCi8BSqM9gsxfzPUO6qtMb8zoFm5coiWlg
 BakYdElK3bRhhKNChbTQ3QkgwaEatwC/mPcTtPf8aXkZadxOYXM+K6n+ttKSNQQfilIRzTqNcUq
 l
X-Google-Smtp-Source: AGHT+IFqiUQ6N93ScMXP0EOvsuGa+YTPNZStSMeOrYhqEbNerfgl0VEYaBTcRIMEPHsIcPJIdOoMkg==
X-Received: by 2002:a05:6a00:2d8a:b0:71e:233:9537 with SMTP id
 d2e1a72fcca58-720630b4535mr5545111b3a.28.1729965281653; 
 Sat, 26 Oct 2024 10:54:41 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a0df99sm2982079b3a.118.2024.10.26.10.54.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:54:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 6/9] target/mips: Convert Loongson [D]DIVU.G opcodes to
 decodetree
Date: Sat, 26 Oct 2024 14:53:46 -0300
Message-ID: <20241026175349.84523-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x431.google.com
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

Convert DIVU.G (divide 32-bit unsigned integers) and DDIVU.G
(divide 64-bit unsigned integers) opcodes to decodetree.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


