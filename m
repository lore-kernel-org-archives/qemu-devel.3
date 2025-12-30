Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E6DE95A6C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 10:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaWsG-0004ep-Bb; Tue, 30 Dec 2025 05:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWs8-0004cb-3C; Tue, 30 Dec 2025 05:22:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWs5-00033Y-R9; Tue, 30 Dec 2025 05:22:35 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTGUWNI006569;
 Tue, 30 Dec 2025 10:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yq1Xze
 IomxCk820X+uqTGAlmaEp+BiuK7MPZyLLY6iA=; b=UM1MV5xQe398wYRWYr3PWE
 ez6MH2rnGd5GFoXgkq0pOgXET2KCmuE5mt7YkjULAD9uXNa+Vgf43OsXkX1WBV/E
 ivVf4EV/t8OB/y2zHe56OhcH1ZsOa6kCDK1u5Zb3w/c92WCcxWGrOpr4IdLlF+Ex
 4F8Wq3I5IQO2SdYZ+ylht+SRF9UOI9lyQLLTjYSrQcZnYEz0Rimqa7qkQS5eusPb
 o9bIalCWmJbRCudQ1SdSMyjM1UU3biIH/khqc2Qt2+ZcIzv0nT6VHQ8hPhZGIj6S
 Yp30qWbtX/3PvDmlrbGSZbYnmO3Ui+S/ctp//pRJXETk4ulUUH189dd9KVTlsVCQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba764ty66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BUAMTUV011902;
 Tue, 30 Dec 2025 10:22:29 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba764ty62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU6bbnu012847;
 Tue, 30 Dec 2025 10:22:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bassssm9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BUAMQ3U45744480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Dec 2025 10:22:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99ED75805A;
 Tue, 30 Dec 2025 10:22:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48AA258054;
 Tue, 30 Dec 2025 10:22:25 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Dec 2025 10:22:25 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2 2/9] pnv/phb4: Add reset logic to PHB4
Date: Tue, 30 Dec 2025 04:21:20 -0600
Message-ID: <20251230102156.886288-3-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA5MiBTYWx0ZWRfX6f3pmh7KaqQr
 ElS7icwJLod+qo3bzfdlsy4FyhuqEiThu3zcv+BlYv7p4y+3i8IfgUAkzTyPNAYIfg/IB+rpdyv
 RVrX5n5gLLN1QZ+UMm3YumRBC3fIhfxJA6y6eoGeG1vrP1LHQSvACgR7wNXFkIxWBYdccA2Zv+4
 j3nvj6ghqD2hxMzfCPIOycZOTm570OrugJQ0IlbECjyrTpyzBRWek0QOEasgws4z5E0OUNOWLQi
 uG86OnywOxx8VF/yNV4IrAcxehByXSsPDTpCA9izmxDOeohnpo4UNK8ev6wLgRxPk+6hoxBkLnV
 ZuHrYcmNLc4UyG3eKIuMPFwH9f/DPxArIeAoYU7lObgulwwzSaJ+UzggyWv7Pd8SPMm8XeAfnk2
 nyhiZp7PFcV3z0nBJ0ZeUdxjar/wdVT/U8FWlwQjj5mfHo/fJgdpzWAObgoOb//WhW9vyjohZD2
 /UNj1QKzOU9t//j/kjw==
X-Proofpoint-GUID: gxbl_IB0Z0zETUQF7rJa-6hQYDOWVQF_
X-Authority-Analysis: v=2.4 cv=B4+0EetM c=1 sm=1 tr=0 ts=6953a7e5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=hMFCid2_mGc3QkhTxUgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: KbNDNklWbDP98XwG6lF4MRufNh6ejkMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512300092
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
v1 -> v2:
- Using the ResettableClass.
- Reset of the root complex registers done in pnv_phb_root_port_reset_hold().

 hw/pci-host/pnv_phb.c               |   1 +
 hw/pci-host/pnv_phb4.c              | 101 +++++++++++++++++++++++++++-
 include/hw/pci-host/pnv_phb4.h      |   1 +
 include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
 tests/qtest/pnv-phb4-test.c         |  28 +++++++-
 5 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 85fcc3b686..bc08d7488d 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -233,6 +233,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
     pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
     pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
     pci_config_set_interrupt_pin(conf, 0);
