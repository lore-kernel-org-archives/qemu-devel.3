Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F44C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLc-0000q8-Sq; Thu, 01 May 2025 17:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLQ-0000lM-Eu
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:26 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLN-0001Re-Uz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:23 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3085f827538so1909227a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134480; x=1746739280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2E1hfpliYVCoOknCNn0LcMZgg8JjxDs88h3i9lSDC4=;
 b=QFAYL8+duN8OCY+JgscbGSZKK8r0O4Fn+oo857aTkZUW6ydwymZDCuGVF2gRspOcyg
 iLO2+ls+uJmyOISjFUFqnBPm7Ok3Rlpa9CCm3chau9x+Vnn2QwORcU78hQPvKW+4/ZuD
 j2V43+RHUCHijU/CZJDKy0ALnPPafHfBjD957KQrZnHcyuYtBPJJEStkrfibIskQfaAZ
 /51nrVkuiTxDt9C6l0XvmhRmwuaZgu98Psad9cUFDwn/BWD+1ACEOHryDG+zJgwu4QIY
 jLej56X6EwgJ7HSGeP3f98hG1SgndHokT1plXXo6ecAdUnyV8//4eSupnY/uhiVgVdMe
 XZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134480; x=1746739280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2E1hfpliYVCoOknCNn0LcMZgg8JjxDs88h3i9lSDC4=;
 b=abpvWCzrWkzZOYxxZbMMg8/AXxkEA5PqRPbt7ZYzioN6ZEBEBo2OloUtNUNBOeMyNt
 gptTsSpCpAaj/oMa0O98oh5FAYkxEnJFjNU3HZeFhZDrUnqN2xRjwfzotONBg6BrA1ax
 NaJQx8ZmG7a2P94U3ppZFG0x8H4naVZRMJYuog0SKJrqHNbTz+bYay+zVi/C9LEYJ7AW
 rhHZPNFh3dPSnPthqhINu2larq9aoL9TN/Y/Vnhg/Meoq8yvBH2b33YHKmJ7zJL8ZIHy
 Tkw/sdGByAZ+Fw/O/qzJ3mKUTiY+TkOFeLdGTR0YzYfqN6S6k2bwLupx3f+89VY2pHnz
 K8GA==
X-Gm-Message-State: AOJu0YxUarkr2tJh4WCHmhVOgmQZ2SPbBp2O7BuF79n8FHco0A8PaNi1
 8si1PU2lvGGi1Zg8XLlLrR0t11TY2uPyy8V6NE58igg5Kz91hY4jF2s/BfW0xXASZWhc9U1S8lp
 /
X-Gm-Gg: ASbGncswVIFHGHBoFHOuzn43KZbxngWN+/xv/kAiR6NKn+ufe/q7g39e5nENiJHpo2W
 qA4YoieZp88Hgxt7/+c4tB6QWLF6OKM/6nbstbshhcK0OoIVZtNqOg5rnvpZoXq4APXdwuOS8sA
 lrzd9wDqI8Jd1ihiBblIrv71hK75o/0DJ/E22Ur6zpvdlIRPMmb93bTDdTyknIa+eEF+g5jmSPd
 nb+DUkvAj9JEhu/Ys3Vnns/MUDaObtvmZMzziQib0Ih02g/ny1f8oi5ELOtzCTSdIGpjCSYzGPR
 Ng8DgX4qdUckbnkUwESoMR3Mb5WX1D79amzuyd700iJegdkphrt5PFWxzV34pI/tYuamTxVpucj
 hM6k9QfKLcQ==
X-Google-Smtp-Source: AGHT+IEsLXT8TaBR+a0XNgNezqBEbQtTCmmF1nDYnHzIQZYLFQoziEz8vp3wPGbG+KLEaGZnnZr7fw==
X-Received: by 2002:a17:90a:f944:b0:2ff:6aa6:47a3 with SMTP id
 98e67ed59e1d1-30a4e686b6amr843643a91.25.1746134480293; 
 Thu, 01 May 2025 14:21:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/59] accel/tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
