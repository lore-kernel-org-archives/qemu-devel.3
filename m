Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62536C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWOr-0004MZ-H0; Wed, 22 Jul 2026 08:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMJ-0002ni-9o; Wed, 22 Jul 2026 08:47:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMH-0001nR-Kw; Wed, 22 Jul 2026 08:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=Uj5SPltuEMKQ9l7jZ/Gupa4rWwu9kglq7Of8y4m2wBI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nl701QvTTYTeORmIiImkqddv73AvyhPOROMRMPgR5KfnkfXsDIkNdJtZUGvw+ynUN
 8nacp9SzmfPWla3LJpKKQLwF7NYADWpC4CQLfMEXoRcKQ0v2rG4NDFym6uPOFjZ4mo
 wqmtZmCZ/WW7SXNecMJxUayS4p5GOJFc5ktTnittyH/l5ac3TuL2W7Y3d6GvHffpR0
 UDaFUoMDG1fEhCHgjxLmbnoY9HF3nNSGGxI+JyvyOUr5pBbefntebqOZ72/1YT/OEA
 WZLdIYnUNwd/rhjd/etPUm3/+z8YasnmnJ1mi5gBmCh+jAgToNPexPcBJvTZVACfvy
 ml44gJWo5xLQw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79FFE1C3B03;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C1AC03F375D;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 58EC917EEF; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 090/122] linux-user/alpha: populate AT_HWCAP from
 env->amask
Date: Wed, 22 Jul 2026 15:45:39 +0300
Message-ID: <20260722124622.31034-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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

Alpha has never set AT_HWCAP in linux-user emulation, so getauxval(AT_HWCAP)
always returned 0 regardless of the emulated CPU model.

The Linux kernel computes ELF_HWCAP as ~amask(-1), i.e. the set of ISA
extension bits that the amask instruction reports as supported (cleared in
its output).  env->amask stores exactly those bits with the same layout
(BWX=0x1, FIX=0x2, CIX=0x4, MVI=0x100, TRAP=0x200, PREFETCH=0x1000), so
returning it directly from get_elf_hwcap matches the kernel convention.

Add HAVE_ELF_HWCAP to target_elf.h and implement get_elf_hwcap() in
elfload.c to expose the emulated CPU's capability mask to user-space
programs via the auxiliary vector.

Without this fix, programs using getauxval(AT_HWCAP) to detect BWX/FIX/CIX
(such as glibc's memcpy or JIT compilers targeting Alpha) incorrectly
concluded that no extensions were available even when emulating ev56+.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 7a2e863f9dd52883d6f59bb425f30609fc14aee4)
(Mjt: in 10.0.x, the code is in linux-user/elfload.c, -  back-port changes
 to pre-elfload-reorg state: HAVE_ELF_HWCAP is ELF_HWCAP, get_elf_hwcap()
 accepts no argument and returns uint32_t)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 35b7ea23880..6b1be150a3e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1720,6 +1720,20 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
+#define ELF_HWCAP get_elf_hwcap()
+
+static uint32_t get_elf_hwcap(void)
+{
+    CPUState *cs = thread_cpu;
+    /*
+     * The Linux kernel computes ELF_HWCAP as ~amask(-1), which clears a bit
+     * for each supported ISA extension.  env->amask stores exactly those bits
+     * set for the extensions supported by the emulated CPU model, matching
+     * the kernel's convention: bit set in AT_HWCAP ↔ extension present.
+     */
+    return cpu_env(cs)->amask;
+}
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
-- 
2.47.3


