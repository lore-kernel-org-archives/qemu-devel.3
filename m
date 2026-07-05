Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AEFC44501
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEbs-0004k5-7r; Sun, 05 Jul 2026 00:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbn-0004h4-Rg
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbi-0003xo-KM
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:35 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ca7aaa4b85so15398205ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226249; x=1783831049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j6H+eudJOEIEy2ri47Xi63D0FORu25fkEtCnWjt4xbQ=;
 b=bEqxgmgmHXiaaTL/YPY6blFdBJXKxWiOzAJvgvmuq1tog44E/mqLvdr3Z4stw9HjHY
 41cru92Q8FW04t1yfrsHyGvwi+IA0MnR37Rrn3NzlDg5m1ll3QXZU8dheJZiXMQinsTT
 GxyCcnfc9AcJOj69G7qT+agSoFR025UgjsKAvzZoG0z6Vt1ix2QCwlple/64MUi43Hu3
 8CdxRSQ1ih62nCj+khm0Wr4IwTjWhONeW7MAIlyGwHh4ArQP+P/Ndrtszkrn0CUN72wX
 Dqf6vXZLv2K7U9qc0J9QOHEC1+OEepk4xO/GR+NOSmzflk5TCJt7YH9LQ7XkwwFI6jox
 15Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226249; x=1783831049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j6H+eudJOEIEy2ri47Xi63D0FORu25fkEtCnWjt4xbQ=;
 b=f1y7snqVCLFzft5IcL1HXhYVTPPRxTkOrCPiIAGQlvYA+Gbx5aDaLa+f7PnA0DAy2v
 3k1p8990b0aVeC7EJCQ5Af8cc1d+CffpdyN4QnkPNQFXqxrf1ffjVkgR8qUjhXFleE95
 vO/BecxOIzpzD/oXK57bGYb1QHDEo3cYcoYgMjPF37IJalUz2RuWzOIFMiBM8iCZNaI8
 Pv9UeNpm/e0KG5rwQkP8TyiWjMRUMwtWVLYqY61FdEwNLHyFQjQN4lTPanTGN5juVmqr
 VuZOKmXVTac4zjk1l029RHr10gwVDsFW4ey/LmImMdxhLVDaKRLgrbpLFm6uJ0a2khQg
 TTsg==
X-Gm-Message-State: AOJu0Yx2eJOFFJ5HV7j6i0oists9yKgpbO1N1+7/xOC+PLiu5Q+ftDLg
 OFIuVynk62LZmhjggDwX+7dDDIhYrlaSPmUCDnLGxCGGOyB3mcjU5arwkysTCiwEBy4ukXz4wPA
 gBbOj
X-Gm-Gg: AfdE7ckEOrYdrTPdXut3hdUsIGYO3NNF8qKgumM2rQbEm0EsIFgjlksiRDNBVxRg8Zy
 NDq9zLEeXsKfu2Zt5wU7Tk/NKoF8ZSf9i2D6tabqIGLXIJu+sFXUbGiyg/5Br5/W5tGGvgl8GHc
 KGNzkB4ZkooPL+G52wSroavvqSpwyU8dR5PekBUxXWjgkxy2gy7LnqDl51/Pm64fTULCMC7zU6n
 TmaPL0OFoYkHdsQw8UFnIJSb5QFdh9/kRk2Ck2qWCTIIn4KBmOmcodDGRr9uZDiBGKxsv8Q1XXE
 Nf4lYQRQt5dcwsc11pz/C+0nbYz2LUYijIurnlGMoZDzL5Wd64sAcdacq1zKl6+Zkqumlv3koXu
 MNhp9IzWGc+wetYElIM1cpNI+6j5tmdUFEG/F1jI1qW5/LKGIzQjPDTrq0c7qZe/vH8JHLA9N/t
 40LPanRcTJYFSvuO7gxfn4uC2jBzqw7f4zBA5AsaA7bOfhnMc=
X-Received: by 2002:a17:902:f551:b0:2ca:281:27fd with SMTP id
 d9443c01a7336-2cbb9ebcd0cmr50316435ad.25.1783226248798; 
 Sat, 04 Jul 2026 21:37:28 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 02/46] cpu: Define BreakpointFlags type
