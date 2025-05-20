Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15005C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMVe-0005sv-3C; Tue, 20 May 2025 08:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMV1-0004Zv-IV; Tue, 20 May 2025 08:55:16 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUy-0001J3-2i; Tue, 20 May 2025 08:55:15 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30ea7770bd2so4208220a91.0; 
 Tue, 20 May 2025 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745705; x=1748350505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBZg2rkxk5ny0INYpq4DIhkYLh/SGhQqukUB+EhzpVk=;
 b=QqVuH3DBkBKxU+hXy9ZrgxQSehxYxLGZ5LZO54a1qtl1P/sMCPCaIns3nLOFNHmeA1
 +aZCH5yB16YT4kalzPUGMVc/VESDGfaZ213d8II0NOZMS/MTetYc1W7LrhGQUPs7g6HQ
 BH4rmNuoGv3cZOffPQjT59wPVrGZppcjledk3WScxDeUMhlNVyUmUtrNHx3IOFr8704T
 xG+Bdn0AOFYI/UeR9xapmFGI+aa8BRgYu3dGwg7JcBwt5W1HQgfMW/KPyJHkYiaxAJ8s
 bS2Pc5LrlgQVA5BuH2ds1r321qVRYIpJPt2W8LtgFFpXLbzniDI0VLHBm0Y8gnD+lT1K
 jA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745705; x=1748350505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBZg2rkxk5ny0INYpq4DIhkYLh/SGhQqukUB+EhzpVk=;
 b=j8LyALEraS2XxQKWb1/hhsYYuykQOKgibLZxqW4SD4ru8ItXJ4scVtYjFn5QEu0h25
 r+BOmAalP414BqCmd0r0hzRJZZHnmmyrBiLQieAuXy/9pZJ9HmVo0NgFPh/zfb4UiKtD
 M6OJ0tCTnv4kBX6kN+FWOa3qh8IbxopY0eLoVvjMquJbORJmO9YoHszo7mQLzQNZvWNB
 jIGTX2OSsBUdwcdPoFMGMHnNa7Yzys2WdCxwdgonIh+gmTP7pYQGKC2YSBMRAYiD2AZb
 SYf4zyn4wysysS+UGKtz8tzPjYSCrBQVRb9nXoI4PU5E04aW++R1Aj2fSFlzFex0NSA8
 sW0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu6rBQYsC01esdzVVYn5s/6k6vNAYsbMwWVTAWW0fxFTU4aW8k+duu6ebHLj3I/K+lXZbKgg7y8AsJtA==@nongnu.org,
 AJvYcCWyUQbu2eD1rEYAsi13f0ArJ86uto5rrptqwZhU0sm73Q6PlRucE2D4k4mbnEK1QD44wlvxLrCTng==@nongnu.org
X-Gm-Message-State: AOJu0YzPN2oSpclQNtFUkIcq/ys+v6aFIQQo/iJJIt3w5QqRDWWGPzNb
 I1gd+YcR1SZ9Z20G8t/Pn7rN/ebl2RG1/aOz3Q0XLWOrGQ67RVeboKUg28L1BpB8
X-Gm-Gg: ASbGncsDdCkiDoUGy3Hp4IR0ONCC2a6Q2G1GOcdTiTa6mAt/yvHAN4QN1Wu7zyArerd
 D9HwPj4fy5hXXa6X8naTUHNe1Az2CRUFotPeaDqQiCYoWvYkpF25D/Fi7Z/TiA9hHBv7gUlbLTj
 6MmGOb/m4108Qe7h4iPxvIK/4GVh0MWq7Z7lzu56muBJUmLIifX/cAxuDGVI/l0UNnhWxgZ3y6O
 ve3T0HdZuDX0PsY3wcG5+4Eas5/jbXdPDuHSAM6QBcZUEV5dKE6oCL0/Us/g28PsWrsYvPB0kCP
 cNjR+IZ7KKUSHFWHEoZYV9jwQz9dceyE/MAnSjdve8gBymMcgIo=
