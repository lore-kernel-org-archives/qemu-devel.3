Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4110CCA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwIo-0005jE-Mf; Tue, 26 Aug 2025 12:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIe-00059P-42; Tue, 26 Aug 2025 12:13:34 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIU-000871-AM; Tue, 26 Aug 2025 12:13:31 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b49cf1d4f6fso2232616a12.3; 
 Tue, 26 Aug 2025 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224798; x=1756829598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFiDyHt5IwnbampOaWjLdnsRrs8OFqI+gDaDS6Ln9mA=;
 b=JhsGAwRCMOnXI2jjZBffLSYOuVaSQJqebjg5DrreMNIpIH7LKdSetWfqHNZ++qPiJx
 0LFo6Fb/QLZmoeKStJN/aUALg9l0yPaFA3c9DILqJnTWY5L2OiW9XNazbUcryVKzcjg8
 I7mW2S4hxtOI+cMHAKITlzgw+51Iyrl1bN/EvzBy864MpIoDE8RWffsXmmd3LCn6RVdU
 +3e7ZrEWDicZZzYUk+5yCJ7fj2mnlujF52QiODtsCzHNA71/gNYU3n72pwlVgdXEJ4xD
 Idm2mDaEcrwjJbMUMgxIE0Ko99vSKHv7mvhXYSVybbemsVAFEuhg3iNlmnr0oGqU7owy
 51MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224798; x=1756829598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFiDyHt5IwnbampOaWjLdnsRrs8OFqI+gDaDS6Ln9mA=;
 b=dRP4HK3skYZW1qEgSDoRnGT9IvHhyN+2m8+Kv+6DdxRXUSe4Vg+ypmXasX4Rs3O+ke
 QU8A33xX8M3Y+4MGjlK/ujsCj4BBEgZ84B36c5vDZMreJZslgYnurW/jCs7CZ2Jgb2bt
 fYWczminjsRkKp6bx/WR9G+k2E+lO3zNhIHNiqVFXqxsimnIEWIZjbVbNcU0QNpAMe9q
 i2fbu4F1ziZEsmF1i5/7ielqGRi01WfoFpCOEWvv0zwFGxAR8IsOsTTZ0SUZisXHlham
 rqT8GJRX2wvNAYgxvsUZ2HGa0rJ5mz3yTla/vG9E4Za2h5iHZDixBsbDsWFe1+36esJk
 Hezg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdd0qTJnOHWxxqvhT49FVnd1dpmz77/Xlr5+uEAzCDW+wZJ2iRq1NDHjdOt/TiqfP87KUWclr5Wg==@nongnu.org,
 AJvYcCX3CUD8mfsVkLqLN5Y1yeHCRcQrCdZw0tsj/QXxQ5u90zk/pHh2cojqlB7gSwIsMbchzIDFjVp3W2oGqA==@nongnu.org
X-Gm-Message-State: AOJu0YxuKk6WYg7dd1uekz2Oy2vYXEPNnQq3CEuQbXdXTqkk2OS0Y0hs
 PWOrIX4coYYxkT4HndpOJ64/qscwgtHQeFncnjYM3zEmuH9smVoMnalKBJ8XyA==
X-Gm-Gg: ASbGncuDyN4LKjmgIR1yOoo5QMy+nHjwbdKSUNcEUGKgnq/3RM3FbMv/1BsGIXMiqOG
 5dMxqnwamCkpEbmIIQBb7hX5jR8m8ur+SBHv5I46Hsl8VNX4P268oJLrm8I2/u3Q5t82uIL3ufl
 vps2sXgYaNdywSxxZ/BNPgCcICJqGl/MCovj0FoehrGAG01KigUNcImBNh6Bo54FB6gV6IPQlsT
 l3AxfQ/0yIk9wkNBiaeF/BDLUSpt+AS8RJhTIsD3BEBfzP5d+h3pR7UcQkWyN/O/PzXmLMpTzqs
 b49fJdYKSjZuWAEvFtR4wXcUyyliWsa5qr0s8vocPgSKiqV7c0rsIxcTO6eEJ1vbVXA6sj6pZ1/
 B2SzKhSSGQ+DkWLzehlcCCQ==
X-Google-Smtp-Source: AGHT+IG19Q+DuwPuB6N6G6K/27Xbf1c/5kRfeJ9sTqn/YAIcAGiVl8qj2hKzTpA7wPqzSO5q5FXCcg==
X-Received: by 2002:a17:90b:1845:b0:31a:ab75:6e45 with SMTP id
 98e67ed59e1d1-32517742cd6mr19074213a91.28.1756224798003; 
 Tue, 26 Aug 2025 09:13:18 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:13:17 -0700 (PDT)
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
Subject: [PATCH v2 22/35] tcg/wasm: Add call instruction
Date: Wed, 27 Aug 2025 01:10:27 +0900
Message-ID: <942c6e41ff9418ae82537b2b8eb81af543997dcc.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x532.google.com
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

To call QEMU functions from a TB's Wasm module, the functions must be
imported into the module.

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

TCI instructions are also generated in the same way as the original TCI
backend.

[1] https://github.com/WebAssembly/tool-conventions/blob/060cf4073e46931160c2e9ecd43177ee1fe93866/BasicCABI.md#function-arguments-and-return-values

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  63 +++++++++++++
 tcg/wasm.h                |  10 +++
 tcg/wasm/tcg-target.c.inc | 183 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.

