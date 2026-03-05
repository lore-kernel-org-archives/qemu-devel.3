Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7D9EEF30C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy1uW-0002Al-34; Thu, 05 Mar 2026 01:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vy1uB-0001y7-5N; Thu, 05 Mar 2026 01:09:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vy1u9-000180-AF; Thu, 05 Mar 2026 01:09:50 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624Endhs2358989; Thu, 5 Mar 2026 06:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=b+XhsK
 vRYPW3JE1OvwlBIyYvEPl0zOAy2CVX0NwTbwk=; b=eWjfHK4xbHmCyhuftd5XLi
 mzVh1VkSeEWeniEyAqPbQmSWHDswWrloZmryPfZZDCD/SBIYZMF46EmC+IZHxjuG
 tgQAC9O/26WY6ZlqgtePfpV0o/aSDBLnEg0TpRJWKrYx1W3rHAqWB6+xythrYjA5
 N1ifmFoXYhlOK+NAn8SjGxERmgWpyUbJxRcLiiWaJNpgudhnQLiPgEJAix5z+X8V
 lCWs8Wdbd0F2A3fD2U+mlp81w9t1lelDMJ+J4/69/hJTHdhkzVvlEuPp6+wTDNE6
 /OJtrCPGv7yqRjPDuqH9Gq6CdevGPZOcEZr7BaQpyBfTTFWkXCBV7wU6zPlePqQw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk41yuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 06:09:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62510Vvu008796;
 Thu, 5 Mar 2026 06:09:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1hjxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 06:09:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62569c9722610464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 06:09:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F9B158061;
 Thu,  5 Mar 2026 06:09:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 678F758058;
 Thu,  5 Mar 2026 06:09:37 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 06:09:37 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v4 7/9] pnv/phb4: Set link speed and width in the DLP training
 control register
Date: Thu,  5 Mar 2026 00:09:09 -0600
Message-ID: <20260305060923.3753402-8-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1Nk63443AgLpfJcSxwoftSHUdkp09hIO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA0NiBTYWx0ZWRfX1Ret0oC6jIG+
 TsCths/zSnGniT+WKNzyDo2soTa9YQPi9KXQdtSqnjaymBNCTRnes/Ey+/Fvm0mqzXPne4LdJoM
 YWjGLokHTYJkfPnggSJdGbHtP5M8C3IbEQBFbit99soiV8Bz9Ih78FzpbUTORySynoLLCCGcMMv
 KuZ2DgLYgxjZev4eFTtNmddrErR4Scp4ZYFvJhyg1XEQOoV0T/zcq+wT6zjq6JaSIbNOo/Fxihm
 HXBnCa9FaNJKam4PyJp1Rv/zAk8DnkI06tiQIz6FlnGXGWRPArEpSaJu41cf9JOq9VfWFk+yi6R
 7voBNeR9xMUKwrSL9V+JxhBs41AGqJutsE+xcv41to6Yx0bGeqMU1v39cDaVLr0NlrUdFHPlKFS
 JkWwC+E4J9TmPd1BSwFTZsN09G3L2YexwJcE9GksazlQ0clLYd3N79nFM+LUshdtyO8EcaFjm+t
 oIre/3ZiMTm7nlB7KUA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a91e25 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: mtAx2-57_bF9H3NRAXj8QPhiBliHY2Kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050046
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
v3: Updates for coding guidelines.

 hw/pci-host/pnv_phb4.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index c35f632e64..a6fa578e85 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -900,6 +900,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
     uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
+    uint32_t v, lnkstatus;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
         return pnv_phb4_config_read(phb, off & 0x3, size);
@@ -961,10 +962,27 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
         break;
 
-    /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
-        /* TODO: Do something sensible with speed ? */
+        /* Get the current link-status from PCIE */
+        lnkstatus = bswap32(pnv_phb4_rc_config_read(phb,
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
2.47.3


