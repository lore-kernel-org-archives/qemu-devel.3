Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D33CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqb-0005FD-6F; Tue, 13 Oct 2026 23:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqa-0005Ey-5h
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:08 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqX-0001bD-Di
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:07 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso1921352a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949204; x=1792554004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DB5qlwcJ4h2eLACqqal0N4/0XhyrZ2ztgIgld4fHkoc=;
 b=Rb/FsAiZFOgZ5CmzxhLM5v7VbuBVU7P4BEsl/y36Wd0o22dfXWDmjONP/3LgewU97m
 lVWUqQJvdEsbqLxzxXYHJguyj/Ygnatus/WY6BhgZUfbR8zdPPFOAgLoDL9SD0UqfUcz
 gQpK+vEjtnhz3/ZK4s6UnIcc1b3EYRFqfIs6cUaf/GnJ9LvWxFXEiETKPaZ6fxkBZDUH
 TUnHjOW30pD+y9qrVk/a51QaK9bCqxlRd/GqC2yPf43q1cMk2d1KDx6239zozgWxt4KJ
 Yr53Dp49bsvfoMXFgcEzZ2GJnYlHe5Y2B4NsOrO5lle2G1TnOMHrMCzncRfl7H3F6FPA
 yWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949204; x=1792554004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DB5qlwcJ4h2eLACqqal0N4/0XhyrZ2ztgIgld4fHkoc=;
 b=tk5ALo547DGBHUV0LpMOYRG6Oasxmb4+R3a5Cv0rEHHsJhKCIVsaG8izL59rLVI7Bl
 aWCEySyubYx00lRpq/RipYBvuUtHZpvOqjbJZ9sMvGWhHphkddhIsB6+zvvUSAZUc9Gi
 VgiDO06ynOBRCrG0FaZiFhGExke1gkHpAWymEzH53iZcRR4Tn91ohvhyzl1Dn9x6N15y
 FHPEmDv1CvKUt7ruoS9KHy3BW4QfvxMMTIsYRgnAvKJ3WBLS09iw4KN8zZZFy2VC5Vrt
 ZXHWTQVu/fXzMMGQgZuXPyOhBIMLf0bXHolZvpUWSvc00OwsxnrZw88B53eooNy1mL+D
 KLzg==
X-Gm-Message-State: AFq9FYJzHz7+pnVS7tm8ComlOpwiJlfo5nb4+xORCUM3rtTm880nBADn
 4U/OpDv7OpKnA6feRJ6hP4IzrYbJ758Mb3aGb49725+sjtHdlWJKdr2K8de2qw==
X-Gm-Gg: AYBFou10lka1Hwp6EEA5fwstRfpxrAw+yVBZVHYctiOhF9EtQmeC7xh4L2DI+mz0Jlc
 oWomctTch46zPChcywSNZucdWWs6+Dm2gRBpkQf+nSiQUvIRL/fRPoAmX2x1pPhCnEzL5F2dpSd
 Azx0UfLgz4EBsNKdXje1DTUIdhYcKeVwJWwTh/2ZMU7CMAplAAfnxQGKAQyB7geIh4gqg+WTOOl
 44rSznCGE1DhecYFZ8l993DGlBBxIPg430IGYECwmXQLg/QKjD8SXrBxYVL2uG49eExTrKPTQwt
 vRykkchMz2Bv+SZA0YLuDefQGUT1wNgRckveqKchPajLfiN6+ZTV4cJ26VQewBpbil8HuwGN+MU
 spW9DX5tjI52cjBifqJWZDffkrdNUZ7ULscAX5ABuQ2dbjTdW8eDqBRAXCjVkIPanEOjVJ6MSb5
 blrRH5jGiXUnQju+AiSztp/TjwMORmyMW5J4WsUfLO1qRckz0FamG5eob6kf4ZSqgPlajNb2nud
 pCynKiJTcisxz9B
X-Received: by 2002:a17:90b:498f:b0:3ab:d26b:c2df with SMTP id
 98e67ed59e1d1-3abd26bc4e0mr4983469a91.27.1791949203860; 
 Tue, 13 Oct 2026 20:40:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Mingliang Liu <liumingliang.dev@bytedance.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/52] tests/tcg/riscv64: Add Zvabd extension tests
Date: Wed, 14 Oct 2026 13:38:28 +1000
Message-ID: <20261014033907.3332383-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: Mingliang Liu <liumingliang.dev@bytedance.com>

Add a RV64 TCG test covering the masked and unmasked vector-vector
and vector-scalar forms of vabd, vabdu, vwabda, and vwabdau.

Assemblers do not yet support the version 0.9 instruction mnemonics,
so the instruction encodings are hardcoded for the time being.

