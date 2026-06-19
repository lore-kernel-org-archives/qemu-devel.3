Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95B5CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVto-0001sj-Fs; Fri, 19 Jun 2026 05:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1waVtl-0001sJ-TA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:52:29 -0400
Received: from forward102b.mail.yandex.net ([2a02:6b8:c02:900:1:45:d181:d102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1waVtj-0000XU-Et
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:52:29 -0400
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTPS id D43A7C0125;
 Fri, 19 Jun 2026 12:52:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id JqPRggKd9eA0-madJEkJt; 
 Fri, 19 Jun 2026 12:52:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1781862742; bh=pSzd22esU0WikM6sOZxfXPbr6Ei588/oarU1oXkH1p8=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=ZjmESzjyZzdAjqA55H3f6CUfgyQqPML3T7xW83sR8CZoAwYWh/sc0CrtnmldsWNPt
 1c1JntivSMwPz1KkiCuqiPbHprXgwiu8Jt7FkAdLJt+99MBCwwM3/iH4g1Ega07F4F
 wRndgAAndP/2+ASg3yt6rGM2ukRnZOgmTsMJCFno=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 19 Jun 2026 12:52:20 +0300
Subject: [PATCH 2/2] tests/tcg/riscv32: Add RISC-V 32-bit semihosting test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260619-fix-sign-extended-32-bit-addresses-v1-2-47ae14f8e8c5@maquefel.me>
References: <20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me>
In-Reply-To: <20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781862741; l=5429;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=6uTDDy3BxcoaWKb0pvMT5Oeu6cuLvDjV/ODoLijb13c=;
 b=UaXPk+YGiIKUlSk9UPrvY8VVsc82hLs4UkXG72geJbhVOTpXSwNBawYi+HYx5grvjvXw8aSmn
 g0mTGKoMEeDBHb86F8LNZBobgYksazhZXNK50dBLWVc3Mw3fUTlRErV
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:d102;
 envelope-from=nikita.shubin@maquefel.me; helo=forward102b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Extend the TCG test infrastructure to support 32-bit RISC-V (riscv32)
system tests.

- configure: Add riscv32 to probe_target_compiler() using the same
  container (debian-all-test-cross) as riscv64, with cross prefix
  riscv64-linux-gnu- (the compiler can generate 32-bit code with
  -march=rv32imafdch -mabi=ilp32d).

- tests/tcg/riscv32/: New directory with:
  * Makefile.softmmu-target – build rules for 32-bit softmmu tests
  * semihost.ld – linker script (same as riscv64, RAM at 0x80000000)
  * test-semihosting-open.S – test for SYS_OPEN with auto length (-1)

The semihosting test validates the fix for sign-extended 32-bit
pointers when running riscv32 guests on qemu-system-riscv32.

CFLAGS and LDFLAGS are explicitly set for rv32imafdch/ilp32d ABI,
and LDFLAGS includes -melf32lriscv to produce 32-bit ELF.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 configure                                 |  6 +++-
 tests/tcg/riscv32/Makefile.softmmu-target | 30 +++++++++++++++++
 tests/tcg/riscv32/semihost.ld             | 24 +++++++++++++
 tests/tcg/riscv32/test-semihosting-open.S | 56 +++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index d8bc10060e..2df0811b5d 100755
--- a/configure
+++ b/configure
@@ -1405,7 +1405,7 @@ probe_target_compiler() {
     mips) container_hosts=x86_64 ;;
     ppc) container_hosts=x86_64 ;;
     ppc64|ppc64le) container_hosts=x86_64 ;;
-    riscv64) container_hosts=x86_64 ;;
+    riscv32|riscv64) container_hosts=x86_64 ;;
     s390x) container_hosts=x86_64 ;;
     sh4) container_hosts=x86_64 ;;
     sparc64) container_hosts=x86_64 ;;
@@ -1424,6 +1424,10 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=aarch64-linux-gnu-
         ;;
+      riscv32)
+        container_image=debian-all-test-cross
+        container_cross_prefix=riscv64-linux-gnu-
+        ;;
       alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
         container_image=debian-all-test-cross
         ;;
