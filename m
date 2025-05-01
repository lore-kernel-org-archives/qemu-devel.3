Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFEFC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPM-0005kV-FC; Thu, 01 May 2025 17:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOn-0004Xh-RL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOl-0002BB-0s
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:53 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so2106447b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134689; x=1746739489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOn2Y1giKBfi7cu53+t6CSfZv1TgtkzLY9Zga711y9o=;
 b=qykBvOiJYsNDesUUAhmFIl4hizb6mzNbxMhQlgo/pAr4sXJ2Sr1ZOY2VDs30fcHWSl
 nSV7iK4HTSAjNX0MT1wNr5xsGdKCSosL70hsGa7xKb/2wBsh5+QectCqVdRlrgtZXk0Z
 unRW2ITWaQSiRf0ELmSo0TDmG9U6iGU/sZGqOYQDgU1Q2jWwIQnb90EvTsWcVbS2Bsti
 r13ZXodrY99NgqNKrDgzTdfWCNJSlWj/v4Ftf0gtcZ/eH0vb6bTR3GDJ/WpU0CjoCuRK
 rrJNHOfC+rKTEdjvY/JgYd7m2GHlodb1xUCO5OUPP+qQScOQJEFosAfHymVS4jrFXcgx
 HvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134689; x=1746739489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOn2Y1giKBfi7cu53+t6CSfZv1TgtkzLY9Zga711y9o=;
 b=HL6QouRVbmgSU90yAF4jmkihLJQwizXtzCHIedt/2wIAEUtDSQtggMxATla2qWluq9
 42KFnKkWdhFSM1ZTU7Os43pS/wmPTjshGNCnzijaPZHfb4n4SybIrk7ilFC38B68Jc8W
 T8EfuFJRMC5NHfmQZYtiAs1JmphV6fhmmvAxEZ4/r9xbViGB+pPFnS6FebXq5ZFsH6qQ
 hmF2Fniz9UCGz8DLnUPff+7zq8IjtoED4RljZ8Z6LbptutKgEKgljdT9Z2eOKZG9SSQz
 RuKKgSzufyx8RlJ4UgU/U0fW6aME72UGAJL1NIlcYqDzH11hS9TdKaJ4ATDUychOmaOS
 91cw==
X-Gm-Message-State: AOJu0Yys/cIEHjvjmeyPZ8m00CRNTcRhyhDYLX0kADEJF5NWNuKSb26M
 l9c7uYsbKeRwFGnTJrcjqgMsXFI/eS/CVAYYKwQEJoW9uUcoIChQ3SGt5wGnZdJYKHzJXH4e+5R
 x
X-Gm-Gg: ASbGncvF9lVCujFYPJf+gHVSqMua9eKXIJQqw11oRHtZpZLeBaBO6Un99ALGg/ngx+Z
 h80sdgF38cQmkicZfVUdI5S+Mm7Qr2nMfu4EPw5kV6pc684Mjc2HDY4PBy4N+WjeCehjfCbPSDC
 DVooayFNIjEXjAbnQaWAIFdWLzXfYIc1lr0VjHIsTUc6RECTOufGsKfI6dWKs2QKcKumv+7y0zT
 zpoehoKfYmZeZH4iYhX3mr79Fd3/99KCiAw8Nj9GHjZdjbjp4nTDPmMvHV775xqs5oWZqDO9MsB
 0oEVr13nPQZscVpGkne6yNGqC/kxWZYLB/jsaPfhdb8eSooC03qRrwfi2nLShtwWVJa5qMc4+hM
 =
X-Google-Smtp-Source: AGHT+IFkNGPmDRebvaWaiBnnHgN8upUAb/HxluDke1BTFuIf80jchZ2J2uPhu6PBkLvqkvMUMaRTiQ==
X-Received: by 2002:a05:6a00:2908:b0:737:6fdf:bb69 with SMTP id
 d2e1a72fcca58-74058a557demr647374b3a.13.1746134689461; 
 Thu, 01 May 2025 14:24:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 43/59] tcg: Define INSN_START_WORDS as constant 3
Date: Thu,  1 May 2025 14:20:57 -0700
Message-ID: <20250501212113.2961531-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use the same value for all targets.

Rename TARGET_INSN_START_WORDS and do not depend on
TARGET_INSN_START_EXTRA_WORDS.
Remove TCGContext.insn_start_words.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/insn-start-words.h | 11 +++++------
 include/tcg/tcg-op.h           | 17 ++++++++++++++---
 include/tcg/tcg-opc.h          |  3 +--
 include/tcg/tcg.h              | 12 +++++++-----
 accel/tcg/translate-all.c      | 19 +++++++++----------
 target/i386/helper.c           |  2 +-
 target/openrisc/sys_helper.c   |  2 +-
 tcg/perf.c                     |  5 ++---
 tcg/tcg.c                      | 12 +++++-------
 9 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
index d416d19bcf..c52aec50a7 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -1,13 +1,12 @@
 /* SPDX-License-Identifier: MIT */
 /*
- * Define TARGET_INSN_START_WORDS
+ * Define INSN_START_WORDS
  * Copyright (c) 2008 Fabrice Bellard
  */
 
