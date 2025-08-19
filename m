Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54543CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR1z-000380-QH; Tue, 19 Aug 2025 14:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1a-0001nB-BX; Tue, 19 Aug 2025 14:25:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1X-0004aJ-L5; Tue, 19 Aug 2025 14:25:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-244581cc971so66766965ad.2; 
 Tue, 19 Aug 2025 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627929; x=1756232729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uY8pkG0EyUHp7TJZzW6pu+thngmuu/hzgZ+1SF/arE=;
 b=Xf85jjU6kJ/YfPrqQNIwjUaxZkwrvoRYWW7ajLYQ4uS37EA1XQNoi926SQ4koFvAWD
 7ZmiuwU8RJOch28DHcD3kXnMiPCFO4xXASGx+r8FyGu/VVTbJm4vC1FyIocJ98IjH1Jw
 ZgwY5oyXq1VTmAwF6qQi0qsUUyBNgL0Gp8M5Xf7gS9+paIAIoYCXvqF3/kt85w7Tt5wN
 ikYetGuNS/VGAm1KX2Kd/5wbmm/R+udsMgg/UobaL8n3cZecTYe7d4xAR+X77GK50DSK
 FJ1Ysfqx23Scy6VsSA31dxFYyDHVfYzt1buc/ovLguK4sAHUQ8+Yt4GB9TvEZCsJUPur
 zgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627929; x=1756232729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2uY8pkG0EyUHp7TJZzW6pu+thngmuu/hzgZ+1SF/arE=;
 b=jn6MuBTgb78eW+Rqy15tleW+qms2W5Cu5nGQNtSLb4KjzmiqwFS+LtzjN1+usBxwSB
 Hbmitxnt+0C8Hk3P4/iF1+ErRKcgq93W/UeWEbyW3Fj9G5vmOIrq0qChAOktHscn/PtD
 w1FxR+WfCNnosfn8/tIxRqxzZhOQafBVowxklW+GLEVOc50cekUhqUTOJy8V5EHunjAW
 ZITfr2Ghj+Lh3QCfB0z308QsVIFDvIUCYHQugHCk/raUYuN6sAwdl4fkHTAQbd+rOL/c
 RgiAMHUyPVnMqek6nrpqto049w9Xm/yV5tZ4TuYo9ayP7lZ2yN8jOB081K5os7FKA0Iu
 O2GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMdBT5CJkZCkV624+saTW8dpHWn0NXbrWJbNI/8OBR4Nabt50Ap14PP2j2iA4KWgQAhVIf3ehGXgVrqw==@nongnu.org,
 AJvYcCWus+lsa3q8CuYRGmvgrqwt2QHbV3Sq6AULmsp3KY9ePo3kGXZeLHlnRRZWDaBH1jsvb4aBl5NCKQ==@nongnu.org
X-Gm-Message-State: AOJu0YwD4OMk5GWDy7Tfl6YXw7m0yyAHds9pfzEqCi3HE4lMQauR8A5W
 ymzhNf6gqZcpEs8FRWYiECfNq9tEPPXCEuQvq8s6oCHihiaciOGwlKcNclFVvg==
X-Gm-Gg: ASbGncu4fjepK3q+NqkNnQ4I90QHFUY+DfoZ9r0PSLNIci+dvK47aa+tssSkHYJypLB
 g4XgYIFEES51u/xZyWHPBe2aHFQnVy0RLQNqrmP6TYFVaHJPOXWd3Rmp5eyHL7laeGgbHFYMutZ
 wiS7/dqSuWzV+4+RV+HA0jZidY4UZvh5Y+uPStKXca25CYlise/Qiv3o9c0aXmMIJpX4bKohM77
 oDMsMdM/j2FYtIptCH5+OgVOCvjQrYuNuBIf6wCaIaVJRjyRsNAuadUx2PvHasun0aBP3zfhkc1
 vYHovIx8wtWNYsl/BTWfOo3GZwOSArQdhRt3Wa/dy9H2I39jllMCl2AT54K/wpYQwQaoX602144
 YTYUTgENr5PPDT9rX+xsUziVeuFM6ULDDqb4ayz3+BtM=
