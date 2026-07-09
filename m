Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F40DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whe9B-0004ff-PN; Wed, 08 Jul 2026 22:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whe9A-0004fH-5o
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:05:52 -0400
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whe97-0006kh-Tf
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:05:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783562747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M340HysvhMOP5FOFCjNkrui4LPGMUf+jwONfghVISXA=;
 b=hIU1IP+qriQmi9LBvUezV7RRpsfJw2rnmgExKDxLn6KkPQYpm+HG/n4mJBrbY1jARt5UWB
 fVjzQJE+nn1tGceJk5/g22/GR9+JFLJOkJBqqusbFwvsMKb5E10xatI8Vq2vjOsaPVPPTW
 yjheqkCkIuoNS2jvJnhj8gdYWJbmkdc=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, cuitao@kylinos.cn,
 cui.tao@linux.dev
Subject: [PATCH v1 2/2] tests/multiboot: add regression test for translator_ld
 wraparound
Date: Thu,  9 Jul 2026 10:05:29 +0800
Message-ID: <20260709020529.126652-3-cui.tao@linux.dev>
In-Reply-To: <20260709020529.126652-1-cui.tao@linux.dev>
References: <20260709020529.126652-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b5;
 envelope-from=cui.tao@linux.dev; helo=out-181.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Tao Cui <cuitao@kylinos.cn>

Add a multiboot test case that reaches an instruction straddling the
end of the 32-bit address space (0xfffffffe). Before the translator_ld
fix QEMU aborts at translator.c:296; afterwards the case reaches
isa-debug-exit and passes.

The top page (0xfffff000) is SeaBIOS ROM, so the cross-boundary byte is
the ROM's own 0x00 (add r/m8, r8) at 0xffffffff, whose modrm is fetched
from [0x0]. A short exit stub is placed there. The case runs on
qemu-system-i386 since the bug is 32-bit only.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tests/multiboot/Makefile       |  7 +++++-
 tests/multiboot/run_test.sh    |  8 +++++-
 tests/multiboot/wraparound.c   | 46 ++++++++++++++++++++++++++++++++++
 tests/multiboot/wraparound.out |  5 ++++
 4 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 tests/multiboot/wraparound.c
 create mode 100644 tests/multiboot/wraparound.out

diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
index ed4225e7d1..b5045855d7 100644
--- a/tests/multiboot/Makefile
+++ b/tests/multiboot/Makefile
@@ -9,7 +9,7 @@ LIBS=$(shell $(CC) $(CCFLAGS) -print-libgcc-file-name)
 
 AOUT_KLUDGE_BIN=$(foreach x,$(shell seq 1 9),aout_kludge_$x.bin)
 
-all: mmap.elf modules.elf $(AOUT_KLUDGE_BIN)
+all: mmap.elf modules.elf wraparound.elf $(AOUT_KLUDGE_BIN)
 
 mmap.elf: start.o mmap.o libc.o link.ld
 	$(LD) $(LDFLAGS_ELF) -o $@ $^ $(LIBS)
@@ -17,6 +17,11 @@ mmap.elf: start.o mmap.o libc.o link.ld
 modules.elf: start.o modules.o libc.o link.ld
 	$(LD) $(LDFLAGS_ELF) -o $@ $^ $(LIBS)
 
+# link.ld is provided via LDFLAGS_ELF (-T); keep it out of the
+# prerequisite list so $^ does not pass it to ld a second time.
+wraparound.elf: start.o wraparound.o libc.o
+	$(LD) $(LDFLAGS_ELF) -o $@ $^ $(LIBS)
+
 aout_kludge_%.bin: aout_kludge_%.o link.ld
 	$(LD) $(LDFLAGS_BIN) -o $@ $^ $(LIBS)
 
diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index f968bf797e..517281ba49 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -73,9 +73,15 @@ aout_kludge() {
     done
 }
 
+wraparound() {
+    # The translator_ld wraparound bug is i386-only (32-bit address space);
+    # the default x86_64 QEMU does not reproduce it.
+    QEMU="${QEMU%x86_64}i386" run_qemu wraparound.elf -m 4G
+}
+
 make all
 
-for t in mmap modules aout_kludge; do
+for t in mmap modules aout_kludge wraparound; do
 
     echo > test.log
     pass=1
diff --git a/tests/multiboot/wraparound.c b/tests/multiboot/wraparound.c
new file mode 100644
index 0000000000..3b757f3f98
--- /dev/null
+++ b/tests/multiboot/wraparound.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Regression test for the translator_ld crash when an instruction
+ * straddles the end of the 32-bit address space (i386).
+ */
+
+#include "libc.h"
+#include "multiboot.h"
+
+int test_main(uint32_t magic, struct mb_info *mbi)
+{
+    (void) magic;
+    (void) mbi;
+
+    printf("cross-boundary insn at end of address space\n");
+
+    /*
+     * The top page (0xfffff000) is SeaBIOS ROM and cannot be written.
+     * Its byte at 0xffffffff (0x00 = "add r/m8, r8") already crosses the
+     * page boundary into page1 at 0x0, which is exactly the case
+     * translator_ld must handle without aborting.  Reaching 0xfffffffe
+     * runs the ROM's cld, then that add; the add's modrm is fetched from
+     * [0x0], which is RAM, so build a short exit stub there:
+     *
+     *   [0x0] c0                 modrm -> "add al, al" (reg; EIP -> 1)
+     *   [1] eb 00                jmp +0          (EIP -> 3)
+     *   [3] b8 00 00 00 00       mov eax, 0
+     *   [8] e7 f4                out 0xf4, eax   -> isa-debug-exit(0)
+     *
+     * Without the translator_ld fix QEMU aborts while reading the modrm
+     * at the wrapped address 0x0 (translator.c assert).
+     *
+     * Note: this relies on the SeaBIOS byte at 0xffffffff being 0x00
+     * (add r/m8, r8); if that ever changes, the stub below must move.
+     */
+    volatile uint8_t *p = (uint8_t *)0x00000000;
+    p[0] = 0xC0;                        /* modrm: add al, al */
+    p[1] = 0xEB; p[2] = 0x00;           /* jmp +0 -> 0x3 */
+    /* mov eax, 0 */
+    p[3] = 0xB8; p[4] = 0x00; p[5] = 0x00; p[6] = 0x00; p[7] = 0x00;
+    p[8] = 0xE7; p[9] = 0xF4;           /* out 0xf4, eax -> exit 0 */
+
+    asm volatile("mov $0xFFFFFFFE, %%eax; jmp *%%eax" : : : "eax");
+
+    return 1; /* unreachable */
+}
diff --git a/tests/multiboot/wraparound.out b/tests/multiboot/wraparound.out
new file mode 100644
index 0000000000..23cb05ed11
--- /dev/null
+++ b/tests/multiboot/wraparound.out
@@ -0,0 +1,5 @@
+
+
+=== Running test case: wraparound.elf -m 4G ===
+
+cross-boundary insn at end of address space
-- 
2.43.0


