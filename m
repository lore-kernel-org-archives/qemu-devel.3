Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB1DEA811A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo0n-0002R1-T6; Tue, 10 Feb 2026 08:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpo0l-0002NI-Gz; Tue, 10 Feb 2026 08:42:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpo0j-0003IU-TM; Tue, 10 Feb 2026 08:42:39 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AAMfpc348378; Tue, 10 Feb 2026 13:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N+ZjMg
 ZgtOzJcKLQl5aGQ8nA57L7MuJwiF0xXpPfGj8=; b=TS3XaRsVSU3G+lU4fUWh0o
 ozfkKz+N63gNxWsAPEhO96tm29zDekbB/U9UW6S5HGqgqMZ2o5tJw5s0KTQa0U07
 zM/0Je6WIoiNbSO0DxTZ4qUO21vdFnRGQDZxdQcII5KfuVWAK8+iPKyR/pgUF1GO
 uPXFMSo/mu6gL87eS1fnxrkA+DnAaiJJmNt7+0ouZihcHiIb02ih1cVQ/vc7CUFy
 yw/BZUBuWYmQzsqF+7hLSrAXdkE9nD9xvLQqH2lT5dJ7DiF5x/8XjMBuMyNtzY0e
 WMgtlhGiPL+av3FxuOxtU9FVed/5XevN/J0sGFzdeubO82x/Y99CnfXVPc1sHdyA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ucfy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:42:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AAEfno001408;
 Tue, 10 Feb 2026 13:42:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqn1ge8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:42:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADgVE326804800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:42:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 039E85805A;
 Tue, 10 Feb 2026 13:42:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB5BA58054;
 Tue, 10 Feb 2026 13:42:29 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:42:29 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 7/9] pnv/phb4: Set link speed and width in the DLP training
 control register
Date: Tue, 10 Feb 2026 07:40:57 -0600
Message-ID: <20260210134110.1515322-8-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698b35ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=VOsU92DsAUPXpT8d5pYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMiBTYWx0ZWRfXxX73PoROAgV8
 /pz598h90Mc7JjAKZvRkQtsWBrNb6l6k6a+Kv/9aenbbDEhOPAv2Qc/ZldYr4oLwLkWEHJ5EdeJ
 2va2Iax+jaSPqWLaF1y8lAwxVK99SkN8wtsTBeMFkDPg4cuuZ41mTJ9GvERYQadLlYYP2B41xV9
 0nGLL87yRiYIKCgUMA2dr1+1AJeIHlsFrZPVHWiD/FZ0VVBLQjDPE24qnXvlTxsBWQ8q3HZQqUh
 ah4PeRHLIl1OsNsV0ph+yk/HblQa8avp3AU+//Rddi8bU3EtwNjqo4W8h9KdC4MpjpEVLAFSjOX
 qF405MuG34GPsqjohptb+Z4d0ctB1EoHYfpCyvP2n87aUnOxeRu/206znl25ZbILqk1+/po3HCz
 Y5uAFnfqkPbd7K0110XhZKkJsWNArBIdNbgb2o1R65WCduW6Qqz/oxSqIDPflNWae7Nx2SzED9m
 sQof4PdX+kobtPKalJw==
X-Proofpoint-ORIG-GUID: zbHz562PC_RSXIl8XlflyxgV7RaWqlpg
X-Proofpoint-GUID: xjFOCeCCnzjD_8cPWMQ_resZHAjKLNgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100112
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

Get the current link-status from PCIE macro.
Extract link-speed and link-width from the link-status
and set in the DLP training control (PCIE_DLP_TCR) register.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
v3: Updates for coding guidelines.


 hw/pci-host/pnv_phb4.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index ebbdaf77b3..a7a4ba46db 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -956,10 +956,30 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
         break;
 
-    /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
-        /* TODO: Do something sensible with speed ? */
+        /* Get the current link-status from PCIE */
+        PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+        PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+        uint32_t exp_offset = get_exp_offset(pdev);
+        uint32_t lnkstatus = bswap32(pnv_phb4_rc_config_read(phb,
+                                exp_offset + PCI_EXP_LNKSTA, 4));
+
+        /* Extract link-speed from the link-status */
+        uint32_t v = lnkstatus & PCI_EXP_LNKSTA_CLS;
+
+        /* Link training always appears trained */
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+
+        /* Set the current link-speed at the LINK_SPEED position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
+
+        /*
+         * Extract link-width from the link-status,
+         * after shifting the required bitfields.
+         */
+        v = (lnkstatus & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
+        /* Set the current link-width at the LINK_WIDTH position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
         return val;
 
     /*
@@ -968,6 +988,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
      * - Link active  (bit 12)
      */
     case PHB_PCIE_HOTPLUG_STATUS:
+        /* Get the PCI-E capability offset from the root-port */
+        pci = PCI_HOST_BRIDGE(phb->phb_base);
+        pdev = pci_find_device(pci->bus, 0, 0);
+        uint32_t exp_base = get_exp_offset(pdev);
+
         /*
          * Presence-status bit hpi_present_n is active-low, with reset value 1.
          * Start by setting this bit to 1, indicating the card is not present.
@@ -975,11 +1000,6 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
          */
         val |= PHB_PCIE_HPSTAT_PRESENCE;
 
-        /* Get the PCI-E capability offset from the root-port */
-        PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
-        PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
-        uint32_t exp_base = get_exp_offset(pdev);
-
         /*
          * Config-read the PCI-E macro register for slot-status.
          * Method for config-read converts to BE value.
-- 
2.47.3