diff --git a/tests/tcg/riscv32/Makefile.softmmu-target b/tests/tcg/riscv32/Makefile.softmmu-target
new file mode 100644
index 0000000000..eff5b000f0
--- /dev/null
+++ b/tests/tcg/riscv32/Makefile.softmmu-target
@@ -0,0 +1,30 @@
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# RISC-V 32-bit system tests
+#
+
+TEST_SRC = $(SRC_PATH)/tests/tcg/riscv32
+VPATH += $(TEST_SRC)
+
+LINK_SCRIPT = $(TEST_SRC)/semihost.ld
+LDFLAGS = -T $(LINK_SCRIPT)
+CFLAGS += -g -Og
+
+%.o: %.S
+	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
+%: %.o $(LINK_SCRIPT)
+	$(LD) $(LDFLAGS) $< -o $@
+
+QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
+# provide flags for riscv32 as we are using riscv64-linux-gnu-
+CFLAGS += -march=rv32imafdch -mabi=ilp32d
+LDFLAGS += -melf32lriscv
+
+EXTRA_RUNS += run-semihosting-open
+run-semihosting-open: test-semihosting-open
+	$(call run-test, $<, \
+	  $(QEMU) $(QEMU_OPTS)$<)
+
+# We don't currently support the multiarch system tests
+undefine MULTIARCH_TESTS
\ No newline at end of file
diff --git a/tests/tcg/riscv32/semihost.ld b/tests/tcg/riscv32/semihost.ld
new file mode 100644
index 0000000000..ff3b786481
--- /dev/null
+++ b/tests/tcg/riscv32/semihost.ld
@@ -0,0 +1,24 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+ENTRY(_start)
+
+SECTIONS
+{
+    /* virt machine, RAM starts at 2gb */
+    . = 0x80000000;
+    .text : {
+        *(.text)
+    }
+    .rodata : {
+        *(.rodata)
+    }
+    /* align r/w section to next 2mb */
+    . = ALIGN(1 << 21);
+    .data : {
+        *(.data)
+    }
+    .bss : {
+        *(.bss)
+    }
+}
diff --git a/tests/tcg/riscv32/test-semihosting-open.S b/tests/tcg/riscv32/test-semihosting-open.S
new file mode 100644
index 0000000000..acbb31c558
--- /dev/null
+++ b/tests/tcg/riscv32/test-semihosting-open.S
@@ -0,0 +1,56 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+.option norvc
+.text
+.global _start
+_start:
+    # Argument block for SYS_OPEN (each arg is 4 bytes in RV32)
+    la      a1, open_args
+    la      t0, test_filename
+    sw      t0, 0(a1)          # arg0: pointer to filename
+    li      t0, 4              # arg1: "w" (write, create, truncate)
+    sw      t0, 4(a1)
+    li      t0, -1             # arg2: auto length (-1 = 0xffffffff)
+    sw      t0, 8(a1)
+
+    # SYS_OPEN semihosting call
+    li      a0, 0x01
+    .balign 16
+    slli    zero, zero, 0x1f
+    ebreak
+    srai    zero, zero, 0x7
+
+    # Check result: a0 should be a valid file descriptor (not -1)
+    li      t0, -1
+    beq     a0, t0, fail
+
+    # Success
+    li      a0, 0
+    j       exit
+
+fail:
+    li      a0, 1
+
+exit:
+    # Extended semihosting exit
+    la      a1, semiargs
+    li      t0, 0x20026        # ADP_Stopped_ApplicationExit
+    sw      t0, 0(a1)
+    sw      a0, 4(a1)
+    li      a0, 0x20           # TARGET_SYS_EXIT_EXTENDED
+    .balign 16
+    slli    zero, zero, 0x1f
+    ebreak
+    srai    zero, zero, 0x7
+
+    j       .
+
+.data
+.balign 16
+test_filename:
+    .string "testfile.txt"
+open_args:
+    .space 12                  # 3 * 4 bytes
+semiargs:
+    .space 8                   # 2 * 4 bytes

-- 
2.52.0


