Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E6ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8jg-0006aJ-7r; Sun, 24 May 2026 09:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jf-0006Zb-0E
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:19 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jd-0005Xj-9Y
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6366640294;
 Sun, 24 May 2026 13:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D943F1F000E9;
 Sun, 24 May 2026 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779628756;
 bh=4jUD/iUmIk0WZSVuI4UggbN0ekm9NJMZB34COoCbZKM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MmljiueBRk8lVtkc+5SNSJfq0x+8a2JSoAF2zI6sAlFK5z8mbscaojKPE2AmO1phH
 /y78ajjBgZXnCcTFGU8N9OmLIZ+jdTCjh4xulGYkG/sRHkeOW0tbvFe0BRRK3Txf71
 8+PcTCPTFav0MnYOjgu8E+AgOStoi+jFw8tYmxH73fCty2NCG2dup65dnH3uZt0kMw
 LTkrIZsx8fJfOs/+ZTVRxkiE4tEYGYVoP6kRiozX/6IDzzFNwQ2bjPisTBaTBp3eOt
 JzrAYY3w9rbCEiXK9vy+cTx1HD3Kxjx2pt/83F6udR4NTi362t1xQ8suwDKT7CRsRN
 FCKJZ1/MUfkbA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/6] linux-user/mips64: fix elf_core_copy_regs register layout
 in core files
Date: Sun, 24 May 2026 15:19:04 +0200
Message-ID: <20260524131909.162990-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524131909.162990-1-deller@kernel.org>
References: <20260524131909.162990-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

mips64/elfload.c uses #include "../mips/elfload.c" to share code. When
the compiler processes mips/elfload.c the quoted #include "target_elf.h"
resolves relative to the including file's directory, so it picks up
mips/target_elf.h instead of mips64/target_elf.h.  mips/target_elf.h
pulls in mips/target_ptrace.h, whose target_pt_regs has a pad0[6] field
before regs[].  As a result elf_core_copy_regs writes:

  r->pt.regs[i]   -> reserved[6+i]   (shifted by 6 from the correct index)
  r->pt.cp0_epc   -> reserved[40]    (correct mips64 N64 index is 34)

The Linux kernel and glibc both use the mips64 N64 layout (no pad0): EPC
at reserved[34].  Debuggers and libunwind reading the core with N64
constants therefore see a completely wrong register set — EPC points to
GP, RA holds the branch target instead of the link address, etc.

Fix by:
 - Guarding the mips32 elf_core_copy_regs in mips/elfload.c with #ifndef
   TARGET_MIPS64 so it is not compiled for mips64/mipsn32 targets.
 - Providing a mips64-specific elf_core_copy_regs in mips64/elfload.c
   that writes directly to r->reserved[i] with the correct N64 indices,
   bypassing the struct field names that are tainted by the wrong header
   include.

The mipsn32 (TARGET_ABI_MIPSN32) and mips64el targets are covered by the
same mips64/elfload.c and benefit from the same fix.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/mips/elfload.c   |  2 ++
 linux-user/mips64/elfload.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index cc5bbf05ab..1a46e180cf 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -131,6 +131,7 @@ const char *get_elf_base_platform(CPUState *cs)
 #undef MATCH_PLATFORM_INSN
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+#ifndef TARGET_MIPS64
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
     for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
@@ -146,3 +147,4 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
     r->pt.cp0_status = tswapl(env->CP0_Status);
     r->pt.cp0_cause = tswapl(env->CP0_Cause);
 }
+#endif
diff --git a/linux-user/mips64/elfload.c b/linux-user/mips64/elfload.c
index b719555e65..9081ae8111 100644
--- a/linux-user/mips64/elfload.c
+++ b/linux-user/mips64/elfload.c
@@ -1 +1,30 @@
 #include "../mips/elfload.c"
+
+/*
+ * mips/elfload.c defines elf_core_copy_regs guarded by #ifndef TARGET_MIPS64.
+ *
+ * We must provide the mips64 version here.  We cannot use r->pt.regs[] because
+ * when mips/elfload.c is #include'd above its "#include "target_elf.h"" resolves
+ * to mips/target_elf.h (compiler searches the including file's directory first),
+ * which pulls in mips/target_ptrace.h.  That struct has pad0[6] before regs[],
+ * so r->pt.regs[i] writes to reserved[6+i] — offset by 6 from what the kernel
+ * and glibc expect for the N64 ABI (EPC at reserved[34], not reserved[40]).
+ *
+ * Write directly to reserved[] using the mips64 N64 index layout:
+ *   R0-R31 at reserved[0..31], LO at [32], HI at [33], EPC at [34].
+ */
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
+{
+    /* R0 is always 0; r->reserved is zero-initialised by the caller */
+    for (int i = 1; i < 32; i++) {
+        r->reserved[i] = tswap64(env->active_tc.gpr[i]);
+    }
+    r->reserved[26] = 0;   /* k0 */
+    r->reserved[27] = 0;   /* k1 */
+    r->reserved[32] = tswap64(env->active_tc.LO[0]);
+    r->reserved[33] = tswap64(env->active_tc.HI[0]);
+    r->reserved[34] = tswap64(env->active_tc.PC);
+    r->reserved[35] = tswap64(env->CP0_BadVAddr);
+    r->reserved[36] = tswap64(env->CP0_Status);
+    r->reserved[37] = tswap64(env->CP0_Cause);
+}
-- 
2.54.0


