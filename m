Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D6CCA465
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQE-00070R-7F; Thu, 15 Oct 2026 21:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWN9-0001TR-2j
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWN2-0004NP-7B
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e942864693so10294785ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112664; x=1792717464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KQjiTzatNJCJQkGwAPuBoHRcCXFWmljf4WQq/JCwzHo=;
 b=NSE3hv7308sU47NfAJMfeypUBUzixyvP8Px4kfftwj8kIMQ07iawxhivVQj75CU6HQ
 rfF3yIUuKgk4tmkx8aiTkF0I+w++zyzPzb7hg8tFQcSuyUDEXNaWiWwVoHExdYf4a9ld
 I4M/PsnI8N+tizdu0MG1F+Hp6dWCaI8mSKjFXQyTPRKK2xivAXswgKob61o7a8RbTIZM
 8umIVqcyiix6raYa/m012SZGxtNgnuIAzmTvPcngBQ5+uegJb4Aanem5N9AL8iyZdl6Z
 IvADRjqWK7f30EoH6VyL28mO1vGpjhod8+ucLNLVB+SZawgCsrb8POF6ehs7NhxEvY14
 GZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112664; x=1792717464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KQjiTzatNJCJQkGwAPuBoHRcCXFWmljf4WQq/JCwzHo=;
 b=MAxcH2pHaGZT5h8xMv2jgUxswPV1cX+gpHLa/HeIlnoFSxiLn9eNN3cFAKCvqnGlor
 Zt7z+6v4QMogrx0S09Dz64mRQlRIch4AHLC0eodE80nkaLTfyihub5WI1xZ5oFfQ847h
 TjtiR2keu7loSymNbuLDEt/fdn0fzsLszyYrPtTGwt1+ijH7c7MpXhxI++98ttXV1SQ7
 ODtyaG6J/Imvcc2anpZWmzB1cqX0SFY/I3+DIZlmv/Ek6EDrKlCL22fd2uKuoIDvDRo5
 RqyFv9unxeotyIJQTNMKHXlQ1ysenopCz/9002GHiAGMmMchnJ4eaLcAwFjupsYUaVmW
 IJBQ==
X-Gm-Message-State: AFq9FYI7zgz+jCXslBglbpv6jho9+S2TZhzEA5QNoOZDFzBXK8lAMbWC
 LN/zN2O+v9YyhQi1zZp/gsGVhPpI/2nO0wEY+YEAw43Y5EdQQC0KwnKOrFAQYw==
X-Gm-Gg: AYBFou0t66ptSpD4ySxoHzN1ROHfSTTOg/qFj3CoBwHlNloF3OixRjbn7tNzJQFjhLD
 rXuk4Ch5SpbtNfAd+VHUSkvRTT4/dzkF/vEc/AbuwtUP0xlA6pB7c7IXgrUM02+4T37qd5hB5CO
 VKMrpnimeSJFo1SOcFDxJk2ANFIjSXJrt5iGVniwdcf/CmP4nItmDQSWUSSPPoCgsGhcEoBi8bd
 yD7RH7Loqb3J0S8d3GvKd9y4QFXsvvtQSoVM/0mwGRO27xqX0SVRqib8n8T+3DNcWlWGwm+5lWZ
 HIIbio479jsHm/MpcoEoYQ5ZWIG9Dcg1xAsppiofIpelB6g59+nDv7j/Y8GvyJSjUctruiGxgoK
 z7uwNXGzRl6lwlxr7UcO2Zjwxo4sMudNKeF0nzRpAujdGAC8gCDsoBa3v4bUSSVYNRXtjGmmq/4
 Q095/o7pEU/OvOoaVKZbjGGZeKfTOze1w1CKWOCyjnvEcbADTgGjv4JfWS2vdGHLVDbdCyfZxqn
 /6F4nsIZ3ixAkv7
X-Received: by 2002:a17:902:ce08:b0:2e9:776f:66b3 with SMTP id
 d9443c01a7336-2e9776f76ffmr16172755ad.2.1792112663919; 
 Thu, 15 Oct 2026 18:04:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL v2 34/50] tests/tcg/riscv64: Add tests for SiFive int8 matmul
 extensions
