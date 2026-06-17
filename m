Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FE1CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmw4-0005kS-Dr; Wed, 17 Jun 2026 05:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmw2-0005hG-Mt; Wed, 17 Jun 2026 05:51:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmw1-00044s-1I; Wed, 17 Jun 2026 05:51:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mKls4127616; Wed, 17 Jun 2026 09:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mG+IXzg+dXvF762/I
 XElJ2kHeXc7kSAfN6NBSZPyt3g=; b=rJe5fmfeQl/9KuodqFEN6lAT7gLz36WRj
 ysFuBv0yl0/vL+bae2F1F4PegUXjB+t/mxhbi1M+jMve/+mUkUZ3hlQwYpFJzJpm
 oseYEjr8WdiEBKWv0kB/hxo03Xz/Kvimggtvnult5gJBlHTwpFBQy9QoyLvWifF6
 v79Wt88JHhqjY0o7eGkZRjDVyhCURXQAM13sMLHHbL9vmsWi5sIpFABUVunirGrN
 9ov0wA41O60nyN4hg+zqabuB/gfgF61hMmGwUeiVm/ozYIcBNcZK5uHXE92IwwVt
 w3SSLTOYOSeXkpUCpafZP4AhVMnDX/QkARLhXdAUioPGLhkdpeyJQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtj9nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9nbih023343;
 Wed, 17 Jun 2026 09:51:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvaah7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H9pL0q26673726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 09:51:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3CA558055;
 Wed, 17 Jun 2026 09:51:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47D8058059;
 Wed, 17 Jun 2026 09:51:19 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 09:51:19 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v5 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
Date: Wed, 17 Jun 2026 04:50:55 -0500
Message-ID: <20260617095058.652789-7-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FEbLCLki9I2p-3CGWZTbNyemmGkSZ4o8
X-Proofpoint-GUID: 0Eq8IA4_c3bPKKTFxFybm06o0falnCo8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXwKvcHBte70u5
 NQ2LPUg2jstfKGDhmTeMdRv3dOEb6KcSeWzoGrmpK8bxYhN2zicrBD+i8XyVrdkc1Gr4AFeaFx+
 /Uz+cMYt1h8E2fn+ECNaqy0DOA3/d/gpixUvfnjQ1eZyi9ybVnW34X8SvM94nQOtPL22+hAmPTx
 3p106Suu/JQp9SLj1utI3ZizYvXFk8sEyynREeB3WCaVBvyqv+gyapIpt1qFOuKOTXgVakCyiOT
 TlUFI2sWQ9VwN6Jgrbr79kfjPQnDjHZDoO64J8uwhekTELWILDvw5e/YpJsGyzytcDzphiE1wPi
 lCn8moCWIpDwDww3f4zWrbrwgEfuFOvfcae3r3oxA7Q78561LFh9+KDKVzzZtDvjRpO54uAWLrz
 AKj7rcBHq7Scl1v5SNRIGuUDmqE3UBxoEecoiRFdzU0XienLUSRzmR9zYAG4UhWY2AjWRTU/amY
 vL2z3vh6Pm0AFn9P0Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX/a9ozA4ZlveA
 SjeD3qDjW8ji13+Nz52jjTV0r/EjumbrsQWssuO5tqRA/z0pM3Pq3n+7IhDzWasWWcAwaFpOFAB
 zNXBa3iqsktVEJkYnVN/Fd3uAC4dUjU=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a326e1c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=SX2aUA2rIF85faSKF8YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170092
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Config-read the link-status register in the PCI-E macro,
Depending on the link-active bit, set the link-active status
in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
after config-reading the slot-status in the PCI-E macro.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
---
v5: Using be16_to_cpu as required.
v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
v3: Updates for coding guidelines.


 hw/pci-host/pnv_phb4.c | 61 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 838f9d3c23..125f610790 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -511,6 +511,21 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
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
+    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
+                        exp_offset + PCI_EXP_LNKSTA, 4)) &
+                        PCI_EXP_LNKSTA_DLLLA);
+}
+
 /*
  * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
  * RC-config space values and masks are LE.
@@ -727,6 +742,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
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
@@ -874,6 +894,10 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
+    /* Get the PCI-E capability offset from the root-port */
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+    uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
@@ -942,8 +966,38 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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
+        /*
+         * Config-read the PCI-E macro register for slot-status.
+         * Method for config-read converts to BE value.
+         * To check actual bit in the PCI-E register,
+         * convert the value back to host format.
+         * Clear the Presence-status active low bit.
+         */
+        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
+                                                4))
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
 
@@ -951,6 +1005,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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
2.52.0


