Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64FAEA811A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo0a-0001Y6-SL; Tue, 10 Feb 2026 08:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpo0Z-0001Us-8o; Tue, 10 Feb 2026 08:42:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpo0X-0003Gr-DA; Tue, 10 Feb 2026 08:42:27 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A21NaA3344155; Tue, 10 Feb 2026 13:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=b+Z6VX
 SgIGl9rGJn9dkJWCJ7W53tYGvBFFIAymZaZ0k=; b=huF7CP76K/FiTZUHvvh4cV
 EjE/gsqbOLdOj/N9yB4DLQS9kGjWaod6ERluJQf1UAu5dYWt9MQCsDw7kuaQa6BI
 BQ+IGlk1kqXG6nzQvKHwNcXHnz6AMtrCGpE3JiGCtsgkgWuLWutExbqxCCtYuteE
 kQEC5882YdTmsWUK8T7cCbTOQ80w526aBVmzVOYr0KDYG57foJj3vyNlD8PxjoLA
 LGL2U6bbgzXjnUiZOcGQjJMT4xUlg0PacwJ6SZC0cnVBuK8WjQ5R7CJ4rcR5vboO
 nHMCfZ84pqLCwpDcw5I1aRaFGDzTS3OAZ0nXPkaDyHRHRSagQB4PqFRkzmYmpYcg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696utaxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:42:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A9CHp0008378;
 Tue, 10 Feb 2026 13:42:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3y9k35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:42:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADgESQ34013826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:42:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BD655805D;
 Tue, 10 Feb 2026 13:42:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F20758054;
 Tue, 10 Feb 2026 13:42:13 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:42:12 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 5/9] pnv/phb4: Implement write-clear and return 1's on
 unimplemented reg read
Date: Tue, 10 Feb 2026 07:40:55 -0600
Message-ID: <20260210134110.1515322-6-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMiBTYWx0ZWRfX2RkAfTabQo9a
 be1f+JfeRL+EZAq6yiwebC33YeX2/po3wzd3WcekY0oCnRFA8dzvwoK7LiihMM24lZkEYSAeEuO
 f+dqoMR03uqGYTr5fg/vDSO91ikanCru3jgPMaScR7xE3pXz1GyOCUbEjmFv8x3l8LCEDMuF7ac
 o12YqQzjiytGjj50U7o6T4sVA0fmfyeMmCjiItjFmzGN8TJJa4Wmc0znX7Ck2El9USIrDqw6/EX
 4bptDQla3z8rk66pG4jpPot3nub34SIoUAsjEMk4Em4TbCSVo9tr3P67Sl5VHf9KABGGEFdYBPz
 XWZUyTf+U7Pz+exShXu3ABZDmEBag+P6BLiB8AmuTrCJ3ym7533tGgkB8OrKSf8GuOBEj/9Jlvf
 Y88TZbEUxQgQ+WGWp76WovZZOyiUoorhkWliNLh87mIOG2POMlNG0V5xNzdQQ22p25eJHRzwkDX
 95E1KlIS0aQKz3aD07g==
X-Proofpoint-ORIG-GUID: 0XxLyN9fgRa1MALeN6tetdcHI7H1p9Rg
X-Proofpoint-GUID: 0gM3dmshvdaeoQ27O6TkmvfilyRgGIEA
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698b35b8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=kBXAIK7tWc9G5WBdYtYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100112
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement write-1-to-clear and write-X-to-clear logic.
Update registers with silent simple read and write.
Return all 1's when an unimplemented/reserved register is read.

Test that reading address 0x0 returns all 1's (i.e. -1).

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
v3: Updates for coding guidelines.


 hw/pci-host/pnv_phb4.c              | 190 ++++++++++++++++++++++------
 include/hw/pci-host/pnv_phb4_regs.h |  11 +-
 tests/qtest/pnv-phb4-test.c         |   9 ++
 3 files changed, 169 insertions(+), 41 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 07479346c2..c044e9d2a3 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -654,8 +654,41 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         return;
     }
 
