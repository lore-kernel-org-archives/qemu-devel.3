Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B44CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9fy-00035A-3P; Sat, 17 Oct 2026 15:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9eo-0000no-L5; Sat, 17 Oct 2026 15:01:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9em-0004Ji-Ki; Sat, 17 Oct 2026 15:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263431; bh=YG5Yd+2JiC+IqULO3jNH652vwHwcVLhTsiVUVIM1sSM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bRtDWbI0yMGb3GWwPerDxepSoQNcw2rj92E1AWFRIKHjivOeBVdZt6pBJdY9rcDKg
 yDuM0/811DTJUDXxcKfTuKkEq1sHwCHt203YQQlsfnjxhLAq81zmvomQvwWNqFK6gv
 4JZq42RBT5vIyu7qYXcpgUz7XFvVRfMQ2bPCpJS0ZKi2nSnyvdKsUeinzqKstUVe3E
 QouAX8O3OJkQe1GtK25VKBw6g2NwyByOafqOtHeZOnElMURSv7jGwAjwukly7kKHiS
 3P3bYjpTMf/V7Wo+hB3+daWA7RRFREB9t2woRsIz/TThqjc09ft+X3wXMuQJy5kFxf
 k7q+dBe4+SW+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D4311DE6DD;
 Sat, 17 Oct 2026 21:57:11 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 500264433A5;
 Sat, 17 Oct 2026 21:57:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 58/63] target/riscv: stop translating after WFI
Date: Sat, 17 Oct 2026 21:55:14 +0300
Message-ID: <20261017185528.722197-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

helper_wfi() never returns to translated code: it either raises an
exception or exits the CPU loop after marking the CPU as halted. However,
trans_wfi() leaves the translation state as DISAS_NEXT, so instructions
following WFI can be included in the same TB.

With icount enabled, this makes the following instruction part of the TB's
instruction count when WFI exits, causing minstret to be incremented once
too many. Set DISAS_NORETURN after emitting the helper.

Add a TCG test for both reported cases: WFI waking for a locally enabled
pending interrupt with mstatus.MIE clear, and WFI taking a timer interrupt.

Cc: qemu-stable@nongnu.org
Fixes: 55c2a12cbcd3 ("RISC-V TCG Code Generation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4230
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260910025324.54990-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 410166b550ccacdc46065af00e68cea4d60efb65)
(Mjt: adjust test to before make=>meson conversion)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..3c5f92f608 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -145,6 +145,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
     decode_save_opc(ctx, 0);
     gen_update_pc(ctx, ctx->cur_insn_len);
     gen_helper_wfi(tcg_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 #else
     return false;
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 7c1d44d3f4..9bda32fc2f 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -20,5 +20,9 @@ EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-minstret-wfi
+run-test-minstret-wfi: test-minstret-wfi
+	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-minstret-wfi.S b/tests/tcg/riscv64/test-minstret-wfi.S
new file mode 100644
index 0000000000..0fd0158d5b
--- /dev/null
+++ b/tests/tcg/riscv64/test-minstret-wfi.S
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+	li	s3, 0
+
+	/*
+	 * A pending, locally enabled interrupt wakes WFI even with MIE
+	 * clear.
+	 */
+	li	t0, 0x8		/* MIE_MSIE */
+	csrw	mie, t0
+	csrci	mstatus, 0x8	/* MSTATUS_MIE */
+	li	t0, 0x2000000	/* MSIP0 */
+	li	t1, 1
+	sw	t1, 0(t0)
+
+	/*
+	 * The first CSR read and WFI retire before the second read obtains s1,
+	 * so the expected difference is two.
+	 */
+	csrr	s0, minstret
+	wfi
+	csrr	s1, minstret
+	sub	s1, s1, s0
+	li	t1, 2
+	beq	s1, t1, 1f
+	ori	s3, s3, 1
+1:
+
+	/* Clear the software interrupt before testing the trap path. */
+	sw	zero, 0(t0)
+	csrw	mie, zero
+
+	/* Schedule a timer interrupt far enough ahead to reach WFI first. */
+	li	t0, 0x200bff8	/* MTIME */
+	ld	t1, 0(t0)
+	addi	t1, t1, 100
+	li	t0, 0x2004000	/* MTIMECMP0 */
+	sd	t1, 0(t0)
+	li	t0, 0x80		/* MIE_MTIE */
+	csrw	mie, t0
+	csrsi	mstatus, 0x8	/* MSTATUS_MIE */
+
+	/*
+	 * The first CSR read and WFI retire before the trap handler obtains s1,
+	 * so the expected difference is again two.
+	 */
+	li	s2, 1
+	csrr	s0, minstret
+	wfi
+	beqz	s2, 1f
+	ori	s3, s3, 2
+1:
+	bnez	s3, fail
+	li	a0, 0
+	j	_exit
+
+fail:
+	mv	a0, s3
+
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
+	.balign	4
+trap:
+	/* Read minstret before retiring an instruction in the handler. */
+	csrr	s1, minstret
+	sub	s1, s1, s0
+	addi	s1, s1, -2
+	snez	s2, s1
+
+	/* Disable the timer interrupt before returning past WFI. */
+	li	t0, 0x2004000	/* MTIMECMP0 */
+	li	t1, -1
+	sd	t1, 0(t0)
+	li	t0, 0x80		/* MIE_MTIE */
+	csrc	mie, t0
+	mret
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.47.3


