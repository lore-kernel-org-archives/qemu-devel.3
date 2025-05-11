Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79763C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6dQ-0005qD-Ux; Sun, 11 May 2025 09:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6dL-0005pg-63
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:22:24 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6dI-0008HZ-3T
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:22:22 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 5ED5D17F6DC
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:22:17 +0200 (CEST)
Received: (qmail 2710 invoked by uid 990); 11 May 2025 13:22:17 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:22:17 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v4 22/23] tests: add test for double-traps on rv64
Date: Sun, 11 May 2025 15:22:04 +0200
Message-ID: <a8da56b19c033e4187dfaf2d279251381f1ff91b.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.956359) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.556359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=eUTnk0SsP7MHhQE4SD1W0GftCCfEm0F/fm+fj9Jx9SM=;
 b=uwdEIFnEKSuPkDvwXS6LerA5JZN972XO3dOmHhzVPNMjo2IREAXTQDcfyfoqX9h8g5LzA6qsSG
 nWedCXH/Cb+yQ9i/mgtqUwyUGtHN8C3MzwuIOWH4wnfzuygs2ehW9XDYzlccHnP7F6w4/3Fd3R4O
 MCPqFgVQ4z/Xx+GimoNQlXryv2HnxlIxkFaMM5g5Fu9H9AwoeNcho6MAbsLhV78uDTBfAZjEdhoP
 lxgkfDjvWEoZo7OrVpSRlhqx/m1bXoQhDqUZWiHTWARCdyocL1JZxXXzK7rV5IommnGCtjP+wNDM
 sDUhWKEhTLXq8dGOwj1cYseyH3EsPTQGSKLrF2u2l/ONeh3ZAMe4NmBUvZX/Do2lkzGRjgeHm6qx
 KRRvVvjvGASCQaBndvRD1LIkg9wT5ukgViOvRvi0R8xgVwjeOssxeqAphN6XtlqfzcjMXUYKfXeL
 W6V31LQb0FxfG7hGJpG6Nnt8PMZMpgCYuKyIOK20Csl5RadilmPQGXrePC8ava4fRDdz1P+ZRrT3
 gzmjezhtmMXShCN51tx6yVM2tTowjeFbrhIE/R/+Qe/lwIuFK2q7GzPTtq70KzsiGWTRORRG1Bez
 SjSDPGU24arIDczJ0ccsarOeDrquX8e3BI7Cf6kUcl2vxwS1mcj747+mghy/lZWk15Koa8yAROgV
 4=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We do have a number of test-caes for various architectures exercising
their interrupt/exception logic. However, for the recently introduced
trap API we also want to exercise the logic for double traps on at leat
one architecture.

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