X-Google-Smtp-Source: AGHT+IFVDwR9OMJl+zS8v+j14qOrqSC22HwHzudg6SLEv6QJtDFsh1QVYN472BwElteO3wpZaIh/uQ==
X-Received: by 2002:a17:90b:3905:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-30e7d501dd0mr21918201a91.5.1747745705216; 
 Tue, 20 May 2025 05:55:05 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:55:04 -0700 (PDT)
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
Subject: [PATCH 30/33] tcg/wasm32: Enable instantiation of TBs executed many
 times
Date: Tue, 20 May 2025 21:51:32 +0900
Message-ID: <75d5017b4af1853c2924a21b406792c6154ac08e.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1032.google.com
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

This commit enables instantiations of TBs in wasm32.c. Browsers cause out of
memory error if too many Wasm instances are created so the number of
instances needs to be limited. So this commit restricts instantiation only
for TBs that are called many times.

This commit adds a counter (or its array if there are multiple threads) to
the TB. Each time a TB is executed on TCI, the counter on TB is
incremented. If it reaches to a threshold, that TB is instantiated as Wasm
via instantiate_wasm.

The total number of instances are tracked by the instances_global variable
and its max number is limited by MAX_INSTANCES. When a Wasm module is
instantiated, instances_global is incremented and the instance's function
pointer is recorded to an array of wasmInstanceInfo.

Each TB refers to the wasmInstanceInfo via wasmTBHeader's info_ptr (or its
array if there are multiple threads). This allows tcg_qemu_tb_exec to
resolve the instance function pointer from TB.

When a new instantiation risks exceeding the limit, the Wasm backend doesn't
perform the instantiation (i.e. TB continues to be executed on TCI),
instead, removal of older Wasm instances is triggered using Emscripten's
removeFunction function. Once the removal of the instance is detected via
FinalizationRegistry API[1], instances_global is decremented, which allows
instantiation of new modules again.

[1] https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/FinalizationRegistry

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.c                | 241 +++++++++++++++++++++++++++++++++++-
 tcg/wasm32.h                |  45 +++++++
 tcg/wasm32/tcg-target.c.inc |  17 +++
 3 files changed, 299 insertions(+), 4 deletions(-)

diff --git a/tcg/wasm32.c b/tcg/wasm32.c
index e6a3dbf750..fe6f2f17da 100644
--- a/tcg/wasm32.c
+++ b/tcg/wasm32.c
@@ -26,6 +26,7 @@
 #include "tcg-has.h"
 #include <ffi.h>
 #include <emscripten.h>
+#include "wasm32.h"
 
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
@@ -45,6 +46,9 @@
 
 __thread uintptr_t tci_tb_ptr;
 
+/* TBs executed more than this value will be compiled to wasm */
+#define INSTANTIATE_NUM 1500
+
 EM_JS(int, instantiate_wasm, (int wasm_begin,
                               int wasm_size,
                               int import_vec_begin,
@@ -68,6 +72,8 @@ EM_JS(int, instantiate_wasm, (int wasm_begin,
             "helper" : helper,
     });
 
+    Module.__wasm32_tb.inst_gc_registry.register(inst, "tbinstance");
+
     return addFunction(inst.exports.start, 'ii');
 });
 
@@ -353,16 +359,44 @@ static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
     }
 }
 
