Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1451FCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utdlI-0000G5-Jy; Tue, 02 Sep 2025 23:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utdkn-0008LQ-Pq; Tue, 02 Sep 2025 23:01:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utdkl-0006qQ-QL; Tue, 02 Sep 2025 23:01:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so5036525b3a.2; 
 Tue, 02 Sep 2025 20:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756868501; x=1757473301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9fobgHF8BPoZ4YDoGnftfY3pCQ30cooqytFfFW2iyM=;
 b=cmKReeEIzc/4heY4efv/00d5+g/TOCx2KjigfoxBNFmkFjxe2VpkHIEhYzRQrSgzz9
 /5Eqdg/rXnWDk9VlOv1AtyBhmSKKczcVoRF1NSbSuR0BwQIHpkx/qFvp42liFTZb1k9F
 HC/lFB5ryf23CDfKN0+JSBiTg76VYQ0CoLiozhxb1Dk4fG/vktwo/JPk3sQN+vC/KeHA
 UivsLJUAJOabIDH6EhKsgZuqY3WTIZxGWTkVNVrhD+d7kWfF1dzjhVLVVaE/ilc95D+i
 xU+BW7kt9vYZ2zQ1znziBPwtsLjz+9kXOajLSbQiKaIWAX1Ue2oUus8fJ3sF/GQxwVd6
 8kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756868501; x=1757473301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9fobgHF8BPoZ4YDoGnftfY3pCQ30cooqytFfFW2iyM=;
 b=sXWy+ITgTlMGJTDCwLuTqMHGodxvXcq6LZSNEGfA6pnc108Fyw8x+Nw9l0jqK+Hi2h
 V4/s55rNQQ+Wtc1ujm1HQR6EKAIMm78xsWqSLScVSSdylrNFu54230GvHTS+3y8lXWs0
 OMLBfbYSzmwM7Vy3zndajvY12SAk9aEoTENy0PexnrUvtou02QAfQLtzPFdhAzYvQdIR
 nS4cyhcxeovjRjtU9e2CpW64RLay5tZDiMqaRWTfuQMdU+A1Ei6IABEyrWr/zELTbVoc
 ll2BSOtaA+uJOlanCufGtWHltJQ6EIisiyxgi1IOKjFBTMb87sbiNbPwkXFRA0Cfqp81
 yQvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXocAAkyCmDbNG23Wbev1J6RQHbhFBZ463bMAzAn20+Tom7ByEDBNyfsrNqrkDCyZ6R8c6LHEOGItBZ@nongnu.org
X-Gm-Message-State: AOJu0YzRco4UtvT7IJqAUTDRmdaxrMek1QNMabQ9/PsM7Fhr6V8AhTwP
 1j0Wyf+3NDVZ61u+a3GsPxhI0UCsqn7GCF2puPygt7BO4m7T+ggT2uyQVLRB7w==
X-Gm-Gg: ASbGnctHQA4s2LI4+gIj5qp9EUZutVrf+SO6bvjJ73ghzJECYEVVSNXNFNwrUCROnAC
 4Z9koKcg3gCB0rI0vkozqGlJK2IMWa319i/7NQAXJJzGZ5ogWNyNxBlsv3SGQDzR5+7y/sHHU+Z
 ipYxkkJ+zqxz1Hn6U6fSrt6ZFRbS+znrbVUKOIEuUzbTOYP/5AromYUZ0ilhsjzL70lEANKn1XK
 eERPwL7enEKkq17oeTT6g5Vxf47n0UQD/612NMJe7OgWgcxWvwgr3TYbTpDobX2U8O3cuOyeqr/
 2n+T+yFSwB+yKzjsRmJDHmRhdSX//04uv9avYkii8qyoaWzQuWrzX+oyUrSWxN+a+BbWJdXBhCo
 DiIiFqYaC+W5gwPyZsQkaTV/PSWaiHz6l+Nko0AZzxo0MUC/6cGgAi4JuD5C/tzuMM1vwr5mjir
 okrbmr8ECQX9optrz8OqM=
X-Google-Smtp-Source: AGHT+IG8OnK7/aOpVNZmhIhVKGjpj/I0cKLRAcRu13mdMoN5Quvfw+RztT43aPCuV48sOd8W0nJF9w==
X-Received: by 2002:a05:6a00:ae10:b0:772:4319:e7f0 with SMTP id
 d2e1a72fcca58-7724319ecc4mr16866773b3a.32.1756868500965; 
 Tue, 02 Sep 2025 20:01:40 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7725e419913sm6971760b3a.55.2025.09.02.20.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 20:01:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>, Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: [PATCH 1/3] target/riscv: Fix IALIGN check in misa write
Date: Wed,  3 Sep 2025 13:01:11 +1000
Message-ID: <20250903030114.274535-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903030114.274535-1-npiggin@gmail.com>
References: <20250903030114.274535-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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


