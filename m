Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C23C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11A7-0003Xf-Cf; Mon, 31 Aug 2026 08:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A5-0003Wo-FZ; Mon, 31 Aug 2026 08:30:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A3-00067w-FV; Mon, 31 Aug 2026 08:30:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBW6YI212012; Mon, 31 Aug 2026 12:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gwQq0M04+SMgQGR7/
 0eOYy6XEbgRFNmBqXcvNu+wZ7E=; b=HqcmKRxM0OwNx4J7tpp4jtUo3gE5kqedq
 t5ZsgqMlbDT3ui61HMnqYHXNhzf0LR7pCNfU43uiGPV9A0JzEveRh8g4cdE3siKW
 QRKleQDMzy5Ci7GEzWoUBK3xpsYn1cJ+z0KFOrPWXJEBmSeEQ3YHTVf99xMfRuEG
 jl3dgmNYAIAY6aVapu6qLMTq/O14bo9BHU1f+6742BbysrX/iCXLQbpnN7CvqILj
 oUtiWDDiR0oS8qmtdnTMV8PozGtxUWpTBvO37R4rOGJdWi5XHE01nbBRpH62M3xG
 iBDIBwJmPXNEDCKQChrJyH+RIBmfKn0AJuScA1raxD4e4e1MREF8w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r15gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VCQG1g002277;
 Mon, 31 Aug 2026 12:30:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h5qtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VCUMZI10748570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 12:30:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42B9E58057;
 Mon, 31 Aug 2026 12:30:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48E1C5805D;
 Mon, 31 Aug 2026 12:30:21 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 12:30:21 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
Date: Mon, 31 Aug 2026 07:30:02 -0500
Message-ID: <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9573e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=SX2aUA2rIF85faSKF8YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX7TrG9RRoNLSo
 07mZOIDqCprh+7NXKkT66xP+Ava4zGODrcwXc+5RmJMrp7aPJjrTL0MUA5GLNT9fx4dJqO436x8
 RbZPvcmLYBLFwVL5+l08k03tEaiAk8X4TVwMEHTTmuGLDRf5K1TS2jr7c0hhq8QmrMTArc0riEv
 rHlMV1nzpQ8wtUJAKEl0vBvk6hqUnxtt5EJ5ze5tXPtnDMXOKDzABm3+uJNgW8Rtd6BqGwoA+Un
 OXwY17r8MlGw04E4KqeUTehiOL9hIPUU+IkJOYHlOLGePa+Yy8IGUDVJ9JP8eL9uXOSFEXbqtFU
 ikRYpTQSlrgxMYknlqlI582dI+IYNcu0PolgHA9d7keXmRRnhp6pMgGCc/kSSvrxie06gWuGEkH
 /lxezuiS3nAUq2CMTeChtdKCTVn7ZcpJYgxWGVB0VgTaIPUoJIMwckj2swx07UAVII2N6ZQi7aP
 Z26hFjiyotfGC2eoFZQ==
X-Proofpoint-GUID: F46mqANKBq1jXmJ-dZByjdNXgUUU3dkH
X-Proofpoint-ORIG-GUID: J01NdwwGwFilLC9JabrnvSm_m5mj6aK7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX5vvmANDn1ITA
 6vTwvdLFyyJkLJJubQomRCFtl+rxHFMfcTeNA0ttVX+qsWtOuw5i+clPq7ndH4MZ9JXe0W4RvbZ
 /ggXSg7tRyhCVdxLOExD9C5hGRNBFQQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310104
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
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 74 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index b13165f84d..87446aedc8 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -508,6 +508,34 @@ uint32_t get_exp_offset(PCIDevice *pdev)
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
+/*
+ * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
+ * RC-config space values and masks are LE.
+ * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
+ * Compute new value in LE domain.
+ * New value computation using sticky-mask is in LE.
+ * Convert the computed value from LE to BE before writing back.
+ */
+#define RC_CONFIG_STICKY_RESET(a, v, s) \
+    (pci_set_word(conf + (a), be16_to_cpu( \
+                     (be16_to_cpu(pci_get_word(conf + (a))) & (s)) | \
+                     ((v) & ~(s)))))
+
 void pnv_phb4_cfg_core_reset(PCIDevice *d)
 {
     uint8_t *conf = d->config;
@@ -680,6 +708,11 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
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
@@ -827,6 +860,10 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
+    /* Get the PCI-E capability offset from the root-port */
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+    uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
@@ -895,8 +932,38 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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
 
@@ -904,6 +971,11 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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


