Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77173C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMVg-00067o-98; Tue, 20 May 2025 08:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUg-0003M5-Uy; Tue, 20 May 2025 08:54:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUd-00014t-J7; Tue, 20 May 2025 08:54:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3081f72c271so4814961a91.0; 
 Tue, 20 May 2025 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745688; x=1748350488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Km97/3qRAEAEgLIAK0qw3k5JzHlsxkZR+9MPB91ZrAE=;
 b=ZH9sSVKAb/zY1Vwwwn0/BZZHN73RO2MhW2HnxXZ6JMqJtFoKTZ/CjmhLqGdap3kEJp
 r+UnqPy2YnvkG91UfPhx0Txt0yyDhS9Iww3Gixq6d4UO0FO9Tj30ta8YzgVB7BxxH4ot
 HLB0xOsNsdES4KNAvTc1sepEhvKOW0kuqk/kahcUIunOfCZk06oIm4DMshtTREA+xjiE
 uvYfLDAL7uZ6LP9hzkUIEiuU2A8z8p0cVaoXZ1c7bmB9m3mNMrAdqZUFY3EucwiSBSlb
 jHE/s/l+QjHp40HO/Lo4GSqV3xX+MW/30blzs2xL/LqH4pZWXnzwLk8hGzSR8KuZsSEW
 R5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745688; x=1748350488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Km97/3qRAEAEgLIAK0qw3k5JzHlsxkZR+9MPB91ZrAE=;
 b=FtYdlvKon+KQPdrMxExhAFObdshJ80BG8Z8MtFHowtcWjGkjk1ouaYFgMoHPrKpFfD
 E+pDku2utUoVHf68/iJTY7Z2JEDVCBLkt0bLf7Hg3xEL1+W3Lj0O0+pq1x4Yzlnbfo0G
 vQ0B5GZduXJkkiQN9inr9pzaVqAnVnaLZ32IPEnNOXDhMoBLf3D2yrIb9rmtH4IPiK7e
 AhkS6ivQ680Zh2gNli5bGUS9/pthic6Ox8zPsECgw2S+eHnx0aodpQa0nY283Ve2KIh7
 1SDbOKa1DSv2H3jOvs7W2xyf+U1xJ+yAnoecon72zW9NaPJ+e5/Ji8524I81GopR2wy0
 83uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPe7yXePRQJQjqpX2ZtjMUMjFMKlcyFEPJCmDMYbJAhM93Wb605f4NgbaBZ8SoKjb7EBEgET8ye0lDLA==@nongnu.org,
 AJvYcCXZ62g0Td0DbQ3F3V3AriFATdJcKcaAuBCudY0CTD0uq0irKhRjCkUo0zRB6q7NM4h5OYCEZsQLHA==@nongnu.org
X-Gm-Message-State: AOJu0YxEOsD2iBGS2nROBmq08ocPltaJAs0bKEiFuG0miKOgD3xRdaHC
 bw9c13oMoPcV4KVftY2Z3UAushJhhn93nIcYz3hNA/d56AiqccZmlh68YW4Kz3Sw
X-Gm-Gg: ASbGncs71aaTkw5PgmpQaPrJggBtl8EkpvkGGDd7xKPBmKJ5xBE62qr7Yn731Teukgq
 5PzUZazLsW0lEi034gGQ7J+A6yMZpfDBqHwWqI6yYTV4diIuEDOwMN+0v065qKTRtSSr6JBEn5m
 ef33bTg62QRue5YC/yzj4ANQXSoxYkVdynvb0tWOiTb+lKhioXM5qHOhcpg7R/7Os7SnROc4Mz2
 jkrA9ays1vUI7Cq5HEK7rdUSK/GPZFpZSDa8xo4xnEa+AWsdXn6WfEW3RfjIfsYo7yzmZWq7WQQ
 akl9MerWQGeGPuePpYyXkXBZxAXwWSMCacvPVeB7OY4xxzi2xcg=
