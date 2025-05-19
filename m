Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C6C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2MB-0008HM-OH; Mon, 19 May 2025 11:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2Lm-0007xJ-PU
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:24:25 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2Lj-0005ob-8B
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:24:22 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id E87A9180EAB
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:24:17 +0200 (CEST)
Received: (qmail 5968 invoked by uid 990); 19 May 2025 15:24:17 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:24:17 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v5 24/25] tests: add test for double-traps on rv64
Date: Mon, 19 May 2025 17:24:08 +0200
Message-ID: <83fc9462a895d5c0d9edb9e8bcce980c27d8fc81.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.951293) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.551293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=oVnnQOlaHDcgULY7mP8Q+DwiS6v0Cp7ANlJ4mQwWq6E=;
 b=BZ0+ABjWajvIgKu6PBcdFdjhGksEzA1PUheRsyIz4rcgCkX/vqZ4lmuPEdW1qathmqDKHT5IPr
 gRZ3rKwC5UOoGxUw6gDWDbY7RzvXaDR/e5H51LjITYemhlZt2vYBNcxJqFgfMS5pLNlt+IXigZtS
 W56UqMWCnYCUqzkVrG1pwjWJEKe0QZTsafONbQlGhxNqLCoweIqmybyGja0f8RK6+1NkX7tNu0jg
 drtRx9jEcjf4qQqNPMAgg82TudbtwaiT3sCtZh9UIJvHjW8GEbaACqLipx1WsOnR1ikS6MXjIX0H
 jMcSK6AjxQUP7ICxbDycZKdJVbRaYKllQ6uUvx3oejkLGX94lUD0i0KXfkP5GSoj+ycjpX9vdsdf
 23L76IddwiDBU9yYw/mjNMJ5Tsc+ljjFdgfwxFCE1dpIGapN5tZY2vn4Yp8Jl16M3YLMcS8MAqMc
 VGslOmiv//n0WiuwbBjuhpXdWuU4Sai2O6Nk+EkdHGuVU5TYycJdKIInW9u5s6a3x415WcIYovBz
 yEW2ssxckRWKp7eWqlFhjlFmPDXChOcA7/LBItz342fz82VgthJj39kiTOugLZcviWuBiXghk6uX
 ZYUnbfEeGRDFYMllyAvy93/G71HwqQ+OmqITROneDr9uWmkBFsftEqK1UYVsVJ22NHnlJ3Vygngv
 A=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We do have a number of test-case for various architectures exercising
their interrupt/exception logic. However, for the recently introduced
trap API we also want to exercise the logic for double traps on at least
one architecture.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
 tests/tcg/riscv64/doubletrap.S            | 73 +++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tests/tcg/riscv64/doubletrap.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 7c1d44d3f4..5fba973e18 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -20,5 +20,11 @@ EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-plugin-doubletrap
+run-plugin-doubletrap: doubletrap
+	$(call run-test, $<, \
+	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
+	  $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/doubletrap.S b/tests/tcg/riscv64/doubletrap.S
new file mode 100644
index 0000000000..b61089c9c1
--- /dev/null
+++ b/tests/tcg/riscv64/doubletrap.S
@@ -0,0 +1,73 @@
+	.option norvc
+
+	.text
+	.global _start
+_start:
+	# Set up vectored interrupts
+	lla	t0, trap
+	add	t0, t0, 1
+	csrw	mtvec, t0
+
+	# Enable sw interrupts
+	csrrsi	zero, mie, 0x8
+	csrrsi	zero, mstatus, 0x8
+
+	# Engage the double trap: we trigger an machine-level software
+	# interrupt, which will trap to an illegal instruction
+	lui	t1, 0x02000
+	li	t0, 1
+	sw	t0, 0(t1)
+
+	# If we still not went out via the software interrupt route after a
+	# short while, we failed the test.
+	lui	t0, 0x1
+0:
+	addi	t0, t0, -1
+	bnez	t0, 0b
+	j	fail
+
+trap:
+	j	illegal_insn # Exceptions
+	j	fail # Supervisor software interrupt
+	j	fail
+	.insn	i CUSTOM_0, 0, x0, x0, 0 # Machine software interrupt
+	j	fail
+	j	fail # Supervisor timer interrupt
+	j	fail
+	j	fail # Machine timer interrupt
+	j	fail
+	j	fail # Supervisor external interrupt
+	j	fail
+	j	fail # Machine external interrupt
+	j	fail
+	j	fail # Counter overflow interrupt
+	j	fail
+	j	fail
+
+illegal_insn:
+	# Check whether we really got an illegal instruction
+	csrr	t0, mcause
+	li	t1, 2
+	bne	t0, t1, fail
+	li	a0, 0
+	j	_exit
+fail:
+	li	a0, 1
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.49.0


