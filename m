Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C9ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR2c-0005OB-6P; Tue, 19 Aug 2025 14:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1j-00024g-06; Tue, 19 Aug 2025 14:25:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1d-0004eM-Sq; Tue, 19 Aug 2025 14:25:40 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24458317464so63752345ad.3; 
 Tue, 19 Aug 2025 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627935; x=1756232735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lEO6Ug5ERIuH8Mlq3IETtFos+2BtbJerwnarkvJecM=;
 b=IyHiUcuNtjalZgBpJ6X8KRRxwhTkcvLYgG3nvKOZwBM27VV2xc2vhz9RQX8yklNuA/
 X3YWHvAXguYkaDs2LqyWFPlUIdOTrTDRCKagFEE//49H2afBf0KADOs4v2Lq7AjN3CDK
 Dw9oeKMXJRKxZzchFuwN+BZXNJCYdhOUXMrIqZL2EjCt57v23ZmugAsp1VJFzrBiCGEa
 8syq9Pl0l+tFkwCEiBiO39w8eAu6teTINtcZHlT9Sib1NusOE3a1AJIFI+Smn4NkDU+X
 EVyRZ0xHk9lhJlSP/71oklB7r+mNTs3CFacafM8lXRwAZDrdoHPf0Geg0Ags5dd7JH+r
 jtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627935; x=1756232735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lEO6Ug5ERIuH8Mlq3IETtFos+2BtbJerwnarkvJecM=;
 b=GNOOzbjX8c6/qgFsRzBAUmXCS5NvBurgkOEOPs/fjLdolfN+W4/uk9XekaacHytfId
 mAiBOjcmGRcUy5b3qangmj3OpOwBouan8/JP+FBb8YIM8cYzE6HofmGZCkbZFQUxti4H
 0wHVSn7jnl8zEvOh/jNAoltCaWVjGFRS+p8zH1dpUQgyaOtU/TBgXly2GsY+F2Hbmnlr
 irBJebmdPNkcazzCCp3vqf3pNbywULqzoc9hl8eu4RpgR+yMjk9QpeC8t4riDRCqjfUN
 CKwaNAEVHZdYHZjrmNpZDzp37xl75C8CNB4906jdVGN7gr9VOLCNHT1c5LN9Z+qvfqJO
 2ivg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/bhnq225tQxHj1O+38mdUSbTpo1lZg0KGvcYsWEKl9Q1+nuzs2iupbY+x8sgWmuShnweZG+5ZVQ==@nongnu.org,
 AJvYcCXZlRtO9icMWtEtzQNK4iiR8gnGR9WQHoZLW4sJQsXdFkgAjk8XTx8SmOF1bJienbleXsee1IBz5IjK5Q==@nongnu.org
X-Gm-Message-State: AOJu0YwmGnWBvkzbT5ArQZt+t8LSADsyC3/ZCd4igNGt7vlyNzuPMWW+
 9EFjqsWhdt181Lh0miS5t2vAVAlapfq9r6dqrJvxXDB4uAFUGhmLo/q3t90g5A==
X-Gm-Gg: ASbGncvmOga6ekMLqJS0L+X7J8sMMFooE4rxwDnBg9f6Tkoqz+bIGr2qPuLUayZC9ew
 2MsRKjxBlK54x3FG7FCU/8c0BGaorZm4V7G//LCG7NmkAisTioetkAyPwwj+D9Mwg+OStUOd0/o
 QTHDzfsvHrnrnkP0dbL9nsAxFX4btPNoskmuP1PQz8cVvWN+DLInROFvRJmu4RWu8QNjLNtQZ8m
 kbPMumMQik6zHndrQ/SZfRg8nnb1bf0sjp/rnG6/SIb3Er+6OFxt/5rEVWWhLQyebk6U6ts4mcp
 PIrUGwv9rFbZs8PFCZUbbBJHhruxEUnsTUMw1VEm6LZEb2uN8u5gI/xWel0u2cAgFzaWIuXoUJr
 +X0IDtLXgQS8JV/OwkJx+IryvfTriyCM9
