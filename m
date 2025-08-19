Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4879BCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR1M-0001V9-Gx; Tue, 19 Aug 2025 14:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR12-0001Ds-JI; Tue, 19 Aug 2025 14:25:04 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR10-00047B-6v; Tue, 19 Aug 2025 14:25:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-244581caca6so43636935ad.2; 
 Tue, 19 Aug 2025 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627895; x=1756232695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtkykzeH9qSOmbsg3y5wTXrba4XSdnuJVlbAm8R2kzI=;
 b=c+YzA6+QduWhhgdHNM69JsjOqFu3ewznMNULBp9H4NpsE8Gumm1oBJ4fHc/bQO/EgL
 NlKwSWnqCTCDNuT55dPTem8edkL0krtd6XgWwy5VTQwG69vKAU1ISI9yPp8qCBSoiABj
 QRqClQF4ceAchctFzN8ElQwsgHYP+A18fd+PWCJ8KNv6bcXTRaIZLetJCRK8r9I6bY1Z
 25Fx4yfMOYCN3z1ib9ytqXa85nuE02jgFR2/p/9wj/rHEvSxHNL877i3Djr9VfxzvTO/
 +94xUQkFKq/FnTfM834yc+1d5G3oqPNwJWxLjdU1i0rIjL1UdPs8uAhyvQUT2ghMUkzr
 HMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627895; x=1756232695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtkykzeH9qSOmbsg3y5wTXrba4XSdnuJVlbAm8R2kzI=;
 b=sWk4RpE58bm7ElhoM57se9Pk5GJfImEG6waqq660YCbgAmbQXtcIZD+H2ohFz0GtqL
 w3+oMh5PgU136/xNFt25V67i3sawn0PvUn2wW1HPcEl8S3i326b8H9kL3a6LNfB0tM3a
 E+R1rvnOfCo6SsCQKt4MFzpV++Vr8EE1m6UwsSSonfNziqjOcVk5/uz4kLNCozwiSpnw
 sV2TP5bcU5oxPeLRYOD+MumIzMUcn83VWOgCQzjRBnQyv/nPlDsP3B+mk45yZPeGPQgG
 aE01VSKE+sllOi7bV0IkgAK1unLXr1X3svKH2lhf85MM/FzbrjNHDBX39+b80RMkDXOh
 cXLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwgBEu7Py4srdTApDvlXbzTnXtc3v+Zo+05n2vUQA1+gR5c2ZesCYV2G8EyoWpuK3ca29DIzrW6A6zfg==@nongnu.org,
 AJvYcCVklafB320x2IdmoziXTt3CSAvf3UaFq68YZGsiB66DQ9XaFW/7N9Nk+b7PUilbj+gaZi6Q/fzGxg==@nongnu.org
X-Gm-Message-State: AOJu0Yx9u291x2Y9WIfvf5QRIOAw6J9pHJeZdJLx9JsgN9szdF0EKb56
 DGP2kIS+QPnv7cZOHSPbIlE2cnlPwyosavxcEWDZV5putmh4bb9jswgtOaqlHQ==
X-Gm-Gg: ASbGncuNp9HXFjjZfsWyBInhFINsSngA/BeaO2ctHIHFV9b8TwYk6gIUfKIE/Pv1QXi
 g8tSlezXJVmAa4L64HTvVy2dPSLFsKfgQTYzN8JKlZCvKQ8aceDhkpX8NWj3HEVMMPi4ZqjEUB+
 VdRVGWjcBLBND5g2ICxv0qUCGmcPvzatrpmbk69EU4R5tJEWfQFdHzN18Y3Gnr/+k3o6htKh0hj
 +YJoz2rLnzuA3kkRrS1+9RzEx3lUviWoIqPjL0SpaWrZDShoxnTaGb2z4gg4tEysH8dnWMvylnn
 yqzPQxmKp/SF9hGOGOT1axfJUGZU2MF73jn+kvtZCcncjlm/uF2BFc5msWqMhP2x3E3dp2EgpWi
 6AehvOSaObV/dlM6vObWvrybC5yCOI5nU
