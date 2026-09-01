Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC162C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Kbw-00026K-Ib; Tue, 01 Sep 2026 05:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x1Kbt-00025J-L0
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:16:55 -0400
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x1Kbr-0001o7-Nh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:16:53 -0400
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf5e516e67so18494565ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788254210; x=1788859010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pqiSDtPP2yU4efD3ynS3kttzqeRAM1ybKSi3j0Qh5+8=;
 b=nf+fe4CUahh2iA81vn0Lt88ZHtFCkgz1r2Juyv5b5Jsc8CBKyZwwmjFNeFm2tqD4C1
 TPWJi9CjHjtfpt++KLnd+0Bzpi1jUG3v8MwtPcb1I45jdEdBrq/hQxFx30tY32Uay1kI
 sDRarlmnZrLafjqXWDe1T6nMyvqbsIbla8BHdML2hX4g/ZRcqllIjRvgRQLX6cT+9onQ
 C1+kWducWGjO3RHD9pVuHLa+LOi/f636/L8NwXW8kLqTTNpXzJ3U9aFVgiScbRVpqKQK
 zdD9jyLb1n/jONJXm76sXb6pxJbrBeuVkBBrBPw17KA+uR3JCufrvPGez1upsJkeoMr6
 LNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788254210; x=1788859010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pqiSDtPP2yU4efD3ynS3kttzqeRAM1ybKSi3j0Qh5+8=;
 b=Ix1WM6LGes/bO+GPCH3ge/NM2+i2SR76GC+3vexFGorikxbOUkI7sBIAHBvZiO8ngD
 FoMqjZLgUbKnvt3AGMeLu8PJTAsB4Ko/+UxUVn74h8Lkd0C8CepgipmwrDM5/n4iSxl2
 SJdWmo6dpdsgEg+ix7ZK6TqmSGbnfuucU3n9ALCzEjnJkc+tQ1u95OXJ9dxO1AHqrJnR
 KpqknYdgdt2BTPUebyFFiqJJhJFQW30yBFVKpmkybDsCr1EeldnyuJyw4AIOgh2aqJny
 qWhz5bxm322ZtugP+pRk3os+UOmBmmIoCJIvIjwj/ckNPftRPx2QCJh8lTb9jAJpBBNG
 bBdA==
X-Gm-Message-State: AFuF++m3liih0FXDCnaLJM+3xMQCN1fe5MMbTVgIgFqr66ybYJEMlAkK
 vZfOl1PhzfjKD+6nSaIrc02vws0LW93telw7sL6SnxjBABzjz1v2M7Gm3m9JAf9p+mg=
X-Gm-Gg: AYBFou2FAtA/ZjRu/dvdbM/K7xweOqPeTaKlnH2MC4vn3a1uvQg4uLAEFHkViz55uSO
 Sc6Ep0nX716e/Mkz9gVglEPBkJHTaRjWtMpKUzpwjbUAPgdQLJmQLWpIWFRmwiQ4CAK++vnP9A3
 sq0COnmxgR1WnXs+282N2zMBsIK2TQcqt7gJ/HBJtfeRGmmPZEDPRbJJ96qt5WEM6VtQmU+i+l0
 fNFDHx1VtyjsZhB6wV4N+9XvkHBJyWBm09+DyzqJWLLeD5w2SQBo30WngjDl7YqKa4Wr5WTBwPa
 KhBNZOe/S1n+SlNFqYiXUQwa/+dlMyKgBu9gZ32BciqsxCUre6xhhHpsJaNBAK4Txgah02wGgqH
 r8MY+lLewXdg7cpee53W2dMaOSrQk1fQmjREzy+o2DXdh1cRhLfYCZx+MohLMSI1XnLVrEZfwiu
 wL7yJoq21s8iVKZkiYXpbOgr6DXXO67//QqoUcSxU+WSCpQw8vIIme8LhWPH3cT5FyPf9/N1Xlx
 s9crK2RPDVemwP3nV1Wa5Fqeg==
