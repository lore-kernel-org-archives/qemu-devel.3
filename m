Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A78C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcu-0006ky-M9; Wed, 30 Apr 2025 12:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcT-0005F2-9B
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcP-0001vY-5R
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso169663b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031747; x=1746636547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNItTYCqljpWXCYmXErceMTzMhdQ1ZlNvx1ZSBZc8tk=;
 b=g41GqAogsc29mLkM+uU6lZSmCVnPF97u8idsrXxM3aIgjK7l6BY6zgDd+1ClbVZwe6
 Mt2mP0WCELRxbcM/BE9N+C+yPm+YxJRiqAfHFUuqMyXVaPxdWwIdtv5Faah10QnGVQ6i
 hNg1me8VhwGLBNOeDJjACCQy2gfQmPsfmnsU1UKMWh8XiEEFr1UWlgKrFRiROW/x8ND2
 Udgk4L4xstK0nZGrFF7M2z9WhDlY3dQy3nmIUGGbNGTg13dL8NSYrbnhe9YUgBhIfNW6
 lUZzQNTVcggPAeGzhPmzRy0ex/hP3iBC4Xn6ItCeFwqGgasvb/gC27s/F8GDeX/8yIUA
 G8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031747; x=1746636547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNItTYCqljpWXCYmXErceMTzMhdQ1ZlNvx1ZSBZc8tk=;
 b=Sv/tMz6upQ0Rycy/tAkTEq6vSgodlYtrEfuHijnU/G4NNn4fT6NIXVCbwZrvJY9RDh
 kwP3ylmvsOs7KayzqBmuNzi+WpTFaEAxSQkkppjhmz4W6DO4OEvUEuUaLzrnbQ73xYOQ
 7GP0ktofx4wTLuFwLuJj76sMETxecz2WYqOLPf+HfAIm/bgS9SsROeumcKZO8i/HftdE
 ntyL3jcIsVKwPfkB9I4wLQbJsxYrnh1FpfjpZ9l9D2oz8IMrk1aTebT0soVRjG7ABQeh
 MbRpyXoQHpiCkV8ITv35RzzBCq6ySzWdf+N7Xf5yibQW0uEE5d2VwtkanWFFeLIfE12s
 QmdQ==
X-Gm-Message-State: AOJu0YwcfxawqCvwm+1ypzHiccurxC3EyAedWuQLZfxL9kiiX216U4V3
 djOl5eoSXXnDvuXIxAL0UET7JEnJ/PQl9Dd0x2dinn+FSMYOpLlpfTTDQoveH3h+PnuvX1d8lsS
 m
X-Gm-Gg: ASbGncsngCpOW8IewSNvPlVKfY/FOBolE4jpFz3/WJb8MFpZwxUiHyOJ0umhrNoRrpB
 FAhRXg5W0Mqr1Q0uqTL+6Spi3PiY1V4ilWEOlazg8s9EmVr5roRqlF4AT9Eiq3D0GlfIiMWXjH1
 2O59+emp2rDY4UCrC9lLdQsthx0mj3y78HvDWkm/SGPOI/b1eij7JLgj7SCNf4j+RxbT0z3XEMl
 Bqzd//DjD/cllN1ajTp0tYOpUUNUtAdSvocH/CbdBwO3JTm1pfwE7SpMSRfEiOewq+7CeIzWgCc
 SsttimMeAYhmqH+m8cUiz8BCtH6Hkj/XAjNhK/ECeMbKLRkgE37t5hWTELB7YoCnkIxREVEEDAc
 =
X-Google-Smtp-Source: AGHT+IEZUb64eDJnTtOSb4gVDYBTxU/1+2ahoDFAxTIV1MMqSExpd5h5asji5aQsou6V7+mZ5GhxCQ==
X-Received: by 2002:a05:6a20:9f4e:b0:1f5:7eb5:72dc with SMTP id
 adf61e73a8af0-20aa26d41ccmr5129356637.3.1746031746767; 
 Wed, 30 Apr 2025 09:49:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 14/16] accel/tcg: Pass TCGTBCPUState to tb_gen_code
Date: Wed, 30 Apr 2025 09:48:52 -0700
Message-ID: <20250430164854.2233995-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


