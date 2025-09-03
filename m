Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B4FCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utjAW-0003J5-G4; Wed, 03 Sep 2025 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utjAT-0003Ht-9k
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:48:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utjAQ-0007Mk-8n
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:48:36 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxP9PdALhoGScGAA--.12554S3;
 Wed, 03 Sep 2025 16:48:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMHcALhoc916AA--.5293S2;
 Wed, 03 Sep 2025 16:48:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] target/loongarch: Small enhancement about TLB flush
Date: Wed,  3 Sep 2025 16:48:15 +0800
Message-Id: <20250903084827.3085911-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMHcALhoc916AA--.5293S2
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

This patch set is continuous MMU enhancement, it is focused on TLB
search, especially on function helper_invtlb_page_asid() and function
helper_invtlb_page_asid_or_g(). The code is similiar with function
loongarch_tlb_search(), one common API loongarch_tlb_search_cb() is
added for these functions.

Also there is optimization with qemu TLB flush, invalidate_tlb_entry()
is used to flush one TLB entry rather than flush all TLB entries.
---
v2 ... v3:
  1. Remove optimization to flush QEMU TLB with MMU_USER_IDX, now both
     MMU_KERNEL_IDX and MMU_USER_IDX bitmap is added.
  2. Add field RESERVE with register CSR_STLBPS, field RESERVE keeps
     zero when change register CSR_STLBPS.

v1 ... v2:
  1. Add bugfix patch with CSR_STLBPS page size set issue.
  2. Add tlb entry invalidation in function invalidate_tlb(), it can be
     used in both helper_invtlb_page_asid() and function
     helper_invtlb_page_asid_or_g().
---
Bibo Mao (12):
  target/loongarch: Use mmu idx bitmap method when flush TLB
  target/loongarch: Add parameter tlb pointer with fill_tlb_entry
  target/loongarch: Reduce TLB flush with helper_tlbwr
  target/loongarch: Update TLB index selection method
  target/loongarch: Fix page size set issue with CSR_STLBPS
  target/loongarch: Add tlb search callback in loongarch_tlb_search()
  target/loongarch: Add common API loongarch_tlb_search_cb()
  target/loongarch: Use loongarch_tlb_search_cb in
    helper_invtlb_page_asid_or_g
  target/loongarch: Use loongarch_tlb_search_cb in
    helper_invtlb_page_asid
  target/loongarch: Invalid tlb entry in invalidate_tlb()
  target/loongarch: Only flush one TLB entry in
    helper_invtlb_page_asid_or_g()
  target/loongarch: Only flush one TLB entry in
    helper_invtlb_page_asid()

 target/loongarch/cpu-csr.h        |   1 +
 target/loongarch/tcg/csr_helper.c |   5 +-
 target/loongarch/tcg/tlb_helper.c | 197 +++++++++++++++++++-----------
 3 files changed, 132 insertions(+), 71 deletions(-)


base-commit: 8415b0619f65bff12f10c774659df92d3f61daca
-- 
2.39.3


