Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDDCC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWRm-0002lC-CB; Wed, 22 Jul 2026 08:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQy-0002ej-50; Wed, 22 Jul 2026 08:52:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQv-0002RJ-Er; Wed, 22 Jul 2026 08:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=QR2ssYITYSs3Asb2kUlSgGRDU4LyZYIgP5gR1MraL4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NU+qrftXSS7GKrP5v3hMyJ4yPAW+w+O4W/xL37wku37Q+6ndrIsBsR+GPAsxN092T
 91PYm1K7NGj9iPU8giRmOveNksJXLfDPJQE6QnU5xr89/DuHkO7eMKSeVfUgwt8dWX
 EXprRj4rfVPG410Au49kqWTKiUZ1u74N0B6Q8cslNp3iqz2u0+3YEVYVE4kd57B8Uk
 Nb0L72shzZJeoIORNxL4m6PlxXUxwpmlxnW03HOi4W83f3y4wBCVqBlRy85pgIiiMU
 L+ua1M59QwrBqErPHhwMJm4HzE/8X5MfEhS6bygyK59i3C/l0K1RGBRWM6d+As7Vke
 qY9va7SjLdo5w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C10F81C3B3B;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 15F143F378B;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B0C8917F4B; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 094/127] linux-user/alpha: populate AT_HWCAP from
 env->amask
Date: Wed, 22 Jul 2026 15:48:19 +0300
Message-ID: <20260722124859.32371-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
index 1969f620a54..7be9e466b68 100644
--- a/linux-user/alpha/elfload.c
+++ b/linux-user/alpha/elfload.c
@@ -6,6 +6,17 @@
 #include "target_elf.h"
 
 
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    /*
+     * The Linux kernel computes ELF_HWCAP as ~amask(-1), which clears a bit
+     * for each supported ISA extension.  env->amask stores exactly those bits
+     * set for the extensions supported by the emulated CPU model, matching
+     * the kernel's convention: bit set in AT_HWCAP ↔ extension present.
+     */
+    return cpu_env(cs)->amask;
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUAlphaState *env)
 {
     int i;
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 4987ae39448..dd90c6f783b 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -12,6 +12,7 @@
 #define ELF_MACHINE             EM_ALPHA
 
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_ELF_HWCAP          1
 
 /*
  * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
-- 
2.47.3


