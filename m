Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C38C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFLi-00081A-S5; Fri, 12 Jul 2024 08:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSFLY-0007Ks-45
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:25:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSFLU-0002wM-3r
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:25:55 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL9lG6dkRz6JB6Q;
 Fri, 12 Jul 2024 20:24:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 060E1140B2A;
 Fri, 12 Jul 2024 20:25:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 13:25:46 +0100
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
 <fan.ni@samsung.com>
Subject: [RFC qemu 3/6] hw/pcie: Factor out PCI Express link register filing
 common to EP.
Date: Fri, 12 Jul 2024 13:24:11 +0100
Message-ID: <20240712122414.1448284-4-Jonathan.Cameron@huawei.com>
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

Whilst not all link related registers are common between RP / Switch DSP
and EP / Switch USP many of them are.  Factor that group out to save
on duplication when adding EP / Swtich USP configurability.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci/pcie.c | 87 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4b2f0805c6..b14d59573e 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -105,46 +105,18 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
     pci_set_word(cmask + PCI_EXP_LNKSTA, 0);
 }
 
-static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
+/* Includes setting the target speed default */
+static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
+                              PCIExpLinkSpeed speed)
 {
-    PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
-    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
-
-    /* Skip anything that isn't a PCIESlot */
-    if (!s) {
-        return;
-    }
-
     /* Clear and fill LNKCAP from what was configured above */
     pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
                                  PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
     pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
-                               QEMU_PCI_EXP_LNKCAP_MLW(s->width) |
-                               QEMU_PCI_EXP_LNKCAP_MLS(s->speed));
-
-    /*
-     * Link bandwidth notification is required for all root ports and
-     * downstream ports supporting links wider than x1 or multiple link
-     * speeds.
-     */
-    if (s->width > QEMU_PCI_EXP_LNK_X1 ||
-        s->speed > QEMU_PCI_EXP_LNK_2_5GT) {
-        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
-                                   PCI_EXP_LNKCAP_LBNC);
-    }
-
-    if (s->speed > QEMU_PCI_EXP_LNK_2_5GT) {
-        /*
-         * Hot-plug capable downstream ports and downstream ports supporting
-         * link speeds greater than 5GT/s must hardwire PCI_EXP_LNKCAP_DLLLARC
-         * to 1b.  PCI_EXP_LNKCAP_DLLLARC implies PCI_EXP_LNKSTA_DLLLA, which
-         * we also hardwire to 1b here.  2.5GT/s hot-plug slots should also
-         * technically implement this, but it's not done here for compatibility.
-         */
-        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
-                                   PCI_EXP_LNKCAP_DLLLARC);
-        /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
+                               QEMU_PCI_EXP_LNKCAP_MLW(width) |
+                               QEMU_PCI_EXP_LNKCAP_MLS(speed));
 
+    if (speed > QEMU_PCI_EXP_LNK_2_5GT) {
         /*
          * Target Link Speed defaults to the highest link speed supported by
          * the component.  2.5GT/s devices are permitted to hardwire to zero.
@@ -152,7 +124,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKCTL2,
                                      PCI_EXP_LNKCTL2_TLS);
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKCTL2,
-                                   QEMU_PCI_EXP_LNKCAP_MLS(s->speed) &
+                                   QEMU_PCI_EXP_LNKCAP_MLS(speed) &
                                    PCI_EXP_LNKCTL2_TLS);
     }
 
@@ -161,25 +133,62 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
      * actually a reference to the highest bit supported in this register.
      * We assume the device supports all link speeds.
      */
-    if (s->speed > QEMU_PCI_EXP_LNK_5GT) {
+    if (speed > QEMU_PCI_EXP_LNK_5GT) {
         pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP2, ~0U);
         pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
                                    PCI_EXP_LNKCAP2_SLS_2_5GB |
                                    PCI_EXP_LNKCAP2_SLS_5_0GB |
                                    PCI_EXP_LNKCAP2_SLS_8_0GB);
-        if (s->speed > QEMU_PCI_EXP_LNK_8GT) {
+        if (speed > QEMU_PCI_EXP_LNK_8GT) {
             pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
                                        PCI_EXP_LNKCAP2_SLS_16_0GB);
         }
-        if (s->speed > QEMU_PCI_EXP_LNK_16GT) {
+        if (speed > QEMU_PCI_EXP_LNK_16GT) {
             pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
                                        PCI_EXP_LNKCAP2_SLS_32_0GB);
         }
-        if (s->speed > QEMU_PCI_EXP_LNK_32GT) {
+        if (speed > QEMU_PCI_EXP_LNK_32GT) {
             pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
                                        PCI_EXP_LNKCAP2_SLS_64_0GB);
         }
+    }    
+}
+
+static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
+{
+    PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+
+    /* Skip anything that isn't a PCIESlot */
+    if (!s) {
+        return;
     }
+
+    /*
+     * Link bandwidth notification is required for all root ports and
+     * downstream ports supporting links wider than x1 or multiple link
+     * speeds.
+     */
+    if (s->width > QEMU_PCI_EXP_LNK_X1 ||
+        s->speed > QEMU_PCI_EXP_LNK_2_5GT) {
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
+                                   PCI_EXP_LNKCAP_LBNC);
+    }
+
+    if (s->speed > QEMU_PCI_EXP_LNK_2_5GT) {
+        /*
+         * Hot-plug capable downstream ports and downstream ports supporting
+         * link speeds greater than 5GT/s must hardwire PCI_EXP_LNKCAP_DLLLARC
+         * to 1b.  PCI_EXP_LNKCAP_DLLLARC implies PCI_EXP_LNKSTA_DLLLA, which
+         * we also hardwire to 1b here.  2.5GT/s hot-plug slots should also
+         * technically implement this, but it's not done here for compatibility.
+         */
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
+                                   PCI_EXP_LNKCAP_DLLLARC);
+        /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
+    }
+
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
-- 
2.43.0


