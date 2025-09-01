Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900F3CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut33m-0006kB-P5; Mon, 01 Sep 2025 07:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31V-0003e4-Fv; Mon, 01 Sep 2025 07:48:36 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31L-0001ra-CX; Mon, 01 Sep 2025 07:48:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2445805aa2eso43022645ad.1; 
 Mon, 01 Sep 2025 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727295; x=1757332095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrnKzdEd+MTfG/VxM7WMSinaKjZRPI/Ikt1qARO7ThI=;
 b=XFnkYwO78Kv/Ygzvx0zJVRCpDsXkqwRqDa6gziqB8gtB3Np2rYCpCQkgSmGDgfRhhT
 DOc5us2YygBh8darHPQkRSuMrT8BPb5I9FEpoWDr370TE7GZYJdgtB7tvl9YiSfPtzaK
 H0d0G3NbAZB5zVs4V3ET3KSI0pAxpXVTldlSsoQAN0u82l4Paeo4lvFZphifRibx2YaT
 MMt90EFfNQPstCbksAhpe+VO/pTX1ov6BYQNIcigLKG66Khj5yqVbORU5uRcIwnFt2nC
 pd654HbIt/p20lrUry9R2P3P1Q5z6ugBiuShKABa4f4iL1OmBjZ7fl+VI4bQqgR/rHEu
 +f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727295; x=1757332095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrnKzdEd+MTfG/VxM7WMSinaKjZRPI/Ikt1qARO7ThI=;
 b=bvBlfzrNP1ctRLBZxsHsdrTeV6ykmYnF05HtleAeOkcWPv4iVxTKbHYAAfnpiLb5Zb
 ymfRbr+9Ym3bSRU5Yka/R3QZGewvdmG0qn9xSkGISJv8ciToGsE0+YquFlZJLw2Ttsdy
 wwfdAymovJd214G5FfxrXpH7RFER3FOnkCO5Fl50SA2RurGV0uM6PNaQLucZe+Si9Ucj
 617AeNxCe5u+zGX8PexCDDTEm3B+sVqOhyqgw06nIJArfNCM3SY9emrZ56vwi7UDakRY
 5EZEDylaorhY0ekozfTxn9i0SEr61Iy+RQCPVIGVhu6vo4+5pfPFvOKEheTRySfDUqj5
 82hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsBnfrTqPGTXtg4tt9SShmuaJQAhGwtaxJF7FTU77JTW5GpIY5nZ8E0iHR1+7HbqJiAFcVmn/dlA==@nongnu.org,
 AJvYcCV2t8GK9jqSBD8E8J5oG0Mfkg7hYMA7lJ1L44JybeNvDxyiUjE+w6Jf0m2aC+FsIoU+DPpcnqg7szGD+w==@nongnu.org
X-Gm-Message-State: AOJu0YxCk/bxlK1VHQEPNIVlje99jly6277T1NTtWqJ+txEdNWcA31dk
 HJJP1f2i11Dp9m9lnedrjs5lEG/a4yXPCJdbFGOmPE+BaKF/JBERvWf5IC5O1w==
X-Gm-Gg: ASbGnct4WICfPfFabzpCz8mkIRQNRJ7MLy1Oiw88pnt1hVTeE6gG1SNTUAf+6sghq2P
 aA3jDuryYXeEeDKk3zcb8XfMwUzCSQYSiksh+Iyp9YmEzS0dS3+RpqJUVhXnjg+O4d5KQPchous
 Wi1lJegqspkfhDEWs7gIU3bzE4HXgaDq3Vc0Qd2/eCDEt6CfXqnKXVD+qhZewMJR6KGeAJ4j8rw
 nyWkmuVb6NAmuCZKKMSRK+rYdgfBWd0WPDdaY2hJggOaOlD19tw0J1nX/vPNtlB/b/HwXpUSW0n
 KN2Le0alJCAPAigf8+yhRTa+flNq+AxXX6S0micMT7lI1RK93M81ZpWPD2eLj5GAgFkMKfq0yQb
 vyiWPIQeOsDW4nDi2/rzQtt7bJ3okCdIs
X-Google-Smtp-Source: AGHT+IH8eAqlOi/gK2WG49ASJm9/0n1ujHDsC4592zhn0zFAfT6BGAEKWE+3NlatvfsauHPb2SjqMQ==
X-Received: by 2002:a17:903:41d0:b0:249:27b9:2a06 with SMTP id
 d9443c01a7336-2494488a758mr110173015ad.2.1756727294946; 
 Mon, 01 Sep 2025 04:48:14 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:48:14 -0700 (PDT)
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
Subject: [PATCH v3 30/35] tcg/wasm: Enable instantiation of TBs executed many
 times