+__thread int thread_idx;
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
+static inline struct wasmInstanceInfo *get_info_local(void *tb_ptr)
+{
+    return get_info(tb_ptr, thread_idx);
+}
+
+static inline void set_info_local(void *tb_ptr, struct wasmInstanceInfo *info)
+{
+    set_info(tb_ptr, thread_idx, info);
+}
+
+__thread struct wasmContext ctx = {
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
@@ -384,6 +418,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
         MemOpIdx oi;
         int32_t ofs;
         void *ptr;
+        int32_t counter;
 
         insn = *tb_ptr++;
         opc = extract32(insn, 0, 8);
@@ -802,20 +837,40 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
         case INDEX_op_exit_tb:
             tci_args_l(insn, tb_ptr, &ptr);
+            ctx.tb_ptr = 0;
             return (uintptr_t)ptr;
 
         case INDEX_op_goto_tb:
             tci_args_l(insn, tb_ptr, &ptr);
-            tb_ptr = *(void **)ptr;
+            if (*(uint32_t **)ptr != tb_ptr) {
+                tb_ptr = *(uint32_t **)ptr;
+                ctx.tb_ptr = tb_ptr;
+                counter = get_counter_local(tb_ptr);
+                if ((counter >= 0) && (counter < INSTANTIATE_NUM)) {
+                    set_counter_local(tb_ptr, counter + 1);
+                } else {
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
+            counter = get_counter_local(tb_ptr);
+            if ((counter >= 0) && (counter < INSTANTIATE_NUM)) {
+                set_counter_local(tb_ptr, counter + 1);
+            } else {
+                return 0; /* enter to wasm TB */
+            }
+            tb_ptr = get_tci_ptr(tb_ptr);
             break;
 
         case INDEX_op_qemu_ld:
@@ -861,3 +916,181 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 /*
  * TODO: Disassembler is not implemented
  */
+
+/*
+ * Max number of instances can exist simultaneously.
+ *
+ * If the number of instances reaches this and a new instance needs to be
+ * created, old instances are removed so that new instances can be created
+ * without hitting the browser's limit.
+ */
+#define MAX_INSTANCES 15000
+
+int instances_global;
+
+/* Avoid overwrapping of begin/end pointers */
+#define INSTANCES_BUF_MAX (MAX_INSTANCES + 1)
+
+__thread struct wasmInstanceInfo instances[INSTANCES_BUF_MAX];
+__thread int instances_begin;
+__thread int instances_end;
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
+__thread int instance_pending_gc;
+__thread int instance_done_gc;
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
+    struct wasmInstanceInfo *elm = get_info_local(tb_ptr);
+    if (elm == NULL) {
+        return NULL;
+    }
+    if (elm->tb_ptr != tb_ptr) {
+        /*
+         * This TB was instantiated but has been removed. Set counter to the
+         * max value so that this will be instantiated again at the next
+         * invocation.
+         */
+        set_counter_local(tb_ptr, INSTANTIATE_NUM);
+        set_info_local(tb_ptr, NULL);
+        return NULL;
+    }
+    return elm->tb_func;
+}
+
+static void check_instance_garbage_collected(void)
+{
+    if (instance_done_gc > 0) {
+        qatomic_sub(&instances_global, instance_done_gc);
+        instance_pending_gc -= instance_done_gc;
+        instance_done_gc = 0;
+    }
+}
+
+EM_JS(void, init_wasm32_js, (int instance_done_gc_ptr),
+{
+    Module.__wasm32_tb = {
+        inst_gc_registry: new FinalizationRegistry((i) => {
+            if (i == "tbinstance") {
+                const memory_v = new DataView(HEAP8.buffer);
+                let v = memory_v.getInt32(instance_done_gc_ptr, true);
+                memory_v.setInt32(instance_done_gc_ptr, v + 1, true);
+            }
+        })
+    };
+});
+
+#define MAX_EXEC_NUM 50000
+__thread int exec_cnt = MAX_EXEC_NUM;
+static inline void trysleep(void)
+{
+    /*
+     * Even during running TBs continuously, try to return the control
+     * to the browser periodically and allow browsers doing tasks.
+     */
+    if (--exec_cnt == 0) {
+        if (!can_add_instance()) {
+            emscripten_sleep(0);
+            check_instance_garbage_collected();
+        }
+        exec_cnt = MAX_EXEC_NUM;
+    }
+}
+
+int thread_idx_max;
+
+static void init_wasm32(void)
+{
+    thread_idx = qatomic_fetch_inc(&thread_idx_max);
+    ctx.stack = g_malloc(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE);
+    ctx.buf128 = g_malloc(16);
+    ctx.tci_tb_ptr = (uint32_t *)&tci_tb_ptr;
+    init_wasm32_js((int)&instance_done_gc);
+}
+
+__thread bool initdone;
+
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *v_tb_ptr)
+{
+    if (!initdone) {
+        init_wasm32();
+        initdone = true;
+    }
+    ctx.env = env;
+    ctx.tb_ptr = (void *)v_tb_ptr;
+    while (true) {
+        trysleep();
+        struct wasmTBHeader *header = (struct wasmTBHeader *)ctx.tb_ptr;
+        int32_t counter = get_counter_local(header);
+        uint32_t res;
+        wasm_tb_func tb_func = get_instance_from_tb(ctx.tb_ptr);
+        if (tb_func) {
+            /*
+             * call the instance if available
+             */
+            res = call_wasm_tb(tb_func, &ctx);
+        } else if (counter < INSTANTIATE_NUM) {
+            /*
+             * run it on TCI if the counter value is small
+             */
+            set_counter_local(ctx.tb_ptr, counter + 1);
+            res = tcg_qemu_tb_exec_tci(env);
+        } else if (!can_add_instance()) {
+            /*
+             * too many instances has been created, try removing older
+             * instances and keep running this TB on TCI
+             */
+            remove_old_instances();
+            check_instance_garbage_collected();
+            res = tcg_qemu_tb_exec_tci(env);
+        } else {
+            /*
+             * instantiate and run TB as Wasm
+             */
+            tb_func = (wasm_tb_func)instantiate_wasm((int)header->wasm_ptr,
+                                                     header->wasm_size,
+                                                     (int)header->import_ptr,
+                                                     header->import_size);
+            add_instance(tb_func, ctx.tb_ptr);
+            res = call_wasm_tb(tb_func, &ctx);
+        }
+        if (!ctx.tb_ptr) {
+            return res;
+        }
+    }
+}
diff --git a/tcg/wasm32.h b/tcg/wasm32.h
index f2749f1e0e..9a3230e87c 100644
--- a/tcg/wasm32.h
+++ b/tcg/wasm32.h
@@ -48,6 +48,14 @@ static inline int32_t call_wasm_tb(wasm_tb_func f, struct wasmContext *ctx)
     return f(ctx);
 }
 
