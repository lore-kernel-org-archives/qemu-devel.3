Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CC9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhp-0007fU-G8; Wed, 12 Aug 2026 16:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhm-0007XT-G6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:42 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhk-0001Fg-MP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFC4240388;
 Wed, 12 Aug 2026 20:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA091F000E9;
 Wed, 12 Aug 2026 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567059;
 bh=2H7HVfwqlDxoeLXTzIQpGxDP5wgRXBpmf4KDHNqccOE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OmsqnO4jW/VM/haUOgAINDVRNjvzdD8wfyDmUVdVv9PY1oCGvgL0dGvkJs6vRdf6S
 A4mxOicrh/XjkFsxO6PldcRNYgi+FF2XXeGz2aaeovjbxdX1trWV4qyNKxYJXOI+nz
 DdiYi+4J7rwlaxqoZfxN4rdfgZHJiMIJCg8IFqQ/N6sf2+SvtFsAUDvnmbh8QhxAgw
 39yxV+Z9TKdPx/JTHw9x18Em6Aywdf80attVmTb6O8klICil3q2VVNG3fhMOCwKI7a
 d5+wfJrC5tJkJJ/NmNZjpuNnwR2441VM5i6RlsMQg0YGPFJ6qL4APXhDO3JUZ8zwWW
 thSQ5tuAZSr6g==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 6/7] linux-user/riscv: write the floating-point registers to a
 core dump
Date: Wed, 12 Aug 2026 22:37:24 +0200
Message-ID: <20260812203725.10694-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
References: <20260812203725.10694-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Write an NT_FPREGSET note for RISC-V, matching struct __riscv_d_ext_state
from uapi/asm/ptrace.h: f0-f31 as 64-bit values followed by fcsr.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/riscv/elfload.c    |  9 +++++++++
 linux-user/riscv/target_elf.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index afe103a631..1bc8beacb1 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
@@ -11,6 +11,15 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "max";
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPURISCVState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->fpr[i] = tswap64(env->fpr[i]);
+    }
+    r->fcsr = tswap32(((uint32_t)env->frm << FSR_RD_SHIFT) |
+                      (riscv_cpu_get_fflags((CPURISCVState *)env) << FSR_AEXC_SHIFT));
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPURISCVState *env)
 {
     r->pc = tswapal(env->pc);
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 859f726578..185b81a2db 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -27,4 +27,15 @@ typedef struct target_elf_gregset_t {
     abi_ulong regs[31];
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches struct __riscv_d_ext_state from uapi/asm/ptrace.h:
+ *   f0-f31 as 64-bit values followed by fcsr.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+    uint32_t fcsr;
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0


