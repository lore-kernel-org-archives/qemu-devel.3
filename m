Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3426CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQEH-0003We-Qc; Sat, 10 Oct 2026 02:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCr-0002gz-5f; Sat, 10 Oct 2026 02:05:18 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCk-00040j-UL; Sat, 10 Oct 2026 02:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612285; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=uEnoJ2+HKDI+H989hoikaVDHX83cQyYMPDT81TBNlB0=;
 b=ioGKpT4VKdszcXUa2zbw+bfNzQmGKKVr+7f3D04MaVhCG51jX+/gkcYIoBGtm3WzoPfF6fXtYJWjmZRR/yufIunWCuF7PFyy9drJuyDcy5ZDhk7x2lOlVLErT5/wffqFHdN2KylW0cVmdetnVZ2pd1OmfHDlpa+5KW83lIQiy7Q=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGsh_1791612283; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGsh_1791612283 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:44 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:28 +0800
Subject: [PATCH v3 04/14] target/riscv: Preserve MINH on delegated config reads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-4-712bf814a7be@linux.alibaba.com>
References: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
In-Reply-To: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612280; l=7977;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=cbL3lJppujAQrnNB6q7k1oSrTUIXw032qiqAYhIqIWg=;
 b=K2N8/hKNPdXOtVVH8xar7oONF/KTCZegSlW/E3uLJtpbCStanGrVE/W9/1ETKvqq2sLWHP0oN
 FiynOz86sD9AfMLXIFspET18Dw3uQlTBVuQId1voW/OE9OvyEM5gpXU
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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
index f2fe7700fdc64600eff1bb0aef28a0ca212d687c..32c8282dfcb3ec578150f107ccc8bd753085a050 100644
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
index f8e55ad3d4e6b64dc4a59e048b9cce71fdce120c..09e2c4fc8c6f356dc27ae9299f3231e2e3356891 100644
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
index 3108e6595d4e91e6a941e006206992a41ddbe436..6af497a1a41debe58dfa329060510bd896c88ac7 100644
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