X-Google-Smtp-Source: AGHT+IFRSqU0y67I8zqhxLqwH5mfvyWM8AKPYHvJC4qpHwSBV2SavMTw+mHSzA2TMrDBEruEplLvuA==
X-Received: by 2002:a17:90a:ec8c:b0:30c:540b:9ac with SMTP id
 98e67ed59e1d1-30e830ebd3fmr27835549a91.10.1747745688216; 
 Tue, 20 May 2025 05:54:48 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:47 -0700 (PDT)
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
Subject: [PATCH 27/33] tcg/wasm32: Write wasm binary to TB
Date: Tue, 20 May 2025 21:51:29 +0900
Message-ID: <fb9514d90884655ffd4a4853c7d90b6cfc73e652.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102d.google.com
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

This commit updates tcg_out_tb_start and tcg_out_tb_end to emit Wasm
binaries into the TB code buffer. The generated Wasm binary defines a
function of type wasm_tb_func which takes a wasmContext, executes the TB,
and returns a result. In the Wasm backend, each TB starts with a
wasmTBHeader, followed by the following data:

- TCI code
- Wasm code
- Array of function indices imported into the Wasm instance

The wasmTBHeader contains pointers to each of these elements.

tcg_out_tb_start writes the wasmTBHeader to the code buffer. tcg_out_tb_end
generates the full Wasm executable binary by creating the Wasm module header
following the spec[1][2] and copying the Wasm code body from sub_buf to the
code buffer. Wasm binary is placed after the TCI code which was emitted
earlier.

Additionally, an array of imported function pointers is appended to the TB.
They are used during Wasm module instantiation. Function are imported to
Wasm with names like "helper.0", "helper.1", etc., where the number
corresponds to the assigned function IDs.

Each function's type signature must also be encoded in the Wasm module header.
To support this, each call, qemu_ld and qemu_st operation records the target
function's type information to a buffer.

Memory is shared between QEMU and the TBs and is imported to the Wasm module
with the name "env.buffer".

[1] https://webassembly.github.io/spec/core/binary/modules.html
[2] https://github.com/WebAssembly/threads/blob/b2567bff61ee6fbe731934f0ed17a5d48dc9ab01/proposals/threads/Overview.md

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.h                |  26 +++
 tcg/wasm32/tcg-target.c.inc | 390 ++++++++++++++++++++++++++++++++++++
 2 files changed, 416 insertions(+)

diff --git a/tcg/wasm32.h b/tcg/wasm32.h
index ab23e26eca..f8651af4ee 100644
--- a/tcg/wasm32.h
+++ b/tcg/wasm32.h
@@ -34,4 +34,30 @@ struct wasmContext {
     uint64_t *stack;
 };
 
+/* Instantiated Wasm function of a TB */
+typedef int32_t (*wasm_tb_func)(struct wasmContext *);
+
+/*
+ * TB of wasm backend starts from a header which stores pointers for each data
+ * stored in the following region in the TB.
+ */
+struct wasmTBHeader {
+    /*
+     * Pointer to the region containing TCI instructions.
+     */
+    void *tci_ptr;
+
+    /*
+     * Pointer to the region containing Wasm instructions.
+     */
+    void *wasm_ptr;
+    int wasm_size;
+
+    /*
+     * Pointer to the array containing imported function pointers.
+     */
+    void *import_ptr;
+    int import_size;
+};
+
 #endif
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 4b7cd784cb..d9a3abae70 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -485,6 +485,30 @@ static void tcg_wasm_out_op_cond_i32(
     tcg_wasm_out8(s, op);
 }
 
+static void fill_uint32_leb128(uint8_t *b, uint32_t v)
+{
+    do {
+        *b |= v & 0x7f;
+        v >>= 7;
+        b++;
+    } while (v != 0);
+}
+
+static int write_uint32_leb128(uint8_t *b, uint32_t v)
+{
+    uint8_t *base = b;
+    do {
+        *b = v & 0x7f;
+        v >>= 7;
+        if (v != 0) {
+            *b |= 0x80;
+        }
+        b++;
+    } while (v != 0);
+
+    return (int)(b - base);
+}
+
 static void tcg_wasm_out_leb128_sint32_t(TCGContext *s, int32_t v)
 {
     bool more = true;
@@ -1706,6 +1730,105 @@ static void gen_call(TCGContext *s, const TCGHelperInfo *info, int func_idx)
     return;
 }
 
