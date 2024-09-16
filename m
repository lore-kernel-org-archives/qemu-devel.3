Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416DBC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFge-00046W-Sg; Mon, 16 Sep 2024 13:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFga-0003mZ-5q
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:38:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFgX-0003dS-LW
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:38:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sVM0t5Hz6K9FB;
 Tue, 17 Sep 2024 01:34:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4D72C140F1C;
 Tue, 17 Sep 2024 01:38:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:38:44 +0200
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
 <fan.ni@samsung.com>
Subject: [PATCH 6/6] hw/pci-bridge/cxl-upstream: Add properties to control
 link speed and width
Date: Mon, 16 Sep 2024 18:35:18 +0100
Message-ID: <20240916173518.1843023-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To establish performance characteristics of a CXL device when used via a
particular CXL topology (root ports, switches, end points) it is necessary
to set the appropriate link speed and width in the PCI Express capability
structure.  Provide x-speed and x-link properties for this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci-bridge/cxl_upstream_port.h | 4 ++++
 hw/pci-bridge/cxl_upstream.c              | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index 12635139f6..f208397ffe 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -12,6 +12,10 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     CXLCCI swcci;
+
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+
     DOECap doe_cdat;
     uint64_t sn;
 } CXLUpstreamPort;
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a5a39cc524..55f8b0053f 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
@@ -100,6 +101,7 @@ static void cxl_usp_reset(DeviceState *qdev)
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
     latch_registers(usp);
 }
 
@@ -363,6 +365,10 @@ static void cxl_usp_exitfn(PCIDevice *d)
 static Property cxl_upstream_props[] = {
     DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLUpstreamPort,
+                                speed, PCIE_LINK_SPEED_32),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
+                                width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0


