Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D32CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV6i-0003F4-6C; Sat, 13 Jun 2026 16:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6b-000377-Qy; Sat, 13 Jun 2026 16:37:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6Z-0003SY-CS; Sat, 13 Jun 2026 16:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382963; bh=5LTbrdiZZKvPaIrNvB8ScBmmfWMVGkV6wGymiQXW1SQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mYg5117z4+yfqRm3ebhzhPWzslfU4nLsSaLvcC4Z/5UWqhbb46RX1UKNLMldgQOIS
 6evwpO2vPGxmp0TeXc9zkkDuwlx+G+d0I86hrl0rjfPfAezfV4rIKeLQ9y3rW5WVNW
 pzBfqfYTNaBDoS0aJXsKwgANe+dWyBNA4xrDvISMRANFLu2hM03iwbP24cASOrPiI/
 tVUPKuCGMp5LThaWAIebCS5alyA+llRYTwK9saZTSNP2Wi8SN1mgzkSgwRjGelxztn
 YEJLYhB8WReV235ktdv40/pwhx/E1454OSdxswMwiWGIqIwAe6WqKLMI3XffABDdIl
 /VBjimRe9vg7g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 597941B6EEA;
 Sat, 13 Jun 2026 23:36:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2A813CE93C;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 16/72] linux-user/mips64: fix mipsn32
 elf_core_copy_regs entry width
Date: Sat, 13 Jun 2026 23:34:42 +0300
Message-ID: <20260613203542.1809153-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

For mipsn32 (TARGET_ABI32=y, TARGET_LONG_BITS=64):
  abi_ulong = uint32_t (4 bytes) — for pointers and ABI-sized fields
  target_ulong = uint64_t (8 bytes) — for general-purpose registers

linux-user/elfload.c allocates target_elf_prstatus using the
mips64/target_elf.h definition where target_elf_gregset_t has
target_ulong reserved[45] (8 bytes each, 360 bytes total).

However, in linux-user/mips64/elfload.c, #include "target_elf.h" inside
the included mips/elfload.c resolves to mips/target_elf.h (compiler
searches the file's own directory first), where the union uses abi_ulong
reserved[45].  For mipsn32 this gives 4-byte entries (180 bytes), not
the 8-byte entries (360 bytes) that elfload.c actually allocated.

Writing via r->reserved[34] therefore lands at byte offset 34*4=136
instead of the correct 34*8=272, silently zeroing the EPC in the core
file.

Fix by casting the pointer to target_ulong * so writes always use 8-byte
slots and land at the offsets matching the allocated layout.

This does not change behavior for mips64 (N64) where abi_ulong already
equals target_ulong (both 8 bytes).

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 6033df08e93df313771b6637230de2d66bdc09cb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mips64/elfload.c b/linux-user/mips64/elfload.c
index 9081ae8111..e4d84a7bd6 100644
--- a/linux-user/mips64/elfload.c
+++ b/linux-user/mips64/elfload.c
@@ -15,16 +15,31 @@
  */
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
-    /* R0 is always 0; r->reserved is zero-initialised by the caller */
+    /*
+     * linux-user/elfload.c allocates target_elf_prstatus using the
+     * definition from mips64/target_elf.h, where target_elf_gregset_t
+     * has target_ulong reserved[45] (8 bytes each = 360 bytes total).
+     *
+     * But in this compilation unit, "#include target_elf.h" resolved to
+     * mips/target_elf.h (wrong directory), so our local target_elf_gregset_t
+     * has abi_ulong reserved[45] which is only 4 bytes each for mipsn32.
+     * Using r->reserved[i] would write to the wrong offsets for mipsn32.
+     *
+     * Cast to target_ulong * to always write 8-byte entries at the correct
+     * positions, matching the layout that elfload.c allocated.
+     */
+    target_ulong *regs = (target_ulong *)r;
+
+    /* R0 is always 0; buffer is zero-initialised by the caller */
     for (int i = 1; i < 32; i++) {
-        r->reserved[i] = tswap64(env->active_tc.gpr[i]);
+        regs[i] = tswap64(env->active_tc.gpr[i]);
     }
-    r->reserved[26] = 0;   /* k0 */
-    r->reserved[27] = 0;   /* k1 */
-    r->reserved[32] = tswap64(env->active_tc.LO[0]);
-    r->reserved[33] = tswap64(env->active_tc.HI[0]);
-    r->reserved[34] = tswap64(env->active_tc.PC);
-    r->reserved[35] = tswap64(env->CP0_BadVAddr);
-    r->reserved[36] = tswap64(env->CP0_Status);
-    r->reserved[37] = tswap64(env->CP0_Cause);
+    regs[26] = 0;   /* k0 */
+    regs[27] = 0;   /* k1 */
+    regs[32] = tswap64(env->active_tc.LO[0]);
+    regs[33] = tswap64(env->active_tc.HI[0]);
+    regs[34] = tswap64(env->active_tc.PC);
+    regs[35] = tswap64(env->CP0_BadVAddr);
+    regs[36] = tswap64(env->CP0_Status);
+    regs[37] = tswap64(env->CP0_Cause);
 }
-- 
2.47.3


