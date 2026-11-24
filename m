Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D828606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GM5DSllS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwV3-00028f-L8; Tue, 24 Nov 2026 14:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVwUl-00025i-Eg; Tue, 24 Nov 2026 14:48:03 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVwUj-0006Bk-H6; Tue, 24 Nov 2026 14:48:03 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E9D461EDE;
 Tue, 24 Nov 2026 19:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7601F000D0;
 Tue, 24 Nov 2026 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795549678;
 bh=5S3SlIa6EtSvbqxlsU1Lfl9OJby7kPC2CyAnzoqh4RQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GM5DSllSESCRcRrIRz8nwcA11hEkgmInx/zoG0lyNbYzSlOiFOWnFTFWRs+fvfa54
 aTLBp2fCe+LfHcPxHmrixpiuOuY5VO3/BA54MGtdPuO3qV9Dff7g6XCj0elRSVV95o
 6ujhzSngoglspx47DES6AyD0DpEexVZ08f8Kw8SCxBKzGlmr3S+RfzV7uGOcVA+HZN
 UEngzhSESpuvQr3EN+tsJ/O2s3FcHjbx0TIGFuPbw0LF2DIzi9T1exthapRtGj3CS2
 8nOHSPsyuTdAAyjJD9OyH/UIxJ1FZdq6Ia+KgxOYa9MZemWfafEQQvAuyoCaShEylt
 Ib8qJWA3pnt+w==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 24 Nov 2026 11:47:50 -0800
Subject: [PATCH v9 2/7] tests/tcg/riscv64: add test for the srmcfg CSR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-riscv-ssqosid-cbqri-v9-2-73b961a3f1d9@kernel.org>
References: <20261124-riscv-ssqosid-cbqri-v9-0-73b961a3f1d9@kernel.org>
In-Reply-To: <20261124-riscv-ssqosid-cbqri-v9-0-73b961a3f1d9@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6398; i=fustini@kernel.org;
 h=from:subject:message-id; bh=RwlTwtjmFYekxu3uJdgDOpweqtI4+VTIun1/NFEaMwg=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSzvnz95Rzr14/+0ieTLu4KeP193rq5vbuuzNPfEScnw
 loe5VMg21HKwiDGxSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYyNcKRoa1Qi4+Ag3N7bx2
 c22eCO9bp/hnw3WlY847DvBrbT4d9EqX4b/HCbtye1+DCw5l+/f6a7/yTIlaFi7NbOMXlr7d+am
 0CTcA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check that only the RCID and MCID fields of srmcfg are writable and
