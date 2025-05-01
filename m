Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC65C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbM0-00019i-Oj; Thu, 01 May 2025 17:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLo-00011a-L5
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:48 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLm-0001aW-OR
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:48 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso2048764a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134505; x=1746739305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsZ8FJcLEY5U3nEVLTj99X8sj4X3vzwcgXXSB46La3Y=;
 b=BtjKkUpi8TIfXYQGbsh/1qyH28jaBuCgyr7OQOhNQvncw3y9cMeh/23gw8wh52/dJr
 0+/a4ccAAjd1C5vOHg68JZ9aLm6pCE6TFcIqnnFWgYPgsoDnn5R/Mgp9Amav7BQQ84VA
 qLK6yNHv4+lQ3W4GxCEduKSFgfkNj1pEftshAi/FQHX/KQwGuEWcDbvDYCssjlPylIUt
 qmbagSPk2zsMCLr87nAoFFjSayyRydExGCXk8WEuzybJgX1mmqlgZ/iiOu9x1FgnbeYP
 AI6huYxQjuQLq4idhFgESsXtrqen82RpRwgCFbaR5bZtQfEhxdzA4mRiO38CxLclz6Sn
 IA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134505; x=1746739305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gsZ8FJcLEY5U3nEVLTj99X8sj4X3vzwcgXXSB46La3Y=;
 b=aMnCa9vTW8CuZS4/uNXY9eZRGNs4+orHVXicIVFmltnBO5WYKv/3sZ/yGQyUmxOknE
 DlEsiTnnAgbrRAMrHPIAgBVYRih2tWXMWzZLeI5FoOwo3lqAzGE2Pb6ooBEPUduezzAy
 nyacRF3VXNtdj/WVfUUj+xvj7MhlZQaSFUfCfevCVmRPh7aAj0EBWSzu4hgtvS0+Y4HP
 lP6KZ7W99MONYUKLA6ywIU087MlNe9WrJ8yX3JABgw7IDkoEMdmWILFNNG/xM8YJKAyA
 Su9o22C6hNEDO5Pp2vSOcZjIphyRYvJnnX4UTrvPuYR+1YTAJYJr3HR5Y6lp41Qs9KCJ
 K+dA==
X-Gm-Message-State: AOJu0YztNEBrLffPs3EPFhodvWaDJHepGDkQQrkxgS9zLnctOisuaBAL
 z/J5nA6uRvfGK7VUU/ZHGUyMQSkcnkMy0QmbhTOQpUUdAnrMC0EjnqMx9Ndv2etZvOB+s7SXTcf
 Y
X-Gm-Gg: ASbGnctlYL3jF+/IbPelxJR6UUkBw7sp+hqLsgyLuA85gArZgpWGE6wWyyAjDkLzdYW
 Fo5rUchDhYwXHNxnpJyUm+3JasuBdyZJ5Lxc6U96wyRkl0IlsZCWqs6EeYRqUdrgWNEK2lEmD4T
 7ZkrSnDUwPLB07D94wDq7pIt0n5UtnwV3Q5d+f8/rsj9lmAYnavlUbAylrnfxYnC7hhuxwrsvvY
 jYTk7wlQR4V/2YN46J+wZI7XBbQsptnRcS/HB4AF/N73YbBLqeJrTK/YQKIuC8JbBEFuQ3+ruCP
 Tx+74dRmaDRkM0F6PKXtxMQOKwOrUd6Xv8gJq0aYPuHUf4fQNRHx1AGBbBYKO0YaKjG/nU/vL8M
 =
X-Google-Smtp-Source: AGHT+IFSwWTOb2DzA/5jj1ryhtvwgy6574vpZEOfgxH5QjxwMl2ePH2meV8q4rCRHdAIbamxPR3MMA==
X-Received: by 2002:a17:90b:58e4:b0:30a:204e:3271 with SMTP id
 98e67ed59e1d1-30a4e5c60femr1035249a91.17.1746134505171; 
 Thu, 01 May 2025 14:21:45 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 37/59] accel/tcg: Pass TCGTBCPUState to tb_gen_code
