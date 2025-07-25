Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D241C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7PT-00020p-Hq; Thu, 24 Jul 2025 21:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7Nf-0000gw-BQ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7Nc-0002Z5-B2
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxC3Lk34JofpAxAQ--.34226S3;
 Fri, 25 Jul 2025 09:37:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxdOTk34Joz5wlAA--.62171S2;
 Fri, 25 Jul 2025 09:37:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 00/17] target/loongarch: Enhancement about tcg mmu
Date: Fri, 25 Jul 2025 09:37:22 +0800
Message-Id: <20250725013739.994437-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOTk34Joz5wlAA--.62171S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There is some enhance about LoongArch mmu tcg emulation, add new
header file cpu-mmu.h and function loongarch_check_pte(). Function
loongarch_check_pte() can work on both TLB entry and pte entry.

This patchset mainly is code cleanup and enhancement, its main
purpose is to work for hardware page table walk emluation in future.
---
v2 ... v3:
  1. Track user space page accessed in kernel mode, since mmu idx usage
     is different between QEMU TLB and LoongArch TLB emulation.
  2. Add 48 bit to 64 bit signed extension conversion with virtual address,
     since QEMU TLB use 64 bit address, LoongArch TLB is 48 bit.
  3. Optimization with LoongArch TLB update, do not flush QEMU TLB if
     updated TLB entry is the same or invalid.
  4. Optimization with new LoongArch TLB entry selection, invalid entry
     or different ASID with higher priority than the random method.
v1 ... v2:
  1. Rename structure name pte_context with mmu_context, since it
     can be extended to get DMW or DA mmu idx and window size
  2. Add fine-grained tlb flush method
  3. Fix some issues in function invalidate_tlb_entry() to flush tlb,
     such as bitmap method with mmu idx, page size and address
     calculation
---
Bibo Mao (17):
  target/loongarch: Move some function definition to kvm directory
  target/loongarch: Define function loongarch_cpu_post_init as static
  target/loongarch: Set page size in TLB misc with STLB
  target/loongarch: Add header file cpu-mmu.h
  target/loongarch: Add common function loongarch_check_pte()
  target/loongarch: Use loongarch_check_pte() with page table walking
  target/loongarch: Add parameter mmu_context with
    loongarch_page_table_walker
  target/loongarch: Add parameter mmu_context with
    loongarch_map_tlb_entry
  target/loongarch: Add parameter mmu_context with
    loongarch_get_addr_from_tlb
  target/loongarch: Add parameter mmu_context with loongarch_map_address
  target/loongarch: Add parameter mmu_context with get_physical_address
  target/loongarch: Track user mode address accessed in kernel mode
  target/loongarch: Use correct address when flush tlb
  target/loongarch: Use mmu idx bitmap method when flush tlb
  target/loongarch: Add parameter tlb pointer with fill_tlb_entry
  target/loongarch: Reduce TLB flush with helper_tlbwr
  target/loongarch: Update TLB index selection method

 hw/loongarch/virt.c                  |   1 +
 target/loongarch/cpu-mmu.h           |  41 ++++
 target/loongarch/cpu.c               | 181 +++++++++---------
 target/loongarch/cpu.h               |  22 +--
 target/loongarch/cpu_helper.c        | 131 ++++++++-----
 target/loongarch/internals.h         |  20 --
 target/loongarch/kvm/kvm_loongarch.h |   4 +-
 target/loongarch/tcg/csr_helper.c    |   1 +
 target/loongarch/tcg/tcg_loongarch.h |   4 +-
 target/loongarch/tcg/tlb_helper.c    | 272 ++++++++++++++++-----------
 10 files changed, 395 insertions(+), 282 deletions(-)
 create mode 100644 target/loongarch/cpu-mmu.h


base-commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb
-- 
2.39.3


