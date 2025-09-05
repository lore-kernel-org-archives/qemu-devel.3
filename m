Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203BECA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRGN-0006lT-Hs; Fri, 05 Sep 2025 03:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRGI-0006kJ-39; Fri, 05 Sep 2025 03:53:34 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRGF-0000ES-Tp; Fri, 05 Sep 2025 03:53:33 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-32b959b4895so1058099a91.1; 
 Fri, 05 Sep 2025 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757058807; x=1757663607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9fobgHF8BPoZ4YDoGnftfY3pCQ30cooqytFfFW2iyM=;
 b=LDMwTJShM8jdFpJD6W0mcPQhzWiYPqEwhz3UwvLOcPjGzJuvyvukyyNSz1Tm3MnVCb
 WY3IVVrcniZtmYZxuEtymubFVT3FALb49yfUILez36gzw2favLSDRXQcvLOUuabqqI0n
 GUjkXh5KnAltyLpkY5LNUH+HJw1ULLm90wd0xW9uOgHg285DVCeCCrmP33U24WlD5XPp
 XW45Xl2ghOr9Dgb9tasV/w9HGe4+elpYfFRnbD3jl6Fu/YuSBd6tJobGXO8gtmVaAu9D
 s8lWG/IYhd0U2ltWgF3xiSXH//1CM9XsZ0pZZbR8q1LKNc+2Y848jOoZCAydzNunS8WC
 NN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058807; x=1757663607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9fobgHF8BPoZ4YDoGnftfY3pCQ30cooqytFfFW2iyM=;
 b=gM9TPO8QxcLjVsldtOM3Ndsp11gDa4hsc7P0Q2YETqJkrxyL52sKUZ0No99ZTR/XrJ
 18LOnqwenEQUDgiOGloUzAU9K+s2WWPo7unRKAyXFN5VheEZf59FZ8B4BDu6cKspEYdk
 wyOQ4NNpkDw0DyXIPY/5sBAmFGEubvFQJ0lpLV3rkM+L6gbcGVFes3Ou2nRy5u9SvMvW
 zMrNWeu7UQ0ehbLXlCafZf1g0sD4mDJI46Vz+oCTMndPCLlw0h451uWvoCt+Q+fooZJb
 Y6/K2vKeDVVauRKxHZD4BTZFFO1bWDD92Vmbj+kNDrCNyHelUOce5bf4N7XSiZ8p+8Pe
 ISQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWngyA6Vs+TGS+IiOAvmQAbWx6uWmAnoAZomtUo4U+NiTzmjHWiLrj/n3TeQj4Hkz/eiPF/9s84otwC@nongnu.org
X-Gm-Message-State: AOJu0YzGzX4gmqmvpnncKswrqXYbKfElCe+ZgY9arFqlQhgTfdziEBAW
 twg+6upGv+YAccze7DucJVYLET1RjydI72UwHsIBn+j6LQvgfobvbMT4ZnNoHAu7
X-Gm-Gg: ASbGncsXWxD+4BUpbd8a8iNM1MtACh9cCcqok5NC8YYgMY9QK469htMJ7/ClwTOtXoM
 v/dHpm6p95RfJ609CRMh5PkXOLg0qo5zPwBpw2AwYbzTUNgzyqTTJU0GVFCP1RzIHbMG6IOEJ8R
 G+CGVzANaifYxQ9aVMYcWIFaIoDNNsNyJedKyyNoDTZmkGfHF2WeYyzV2GRRPdB23NmWH1a1mX1
 SWPEQFyRS/UI7VXVKTUfgD8Nmt1+gpiDkHOh8uOUAt/uHMV/JAG8JPfRefA3dEsX2pl4xODygC9
 /gGweOn5fktFPmx+aF2nBXvX4yxIBbOVFqxc0CVddXuq1RMNJNu1CmYeMvenWXANDz4cmtEsPfg
 jlOrIZlo3gLbr3wXho41VFM0E+WvVi+LjBzFYHg==
X-Google-Smtp-Source: AGHT+IGCOqZQMTCQrOpjHbRzmqi7x7hlF2DY8tT6/nPVA1T14lb+e36kYx0agwxoWC9AGTJWuLJjgA==
X-Received: by 2002:a17:90b:394f:b0:32b:c9fc:8aa2 with SMTP id
 98e67ed59e1d1-32bc9fc8db5mr2583906a91.20.1757058806866; 
 Fri, 05 Sep 2025 00:53:26 -0700 (PDT)
