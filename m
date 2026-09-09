Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF3C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DtM-0008H9-OX; Wed, 09 Sep 2026 04:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtL-0008Gt-KU
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:51 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtJ-0003JO-E8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:51 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so7666885ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788943368; x=1789548168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vImdkmvMo/lSnFvS/i/NnfNPKJd5mdI+EH5Dgwt+YC8=;
 b=kozbK1NmsgMXNpEtC+BcQBTnK4sNv2Ku4dZ+5YvJJtBCfdn3bPuFeJ93P3j5RCJn9p
 r0UAqYQTBwtqMXOK8FH6m/5AMQFlc9dsw4TSxH9YeDxXO4ySkvkmhcyfVUca/pz1xcNq
 V0asP57L1m8nmOauv73fecZNRwQWjqW8n4lEUfEEsqeCgZBBp9tOs0BxyT65U0r//lUd
 zorN/UgWN8UOibTwEed85Tkfp7xAvNRfD2iFWN0DDFBpR1R4a7suee7KEZP1GvxnTECl
 HXfC1MUEneKE324QdDhAFqPU7Yqir1a3Jv5GB8Hv5w462gs+b5Zc9NksvcMtJmDMxPYL
 XJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943368; x=1789548168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vImdkmvMo/lSnFvS/i/NnfNPKJd5mdI+EH5Dgwt+YC8=;
 b=dx13K2bamSmPCTaBqzbpwOv3QLdOs50tAs6gJs9q200Kg5kBjnL2TpLBn3KzfDSjoj
 34dsWbzX8pbIyISpmT6Zksyu/OTwsyIaToEUPJMpW23qZG8a5h8xEw8Q8pGGtfvSSpif
 v+HFg19/hA0ZJYTWQvRmrqVhT/RjVeRvmTM/3oPHb51cJ5d62gdgFJUOjHHbwn/iBC2d
 mLNseat7B98a+Fb60UTgqrHEOh2EbxLbW7dCwQ7ifJW8H5BlMldzUJ+uNfRDifBH9m2i
 G86mkX/DxfgYY5+w+amHfBpkdM0lk2+bOy72IHTX57POi1K8OXiMzvhs6iTEuF8HEeQ1
 8Bqg==
X-Gm-Message-State: AFuF++muPprDMn0PUQwa94vYGzVPIGftrAlyxLPCD/GdRBE3fHRVfuvS
 PRrQx0IeH6df77a+Xo6N8ae1L7nj8HFnuBctFxEts3Udhu0dqzSBzm71JGSFlXS0nA6Lsqgvng0
 Fb3/UhTII5qv1iSaGk3uOlZnqLCbh1CMVIORlPiwKqF2Ba4IsWIELbGpBhxBK4YF8BDctKyvcdI
 qoaLkhMb8J/g+tVeAI48T74lGi6rfDR5URPDwVtmAC7Q==
X-Gm-Gg: AYBFou1RtQ/0dwf4cZqK2buybkmUK3QNeLR0wR/kmboCmQsKFQfy7J7CG5bngTUijFE
 aqD+lz3nYMC4bqEaQEfHvyE5nn/VpLi+qAyav1skAyZUwX/ezgua24PWoQx8dG4gKld5bdmA6ct
 wsZCWm3Kg/RvSLGF/FQlmYRSaI7PbdzYx+8pqi7VVOfl187GrD4H/7MDL/TbXxzI2jdi8LR68ya
 TjCpgIwDCB4H5ndCgeBPdAs2saX7cgtvCT7E8xnlh8FaJlQYbnRJiSNi08UsCawqFtPOtF23D4x
 Dv4046+kg9ZM/KB1HdHpOPe09Hre9f4gz5VCtftENxYK5i4lrmXTGsOptLzWNQBW9INKONQuZhj
 robqspzY65phi2B+PP8dUMu8MX3WsOsgaj2dO/fKZVnM9qxrXnX+AlxplDpM9VlnUBEm+xjTCUk
 7BWMEe1hzBQLVR8lkedUC/5UKgR5/AkWk9wKzjOfsMp4trtV2IJa91mNCGrwGb6HaVpJVCcR5mM
 OuQupSmh0IBiDtt7J9XIYI1E4dZiQr1dzGpbfL9iRyavYAWHCCS384dvE8wx0nwk/xtnUsaY2eK
 C9WXG4UJ
