Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF32EC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcl-00063m-Da; Wed, 30 Apr 2025 12:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcP-00059v-F5
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcL-0001v2-EL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1239579b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031744; x=1746636544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNT5Z/b9p+1dr/iEIvcApv/bdjCSakHasHj7w3R0SoY=;
 b=wghYmN4MXUvO0Z7hLSGtyw9oDKSAhO/Kr3jPaPKH9SuXoNpNsiLOM46u5LXSgv4Qr6
 v8QAvHsYjS2A/rPd5OWOhT2m5vaL8AoWOIyiDQGy9TbTsaY5Y/M/SD7Pt+cK2kOZiTRl
 xhtjp0CmmVY5GeoP80HUwxpWYulYV4uOMpJ9LQF101lrNydQg4adjQciZmVGC7+d2Cpv
 ElCO68pMgCDhjo0bDeO7/MPIZ5TFsSjAufHluac7uaRdiyUNctkBGs342WBvKwBG/dd0
 2BLLEZgnhp0QxmSX1rypRxWAqKjlH3v4DJsBvT3BkOC+ODEV52uAYd0MVZ4yh4bFbB/6
 akpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031744; x=1746636544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNT5Z/b9p+1dr/iEIvcApv/bdjCSakHasHj7w3R0SoY=;
 b=oeqnTAOycb5/SPcu0iHGVUnsjajgDNIa8jfD/m/AHFXuQGzCUzCWOctJOzjR9/ceMS
 wvT3JP8J2sahQnc/AZF9WfS0AZjVs5JMAW0fbUIQNsAkcLdQ8DTjrI6JY4QwvmDl2Nnq
 9zby/Fc72iiEwIhr7H3fmusdGJS03e87K4AnmU9wuVwedgjBIWcogt03H8ObWtfmQTMz
 yzxqGPUWSctNmoM7gpnBX9wUlf1M4jGbBNT95k0meQbhs1UUP1tHea+UeXTJ4z3GZsJm
 dNhDrEn94bT2pHBud1GyM8hahKHYcUsvS2ZVBwXeibK7s9bk7/W/nfKZA+RAkG7nF20U
 IW3g==
X-Gm-Message-State: AOJu0Yzn6T5YF0HX9n6UrwxGVN6wVCTDN5Wk9TxHm2HoPn38LAyxKaVn
 5FxLO9+hiuqa/Iy0J3TIFO9+VSpXX80AXTH8+CgPEHboNXJy9e2ls51EjYne+h4fPKwTuNP9uA4
 G
X-Gm-Gg: ASbGnct0muAQfnnmVhML6ykkVJ7XkDQWUjAVSpYfx+rsk4OEdp2MRJDrk3qFlLspEnp
 zQuqicmni0lpoWLfsRIQOyF5wa+sLRLcYOXBpPMLbS+qtdV3XrX0EeEV6E/5IR4U29v9AzzD8We
 gD7HtTl8Yq8SVHoIbzmO8NES8xRDWWchvyv//3YO3vNO0dYGiFjuy3MquJF/B4mm2Svx/efx3V9
 q3Z86mlvbt8EyNazPoCcijSP9u3fxuYe0YYHZQ5V1a4amAgmT2xZExjS7kQ29kQzuZJ13a1J47W
 wgQ+dNMXFQUpdsvbQU93Ks0GPGf/SFAxGIPy9yw/CXo+sRMAwciV53RifFR8DhE3dy8JoSK0JvU
 =
X-Google-Smtp-Source: AGHT+IE+z6N/lxgoRkH/VUvS6bhOTpXTY7IoKHdcCYUSggxAGdvB5dI7fZg+SgR7WHOKY4WbUn3iKA==
X-Received: by 2002:a05:6a00:3a07:b0:736:b400:b58f with SMTP id
 d2e1a72fcca58-74045fbdb07mr341339b3a.0.1746031744002; 
 Wed, 30 Apr 2025 09:49:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 10/16] accel/tcg: Move cpu_get_tb_cpu_state to TCGCPUOps
