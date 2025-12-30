Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C0EE95A6C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 10:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaWsG-0004f9-GS; Tue, 30 Dec 2025 05:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWs9-0004cr-I9; Tue, 30 Dec 2025 05:22:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWs6-00033r-Tk; Tue, 30 Dec 2025 05:22:37 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTFwCPc018036;
 Tue, 30 Dec 2025 10:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7bNNUK
 MXXM0UVE7m/5EJP7UJX7uOgWn00UHbIk0tX3A=; b=nScU8I8Ihzw2HCD1yhhQCY
 MN1hA0ohICpFjEvT9IrV40UYw7JMhQ93+etlxpG5y8WW1weKyVEQfc+JiY9Meoqa
 CYAUYYelaLKu146+DhyYj5Wu0OOLA1sMyANxkbTpmZ7JMSt8nrM96IgVSvvzsUgm
 e7UJUADp+Jb8O6lAmF2M02to2Wfij54DZZzzrlSlGRjsevNh+KPxs9NzihT3Ipph
 FBA+pce+6uXeGPyaUrTuLylleA4iOQfaWwbgPdfz/Z0pP8HVXUXFlXBV9OYZgLiI
 9QucjuPtHMpPbAbThKLWo+jhDITB26eda9uCHwxaYzrls6+aHw/1lVRjPPZNKEpw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vssvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BUAMVU4017558;
 Tue, 30 Dec 2025 10:22:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vssvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU7CqX3025002;
 Tue, 30 Dec 2025 10:22:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bau9k9d5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:31 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BUAMTJU27787960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Dec 2025 10:22:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FF475805A;
 Tue, 30 Dec 2025 10:22:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44BBF58054;
 Tue, 30 Dec 2025 10:22:28 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Dec 2025 10:22:28 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2 4/9] pnv/phb4: Implement read-only and write-only bits of
 registers
Date: Tue, 30 Dec 2025 04:21:22 -0600
Message-ID: <20251230102156.886288-5-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l1NiPRqKR_DOQQtgBOeGazydNGJRSp0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA4OCBTYWx0ZWRfX+2m5hzmHalEj
 hNNnbKNM+101LcKkmTfhyaHCe8ZgpOMKu8/gj8JErq7V4L6Qj9YOc5x8LAHSEIpGZHK6p8Xn4s0
 e7UvlAWkOqkV5Mie32RY9w3e+HqTQ/4qnVu4VP1A6CsDGpOY8A9Pwt41yFbq+xfm92g/qGZGuoL
 Q2MpQp5HISE6Cos4C7xtFEJNe5ljYDFRpuyoQBAuY1FAfT2PYFUckvd+d0v92qY1qq5H81ytOHy
 wuv7wqbn/3GZdmu/4qKzb/dE0S+k41YRHtO4ZL4CyVRUnsQtAj83MJvM/rbttaxzeX0v7PmoDLm
 96IXh8glV6u+UuJiZT1xOwwsh71J0onPWdhTr/KOq/S0Ce886neyT9d3WHPuEYD+0p5ROvSN4Kb
 3+yO+VgJ372wEUKUW/YrggrBkPWdVRK7kpgVpXzUvkMbOJOQ4t7Oe4A6NApMUp0xgmQLb2ksm/a
 G2PNzobZFk1NWIS5RUg==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=6953a7e8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=qL7dbseoqaOwmC5j1pEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: TYWMOI-19w2WOT2KM-pVyoKBNOOUkIsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300088
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

SW cannot write the read-only(RO) bits of a register
and write-only(WO) bits of a register return 0 when read.

Added ro_mask[] for each register that defines which
bits in that register are RO.
When writing to a register, the RO-bits are not updated.

When reading a register, clear the WO bits and return the updated value.

Tested the registers PHB_DMA_SYNC, PHB_PCIE_HOTPLUG_STATUS, PHB_PCIE_LMR,
PHB_PCIE_DLP_TRWCTL, PHB_LEM_ERROR_AND_MASK and PHB_LEM_ERROR_OR_MASK
by writing all 1's and reading back the value.
The WO bits in these registers should read back as 0.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
v1 -> v2: New PnvPHB4Class to hold each register's RO mask.

 hw/pci-host/pnv_phb4.c              | 78 ++++++++++++++++++++++++++---
 include/hw/pci-host/pnv_phb4.h      | 13 ++++-
 include/hw/pci-host/pnv_phb4_regs.h | 20 ++++++--
 tests/qtest/pnv-phb4-test.c         | 60 +++++++++++++++++++++-
 4 files changed, 157 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 70f5af21fa..48caba9e79 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -707,6 +707,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         return;
     }
 
