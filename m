Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E4FC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzeP-0007Rl-VD; Thu, 23 Jul 2026 16:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeH-0007OR-JY; Thu, 23 Jul 2026 16:04:06 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeA-0005SD-Lx; Thu, 23 Jul 2026 16:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784837027; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=YZeWaiS6fuLwx9Xkrp3dK8yuipuHKK+sT+MR5ZcDcT4=;
 b=f3LQL3wHNA4bzM8h2fW4i0K2ILSfY03+x0+pYpVaJj91s+K6nDPjWk8BSAyUMXx6qkql2hdYNHCWS7g/RU6y0CnG2vZQ9aKXqARDufsz/5giGVfTv4i/IODQq47ilZFUzPx90IeE3HdIXDti2Ypfw/1H5bccStIPTDk+uI79y1I=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X7h4Uw9_1784837025; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X7h4Uw9_1784837025 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jul 2026 04:03:45 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v8 09/11] target/riscv: Add system test for SMMPT extension
Date: Fri, 24 Jul 2026 04:03:23 +0800
Message-Id: <20260723200325.24969-10-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Add a bare-metal M-mode assembly test (test-smmpt.S) that validates the
Smmpt43 MPT lookup and permission enforcement against SMMTT v0.4.9.

The test builds a 3-level Smmpt43 MPT in RAM and uses the MPRV trick
(mstatus.MPRV=1, MPP=S, satp=Bare) so that data accesses are subject to
MPT checks while instruction fetches remain in M-mode (which bypasses
the MPT). PMP is configured to grant all permissions so that only the
MPT gates the accesses.

Coverage: mfence.pa in M-mode; every XWR encoding (RW, no-access,
R-only, R+X, RWX, the reserved 010/110 encodings and X-only) checked for
both load and store, verifying the correct exception cause (load access
fault = 5, store/AMO access fault = 7); an invalid (V=0) leaf; a leaf
with a reserved bit set; and NAPOT leaves with a valid and a reserved G
field.

The mode-independent harness (MPRV helpers, per-access check/verify
subroutines, the M-mode trap handler and the semihosting exit) lives in
a shared smmpt-common.S so the Smmpt52/Smmpt64/Smmpt34 tests can reuse
it.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   4 +
 tests/tcg/riscv64/smmpt-common.S          | 257 ++++++++++++++++++++++
 tests/tcg/riscv64/test-smmpt.S            |  85 +++++++
 3 files changed, 346 insertions(+)
 create mode 100644 tests/tcg/riscv64/smmpt-common.S
 create mode 100644 tests/tcg/riscv64/test-smmpt.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 82be8a2c91..18da9c6299 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -41,5 +41,9 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-smmpt