that an S-mode access to srmcfg raises an illegal instruction exception
unless mstateen0.SRMCFG is set. Also check that a VS-mode access raises
a virtual instruction exception when mstateen0.SRMCFG is set and an
illegal instruction exception when it is clear.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 tests/tcg/riscv64/system/meson.build |   1 +
 tests/tcg/riscv64/test-srmcfg.S      | 210 +++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index cdd2e99d22a3..12f972ccab74 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -26,6 +26,7 @@ tests += {
   'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
   'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
+  'test-srmcfg.S': setup + {'qemu_args': ['-cpu', 'rv64,ssqosid=true,smstateen=true', qemu_args]},
   'test-zvabd.S': setup + {'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,x-zvabd=true', qemu_args]},
   'test-vsepc-masking.S': setup + {
     'test_name': 'test-vsepc-masking-c',
diff --git a/tests/tcg/riscv64/test-srmcfg.S b/tests/tcg/riscv64/test-srmcfg.S
new file mode 100644
index 000000000000..a1c956c0b977
--- /dev/null
+++ b/tests/tcg/riscv64/test-srmcfg.S
@@ -0,0 +1,210 @@
+/*
+ * RISC-V Ssqosid srmcfg CSR test: check the WARL fields of srmcfg, that
+ * mstateen0.SRMCFG is writable, and that an S-mode access to srmcfg
+ * raises an illegal instruction exception while mstateen0.SRMCFG is
+ * clear and succeeds once it is set. A VS-mode access raises a virtual
+ * instruction exception while mstateen0.SRMCFG is set and an illegal
+ * instruction exception while it is clear.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.equ CSR_SRMCFG,		0x181
+.equ CSR_MSTATEEN0,		0x30c
+.equ SRMCFG_RCID_MCID,		0x0FFF0FFF
+.equ MSTATEEN0_SRMCFG,		(1 << 55)
+.equ MSTATUS_MPP,		0x1800
+.equ MSTATUS_MPP_S,		0x0800
+.equ MSTATUS_MPV,		(1 << 39)
+.equ CAUSE_ILLEGAL_INST,	2
+.equ CAUSE_ECALL_S,		9
+.equ CAUSE_ECALL_VS,		10
+.equ CAUSE_VIRT_INST,		22
+.equ PMPCFG_NAPOT_RWX,		0x1f
+.equ SRMCFG_TEST_VALUE,		0x00550033	/* MCID 0x55, RCID 0x33 */
+
+	.option norvc
+	.text
+
+	.global _start
+
+_start:
+	la	t0, trap_handler
+	csrw	mtvec, t0
+
+	/* Let S-mode access all of memory. */
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, PMPCFG_NAPOT_RWX
+	csrw	pmpcfg0, t0
+
+	/* Only the RCID and MCID fields of srmcfg are writable. */
+	li	t0, -1
+	csrw	CSR_SRMCFG, t0
+	csrr	t1, CSR_SRMCFG
+	li	t2, SRMCFG_RCID_MCID
+	bne	t1, t2, _fail
+
+	/* mstateen0.SRMCFG must not be read-only zero. */
+	li	t0, MSTATEEN0_SRMCFG
+	csrw	CSR_MSTATEEN0, t0
+	csrr	t1, CSR_MSTATEEN0
+	and	t1, t1, t0
+	beqz	t1, _fail
+
+	/*
+	 * With mstateen0.SRMCFG clear an S-mode access to srmcfg must raise
+	 * an illegal instruction exception.
+	 */
+	csrw	CSR_MSTATEEN0, zero
+	la	t0, smode_access_blocked
+	jal	enter_smode
+	la	t0, trap_mcause
+	ld	t1, 0(t0)
+	li	t2, CAUSE_ILLEGAL_INST
+	bne	t1, t2, _fail
+
+	/*
+	 * With mstateen0.SRMCFG set an S-mode write to srmcfg must not trap
+	 * and must read back.
+	 */
+	li	t0, MSTATEEN0_SRMCFG
+	csrw	CSR_MSTATEEN0, t0
+	la	t0, trap_mcause
+	sd	zero, 0(t0)
+	la	t0, smode_access_allowed
+	jal	enter_smode
+	la	t0, trap_mcause
+	ld	t1, 0(t0)
+	bnez	t1, _fail
+	la	t0, smode_value
+	ld	t1, 0(t0)
+	li	t2, SRMCFG_TEST_VALUE
+	bne	t1, t2, _fail
+
+	/*
+	 * With mstateen0.SRMCFG set a VS-mode access to srmcfg must raise a
+	 * virtual instruction exception.
+	 */
+	la	t0, smode_access_blocked
+	jal	enter_vsmode
+	la	t0, trap_mcause
+	ld	t1, 0(t0)
+	li	t2, CAUSE_VIRT_INST
+	bne	t1, t2, _fail
+
+	/*
+	 * With mstateen0.SRMCFG clear the same VS-mode access must raise an
+	 * illegal instruction exception.
+	 */
+	csrw	CSR_MSTATEEN0, zero
+	la	t0, smode_access_blocked
+	jal	enter_vsmode
+	la	t0, trap_mcause
+	ld	t1, 0(t0)
+	li	t2, CAUSE_ILLEGAL_INST
+	bne	t1, t2, _fail
+
+	li	a0, 0
+	j	_exit
+
+_fail:
+	li	a0, 1
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
+/*
+ * Run the code at t0 in S-mode. That code ends with an ecall, which the
+ * trap handler turns into a return to M-mode at the instruction after
+ * the ecall, so the S-mode code returns to our caller with ra intact.
+ */
+enter_smode:
+	li	t1, MSTATUS_MPP
+	csrc	mstatus, t1
+	li	t1, MSTATUS_MPP_S
+	csrs	mstatus, t1
+	csrw	mepc, t0
+	mret
+
+/* Same as enter_smode, with mstatus.MPV set so that mret enters VS-mode. */
+enter_vsmode:
+	li	t1, MSTATUS_MPP
+	csrc	mstatus, t1
+	li	t1, MSTATUS_MPP_S | MSTATUS_MPV
+	csrs	mstatus, t1
+	csrw	mepc, t0
+	mret
+
+/* The csrr is expected to trap. The handler skips it and the nop. */
+smode_access_blocked:
+	csrr	t1, CSR_SRMCFG
+	nop
+	ecall
+	ret
+
+smode_access_allowed:
+	li	t1, SRMCFG_TEST_VALUE
+	csrw	CSR_SRMCFG, t1
+	csrr	t1, CSR_SRMCFG
+	la	t2, smode_value
+	sd	t1, 0(t2)
+	ecall
+	ret
+
+	.balign	4
+trap_handler:
+	csrr	t4, mcause
+	li	t5, CAUSE_ECALL_S
+	beq	t4, t5, 1f
+	li	t5, CAUSE_ECALL_VS
+	beq	t4, t5, 1f
+	li	t5, CAUSE_ILLEGAL_INST
+	beq	t4, t5, 3f
+	li	t5, CAUSE_VIRT_INST
+	bne	t4, t5, 2f
+
+3:
+	/* Record the cause and skip the trapping insn and the one after it. */
+	la	t5, trap_mcause
+	sd	t4, 0(t5)
+	csrr	t4, mepc
+	addi	t4, t4, 8
+	csrw	mepc, t4
+	mret
+
+2:
+	/* Any other trap is a failure: exit from M-mode. */
+	li	t5, MSTATUS_MPP
+	csrs	mstatus, t5
+	la	t4, _fail
+	csrw	mepc, t4
+	mret
+
+1:
+	/* ecall from S or VS-mode: return to M-mode after the ecall. */
+	li	t5, MSTATUS_MPP
+	csrs	mstatus, t5
+	csrr	t4, mepc
+	addi	t4, t4, 4
+	csrw	mepc, t4
+	mret
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
+trap_mcause:
+	.space	8
+smode_value:
+	.space	8

-- 
2.43.0