-#ifndef TARGET_INSN_START_WORDS
+#ifndef TCG_INSN_START_WORDS
+#define TCG_INSN_START_WORDS
 
-#include "cpu-param.h"
+#define INSN_START_WORDS 3
 
-# define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-
-#endif /* TARGET_INSN_START_WORDS */
+#endif /* TCG_INSN_START_WORDS */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 59d19755e6..c912578fdd 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -9,6 +9,7 @@
 #define TCG_TCG_OP_H
 
 #include "tcg/tcg-op-common.h"
+#include "tcg/insn-start-words.h"
 #include "exec/target_long.h"
 
 #ifndef TARGET_LONG_BITS
@@ -23,24 +24,34 @@
 # error
 #endif
 
+#if INSN_START_WORDS != 3
+# error Mismatch with insn-start-words.h
+#endif
+
 #if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
+                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
+    tcg_set_insn_start_param(op, 1, 0);
+    tcg_set_insn_start_param(op, 2, 0);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 2 * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
+                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
+    tcg_set_insn_start_param(op, 2, 0);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 2
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 3 * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
+                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, a2);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 995b79383e..e988edd93a 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -114,8 +114,7 @@ DEF(extrh_i64_i32, 1, 1, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
-/* There are tcg_ctx->insn_start_words here, not just one. */
-DEF(insn_start, 0, 0, DATA64_ARGS, TCG_OPF_NOT_PRESENT)
+DEF(insn_start, 0, 0, DATA64_ARGS * INSN_START_WORDS, TCG_OPF_NOT_PRESENT)
 
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index aa300a2f8b..a8c00c72cc 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -34,6 +34,7 @@
 #include "tcg-target-reg-bits.h"
 #include "tcg-target.h"
 #include "tcg/tcg-cond.h"
+#include "tcg/insn-start-words.h"
 #include "tcg/debug-assert.h"
 
 /* XXX: make safe guess about sizes */
@@ -359,7 +360,6 @@ struct TCGContext {
     int page_mask;
     uint8_t page_bits;
     uint8_t tlb_dyn_max_bits;
-    uint8_t insn_start_words;
     TCGBar guest_mo;
 
     TCGRegSet reserved_regs;
@@ -582,18 +582,19 @@ static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
     return (TCGv_vec)temp_tcgv_i32(t);
 }
 
-static inline TCGArg tcg_get_insn_param(TCGOp *op, int arg)
+static inline TCGArg tcg_get_insn_param(TCGOp *op, unsigned arg)
 {
     return op->args[arg];
 }
 
-static inline void tcg_set_insn_param(TCGOp *op, int arg, TCGArg v)
+static inline void tcg_set_insn_param(TCGOp *op, unsigned arg, TCGArg v)
 {
     op->args[arg] = v;
 }
 
-static inline uint64_t tcg_get_insn_start_param(TCGOp *op, int arg)
+static inline uint64_t tcg_get_insn_start_param(TCGOp *op, unsigned arg)
 {
+    tcg_debug_assert(arg < INSN_START_WORDS);
     if (TCG_TARGET_REG_BITS == 64) {
         return tcg_get_insn_param(op, arg);
     } else {
@@ -602,8 +603,9 @@ static inline uint64_t tcg_get_insn_start_param(TCGOp *op, int arg)
     }
 }
 
-static inline void tcg_set_insn_start_param(TCGOp *op, int arg, uint64_t v)
+static inline void tcg_set_insn_start_param(TCGOp *op, unsigned arg, uint64_t v)
 {
+    tcg_debug_assert(arg < INSN_START_WORDS);
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_set_insn_param(op, arg, v);
     } else {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7b0bd50904..fa4998b341 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -120,7 +120,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
 /* Encode the data collected about the instructions while compiling TB.
    Place the data at BLOCK, and return the number of bytes consumed.
 
-   The logical table consists of TARGET_INSN_START_WORDS target_ulong's,
+   The logical table consists of INSN_START_WORDS uint64_t's,
    which come from the target's insn_start data, followed by a uintptr_t
    which comes from the host pc of the end of the code implementing the insn.
 
@@ -140,13 +140,13 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
     for (i = 0, n = tb->icount; i < n; ++i) {
         uint64_t prev, curr;
 
-        for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
+        for (j = 0; j < INSN_START_WORDS; ++j) {
             if (i == 0) {
                 prev = (!(tb_cflags(tb) & CF_PCREL) && j == 0 ? tb->pc : 0);
             } else {
-                prev = insn_data[(i - 1) * TARGET_INSN_START_WORDS + j];
+                prev = insn_data[(i - 1) * INSN_START_WORDS + j];
             }
-            curr = insn_data[i * TARGET_INSN_START_WORDS + j];
+            curr = insn_data[i * INSN_START_WORDS + j];
             p = encode_sleb128(p, curr - prev);
         }
         prev = (i == 0 ? 0 : insn_end_off[i - 1]);
@@ -178,7 +178,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
         return -1;
     }
 
-    memset(data, 0, sizeof(uint64_t) * TARGET_INSN_START_WORDS);
+    memset(data, 0, sizeof(uint64_t) * INSN_START_WORDS);
     if (!(tb_cflags(tb) & CF_PCREL)) {
         data[0] = tb->pc;
     }
@@ -188,7 +188,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
      * at which the end of the insn exceeds host_pc.
      */
     for (i = 0; i < num_insns; ++i) {
-        for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
+        for (j = 0; j < INSN_START_WORDS; ++j) {
             data[j] += decode_sleb128(&p);
         }
         iter_pc += decode_sleb128(&p);
@@ -206,7 +206,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc)
 {
-    uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t data[INSN_START_WORDS];
     int insns_left = cpu_unwind_data_from_tb(tb, host_pc, data);
 
     if (insns_left < 0) {
@@ -349,7 +349,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
-    tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
     tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
@@ -457,7 +456,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
             fprintf(logfile, "OUT: [size=%d]\n", gen_code_size);
             fprintf(logfile,
                     "  -- guest addr 0x%016" PRIx64 " + tb prologue\n",
-                    tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                    tcg_ctx->gen_insn_data[insn * INSN_START_WORDS]);
             chunk_start = tcg_ctx->gen_insn_end_off[insn];
             disas(logfile, tb->tc.ptr, chunk_start);
 
@@ -470,7 +469,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
                 size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
                 if (chunk_end > chunk_start) {
                     fprintf(logfile, "  -- guest addr 0x%016" PRIx64 "\n",
-                            tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                            tcg_ctx->gen_insn_data[insn * INSN_START_WORDS]);
                     disas(logfile, tb->tc.ptr + chunk_start,
                           chunk_end - chunk_start);
                     chunk_start = chunk_end;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 197fdac7dd..e0aaed3c4c 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -526,7 +526,7 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
 static inline target_ulong get_memio_eip(CPUX86State *env)
 {
 #ifdef CONFIG_TCG
-    uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t data[INSN_START_WORDS];
     CPUState *cs = env_cpu(env);
 
     if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 951f8e247a..d96b41a01c 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -218,7 +218,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
-    uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t data[INSN_START_WORDS];
     MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cs = env_cpu(env);
     int idx;
diff --git a/tcg/perf.c b/tcg/perf.c
index 412a987d95..4e8d2c1bee 100644
--- a/tcg/perf.c
+++ b/tcg/perf.c
@@ -313,7 +313,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
                       const void *start)
 {
     struct debuginfo_query *q;
-    size_t insn, start_words;
+    size_t insn;
     uint64_t *gen_insn_data;
 
     if (!perfmap && !jitdump) {
@@ -329,11 +329,10 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
 
     /* Query debuginfo for each guest instruction. */
     gen_insn_data = tcg_ctx->gen_insn_data;
-    start_words = tcg_ctx->insn_start_words;
 
     for (insn = 0; insn < tb->icount; insn++) {
         /* FIXME: This replicates the restore_state_to_opc() logic. */
-        q[insn].address = gen_insn_data[insn * start_words + 0];
+        q[insn].address = gen_insn_data[insn * INSN_START_WORDS + 0];
         if (tb_cflags(tb) & CF_PCREL) {
             q[insn].address |= (guest_pc & qemu_target_page_mask());
         }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c4e866e9c3..648333a9fb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1989,7 +1989,6 @@ void tcg_func_start(TCGContext *s)
     QSIMPLEQ_INIT(&s->labels);
 
     tcg_debug_assert(s->addr_type <= TCG_TYPE_REG);
-    tcg_debug_assert(s->insn_start_words > 0);
 }
 
 static TCGTemp *tcg_temp_alloc(TCGContext *s)
@@ -2943,7 +2942,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             nb_oargs = 0;
             col += ne_fprintf(f, "\n ----");
 
-            for (i = 0, k = s->insn_start_words; i < k; ++i) {
+            for (i = 0, k = INSN_START_WORDS; i < k; ++i) {
                 col += ne_fprintf(f, " %016" PRIx64,
                                   tcg_get_insn_start_param(op, i));
             }
@@ -6835,7 +6834,7 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 {
-    int i, start_words, num_insns;
+    int i, num_insns;
     TCGOp *op;
 
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
@@ -6925,9 +6924,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     QSIMPLEQ_INIT(&s->ldst_labels);
     s->pool_labels = NULL;
 
-    start_words = s->insn_start_words;
     s->gen_insn_data =
-        tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
+        tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * INSN_START_WORDS);
 
     tcg_out_tb_start(s);
 
@@ -6969,8 +6967,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
                 assert(s->gen_insn_end_off[num_insns] == off);
             }
             num_insns++;
-            for (i = 0; i < start_words; ++i) {
-                s->gen_insn_data[num_insns * start_words + i] =
+            for (i = 0; i < INSN_START_WORDS; ++i) {
+                s->gen_insn_data[num_insns * INSN_START_WORDS + i] =
                     tcg_get_insn_start_param(op, i);
             }
             break;
-- 
2.43.0


