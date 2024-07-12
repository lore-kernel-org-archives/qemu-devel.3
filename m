Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C7C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFM8-0001l2-Bz; Fri, 12 Jul 2024 08:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSFLy-0000wS-IN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:26:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSFLw-0003HT-A4
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:26:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL9ls0sR3z6JB8s;
 Fri, 12 Jul 2024 20:25:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3CF7D140B2A;
 Fri, 12 Jul 2024 20:26:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 13:26:16 +0100
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
 <fan.ni@samsung.com>
Subject: [RFC qemu 4/6] hw/pcie: Provide a utility function for control of EP
 / SW USP link
Date: Fri, 12 Jul 2024 13:24:12 +0100
Message-ID: <20240712122414.1448284-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
References: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Whilst similar to existing PCIESlot link configuration a few registers
need to be set differently so that the downstream device presents
a 'configured' state that is then used to 'train' the upstream port
on the link.  Basically that means setting the status register to
reflect it succeeding in training up to target settings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci/pcie.h |  2 ++
 hw/pci/pcie.c         | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 5eddb90976..b8d59732bc 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -141,6 +141,8 @@ void pcie_acs_reset(PCIDevice *dev);
 void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
+void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
+                               PCIExpLinkSpeed speed);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b14d59573e..89734b50a2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -154,6 +154,24 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
     }    
 }
 
+void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
+                               PCIExpLinkSpeed speed)
+{
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+
+    /*
+     * For an end point or USP need to set the current status as well
+     * as the capabilities.
+     */
+    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                 PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
+    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                               QEMU_PCI_EXP_LNKSTA_NLW(width) |
+                               QEMU_PCI_EXP_LNKSTA_CLS(speed));
+    
+    pcie_cap_fill_lnk(exp_cap, width, speed);
+}
+
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
 {
     PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
-- 
2.43.0


