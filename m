Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5D606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=q+PI6J/1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbYo-0008IA-Op; Wed, 18 Nov 2026 04:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYf-0008Ft-Qh; Wed, 18 Nov 2026 04:02:27 -0500
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYc-00042M-4x; Wed, 18 Nov 2026 04:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794992520; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=XHeHm4MyKKi/nzVdDi9eeXQ/fXxcSGLMC08hL8tRkQE=;
 b=q+PI6J/1m/wsrH7JzdAQ5ECK4fGW5kUBSjnAuxAU/D9RAq87/pz/b9BUuiY/Izx7oRSCSTY5UD5KhYJqatK3DrBFQupmrR2WC4v1nkD95y8sILBq755VWr/JENKpCCYzgAgiYDNynAmj45si6RVWAobLZguLpiLg9XDxWrYLjAE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R951e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XF0GqjB_1794992519; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF0GqjB_1794992519 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 17:01:59 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 18 Nov 2026 17:01:35 +0800
Subject: [PATCH RFC 8/8] tests/tcg/riscv: Check Zl fetching and halfword
 alignment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-zl-master-v1-8-129f85e0f887@linux.alibaba.com>
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992514; l=6163;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=GdTIv6TJyvY3YpDRzfwf1R3vTW3eALq80nFWDjtTRZA=;
 b=3cqTpMQVhqMEA1IZNmFSaAa6DDk2C3icdxzyuOXohugWFSdvX9h4KmldP8jftbrdqfF9SExhr
 VMBrcsS9W2pBwzFi0yte3/c6oGjTkBRQ05wsSS/YscxQBzLZgPnOZkw
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Run the same bare-metal program on RV32 and RV64 with C and Zca disabled.
Check complete 48/64-bit encodings and undefined lengths.

Place a 48-bit encoding and an encoding with an undefined instruction
length at the end of RAM to detect unnecessary reads of parcel D.
Place required parcels C and D beyond the end of RAM in separate cases
to check instruction access faults.
Check mcause, mepc and mtval, including the failing fetch address,
RV32 truncation of instruction bits, and zero for undefined lengths.

Check IALIGN=16 for JAL, JALR, BEQ and MRET. Check that a compressed
instruction remains illegal.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 tests/tcg/riscv/zl/zl.S              | 165 +++++++++++++++++++++++++++++++++++
 tests/tcg/riscv32/system/meson.build |   9 ++
 tests/tcg/riscv64/system/meson.build |   9 ++
 3 files changed, 183 insertions(+)

