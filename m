Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3928C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 16:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3FsX-0002sx-1L; Sun, 06 Sep 2026 12:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsV-0002r9-E9; Sun, 06 Sep 2026 12:37:59 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsO-00033U-DL; Sun, 06 Sep 2026 12:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788712653; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=8kmJ+U2czJtSLYkhnnST/lEwFU0nr+9dKHTdViNoHZI=;
 b=GakJzGGADDqv9ceDZgaS35BxHVeZcKFAkxWtshCsxH9bEGvpeeg+ms38ldVv2/xgewrmHQEwUOUXk+lMI+M5TKEuCThRBydSQq55XpphiC2nsAitUsVgcRFO+2Jtf5VhQCgYKSMmMJFgJ4C5WE7KD0evEXbIMCHHQ1GJkooqObs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XANKIIZ_1788712652; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XANKIIZ_1788712652 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 00:37:32 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Mon, 07 Sep 2026 00:37:20 +0800
Subject: [PATCH 04/14] target/riscv: Preserve MINH on delegated config
 reads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-riscv-pmu-correctness-v1-4-5f1f41458989@linux.alibaba.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
In-Reply-To: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788712649; l=8019;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=9hnSioaihNxUR8jDthpZPvWFAvgJ4fXsLSawsn9mE8o=;
 b=FhPPdZndAzamOAHtsZH6gQyw0VSIS4xdgomJkwrz7FOQxxba6xIuRkOngM743YYLFjjG+uVdk
 DOYZH+da7HXBFbRePSVtlNFHHk0RNYRuXDPQNlq4Jotp+7ZHrVK0wdI
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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
 target/riscv/tcg/csr.c                    |  8 ++--
 tests/tcg/riscv32/Makefile.softmmu-target | 22 ++++++++++
 tests/tcg/riscv32/smcdeleg-minh-rv32.S    | 70 +++++++++++++++++++++++++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/smcdeleg-minh.S         | 70 +++++++++++++++++++++++++++++++
 5 files changed, 170 insertions(+), 4 deletions(-)

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
diff --git a/tests/tcg/riscv32/Makefile.softmmu-target b/tests/tcg/riscv32/Makefile.softmmu-target
new file mode 100644
index 0000000000000000000000000000000000000000..67d334974577e14ff36e7c51067ebcab4c1349bd
--- /dev/null
+++ b/tests/tcg/riscv32/Makefile.softmmu-target
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# RISC-V 32-bit system tests
+#
+
+TEST_SRC = $(SRC_PATH)/tests/tcg/riscv32
+VPATH += $(TEST_SRC)
+
+LINK_SCRIPT = $(SRC_PATH)/tests/tcg/riscv64/semihost.ld
+LDFLAGS = -m elf32lriscv -T $(LINK_SCRIPT)
+CFLAGS += -g -Og $(EXTRA_CFLAGS) -march=rv32im_zicsr -mabi=ilp32
+
+%.o: %.S
+	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
+%: %.o $(LINK_SCRIPT)
+	$(LD) $(LDFLAGS) $< -o $@
+
+QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
+
+TESTS += smcdeleg-minh-rv32
+run-smcdeleg-minh-rv32: smcdeleg-minh-rv32
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
diff --git a/tests/tcg/riscv32/smcdeleg-minh-rv32.S b/tests/tcg/riscv32/smcdeleg-minh-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..2e8ee394f5f8a4e01b1c9efc815d21af18de4b3c
--- /dev/null
+++ b/tests/tcg/riscv32/smcdeleg-minh-rv32.S
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
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
+	csrw	0x721, t0		/* mcyclecfgh */
+	csrw	0x722, t0		/* minstretcfgh */
+	li	t1, 1
+	slli	t1, t1, 28		/* menvcfgh.CDE */
+	csrw	0x31a, t1
+	li	t1, 5			/* delegate cycle and instret */
+	csrw	mcounteren, t1
+
+	li	t1, 0x40
+	csrw	0x150, t1		/* siselect: cycle */
+	csrr	t1, 0x156		/* sireg5: cyclecfgh */
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	or	t4, t4, t1
+	csrr	t1, 0x721
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 1
+	or	t4, t4, t1
+
+	li	t1, 0x42
+	csrw	0x150, t1		/* siselect: instret */
+	csrr	t1, 0x156		/* sireg5: instretcfgh */
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	slli	t1, t1, 2
+	or	t4, t4, t1
+	csrr	t1, 0x722
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 3
+	or	t4, t4, t1
+
+	la	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	t4, 4(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
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
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 677244e8b187435b09fc6b7616e269992543587c..af6bc1aad8893726a3b26392da89f34319dd78a8 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -48,6 +48,10 @@ TESTS += sscofpmf-cycle-overflow
 run-sscofpmf-cycle-overflow: sscofpmf-cycle-overflow
 	$(call run-test, $<, $(QEMU) -cpu max -icount shift=3 $(QEMU_OPTS)$<)
 
+TESTS += smcdeleg-minh
+run-smcdeleg-minh: smcdeleg-minh
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+
 EXTRA_RUNS += run-plugin-doubletrap
 run-plugin-doubletrap: doubletrap
 	$(call run-test, $<, \
diff --git a/tests/tcg/riscv64/smcdeleg-minh.S b/tests/tcg/riscv64/smcdeleg-minh.S
new file mode 100644
index 0000000000000000000000000000000000000000..41cbb580475b5dcd079d4542631dfe2474536d60
--- /dev/null
+++ b/tests/tcg/riscv64/smcdeleg-minh.S
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
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
+	csrw	0x321, t0		/* mcyclecfg */
+	csrw	0x322, t0		/* minstretcfg */
+	li	t1, 1
+	slli	t1, t1, 60		/* menvcfg.CDE */
+	csrw	0x30a, t1
+	li	t1, 5			/* delegate cycle and instret */
+	csrw	mcounteren, t1
+
+	li	t1, 0x40
+	csrw	0x150, t1		/* siselect: cycle */
+	csrr	t1, 0x152		/* sireg2: cyclecfg */
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	or	t4, t4, t1
+	csrr	t1, 0x321		/* mcyclecfg: MINH remains set */
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 1
+	or	t4, t4, t1
+
+	li	t1, 0x42
+	csrw	0x150, t1		/* siselect: instret */
+	csrr	t1, 0x152		/* sireg2: instretcfg */
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	slli	t1, t1, 2
+	or	t4, t4, t1
+	csrr	t1, 0x322		/* minstretcfg: MINH remains set */
+	and	t1, t1, t0
+	sltu	t1, zero, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 3
+	or	t4, t4, t1
+
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	t4, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
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

-- 
2.43.0


