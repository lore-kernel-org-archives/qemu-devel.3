Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD986CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzw-0005g3-8r; Tue, 19 Aug 2025 14:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzt-0005Tx-GB; Tue, 19 Aug 2025 14:23:49 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzp-0003rn-Os; Tue, 19 Aug 2025 14:23:48 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b474e8d6d01so1393473a12.0; 
 Tue, 19 Aug 2025 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627823; x=1756232623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDaxTkVmNHgEN/pCYynl1Q9zMx/LngyuWvcU/DTVG5s=;
 b=k1MROYhX8L1sCefGX8P6OnJOXB6ZUfZOqgdseknYxg6aETfRON30WhFx9sH+v6ecUU
 20bXDJ33oDNXLy0bH3X5Y5qAhm579LFxOS0fM/i2To9cm5Hw/XC14Ez5KSRQqR/jRoa7
 qmhj194P5fEwX93yjBtuR8qsCcRsTP17GLa3QUirCqQvYZAtDbwTNn/0iuYCvDhzhxRY
 F9YIWHPr5c27JXM41cMAQdtHf/LKFTuD947ntYPGYKeRDrG2Le0H6IqGEyo4YWyHnVlj
 ijQ44NECz7Pbdj5Et8Q+FQ2sBUZr7lwo/vT3ywHRilwUnxsk2pe7n7SOqONigr0BQ6fJ
 5t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627823; x=1756232623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDaxTkVmNHgEN/pCYynl1Q9zMx/LngyuWvcU/DTVG5s=;
 b=saoRFVyHIt43uUyi3SpN8p0VU0JS2BLnC6ElTPNFGAgAfab8nlS1kvKlCvY40K05KH
 G6Q760cYKsCUOUmZts0o4GuHNtnpajQAf0wBVSJjyW2ouPsWCGULZwj/2eBbYH/ZcYp8
 SFUtmoqan/YZtNE8voplvhyo7XmVik5wJY1Ff6yvRBOiGQs/8FGigTbXIgLbY7C/hPcv
 ygOb9P66O3obIAsRQRs/g0XMFyHvo9+gK9ijNv0qlCH1fUujWWJ/l2++rbMZ3G/T6krU
 ZfdEvx4cV9Fcmq8Hiaro0uQ/SGrBld1AM+EBq6jzGvkwAyTlffbJ384M480jBBWC6Ca+
 6pfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4JQxjarLtiVRChNLZ/eIp2Byl1taX3c4kXE8ByCtTNoKFacuR72VYAzT93vWRV73bVUPPX82Sz+A3zQ==@nongnu.org,
 AJvYcCUFibZs4r1uA39LewVKzc6HjGfmS9kfBuNDXeYbkh9KIEyVm2wu3PZb35MtMN3/1hb3jmpAsJ27nA==@nongnu.org
X-Gm-Message-State: AOJu0Yx2x7M9PdyzizvxKJKS0X+2BgkV01lArO4ar6CsWJOAVglkxZzB
 dGZ8bD2sYPXZkZGNBje064Vbg8WWOfCZcR2svzfPxTi6LkBoawD0C76xNWGosQmn
X-Gm-Gg: ASbGncuxPHXYHpfFaasyX0dgYN5Jn9Mx/VLUjqL3ejjuHJL7k/xe7gOv6wR11DEFrh8
 F9s91jjL62ArMS5TP89jggJRnFdT7YE1TGwuYO1bemwcH9/4M+GgiIRJuiigB96ItKqMUP+2NVd
 0Sbo6eSYqJgKkcJ5GhHGQCHleUg/QPx41ny0QJ0NNRZ7y+lvxGPhkMKqQZsAZtPfcqj3+Aw/YMs
 csISdGqFXBzxdHjPmVIA9m2WDe9MHMIx4v+m6T0mgkG7vamwnYf9tI64UOGTg+ZMCuy92GDxYiR
 zx7vXXMcIUi2++0uZijwrqoJP/pfA5Jt1GYk6UjYcnJ/TynUMfGGX0amyrZnBUZhMWv+B+LRO3k
 Ew8G3F7DUb6r/x6+g26AlQ1H4uYbu052o
X-Google-Smtp-Source: AGHT+IFgiZyY03En/iqAp7Fe45Qscuvesp0t1K+erMqvymFeGjE649/ub+gJU7Nv0+7e/+W5CTxQtA==
X-Received: by 2002:a17:902:f60a:b0:240:2953:4b6b with SMTP id
 d9443c01a7336-245e02c129fmr47704645ad.2.1755627822609; 
 Tue, 19 Aug 2025 11:23:42 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:41 -0700 (PDT)
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
Subject: [PATCH 12/35] tcg/wasm: Add shl/shr/sar instructions
Date: Wed, 20 Aug 2025 03:21:41 +0900
Message-ID: <1df7099b73d5a3926a05f2606b5dde9e10f05532.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
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

This commit implements shl, shr and sar operations using Wasm
instructions. The Wasm backend uses 64bit variables so the right shift
operation for 32bit values extract the lower 32bit of the operand before
shifting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index e1b10c57b0..81e83a8bdf 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -120,12 +120,22 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I32_SHL = 0x74,
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
@@ -199,6 +209,27 @@ static void tcg_wasm_out_o1_i2(
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
 
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
@@ -930,11 +961,14 @@ static const TCGOutOpBinary outop_rotr = {
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
+    TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
         tcg_out_ext32s(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_SHR_S, OPC_I64_SHR_S,
+                            a0, orig_a1, a2);
 }
 
 static const TCGOutOpBinary outop_sar = {
@@ -946,6 +980,7 @@ static void tgen_shl(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_shl, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_SHL, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_shl = {
@@ -956,11 +991,14 @@ static const TCGOutOpBinary outop_shl = {
 static void tgen_shr(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
+    TCGReg orig_a1 = a1;
     if (type < TCG_TYPE_REG) {
         tcg_out_ext32u(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
     tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
+    tcg_wasm_out_o1_i2_type(s, type, OPC_I32_SHR_U, OPC_I64_SHR_U,
+                            a0, orig_a1, a2);
 }
 
 static const TCGOutOpBinary outop_shr = {
-- 
2.43.0


