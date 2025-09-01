Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D590BCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut33Y-000601-Fj; Mon, 01 Sep 2025 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31Z-0003ee-8R; Mon, 01 Sep 2025 07:48:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31J-0001pm-Hw; Mon, 01 Sep 2025 07:48:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-248c7f955a2so37343655ad.2; 
 Mon, 01 Sep 2025 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727289; x=1757332089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mhZoyyImgDjzAPXj+YimSquQazjd0N7mWZJ50wnHeY=;
 b=LG9a+v/9Gx1DM0ZdNVMVKRxxGCC2XE8RoKcZcb7Xt+EybY8kUorRcZ1eIqqXFGK5bH
 EVk59HuDZBa02wrFqtjX7mk2AOHo/bjwyIpKw529/8hX/86LxgjudQJjbAGYFZuZFcXX
 D8UAymZoN/aVNBfWueMRTciWp9UnMYDYSW1W5yLMxKM8j37E3e2fV/Lrsoby8lxfsTEm
 A7danQoWblmpHnKga399qF9JEgS+LIvQFoMKUykflIzcUlpZ+dvjw7vfRJHTwMGr2G5x
 hr0qVGDdkxDZ3QYZ7Rws6JrgEUamyYCgMnhC2B5KYbfhNAyeM/S4InAlf6PcthU1EHk7
 vzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727289; x=1757332089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mhZoyyImgDjzAPXj+YimSquQazjd0N7mWZJ50wnHeY=;
 b=WsbVBIE1e/a26W4Bsp1yBimnPJhoG36rVuccxpNcP4OC7aNfh5makzm9i4eWGPqaYK
 kBTebskZqnN2sHTHXcv3ri7XsROqF1DDx+6/Ak7g+8ExrkOdrviY7F+HiHCjUH5LVA9k
 il4pPQpIXaNHUX6Lwi5S+Blb+2Rhz+E4U8rfwLWJsHgbmlaEeuiYh+O5gDMMlpIkwjpH
 xc+w98cyB/BXvBbLytWuUzGcOYH+j/Smf8n8sXmSHnJGR4Zmdefz39kfvkoqjda0iMs9
 GzNcIa0nQkCjn64fFo3DpS3WN5qrIJILukkU34Png9dDigIjPwmaMJSFMJeRWjKz45a7
 DXSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaNdRHxCLzjLYjLBetk3aJCSBWJ+bp2LAtZaS7NgYlUp9xdtOCe43ctIgb2Ha8yXzsAMHApr5wHcKfhg==@nongnu.org,
 AJvYcCWRsAsW6mUZiWqBLdca/onDtNii3C0lLWdc5yj9VCMSlIbLXCfdCxEfw8d87bqGMqwBZbpMmE9PWQ==@nongnu.org
X-Gm-Message-State: AOJu0YxfszGfLqDnYMqJhRfaGOFsbwtF3F4CRj5hbOWtcDGnWG1mEJr1
 ngBoezwr66oVMvMshaEa8KWocV9sELjVtZ+f1Bm7r+4j6eygleGo5T5K9MEZwg==
X-Gm-Gg: ASbGncvxBwpQapG+hOhaocb0ayBYcaURpastbiOOuunYeSEWFI/BQfX8KOSUHxwzG/4
 +5Q6/FBgy51Vldbjhq0rvnWG31TNt21rouJLALeto5HorCBMCF1s+cVS6pM7eiH3f70fFfdXtm7
 fMqAlqinSUzPBIHK98R8Wlo5UKYGOEnfel+8x2Vnxy5DqPFuiJ04+7b4mbWMDPNX7+ngDLydPeQ
 SopMo8geTEENBb04p107MnnYqKYzLyJBLnW2npsVLs2zEEIDTC77XaumEDrFkHifPN97uAquNwh
 Tvvz6BNPk+CgW9eWRFLho99VLavWHKibD/B+4pDGrhZ+3Y28Uncne9RCIxvvKkwy1Kci7JYTqVE
 RpBQT33HPhuZygKR1SWrhGZE2RAix+fth
