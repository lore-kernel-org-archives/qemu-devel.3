Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9289C61CE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcR-0001YC-FQ; Mon, 24 Aug 2026 01:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcP-0001PQ-Ap
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:13 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcN-0003IX-CY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:13 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3272007a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550790; x=1788155590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E8fww6SheAAob+IWhdtbx0dCzxTAUBtVsPa0wdfQKz0=;
 b=r1v32N6nLlq8iKCn9RX0j3ISbxNnzW0wt7TKpBRwALwF9fsWRBuWWCipIscw9OIAdF
 lOyc/xndj5yLPVjQFXtFUaVREnhU8+3jCJb4SddvGkDdMxO0y/K+cB46zH/5QSSfDVeJ
 CWMhEvu0AvgKJMQY2GjU/t8/dTOeFKAiMugQ+8zVU1Vq1vQbsAskfxPpjb96GtrrqfF4
 hb60zWvf28VYLzgbwHkCplnex1foFaiYvn4y7F4MjEzJybVOOAPL6GH+tka6ku3BfCA9
 Sg6bL099hocCY3SQ1WlLLNVQXrumFpSfAyqc3mou6LooD7Tt7X3I5t9JYOQ2T9b3mdd7
 oDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550790; x=1788155590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E8fww6SheAAob+IWhdtbx0dCzxTAUBtVsPa0wdfQKz0=;
 b=oqxQtJDa6Vsvy1+ZJa9fRelawGK/AW4DAjrTjzg2DyP6APkDcgg+R/TwMovns52M6C
 Eyx+gXxyXQ64sFWbATSglARPD0UiGRbGg7A5a9WXKUy/se5XtMNXzts2c8yf+aBPH0o0
 rQNHzR4TV1HiCZderYkvMq+omOvsw/XfmKF8iShwyd9y6tqgFNukaGd1sONen63RpTQT
 CHlVt/uiHTOdSTkrlc+s6jYNfeid+3qLhsqcAPgDjMK4lit7SpP7i7SFwRAZRbL9ElF+
 5Elw8OdZ0nKg8D6NVXJ+ey8ntTmLfg3+CRMvDGojUQ4/1uKU5xtj8+Ec880qPkNsd+Ey
 FlPQ==
X-Gm-Message-State: AFuF++l+Y4V9aHXUq0AwubJf3x6cABeV+SvKbaWIOINCQT1rV9R1zZlC
 CvgOTRYKw/SoUQ8bH1jiMKVN+PUDgcIkPrTuTjM/AfWurCUf5oFhnrUT+UhHEw==
X-Gm-Gg: AR+sD13cERLh8iRb4Si25FFRcfH/nVeY6yoJ9/2Yn5vDXq8XKAAHbdASb6HYgNFkSoS
 bKfG3n5MT00E3PS+PU9fUn5CE6T8s8Dv738N6axCPiO03SZw9jCO2wd4u96nmzQNDUwYJyy/WHi
 cLO66EAeY3nPUT6Wbm5qiH4iID4i4QNtmRY1Grzi4od98vmH8E/+slQ5r7mWMQtsMgvx4uXPb1X
 Y07P4zUtI0mFfTaGXWTt0I6vRfqPclBHeX/mOMHizZ1nuXpxm1K6w/txkm3bF9T3+JMsfFBd7Hy
 oihtT2B5G8ahQCmW6D1U57aTuBIIO066TN3I4nVCAIiQ+zsAc9II+qp4YHwZCOu/zP7H30Map+G
 AjSeZvCDsPm3QJ5558/bdSoCmfhRbPsN+zpIX2mtJIMNoz2OQvzdz+oZiftQeO5V19ZZZLTH5nb
 1FyJCZFQFvMDOicuQP7wNh6eWSgmCxa0JEONkxnM+rlyGwinp4VZYqOpMvw+wblv7Re5pTGWRlI
 DRnBA==
X-Received: by 2002:a17:90b:560e:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-395df617b34mr31707868a91.13.1787550789953; 
 Sun, 23 Aug 2026 22:53:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:53:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Vladimir Isaev <vvisaev@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 94/96] tests/tcg/riscv64: add misa write test
Date: Mon, 24 Aug 2026 15:48:04 +1000
Message-ID: <20260824054806.2790041-95-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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

From: Vladimir Isaev <vvisaev@gmail.com>

Link: https://lore.kernel.org/r/20260321144554.606417-2-npiggin@gmail.com
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
Message-ID: <20260817150653.40357-3-vvisaev@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/test-misa-w.S           | 88 +++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-misa-w.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index fac0474746..6a219c306c 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -67,5 +67,9 @@ EXTRA_RUNS += run-test-zicclsm-off
 run-test-zicclsm-off: test-zicclsm-off
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-misa-w
+run-test-misa-w: test-misa-w
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true$(comma)v=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-misa-w.S b/tests/tcg/riscv64/test-misa-w.S
new file mode 100644
index 0000000000..7f1eb30023
--- /dev/null
+++ b/tests/tcg/riscv64/test-misa-w.S
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
2.54.0