Received: from lima-default ([1.146.99.18]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26ae02sm20967560b3a.21.2025.09.05.00.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:53:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: [PATCH v2 1/3] target/riscv: Fix IALIGN check in misa write
Date: Fri,  5 Sep 2025 17:49:56 +1000
Message-ID: <20250905074959.426911-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905074959.426911-1-npiggin@gmail.com>
References: <20250905074959.426911-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The instruction alignment check for the C extension was inverted.
The new value should be checked for C bit clear (thus increasing
IALIGN). If IALIGN is incompatible, then the write to misa should
be suppressed, not just ignoring the update to the C bit.

From the ISA:

  Writing misa may increase IALIGN, e.g., by disabling the "C"
  extension. If an instruction that would write misa increases IALIGN,
  and the subsequent instruction’s address is not IALIGN-bit aligned,
  the write to misa is suppressed, leaving misa unchanged.

This was found with a verification test generator based on RiESCUE.

Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/csr.c                        | 16 ++++-
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/misa-ialign.S           | 88 +++++++++++++++++++++++
 3 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/misa-ialign.S

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8842e07a73..64b55b7add 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2140,9 +2140,19 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
-    /* Suppress 'C' if next instruction is not aligned. */
-    if ((val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
-        val &= ~RVC;
+    /*
+     * misa writes that increase IALIGN beyond alignment of the next
+     * instruction cause the write to misa to be suppressed. Clearing
+     * "C" extension increases IALIGN.
+     */
+    if (!(val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
+        /*
+         * If the next instruction is unaligned mod 4 then "C" must be
+         * set or this instruction could not be executing, so we know
+         * this is is clearing "C" (and not just keeping it clear).
+         */
+        g_assert(env->misa_ext & RVC);
+        return RISCV_EXCP_NONE;
     }
 
     /* Disable RVG if any of its dependencies are disabled */
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 3ca595335d..6e470a028f 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -24,5 +24,10 @@ EXTRA_RUNS += run-test-mepc-masking
 run-test-mepc-masking: test-mepc-masking
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-misa-ialign
+run-misa-ialign: QEMU_OPTS := -cpu rv64,c=true,v=true,x-misa-w=on $(QEMU_OPTS)
+run-misa-ialign: misa-ialign
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/misa-ialign.S b/tests/tcg/riscv64/misa-ialign.S
new file mode 100644
index 0000000000..7f1eb30023
--- /dev/null
+++ b/tests/tcg/riscv64/misa-ialign.S
@@ -0,0 +1,88 @@
+/*
+ * Test for MISA changing C and related IALIGN alignment cases
+ *
+ * This test verifies that the "C" extension can be cleared and set in MISA,
+ * that a branch to 2-byte aligned instructions can be executed when "C" is
+ * enabled, and that a write to MISA which would increase IALIGN and cause
+ * the next instruction to be unaligned is ignored.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define RVC (1 << ('C'-'A'))
+#define RVV (1 << ('V'-'A'))
+
+.option norvc
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	csrr	t0, misa
+	li	t1, RVC
+	not	t1, t1
+	and	t0, t0, t1
+	csrw	misa, t0
+	csrr	t1, misa
+	li	a0, 2 # fail code
+	bne	t0, t1, _exit # Could not clear RVC in MISA
+
+	li	t1, RVC
+	or	t0, t0, t1
+	csrw	misa, t0
+	csrr	t1, misa
+	li	a0, 3 # fail code
+	bne	t0, t1, _exit # Could not set RVC in MISA
+
+	j	unalign
+. = . + 2
+unalign:
+
+	li	t1, RVC
+	not	t1, t1
+	and	t0, t0, t1
+	csrw	misa, t0
+	csrr	t1, misa
+	li	a0, 4 # fail code
+	beq	t0, t1, _exit # Was able to clear RVC in MISA
+
+	li	t0, (RVC|RVV)
+	not	t0, t0
+	and	t0, t0, t1
+	csrw	misa, t0
+	csrr	t0, misa
+	li	a0, 5 # fail code
+	bne	t0, t1, _exit # MISA write was not ignored (RVV was cleared)
+
+	j	realign
+. = . + 2
+realign:
+
+	# Success!
+	li	a0, 0
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
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
2.51.0