X-Google-Smtp-Source: AGHT+IHNZ8chk7HN4IaK7VGH469nQvszfLdvVQbyw/C82kWfZk/Gbu1regw3qFi2butVz/CuKmpPsg==
X-Received: by 2002:a17:902:e749:b0:24a:ad84:b1bd with SMTP id
 d9443c01a7336-24aad84b320mr60189555ad.32.1756727288914; 
 Mon, 01 Sep 2025 04:48:08 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:48:08 -0700 (PDT)
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
Subject: [PATCH v3 29/35] tcg/wasm: Allow switching coroutine from a helper
Date: Mon,  1 Sep 2025 20:44:31 +0900
Message-ID: <18770eb1458b4824b97608563ce6a65dc381e994.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Emscripten's Fiber coroutine implements coroutine switching using Asyncify's
stack unwinding and rewinding features [1]. When a coroutine yields
(i.e. switches out), Asyncify unwinds the stack, returning control to
Emscripten's JS code (Fiber.trampoline()). Then execution resumes in the
target coroutine by rewinding the stack. Stack unwinding is implemented by a
sequence of immediate function returns, while rewinding re-enters the
functions in the call stack, skipping any code between the function's entry
point and the original call position [2].

This commit updates the TB's Wasm module to allow helper functions to
trigger coroutine switching. Particaully, the TB handles the unwinding and
rewinding flows as follows:

- The TB check the Asyncify.state JS object after each helper call. If
  unwinding is in progress, the TB immediately returns to the caller so that
  the unwinding can continue.
- Each function call is preceded by a block boundary and an update of the
  BLOCK_IDX variable. This enables rewinding to skip any code between the
  function's entry point and the original call position.

Additionally, this commit introduces WasmContext.do_init which is a flag
indicating whether the TB should reset the BLOCK_IDX variable to 0
(i.e. start from the beginning). call_wasm_tb is a newly introduced wrapper
function for the Wasm module's entrypoint and this sets "do_init = 1" to
ensure normal TB execution begins at the first block. During a rewinding,
the C code does not set do_init to 1, allowing the TB to preserve the
BLOCK_IDX value from the previous unwinding and correctly resume execution
from the last unwound block.