Date: Mon,  1 Sep 2025 20:44:32 +0900
Message-ID: <d7d4fc4a608aed5fc04c1fe4987be876a8af4ba3.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit enables the instantiation and execution of TBs in wasm.c. As in
TCI, the tcg_qemu_tb_exec function serves as the entrypoint for the TB
execution, handling both instantiation and invocation of the Wasm
module. Since browsers cause out of memory error if too many Wasm instances
are created, this commit restricts instantiation to TBs that are called many
times.

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
 tcg/wasm.c                | 244 +++++++++++++++++++++++++++++++++++++-
 tcg/wasm.h                |  45 +++++++
 tcg/wasm/tcg-target.c.inc |  21 ++++
 3 files changed, 307 insertions(+), 3 deletions(-)

V3:
- Fixed init_wasm_js to correctly cast pointers to Numbers when passing the
  arguments to the getInt32 and setInt32 methods.
- Lowered the the maximum number of instances (MAX_INSTANCES) to avoid the
  out of memory error in recent versions of FireFox.

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 82987e9dff..00f4222183 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -24,6 +24,10 @@
 #include "tcg/helper-info.h"
 #include <ffi.h>
 #include <emscripten.h>
+#include "wasm.h"
+
+/* TBs executed more than this value will be compiled to wasm */
+#define INSTANTIATE_NUM 1500
 
 #define EM_JS_PRE(ret, name, args, body...) EM_JS(ret, name, args, body)
 
@@ -61,6 +65,8 @@ EM_JS_PRE(void*, instantiate_wasm, (void *wasm_begin,
             "helper" : helper,
     });
 
+    Module.__wasm_tb.inst_gc_registry.register(inst, "tbinstance");
+
     return ENC_PTR(addFunction(inst.exports.start, 'ii'));
 });
 
@@ -288,9 +294,53 @@ static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
     }
 }
 
-static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
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
 {
-    const uint32_t *tb_ptr = v_tb_ptr;
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
+static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env)
+{
+    uint32_t *tb_ptr = get_tci_ptr(ctx.tb_ptr);
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
                    / sizeof(uint64_t)];
@@ -583,18 +633,32 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             break;
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
             tci_args_rrm(insn, &r0, &r1, &oi);
@@ -615,3 +679,177 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         }
     }
 }
+
+/*
+ * The maximum number of instances that can exist simultaneously
+ *
+ * If this limit is reached and a new instance is required, older instances are
+ * removed to allow creation of new ones without exceeding the browser's limit.
+ */
+#define MAX_INSTANCES 12000
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
+                let v = memory_v.getInt32(DEC_PTR(instance_done_gc), true);
+                memory_v.setInt32(DEC_PTR(instance_done_gc), v + 1, true);
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
index fdde908557..88163c28df 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -46,6 +46,14 @@ static inline uintptr_t call_wasm_tb(wasm_tb_func f, struct WasmContext *ctx)
     return f(ctx);
 }
 
+/*
+ * WasmInstanceInfo holds the relationship between TB and Wasm instance.
+ */
+struct WasmInstanceInfo {
+    void *tb_ptr;
+    wasm_tb_func tb_func;
+};
+
 /*
  * A TB of the Wasm backend starts from a header which contains pointers for
  * each data stored in the following region in the TB.
@@ -67,6 +75,43 @@ struct WasmTBHeader {
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
index 6af4d6eb07..784df9e630 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -28,6 +28,9 @@
 #include "qemu/queue.h"
 #include "../wasm.h"
 
+/* This is included to get the number of threads via tcg_max_ctxs. */
+#include "../tcg-internal.h"
+
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET 0
 #define TCG_TARGET_STACK_ALIGN       8
@@ -2295,6 +2298,11 @@ static void tcg_out_set_carry(TCGContext *s)
     g_assert_not_reached();
 }
 
+/* Generate global QEMU prologue and epilogue code. */
+static inline void tcg_target_qemu_prologue(TCGContext *s)
+{
+}
+
 static const uint8_t mod_1[] = {
     0x0, 0x61, 0x73, 0x6d, /* magic */
     0x01, 0x0, 0x0, 0x0,   /* version */
@@ -2443,6 +2451,7 @@ static int write_mod_code(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    int size;
     intptr_t ofs;
     struct WasmTBHeader *h;
 
@@ -2457,6 +2466,18 @@ static void tcg_out_tb_start(TCGContext *s)
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


