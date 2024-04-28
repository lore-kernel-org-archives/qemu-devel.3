Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B54AC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CpZ-00024y-EK; Sun, 28 Apr 2024 18:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpC-00018E-8k
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cp9-0005k0-Rl
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:45 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-572229f196cso3881524a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342601; x=1714947401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Evb3eGbBZdxVTABj6hS8iE4A57Mw0jsMC3hyjWh5Exw=;
 b=vubWJ/k7ZEL9sjKMVKwAaB7XZjHjj8KGdwNigR3+3KTTZTA3bjaWElBlfPAwMm54Cl
 wXTKHg+RcogNC3YOHwlI3UIo8Kt/kmKAwOw/5EJI/tkeETkW9YxY6xO996/JcherWH+X
 GGMxwdx0Y1ScoMAZPK+xBtlCYLmKW11Wx+6WF/81V/dIlK94NHiydiNw2ybGlrE/PiWv
 2lNuWsIQayrZyQbdQmxVhH/RistpYa/YIhmR3iRhv2tzULSNdOs482uGcM215g6s7XSS
 GRBxXVY+FbAv2D2yeDLOXAXJ4LUAC7dycp74Ola04G8JcIPbCy+bPWSkZCJP8Cet42L7
 btyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342601; x=1714947401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Evb3eGbBZdxVTABj6hS8iE4A57Mw0jsMC3hyjWh5Exw=;
 b=NVbG/xfsDhekUuC9jGVWV/Z9wgRMhtWJ5IHIEz+EYHJ1U0bOv63RReS4u40ycqrNPA
 TXB2xVCEtjl9SkwGy3PDqipz5OhEt+xDzqbqEbg9PopeQShWDPTH2e3X8Weor3E2y2sQ
 v/ZatdGGJMi1U2xy1SjXNKZYDwWE90fww28Msxoz/o3bF/VcwRKLAmgbYkLqL0w4gQvx
 TT9+2ru6rEDsCtZBKvV118yBUL9u/A0wzEOH+6rCJV+RAcZfF9JTB1a9Rfto5fWVpbDn
 ztVfOnudxyzEcd3t10y2j3EwYFC+m8jBtmquUcqe5dLbL2d/IseUaRdZqkcbWHy7kjmb
 jcuA==
X-Gm-Message-State: AOJu0YywVloTqp8GRnwCqNQmhm10+LaraZs+VrV9Ts5kxG9Adtj8SYrC
 Qdap+4Ys+QfWgad5ryv+vBo8ZRsV6M9DQIsRdHCYJVbtZHXh5nBhJoUXs6kJwuoeS2MyPf0JkJx
 U
X-Google-Smtp-Source: AGHT+IH98fELUCy8Ey1S7rRdg9c2syyMhocgeRUlOcXumMbAc0jpo3TVgaSq3vIc61vBxWRSarRTjQ==
X-Received: by 2002:a50:9f43:0:b0:572:3fe4:18b5 with SMTP id
 b61-20020a509f43000000b005723fe418b5mr4572654edf.32.1714342601075; 
 Sun, 28 Apr 2024 15:16:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05640210d300b00572033ec969sm8495254edu.60.2024.04.28.15.16.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/24] accel/tcg: Move @tb_jmp_cache from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:46 +0200
Message-ID: <20240428221450.26460-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

@tb_jmp_cache is specific to TCG accelerator, move it to
its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-jmp-cache.h  | 4 ++--
 accel/tcg/vcpu-state.h    | 2 ++
 include/hw/core/cpu.h     | 2 --
 include/qemu/typedefs.h   | 1 -
 accel/tcg/cpu-exec.c      | 7 +++----
 accel/tcg/cputlb.c        | 2 +-
 accel/tcg/tb-maint.c      | 2 +-
 accel/tcg/translate-all.c | 5 +++--
 8 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index 184bb3e3e2..c3a505e394 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -22,12 +22,12 @@
  * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
  * CF_PCREL, but it's used always for simplicity.
  */
-struct CPUJumpCache {
+typedef struct CPUJumpCache {
     struct rcu_head rcu;
     struct {
         TranslationBlock *tb;
         vaddr pc;
     } array[TB_JMP_CACHE_SIZE];
-};
+} CPUJumpCache;
 
 #endif /* ACCEL_TCG_TB_JMP_CACHE_H */
diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 2d09dc3857..5b31c801d8 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -7,6 +7,7 @@
 #define ACCEL_TCG_VCPU_STATE_H
 
 #include "hw/core/cpu.h"
+#include "tb-jmp-cache.h"
 
 /**
  * AccelCPUState:
@@ -16,6 +17,7 @@ struct AccelCPUState {
     uint32_t cflags_next_tb;
 
     sigjmp_buf jmp_env;
+    CPUJumpCache tb_jmp_cache;
 
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9e192f739a..99709270fa 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -484,8 +484,6 @@ struct CPUState {
     AddressSpace *as;
     MemoryRegion *memory;
 
-    CPUJumpCache *tb_jmp_cache;
-
     GArray *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 36f2825725..daf9009332 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -44,7 +44,6 @@ typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUArchState CPUArchState;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CpuInfoFast CpuInfoFast;
-typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
 typedef struct DeviceListener DeviceListener;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 55235d3e5e..8f8e1fa948 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -261,7 +261,7 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
     tcg_debug_assert(!(cflags & CF_INVALID));
 
     hash = tb_jmp_cache_hash_func(pc);
-    jc = cpu->tb_jmp_cache;
+    jc = &cpu->accel->tb_jmp_cache;
 
     tb = qatomic_read(&jc->array[hash].tb);
     if (likely(tb &&
@@ -1004,7 +1004,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                  * for the fast lookup
                  */
                 h = tb_jmp_cache_hash_func(pc);
-                jc = cpu->tb_jmp_cache;
+                jc = &cpu->accel->tb_jmp_cache;
                 jc->array[h].pc = pc;
                 qatomic_set(&jc->array[h].tb, tb);
             }
@@ -1083,7 +1083,6 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         tcg_target_initialized = true;
     }
 
-    cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1101,5 +1100,5 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 #endif /* !CONFIG_USER_ONLY */
 
     tlb_destroy(cpu);
-    g_free_rcu(cpu->tb_jmp_cache, rcu);
+    g_free_rcu(&cpu->accel->tb_jmp_cache, rcu);
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e9d6faf78f..964dacaf44 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -156,7 +156,7 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
 
 static void tb_jmp_cache_clear_page(CPUState *cpu, vaddr page_addr)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
+    CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
     int i, i0;
 
     if (unlikely(!jc)) {
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 2d5faca9fd..83758648f2 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -888,7 +888,7 @@ static void tb_jmp_cache_inval_tb(TranslationBlock *tb)
         uint32_t h = tb_jmp_cache_hash_func(tb->pc);
 
         CPU_FOREACH(cpu) {
-            CPUJumpCache *jc = cpu->tb_jmp_cache;
+            CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
 
             if (qatomic_read(&jc->array[h].tb) == tb) {
                 qatomic_set(&jc->array[h].tb, NULL);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3a8199a761..ca1e193633 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -652,13 +652,14 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
  */
 void tcg_flush_jmp_cache(CPUState *cpu)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
+    CPUJumpCache *jc;
 
     /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(jc == NULL)) {
+    if (unlikely(cpu->accel == NULL)) {
         return;
     }
 
+    jc = &cpu->accel->tb_jmp_cache;
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
     }
-- 
2.41.0


