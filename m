Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A68C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzey-0007XH-Dr; Thu, 23 Jul 2026 16:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeH-0007OS-Jd; Thu, 23 Jul 2026 16:04:06 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeA-0005Rh-MA; Thu, 23 Jul 2026 16:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784837019; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=wRhLOWtyempeLUIfXjWsGUdKh9L9dsnADem3H/qLM6I=;
 b=xQTkQYBTUUsS/QsB/qzq8nBhG19ihF96ah/qKE/dqDkK2+aPwavx2AFu/3c33ZVYR5pLNeLVmwYWbHAIo0d+i9SPAD5MbFo9ITUOq7rxERjP7oV1vZn5CTo4jWigC+NYSgsotdZmfbGxVQmfpmdXh/Lu2KiNWFqUM3kmt2H51F4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X7h4Ute_1784837017; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X7h4Ute_1784837017 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jul 2026 04:03:38 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v8 00/11] target/riscv: Implement Smsdid and Smmpt extension
Date: Fri, 24 Jul 2026 04:03:14 +0800
Message-Id: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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

This patch set introduces support for the RISC-V Smsdid and Smmpt
(Supervisor Domain Identifier and Memory Protection Table) extensions
v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
Smmpt provides a hardware mechanism for fine-grained memory protection,
checked after address translation, which is particularly useful for
supervisor-level sandboxing and security monitoring.

The rfc patch set:
https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html

Rahul Pathak is working on SMMPT OpenSBI support -
https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html

based on his QEMU SMMPT branch -
https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1

As we all agree -
https://patchew.org/QEMU/20260715145016.17369-1-zhiwei._5Fliu@linux.alibaba.com/
, we will collaborate on this work and not duplicate efforts. Rahul will
focus on OpenSBI upstream and I will update the QEMU patch set to v8.

Xiangyi will review the OpenSBI SMMPT patch set and may collaborate to
upstream the other parts, such as SMSDIA and IOMPT.

v7->v8:
    1. Update the mfence.pa and minval.pa instruction encodings to match the
       upstream riscv-opcodes definition
       (https://github.com/riscv/riscv-opcodes/pull/389/): mfence.pa now uses
       funct7=0b0011001 and minval.pa uses funct7=0b0011011. The decoder,
       disassembler and the system test are updated accordingly.

v6->v7:
    The implementation is updated from the v0.3.4 specification to
    v0.4.9. The main changes are:
    1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
    2. Update the mmpt register layout: the SDID and PPN field positions
       changed and the RV64 PPN is now 44 bits.
    3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2, the
       non-leaf NAPOT form is removed, NAPOT leaf entries encode a single
       XWR tuple plus a G granularity field, and non-NAPOT leaf entries
       hold per-page XWR tuples.
    4. Treat XWR=000 as "no access" and a non-leaf entry with N=1 as a
       fault.
    5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits zero).
    6. Rename the fence instructions mfence.spa/minval.spa to
       mfence.pa/minval.pa.
    7. Drop stale Reviewed-by tags on the substantially reworked patches.
    8. Introduce the configurable "smmpt-sdidlen" CPU property.
    9. Add disassembly support for the Smmpt.
    10. Add bare-metal M-mode system tests.
    11. Rebase to master.

v5->v6:
    1. Use explicitly bit fields extract instead of mpte_union_t.
    2. Use the same exception behavior for MPT valiation as PMP
       valiation.
    3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
    4. Use address_space_*_le instead of address_space_* for SMMPT.
    5. Only print SMMPT address check log when SMMPT is enabled.
    6. Add implied rule for SMMPT as it depends on SMSDID.
    7. Rebase to master.

v4->v5:
    1. Rebase to master.
v3->v4:
    1. Add missing review tags.
v2->v3:
    1. Fix build error in patch 2.
    2. Rebase to master.

rfc->v2:
    1. When ext_smmpt is false or BARE mode, make other fields in mmpt
       CSR zero.
    2. Add patch 5 to fix smrnmi ISA string order.
    3. Fix patch 6 smmpt and smsdid ISA string order.
    4. Make smmpt and smsdid experiment extensions.
    5. Add review tags.

LIU Zhiwei (11):
  target/riscv: Add basic definitions and CSRs for SMMPT
  target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
  target/riscv: Implement core SMMPT lookup logic
  target/riscv: Integrate SMMPT checks into MMU and TLB fill
  target/riscv: Implement SMMPT fence instructions
  target/riscv: Fix smrnmi isa alphabetical order
  target/riscv: Add disassembly for Smmpt instructions and CSRs
  target/riscv: Enable SMMPT extension
  target/riscv: Add system test for SMMPT extension
  target/riscv: Add system tests for Smmpt52 and Smmpt64
  target/riscv: Add system test for Smmpt34

 disas/riscv.c                                 |   9 +-
 target/riscv/cpu.c                            |  60 +++-
 target/riscv/cpu.h                            |   8 +
 target/riscv/cpu_bits.h                       |  27 ++
 target/riscv/cpu_cfg_fields.h.inc             |   3 +
 target/riscv/insn32.decode                    |   2 +
 target/riscv/meson.build                      |   1 +
 target/riscv/riscv_smmpt.c                    | 339 ++++++++++++++++++
 target/riscv/riscv_smmpt.h                    |  26 ++
 target/riscv/tcg/cpu_helper.c                 | 119 +++++-
 target/riscv/tcg/csr.c                        | 106 ++++++
 .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
 target/riscv/tcg/pmp.h                        |   3 +
 tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
 tests/tcg/riscv64/smmpt-common.S              | 257 +++++++++++++
 tests/tcg/riscv64/test-smmpt.S                |  85 +++++
 tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
 tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
 tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
 19 files changed, 1354 insertions(+), 19 deletions(-)
 create mode 100644 target/riscv/riscv_smmpt.c
 create mode 100644 target/riscv/riscv_smmpt.h
 create mode 100644 tests/tcg/riscv64/smmpt-common.S
 create mode 100644 tests/tcg/riscv64/test-smmpt.S
 create mode 100644 tests/tcg/riscv64/test-smmpt34.S
 create mode 100644 tests/tcg/riscv64/test-smmpt52.S
 create mode 100644 tests/tcg/riscv64/test-smmpt64.S


base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
-- 
2.43.0


