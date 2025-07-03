Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8492DC83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 18:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXObP-0003oO-GO; Thu, 03 Jul 2025 14:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1uXObK-0003nP-6w
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 14:24:03 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1uXObG-0007nf-NS
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 14:24:01 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 9912324002B
 for <qemu-devel@nongnu.org>; Thu,  3 Jul 2025 20:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
 s=1984.ea087b; t=1751567030;
 bh=aONxnhG2/4C5CRB6gZRLVbyh3cNluMhiy15RdumhPlM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=iizuKDkDGjGE6OCBfRVLREmzVrM/1vk+yyLSgcUj+NIThiC13dGTAMBakeheHugn+
 J4haCs+ajFxyWmUlb4v4ec8tQI21PUmptOsYQXqHzrK5wf5AWITjOd13a8LFcsD8aq
 ydMbG6h0BjOzDuPP0ErshwI1QqdgeveydMXJSB/87+mnFxy1dQQzwog+yM3yJrnBhy
 mNd8xmMQ0V0W+m3qBGk66d0xf2FPHrbPHsXw5oC94WDAEx4NzpvOy5ObQBan2c2H1k
 QulnSnmuR8qAEBXGFow4pbqbYHYQosubdYqQUlxcz1HdyQo4c+ur6YORKBFGVXzPoT
 xaaS/dablze4SOPqhSqTQ8Gjj5WeCRLfOdtV5VSmr1mGYdILh9UbvUyzu1ELu8NmKm
 onhko2pCJ4uxU5yeXpPTtmz8TsD+Cr/R4xdRgGRe1gb9Mt9aM3pYmdW9gAzYOqC7Em
 QceOJXW32ikBf3sym58yWTywK9Q0NvpSEN34cjWKJKUVXuxtU8l
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4bY4sK372fz6v0M;
 Thu,  3 Jul 2025 20:23:49 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 2/2] tests/tcg/riscv64: Add test for MEPC bit masking
Date: Thu,  3 Jul 2025 18:21:44 +0000
Message-ID: <20250703182157.281320-3-charmitro@posteo.net>
In-Reply-To: <20250703182157.281320-1-charmitro@posteo.net>
References: <20250703182157.281320-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=charmitro@posteo.net;
 helo=mout01.posteo.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a regression test to verify that MEPC properly masks the lower
bits when an address with mode bits is written to it, as required by
the RISC-V Privileged Architecture specification.

The test sets STVEC to an address with bit 0 set (vectored mode),
triggers an illegal instruction exception, copies STVEC to MEPC in the
trap handler, and verifies that MEPC masks bits [1:0] correctly for
IALIGN=32.

Without the fix, MEPC retains the mode bits (returns non-zero/FAIL).
With the fix, MEPC clears bits [1:0] (returns 0/PASS).

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/test-mepc-masking.S     | 73 +++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-mepc-masking.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 7c1d44d3f4..3ca595335d 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -20,5 +20,9 @@ EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-mepc-masking
+run-test-mepc-masking: test-mepc-masking
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-mepc-masking.S b/tests/tcg/riscv64/test-mepc-masking.S
new file mode 100644
index 0000000000..fccd2a7ac4
--- /dev/null
+++ b/tests/tcg/riscv64/test-mepc-masking.S
@@ -0,0 +1,73 @@
+/*
+ * Test for MEPC masking bug fix
+ *
+ * This test verifies that MEPC properly masks the lower bits according
+ * to the RISC-V specification when vectored mode bits from STVEC are
+ * written to MEPC.
+ */
+
+	.option	norvc
+
+	.text
+	.global _start
+_start:
+	/* Set up machine trap vector */
+	lla	t0, machine_trap_handler
+	csrw	mtvec, t0
+
+	/* Set STVEC with vectored mode (mode bits = 01) */
+	li	t0, 0x80004001
+	csrw	stvec, t0
+
+	/* Clear medeleg to handle exceptions in M-mode */
+	csrw	medeleg, zero
+
+	/* Trigger illegal instruction exception */
+	.word	0xffffffff
+
+test_completed:
+	/* Exit with result in a0 */
+	/* a0 = 0: success (bits [1:0] were masked) */
+	/* a0 != 0: failure (some bits were not masked) */
+	j	_exit
+
+machine_trap_handler:
+	/* Check if illegal instruction (mcause = 2) */
+	csrr	t0, mcause
+	li	t1, 2
+	bne	t0, t1, skip_test
+
+	/* Test: Copy STVEC (with mode bits) to MEPC */
+	csrr	t0, stvec	/* t0 = 0x80004001 */
+	csrw	mepc, t0	/* Write to MEPC */
+	csrr	t1, mepc	/* Read back MEPC */
+
+	/* Check if bits [1:0] are masked (IALIGN=32 without RVC) */
+	andi	a0, t1, 3	/* a0 = 0 if both bits masked correctly */
+
+	/* Set correct return address */
+	lla	t0, test_completed
+	csrw	mepc, t0
+
+skip_test:
+	mret
+
+/* Exit with semihosting */
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
-- 
2.47.2