diff --git a/tests/tcg/riscv/zl/zl.S b/tests/tcg/riscv/zl/zl.S
new file mode 100644
index 0000000000000000000000000000000000000000..c289f64f1262ab240d11a96b365b97aa5922ca54
--- /dev/null
+++ b/tests/tcg/riscv/zl/zl.S
@@ -0,0 +1,165 @@
+/*
+ * Zl lengths, required fetches and IALIGN=16 with C/Zca disabled.
+ * Run on virt with 16 MiB RAM: 0x80000000 <= address < 0x81000000.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    .option norvc
+    .option norelax
+    .text
+    .global _start
+
+    /* s0: faulting PC; s1: cause; s2: tval; s3: resume PC. */
+    .macro expect_exception cause, tval
+    li s1, \cause
+    li s2, \tval
+    lla s3, 1f
+    jr s0
+1:
+    .endm
+
+_start:
+    lla t0, trap_handler
+    csrw mtvec, t0
+    csrw mie, zero
+    li s4, 0
+    csrr t0, misa
+    andi t0, t0, 4
+    bnez t0, failed
+
+    /* JALR to a 48-bit candidate at RAM end; D must not be fetched. */
+    li s0, 0x80fffffa
+    lla t0, insn48
+    lhu t1, 0(t0)
+    sh t1, 0(s0)
+    lhu t1, 2(t0)
+    sh t1, 2(s0)
+    lhu t1, 4(t0)
+    sh t1, 4(s0)
+    fence.i
+#if __riscv_xlen == 64
+    expect_exception 2, 0x5a692468003f
+#else
+    expect_exception 2, 0x2468003f
+#endif
+
+    /* Undefined C still stops after A/B/C, with no instruction bits. */
+    li t0, 0x5a7f
+    sh t0, 4(s0)
+    fence.i
+    expect_exception 2, 0
+
+    lla s0, insn64
+#if __riscv_xlen == 64
+    expect_exception 2, 0x9abc5a632468001f
+#else
+    expect_exception 2, 0x2468001f
+#endif
+
+    /* A/B present, C missing: fault at the first inaccessible parcel. */
+    li s0, 0x80fffffc
+    li t0, 0x2468003f
+    sw t0, 0(s0)
+    fence.i
+    expect_exception 1, 0x81000000
+
+    /* A/B/C present, D missing; C requests eight bytes. */
+    li s0, 0x80fffffa
+    lla t0, insn64
+    lhu t1, 0(t0)
+    sh t1, 0(s0)
+    lhu t1, 2(t0)
+    sh t1, 2(s0)
+    lhu t1, 4(t0)
+    sh t1, 4(s0)
+    fence.i
+    expect_exception 1, 0x81000000
+
+    /* JAL and a word-aligned BEQ must reach halfword targets. */
+    jal zero, half_jal
+    j failed
+    .balign 4, 0
+    .2byte 0
+half_jal:
+    j branch_entry
+    .balign 4, 0
+branch_entry:
+    beq zero, zero, half_branch
+    j failed
+    .balign 4, 0
+    .2byte 0
+half_branch:
+    lla t0, half_return
+    andi t1, t0, 3
+    li t2, 2
+    bne t1, t2, failed
+    csrw mepc, t0
+    csrr t1, mepc
+    bne t0, t1, failed
+    li t1, 0x1800
+    csrs mstatus, t1
+    mret
+    .balign 4, 0
+    .2byte 0
+half_return:
+    lla s0, compressed
+    expect_exception 2, 1
+    li t0, 6
+    bne s4, t0, failed
+    j passed
+
+    .balign 4, 0
+trap_handler:
+    csrr t0, mcause
+    bne t0, s1, failed
+    csrr t0, mepc
+    bne t0, s0, failed
+    csrr t0, mtval
+    bne t0, s2, failed
+    addi s4, s4, 1
+    csrw mepc, s3
+    mret
+
+    /* A alone would select the opposite length under the old encoding. */
+insn48:
+    .2byte 0x003f, 0x2468, 0x5a69
+insn64:
+    .2byte 0x001f, 0x2468, 0x5a63, 0x9abc
+compressed:
+    .2byte 0x0001, 0
+
+    .balign 4, 0
+passed:
+    li a0, 4
+    lla a1, pass
+    .balign 16
+    slli zero, zero, 31
+    ebreak
+    srai zero, zero, 7
+    li a0, 0
+    j exit
+failed:
+    li a0, 1
+exit:
+    lla a1, semiargs
+#if __riscv_xlen == 64
+    sd a0, 8(a1)
+#else
+    sw a0, 4(a1)
+#endif
+    li a0, 0x20
+    .balign 16
+    slli zero, zero, 31
+    ebreak
+    srai zero, zero, 7
+    j .
+
+    .data
+    .balign 8
+semiargs:
+#if __riscv_xlen == 64
+    .dword 0x20026, 0
+#else
+    .word 0x20026, 0
+#endif
+pass:
+    .asciz "Zl PASS\n"
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index 117ae6fbce4a0e26fea242a2a86fc7f6ecb448a4..b36047a6240f5afa3dc22817fed12b979427f50f 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -22,6 +22,15 @@ tests += {
   },
 }
 
+tests += {
+  '../riscv/zl/zl.S': {
+    'cflags': cflags + ['-march=rv32i_zicsr_zifencei'],
+    'qemu_args': ['-M', 'virt', '-m', '16M', '-bios', 'none', '-display', 'none',
+                  '-serial', 'none', '-monitor', 'none', '-semihosting',
+                  '-cpu', 'rv32,x-zl=true,c=false,zca=false', '-kernel'],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e98e0b5498952d2b50b48894c99c377..0b5a6db4a4926d342c6e613490731fb7a663fb5c 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,15 @@ tests += {
   }
 }
 
+tests += {
+  '../riscv/zl/zl.S': {
+    'cflags': cflags + ['-march=rv64i_zicsr_zifencei', '-mabi=lp64'],
+    'qemu_args': ['-M', 'virt', '-m', '16M', '-bios', 'none', '-display', 'none',
+                  '-serial', 'none', '-monitor', 'none', '-semihosting',
+                  '-cpu', 'rv64,x-zl=true,c=false,zca=false', '-kernel'],
+  },
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {

-- 
2.43.0


