Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99BDC79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 16:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3FsV-0002rK-K7; Sun, 06 Sep 2026 12:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsT-0002pe-5U; Sun, 06 Sep 2026 12:37:57 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsO-00033c-Rw; Sun, 06 Sep 2026 12:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788712654; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=uRt0gBb8L8FGHi21aFS83kzFqYi/Wj94R+OnC6gSM+4=;
 b=U+8dkjAB0ey0OM6z/RIoebvGkSyUfQtFaoqu/nK4K9K8GXPJn1FeCUdqYByIFfqZ+lAYlvGwICXoV/qqy+ugygvDjWPFMyi9kfW4R3u656wjI88xdyIxDn0LUM8feGIDtcpcbZtySYwv5T7BmYqxxdIlF8k0Ntx/P7RsKWFYoRo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XANKIIv_1788712653; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XANKIIv_1788712653 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 00:37:33 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Mon, 07 Sep 2026 00:37:21 +0800
Subject: [PATCH 05/14] target/riscv: Preserve minstretcfgh on RV32
 minstretcfg writes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-riscv-pmu-correctness-v1-5-5f1f41458989@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788712649; l=3379;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=IdUFjos+O+zWBPe2lmEXuq6/NeB+c260XZxX21qLlJ4=;
 b=UazR3ic5L6ZlPb9Cp1TC29Btv/HvlK7CvnOqkiHWFSKbcHIIyBr+/LBjqc/MVBfR/M+jTjHj3
 r70IyBg+3efCE8s0IyqiYWTQWixraeXI8xO4EtWomkfPQ1hsDVDC50S
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
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

RV32 write_minstretcfg() replaces the full 64-bit register, clearing
minstretcfgh and its privilege-inhibit bits.

Replace only bits 31:0, as write_mcyclecfg() does. Test that a low-half
write preserves both set and clear xINH bits in minstretcfgh.

Fixes: b54a84c15e38 ("target/riscv: Add cycle & instret privilege mode filtering support")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/csr.c                    |  2 +-
 tests/tcg/riscv32/Makefile.softmmu-target |  4 +++
 tests/tcg/riscv32/pmu-minstretcfg-rv32.S  | 48 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 57030724f85a897e21e5082b9857411b50f932ac..f9f43a9c12e1afdbdf6c7202c167988389963c10 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1167,7 +1167,7 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->minstretcfg = val;
+        env->minstretcfg = deposit64(env->minstretcfg, 0, 32, val);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UINH : 0;
diff --git a/tests/tcg/riscv32/Makefile.softmmu-target b/tests/tcg/riscv32/Makefile.softmmu-target
index 67d334974577e14ff36e7c51067ebcab4c1349bd..43c162fd337f7b0d5d3e4dedb3f5b06b2821fd88 100644
--- a/tests/tcg/riscv32/Makefile.softmmu-target
+++ b/tests/tcg/riscv32/Makefile.softmmu-target
@@ -20,3 +20,7 @@ QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
 TESTS += smcdeleg-minh-rv32
 run-smcdeleg-minh-rv32: smcdeleg-minh-rv32
 	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+
+TESTS += pmu-minstretcfg-rv32
+run-pmu-minstretcfg-rv32: pmu-minstretcfg-rv32
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
diff --git a/tests/tcg/riscv32/pmu-minstretcfg-rv32.S b/tests/tcg/riscv32/pmu-minstretcfg-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..44f6127da1babe04d6d1094dce5f37528282bee3
--- /dev/null
+++ b/tests/tcg/riscv32/pmu-minstretcfg-rv32.S
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* RV32 writes to minstretcfg must preserve minstretcfgh. */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/*
+	 * Use complementary patterns to check both set and clear xINH bits.
+	 * All fields in the low half are WPRI, so write zero there.
+	 * Exit status 1 or 2 identifies the pattern that was not preserved.
+	 */
+	li	t4, 1
+	li	t0, 0x54000000		/* MINH, UINH, VUINH */
+	csrw	0x722, t0		/* minstretcfgh */
+	csrw	0x322, zero		/* minstretcfg */
+	csrr	t1, 0x722
+	bne	t0, t1, exit
+
+	li	t4, 2
+	li	t0, 0x28000000		/* SINH, VSINH */
+	csrw	0x722, t0		/* minstretcfgh */
+	csrw	0x322, zero		/* minstretcfg */
+	csrr	t1, 0x722
+	bne	t0, t1, exit
+	li	t4, 0
+
+exit:
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

-- 
2.43.0


