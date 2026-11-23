Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615B606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTbO-0003ZB-RZ; Mon, 23 Nov 2026 07:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <muratseker@muratseker-mac.localdomain>)
 id 1xVKDe-0007IC-Oh
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:55:50 -0500
Received: from dals-20-b2-v4wan-168472-cust668.vm1.cable.virginm.net
 ([82.45.50.157] helo=muratseker-mac.localdomain)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muratseker@muratseker-mac.localdomain>)
 id 1xVKDW-0003o6-SH
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:55:50 -0500
Received: by muratseker-mac.localdomain (Postfix, from userid 501)
 id 376097E5DE1A; Mon, 23 Nov 2026 02:46:46 +0000 (GMT)
From: Murat Seker <muratseker@meta.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 Murat Seker <m.seker@aol.com>
Subject: [PATCH] accel/tcg: Skip clean MMU modes when resetting TLB dirty flags
Date: Mon, 23 Nov 2026 02:46:46 +0000
Message-ID: <20261123024646.98261-1-muratseker@meta.com>
X-Mailer: git-send-email 2.53.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=82.45.50.157;
 envelope-from=muratseker@muratseker-mac.localdomain;
 helo=muratseker-mac.localdomain
X-Spam_score_int: 61
X-Spam_score: 6.1
X-Spam_bar: ++++++
X-Spam_report: (6.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, KHOP_HELO_FCRDNS=0.4,
 NO_DNS_FOR_FROM=0.001, PDS_RDNS_DYNAMIC_FP=0.01, RCVD_IN_PBL=3.335,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TO_NO_BRKTS_DYNIP=3.026 autolearn=no autolearn_force=no
X-Spam_action: reject
X-Mailman-Approved-At: Mon, 23 Nov 2026 07:56:42 -0500
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Murat Seker <m.seker@aol.com>

tlb_reset_dirty() scans every MMU mode, including modes whose TLBs
contain no entries. These scans waste work while holding the TLB lock.

Use the dirty MMU bitmap to scan only modes that may contain entries.
A clear bit indicates an empty TLB, so skipping those modes preserves
the dirty flag reset behavior and reduces time spent under the lock.

Signed-off-by: Murat Seker <m.seker@aol.com>
---
 accel/tcg/cputlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d79eae58df..2ad8983151 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -883,10 +883,15 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
  */
 void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 {
-    int mmu_idx;
+    MMUIdxMap work;
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+    /*
+     * An mmu_idx that is clean in c.dirty has been flushed and holds no
+     * entries, so only the dirty ones need scanning.
+     */
+    for (work = cpu->neg.tlb.c.dirty; work != 0; work &= work - 1) {
+        int mmu_idx = ctz32(work);
         CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
         CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
         unsigned int n = tlb_n_entries(fast);
-- 
2.53.1-Meta