+__thread LinkedBuf *types_buf_root;
+__thread LinkedBuf *types_buf_cur;
+
+static void init_types_buf(void)
+{
+    types_buf_root = new_linked_buf();
+    types_buf_cur = types_buf_root;
+}
+
+static inline void types_buf_out8(uint8_t v)
+{
+    types_buf_cur = linked_buf_out8(types_buf_cur, v);
+}
+
+static inline int types_buf_len(void)
+{
+    return linked_buf_len(types_buf_root);
+}
+
+static void types_out_leb128_uint32(uint32_t v)
+{
+    uint8_t b;
+    do {
+        b = v & 0x7f;
+        v >>= 7;
+        if (v != 0) {
+            b |= 0x80;
+        }
+        types_buf_out8(b);
+    } while (v != 0);
+}
+
+static void gen_func_type_call(TCGContext *s, const TCGHelperInfo *info)
+{
+    unsigned typemask = info->typemask;
+    int rettype = typemask & 7;
+    int vec_size = 0;
+
+    if (rettype == dh_typecode_i128) {
+        vec_size++;
+    }
+    for (int m = typemask >> 3; m; m >>= 3) {
+        int typecode = m & 7;
+        if (typecode != dh_typecode_void) {
+            vec_size++;
+        }
+    }
+
+    types_buf_out8(0x60);
+    types_out_leb128_uint32(vec_size);
+
+    if (rettype == dh_typecode_i128) {
+        types_buf_out8(0x7f);
+    }
+
+    for (int m = typemask >> 3; m; m >>= 3) {
+        int typecode = m & 7;
+        if (typecode == dh_typecode_void) {
+            continue;
+        }
+        switch (typecode) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            types_buf_out8(0x7f);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            types_buf_out8(0x7e);
+            break;
+        case dh_typecode_i128:
+            types_buf_out8(0x7f);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    if ((rettype == dh_typecode_void) || (rettype == dh_typecode_i128)) {
+        types_buf_out8(0x0);
+    } else {
+        types_buf_out8(0x1);
+        switch (rettype) {
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+        case dh_typecode_ptr:
+            types_buf_out8(0x7f);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            types_buf_out8(0x7e);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return;
+}
+
 typedef struct HelperInfo {
     struct HelperInfo *next;
     uint32_t idx_on_qemu;
@@ -1778,6 +1901,7 @@ static void tcg_wasm_out_call(TCGContext *s, int func,
     int func_idx = get_helper_idx(s, (int)func);
     if (func_idx < 0) {
         func_idx = register_helper(s, (int)func);
+        gen_func_type_call(s, info);
     }
 
     tcg_wasm_out_ctx_i32_load(s, tci_tb_ptr);
@@ -1787,6 +1911,39 @@ static void tcg_wasm_out_call(TCGContext *s, int func,
     gen_call(s, info, func_idx);
 }
 
+static void gen_func_type_qemu_ld(TCGContext *s, uint32_t oi)
+{
+    types_buf_out8(0x60);
+    types_buf_out8(0x4);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7e);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x1);
+    types_buf_out8(0x7e);
+}
+
+static void gen_func_type_qemu_st(TCGContext *s, uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+
+    types_buf_out8(0x60);
+    types_buf_out8(0x5);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7e);
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        types_buf_out8(0x7e);
+        break;
+    default:
+        types_buf_out8(0x7f);
+        break;
+    }
+    types_buf_out8(0x7f);
+    types_buf_out8(0x7f);
+    types_buf_out8(0x0);
+}
+
 static void *qemu_ld_helper_ptr(uint32_t oi)
 {
     MemOp mop = get_memop(oi);
@@ -1821,6 +1978,7 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
     func_idx = get_helper_idx(s, helper_idx);
     if (func_idx < 0) {
         func_idx = register_helper(s, helper_idx);
+        gen_func_type_qemu_ld(s, oi);
     }
 
     if (!addr64) {
@@ -1868,6 +2026,7 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
     func_idx = get_helper_idx(s, helper_idx);
     if (func_idx < 0) {
         func_idx = register_helper(s, helper_idx);
+        gen_func_type_qemu_st(s, oi);
     }
 
     if (!addr64) {
@@ -3251,12 +3410,207 @@ static inline void tcg_target_qemu_prologue(TCGContext *s)
 {
 }
 
+static const uint8_t mod_1[] = {
+    0x0, 0x61, 0x73, 0x6d, /* magic */
+    0x01, 0x0, 0x0, 0x0,   /* version */
+
+    0x01,                         /* type section */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placehodler for size */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placehodler for num of types vec */
+    0x60,                         /* 0: Type of "start" function */
+    0x01, 0x7f,                   /* arg: ctx pointer (i32) */
+    0x01, 0x7f,                   /* return: res (i32) */
+};
+
+static const uint8_t mod_2[] = {
+    0x02,                                     /* import section */
+    0x80, 0x80, 0x80, 0x80, 0x00,             /* placehodler for size */
+    0x80, 0x80, 0x80, 0x80, 0x00,             /* placehodler for imports num */
+    0x03, 0x65, 0x6e, 0x76,                   /* module: "env" */
+    0x06, 0x62, 0x75, 0x66, 0x66, 0x65, 0x72, /* name: "buffer" */
+    0x02, 0x03,                               /* shared mem */
+    0x00, 0xff, 0xff, 0x03,                   /* min: 0, max: 0xffff pages */
+};
+
+static const uint8_t mod_3[] = {
+    0x03,       /* function section */
+    2, 1, 0x00, /* function type 0 */
+
+    0x06,                         /* global section */
+    0x5b,                         /* section size */
+    18,                           /* num of global vars */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+    0x7e, 0x01, 0x42, 0x00, 0x0b, /* 0-cleared 64bit var */
+
+    0x07,                               /* export section */
+    13,                                 /* size of section */
+    1,                                  /* num of funcs */
+    0x05, 0x73, 0x74, 0x61, 0x72, 0x74, /* "start" function */
+    0x00, 0x80, 0x80, 0x80, 0x80, 0x00, /* placeholder for func index*/
+};
+
+static const uint8_t mod_4[] = {
+    0x0a,                         /* code section */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placeholder for section size*/
+    1,                            /* num of codes */
+    0x80, 0x80, 0x80, 0x80, 0x00, /* placeholder for code size */
+    0x2, 0x2, 0x7f, 0x1, 0x7e,    /* variables (32bit*2, 64bit*1) */
+};
+
+static int write_mod_1(TCGContext *s)
+{
+    void *base = s->code_ptr;
+    int helpers_num = helpers_len();
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_1) + types_buf_len())
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod_1, sizeof(mod_1));
+    s->code_ptr += sizeof(mod_1);
+    linked_buf_write(types_buf_root, s->code_ptr);
+    s->code_ptr += types_buf_len();
+
+    uint32_t type_section_size = types_buf_len() + 10;
+    fill_uint32_leb128(base + 9, type_section_size);
+    fill_uint32_leb128(base + 14, HELPER_IDX_START + helpers_num + 1);
+
+    return 0;
+}
+
+static int write_mod_2(TCGContext *s)
+{
+    void *base = s->code_ptr;
+    int helpers_num = helpers_len();
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_2))
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    tcg_debug_assert(helpers_num <= INT_MAX);
+    memcpy(s->code_ptr, mod_2, sizeof(mod_2));
+    s->code_ptr += sizeof(mod_2);
+    for (int i = 0; i < helpers_num; i++) {
+        int typeidx = HELPER_IDX_START + i + 1;
+        char buf[11]; /* enough for decimal int max + NULL*/
+        int n = snprintf(buf, sizeof(buf), "%d", i);
+        tcg_debug_assert(n < sizeof(buf));
+        *(uint8_t *)s->code_ptr++ = 6; /* helper */
+        *(uint8_t *)s->code_ptr++ = 0x68;
+        *(uint8_t *)s->code_ptr++ = 0x65;
+        *(uint8_t *)s->code_ptr++ = 0x6c;
+        *(uint8_t *)s->code_ptr++ = 0x70;
+        *(uint8_t *)s->code_ptr++ = 0x65;
+        *(uint8_t *)s->code_ptr++ = 0x72;
+        s->code_ptr += write_uint32_leb128((uint8_t *)s->code_ptr, n);
+        memcpy(s->code_ptr, buf, n);
+        s->code_ptr += n;
+        *(uint8_t *)s->code_ptr++ = 0x00; /* type(0) */
+        s->code_ptr += write_uint32_leb128((uint8_t *)s->code_ptr, typeidx);
+        if (unlikely(((void *)s->code_ptr > s->code_gen_highwater))) {
+            return -1;
+        }
+    }
+
+    uint32_t import_section_size = (int)s->code_ptr - (int)base - 6;
+    fill_uint32_leb128(base + 1, import_section_size);
+    fill_uint32_leb128(base + 6, HELPER_IDX_START + helpers_num + 1);
+
+    return 0;
+}
+
+static int write_mod_3(TCGContext *s)
+{
+    void *base = s->code_ptr;
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_3))
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod_3, sizeof(mod_3));
+    s->code_ptr += sizeof(mod_3);
+
+    int startidx = HELPER_IDX_START + helpers_len();
+    fill_uint32_leb128(base + 107, startidx);
+
+    return 0;
+}
+
+static int write_mod_4(TCGContext *s)
+{
+    void *base = s->code_ptr;
+
+    if (unlikely(((void *)s->code_ptr + sizeof(mod_4))
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+
+    memcpy(s->code_ptr, mod_4, sizeof(mod_4));
+    s->code_ptr += sizeof(mod_4);
+
+    int code_size = sub_buf_len() + 5;
+    fill_uint32_leb128(base + 1, code_size + 6);
+    fill_uint32_leb128(base + 7, code_size);
+
+    return 0;
+}
+
+static int write_mod_code(TCGContext *s)
+{
+    void *base = s->code_ptr;
+    int code_size = sub_buf_len();
+
+    if (unlikely(((void *)s->code_ptr + code_size) > s->code_gen_highwater)) {
+        return -1;
+    }
+    linked_buf_write(sub_buf_root, s->code_ptr);
+    s->code_ptr += code_size;
+    for (BlockPlaceholder *p = block_placeholder; p; p = p->next) {
+        uint8_t *ph = p->pos + base;
+        int blk = get_block_of_label(p->label);
+        tcg_debug_assert(blk >= 0);
+        fill_uint32_leb128(ph, blk);
+    }
+
+    return 0;
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
+    int size;
+    struct wasmTBHeader *h;
+
     init_sub_buf();
     init_blocks();
     init_label_info();
     init_helpers();
+    init_types_buf();
+
+    /* TB starts from a header */
+    h = (struct wasmTBHeader *)(s->code_ptr);
+    s->code_ptr += sizeof(struct wasmTBHeader);
+
+    /* Followed by TCI code */
+    h->tci_ptr = s->code_ptr;
 
     /* generate wasm code to initialize fundamental registers */
     tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
@@ -3283,11 +3637,47 @@ static void tcg_out_tb_start(TCGContext *s)
 
 static int tcg_out_tb_end(TCGContext *s)
 {
+    int res;
+    struct wasmTBHeader *h = (struct wasmTBHeader *)(s->code_buf);
+
     tcg_wasm_out_op_end(s); /* end if */
     tcg_wasm_out_op_end(s); /* end loop */
     tcg_wasm_out8(s, 0x0);  /* unreachable */
     tcg_wasm_out_op_end(s); /* end func */
 
+    /* write wasm blob */
+    h->wasm_ptr = s->code_ptr;
+    res = write_mod_1(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_2(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_3(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_4(s);
+    if (res < 0) {
+        return res;
+    }
+    res = write_mod_code(s);
+    if (res < 0) {
+        return res;
+    }
+    h->wasm_size = (int)s->code_ptr - (int)h->wasm_ptr;
+
+    /* record imported helper functions */
+    if (unlikely(((void *)s->code_ptr + helpers_len() * 4)
+                 > s->code_gen_highwater)) {
+        return -1;
+    }
+    h->import_ptr = s->code_ptr;
+    s->code_ptr += helpers_copy((uint32_t *)s->code_ptr);
+    h->import_size = (int)s->code_ptr - (int)h->import_ptr;
+
     return 0;
 }
 
-- 
2.43.0


