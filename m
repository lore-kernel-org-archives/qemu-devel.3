Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7F4C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMTB-0005fJ-J8; Fri, 21 Aug 2026 06:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wxMTA-0005eX-5Z; Fri, 21 Aug 2026 06:27:28 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wxMT8-0004ym-5y; Fri, 21 Aug 2026 06:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1787308044;
 bh=Mpr49LYowtuQ5WddJh0TKsGoDVI0lhtUXA2egR/EQjA=;
 h=From:To:Cc:Subject:Date:From;
 b=KqpsexbdKfJytaejBcRL9hfY1ksb6ItZLdk907/+wQvZA4KuetHAryXOn37mwVFp7
 xdj6GnXUswnRW65ecIvdh/+6EF9KxN9SvJeQyOpmCKs2ArLMo+NiC64Dl98E9C/7Qo
 9Hz7REQZjB934QgbrfdEw3Drxdh5nE/pDCi896ywnYnEgcFFWllMU5ijUYhcKM/TO6
 JjfwRtPDaGoLn/jssAgw2z+2NisgaOZuDbB8hkSKIO4pJH5E0g+6tXZaFHSq83JsDj
 nNAeXYtQUN8ptvC8JA0kZkk6txj42Kjq9WZfKj7d8xjvuT6XKFo/Feup8q1PxRwTqE
 k6u6G6uEo6spw==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id B90B04021B;
 Fri, 21 Aug 2026 12:27:24 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id B4F2AFF856;
 Fri, 21 Aug 2026 12:27:24 +0200 (CEST)
Received: from naga.. (unknown [78.240.82.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id BB05D140046;
 Fri, 21 Aug 2026 12:27:21 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH] tests/tcg/riscv64: Add tests for rv128 [ms]status
Date: Fri, 21 Aug 2026 12:27:29 +0200
Message-ID: <20260821102729.997150-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Adding asm tests to check that mstatus and sstatus are updated as
expected in an rv128 cpu.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   9 ++
 tests/tcg/riscv64/test-rv128-mstatus.S    |  67 ++++++++++++++
 tests/tcg/riscv64/test-rv128-sstatus.S    | 108 ++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-rv128-mstatus.S
 create mode 100644 tests/tcg/riscv64/test-rv128-sstatus.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index fac0474746..83d621c5d0 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -67,5 +67,14 @@ EXTRA_RUNS += run-test-zicclsm-off
 run-test-zicclsm-off: test-zicclsm-off
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS)$<)
 
