Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0464BCD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUc0-00017J-Ur; Sat, 13 Jun 2026 16:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbn-0000nO-Sv; Sat, 13 Jun 2026 16:05:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUbk-0000LY-Q4; Sat, 13 Jun 2026 16:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381067; bh=VpUXHEeZq4VCjeyy0rgRt2Of/KA2IN5KTxh0zZi1P0I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SGr9nygYjurYFm2js2BTMkf0yH6sXDpkIelQN3cyGjkzIJgztONGQBC20LihF8KLc
 ipIX8isFbkUJdSB+/kb9b/0xx4b81kUoIAt2yd5gEzFeR6vFUapCeyvd6zGxSB0LZD
 3bmSEZH6RVyAkTOifu6Xvbj8R1u88ceMg6Xl0YXNPKulRe90+y3SYo81m6dy/PGm5M
 hnNIOwcm2swIhgO9BcWEutGRmWeAqA5Y2oEpWuzBxCG+i+vQH50kEpQeCLqwZ5I8bq
 puSfqb59obqVm55gDnbp6ex6p+2dmNKDai7LVpCaM55qgzZaH+QS92lULfjFzdWOVJ
 4uNKHQDG481ng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C578C1B6E75;
 Sat, 13 Jun 2026 23:04:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2F0D53CE8D8;
 Sat, 13 Jun 2026 23:04:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 14/61] linux-user/mips64: fix elf_core_copy_regs
 register layout in core files
Date: Sat, 13 Jun 2026 23:02:57 +0300
Message-ID: <20260613200411.1808021-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
(cherry picked from commit dd3a906d3505561d9cb3367b82c5475acca50b6b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