X-Received: by 2002:a17:902:fc4e:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2db8da30a48mr62754735ad.8.1788943367894; 
 Wed, 09 Sep 2026 01:42:47 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db56c2a1f1sm38328225ad.78.2026.09.09.01.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:42:47 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 4/6] tests/tcg/riscv64: Add vector unit-stride PMP test
Date: Wed,  9 Sep 2026 16:41:51 +0800
Message-ID: <20260909084154.223529-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909084154.223529-1-max.chou@sifive.com>
References: <20260909084154.223529-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a bare-metal test for locked NA4 PMP permissions lying inside
unit-stride access ranges. The test covers unmasked and masked reads
and writes, and checks that an interior deny is reported with the
exact faulting mtval and vstart rather than merely trapping somewhere
in the range.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   7 +-
 tests/tcg/riscv64/test-rvv-ldst-us-pmp.S  | 281 ++++++++++++++++++++++
 2 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-us-pmp.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 0fdf242f735..9e0e0490753 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -86,17 +86,20 @@ run-test-vle32ff: test-vle32ff
 test-vle32ff: CFLAGS += -march=rv64gcv
 
 RVV_LDST_MARCH = -march=rv64gcv
-RVV_LDST_TESTS = test-rvv-ldst-ff-pmp
+RVV_LDST_TESTS = test-rvv-ldst-ff-pmp test-rvv-ldst-us-pmp
 CLEANFILES += $(RVV_LDST_TESTS)
 
 $(RVV_LDST_TESTS): %: %.S rvv-ldst.inc $(LINK_SCRIPT)
 	$(CC) $(CFLAGS) $(RVV_LDST_MARCH) $< -Wa,--noexecstack -c -o $@.o
 	$(LD) $(LDFLAGS) $@.o -o $@
 
-EXTRA_RUNS += run-test-rvv-ldst-ff-pmp
+EXTRA_RUNS += run-test-rvv-ldst-ff-pmp run-test-rvv-ldst-us-pmp
 
 run-test-rvv-ldst-ff-pmp: test-rvv-ldst-ff-pmp
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0$(comma)rvv_ta_all_1s=true$(comma)rvv_ma_all_1s=true $(QEMU_OPTS)$<)
 