X-Google-Smtp-Source: AGHT+IE2n81WeAJI9yVIAZcxR3gmAe13JD+midgBrZ1wm09MfeB1BLWUozNOsvM0q2GQjsT+C1M/ig==
X-Received: by 2002:a17:903:2ac5:b0:240:3909:5359 with SMTP id
 d9443c01a7336-245e04b7bc7mr41833565ad.40.1755627895554; 
 Tue, 19 Aug 2025 11:24:55 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:24:55 -0700 (PDT)
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
Subject: [PATCH 25/35] tcg/wasm: Add call instruction
Date: Wed, 20 Aug 2025 03:21:54 +0900
Message-ID: <1c2779b1aa2858a5d3609a00c1b1e8476703f3cb.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x632.google.com
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

To call QEMU functions from a TB (i.e. a Wasm module), those functions must
be imported into the module.

Wasm's call instruction can invoke an imported function using a locally
assigned function index. When a call TCG operation is generated, the Wasm
backend assigns the ID (starting from 0) to the target function. The mapping
between the function pointer and its assigned ID is recorded in a list of
HelperInfo.

Since Wasm's call instruction requires arguments to be pushed onto the Wasm
stack, the backend retrieves the function arguments from TCG's stack array
and pushes them to the Wasm stack before the call. After the function
returns, the result is retrieved from the Wasm stack and set in the
corresponding TCG variable.

In the Emscripten build configured with !has_int128_type, a 128bit value is
represented by the Int128 struct. Such values are passed to the function via
pointer parameters and returned via a prepended pointer argument, as
described in [1]. For this prepended buffer area, the module expects a
pre-allocated Int128 buffer from the caller via ctx.buf128.

Helper functions expect the target of the return instruction via the GETPC
macro (the tci_tb_ptr variable in TCI). However, unlike other architectures,
Wasm doesn't have a register pointing to the return target. To emulate this
behaviour, the Wasm module sets the instruction pointer to the corresponding
TCI instruction (s->code_ptr) in tci_tb_ptr passed via the WasmContext.

[1] https://github.com/WebAssembly/tool-conventions/blob/060cf4073e46931160c2e9ecd43177ee1fe93866/BasicCABI.md#function-arguments-and-return-values

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.h                |  10 +++
 tcg/wasm/tcg-target.c.inc | 147 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/tcg/wasm.h b/tcg/wasm.h
index bd12f1039b..fba8b16503 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -12,6 +12,16 @@ struct WasmContext {
      * Pointer to the TB to be executed.
      */
     void *tb_ptr;
+
+    /*
+     * Pointer to the tci_tb_ptr variable.
+     */
+    void *tci_tb_ptr;
+
+    /*
+     * Buffer to store 128bit return value on call.
+     */
+    void *buf128;
 };
 
 #endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index c907a18d9e..d7d4fd4e58 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -131,6 +131,9 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 #define TMP32_LOCAL_0_IDX 1
 #define TMP64_LOCAL_0_IDX 2
 