Date: Thu,  1 May 2025 14:20:21 -0700
Message-ID: <20250501212113.2961531-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
have each target set the 'precise_smc' field in the TCGCPUOps
structure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  7 +++++++
 include/exec/poison.h       |  1 -
 target/i386/cpu.h           |  4 ----
 target/s390x/cpu.h          |  2 --
 accel/tcg/tb-maint.c        | 32 +++++++++++++-------------------
 accel/tcg/user-exec.c       | 10 +++++-----
 target/i386/tcg/tcg-cpu.c   |  1 +
 target/s390x/cpu.c          |  1 +
 8 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 0e4352513d..60b5e97205 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -28,6 +28,13 @@ struct TCGCPUOps {
      */
     bool mttcg_supported;
 
+    /**
+     * @precise_smc: Stores which modify code within the current TB force
+     *               the TB to exit; the next executed instruction will see
+     *               the result of the store.
+     */
+    bool precise_smc;
+
     /**
      * @guest_default_memory_order: default barrier that is required
      *                              for the guest memory ordering.
diff --git a/include/exec/poison.h b/include/exec/poison.h
index bc422719d8..a779adbb7a 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,7 +37,6 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
-#pragma GCC poison TARGET_HAS_PRECISE_SMC
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 54bf9639f1..3182ba413b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -35,10 +35,6 @@
 
 #define XEN_NR_VIRQS 24
 
-/* support for self modifying code even if the modified instruction is
-   close to the modifying instruction */
-#define TARGET_HAS_PRECISE_SMC
-
 #ifdef TARGET_X86_64
 #define I386_ELF_MACHINE  EM_X86_64
 #define ELF_MACHINE_UNAME "x86_64"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d9ca2506e2..530d97ccf1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -35,8 +35,6 @@
 
 #define ELF_MACHINE_UNAME "S390X"
 
-#define TARGET_HAS_PRECISE_SMC
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3837f2f633..1596767879 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -28,6 +28,7 @@
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
@@ -1042,9 +1043,7 @@ static void tb_invalidate_phys_page(tb_page_addr_t addr)
 /*
  * Called with mmap_lock held. If pc is not 0 then it indicates the
  * host PC of the faulting store instruction that caused this invalidate.
- * Returns true if the caller needs to abort execution of the current
- * TB (because it was modified by this store and the guest CPU has
- * precise-SMC semantics).
+ * Returns true if the caller needs to abort execution of the current TB.
  */
 bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
                                     uintptr_t pc)
@@ -1059,10 +1058,7 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
      * Without precise smc semantics, or when outside of a TB,
      * we can skip to invalidate.
      */
-#ifndef TARGET_HAS_PRECISE_SMC
-    pc = 0;
-#endif
-    if (!pc) {
+    if (!pc || !cpu || !cpu->cc->tcg_ops->precise_smc) {
         tb_invalidate_phys_page(addr);
         return false;
     }
@@ -1113,14 +1109,16 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
 {
     TranslationBlock *tb;
     PageForEachNext n;
-#ifdef TARGET_HAS_PRECISE_SMC
     bool current_tb_modified = false;
-    TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
-#endif /* TARGET_HAS_PRECISE_SMC */
+    TranslationBlock *current_tb = NULL;
 
     /* Range may not cross a page. */
     tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
 
+    if (retaddr && cpu && cpu->cc->tcg_ops->precise_smc) {
+        current_tb = tcg_tb_lookup(retaddr);
+    }
+
     /*
      * We remove all the TBs in the range [start, last].
      * XXX: see if in some cases it could be faster to invalidate all the code
@@ -1138,8 +1136,7 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
             tb_last = tb_start + (tb_last & ~TARGET_PAGE_MASK);
         }
         if (!(tb_last < start || tb_start > last)) {
-#ifdef TARGET_HAS_PRECISE_SMC
-            if (current_tb == tb &&
+            if (unlikely(current_tb == tb) &&
                 (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
                 /*
                  * If we are modifying the current TB, we must stop
@@ -1149,9 +1146,8 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
                  * restore the CPU state.
                  */
                 current_tb_modified = true;
-                cpu_restore_state_from_tb(current_cpu, current_tb, retaddr);
+                cpu_restore_state_from_tb(cpu, current_tb, retaddr);
             }
-#endif /* TARGET_HAS_PRECISE_SMC */
             tb_phys_invalidate__locked(tb);
         }
     }
@@ -1161,15 +1157,13 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
         tlb_unprotect_code(start);
     }
 
-#ifdef TARGET_HAS_PRECISE_SMC
-    if (current_tb_modified) {
+    if (unlikely(current_tb_modified)) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
-        current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
         mmap_unlock();
-        cpu_loop_exit_noexc(current_cpu);
+        cpu_loop_exit_noexc(cpu);
     }
-#endif
 }
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2b12c077e9..112292b729 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -733,12 +733,12 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
          * this thread raced with another one which got here first and
          * set the page to PAGE_WRITE and did the TB invalidate for us.
          */
-#ifdef TARGET_HAS_PRECISE_SMC
-        TranslationBlock *current_tb = tcg_tb_lookup(pc);
-        if (current_tb) {
-            current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
+        if (pc && cpu->cc->tcg_ops->precise_smc) {
+            TranslationBlock *current_tb = tcg_tb_lookup(pc);
+            if (current_tb) {
+                current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
+            }
         }
-#endif
     } else {
         int host_page_size = qemu_real_host_page_size();
         target_ulong start, len, i;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index e53aaa31bf..192812656c 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -126,6 +126,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 
 const TCGCPUOps x86_tcg_ops = {
     .mttcg_supported = true,
+    .precise_smc = true,
     /*
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3d644f5e23..99ff58affc 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -346,6 +346,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 
 static const TCGCPUOps s390_tcg_ops = {
     .mttcg_supported = true,
+    .precise_smc = true,
     /*
      * The z/Architecture has a strong memory model with some
      * store-after-load re-ordering.
-- 
2.43.0


