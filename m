Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A404DCA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0vY-0004dg-OZ; Thu, 08 Oct 2026 23:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vR-0004cP-4Q
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:38 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vO-0005lP-0B
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:36 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 5FFEFDFC1;
 Fri, 09 Oct 2026 08:35:29 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	SignKirigami <prcups@krgm.moe>
Subject: [PATCH v5 00/23] add LVZ support for TCG
Date: Fri,  9 Oct 2026 11:04:56 +0800
Message-ID: <cover.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch implements Loongson VirtualiZation (LVZ) extension support
for LoongArch's TCG target. With this patch, it is now possible to start
a nested KVM-accelerated virtual machine on a TCG-emulated virtual machine.

SignKirigami (23):
  target/loongarch: select sys state by VM level
  target/loongarch: add get_sys() helper
  target/loongarch: add LVZ feature switcher
  target/loongarch: add LVZ CSR metadata
  target/loongarch: add vm level 1 definition
  target/loongarch: add definition about guest mmu_idx
  target/loongarch: add LVZ guest interrupt state
  target/loongarch: add LVZ guest timer
  target/loongarch: handle return to guest in ertn
  target/loongarch: handle LVZ exception and vm_exit
  target/loongarch: add host TLBRet and handle
  target/loongarch: add gid management functions
  target/loongarch: add LVZ parameters to TLB functions
  target/loongarch: add LVZ to TLB functions
  target/loongarch: add LVZ to invtlb
  target/loongarch: add LVZ to ptw
  target/loongarch: add LVZ migration state
  target/loongarch: add gcsr instructions and vm level 1 csr management
  target/loongarch: add LVZ CSRs
  target/loongarch: translate LVZ guest TLB instructions
  target/loongarch: translate LVZ guest traps and HVC
  target/loongarch: initialize CSR related to LVZ
  target/loongarch: exit to vm level 0 for fpd, sxd and asxd of vm level
    0

 target/loongarch/cpu-csr.h                    |  38 ++
 target/loongarch/cpu-mmu.h                    |  36 +-
 target/loongarch/cpu.c                        |  87 +++-
 target/loongarch/cpu.h                        | 105 ++++-
 target/loongarch/cpu_helper.c                 |  73 ++--
 target/loongarch/csr.c                        | 102 ++---
 target/loongarch/csr.h                        |   1 +
 target/loongarch/disas.c                      |  15 +
 target/loongarch/insns.decode                 |  14 +
 target/loongarch/internals.h                  |   4 +-
 target/loongarch/machine.c                    | 104 +++++
 target/loongarch/tcg/csr_helper.c             | 131 ++++--
 target/loongarch/tcg/helper.h                 |  49 ++-
 .../tcg/insn_trans/trans_extra.c.inc          |   5 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 290 +++++++++++--
 target/loongarch/tcg/op_helper.c              |  37 ++
 target/loongarch/tcg/tcg_cpu.c                |  94 +++--
 target/loongarch/tcg/tcg_loongarch.h          |   3 +-
 target/loongarch/tcg/tlb_helper.c             | 395 ++++++++++++------
 target/loongarch/tcg/translate.c              |   3 +
 target/loongarch/translate.h                  |   1 +
 21 files changed, 1245 insertions(+), 342 deletions(-)

-- 
2.55.0