Date: Sat,  4 Jul 2026 21:36:41 -0700
Message-ID: <20260705043725.1373137-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Use the BreakpointFlags typedef to better follow when
we deal with breakpoint flags (BP_*).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Don't rename mask variables to flags]
Message-ID: <20260630220100.1289-19-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h |  6 ++++--
 include/exec/breakpoint.h   |  3 ++-
 include/exec/watchpoint.h   |  8 +++++---
 include/hw/core/cpu.h       |  9 +++++----
 accel/tcg/cputlb.c          | 12 +++++++-----
 accel/tcg/tcg-accel-ops.c   | 10 +++++-----
 accel/tcg/user-exec-stub.c  | 11 ++++++-----
 accel/tcg/watchpoint.c      |  9 +++++----
 cpu-common.c                |  6 +++---
 system/watchpoint.c         |  6 +++---
 target/arm/tcg/debug.c      |  4 ++--
 target/arm/tcg/mte_helper.c |  3 ++-
 target/ppc/cpu.c            |  2 +-
 target/ppc/kvm.c            |  5 +++--
 target/riscv/cpu_helper.c   |  2 +-
 target/riscv/debug.c        |  6 +++---
 target/s390x/tcg/debug.c    |  3 ++-
 target/xtensa/dbg_helper.c  |  2 +-
 18 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 710da12b82..f64d94b2b5 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -298,7 +298,8 @@ struct TCGCPUOps {
  * specified by @flags.  Exit via exception with a hit.
  */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs attrs, int flags, uintptr_t ra);
+                          MemTxAttrs attrs, BreakpointFlags flags,
+                          uintptr_t ra);
 
 /**
  * cpu_watchpoint_address_matches:
@@ -309,7 +310,8 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
  * Return the watchpoint flags that apply to [addr, addr+len).
  * If no watchpoint is registered for the range, the result is 0.
  */
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
+BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
+                                               vaddr addr, vaddr len);
 
 /*
  * Common pointer_wrap implementations.
diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index cc6fedd09f..0c3cc0c8ff 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -12,6 +12,7 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
+typedef int BreakpointFlags;
 /* Breakpoint/watchpoint flags */
 #define BP_MEM_READ           0x01
 #define BP_MEM_WRITE          0x02
@@ -28,7 +29,7 @@
 
 typedef struct CPUBreakpoint {
     vaddr pc;
-    int flags; /* BP_* */
+    BreakpointFlags flags;
     QTAILQ_ENTRY(CPUBreakpoint) entry;
 } CPUBreakpoint;
 
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
index c4d069425b..a09daf47f1 100644
--- a/include/exec/watchpoint.h
+++ b/include/exec/watchpoint.h
@@ -8,11 +8,13 @@
 #ifndef EXEC_WATCHPOINT_H
 #define EXEC_WATCHPOINT_H
 
+#include "exec/breakpoint.h"
+
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint);
+                          BreakpointFlags flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, int flags);
+                          vaddr len, BreakpointFlags flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 
 #endif /* EXEC_WATCHPOINT_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3959607df..2c58ea5e4c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1138,14 +1138,15 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
                           CPUBreakpoint **breakpoint);
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags);
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
-void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
+void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 
 /* Return true if PC matches an installed breakpoint.  */
