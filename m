Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A8BC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 01:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1aEF-0001Cj-LB; Tue, 01 Sep 2026 21:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x1aEE-0001CJ-LA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 21:57:30 -0400
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x1aEB-0004ay-8P
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 21:57:30 -0400
Received: by mail-pj2-x0a.google.com with SMTP id
 98e67ed59e1d1-39641d0dba5so274697a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 18:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788314246; x=1788919046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZejZZ2ZbB/EBfw/8xAvF1q+yOuOMpS/sGduFd1xS/QU=;
 b=Ad++Ek1WVa3i75MsxUnjVl5Vj9aKTNCrZHoU/pCgpLWyS3nLogoWqAN2O4QtdYtsik
 Vs4aLjS9E0KzTXcRn+SFg9xOZT7uXAhePC8H6AVbGT8O4sCx4TC3A57mjszclRI/SBGw
 0wnlwANmvScGugREaadyYZAxSxwT+gnjgamJS9FdgLkuuZi9i71P9s3TJhH+5Rx8rzoE
 ikznO9P5oKsyzMuhYlOONZ+r7kRGaImqGa6UMdVXc/AqDH3qMnjFXYf9+5vz/mXoUZz2
 qZmUgK+gbc2h4+/ypfLTHYFFOfZgzOWXAOYpoJD4STik4R9e+NTm0CpVjUO+TYdbbDaj
 q+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788314246; x=1788919046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZejZZ2ZbB/EBfw/8xAvF1q+yOuOMpS/sGduFd1xS/QU=;
 b=Es/pxQByGQXZeGIzcoQXf8MMYtwiffv2Mml2da7p1Kqr53kJ5HemwYMOLth3AHprSV
 ZES1EcIwEFVKmBrvo3bQwS/kpkPOgfe9NRd5aJXvn5Wc2BXax1av4k62lV0ry1/wxPMM
 iuP1LTPh4O4cn6Vv9hrkij+UrhzyxN+QbxiEZP5tVX1TVJRy0WVglRJvME7YphIF3Wni
 kiuTxyO+HUF4PahdMnBatfFzdXhlnJLmz7xSX/Gtyr/0KY0ymGhk3MwW6492OipNx216
 ghvd9T16zctWCKdmxR6nu5tICOByhCqy11UaKjneMItDYhV2cuLXhWEgbX6xF4IMP3vQ
 KQwQ==
X-Gm-Message-State: AFuF++k6myLv583NZuB/crU52y6WyQrXAZTQN6aK5Qwbtvd7/NKXvqgt
 9BB/ZUc4eWdcnZ0C/8JuVxdV/zkJE/Ag7wEOS8RABIlxiqCmUZqds2v/9vDvzgm1
X-Gm-Gg: AYBFou0RkTZ19u5ohA5i+3aQr2Go2oM0uYxX5nN+VOFl0wWm2/znn0OjM+f4ml23iar
 A9LHY7l9ksiOwTXbt8rjCBDZ3cSKT6ipC2G+jeppDi0bqFapwVHazqlhXMnG418IPBFVGeC30v/
 PH9mHPewMtvoYbiiQvbZ0SQK6IIo/wf0YhU3VBkx0Q5bHb2ZMggJ7vJiwZG4WsvafN/G44+Bfdw
 Z8edY7vzGe8rn9u/H1dTydIh3fBso0RSOyiCWWpOWzVNKCYyFDIiWFhwlbv9QWIUi7kubpzKljB
 Mlx7bB3Hvlz1k9JedE8HSl8dyp3b+CIMIbr6iX33tywl8dqOLlemOkjna9zE4FluEJUrHRjcJXY
 uFIOV23dIYuExf0LoSJTq82zkbgN05w+3gGIMtNdqRBayj9tP+t6zvWjp6ocRQCs4W3Ikjn1TAd
 7I9uL66tvl38t7YwNLCJZ5W0L077yEQSj7Tp/9RJ4fZ9aYeohVwP2Bt7HKdLNrh2xK6EoQgniWg
 pfd8I1xJbzkPPtT
