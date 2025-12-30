Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91122E9413E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 10:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaWsJ-0004kA-Dw; Tue, 30 Dec 2025 05:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWsC-0004de-LD; Tue, 30 Dec 2025 05:22:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWsB-00034r-7A; Tue, 30 Dec 2025 05:22:40 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTFRcV3013397;
 Tue, 30 Dec 2025 10:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nUZGog
 GfvTIru2lxOUX29uomxupqPXHpRCgdDV+TC9s=; b=d4kE55fvBCVZLTP2ZJYhgC
 9e9o3m6odThvt3donB9wUCLTjfLHWOcmLkdwUd6l72U8bIWjheANJthG/vFVHu11
 SPw5MVJ7zAYUG2hdWbmx3Xy2Juu85N2GMwQW+uNqs1CZnF4Gu0SKGNTPNa+ZFT3M
 hUBxuv6eLVH8ic/XJSqgtS/XlIBoVR9x8axyXd61H/jT0aWrpJr6aMzxhx67LpEa
 1D4OSovCSF0yR/unb/lnIzVtEHFc6giN/YBjXV2WlUO6u7Fq2DKoh1mElgIUeiLG
 f4L/gY7A54CdXUnCms6WmS2Zhpd1YsmujhWZfn2Lo7dd5naluZg3ktXyZWbJ6wLQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vf1x50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BUAH3Px032672;
 Tue, 30 Dec 2025 10:22:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vf1x4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU7Uwow025057;
 Tue, 30 Dec 2025 10:22:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bau9k9d5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:35 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BUAMYxa24052238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Dec 2025 10:22:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAF3F58054;
 Tue, 30 Dec 2025 10:22:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1B525805C;
 Tue, 30 Dec 2025 10:22:32 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Dec 2025 10:22:32 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2 7/9] pnv/phb4: Set link speed and width in the DLP training
 control register
Date: Tue, 30 Dec 2025 04:21:25 -0600
Message-ID: <20251230102156.886288-8-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a9k9NESF c=1 sm=1 tr=0 ts=6953a7ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=_qjpHTQ_RxqDlWHkd1gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: tCNFvaqx0zKO9Q_1beKFS0L0kXWKdZ7C
X-Proofpoint-ORIG-GUID: NQHJPr9ZSbD3D6byV6CmoWG7r-hNz2WV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA5MiBTYWx0ZWRfX9yAx0OzKkoou
 MAT67xjNePLIkl4G27htkBDEL8rBoivI22XFw60NtmCGiiRUDapzAZ6ZQ1nc7ttzDFXHVicEmC0
 05kbRGOeqbq3dGvHDfGI+3DU6ODIS37IOKsta9zuZv5JrZekJkJ9X3/oOyZrYDe1wl0iUSxdyFx
 rmMRTa3GIqVe59uAFlwaGVJQlRp2hfE+rOk0RygpNgSaI119MzgLBDUBkVlxCOYaAY+p8+6hiZV
 Y7pTo1Iq3ooIq7vp/rbTY0vjx1y9g2gO+B94RQRcWSZoFvST59uFMcLJUcFY0w5neUKPjUKJHHz
 R10zdCi4Y6Jx5us07rmqNgACVFEO4O2E+njShPfqHqm5P4fZZRS1ycGjG0MRqYx2Eimhw8pfpjG
 7F+4l+BZTzyGNsDFq8HhXAO7sF9KPVSoRPoE92ZHTINLcrbFFPzINvOsvLejsVacMWGT3gIedtl
 974d/s8E47iLZd+1OMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300092
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

Get the current link-status from PCIE macro.
Extract link-speed and link-width from the link-status
and set in the DLP training control (PCIE_DLP_TCR) register.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/pci-host/pnv_phb4.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index be273c067a..ba351bb147 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -955,10 +955,29 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
         break;
 
-    /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
-        /* TODO: Do something sensible with speed ? */
+        /* Link training always appears trained */
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+
+        /* Get the current link-status from PCIE */
+        PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+        PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+        uint32_t exp_offset = get_exp_offset(pdev);
+        uint32_t lnkstatus = bswap32(pnv_phb4_rc_config_read(phb,
+                                exp_offset + PCI_EXP_LNKSTA, 4));
+
+        /* Extract link-speed from the link-status */
+        uint32_t v = lnkstatus & PCI_EXP_LNKSTA_CLS;
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
@@ -975,8 +994,8 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_HPSTAT_PRESENCE;
 
         /* Get the PCI-E capability offset from the root-port */
-        PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
-        PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+        pci = PCI_HOST_BRIDGE(phb->phb_base);
+        pdev = pci_find_device(pci->bus, 0, 0);
         uint32_t exp_base = get_exp_offset(pdev);
 
         /*
-- 
2.47.3


