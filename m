Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A175CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut310-00023l-Tb; Mon, 01 Sep 2025 07:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30T-0001RN-0a; Mon, 01 Sep 2025 07:47:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30L-0001cX-6X; Mon, 01 Sep 2025 07:47:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-248de53d12dso25194535ad.2; 
 Mon, 01 Sep 2025 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727231; x=1757332031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5u/GKaMHlHVYWbQxiaNJLdfFOyogib0bqUIPS8H3LU=;
 b=iYLUvMgWgbNS9VmVc0CRjp31MI9QcNbMIbqoceWhf95+KuEE5OOU4ZX7YDZFqBfsb7
 EgZPp+nPXBk7CaAv583LQF21btpWSUVYtn+sK26CsWImp8htXSX9Chp4d+37puzeIXZ6
 TOJ422in08ex+xT4wFhYSvxhHq50BODORCHD4Ws7afd1Ty5aLnY/EB4W1GO5iAaN1wlh
 4oPGDpJTWw7za9r3ICODfyJhkLLY2goy97Gsz4xGwLIlfcq4zNJSJzePpyJQ7Ivzl4Ef
 u2yPGZ01NenwbdoA0jZf9NaAtcCYJKjOvDR6q6KRuMirQE+C8drgDHTfgEwtkvNtd3eT
 Lnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727231; x=1757332031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5u/GKaMHlHVYWbQxiaNJLdfFOyogib0bqUIPS8H3LU=;
 b=n2XrsmVPrFLYs3WEN2KlrZyQi+XRSiDHYwgnN3Ufqf48TEGqewzebdUzhascpL/qH4
 bFJXpAbUh/mIyNeeqxa6JszaZVMJf7ylhl1YnX7SuiCHwP7C2XDRFe3ucnDxyALL9wc3
 OfnMyAeo3sHdeRAZVSujnW4cqw8kLG6HrroiXmCjN4SllcPP0RWUCnFYXn6Y63AQFk8W
 ZfMva4fqP38nTyCGM9Azj4+6H/h6hGjwgbKTD3L1Kt9Ny5i2mNFn9Vk9jjeb43/6pVT/
 qtc3jTsbacikXfXVkssG/wbCX6ICQ1vVPG2j9ejOcylpBOi7/7Nud4PsZb28h2abMHmx
 DZNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgCoCjZMTFAF9fnnxit3yG/rJusHWUXlnguMVwGLNcwMH8jv7qrQ8lPH5DtDZv3HW7RhZdJjtfCAfRNA==@nongnu.org,
 AJvYcCXMF3VpKBMNheAE2CqiHPPP7XHW5V/bjvkr2cz0Cbm7N3aXT9P44j/JB4DXxZYuBcllajAnttDdcA==@nongnu.org
X-Gm-Message-State: AOJu0YwSIQY51t5Z1gBGdbFDCq966d4mdLq0IHsuAskFyoGWwsB3nudh
 8J2ymNdjc8W8pEz+8/tWiW8btUQAA1YYihTXevylnGAiIbTGmhKwgrD87dIc0A==
X-Gm-Gg: ASbGncvCqB/T04yNlxVfsYwQN2hnG4hZlwR2ti5bIE5wFT6DlKHJrZEA+dqcMBEMFRS
 UUVvXmeHgWUchZglFGoXWzC2BoW/qnt4i2U7HbUy3NcG0kfo3zLbv66BNdq3L6Y3fFaueTvuizq
 ZEqwASzFSH4aSxxy5NLqhhVnSBoJqrmhL5Uv4r5NlYV8CtsW7rcD2aePwX0Ern9ySDMe3yzUMu3
 FJp5sa1dl5KuGmRymDL7/IgEj5BMKea38yEEaGHHP7kgiKvw0yV4VclSNbVmFp2/ERWPwpC8eRE
 yUT1XhF7DOvIpz0x5WVZUFoWwK88/xdFAxU+YhLo59s6w4EC29v/XNTiG7O9+9dbvPHd/1l4OSs
 jB6uDIJIN/C2yzHJN5Kmfqs3uGKPQASf8
X-Google-Smtp-Source: AGHT+IEO4Vg8cH2671t3pzJq0DViJhQiPjnZwjXSmMqbnckDZCJoj7KZN1xofwgqQGBBlJaFSjzDrg==
X-Received: by 2002:a17:902:d4cb:b0:249:3049:9748 with SMTP id
 d9443c01a7336-24944a98207mr97943645ad.35.1756727231385; 
 Mon, 01 Sep 2025 04:47:11 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:47:10 -0700 (PDT)
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
Subject: [PATCH v3 19/35] tcg/wasm: Add rot/clz/ctz instructions
Date: Mon,  1 Sep 2025 20:44:21 +0900
Message-ID: <ad0fb42234f6a5569489cfb5c4d04361575e4905.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62b.google.com
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

