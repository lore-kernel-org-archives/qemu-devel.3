Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781D1CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8jm-0006bY-Gf; Sun, 24 May 2026 09:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jl-0006bI-6U
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:25 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jj-0005ai-Lq
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:24 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC519409B3;
 Sun, 24 May 2026 13:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF211F00A3C;
 Sun, 24 May 2026 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779628761;
 bh=7B3sC2FvVNUkuJyuRL95Tb66TxfppTszcuAs1pXXHCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=k5/fZrkWPxr0Pb71+VVydsvEA4ttpyJrtCs9Sz+wOh94kCGLSiWFhRz8S44l7SCf/
 8ioCg1ZOKC5NgGsKPk+fDQr5FOWVEdrvxtnFRVYxnPc+YVbOECExy5hfE4cYPPT4mt
 mQA1SkPvN8/rS5D3DolaORo7rwf7NJaZgLSWiltOizAtY4XDFT2nlVxNyZqovHws0U
 XPK6azYHs6a1HGLKvQKjzPuxGR+lEqYAXobZHhHPnfkG1V9l9lRozl8hknpwr0h+5n
 o/M3nfeaLsWWS22ILcJVTUAAanMbu28dBvvc26EElstUgPv0ZAhnQ2Pi+RsQUSLMRT
 803UJgrbF2rgg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 5/6] linux-user/riscv: add coredump support
Date: Sun, 24 May 2026 15:19:07 +0200
Message-ID: <20260524131909.162990-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524131909.162990-1-deller@kernel.org>
References: <20260524131909.162990-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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
mirroring struct user_regs_struct: pc followed by x1 (ra) through
x31 (t6).  Implement elf_core_copy_regs() in elfload.c to populate
the gregset from CPURISCVState.

Without this, bprm->core_dump is NULL for RISC-V targets.  When a
guest signal goes unhandled, dump_core_and_abort() skips the core
write and falls through to die_with_signal(), which re-raises the
signal to the host.  The host kernel then writes an x86-64 core file
for the qemu-riscv64 process instead of a RISC-V guest core.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/riscv/elfload.c    | 9 +++++++++
 linux-user/riscv/target_elf.h | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index 2e7d622232..afe103a631 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -10,6 +11,14 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "max";
 }
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPURISCVState *env)
+{
+    r->pc = tswapal(env->pc);
+    for (int i = 0; i < 31; i++) {
+        r->regs[i] = tswapal(env->gpr[i + 1]);
+    }
+}
+
 abi_ulong get_elf_hwcap(CPUState *cs)
 {
 #define MISA_BIT(EXT) (1 << (EXT - 'A'))
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index dbbfdf54d3..859f726578 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -19,5 +19,12 @@
 #endif
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_CORE_DUMP      1
+
+/* Mirrors struct user_regs_struct: pc followed by x1 (ra) .. x31 (t6). */
+typedef struct target_elf_gregset_t {
+    abi_ulong pc;
+    abi_ulong regs[31];
+} target_elf_gregset_t;
 
 #endif
-- 
2.54.0


