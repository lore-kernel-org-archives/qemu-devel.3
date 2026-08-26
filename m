Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6536CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAuN-0001uM-Pz; Wed, 26 Aug 2026 06:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wzAuL-0001tZ-Hw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:01 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wzAuJ-0003JV-CL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:31:01 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id F3BF57A15;
 Wed, 26 Aug 2026 16:00:53 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>
Subject: [PATCH v4 00/14] target/loongarch: add LVZ support for TCG
Date: Wed, 26 Aug 2026 18:30:04 +0800
Message-ID: <cover.1787739852.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SignKirigami (14):
  target/loongarch: Define LVZ CSR fields
  target/loongarch: Add LVZ CPU state definitions
  target/loongarch: Add LVZ CSR metadata
  target/loongarch: Add LVZ CPU model support
  target/loongarch: Add LVZ guest interrupt state
  target/loongarch: Add LVZ guest timer support
  target/loongarch: Add LVZ VM entry and exception handling
  target/loongarch: Add LVZ guest CSR helpers
  target/loongarch: Add LVZ migration state
  target/loongarch: Add LVZ MMU and PTW support
  target/loongarch: Translate LVZ guest CSR instructions
  target/loongarch: Translate LVZ guest TLB instructions
  target/loongarch: Translate LVZ guest traps and HVC
  fix(tcg/loongarch): strip flag bits in lddir/ldpte address calculation

 target/loongarch/arch_dump.c                  |   6 +-
 target/loongarch/cpu-csr.h                    |  38 ++
 target/loongarch/cpu-mmu.h                    |  38 +-
 target/loongarch/cpu.c                        | 247 ++++++---
 target/loongarch/cpu.h                        |  64 ++-
 target/loongarch/cpu_helper.c                 |  84 +--
 target/loongarch/csr.c                        | 112 ++--
 target/loongarch/csr.h                        |   6 +-
 target/loongarch/disas.c                      |  15 +
 target/loongarch/insns.decode                 |  14 +
 target/loongarch/internals.h                  |  10 +-
 target/loongarch/machine.c                    | 111 +++-
 target/loongarch/tcg/constant_timer.c         |  67 ++-
 target/loongarch/tcg/csr_helper.c             | 224 +++++++-
 target/loongarch/tcg/helper.h                 |  36 +-
 .../tcg/insn_trans/trans_extra.c.inc          |   2 +-
 .../tcg/insn_trans/trans_privileged.c.inc     | 388 +++++++++++---
 target/loongarch/tcg/op_helper.c              |  22 +
 target/loongarch/tcg/tcg_cpu.c                |  82 ++-
 target/loongarch/tcg/tcg_loongarch.h          |   3 +-
 target/loongarch/tcg/tlb_helper.c             | 498 ++++++++++++------
 target/loongarch/tcg/translate.c              |   6 +-
 target/loongarch/translate.h                  |   2 +
 23 files changed, 1588 insertions(+), 487 deletions(-)

-- 
2.55.0


