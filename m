Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B0ACCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXP5-0000NZ-4q; Wed, 22 Oct 2025 07:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vBXOt-0000N5-Gv; Wed, 22 Oct 2025 07:53:08 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vBXOl-0003wI-Jy; Wed, 22 Oct 2025 07:53:06 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id D7B9A1A0002;
 Wed, 22 Oct 2025 11:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com D7B9A1A0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1761133972; bh=48uiUuIA3hPr5jwoWkHueLUx8bqmxbk944pCbWvQkeU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=JoSljbcLw7w28s+2w1OxvRDZglBz/6nuDVDZLlMp0cqVhZyi1Axq1QLtUPn8IFD1c
 FyZXhUJZQDWakGwqVe2XXCrhFQeck62C+K6229Se0u/KaCloJe3sctd84bc3JAQAZy
 HxdJw7CXrYinpT0y8NJPAMNeTPE9ZfAKgAMwzzzQycq9FynQlrBDkuf3OirSERmDZi
 1EBWc+9HyLcMxdxU73CbeXuvvicBmzzpalwYhGAX/40A0zWzFEz2sPKvkXK3uFqbdL
 HCSUdbIQj1h9JYu6PW89Dh11xPl5KcTaHA03vIqZNdPD7hIJN3ANaixHWtFAu+sU5w
 B4E3HMKUIUrkg==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Wed, 22 Oct 2025 11:52:52 +0000 (UTC)
Received: from mail.syntacore.com (172.17.58.29) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 14:52:29 +0300
From: Nikita Novikov <n.novikov@syntacore.com>
To: <richard.henderson@linaro.org>
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 Nikita Novikov <n.novikov@syntacore.com>
Subject: [PATCH] accel/tcg: Pass actual memop_size to tlb_fill instead of 0
Date: Wed, 22 Oct 2025 14:52:13 +0300
Message-ID: <20251022115213.91457-1-n.novikov@syntacore.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.58.29]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/10/22 06:57:00 #27791190
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=n.novikov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Recent debugging of misaligned access handling on RISC-V revealed that we
always call `tlb_fill` with `memop_size == 0`. This behavior effectively
disables natural alignment checks in `riscv_tlb_fill_align()`, because we
have to fall back from `memop_size` to `size` when computing the alignment bits.

With `memop_size == 0`, misaligned cross-page stores end up reported as
`store access fault` (AF, cause=7) instead of the expected
`store page fault` (PF, cause=15), since the “misalign” path triggers before
the second page translation can fault. This breaks misaligned accesses at
page boundaries.

After switching to pass the real `l->memop` into `tlb_fill`, the cross-page
faults are no longer mis-classified as AF.

Fixes: ec03dd972378 ("accel/tcg: Hoist first page lookup above pointer_wrap")

Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 631f1fe135..271c061be1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1782,7 +1782,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
          * If the lookup potentially resized the table, refresh the
          * first CPUTLBEntryFull pointer.
          */
-        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
+        if (mmu_lookup1(cpu, &l->page[1], l->memop, l->mmu_idx, type, ra)) {
             uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
             l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
         }
-- 
2.51.0


