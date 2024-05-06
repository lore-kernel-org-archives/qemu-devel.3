Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74326C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcN-0001zG-Mw; Mon, 06 May 2024 08:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xc0-0001QX-AV
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbx-00021E-I8
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34c1fff534fso1594354f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999107; x=1715603907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6uicuNXM1zCeQNR1mjKMJ1odcYWti2ZKucvzgTpxJI=;
 b=aVVKqajLl6nPm7PthXunvITGSpQ9FcoHGHoH4Fq5B16xorYmaT2asspFujQfZj+dBF
 D5UC5GRxF5TXlGIHQwipNWVaKit6E+QKeND2b9KwDMmVrGCf1tfgXd1VswFtizvEiG8w
 oMAdKDvfRlxvoPmWq8UvsOgIUM2nQjcwH+2Gx02yc9vlCHxuaIj4P5Ubwml3a4G2gOmw
 KekDRQ+MkfQ3VwbGQ8rxi3OLtYL9gxbRnh9hSl5omvav1F+iBZWwXjGJsPp/osWwfKyR
 /yZVhRcjjUP7q0wiYaBMzHeoUZmLmR8oCzhex0xdRcwomWpIOhTc0WerJ6oj94HrXSWk
 8a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999107; x=1715603907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6uicuNXM1zCeQNR1mjKMJ1odcYWti2ZKucvzgTpxJI=;
 b=EYk5QsYu+/wJjAJt3Br3s82FYuwosOgRMt3Qvksy6yTZZth+eTS+b64oo0v8uWHZpM
 5ad+bvSIsA3ZzZ6anotMgcP/JGwYcAxlIsRwRW54HiIBllCQN3YlnfwKT80cy2GBAzzs
 t0NdrguMB8q28dENhxuDp7jZf8upH5Th5YFC/hrlfwFkzJsR1Y4FCi6oknWHfs0Tg2c3
 +1s1yOQ56NrBwH5DkM4iYlbGZ2BR7mxdPaw2shhdNKTJJGGIrUDJ8+flRw7pBFFxaZY/
 /YUjEkTJn6SUwZyD3gP7nC1rkap6RcWHjOZ/d2UabbZ4APMPKKu6+HawBq0XgCxupJ2E
 fMxA==
X-Gm-Message-State: AOJu0Ywdy7AbRVxlpx3RBRnYlHqfYMbUvyh7Z/7T6bZ5ddYgSfYuXpwU
 CBXWelRiEh429BI8yst6AXmlcUmRyOz2vqtRfo0aqhljpLMF/XouOoHftJpoVN9dNQgvZIlNAUm
 0
X-Google-Smtp-Source: AGHT+IHl/vdL+5d1AUwvnM2UZNwommvHKqAEU5D1ADGGXWpvie972SJ/IijW2FDCeOwDFcABHYnD6Q==
X-Received: by 2002:a05:6000:1145:b0:347:9bec:9ba3 with SMTP id
 d5-20020a056000114500b003479bec9ba3mr6899527wrx.66.1714999107465; 
 Mon, 06 May 2024 05:38:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfed07000000b0034d839bed92sm10581414wro.64.2024.05.06.05.38.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/28] accel/tcg: Access tcg_cflags with getter / setter
Date: Mon,  6 May 2024 14:37:07 +0200
Message-ID: <20240506123728.65278-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Access the CPUState::tcg_cflags via tcg_cflags_has() and
tcg_cflags_set() helpers.

Mechanical change using the following Coccinelle spatch script:

  @@
  expression cpu;
  expression flags;
  @@
  -     cpu->tcg_cflags & flags
  +     tcg_cflags_has(cpu, flags)

  @@
  expression cpu;
  expression flags;
  @@
  -     (tcg_cflags_has(cpu, flags))
  +     tcg_cflags_has(cpu, flags)

  @@
  expression cpu;
  expression flags;
  @@
  -     cpu->tcg_cflags |= flags;
  +     tcg_cflags_set(cpu, flags);

