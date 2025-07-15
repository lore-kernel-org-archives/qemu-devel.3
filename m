Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9CCC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfRT-0006fL-2V; Tue, 15 Jul 2025 09:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ubaE0-000568-0f; Tue, 15 Jul 2025 03:37:16 -0400
Received: from [115.124.28.131] (helo=out28-131.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ubaDw-0007MN-T7; Tue, 15 Jul 2025 03:37:15 -0400
Received: from aliyun.com(mailfrom:zhangzhijie@bosc.ac.cn
 fp:SMTPD_---.dnDqMsY_1752564773 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 15 Jul 2025 15:32:54 +0800
From: zhangzhijie <zhangzhijie@bosc.ac.cn>
To: zhangzhijie@bosc.ac.cn, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
 peter.maydell@linaro.org, andrew.smirnov@gmail.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v1] hw/pci-host/designware: Support 64Bit resource for
 DesignwarePCIEHost
Date: Tue, 15 Jul 2025 15:32:51 +0800
Message-Id: <20250715073251.2376473-1-zhangzhijie@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.131 (deferred)
Received-SPF: pass client-ip=115.124.28.131;
 envelope-from=zhangzhijie@bosc.ac.cn; helo=out28-131.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Jul 2025 09:08:55 -0400
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

0. DW pcie support 64bit resource
1. DW version type using Linux kernel

Signed-off-by: zhangzhijie <zhangzhijie@bosc.ac.cn>
---
 hw/pci-host/designware.c         | 12 +++++++++---
 include/hw/pci-host/designware.h |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f6e49ce9b8..99d791c0a7 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -41,6 +41,8 @@
 #define DESIGNWARE_PCIE_MSI_INTR0_ENABLE           0x828
 #define DESIGNWARE_PCIE_MSI_INTR0_MASK             0x82C
 #define DESIGNWARE_PCIE_MSI_INTR0_STATUS           0x830
+#define PCIE_VERSION_NUMBER                        0x8F8
+#define PCIE_VERSION_TYPE                          0x8FC
 #define DESIGNWARE_PCIE_ATU_VIEWPORT               0x900
 #define DESIGNWARE_PCIE_ATU_REGION_INBOUND         BIT(31)
 #define DESIGNWARE_PCIE_ATU_CR1                    0x904
@@ -144,6 +146,10 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
     uint32_t val;
 
     switch (address) {
+    case PCIE_VERSION_NUMBER:
+    case PCIE_VERSION_TYPE:
+        val = 0x3534302a;
+        break;
     case DESIGNWARE_PCIE_PORT_LINK_CONTROL:
         /*
          * Linux guest uses this register only to configure number of
@@ -427,7 +433,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->inbound = true;
         viewport->base    = 0x0000000000000000ULL;
         viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
+        viewport->limit   = UINT64_MAX;
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
         source      = &host->pci.address_space_root;
@@ -451,7 +457,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->inbound = false;
         viewport->base    = 0x0000000000000000ULL;
         viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
+        viewport->limit   = UINT64_MAX;
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
         destination = &host->pci.memory;
@@ -558,7 +564,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, DesignwarePCIEViewport),
         VMSTATE_UINT64(target, DesignwarePCIEViewport),
-        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
+        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
         VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
         VMSTATE_END_OF_LIST()
     }
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index a35a3bd06c..6e06f54801 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -46,7 +46,7 @@ typedef struct DesignwarePCIEViewport {
 
     uint64_t base;
     uint64_t target;
-    uint32_t limit;
+    uint64_t limit;
     uint32_t cr[2];
 
     bool inbound;
-- 
2.34.1