X-Google-Smtp-Source: AGHT+IFWVd0UgV/zaRXnBgiI+AmRtfvKgtPmB4/a6lFAeRl7AuAImttXXw2MX3VLyHz7TjWtt6fn9g==
X-Received: by 2002:a17:902:c947:b0:244:5089:ff44 with SMTP id
 d9443c01a7336-245e0526b5emr45861735ad.41.1755627935261; 
 Tue, 19 Aug 2025 11:25:35 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:34 -0700 (PDT)
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
Subject: [PATCH 32/35] tcg/wasm: Enable instantiation of TBs executed many
 times
Date: Wed, 20 Aug 2025 03:22:01 +0900
Message-ID: <0a68602fe660f0c77bf8b54fd26e4933e7255dec.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

This commit enables instantiations of TBs in wasm.c. Browsers cause out of
memory error if too many Wasm instances are created so the number of
instances needs to be limited. So this commit restricts instantiation only
for TBs that are called many times.

This commit adds a counter (or its array if there are multiple threads) to
the TB. Each time a TB is executed on TCI, the counter on TB is
incremented. If it reaches to a threshold, that TB is instantiated as Wasm
via instantiate_wasm.

The total number of instances are tracked by the instances_global variable
and its maximum number is limited by MAX_INSTANCES. When a Wasm module is
instantiated, instances_global is incremented and the instance's function
pointer is recorded to an array of WasmInstanceInfo.

Each TB refers to the WasmInstanceInfo entry via WasmTBHeader's info_ptr (or
its array if there are multiple threads). This allows tcg_qemu_tb_exec to
resolve the instance's function pointer from the TB.

When a new instantiation would exceed the limit, the Wasm backend doesn't
perform instantiation (i.e. TB continues execution on TCI). Instead, it
triggers the removal of older Wasm instances using Emscripten's
removeFunction function. Once the removal is completed and detected via
FinalizationRegistry API[1], instances_global is decremented, allowing new
modules to be instantiated.

[1] https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/FinalizationRegistry

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                | 245 +++++++++++++++++++++++++++++++++++++-
 tcg/wasm.h                |  45 +++++++
 tcg/wasm/tcg-target.c.inc |  18 +++
 3 files changed, 304 insertions(+), 4 deletions(-)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index f879ab0d4a..abc5d6b940 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -26,6 +26,7 @@
 #include "tcg-has.h"
 #include <ffi.h>
 #include <emscripten.h>
+#include "wasm.h"
 
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
@@ -45,6 +46,9 @@
 
 __thread uintptr_t tci_tb_ptr;
 
+/* TBs executed more than this value will be compiled to wasm */
+#define INSTANTIATE_NUM 1500
+
 #define EM_JS_PRE(ret, name, args, body...) EM_JS(ret, name, args, body)
 
 #define DEC_PTR(p) bigintToI53Checked(p)
@@ -81,6 +85,8 @@ EM_JS_PRE(void*, instantiate_wasm, (void *wasm_begin,
             "helper" : helper,
     });
 
+    Module.__wasm_tb.inst_gc_registry.register(inst, "tbinstance");
+
     return ENC_PTR(addFunction(inst.exports.start, 'ii'));
 });
 
@@ -366,16 +372,59 @@ static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
     }
 }
 