-static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
+static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc,
+                                       BreakpointFlags mask)
 {
     CPUBreakpoint *bp;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6e66f3c6e9..dbbcf1dbf4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1032,7 +1032,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     CPUTLBEntry *te, tn;
     hwaddr iotlb, xlat, sz, paddr_page;
     vaddr addr_page;
-    int asidx, wp_flags, prot;
+    int asidx, prot;
+    BreakpointFlags wp_flags;
     bool is_ram, is_romd;
 
     assert_cpu_is_self(cpu);
@@ -1498,8 +1499,8 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     if (unlikely(flags & (TLB_NOTDIRTY | TLB_WATCHPOINT))) {
         /* Handle watchpoints.  */
         if (flags & TLB_WATCHPOINT) {
-            int wp_access = (access_type == MMU_DATA_STORE
-                             ? BP_MEM_WRITE : BP_MEM_READ);
+            BreakpointFlags wp_access = (access_type == MMU_DATA_STORE
+                                        ? BP_MEM_WRITE : BP_MEM_READ);
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  full->attrs, wp_access, retaddr);
         }
@@ -1701,7 +1702,8 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
 
     /* On watchpoint hit, this will longjmp out.  */
     if (flags & TLB_WATCHPOINT) {
-        int wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE : BP_MEM_READ;
+        BreakpointFlags wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE
+                                                           : BP_MEM_READ;
         cpu_check_watchpoint(cpu, addr, size, full->attrs, wp, ra);
         flags &= ~TLB_WATCHPOINT;
     }
@@ -1884,7 +1886,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
-        int wp_flags = 0;
+        BreakpointFlags wp_flags = 0;
 
         if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
             wp_flags |= BP_MEM_WRITE;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index c179cd4ade..7ba682592c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -115,20 +115,20 @@ static bool tcg_supports_guest_debug(void)
 }
 
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
-static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
+static inline BreakpointFlags xlat_gdb_type(CPUState *cpu, int gdbtype)
 {
-    static const int xlat[] = {
+    static const BreakpointFlags xlat[] = {
         [GDB_WATCHPOINT_WRITE]  = BP_GDB | BP_MEM_WRITE,
         [GDB_WATCHPOINT_READ]   = BP_GDB | BP_MEM_READ,
         [GDB_WATCHPOINT_ACCESS] = BP_GDB | BP_MEM_ACCESS,
     };
 
-    int cputype = xlat[gdbtype];
+    BreakpointFlags cpuflags = xlat[gdbtype];
 
     if (cpu->cc->gdb_stop_before_watchpoint) {
-        cputype |= BP_STOP_BEFORE_ACCESS;
+        cpuflags |= BP_STOP_BEFORE_ACCESS;
     }
-    return cputype;
+    return cpuflags;
 }
 
 static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 28286e11a6..a10ff03922 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -22,13 +22,13 @@ void cpu_exec_reset_hold(CPUState *cpu)
 }
 
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint)
+                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
 {
     return -ENOSYS;
 }
 
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, int flags)
+                          vaddr len, BreakpointFlags flags)
 {
     return -ENOSYS;
 }
@@ -37,17 +37,18 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
 {
 }
 
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask)
 {
 }
 
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
+                                               vaddr addr, vaddr len)
 {
     return 0;
 }
 
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs atr, int fl, uintptr_t ra)
+                          MemTxAttrs atr, BreakpointFlags flags, uintptr_t ra)
 {
 }
 
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index c75ed27845..5ea66e9763 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -52,10 +52,11 @@ static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
 }
 
 /* Return flags for watchpoints that match addr + prot.  */
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
+                                               vaddr addr, vaddr len)
 {
     CPUWatchpoint *wp;
-    int ret = 0;
+    BreakpointFlags ret = 0;
 
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (watchpoint_address_matches(wp, addr, len)) {
@@ -67,7 +68,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
 
 /* Generate a debug exception if a watchpoint has been hit.  */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs attrs, int flags, uintptr_t ra)
+                          MemTxAttrs attrs, BreakpointFlags flags, uintptr_t ra)
 {
     CPUWatchpoint *wp;
 
@@ -91,7 +92,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 
     assert((flags & ~BP_MEM_ACCESS) == 0);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        int hit_flags = wp->flags & flags;
+        BreakpointFlags hit_flags = wp->flags & flags;
 
         if (hit_flags && watchpoint_address_matches(wp, addr, len)) {
             if (replay_running_debug()) {
diff --git a/cpu-common.c b/cpu-common.c
index 988d057d84..bc77835aea 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -389,7 +389,7 @@ void process_queued_cpu_work(CPUState *cpu)
 }
 
 /* Add a breakpoint.  */
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
                           CPUBreakpoint **breakpoint)
 {
     CPUBreakpoint *bp;
@@ -419,7 +419,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 }
 
 /* Remove a specific breakpoint.  */
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags)
 {
     CPUBreakpoint *bp;
 
@@ -446,7 +446,7 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
 }
 
 /* Remove all matching breakpoints. */
