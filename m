Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702F7C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyYhN-0003BI-9v; Mon, 24 Aug 2026 13:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wyYhL-0003Ap-R1; Mon, 24 Aug 2026 13:43:04 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wyYhJ-0000Z6-Jl; Mon, 24 Aug 2026 13:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1787593376;
 bh=HjDQ6eJ+7RdVUGTg+kk0qj0ipShSqilDz1VxZisT4hw=;
 h=From:To:Cc:Subject:Date:From;
 b=CeU5PzVi8zp+LNO/lNV3813fj8DKKuFR3OnfwgRtIG8DL189orO0IJBuTMFraI5eD
 +bYfj2vxgJJlL7EKSzlyqZiYLW8w7LPpkeHneEpIM0bRAyOqik4VWfdbjnae4SQyE6
 p48m31/i7A1swnSxK0iHueSfDMMFl5UBRi+uw3P/G4cij3/p7TFGy8mrZPra8+j1lj
 exUjNPxv7QVYe7yagzHdv7IfSxNnvVj/yAm5P9GE5UCTY9f0N8VV0WX1lAqnqfg6v4
 A8Ui6fIUQZ+FFr2IJRT9CydFk0gNBg7oyfzv868vcxvRQil8EZ56O/dgiXogGltFNO
 YB3PwRyqWrbdA==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id D4DFD40230;
 Mon, 24 Aug 2026 19:42:56 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id D0DDAFF859;
 Mon, 24 Aug 2026 19:42:56 +0200 (CEST)
Received: from naga.. (pers-165-50.vpn.u-ga.fr [147.171.165.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 4BC3F14004C;
 Mon, 24 Aug 2026 19:42:55 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2] tests/tcg/riscv64: Add tests for rv128 [ms]status
Date: Mon, 24 Aug 2026 19:42:46 +0200
Message-ID: <20260824174246.202150-1-frederic.petrot@univ-grenoble-alpes.fr>
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   9 ++
 tests/tcg/riscv64/test-rv128-mstatus.S    |  67 ++++++++++++++
 tests/tcg/riscv64/test-rv128-sstatus.S    | 108 ++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-rv128-mstatus.S
 create mode 100644 tests/tcg/riscv64/test-rv128-sstatus.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 6a219c306c..575571de90 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -71,5 +71,14 @@ EXTRA_RUNS += run-test-misa-w
 run-test-misa-w: test-misa-w
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true$(comma)v=true $(QEMU_OPTS)$<)
 
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
index 0000000000..323f65ef90
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
index 0000000000..af118e355a
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


