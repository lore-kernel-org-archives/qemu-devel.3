Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85B1C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2RZ-00009C-Lm; Thu, 20 Aug 2026 09:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wx2RQ-0008Vu-Sw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:21 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wx2RP-0006li-5Z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:20 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-381b831d535so3301626a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787231058; x=1787835858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jm+Bj84TUkcYq9nDwO2PM0NMiH+RaqV9l8SrAI3KExQ=;
 b=e+ZoRz2dni3JINloGi+bIJziiT+5RrJd+jFPlC8YJ2CnKruioiH9r/78gkNbCyoXkz
 QfQlFnJaBRT9dKxEwcW1sIaskl6fR/IfV7ZWMJTfhLq6mId32BleEg9UuLrNtrwyoK/D
 pHbPqNwytH5BWgh3LHej4alRxiyLZVei46+IfmmuGNkCjJDCgrjLfdRfquv9xRgNnHM/
 vfnGSNN5fEzoDj3hnxfT+QMkJQR3Irla24DiUWBjMyO++qmnYhgPga+74Q2Yt3hbsYhg
 Yh5vjb1aFdFKtGnzOyvUOgv3ICE9K1V2hhmblutZm0hnwexm75crIgLLOG1zqylIrg1G
 24lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231058; x=1787835858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jm+Bj84TUkcYq9nDwO2PM0NMiH+RaqV9l8SrAI3KExQ=;
 b=KRoGqsN8GSLSX/4vB001vlaNUaW0FP7DwXcTbyGo14+PrTgMUzPGgfJSTz61nEoYLA
 845BVpmw8WuRh2+zeLtEql6J0xtnGioHz1sCnM1dQARZHj5osBGVeQmN6CeV8FfWkWnN
 /9gIzQXBYrk0e3PqbzTgrbVjsJFim+BadPqIgl0Uxa+0qSyT2Nh7vAhlbgiAEiJDxY4Z
 hg9vL7RS5Y61Jp+o540G4Klsg6uQJLGMP4/UJ8YEImRSC0JSKRzHQXZi/UOnPswoIQmI
 1quK1mATW49o7y5ieG1P1q3UngF2x97KvstwIflRBjFp01zd82B2zwwcihaYcz30j0Yb
 Y68g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/Et7UJ+f9ScyVxG/gBAwPjSHCTPx1IetunyzWNBEbbKkQ4zyINNkaH3FDxb5f/wbNYNdlwl7CUuT6@nongnu.org
X-Gm-Message-State: AFuF++nZ/pwza471K5YXjbfVicEirszYWZyAKC3SvfHVNe3QbXzIBNtp
 UGDxUGNGIKGmnlMQAEM4eZtbmrPFyht2uwAJMczqygV6QI+htyjV0kAz
X-Gm-Gg: AR+sD12UPpIhKFDwhj2x+HYRrR2sKI+webnj5sBKgcB5EjL1sV/Do8cKZ/uvrd/98Sz
 +ZmmdEJECJhhkrG0MZ2bnqUxkf/I/z6iG77XN0yT88NCvidFX3i4PbWJ9p/59s31XOZ5H2FYtag
 1DY6Ga7b+V4gl0H3Y4LXbjnhGxF5h+h9OZmw/AMImJGTX3b/awhDTeF6J1m1T00Pjmjx2n4kzx7
 4i2UJUZH1f43sGZ839tPdg/mvL5KGwISX7LCCh974kR4x10Khbjrc0OhTkZJijK/Y8mj7BS+YMY
 T1xsHPecKLULvr5nvSt9sV7lARBwFxk79bWem/GfZeEQmADQK4Tg+qAFbwf7hI1gVpjmFmxVhpv
 by2gPHPQCnBmepzT0D23oYAMNR1kkce3MEAOUIPMir4Sh62x47j2UqA6PqT9i8SyP0up4tYW2XB
 0tEm9tmOOpAeo3r0WuJEv0W5b9jt73kppwkooyp5zKwWBu+cB3Siwb+lnf3coFNVjVIxByL3x1v
 ofL3ZkpPvpxDfMEmJLu8I7pRw8z6ARJ7/R1JYOr+QiTrh9HdRjBFJgFt9quFy+5lXfQbfGxfds6
 LfemmwthnZArQR1sTJp/rw==
X-Received: by 2002:a17:90b:1e49:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-39580f6c037mr21406993a91.10.1787231057706; 
 Thu, 20 Aug 2026 06:04:17 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf6849sm6451915a91.10.2026.08.20.06.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:04:16 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/tcg/riscv64: Vector load test
Date: Thu, 20 Aug 2026 22:32:20 +0930
Message-ID: <20260820130223.2762-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260820130223.2762-1-joel@jms.id.au>
References: <20260820130223.2762-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A userspace program to perform vector loads and stores that cross page
boundaries, and check the result.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/riscv64/Makefile.target |  13 +++
 tests/tcg/riscv64/test-rvv-ldst.S | 131 ++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst.S

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b322..68a5ec525598 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -13,6 +13,19 @@ run-test-noc: QEMU_OPTS += -cpu rv64,c=false
 TESTS += test-aes
 run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
 