X-Received: by 2002:a17:903:286:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2d74dcbe867mr504176905ad.7.1788254209377; 
 Tue, 01 Sep 2026 02:16:49 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([123.150.5.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d75963bc14sm48463445ad.32.2026.09.01.02.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 02:16:48 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Date: Tue,  1 Sep 2026 17:16:22 +0800
Message-ID: <20260901091622.88113-1-fritchleybohrer@gmail.com>
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

helper_wrs_nto() may raise an illegal or virtual-instruction exception.
However, trans_wrs_nto() does not save the decoded opcode before calling
the helper. As a result, exception unwinding leaves env->bins stale and
trap handling reports an incorrect value in tval.

Call decode_save_opc() before the helper so the faulting instruction
encoding is restored for trap handling.

Add a TCG test that delegates the mstatus.TW-triggered illegal-instruction
exception to S-mode and checks scause, sepc and stval.

Fixes: b62e0ce76098 ("target/riscv: Raise exceptions on wrs.nto")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4080
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 .../riscv/tcg/insn_trans/trans_rvzawrs.c.inc  |  2 +
 tests/tcg/riscv64/Makefile.softmmu-target     |  4 +
 tests/tcg/riscv64/test-zawrs-stval.S          | 87 +++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zawrs-stval.S

diff --git a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
index 0eef033..ecebec0 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
@@ -54,6 +54,8 @@ static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
      * exception, as handled by the wrs.nto helper.
      */
 #ifndef CONFIG_USER_ONLY
+    /* Save the opcode in case the helper raises an exception. */
+    decode_save_opc(ctx, 0);
     gen_helper_wrs_nto(tcg_env);
 #endif
 
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 6a219c3..979df2c 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -20,6 +20,10 @@ EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-zawrs-stval
+run-test-zawrs-stval: test-zawrs-stval
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+
 EXTRA_RUNS += run-test-mepc-masking
 run-test-mepc-masking: test-mepc-masking
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
diff --git a/tests/tcg/riscv64/test-zawrs-stval.S b/tests/tcg/riscv64/test-zawrs-stval.S
new file mode 100644
index 0000000..42a9901
--- /dev/null
+++ b/tests/tcg/riscv64/test-zawrs-stval.S
@@ -0,0 +1,87 @@
+/*
+ * Test that WRS.NTO writes the instruction encoding to stval when
+ * mstatus.TW causes an illegal-instruction exception in S-mode.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	/* Unexpected traps to M-mode fail the test. */
+	lla	t0, machine_trap
+	csrw	mtvec, t0
+
+	/* Delegate illegal-instruction exceptions to S-mode. */
+	li	t0, 1 << 2
+	csrs	medeleg, t0
+
+	lla	t0, supervisor_trap
+	csrw	stvec, t0
+
+	/* Give S-mode read, write and execute access to all memory. */
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, 0xf
+	csrw	pmpcfg0, t0
+
+	/* Set mstatus.TW and select S-mode for mret. */
+	li	t0, 3 << 11
+	csrc	mstatus, t0
+	li	t0, (1 << 21) | (1 << 11)
+	csrs	mstatus, t0
+
+	lla	t0, supervisor_start
+	csrw	mepc, t0
+	mret
+
+supervisor_start:
+	/* WRS.NTO must trap because mstatus.TW is set. */
+	li	a0, 1
+wrs_nto:
+	.word	0x00d00073
+	j	_exit
+
+machine_trap:
+	li	a0, 2
+	j	_exit
+
+supervisor_trap:
+	li	a0, 3
+
+	csrr	t0, scause
+	li	t1, 2
+	bne	t0, t1, _exit
+
+	csrr	t0, sepc
+	lla	t1, wrs_nto
+	bne	t0, t1, _exit
+
+	csrr	t1, stval
+	lwu	t2, 0(t0)
+	bne	t1, t2, _exit
+	li	t2, 0x00d00073
+	bne	t1, t2, _exit
+
+	li	a0, 0
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


