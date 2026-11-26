Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA4606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o2mAoCB6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUJH-0006ap-F5; Thu, 26 Nov 2026 02:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJE-0006VN-7N; Thu, 26 Nov 2026 02:54:24 -0500
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xWUJ7-0002aA-NB; Thu, 26 Nov 2026 02:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795679640; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=KS5Mdf8GznZV0nyu+Jd6sGT2VO9cFWm1bOa0+Ya6Y+8=;
 b=o2mAoCB67y1U/nk3Hp51ON+s6NdfRH2RG+OpYgDVfNiMJsizJ/PcpAXUzjMqWbEX8bBPWfitGdjME4U2w/RqzfQl9Oak2IS6DrVYt7Dl08jiDdVUTJ+rHzayhwmTZJyrIVLNoccmJnAtJEZWUfNAfekMjn/d0Tc5umJEMfJctN4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R681e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XFTpGYa_1795679639; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XFTpGYa_1795679639 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:53:59 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 2/6] tests/tcg/riscv64: Add nested-PTE-read access-fault
 regression
Date: Thu, 26 Nov 2026 15:53:46 +0800
Message-Id: <20261126075350.13022-3-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
References: <20261126075350.13022-1-zhiwei_liu@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
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

Add an H-extension regression test for the preceding VS PTE read fix.

While translating a guest virtual address, the VS-stage walker may need
to read a PTE. Reading that PTE requires a G-stage translation. A PMP
or PMA failure during this recursive walk must raise an access fault
for the original fetch, load or store. It must not become a guest-page
fault.

The test builds a small bare-metal setup and checks both outcomes:

- PMP/PMA failures during nested PTE reads report the original
  access-fault type.
- Genuine G-stage translation failures report guest-page faults.

For access faults, also check that mtval holds the original virtual
address and mtval2 is zero.