-    /* Handle masking */
+    /* Handle RO, W1C, WxC and masking */
     switch (off) {
+    /* W1C: Write-1-to-Clear registers */
+    case PHB_TXE_ERR_STATUS:
+    case PHB_RXE_ARB_ERR_STATUS:
+    case PHB_RXE_MRG_ERR_STATUS:
+    case PHB_RXE_TCE_ERR_STATUS:
+    case PHB_ERR_STATUS:
+    case PHB_REGB_ERR_STATUS:
+    case PHB_PCIE_DLP_ERRLOG1:
+    case PHB_PCIE_DLP_ERRLOG2:
+    case PHB_PCIE_DLP_ERR_STATUS:
+    case PHB_PBL_ERR_STATUS:
+        phb->regs[off >> 3] &= ~val;
+        return;
+
+    /* WxC: Clear register on any write */
+    case PHB_PBL_ERR1_STATUS:
+    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR_LOG_1:
+    case PHB_REGB_ERR1_STATUS:
+    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR_LOG_1:
+    case PHB_TXE_ERR1_STATUS:
+    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR_LOG_1:
+    case PHB_RXE_ARB_ERR1_STATUS:
+    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR_LOG_1:
+    case PHB_RXE_MRG_ERR1_STATUS:
+    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR_LOG_1:
+    case PHB_RXE_TCE_ERR1_STATUS:
+    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR_LOG_1:
+    case PHB_ERR1_STATUS:
+    case PHB_ERR_LOG_0 ... PHB_ERR_LOG_1:
+        phb->regs[off >> 3] = 0;
+        return;
+
+    /* Write value updated by masks */
     case PHB_LSI_SOURCE_ID:
         val &= PHB_LSI_SRC_ID;
         break;
@@ -694,7 +727,6 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
     case PHB_LEM_WOF:
         val = 0;
         break;
-    /* TODO: More regs ..., maybe create a table with masks... */
 
     /* Read only registers */
     case PHB_CPU_LOADSTORE_STATUS:
@@ -703,6 +735,12 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
     case PHB_PHB4_TCE_CAP:
     case PHB_PHB4_IRQ_CAP:
     case PHB_PHB4_EEH_CAP:
+    case PHB_VERSION:
+    case PHB_DMA_CHAN_STATUS:
+    case PHB_TCE_TAG_STATUS:
+    case PHB_PBL_BUF_STATUS:
+    case PHB_PCIE_BNR:
+    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
         return;
     }
 
@@ -725,6 +763,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
             pnv_phb4_update_all_msi_regions(phb);
         }
         break;
+
     case PHB_M32_START_ADDR:
     case PHB_M64_UPPER_BITS:
         if (changed) {
@@ -772,27 +811,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         break;
 
     /* Silent simple writes */
-    case PHB_ASN_CMPM:
-    case PHB_CONFIG_ADDRESS:
-    case PHB_IODA_ADDR:
-    case PHB_TCE_KILL:
-    case PHB_TCE_SPEC_CTL:
-    case PHB_PEST_BAR:
-    case PHB_PELTV_BAR:
+    /* PHB Fundamental register set A */
+    case PHB_CONFIG_DATA ... PHB_LOCK1:
     case PHB_RTT_BAR:
-    case PHB_LEM_FIR_ACCUM:
-    case PHB_LEM_ERROR_MASK:
-    case PHB_LEM_ACTION0:
-    case PHB_LEM_ACTION1:
-    case PHB_TCE_TAG_ENABLE:
+    case PHB_PELTV_BAR:
+    case PHB_PEST_BAR:
+    case PHB_CAPI_CMPM ... PHB_M64_AOMASK:
+    case PHB_NXLATE_PREFIX ... PHB_DMA_SYNC:
+    case PHB_TCE_KILL ... PHB_IODA_ADDR:
+    case PHB_PAPR_ERR_INJ_CTL ... PHB_PAPR_ERR_INJ_MASK:
     case PHB_INT_NOTIFY_ADDR:
     case PHB_INT_NOTIFY_INDEX:
-    case PHB_DMA_SYNC:
-       break;
+    /* Fundamental register set B */
+    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
+    /* FIR & Error registers */
+    case PHB_LEM_FIR_ACCUM:
+    case PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
+    case PHB_ERR_INJECT ... PHB_ERR_AIB_FENCE_ENABLE:
+    case PHB_ERR_STATUS_MASK ... PHB_ERR1_STATUS_MASK:
+    case PHB_TXE_ERR_INJECT ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
+    case PHB_TXE_ERR_STATUS_MASK ... PHB_TXE_ERR1_STATUS_MASK:
+    case PHB_RXE_ARB_ERR_INJECT ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_ARB_ERR_STATUS_MASK ... PHB_RXE_ARB_ERR1_STATUS_MASK:
+    case PHB_RXE_MRG_ERR_INJECT ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_MRG_ERR_STATUS_MASK ... PHB_RXE_MRG_ERR1_STATUS_MASK:
+    case PHB_RXE_TCE_ERR_INJECT ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_TCE_ERR_STATUS_MASK ... PHB_RXE_TCE_ERR1_STATUS_MASK:
+    /* Performance monitor & Debug registers */
+    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
+    /* REGB Registers */
+    /* PBL core */
+    case PHB_PBL_CONTROL:
+    case PHB_PBL_TIMEOUT_CTRL:
+    case PHB_PBL_NPTAG_ENABLE:
+    case PHB_PBL_SYS_LINK_INIT:
+    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
+    case PHB_PBL_ERR_STATUS_MASK ... PHB_PBL_ERR1_STATUS_MASK:
+    /* PCI-E stack */
+    case PHB_PCIE_SCR:
+    case PHB_PCIE_DLP_STR ... PHB_PCIE_HOTPLUG_STATUS:
+    case PHB_PCIE_LMR ... PHB_PCIE_DLP_LSR:
+    case PHB_PCIE_DLP_RXMGN:
+    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_TRCRDDATA:
+    case PHB_PCIE_DLP_ERR_COUNTERS:
+    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
+    case PHB_PCIE_TRACE_CTRL:
+    case PHB_PCIE_MISC_STRAP ... PHB_PCIE_PHY_EQ_CTL:
+    /* Error registers */
+    case PHB_REGB_ERR_INJECT:
+    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
+    case PHB_REGB_ERR_STATUS_MASK ... PHB_REGB_ERR1_STATUS_MASK:
+        break;
 
     /* Noise on anything else */
     default:
-        qemu_log_mask(LOG_UNIMP, "phb4: reg_write 0x%"PRIx64"=%"PRIx64"\n",
+        qemu_log_mask(LOG_UNIMP,
+                      "phb4: unimplemented reg_write 0x%"PRIx64"=%"PRIx64"\n",
                       off, val);
     }
 }
