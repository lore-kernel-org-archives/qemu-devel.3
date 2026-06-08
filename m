Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BEACD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfsX-0008UJ-8V; Mon, 08 Jun 2026 15:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsP-0008Sr-Ak
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:17 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsM-0006CF-Dn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:11 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6BECD601D8;
 Mon,  8 Jun 2026 19:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8C81F00893;
 Mon,  8 Jun 2026 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780947789;
 bh=UPeXJIlKzbTxaer6fjTxCLj0ISR2mmzL0SNT7pcKTJM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gy0S67x4kJimjdzptojarBQaJyLNbi5WBgr4kqRGF4gdnA4Z6bIe/JJ9pqQeJNMr8
 XJ0IEKE42sdt0plfFLhdm4kAaNYybBfcIUVa5B02yLWTEviBxHf8bfojOnIOdDJCBf
 bVooSnGrmepI1mix0OPMWtJ4zGZ3XkexzYDG1guhJB74Ln6kuOB+VQmjFR8Xi77R3z
 3D6u104tbLTgiIPRhLJclzdKU2EqyJPnXpLF/+Dm3R4S2fmu8M4DJA52m9t8c6budp
 b/xTQWJ5AgDhsBGVYOMJbuVDH4bMTV1493Ero7DAUaLLQ/DwADePOa9rQQHz1hHbaw
 VU4t04cn83tgg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Matt Turner <mattst88@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 4/8] linux-user/sparc: add coredump support
Date: Mon,  8 Jun 2026 21:42:52 +0200
Message-ID: <20260608194256.13794-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194256.13794-1-deller@kernel.org>
References: <20260608194256.13794-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h
sized to match the kernel's elf_gregset_t:

  sparc32/sparc32plus (ELF_NGREG = 38):
    [0]      PSR
    [1]      PC
    [2]      NPC
    [3]      Y
    [4..11]  G0-G7
    [12..19] O0-O7
    [20..27] L0-L7
    [28..35] I0-I7
    [36..37] reserved (stack_check)

  sparc64 (ELF_NGREG = 36):
    [0..7]   G0-G7
    [8..15]  O0-O7
    [16..23] L0-L7
    [24..31] I0-I7
    [32]     TSTATE
    [33]     TPC
    [34]     TNPC
    [35]     Y

Also define ELF_MACHINE as EM_SPARC32PLUS for TARGET_ABI32 builds,
matching the kernel and ensuring the correct machine type appears in
the core file.

Implement elf_core_copy_regs() in elfload.c to populate the gregset
from CPUSPARCState, including L0-L7 and I0-I7 from env->regwptr.
A memset() at entry zeros the trailing reserved slots.

Without this, bprm->core_dump is NULL for SPARC targets.  When a
guest signal goes unhandled, dump_core_and_abort() skips the core
write and falls through to die_with_signal(), which re-raises the
signal to the host.  The host kernel then writes an x86-64 core file
for the qemu-sparc process instead of a SPARC guest core.

Populating the full register layout is required for tools like
libunwind-coredump, which reads pr_reg[33] for the trap PC and
pr_reg[16..31] for the windowed registers.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sparc/elfload.c    | 27 +++++++++++++++++++++++++++
 linux-user/sparc/target_elf.h | 11 +++++++++++
 2 files changed, 38 insertions(+)

diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 32ca1b05b1..e6387ec891 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -4,8 +4,35 @@
 #include "qemu.h"
 #include "loader.h"
 #include "elf.h"
+#include "target_elf.h"
 
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
+{
+    CPUSPARCState *e = (CPUSPARCState *)env;
+    int i;
+
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+    for (i = 0; i < 8; i++) {
+        r->regs[i]     = tswap64(env->gregs[i]);
+        r->regs[8 + i] = tswap64(env->regwptr[WREG_O0 + i]);
+    }
+    r->regs[16] = tswap64(sparc64_tstate(e));
+    r->regs[17] = tswap64(env->pc);
+    r->regs[18] = tswap64(env->npc);
+    r->regs[19] = tswap64(env->y);
+#else
+    r->regs[0] = tswap32(cpu_get_psr(e));
+    r->regs[1] = tswap32(env->pc);
+    r->regs[2] = tswap32(env->npc);
+    r->regs[3] = tswap32(env->y);
+    for (i = 0; i < 8; i++) {
+        r->regs[4 + i]  = tswap32(env->gregs[i]);
+        r->regs[12 + i] = tswap32(env->regwptr[WREG_O0 + i]);
+    }
+#endif
+}
+
 const char *get_elf_cpu_model(uint32_t eflags)
 {
 #ifdef TARGET_SPARC64
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 7827767bcb..edb0b3103c 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -13,6 +13,7 @@
 # define ELF_MACHINE            EM_SPARC
 #elif defined(TARGET_ABI32)
 # define ELF_CLASS              ELFCLASS32
+# define ELF_MACHINE            EM_SPARC32PLUS
 # define elf_check_machine(x)   ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
 # define ELF_CLASS              ELFCLASS64
@@ -20,5 +21,15 @@
 #endif
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Matches the kernel's elf_gregset_t (ELF_NGREG = 20).
+ * sparc32/sparc32plus: psr, pc, npc, y, u_regs[16] (g0-g7, o0-o7)
+ * sparc64:             u_regs[16] (g0-g7, o0-o7), tstate, pc, npc, y
+ */
+typedef struct target_elf_gregset_t {
+    abi_ulong regs[20];
+} target_elf_gregset_t;
 
 #endif
-- 
2.54.0


