Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A0C5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNa8-0003n0-Ub; Mon, 24 Aug 2026 01:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYq-0001dh-N4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:38 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYo-00020n-8Z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:32 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so3154106a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550569; x=1788155369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/6Agw5nt0+eKUGMb/KCImqqQ0Wj2MEA9zyQKBC5/kA=;
 b=B43Giysx2i++z9qH1gee78j4INMOiholjJkgDlNu+0toNf38HKT7uteGyxaDgcthqP
 6gOtq8+cmoz8fRQVe4Sr4aVvVbWEc4RSvM/dxYSsGSU2KeysqghHZ5todVy1nVOYcHm+
 8hQ5JhkvmNol1oqdmA0l5g4kg6958rjQc6Lk7kchlNqOIzRC3vWmB2pB9kH30Ink6htl
 PbXIMKeKN8pJWBFfelQi7e7UiOSjW6yzquPaGeUNFJXjBMyPQdksu/43eOxH81t72pkM
 svKv0pGmCsvyiBU4DKfVUnEYbwrekRCJQbOOVPrWPJNKzy/fqg5glLmj1N8hf3vNiIKl
 v77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550569; x=1788155369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P/6Agw5nt0+eKUGMb/KCImqqQ0Wj2MEA9zyQKBC5/kA=;
 b=tOj/xVBdlNmnjB/sVJo56sEf1mrNGhxj3hHmcNyiuU+aViYb7LbaaOKamMLUlprUyZ
 20U7Qp94oqN7ru0x2MIwq1/JcyHMc/CnKXLZrjKdSOA+pyebSPcHznzEbkX5i0TlyMX+
 K9LCS3/eB6vk6H3dw2IAkBd1ByZCq29E3Zn33YDw9qxkA0frCsqCO8VsBT1+ShYP0Um4
 +ltSa4wxKHiElAoPyt06p2h+tbua/V8A0dFVWNEYc1R6GXPyePGHxpZ/TvZsWkgV+V2z
 pyiIltBWSx+oHVCwCuZUZs/2tyKDCnsRlTmU/9KsoJO2fDnRbhMFxCuv+vEVI+uWCU6f
 98lw==
X-Gm-Message-State: AFuF++lquwfnSIDiSDRvhoyQLUzf8pEVJDNbkr0eFdFc0zcA1ZSsOvxw
 2WJEOCCXrHtQAN0GUy1TS/O6JuDg9Ky5DOQQqBu3WDD9gCmyPn4AQ3mkRyr9QA==
X-Gm-Gg: AR+sD12kQYLo25t5WkAHu/YVFToZNxoadvc9cWxtvUrLuJMlgxiIBdiJdwEey3EAvJl
 wi6Xpiy0FJjbZJgVXZFX2kdcSyckmGQZT6+mHEl9+yA7/ctNTnhKEnhsvWYQQFKqR3+eCSwgcaa
 x73s62JtmQGZYCIvtmHQoebmfCSRtRv8WPhQ2b7tObTQc69gLi6eQlO2P7l70IIm7ZzXSmvUy/N
 04lbd9e6HMXcSn2v/FNaxWOh/aF46irwZDa0b1tmR0eX78X2iHwnXtdaIuon/K50jLoytlETJt/
 wv34WjvtN2KT/dN+VydZNu+NLPfnkjnpeZdwy55vE4SvFhxSNa/8ZE3pk4Jz3jiAfzJSMO/Pjrv
 tEMym2QblA1HsZ31TpLlK2Dl0+N8NEWF0DmdfzMCNm7d6f2R0/3pCfdIrNupQpiniww8ClysTMV
 9ziYu4gHNSWLgWBLHtSmBShWcsF0l09nRIkm5uG79jq689A/AUEKTNthAX+9uo9PiHyZe+pvZ6i
 BuLXA==
X-Received: by 2002:a17:90b:524b:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-395deec4953mr30437985a91.5.1787550568697; 
 Sun, 23 Aug 2026 22:49:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 22/96] tests/tcg/riscv64: Add test for Zicclsm
Date: Mon, 24 Aug 2026 15:46:52 +1000
Message-ID: <20260824054806.2790041-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Cover scalar, floating-point, vector, and segmented misaligned accesses
with Zicclsm enabled and disabled. Clean up both generated test
binaries.

To build and run the tests:

    make -C build/tests/tcg/riscv64-softmmu \
        CC=riscv64-unknown-elf-gcc LD=riscv64-unknown-elf-ld \
        test-zicclsm test-zicclsm-off

    make -C build/tests/tcg/riscv64-softmmu \
        run-test-zicclsm run-test-zicclsm-off

