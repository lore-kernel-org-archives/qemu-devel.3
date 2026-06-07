Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58621CD8C88
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWE6t-0004Lf-Mz; Sun, 07 Jun 2026 10:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6s-0004LJ-LL
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:18 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6q-00086L-KY
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE8A560018;
 Sun,  7 Jun 2026 14:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FCB1F00893;
 Sun,  7 Jun 2026 14:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841055;
 bh=gEmpbKVD9hDcSZqLWrik9HtYpOvGlKu3Ri0bvNo/FQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fVBxOEV4CTtlMUmoDf4OgKZzSZUUMyRlAOsL/8LwBjLu2fYQUkb5G0m34c38P9f6G
 PovWQMq5MDP4mmKwvxZGVUalhN+C6hDKs3MDy46T4aNze6UK6FZ0QalrdVtV4ol5lu
 ku05mCoJirlMPzYhCZDWKx4LajKdUTCZg47m+QPrHVHvDesQQrkaKfeiK+JKkb01dR
 o/U16v5CXyMnrb3x34BFL76IHrtC7ahbb1IZjfRgSYtVT98HVy4E1JjEjTeN2orx/5
 jZGMMudyxCTzQBZ7Go3TTyajX+/ZtL3sJE8g4ZPswcIX9v06u1avb2chBBd36jd6d1
 IUgEXmpyiIwoA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Matt Turner <mattst88@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 07/10] linux-user/sparc: flush register windows before core
 dump
Date: Sun,  7 Jun 2026 16:03:53 +0200
Message-ID: <20260607140356.10702-8-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140356.10702-1-deller@kernel.org>
References: <20260607140356.10702-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Turner <mattst88@gmail.com>

Without this, only the crash frame's window is spilled to the
stack; all deeper call frames remain in the register file and
are absent from the core's memory segments. Stack unwinding
fails past the first DWARF step because the callers' register
save areas contain stale/garbage data.

