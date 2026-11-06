Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D360A2601
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=4IqrdMfa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMej-0007Kv-HW; Fri, 06 Nov 2026 11:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeZ-0007EK-HI; Fri, 06 Nov 2026 11:18:59 -0500
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeV-0004E8-Kq; Fri, 06 Nov 2026 11:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1793981932;
 bh=DSo6OEZ9+BpqyQqB9FFmN9tmeE9uqLngPmCiP7X0dxI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=4IqrdMfadJVLEZ3mmH/QW8JegUJKU+5rrv/xmkJPu40TLajy3eehVkb/F2v/Bola2
 hM0nRFjVvIHuhKOlY3vTNX3mpRW/vYdom3tWVtWcO1zjG9uFYycydmDhjrywZKxnLX
 1qZbHyZ8a0yfcVnP6S0bW5UwKr637qtuifhBoyuGW0AcG5IYcHoFJeIqA+iHpWJAN4
 bEcprzxnuctDDkTMIBADu1k7iRXo7geNVxDmvVc+bD66euzOx9x7c7LuCHc9KxMTSx
 llrO7hlhZmdvEWNGASFCsfGp2UB57IpFjSFaH3PI8DZJ37qqmFXTFMoWni/FsaMjYU
 TvgDrqcjzCQFQ==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 6DC80402B5;
 Fri,  6 Nov 2026 17:18:52 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 69D86FF855;
 Fri,  6 Nov 2026 17:18:52 +0100 (CET)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 383CC40056;
 Fri, 06 Nov 2026 17:18:52 +0100 (CET)
From: frederic.petrot@univ-grenoble-alpes.fr
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v3 4/4] target/riscv: [ms]cause tcg tests for x-rv128
Date: Fri,  6 Nov 2026 17:18:43 +0100
Message-ID: <20261106161843.2075117-5-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106161843.2075117-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20261106161843.2075117-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Add tcg tests for the rv128 mcause and scause registers.
This mainly checks the behavior of the read and write instructions,
as other exceptions (at least in s-mode) are catched by the
semihosting mechanism.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 tests/tcg/riscv64/system/meson.build  |  14 ++++
 tests/tcg/riscv64/test-rv128-mcause.S | 101 ++++++++++++++++++++++++++
 tests/tcg/riscv64/test-rv128-scause.S |  94 ++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-rv128-mcause.S
 create mode 100644 tests/tcg/riscv64/test-rv128-scause.S

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..b462d5f4ab 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -53,6 +53,20 @@ tests += {
   }
 }
 
+tests += {
+  'test-rv128-mcause.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'x-rv128', qemu_args],
+  }
+}
+
+tests += {
+  'test-rv128-scause.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'x-rv128', qemu_args],
+  }
+}
+
 tests += {
   'test-vle32ff.S': {
     'cflags': cflags + ['-march=rv64gcv'],
diff --git a/tests/tcg/riscv64/test-rv128-mcause.S b/tests/tcg/riscv64/test-rv128-mcause.S
new file mode 100644
index 0000000000..5dd7b543e1
--- /dev/null
+++ b/tests/tcg/riscv64/test-rv128-mcause.S
@@ -0,0 +1,101 @@
+/*
+ * Test rv128 mcause update and access
+ * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define slli(rd, rs1, imm) .insn i  0b0010011, 0b001, rd, rs1, imm & 0b1111111
+#define srli(rd, rs1, imm) .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
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
+    # Write some values in mcause (wlrl)
+    # 13 is valid for both interruptions and exceptions
+    li      s0, 13
+    csrw    mcause, s0
+    csrr    s1, mcause
+    bne     s1, s0, fail
+
+    li      s1, 1
+    slli    (s1, s1, 127)
+    or      s1, s1, s0
+    csrw    mcause, s1
+    csrr    s0, mcause
+    bne     s1, s0, fail
+
+    # Write an illegal value, but as for the 32/64-bit versions,
+    # we keep it as it is
+    li      s1, -1
+    csrw    mcause, s1
+    csrr    s0, mcause
+    bne     s1, s0, fail
+
+    # Set the trap vector
+    la       s0, tvecall
+    csrw     mtvec, s0
+    # Do an ecall to make sure mcause is properly set
+    ecall
+    # Set the trap vector
+    la       s0, tvbreak
+    csrw     mtvec, s0
+    # Do an ecall to make sure mcause is properly set
+    ebreak
+    li      a0, 0
+    j       _exit
+
+    # mtvec bit 1:0 indicate mode, 00 is Direct, what
+    # we want in this simple test
+    .align 4
+tvecall:
+    csrr    s0, mcause
+    li      s1, 11 # ecall from m-mode
+    bne     s1, s0, fail
+    csrr    s0, mepc
+    addi    s0, s0, 4
+    csrw    mepc, s0
+    mret
+
+    .align 4
+tvbreak:
+    csrr    s0, mcause
+    li      s1, 3 # break
+    bne     s1, s0, fail
+    csrr    s0, mepc
+    addi    s0, s0, 4
+    csrw    mepc, s0
+    mret
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
diff --git a/tests/tcg/riscv64/test-rv128-scause.S b/tests/tcg/riscv64/test-rv128-scause.S
new file mode 100644
index 0000000000..823bdbac81
--- /dev/null
+++ b/tests/tcg/riscv64/test-rv128-scause.S
@@ -0,0 +1,94 @@
+/*
+ * Test rv128 mcause update and access
+ * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define slli(rd, rs1, imm) .insn i  0b0010011, 0b001, rd, rs1, imm & 0b1111111
+#define srli(rd, rs1, imm) .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
+
+    .option norvc
+
+    .text
+    .globl _start
+_start:
+    # Check RV128 is running
+    csrr    s0, misa
+    srli    (s1, s0, 126)
+    li      s0, 3
+    bne     s1, s0, fail
+
+    # Minimal pmp settings
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
+    # Set MPP to supervisor
+    csrr    s0, mstatus
+    li      s1, ~0x1800 // mask
+    and     s1, s1, s0
+    li      s0, 0x0800  // supervisor
+    or      s1, s1, s0
+    csrw    mstatus, s1
+    # Change to supervisor mode
+    la      s0, 1f
+    csrw    mepc, s0
+    mret
+1:
+    # Check UXL is set to RV128
+    csrr    s0, sstatus
+    srli    (s1, s0, 32)
+    andi    s1, s1, 0xf
+    li      s0, 0x3
+    bne     s1, s0, fail
+
+    # Write some values in scause (wlrl)
+    # 13 is valid for both interruptions and exceptions
+    li      s0, 13
+    csrw    scause, s0
+    csrr    s1, scause
+    bne     s1, s0, fail
+
+    li      s1, 1
+    slli    (s1, s1, 127)
+    or      s1, s1, s0
+    csrw    scause, s1
+    csrr    s0, scause
+    bne     s1, s0, fail
+
+    # Write an illegal value, but as for the 32/64-bit versions,
+    # we keep it as it is
+    li      s1, -1
+    csrw    scause, s1
+    csrr    s0, scause
+    bne     s1, s0, fail
+
+    li      a0, 0
+    j       _exit
+
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


