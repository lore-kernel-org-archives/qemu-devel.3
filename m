Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427EBC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFIP-00075S-Qb; Thu, 21 Mar 2024 06:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI8-000706-6w; Thu, 21 Mar 2024 06:04:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI4-0007Z6-L0; Thu, 21 Mar 2024 06:04:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L8UEIB031704; Thu, 21 Mar 2024 10:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YnasUjAzqJPULha4qOGtagAtf5QI/CkXuLQkGj0RKoM=;
 b=fKmQgZTMWSIoNwThzkCVdFAK/7V2YsileaF7RkDGWu9LxzQIEMT0FW5S/H8eGvOeI5JI
 CxnxbqIBBT5BWM2bha3j3w4jD8eFqtscILjgUcgY7x7pmrYrcp5MzzSzpjEqCPZvw0A7
 kZlzYoADsbWr5pgLw4cmsM3vHduendG5KR2qExIKMwd4ZpDyAP+I2xoDqNjqPvGhlf+5
 fCL4P4ci2y8kxU+CfJxLt/zvxsIaXCvOCTrAkd9N9IXJLbJHAGjiey5zG5BtKwJ+gS2J
 cMhtFDD8H/tSMTaqkFMYuKe3VLwZukOsYNLZLjcQeN5tXKrD8IgUpOyPAW+m5IFf+Yhm Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0c6m0usv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:39 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LA4dMF010226;
 Thu, 21 Mar 2024 10:04:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0c6m0ust-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L8qiHs015792; Thu, 21 Mar 2024 10:04:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50cfk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42LA4YhN24117884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 10:04:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 918BC58052;
 Thu, 21 Mar 2024 10:04:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B7DA58066;
 Thu, 21 Mar 2024 10:04:34 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 10:04:34 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH 02/10] pnv/phb4: Add reset logic to PHB4
Date: Thu, 21 Mar 2024 05:04:14 -0500
Message-Id: <20240321100422.5347-3-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jhlvPbyKxV8dXqlJjNEJT-qTweMeVf9D
X-Proofpoint-ORIG-GUID: PEfD5w5s1m_VRrqYtOrmY7iN3V-s4u9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403210069
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a method to be invoked on QEMU reset.
Also add CFG and PBL core-blocks reset logic using
appropriate bits of PHB_PCIE_CRESET register.