+# Vector load test
+TESTS += test-rvv-ldst
+test-rvv-ldst: CFLAGS += -march=rv64gcv
+test-rvv-ldst: LDFLAGS = -nostdlib -static
+run-test-rvv-ldst: QEMU_OPTS += -cpu max
+
+# Re-run the vector tests at each supported VLEN
+TEST_RVV_VLENS = 128 256 512 1024
+EXTRA_RUNS += $(patsubst %,run-test-rvv-ldst-vlen%,$(TEST_RVV_VLENS))
+run-test-rvv-ldst-vlen%: test-rvv-ldst
+	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) -cpu max$(COMMA)vlen=$* $<, \
+		test-rvv-ldst with vlen=$*)
+
 # Test for fcvtmod
 TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
diff --git a/tests/tcg/riscv64/test-rvv-ldst.S b/tests/tcg/riscv64/test-rvv-ldst.S
new file mode 100644
index 000000000000..939b3f038b14
--- /dev/null
+++ b/tests/tcg/riscv64/test-rvv-ldst.S
@@ -0,0 +1,131 @@
+/*
+ * RISC-V vector load/store page crossing test
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+    .section .rodata
+    // Page aligned so the within-page cases never cross a boundary
+    .set MAX_PAGE_SIZE, 65536
+    .balign MAX_PAGE_SIZE
+src_data:
+    .byte 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17
+    .byte 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F
+    .set NUM_BYTES, . - src_data
+
+    .balign MAX_PAGE_SIZE
+pageA_start:
+    // Fill the page, stopping 8 bytes short of the boundary
+    .fill MAX_PAGE_SIZE - 8, 1, 0xfa
+src_cross_data:
+    .byte 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27
+pageB_start:
+    .byte 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F
+    .set NUM_CROSS_BYTES, . - src_cross_data
+
+    .section .bss
+    .balign MAX_PAGE_SIZE
+dst_data:
+    .space 16
+
+    .balign MAX_PAGE_SIZE
+    .space (MAX_PAGE_SIZE - 8)
+dst_cross_data:
+    .space 16
+
+.option norelax
+.option norvc
+
+    .text
+    .globl _start
+_start:
+    // Case 1: Load/store within a page. t3 is the exit code on failure
+    li      t3, 1
+    la      a0, src_data
+    li      a1, NUM_BYTES
+
+    // SEW=8, LMUL=1
+    vsetvli t0, a1, e8, m1, ta, ma
+
+    // Check the load will cover 16 bytes
+    bne     t0, a1, fail
+
+    // perform load
+    vle8.v  v1, (a0)
+
+    // Store vector content in memory
+    la      a2, dst_data
+    vse8.v  v1, (a2)
+
+    // Compare first half
+    ld      t1, 0(a0)
+    ld      t2, 0(a2)
+    bne     t1, t2, fail
+
+    // Compare second half
+    ld      t1, 8(a0)
+    ld      t2, 8(a2)
+    bne     t1, t2, fail
+
+    // Case 2: Load straddles a page boundary
+    li      t3, 2
+    la      a0, src_cross_data
+    li      a1, NUM_CROSS_BYTES
+
+    // SEW=8, LMUL=1
+    vsetvli t0, a1, e8, m1, ta, ma
+    bne     t0, a1, fail
+
+    // perform load
+    vle8.v  v1, (a0)
+
+    // Store vector content in memory
+    la      a2, dst_data
+    vse8.v  v1, (a2)
+
+    // Compare first half
+    ld      t1, 0(a0)
+    ld      t2, 0(a2)
+    bne     t1, t2, fail
+
+    // Compare second half
+    ld      t1, 8(a0)
+    ld      t2, 8(a2)
+    bne     t1, t2, fail
+
+    // Case 3: Store straddles a page boundary
+    li      t3, 3
+    la      a0, src_data
+    li      a1, NUM_BYTES
+
+    // SEW=8, LMUL=1
+    vsetvli t0, a1, e8, m1, ta, ma
+    bne     t0, a1, fail
+
+    // perform load
+    vle8.v  v1, (a0)
+
+    // Store vector content in memory
+    la      a2, dst_cross_data
+    vse8.v  v1, (a2)
+
+    // Compare first half
+    ld      t1, 0(a0)
+    ld      t2, 0(a2)
+    bne     t1, t2, fail
+
+    // Compare second half
+    ld      t1, 8(a0)
+    ld      t2, 8(a2)
+    bne     t1, t2, fail
+
+pass:
+    li      a0, 0
+    j       exit
+
+fail:
+    mv      a0, t3
+
+exit:
+    li      a7, 93        // sys_exit
+    ecall
-- 
2.53.0


