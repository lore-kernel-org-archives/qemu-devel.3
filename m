Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A0606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvP-0002mG-Dc; Fri, 13 Nov 2026 03:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvL-0002l1-Va
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:19 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvK-0007OH-71
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:19 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 3DBE61DD;
 Fri, 13 Nov 2026 14:16:11 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	SignKirigami <prcups@krgm.moe>
Subject: [PATCH v6 00/26] add LVZ support for TCG
Date: Fri, 13 Nov 2026 16:45:15 +0800
Message-ID: <cover.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch implements Loongson VirtualiZation (LVZ) extension support
for LoongArch's TCG target. With this patch, it is now possible to start
a nested KVM-accelerated virtual machine on a TCG-emulated virtual machine.

SignKirigami (26):
  target/loongarch: add get_sys() helper
  target/loongarch: add LVZ feature switcher
  target/loongarch: add LVZ CSR metadata
  target/loongarch: add vm level 1 definition
  target/loongarch: add definition about guest mmu_idx
  target/loongarch: move timer initialization to
    loongarh_cpu_realizefn()
  target/loongarch: add LVZ guest interrupt state
  target/loongarch: add LVZ guest timer
  target/loongarch: handle return to guest in ertn
  target/loongarch: handle LVZ exception and vm_exit
  target/loongarch: add host TLBRet and handle
  target/loongarch: add gid management functions
  target/loongarch: add LVZ parameters to TLB functions
  target/loongarch: add LVZ to TLB functions
  target/loongarch: add 2-level address mapping to
    loongarch_cpu_tlb_fill()
  target/loongarch: add LVZ to invtlb 0x0-0x6
  target/loongarch: add LVZ to invtlb 0xa-0xe
  target/loongarch: add LVZ to ptw
  target/loongarch: add LVZ migration state
  target/loongarch: add LVZ to CSR operations
  target/loongarch: add LVZ to CSR helpers
  target/loongarch: add guest CSR operations
  target/loongarch: add LVZ CSRs
  target/loongarch: translate LVZ guest traps and HVC
  target/loongarch: initialize CSR related to LVZ
  target/loongarch: exit to vm level 0 for fpd, sxd and asxd of vm level
    0

 target/loongarch/cpu-csr.h                    |  38 ++
 target/loongarch/cpu-mmu.h                    |  31 +-
 target/loongarch/cpu.c                        | 117 +++++--
 target/loongarch/cpu.h                        |  90 ++++-
 target/loongarch/cpu_helper.c                 |  52 +--
 target/loongarch/csr.c                        | 102 +++---
 target/loongarch/csr.h                        |   1 +
 target/loongarch/disas.c                      |   9 +
 target/loongarch/insns.decode                 |   7 +
 target/loongarch/internals.h                  |   4 +-
 target/loongarch/machine.c                    | 139 ++++++++
 target/loongarch/tcg/csr_helper.c             | 131 +++++--
 target/loongarch/tcg/helper.h                 |  37 +-
 .../tcg/insn_trans/trans_extra.c.inc          |   5 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 212 ++++++++++--
 target/loongarch/tcg/op_helper.c              |  37 ++
 target/loongarch/tcg/tcg_cpu.c                |  89 +++--
 target/loongarch/tcg/tlb_helper.c             | 324 ++++++++++++------
 target/loongarch/tcg/translate.c              |   3 +
 target/loongarch/translate.h                  |   1 +
 20 files changed, 1107 insertions(+), 322 deletions(-)


base-commit: 49559567804523cb28cad002aa8e97f444e23ad7
-- 
2.56.0


