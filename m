Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2E1CCD183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAVBv-0001i3-CX; Sun, 19 Oct 2025 11:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAVBs-0001Zc-WC
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:19:25 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAVBo-0003Uy-Em
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:19:24 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id B707F60AE3
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:19:18 +0200 (CEST)
Received: (qmail 26402 invoked by uid 990); 19 Oct 2025 15:19:18 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:19:14 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v8 25/25] tests: add test with interrupted memory accesses on
 rv64
Date: Sun, 19 Oct 2025 17:18:44 +0200
Message-ID: <5a95ff9e573a245ae5aba91ecc01c5e14579580b.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: --
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-0.127773) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -2.727773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=JtHctVu4zzyt5rbO+qSrHWtDCImC8Y50wo+oZsOBoUM=;
 b=F+buPZMGtj24s5QGssO2bXwXfqfbAtnJNJos+Ftq8YAbOH1cqeQ/RJ1Q2zOIFQldMqjCgh6/lB
 ee8NmZNQovad/+noGqbpf1PJhUpxAMEQb8kQ1sJNRCXSgiI33t7JrjuHQ2XPm959i2h6jPV7Rieq
 NiIsz8TZcLATZIYWp7lNQTStys19kI9gEnPnAlC8a94D1p4iCoxajEuXTgFJEXwNI2OIBU1bMjo6
 jibpOOSm+ent9FHWub3vkjahEFvfnn86RqmO7hZ2xIva/c3Rxf7+MD2CyFVJ9wNVQxgzz2MG95KC
 WA5z7ltbx6ZzG0wJHBEY3EACkolxiokdlZGU2XhCuIe0wvYgvTA7AjWJrMhIeuMjNELFG2dlqNWK
 2eKMhVch2g7Xj6TdKopv8tSjy69T21tNQbT2sUy0iWgckQwRkYEESD0Tb1CRjIE4vAqCvv3o04mN
 D9/6B5EMR0zTWwO/Oxw6o4SHl8V5tyuW2gk7n973OefNIMsNEE7xZklxmwaki7o4lJmsvMZ4a7xu
 8P7jEgIefvLODd0eYeTd3rbL5tXbkTXIE8p0Wk+PbUf/Q6/PCwNnBzCoW/ntmW6iFB5S8690ON7A
 y4z3jF5pzv/oRbIn0X5VrPjT6Rg0aQ0aq0gLMslght7YDwabqAUZAMd66Kd78rkTMkJYhzaKuBjt
 M=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
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

This test aims at catching API misbehaviour w.r.t. the interaction
between interrupts and memory accesses, such as the bug fixed in

    27f347e6a1d269c533633c812321cabb249eada8
    (accel/tcg: also suppress asynchronous IRQs for cpu_io_recompile)

Because the condition for triggering misbehaviour may not be
deterministic and the cross-section between memory accesses and
interrupt handlers may be small, we have to place our trust in large
numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, we
decided to loop for a fixed amount of real-time. This avoids the test
running into a time-out on slower machines while enabling a high number
of possible interactions on faster machines.

The test program sends a single '.' per 1000000 loads/stores over the
serial. This output is not captured, but may be used by developers to
gauge the number of possible interactions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
 tests/tcg/riscv64/interruptedmemory.S     | 97 +++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index d9c0036eb4..eb1ce6504a 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -30,5 +30,11 @@ run-plugin-doubletrap: doubletrap
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-plugin-interruptedmemory
+run-plugin-interruptedmemory: interruptedmemory
+	$(call run-test, $<, \
+	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
+	  $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
new file mode 100644
index 0000000000..cd9073ee31
--- /dev/null
+++ b/tests/tcg/riscv64/interruptedmemory.S
@@ -0,0 +1,97 @@
+	.option norvc
+
+	.text
+	.global _start
+_start:
+	# Set up trap vector
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	# Set up timer
+	lui	t1, 0x02004
+	sd	zero, 0(t1) # MTIMECMP0
+
+	# Enable timer interrupts
+	li	t0, 0x80
+	csrrs	zero, mie, t0
+	csrrsi	zero, mstatus, 0x8
+
+	# Set up UART
+	lui	t1, 0x10000
+	li	a0, 0x80	# DLAB=1
+	sb	a0, 3(t1)
+	li	a0, 1		# Full speed
+	sw	a0, 0(t1)
+	li	a0, 0x03	# 8N1, DLAB=0
+	sb	a0, 3(t1)
+
+	# Run test for around 60s
+	call	rtc_get
+	li	t0, 30
+	slli	t0, t0, 30 # Approx. 10e9 ns
+	add	t0, t0, a0
+0:
+	# Tight loop with memory accesses
+	li	a1, 1000000
+	la	a2, semiargs
+1:
+	ld	a0, 0(a2)
+	sd	a0, 0(a2)
+	addi	a1, a1, -1
+	bnez	a1, 1b
+
+	li	a0, '.'
+	call	send_byte
+	call	rtc_get
+	bltu	a0, t0, 0b
+
+	li	a0, '\n'
+	call	send_byte
+
+	# Exit
+	li	a0, 0
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
+
+	j	.
+
+rtc_get:
+	# Get current time from the goldfish RTC
+	lui	t3, 0x0101
+	lw	a0, 0(t3)
+	lw	t3, 4(t3)
+	slli	t3, t3, 32
+	add	a0, a0, t3
+	ret
+
+send_byte:
+	# Send a single byte over the serial
+	lui	t3, 0x10000
+	lb	a1, 5(t3)
+	andi	a1, a1, 0x20
+	beqz	a1, send_byte
+	sb	a0, 0(t3)
+	ret
+
+	.balign 4
+trap:
+	lui	t5, 0x0200c
+	ld	t6, -0x8(t5) # MTIME
+	addi	t6, t6, 100
+	lui	t5, 0x02004
+	sd	t6, 0(t5) # MTIMECMP
+	mret
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.49.1


