Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFD5C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMVo-0006g8-Af; Tue, 20 May 2025 08:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUu-0004B6-0k; Tue, 20 May 2025 08:55:10 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUq-00016y-ES; Tue, 20 May 2025 08:55:07 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b26f5cd984cso3920614a12.3; 
 Tue, 20 May 2025 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745700; x=1748350500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldWym2VLMHax4CE85S7n09RdQWchgzVNNktVRnfbMqs=;
 b=BAhMoekwQS/pYCSpZhpaUVpWPuVMIywB9qxgYclvl8akkEvbXMiVG1OqEaUDqa3JM1
 pmGp6/zbnncnSsjSBQb/HVJTfIaZfbGDedvpXUtrB9RkEF/Y+uZMYjrpsvXD+y3CM0B3
 oZYNL3udS8hSGofdS6axIyMg2/UTPqmcHIjSTi09XdYCNdcJbfTmpPYXUn21zL93nnXT
 otFKIdZ7xeuSgwCKR4AJSBbSz0fs7oAQL7obfXt7buj/jKtqSiOIN6AEdv6Kx+vi62dG
 ApdJM+R2YqE1jbZP0TZT1gG7X0cRHF6SzfH7LDB9+/3vq0UEEF7YipBWgo061jq94R8t
 55wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745700; x=1748350500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldWym2VLMHax4CE85S7n09RdQWchgzVNNktVRnfbMqs=;
 b=JP9MVLT60tKiX9DA6x6Uj5kNuwn7nr57lff/BtQemwrOcZb6w44HpUFk6GsyXahuQI
 sZ9TZdYmuBlTex1dzZQQl6Y86UuEn+teqd4hvJnHArz2nXQgMXrSxGd3WuUmCg8fhUh4
 xiyNP9MP6TKl7UsxzsJR1I6l1AlIAuKo2qEUsURDFq4C+CE+4V6Kv74LEYT6mUnRddQZ
 G5pO8+pX0ka2e0ivNH1EWf9dZw6sXkrgWDOmobiepw9HDcSE851N4klg1HHnP2GDTxSe
 LyONUk+4PLyYclIN71P0POnK24lHJFMuTqBcxTFMA6nd2ngtXAzqxN2RJFOzRAwzUBh9
 U4QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvoYLOu+p1NodwMytM9U2lAWdOPapSKMbmT8P13jIs3lKGI6CpJWb4ybg61V3pQOZeEE3aPAskJ3G7HQ==@nongnu.org,
 AJvYcCXD2BetYAy+dnIR1i4m4Ecr9ODauymQwHGdZblVF5+F25QV8nk4aoP2booKbAgk1/2NGwZcoqFMzA==@nongnu.org
X-Gm-Message-State: AOJu0Yw9yodpszRoZYnz7NyqlFYXS8ks9p+sw+NeeKDbVIwZ8MhJRtTu
 UCpX3feKIKu5mtlcDqr4GcS63rWfzv0+EWTGvFZCiNK7sEzdPPjScbGiJ006q+8M
X-Gm-Gg: ASbGncsn7kx4zAnVgqPkyba1tT3/XuL8UtdApOvB3NqVEpTQoXZXNa++eI+WKD9FcAL
 jKROZfTWseaHnzU03DsJrTSIDNhcPRgKUpU/TKz+ftIp4KR3uxHWu3Ulh/HMFCiQTtUpYytz/wH
 QMFwpUyh5fuDj5EvtDXgocYF5BgM1egtfHf+id2OkEcCQCGls2/f2tGXeTkVW4CF/x7DGBtyjv2
 QSF2Wr+orlzv6oj2o/PjdfRJ42L8FPfiNKGeuCCBLF8Cwp6YhXj1/SpU0I1wn0eYZjK7aBCmokG
 f37vdaa+OYCxCxNicJe0wW5742cqJjlkMrRPY4EYIPbvZjZlb0U=
X-Google-Smtp-Source: AGHT+IErjVtBwvRt2kikcLU8V+gM9yO/qzQGjvrVXya4JW8hWhPZkE2oRWPWRlCaDe3Zlo+61szrMA==
X-Received: by 2002:a17:90b:4b0f:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-30e7d545920mr29668717a91.17.1747745699558; 
 Tue, 20 May 2025 05:54:59 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:59 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 29/33] tcg/wasm32: Allow Asyncify unwinding from TB
Date: Tue, 20 May 2025 21:51:31 +0900
Message-ID: <39e1655832058b6c16fde756d96e90bb7eae1db0.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x534.google.com
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

