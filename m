Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5950CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0f-0007DZ-JG; Tue, 19 Aug 2025 14:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0R-0006vj-K3; Tue, 19 Aug 2025 14:24:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR0N-0003w8-NH; Tue, 19 Aug 2025 14:24:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2445806df50so42112535ad.1; 
 Tue, 19 Aug 2025 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627856; x=1756232656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvAd64/o7YFABVEip01g3of0GXJUvHRPN0JKXxULcjE=;
 b=EnoV/WTArKvIucg0hJy0sIXHMoVzuCxoleEmfNC9yt55Dp/7RSOknALCFCCIHzLGM6
 f4MGd4rOtxbY7DNz1o7pum1P/jEfzjMVA46ln2flwB+IJoHy79KTwWArUUyXCmccuOTr
 JbrdUpgY2uK83XLTgQ/4hY5fubh/I8q4hHsGoifD0HBcdMfZz9Ki3fiCGx8UkX0nJAHI
 QbggLLfAsfVmn47Gr+7OceVSq3j5sK8x9Qh/3HboHslaaBNAj8n8xN3EEwLKPTJFTw2D
 kuoTZ6MbVgoX69S+94hfjzFTaTsnpvM/w+XVFxJutKUSUPrqfSIPWAODo80eZWAnyvEb
 CXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627856; x=1756232656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvAd64/o7YFABVEip01g3of0GXJUvHRPN0JKXxULcjE=;
 b=f28avEUVpIUlrAh+WEzw8kWwrGUVhPl2RGw9v+nhPv3GIRMwjU01AliFHgMihQbsif
 H5vwm73WVtb0nm4/u87zw3gNirdyfo4MeOWv6rNbKhHiyIfOrTFwPyec07zHIr7nrhx7
 wEFlNfvgJm6ti82OcZ+koF9cDgdySktwvQismfsfNY0sjwmsoiVUzffzncZdxJfmPjSH
 J+IeDtruPC6ABCvWKbZuFyhQ9C4aA5G2i9wmueeffsw8w0wKPDofBeM+C7zp2nOMG5wO
 s5dhTQgY/4so2AsYx9WQXWn1BG9D7bU1zCJdICBiudWVaGaAELsda7iewltQrWKlcscq
 94FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAhQVuM+A6/fxd5G6idm2AmvDiivbfRdvdaTWjYj+NnI40dpV/vsEA7rSVRTWXj+LV0NfJq/qJFkOvhg==@nongnu.org,
 AJvYcCXgX5a4R08NMVasmJ2RWAYpjLsjN3S27JmvfLL1yF6XvEK/cnit/GAE4t3iJnJ505zunH/72w2Iyw==@nongnu.org
X-Gm-Message-State: AOJu0YwsKZ45D8p122ir844svQeNBI14UFd6mC5e1hx+0k3pa6x/AaLu
 c8jMHratoSr9PRbuJYU7KouaByT1d3Nz6wZx8XQCjNQGF+UKQvAbLGghL9TnWXSM
X-Gm-Gg: ASbGncvHZ4DnKcorvtzwutX2MeJEVziasSFSl9bFtM7jDiDk6OjkHNwk/HmzsNhJb9h
 qSH34LF6T2SLFzCleTkrw+VysGW8IRPe/AJJSpwK4/JYaSaGCW6A/EdCvkIYeYTSlEvBwyi8qmb
 EO8EDP1BRhHxDttx9vDDCKOYdvVQxTJu9x0Hmh0H1ffI4gx8o/VtldKBIFNchRT7eoFavBQ+vuW
 L5T1Z7wFzxk8HnWPJ4wC7rM2ZkYe3ku06WaRPzaOzQ9a1kB3lGFei4e0WyLgGm5YvmyxKL3/P65
 zsCOkDPYI/ZQINljzB7p038JEUT+cWHvcSUhg8TUSkVws5xjHf/TxJiY5mQ+LZRlVt+SeAvloG9
 fXlpJJ6RT+dNkxKEBPfvSRQ==
X-Google-Smtp-Source: AGHT+IHuZ8U+vlcir8gg6hbrfziS3yK1asp1CaavGAsbW0jFBojbL7aMVgcROLIlcaAo/Dfeek23jA==
X-Received: by 2002:a17:903:3bd0:b0:240:8fa2:15d2 with SMTP id
 d9443c01a7336-245e0488c15mr49727335ad.33.1755627855965; 
 Tue, 19 Aug 2025 11:24:15 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:15 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 18/35] tcg/wasm: Add bswap instructions
Date: Wed, 20 Aug 2025 03:21:47 +0900
Message-ID: <ceb5f4b3fb6a4c0f6c647a7e1b39c801144ac6af.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit introduces Wasm module local variables[1] assigned from the
index 0. These variables are used as temporary storage during calculations.

