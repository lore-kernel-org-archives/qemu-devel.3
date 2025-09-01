Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A93CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut30C-0000VP-0R; Mon, 01 Sep 2025 07:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zp-0007xu-J4; Mon, 01 Sep 2025 07:46:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zc-0001Pn-28; Mon, 01 Sep 2025 07:46:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b47052620a6so3804922a12.1; 
 Mon, 01 Sep 2025 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727185; x=1757331985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhPwaGI2GoqW6tt9mOEN3xV7zJdvKH3shZBj9/JQG6Q=;
 b=lYZmm3hEyUFU4v5ifn1OxXBmLeVdbn7jZMhyg9EB8G5V9wXzGZtImShUl/UKuCaGfN
 rY2UZwu1Zl5+I6Oc3zmScYx0VqbrVdJefrCZPziIX0D7XgaCBbDJi1rBVEjQ2J0OnhLh
 U5cYOMsOEW7Ec/ZjvDeNWmN7N0NzLUzgt12v/UmjASVwHDFlaNrkcLI7To29TgPapxK6
 QTHlmL8PtKm1iaiCU+uFQG84P/FqStwBaiNXX/WV4uVg5KPOh9FvXp+nX3hKLbD0zNeX
 826BMhRGvgXswV19opD6m23Tsj19If/1YxvrF/ku/YfhraXN+dkDs2mDoRckLy9HaQ8K
 96+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727185; x=1757331985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhPwaGI2GoqW6tt9mOEN3xV7zJdvKH3shZBj9/JQG6Q=;
 b=oO1LWmDl0ohXAks9J7uPQCXvPSO4WbMKZDey6bxrNsWJhxQm+psL5iFGDCUTRSL29H
 YPTcocUkIv8Kd5d6a1YBFgdruDvbB2q39k1gcxz71dSBCm6Rq8xY3p/GoHfGEO+XD7Aw
 eE4KM6bmT8GywacHkIFOrAeExvU0uN0YrDsquUk1rTPYpfQFe9dmCHd6FlNS4J72Zl6x
 wEfKfTP9XGKhcY4lGgp0D6oTu30hNCY5cZHokOzbqan0XGT7wv1Mzf4J1EGiWlZRLr+l
 jfu0QBhEF5UahNmOIHeEurNUr3/meqhvQydUrUJYnVG/QJ+kF8w4QJ1S3td6h78j4Z3I
 FgIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC+WASfOetNnHII3bKPVfuLAJZ3TKNt5pvJyd6yLawMdJ0GsYAaQ25Kv3u7IT45Oh5/nTJWnWvAw==@nongnu.org,
 AJvYcCVtvOyq9+hgft6Q7E5C4nF9lPs/64u+0oPTKkMV3+mRTuekmTeyAr7dOtir5zjFsYjUXQVP0kWcNyDXSg==@nongnu.org
X-Gm-Message-State: AOJu0YxTlZMG/YK+/IhTKJO6c1EMqW3R7Mtat/NnP/Qxhy90Aii2xBvi
 8I1oSCm6a3zm5eD51JU6+jqoqQL05cju0CzDFEoH23i1Pwp0myOQxHJTIsXJ+w==
X-Gm-Gg: ASbGncurpkr31ntw8Rmnh92QB9WjO8kxFqVztP65YjgC3rjCuHCqgnVGImL1prCc4jZ
 dnqgFFOiq1cmhG+YU4LyiILJgUBMsn+dTAYkENm/xeKEnciuVDujM9tPJRX4YMttq3X6WL43Fjc
 URAVBpKYaXefaOIklQTerbjjrFHBgV8HZkYcWBl60S4c422uzm0jIgaeaq/qbdAuxDqMLKK2Z+z
 xv8pUFEih7qQsfJ3pX880kX513EID0gBaxUR3MCcTXuUnJLKuz+/GbIc07Jeq2SpLgBzrYcdTe1
 BpB64PYlVxwGz2UOsmjIioAeI4NXotqPijB0KxZ3HbpfUeEXKpcbKf1MCKJC9mBcd9A44VxFLeh
 BX05gcG/SvE6gwCE6iVl99O9sV8ohdphv