Then manually moving the declarations, and adding both
tcg_cflags_has() and tcg_cflags_set() definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-15-philmd@linaro.org>
---
 accel/tcg/internal-common.h             |  3 ++-
 include/exec/cpu-common.h               |  7 +++++++
 include/exec/exec-all.h                 |  3 ---
 accel/tcg/cpu-exec.c                    | 10 ++++++++++
 accel/tcg/tcg-accel-ops.c               |  2 +-
 linux-user/mmap.c                       |  8 ++++----
 linux-user/syscall.c                    |  4 ++--
 target/arm/cpu.c                        |  2 +-
 target/avr/cpu.c                        |  2 +-
 target/hexagon/cpu.c                    |  2 +-
 target/hppa/cpu.c                       |  2 +-
 target/i386/cpu.c                       |  2 +-
 target/i386/helper.c                    |  2 +-
 target/loongarch/cpu.c                  |  2 +-
 target/microblaze/cpu.c                 |  2 +-
 target/mips/tcg/exception.c             |  2 +-
 target/mips/tcg/sysemu/special_helper.c |  2 +-
 target/openrisc/cpu.c                   |  2 +-
 target/riscv/tcg/tcg-cpu.c              |  4 ++--
 target/rx/cpu.c                         |  2 +-
 target/sh4/cpu.c                        |  4 ++--
 target/sparc/cpu.c                      |  2 +-
 target/tricore/cpu.c                    |  2 +-
 23 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index edefd0dcb7..ead53cb8a5 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -9,6 +9,7 @@
 #ifndef ACCEL_TCG_INTERNAL_COMMON_H
 #define ACCEL_TCG_INTERNAL_COMMON_H
 
+#include "exec/cpu-common.h"
 #include "exec/translation-block.h"
 
 extern int64_t max_delay;
@@ -20,7 +21,7 @@ extern int64_t max_advance;
  */
 static inline bool cpu_in_serial_context(CPUState *cs)
 {
-    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
+    return !tcg_cflags_has(cs, CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 78f2c381b1..8bc397e251 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -178,6 +178,13 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 void list_cpus(void);
 
 #ifdef CONFIG_TCG
+
+bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
+void tcg_cflags_set(CPUState *cpu, uint32_t flags);
+
+/* current cflags for hashing/comparison */
+uint32_t curr_cflags(CPUState *cpu);
+
 /**
  * cpu_unwind_state_data:
  * @cpu: the cpu context
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4c5e470581..2cd7b8f61b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -510,9 +510,6 @@ static inline void tb_set_page_addr1(TranslationBlock *tb,
 #endif
 }
 
-/* current cflags for hashing/comparison */
-uint32_t curr_cflags(CPUState *cpu);
-
 /* TranslationBlock invalidate API */
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c18a7e2b85..9af66bc191 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -147,6 +147,16 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 }
 #endif /* CONFIG USER ONLY */
 
+bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
+{
+    return cpu->tcg_cflags & flags;
+}
+
+void tcg_cflags_set(CPUState *cpu, uint32_t flags)
+{
+    cpu->tcg_cflags |= flags;
+}
+
 uint32_t curr_cflags(CPUState *cpu)
 {
     uint32_t cflags = cpu->tcg_cflags;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 2c7b0cc09e..1433e38f40 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -62,7 +62,7 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
 
     cflags |= parallel ? CF_PARALLEL : 0;
     cflags |= icount_enabled() ? CF_USE_ICOUNT : 0;
-    cpu->tcg_cflags |= cflags;
+    tcg_cflags_set(cpu, cflags);
 }
 
 void tcg_cpu_destroy(CPUState *cpu)
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 72b30279a2..4d09a72fad 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -960,8 +960,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      */
     if (ret != -1 && (flags & MAP_TYPE) != MAP_PRIVATE) {
         CPUState *cpu = thread_cpu;
-        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-            cpu->tcg_cflags |= CF_PARALLEL;
+        if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
+            tcg_cflags_set(cpu, CF_PARALLEL);
             tb_flush(cpu);
         }
     }
@@ -1400,8 +1400,8 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
      * supported by the host -- anything that requires EXCP_ATOMIC will not
      * be atomic with respect to an external process.
      */
-    if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-        cpu->tcg_cflags |= CF_PARALLEL;
+    if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
+        tcg_cflags_set(cpu, CF_PARALLEL);
         tb_flush(cpu);
     }
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6a492c9d35..1b42e80f9a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6583,8 +6583,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
          * generate code for parallel execution and flush old translations.
          * Do this now so that the copy gets CF_PARALLEL too.
          */
-        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-            cpu->tcg_cflags |= CF_PARALLEL;
+        if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
+            tcg_cflags_set(cpu, CF_PARALLEL);
             tb_flush(cpu);
         }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index fdc3eda318..77f8c9c748 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1941,7 +1941,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
-    cs->tcg_cflags |= CF_PCREL;
+    tcg_cflags_set(cs, CF_PCREL);
 #endif
 
     /* If we needed to query the host kernel for the CPU features
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 71ce62a4c2..f53e1192b1 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -55,7 +55,7 @@ static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
 static void avr_cpu_synchronize_from_tb(CPUState *cs,
                                         const TranslationBlock *tb)
 {
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu_env(cs)->pc_w = tb->pc / 2; /* internally PC points to words */
 }
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a56bb4b075..64cc05cca7 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -257,7 +257,7 @@ static vaddr hexagon_cpu_get_pc(CPUState *cs)
 static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
 }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 3831cb6db2..393a81988d 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -48,7 +48,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
 
 #ifdef CONFIG_USER_ONLY
     cpu->env.iaoq_f = tb->pc;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aa3b2d8391..25c0702ca1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7371,7 +7371,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
