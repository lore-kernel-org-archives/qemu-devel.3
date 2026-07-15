Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD8DC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk11y-0006ev-SF; Wed, 15 Jul 2026 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11s-0006dV-Bj; Wed, 15 Jul 2026 10:56:09 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11m-00053e-A7; Wed, 15 Jul 2026 10:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784127351; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=LbeloWnfmme1Ol6QCO52wmwJAeYMXLpwV3PnXwunugw=;
 b=PJpU5XZdZ/+MSd6HxiVjjBoDr/x49OQvTYs+tXpwjPS3dF9x9JRw8C5CvscMp4Dp4Bu0RcG/FYvnkbagn0aXhk7Tjw3xqunxxWGaSwV5PxoOaSR0h2pHpV0LNmLJjkId2X3zJiadAbNQ6AGgw+QWKl3inH/GHDtgiv3H3Pa0y9c=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X79XjPe_1784127035; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X79XjPe_1784127035 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 15 Jul 2026 22:50:36 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 10/11] target/riscv: Add system tests for Smmpt52 and
 Smmpt64
Date: Wed, 15 Jul 2026 22:50:15 +0800
Message-Id: <20260715145016.17369-11-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
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

Extend the SMMPT system-test coverage to the two larger RV64 memory
protection schemes: Smmpt52 (4-level MPT, 52-bit SPA) and Smmpt64
(5-level MPT, 64-bit SPA with a 32 KiB / 32 KiB-aligned root table).