Date: Thu,  1 May 2025 14:20:51 -0700
Message-ID: <20250501212113.2961531-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h |  5 ++---
 accel/tcg/cpu-exec.c        |  4 ++--
 accel/tcg/translate-all.c   | 28 +++++++++++++---------------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 98c702422f..1dbc45dd95 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -12,6 +12,7 @@
 #include "exec/cpu-common.h"
 #include "exec/translation-block.h"
 #include "exec/mmap-lock.h"
+#include "accel/tcg/tb-cpu-state.h"
 
 extern int64_t max_delay;
 extern int64_t max_advance;
@@ -46,9 +47,7 @@ static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
 #endif
 }
 
-TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
-                              uint64_t cs_base, uint32_t flags,
-                              int cflags);
+TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s);
 void page_init(void);
 void tb_htable_init(void);
 void tb_reset_jump(TranslationBlock *tb, int n);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4ad84c2db8..a7436d2873 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -574,7 +574,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         tb = tb_lookup(cpu, s);
         if (tb == NULL) {
             mmap_lock();
-            tb = tb_gen_code(cpu, s.pc, s.cs_base, s.flags, s.cflags);
+            tb = tb_gen_code(cpu, s);
             mmap_unlock();
         }
 
@@ -951,7 +951,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 uint32_t h;
 
                 mmap_lock();
-                tb = tb_gen_code(cpu, s.pc, s.cs_base, s.flags, s.cflags);
+                tb = tb_gen_code(cpu, s);
                 mmap_unlock();
 
                 /*
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 97aadee52c..7b0bd50904 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -290,9 +290,7 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
 }
 
 /* Called with mmap_lock held for user mode emulation.  */
-TranslationBlock *tb_gen_code(CPUState *cpu,
-                              vaddr pc, uint64_t cs_base,
-                              uint32_t flags, int cflags)
+TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
 {
     CPUArchState *env = cpu_env(cpu);
     TranslationBlock *tb, *existing_tb;
@@ -305,14 +303,14 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     assert_memory_lock();
     qemu_thread_jit_write();
 
-    phys_pc = get_page_addr_code_hostp(env, pc, &host_pc);
+    phys_pc = get_page_addr_code_hostp(env, s.pc, &host_pc);
 
     if (phys_pc == -1) {
         /* Generate a one-shot TB with 1 insn in it */
-        cflags = (cflags & ~CF_COUNT_MASK) | 1;
+        s.cflags = (s.cflags & ~CF_COUNT_MASK) | 1;
     }
 
-    max_insns = cflags & CF_COUNT_MASK;
+    max_insns = s.cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = TCG_MAX_INSNS;
     }
@@ -332,12 +330,12 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     gen_code_buf = tcg_ctx->code_gen_ptr;
     tb->tc.ptr = tcg_splitwx_to_rx(gen_code_buf);
-    if (!(cflags & CF_PCREL)) {
-        tb->pc = pc;
+    if (!(s.cflags & CF_PCREL)) {
+        tb->pc = s.pc;
     }
-    tb->cs_base = cs_base;
-    tb->flags = flags;
-    tb->cflags = cflags;
+    tb->cs_base = s.cs_base;
+    tb->flags = s.flags;
+    tb->cflags = s.cflags;
     tb_set_page_addr0(tb, phys_pc);
     tb_set_page_addr1(tb, -1);
     if (phys_pc != -1) {
@@ -355,9 +353,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
-    trace_translate_block(tb, pc, tb->tc.ptr);
+    trace_translate_block(tb, s.pc, tb->tc.ptr);
 
-    gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
+    gen_code_size = setjmp_gen_code(env, tb, s.pc, host_pc, &max_insns, &ti);
     if (unlikely(gen_code_size < 0)) {
         switch (gen_code_size) {
         case -1:
@@ -434,10 +432,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * For CF_PCREL, attribute all executions of the generated code
      * to its first mapping.
      */
-    perf_report_code(pc, tb, tcg_splitwx_to_rx(gen_code_buf));
+    perf_report_code(s.pc, tb, tcg_splitwx_to_rx(gen_code_buf));
 
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
-        qemu_log_in_addr_range(pc)) {
+        qemu_log_in_addr_range(s.pc)) {
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
             int code_size, data_size;
-- 
2.43.0


