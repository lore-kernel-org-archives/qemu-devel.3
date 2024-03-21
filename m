Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A1C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFIZ-0007Aa-Pg; Thu, 21 Mar 2024 06:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI8-000707-8A; Thu, 21 Mar 2024 06:04:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI5-0007Z3-RW; Thu, 21 Mar 2024 06:04:55 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L6sCg0023936; Thu, 21 Mar 2024 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8zraPkvW4ET16KSAnHl1dIdf5lqFjbzuP06NPy2jmzY=;
 b=nNaA7GB05hdjiFEPCDm94Wfnv4zQZmPLSXYTto5IVvh7fTWqJuumy/POcYMfkfX3Of3y
 92i5ZfqLuoq7LpSIWLjontw8VDBZUJn0ktovKoNMuCS8HLvxGnQ9Nw4p0E7noEF4SzB9
 Y4JT9P+O/gZt8wNw+H5TMxXISNshOxhJi18LSyjPGjJPUlNaooS8voqeefL8C+twHW8c
 zfIh5Mm+lWnXnYgWTVVFOhDdH8KxpLQN+XACwRQaS7ZRqPBei6qz3NpBCnYnIhFMGBIX
 DVE7R/Tjq3OIDV3F1mVadG09G3VAh/Zgr8MQTDOwc1xbDjWujalEmtgQq9c84YUHSXRu Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0e5ugmb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:39 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LA44Ml020257;
 Thu, 21 Mar 2024 10:04:39 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0e5ugmb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:38 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L91V94017190; Thu, 21 Mar 2024 10:04:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtmh7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42LA4ZM146727592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 10:04:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2132A58064;
 Thu, 21 Mar 2024 10:04:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F67C5805A;
 Thu, 21 Mar 2024 10:04:34 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 10:04:34 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH 03/10] pnv/phb4: Implement sticky reset logic in PHB4
Date: Thu, 21 Mar 2024 05:04:15 -0500
Message-Id: <20240321100422.5347-4-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gHUN7C87n3BWnK4jk3zDtHvmL--g585X
X-Proofpoint-GUID: loFHIl9QBMMER0DQvImF9Y_m3oyht9ur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210069
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

Sticky bits retain their values on reset and are not overwritten with the reset value.
Added sticky reset logic for all required registers,
i.e. CFG core, PBL core, PHB error registers, PCIE stack registers and REGB error registers.

Tested by writing all 1's to the reg PHB_PBL_ERR_INJECT.
This will set the bits in the reg PHB_PBL_ERR_STATUS.
Reset the PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
Verify that the sticky bits in the PHB_PBL_ERR_STATUS reg are still set.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
 hw/pci-host/pnv_phb4.c              | 156 ++++++++++++++++++++++++++--
 include/hw/pci-host/pnv_phb4_regs.h |  20 +++-
 tests/qtest/pnv-phb4-test.c         |  30 +++++-
 3 files changed, 196 insertions(+), 10 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index d2e7403b37..b3a83837f8 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -516,14 +516,52 @@ static uint32_t get_exp_offset(PnvPHB4 *phb)
     return rpc->exp_offset;
 }
 