Emscripten's Fiber coroutine implements coroutine switching using the stack
unwinding and rewinding capabilities of Asyncify [1]. When a coroutine
yields (i.e. switches out), Asyncify unwinds the stack, returning control to
Emscripten's JS code (Fiber.trampoline()), which then performs stack
rewinding to resume execution in the target coroutine. Stack unwinding is
implemented by a sequence of immediate function returns, while rewinding
works by re-entering the functions in the call stack, skipping any code
between the top of the function and the original call position [2].

This commit modifies the Wasm TB modules to support Fiber
coroutines. Assuming the TCG CPU loop is executed by only one coroutine per
thread, a TB module must allow helper functions to unwind and be resumed via
rewinding.

Specifically:

- When a helper returns due to an unwind, the module must immediately return
  to its caller, allowing unwinding to propagate.
- When being called again for a rewind, the module must skip any code
  between the top of the function and the call position that triggered the
  unwind, and directly enter the helper.

To support this:

- TBs now check the Asyncify.state JS object after each helper call. If
  unwinding is in progress, the TB immediately returns control to the
  caller.
- Each function call is preceded by a block boundary and an update of the
  BLOCK_PTR_IDX variable. This enables the TB to re-enter execution at the
  correct point during a rewind, skipping earlier blocks.

Additionally, this commit introduces wasmContext.do_init which is a flag
indicating whether the TB should reset the BLOCK_PTR_IDX variable to 0
(i.e. start from the beginning). In call_wasm_tb, this is always set
(ctx.do_init = 1) to ensure normal TB execution begins at the first
block. Once the TB resets the BLOCK_PTR_IDX variable, it also clears
do_init. During a rewind, the C code does not set ctx.do_init to 1, allowing
the TB to preserve the BLOCK_PTR_IDX value from the previous unwind and
correctly resume execution from the last unwound block.

[1] https://emscripten.org/docs/api_reference/fiber.h.html
[2] https://kripken.github.io/blog/wasm/2019/07/16/asyncify.html#new-asyncify

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.c                |  3 ++
 tcg/wasm32.h                | 11 ++++++++
 tcg/wasm32/tcg-target.c.inc | 56 +++++++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/tcg/wasm32.c b/tcg/wasm32.c