+    /* Update 'val' according to the register's RO-mask */
+    PnvPHB4Class *k = PNV_PHB4_GET_CLASS(phb);
+    val = (phb->regs[off >> 3] & k->ro_mask[off >> 3]) |
+                                            (val & ~(k->ro_mask[off >> 3]));
+
     /* Record whether it changed */
     changed = phb->regs[off >> 3] != val;
 
@@ -781,7 +786,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
     case PHB_TCE_TAG_ENABLE:
     case PHB_INT_NOTIFY_ADDR:
     case PHB_INT_NOTIFY_INDEX:
-    case PHB_DMARD_SYNC:
+    case PHB_DMA_SYNC:
        break;
 
     /* Noise on anything else */
@@ -819,7 +824,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     case PHB_VERSION:
         return PNV_PHB4_PEC_GET_CLASS(phb->pec)->version;
 
-        /* Read-only */
+    /* Read-only */
     case PHB_PHB4_GEN_CAP:
         return 0xe4b8000000000000ull;
     case PHB_PHB4_TCE_CAP:
@@ -829,18 +834,49 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     case PHB_PHB4_EEH_CAP:
         return phb->big_phb ? 0x2000000000000000ull : 0x1000000000000000ull;
 
+    /* Write-only, read will return zeros */
+    case PHB_LEM_ERROR_AND_MASK:
+    case PHB_LEM_ERROR_OR_MASK:
+        return 0;
+    case PHB_PCIE_DLP_TRWCTL:
+        val &= ~PHB_PCIE_DLP_TRWCTL_WREN;
+        return val;
     /* IODA table accesses */
     case PHB_IODA_DATA0:
         return pnv_phb4_ioda_read(phb);
 
+    /*
+     * DMA sync: make it look like it's complete,
+     *           clear write-only read/write start sync bits.
+     */
+    case PHB_DMA_SYNC:
+        val = PHB_DMA_SYNC_RD_COMPLETE |
+            ~(PHB_DMA_SYNC_RD_START | PHB_DMA_SYNC_WR_START);
+        return val;
+
+    /*
+     * PCI-E Stack registers
+     */
+    case PHB_PCIE_SCR:
+        val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
+        break;
+
     /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
         /* TODO: Do something sensible with speed ? */
-        return PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+        val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+        return val;
+
+    case PHB_PCIE_HOTPLUG_STATUS:
+        /* Clear write-only bit */
+        val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
+        return val;
 
-    /* DMA read sync: make it look like it's complete */
-    case PHB_DMARD_SYNC:
-        return PHB_DMARD_SYNC_COMPLETE;
+    /* Link Management Register */
+    case PHB_PCIE_LMR:
+        /* These write-only bits always read as 0 */
+        val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
+        return val;
 
     /* Silent simple reads */
     case PHB_LSI_SOURCE_ID:
@@ -1685,6 +1721,32 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
     .get_address_space = pnv_phb4_dma_iommu,
 };
 