-#define RC_CONFIG_WRITE(a, v) pnv_phb4_rc_config_write(phb, a, 4, v);
+#define RC_CONFIG_WRITE(a, v) pnv_phb4_rc_config_write(phb, a, 4, v)
+
+/*
+ * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
+ * RC-config space values and masks are LE.
+ * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
+ * Compute new value in LE domain.
+ * New value computation using sticky-mask is in LE.
+ * Convert the computed value from LE to BE before writing back.
+ */
+#define RC_CONFIG_STICKY_RESET(a, v, s) \
+    (RC_CONFIG_WRITE(a, bswap32( \
+                     (bswap32(pnv_phb4_rc_config_read(phb, a, 4)) & s) \
+                      | (v & ~s) \
+                     )))
 
 static void pnv_phb4_cfg_core_reset(PnvPHB4 *phb)
 {
-    /* Zero all registers initially */
+    /*
+     * Zero all registers initially,
+     * except those that have sticky reset.
+     */
     int i;
     for (i = PCI_COMMAND ; i < PHB_RC_CONFIG_SIZE ; i += 4) {
-            RC_CONFIG_WRITE(i, 0)
+        switch (i) {
+        case PCI_EXP_LNKCTL2:
+        case PHB_AER_UERR:
+        case PHB_AER_UERR_MASK:
+        case PHB_AER_CERR:
+        case PHB_AER_CAPCTRL:
+        case PHB_AER_HLOG_1:
+        case PHB_AER_HLOG_2:
+        case PHB_AER_HLOG_3:
+        case PHB_AER_HLOG_4:
+        case PHB_AER_RERR:
+        case PHB_AER_ESID:
+        case PHB_DLF_STAT:
+        case P16_STAT:
+        case P16_LDPM:
+        case P16_FRDPM:
+        case P16_SRDPM:
+        case P32_CTL:
+            break;
+        default:
+            RC_CONFIG_WRITE(i, 0);
+        }
     }
 
     RC_CONFIG_WRITE(PCI_COMMAND,          0x100100);
@@ -563,15 +601,55 @@ static void pnv_phb4_cfg_core_reset(PnvPHB4 *phb)
     RC_CONFIG_WRITE(P16_ECAP,     0x22410026);
     RC_CONFIG_WRITE(P32_ECAP,     0x1002A);
     RC_CONFIG_WRITE(P32_CAP,      0x103);
+
+    /* Sticky reset */
+    RC_CONFIG_STICKY_RESET(exp_offset + PCI_EXP_LNKCTL2,   0x5,  0xFEFFBF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_UERR,      0,    0x1FF030);
+    RC_CONFIG_STICKY_RESET(PHB_AER_UERR_MASK, 0,    0x1FF030);
+    RC_CONFIG_STICKY_RESET(PHB_AER_CERR,      0,    0x11C1);
+    RC_CONFIG_STICKY_RESET(PHB_AER_CAPCTRL,   0xA0, 0x15F);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_1,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_2,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_3,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_4,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_RERR,      0,    0x7F);
+    RC_CONFIG_STICKY_RESET(PHB_AER_ESID,      0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_DLF_STAT,      0,    0x807FFFFF);
+    RC_CONFIG_STICKY_RESET(P16_STAT,          0,    0x1F);
+    RC_CONFIG_STICKY_RESET(P16_LDPM,          0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_FRDPM,         0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_SRDPM,         0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P32_CTL,           0,    0x3);
 }
 
