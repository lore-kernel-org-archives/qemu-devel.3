Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399CED16252
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0K6E-0007ML-GH; Mon, 14 Oct 2024 08:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0K60-0007KB-Ev
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:22:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0K5y-0001rv-Un
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:22:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRxDx3XwGz6K9L5;
 Mon, 14 Oct 2024 20:22:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 304ED140445;
 Mon, 14 Oct 2024 20:22:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:22:40 +0200
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
 <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 7/7] hw/pci-bridge: Make pxb_dev_realize_common() return
 if it succeeded
Date: Mon, 14 Oct 2024 13:19:02 +0100
Message-ID: <20241014121902.2146424-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
References: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For the CXL PXB there is additional code after pxb_dev_realize_common()
is called.  If that realize failed (e.g. due to an out of range numa_node)
we will get a segfault.  Return a bool so the caller can check if the
pxb_dev_realize_common() succeeded or not without having to poke around
in the errp.

Fixes: 4f8db8711cbd ("hw/pxb: Allow creation of a CXL PXB (host bridge)")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 4578e03024..07d411cff5 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -330,7 +330,7 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
            0;
 }
 
-static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
                                    Error **errp)
 {
     PXBDev *pxb = PXB_DEV(dev);
@@ -342,13 +342,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
 
     if (ms->numa_state == NULL) {
         error_setg(errp, "NUMA is not supported by this machine-type");
-        return;
+        return false;
     }
 
     if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
         pxb->numa_node >= ms->numa_state->num_nodes) {
         error_setg(errp, "Illegal numa node %d", pxb->numa_node);
-        return;
+        return false;
     }
 
     if (dev->qdev.id && *dev->qdev.id) {
@@ -394,12 +394,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
     pci_config_set_class(dev->config, PCI_CLASS_BRIDGE_HOST);
 
     pxb_dev_list = g_list_insert_sorted(pxb_dev_list, pxb, pxb_compare);
-    return;
+    return true;
 
 err_register_bus:
     object_unref(OBJECT(bds));
     object_unparent(OBJECT(bus));
     object_unref(OBJECT(ds));
+    return false;
 }
 
 static void pxb_dev_realize(PCIDevice *dev, Error **errp)
@@ -500,7 +501,9 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pxb_dev_realize_common(dev, CXL, errp);
+    if (!pxb_dev_realize_common(dev, CXL, errp)) {
+        return;
+    }
     pxb_cxl_dev_reset(DEVICE(dev));
 }
 
-- 
2.43.0


