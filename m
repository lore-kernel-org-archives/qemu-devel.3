Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9EEC88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtE-00057x-6D; Mon, 26 Jan 2026 02:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfu-00035Z-Op
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:21 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfo-0004Ol-VL
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:13 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f4e136481so2065447b3a.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411128; x=1770015928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsGEhSeVl1NqcIA0je3eZOmWyYh2uE5d9S+11aiI57c=;
 b=fTLgrPn0UCkxX++ObPgIiUszUgwPCYc3wBrfIl0/+esIj2cGnJj2f145ftN5KWJFhk
 OSvUb4iaIu4+nJduozxSy73Md3/53pH6utemCz1RfXz+CXUdtZFkDndHRinecsF0d0Af
 je62sCDi5MFx2XGsQgqxOE04FxmmPvX2nT1ahULBgfoqEhr4hdk0xfyfERlWrgiGTxLf
 h8n91qVHw7DAT5vhBX/dyau/UXq781FtUI7k+/SCBqG0wJznb+6xfKb7vFr/ZAQ+89NO
 zVWVM5ofEJIN63R11C7Kn2h+MHLVLkn2IJIi1IyeD1XLGwaHIVSQYUgpkmSSy4kBy+JK
 jZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411128; x=1770015928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WsGEhSeVl1NqcIA0je3eZOmWyYh2uE5d9S+11aiI57c=;
 b=riUwWLK80PqExi5P/gX0Wv86DkQNVh7R9uaHJTeHd+VM046KyinyZ/n2zDpff4BLzc
 LtEVR2yXMmXazPKaiZXb6BIAhX1VwZE7S2XBLW8j2WFPv4/h0HB5bscInBE5DfzA6Ch1
 +ofLKeiaYHCEimq+c+m9pr5xdyzn/tRwBQKNdnldxSLwKGk/Oxlt/lZxukZVEzQS1EVQ
 EiqnxvyOaPuBSZ568wOEBM2Q45XID8bFHeuyJugB2oZFHq4ZpKTZ8RoODp9eC0hFJiIa
 c0zZu6H4UuKpPFO32i8e5URw6pYSKhkJOfDGJjzP11wwtJxMzRf7qNa3odNG5FKMKVVb
 bAKA==
X-Gm-Message-State: AOJu0YyU528XoLuTZN81Kf5fwkdes4XnBQuppjG2U4jSiDTyYw7h979q
 tkXs0P8lQIcryG9cWnmFCuJSvbbYbVjBx/coS5M9xt/1SY4gSeX8NdJU3wG/Qtpc
X-Gm-Gg: AZuq6aJS41ihZy6yBL9JVm/pkBQ5A2tHTdIRt71ILMkPz3Ng5952IhYELE5VOo7x+l+
 E/47vfTwUS3JR0gDcIUwk5X32caLdui4LuAPPW4j7wEAvJ4B6WChQLcs/V/poPCQMar8yKfPSzH
 Uieq8gfJsG/bPih6wGQ/C/OY086KKdI7/NfS5quseKy8KUuzcRaHJIILyc6EzbGhVxx4gMwmnwe
 zz+YMaQF1iGQ1VzwFpDVFj6B8OYGtm+hipr2fwvA8P67uP7f2evR29SYbHfLCafEGiFNj3svYCc
 nI7H90ZHaGzpcTLPP/jZE7+Jc1+6p3fjILyOijHH9JsMMuTbPw/ks1jDR6jtIvbhaDzkPh/Qu3V
 yjIde+jTQ6jHErOxEAr/vHV2b93mWq0g316mZbHpH8NCgmskceb7PwJuuWHH2hGFYeeD4dtFpgN
 d0JukS5ai/1QxY5F1tK1A9/SmTeT/ziqYF9SENY6+JOmMJ/oOinej6
X-Received: by 2002:a05:6a00:3a2a:b0:821:80d7:2efa with SMTP id
 d2e1a72fcca58-823412a37c1mr3032033b3a.51.1769411128369; 
 Sun, 25 Jan 2026 23:05:28 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:27 -0800 (PST)
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
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 18/33] tcg/wasm64: Add call instruction
Date: Mon, 26 Jan 2026 07:03:31 +0000
Message-ID: <8e288d8a54cecea24c88def7aab9a221806abbc3.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 tcg/wasm64.c                |  59 ++++++++++++
 tcg/wasm64.h                |  10 ++
 tcg/wasm64/tcg-target.c.inc | 183 ++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index c54c5c5b2c..9fb29131cb 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
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
@@ -204,6 +215,54 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
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
diff --git a/tcg/wasm64.h b/tcg/wasm64.h
index 9da38e4d0e..a3631b34a8 100644
--- a/tcg/wasm64.h
+++ b/tcg/wasm64.h
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
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index ff1151390b..765ab72941 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -28,6 +28,14 @@
 #include "qemu/queue.h"
 #include "../wasm64.h"
 
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


