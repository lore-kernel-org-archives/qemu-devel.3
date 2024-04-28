Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBF9C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CpQ-0001Nn-F0; Sun, 28 Apr 2024 18:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cp0-0000ut-Jn
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:40 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Coy-0005hX-C2
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:34 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so4580040a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342590; x=1714947390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+FNp2PkYoVTOnMYxz45GqXiz7MbjGTG7zrwBtJ7b14=;
 b=STX+chonLN0LeaWIo5R0JnMxPUpyMfK3HyCt0+R5eYzHFv9JKTTTPo9cZNOsVtO/2b
 wlPD31jX+lwKANKB+bcTGK8IOJpKSq3ES2zI5tm3KBNCAtk2sxZu5WFL5rpCKTyyOF6Z
 C+gcraikrXobVM7WTlsnH7LRTc2UMaoJNCOc/Gmf+NTCYN0mCkyDxMEXlfktsD/0iNya
 gzwW8Ax/x2otf/GvLZ4WePh9kyLvz7m3z1jLqwY+TgA3+BAgNrA++6cYC9AfZLiDSGYl
 NkqDYdOyGcOa7T6KPHOt3p1b0sQMjEhFzthiH42tgmaeesckDcz/1nCCOjHsRD5LAJ29
 QYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342590; x=1714947390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+FNp2PkYoVTOnMYxz45GqXiz7MbjGTG7zrwBtJ7b14=;
 b=wXjkft3I+HHeQNzGufUHHxVxULgrF8rq0JUipbfHrNPghBu6GkSLHMDyVE/fclS8i/
 X1ltRkVjZtg45sZzrB47Lk2zDN0sbJOoMsqMexGevP2V3ixn6qq0Xo88S3Jh/iik3qjq
 HWJ9WfoobNILBFujsN6dyIRliLoCTHGI6Cq6phwt0yYcp28YaeFZb6K4ZMvz+DFOQ3a6
 Z4Su0e4ChA1O+WDp5ewucOk4V4wsEZTmJi1/qTV26mUjRbqeqNbwF99Z18S8/Uv1XN+d
 srOiff7p2w3aVo0nnR5iOQ2BLx74krqkIF7DHd7EHmNxFlqpKW9rBDJw0n+mdp5XR7qv
 RAJA==
X-Gm-Message-State: AOJu0Yzj16uGrL4yJYhO67h1oD/BwpU8XOGWz/L53y9+0M+Mr9+4TtXc
 lnKz2OgkFDD1XYCvsIM7CoF5FgY1URItG39951A6pYiFFxd+qFg02ZO+r9o318mUr5l9aCPh/lb
 q
X-Google-Smtp-Source: AGHT+IG0TuitVrfg85Dj8fmqyDX3M1axWNgdIZ6c0SYFxD8Uz0BCf8Tna2ca+2/DyZDXxGoXr6wjDg==
X-Received: by 2002:a50:8d42:0:b0:571:be3a:e904 with SMTP id
 t2-20020a508d42000000b00571be3ae904mr5563105edt.8.1714342590271; 
 Sun, 28 Apr 2024 15:16:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a056402271400b00572300f0768sm5331190edd.79.2024.04.28.15.16.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/24] accel/tcg: Move @cflags_next_tb from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:44 +0200
Message-ID: <20240428221450.26460-19-philmd@linaro.org>
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

