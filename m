Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A6606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gs6tAaY7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRSN-0002K1-Qd; Thu, 12 Nov 2026 04:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRc-0001nc-Mj; Thu, 12 Nov 2026 04:50:13 -0500
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRU-0002yL-0D; Thu, 12 Nov 2026 04:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794476971; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=eQ+agmPDZsnxqp3aHdOYVkXdLtG27uQo6KL+VOfeHEo=;
 b=gs6tAaY7rLmFYlevSpr2Seskn0fYYrjm39URqlE/JxFdmAZUH+ukPcAd5UjrtoOf1/xEEgJFEWsNiFI+4y3Y0G+N0PEdiRmPB4Mi+cMzf5YGO0DDPLgjpbIjtnNeif21EvPHTYJaoGX1318sjyjj+rlt8Q6VtUp7MOssVEMAen4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XEbfda9_1794476970; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XEbfda9_1794476970 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Nov 2026 17:49:30 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:49:10 +0800
Subject: [PATCH v4 04/14] target/riscv: Preserve MINH on delegated config reads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-riscv-pmu-correctness-v4-4-e9067bdf4df5@linux.alibaba.com>
References: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
In-Reply-To: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476967; l=7979;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=A0lzLEKC+GoGUe2XMXLfKGXAPGZDUWjQb2R5HHNRb7Q=;
 b=IHAbUQxtFgnhHkgqEKjK2Yqy/e3+Nsaq9irc5mWhtQhhHCf5ycszQ5VDTy44s8EI+xgI69RHM
 ggirWFQ66Z9CBv0XMMdty7Nf+lCLDMeM2Tl9/LCZ6c+40HTBx7Sf2qJ
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Smcdeleg requires MINH to read as zero through sireg*. The RV64 callback
masks it by modifying the machine register; the RV32 high-half callback
does not mask it.

Return a masked copy without changing mcyclecfg or minstretcfg. Test both
configuration registers on RV32 and RV64.

Fixes: d9fa41e10156 ("target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read")
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/csr.c                 |  8 ++--
 tests/tcg/riscv32/smcdeleg-minh-rv32.S | 78 ++++++++++++++++++++++++++++++++++
 tests/tcg/riscv32/system/meson.build   |  7 +++
 tests/tcg/riscv64/smcdeleg-minh.S      | 78 ++++++++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build   |  7 +++
 5 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index b5d95cb39582ef7364676ba116a36a135c415ea7..f11b912d38df9c9588827878b3601f672fc8f65e 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1610,7 +1610,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             wr_mask &= ~MCYCLECFG_BIT_MINH;
             env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
         } else {
-            *val = env->mcyclecfg &= ~MHPMEVENT_BIT_MINH;
+            *val = env->mcyclecfg & ~MCYCLECFG_BIT_MINH;
         }
         break;
     case 2:             /* INSTRETCFG */
@@ -1619,7 +1619,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             env->minstretcfg = (new_val & wr_mask) |
                                (env->minstretcfg & ~wr_mask);
         } else {
-            *val = env->minstretcfg &= ~MHPMEVENT_BIT_MINH;
+            *val = env->minstretcfg & ~MINSTRETCFG_BIT_MINH;
         }
         break;
     default:
@@ -1645,7 +1645,7 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
             cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
             env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
         } else {
-            *val = cfgh;
+            *val = cfgh & ~MCYCLECFGH_BIT_MINH;
         }
         break;
     case 2:          /* INSTRETCFGH */
@@ -1655,7 +1655,7 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
             cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
             env->minstretcfg = deposit64(env->minstretcfg, 32, 32, cfgh);
         } else {
-            *val = cfgh;
+            *val = cfgh & ~MINSTRETCFGH_BIT_MINH;
         }
         break;
     default:
diff --git a/tests/tcg/riscv32/smcdeleg-minh-rv32.S b/tests/tcg/riscv32/smcdeleg-minh-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..db467b95cf1441e3440f59097401cf6956d294d3
--- /dev/null
+++ b/tests/tcg/riscv32/smcdeleg-minh-rv32.S
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR numbers for older assemblers. */
+#define CSR_SISELECT         0x150
+#define CSR_SIREG5           0x156
+#define CSR_MENVCFGH         0x31a
+#define CSR_MCYCLECFGH       0x721
+#define CSR_MINSTRETCFGH     0x722
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global	_start
+_start:
+	/*
+	 * Failure bits:
+	 * 0: delegated cyclecfgh exposes MINH
+	 * 1: reading delegated cyclecfgh clears mcyclecfgh.MINH
+	 * 2: delegated instretcfgh exposes MINH
+	 * 3: reading delegated instretcfgh clears minstretcfgh.MINH
+	 */
+	li	t4, 0
+	li	t0, 1
+	slli	t0, t0, 30		/* MINH in the high half */
+	csrw	CSR_MCYCLECFGH, t0
+	csrw	CSR_MINSTRETCFGH, t0
+	li	t1, 1
+	slli	t1, t1, 28		/* menvcfgh.CDE */
+	csrw	CSR_MENVCFGH, t1
+	li	t1, 5			/* Delegate cycle and instret. */
+	csrw	mcounteren, t1
+
+	/* Check the delegated view, then the underlying machine register. */
+	li	t1, 0x40		/* siselect: cycle */
+	csrw	CSR_SISELECT, t1
+	csrr	t1, CSR_SIREG5
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	or	t4, t4, t1
+	csrr	t1, CSR_MCYCLECFGH
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 1
+	or	t4, t4, t1
+
+	li	t1, 0x42		/* siselect: instret */
+	csrw	CSR_SISELECT, t1
+	csrr	t1, CSR_SIREG5
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	slli	t1, t1, 2
+	or	t4, t4, t1
+	csrr	t1, CSR_MINSTRETCFGH
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 3
+	or	t4, t4, t1
+
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	t4, 4(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	8
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index 117ae6fbce4a0e26fea242a2a86fc7f6ecb448a4..7364b625c02b05987af848c7f3bfcc91192e5129 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -22,6 +22,13 @@ tests += {
   },
 }
 
+tests += {
+  'smcdeleg-minh-rv32.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
diff --git a/tests/tcg/riscv64/smcdeleg-minh.S b/tests/tcg/riscv64/smcdeleg-minh.S
new file mode 100644
index 0000000000000000000000000000000000000000..38d3c30f0afaa416a46322f2b892e5969172a60f
--- /dev/null
+++ b/tests/tcg/riscv64/smcdeleg-minh.S
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR numbers for older assemblers. */
+#define CSR_SISELECT         0x150
+#define CSR_SIREG2           0x152
+#define CSR_MENVCFG          0x30a
+#define CSR_MCYCLECFG        0x321
+#define CSR_MINSTRETCFG      0x322
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global	_start
+_start:
+	/*
+	 * Failure bits:
+	 * 0: delegated cyclecfg exposes MINH
+	 * 1: reading delegated cyclecfg clears mcyclecfg.MINH
+	 * 2: delegated instretcfg exposes MINH
+	 * 3: reading delegated instretcfg clears minstretcfg.MINH
+	 */
+	li	t4, 0
+	li	t0, 1
+	slli	t0, t0, 62		/* MINH */
+	csrw	CSR_MCYCLECFG, t0
+	csrw	CSR_MINSTRETCFG, t0
+	li	t1, 1
+	slli	t1, t1, 60		/* menvcfg.CDE */
+	csrw	CSR_MENVCFG, t1
+	li	t1, 5			/* Delegate cycle and instret. */
+	csrw	mcounteren, t1
+
+	/* Check the delegated view, then the underlying machine register. */
+	li	t1, 0x40		/* siselect: cycle */
+	csrw	CSR_SISELECT, t1
+	csrr	t1, CSR_SIREG2
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	or	t4, t4, t1
+	csrr	t1, CSR_MCYCLECFG
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 1
+	or	t4, t4, t1
+
+	li	t1, 0x42		/* siselect: instret */
+	csrw	CSR_SISELECT, t1
+	csrr	t1, CSR_SIREG2
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	slli	t1, t1, 2
+	or	t4, t4, t1
+	csrr	t1, CSR_MINSTRETCFG
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 3
+	or	t4, t4, t1
+
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	t4, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
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
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 83a80f3066257aea553b4ebb92b684c0d1a2c8d7..312947aec4a3a42709633a74aa9c5e2b778a2258 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -103,6 +103,13 @@ tests += {
   },
 }
 
+tests += {
+  'smcdeleg-minh.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {

-- 
2.43.0


