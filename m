Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE6FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMUr-0003wi-KA; Tue, 20 May 2025 08:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUJ-0002P4-OX; Tue, 20 May 2025 08:54:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUA-0000yq-Op; Tue, 20 May 2025 08:54:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso7049939b3a.2; 
 Tue, 20 May 2025 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745655; x=1748350455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7+9niXXB1Fhurf42nBGF3zTCxGh2saaYSnPS8Sr56Q=;
 b=bY8tgUjknmdX+GOSZ8eZ7qg7aRq7RLrXFoPJ0yGhXLo8cMTX/15z5sK6sXbCy+EX9+
 l/I02ZkYalwayZq8YQZslG4FhNh+PE/ub0yNzT4Wbn+fx8oKMsmY0j26gEHnEkg8Cd0O
 8ULFqehMeTSVlzdrcboZH11IHQrXBAAgYRMSPibunEZ+L3FzuBnmqug6gIfDX6MA7N2A
 j/o7bJXfu3EOGI2Ru/iifrGdcFzn/86oOJhJD6KjMnvgmoqi/pAG6ienUjx2AUpoGLNV
 RdCtP/VnpafIvrhPTNNSVAJ2HpBtpZZfiy2LneE+/E4Q0FIl9FHgyIA6oKF7mIZrcy/o
 K4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745655; x=1748350455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7+9niXXB1Fhurf42nBGF3zTCxGh2saaYSnPS8Sr56Q=;
 b=j9fn4id0v8qDHRI18x9cU2QbMoatN5m+SVp3zb4D1REmT72zwJfRl8dJEtq17qzqDL
 zCG5+Aj66zhqdo8PQq2Q0GkMfHNp9Ye4c9Jyj/hODsuyRzWmbg96w8EgzpFATyIF+Sl/
 g8wMAAukc/71OXkdz7tlrQ2sjoYD9YthDWzuWXP+W1WSLWgNaVo/aSUq7VAaoK0S3Ck5
 vaQv8WW1Ab6bG/jVk67qdelNzPNAv7Hc4jUtu6yAqD/1+fmgC5/XITUoTMze8ze678Kn
 lg9y5e8PGZHrPtaJLxBubqF85piMx1k7SwH0Fjdd8VJQpOGwQ48diwfevUHwU2DFD5jG
 x0eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzlUJXggNrYYCid3r4SLpqSS6SQuMmPqX88F96HfQCsEOvvbSWTTISr3CUPe/4yhmy4qkG+EwbJWsv+A==@nongnu.org,
 AJvYcCWzo2uI0tilYgUyulmNf96BKO+UZZrDHtZqEQNb1L4yJl1XPw2lH6/SHgZohg2pFA3uipuJFyA/cw==@nongnu.org
X-Gm-Message-State: AOJu0Yw+3y1198UNHAGhsLm4Kj+9Ll37GXzgvANvFNV0fW1JpMgCsNRf
 vl/1WKleayu8rhxv6buvDTQ76G84w19H6g81tQ8kAXWEz3jJEv2i0HAT9Fr0C6fU
X-Gm-Gg: ASbGncswCTHDsWFMhMe7Bgqsp1+ZYmJQh5j9MAlY0rDTZzw9wh9Xgg0d64Hb4qxg4Cf
 IvNh5EzABTAmG9c9ewy6q4qQWlh/AvtRw46XoftRQpcJ60LW1K8gEo8LGnNWtdB4+SgCb2DaaPC
 QOKQBqb4n/Yk/RwOVeeetW2EqY6AWKepoywU3CiqosrzwsvxvzcGd7ewtkrihqj54jReBhgEuJm
 uykkbC6wL/nP8GVQCMcs56iLVcJ0XMse9TbJ/mvTVKvfVMXwuP8oLXDDBeYFUyt7RFeAW4jnvaC
 oew1MxdR0Crqia07oA+JEYsYi24MMBuui4W36B9FCSM9rBuV90W+9CmV7ESw5g==
