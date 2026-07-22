Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C2EC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWSe-0004VR-W0; Wed, 22 Jul 2026 08:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQw-0002ea-Tt; Wed, 22 Jul 2026 08:52:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQu-0002Qe-1E; Wed, 22 Jul 2026 08:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=LLZgFtID7Y0u7woJv6idu+dtYbPMeWbCYDycpRvO6VE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rFdp+sJyKhFJwjW0MhL6+mKT2S5U7+i4KtD1oL1T3g1R31q7zfNq9lEjCl0JTmFw4
 tnOIW9QAWPlAFVktMDrjJknXhYbVsgNZWGJWfxN+5n4bglJn0R739a0AcZiw4SadFQ
 MYShG1Qm/NGFoTC5y0IAgn9u7o+u/4hI36E5PvWtu/XF0kJrOLP5V3dti97qr5ogCo
 R5IJvvAIt1qFDJ3huxc+ILAL68rnUG5dfweAUR6D/bFjo2XuNrE/DXmE96Eg5468fn
 HtRXGVLLjr6QVzq5jo5NCmylq2i8+0etjM5Rcp596zEYJQyom64gy+9GEDfeNLOxZL
 LzfaczS2CzUXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB1B31C3B3A;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0FCB43F378A;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AE7B317F49; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 093/127] linux-user/alpha: add coredump support
Date: Wed, 22 Jul 2026 15:48:18 +0300
Message-ID: <20260722124859.32371-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 9db18ed0631d09f349057c22f7872b2c45275d0c)
(Mjt: pick this for -stable too, helps with debugging and makes subsequent
 changes to apply cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
index 1e44475c475..1969f620a54 100644
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
+    r->unique = tswap64(env->unique);
+}
+
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "ev67";
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 864dc6e2e6f..4987ae39448 100644
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
2.47.3


