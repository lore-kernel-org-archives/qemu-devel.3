Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92961CCA46F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RR1-0000wL-Oh; Mon, 29 Sep 2025 23:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RQy-0000vM-Kc
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RQq-0001pe-P8
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:48 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_tI9VNtot2sQAA--.34566S3;
 Tue, 30 Sep 2025 11:53:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S2;
 Tue, 30 Sep 2025 11:53:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 00/13] target/loongarch: Add hardware page table walk
 support
Date: Tue, 30 Sep 2025 11:53:19 +0800
Message-Id: <20250930035332.2609520-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S2
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hardware page table walk (PTW for short) is one feature supported in
Loongson 3C6000 system. With hardware PTW supported, if there is an TLB
miss, hardware will take PTW and fill it in TLB if matched, report TLB
exception if not matched.

With hardware PTW supported, bit Present and Write in pte entry is HW bit.
Bit Present means that the page is valid, and bit Write means that the
page is writable. At the same time HW will set bit Valid with read access,
bit Dirty will be set with write access.
---
v3 ... v4:
  1. Rebase the patch on the latest version.
  2. Set PTW feature disabled on LA464 CPU by default, ON_OFF_AUTO_AUTO
     on max CPU type.
  3. Add field tlb_index and mmu_index when searching TLB table in new
     patch 10

v2 ... v3:
  1. Reserve high 48-63 bit PTE attribute with huge page, which is
     discard and converted to physical address wrongly.
  2. Reload PTE entry rather than restart hardware PTW if PTE entry is
    updated with other CPUs and qatomic_cmpxchg() fails.
  3. Since Huge page bit is the same with Global bit, judge huge page from
     page table level rather than Huge page bit.

v1 ... v2:
  1. Add wrapper function loongarch_cmpxchg_phys(), and use
     qatomic_cmpxchg() API to update PTW access/dirty bit.
  2. Add restart hardware PTW if qatomic_cmpxchg() fails
  3. Rename loongarch_page_table_walker() with loongarch_ptw().
  4. Add debug parameter in loongarch_ptw(), with debug mode it is to
     get physical address only. With normal mode, bit Valid and Dirty
     will be update.
---
Bibo Mao (13):
  target/loongarch: Use auto method with PTW feature
  target/loongarch: Add CSR_PWCH write helper function
  target/loongarch: Add present and write bit with pte entry
  target/loongarch: Add function sptw_prepare_tlb before adding tlb
    entry
  target/loongarch: Add common function get_tlb_random_index()
  target/loongarch: Add MMUContext parameter in fill_tlb_entry()
  target/loongarch: Add debug parameter with
    loongarch_page_table_walker()
  target/loongarch: Reserve higher 48 bit PTE attribute with huge page
  target/loongarch: Move last PTE lookup into page table walker loop
  target/loongarch: Add field tlb_index to record TLB search info
  target/loongarch: Add basic hardware PTW support
  target/loongarch: Update matched ptw bit A/D with PTW supported
  target/loongarch: Add bit A/D checking in TLB entry with PTW supported

 target/loongarch/cpu-csr.h                    |   4 +
 target/loongarch/cpu-mmu.h                    |  62 ++++++++
 target/loongarch/cpu.c                        |  25 +++
 target/loongarch/cpu.h                        |   2 +
 target/loongarch/cpu_helper.c                 | 146 +++++++++++++++---
 target/loongarch/tcg/csr_helper.c             |  15 ++
 target/loongarch/tcg/helper.h                 |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc     |   1 +
 target/loongarch/tcg/tlb_helper.c             | 127 +++++++++++----
 9 files changed, 335 insertions(+), 48 deletions(-)


base-commit: 4975b64efb5aa4248cbc3760312bbe08d6e71638
-- 
2.39.3


