Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB53606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iqY/F0Sv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3HN-0004UE-2z; Mon, 16 Nov 2026 15:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HJ-0004Ax-Iz; Mon, 16 Nov 2026 15:26:13 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HH-0006U9-Ar; Mon, 16 Nov 2026 15:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=qGjseEVC48CZ/nboZ7wB2TVfVaNl+47s32xqISzzbsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iqY/F0SvO/JAQXgjclA7G7G9n0pPQrizUQFhtuQmLsOEGiVzQBX3he84+0/nyUFxB
 OrUkcRiyaD2cJXneM/IkoSMeDIebekr0SQXxKnwrpkcrvEB2L272hUZViCsW8q+jOz
 Leiep4mLYx32oUvIeBKrA/NqylBI1qdpkHOH3RhKySNbUFmJt5zFk/WI66muJ2CYUn
 c45zLLt/ElCIiAbnkn9HWiUYL3XsFSp0jKdCZ9LVHbcqf6siv5lzVFfAcFUVfbZgVf
 K6XZa53zv6dtOUZOUvPdQdMFN6A7FOaxVpyQW6R+/bGnl2XYv2FSMvrJhJCBJ5XdNW
 yfiTRLdGfQsaA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9101D1E7199;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8DE2445FBC5;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 74869B8E4E; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Omar Elghoul <oelghoul@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 04/63] s390x/pci: reclaim DMA slots upon IOMMU disable
Date: Mon, 16 Nov 2026 23:24:43 +0300
Message-ID: <20261116202554.535325-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Omar Elghoul <oelghoul@linux.ibm.com>

s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
mappings, but it doesn't account for reclaiming the freed DMA slots.
This is problematic when an IOMMU is disabled and re-enabled while
reusing the container (e.g. during a guest reboot), which may cause the
RPCIT path to fail with DMA slots exhaustion errors, manifesting as
unexplained ENOMEMs in the guest.

Fix it by reclaiming all the entries in the I/O TLB's hash table before
removing all its entries. The actual DMA slots consumed by the IOMMU are
already relinquished to vfio when the memory subregion is deleted in the
same function.

Cc: qemu-stable@nongnu.org
Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261021175031.23840-1-oelghoul@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 24f4453789bd0fe4339e659e5ab25210e79ca0c0)
(Mjt: back-port across v11.1.0-2159-gf2cb275ea968
 "s390x/pci: Move dm_mr from S390PCIIOMMU to S390PCIBusDevie")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eff980fdfe9..2bb87f731b1 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -763,6 +763,14 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
     iommu->enabled = false;
+    if (iommu->dma_limit) {
+        /*
+         * Account for all the DMA mappings still in the IOTLB; they will be
+         * returned to vfio when we delete the memory subregion via
+         * memory_region_del_subregion() below.
+         */
+        iommu->dma_limit->avail += g_hash_table_size(iommu->iotlb);
+    }
     g_hash_table_remove_all(iommu->iotlb);
     if (iommu->dm_mr) {
         memory_region_del_subregion(&iommu->mr, iommu->dm_mr);
-- 
2.47.3