X-Google-Smtp-Source: AGHT+IFPlqRQ1YPOgXYMn8sylaCHdOyEFt8VqLuMxdXEvsU5rL1gozNwHMX/DB8mCdVHm0qWPQn8Vw==
X-Received: by 2002:a17:90b:33c2:b0:2ff:58b8:5c46 with SMTP id
 98e67ed59e1d1-30e830f7b18mr25403623a91.8.1747745654522; 
 Tue, 20 May 2025 05:54:14 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:14 -0700 (PDT)
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
Subject: [PATCH 21/33] tcg/wasm32: Add call instruction
Date: Tue, 20 May 2025 21:51:23 +0900
Message-ID: <f25caa407e47079f1c305869a5bce9857fb86cfd.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x433.google.com
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
backend assigns a unique ID (starting from 0) to the target function. The
mapping between the function pointer and its assigned ID is recorded in the
HelperInfo structure.

Since Wasm's call instruction requires arguments to be pushed onto the Wasm
stack, the backend retrieves the function arguments from TCG's stack array
and pushes them to the stack before the call. After the function returns,
the result is retrieved from the stack and set in the corresponding TCG
variable.

In our Emscripten build configuration with !has_int128_type, a 128-bit value
is represented by the Int128 struct. These values are passed indirectly via
pointer parameters and returned via a prepended pointer argument, as
described in [1].

[1] https://github.com/WebAssembly/tool-conventions/blob/060cf4073e46931160c2e9ecd43177ee1fe93866/BasicCABI.md#function-arguments-and-return-values

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.h                |  10 +++
 tcg/wasm32/tcg-target.c.inc | 170 ++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/tcg/wasm32.h b/tcg/wasm32.h
