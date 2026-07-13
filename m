Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjHlD-00089X-R9; Mon, 13 Jul 2026 10:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wjHl1-00088M-Uj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:35:46 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wjHkz-0001uF-QQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:35:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19E3140139;
 Mon, 13 Jul 2026 14:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EA21F000E9;
 Mon, 13 Jul 2026 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783953340;
 bh=T8p4n2eSgA6Zg6pqEnfewKH6Qm0lGS/uzGWFa5oza50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QVGW/YoKQfDspsaGeSUp7vOdzX6XeVf3N925i47STxxm9NL/BMSp1bxraLHaNcjAy
 ik1N8TsilBB9rCVBa1dnva0K+J5PwlQ+wVLCkwo0+a3i4G9v7c2MJYq1ehwxlxoBuQ
 nH0/APo/W4K813l2xy/pVt/0vwBZPmJLvOXAAS/kCmpg16o2a+LOj5/4W+GqhvuW/x
 O3eR5h9LkYzsrVIhK/GkTB96dXwGIoCsZ82Povk0+GFWY2zp+WoYx1YDHnWh53KwCM
 lne+HyV08sMtV29DieYz84oRJtOP4TwfvWzXuxbJ1JQgrL5VYFqWUiB+kRs4ypnH7v
 ZpNMbW0n2YKPg==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
Subject: [PULL 2/2] linux-user/alpha: populate AT_HWCAP from env->amask
Date: Mon, 13 Jul 2026 16:35:31 +0200
Message-ID: <20260713143533.4641-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713143533.4641-1-deller@kernel.org>
References: <20260713143533.4641-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
 linux-user/alpha/elfload.c    | 11 +++++++++++
 linux-user/alpha/target_elf.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
index 1969f620a5..7be9e466b6 100644
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
index 4987ae3944..dd90c6f783 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -12,6 +12,7 @@
 #define ELF_MACHINE             EM_ALPHA
 
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_ELF_HWCAP          1
 
 /*
  * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
-- 
2.54.0