+run-test-smmpt: test-smmpt
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-smmpt=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/smmpt-common.S b/tests/tcg/riscv64/smmpt-common.S
new file mode 100644
index 0000000000..3a3b10ed53
--- /dev/null
+++ b/tests/tcg/riscv64/smmpt-common.S
@@ -0,0 +1,257 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Shared harness for the Smmpt (Supervisor Memory Protection Table) system
+ * tests, per SMMTT specification v0.4.9.
+ *
+ * This header is meant to be #included by the per-mode Smmpt test programs
+ * (Smmpt34 on RV32, Smmpt43/52/64 on RV64).  All the mode-independent logic
+ * lives here so each test only has to build its mode-specific MPT and invoke
+ * RUN_LEAF_CHECKS.
+ *
+ * The tests run in M-mode and use the MPRV trick (mstatus.MPRV=1,
+ * mstatus.MPP=S, satp=Bare so PA==VA) to subject explicit data accesses to
+ * MPT checks while the instruction stream keeps running in M-mode (M-mode
+ * fetches bypass the MPT).  The data-access width is irrelevant to the MPT
+ * check, so the harness uses lw/sw and works unmodified on RV32 and RV64.
+ *
+ * The MPT XWR field uses the standard bit order R=bit0, W=bit1, X=bit2
+ * (matching QEMU PAGE_READ/PAGE_WRITE/PAGE_EXEC), so Read+Write is 0b011=3.
+ * Per the spec the exception is reported for the original access type: a load
+ * violation raises "load access fault" (cause 5) and a store violation raises
+ * "store/AMO access fault" (cause 7).
+ *
+ * Execute permission is not exercised: the MPRV trick only redirects data
+ * accesses, while instruction fetch stays in M-mode and bypasses the MPT.
+ * X-bearing encodings are therefore checked only for their load/store
+ * behaviour (e.g. X-only denies loads, R+X denies stores).
+ *
+ * The tests expect an MPT laid out so that these supervisor physical
+ * addresses resolve as follows (identical across all modes):
+ *
+ *   0x8050_0000..0x8050_7000  non-NAPOT leaf, XWR[pi] tuples (LEAF_ALL_XWR):
+ *                               pi0 011 (RW)   pi1 000 (no access)
+ *                               pi2 001 (R)    pi3 101 (R+X)
+ *                               pi4 111 (RWX)  pi5 010 (reserved)
+ *                               pi6 110 (rsvd) pi7 100 (X only)
+ *   0x8051_0000               invalid leaf (V=0)
+ *   0x8052_0000               leaf with a reserved bit set
+ *   0x8060_0000               NAPOT leaf with a valid G
+ *   0x8080_0000               NAPOT leaf with a reserved G
+ *
+ * On any mismatch the test exits (via semihosting) with a non-zero code that
+ * identifies the failing check; a successful run exits with 0.
+ */
+
+	/* mstatus bits (same positions on RV32 and RV64) */
+	.equ	MSTATUS_MPP_S,	(1 << 11)	/* MPP = 01 (Supervisor) */
+	.equ	MSTATUS_MPP_M,	(3 << 11)	/* MPP mask */
+	.equ	MSTATUS_MPRV,	(1 << 17)
+
+	/* Expected fault causes */
+	.equ	CAUSE_LOAD_ACCESS_FAULT,	5
+	.equ	CAUSE_STORE_ACCESS_FAULT,	7
+
+	.equ	EXPECT_OK,	0
+	.equ	EXPECT_FAULT,	1
+
+	/*
+	 * Non-NAPOT leaf value carrying all eight XWR encodings in pi0..pi7:
+	 *   V|L | pi0=011 pi1=000 pi2=001 pi3=101
+	 *         pi4=111 pi5=010 pi6=110 pi7=100
+	 * The XWR tuples occupy bits [31:8], valid for both the 4-byte (RV32)
+	 * and 8-byte (RV64) leaf formats.
+	 */
+	.equ	LEAF_ALL_XWR,	0x997A4303
+
+	/*
+	 * Switch the effective privilege of data accesses to S-mode so that
+	 * they are subject to MPT checks (MPP=S, MPRV=1).  Uses t0 only.
+	 */
+	.macro	ENTER_MPRV
+	li	t0, MSTATUS_MPP_M
+	csrc	mstatus, t0		/* clear MPP */
+	li	t0, MSTATUS_MPP_S
+	csrs	mstatus, t0		/* MPP = S */
+	li	t0, MSTATUS_MPRV
+	csrs	mstatus, t0		/* enable MPRV */
+	.endm
+
+	.macro	EXIT_MPRV
+	li	t0, MSTATUS_MPRV
+	csrc	mstatus, t0		/* disable MPRV */
+	.endm
+
+	/*
+	 * Perform an MPT-checked load/store from \addr and verify the outcome.
+	 *   \eflt   : EXPECT_OK or EXPECT_FAULT
+	 *   \ecause : expected mcause when a fault is expected
+	 *   \code   : exit code reported if the check fails
+	 */
+	.macro	TEST_LOAD addr, eflt, ecause, code
+	li	a3, \addr
+	jal	do_load
+	li	a4, \eflt
+	li	a5, \ecause
+	li	a6, \code
+	jal	check
+	.endm
+
+	.macro	TEST_STORE addr, eflt, ecause, code
+	li	a3, \addr
+	li	t3, 0x1234
+	jal	do_store
+	li	a4, \eflt
+	li	a5, \ecause
+	li	a6, \code
+	jal	check
+	.endm
+
+	/*
+	 * MFENCE.PA (funct7=0b0011001) must not fault in M-mode.  Reuses the
+	 * generic check subroutine (expects no fault).
+	 */
+	.macro	TEST_MFENCE_PA code
+	li	s0, 0
+	.insn	r 0x73, 0, 0x19, x0, x0, x0
+	li	a4, EXPECT_OK
+	li	a6, \code
+	jal	check
+	.endm
+
+	/*
+	 * Run the full set of MPT permission and structural checks against the
+	 * shared address layout described above.
+	 */
+	.macro	RUN_LEAF_CHECKS
+	/* pi0 RW: load and store both allowed */
+	TEST_LOAD  0x80500000, EXPECT_OK,    0,                        2
+	TEST_STORE 0x80500000, EXPECT_OK,    0,                        3
+	/* pi1 no-access: load faults (cause 5), store faults (cause 7) */
+	TEST_LOAD  0x80501000, EXPECT_FAULT, CAUSE_LOAD_ACCESS_FAULT,  4
+	TEST_STORE 0x80501000, EXPECT_FAULT, CAUSE_STORE_ACCESS_FAULT, 5
+	/* pi2 R-only: load allowed, store faults */
+	TEST_LOAD  0x80502000, EXPECT_OK,    0,                        6
+	TEST_STORE 0x80502000, EXPECT_FAULT, CAUSE_STORE_ACCESS_FAULT, 7
+	/* pi3 R+X: load allowed, store faults */
+	TEST_LOAD  0x80503000, EXPECT_OK,    0,                        8
+	TEST_STORE 0x80503000, EXPECT_FAULT, CAUSE_STORE_ACCESS_FAULT, 9
+	/* pi4 RWX: load and store both allowed */
+	TEST_LOAD  0x80504000, EXPECT_OK,    0,                        10
+	TEST_STORE 0x80504000, EXPECT_OK,    0,                        11
+	/* pi5/pi6 reserved encodings (010/110): load faults (cause 5) */
+	TEST_LOAD  0x80505000, EXPECT_FAULT, CAUSE_LOAD_ACCESS_FAULT,  12
+	TEST_LOAD  0x80506000, EXPECT_FAULT, CAUSE_LOAD_ACCESS_FAULT,  13
+	/* pi7 X-only: load faults (cause 5) */
+	TEST_LOAD  0x80507000, EXPECT_FAULT, CAUSE_LOAD_ACCESS_FAULT,  14
+	/* invalid leaf (V=0): load faults (cause 5) */
+	TEST_LOAD  0x80510000, EXPECT_FAULT, CAUSE_LOAD_ACCESS_FAULT,  15
+	/* leaf with a reserved bit set: load faults (cause 5) */
+	TEST_LOAD  0x80520000, EXPECT_FAULT, CAUSE_LOAD_ACCESS_FAULT,  16
+	/* NAPOT leaf, valid G, RW: load and store both allowed */
+	TEST_LOAD  0x80600000, EXPECT_OK,    0,                        17
+	TEST_STORE 0x80600000, EXPECT_OK,    0,                        18
+	/* NAPOT leaf with a reserved G: load faults (cause 5) */
+	TEST_LOAD  0x80800000, EXPECT_FAULT, CAUSE_LOAD_ACCESS_FAULT,  19
+	.endm
+
+	/*
+	 * Emit the shared subroutines, trap handler, semihosting exit and data.
+	 * Invoke once, after the test's _start code.
+	 */
+	.macro	SMMPT_HARNESS
+	/*
+	 * do_load / do_store: perform one MPT-checked access from a3.
+	 * On return, s0 = 1 if the access faulted (else 0) and s1 = mcause.
+	 * do_store uses the value in t3.  lw/sw keep these width-agnostic.
+	 */
+	.balign	4
+do_load:
+	li	s0, 0
+	li	s1, 0
+	ENTER_MPRV
+	lw	t4, 0(a3)		/* MPT-checked load */
+	EXIT_MPRV
+	ret
+
+do_store:
+	li	s0, 0
+	li	s1, 0
+	ENTER_MPRV
+	sw	t3, 0(a3)		/* MPT-checked store */
+	EXIT_MPRV
+	ret
+
+	/*
+	 * check: verify the outcome of the last access.
+	 *   a4 = expected fault (0/1), a5 = expected cause, a6 = fail code.
+	 * Returns on success; exits with a6 on mismatch.
+	 */
+	.balign	4
+check:
+	beqz	a4, 1f
+	beqz	s0, 2f			/* expected a fault but none occurred */
+	bne	s1, a5, 2f		/* faulted with the wrong cause */
+	ret
+1:
+	bnez	s0, 2f			/* unexpected fault */
+	ret
+2:
+	mv	a0, a6
+	j	_exit
+
+	/*
+	 * M-mode trap handler.  Records that a fault occurred (s0=1) and the
+	 * mcause (s1), skips the faulting 4-byte instruction, disables MPRV
+	 * and returns.  Only clobbers t5/t6 besides s0/s1.
+	 */
+	.balign	4
+mtrap:
+	csrr	t5, mcause
+	li	s0, 1
+	mv	s1, t5
+	csrr	t6, mepc
+	addi	t6, t6, 4		/* skip the faulting instruction */
+	csrw	mepc, t6
+	li	t5, MSTATUS_MPRV
+	csrc	mstatus, t5		/* ensure MPRV is off on return */
+	mret
+
+	/* Exit via semihosting (ADP_Stopped_ApplicationExit) */
+_exit:
+#if __riscv_xlen == 32
+	/*
+	 * On RV32 the SYS_EXIT_EXTENDED parameter block cannot be used: when
+	 * this test runs on qemu-system-riscv64 with a 32-bit CPU the block
+	 * pointer is sign-extended (0xffffffff_8xxx_xxxx) and the semihosting
+	 * argument read faults.  Use the plain SYS_EXIT, which takes the exit
+	 * reason directly in a1: a successful run (a0==0) reports
+	 * ADP_Stopped_ApplicationExit and any failure reports a non-zero
+	 * reason (reported by QEMU as exit status 1).
+	 */
+	li	a1, 0x20026		/* ADP_Stopped_ApplicationExit */
+	beqz	a0, 1f
+	mv	a1, a0			/* non-zero reason -> exit status 1 */
+1:
+	li	a0, 0x18		/* TARGET_SYS_EXIT */
+#else
+	lla	a1, semiargs
+	li	t0, 0x20026
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+#endif
+
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+#if __riscv_xlen != 32
+	.data
+	.balign	8
+semiargs:
+	.space	16
+#endif
+	.endm
diff --git a/tests/tcg/riscv64/test-smmpt.S b/tests/tcg/riscv64/test-smmpt.S
new file mode 100644
index 0000000000..f8da362629
--- /dev/null
+++ b/tests/tcg/riscv64/test-smmpt.S
@@ -0,0 +1,85 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for the Smmpt43 (Supervisor Memory Protection Table) extension,
+ * per SMMTT specification v0.4.9.
+ *
+ * The test runs in M-mode and builds a 3-level Smmpt43 MPT, then drives the
+ * mode-independent checks in smmpt-common.S.  See that harness for the MPRV
+ * trick, the shared address layout and the exit-code convention.
+ *
+ * MPT layout (Smmpt43, 3 levels, 8-byte entries, 16 pages per leaf,
+ * pi = SPA[15:12], pn[i] 9 bits at SPA[16 + i*9 +: 9]):
+ *
+ *   L2 (root) @ 0x8040_0000 : entry[0]  -> non-leaf, PPN(L1)=0x80410
+ *   L1        @ 0x8041_0000 : entry[64] -> non-leaf, PPN(L0)=0x80420
+ *   L0        @ 0x8042_0000 :
+ *     entry[80]  -> non-NAPOT leaf (LEAF_ALL_XWR)  covering 0x8050_0000+
+ *     entry[81]  -> V=0 (invalid)                  covering 0x8051_0000
+ *     entry[82]  -> leaf with a reserved bit set    covering 0x8052_0000
+ *     entry[96]  -> NAPOT leaf, G=4, XWR=RW         covering 0x8060_0000
+ *     entry[128] -> NAPOT leaf, reserved G=5        covering 0x8080_0000
+ *
+ *   mmpt = MODE(1=Smmpt43)<<60 | PPN(0x80400)
+ */
+
+#include "smmpt-common.S"
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	/* Install the M-mode trap handler */
+	lla	t0, mtrap
+	csrw	mtvec, t0
+	csrw	medeleg, zero
+
+	/* PMP entry 0: NAPOT covering the whole space, RWX, so S-mode
+	 * accesses pass PMP and the MPT is the only gate. */
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, 0x1f		/* A=NAPOT(0x18) | R | W | X */
+	csrw	pmpcfg0, t0
+
+	/* Build the MPT tables (M-mode stores bypass the MPT). */
+	/* L2[0] = non-leaf -> L1 (PPN 0x80410): (0x80410 << 10) | V */
+	li	t0, 0x80400000
+	li	t1, 0x20104001
+	sd	t1, 0(t0)
+	/* L1[64] = non-leaf -> L0 (PPN 0x80420): (0x80420 << 10) | V */
+	li	t0, 0x80410000
+	li	t1, 0x20108001
+	sd	t1, 0x200(t0)		/* 64 * 8 = 0x200 */
+
+	li	t0, 0x80420000
+	/* L0[80] = non-NAPOT leaf carrying all XWR encodings (pi0..pi7) */
+	li	t1, LEAF_ALL_XWR
+	sd	t1, 0x280(t0)		/* 80 * 8 = 0x280 */
+	/* L0[81] = 0: invalid entry (V=0) */
+	sd	x0, 0x288(t0)		/* 81 * 8 = 0x288 */
+	/* L0[82] = leaf with reserved bit 3 set (V|L|rsv|XWR[pi0]=RW) */
+	li	t1, 0x30B
+	sd	t1, 0x290(t0)		/* 82 * 8 = 0x290 */
+	/* L0[96] = NAPOT leaf: V|L|N | XWR=RW(0x300) | G=4(0x4000) */
+	li	t1, 0x4307
+	sd	t1, 0x300(t0)		/* 96 * 8 = 0x300 */
+	/* L0[128] = NAPOT leaf, reserved G=5 (0x5000): V|L|N | XWR=RW */
+	li	t1, 0x5307
+	sd	t1, 0x400(t0)		/* 128 * 8 = 0x400 */
+
+	/* Program mmpt: MODE=1 (Smmpt43), PPN = 0x80400 */
+	li	t0, 0x1000000000080400
+	csrw	0x382, t0		/* CSR_MMPT */
+
+	/* mfence.pa must not fault in M-mode */
+	TEST_MFENCE_PA 1
+
+	/* Run the shared permission and structural checks */
+	RUN_LEAF_CHECKS
+
+	/* All tests passed */
+	li	a0, 0
+	j	_exit
+
+	SMMPT_HARNESS
-- 
2.43.0