+static __thread int thread_idx;
+
+static inline int32_t get_counter_local(void *tb_ptr)
+{
+    return get_counter(tb_ptr, thread_idx);
+}
+
+static inline void set_counter_local(void *tb_ptr, int v)
+{
+    set_counter(tb_ptr, thread_idx, v);
+}
+
+static inline struct WasmInstanceInfo *get_info_local(void *tb_ptr)
+{
+    return get_info(tb_ptr, thread_idx);
+}
+
+static inline void set_info_local(void *tb_ptr, struct WasmInstanceInfo *info)
+{
+    set_info(tb_ptr, thread_idx, info);
+}
+
+/*
+ * inc_counter increments the execution counter in the specified TB.
+ * If the counter reaches the limit, it returns true otherwise returns false.
+ */
+static inline bool inc_counter(void *tb_ptr)
+{
+    int32_t counter = get_counter_local(tb_ptr);
+    if ((counter >= 0) && (counter < INSTANTIATE_NUM)) {
+        set_counter_local(tb_ptr, counter + 1);
+    } else {
+        return true; /* enter to wasm TB */
+    }
+    return false;
+}
+
+static __thread struct WasmContext ctx = {
+    .tb_ptr = 0,
+    .stack = NULL,
+    .do_init = 1,
+    .buf128 = NULL,
+};
+
 /* Interpret pseudo code in tb. */
 /*
  * Disable CFI checks.
  * One possible operation in the pseudo code is a call to binary code.
  * Therefore, disable CFI checks in the interpreter function
  */
-uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
-                                            const void *v_tb_ptr)
+static uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec_tci(CPUArchState *env)
 {
-    const uint32_t *tb_ptr = v_tb_ptr;
+    uint32_t *tb_ptr = get_tci_ptr(ctx.tb_ptr);
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
                    / sizeof(uint64_t)];
@@ -814,20 +863,34 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
         case INDEX_op_exit_tb:
             tci_args_l(insn, tb_ptr, &ptr);
+            ctx.tb_ptr = 0;
             return (uintptr_t)ptr;
 
         case INDEX_op_goto_tb:
             tci_args_l(insn, tb_ptr, &ptr);
-            tb_ptr = *(void **)ptr;
+            if (tb_ptr != *(void **)ptr) {
+                tb_ptr = *(void **)ptr;
+                ctx.tb_ptr = tb_ptr;
+                if (inc_counter(tb_ptr)) {
+                    return 0; /* enter to wasm TB */
+                }
+                tb_ptr = get_tci_ptr(tb_ptr);
+            }
             break;
 
         case INDEX_op_goto_ptr:
             tci_args_r(insn, &r0);
             ptr = (void *)regs[r0];
             if (!ptr) {
+                ctx.tb_ptr = 0;
                 return 0;
             }
             tb_ptr = ptr;
+            ctx.tb_ptr = tb_ptr;
+            if (inc_counter(tb_ptr)) {
+                return 0; /* enter to wasm TB */
+            }
+            tb_ptr = get_tci_ptr(tb_ptr);
             break;
 
         case INDEX_op_qemu_ld:
@@ -873,3 +936,177 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 /*
  * TODO: Disassembler is not implemented
  */
