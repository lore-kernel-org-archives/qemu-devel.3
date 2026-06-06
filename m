Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF74CD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 21:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVyea-00025M-4C; Sat, 06 Jun 2026 17:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wVyeY-00025B-PV
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 17:34:02 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wVyeW-0000wk-BN
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 17:34:02 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D16BE600AE;
 Sat,  6 Jun 2026 21:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFE81F00893;
 Sat,  6 Jun 2026 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780781632;
 bh=et5eLMegT6ampsfftjXOFLTcAsoi2sO/Rg/7dQphinA=;
 h=From:To:Cc:Subject:Date;
 b=RmWbr/GM56SwRtzURAxc5LV9/nRuhsjcRhE+bJV2r/EeK4cZgwJV0n0cBl2DZQwDs
 ogEzkwNnjf1TU1G8lTtnMKl5OW439umS/hof907vdJaTUAjkOv325Bp6IcK2k0uz+A
 AIRTSdfh/48yaDrsF5yR2QQ5Cl0yO+0t2CEn0RUReVdvio4iqOPbi2Uet35yJ6vsRk
 WZFJZ8EDLCN31dLKhKdKU/QaU0RUYeOtk4CXTaNKK75C+Q1d0N7u2Nkhanrj3hnANv
 g1IilTNIOdZVdkSoswXyDgV1joFXTv0Rz5iehXGi5xYtXKqdI1WsfbotBAKYHQKq5r
 U8hWoOEJVtzeQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH] linux-user/alpha: add coredump support
Date: Sat,  6 Jun 2026 23:33:43 +0200
Message-ID: <20260606213343.11970-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h,
mirroring the kernel's elf_gregset_t (ELF_NGREG = 66): r0-r31
[0..31], f0-f31 [32..63], pc [64], unique [65].  Implement
elf_core_copy_regs() in elfload.c to populate the gregset from
CPUAlphaState.

Without this, bprm->core_dump is NULL for Alpha targets.  When a
guest signal goes unhandled, dump_core_and_abort() skips the core
write and falls through to die_with_signal(), which re-raises the
signal to the host.  The host kernel then writes an x86-64 core file
for the qemu-alpha process instead of an Alpha guest core.

v2: Store thread unique field, same as in Linux kernel. Added by Helge &
suggested by Richard.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/alpha/elfload.c    | 12 ++++++++++++
 linux-user/alpha/target_elf.h | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
index 1e44475c47..d2aed15ce5 100644
--- a/linux-user/alpha/elfload.c
+++ b/linux-user/alpha/elfload.c
@@ -3,8 +3,20 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUAlphaState *env)
+{
+    int i;
+
+    for (i = 0; i < 31; i++) {
+        r->regs[i] = tswap64(env->ir[i]);
+    }
+    r->pc = tswap64(env->pc);
+    r->unique = env->unique;
+}
+
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "ev67";
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 864dc6e2e6..4987ae3944 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -11,4 +11,17 @@
 #define ELF_CLASS               ELFCLASS64
 #define ELF_MACHINE             EM_ALPHA
 
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
+ *   r0-r30 at indices 0-30, pc at 31, ps at 32.
+ * r31 (hardwired zero) is not stored; pc occupies index 31.
+ */
+typedef struct target_elf_gregset_t {
+    abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
+    abi_ulong pc;        /* program counter           [31]    */
+    abi_ulong unique;    /* thread's UNIQUE field     [32]    */
+} target_elf_gregset_t;
+
 #endif
-- 
2.54.0