+run-test-rvv-ldst-us-pmp: test-rvv-ldst-us-pmp
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0$(comma)rvv_ta_all_1s=true$(comma)rvv_ma_all_1s=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-rvv-ldst-us-pmp.S b/tests/tcg/riscv64/test-rvv-ldst-us-pmp.S
new file mode 100644
index 00000000000..521667628da
--- /dev/null
+++ b/tests/tcg/riscv64/test-rvv-ldst-us-pmp.S
@@ -0,0 +1,281 @@
+/*
+ * RISC-V vector unit-stride with PMP tests
+ *
+ * Runs with rvv_ta_all_1s=true and rvv_ma_all_1s=true so that with a
+ * "ta, ma" vtype QEMU fills every masked-off and tail element with
+ * all-1s, distinct from the 0x05050505 sentinel and the loaded data.
+ *
+ * PMP layout (locked entries, lowest number wins; everything outside
+ * the test page is unmatched and so fully accessible from M-mode):
+ *   pmp0: NA4   buf_a+4,   L, ---   deny word 1 of buf_a
+ *   pmp1: NA4   buf_b+8,   L, ---   deny word 2 of buf_b
+ *   pmp2: NA4   buf_c+4,   L, R--   word 1 of buf_c readable, no write
+ *   pmp3: NAPOT test page, L, RW    lower-priority page allow
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    #include "rvv-ldst.inc"
+
+    /* Assert the word at \sym+\off (readable) still equals \expected. */
+    .macro  CHECK_WORD sym, off, expected
+    lla     t1, \sym
+    lw      t0, \off(t1)
+    li      t6, \expected
+    bne     t0, t6, fail
+    .endm
+
+    .text
+    .global _start
+_start:
+    RVV_ENABLE
+    lla     t0, trap_handler
+    csrw    mtvec, t0
+
+    /*
+     * Trap handler protocol:
+     *   s0: expected mcause (0: no trap expected)
+     *   s1: expected mtval  (-1: any mtval accepted)
+     *   s2: traps taken     s3: vstart seen at last trap
+     *   s4: traps expected  s5: mtval seen at last trap
+     */
+    li      s0, 0
+    li      s1, 0
+    li      s2, 0
+    li      s3, -1
+    li      s4, 0
+    li      s5, -1
+
+    /* Program the locked PMP entries; single locking cfg write last. */
+    lla     t0, buf_a + 4
+    srli    t0, t0, 2
+    csrw    pmpaddr0, t0
+    lla     t0, buf_b + 8
+    srli    t0, t0, 2
+    csrw    pmpaddr1, t0
+    lla     t0, buf_c + 4
+    srli    t0, t0, 2
+    csrw    pmpaddr2, t0
+    lla     t0, pmp_page
+    srli    t0, t0, 2
+    ori     t0, t0, 0x1ff
+    csrw    pmpaddr3, t0
+    li      t0, 0x000000009b919090
+    csrw    pmpcfg0, t0
+
+    /*
+     * Case 1: sanity: the NA4 read deny traps a scalar load.
+     */
+    CASE    1
+    li      s0, 5
+    li      s1, -1
+    lla     t1, buf_a
+    lw      t0, 4(t1)
+    CHECK_TRAP
+
+    /*
+     * Case 2: sanity: the read-only NA4 word traps a scalar store and
+     * still reads back, proving stores can be verified via loads.
+     */
+    CASE    2
+    li          s0, 7
+    li          s1, -1
+    lla         t1, buf_c
+    sw          t1, 4(t1)
+    CHECK_TRAP
+    CHECK_WORD  buf_c, 4, 0x00cc0001
+
+    /*
+     * Case 3: unmasked vle32.v, vl 3, read deny strictly inside the
+     * range at buf_a+4 (element 1): element 1 is active, so the access
+     * must raise a load access fault.  A probe that samples only the range
+     * endpoints sees just the page allow and loads the denied word silently.
+     */
+    CASE    3
+    PREFILL
+    li          s0, 5
+    li          s1, -1
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_a
+    vle32.v     v2, (a0)
+    CHECK_TRAP
+
+    /*
+     * Case 4: unmasked vle32.v with the denied word first in the
+     * range: element 0 faults and vstart is zero.
+     */
+    CASE    4
+    PREFILL
+    li          s0, 5
+    li          s1, -1
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_a + 4
+    vle32.v     v2, (a0)
+    CHECK_TRAP
+    bnez        s3, fail
+
+    /*
+     * Case 5: unmasked vle32.v with the denied word last in the range
+     * at buf_b+8 (element 2): must trap.
+     */
+    CASE    5
+    PREFILL
+    li          s0, 5
+    li          s1, -1
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_b
+    vle32.v     v2, (a0)
+    CHECK_TRAP
+
+    /*
+     * Case 6: unmasked vse32.v, vl 3, write deny strictly inside the
+     * range at buf_c+4 (element 1): the protected word must remain
+     * unmodified.  Element 0 must have been stored and element 2 must
+     * not, so that a "store every element whose own probe succeeds"
+     * implementation is rejected rather than passing on the protected
+     * word alone.
+     */
+    CASE    6
+    vsetivli    zero, 4, e32, m1, ta, ma
+    lla         a0, st_data_a
+    vle32.v     v4, (a0)
+    li          s0, 7
+    li          s1, -1
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_c
+    vse32.v     v4, (a0)
+    CHECK_TRAP
+    CHECK_WORD  buf_c, 0, 0x11111111
+    CHECK_WORD  buf_c, 4, 0x00cc0001
+    CHECK_WORD  buf_c, 8, 0x00cc0002
+
+    /*
+     * Case 7: masked vle32.v with the read deny only under masked-off
+     * element 1: no access is performed there, so no trap and the
+     * mask-agnostic all-1s fill applies.
+     */
+    CASE    7
+    PREFILL
+    SET_MASK    0b101
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_a
+    vle32.v     v2, (a0), v0.t
+    CHECK_NO_TRAP
+    CHECK_VELEM v2, 0, 0x00aa0000
+    CHECK_VELEM v2, 1, -1
+    CHECK_VELEM v2, 2, 0x00aa0002
+    CHECK_VELEM v2, 3, -1
+
+    /*
+     * Case 8: masked vse32.v with the write deny only under masked-off
+     * element 1: no trap, elements 0 and 2 stored, the protected word
+     * untouched.
+     */
+    CASE    8
+    vsetivli    zero, 4, e32, m1, ta, ma
+    lla         a0, st_data_b
+    vle32.v     v4, (a0)
+    SET_MASK    0b101
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_c
+    vse32.v     v4, (a0), v0.t
+    CHECK_NO_TRAP
+    CHECK_WORD  buf_c, 0, 0x44444444
+    CHECK_WORD  buf_c, 4, 0x00cc0001
+    CHECK_WORD  buf_c, 8, 0x66666666
+
+    /*
+     * Case 9: like case 3 (read deny at element 1 of 3), the mtval should be
+     * the denied word's own address and vstart should be 1, not the range
+     * base and 0.
+     */
+    CASE    9
+    PREFILL
+    li          s0, 5
+    lla         s1, buf_a + 4
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_a
+    vle32.v     v2, (a0)
+    CHECK_TRAP
+    ASSERT_EQ   s3, 1
+
+    /*
+     * Case 10: like case 5 (read deny at element 2, the last of 3),
+     * confirming precise reporting also holds when the denied element
+     * is not the first one probed.
+     */
+    CASE    10
+    PREFILL
+    li          s0, 5
+    lla         s1, buf_b + 8
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_b
+    vle32.v     v2, (a0)
+    CHECK_TRAP
+    ASSERT_EQ   s3, 2
+
+    /*
+     * Case 11: like case 6 (write deny at element 1 of 3), on the
+     * store side.  buf_c+8 still holds the 0x66666666 that case 8
+     * stored, so checking it here proves element 2 was not written
+     * after the trap.
+     */
+    CASE    11
+    vsetivli    zero, 4, e32, m1, ta, ma
+    lla         a0, st_data_a
+    vle32.v     v4, (a0)
+    li          s0, 7
+    lla         s1, buf_c + 4
+    vsetivli    zero, 3, e32, m1, ta, ma
+    lla         a0, buf_c
+    vse32.v     v4, (a0)
+    CHECK_TRAP
+    ASSERT_EQ   s3, 1
+    CHECK_WORD  buf_c, 0, 0x11111111
+    CHECK_WORD  buf_c, 4, 0x00cc0001
+    CHECK_WORD  buf_c, 8, 0x66666666
+
+    li    a0, 0
+exit:
+    SEMI_EXIT
+    FAIL
+
+    .balign    4
+trap_handler:
+    csrr    t5, mcause
+    bne     t5, s0, fail
+    csrr    s5, mtval
+    li      t5, -1
+    beq     s1, t5, 1f
+    bne     s5, s1, fail
+1:
+    csrr    s3, vstart
+    addi    s2, s2, 1
+    csrw    vstart, zero
+    csrr    t5, mepc
+    addi    t5, t5, 4
+    csrw    mepc, t5
+    mret
+
+    .data
+    .balign    16
+semiargs: .space 16
+
+    /* Store source data; outside every PMP region. */
+st_data_a: .word    0x11111111, 0x22222222, 0x33333333, 0x77777777
+st_data_b: .word    0x44444444, 0x55555555, 0x66666666, 0x88888888
+
+    /* One dedicated page governed by the locked NAPOT RW entry. */
+    .balign    4096
+pmp_page:
+buf_a:
+    .word    0x00aa0000, 0x00aa0001, 0x00aa0002, 0x00aa0003
+    .word    0x00aa0004, 0x00aa0005
+    .skip    40
+buf_b:
+    .word    0x00bb0000, 0x00bb0001, 0x00bb0002, 0x00bb0003
+    .word    0x00bb0004, 0x00bb0005
+    .skip    40
+buf_c:
+    .word    0x00cc0000, 0x00cc0001, 0x00cc0002, 0x00cc0003
+    .word    0x00cc0004, 0x00cc0005
+    .skip    3944
-- 
2.43.0


