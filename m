Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C935CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqI-0004vd-Vq; Tue, 13 Oct 2026 23:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqC-0004tK-Om
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:47 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqB-0001My-02
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:44 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso1323895a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949182; x=1792553982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F5/44gQDY0kzg4/E/SGev6N3prLZC2rRm70nQVMzR9E=;
 b=ZHgutZi3pFm6O8LsC0mZi6D52VK2YooMYp03fQrXjOpBYGxmMfEmAt7Wdc44rkGAh4
 COjSuDzWMpHjWS3RBqv6WwxezB6XjOgZF4JFD3PP3qtkrxFxrtb6194Kcs21pQVz4PMd
 zzqnWP1+Si/ssYhrdBuPMmcjsHIKc3cZ0y/cqwBbdgn2dj5qvJKcknWulgEtjwv9HcrH
 wxo6VF9Fiu2Tmw71TKJ3ihszIsgnU/qjI+FqvhfotMd08LgZ3suTrPFusVpRdxumPDUp
 Y3huHCPP0IfJrvBMWCd//RQNFE03NM253xSyss/4EFwS5EClZdNsISDSpoDcQqv6dwDn
 FlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949182; x=1792553982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F5/44gQDY0kzg4/E/SGev6N3prLZC2rRm70nQVMzR9E=;
 b=UAaQ/HFEh3wRkh5wKr0j3jOynW1mouTTn9IG5jrZ4i/hKUVgzZtNwwvmR3xA+vtFxD
 rzDC2IZud3qzDa9a1QIWwjhMK0RKXc3Gx6IWKXIQccNFF3uCw1CLsgJsBv/6KZ/mHZ1H
 nM/C6kfnXAnJruCSDOHBo/uU6uoXkpW4ywGtdD7I8+7QUCzxJrnToTpIgRGPxufFmC3Z
 7DUVwH6UBkaJ4m6gKDSbbJFp7keHITfao6t/BFXb5jgW8gURdabDxYPlgxGSwQnTUSDP
 PSSaQHlzdjrXp7ctuyCJG/mVW9WpSyHgmhiseSr/F/QjXDQOCXftbrw+BbRuxoE807xt
 Vt0w==
X-Gm-Message-State: AFq9FYJpn3fut3d2J24EqZTJh+NwzHy8ZMujNFCDvTc/mypMPzBIbvMb
 /hbN9UrMtoKW65rScsC2Rl6dPyoBr5kwgFJdU7h6hi9+o+/zxb0Zk240TOBL6g==
X-Gm-Gg: AYBFou1GKDRUOCiUoE+hRrTOG7dVmWaF2x92OAJSzHBtftt6rrqkqc1KCiJBmaWM2XE
 0lYxCJSqWGVisditM84rYAV+5PAPjWawBAjfDHImLZ+JCL2oP8H4RBoOCAAIvEoWrV94ctv8T4n
 vr8UN3UVajrsaj6wO0kdGhWWafwmACti7OoqJxEsKq0g1SfEesIGGQAX6tEv+sV3ZwBnKw/hfZb
 VYucDOyvY4rWK9n/zQ1g7Q57R3EY+mNg+7Cya8RwK4DD/cXkuUMgEOptKEBVAaPhph1QpsTb6lq
 H1dI9AoeiJMLx+6vbA2CEDFslmR0iemXIdOFuPdKRcVtFanzQrBI9As6LEWED8oL08zCJwVPsfP
 oqVyNXoNXqC5fJumfsxx6kVNNeYeE16JoHfle0QFC/t+22/ZWUbZOgcyJJXuVlAQ66ZRFtz8lPg
 vG3d0lnkMugNam8QLnL/tXcouy1/U35ISVbhVQwcq5pSAL9woDuNUZ8KCiS7Wt34PvQzYUiPiSD
 14yAEGvnGc2YFbAyiWa01iLNpeU
X-Received: by 2002:a17:90b:314d:b0:3ac:7556:8eed with SMTP id
 98e67ed59e1d1-3ac7556a42cmr316640a91.44.1791949181458; 
 Tue, 13 Oct 2026 20:39:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/52] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Date: Wed, 14 Oct 2026 13:38:21 +1000
Message-ID: <20261014033907.3332383-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

helper_wrs_nto() may raise an illegal or virtual-instruction exception.
However, trans_wrs_nto() does not save the decoded opcode before calling
the helper. As a result, exception unwinding leaves env->bins stale and
trap handling reports an incorrect value in tval.

Call decode_save_opc() before the helper so the faulting instruction
encoding is restored for trap handling.

Add a TCG test that delegates the mstatus.TW-triggered illegal-instruction
exception to S-mode and checks scause, sepc and stval.

Cc: qemu-stable@nongnu.org
Fixes: b62e0ce76098 ("target/riscv: Raise exceptions on wrs.nto")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4080
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Message-ID: <20260901091622.88113-1-fritchleybohrer@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../riscv/tcg/insn_trans/trans_rvzawrs.c.inc  |  2 +
 tests/tcg/riscv64/Makefile.softmmu-target     |  4 +
 tests/tcg/riscv64/test-zawrs-stval.S          | 87 +++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zawrs-stval.S

diff --git a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
index 1831bbcfc0..cb83b5247e 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
@@ -57,6 +57,8 @@ static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
      * exception, as handled by the wrs.nto helper.
      */
 #ifndef CONFIG_USER_ONLY
+    /* Save the opcode in case the helper raises an exception. */
+    decode_save_opc(ctx, 0);
     gen_helper_wrs_nto(tcg_env);
 #endif
 
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index f2c75abd57..1e44410418 100644
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
index 0000000000..42a9901fa6
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
2.55.0