Date: Fri, 16 Oct 2026 11:02:21 +1000
Message-ID: <20261016010237.1102834-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Max Chou <max.chou@sifive.com>

Add a test that exercises all SiFive int8 matrix-multiply instructions
from the Xsfvqmaccqoq and Xsfvqmaccdod extensions.

For each tile shape the test covers the four signedness variants
(sf.vqmaccu / sf.vqmacc / sf.vqmaccus / sf.vqmaccsu) and the
reserved-encoding path: with vl set to a value that is not a multiple
of the tile size the helper raises an illegal-instruction exception.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-7-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                          |   1 +
 tests/tcg/riscv64/system/meson.build |   7 +
 tests/tcg/riscv64/test-xsfvqmacc.S   | 260 +++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-xsfvqmacc.S

diff --git a/MAINTAINERS b/MAINTAINERS
index de47c4a879..cceefb4cb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -406,6 +406,7 @@ F: target/riscv/xsf.decode
 F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
 F: target/riscv/tcg/xsf_helper.c
 F: disas/riscv-xsf*
+F: tests/tcg/riscv64/test-xsfvqmacc.S
 
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index a7478b4219..3e1c970382 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -70,6 +70,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-xsfvqmacc.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,xsfvqmaccdod=true,xsfvqmaccqoq=true', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-xsfvqmacc.S b/tests/tcg/riscv64/test-xsfvqmacc.S
new file mode 100644
index 0000000000..a116712e50
--- /dev/null
+++ b/tests/tcg/riscv64/test-xsfvqmacc.S
@@ -0,0 +1,260 @@
+/*
+ * Test the SiFive Xsfvqmaccqoq/Xsfvqmaccdod custom int8 matrix-multiply
+ * extensions.
+ *
+ * The eight instructions widen 8-bit integer inputs to 32 bits and perform
+ * a matrix-multiply-accumulate into a vector of int32 accumulators:
+ *
+ *   C[j] += A * B[j]
+ *
+ * Xsfvqmaccqoq (4x8x4): A is 4x8, B[j] is 8x4, C[j] is 4x4 int32. One matrix
+ * operation is performed per 32 elements of vl (TILE_SIZE = 32).
+ * Xsfvqmaccdod (2x8x2): A is 2x8, B[j] is 8x2, C[j] is 2x2 int32. One matrix
+ * operation is performed per 16 elements of vl (TILE_SIZE = 16).
+ *
+ * The input tiles below contain bytes >= 0x80 so that each signedness
+ * variant produces a distinct result; the expected int32 tiles were computed
+ * with an independent reference model of the specification. The accumulators
+ * are cleared before every operation, so the expected value is the pure
+ * matrix product.
+ *
+ * Test exits via semihosting with status 0 on success, or the 1-based index
+ * of the first failing operation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option arch, +v
+	.option norvc
+
+	.text
+
+/*
+ * Run one 4x8x4 operation: load the 32-byte A and B tiles, clear the 4x4
+ * int32 accumulator (vd = v4:v5, EMUL = 2), execute the op, then compare the
+ * 16 int32 results against the expected tile.
+ */
+.macro RUN_QOQ id, word, exp
+	li	a2, 32
+	vsetvli	t0, a2, e8, m1, ta, ma
+	la	t1, a_qoq
+	vle8.v	v1, (t1)
+	la	t1, b_qoq
+	vle8.v	v2, (t1)
+	vsetvli	t0, x0, e32, m2, ta, ma
+	vmv.v.i	v4, 0
+	li	a2, 32
+	vsetvli	t0, a2, e8, m1, ta, ma
+	.word	\word
+	vsetvli	t0, x0, e32, m2, ta, ma
+	la	t1, result
+	vse32.v	v4, (t1)
+	la	a0, result
+	la	a1, \exp
+	li	a2, 16
+	li	t6, \id
+	call	check_words
+.endm
+
+/*
+ * Run one 2x8x2 operation: load the 16-byte A and B tiles, clear the 2x2
+ * int32 accumulator (vd = v4, EMUL = 1), execute the op, then compare the
+ * 4 int32 results against the expected tile.
+ */
+.macro RUN_DOD id, word, exp
+	li	a2, 16
+	vsetvli	t0, a2, e8, m1, ta, ma
+	la	t1, a_dod
+	vle8.v	v1, (t1)
+	la	t1, b_dod
+	vle8.v	v2, (t1)
+	vsetvli	t0, x0, e32, m1, ta, ma
+	vmv.v.i	v4, 0
+	li	a2, 16
+	vsetvli	t0, a2, e8, m1, ta, ma
+	.word	\word
+	vsetvli	t0, x0, e32, m1, ta, ma
+	la	t1, result
+	vse32.v	v4, (t1)
+	la	a0, result
+	la	a1, \exp
+	li	a2, 4
+	li	t6, \id
+	call	check_words
+.endm
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
+	RUN_QOQ	1, 0xF220A25B, exp_qoq_u	/* sf.vqmaccu.4x8x4  */
+	RUN_QOQ	2, 0xF620A25B, exp_qoq_s	/* sf.vqmacc.4x8x4   */
+	RUN_QOQ	3, 0xFA20A25B, exp_qoq_us	/* sf.vqmaccus.4x8x4 */
+	RUN_QOQ	4, 0xFE20A25B, exp_qoq_su	/* sf.vqmaccsu.4x8x4 */
+	RUN_DOD	5, 0xB220A25B, exp_dod_u	/* sf.vqmaccu.2x8x2  */
+	RUN_DOD	6, 0xB620A25B, exp_dod_s	/* sf.vqmacc.2x8x2   */
+	RUN_DOD	7, 0xBA20A25B, exp_dod_us	/* sf.vqmaccus.2x8x2 */
+	RUN_DOD	8, 0xBE20A25B, exp_dod_su	/* sf.vqmaccsu.2x8x2 */
+
+	/*
+	 * Illegal-instruction reporting test (op 9).
+	 *
+	 * When vl is not a multiple of the tile size the instruction is
+	 * reserved and the helper raises an illegal-instruction exception at
+	 * runtime.
+	 */
+	la	t1, trap_mtval
+	sd	zero, 0(t1)
+	la	t1, trap_mcause
+	sd	zero, 0(t1)
+	/* vl = 16 is not a multiple of the 4x8x4 tile size (32 elements). */
+	li	a2, 16
+	vsetvli	t0, a2, e8, m1, ta, ma
+	.word	0xF220A25B		/* sf.vqmaccu.4x8x4, traps */
+	/* The handler skips the faulting insn, so control resumes here. */
+	li	a0, 9			/* fail code for this check */
+	la	t1, trap_mcause
+	ld	t2, 0(t1)
+	li	t3, 2			/* RISCV_EXCP_ILLEGAL_INST */
+	bne	t2, t3, _exit
+	la	t1, trap_mtval
+	ld	t2, 0(t1)
+	li	t3, 0xF220A25B
+	bne	t2, t3, _exit
+
+	li	a0, 0
+	j	_exit
+
+/*
+ * Machine-mode trap handler: record mcause and mtval, then advance mepc
+ * past the 4-byte faulting instruction and return.
+ */
+	.balign	4
+trap_handler:
+	csrr	t4, mcause
+	la	t5, trap_mcause
+	sd	t4, 0(t5)
+	csrr	t4, mtval
+	la	t5, trap_mtval
+	sd	t4, 0(t5)
+	csrr	t4, mepc
+	addi	t4, t4, 4
+	csrw	mepc, t4
+	mret
+
+/*
+ * check_words(a0 = result, a1 = expected, a2 = word count).
+ * Returns to the caller if every word matches; otherwise exits with the
+ * operation index held in t6.
+ */
+check_words:
+1:	beqz	a2, 2f
+	lw	t2, 0(a0)
+	lw	t3, 0(a1)
+	bne	t2, t3, 3f
+	addi	a0, a0, 4
+	addi	a1, a1, 4
+	addi	a2, a2, -1
+	j	1b
+2:	ret
+3:	mv	a0, t6
+	j	_exit
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
+	.data
+	.balign	8
+semiargs:
+	.space	16
+result:
+	.space	64
+trap_mcause:
+	.space	8
+trap_mtval:
+	.space	8
+
+/*
+ * A (4x8, row-major) in bytes [0, 32) of vs1.
+ */
+a_qoq:
+	.byte	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x80
+	.byte	0xFF, 0x01, 0x00, 0x02, 0x7F, 0x03, 0x04, 0x05
+	.byte	0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x08
+	.byte	0x00, 0x00, 0x81, 0x00, 0x00, 0x02, 0x00, 0x03
+/*
+ * B (8x4, row-major) in bytes [0, 32) of vs2.
+ */
+b_qoq:
+	.byte	0x01, 0x02, 0x03, 0x04
+	.byte	0x05, 0x06, 0x07, 0x08
+	.byte	0x80, 0x7F, 0xFF, 0x01
+	.byte	0x00, 0x10, 0x20, 0x30
+	.byte	0x02, 0x02, 0x02, 0x02
+	.byte	0xFE, 0x01, 0x00, 0x7F
+	.byte	0x03, 0x00, 0x81, 0x04
+	.byte	0x40, 0x50, 0x60, 0x70
+/*
+ * A (2x8, row-major) in bytes [0, 16) of vs1.
+ */
+a_dod:
+	.byte	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x80
+	.byte	0xFF, 0x7F, 0x00, 0x02, 0x81, 0x03, 0x04, 0x05
+/*
+ * B (8x2, row-major) in bytes [0, 16) of vs2.
+ */
+b_dod:
+	.byte	0x01, 0x02
+	.byte	0x80, 0x7F
+	.byte	0x03, 0xFF
+	.byte	0x00, 0x10
+	.byte	0x02, 0xFE
+	.byte	0x7F, 0x01
+	.byte	0x81, 0x04
+	.byte	0x40, 0x50
+
+	.balign	4
+exp_qoq_u:
+	.word	0x0000279e, 0x000029db, 0x0000371f, 0x00003bf7
+	.word	0x00000648, 0x000004b5, 0x00000826, 0x0000091f
+	.word	0x00007be0, 0x00002030, 0x000074f0, 0x000042f0
+	.word	0x0000433c, 0x000040f1, 0x0000819f, 0x000002cf
+exp_qoq_s:
+	.word	0xffffde9e, 0xffffd9db, 0xffffcd1f, 0xffffcbf7
+	.word	0x00000248, 0x000002b5, 0x00000126, 0x0000051f
+	.word	0xffffebe0, 0x00002030, 0xffffd4f0, 0x000042f0
+	.word	0x0000403c, 0xffffc1f1, 0x0000019f, 0x000001cf
+exp_qoq_us:
+	.word	0x00001e9e, 0x000029db, 0x00002d1f, 0x00003bf7
+	.word	0x00000348, 0x000004b5, 0x00000426, 0x0000091f
+	.word	0xffffebe0, 0x00002030, 0xffffd4f0, 0x000042f0
+	.word	0xffffc03c, 0x000040f1, 0x0000009f, 0x000002cf
+exp_qoq_su:
+	.word	0xffffe79e, 0xffffd9db, 0xffffd71f, 0xffffcbf7
+	.word	0x00000548, 0x000002b5, 0x00000526, 0x0000051f
+	.word	0x00007be0, 0x00002030, 0x000074f0, 0x000042f0
+	.word	0xffffc33c, 0xffffc1f1, 0xffff829f, 0x000001cf
+exp_dod_u:
+	.word	0x00002795, 0x00003155, 0x00004642, 0x0000c2c0
+exp_dod_s:
+	.word	0xffffde95, 0xffffd955, 0xffffc042, 0x000041c0
+exp_dod_us:
+	.word	0x00001e95, 0x00002955, 0xffffc342, 0x000041c0
+exp_dod_su:
+	.word	0xffffe795, 0xffffe155, 0x00004342, 0xffffc2c0
-- 
2.55.0


