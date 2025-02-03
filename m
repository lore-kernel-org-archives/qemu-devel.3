Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41772C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezAz-0006f5-7R; Mon, 03 Feb 2025 11:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tezAu-0006Xx-2b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:19:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tezAr-0004c1-Hs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:19:51 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmsBL2BDdz6K8yT;
 Tue,  4 Feb 2025 00:18:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 74E4F1401F4;
 Tue,  4 Feb 2025 00:19:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 17:19:40 +0100
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 1/5] hw/cxl: Introduce CXL_T3_MSIX_VECTOR enumeration
Date: Mon, 3 Feb 2025 16:19:04 +0000
Message-ID: <20250203161908.145406-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Introduce the `CXL_T3_MSIX_VECTOR` enumeration to specify MSIX vector
assignments specific to the Type 3 (T3) CXL device.

The primary goal of this change is to encapsulate the MSIX vector uses
that are unique to the T3 device within an enumeration, improving code
readability and maintenance by avoiding magic numbers. This organizational
change allows for more explicit references to each vector’s role, thereby
reducing the potential for misconfiguration.

It also modified `mailbox_reg_init_common` to accept the `msi_n` parameter,
reflecting the new MSIX vector setup.

This pertains to the T3 device privately; other endpoints should refrain from
using it, despite its public accessibility to all of them.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  4 ++--
 hw/cxl/cxl-device-utils.c   | 12 +++++-------
 hw/cxl/switch-mailbox-cci.c |  4 +++-
 hw/mem/cxl_type3.c          | 20 ++++++++++++++------
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc8..3a0ee7e8e7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -264,8 +264,8 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
 typedef struct CXLType3Dev CXLType3Dev;
 typedef struct CSWMBCCIDev CSWMBCCIDev;
 /* Set up default values for the register block */
-void cxl_device_register_init_t3(CXLType3Dev *ct3d);
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n);
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n);
 
 /*
  * CXL r3.1 Section 8.2.8.1: CXL Device Capabilities Array Register
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6d..52ad1e4c3f 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -352,10 +352,8 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
     }
 }
 
-static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
+static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate, int msi_n)
 {
-    const uint8_t msi_n = 9;
-
     /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
@@ -382,7 +380,7 @@ static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->memdev_status = memdev_status_reg;
 }
 
-void cxl_device_register_init_t3(CXLType3Dev *ct3d)
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -398,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000,
         CXL_MEM_DEV_STATUS_VERSION);
@@ -408,7 +406,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
                               CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &sw->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -423,7 +421,7 @@ void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 65cdac6cc1..833b824619 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -17,10 +17,12 @@
 #include "hw/qdev-properties.h"
 #include "hw/cxl/cxl.h"
 
+#define CXL_SWCCI_MSIX_MBOX 3
+
 static void cswmbcci_reset(DeviceState *dev)
 {
     CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(dev);
-    cxl_device_register_init_swcci(cswmb);
+    cxl_device_register_init_swcci(cswmb, CXL_SWCCI_MSIX_MBOX);
 }
 
 static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0ae1704a34..ebc0ec536e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,14 @@
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 
+/* type3 device private */
+enum CXL_T3_MSIX_VECTOR {
+    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS = 0,
+    CXL_T3_MSIX_EVENT_START = 2,
+    CXL_T3_MSIX_MBOX = CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
+    CXL_T3_MSIX_VECTOR_NR
+};
+
 #define DWORD_BYTE 4
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
@@ -843,7 +851,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 10;
     int i, rc;
     uint16_t count;
 
@@ -884,16 +891,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
         goto err_address_space_free;
     }
-    for (i = 0; i < msix_num; i++) {
+    for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
+                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
@@ -908,7 +916,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
-    cxl_event_init(&ct3d->cxl_dstate, 2);
+    cxl_event_init(&ct3d->cxl_dstate, CXL_T3_MSIX_EVENT_START);
 
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
@@ -1202,7 +1210,7 @@ static void ct3d_reset(DeviceState *dev)
 
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
-    cxl_device_register_init_t3(ct3d);
+    cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
-- 
2.43.0


