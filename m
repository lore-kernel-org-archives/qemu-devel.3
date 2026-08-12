Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693A6C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhl-0007UP-AC; Wed, 12 Aug 2026 16:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhk-0007TE-3f
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:40 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhh-0001Ek-Cw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:39 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C75C4345E;
 Wed, 12 Aug 2026 20:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9666D1F00A3A;
 Wed, 12 Aug 2026 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567056;
 bh=l9mybwz/TyY+oyBh3FK+zP6geKy0Ld5o+RX6e2KU+gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mzRT4v0UP+zCIb50s3u7PnoeIR4o+tgOZfsSBAf2bNr5AigHUYghMf5UUeXbDx/TH
 /MsSJbBU0ikAKMuwwVFLMdroJd6u1F2or1AZc8wrzJv9e2ivLTCVJeu+2B0EZU2/Ag
 XezX0mKgPb7HglLZE3daK0axWtVH9yI5y/kRtFnOy2QSulrCm/nhO7/GbN0nhnv9jZ
 fzQwhP6x3hHIISsvCEMrwG+IC+Soe5OUzQZYlj7Nr1XlqAb8l3Eh5l7Z6AZKJRJ+Kg
 ZRL0iCtBZ1sLFaQkAugt7DkbcvGrQz13QEX7n6ZUkv9LPvDmzP7cD7Uv1t7FyM7FkV
 M3L8qaJfc4Bbg==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 4/7] linux-user/mips: write the floating-point registers to a
 core dump
Date: Wed, 12 Aug 2026 22:37:22 +0200
Message-ID: <20260812203725.10694-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
References: <20260812203725.10694-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

Write an NT_FPREGSET note for MIPS and MIPS64, matching the kernel's
elf_fpregset_t layout (ELF_NFPREG = 33): fpr[0..31] hold f0-f31, and
fcsr occupies the low 32 bits of slot 32.  The pad field rounds the
struct to 33 × 8 bytes = 264 bytes.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/mips/elfload.c      |  8 ++++++++
 linux-user/mips/target_elf.h   | 13 +++++++++++++
 linux-user/mips64/target_elf.h | 13 +++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index ce2c4514f3..1d62ae0a4d 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -130,6 +130,14 @@ const char *get_elf_base_platform(CPUState *cs)
 
 #undef MATCH_PLATFORM_INSN
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUMIPSState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->fpr[i] = tswap64(env->active_fpu.fpr[i].d);
+    }
+    r->fcsr = tswap32(env->active_fpu.fcr31);
+}
+
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
 #ifndef TARGET_MIPS64
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 157306f7a0..426f905d3a 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -26,4 +26,17 @@ typedef struct target_elf_gregset_t {
     };
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches the kernel's elf_fpregset_t (ELF_NFPREG = 33):
+ *   fpr[0..31] hold f0-f31; fcsr occupies the low 32 bits of slot 32.
+ *   pad rounds the struct to 33 × 8 bytes = 264 bytes.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+    uint32_t fcsr;
+    uint32_t pad;
+} target_elf_fpregset_t;
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 061471a0f1..efb5d97563 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -32,4 +32,17 @@ typedef struct target_elf_gregset_t {
     };
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches the kernel's elf_fpregset_t (ELF_NFPREG = 33):
+ *   fpr[0..31] hold f0-f31; fcsr occupies the low 32 bits of slot 32.
+ *   pad rounds the struct to 33 × 8 bytes = 264 bytes.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+    uint32_t fcsr;
+    uint32_t pad;
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0


