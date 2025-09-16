Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09098CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 09:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyRxW-0002hN-UO; Tue, 16 Sep 2025 05:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uyRwx-0002Z2-7P; Tue, 16 Sep 2025 05:26:12 -0400
Received: from [115.124.28.84] (helo=out28-84.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uyRwr-0002fw-ST; Tue, 16 Sep 2025 05:26:09 -0400
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.egLKg9k_1758014506 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 16 Sep 2025 17:21:46 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: richard.henderson@linaro.org, paolo.savini@embecosm.com, npiggin@gmail.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>,
 Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v9 2/2] tests/tcg/riscv64: Add test for vlsseg8e32 instruction
Date: Tue, 16 Sep 2025 17:21:38 +0800
Message-ID: <948d065ae900bc44cbfbb107baff157dab4f1b4a.1758006834.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758006834.git.chao.liu@zevorn.cn>
References: <cover.1758006834.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.84 (deferred)
Received-SPF: pass client-ip=115.124.28.84; envelope-from=chao.liu@zevorn.cn;
 helo=out28-84.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

From: Chao Liu <chao.liu@yeah.net>

This case, it copied 64 bytes from a0 to a1 with vlsseg8e32.

Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Eric Biggers <ebiggers@kernel.org>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   7 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 107 ++++++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 3ca595335d..e52c005f87 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -7,7 +7,7 @@ VPATH += $(TEST_SRC)
 
 LINK_SCRIPT = $(TEST_SRC)/semihost.ld
 LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
+CFLAGS += -march=rv64gcv -mabi=lp64d -g -Og
 
 %.o: %.S
 	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
@@ -24,5 +24,10 @@ EXTRA_RUNS += run-test-mepc-masking
 run-test-mepc-masking: test-mepc-masking
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-vlsseg8e32
+run-vlsseg8e32: QEMU_OPTS := -cpu rv64,v=true $(QEMU_OPTS)
+run-vlsseg8e32: test-vlsseg8e32
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-vlsseg8e32.S b/tests/tcg/riscv64/test-vlsseg8e32.S
new file mode 100644
index 0000000000..bbc79d5e8d
--- /dev/null
+++ b/tests/tcg/riscv64/test-vlsseg8e32.S
@@ -0,0 +1,107 @@
+#
+# QEMU RISC-V Vector Strided Load Instruction testcase
+#
+# Copyright (c) 2025 Chao Liu chao.liu@yeah.net
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+	.option	norvc
+
+	.section .data
+	.align 4
+source_data:
+	.asciz "Test the vssseg8e32 insn by copy 64b and verifying correctness."
+	.equ source_len, 64
+
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+enable_rvv:
+
+	li	x15, 0x800000000024112d
+	csrw	0x301, x15
+	li	x1, 0x2200
+	csrr	x2, mstatus
+	or	x2, x2, x1
+	csrw	mstatus, x2
+
+rvv_test_func:
+	la	a0, source_data
+	li	a1, 0x80020000
+	vsetivli	zero, 1, e32, m1, ta, ma
+	li	t0, 64
+
+	vlsseg8e32.v	v0, (a0), t0
+	addi	a0, a0, 32
+	vlsseg8e32.v	v8, (a0), t0
+
+	vssseg8e32.v	v0, (a1), t0
+	addi	a1, a1, 32
+	vssseg8e32.v	v8, (a1), t0
+
+compare_start:
+	la	a0, source_data
+	li	a1, 0x80020000
+	li	t0, 0
+	li	t1, source_len
+
+compare_loop:
+	# when t0 >= len, compare end
+	bge	 t0, t1, compare_done
+
+	lb	t2, 0(a0)
+	lb	t3, 0(a1)
+	bne	t2, t3, compare_fail
+
+	addi	a0, a0, 1
+	addi	a1, a1, 1
+	addi	t0, t0, 1
+	j	compare_loop
+
+compare_done:
+	# compare ok, return 0
+	li	a0, 0
+	j	_exit
+
+compare_fail:
+	# compare failed, return 2
+	li	a0, 2
+	j	_exit
+
+trap:
+	# When an instruction traps, compare it to the insn in memory.
+	csrr	t0, mepc
+	csrr	t1, mtval
+	lwu	t2, 0(t0)
+	bne	t1, t2, fail
+
+	# Skip the insn and continue.
+	addi	t0, t0, 4
+	csrw	mepc, t0
+	mret
+
+fail:
+	li	a0, 1
+
+# Exit code in a0
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
2.51.0


