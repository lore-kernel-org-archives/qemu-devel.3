Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E14C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPDJH-0008U9-EF; Wed, 03 Jul 2024 23:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPDJA-0008Nr-HO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:38:56 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPDJ8-0005Jl-1x
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1720064333; x=1751600333;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0W5mhg8hCyKpK1eNIePtBioTpvKDhGzWNYxpqDOgeZs=;
 b=Nz9hUhM2DmI0ugsI60UgLiPZmuwIkWUV5faIh/6kviE/6aNIwZOa6JfB
 FFqvwH5cAIzZimpaSYLE51kMHM9wO2wqiMAmW8pKEpr+4jaywrn2y+/S9
 r7ubosHDN20SNbUyQICeNdlYZn6AWsxTujIVKyCFWhHphVjChU5zArjsc
 KktzElZcACsN3I8Td/Mmn501StxAqSEf0FE3G5PfOTYMB6mVCjLHP/Osm
 aAcDRY8xQEDsHZhvDDoanITkV0xFqaCZWpT27kFddi5wPEWxS2Bt/7bQn
 9+ogZHBfVQKmTQF/2Nhhk627kX14JW4pxhQ1rlTSvead0IgD4zQu1a6Sk w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="153849532"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; d="scan'208";a="153849532"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 12:38:47 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6CFE6E428A
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2024 12:38:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A6F79F0F31
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2024 12:38:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3014F1EBDB3
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2024 12:38:44 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 789A21A000B;
 Thu,  4 Jul 2024 11:38:43 +0800 (CST)
To: mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH] pci-bridge: avoid linking a single downstream port more than
 once
Date: Wed,  3 Jul 2024 23:38:34 -0400
Message-Id: <20240704033834.3362-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28508.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28508.002
X-TMASE-Result: 10--5.224400-10.000000
X-TMASE-MatchedRID: 1/+HFyQe+xt6bMYbioM9qazGfgakLdjaCZa9cSpBObnAuQ0xDMaXkH4q
 tYI9sRE/1rH4Rg0AOT0G9ZKAHndbv3YueYDP2Zdtdo0n+JPFcJp9LQinZ4QefPcjNeVeWlqY+gt
 Hj7OwNO35N/S1zEq4ukauK2j86yr7R8RykkDhrDcwlma87ehZgpLB5sVlLr7G
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since the downstream port is not checked, two slots can be linked to
a single port. However, this can prevent the driver from detecting the
device properly.

It is necessary to ensure that a downstream port is not linked more than
once.

Links: https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/pci-bridge/cxl_downstream.c     | 6 ++++++
 hw/pci-bridge/pcie_root_port.c     | 6 ++++++
 hw/pci-bridge/xio3130_downstream.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 742da07a01..fa33cdb36b 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -153,6 +153,12 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
         goto err_bridge;
     }
 
+    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
+        rc = -EBUSY;
+        error_setg(errp, "Can't link port, error %d", rc);
+        goto err_msi;
+    }
+
     rc = pcie_cap_init(d, CXL_DOWNSTREAM_PORT_EXP_OFFSET,
                        PCI_EXP_TYPE_DOWNSTREAM, p->port,
                        errp);
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 09a34786bc..350137bd8c 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -89,6 +89,12 @@ static void rp_realize(PCIDevice *d, Error **errp)
         }
     }
 
+    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
+        rc = -EBUSY;
+        error_setg(errp, "Can't link port, error %d", rc);
+        goto err_int;
+    }
+
     rc = pcie_cap_init(d, rpc->exp_offset, PCI_EXP_TYPE_ROOT_PORT,
                        p->port, errp);
     if (rc < 0) {
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 907d5105b0..af04d2efad 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -88,6 +88,12 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
         goto err_msi;
     }
 
+    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
+        rc = -EBUSY;
+        error_setg(errp, "Can't link port, error %d", rc);
+        goto err_msi;
+    }
+
     rc = pcie_cap_init(d, XIO3130_EXP_OFFSET, PCI_EXP_TYPE_DOWNSTREAM,
                        p->port, errp);
     if (rc < 0) {
-- 
2.37.3