X-Received: by 2002:a17:90b:17c3:b0:398:dcef:c040 with SMTP id
 98e67ed59e1d1-39aee1d6bf3mr1677227a91.19.1788314245545; 
 Tue, 01 Sep 2026 18:57:25 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([149.118.62.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990bd1b395sm9455664a91.1.2026.09.01.18.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 18:57:24 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH] target/riscv: save ELP in MPELP for NMIE=0 exceptions
Date: Wed,  2 Sep 2026 09:57:04 +0800
Message-ID: <20260902015704.101990-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::a;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x0a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When an exception occurs in M-mode while mnstatus.NMIE is clear,
Smrnmi only changes the exception handler address. Trap state is still
saved in the regular M-mode CSRs and the handler returns with MRET.

riscv_cpu_do_interrupt() instead saves ELP in mnstatus.MNPELP on this
path. MRET restores ELP from mstatus.MPELP, so the expected landing-pad
state is lost.

Always save ELP in mstatus.MPELP for M-mode exceptions. Keep MNPELP for
the actual RNMI interrupt path, which returns with MNRET.

Add a TCG test that checks ELP preservation across an NMIE=0 M-mode
exception and MRET.

Fixes: 0266fd8b56a4 ("target/riscv: Add Zicfilp support for Smrnmi")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4223
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/tcg/cpu_helper.c             |  18 +---
 tests/tcg/riscv64/Makefile.softmmu-target |   8 ++
 tests/tcg/riscv64/test-zicfilp-smrnmi.S   | 117 ++++++++++++++++++++++
 3 files changed, 127 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-zicfilp-smrnmi.S

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..a0d79b33a5 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2264,23 +2264,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
         src = env->sepc;
     } else {
-        /*
-         * If the hart encounters an exception while executing in M-mode
-         * with the mnstatus.NMIE bit clear, the exception is an RNMI exception.
-         */
-        nnmi_excep = cpu->cfg.ext_smrnmi &&
-                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
-                     !async;
-
-        /* handle the trap in M-mode */
-        /* save elp status */
+        /* Save ELP for MRET. */
         if (cpu_get_fcfien(env)) {
-            if (nnmi_excep) {
-                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
-                                          env->elp);
-            } else {
-                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
-            }
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
         }
 
         if (riscv_has_ext(env, RVH)) {
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 6a219c306c..8522c3fe6f 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -45,6 +45,14 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-zicfilp-smrnmi
+run-test-zicfilp-smrnmi: test-zicfilp-smrnmi
+	$(call run-test, $<, \
+	  $(QEMU) \
+	  -cpu rv64$(comma)zicsr=true$(comma)zicfilp=true$(comma)smrnmi=true \
+	  -global rv64-riscv-cpu.rnmi-exception-vector=0x80000100 \
+	  $(QEMU_OPTS)$<)
+
 # Zicclsm: misaligned load/store support. Assemble one source twice: the
 # default build expects every misaligned access to succeed (zicclsm=true),
 # the -DZICCLSM_DISABLED build expects every one to trap (zicclsm=false).
diff --git a/tests/tcg/riscv64/test-zicfilp-smrnmi.S b/tests/tcg/riscv64/test-zicfilp-smrnmi.S
new file mode 100644
index 0000000000..b5965bf705
--- /dev/null
+++ b/tests/tcg/riscv64/test-zicfilp-smrnmi.S
@@ -0,0 +1,117 @@
+/*
+ * Test that an M-mode exception taken with mnstatus.NMIE clear saves ELP in
+ * mstatus.MPELP, so that it is restored by MRET.  MNPELP is reserved for the
+ * actual RNMI path, which returns with MNRET.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option	norvc
+
+	.equ	CSR_MNSTATUS, 0x744
+	.equ	CSR_MSECCFG, 0x747
+	.equ	MNSTATUS_NMIE, 1 << 3
+	.equ	MNSTATUS_MNPELP, 1 << 9
+	.equ	MSECCFG_MLPE, 1 << 10
+	.equ	MSTATUS_MPELP, 1 << 41
+	.equ	EXCP_INST_ACCESS_FAULT, 1
+	.equ	EXCP_SW_CHECK, 18
+	.equ	SW_CHECK_FCFI_TVAL, 2
+
+	.text
+	.global	_start
+_start:
+	/* Verify that NMIE is clear before exercising the exception path. */
+	csrr	t0, CSR_MNSTATUS
+	andi	t0, t0, MNSTATUS_NMIE
+	bnez	t0, fail_nmie
+
+	/* Enable landing-pad checks in M-mode, then start a new TB. */
+	li	t0, MSECCFG_MLPE
+	csrs	CSR_MSECCFG, t0
+	j	tracked_jump
+
+tracked_jump:
+	/* Make a Zicfilp-tracked indirect jump to an address that faults. */
+	li	t1, 0
+	jalr	zero, 0(t1)
+
+	/*
+	 * The instruction access fault should have redirected to the handler.
+	 */
+	li	a0, 1
+	j	_exit
+
+fail_nmie:
+	li	a0, 6
+	j	_exit
+
+	/* Must match rnmi-exception-vector in Makefile.softmmu-target. */
+	.org	0x100
+rnmi_exception:
+	csrr	t0, mcause
+	li	t1, EXCP_INST_ACCESS_FAULT
+	beq	t0, t1, handle_fetch_fault
+	li	t1, EXCP_SW_CHECK
+	beq	t0, t1, handle_sw_check
+
+	li	a0, 4
+	j	_exit
+
+handle_fetch_fault:
+	/* This is an M-mode exception and will return with MRET. */
+	csrr	t0, mstatus
+	li	t1, MSTATUS_MPELP
+	and	t0, t0, t1
+	beqz	t0, fail_mpelp
+
+	csrr	t0, CSR_MNSTATUS
+	andi	t0, t0, MNSTATUS_MNPELP
+	bnez	t0, fail_mnpelp
+
+	lla	t0, resume_non_lpad
+	csrw	mepc, t0
+	mret
+
+resume_non_lpad:
+	/* MRET must restore ELP, so this instruction must not retire. */
+	li	a0, 1
+	j	_exit
+
+handle_sw_check:
+	csrr	t0, mtval
+	li	t1, SW_CHECK_FCFI_TVAL
+	bne	t0, t1, fail_tval
+
+	li	a0, 0
+	j	_exit
+
+fail_mpelp:
+	li	a0, 2
+	j	_exit
+
+fail_mnpelp:
+	li	a0, 3
+	j	_exit
+
+fail_tval:
+	li	a0, 5
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
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
2.43.0


