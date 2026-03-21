Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F387D1094474
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3xap-0006zQ-Ju; Sat, 21 Mar 2026 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xao-0006yn-0E
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:22 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3xam-00013k-9J
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:46:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35a04d6aeb0so1144574a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774104379; x=1774709179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQ5sh+/RM/yM/7FBlkEi36m4uOP235gtc22IzTz9aDE=;
 b=e1lRwBD2MuFw9wscjgJT8VRoapcx+u7lBW4UCuZt62/wcuHuQybBBTnVlQNM4pXBCe
 g4aPPLaGUH4H6zXjhoTcbHekxuteAk0zPGKLzca0rJEvjo1xCSfJzKX9ni02ENKr9nAv
 zvz9id6M0xd4nVENNmV6mugRcJ6S8jeygiM8jmir3rhmepvJtk/SwqffoE2tegs/6LYp
 JA0TId/E29BkW38hNuND3R1+m+vIyPO7oKnrxIyhi3Repm7IsCpMP5DpWZAuUdyR4dSa
 9A67fe/CCGoZHu7NKnH6Zgq9up/uUD3ouQCBe5My+bA1UD/LuEJY2Xmp5mxWvkrMXprf
 bnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774104379; x=1774709179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FQ5sh+/RM/yM/7FBlkEi36m4uOP235gtc22IzTz9aDE=;
 b=iMKufmunduaJcwYlTfSSA6J7XrV1hX3MxzdcKM8/2ZSoEaHkL2FXGrDPP81MLpKkFD
 igqYRvra7vGmQfePvaWchVsimdYsln2T59VR1vFGz2DpdTDfOd1LKLTWdgYTa3IU7+P8
 MDljuU6HADcILRSp7cr7zCfr3Zzs8xRogyoUhoc6hDmV5eVi48cgMqwoL5G8S9HCosKc
 oaso74OjxdPMZQJvX1zNoP41vODKwwIlQ9Bc5R2ek5KULqKFeFg14OWJ6ZIG1s4DvC8V
 qX3zpBaQfRAY4f0gu/71BVbG8IsS8Hw6n9Ze2KLLjgD58orbZ4DMZrPqsFWacyQrzkFf
 NVSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0C6fq380CFrNXiBwoJuAU9ZVsRZTLVS5xtM/gYoXFvPwnUGQSoPNLH1vI2da6mLbhkWc8X2QvIAS1@nongnu.org
X-Gm-Message-State: AOJu0YxVQm8fcOZxfG/HD7oGyM5d88VQP276F1PCKEPpNmbe+LuYj7Ae
 hEs9uLtPbH+ojjmf6r2ODpxmnC8jP/27ufkQoFS6wQ1qAlUwW3avjt8R
X-Gm-Gg: ATEYQzzRKjaxr1Ef48Pif9mMO+4wWIkDYjOx3Aiwi/UffnRuuD+T0B4KHVblknzSPqO
 vWc0oTjHZ5FOc/xmy+UIQ2zm4wMTmr6kBNuHnXA8Sz9otQEUK20VCiZEFWQWnG1dOiKGSnpjTEh
 oFnPWdJjjhxsgllu2fmhiMCOK8E5/Z4HyTAXrFh/RyhXeu2aDYM+Rl4f/0GCNgAThbT7i0EodcH
 KHE16FVr2+/aTwaKIZfpbohWuZeHGd31OWsqfPDgCQbhPjo+6vUlLwA8ar7MI14BoW6w8sZUqIz
 /r7GtRgCiRuijkFHPN6dY3hcBvDvY6NBpsriESyUwKp5a3gmab9NNEhN3J2WNebRT+UG/JbQ6Wx
 nMXNPllRZSdoLO525Xn5NS5Dm7sLswmxHYyZ3qJ0L8QlC6XIarILCgDdGUD5OPh8UYnuAt2ot2M
 gbYNfR4LasbS48Z2ccA8RkTxb8Rf/X7ogtwlmFOPkpiP1vD349Z0eUY974gvOCXUPhUXos
X-Received: by 2002:a17:90b:4c0f:b0:34c:904a:d92 with SMTP id
 98e67ed59e1d1-35bd2d6007cmr5343809a91.26.1774104378793; 
 Sat, 21 Mar 2026 07:46:18 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd24f1b9csm2283060a91.0.2026.03.21.07.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:46:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: [PATCH v3 1/3] target/riscv: Fix IALIGN check in misa write
Date: Sun, 22 Mar 2026 00:45:52 +1000
Message-ID: <20260321144554.606417-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321144554.606417-1-npiggin@gmail.com>
References: <20260321144554.606417-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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
index 5064483917..91421a2dd8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2129,9 +2129,19 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
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
index eb1ce6504a..f176f87ed0 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
 	  $(QEMU_OPTS)$<)
 
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