+    pnv_phb4_cfg_core_reset(d);
 }
 
 static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 396bc47817..bf21f955c8 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1,7 +1,8 @@
 /*
  * QEMU PowerPC PowerNV (POWER9) PHB4 model
+ * QEMU PowerPC PowerNV (POWER10) PHB5 model
  *
- * Copyright (c) 2018-2020, IBM Corporation.
+ * Copyright (c) 2018-2025, IBM Corporation.
  *
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
@@ -22,6 +23,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "trace.h"
+#include "system/reset.h"
 
 #define phb_error(phb, fmt, ...)                                        \
     qemu_log_mask(LOG_GUEST_ERROR, "phb4[%d:%d]: " fmt "\n",            \
@@ -499,6 +501,81 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
     }
 }
 
+/*
+ * Get the PCI-E capability offset from the root-port
+ */
+static uint32_t get_exp_offset(PCIDevice *pdev)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(pdev);
+    return rpc->exp_offset;
+}
+
+void pnv_phb4_cfg_core_reset(PCIDevice *d)
+{
+    uint8_t *conf = d->config;
+    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
+    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
+    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
+    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
+    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
+    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
+    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
+    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
+    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
+    pci_set_word(conf + PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
+    pci_set_long(conf + PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
+
+    uint32_t exp_offset = get_exp_offset(d);
+    pci_set_long(conf + exp_offset, 0x420010);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP,  0x8022);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG
+                                              | PCI_EXP_DEVCTL_PAYLOAD_512B);
+    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_LBNC
+                 | PCI_EXP_LNKCAP_DLLLARC | BIT(8) | PCI_EXP_LNKCAP_SLS_32_0GB);
+    pci_set_word(conf + exp_offset + PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);
+    pci_set_word(conf + exp_offset + PCI_EXP_LNKSTA,
+                       (PCI_EXP_LNKSTA_NLW_X8 << 2) | PCI_EXP_LNKSTA_CLS_2_5GB);
+    pci_set_long(conf + exp_offset + PCI_EXP_SLTCTL,
+                                                   PCI_EXP_SLTCTL_ASPL_DISABLE);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP2, BIT(16)
+                  | PCI_EXP_DEVCAP2_ARI | PCI_EXP_DEVCAP2_COMP_TMOUT_DIS | 0xF);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
+    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP2, BIT(23)
+                       | PCI_EXP_LNKCAP2_SLS_32_0GB
+                       | PCI_EXP_LNKCAP2_SLS_16_0GB | PCI_EXP_LNKCAP2_SLS_8_0GB
+                       | PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB);
+    pci_set_long(conf + PHB_AER_ECAP, PCI_EXT_CAP(0x1, 0x1, 0x148));
+    pci_set_long(conf + PHB_SEC_ECAP, (0x1A0 << 20) | BIT(16)
+                                                       | PCI_EXT_CAP_ID_SECPCI);
+    pci_set_long(conf + PHB_LMR_ECAP, 0x1E810027);
+    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
+    int i;
+    for (i = PHB_LMR_CTLSTA_2 ; i <= PHB_LMR_CTLSTA_16 ; i += 4) {
+        pci_set_long(conf + i, 0x9C38);
+    }
+
+    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
+    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
+    pci_set_long(conf + P16_ECAP, 0x22410026);
+    pci_set_long(conf + P32_ECAP, 0x1002A);
+    pci_set_long(conf + P32_CAP,  0x103);
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
@@ -612,6 +689,17 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         pnv_phb4_update_xsrc(phb);
         break;
 
+    /* Reset core blocks */
+    case PHB_PCIE_CRESET:
+        if (val & PHB_PCIE_CRESET_CFG_CORE) {
+            PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+            pnv_phb4_cfg_core_reset(pci_find_device(pci->bus, 0, 0));
+        }
+        if (val & PHB_PCIE_CRESET_PBL) {
+            pnv_phb4_pbl_core_reset(phb);
+        }
+        break;
+
     /* Silent simple writes */
     case PHB_ASN_CMPM:
     case PHB_CONFIG_ADDRESS:
@@ -1532,6 +1620,12 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
     .get_address_space = pnv_phb4_dma_iommu,
 };
 
+static void pnv_phb4_reset(Object *obj, ResetType type)
+{
+    PnvPHB4 *phb = PNV_PHB4(obj);
+    pnv_phb4_pbl_core_reset(phb);
+}
+
 static void pnv_phb4_instance_init(Object *obj)
 {
     PnvPHB4 *phb = PNV_PHB4(obj);
@@ -1608,6 +1702,8 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
+
+    qemu_register_resettable(OBJECT(dev));
 }
 
 /*
@@ -1707,6 +1803,9 @@ static void pnv_phb4_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable  = false;
 
     xfc->notify         = pnv_phb4_xive_notify;
+
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    rc->phases.enter = pnv_phb4_reset;
 }
 
 static const TypeInfo pnv_phb4_type_info = {
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index de996e718b..47a5c3edf5 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -160,6 +160,7 @@ void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
 int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
 PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
 void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
+void pnv_phb4_cfg_core_reset(PCIDevice *d);
 extern const MemoryRegionOps pnv_phb4_xscom_ops;
 
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
index 3890b4f970..3957c743a3 100644
--- a/tests/qtest/pnv-phb4-test.c
+++ b/tests/qtest/pnv-phb4-test.c
@@ -35,6 +35,29 @@ static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
     return qtest_readq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_data));
 }
 
+#define phb4_xscom_read(a) pnv_phb_xscom_read(qts, \
+                                   &pnv_chips[PNV_P10_CHIP_INDEX], PHB4_XSCOM, \
+                                   PHB_SCOM_HV_IND_ADDR, PHB_SCOM_HV_IND_DATA, \
+                                   PPC_BIT(0) | a)
+
+/* Assert that 'PHB PBL Control' register has correct reset value */
+static void phb4_reset_test(QTestState *qts)
+{
+    g_assert_cmpuint(phb4_xscom_read(PHB_PBL_CONTROL), ==, 0xC009000000000000);
+}
+
+static void phb4_tests(void)
+{
+    QTestState *qts = NULL;
+
+    qts = qtest_initf("-machine powernv10 -accel tcg");
+
+    /* Check reset value of a register */
+    phb4_reset_test(qts);
+
+    qtest_quit(qts);
+}
+
 /* Assert that 'PHB - Version Register' bits-[24:31] are as expected */
 static void phb_version_test(const void *data)
 {
@@ -71,8 +94,6 @@ static void phb_version_test(const void *data)
     /* PHB Version register bits [24:31] */
     ver = ver >> (63 - 31);
     g_assert_cmpuint(ver, ==, expected_ver);
-
-    qtest_quit(qts);
 }
 
 /* Verify versions of all supported PHB's */
@@ -95,5 +116,8 @@ int main(int argc, char **argv)
     /* PHB[345] tests */
     add_phbX_version_test();
 
+    /* PHB4 specific tests */
+    qtest_add_func("phb4", phb4_tests);
+
     return g_test_run();
 }
-- 
2.47.3


