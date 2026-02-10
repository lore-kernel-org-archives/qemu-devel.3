Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942CAEA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo0l-0002Mh-6v; Tue, 10 Feb 2026 08:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpo0j-0002KP-Rf; Tue, 10 Feb 2026 08:42:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpo0i-0003Hy-4M; Tue, 10 Feb 2026 08:42:37 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61ABwtuf501539; Tue, 10 Feb 2026 13:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qxQJzP1/6E8GYWUza
 ILV/2Lg+XdZWAPa0N+uDJZFGnY=; b=k5FHKLKwwQF6t7mtvJ8WgjgncegYm8duT
 8ii9I4mUeTyQyoFGCcgmcnrRgsCPKZl44ocCRk+bVrcfketouo1AHU4HPOR60YRX
 AjY2+V99O5a3InLYCQ5bDGBNZW4rrLf9HGB+qD5f0lST6kQXiC6AEDD+xPWZZ56g
 56PglnhIe2nUmxPd0QuEa5oTWXYI5OZVH3lVNUmI/ysoKGSIwHzHfisXW0F6a2Ee
 i8YuZYrl6JEJMjsyTdbBQeEVDTvTyTOB60JiWSzyYdX7ny65rv00pRLGYojpLcc2
 ANCjs8WZdwEz/5/M5PmAkDby4VveR44hbOLTolx/WHIFQutuoovqw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w4euu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:42:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61ADITOZ002635;
 Tue, 10 Feb 2026 13:42:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqshnq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:42:25 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADgONP5767972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:42:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07BB95805D;
 Tue, 10 Feb 2026 13:42:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C684658054;
 Tue, 10 Feb 2026 13:42:22 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:42:22 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 6/9] pnv/phb4: Set link-active status in HPSTAT and LMR
 registers
Date: Tue, 10 Feb 2026 07:40:56 -0600
Message-ID: <20260210134110.1515322-7-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698b35c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=E9s9Sk2w9S_N8XOcZ00A:9
X-Proofpoint-GUID: _scJS16wOugyqyhp7N-PvDmKy8-Mx97z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMiBTYWx0ZWRfX9lYDIFfbeS/3
 G9fvnINwk6f/6Rn7q8uF/D5NTBQyOTZCKmBTQDOWYv2BTA+hfv9CBt2PnHXENXkGX4qfFwBipH4
 k8PdutPO67AzNrDt2ay2qTRfR+tuZHXCrB5oKSLdUTANZakZR7QQZc+/KhwFQ+fnayWAZoT8saF
 nunGbDRHuQbOKTi8ZQR9CxoyLi7I1KS22vJ8FJ19UzZZgubU9i7/BVvmgPoVZTKa4blNOZoTtNi
 znnaGPlCqZbvAQiENNnNcd9/AySf9go50sUr0u+sbWB0k04EPeC1VWSYMcU3E38XA38/IJTpDW5
 +kvowfw8siXWHQLPReIr3xY0MSNrN0aHge4BQGJ8aJ9UrHmNT6hUcyyGLJ+RSrk9qZkDeo0uYIv
 C/BclxkYDbeY6Adc/bOvSU2LzKjSOsGyj4iGGuoODDzJlimqnCX9Kui76U0lPvwULkxzig9/moR
 JzRnZ0Ge0RxXL0Vwr/w==
X-Proofpoint-ORIG-GUID: c7vRcfQUygkuy1cihp-9GaHTRpTP56na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100112
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Config-read the link-status register in the PCI-E macro,
Depending on the link-active bit, set the link-active status
in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
after config-reading the slot-status in the PCI-E macro.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
v3: Updates for coding guidelines.


 hw/pci-host/pnv_phb4.c | 60 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index c044e9d2a3..ebbdaf77b3 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -510,6 +510,20 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
     return rpc->exp_offset;
 }
 
+/*
+ * Config-read the link-status register in the PCI-E macro,
+ * convert to LE and check the link-active bit.
+ */
+static uint32_t is_link_active(PnvPHB4 *phb)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+    uint32_t exp_offset = get_exp_offset(pdev);
+
+    return (bswap32(pnv_phb4_rc_config_read(phb, exp_offset + PCI_EXP_LNKSTA, 4)
+                    ) & PCI_EXP_LNKSTA_DLLLA);
+}
+
 /*
  * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
  * RC-config space values and masks are LE.
@@ -728,6 +742,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         val = 0;
         break;
 
+    case PHB_PCIE_HOTPLUG_STATUS:
+        /* For normal operations, Simspeed diagnostic bit is always zero */
+        val &= PHB_PCIE_HPSTAT_SIMDIAG;
+        break;
+
     /* Read only registers */
     case PHB_CPU_LOADSTORE_STATUS:
     case PHB_ETU_ERR_SUMMARY:
@@ -943,8 +962,42 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
         return val;
 
+    /*
+     * Read PCI-E registers and set status for:
+     * - Card present (active low bit 10)
+     * - Link active  (bit 12)
+     */
     case PHB_PCIE_HOTPLUG_STATUS:
-        /* Clear write-only bit */
+        /*
+         * Presence-status bit hpi_present_n is active-low, with reset value 1.
+         * Start by setting this bit to 1, indicating the card is not present.
+         * Then check the PCI-E register and clear the bit if card is present.
+         */
+        val |= PHB_PCIE_HPSTAT_PRESENCE;
+
+        /* Get the PCI-E capability offset from the root-port */
+        PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+        PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+        uint32_t exp_base = get_exp_offset(pdev);
+
+        /*
+         * Config-read the PCI-E macro register for slot-status.
+         * Method for config-read converts to BE value.
+         * To check actual bit in the PCI-E register,
+         * convert the value back to LE using bswap32().
+         * Clear the Presence-status active low bit.
+         */
+        if (bswap32(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA, 4))
+                    & PCI_EXP_SLTSTA_PDS) {
+            val &= ~PHB_PCIE_HPSTAT_PRESENCE;
+        }
+
+        /* Check if link is active and set the bit */
+        if (is_link_active(phb)) {
+            val |= PHB_PCIE_HPSTAT_LINKACTIVE;
+        }
+
+        /* Clear write-only resample-bit */
         val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
         return val;
 
@@ -952,6 +1005,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     case PHB_PCIE_LMR:
         /* These write-only bits always read as 0 */
         val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
+
+        /* Check if link is active and set the bit */
+        if (is_link_active(phb)) {
+            val |= PHB_PCIE_LMR_LINKACTIVE;
+        }
         return val;
 
     /* Silent simple reads */
-- 
2.47.3