+# Test for rv128
+EXTRA_RUNS += run-test-rv128-mstatus
+run-test-rv128-mstatus: test-rv128-mstatus
+	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
+
+EXTRA_RUNS += run-test-rv128-sstatus
+run-test-rv128-sstatus: test-rv128-sstatus
+	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-rv128-mstatus.S b/tests/tcg/riscv64/test-rv128-mstatus.S
new file mode 100644
index 0000000000..e8b5101e26
--- /dev/null
+++ b/tests/tcg/riscv64/test-rv128-mstatus.S
@@ -0,0 +1,67 @@
+/*
+ * Test rv128 mstatus update and access
+ * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define srli(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
+
+    .option norvc
+
+    .text
+    .globl _start
+_start:
+    csrr    s0, misa
+    srli    (s1, s0, 126)
+    li      s0, 3
+    bne     s1, s0, fail
+
+    # Check UXL and SXL are set to RV128 too
+    csrr    s0, mstatus
+    srli    (s1, s0, 32)
+    andi    s1, s1, 0xf
+    li      s0, 0xf
+    bne     s1, s0, fail
+
+    # Mark FPU dirty to check for SD
+    .equiv  MSTATUS_FS, 0x00006000
+    li      s0, MSTATUS_FS
+    csrs    mstatus, s0
+    # Do some useless computation
+    fmadd.s f3, f2, f1, f0
+    fmax.s  f0, f1, f2
+    # Check SD has changed where expected
+    csrr    s0, mstatus
+    srli    (s1, s0, 127)
+    li      s0, 1
+    bne     s1, s0, fail
+    # Mark FPU clean (2 in FS place)
+    li      s0, ~0x00004000
+    csrc    mstatus, s0
+    csrr    s0, mstatus
+    srli    (s1, s0, 13)
+    andi    s1, s1, 3
+    li      s0, 2
+    bne     s1, s0, fail
+    li      a0, 0
+    j       _exit
+fail:      
+    li      a0, 1
+_exit:     
+    lla     a1, semiargs
+    li      t0, 0x20026 # ADP_Stopped_ApplicationExit
+    sd      t0, 0(a1)
+    sd      a0, 8(a1)
+    li      a0, 0x20    # TARGET_SYS_EXIT_EXTENDED
+
+    # Semihosting call sequence
+    .balign 16
+    slli   zero, zero, 0x1f
+    ebreak
+    srai   zero, zero, 0x7
+    j      .
+
+    .data
+    .balign 16
+semiargs:
+    .space  16
diff --git a/tests/tcg/riscv64/test-rv128-sstatus.S b/tests/tcg/riscv64/test-rv128-sstatus.S
new file mode 100644
index 0000000000..32f792a6aa
--- /dev/null
+++ b/tests/tcg/riscv64/test-rv128-sstatus.S
@@ -0,0 +1,108 @@
+/*
+ * Test rv128 sstatus update and access
+ * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define srli(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
+
+    .option norvc
+
+    .text
+    .globl _start
+_start:
+    // Check RV128 is running
+    csrr     s0, misa
+    srli     (s1, s0, 126)
+    li       s0, 3
+    bne      s1, s0, fail
+
+    // Minimal pmp settings
+#define PMP_NAPOT 0x18
+#define PMP_R     0x01
+#define PMP_W     0x02
+#define PMP_X     0x04
+
+    li       s0, -1
+    csrw     pmpaddr0, s0
+    li       s0, PMP_NAPOT | PMP_R | PMP_W | PMP_X
+    csrw     pmpcfg0, s0
+
+    la       s0, backm
+    csrw     mtvec, s0
+
+    // Set MPP to supervisor
+    csrr     s0, mstatus
+    li       s1, ~0x1800 // mask
+    and      s1, s1, s0
+    li       s0, 0x0800  // supervisor
+    or       s1, s1, s0
+    csrw     mstatus, s1
+    // Change to supervisor mode
+    la       s0, 1f
+    csrw     mepc, s0
+    mret
+1:
+    // Check UXL is set to RV128
+    csrr     s0, sstatus
+    srli     (s1, s0, 32)
+    andi     s1, s1, 0x3
+    li       s0, 3
+    bne      s1, s0, fail
+    // Check SPP if is set to 1, since we
+    // come from machine mode
+    srli     (s1, s0, 8)
+    andi     s1, s1, 0x1
+    // Actually this check fails, so test 0
+    li       s0, 0
+    bne      s1, s0, fail
+
+    // Mark FPU dirty to check for SD
+    .equiv   MSTATUS_FS, 0x00006000
+    li       s0,  MSTATUS_FS
+    csrs     sstatus, s0
+    // Do some fun useless computation
+    fmadd.s  f3, f2, f1, f0
+    fmax.s   f0, f1, f2
+    // Check SD has changed where expected
+    csrr     s0, sstatus
+    srli     (s1, s0, 127)
+    li       s0, 1
+    bne      s1, s0, fail
+    // Mark FPU clean (2 in FS place)
+    li       s0, ~0x00004000
+    csrc     sstatus, s0
+    csrr     s0, sstatus
+    srli     (s1, s0, 127)
+    li       s0, 0
+    bne      s1, s0, fail
+
+    // Let's go back to machine mode to exit
+    ecall
+
+    // mtvec bit 1:0 indicate mode, 00 is Direct, what
+    // we want in this simple test
+    .align 4
+backm:
+    li      a0, 0
+    j       _exit
+fail:      
+    li      a0, 1
+_exit:     
+    lla     a1, semiargs
+    li      t0, 0x20026 # ADP_Stopped_ApplicationExit
+    sd      t0, 0(a1)
+    sd      a0, 8(a1)
+    li      a0, 0x20    # TARGET_SYS_EXIT_EXTENDED
+
+    # Semihosting call sequence
+    .balign 16
+    slli   zero, zero, 0x1f
+    ebreak
+    srai   zero, zero, 0x7
+    j      .
+
+    .data
+    .balign 16
+semiargs:
+    .space  16
-- 
2.43.0