+static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
+{
+    PnvPHB4Class *phb4c = PNV_PHB4_GET_CLASS(phb);
+
+    /*
+     * Set register specific RO-masks
+     */
+
+    /* PBL - Error Injection Register (0x1910) */
+    phb4c->ro_mask[PHB_PBL_ERR_INJECT >> 3] =
+        PPC_BITMASK(0, 23) | PPC_BITMASK(28, 35) | PPC_BIT(38) | PPC_BIT(46) |
+        PPC_BITMASK(49, 51) | PPC_BITMASK(55, 63);
+
+    /* Reserved bits[60:63] */
+    phb4c->ro_mask[PHB_TXE_ERR_LEM_ENABLE >> 3] =
+    phb4c->ro_mask[PHB_TXE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(60, 63);
+    /* Reserved bits[36:63] */
+    phb4c->ro_mask[PHB_RXE_TCE_ERR_LEM_ENABLE >> 3] =
+    phb4c->ro_mask[PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(36, 63);
+    /* Reserved bits[40:63] */
+    phb4c->ro_mask[PHB_ERR_LEM_ENABLE >> 3] =
+    phb4c->ro_mask[PHB_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(40, 63);
+
+    /* TODO: Add more RO-masks as regs are implemented in the model */
+}
+
 static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
 {
     STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
@@ -1743,6 +1805,7 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
     pnv_phb4_err_reg_reset(phb);
     pnv_phb4_pcie_stack_reg_reset(phb);
     pnv_phb4_regb_err_reg_reset(phb);
+    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
 }
 
 static void pnv_phb4_instance_init(Object *obj)
@@ -1753,6 +1816,9 @@ static void pnv_phb4_instance_init(Object *obj)
 
     /* XIVE interrupt source object */
     object_initialize_child(obj, "source", &phb->xsrc, TYPE_XIVE_SOURCE);
+
+    /* Initialize RO-mask of registers */
+    pnv_phb4_ro_mask_init(phb);
 }
 
 void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 47a5c3edf5..bea0684724 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -19,7 +19,7 @@
 
 
 #define TYPE_PNV_PHB4 "pnv-phb4"
-OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
+OBJECT_DECLARE_TYPE(PnvPHB4, PnvPHB4Class, PNV_PHB4)
 
 typedef struct PnvPhb4PecStack PnvPhb4PecStack;
 
@@ -156,6 +156,17 @@ struct PnvPHB4 {
     QLIST_HEAD(, PnvPhb4DMASpace) dma_spaces;
 };
 
+typedef struct PnvPHB4Class {
+    DeviceClass parent_class;
+
+    /*
+     * Read-only bitmask for registers
+     * Bit value: 1 => RO bit
+     *            0 => RW bit
+     */
+    uint64_t ro_mask[PNV_PHB4_NUM_REGS];
+} PnvPHB4Class;
+
 void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
 int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
 PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index df5e86d29a..dfd0e01d1e 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -180,9 +180,11 @@
 #define PHB_M64_AOMASK                  0x1d0
 #define PHB_M64_UPPER_BITS              0x1f0
 #define PHB_NXLATE_PREFIX               0x1f8
-#define PHB_DMARD_SYNC                  0x200
-#define   PHB_DMARD_SYNC_START          PPC_BIT(0)
-#define   PHB_DMARD_SYNC_COMPLETE       PPC_BIT(1)
+#define PHB_DMA_SYNC                    0x200
+#define   PHB_DMA_SYNC_RD_START         PPC_BIT(0)
+#define   PHB_DMA_SYNC_RD_COMPLETE      PPC_BIT(1)
+#define   PHB_DMA_SYNC_WR_START         PPC_BIT(2)
+#define   PHB_DMA_SYNC_WR_COMPLETE      PPC_BIT(3)
 #define PHB_RTC_INVALIDATE              0x208
 #define   PHB_RTC_INVALIDATE_ALL        PPC_BIT(0)
 #define   PHB_RTC_INVALIDATE_RID        PPC_BITMASK(16, 31)
@@ -370,6 +372,7 @@
 #define P32_CAP                                 0x228
 #define P32_CTL                                 0x22C
 #define P32_STAT                                0x230
+
 /* PHB4 REGB registers */
 
 /* PBL core */
@@ -395,8 +398,8 @@
 #define PHB_PCIE_SCR                    0x1A00
 #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
 #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
+#define   PHB_PCIE_SCR_PLW_X16          PPC_BIT(41) /* x16 */
 #define PHB_PCIE_BNR                    0x1A08
-
 #define PHB_PCIE_CRESET                 0x1A10
 #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
 #define   PHB_PCIE_CRESET_TLDLP         PPC_BIT(1)
@@ -405,7 +408,14 @@
 #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
 #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
 #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
+#define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
+#define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
 #define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
+#define   PHB_PCIE_HPSTAT_LINKACTIVE    PPC_BIT(12)
+#define PHB_PCIE_LMR                    0x1A30
+#define   PHB_PCIE_LMR_CHANGELW         PPC_BIT(0)
+#define   PHB_PCIE_LMR_RETRAINLINK      PPC_BIT(1)
+#define   PHB_PCIE_LMR_LINKACTIVE       PPC_BIT(8)
 
 #define PHB_PCIE_DLP_TRAIN_CTL          0x1A40
 #define   PHB_PCIE_DLP_LINK_WIDTH       PPC_BITMASK(30, 35)
@@ -433,7 +443,7 @@
 
 #define PHB_PCIE_DLP_TRWCTL             0x1A80
 #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
-
+#define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
 #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
 #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
 #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
index f186efaf0d..841306ae3f 100644
--- a/tests/qtest/pnv-phb4-test.c
+++ b/tests/qtest/pnv-phb4-test.c
@@ -73,7 +73,8 @@ static void phb4_sticky_rst_test(QTestState *qts)
      * Sticky reset test of PHB_PBL_ERR_STATUS.
      *
      * Write all 1's to reg PHB_PBL_ERR_INJECT.
-     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
+     * RO-only bits will not be written and
+     * updated value will be copied to reg PHB_PBL_ERR_STATUS.
      *
      * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
      * Verify the sticky bits are still set.
@@ -81,7 +82,59 @@ static void phb4_sticky_rst_test(QTestState *qts)
     phb4_xscom_write(PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
     phb4_xscom_write(PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
     val = phb4_xscom_read(PHB_PBL_ERR_STATUS);
-    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
+    g_assert_cmpuint(val, ==, 0xF00DFD8E00);
+}
+
+/* Check that write-only bits/regs return 0 when read */
+static void phb4_writeonly_read_test(QTestState *qts)
+{
+    uint64_t val;
+
+    /*
+     * Set all bits of PHB_DMA_SYNC,
+     * bits 0 and 2 are write-only and should be read as 0.
+     */
+    phb4_xscom_write(PHB_DMA_SYNC, PPC_BITMASK(0, 63));
+    val = phb4_xscom_read(PHB_DMA_SYNC);
+    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
+    g_assert_cmpuint(val & PPC_BIT(2), ==, 0x0);
+
+    /*
+     * Set all bits of PHB_PCIE_HOTPLUG_STATUS,
+     * bit 9 is write-only and should be read as 0.
+     */
+    phb4_xscom_write(PHB_PCIE_HOTPLUG_STATUS, PPC_BITMASK(0, 63));
+    val = phb4_xscom_read(PHB_PCIE_HOTPLUG_STATUS);
+    g_assert_cmpuint(val & PPC_BIT(9), ==, 0x0);
+
+    /*
+     * Set all bits of PHB_PCIE_LMR,
+     * bits 0 and 1 are write-only and should be read as 0.
+     */
+    phb4_xscom_write(PHB_PCIE_LMR, PPC_BITMASK(0, 63));
+    val = phb4_xscom_read(PHB_PCIE_LMR);
+    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
+    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
+
+    /*
+     * Set all bits of PHB_PCIE_DLP_TRWCTL,
+     * write-only bit-1 should be read as 0.
+     */
+    phb4_xscom_write(PHB_PCIE_DLP_TRWCTL, PPC_BITMASK(0, 63));
+    val = phb4_xscom_read(PHB_PCIE_DLP_TRWCTL);
+    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
+
+    /*
+     * Set all bits of PHB_LEM_ERROR_AND_MASK, PHB_LEM_ERROR_OR_MASK,
+     * both regs are write-only and should be read as 0.
+     */
+    phb4_xscom_write(PHB_LEM_ERROR_AND_MASK, PPC_BITMASK(0, 63));
+    val = phb4_xscom_read(PHB_LEM_ERROR_AND_MASK);
+    g_assert_cmpuint(val, ==, 0x0);
+
+    phb4_xscom_write(PHB_LEM_ERROR_OR_MASK, PPC_BITMASK(0, 63));
+    val = phb4_xscom_read(PHB_LEM_ERROR_OR_MASK);
+    g_assert_cmpuint(val, ==, 0x0);
 }
 
 static void phb4_tests(void)
@@ -96,6 +149,9 @@ static void phb4_tests(void)
     /* Check sticky reset of a register */
     phb4_sticky_rst_test(qts);
 
+    /* Check write-only logic */
+    phb4_writeonly_read_test(qts);
+
     qtest_quit(qts);
 }
 
-- 
2.47.3


