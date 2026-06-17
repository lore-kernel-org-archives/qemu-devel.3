Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D911CD98F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmw1-0005gK-7p; Wed, 17 Jun 2026 05:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmvz-0005dt-H9; Wed, 17 Jun 2026 05:51:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmvx-00040f-RB; Wed, 17 Jun 2026 05:51:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mTaE080213; Wed, 17 Jun 2026 09:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=B8LS3r
 jImZZHtTcnKKlmZtkIGoJntMJpYuliiQlGvAY=; b=Gy0qxFXFNfiSx47beXfpAM
 rQ/ijauoosvi78PWxnFlC0uWEOkixxq5DDNQV1bEo9mI0syO/O6Rlh/Dbj8mu2qy
 qVO2ZCeNwgM9dCdF2gzuNItxKOYProTHixWDiMWiCVFADTNMnW03heRok0L36fVQ
 pc9fO3WXucIbbbicjsDoDVWLaUftU66O/u4IHW2OKh8j/RRbyFCUMkc1/wUot6b4
 eizISPgo8dIfXn0DvcI/hx0bbLUkxUetqD7g+0vZJZYdXUhcwlX0hrgLwGe5kb5a
 xAUzn7KfV9G/xJiWaVAgvu1UX3li6y8WGP36XMri8Qm6NfukDrSpPTLY5580fJvQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ29aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9nfHB026023;
 Wed, 17 Jun 2026 09:51:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvajh9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H9pMvU27001534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 09:51:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A582058065;
 Wed, 17 Jun 2026 09:51:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10E6158059;
 Wed, 17 Jun 2026 09:51:21 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 09:51:20 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v5 7/9] pnv/phb5: Set link speed and width in the DLP training
 control register
Date: Wed, 17 Jun 2026 04:50:56 -0500
Message-ID: <20260617095058.652789-8-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX3a73Tydv6h4p
 V4T0vxRwOpHijWJhKoPCX2PfYm0ah3+Jw9D+V8hvncBb2CA88FzlUgztB4cCiBRHIAazFyemlEl
 9VC5tu61e3MNYNmnIvgkiYnBHHEc6uM=
X-Proofpoint-ORIG-GUID: jc9b3GClWQyb3wrXSgdIDnBj0R35XXvU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXxY9e6GAad65/
 Sjo2gfdlecBZxyklbfVtS5XHBkfrtza/yeJIlhWt6Itx8g6Qikxn7qSkrInOnyP78hiCa2Jbiab
 5S8uzqeEWWFuWI3DEy5xSrY09neZNIGJ5mD77KCINmgafBvkDjCr3rCZrft0g3po+ofoDyJV59T
 /L/D3H0Ku3m4r/XcnHNtpL72ScSzzFG7sroMDldH2WQmB5F1WTyN/fFXvOO/7VIlbnKmQTkamwj
 BA73VT6xkU8so3uzxQh0EvExGmpXzSnUMyo+39JI52MVNp1smYbv/TV9bdVe+ALS3iYlzC6a3/i
 zs4hVUOi02ZbkDFdNH7JAb18NfdB9eOEB42tYa/tVVi4fvMUych/ZeIYzTgxV8J1DCwhIJ4ifMr
 hAZnb9jAXN7BmkZqPrcgBWqLjBeANjh7oofHZnKHdF2kSCCExEv1PGEEJJt9HSMGYkd+2njXE6I
 21iCDOxpPKKOst/rWKQ==
X-Proofpoint-GUID: k-iYQNomFdNf-Evhqvhf8mdtZVT5EUgA
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a326e1d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=AEFhk3bnKYIRDrMN3YsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092
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

Get the current link-status from PCIE macro.
Extract link-speed and link-width from the link-status
and set in the DLP training control (PCIE_DLP_TCR) register.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
---
v5: Using be16_to_cpu as appropriate.
v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
v3: Updates for coding guidelines.


 hw/pci-host/pnv_phb4.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 125f610790..e9d9323dba 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -899,6 +899,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
     uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
+    uint32_t v, lnkstatus;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
         return pnv_phb4_config_read(phb, off & 0x3, size);
@@ -960,10 +961,27 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
         break;
 
-    /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
-        /* TODO: Do something sensible with speed ? */
+        /* Get the current link-status from PCIE */
+        lnkstatus = be16_to_cpu(pnv_phb4_rc_config_read(phb,
+                                exp_base + PCI_EXP_LNKSTA, 4));
+
+        /* Extract link-speed from the link-status */
+        v = lnkstatus & PCI_EXP_LNKSTA_CLS;
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
-- 
2.52.0