[1] https://webassembly.github.io/spec/core/binary/instructions.html#variable-instructions

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 117 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index afaea76d5c..7f4ec250ff 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -116,10 +116,16 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 
 #define REG_IDX(r) tcg_target_reg_index[r]
 
+/* Temporary local variables */
+#define TMP32_LOCAL_0_IDX 0
+#define TMP64_LOCAL_0_IDX 1
+
 typedef enum {
     OPC_IF = 0x04,
     OPC_ELSE = 0x05,
     OPC_END = 0x0b,
+    OPC_LOCAL_GET = 0x20,
+    OPC_LOCAL_SET = 0x21,
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
@@ -163,9 +169,12 @@ typedef enum {
     OPC_I64_GE_U = 0x5a,
 
     OPC_I32_ADD = 0x6a,
+    OPC_I32_AND = 0x71,
+    OPC_I32_OR = 0x72,
     OPC_I32_SHL = 0x74,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
+    OPC_I32_ROTR = 0x78,
 
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
@@ -176,6 +185,7 @@ typedef enum {
     OPC_I64_SHL = 0x86,
     OPC_I64_SHR_S = 0x87,
     OPC_I64_SHR_U = 0x88,
+    OPC_I64_ROTR = 0x8a,
 
     OPC_I32_WRAP_I64 = 0xa7,
     OPC_I64_EXTEND_I32_S = 0xac,
@@ -524,6 +534,110 @@ static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
 }
 
+static void tcg_wasm_out_bswap64(
+    TCGContext *s, TCGReg dest, TCGReg src)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(src));
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 32);
+    tcg_wasm_out_op(s, OPC_I64_ROTR);
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_SET, TMP64_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0xff000000ff000000);
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 24);
+    tcg_wasm_out_op(s, OPC_I64_SHR_U);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x00ff000000ff0000);
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 8);
+    tcg_wasm_out_op(s, OPC_I64_SHR_U);
+
+    tcg_wasm_out_op(s, OPC_I64_OR);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x0000ff000000ff00);
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 8);
+    tcg_wasm_out_op(s, OPC_I64_SHL);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP64_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0x000000ff000000ff);
+    tcg_wasm_out_op(s, OPC_I64_AND);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 24);
+    tcg_wasm_out_op(s, OPC_I64_SHL);
+
+    tcg_wasm_out_op(s, OPC_I64_OR);
+
+    tcg_wasm_out_op(s, OPC_I64_OR);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
+static void tcg_wasm_out_bswap32(
+    TCGContext *s, TCGReg dest, TCGReg src, int flags)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(src));
+    tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_SET, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 16);
+    tcg_wasm_out_op(s, OPC_I32_ROTR);
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_SET, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 0xff00ff00);
+    tcg_wasm_out_op(s, OPC_I32_AND);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 8);
+    tcg_wasm_out_op(s, OPC_I32_SHR_U);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 0x00ff00ff);
+    tcg_wasm_out_op(s, OPC_I32_AND);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 8);
+    tcg_wasm_out_op(s, OPC_I32_SHL);
+
+    tcg_wasm_out_op(s, OPC_I32_OR);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);
+    } else {
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+    }
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
+static void tcg_wasm_out_bswap16(
+    TCGContext *s, TCGReg dest, TCGReg src, int flags)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(src));
+    tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_SET, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 8);
+    tcg_wasm_out_op(s, OPC_I32_ROTR);
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_SET, TMP32_LOCAL_0_IDX);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 0x000000ff);
+    tcg_wasm_out_op(s, OPC_I32_AND);
+
+    tcg_wasm_out_op_idx(s, OPC_LOCAL_GET, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 0xff000000);
+    tcg_wasm_out_op(s, OPC_I32_AND);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 16);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_wasm_out_op(s, OPC_I32_SHR_S);
+    } else {
+        tcg_wasm_out_op(s, OPC_I32_SHR_U);
+    }
+
+    tcg_wasm_out_op(s, OPC_I32_OR);
+    tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
 static void tcg_wasm_out_mov(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
@@ -1448,6 +1562,7 @@ static void tgen_bswap16(TCGContext *s, TCGType type,
     if (flags & TCG_BSWAP_OS) {
         tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
     }
+    tcg_wasm_out_bswap16(s, a0, a1, flags);
 }
 
 static const TCGOutOpBswap outop_bswap16 = {
@@ -1462,6 +1577,7 @@ static void tgen_bswap32(TCGContext *s, TCGType type,
     if (flags & TCG_BSWAP_OS) {
         tcg_tci_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
     }
+    tcg_wasm_out_bswap32(s, a0, a1, flags);
 }
 
 static const TCGOutOpBswap outop_bswap32 = {
@@ -1473,6 +1589,7 @@ static const TCGOutOpBswap outop_bswap32 = {
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_bswap64, a0, a1);
+    tcg_wasm_out_bswap64(s, a0, a1);
 }
 
 static const TCGOutOpUnary outop_bswap64 = {
-- 
2.43.0