Both tests reuse the mode-independent harness in smmpt-common.S and only
differ in the number of radix levels and, for Smmpt64, the root-table
size and alignment. They exercise the same permission and structural
checks (all XWR encodings for load and store, V=0 and reserved-bit
leaves, and NAPOT leaves with a valid and a reserved G field) and are
wired into the Makefile as run-test-smmpt52 and run-test-smmpt64.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  8 ++
 tests/tcg/riscv64/test-smmpt52.S          | 91 +++++++++++++++++++++
 tests/tcg/riscv64/test-smmpt64.S          | 98 +++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-smmpt52.S
 create mode 100644 tests/tcg/riscv64/test-smmpt64.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 18da9c6299..6bbec02ed2 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -45,5 +45,13 @@ EXTRA_RUNS += run-test-smmpt
 run-test-smmpt: test-smmpt
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-smmpt=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-smmpt52
+run-test-smmpt52: test-smmpt52
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-smmpt=true $(QEMU_OPTS)$<)
+
+EXTRA_RUNS += run-test-smmpt64
+run-test-smmpt64: test-smmpt64
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-smmpt=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-smmpt52.S b/tests/tcg/riscv64/test-smmpt52.S
new file mode 100644
index 0000000000..445ba50d22
--- /dev/null
+++ b/tests/tcg/riscv64/test-smmpt52.S
@@ -0,0 +1,91 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for the Smmpt52 (Supervisor Memory Protection Table) extension,
+ * per SMMTT specification v0.4.9.
+ *
+ * Smmpt52 uses a 4-level MPT with 8-byte entries (16 pages per leaf,
+ * pi = SPA[15:12], pn[i] 9 bits at SPA[16 + i*9 +: 9]).  It shares the MPTE
+ * formats and the permission-lookup algorithm with Smmpt43, only adding one
+ * more radix level.  See smmpt-common.S for the MPRV trick, the shared
+ * address layout and the exit-code convention.
+ *
+ * For the low (< 4 GiB) addresses exercised here pn[3] and pn[2] are 0, so
+ * the upper levels are single-entry chains:
+ *
+ *   L3 (root) @ 0x8040_0000 : entry[0]  -> non-leaf, PPN(L2)=0x80410
+ *   L2        @ 0x8041_0000 : entry[0]  -> non-leaf, PPN(L1)=0x80420
+ *   L1        @ 0x8042_0000 : entry[64] -> non-leaf, PPN(L0)=0x80430
+ *   L0        @ 0x8043_0000 :
+ *     entry[80]  -> non-NAPOT leaf (LEAF_ALL_XWR)  covering 0x8050_0000+
+ *     entry[81]  -> V=0 (invalid)                  covering 0x8051_0000
+ *     entry[82]  -> leaf with a reserved bit set    covering 0x8052_0000
+ *     entry[96]  -> NAPOT leaf, G=4, XWR=RW         covering 0x8060_0000
+ *     entry[128] -> NAPOT leaf, reserved G=5        covering 0x8080_0000
+ *
+ *   mmpt = MODE(2=Smmpt52)<<60 | PPN(0x80400)
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
+	/* PMP entry 0: NAPOT covering the whole space, RWX. */
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, 0x1f
+	csrw	pmpcfg0, t0
+
+	/* Build the MPT tables (M-mode stores bypass the MPT). */
+	/* L3[0] = non-leaf -> L2 (PPN 0x80410) */
+	li	t0, 0x80400000
+	li	t1, 0x20104001
+	sd	t1, 0(t0)
+	/* L2[0] = non-leaf -> L1 (PPN 0x80420) */
+	li	t0, 0x80410000
+	li	t1, 0x20108001
+	sd	t1, 0(t0)
+	/* L1[64] = non-leaf -> L0 (PPN 0x80430) */
+	li	t0, 0x80420000
+	li	t1, 0x2010C001
+	sd	t1, 0x200(t0)		/* 64 * 8 = 0x200 */
+
+	li	t0, 0x80430000
+	/* L0[80] = non-NAPOT leaf carrying all XWR encodings (pi0..pi7) */
+	li	t1, LEAF_ALL_XWR
+	sd	t1, 0x280(t0)		/* 80 * 8 = 0x280 */
+	/* L0[81] = 0: invalid entry (V=0) */
+	sd	x0, 0x288(t0)		/* 81 * 8 = 0x288 */
+	/* L0[82] = leaf with reserved bit 3 set */
+	li	t1, 0x30B
+	sd	t1, 0x290(t0)		/* 82 * 8 = 0x290 */
+	/* L0[96] = NAPOT leaf: V|L|N | XWR=RW | G=4 */
+	li	t1, 0x4307
+	sd	t1, 0x300(t0)		/* 96 * 8 = 0x300 */
+	/* L0[128] = NAPOT leaf with reserved G=5 */
+	li	t1, 0x5307
+	sd	t1, 0x400(t0)		/* 128 * 8 = 0x400 */
+
+	/* Program mmpt: MODE=2 (Smmpt52), PPN = 0x80400 */
+	li	t0, 0x2000000000080400
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
diff --git a/tests/tcg/riscv64/test-smmpt64.S b/tests/tcg/riscv64/test-smmpt64.S
new file mode 100644
index 0000000000..d67035aabb
--- /dev/null
+++ b/tests/tcg/riscv64/test-smmpt64.S
@@ -0,0 +1,98 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for the Smmpt64 (Supervisor Memory Protection Table) extension,
+ * per SMMTT specification v0.4.9.
+ *
+ * Smmpt64 uses a 5-level MPT with 8-byte entries.  Unlike the other RV64
+ * modes its root table is 32 KiB (2^12 entries, pn[4] = SPA[63:52], 12 bits)
+ * and must be aligned to a 32 KiB boundary; the non-root levels are the usual
+ * 4 KiB / 9-bit tables (16 pages per leaf, pi = SPA[15:12]).  See
+ * smmpt-common.S for the MPRV trick, the shared address layout and the
+ * exit-code convention.
+ *
+ * For the low (< 4 GiB) addresses exercised here pn[4], pn[3] and pn[2] are
+ * 0, so the upper levels are single-entry chains:
+ *
+ *   L4 (root) @ 0x8040_0000 : entry[0]  -> non-leaf, PPN(L3)=0x80410
+ *                             (32 KiB / 32 KiB-aligned)
+ *   L3        @ 0x8041_0000 : entry[0]  -> non-leaf, PPN(L2)=0x80420
+ *   L2        @ 0x8042_0000 : entry[0]  -> non-leaf, PPN(L1)=0x80430
+ *   L1        @ 0x8043_0000 : entry[64] -> non-leaf, PPN(L0)=0x80440
+ *   L0        @ 0x8044_0000 :
+ *     entry[80]  -> non-NAPOT leaf (LEAF_ALL_XWR)  covering 0x8050_0000+
+ *     entry[81]  -> V=0 (invalid)                  covering 0x8051_0000
+ *     entry[82]  -> leaf with a reserved bit set    covering 0x8052_0000
+ *     entry[96]  -> NAPOT leaf, G=4, XWR=RW         covering 0x8060_0000
+ *     entry[128] -> NAPOT leaf, reserved G=5        covering 0x8080_0000
+ *
+ *   mmpt = MODE(3=Smmpt64)<<60 | PPN(0x80400)   (PPN[2:0] must be 0)
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
+	/* PMP entry 0: NAPOT covering the whole space, RWX. */
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, 0x1f
+	csrw	pmpcfg0, t0
+
+	/* Build the MPT tables (M-mode stores bypass the MPT). */
+	/* L4[0] = non-leaf -> L3 (PPN 0x80410); root is 32 KiB aligned */
+	li	t0, 0x80400000
+	li	t1, 0x20104001
+	sd	t1, 0(t0)
+	/* L3[0] = non-leaf -> L2 (PPN 0x80420) */
+	li	t0, 0x80410000
+	li	t1, 0x20108001
+	sd	t1, 0(t0)
+	/* L2[0] = non-leaf -> L1 (PPN 0x80430) */
+	li	t0, 0x80420000
+	li	t1, 0x2010C001
+	sd	t1, 0(t0)
+	/* L1[64] = non-leaf -> L0 (PPN 0x80440) */
+	li	t0, 0x80430000
+	li	t1, 0x20110001
+	sd	t1, 0x200(t0)		/* 64 * 8 = 0x200 */
+
+	li	t0, 0x80440000
+	/* L0[80] = non-NAPOT leaf carrying all XWR encodings (pi0..pi7) */
+	li	t1, LEAF_ALL_XWR
+	sd	t1, 0x280(t0)		/* 80 * 8 = 0x280 */
+	/* L0[81] = 0: invalid entry (V=0) */
+	sd	x0, 0x288(t0)		/* 81 * 8 = 0x288 */
+	/* L0[82] = leaf with reserved bit 3 set */
+	li	t1, 0x30B
+	sd	t1, 0x290(t0)		/* 82 * 8 = 0x290 */
+	/* L0[96] = NAPOT leaf: V|L|N | XWR=RW | G=4 */
+	li	t1, 0x4307
+	sd	t1, 0x300(t0)		/* 96 * 8 = 0x300 */
+	/* L0[128] = NAPOT leaf with reserved G=5 */
+	li	t1, 0x5307
+	sd	t1, 0x400(t0)		/* 128 * 8 = 0x400 */
+
+	/* Program mmpt: MODE=3 (Smmpt64), PPN = 0x80400 */
+	li	t0, 0x3000000000080400
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