+/* Apply sticky-mask to the reset-value and write to the reg-address */
+#define STICKY_RST(addr, rst_val, sticky_mask) (phb->regs[addr >> 3] = \
+            ((phb->regs[addr >> 3] & sticky_mask) | (rst_val & ~sticky_mask)))
+
 static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
 {
-    /* Zero all registers initially */
+    /*
+     * Zero all registers initially,
+     * with sticky reset of certain registers.
+     */
     int i;
     for (i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
-        phb->regs[i >> 3] = 0x0;
+        switch (i) {
+        case PHB_PBL_ERR_STATUS:
+            break;
+        case PHB_PBL_ERR1_STATUS:
+        case PHB_PBL_ERR_LOG_0:
+        case PHB_PBL_ERR_LOG_1:
+        case PHB_PBL_ERR_STATUS_MASK:
+        case PHB_PBL_ERR1_STATUS_MASK:
+            STICKY_RST(i, 0, PPC_BITMASK(0, 63));
+            break;
+        default:
+            phb->regs[i >> 3] = 0x0;
+        }
     }
+    STICKY_RST(PHB_PBL_ERR_STATUS, 0, \
+            (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
 
     /* Set specific register values */
     phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
@@ -703,6 +781,17 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         }
         break;
 
+    /*
+     * Writing bits to a 1 in this register will inject the error corresponding
+     * to the bit that is written. The bits will automatically clear to 0 after
+     * the error is injected. The corresponding bit in the Error Status Reg
+     * should also be set automatically when the error occurs.
+     */
+    case PHB_PBL_ERR_INJECT:
+        phb->regs[PHB_PBL_ERR_STATUS >> 3] = phb->regs[off >> 3];
+        phb->regs[off >> 3] = 0;
+        break;
+
     /* Silent simple writes */
     case PHB_ASN_CMPM:
     case PHB_CONFIG_ADDRESS:
@@ -1622,12 +1711,67 @@ static void pnv_phb4_xscom_realize(PnvPHB4 *phb)
 static PCIIOMMUOps pnv_phb4_iommu_ops = {
     .get_address_space = pnv_phb4_dma_iommu,
 };
+
+static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
+{
+    STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
+    STICKY_RST(PHB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_TXE_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_TXE_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_TXE_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_TXE_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_RXE_ARB_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_RXE_MRG_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_MRG_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_MRG_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_MRG_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_RXE_TCE_ERR_STATUS,       0, PPC_BITMASK(0, 35));
+    STICKY_RST(PHB_RXE_TCE_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+}
+
+static void pnv_phb4_pcie_stack_reg_reset(PnvPHB4 *phb)
+{
+    STICKY_RST(PHB_PCIE_CRESET, 0xE000000000000000, \
+                        (PHB_PCIE_CRESET_PERST_N | PHB_PCIE_CRESET_REFCLK_N));
+    STICKY_RST(PHB_PCIE_DLP_ERRLOG1,             0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_PCIE_DLP_ERRLOG2,             0, PPC_BITMASK(0, 31));
+    STICKY_RST(PHB_PCIE_DLP_ERR_STATUS,          0, PPC_BITMASK(0, 15));
+}
+
+static void pnv_phb4_regb_err_reg_reset(PnvPHB4 *phb)
+{
+    STICKY_RST(PHB_REGB_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+}
+
 static void pnv_phb4_reset(void *dev)
 {
     PnvPHB4 *phb = PNV_PHB4(dev);
     pnv_phb4_cfg_core_reset(phb);
     pnv_phb4_pbl_core_reset(phb);
-    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
+
+    pnv_phb4_err_reg_reset(phb);
+    pnv_phb4_pcie_stack_reg_reset(phb);
+    pnv_phb4_regb_err_reg_reset(phb);
 }
 
 static void pnv_phb4_instance_init(Object *obj)
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index 6892e21cc9..df5e86d29a 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -344,17 +344,32 @@
 #define   PHB_RC_CONFIG_SIZE                    0x800
 
 #define PHB_AER_ECAP                            0x100
+#define PHB_AER_UERR                            0x104
+#define PHB_AER_UERR_MASK                       0x108
+#define PHB_AER_CERR                            0x110
 #define PHB_AER_CAPCTRL                         0x118
+#define PHB_AER_HLOG_1                          0x11C
+#define PHB_AER_HLOG_2                          0x120
+#define PHB_AER_HLOG_3                          0x124
+#define PHB_AER_HLOG_4                          0x128
+#define PHB_AER_RERR                            0x130
+#define PHB_AER_ESID                            0x134
 #define PHB_SEC_ECAP                            0x148
 #define PHB_LMR_ECAP                            0x1A0
 #define PHB_LMR_CTLSTA_2                        0x1AC
 #define PHB_LMR_CTLSTA_16                       0x1E4
 #define PHB_DLF_ECAP                            0x1E8
 #define PHB_DLF_CAP                             0x1EC
+#define PHB_DLF_STAT                            0x1F0
 #define P16_ECAP                                0x1F4
+#define P16_STAT                                0x200
+#define P16_LDPM                                0x204
+#define P16_FRDPM                               0x208
+#define P16_SRDPM                               0x20C
 #define P32_ECAP                                0x224
 #define P32_CAP                                 0x228
-
+#define P32_CTL                                 0x22C
+#define P32_STAT                                0x230
 /* PHB4 REGB registers */
 
 /* PBL core */
@@ -388,8 +403,7 @@
 #define   PHB_PCIE_CRESET_PBL           PPC_BIT(2)
 #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
 #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
-
-
+#define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
 #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
 #define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
 
diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
index 44141462f6..708df3867c 100644
--- a/tests/qtest/pnv-phb4-test.c
+++ b/tests/qtest/pnv-phb4-test.c
@@ -36,7 +36,12 @@ static uint64_t pnv_phb4_xscom_addr(uint32_t reg)
    - bit[51:61]: Indirect Address(00:10)
  * Read/write 'SCOM - HV Indirect Data Register' to get/set the value.
  */
-
+static void pnv_phb4_xscom_write(QTestState *qts, uint32_t reg, uint64_t val)
+{
+    qtest_writeq(qts, pnv_phb4_xscom_addr(PHB_SCOM_HV_IND_ADDR),
+            PPC_BIT(0) | reg);
+    qtest_writeq(qts, pnv_phb4_xscom_addr(PHB_SCOM_HV_IND_DATA), val);
+}
 static uint64_t pnv_phb4_xscom_read(QTestState *qts, uint32_t reg)
 {
     qtest_writeq(qts, pnv_phb4_xscom_addr(PHB_SCOM_HV_IND_ADDR),
@@ -61,6 +66,26 @@ static void phb4_reset_test(QTestState *qts)
                      ==, 0xC009000000000000);
 }
 
+/* Check sticky-reset */
+static void phb4_sticky_rst_test(QTestState *qts)
+{
+    uint64_t val;
+
+    /*
+     * Sticky reset test of PHB_PBL_ERR_STATUS.
+     *
+     * Write all 1's to reg PHB_PBL_ERR_INJECT.
+     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
+     *
+     * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
+     * Verify the sticky bits are still set.
+     */
+    pnv_phb4_xscom_write(qts, PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
+    pnv_phb4_xscom_write(qts, PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
+    val = pnv_phb4_xscom_read(qts, PHB_PBL_ERR_STATUS);
+    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
+}
+
 static void test_phb4(void)
 {
     QTestState *qts = NULL;
@@ -73,6 +98,9 @@ static void test_phb4(void)
     /* Check reset value of a register */
     phb4_reset_test(qts);
 
+    /* Check sticky reset of a register */
+    phb4_sticky_rst_test(qts);
+
     qtest_quit(qts);
 }
 
-- 
2.39.3