-void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
+void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask)
 {
     CPUBreakpoint *bp, *next;
 
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 21d0bb36ca..3785ffff46 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -26,7 +26,7 @@
 
 /* Add a watchpoint.  */
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint)
+                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
 {
     CPUWatchpoint *wp;
     vaddr in_page;
@@ -65,7 +65,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
 
 /* Remove a specific watchpoint.  */
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags)
+                          BreakpointFlags flags)
 {
     CPUWatchpoint *wp;
 
@@ -90,7 +90,7 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
 }
 
 /* Remove all matching watchpoints.  */
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask)
 {
     CPUWatchpoint *wp, *next;
 
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 07a52643e7..11043ecd58 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -550,7 +550,7 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
     vaddr wvr = env->cp15.dbgwvr[n];
     uint64_t wcr = env->cp15.dbgwcr[n];
     int mask;
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
 
     if (env->cpu_watchpoint[n]) {
         cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[n]);
@@ -656,7 +656,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
     uint64_t bcr = env->cp15.dbgbcr[n];
     vaddr addr;
     int bt;
-    int flags = BP_CPU;
+    BreakpointFlags flags = BP_CPU;
 
     if (env->cpu_breakpoint[n]) {
         cpu_breakpoint_remove_by_ref(CPU(cpu), env->cpu_breakpoint[n]);
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index dca4ef5a94..17f920b3f3 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -190,7 +190,8 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
 
     /* Any debug exception has priority over a tag check exception. */
     if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
-        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
+        BreakpointFlags wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ
+                                                         : BP_MEM_WRITE;
         assert(ra != 0);
         cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
     }
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 41edb18643..913920d55b 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -145,7 +145,7 @@ void ppc_update_daw(CPUPPCState *env, int rid)
     bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
     bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
     vaddr len;
-    int flags;
+    BreakpointFlags flags;
 
     if (env->dawr_watchpoint[rid]) {
         cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a0..2a3711fb1d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1429,7 +1429,7 @@ static int find_hw_breakpoint(target_ulong addr, int type)
     return -1;
 }
 
-static int find_hw_watchpoint(target_ulong addr, int *flag)
+static int find_hw_watchpoint(target_ulong addr, BreakpointFlags *flag)
 {
     int n;
 
@@ -1575,7 +1575,6 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
 {
     int handle = DEBUG_RETURN_GUEST;
     int n;
-    int flag = 0;
 
     if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
         if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
@@ -1585,6 +1584,8 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
             }
         } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
                                         KVMPPC_DEBUG_WATCH_WRITE)) {
+            BreakpointFlags flag = 0;
+
             n = find_hw_watchpoint(arch_info->address,  &flag);
             if (n >= 0) {
                 handle = DEBUG_RETURN_GDB;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2db07f5dfb..c318dcd633 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2000,7 +2000,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        int wp_access = 0;
+        BreakpointFlags wp_access = 0;
 
         if (access_type == MMU_DATA_LOAD) {
             wp_access |= BP_MEM_READ;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index ba5bc6ae13..fa47b2724e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -480,7 +480,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     target_ulong addr = env->tdata2[index];
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t size, def_size;
 
     if (!enabled) {
@@ -605,7 +605,7 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     target_ulong addr = env->tdata2[index];
     bool enabled = type6_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t size;
 
     if (!enabled) {
@@ -994,7 +994,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     target_ulong ctrl;
     target_ulong addr;
     int trigger_type;
-    int flags;
+    BreakpointFlags flags;
     int i;
 
     for (i = 0; i < env->num_triggers; i++) {
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index 99140b1ac9..d10e9ed892 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -14,7 +14,8 @@
 
 void s390_cpu_recompute_watchpoints(CPUState *cs)
 {
-    const int wp_flags = BP_CPU | BP_MEM_WRITE | BP_STOP_BEFORE_ACCESS;
+    const BreakpointFlags wp_flags = BP_CPU | BP_MEM_WRITE
+                                     | BP_STOP_BEFORE_ACCESS;
     CPUS390XState *env = cpu_env(cs);
 
     /* We are called when the watchpoints have changed. First
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 3b91f7c38a..990012f60e 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -85,7 +85,7 @@ static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
         uint32_t dbreakc)
 {
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t mask = dbreakc | ~DBREAKC_MASK;
 
     if (env->cpu_watchpoint[i]) {
-- 
2.43.0


