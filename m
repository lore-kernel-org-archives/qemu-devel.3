Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB28BCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHb-0004Gp-6n; Tue, 26 Aug 2025 12:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHY-0004Fy-Up; Tue, 26 Aug 2025 12:12:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHU-0007ts-Fm; Tue, 26 Aug 2025 12:12:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-770593ba164so2346492b3a.3; 
 Tue, 26 Aug 2025 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224734; x=1756829534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rP9o5I3iZTsP3xsDaIImF9EGNVief0IFdCrbUXJyoyI=;
 b=ZQq6aDdWllEOWn545DRU4/zQsHgjLk2xPYm5YYu0n51kSFvq/v6Sqpgg5aEm6u8Zz1
 MNSzF7wcEvkol5a0DLfShO164AWrA2/nKywa+0TZ5iRoD7PWLgmtnVRYmdfkH6yjND/H
 3r5lpLjrIY+8oCfOh62aKJVwXyH0ro4oZoupLlgLTApQqzDB9B00lORF1lNIt+TEZbCv
 pLrrV4sb5M5+YPCBPRisIywFgE8XmAxSADnntB4alpt5W2OHtxz2t0Whc6QxxTvZLwsD
 b5D4XijgPXIxFKtX+ik8vsMR/QO9WwmLKvoGr9pqrvjGeHUGd9a0YZRUVblbZIkfot3K
 n6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224734; x=1756829534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rP9o5I3iZTsP3xsDaIImF9EGNVief0IFdCrbUXJyoyI=;
 b=Bq2R0OjS7bbPzWPwK5YkNiM89V7OpIpZDFqFi+nQXN0fb6Bm+UDNIrsmwSqIUiF6pV
 n/CBvzFyZa1hzKLk6UUo7kOk2+2FvHC7/yo2cU6gwNhhOkNId0vD0MDbl2DIn9c/qWG+
 Sapg1UToKuix62HcVDTNLdyvi5jr5QAd5j7tqeJKO8JsbbrNhRBBijorP9VtLIGDgkGg
 qf4KNSkhX8ov5+go+ReWznjyb/HZ4KYJzP2paO/SaZaYwaiEPYLjSluFw7WiCgntLS/9
 I1YQm3qulczbRNZwCoJMxg/1Xy2aUIxAEB+/Rw31TTKua0xFfynFEL1fcs34fUFoWfHt
 aO/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlmJ8yH8tpb4q+XyoKQgjYwA0fvIIujUt8ThTr5Uka5rwr4EgKcSpgF6ZIgx58szLdK8dpww5Rug==@nongnu.org,
 AJvYcCX2k5A3YRX6MTVXivrCEdkmec1i+FgmGIAG30Od7WLMASuqZgWa9BfrXnYpfSJAWTnbdiV0m2+nMG6mLw==@nongnu.org
X-Gm-Message-State: AOJu0YyNBiad8UsLDyvgiHzPpbYwOYVKE7PDFwyzv8+trnzQKlV+Tl90
 vQTjnpldAID4Yi38NdX4G5KUP+XhdA9gCK0R3QTmhPhh1zGqxw1wLHSdMHr05g==
X-Gm-Gg: ASbGncskSa3gXgQZaGW7fI4kYOSpbt+ro3aHrTpVlqwCfU6zFSkWToLHX28+1F4dOyR
 prpn6M6XaFtZr3vqUUBOALAxK/11MWS10yZYsGhsvG3CQmsNiPcKk2FVh7hRlybGj44BoGrboDO
 s6bGaXnJltoiInreS3DWALAI4PUrTATwqFmUpE1lTh0Mk3pqrNsZZntJtpP7Ei0V+oJ48+8joNN
 F9h47UCr2KKlhPfaDcGhrmoBjEjhutu970MkvAVmywHgWhpUvbjT9kVTakdqGvZSdG9gcP2UifN
 0ZTLHtJU4zJO1d2nKn7eVi5gC3UAMXRQKiCNsk21I4GVDJqntwH77igPRl3NHmu2wAlm3BSdBWX
 jtSNlzvggaTlhbAlbz7ktxQ==
X-Google-Smtp-Source: AGHT+IHdevDeGah6J4+3MKVmgcSpJ0XxeaInH5Stwpej0Mhuhgtzux6dQkKhod+DlHf49xg1JFSx2Q==
X-Received: by 2002:a17:902:ea03:b0:248:79d4:939d with SMTP id
 d9443c01a7336-24879d4992amr24567435ad.35.1756224733638; 
 Tue, 26 Aug 2025 09:12:13 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:12 -0700 (PDT)
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
Subject: [PATCH v2 11/35] tcg/wasm: Add shl/shr/sar instructions
Date: Wed, 27 Aug 2025 01:10:16 +0900
Message-ID: <cb7883a5da41bad585b28293458c7bdc52057cd9.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42b.google.com
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

This commit implements the shl, shr and sar operations using Wasm
instructions. Since the Wasm backend uses 64bit variables, right shifts on
32bit values extract the lower 32bit of the operand before shifting. TCI
instructions are also generated in the same way as the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                | 31 +++++++++++++
 tcg/wasm/tcg-target.c.inc | 93 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.

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