[1] https://emscripten.org/docs/api_reference/fiber.h.html
[2] https://kripken.github.io/blog/wasm/2019/07/16/asyncify.html#new-asyncify

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  3 ++
 tcg/wasm.h                | 11 ++++++++
 tcg/wasm/tcg-target.c.inc | 58 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 15db1f9a8a..82987e9dff 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -44,6 +44,9 @@ EM_JS_PRE(void*, instantiate_wasm, (void *wasm_begin,
     const wasm = HEAP8.subarray(DEC_PTR(wasm_begin),
                                 DEC_PTR(wasm_begin) + wasm_size);
     var helper = {};
+    helper.u = () => {
+        return (Asyncify.state != Asyncify.State.Unwinding) ? 1 : 0;
+    };
     const entsize = TCG_TARGET_REG_BITS / 8;
     for (var i = 0; i < import_vec_size / entsize; i++) {
         const idx = memory_v.getBigInt64(
diff --git a/tcg/wasm.h b/tcg/wasm.h
index b5d9ce75da..fdde908557 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -30,11 +30,22 @@ struct WasmContext {
      * Pointer to a stack array.
      */
     uint64_t *stack;
+
+    /*
+     * Flag indicating whether to initialize the block index(1) or not(0).
+     */
+    uint32_t do_init;
 };
 
 /* Instantiated Wasm function of a TB */
 typedef uintptr_t (*wasm_tb_func)(struct WasmContext *);
 
+static inline uintptr_t call_wasm_tb(wasm_tb_func f, struct WasmContext *ctx)
+{
+    ctx->do_init = 1; /* reset the block index (rewinding will skip this) */
+    return f(ctx);
+}
+
 /*
  * A TB of the Wasm backend starts from a header which contains pointers for
  * each data stored in the following region in the TB.
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 7663f03eaf..6af4d6eb07 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -152,7 +152,8 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 #define CTX_IDX 0
 
 /* Function index */
-#define HELPER_IDX_START 0 /* The first index of helper functions */
+#define CHECK_UNWINDING_IDX 0 /* A function to check the Asyncify status */
+#define HELPER_IDX_START 1 /* The first index of helper functions */
 
 #define PTR_TYPE 0x7e
 
@@ -169,6 +170,7 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I32_LOAD = 0x28,
     OPC_I64_LOAD = 0x29,
     OPC_I64_LOAD8_S = 0x30,
     OPC_I64_LOAD8_U = 0x31,
@@ -176,6 +178,7 @@ typedef enum {
     OPC_I64_LOAD16_U = 0x33,
     OPC_I64_LOAD32_S = 0x34,
     OPC_I64_LOAD32_U = 0x35,
+    OPC_I32_STORE = 0x36,
     OPC_I64_STORE = 0x37,
     OPC_I64_STORE8 = 0x3c,
     OPC_I64_STORE16 = 0x3d,
@@ -1116,6 +1119,17 @@ static int64_t get_helper_idx(TCGContext *s, intptr_t helper_idx_on_qemu)
     return -1;
 }
 
+static void tcg_wasm_out_handle_unwinding(TCGContext *s)
+{
+    tcg_wasm_out_op_idx(s, OPC_CALL, CHECK_UNWINDING_IDX);
+    tcg_wasm_out_op(s, OPC_I32_EQZ);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    /* returns if unwinding */
+    tcg_wasm_out_op(s, OPC_RETURN);
+    tcg_wasm_out_op(s, OPC_END);
+}
+
 static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
                               const TCGHelperInfo *info)
 {
@@ -1132,7 +1146,16 @@ static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
     tcg_wasm_out_op_const(s, OPC_I64_CONST, (uint64_t)s->code_ptr);
     tcg_wasm_out_op_ldst(s, OPC_I64_STORE, 0, ofs);
 
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, cur_block_idx + 1);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+    tcg_wasm_out_new_block(s);
+
     gen_call(s, info, func_idx);
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static void gen_func_type_qemu_ld(TCGContext *s, uint32_t oi)
@@ -1204,6 +1227,14 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
         gen_func_type_qemu_ld(s, oi);
     }
 
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, cur_block_idx + 1);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+    tcg_wasm_out_new_block(s);
+
     /* call the target helper */
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
@@ -1212,6 +1243,7 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
 
     tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(data_reg));
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static void *qemu_st_helper_ptr(uint32_t oi)
@@ -1245,6 +1277,14 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
         gen_func_type_qemu_st(s, oi);
     }
 
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, cur_block_idx + 1);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+    tcg_wasm_out_new_block(s);
+
     /* call the target helper */
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
@@ -1261,6 +1301,7 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
     tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
 
     tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
@@ -2264,6 +2305,9 @@ static const uint8_t mod_1[] = {
     0x60,                         /* 0: Type of "start" function */
     0x01, PTR_TYPE,               /* arg: ctx pointer */
     0x01, PTR_TYPE,               /* return: res */
+    0x60,                         /* 1: Type of the asyncify helper */
+    0x0,                          /* no argument */
+    0x01, 0x7f,                   /* return: res (i32) */
 };
 
 #define MOD_1_PH_TYPE_SECTION_SIZE_OFF 9
@@ -2289,6 +2333,9 @@ static const uint8_t mod_2[] = {
     0x02, 0x07,                               /* shared mem(64bit) */
     0x00, 0x80, 0x80, 0x10,                   /* min: 0, max: 262144 pages */
 #endif
+    0x06, 0x68, 0x65, 0x6c, 0x70, 0x65, 0x72, /* module: "helper" */
+    0x01, 0x75,                               /* name: "u" */
+    0x00, 0x01,                               /* func type 1 */
 };
 
 #define MOD_2_PH_IMPORT_SECTION_SIZE_OFF 1
@@ -2427,8 +2474,17 @@ static void tcg_out_tb_start(TCGContext *s)
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_CALL_STACK));
     tcg_wasm_out_op(s, OPC_END);
 
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(do_init));
+    tcg_wasm_out_op_ldst(s, OPC_I32_LOAD, 0, ofs);
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 0);
+    tcg_wasm_out_op(s, OPC_I32_NE);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
     tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(do_init));
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, 0);
+    tcg_wasm_out_op_ldst(s, OPC_I32_STORE, 0, ofs);
+    tcg_wasm_out_op(s, OPC_END);
 
     tcg_wasm_out_op_block(s, OPC_LOOP, BLOCK_NORET);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
-- 
2.43.0


