Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEA4CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprc-0008B7-Ou; Tue, 13 Oct 2026 23:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprX-0007vp-Qt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:09 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprW-0001i2-5S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:07 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso235570a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949265; x=1792554065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2cE1KumKanom6mt8123RfgEvZ1VMzW2u2Z5xS7COiMw=;
 b=idZx2Ozdg6QNwVPWsAh8uGtjKmEFmJPC60+4F+cJ1/VbW9UMHZXYSY7B33pQkjT/bq
 OJ/4qKnW0vc5gkETY0C//dnfEy89Ngc8uHAJOCIiZNrmQIU+cnH6L6UHSSN5YyUaGaT9
 wKq+EanE/XDgCB6WiIGmjHtXc6XY5oUj/aN/wXlfkM7gbLOlQ2fePqAgY3ItYNI7/CDa
 hFAcyA6NsuBDebOMk/nj9X8g+p4jyLuKR/JRxT4nRNh3Yy44077VsscUz4h2m39X12QY
 ZbFUZ3l/dM3M3ir42YNWCAUjWxTMJMxhIr+I+yRcOtRCh6m9MZ1ObkAkrvJw8syqF1YL
 3PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949265; x=1792554065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2cE1KumKanom6mt8123RfgEvZ1VMzW2u2Z5xS7COiMw=;
 b=ZvgBLY4hUZ19zWB8Af/SBiV7dp+8WTOFVrWGgXV3NRC4/VLaRf98EAeufLAlrnJOM8
 LrQdQII2lOI2mCQVBJcbicYDxjgdnigTfU/B4NJyoX9M3GDvp668gyAmPOnVJnU0i34M
 yq6U2gkRMgmCqvGJuxTGTJolqCrQcBkFBgFQN23rZ+Pgfw/l+51ZjD82gK+/l415RDpU
 8KhLhtD5pDuWGoInji6iWnQtnThqtqeQ2GkianzZNrBS5vOX9AultUlB9oCoBpbd1XIY
 TGFAqac2Hd3EDBgHVUor5UQo3ZDcIrGxei1N6hDdvxv4IboDLfM/n7dA8LS7A+y2+euE
 RqfQ==
X-Gm-Message-State: AFq9FYI3HaHEAWEIGPhddawRf1CE/3zPZ5YipuKyJ+VWfUMtl9pl8GTQ
 ySuJyV+jqJbA/gifnr9Bs4EFBLs4OQe/WBK+Ug5ehfrQV3+239QGbpcBuSHufQ==
X-Gm-Gg: AYBFou1iaSHgm71RUMVDYXfQsbqIXdEff1mX5xDKVinwWIwqrlziitM0C1qhM4oXqUI
 jFOBiBPVq9w9+wwsS4WrPNeYHDFRpc0KGruQ1lZYnwOnu5xBYMtEx2/HGukzEElEleaAPT9FKY5
 umm0WSGsKGBh2Srm9EhrU8qKri6fL23geg0nu1+puFWxmnh36C786STP/bVot4+EteODC5Zdwvm
 nBkLM6GbvhXMO2YvhDKvf2YfX5yMokykaPqS/7rX534TUDGSmE/2SWAFfcgBd5rC/91QZP/9Wkj
 RmV/3Rp1PlVJjzFekDFasHD2XvO/rMI8OI+Qh86Fc8wQEdOZY/BAROqJlHZIyO4MJTPsfak4XPk
 rvpn4WXSBvP1bv4ugzzKf+P3pyJZIaBIoJmuaUr6XumQOYdWjYWMFLeNMXvBye3/OI2pVu5Y0IA
 JcaXI7we3p2OguU4ZxHrckqDE9t85AEW2s1nhc6tD2WH/d7dNtPCU2Ez4WZhvGJ/pj3Jyfgwb8B
 r2C76DX/pbSrQJa
X-Received: by 2002:a17:90b:3145:b0:3ab:413:49ab with SMTP id
 98e67ed59e1d1-3ab3a9e00f7mr12163538a91.66.1791949264675; 
 Tue, 13 Oct 2026 20:41:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/52] tests/tcg/riscv64: add sdext "not on Debug mode" sigill
 tests
Date: Wed, 14 Oct 2026 13:38:48 +1000
Message-ID: <20261014033907.3332383-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Adding proper TCG automated tests to sdext CSRs requires enabling
gdbstub support for riscv64, which we don't have, since the nature of
the CSRs added is that they run in a higher privilege than M mode.

DCSR has bits to allow for context switching from other modes to Debug
mode, but those bits must be set via an external entity (e.g. gdb)
beforehand.

What we can do for now is a "negative" TCG test to ensure that we'll
throw illegal insn traps when trying to write sdext CSRs in machine
mode.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260928195902.2045235-8-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/system/meson.build  |  8 +++
 tests/tcg/riscv64/test-sdext-sigill.S | 83 +++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index a632674832..a7478b4219 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -62,6 +62,14 @@ tests += {
   }
 }
 
+tests += {
+  'test-sdext-sigill.S': {
+    'exe_name': 'test-sdext-sigill',
+    'cflags': cflags + ['-march=rv64gcv'],
+    'qemu_args': ['-cpu', 'rv64,sdtrig=true,sdext=true', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-sdext-sigill.S b/tests/tcg/riscv64/test-sdext-sigill.S
new file mode 100644
index 0000000000..80a6c06465
--- /dev/null
+++ b/tests/tcg/riscv64/test-sdext-sigill.S
@@ -0,0 +1,83 @@
+/*
+ * RISC-V sdext extension "SIGILL" test: check if sdext CSRs
+ * and 'dret' will throw SIGILLs outside of Debug Mode.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.equ CSR_DCSR,      0x7b0
+.equ CSR_DPC,       0x7b1
+.equ CSR_DSCRATCH0, 0x7b2
+
+	.option norvc
+	.text
+
+	.global _start
+
+_start:
+	la t0, trap_handler
+	csrw mtvec, t0
+
+	dret
+	j _fail
+
+	li t0, 1
+	csrw CSR_DPC, t0
+	j _fail
+
+	li t0, 1
+	csrw CSR_DSCRATCH0, t0
+	j _fail
+
+	li t0, 1
+	csrw CSR_DCSR, t0
+	j _fail
+
+	li a0, 0
+	j _exit
+
+_fail:
+	li a0, 1
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
+
+	.balign	4
+trap_handler:
+	csrr	t4, mcause
+	la	t5, trap_mcause
+	sd	t4, 0(t5)
+	csrr	t4, mtval
+	la	t5, trap_mtval
+	sd	t4, 0(t5)
+	csrr	t4, mepc
+
+	/*
+	 * Skip 2 insns (8 increment in mepc) to skip both the
+	 * insn that caused the trap and the "j  _fail" insn
+	 * that follows it.
+	 */
+	addi	t4, t4, 8
+	csrw	mepc, t4
+	mret
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
+trap_mcause:
+	.space	8
+trap_mtval:
+	.space	8
-- 
2.55.0