index f2269c0a22..e6a3dbf750 100644
--- a/tcg/wasm32.c
+++ b/tcg/wasm32.c
@@ -53,6 +53,9 @@ EM_JS(int, instantiate_wasm, (int wasm_begin,
     const memory_v = new DataView(HEAP8.buffer);
     const wasm = HEAP8.subarray(wasm_begin, wasm_begin + wasm_size);
     var helper = {};
+    helper.u = () => {
+        return (Asyncify.state != Asyncify.State.Unwinding) ? 1 : 0;
+    };
     for (var i = 0; i < import_vec_size / 4; i++) {
         helper[i] = wasmTable.get(
             memory_v.getInt32(import_vec_begin + i * 4, true));
diff --git a/tcg/wasm32.h b/tcg/wasm32.h
index f8651af4ee..f2749f1e0e 100644
--- a/tcg/wasm32.h
+++ b/tcg/wasm32.h
@@ -32,11 +32,22 @@ struct wasmContext {
      * Pointer to a stack array.
      */
     uint64_t *stack;
+
+    /*
+     * Flag indicates whether to initialize basic registers(1) or not(0).
+     */
+    uint32_t do_init;
 };
 
 /* Instantiated Wasm function of a TB */
 typedef int32_t (*wasm_tb_func)(struct wasmContext *);
 
+static inline int32_t call_wasm_tb(wasm_tb_func f, struct wasmContext *ctx)
+{
+    ctx->do_init = 1; /* reset block index (rewinding will skip this) */
+    return f(ctx);
+}
+
 /*
  * TB of wasm backend starts from a header which stores pointers for each data
  * stored in the following region in the TB.
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index d9a3abae70..04cd9b6e4a 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -135,7 +135,8 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 #define TMP64_LOCAL_0_IDX 3
 
 /* function index */
-#define HELPER_IDX_START 0 /* helper funcitons */
+#define CHECK_UNWINDING_IDX 0 /* a funtion of checking Asyncify status */
+#define HELPER_IDX_START 1 /* helper funcitons */
 
 #define BUF_SIZE 1024
 typedef struct LinkedBuf {
@@ -1895,6 +1896,17 @@ static int get_helper_idx(TCGContext *s, int helper_idx_on_qemu)
     return -1;
 }
 
+static void tcg_wasm_out_handle_unwinding(TCGContext *s)
+{
+    tcg_wasm_out_op_call(s, CHECK_UNWINDING_IDX);
+    tcg_wasm_out_op_i32_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_op_i32_const(s, 0);
+    /* returns if unwinding */
+    tcg_wasm_out_op_return(s);
+    tcg_wasm_out_op_end(s);
+}
+
 static void tcg_wasm_out_call(TCGContext *s, int func,
                               const TCGHelperInfo *info)
 {
@@ -1908,7 +1920,16 @@ static void tcg_wasm_out_call(TCGContext *s, int func,
     tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
     tcg_wasm_out_op_i32_store(s, 0, 0);
 
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_i64_const(s, block_idx + 1);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_new_block(s);
+
     gen_call(s, info, func_idx);
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static void gen_func_type_qemu_ld(TCGContext *s, uint32_t oi)
@@ -1986,6 +2007,14 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
         addr_reg = TCG_REG_TMP;
     }
 
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_i64_const(s, block_idx + 1);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_new_block(s);
+
     /* call helper */
     tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
     tcg_wasm_out_op_i32_wrap_i64(s);
@@ -1995,6 +2024,7 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
 
     tcg_wasm_out_op_call(s, func_idx);
     tcg_wasm_out_op_global_set_r(s, data_reg);
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static void *qemu_st_helper_ptr(uint32_t oi)
@@ -2034,6 +2064,14 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
         addr_reg = TCG_REG_TMP;
     }
 
+    /*
+     * update the block index so that the possible rewinding will
+     * skip this block
+     */
+    tcg_wasm_out_op_i64_const(s, block_idx + 1);
+    tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_new_block(s);
+
     /* call helper */
     tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
     tcg_wasm_out_op_i32_wrap_i64(s);
@@ -2051,6 +2089,7 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
     tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
 
     tcg_wasm_out_op_call(s, func_idx);
+    tcg_wasm_out_handle_unwinding(s);
 }
 
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
@@ -3420,6 +3459,9 @@ static const uint8_t mod_1[] = {
     0x60,                         /* 0: Type of "start" function */
     0x01, 0x7f,                   /* arg: ctx pointer (i32) */
     0x01, 0x7f,                   /* return: res (i32) */
+    0x60,                         /* 1: Type of the asyncify helper */
+    0x0,                          /* no argument */
+    0x01, 0x7f,                   /* return: res (i32) */
 };
 
 static const uint8_t mod_2[] = {
@@ -3430,6 +3472,9 @@ static const uint8_t mod_2[] = {
     0x06, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72, /* name: "buffer" */
     0x02, 0x03,                               /* shared mem */
     0x00, 0xff, 0xff, 0x03,                   /* min: 0, max: 0xffff pages */
+    0x06, 0x68, 0x65, 0x6c, 0x70, 0x65, 0x72, /* module: "helper" */
+    0x01, 0x75,                               /* name: "u" */
+    0x00, 0x01,                               /* func type 1 */
 };
 
 static const uint8_t mod_3[] = {
@@ -3488,7 +3533,7 @@ static int write_mod_1(TCGContext *s)
     linked_buf_write(types_buf_root, s->code_ptr);
     s->code_ptr += types_buf_len();
 
-    uint32_t type_section_size = types_buf_len() + 10;
+    uint32_t type_section_size = types_buf_len() + 14;
     fill_uint32_leb128(base + 9, type_section_size);
     fill_uint32_leb128(base + 14, HELPER_IDX_START + helpers_num + 1);
 
@@ -3613,6 +3658,11 @@ static void tcg_out_tb_start(TCGContext *s)
     h->tci_ptr = s->code_ptr;
 
     /* generate wasm code to initialize fundamental registers */
+    tcg_wasm_out_ctx_i32_load(s, do_init);
+    tcg_wasm_out_op_i32_const(s, 0);
+    tcg_wasm_out_op_i32_ne(s);
+    tcg_wasm_out_op_if_noret(s);
+
     tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
     tcg_wasm_out_op_i64_eqz(s);
     tcg_wasm_out_op_if_noret(s);
@@ -3626,8 +3676,10 @@ static void tcg_out_tb_start(TCGContext *s)
     tcg_wasm_out_op_global_set_r(s, TCG_REG_CALL_STACK);
     tcg_wasm_out_op_end(s);
 
+    tcg_wasm_out_ctx_i32_store_const(s, do_init, 0);
     tcg_wasm_out_op_i64_const(s, 0);
     tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
+    tcg_wasm_out_op_end(s);
 
     tcg_wasm_out_op_loop_noret(s);
     tcg_wasm_out_op_global_get(s, BLOCK_PTR_IDX);
-- 
2.43.0