index ffa359b7dc..1944249891 100644
--- a/tcg/wasm32.h
+++ b/tcg/wasm32.h
@@ -12,6 +12,16 @@ struct wasmContext {
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
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 77db50cf85..708af1fbb6 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -140,6 +140,9 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 #define TMP32_LOCAL_1_IDX 2
 #define TMP64_LOCAL_0_IDX 3
 
+/* function index */
+#define HELPER_IDX_START 0 /* helper funcitons */
+
 #define BUF_SIZE 1024
 typedef struct LinkedBuf {
     struct LinkedBuf *next;
@@ -619,6 +622,12 @@ static void tcg_wasm_out_op_i32_store(TCGContext *s, uint32_t a, uint32_t o)
     tcg_wasm_out_op_loadstore(s, 0x36, a, o);
 }
 
+static void tcg_wasm_out_op_call(TCGContext *s, uint32_t func_idx)
+{
+    tcg_wasm_out8(s, 0x10);
+    tcg_wasm_out_leb128_uint32_t(s, func_idx);
+}
+
 static void tcg_wasm_out_op_not(TCGContext *s)
 {
     tcg_wasm_out_op_i64_const(s, -1);
@@ -1626,6 +1635,165 @@ static void tcg_wasm_out_goto_tb(
     tcg_wasm_out_op_end(s);
 }
 
+static void push_arg_i64(TCGContext *s, int *stack_offset)
+{
+    tcg_wasm_out_op_global_get_r(s, TCG_REG_CALL_STACK);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i64_load(s, 0, *stack_offset);
+    *stack_offset = *stack_offset + 8;
+}
+
+static void gen_call(TCGContext *s, const TCGHelperInfo *info, int func_idx)
+{
+    unsigned typemask = info->typemask;
+    int rettype = typemask & 7;
+    int stack_offset = 0;
+
+    if (rettype ==  dh_typecode_i128) {
+        /* receive 128bit return value via the buffer */
+        tcg_wasm_out_ctx_i32_load(s, buf128);
+    }
+
+    for (typemask >>= 3; typemask; typemask >>= 3) {
+        int typecode = typemask & 7;
+        if (typecode == dh_typecode_void) {
+            continue;
+        }
+        switch (typecode) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            push_arg_i64(s, &stack_offset);
+            tcg_wasm_out_op_i32_wrap_i64(s);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            push_arg_i64(s, &stack_offset);
+            break;
+        case dh_typecode_i128:
+            tcg_wasm_out_op_global_get_r(s, TCG_REG_CALL_STACK);
+            tcg_wasm_out_op_i32_wrap_i64(s);
+            tcg_wasm_out_op_i32_const(s, stack_offset);
+            tcg_wasm_out_op_i32_add(s);
+            stack_offset += 16;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    tcg_wasm_out_op_call(s, func_idx);
+
+    if (rettype != dh_typecode_void) {
+        switch (rettype) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            tcg_wasm_out_op_i64_extend_i32_s(s);
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R0);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R0);
+            break;
+        case dh_typecode_i128:
+            tcg_wasm_out_ctx_i32_load(s, buf128);
+            tcg_wasm_out_op_i64_load(s, 0, 0);
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R0);
+            tcg_wasm_out_ctx_i32_load(s, buf128);
+            tcg_wasm_out_op_i64_load(s, 0, 8);
+            tcg_wasm_out_op_global_set_r(s, TCG_REG_R1);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    return;
+}
+
+typedef struct HelperInfo {
+    struct HelperInfo *next;
+    uint32_t idx_on_qemu;
+} HelperInfo;
+
+__thread HelperInfo *helpers;
+
+static void init_helpers(void)
+{
+    helpers = NULL;
+}
+
+static int register_helper(TCGContext *s, int helper_idx_on_qemu)
+{
+    int idx = HELPER_IDX_START;
+
+    tcg_debug_assert(helper_idx_on_qemu >= 0);
+
+    HelperInfo *e = tcg_malloc(sizeof(HelperInfo));
+    e->idx_on_qemu = helper_idx_on_qemu;
+    e->next = NULL;
+    if (helpers == NULL) {
+        helpers = e;
+        return idx;
+    }
+    HelperInfo *last = helpers;
+    for (HelperInfo *p = last; p; p = p->next) {
+        last = p;
+        idx++;
+    }
+    last->next = e;
+    return idx;
+}
+
+static int helpers_len(void)
+{
+    int n = 0;
+    for (HelperInfo *p = helpers; p; p = p->next) {
+        n++;
+    }
+    return n;
+}
+
+static inline int helpers_copy(uint32_t *dst)
+{
+    void *start = dst;
+    for (HelperInfo *p = helpers; p; p = p->next) {
+        *dst++ = p->idx_on_qemu;
+    }
+    return (int)dst - (int)start;
+}
+
+
+static int get_helper_idx(TCGContext *s, int helper_idx_on_qemu)
+{
+    int idx = HELPER_IDX_START;
+
+    for (HelperInfo *p = helpers; p; p = p->next) {
+        if (p->idx_on_qemu == helper_idx_on_qemu) {
+            return idx;
+        }
+        idx++;
+    }
+    return -1;
+}
+
+static void tcg_wasm_out_call(TCGContext *s, int func,
+                              const TCGHelperInfo *info)
+{
+    int func_idx = get_helper_idx(s, (int)func);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, (int)func);
+    }
+
+    tcg_wasm_out_ctx_i32_load(s, tci_tb_ptr);
+    tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
+    tcg_wasm_out_op_i32_store(s, 0, 0);
+
+    gen_call(s, info, func_idx);
+}
+
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -2034,6 +2202,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
     insn = deposit32(insn, 0, 8, INDEX_op_call);
     insn = deposit32(insn, 8, 4, which);
     tcg_out32(s, insn);
+    tcg_wasm_out_call(s, (int)func, info);
 }
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
@@ -3072,6 +3241,7 @@ static void tcg_out_tb_start(TCGContext *s)
     init_sub_buf();
     init_blocks();
     init_label_info();
+    init_helpers();
 
     tcg_wasm_out_op_loop_noret(s);
     tcg_wasm_out_op_global_get(s, BLOCK_PTR_IDX);
-- 
2.43.0