-    cs->tcg_cflags |= CF_PCREL;
+    tcg_cflags_set(cs, CF_PCREL);
 #endif
 
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 23ccb23a5b..48d1513a35 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -523,7 +523,7 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
     }
 
     /* Per x86_restore_state_to_opc. */
-    if (cs->tcg_cflags & CF_PCREL) {
+    if (tcg_cflags_has(cs, CF_PCREL)) {
         return (env->eip & TARGET_PAGE_MASK) | data[0];
     } else {
         return data[0] - env->segs[R_CS].base;
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 1ebba043f4..96da1a685e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -336,7 +336,7 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
                                               const TranslationBlock *tb)
 {
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     set_pc(cpu_env(cs), tb->pc);
 }
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9eb7374ccd..41ad47d04c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -99,7 +99,7 @@ static void mb_cpu_synchronize_from_tb(CPUState *cs,
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu->env.pc = tb->pc;
     cpu->env.iflags = tb->flags & IFLAGS_TB_MASK;
 }
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 13275d1ded..4886d087b2 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -81,7 +81,7 @@ void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb)
 {
     CPUMIPSState *env = cpu_env(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     env->active_tc.PC = tb->pc;
     env->hflags &= ~MIPS_HFLAG_BMASK;
     env->hflags |= tb->flags & MIPS_HFLAG_BMASK;
diff --git a/target/mips/tcg/sysemu/special_helper.c b/target/mips/tcg/sysemu/special_helper.c
index 5baa25348e..9ce5e2ceac 100644
--- a/target/mips/tcg/sysemu/special_helper.c
+++ b/target/mips/tcg/sysemu/special_helper.c
@@ -93,7 +93,7 @@ bool mips_io_recompile_replay_branch(CPUState *cs, const TranslationBlock *tb)
     CPUMIPSState *env = cpu_env(cs);
 
     if ((env->hflags & MIPS_HFLAG_BMASK) != 0
-        && !(cs->tcg_cflags & CF_PCREL) && env->active_tc.PC != tb->pc) {
+        && !tcg_cflags_has(cs, CF_PCREL) && env->active_tc.PC != tb->pc) {
         env->active_tc.PC -= (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
         env->hflags &= ~MIPS_HFLAG_BMASK;
         return true;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index d711035cf5..fdaaa09fc8 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -45,7 +45,7 @@ static void openrisc_cpu_synchronize_from_tb(CPUState *cs,
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu->env.pc = tb->pc;
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b5b95e052d..40054a391a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -96,7 +96,7 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs,
         CPURISCVState *env = &cpu->env;
         RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
 
-        tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+        tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
 
         if (xl == MXL_RV32) {
             env->pc = (int32_t) tb->pc;
@@ -890,7 +890,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
-    CPU(cs)->tcg_cflags |= CF_PCREL;
+    tcg_cflags_set(CPU(cs), CF_PCREL);
 
     if (cpu->cfg.ext_sstc) {
         riscv_timer_init(cpu);
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c1a592e893..8a584f0a11 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -46,7 +46,7 @@ static void rx_cpu_synchronize_from_tb(CPUState *cs,
 {
     RXCPU *cpu = RX_CPU(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu->env.pc = tb->pc;
 }
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 43e35ec2ca..618aa7154e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -47,7 +47,7 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs,
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu->env.pc = tb->pc;
     cpu->env.flags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
 }
@@ -74,7 +74,7 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
     CPUSH4State *env = cpu_env(cs);
 
     if ((env->flags & (TB_FLAG_DELAY_SLOT | TB_FLAG_DELAY_SLOT_COND))
-        && !(cs->tcg_cflags & CF_PCREL) && env->pc != tb->pc) {
+        && !tcg_cflags_has(cs, CF_PCREL) && env->pc != tb->pc) {
         env->pc -= 2;
         env->flags &= ~(TB_FLAG_DELAY_SLOT | TB_FLAG_DELAY_SLOT_COND);
         return true;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 485d416925..685485c654 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -702,7 +702,7 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu->env.pc = tb->pc;
     cpu->env.npc = tb->cs_base;
 }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 8f9b72c3a0..bdefb84511 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -47,7 +47,7 @@ static vaddr tricore_cpu_get_pc(CPUState *cs)
 static void tricore_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+    tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
     cpu_env(cs)->PC = tb->pc;
 }
 
-- 
2.41.0