+/*
+ * wasmInstanceInfo holds the relationship between TB and Wasm instance.
+ */
+struct wasmInstanceInfo {
+    void *tb_ptr;
+    wasm_tb_func tb_func;
+};
+
 /*
  * TB of wasm backend starts from a header which stores pointers for each data
  * stored in the following region in the TB.
@@ -69,6 +77,43 @@ struct wasmTBHeader {
      */
     void *import_ptr;
     int import_size;
+
+    /*
+     * Counter holds how many times the TB is executed before instantiation
+     * for each thread.
+     */
+    int32_t *counter_ptr;
+
+    /*
+     * Pointer to the instance information on each thread.
+     */
+    struct wasmInstanceInfo **info_ptr;
 };
 
+static inline uint32_t *get_tci_ptr(void *tb_ptr)
+{
+    return (uint32_t *)(((struct wasmTBHeader *)tb_ptr)->tci_ptr);
+}
+
+static inline int32_t get_counter(void *tb_ptr, int idx)
+{
+    return ((struct wasmTBHeader *)tb_ptr)->counter_ptr[idx];
+}
+
+static inline void set_counter(void *tb_ptr, int idx, int v)
+{
+    ((struct wasmTBHeader *)tb_ptr)->counter_ptr[idx] = v;
+}
+
+static inline struct wasmInstanceInfo *get_info(void *tb_ptr, int idx)
+{
+    return ((struct wasmTBHeader *)tb_ptr)->info_ptr[idx];
+}
+
+static inline void set_info(void *tb_ptr, int idx,
+                            struct wasmInstanceInfo *info)
+{
+    ((struct wasmTBHeader *)tb_ptr)->info_ptr[idx] = info;
+}
+
 #endif
diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 04cd9b6e4a..f0c51a5d3d 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -27,6 +27,11 @@
 
 #include "../wasm32.h"
 
+/*
+ * This is included to get the max number of threads via tcg_max_ctxs.
+ */
+#include "../tcg-internal.h"
+
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
@@ -3654,6 +3659,18 @@ static void tcg_out_tb_start(TCGContext *s)
     h = (struct wasmTBHeader *)(s->code_ptr);
     s->code_ptr += sizeof(struct wasmTBHeader);
 
+    /* locate counters */
+    h->counter_ptr = (int32_t *)s->code_ptr;
+    size = tcg_max_ctxs * sizeof(int32_t);
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
+    /* locate instance information */
+    h->info_ptr = (struct wasmInstanceInfo **)s->code_ptr;
+    size = tcg_max_ctxs * sizeof(void *);
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
     /* Followed by TCI code */
     h->tci_ptr = s->code_ptr;
 
-- 
2.43.0