The real kernel calls flush_all_user_windows() at the top of
do_coredump(). Mirror that via a weak target_flush_windows()
hook called from dump_core_and_abort(), with the SPARC override
calling the existing flush_windows() in cpu_loop.c.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/elfload.c          |  9 ++++++++
 linux-user/sparc/cpu_loop.c   |  3 ++-
 linux-user/sparc/cpu_loop.h   |  7 +++++++
 linux-user/sparc/elfload.c    | 39 +++++++++++++++++++++++++++++------
 linux-user/sparc/target_elf.h | 17 +++++++++++----
 5 files changed, 64 insertions(+), 11 deletions(-)
 create mode 100644 linux-user/sparc/cpu_loop.h

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f7625c0952..b05b8b0c6b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2445,6 +2445,9 @@ static int wmr_write_region(void *opaque, vaddr start,
  * handler (provided that target process haven't registered
  * handler for that) that does the dump when signal is received.
  */
+#ifdef TARGET_SPARC
+#include "sparc/cpu_loop.h"
+#endif
 static int elf_core_dump(int signr, const CPUArchState *env)
 {
     const CPUState *cpu = env_cpu_const(env);
@@ -2468,6 +2471,12 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     cpu_list_lock();
     mmap_lock();
 
+#ifdef TARGET_SPARC
+    CPU_FOREACH(cpu_iter) {
+        flush_windows(cpu_env(cpu_iter));
+    }
+#endif
+
     /* By unprotecting, we merge vmas that might be split. */
     walk_memory_regions(NULL, wmr_page_unprotect_regions);
 
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index ab633eeae3..0aacda9448 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -22,6 +22,7 @@
 #include "user-internals.h"
 #include "user/cpu_loop.h"
 #include "signal-common.h"
+#include "sparc/cpu_loop.h"
 
 #define SPARC64_STACK_BIAS 2047
 
@@ -119,7 +120,7 @@ static void restore_window(CPUSPARCState *env)
 #endif
 }
 
-static void flush_windows(CPUSPARCState *env)
+void flush_windows(CPUSPARCState *env)
 {
     int offset, cwp1;
 
diff --git a/linux-user/sparc/cpu_loop.h b/linux-user/sparc/cpu_loop.h
new file mode 100644
index 0000000000..fb6e82d372
--- /dev/null
+++ b/linux-user/sparc/cpu_loop.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef SPARC_CPU_LOOP_H
+#define SPARC_CPU_LOOP_H
+
+void flush_windows(CPUSPARCState *env);
+
+#endif
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index e6387ec891..181f1e00b5 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -12,16 +12,41 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
     CPUSPARCState *e = (CPUSPARCState *)env;
     int i;
 
+    memset(r, 0, sizeof(*r));
+
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+    /* Linux kernel layout for sparc64 (arch/sparc/include/asm/elf_64.h):
+     *   [0..7]   G0-G7
+     *   [8..15]  O0-O7
+     *   [16..23] L0-L7
+     *   [24..31] I0-I7
+     *   [32]     TSTATE
+     *   [33]     TPC
+     *   [34]     TNPC
+     *   [35]     Y
+     */
     for (i = 0; i < 8; i++) {
-        r->regs[i]     = tswap64(env->gregs[i]);
-        r->regs[8 + i] = tswap64(env->regwptr[WREG_O0 + i]);
+        r->regs[i]      = tswap64(env->gregs[i]);
+        r->regs[8 + i]  = tswap64(env->regwptr[WREG_O0 + i]);
+        r->regs[16 + i] = tswap64(env->regwptr[WREG_L0 + i]);
+        r->regs[24 + i] = tswap64(env->regwptr[WREG_I0 + i]);
     }
-    r->regs[16] = tswap64(sparc64_tstate(e));
-    r->regs[17] = tswap64(env->pc);
-    r->regs[18] = tswap64(env->npc);
-    r->regs[19] = tswap64(env->y);
+    r->regs[32] = tswap64(sparc64_tstate(e));
+    r->regs[33] = tswap64(env->pc);
+    r->regs[34] = tswap64(env->npc);
+    r->regs[35] = tswap64(env->y);
 #else
+    /* Linux kernel layout for sparc32 (arch/sparc/include/asm/elf_32.h):
+     *   [0]      PSR
+     *   [1]      PC
+     *   [2]      NPC
+     *   [3]      Y
+     *   [4..11]  G0-G7
+     *   [12..19] O0-O7
+     *   [20..27] L0-L7
+     *   [28..35] I0-I7
+     *   [36..37] reserved (stack_check)
+     */
     r->regs[0] = tswap32(cpu_get_psr(e));
     r->regs[1] = tswap32(env->pc);
     r->regs[2] = tswap32(env->npc);
@@ -29,6 +54,8 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
     for (i = 0; i < 8; i++) {
         r->regs[4 + i]  = tswap32(env->gregs[i]);
         r->regs[12 + i] = tswap32(env->regwptr[WREG_O0 + i]);
+        r->regs[20 + i] = tswap32(env->regwptr[WREG_L0 + i]);
+        r->regs[28 + i] = tswap32(env->regwptr[WREG_I0 + i]);
     }
 #endif
 }
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index edb0b3103c..365af864b0 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -24,12 +24,21 @@
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
- * Matches the kernel's elf_gregset_t (ELF_NGREG = 20).
- * sparc32/sparc32plus: psr, pc, npc, y, u_regs[16] (g0-g7, o0-o7)
- * sparc64:             u_regs[16] (g0-g7, o0-o7), tstate, pc, npc, y
+ * Matches the kernel's elf_gregset_t.
+ *   sparc32/sparc32plus (ELF_NGREG = 38):
+ *     psr, pc, npc, y, u_regs[16] (g0-g7, o0-o7),
+ *     reg_window[16] (l0-l7, i0-i7), stack_check[2]
+ *   sparc64             (ELF_NGREG = 36):
+ *     u_regs[16] (g0-g7, o0-o7), reg_window[16] (l0-l7, i0-i7),
+ *     tstate, tpc, tnpc, y
  */
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+# define TARGET_ELF_NGREG       36
+#else
+# define TARGET_ELF_NGREG       38
+#endif
 typedef struct target_elf_gregset_t {
-    abi_ulong regs[20];
+    abi_ulong regs[TARGET_ELF_NGREG];
 } target_elf_gregset_t;
 
 #endif
-- 
2.54.0