diff --git a/tcg/wasm.c b/tcg/wasm.c
index c54c5c5b2c..db0c213d92 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -21,6 +21,10 @@
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-ldst.h"
+#include "tcg/helper-info.h"
+#include <ffi.h>
+
+__thread uintptr_t tci_tb_ptr;
 
 static void tci_args_l(uint32_t insn, const void *tb_ptr, void **l0)
 {
@@ -33,6 +37,13 @@ static void tci_args_r(uint32_t insn, TCGReg *r0)
     *r0 = extract32(insn, 8, 4);
 }
 
+static void tci_args_nl(uint32_t insn, const void *tb_ptr,
+                        uint8_t *n0, void **l1)
+{
+    *n0 = extract32(insn, 8, 4);
+    *l1 = sextract32(insn, 12, 20) + (void *)tb_ptr;
+}
+
 static void tci_args_rl(uint32_t insn, const void *tb_ptr,
                         TCGReg *r0, void **l1)
 {
@@ -204,6 +215,58 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         opc = extract32(insn, 0, 8);
 
         switch (opc) {
+        case INDEX_op_call:
+            {
+                void *call_slots[MAX_CALL_IARGS];
+                ffi_cif *cif;
+                void *func;
+                unsigned i, s, n;
+
+                tci_args_nl(insn, tb_ptr, &len, &ptr);
+                func = ((void **)ptr)[0];
+                cif = ((void **)ptr)[1];
+
+                n = cif->nargs;
+                for (i = s = 0; i < n; ++i) {
+                    ffi_type *t = cif->arg_types[i];
+                    call_slots[i] = &stack[s];
+                    s += DIV_ROUND_UP(t->size, 8);
+                }
+
+                /* Helper functions may need to access the "return address" */
+                tci_tb_ptr = (uintptr_t)tb_ptr;
+                ffi_call(cif, func, stack, call_slots);
+            }
+
+            switch (len) {
+            case 0: /* void */
+                break;
+            case 1: /* uint32_t */
+                /*
+                 * The result winds up "left-aligned" in the stack[0] slot.
+                 * Note that libffi has an odd special case in that it will
+                 * always widen an integral result to ffi_arg.
+                 */
+                if (sizeof(ffi_arg) == 8) {
+                    regs[TCG_REG_R0] = (uint32_t)stack[0];
+                } else {
+                    regs[TCG_REG_R0] = *(uint32_t *)stack;
+                }
+                break;
+            case 2: /* uint64_t */
+                /*
+                 * For TCG_TARGET_REG_BITS == 32, the register pair
+                 * must stay in host memory order.
+                 */
+                memcpy(&regs[TCG_REG_R0], stack, 8);
+                break;
+            case 3: /* Int128 */
+                memcpy(&regs[TCG_REG_R0], stack, 16);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
         case INDEX_op_and:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & regs[r2];
diff --git a/tcg/wasm.h b/tcg/wasm.h
index 9da38e4d0e..a3631b34a8 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -10,6 +10,16 @@ struct WasmContext {
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
index c077c8ad7c..0606b7de79 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -28,6 +28,14 @@
 #include "qemu/queue.h"
 #include "../wasm.h"
 
+/* Used for function call generation. */
+#define TCG_TARGET_CALL_STACK_OFFSET 0
+#define TCG_TARGET_STACK_ALIGN       8
+#define TCG_TARGET_CALL_ARG_I32      TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128     TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_NORMAL
+
 typedef uint32_t tcg_insn_unit_tci;
 
 static const int tcg_target_reg_alloc_order[] = {
@@ -143,6 +151,9 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 /* Local variable pointing to WasmContext */
 #define CTX_IDX 0
 
+/* Function index */
+#define HELPER_IDX_START 0 /* The first index of helper functions */
+
 typedef enum {
     OPC_UNREACHABLE = 0x00,
     OPC_LOOP = 0x03,
@@ -151,6 +162,7 @@ typedef enum {
     OPC_END = 0x0b,
     OPC_BR = 0x0c,
     OPC_RETURN = 0x0f,
+    OPC_CALL = 0x10,
     OPC_LOCAL_GET = 0x20,
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
@@ -832,6 +844,147 @@ static void tcg_wasm_out_goto_tb(
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
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1604,11 +1757,41 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
+static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
+                             tcg_target_long imm)
+{
+    /* This function is only used for passing structs by reference. */
+    g_assert_not_reached();
+}
+
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
+                         const TCGHelperInfo *info)
+{
+    ffi_cif *cif = info->cif;
+    tcg_insn_unit_tci insn = 0;
+    uint8_t which;
+
+    if (cif->rtype == &ffi_type_void) {
+        which = 0;
+    } else {
+        tcg_debug_assert(cif->rtype->size == 4 ||
+                         cif->rtype->size == 8 ||
+                         cif->rtype->size == 16);
+        which = ctz32(cif->rtype->size) - 1;
+    }
+    new_pool_l2(s, 20, s->code_ptr, 0, (uintptr_t)func, (uintptr_t)cif);
+    insn = deposit32(insn, 0, 8, INDEX_op_call);
+    insn = deposit32(insn, 8, 4, which);
+    tcg_out32(s, insn);
+    tcg_wasm_out_call(s, (intptr_t)func, info);
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
     init_blocks();
     init_label_info();
+    init_helpers();
 
     tcg_wasm_out_op_block(s, OPC_LOOP, BLOCK_NORET);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
-- 
2.43.0


