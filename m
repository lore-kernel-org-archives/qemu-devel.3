Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9285C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjJU-0001gY-Qw; Sun, 27 Sep 2026 03:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHj-000059-13; Sun, 27 Sep 2026 03:26:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHh-0005QN-BC; Sun, 27 Sep 2026 03:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494004; bh=wTVeNoCYDQruGaNMEHnKe2Ex8IhHVUmQdGlEFZMTM0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kWyVb4ATJ1sK/8hulgKDmkdGys7c4pujmqEe+D4K2BFX9RhFIC7dEMqalPsrC5tVg
 wx127VAyZ8dKAJ9cfDqDMflpAariyEx9RLsZFeOBe8hx1ig4rZ8Q3H9j5mJR0V6Bfo
 e1+mcW2KpY5yRCxOvCDjJ7489+3OZZNGz3z6K/j94Q6HBPkStwAf/riZteJG7NvV9Y
 Jq7hi2HSVdlAdkl5Pc1ztEnBaqyeuUAq2vmPeihyGFubNeS1L8xsuMVj5pYRrbSAt6
 OSzCm1gDMKK2eTjoF+Wfi2ZtGClI/DAcPKu7VOre9JcYuFcz0TIm1gEQiUWNnCEnF+
 ucT8XTMDUR4ig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C8EAB1D8AB9;
 Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C644F43204B;
 Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 626AC5E621; Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Omar Elghoul <oelghoul@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 55/72] s390x/pci: fix DMA slot leak on I/O TLB
 entry replacement
Date: Sun, 27 Sep 2026 10:25:47 +0300
Message-ID: <20260927072622.93656-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Omar Elghoul <oelghoul@linux.ibm.com>

When s390_pci_update_iotlb() does a mapping update for an IOVA that has
an already-existing TLB entry with different permissions or translated
address, it unmaps then remaps it. However, at the end of the map path,
it unconditionally decrements the available DMA slot counter without a
corresponding increment in the intermediate unmap branch.

This causes the DMA slot count to be decremented on every remapping of
an active IOVA, leading to a permanent DMA slot leak. This remapping
without a prior invalidation and sync is not seen today in well-behaved
guests but is allowed by the architecture. Fix it by only decrementing
available DMA slots when inserting a brand new mapping.

Cc: qemu-stable@nongnu.org
Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260917140431.45343-1-oelghoul@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 9b64b3cc833eaec290e65bc0958aeb51c6892152)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 3513a93b9d1..d9eb9c9efa0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -653,6 +653,7 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
         goto out;
     } else {
         if (cache) {
+            /* valid->valid transitions reuse the DMA slot */
             if (cache->perm == entry->perm &&
                 cache->translated_addr == entry->translated_addr) {
                 goto out;
@@ -663,6 +664,9 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
             memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
             event.type = IOMMU_NOTIFIER_MAP;
             event.entry.perm = entry->perm;
+        } else {
+            /* invalid->valid transitions consume a new DMA slot */
+            dec_dma_avail(iommu);
         }
 
         cache = g_new(S390IOTLBEntry, 1);
@@ -671,7 +675,6 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
         g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
-        dec_dma_avail(iommu);
     }
 
     /*
-- 
2.47.3