Date: Wed, 30 Apr 2025 09:48:48 -0700
Message-ID: <20250430164854.2233995-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Move the global function name to a hook on TCGCPUOps.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 8 ++++++--
 target/arm/internals.h      | 2 ++
 target/ppc/internal.h       | 3 +++
 accel/tcg/cpu-exec.c        | 7 ++++---
 accel/tcg/translate-all.c   | 2 +-
 target/alpha/cpu.c          | 3 ++-
 target/arm/cpu.c            | 1 +
 target/arm/tcg/cpu-v7m.c    | 1 +
 target/arm/tcg/hflags.c     | 2 +-
 target/avr/cpu.c            | 3 ++-
 target/hexagon/cpu.c        | 3 ++-
 target/hppa/cpu.c           | 3 ++-
 target/i386/tcg/tcg-cpu.c   | 3 ++-
 target/loongarch/cpu.c      | 3 ++-
 target/m68k/cpu.c           | 3 ++-
 target/microblaze/cpu.c     | 3 ++-
 target/mips/cpu.c           | 3 ++-
 target/openrisc/cpu.c       | 3 ++-
 target/ppc/cpu_init.c       | 2 +-
 target/ppc/helper_regs.c    | 3 ++-
 target/riscv/tcg/tcg-cpu.c  | 3 ++-
 target/rx/cpu.c             | 3 ++-
 target/s390x/cpu.c          | 3 ++-
 target/sh4/cpu.c            | 3 ++-
 target/sparc/cpu.c          | 3 ++-
 target/tricore/cpu.c        | 3 ++-
 target/xtensa/cpu.c         | 3 ++-
 27 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 43a39c2e13..23cd6af0b2 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -19,8 +19,6 @@
 #include "accel/tcg/tb-cpu-state.h"
 #include "tcg/tcg-mo.h"
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs);
-
 struct TCGCPUOps {
     /**
      * mttcg_supported: multi-threaded TCG is supported
@@ -63,6 +61,12 @@ struct TCGCPUOps {
      */
     void (*translate_code)(CPUState *cpu, TranslationBlock *tb,
                            int *max_insns, vaddr pc, void *host_pc);
+    /**
+     * @get_tb_cpu_state: Extract CPU state for a TCG #TranslationBlock
+     *
+     * Fill in all data required to select or compile a TranslationBlock.
+     */
+    TCGTBCPUState (*get_tb_cpu_state)(CPUState *cs);
     /**
      * @synchronize_from_tb: Synchronize state from a TCG #TranslationBlock
      *
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 382a4d1015..660d3a88e0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -28,6 +28,7 @@
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
+#include "accel/tcg/tb-cpu-state.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "system/memory.h"
@@ -372,6 +373,7 @@ void arm_restore_state_to_opc(CPUState *cs,
                               const uint64_t *data);
 
 #ifdef CONFIG_TCG
+TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 
 /* Our implementation of TCGCPUOps::cpu_exec_halt */
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 9012d3809c..7723350227 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -21,6 +21,7 @@
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "exec/page-protection.h"
+#include "accel/tcg/tb-cpu-state.h"
 
 /* PM instructions */
 typedef enum {
@@ -308,4 +309,6 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
     return msk;
 }
 
+TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
+
 #endif /* PPC_INTERNAL_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f7e7e7949d..4a405d7b56 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -395,7 +395,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
      */
     cpu->neg.can_do_io = true;
 
-    TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+    TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
     s.cflags = curr_cflags(cpu);
 
     if (check_for_breakpoints(cpu, s.pc, &s.cflags)) {
@@ -567,7 +567,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         g_assert(!cpu->running);
         cpu->running = true;
 
-        TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+        TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
         s.cflags = curr_cflags(cpu);
 
         /* Execute in a serial context. */
@@ -935,7 +935,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb;
-            TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+            TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
             s.cflags = cpu->cflags_next_tb;
 
             /*
@@ -1052,6 +1052,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_reset);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
+        assert(tcg_ops->get_tb_cpu_state);
         assert(tcg_ops->mmu_index);
         tcg_ops->initialize();
         tcg_target_initialized = true;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f2766cedfc..97aadee52c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -590,7 +590,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
         /* The exception probably happened in a helper.  The CPU state should
            have been saved before calling it. Fetch the PC from there.  */
         CPUArchState *env = cpu_env(cpu);
-        TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+        TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
         tb_page_addr_t addr = get_page_addr_code(env, s.pc);
 
         if (addr != -1) {
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 90e3a2e748..890b84c032 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -41,7 +41,7 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState alpha_get_tb_cpu_state(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
     uint32_t flags = env->flags & ENV_FLAG_TB_MASK;
@@ -251,6 +251,7 @@ static const TCGCPUOps alpha_tcg_ops = {
 
     .initialize = alpha_translate_init,
     .translate_code = alpha_translate_code,
+    .get_tb_cpu_state = alpha_get_tb_cpu_state,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
     .mmu_index = alpha_cpu_mmu_index,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3dde70b04a..2020aec54a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2693,6 +2693,7 @@ static const TCGCPUOps arm_tcg_ops = {
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
+    .get_tb_cpu_state = arm_get_tb_cpu_state,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 5c8c374885..95b23d9b55 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -238,6 +238,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
+    .get_tb_cpu_state = arm_get_tb_cpu_state,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index b49381924b..fd407a7b28 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -545,7 +545,7 @@ static bool mve_no_pred(CPUARMState *env)
     return true;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs)
 {
     CPUARMState *env = cpu_env(cs);
     CPUARMTBFlags flags;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 683195b61d..250241541b 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -54,7 +54,7 @@ static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState avr_get_tb_cpu_state(CPUState *cs)
 {
     CPUAVRState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -241,6 +241,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .mttcg_supported = false,
     .initialize = avr_cpu_tcg_init,
     .translate_code = avr_cpu_translate_code,
+    .get_tb_cpu_state = avr_get_tb_cpu_state,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
     .mmu_index = avr_cpu_mmu_index,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a7f76dd089..a5a04173ab 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -255,7 +255,7 @@ static vaddr hexagon_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->gpr[HEX_REG_PC];
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
 {
     CPUHexagonState *env = cpu_env(cs);
     vaddr pc = env->gpr[HEX_REG_PC];
@@ -344,6 +344,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .mttcg_supported = false,
     .initialize = hexagon_translate_init,
     .translate_code = hexagon_translate_code,
+    .get_tb_cpu_state = hexagon_get_tb_cpu_state,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
     .mmu_index = hexagon_cpu_mmu_index,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 40cbc191bb..6465181543 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -51,7 +51,7 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
                          env->iaoq_f & -4);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState hppa_get_tb_cpu_state(CPUState *cs)
 {
     CPUHPPAState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -262,6 +262,7 @@ static const TCGCPUOps hppa_tcg_ops = {
 
     .initialize = hppa_translate_init,
     .translate_code = hppa_translate_code,
+    .get_tb_cpu_state = hppa_get_tb_cpu_state,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
     .mmu_index = hppa_cpu_mmu_index,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 3004fb3023..179dfdf064 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -48,7 +48,7 @@ static void x86_cpu_exec_exit(CPUState *cs)
     env->eflags = cpu_compute_eflags(env);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState x86_get_tb_cpu_state(CPUState *cs)
 {
     CPUX86State *env = cpu_env(cs);
     uint32_t flags, cs_base;
@@ -160,6 +160,7 @@ const TCGCPUOps x86_tcg_ops = {
     .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
+    .get_tb_cpu_state = x86_get_tb_cpu_state,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
     .mmu_index = x86_cpu_mmu_index,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 446cf43914..f7535d1be7 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -336,7 +336,7 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
     uint32_t flags;
@@ -882,6 +882,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 
     .initialize = loongarch_translate_init,
     .translate_code = loongarch_translate_code,
+    .get_tb_cpu_state = loongarch_get_tb_cpu_state,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
     .mmu_index = loongarch_cpu_mmu_index,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index b75ed6e887..c5196a612e 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -40,7 +40,7 @@ static vaddr m68k_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState m68k_get_tb_cpu_state(CPUState *cs)
 {
     CPUM68KState *env = cpu_env(cs);
     uint32_t flags;
@@ -613,6 +613,7 @@ static const TCGCPUOps m68k_tcg_ops = {
 
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
+    .get_tb_cpu_state = m68k_get_tb_cpu_state,
     .restore_state_to_opc = m68k_restore_state_to_opc,
     .mmu_index = m68k_cpu_mmu_index,
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 72a0d0583c..d069e40e70 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -95,7 +95,7 @@ static vaddr mb_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState mb_get_tb_cpu_state(CPUState *cs)
 {
     CPUMBState *env = cpu_env(cs);
 
@@ -442,6 +442,7 @@ static const TCGCPUOps mb_tcg_ops = {
 
     .initialize = mb_tcg_init,
     .translate_code = mb_translate_code,
+    .get_tb_cpu_state = mb_get_tb_cpu_state,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
     .mmu_index = mb_cpu_mmu_index,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b0f7612a64..4cbfb9435a 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -549,7 +549,7 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
     return mips_env_mmu_index(cpu_env(cs));
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
 
@@ -566,6 +566,7 @@ static const TCGCPUOps mips_tcg_ops = {
 
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
+    .get_tb_cpu_state = mips_get_tb_cpu_state,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
     .mmu_index = mips_cpu_mmu_index,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index aba4639bbb..054ad33360 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -41,7 +41,7 @@ static vaddr openrisc_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState openrisc_get_tb_cpu_state(CPUState *cs)
 {
     CPUOpenRISCState *env = cpu_env(cs);
 
@@ -258,6 +258,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
 
     .initialize = openrisc_translate_init,
     .translate_code = openrisc_translate_code,
+    .get_tb_cpu_state = openrisc_get_tb_cpu_state,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
     .mmu_index = openrisc_cpu_mmu_index,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3a01731402..cf88a18244 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -45,7 +45,6 @@
 #include "internal.h"
 #include "spr_common.h"
 #include "power8-pmu.h"
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
@@ -7483,6 +7482,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .guest_default_memory_order = 0,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
+  .get_tb_cpu_state = ppc_get_tb_cpu_state,
   .restore_state_to_opc = ppc_restore_state_to_opc,
   .mmu_index = ppc_cpu_mmu_index,
 
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index ccaf2b0343..7e5726871e 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -28,6 +28,7 @@
 #include "cpu-models.h"
 #include "spr_common.h"
 #include "accel/tcg/cpu-ops.h"
+#include "internal.h"
 
 /* Swap temporary saved registers with GPRs */
 void hreg_swap_gpr_tgpr(CPUPPCState *env)
@@ -256,7 +257,7 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
     env->hflags |= hreg_compute_pmu_hflags_value(env);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
 {
     CPUPPCState *env = cpu_env(cs);
     uint32_t hflags_current = env->hflags;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 927153377e..55e00972b7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -98,7 +98,7 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
     return riscv_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 {
     CPURISCVState *env = cpu_env(cs);
     RISCVCPU *cpu = env_archcpu(env);
@@ -243,6 +243,7 @@ const TCGCPUOps riscv_tcg_ops = {
 
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
+    .get_tb_cpu_state = riscv_get_tb_cpu_state,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
     .mmu_index = riscv_cpu_mmu_index,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index be778c9f65..36eba75545 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -44,7 +44,7 @@ static vaddr rx_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState rx_get_tb_cpu_state(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -220,6 +220,7 @@ static const TCGCPUOps rx_tcg_ops = {
 
     .initialize = rx_translate_init,
     .translate_code = rx_translate_code,
+    .get_tb_cpu_state = rx_get_tb_cpu_state,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
     .mmu_index = rx_cpu_mmu_index,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 279289f265..9c1158ebcc 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,7 +309,7 @@ static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
     return s390x_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState s390x_get_tb_cpu_state(CPUState *cs)
 {
     CPUS390XState *env = cpu_env(cs);
     uint32_t flags;
@@ -358,6 +358,7 @@ static const TCGCPUOps s390_tcg_ops = {
 
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
+    .get_tb_cpu_state = s390x_get_tb_cpu_state,
     .restore_state_to_opc = s390x_restore_state_to_opc,
     .mmu_index = s390x_cpu_mmu_index,
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index cbd43b55e5..b35f18e250 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -43,7 +43,7 @@ static vaddr superh_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState superh_get_tb_cpu_state(CPUState *cs)
 {
     CPUSH4State *env = cpu_env(cs);
     uint32_t flags;
@@ -289,6 +289,7 @@ static const TCGCPUOps superh_tcg_ops = {
 
     .initialize = sh4_translate_init,
     .translate_code = sh4_translate_code,
+    .get_tb_cpu_state = superh_get_tb_cpu_state,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
     .mmu_index = sh4_cpu_mmu_index,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 6166b81f71..2a3e408923 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -716,7 +716,7 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.npc = tb->cs_base;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState sparc_get_tb_cpu_state(CPUState *cs)
 {
     CPUSPARCState *env = cpu_env(cs);
     uint32_t flags = cpu_mmu_index(cs, false);
@@ -1029,6 +1029,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 
     .initialize = sparc_tcg_init,
     .translate_code = sparc_translate_code,
+    .get_tb_cpu_state = sparc_get_tb_cpu_state,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
     .mmu_index = sparc_cpu_mmu_index,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 1151a812b6..e56f90fde9 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -45,7 +45,7 @@ static vaddr tricore_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->PC;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState tricore_get_tb_cpu_state(CPUState *cs)
 {
     CPUTriCoreState *env = cpu_env(cs);
 
@@ -185,6 +185,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .mttcg_supported = false,
     .initialize = tricore_tcg_init,
     .translate_code = tricore_translate_code,
+    .get_tb_cpu_state = tricore_get_tb_cpu_state,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .mmu_index = tricore_cpu_mmu_index,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 431b7ebd7b..91b71b6caa 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -55,7 +55,7 @@ static vaddr xtensa_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -312,6 +312,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .initialize = xtensa_translate_init,
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
+    .get_tb_cpu_state = xtensa_get_tb_cpu_state,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
     .mmu_index = xtensa_cpu_mmu_index,
 
-- 
2.43.0