X-Google-Smtp-Source: AGHT+IGmOOmGHsheZIHtUrQVMjqPoTwL3iFRff+4Tim/REDZu1OCu8CID8Q/YPxCaoWIXFLBRsQLPA==
X-Received: by 2002:a17:903:2443:b0:242:8a7:6a6c with SMTP id
 d9443c01a7336-245e02d7629mr46827595ad.17.1755627929480; 
 Tue, 19 Aug 2025 11:25:29 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:29 -0700 (PDT)
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
Subject: [PATCH 31/35] tcg/wasm: Allow switching coroutine from a helper
Date: Wed, 20 Aug 2025 03:22:00 +0900
Message-ID: <dd60e2a05ca236cd07e118f37e73c44fd814f6c0.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x629.google.com
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

Emscripten's Fiber coroutine implements coroutine switching using Asyncify's
stack unwinding and rewinding features [1]. When a coroutine yields
(i.e. switches out), Asyncify unwinds the stack, returning control to
Emscripten's JS code (Fiber.trampoline()). Then execution resumes in the
target coroutine by rewinding the stack. Stack unwinding is implemented by a
sequence of immediate function returns, while rewinding re-enters the
functions in the call stack, skipping any code between the function's entry
point and the original call position [2].

This commit updates the Wasm TB module to allow helper functions to trigger
coroutine switching. Particaully, the TB handles the unwinding and rewinding
flows as follows:

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
 tcg/wasm.c                |  3 +++
 tcg/wasm.h                | 11 ++++++++
 tcg/wasm/tcg-target.c.inc | 56 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 835167f769..f879ab0d4a 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -64,6 +64,9 @@ EM_JS_PRE(void*, instantiate_wasm, (void *wasm_begin,
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
index 260b7ddf6f..a7e2ba0dd7 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -32,11 +32,22 @@ struct WasmContext {
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
+};
+
 /*
  * A TB of the Wasm backend starts from a header which contains pointers for
  * each data stored in the following region in the TB.
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index a1dbdf1c3c..f1b7ec5f47 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -132,7 +132,8 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 #define TMP64_LOCAL_0_IDX 2
 
 /* Function index */
-#define HELPER_IDX_START 0 /* The first index of helper functions */
+#define CHECK_UNWINDING_IDX 0 /* A function to check the Asyncify status */
+#define HELPER_IDX_START 1 /* The first index of helper functions */
 
 #define PTR_TYPE 0x7e
 
@@ -1286,6 +1287,17 @@ static int64_t get_helper_idx(TCGContext *s, intptr_t helper_idx_on_qemu)
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
@@ -1302,7 +1314,16 @@ static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
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
@@ -1374,6 +1395,14 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
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
@@ -1382,6 +1411,7 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
 
     tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(data_reg));
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static void *qemu_st_helper_ptr(uint32_t oi)
@@ -1415,6 +1445,14 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
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
@@ -1431,6 +1469,7 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
     tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
 
     tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
@@ -2612,6 +2651,9 @@ static const uint8_t mod_1[] = {
     0x60,                         /* 0: Type of "start" function */
     0x01, PTR_TYPE,               /* arg: ctx pointer */
     0x01, PTR_TYPE,               /* return: res */
+    0x60,                         /* 1: Type of the asyncify helper */
+    0x0,                          /* no argument */
+    0x01, 0x7f,                   /* return: res (i32) */
 };
 
 #define MOD_1_PH_TYPE_SECTION_SIZE_OFF 9
@@ -2637,6 +2679,9 @@ static const uint8_t mod_2[] = {
     0x02, 0x07,                               /* shared mem(64bit) */
     0x00, 0x80, 0x80, 0x10,                   /* min: 0, max: 262144 pages */
 #endif
+    0x06, 0x68, 0x65, 0x6c, 0x70, 0x65, 0x72, /* module: "helper" */
+    0x01, 0x75,                               /* name: "u" */
+    0x00, 0x01,                               /* func type 1 */
 };
 
 #define MOD_2_PH_IMPORT_SECTION_SIZE_OFF 1
@@ -2775,8 +2820,17 @@ static void tcg_out_tb_start(TCGContext *s)
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