@@ -880,36 +955,75 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         return val;
 
     /* Silent simple reads */
+    /* PHB Fundamental register set A */
     case PHB_LSI_SOURCE_ID:
+    case PHB_DMA_CHAN_STATUS:
     case PHB_CPU_LOADSTORE_STATUS:
-    case PHB_ASN_CMPM:
+    case PHB_CONFIG_DATA ... PHB_LOCK1:
     case PHB_PHB4_CONFIG:
+    case PHB_RTT_BAR:
+    case PHB_PELTV_BAR:
     case PHB_M32_START_ADDR:
-    case PHB_CONFIG_ADDRESS:
-    case PHB_IODA_ADDR:
-    case PHB_RTC_INVALIDATE:
-    case PHB_TCE_KILL:
-    case PHB_TCE_SPEC_CTL:
     case PHB_PEST_BAR:
-    case PHB_PELTV_BAR:
-    case PHB_RTT_BAR:
+    case PHB_CAPI_CMPM:
+    case PHB_M64_AOMASK:
     case PHB_M64_UPPER_BITS:
-    case PHB_CTRLR:
-    case PHB_LEM_FIR_ACCUM:
-    case PHB_LEM_ERROR_MASK:
-    case PHB_LEM_ACTION0:
-    case PHB_LEM_ACTION1:
-    case PHB_TCE_TAG_ENABLE:
+    case PHB_NXLATE_PREFIX:
+    case PHB_RTC_INVALIDATE ... PHB_IODA_ADDR:
+    case PHB_PAPR_ERR_INJ_CTL ... PHB_ETU_ERR_SUMMARY:
     case PHB_INT_NOTIFY_ADDR:
     case PHB_INT_NOTIFY_INDEX:
-    case PHB_Q_DMA_R:
-    case PHB_ETU_ERR_SUMMARY:
-        break;
-
-    /* Noise on anything else */
+    /* Fundamental register set B */
+    case PHB_CTRLR:
+    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
+    case PHB_TCE_TAG_STATUS:
+    /* FIR & Error registers */
+    case PHB_LEM_FIR_ACCUM ... PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
+    case PHB_ERR_STATUS ... PHB_ERR_AIB_FENCE_ENABLE:
+    case PHB_ERR_LOG_0 ... PHB_ERR1_STATUS_MASK:
+    case PHB_TXE_ERR_STATUS ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
+    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR1_STATUS_MASK:
+    case PHB_RXE_ARB_ERR_STATUS ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR1_STATUS_MASK:
+    case PHB_RXE_MRG_ERR_STATUS ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR1_STATUS_MASK:
+    case PHB_RXE_TCE_ERR_STATUS ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR1_STATUS_MASK:
+    /* Performance monitor & Debug registers */
+    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
+    /* REGB Registers */
+    /* PBL core */
+    case PHB_PBL_CONTROL:
+    case PHB_PBL_TIMEOUT_CTRL:
+    case PHB_PBL_NPTAG_ENABLE:
+    case PHB_PBL_SYS_LINK_INIT:
+    case PHB_PBL_BUF_STATUS:
+    case PHB_PBL_ERR_STATUS ... PHB_PBL_ERR_INJECT:
+    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
+    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR1_STATUS_MASK:
+    /* PCI-E stack */
+    case PHB_PCIE_BNR ... PHB_PCIE_DLP_STR:
+    case PHB_PCIE_DLP_LANE_PWR:
+    case PHB_PCIE_DLP_LSR:
+    case PHB_PCIE_DLP_RXMGN:
+    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_CTL:
+    case PHB_PCIE_DLP_TRCRDDATA:
+    case PHB_PCIE_DLP_ERRLOG1 ... PHB_PCIE_DLP_ERR_COUNTERS:
+    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
+    case PHB_PCIE_TRACE_CTRL:
+    case PHB_PCIE_MISC_STRAP ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
+    /* Error registers */
+    case PHB_REGB_ERR_STATUS ... PHB_REGB_ERR_INJECT:
+    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
+    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR1_STATUS_MASK:
+        break;
+
+    /* Noise on unimplemented read, return all 1's */
     default:
-        qemu_log_mask(LOG_UNIMP, "phb4: reg_read 0x%"PRIx64"=%"PRIx64"\n",
-                      off, val);
+        qemu_log_mask(LOG_UNIMP, "phb4: unimplemented reg_read 0x%"PRIx64"\n",
+                      off);
+        val = ~0ull;
     }
     return val;
 }
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index dfd0e01d1e..c1d5a83271 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -407,6 +407,7 @@
 #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
 #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
 #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
+#define PHB_PCIE_DLP_STR                0x1A18
 #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
 #define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
 #define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
@@ -417,6 +418,7 @@
 #define   PHB_PCIE_LMR_RETRAINLINK      PPC_BIT(1)
 #define   PHB_PCIE_LMR_LINKACTIVE       PPC_BIT(8)
 
+#define PHB_PCIE_DLP_LANE_PWR           0x1A38
 #define PHB_PCIE_DLP_TRAIN_CTL          0x1A40
 #define   PHB_PCIE_DLP_LINK_WIDTH       PPC_BITMASK(30, 35)
 #define   PHB_PCIE_DLP_LINK_SPEED       PPC_BITMASK(36, 39)
@@ -436,18 +438,21 @@
 #define   PHB_PCIE_DLP_DL_PGRESET       PPC_BIT(22)
 #define   PHB_PCIE_DLP_TRAINING         PPC_BIT(20)
 #define   PHB_PCIE_DLP_INBAND_PRESENCE  PPC_BIT(19)
-
+#define PHB_PCIE_DLP_LSR                0x1A48
+#define PHB_PCIE_DLP_RXMGN              0x1A50
+#define PHB_PCIE_DLP_LANEZEROCTL        0x1A70
 #define PHB_PCIE_DLP_CTL                0x1A78
 #define   PHB_PCIE_DLP_CTL_BYPASS_PH2   PPC_BIT(4)
 #define   PHB_PCIE_DLP_CTL_BYPASS_PH3   PPC_BIT(5)
-
 #define PHB_PCIE_DLP_TRWCTL             0x1A80
 #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
 #define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
+#define PHB_PCIE_DLP_TRCRDDATA          0x1A88
 #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
 #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
 #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
 #define PHB_PCIE_DLP_ERR_COUNTERS       0x1AB8
+#define PHB_PCIE_DLP_EIC                0x1AC8
 
 #define PHB_PCIE_LANE_EQ_CNTL0          0x1AD0
 #define PHB_PCIE_LANE_EQ_CNTL1          0x1AD8
@@ -459,6 +464,7 @@
 #define PHB_PCIE_LANE_EQ_CNTL23         0x1B08 /* DD1 only */
 #define PHB_PCIE_TRACE_CTRL             0x1B20
 #define PHB_PCIE_MISC_STRAP             0x1B30
+#define PHB_PCIE_PHY_EQ_CTL             0x1B38
 #define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 0x1B40
 #define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15 0x1B98
 
@@ -592,5 +598,4 @@
 
 #define IODA3_PEST1_FAIL_ADDR           PPC_BITMASK(3, 63)
 
-
 #endif /* PCI_HOST_PNV_PHB4_REGS_H */
diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
index 2078fab9a9..9ccb75cd5a 100644
--- a/tests/qtest/pnv-phb4-test.c
+++ b/tests/qtest/pnv-phb4-test.c
@@ -137,6 +137,12 @@ static void phb4_writeonly_read_test(QTestState *qts)
     g_assert_cmpuint(val, ==, 0x0);
 }
 
+/* Check that reading an unimplemented address 0x0 returns -1 */
+static void phb4_unimplemented_read_test(QTestState *qts)
+{
+    g_assert_cmpint(PHB4_XSCOM_READ(0x0), ==, -1);
+}
+
 static void phb4_tests(void)
 {
     QTestState *qts = NULL;
@@ -152,6 +158,9 @@ static void phb4_tests(void)
     /* Check write-only logic */
     phb4_writeonly_read_test(qts);
 
+    /* Check unimplemented register read */
+    phb4_unimplemented_read_test(qts);
+
     qtest_quit(qts);
 }
 
-- 
2.47.3