To clean the generated binaries and objects:

    make -C build/tests/tcg/riscv64-softmmu clean

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-8-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  22 ++
 tests/tcg/riscv64/test-zicclsm.S          | 368 ++++++++++++++++++++++
 2 files changed, 390 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zicclsm.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 82be8a2c91..908fd008e4 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -41,5 +41,27 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+# Zicclsm: misaligned load/store support. Assemble one source twice: the
+# default build expects every misaligned access to succeed (zicclsm=true),
+# the -DZICCLSM_DISABLED build expects every one to trap (zicclsm=false).
+ZICCLSM_MARCH = -march=rv64gcv_zfh
+CLEANFILES += test-zicclsm test-zicclsm-off
+
+test-zicclsm: test-zicclsm.S $(LINK_SCRIPT)
+	$(CC) $(CFLAGS) $(ZICCLSM_MARCH) $< -Wa,--noexecstack -c -o test-zicclsm.o
+	$(LD) $(LDFLAGS) test-zicclsm.o -o $@
+
+test-zicclsm-off: test-zicclsm.S $(LINK_SCRIPT)
+	$(CC) $(CFLAGS) $(ZICCLSM_MARCH) -DZICCLSM_DISABLED $< -Wa,--noexecstack -c -o test-zicclsm-off.o
+	$(LD) $(LDFLAGS) test-zicclsm-off.o -o $@
+
+EXTRA_RUNS += run-test-zicclsm
+run-test-zicclsm: test-zicclsm
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=true $(QEMU_OPTS)$<)
+
+EXTRA_RUNS += run-test-zicclsm-off
+run-test-zicclsm-off: test-zicclsm-off
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-zicclsm.S b/tests/tcg/riscv64/test-zicclsm.S
new file mode 100644
index 0000000000..a2f217c0d1
--- /dev/null
+++ b/tests/tcg/riscv64/test-zicclsm.S
@@ -0,0 +1,368 @@
+/*
+ * Test the Zicclsm extension (misaligned load/store support).
+ *
+ * This single source is assembled twice:
+ *   - test-zicclsm      : run on a CPU with zicclsm=true. Every misaligned
+ *                         scalar integer, floating-point and vector
+ *                         load/store must complete WITHOUT raising a trap.
+ *   - test-zicclsm-off  : built with -DZICCLSM_DISABLED and run on a CPU with
+ *                         zicclsm=false. Every misaligned access must raise a
+ *                         misaligned load/store exception, with the correct
+ *                         mcause and mtval.
+ *
+ * Zicclsm governs all regular scalar loads/stores (integer and F/D/Zfh
+ * floating-point) as well as vector element loads/stores.  Floating-point
+ * loads/stores (flh/flw/fld, fsh/fsw/fsd) are therefore exercised here.
+ *
+ * Atomic (A/Zacas/...) accesses are intentionally excluded: they always
+ * require natural alignment regardless of Zicclsm.  Likewise cm.push/cm.pop
+ * (Zcmp) are excluded, as they are not regular loads/stores.
+ *
+ * Register conventions (persist across the whole test; the trap handler only
+ * clobbers t0-t4):
+ *   s1 = expected mcause for the pending misaligned access
+ *   s2 = expected mtval (the misaligned address)
+ *   s3 = trap counter (incremented by the handler)
+ *   s4 = base address of the aligned data buffer
+ *   s5 = snapshot of s3 taken before an access, used to check the delta
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option	norelax
+	.option	norvc
+
+/* RISC-V exception causes (see target/riscv/cpu_bits.h). */
+#define CAUSE_LOAD_MISALIGNED	0x4
+#define CAUSE_STORE_MISALIGNED	0x6
+
+/*
+ * EXPECT sets up the expectation for the access that immediately follows and
+ * snapshots the trap counter.
+ *   \cause = expected mcause if the access traps
+ *   \off   = byte offset from the buffer base; also the expected mtval
+ */
+	.macro	EXPECT cause, off
+	li	s1, \cause
+	addi	s2, s4, \off
+	mv	s5, s3
+	.endm
+
+/*
+ * CHECK validates the outcome of the preceding access.
+ *   - When Zicclsm is disabled, exactly one trap must have fired.
+ *   - When Zicclsm is enabled, no trap must have fired.
+ */
+	.macro	CHECK
+#ifdef ZICCLSM_DISABLED
+	addi	s5, s5, 1
+	bne	s3, s5, fail
+#else
+	bne	s3, s5, fail
+#endif
+	.endm
+
+/* In the enabled case, also verify the value returned by scalar loads. */
+	.macro	CHECK_VALUE value
+#ifndef ZICCLSM_DISABLED
+	li	t0, \value
+	bne	a2, t0, fail
+#endif
+	.endm
+
+/* Verify bytes written by an enabled scalar store. */
+	.macro	CHECK_BYTE off, value
+#ifndef ZICCLSM_DISABLED
+	lbu	t0, \off(s4)
+	li	t1, \value
+	bne	t0, t1, fail
+#endif
+	.endm
+
+	.text
+	.global	_start
+_start:
+	/* Install the trap handler. */
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Enable the FP (FS) and Vector (VS) unit state so F/D/V instructions
+	 * do not trap as illegal. 0x6600 = FS[14:13]=11 | VS[10:9]=11. */
+	li	t0, 0x6600
+	csrs	mstatus, t0
+
+	/* Initialise persistent state. */
+	li	s3, 0			/* trap counter */
+	lla	s4, buf			/* aligned buffer base */
+
+	/*
+	 * ---- Scalar integer loads ----
+	 * lh/lhu need 2-byte alignment; lw/lwu 4-byte; ld 8-byte.
+	 */
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	lh	a2, 1(s4)
+	CHECK
+	CHECK_VALUE 0x2211
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	lhu	a2, 1(s4)
+	CHECK
+	CHECK_VALUE 0x2211
+
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	lw	a2, 1(s4)
+	CHECK
+	CHECK_VALUE 0x44332211
+	EXPECT	CAUSE_LOAD_MISALIGNED, 3
+	lw	a2, 3(s4)
+	CHECK
+	CHECK_VALUE 0x66554433
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	lwu	a2, 1(s4)
+	CHECK
+	CHECK_VALUE 0x44332211
+
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	ld	a2, 1(s4)
+	CHECK
+	CHECK_VALUE 0x8877665544332211
+	EXPECT	CAUSE_LOAD_MISALIGNED, 3
+	ld	a2, 3(s4)
+	CHECK
+	CHECK_VALUE 0xaa99887766554433
+	EXPECT	CAUSE_LOAD_MISALIGNED, 7
+	ld	a2, 7(s4)
+	CHECK
+	CHECK_VALUE 0xeeddccbbaa998877
+
+	/*
+	 * ---- Scalar integer stores ----
+	 */
+	li	t6, 0x1122334455667788
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	sh	t6, 1(s4)
+	CHECK
+	CHECK_BYTE 1, 0x88
+	CHECK_BYTE 2, 0x77
+
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	sw	t6, 1(s4)
+	CHECK
+	CHECK_BYTE 1, 0x88
+	CHECK_BYTE 2, 0x77
+	CHECK_BYTE 3, 0x66
+	CHECK_BYTE 4, 0x55
+	EXPECT	CAUSE_STORE_MISALIGNED, 3
+	sw	t6, 3(s4)
+	CHECK
+	CHECK_BYTE 3, 0x88
+	CHECK_BYTE 4, 0x77
+	CHECK_BYTE 5, 0x66
+	CHECK_BYTE 6, 0x55
+
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	sd	t6, 1(s4)
+	CHECK
+	CHECK_BYTE 1, 0x88
+	CHECK_BYTE 2, 0x77
+	CHECK_BYTE 3, 0x66
+	CHECK_BYTE 4, 0x55
+	CHECK_BYTE 5, 0x44
+	CHECK_BYTE 6, 0x33
+	CHECK_BYTE 7, 0x22
+	CHECK_BYTE 8, 0x11
+	EXPECT	CAUSE_STORE_MISALIGNED, 7
+	sd	t6, 7(s4)
+	CHECK
+	CHECK_BYTE 7, 0x88
+	CHECK_BYTE 8, 0x77
+	CHECK_BYTE 9, 0x66
+	CHECK_BYTE 10, 0x55
+	CHECK_BYTE 11, 0x44
+	CHECK_BYTE 12, 0x33
+	CHECK_BYTE 13, 0x22
+	CHECK_BYTE 14, 0x11
+
+	/*
+	 * ---- Floating-point loads ----
+	 * flh needs 2-byte alignment; flw 4-byte; fld 8-byte.  Their alignment
+	 * is governed by Zicclsm just like the scalar integer forms.
+	 */
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	flh	fa0, 1(s4)
+	CHECK
+
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	flw	fa0, 1(s4)
+	CHECK
+	EXPECT	CAUSE_LOAD_MISALIGNED, 3
+	flw	fa0, 3(s4)
+	CHECK
+
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	fld	fa0, 1(s4)
+	CHECK
+	EXPECT	CAUSE_LOAD_MISALIGNED, 7
+	fld	fa0, 7(s4)
+	CHECK
+
+	/*
+	 * ---- Floating-point stores ----
+	 */
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	fsh	fa0, 1(s4)
+	CHECK
+
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	fsw	fa0, 1(s4)
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 3
+	fsw	fa0, 3(s4)
+	CHECK
+
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	fsd	fa0, 1(s4)
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 7
+	fsd	fa0, 7(s4)
+	CHECK
+
+	/*
+	 * ---- Vector unit-stride loads / stores ----
+	 * A base address that is not aligned to the element size (SEW) is
+	 * misaligned for the first element access.
+	 */
+	vsetvli	t1, x0, e16, m1, ta, ma
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	addi	a0, s4, 1
+	vle16.v	v0, (a0)
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	addi	a0, s4, 1
+	vse16.v	v0, (a0)
+	CHECK
+
+	vsetvli	t1, x0, e32, m1, ta, ma
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	addi	a0, s4, 1
+	vle32.v	v0, (a0)
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 3
+	addi	a0, s4, 3
+	vse32.v	v0, (a0)
+	CHECK
+
+	vsetvli	t1, x0, e64, m1, ta, ma
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	addi	a0, s4, 1
+	vle64.v	v0, (a0)
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 7
+	addi	a0, s4, 7
+	vse64.v	v0, (a0)
+	CHECK
+
+	/*
+	 * ---- Vector strided loads / stores ----
+	 */
+	vsetvli	t1, x0, e32, m1, ta, ma
+	li	a1, 8			/* stride in bytes */
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	addi	a0, s4, 1
+	vlse32.v	v0, (a0), a1
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	addi	a0, s4, 1
+	vsse32.v	v0, (a0), a1
+	CHECK
+
+	/* ---- Vector indexed loads / stores ---- */
+	/*
+	 * Zero indices keep the first element at the deliberately misaligned base.
+	 */
+	vmv.v.i	v1, 0
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	addi	a0, s4, 1
+	vluxei32.v	v0, (a0), v1
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	addi	a0, s4, 1
+	vsuxei32.v	v0, (a0), v1
+	CHECK
+
+	/* ---- Vector segmented loads / stores ---- */
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	addi	a0, s4, 1
+	vlseg2e32.v	v0, (a0)
+	CHECK
+	EXPECT	CAUSE_STORE_MISALIGNED, 1
+	addi	a0, s4, 1
+	vsseg2e32.v	v0, (a0)
+	CHECK
+
+	/*
+	 * ---- Vector whole-register load ----
+	 * Only the whole-register *load* forms carry an element width
+	 * (vl1re32.v => EEW=32), so only they enforce alignment when Zicclsm is
+	 * off.  The whole-register store form (vs1r.v) is defined as EEW=8
+	 * (byte granular) and therefore never faults on misalignment, so it is
+	 * not exercised here.
+	 */
+	EXPECT	CAUSE_LOAD_MISALIGNED, 1
+	addi	a0, s4, 1
+	vl1re32.v	v1, (a0)
+	CHECK
+
+	/* Success. */
+	li	a0, 0
+	j	_exit
+
+	/*
+	 * Trap handler: validate mcause and mtval against the expectation, bump
+	 * the trap counter, then skip past the faulting instruction.  The
+	 * instruction length is decoded from its low two bits (0b11 => 4 bytes,
+	 * otherwise a 2-byte compressed instruction).
+	 */
+	.balign	4
+trap:
+	csrr	t0, mcause
+	bne	t0, s1, fail
+	csrr	t1, mtval
+	bne	t1, s2, fail
+	addi	s3, s3, 1
+
+	csrr	t0, mepc
+	lhu	t2, 0(t0)
+	andi	t3, t2, 3
+	li	t4, 3
+	bne	t3, t4, 1f
+	addi	t0, t0, 4		/* 32-bit instruction */
+	j	2f
+1:
+	addi	t0, t0, 2		/* 16-bit compressed instruction */
+2:
+	csrw	mepc, t0
+	mret
+
+fail:
+	li	a0, 1
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
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
+	.balign	64
+buf:
+	.byte	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77
+	.byte	0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff
+	.space	240
-- 
2.54.0


