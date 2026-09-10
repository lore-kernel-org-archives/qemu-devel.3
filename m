Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1361C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4fwx-00039p-O7; Thu, 10 Sep 2026 10:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x4fwn-000320-PT; Thu, 10 Sep 2026 10:40:17 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x4fwc-0003Q2-Uj; Thu, 10 Sep 2026 10:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789051195; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=3cIrX8vvphZfU+2tkgq7BXATXV6vv2BRT69Mz08tqJ4=;
 b=v9gm5rPLE8F+v9ra2159KXgS0OTI+DXRJF8rA2sBAVxeXP4g0QHD9G/Pgcud7WOmeNg877xvOxvYNWRqL2wAIgMelh2z3b5JISBID03CqD1h/PUzR5elUZv920ZOtYdDd6H+8T8S7sQzkxIfpEtA2AAaJv1JXR5kRGqL+cCJf9E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XAhkcF0_1789051194; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XAhkcF0_1789051194 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 10 Sep 2026 22:39:54 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 10 Sep 2026 22:39:41 +0800
Subject: [PATCH v2 04/14] target/riscv: Preserve MINH on delegated config reads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-riscv-pmu-correctness-v2-4-5da5159a0c64@linux.alibaba.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
In-Reply-To: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789051191; l=7924;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=i8/tbCt+1+qC76L/RPpROlwyD4V+t52qb1hqpeRSKkY=;
 b=8Tk5vwxK06E2wuAXHIyqsdmc4eax3RIEibcEleFhiaOUNPc2C3IT+9fdzg58PrG3GStauPK7G
 dO59kIgIoDLDb7xtwaOtvl4JSicOfpIjVXoSIb4TY0LPj6jodAsuRcH
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
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

Smcdeleg requires MINH to read as zero through sireg*. The RV64 callback
masks it by modifying the machine register; the RV32 high-half callback
does not mask it.

Return a masked copy without changing mcyclecfg or minstretcfg. Test both
configuration registers on RV32 and RV64.

Fixes: d9fa41e10156 ("target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/csr.c                 |  8 ++--
 tests/tcg/riscv32/smcdeleg-minh-rv32.S | 78 ++++++++++++++++++++++++++++++++++
 tests/tcg/riscv32/system/meson.build   |  7 +++
 tests/tcg/riscv64/smcdeleg-minh.S      | 78 ++++++++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build   |  7 +++
 5 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 60caee32dc0cf5b6a8492e0cf8ff15f71acc2087..57030724f85a897e21e5082b9857411b50f932ac 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1607,7 +1607,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             wr_mask &= ~MCYCLECFG_BIT_MINH;
             env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
         } else {
-            *val = env->mcyclecfg &= ~MHPMEVENT_BIT_MINH;
+            *val = env->mcyclecfg & ~MCYCLECFG_BIT_MINH;
         }
         break;
     case 2:             /* INSTRETCFG */
@@ -1616,7 +1616,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             env->minstretcfg = (new_val & wr_mask) |
                                (env->minstretcfg & ~wr_mask);
         } else {
-            *val = env->minstretcfg &= ~MHPMEVENT_BIT_MINH;
+            *val = env->minstretcfg & ~MINSTRETCFG_BIT_MINH;
         }
         break;
     default:
@@ -1642,7 +1642,7 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
             cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
             env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
         } else {
-            *val = cfgh;
+            *val = cfgh & ~MCYCLECFGH_BIT_MINH;
         }
         break;
     case 2:          /* INSTRETCFGH */
@@ -1652,7 +1652,7 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
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
index 16f9a06c9485ed75b3d127d6b9d090f5eaad4486..cfe2d854b729a8dfdbce2373e73b91b470db6b4e 100644
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
index 668a9a76070b6f16087b08ea84683d883312e951..5d91381c62d77ae7e37c129112d6367f692df660 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -75,6 +75,13 @@ tests += {
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


