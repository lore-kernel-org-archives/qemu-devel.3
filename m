Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC39CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGu3-0006un-Va; Thu, 04 Sep 2025 16:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGtt-0006Ex-D0
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:49:48 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGti-00011m-2l
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:49:45 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 006CC60C3E
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:49:18 +0200 (CEST)
Received: (qmail 2471 invoked by uid 990); 4 Sep 2025 20:49:18 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:49:18 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v6 25/25] tests: add test with interrupted memory accesses on
 rv64
Date: Thu,  4 Sep 2025 22:49:00 +0200
Message-ID: <f74becaa58fe129897639d126a321afdc7ef2d05.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.796651) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.396651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=mVLyiyy1HWjSWhu1/Q5w+icoVuven8S3d7VhRcdbntg=;
 b=TY0pT536o+ZHiEnQhsgtRx4ZNUf6S2pZiLT1gb/yjcik9RKdUnmUjTkyG5NGEd9mQkc1Jb0afI
 vo/L5CAqROcyN2s9IpYFsHlQ8u07uhcHrvdqTow9sauWmKKigBjRwy4zUxns5VS8rhmOEnpyCr+Y
 nbsF6kqSU+x71OIr++/1EddorRfWcpJxv8PdjYqMD05obdoL5IYygKi7mtSL1eJ8d9xMJmOWp2mr
 /yqYNs9L3qRTUl0frDIGOjcgGt57P8cP3tMCOX+PelVwjHt1vOb0UfRbpwfKvKYMOZtzTquBVzqG
 43IuC/yM1kO0+LFt0qaFURxwxaOf8i7evaF+Uz2HTvr4ahejBf6tECerYTQGGpQkDHvZJP5mwdSi
 k/NfcqdQPaiJkGD4yn+/N0/J/N+SZZFMkN9uHmXuiYCx8QUsH5M+WaySrKxMPcPu/jcgfrxzbnN5
 WOoryyWzZ/VLWiEHv7m8rb+5B0d07X794jJFihbn5cF893Qptl5cdbOXKEDA9GYL9FHd2dTpwaMN
 5y0v5x/w2lftroUJvxGn84a11+0HW/I0UKgA9jzSEhZqFBnOlk1/cZBD5OJjCP+TrktkVJ0bJWs1
 e1nTAIWJkmxuJ216aicRogsNkC7EwZqXkGNgPhzIYg0K2jYo5bwjWHl5CvQqrI4SWNeKsHR+Y4ja
 o=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Because the condition for triggering misbehaviour may not be
deterministic and the cross-section between memory accesses and
interrupt handlers may be small, we have to place our trust in large
numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, we
decided to loop for a fixed amount of real-time. This avoids the test
running into a time-out on slower machines while enabling a high number
of possible interactions on faster machines.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
 tests/tcg/riscv64/interruptedmemory.S     | 67 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 1a71a78653..d8f92b8e61 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -30,5 +30,11 @@ run-plugin-doubletrap: doubletrap
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-plugin-interruptedmemory
+run-plugin-interruptedmemory: interruptedmemory
+	$(call run-test, $<, \
+	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
+	  $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
new file mode 100644
index 0000000000..a32d672849
--- /dev/null
+++ b/tests/tcg/riscv64/interruptedmemory.S
@@ -0,0 +1,67 @@
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
+	# Find out when to stop
+	call	rtc_get
+	li	t0, 60
+	slli	t0, t0, 30 # Approx. 10e9 ns
+	add	t0, t0, a0
+
+	# Loop with memory accesses
+	la	t1, semiargs
+0:
+	ld	t2, 0(t1)
+	sd	t2, 0(t1)
+	call	rtc_get
+	bltu	a0, t0, 0b
+
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