+
+/*
+ * The maximum number of instances that can exist simultaneously
+ *
+ * If this limit is reached and a new instance is required, older instances are
+ * removed to allow creation of new ones without exceeding the browser's limit.
+ */
+#define MAX_INSTANCES 15000
+
+static int instances_global;
+
+/* Avoid overwrapping of begin/end pointers */
+#define INSTANCES_BUF_MAX (MAX_INSTANCES + 1)
+
+static __thread struct WasmInstanceInfo instances[INSTANCES_BUF_MAX];
+static __thread int instances_begin;
+static __thread int instances_end;
+
+static void add_instance(wasm_tb_func tb_func, void *tb_ptr)
+{
+    instances[instances_end].tb_func = tb_func;
+    instances[instances_end].tb_ptr = tb_ptr;
+    set_info_local(tb_ptr, &(instances[instances_end]));
+    instances_end  = (instances_end + 1) % INSTANCES_BUF_MAX;
+
+    qatomic_inc(&instances_global);
+}
+
+static __thread int instance_pending_gc;
+static __thread int instance_done_gc;
+
+static void remove_old_instances(void)
+{
+    int num;
+    if (instance_pending_gc > 0) {
+        return;
+    }
+    if (instances_begin <= instances_end) {
+        num = instances_end - instances_begin;
+    } else {
+        num = instances_end + (INSTANCES_BUF_MAX - instances_begin);
+    }
+    /* removes the half of the oldest instances in the buffer */
+    num /= 2;
+    for (int i = 0; i < num; i++) {
+        EM_ASM({ removeFunction($0); }, instances[instances_begin].tb_func);
+        instances[instances_begin].tb_ptr = NULL;
+        instances_begin = (instances_begin + 1) % INSTANCES_BUF_MAX;
+    }
+    instance_pending_gc += num;
+}
+
+static bool can_add_instance(void)
+{
+    return qatomic_read(&instances_global) < MAX_INSTANCES;
+}
+
+static wasm_tb_func get_instance_from_tb(void *tb_ptr)
+{
+    struct WasmInstanceInfo *elm = get_info_local(tb_ptr);
+    if (elm == NULL) {
+        return NULL;
+    }
+    if (elm->tb_ptr != tb_ptr) {
+        /*
+         * This TB was instantiated before, but has been removed. Set counter to
+         * the max value so that this will be instantiated.
+         */
+        set_counter_local(tb_ptr, INSTANTIATE_NUM);
+        set_info_local(tb_ptr, NULL);
+        return NULL;
+    }
+    return elm->tb_func;
+}
+
+static void check_gc_completion(void)
+{
+    if (instance_done_gc > 0) {
+        qatomic_sub(&instances_global, instance_done_gc);
+        instance_pending_gc -= instance_done_gc;
+        instance_done_gc = 0;
+    }
+}
+
+EM_JS_PRE(void, init_wasm_js, (void *instance_done_gc),
+{
+    Module.__wasm_tb = {
+        inst_gc_registry: new FinalizationRegistry((i) => {
+            if (i == "tbinstance") {
+                const memory_v = new DataView(HEAP8.buffer);
+                let v = memory_v.getInt32(instance_done_gc, true);
+                memory_v.setInt32(instance_done_gc, v + 1, true);
+            }
+        })
+    };
+});
+
+#define MAX_EXEC_NUM 50000
+static __thread int exec_cnt = MAX_EXEC_NUM;
+static inline void trysleep(void)
+{
+    /*
+     * Even during running TBs continuously, try to return the control
+     * to the browser periodically and allow browsers doing tasks.
+     */
+    if (--exec_cnt == 0) {
+        if (!can_add_instance()) {
+            emscripten_sleep(0);
+            check_gc_completion();
+        }
+        exec_cnt = MAX_EXEC_NUM;
+    }
+}
+
+static int thread_idx_max;
+
+static void init_wasm(void)
+{
+    thread_idx = qatomic_fetch_inc(&thread_idx_max);
+    ctx.stack = g_malloc(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE);
+    ctx.buf128 = g_malloc(16);
+    ctx.tci_tb_ptr = (uint32_t *)&tci_tb_ptr;
+    init_wasm_js(&instance_done_gc);
+}
+
+static __thread bool initdone;
+
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *v_tb_ptr)
+{
+    if (!initdone) {
+        init_wasm();
+        initdone = true;
+    }
+    ctx.env = env;
+    ctx.tb_ptr = (void *)v_tb_ptr;
+    while (true) {
+        trysleep();
+        uintptr_t res;
+        wasm_tb_func tb_func = get_instance_from_tb(ctx.tb_ptr);
+        if (tb_func) {
+            /*
+             * Call the Wasm instance
+             */
+            res = call_wasm_tb(tb_func, &ctx);
+        } else if (!inc_counter(ctx.tb_ptr)) {
+            /*
+             * Run it on TCI because the counter value is small
+             */
+            res = tcg_qemu_tb_exec_tci(env);
+        } else if (!can_add_instance()) {
+            /*
+             * Too many instances has been created, try removing older
+             * instances and keep running this TB on TCI
+             */
+            remove_old_instances();
+            check_gc_completion();
+            res = tcg_qemu_tb_exec_tci(env);
+        } else {
+            /*
+             * Instantiate and run the Wasm module
+             */
+            struct WasmTBHeader *header = (struct WasmTBHeader *)ctx.tb_ptr;
+            tb_func = (wasm_tb_func)instantiate_wasm(header->wasm_ptr,
+                                                     header->wasm_size,
+                                                     header->import_ptr,
+                                                     header->import_size);
+            add_instance(tb_func, ctx.tb_ptr);
+            res = call_wasm_tb(tb_func, &ctx);
+        }
+        if (!ctx.tb_ptr) {
+            return res;
+        }
+    }
+}
diff --git a/tcg/wasm.h b/tcg/wasm.h
index a7e2ba0dd7..a9306529e7 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -46,6 +46,14 @@ static inline uintptr_t call_wasm_tb(wasm_tb_func f, struct WasmContext *ctx)
 {
     ctx->do_init = 1; /* reset the block index (rewinding will skip this) */
     return f(ctx);
+}
+
+/*
+ * WasmInstanceInfo holds the relationship between TB and Wasm instance.
+ */
+struct WasmInstanceInfo {
+    void *tb_ptr;
+    wasm_tb_func tb_func;
 };
 
 /*
@@ -69,6 +77,43 @@ struct WasmTBHeader {
      */
     void *import_ptr;
     int import_size;