@cflags_next_tb is specific to TCG accelerator, move it to
its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h    |  2 ++
 include/hw/core/cpu.h     |  1 -
 accel/tcg/cpu-exec.c      | 12 ++++++------
 accel/tcg/tb-maint.c      |  4 ++--
 accel/tcg/tcg-accel-ops.c |  1 +
 accel/tcg/translate-all.c |  2 +-
 accel/tcg/watchpoint.c    |  5 +++--
 hw/core/cpu-common.c      |  1 -
 8 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index d1f989c625..79e1490631 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -13,6 +13,8 @@
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  */
 struct AccelCPUState {
+    uint32_t cflags_next_tb;
+
     sigjmp_buf jmp_env;
 
 #ifdef CONFIG_USER_ONLY
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4df9bfeba9..a8b4ae25f1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -469,7 +469,6 @@ struct CPUState {
     bool crash_occurred;
     bool exit_request;
     int exclusive_context_count;
-    uint32_t cflags_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 46ad16f911..55235d3e5e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -720,7 +720,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         if (replay_has_exception()
             && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
-            cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
+            cpu->accel->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
         }
 #endif
@@ -783,7 +783,7 @@ static inline bool icount_exit_request(CPUState *cpu)
     if (!icount_enabled()) {
         return false;
     }
-    if (cpu->cflags_next_tb != -1 && !(cpu->cflags_next_tb & CF_USE_ICOUNT)) {
+    if (!(cpu->accel->cflags_next_tb == -1 || cpu->accel->cflags_next_tb & CF_USE_ICOUNT)) {
         return false;
     }
     return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
@@ -797,7 +797,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * skip checking here. Any pending interrupts will get picked up
      * by the next TB we execute under normal cflags.
      */
-    if (cpu->cflags_next_tb != -1 && cpu->cflags_next_tb & CF_NOIRQ) {
+    if (cpu->accel->cflags_next_tb != -1 && cpu->accel->cflags_next_tb & CF_NOIRQ) {
         return false;
     }
 
@@ -947,7 +947,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     if (insns_left > 0 && insns_left < tb->icount)  {
         assert(insns_left <= CF_COUNT_MASK);
         assert(cpu->icount_extra == 0);
-        cpu->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
+        cpu->accel->cflags_next_tb = (tb->cflags & ~CF_COUNT_MASK) | insns_left;
     }
 #endif
 }
@@ -979,11 +979,11 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
              * have CF_INVALID set, -1 is a convenient invalid value that
              * does not require tcg headers for cpu_common_reset.
              */
-            cflags = cpu->cflags_next_tb;
+            cflags = cpu->accel->cflags_next_tb;
             if (cflags == -1) {
                 cflags = curr_cflags(cpu);
             } else {
-                cpu->cflags_next_tb = -1;
+                cpu->accel->cflags_next_tb = -1;
             }
 
             if (check_for_breakpoints(cpu, pc, &cflags)) {
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 19ae6793f3..2d5faca9fd 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1084,7 +1084,7 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
         CPUState *cpu = current_cpu;
-        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         return true;
     }
     return false;
@@ -1154,7 +1154,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     if (current_tb_modified) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
-        current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        current_cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index dfa0357558..5429e2d219 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -90,6 +90,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
     cpu->neg.can_do_io = true;
     cpu->accel->mem_io_pc = 0;
+    cpu->accel->cflags_next_tb = -1;
 }
 
 /* mask must never be zero, except for A20 change call */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b67adce20e..3a8199a761 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -631,7 +631,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * operations only (which execute after completion) so we don't
      * double instrument the instruction.
      */
-    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
+    cpu->accel->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = cpu->cc->get_pc(cpu);
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index d3aab11458..0a40bfdc85 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -26,6 +26,7 @@
 #include "sysemu/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/vcpu-state.h"
 
 /*
  * Return true if this watchpoint address matches the specified
@@ -100,7 +101,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                  */
                 if (!cpu->neg.can_do_io) {
                     /* Force execution of one insn next time.  */
-                    cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+                    cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
                     cpu_loop_exit_restore(cpu, ra);
                 }
                 /*
@@ -132,7 +133,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 cpu_loop_exit(cpu);
             } else {
                 /* Force execution of one insn next time.  */
-                cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+                cpu->accel->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
                 mmap_unlock();
                 cpu_loop_exit_noexc(cpu);
             }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 21151f5634..684422991c 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -120,7 +120,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu->icount_extra = 0;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
-    cpu->cflags_next_tb = -1;
 
     cpu_exec_reset_hold(cpu);
 }
-- 
2.41.0