Tested by reading the reset value of a register.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
 hw/pci-host/pnv_phb4.c              | 104 +++++++++++++++++++++++++++-
 include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
 tests/qtest/pnv-phb4-test.c         |  10 +++
 3 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 075499d36d..d2e7403b37 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1,7 +1,7 @@
 /*
- * QEMU PowerPC PowerNV (POWER9) PHB4 model
+ * QEMU PowerPC PowerNV (POWER10) PHB4 model
  *
- * Copyright (c) 2018-2020, IBM Corporation.
+ * Copyright (c) 2018-2024, IBM Corporation.
  *
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
@@ -22,6 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
 #include "trace.h"
+#include "sysemu/reset.h"
 
 #define phb_error(phb, fmt, ...)                                        \
     qemu_log_mask(LOG_GUEST_ERROR, "phb4[%d:%d]: " fmt "\n",            \
@@ -499,6 +500,86 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
     }
 }
 
+/*
+ * Get the PCI-E capability offset from the root-port
+ */
+static uint32_t get_exp_offset(PnvPHB4 *phb)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+    PCIDevice *pdev;
+    pdev = pci_find_device(pci->bus, 0, 0);
+    if (!pdev) {
+        phb_error(phb, "PCI device not found");
+        return ~0;
+    }
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(pdev);
+    return rpc->exp_offset;
+}
+
+#define RC_CONFIG_WRITE(a, v) pnv_phb4_rc_config_write(phb, a, 4, v);
+
+static void pnv_phb4_cfg_core_reset(PnvPHB4 *phb)
+{
+    /* Zero all registers initially */
+    int i;
+    for (i = PCI_COMMAND ; i < PHB_RC_CONFIG_SIZE ; i += 4) {
+            RC_CONFIG_WRITE(i, 0)
+    }
+
+    RC_CONFIG_WRITE(PCI_COMMAND,          0x100100);
+    RC_CONFIG_WRITE(PCI_CLASS_REVISION,   0x6040000);
+    RC_CONFIG_WRITE(PCI_CACHE_LINE_SIZE,  0x10000);
+    RC_CONFIG_WRITE(PCI_MEMORY_BASE,      0x10);
+    RC_CONFIG_WRITE(PCI_PREF_MEMORY_BASE, 0x10011);
+    RC_CONFIG_WRITE(PCI_CAPABILITY_LIST,  0x40);
+    RC_CONFIG_WRITE(PCI_INTERRUPT_LINE,   0x20000);
+    /* PM Capabilities Register */
+    RC_CONFIG_WRITE(PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
+
+    uint32_t exp_offset = get_exp_offset(phb);
+    RC_CONFIG_WRITE(exp_offset, 0x420010);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_DEVCAP,  0x8022);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_DEVCTL,  0x140);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_LNKCAP,  0x300105);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_LNKCTL,  0x2010008);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_SLTCTL,  0x2000);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_DEVCAP2, 0x1003F);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_DEVCTL2, 0x20);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_LNKCAP2, 0x80003E);
+    RC_CONFIG_WRITE(exp_offset + PCI_EXP_LNKCTL2, 0x5);
+
+    RC_CONFIG_WRITE(PHB_AER_ECAP,    0x14810001);
+    RC_CONFIG_WRITE(PHB_AER_CAPCTRL, 0xA0);
+    RC_CONFIG_WRITE(PHB_SEC_ECAP,    0x1A010019);
+
+    RC_CONFIG_WRITE(PHB_LMR_ECAP, 0x1E810027);
+    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
+    for (i = PHB_LMR_CTLSTA_2 ; i <= PHB_LMR_CTLSTA_16 ; i += 4) {
+        RC_CONFIG_WRITE(i, 0x9C38);
+    }
+
+    RC_CONFIG_WRITE(PHB_DLF_ECAP, 0x1F410025);
+    RC_CONFIG_WRITE(PHB_DLF_CAP,  0x80000001);
+    RC_CONFIG_WRITE(P16_ECAP,     0x22410026);
+    RC_CONFIG_WRITE(P32_ECAP,     0x1002A);
+    RC_CONFIG_WRITE(P32_CAP,      0x103);
+}
+
+static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
+{
+    /* Zero all registers initially */
+    int i;
+    for (i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
+        phb->regs[i >> 3] = 0x0;
+    }
+
+    /* Set specific register values */
+    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
+    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
+    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;
+    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
+}
+
 static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
                                unsigned size)
 {
@@ -612,6 +693,16 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         pnv_phb4_update_xsrc(phb);
         break;
 
+    /* Reset core blocks */
+    case PHB_PCIE_CRESET:
+        if (val & PHB_PCIE_CRESET_CFG_CORE) {
+            pnv_phb4_cfg_core_reset(phb);
+        }
+        if (val & PHB_PCIE_CRESET_PBL) {
+            pnv_phb4_pbl_core_reset(phb);
+        }
+        break;
+
     /* Silent simple writes */
     case PHB_ASN_CMPM:
     case PHB_CONFIG_ADDRESS:
@@ -1531,6 +1622,13 @@ static void pnv_phb4_xscom_realize(PnvPHB4 *phb)
 static PCIIOMMUOps pnv_phb4_iommu_ops = {
     .get_address_space = pnv_phb4_dma_iommu,
 };
+static void pnv_phb4_reset(void *dev)
+{
+    PnvPHB4 *phb = PNV_PHB4(dev);
+    pnv_phb4_cfg_core_reset(phb);
+    pnv_phb4_pbl_core_reset(phb);
+    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
+}
 
 static void pnv_phb4_instance_init(Object *obj)
 {
@@ -1608,6 +1706,8 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
+
+    qemu_register_reset(pnv_phb4_reset, dev);
 }
 
 /*
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index bea96f4d91..6892e21cc9 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -343,6 +343,18 @@
 #define PHB_RC_CONFIG_BASE                      0x1000
 #define   PHB_RC_CONFIG_SIZE                    0x800
 
+#define PHB_AER_ECAP                            0x100
+#define PHB_AER_CAPCTRL                         0x118
+#define PHB_SEC_ECAP                            0x148
+#define PHB_LMR_ECAP                            0x1A0
+#define PHB_LMR_CTLSTA_2                        0x1AC
+#define PHB_LMR_CTLSTA_16                       0x1E4
+#define PHB_DLF_ECAP                            0x1E8
+#define PHB_DLF_CAP                             0x1EC
+#define P16_ECAP                                0x1F4
+#define P32_ECAP                                0x224
+#define P32_CAP                                 0x228
+
 /* PHB4 REGB registers */
 
 /* PBL core */
@@ -368,7 +380,7 @@
 #define PHB_PCIE_SCR                    0x1A00
 #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
 #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
-
+#define PHB_PCIE_BNR                    0x1A08
 
 #define PHB_PCIE_CRESET                 0x1A10
 #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
@@ -423,6 +435,8 @@
 #define PHB_PCIE_LANE_EQ_CNTL23         0x1B08 /* DD1 only */
 #define PHB_PCIE_TRACE_CTRL             0x1B20
 #define PHB_PCIE_MISC_STRAP             0x1B30
+#define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 0x1B40
+#define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15 0x1B98
 
 /* Error */
 #define PHB_REGB_ERR_STATUS             0x1C00
diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
index e3b809e9c4..44141462f6 100644
--- a/tests/qtest/pnv-phb4-test.c
+++ b/tests/qtest/pnv-phb4-test.c
@@ -54,6 +54,13 @@ static void phb4_version_test(QTestState *qts)
     g_assert_cmpuint(ver, ==, 0xA5);
 }
 
+/* Assert that 'PHB PBL Control' register has correct reset value */
+static void phb4_reset_test(QTestState *qts)
+{
+    g_assert_cmpuint(pnv_phb4_xscom_read(qts, PHB_PBL_CONTROL),
+                     ==, 0xC009000000000000);
+}
+
 static void test_phb4(void)
 {
     QTestState *qts = NULL;
@@ -63,6 +70,9 @@ static void test_phb4(void)
     /* Make sure test is running on PHB */
     phb4_version_test(qts);
 
+    /* Check reset value of a register */
+    phb4_reset_test(qts);
+
     qtest_quit(qts);
 }
 
-- 
2.39.3