+
+    /*
+     * Counter holds how many times the TB is executed before the instantiation
+     * for each thread.
+     */
+    int32_t *counter_ptr;
+
+    /*
+     * Pointer to the instance information on each thread.
+     */
+    struct WasmInstanceInfo **info_ptr;
 };
 
+static inline void *get_tci_ptr(void *tb_ptr)
+{
+    return ((struct WasmTBHeader *)tb_ptr)->tci_ptr;
+}
+
+static inline int32_t get_counter(void *tb_ptr, int idx)
+{
+    return ((struct WasmTBHeader *)tb_ptr)->counter_ptr[idx];
+}
+
+static inline void set_counter(void *tb_ptr, int idx, int v)
+{
+    ((struct WasmTBHeader *)tb_ptr)->counter_ptr[idx] = v;
+}
+
+static inline struct WasmInstanceInfo *get_info(void *tb_ptr, int idx)
+{
+    return ((struct WasmTBHeader *)tb_ptr)->info_ptr[idx];
+}
+
+static inline void set_info(void *tb_ptr, int idx,
+                            struct WasmInstanceInfo *info)
+{
+    ((struct WasmTBHeader *)tb_ptr)->info_ptr[idx] = info;
+}
+
 #endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index f1b7ec5f47..cf84c3ca4f 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -28,6 +28,11 @@
 #include "qemu/queue.h"
 #include "../wasm.h"
 
+/*
+ * This is included to get the number of threads via tcg_max_ctxs.
+ */
+#include "../tcg-internal.h"
+
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
@@ -2789,6 +2794,7 @@ static int write_mod_code(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    int size;
     struct WasmTBHeader *h;
     intptr_t ofs;
 
@@ -2803,6 +2809,18 @@ static void tcg_out_tb_start(TCGContext *s)
     h = (struct WasmTBHeader *)(s->code_ptr);
     s->code_ptr += sizeof(struct WasmTBHeader);
 
+    /* locate counters */
+    h->counter_ptr = (int32_t *)s->code_ptr;
+    size = tcg_max_ctxs * sizeof(int32_t);
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
+    /* locate the instance information */
+    h->info_ptr = (struct WasmInstanceInfo **)s->code_ptr;
+    size = tcg_max_ctxs * sizeof(void *);
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
     /* Followed by TCI code */
     h->tci_ptr = s->code_ptr;
 
-- 
2.43.0


