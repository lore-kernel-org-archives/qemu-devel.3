Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9F6FD3760
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 15:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGNA-0001JU-7n; Wed, 25 Feb 2026 10:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guix@demindiro.com>)
 id 1vvGMj-00010A-Ox
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:59:54 -0500
Received: from mail.salt-inc.org ([104.244.79.104] helo=vm0.salt-inc.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guix@demindiro.com>)
 id 1vvGMd-0008MX-3T
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:59:50 -0500
Received: from localhost (209.60-130-109.adsl-dyn.isp.belgacom.be
 [109.130.60.209])
 by vm0.salt-inc.org (Postfix) with ESMTPSA id EB14CFF028;
 Wed, 25 Feb 2026 15:58:32 +0100 (CET)
From: David Hoppenbrouwers <qemu@demindiro.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 David Hoppenbrouwers <qemu@demindiro.com>
Subject: [PATCH 1/2] hw/i386/amd_iommu.c: trace page walk in fetch_pte()
Date: Wed, 25 Feb 2026 15:58:30 +0100
Message-ID: <20260225145831.28275-2-qemu@demindiro.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225145831.28275-1-qemu@demindiro.com>
References: <20260225145831.28275-1-qemu@demindiro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.244.79.104; envelope-from=guix@demindiro.com;
 helo=vm0.salt-inc.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

This is necessary to demonstrate the issue in the next commit.
It is also useful when developing drivers.

Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
---
 hw/i386/amd_iommu.c  | 8 ++++++++
 hw/i386/trace-events | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2..29999fd776 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -667,6 +667,8 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
     uint8_t level, mode;
     uint64_t pte_addr;
 
+    trace_amdvi_fetch_pte_translate(address);
+
     *pte = dte;
     *page_size = 0;
 
@@ -691,7 +693,11 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
         return -AMDVI_FR_PT_ROOT_INV;
     }
 
+    trace_amdvi_fetch_pte_root(level, *pte);
+
     do {
+        trace_amdvi_fetch_pte_walk(level, *pte, PTE_NEXT_LEVEL(*pte), *page_size);
+
         level -= 1;
 
         /* Update the page_size */
@@ -750,6 +756,8 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
         *page_size = large_pte_page_size(*pte);
     }
 
+    trace_amdvi_fetch_pte_found(level, *pte, PTE_NEXT_LEVEL(*pte), *page_size);
+
     return 0;
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5fa5e93b68..5e7d7ba30d 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -118,6 +118,10 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
 amdvi_ir_target_abort(const char *str) "%s"
 amdvi_ir_delivery_mode(const char *str) "%s"
 amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
+amdvi_fetch_pte_translate(uint64_t address) "0x%016"PRIx64
+amdvi_fetch_pte_root(uint8_t level, uint64_t pte) "level=%d pte=%016"PRIx64
+amdvi_fetch_pte_walk(uint8_t level, uint64_t pte, uint8_t nextlevel, uint64_t page_size) "level=%d pte=%016"PRIx64" NextLevel=%d page_size=0x%"PRIx64
+amdvi_fetch_pte_found(uint8_t level, uint64_t pte, uint8_t nextlevel, uint64_t page_size) "level=%d pte=%016"PRIx64" NextLevel=%d page_size=0x%"PRIx64
 
 # vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
-- 
2.52.0


