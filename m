Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E38C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua97O-0004vi-8M; Fri, 11 Jul 2025 04:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8y8-0005aU-N5; Fri, 11 Jul 2025 04:18:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8y2-00045H-46; Fri, 11 Jul 2025 04:18:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C6FC1356D9;
 Fri, 11 Jul 2025 11:17:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 03BF023FA4E;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sairaj Kodilkar <sarunkod@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 14/39] hw/i386/amd_iommu: Fix device setup failure
 when PT is on.
Date: Fri, 11 Jul 2025 11:16:10 +0300
Message-ID: <20250711081745.1785806-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Commit c1f46999ef506 ("amd_iommu: Add support for pass though mode")
introduces the support for "pt" flag by enabling nodma memory when
"pt=off". This allowed VFIO devices to successfully register notifiers
by using nodma region.

But, This also broke things when guest is booted with the iommu=nopt
because, devices bypass the IOMMU and use untranslated addresses (IOVA) to
perform DMA reads/writes to the nodma memory region, ultimately resulting in
a failure to setup the devices in the guest.

Fix the above issue by always enabling the amdvi_dev_as->iommu memory region.
But this will once again cause VFIO devices to fail while registering the
notifiers with AMD IOMMU memory region.

Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250516100535.4980-2-sarunkod@amd.com>
Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
(cherry picked from commit 31753d5a336fbb4e9246397f4b90b6f611f27f22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5f9b952799..df8ba5d39a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        if (!x86_iommu->pt_supported) {
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      true);
-        } else {
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      false);
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
-        }
+        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
     }
     return &iommu_as[devfn]->as;
 }
-- 
2.47.2