Before the fix, the first PMP case incorrectly reported a guest-page
fault and the test exited with failure code 2.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
AI-used-for: tests
---
 tests/tcg/riscv64/system/meson.build         |   7 +
 tests/tcg/riscv64/test-gstage-access-fault.S | 225 +++++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-gstage-access-fault.S

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..645bc8576f 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -16,6 +16,13 @@ qemu_args = ['-M', 'virt',
 
 setup = {'cflags': cflags, 'qemu_args': qemu_args}
 
+tests += {
+  'test-gstage-access-fault.S': {
+    'cflags': cflags + ['-march=rv64ima_zicsr'],
+    'qemu_args': ['-cpu', 'rv64,h=true,svade=false,svadu=false', qemu_args],
+  },
+}
+
 tests += {
   'doubletrap.S': setup + {'plugin_test': {'plugin': 'discons'}},
   'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
diff --git a/tests/tcg/riscv64/test-gstage-access-fault.S b/tests/tcg/riscv64/test-gstage-access-fault.S
new file mode 100644
index 0000000000..61a0957270
--- /dev/null
+++ b/tests/tcg/riscv64/test-gstage-access-fault.S
@@ -0,0 +1,225 @@
+/*
+ * Distinguish physical access faults from G-stage page faults.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * Nested-PTE-read test flow (virt with the H extension):
+ *
+ * 1. Set up the test environment.
+ *    Install an M-mode trap handler and disable delegation so every
+ *    exception is observed in M-mode. The handler records mcause in s1
+ *    and returns to the per-case continuation in s2. A failed CHECK
+ *    exits through semihosting with a unique code; success exits zero.
+ *
+ * 2. Create working VS-stage and G-stage mappings.
+ *    Build Sv39 VS tables mapping guest virtual address 0x4000 to guest
+ *    physical address 0x8000. Build Sv39x4 G-stage tables mapping the VS
+ *    page-table pages and final data page into RAM. Pre-set leaf A/D
+ *    bits so these read cases do not enter A/D write-back handling.
+ *    First verify that a normal load from 0x4000 succeeds.
+ *
+ * 3. Check PMP failures during nested PTE reads.
+ *    TRY_DATA uses MPRV/MPV for guest loads and stores. TRY_FETCH uses
+ *    mret to enter VS-mode and fetch from the same virtual address.
+ *    Deny reads of the G-stage root page, G_ROOT, with PMP. A load,
+ *    store and fetch must report access-fault causes 5, 7 and 1,
+ *    respectively. CHECK also requires mtval == 0x4000 and mtval2 == 0.
+ *    As a control, deny reads of the translated VS leaf PTE page and
+ *    require the guest load to report the same load access fault.
+ *
+ * 4. Check genuine G-stage translation failures.
+ *    Restore PMP access, then invalidate the G-stage mapping of the VS
+ *    root page. Require guest-page-fault causes 21, 23 and 20 for load,
+ *    store and fetch. Restore the mapping afterward. WRITE_PTE issues
+ *    HFENCE.VVMA and HFENCE.GVMA so stale translations cannot hide the
+ *    page-table changes.
+ *
+ * 5. Check PMA failures during nested PTE reads.
+ *    Point hgatp at the unmapped physical root address 0x90000000 and
+ *    repeat the load, store and fetch checks. The recursive walk must
+ *    return TRANSLATE_PMA_FAIL for the inaccessible physical PTE read,
+ *    rather than a normal G-stage mapping failure. Require the original
+ *    access-fault causes and the same mtval/mtval2 checks as in step 3.
+ *
+ * 6. Verify recovery.
+ *    Restore valid VS-stage and G-stage translation state, then confirm
+ *    that a normal load succeeds again before exiting with zero.
+ *    Keep the shared helpers and failure-code layout suitable for later
+ *    A/D-update and direct G-stage test extensions.
+ */
+
+        .option norvc
+        .equ MPRV, (1 << 17)
+        .equ MPV, (1 << 39)
+        .equ MPP_S, (1 << 11)
+        .equ MPP_M, (3 << 11)
+        .equ VS_ROOT, 0x80400000
+        .equ VS_L1, 0x80401000
+        .equ VS_L0, 0x80402000
+        .equ G_ROOT, 0x80404000
+        .equ G_L1, 0x80408000
+        .equ G_L0, 0x80409000
+        .equ DATA, 0x80500000
+
+        .macro PMP_ALL
+        csrw pmpcfg0, zero
+        li t0, -1
+        csrw pmpaddr0, t0
+        li t0, 0x1f
+        csrw pmpcfg0, t0
+        .endm
+
+        /* A higher-priority 4 KiB region, with a catch-all RWX region. */
+        .macro PMP_PAGE address, permissions
+        csrw pmpcfg0, zero
+        li t0, ((\address >> 2) | 0x1ff)
+        csrw pmpaddr0, t0
+        li t0, -1
+        csrw pmpaddr1, t0
+        li t0, (0x1f00 | 0x18 | \permissions)
+        csrw pmpcfg0, t0
+        .endm
+
+        .macro WRITE_PTE address, value
+        li t0, \address
+        li t1, \value
+        sd t1, 0(t0)
+        /* HFENCE.VVMA and HFENCE.GVMA for VS- and G-stage changes. */
+        .insn r 0x73, 0, 0x11, x0, x0, x0
+        .insn r 0x73, 0, 0x31, x0, x0, x0
+        .endm
+
+        /* The original faulting address is always GVA 0x4000. */
+        .macro CHECK cause, code
+        li a0, \code
+        li t0, \cause
+        bne s1, t0, fail
+        .if \cause != 0
+        csrr t0, mtval
+        li t1, 0x4000
+        bne t0, t1, fail
+        .endif
+        .if (\cause == 1) || (\cause == 5) || (\cause == 7)
+        csrr t0, mtval2
+        bnez t0, fail
+        .endif
+        .endm
+
+        .macro TRY_DATA store, cause, code
+        li s1, 0
+        lla s2, .Lresume\@
+        li a3, 0x4000
+        li t0, MPP_M
+        csrc mstatus, t0
+        li t0, MPP_S | MPRV | MPV
+        csrs mstatus, t0
+        .if \store
+        sw zero, 0(a3)
+        .else
+        lw t4, 0(a3)
+        .endif
+.Lresume\@:
+        li t0, MPRV | MPV
+        csrc mstatus, t0
+        CHECK \cause, \code
+        .endm
+
+        .macro TRY_FETCH cause, code
+        li s1, 0
+        lla s2, .Lresume\@
+        li t0, MPP_M | MPRV | MPV
+        csrc mstatus, t0
+        li t0, MPP_S | MPV
+        csrs mstatus, t0
+        li t0, 0x4000
+        csrw mepc, t0
+        mret
+.Lresume\@:
+        CHECK \cause, \code
+        .endm
+
+        .text
+        .global _start
+_start:
+        lla t0, trap
+        csrw mtvec, t0
+        csrw medeleg, zero
+        PMP_ALL
+
+        /* VS Sv39 maps VA 0x4000 to GPA 0x8000, using guest PPNs 4/5/6. */
+        WRITE_PTE VS_ROOT, 0x1401
+        WRITE_PTE VS_L1, 0x1801
+        WRITE_PTE (VS_L0 + 0x20), 0x20cf
+
+        /* Sv39x4 maps the three VS page tables and the final data page. */
+        WRITE_PTE G_ROOT, (((G_L1 >> 12) << 10) | 1)
+        WRITE_PTE G_L1, (((G_L0 >> 12) << 10) | 1)
+        WRITE_PTE (G_L0 + 0x20), (((VS_ROOT >> 12) << 10) | 0xdf)
+        WRITE_PTE (G_L0 + 0x28), (((VS_L1 >> 12) << 10) | 0xdf)
+        WRITE_PTE (G_L0 + 0x30), (((VS_L0 >> 12) << 10) | 0xdf)
+        WRITE_PTE (G_L0 + 0x40), (((DATA >> 12) << 10) | 0xdf)
+        li t0, 0x8000000000000004
+        csrw vsatp, t0
+        li t0, (0x8000000000000000 | (G_ROOT >> 12))
+        csrw hgatp, t0
+        TRY_DATA 0, 0, 1
+
+        /* PMP denial while recursively reading a G-stage PTE. */
+        PMP_PAGE G_ROOT, 0
+        TRY_DATA 0, 5, 2
+        TRY_DATA 1, 7, 3
+        TRY_FETCH 1, 4
+
+        /* A denial of the translated VS PTE is also an access fault. */
+        PMP_PAGE VS_L0, 0
+        TRY_DATA 0, 5, 5
+        PMP_ALL
+
+        /* A genuine G-stage mapping failure must remain a guest-page fault. */
+        WRITE_PTE (G_L0 + 0x20), 0
+        TRY_DATA 0, 21, 6
+        TRY_DATA 1, 23, 7
+        TRY_FETCH 20, 8
+        WRITE_PTE (G_L0 + 0x20), (((VS_ROOT >> 12) << 10) | 0xdf)
+
+        /* An unmapped physical G-stage root produces PMA access faults. */
+        li t0, 0x8000000000090000
+        csrw hgatp, t0
+        TRY_DATA 0, 5, 12
+        TRY_DATA 1, 7, 13
+        TRY_FETCH 1, 14
+
+        li t0, 0x8000000000000004
+        csrw vsatp, t0
+        li t0, (0x8000000000000000 | (G_ROOT >> 12))
+        csrw hgatp, t0
+        TRY_DATA 0, 0, 16
+        li a0, 0
+fail:
+        lla a1, semiargs
+        li t0, 0x20026
+        sd t0, 0(a1)
+        sd a0, 8(a1)
+        li a0, 0x20
+        .balign 16
+        slli zero, zero, 0x1f
+        ebreak
+        srai zero, zero, 0x7
+        j .
+
+        .balign 4
+trap:
+        csrr s1, mcause
+        csrw mepc, s2
+        li t0, MPP_M | MPRV | MPV
+        csrc mstatus, t0
+        li t0, MPP_M
+        csrs mstatus, t0
+        mret
+
+        .data
+        .balign 8
+semiargs:
+        .space 16
-- 
2.43.0