The rot/clz/ctz operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                    |  34 +++++++++++
 tcg/wasm/tcg-target-opc.h.inc |   4 ++
 tcg/wasm/tcg-target.c.inc     | 107 ++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index a5e72d8fe5..2688ded58a 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -363,6 +363,40 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop64(regs[r1]);
             break;
+        case INDEX_op_clz:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
+            break;
+        case INDEX_op_ctz:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
+            break;
+        case INDEX_op_tci_clz32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
+            break;
+        case INDEX_op_tci_ctz32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
+            break;
+        case INDEX_op_rotl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol64(regs[r1], regs[r2] & 63);
+            break;
+        case INDEX_op_rotr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror64(regs[r1], regs[r2] & 63);
+            break;
+        case INDEX_op_tci_rotl32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol32(regs[r1], regs[r2] & 31);
+            break;
+        case INDEX_op_tci_rotr32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror32(regs[r1], regs[r2] & 31);
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target-opc.h.inc b/tcg/wasm/tcg-target-opc.h.inc
index 5ed8c67535..092a5086ec 100644
--- a/tcg/wasm/tcg-target-opc.h.inc
+++ b/tcg/wasm/tcg-target-opc.h.inc
@@ -12,3 +12,7 @@ DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 27f3a7414b..d547e7bf09 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -158,6 +158,7 @@ typedef enum {
     OPC_I32_CONST = 0x41,
     OPC_I64_CONST = 0x42,
 
+    OPC_I32_EQZ = 0x45,
     OPC_I32_EQ = 0x46,
     OPC_I32_NE = 0x47,
     OPC_I32_LT_S = 0x48,
@@ -169,6 +170,7 @@ typedef enum {
     OPC_I32_GE_S = 0x4e,
     OPC_I32_GE_U = 0x4f,
 
+    OPC_I64_EQZ = 0x50,
     OPC_I64_EQ = 0x51,
     OPC_I64_NE = 0x52,
     OPC_I64_LT_S = 0x53,
@@ -180,6 +182,8 @@ typedef enum {
     OPC_I64_GE_S = 0x59,
     OPC_I64_GE_U = 0x5a,
 
+    OPC_I32_CLZ = 0x67,
+    OPC_I32_CTZ = 0x68,
     OPC_I32_ADD = 0x6a,
     OPC_I32_DIV_S = 0x6d,
     OPC_I32_DIV_U = 0x6e,
@@ -187,7 +191,11 @@ typedef enum {
     OPC_I32_REM_U = 0x70,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
+    OPC_I32_ROTL = 0x77,
+    OPC_I32_ROTR = 0x78,
 
+    OPC_I64_CLZ = 0x79,
+    OPC_I64_CTZ = 0x7a,
     OPC_I64_POPCNT = 0x7b,
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
@@ -202,6 +210,8 @@ typedef enum {
     OPC_I64_SHL = 0x86,
     OPC_I64_SHR_S = 0x87,
     OPC_I64_SHR_U = 0x88,
+    OPC_I64_ROTL = 0x89,
+    OPC_I64_ROTR = 0x8a,
 
     OPC_I32_WRAP_I64 = 0xa7,
     OPC_I64_EXTEND_I32_S = 0xac,
@@ -212,6 +222,7 @@ typedef enum {
 
 typedef enum {
     BLOCK_I64 = 0x7e,
+    BLOCK_I32 = 0x7f,
 } WasmBlockType;
 
 #define BUF_SIZE 1024
@@ -563,6 +574,42 @@ static void tcg_wasm_out_ctpop64(TCGContext *s, TCGReg ret, TCGReg arg)
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_cz(
+    TCGContext *s, TCGType type, WasmInsn opc32, WasmInsn opc64,
+    TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, OPC_I32_EQZ);
+        tcg_wasm_out_op_block(s, OPC_IF, BLOCK_I32);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, OPC_ELSE);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, opc32);
+        tcg_wasm_out_op(s, OPC_END);
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I64_EQZ);
+        tcg_wasm_out_op_block(s, OPC_IF, BLOCK_I64);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_ELSE);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, opc64);
+        tcg_wasm_out_op(s, OPC_END);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1182,6 +1229,66 @@ static const TCGOutOpUnary outop_ctpop = {
     .out_rr = tgen_ctpop,
 };
 
+static void tgen_rotl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotl32
+                     : INDEX_op_rotl);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_ROTL, OPC_I64_ROTL, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotl,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotr32
+                     : INDEX_op_rotr);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_ROTR, OPC_I64_ROTR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotr,
+};
+
+static void tgen_clz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_clz32
+                     : INDEX_op_clz);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_cz(s, type, OPC_I32_CLZ, OPC_I64_CLZ, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_clz,
+};
+
+static void tgen_ctz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_ctz32
+                     : INDEX_op_ctz);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+    tcg_wasm_out_cz(s, type, OPC_I32_CTZ, OPC_I64_CTZ, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_ctz,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


