Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0CFC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk11z-0006fy-Fx; Wed, 15 Jul 2026 10:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11t-0006dj-Sk; Wed, 15 Jul 2026 10:56:11 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11n-00053v-2H; Wed, 15 Jul 2026 10:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784127351; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=Jt1V96ny+CA0zx6XNKmOp9XsUUuethWx7bcnXoNBbgo=;
 b=xFpDFiDqnF3FZZbRMytjer1H64jKUFpglriGZX4QZcQuOlBGqovktYcSa59K1TsVm2fcE8Rt2pJhtIUyJNzr3iLwu6l0sAHwqm0g+ezzvGLTK9W6qivwsS15fbT1SwHzldEpIq3ilP5QlzPDjhU7PCguJD8GJX49UgdJYZ0FKnA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X79XjPp_1784127036; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X79XjPp_1784127036 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 15 Jul 2026 22:50:36 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 11/11] target/riscv: Add system test for Smmpt34
Date: Wed, 15 Jul 2026 22:50:16 +0800
Message-Id: <20260715145016.17369-12-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RDNS_NONE=0.793,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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

Add SMMPT system-test coverage for Smmpt34, the RV32-only memory
protection scheme (2-level MPT with 4-byte entries).

Smmpt34 requires a 32-bit CPU, but qemu-system-riscv64 can run a 32-bit
CPU (-cpu rv32), so the test lives in tests/tcg/riscv64 alongside the
RV64 Smmpt tests and shares the same harness (smmpt-common.S). It only
differs in the table geometry: 4-byte MPTEs, two radix levels, a 10-bit
level-0 index and the RV32 mmpt CSR layout (MODE in bits[31:30]). It
exercises the same permission and structural checks as the RV64 tests
(all XWR encodings for load and store, V=0 and reserved-bit leaves, and
NAPOT leaves with a valid and a reserved G field), using the same access
addresses. It is built for RV32 and run on qemu-system-riscv64 with
-cpu rv32.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tests/tcg/riscv64/test-smmpt34.S | 97 ++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-smmpt34.S

diff --git a/tests/tcg/riscv64/test-smmpt34.S b/tests/tcg/riscv64/test-smmpt34.S
new file mode 100644
index 0000000000..92c8320999
--- /dev/null
+++ b/tests/tcg/riscv64/test-smmpt34.S
@@ -0,0 +1,97 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test for the Smmpt34 (Supervisor Memory Protection Table) extension,
+ * per SMMTT specification v0.4.9.  Smmpt34 is the RV32-only scheme.
+ *
+ * Although Smmpt34 requires a 32-bit CPU, the program is run on
+ * qemu-system-riscv64 with a 32-bit CPU (-cpu rv32), which lives in the
+ * same target as the RV64 Smmpt tests.  It is therefore kept here in
+ * tests/tcg/riscv64 alongside the other Smmpt tests and shares the same
+ * harness (smmpt-common.S).  Build it for RV32 and run it as:
+ *
+ *   $CC -march=rv32ima_zicsr -mabi=ilp32 -I tests/tcg/riscv64 \
+ *       tests/tcg/riscv64/test-smmpt34.S -Wa,--noexecstack -c -o smmpt34.o
+ *   $LD -m elf32lriscv -T tests/tcg/riscv64/semihost.ld smmpt34.o -o smmpt34
+ *   qemu-system-riscv64 -cpu rv32,x-smmpt=true -M virt -display none \
+ *       -semihosting -device loader,file=smmpt34
+ *
+ * Smmpt34 uses a 2-level MPT with 4-byte entries (8 pages per leaf,
+ * pi = SPA[14:12]).  The supervisor physical address is partitioned as
+ * pn[1] = SPA[33:25] (9-bit root index), pn[0] = SPA[24:15] (10-bit level-0
+ * index) and range offset SPA[14:0].  For the RAM addresses used here
+ * (0x8xxx_xxxx, < 4 GiB) pn[1] resolves to 64.  See smmpt-common.S for the
+ * MPRV trick, the shared address layout and the exit-code convention.
+ *
+ * This test reuses the same shared harness and the same access addresses as
+ * the RV64 tests; only the table geometry (4-byte entries, 2 levels, 10-bit
+ * level-0 index) and the RV32 mmpt layout differ.
+ *
+ * MPT layout (Smmpt34, 2 levels, 4-byte entries):
+ *
+ *   L1 (root) @ 0x8040_0000 : entry[64]  -> non-leaf, PPN(L0)=0x80410
+ *   L0        @ 0x8041_0000 :
+ *     entry[160] -> non-NAPOT leaf (LEAF_ALL_XWR)  covering 0x8050_0000+
+ *     entry[162] -> V=0 (invalid)                  covering 0x8051_0000
+ *     entry[164] -> leaf with a reserved bit set    covering 0x8052_0000
+ *     entry[192] -> NAPOT leaf, G=6, XWR=RW         covering 0x8060_0000
+ *     entry[256] -> NAPOT leaf, reserved G=0        covering 0x8080_0000
+ *
+ *   mmpt = MODE(1=Smmpt34)<<30 | PPN(0x80400)
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
+	/* L1[64] = non-leaf -> L0 (PPN 0x80410): (0x80410 << 10) | V */
+	li	t0, 0x80400000
+	li	t1, 0x20104001
+	sw	t1, 0x100(t0)		/* 64 * 4 = 0x100 */
+
+	li	t0, 0x80410000
+	/* L0[160] = non-NAPOT leaf carrying all XWR encodings (pi0..pi7) */
+	li	t1, LEAF_ALL_XWR
+	sw	t1, 0x280(t0)		/* 160 * 4 = 0x280 */
+	/* L0[162] = 0: invalid entry (V=0) */
+	sw	x0, 0x288(t0)		/* 162 * 4 = 0x288 */
+	/* L0[164] = leaf with reserved bit 3 set (V|L|rsv|XWR[pi0]=RW) */
+	li	t1, 0x30B
+	sw	t1, 0x290(t0)		/* 164 * 4 = 0x290 */
+	/* L0[192] = NAPOT leaf: V|L|N | XWR=RW(0x300) | G=6(0x6000) */
+	li	t1, 0x6307
+	sw	t1, 0x300(t0)		/* 192 * 4 = 0x300 */
+	/* L0[256] = NAPOT leaf with reserved G=0: V|L|N | XWR=RW | G=0 */
+	li	t1, 0x307
+	sw	t1, 0x400(t0)		/* 256 * 4 = 0x400 */
+
+	/* Program mmpt: MODE=1 (Smmpt34) at bits[31:30], PPN = 0x80400 */
+	li	t0, 0x40080400
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