GNU binutils 2.47 supports the incompatible version 0.7 instruction
encodings. Therefore, this test must not be built with that version,
even after it is converted to use instruction mnemonics.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Co-Author: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Message-ID: <20260907152301.1701394-4-liumingliang.dev@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   9 +
 tests/tcg/riscv64/test-zvabd.S            | 659 ++++++++++++++++++++++
 2 files changed, 668 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zvabd.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 9cf049e1cf..34c719e2aa 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -97,5 +97,14 @@ run-test-vle32ff: test-vle32ff
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
 test-vle32ff: CFLAGS += -march=rv64gcv
 
+EXTRA_RUNS += run-test-zvabd
+CLEANFILES += test-zvabd
+test-zvabd: test-zvabd.o $(LINK_SCRIPT)
+	$(LD) $(LDFLAGS) $< -o $@
+run-test-zvabd: test-zvabd
+	$(call run-test, $<, $(QEMU) \
+	-cpu rv64$(comma)v=true$(comma)vlen=256$(comma)x-zvabd=true \
+	$(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-zvabd.S b/tests/tcg/riscv64/test-zvabd.S
new file mode 100644
index 0000000000..4f91acea0c
--- /dev/null
+++ b/tests/tcg/riscv64/test-zvabd.S
@@ -0,0 +1,659 @@
+/*
+ * Test the Zvabd vector absolute-difference instructions and the vabs.v
+ * pseudoinstruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option arch, +v
+	.option norvc
+
+	.text
+
+	.global _start
+_start:
+	/* Enable the vector unit (mstatus.VS = Initial). */
+	li	t0, 1 << 9
+	csrs	mstatus, t0
+
+	/* Route synchronous traps to trap_handler (mtvec direct mode). */
+	la	t0, trap_handler
+	csrw	mtvec, t0
+
+	/* Run each test function. */
+	call	test_vabs_v
+	bnez	a0, _exit
+	call	test_vabs_v_mask
+	bnez	a0, _exit
+
+	call	test_vabd_vv
+	bnez	a0, _exit
+	call	test_vabd_vv_mask
+	bnez	a0, _exit
+
+	call	test_vabd_vx
+	bnez	a0, _exit
+	call	test_vabd_vx_mask
+	bnez	a0, _exit
+
+	call	test_vabdu_vv
+	bnez	a0, _exit
+	call	test_vabdu_vv_mask
+	bnez	a0, _exit
+
+	call	test_vabdu_vx
+	bnez	a0, _exit
+	call	test_vabdu_vx_mask
+	bnez	a0, _exit
+
+	call	test_vwabda_vv
+	bnez	a0, _exit
+	call	test_vwabda_vv_mask
+	bnez	a0, _exit
+
+	call	test_vwabda_vx
+	bnez	a0, _exit
+	call	test_vwabda_vx_mask
+	bnez	a0, _exit
+
+	call	test_vwabdau_vv
+	bnez	a0, _exit
+	call	test_vwabdau_vv_mask
+	bnez	a0, _exit
+
+	call	test_vwabdau_vx
+	bnez	a0, _exit
+	call	test_vwabdau_vx_mask
+	bnez	a0, _exit
+
+	j	_exit
+
+test_vabs_v:
+	vsetivli zero, 2, e8, m1, ta, ma
+
+	/* Load .arr_neg array in v1 */
+	la     t0,.arr_neg
+	vle8.v v1,0(t0)
+
+	/* vabs.v v2, v1 (vabd.vx v2, v1, x0) raw opcode */
+	.insn r 0x57, 0x6, 0x2b, x2, x0, x1
+
+	/* Load .arr_pos in v3 */
+	la      t1,.arr_pos
+	vle8.v  v3,0(t1)
+
+	/* Compare v2 and v3 into v0 */
+	vmsne.vv  v0,v2,v3
+	vcpop.m a0,v0
+	snez    a0,a0
+
+	ret
+
+test_vabs_v_mask:
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load .arr_neg array in v1 */
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+
+	/* Zero v2 using .arr_zero */
+	la     t0,.arr_zero
+	vle8.v v2,0(t0)
+
+	/* Load .v0_mask array in v0 */
+	la     t1,.v0_mask
+	vle8.v v0,0(t1)
+
+	/* vabs.v v2, v1, v0.t raw opcode */
+	.insn r 0x57, 0x6, 0x2a, x2, x0, x1
+
+	/* Load .arr_masked in v3 */
+	la      t0,.arr_masked
+	vle8.v  v3,0(t0)
+
+	/* Compare v2 and v3 into v0 */
+	vmsne.vv  v0,v2,v3
+	vcpop.m a0,v0
+	snez    a0,a0
+
+	ret
+
+test_vabd_vv:
+	/*
+	 * Test signed vector-vector absolute difference:
+	 * abs({-5, -7} - {5, 7}) = {10, 14}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load the two signed source vectors into v1 and v3. */
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v3, 0(t0)
+
+	/* Execute vabd.vv v2, v1, v3. */
+	.insn r 0x57, 0x2, 0x2b, x2, x3, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabd_vv
+	vle8.v  v3, 0(t0)
+
+	/* Compare v2 and v3 into v0 */
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+
+	ret
+
+test_vabd_vv_mask:
+	/*
+	 * Test masked vabd.vv.  Element 0 remains 9 and element 1 becomes
+	 * abs(-7 - 7) = 14.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load the two signed source vectors into v1 and v3. */
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v3, 0(t0)
+
+	/* Load original value into v2 */
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	/* Load mask value into v0 */
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x2, 0x2a, x2, x3, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabd_vv_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabd_vx:
+	/*
+	 * Test signed vector-scalar absolute difference:
+	 * abs({-5, -7} - 3) = {8, 10}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	/* Execute vabd.vx v2, v1, a2. */
+	.insn r 0x57, 0x6, 0x2b, x2, x12, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabd_vx
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabd_vx_mask:
+	/*
+	 * Test masked vabd.vx.  Element 0 remains 9 and element 1 becomes
+	 * abs(-7 - 3) = 10.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x6, 0x2a, x2, x12, x1
+
+	la      t0, .expect_vabd_vx_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vv:
+	/*
+	 * Test unsigned vector-vector absolute difference:
+	 * abs({0, 255} - {255, 0}) = {255, 255}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	/* Load the two unsigned source vectors into v1 and v3. */
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v3, 0(t0)
+
+	/* Execute vabdu.vv v2, v1, v3. */
+	.insn r 0x57, 0x2, 0x2d, x2, x3, x1
+
+	/* Load the expected result into v3. */
+	la      t0, .expect_vabdu_vv
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vv_mask:
+	/*
+	 * Test masked vabdu.vv.  Element 0 remains 9 and element 1 becomes
+	 * abs(255 - 0) = 255.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v3, 0(t0)
+
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x2, 0x2c, x2, x3, x1
+
+	la      t0, .expect_vabdu_vv_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vx:
+	/*
+	 * Test unsigned vector-scalar absolute difference:
+	 * abs({0, 255} - 128) = {128, 127}.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	/* Execute vabdu.vx v2, v1, a2. */
+	.insn r 0x57, 0x6, 0x2d, x2, x12, x1
+
+	la      t0, .expect_vabdu_vx
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vabdu_vx_mask:
+	/*
+	 * Test masked vabdu.vx.  Element 0 remains 9 and element 1 becomes
+	 * abs(255 - 128) = 127.
+	 */
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	la      t0, .arr_init
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x6, 0x2c, x2, x12, x1
+
+	la      t0, .expect_vabdu_vx_masked
+	vle8.v  v3, 0(t0)
+
+	vmsne.vv  v0, v2, v3
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vv:
+	/*
+	 * Test signed widening vector-vector absolute difference and
+	 * accumulation. Start with v4 = {1000, -1000}, and the expected
+	 * widened result is {1000, -1000} + abs({-5, -7} - {5, 7}) =
+	 * {1010, -986}.
+	 */
+	/* Load the 16-bit accumulator before selecting 8-bit operands. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v2, 0(t0)
+
+	/* Execute vwabda.vv v4, v1, v2. */
+	.insn r 0x57, 0x0, 0x7b, x4, x2, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vv
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vv_mask:
+	/*
+	 * Test masked vwabda.vv.
+	 * Start with v4 = {1000, -1000}, v0 = {0, 1}, and the expected widened
+	 * result is {1000, -1000} + abs({-5, -7} - {5, 7}) = {1000, -986}.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_pos
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x0, 0x7a, x4, x2, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vv_masked
+
+	vle16.v v6, 0(t0)
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vx:
+	/*
+	 * Test signed widening vector-scalar absolute difference and
+	 * accumulation. With scalar 3, v4 becomes {1000 + 8, -1000 + 10}.
+	 */
+	/* Load the 16-bit accumulator before selecting 8-bit operands. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	/* Execute vwabda.vx v4, v1, a2. */
+	.insn r 0x57, 0x4, 0x7b, x4, x12, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vx
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabda_vx_mask:
+	/*
+	 * Test masked vwabda.vx.  Element 0 remains 1000 while element 1
+	 * accumulates 10 and becomes -990.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_signed_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_neg
+	vle8.v  v1, 0(t0)
+	li      a2, 3
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x4, 0x7a, x4, x12, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabda_vx_masked
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vv:
+	/*
+	 * Test unsigned widening vector-vector absolute difference and
+	 * accumulation. Start with v4 = {1000, 2000}, adding {255, 255}
+	 * produces {1255, 2255}.
+	 */
+	/* Load the unsigned 16-bit accumulator and 8-bit source vectors. */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+	vsetivli zero, 2, e8, m1, ta, mu
+
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v2, 0(t0)
+
+	/* Execute vwabdau.vv v4, v1, v2. */
+	.insn r 0x57, 0x0, 0x7d, x4, x2, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vv
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vv_mask:
+	/*
+	 * Test masked vwabdau.vv.  Element 0 remains 1000 while element 1
+	 * accumulates 255 and becomes 2255.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	la      t0, .arr_unsigned_rhs
+	vle8.v  v2, 0(t0)
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x0, 0x7c, x4, x2, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vv_masked
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vx:
+	/*
+	 * Test unsigned widening vector-scalar absolute difference and
+	 * accumulation. With scalar 128, v4 becomes {1000 + 128, 2000 + 127}.
+	 */
+	/* Load the unsigned 16-bit accumulator and 8-bit source vector. */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	/* Execute vwabdau.vx v4, v1, a2. */
+	.insn r 0x57, 0x4, 0x7d, x4, x12, x1
+
+	/* Select the widened EEW and compare v4 with the expected result. */
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vx
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+test_vwabdau_vx_mask:
+	/*
+	 * Test masked vwabdau.vx.  Element 0 remains 1000 while element 1
+	 * accumulates 127 and becomes 2127.
+	 */
+	vsetivli zero, 2, e16, m2, ta, mu
+
+	la      t0, .arr_unsigned_acc
+	vle16.v v4, 0(t0)
+
+	vsetivli zero, 2, e8, m1, ta, mu
+	la      t0, .arr_unsigned_lhs
+	vle8.v  v1, 0(t0)
+	li      a2, 128
+
+	la      t0, .v0_mask
+	vle8.v  v0, 0(t0)
+
+	.insn r 0x57, 0x4, 0x7c, x4, x12, x1
+
+	vsetivli zero, 2, e16, m2, ta, mu
+	la      t0, .expect_vwabdau_vx_masked
+	vle16.v v6, 0(t0)
+
+	vmsne.vv  v0, v4, v6
+	vcpop.m a0, v0
+	snez    a0, a0
+	ret
+
+
+/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
+_exit:
+	la	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.balign	4
+trap_handler:
+	csrr	t4, mcause
+	la	t5, trap_mcause
+	sd	t4, 0(t5)
+	csrr	t4, mtval
+	la	t5, trap_mtval
+	sd	t4, 0(t5)
+	li	a0, 1
+	j	_exit
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
+trap_mcause:
+	.space	8
+trap_mtval:
+	.space	8
+.arr_neg:
+	.byte -5, -7
+.arr_pos:
+	.byte 5, 7
+.arr_zero:
+	.byte 0, 0
+.arr_init:
+	.byte 9, 9
+.v0_mask:
+	.byte 0b10
+.arr_masked:
+	.byte 0, 7
+
+/* Unsigned input vectors used by vabdu and vwabdau. */
+.arr_unsigned_lhs:
+	.byte 0, 255
+.arr_unsigned_rhs:
+	.byte 255, 0
+	.balign 2
+
+/* Nonzero accumulators verify the add part of widening operations. */
+.arr_signed_acc:
+	.half 1000, -1000
+.arr_unsigned_acc:
+	.half 1000, 2000
+
+/* Expected results for the unmasked and masked forms. */
+.expect_vabd_vv:
+	.byte 10, 14
+.expect_vabd_vv_masked:
+	.byte 9, 14
+.expect_vabd_vx:
+	.byte 8, 10
+.expect_vabd_vx_masked:
+	.byte 9, 10
+.expect_vabdu_vv:
+	.byte 255, 255
+.expect_vabdu_vv_masked:
+	.byte 9, 255
+.expect_vabdu_vx:
+	.byte 128, 127
+.expect_vabdu_vx_masked:
+	.byte 9, 127
+.expect_vwabda_vv:
+	.half 1010, -986
+.expect_vwabda_vv_masked:
+	.half 1000, -986
+.expect_vwabda_vx:
+	.half 1008, -990
+.expect_vwabda_vx_masked:
+	.half 1000, -990
+.expect_vwabdau_vv:
+	.half 1255, 2255
+.expect_vwabdau_vv_masked:
+	.half 1000, 2255
+.expect_vwabdau_vx:
+	.half 1128, 2127
+.expect_vwabdau_vx_masked:
+	.half 1000, 2127
-- 
2.55.0