+/* Function index */
+#define HELPER_IDX_START 0 /* The first index of helper functions */
+
 typedef enum {
     OPC_UNREACHABLE = 0x00,
     OPC_LOOP = 0x03,
@@ -139,6 +142,7 @@ typedef enum {
     OPC_END = 0x0b,
     OPC_BR = 0x0c,
     OPC_RETURN = 0x0f,
+    OPC_CALL = 0x10,
     OPC_LOCAL_GET = 0x20,
     OPC_LOCAL_SET = 0x21,
     OPC_GLOBAL_GET = 0x23,
@@ -1010,6 +1014,147 @@ static void tcg_wasm_out_goto_tb(
     tcg_wasm_out_op(s, OPC_END);
 }
 
+static void push_arg_i64(TCGContext *s, int *stack_offset)
+{
+    intptr_t ofs;
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_REG_CALL_STACK));
+    ofs = tcg_wasm_out_norm_ptr(s, *stack_offset);
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    *stack_offset = *stack_offset + 8;
+}
+
+static void gen_call(TCGContext *s,
+                     const TCGHelperInfo *info, uint32_t func_idx)
+{
+    unsigned typemask = info->typemask;
+    int rettype = typemask & 7;
+    int stack_offset = 0;
+    intptr_t ofs;
+
+    if (rettype ==  dh_typecode_i128) {
+        /* receive 128bit return value via the buffer */
+        ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(buf128));
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    }
+
+    for (typemask >>= 3; typemask; typemask >>= 3) {
+        switch (typemask & 7) {
+        case dh_typecode_void:
+            break;
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+            push_arg_i64(s, &stack_offset);
+            tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            push_arg_i64(s, &stack_offset);
+            break;
+        case dh_typecode_i128:
+            tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_REG_CALL_STACK));
+            tcg_wasm_out_op_const(s, OPC_I64_CONST, stack_offset);
+            tcg_wasm_out_op(s, OPC_I64_ADD);
+            stack_offset += 16;
+            break;
+        case dh_typecode_ptr:
+            push_arg_i64(s, &stack_offset);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+
+    switch (rettype) {
+    case dh_typecode_void:
+        break;
+    case dh_typecode_i32:
+    case dh_typecode_s32:
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        break;
+    case dh_typecode_i64:
+    case dh_typecode_s64:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        break;
+    case dh_typecode_i128:
+        ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(buf128));
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        ofs = tcg_wasm_out_norm_ptr(s, 0);
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(buf128));
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        ofs = tcg_wasm_out_norm_ptr(s, 8);
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R1));
+        break;
+    case dh_typecode_ptr:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+typedef struct HelperInfo {
+    intptr_t idx_on_qemu;
+    QSIMPLEQ_ENTRY(HelperInfo) entry;
+} HelperInfo;
+
+static __thread QSIMPLEQ_HEAD(, HelperInfo) helpers;
+__thread uint32_t helper_idx;
+
+static void init_helpers(void)
+{
+    QSIMPLEQ_INIT(&helpers);
+    helper_idx = HELPER_IDX_START;
+}
+
+static uint32_t register_helper(TCGContext *s, intptr_t helper_idx_on_qemu)
+{
+    tcg_debug_assert(helper_idx_on_qemu >= 0);
+
+    HelperInfo *e = tcg_malloc(sizeof(HelperInfo));
+    e->idx_on_qemu = helper_idx_on_qemu;
+    QSIMPLEQ_INSERT_TAIL(&helpers, e, entry);
+
+    return helper_idx++;
+}
+
+static int64_t get_helper_idx(TCGContext *s, intptr_t helper_idx_on_qemu)
+{
+    uint32_t idx = HELPER_IDX_START;
+    HelperInfo *e;
+
+    QSIMPLEQ_FOREACH(e, &helpers, entry) {
+        if (e->idx_on_qemu == helper_idx_on_qemu) {
+            return idx;
+        }
+        idx++;
+    }
+    return -1;
+}
+
+static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
+                              const TCGHelperInfo *info)
+{
+    intptr_t ofs;
+    int64_t func_idx = get_helper_idx(s, func);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, func);
+    }
+
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(tci_tb_ptr));
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    ofs = tcg_wasm_out_norm_ptr(s, 0);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (uint64_t)s->code_ptr);
+    tcg_wasm_out_op_ldst(s, OPC_I64_STORE, 0, ofs);
+
+    gen_call(s, info, func_idx);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -1420,6 +1565,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
     insn = deposit32(insn, 0, 8, INDEX_op_call);
     insn = deposit32(insn, 8, 4, which);
     tcg_out32(s, insn);
+    tcg_wasm_out_call(s, (intptr_t)func, info);
 }
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
@@ -2268,6 +2414,7 @@ static void tcg_out_tb_start(TCGContext *s)
     init_sub_buf();
     init_blocks();
     init_label_info();
+    init_helpers();
 
     tcg_wasm_out_op_block(s, OPC_LOOP, BLOCK_NORET);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
-- 
2.43.0