X-Google-Smtp-Source: AGHT+IG9naoGJ0aF4O5AaduMwXMX1qnSxFcTxa6fbcxlH0MpFPLlWeJXWo5zVW0dBSbBu4BmNltcxQ==
X-Received: by 2002:a17:902:f708:b0:24a:acb7:a1a4 with SMTP id
 d9443c01a7336-24aacb7a5f7mr67331105ad.9.1756727185156; 
 Mon, 01 Sep 2025 04:46:25 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:24 -0700 (PDT)
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
Subject: [PATCH v3 11/35] tcg/wasm: Add shl/shr/sar instructions
Date: Mon,  1 Sep 2025 20:44:13 +0900
Message-ID: <cb7883a5da41bad585b28293458c7bdc52057cd9.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit implements the shl, shr and sar operations using Wasm
instructions. Since the Wasm backend uses 64bit variables, right shifts on
32bit values extract the lower 32bit of the operand before shifting. TCI
instructions are also generated in the same way as the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                | 31 +++++++++++++
 tcg/wasm/tcg-target.c.inc | 93 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index ba8a89d920..b63b88e011 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -28,6 +28,15 @@ static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
     *r2 = extract32(insn, 16, 4);
 }
 
+static void tci_args_rrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                          uint8_t *i2, uint8_t *i3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *i2 = extract32(insn, 16, 6);
+    *i3 = extract32(insn, 22, 6);
+}
+
 static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
 {
     const uint32_t *tb_ptr = v_tb_ptr;
@@ -42,6 +51,7 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         uint32_t insn;
         TCGOpcode opc;
         TCGReg r0, r1, r2;
+        uint8_t pos, len;
 
         insn = *tb_ptr++;
         opc = extract32(insn, 0, 8);
@@ -71,6 +81,27 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] * regs[r2];
             break;
+        case INDEX_op_extract:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = extract64(regs[r1], pos, len);
+            break;
+        case INDEX_op_sextract:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = sextract64(regs[r1], pos, len);
+            break;
+        case INDEX_op_shl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] << (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_shr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_sar:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ((tcg_target_long)regs[r1]
+                        >> (regs[r2] % TCG_TARGET_REG_BITS));
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index d5cf324e7b..3a2a707619 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -140,12 +140,21 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I32_SHR_S = 0x75,
+    OPC_I32_SHR_U = 0x76,
+
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
     OPC_I64_AND = 0x83,
     OPC_I64_OR = 0x84,
     OPC_I64_XOR = 0x85,
+    OPC_I64_SHL = 0x86,
+    OPC_I64_SHR_S = 0x87,
+    OPC_I64_SHR_U = 0x88,
+
+    OPC_I32_WRAP_I64 = 0xa7,
+    OPC_I64_EXTEND_I32_U = 0xad,
 } WasmInsn;
 
 #define BUF_SIZE 1024
@@ -219,6 +228,27 @@ static void tcg_wasm_out_o1_i2(
     tcg_wasm_out_op(s, opc);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
+static void tcg_wasm_out_o1_i2_type(
+    TCGContext *s, TCGType type, WasmInsn opc32, WasmInsn opc64,
+    TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        tcg_wasm_out_op(s, opc32);
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_U);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+        break;
+    case TCG_TYPE_I64:
+        tcg_wasm_out_o1_i2(s, opc64, ret, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
 
 static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGReg r2)
@@ -232,6 +262,21 @@ static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
+                            TCGReg r1, uint8_t b2, uint8_t b3)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_debug_assert(b2 == extract32(b2, 0, 6));
+    tcg_debug_assert(b3 == extract32(b3, 0, 6));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 6, b2);
+    insn = deposit32(insn, 22, 6, b3);
+    tcg_out32(s, insn);
+}
+
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -304,6 +349,54 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_shl, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_SHL, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shl,
+};
+
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGReg orig_a1 = a1;
+    if (type < TCG_TYPE_REG) {
+        tcg_out_op_rrbb(s, INDEX_op_extract, TCG_REG_TMP, a1, 0, 32);
+        a1 = TCG_REG_TMP;
+    }
+    tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_SHR_U, OPC_I64_SHR_U,
+                            a0, orig_a1, a2);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shr,
+};
+
+static void tgen_sar(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGReg orig_a1 = a1;
+    if (type < TCG_TYPE_REG) {
+        tcg_out_op_rrbb(s, INDEX_op_sextract, TCG_REG_TMP, a1, 0, 32);
+        a1 = TCG_REG_TMP;
+    }
+    tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_SHR_S, OPC_I64_SHR_S,
+                            a0, orig_a1, a2);
+}
+
+static const TCGOutOpBinary outop_sar = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sar,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


