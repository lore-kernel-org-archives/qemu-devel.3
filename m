Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E64C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPqO-0001NW-6t; Mon, 29 Jul 2024 08:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=933d9f320=ugurus@amazon.co.uk>)
 id 1sYOHd-0003Ox-05
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:11:17 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=933d9f320=ugurus@amazon.co.uk>)
 id 1sYOHW-0002iX-GV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1722251470; x=1753787470;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e8AhwAgHgJ8e9YhGN+PjFVwuMXkBBjHFltbhLuhbi9k=;
 b=V5ddnO+PYrELhUZTp0oQyKqFKY0LKJf9KnRajDxptqFI1BP+31Jus7m0
 IjtyaZaf7hfo7vhgAPbgWfllN0CvSkAWmrylnAzbJiRdTKDP1+hDtf8Vl
 xRbXW8GcxClJ64VzzVnllkV7wLAs6FeQflomc5V2/9pYFhJHw7WgREn0s w=;
X-IronPort-AV: E=Sophos;i="6.09,245,1716249600"; d="scan'208";a="417953085"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 11:11:06 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:61509]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.132:2525]
 with esmtp (Farcaster)
 id 4217380c-5dc7-45ae-9dc4-c6431998d765; Mon, 29 Jul 2024 11:11:04 +0000 (UTC)
X-Farcaster-Flow-ID: 4217380c-5dc7-45ae-9dc4-c6431998d765
Received: from EX19D034EUB002.ant.amazon.com (10.252.61.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 11:11:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D034EUB002.ant.amazon.com (10.252.61.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 11:11:01 +0000
Received: from dev-dsk-ugurus-1a-50a05e10.eu-west-1.amazon.com (172.19.127.99)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server
 (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Mon, 29 Jul 2024 11:11:00 +0000
From: Ugur Usug <ugurus@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, Ugur Usug
 <ugurus@amazon.com>
Subject: [PATCH] hw/i386/amd_iommu: Do not depend on any pci cap ordering
Date: Mon, 29 Jul 2024 11:10:18 +0000
Message-ID: <20240729111018.87536-1-ugurus@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=72.21.196.25;
 envelope-from=prvs=933d9f320=ugurus@amazon.co.uk; helo=smtp-fw-2101.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jul 2024 08:51:15 -0400
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

Currently, pci capabilities are inserted in the reverse order
capabilities are added (see 'pci_add_capability'). amd_iommu hardware
pci realization depends on this implicitly. It assumes that the first
capability added will be the last one (at the tail) and its respective
'PCI_CAP_LIST_NEXT' is zero. This is implicit in 'AMDVI_CAPAB_FEATURES'
in which the next pointer is assumed as zero. However, this assumption
can be both fragile for any update in the future and not easy to spot or
understand.

Given that the PCI spec. has no specific rule for ordering of
capabilities, with this commit we don't assume anything related with the
ordering in pci subsystem and treat feature flag (upper 16-bits portion)
of the capability header separately.

Signed-off-by: Ugur Usug <ugurus@amazon.com>
---
 hw/i386/amd_iommu.c |  3 ++-
 hw/i386/amd_iommu.h | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6d4fde72f9b..791c4edc704 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1558,7 +1558,8 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
     pci_config_set_prog_interface(pdev->config, 0);
 
     /* reset AMDVI specific capabilities, all r/o */
-    pci_set_long(pdev->config + s->capab_offset, AMDVI_CAPAB_FEATURES);
+    pci_set_word(pdev->config + s->capab_offset + AMDVI_CAPAB_FEAT_REG,
+                 AMDVI_CAPAB_FEATURES);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_LOW,
                  AMDVI_BASE_ADDR & ~(0xffff0000));
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_HIGH,
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 73619fe9eaa..513c8f7a9cf 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -26,6 +26,7 @@
 #include "qom/object.h"
 
 /* Capability registers */
+#define AMDVI_CAPAB_FEAT_REG          0x02
 #define AMDVI_CAPAB_BAR_LOW           0x04
 #define AMDVI_CAPAB_BAR_HIGH          0x08
 #define AMDVI_CAPAB_RANGE             0x0C
@@ -34,14 +35,17 @@
 #define AMDVI_CAPAB_SIZE              0x18
 #define AMDVI_CAPAB_REG_SIZE          0x04
 
-/* Capability header data */
+/*
+ * Capability header data which covers the capability id and the feature
+ * flags reside at upper 16-bits portion of the header.
+ */
 #define AMDVI_CAPAB_ID_SEC            0xf
-#define AMDVI_CAPAB_FLAT_EXT          (1 << 28)
-#define AMDVI_CAPAB_EFR_SUP           (1 << 27)
-#define AMDVI_CAPAB_FLAG_NPCACHE      (1 << 26)
-#define AMDVI_CAPAB_FLAG_HTTUNNEL     (1 << 25)
-#define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
-#define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
+#define AMDVI_CAPAB_FLAT_EXT          (1 << 12)
+#define AMDVI_CAPAB_EFR_SUP           (1 << 11)
+#define AMDVI_CAPAB_FLAG_NPCACHE      (1 << 10)
+#define AMDVI_CAPAB_FLAG_HTTUNNEL     (1 << 9)
+#define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 8)
+#define AMDVI_CAPAB_INIT_TYPE         (3 << 0)
 
 /* No. of used MMIO registers */
 #define AMDVI_MMIO_REGS_HIGH  7
@@ -183,8 +187,8 @@
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
         AMDVI_CAPAB_FLAG_NPCACHE | AMDVI_CAPAB_FLAG_IOTLBSUP \
-        | AMDVI_CAPAB_ID_SEC | AMDVI_CAPAB_INIT_TYPE | \
-        AMDVI_CAPAB_FLAG_HTTUNNEL |  AMDVI_CAPAB_EFR_SUP)
+        | AMDVI_CAPAB_INIT_TYPE | AMDVI_CAPAB_FLAG_HTTUNNEL \
+        | AMDVI_CAPAB_EFR_SUP)
 
 /* AMDVI default address */
 #define AMDVI_BASE_ADDR 0xfed80000
-- 
2.40.1


