Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D4BC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11AA-0003Z2-J6; Mon, 31 Aug 2026 08:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A7-0003Xb-16; Mon, 31 Aug 2026 08:30:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A5-00068C-0J; Mon, 31 Aug 2026 08:30:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBW9rx212179; Mon, 31 Aug 2026 12:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jA7P0K
 Cea/Edrx3NZNVHBVbIPDCcLKi2aoHaMvCA65U=; b=rSwsGp1tqYH+w66M+r0/Ux
 MJLa85PAcY4O/Vja0ojk9BDj2TPONVm4mawlmqJ+7zYv9sp7YPEqVq4tOIqNtidl
 NMvWpGBjUjydPCCrPXP5KXos8U/57fAuFOAI1zefC8CqmwF0hN6dAR2fwL5EXZmm
 7lHA/5JmXRgZzprKG4TkWVppVAJLDKPmVvbafBLkABfOD3TsCIqlT2KOyRO9921f
 xAEEfgVhIfHkw9gsVh/vG39w9jGIxACdLhic0O9gmWoyRiwnKF8d6aQaqdBrDKl8
 QRoGYgDhDvTxMkCMRprlcppEk5mq1khAre8V+VsfhglUD4PpG/+YSvk9estYcGCg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r15h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VCQIQ3003123;
 Mon, 31 Aug 2026 12:30:25 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vwvu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VCUOSL28836394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 12:30:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 605D058057;
 Mon, 31 Aug 2026 12:30:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6629D5805D;
 Mon, 31 Aug 2026 12:30:23 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 12:30:23 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 8/9] pnv/phb5: Implement IODA PCT table
Date: Mon, 31 Aug 2026 07:30:04 -0500
Message-ID: <20260831123005.1485518-9-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9573e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=zgsLwUnGCMBw8fX4dgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX52X5poemPJEc
 xM0RuBcbo+87P1ETibW90Etm1PvmKN3fjfDIt50xVVyIFLnfKMa6pAieSYZiXA6BHu+CLVLUjdQ
 8Egzp8HX/9+77l2res+Qpg5MHNCrAjM5eq2TxEbRnSLYVy6eUcrrgn3d/mnTprV2PzV5bev1gUL
 yT1APfYV/h6f/sEMOri5/YhNBSo6IXpQ1KTA5jrW08NboC+SaDoOW6Sy4HGMP+giuyhmecnxm9h
 Sw6GJpYtOswk7ygRTu3I2WVdbBDakVbDXQCtcs1Jg7QkYp8pnH60erBCyHK/9N2Vft/vn9VE7Iy
 8u3ajs03m7xPbMT67e0qFzQu4Mh0w59ysv+93oOIR0FtuB0cGe64Fj+o1+5dlMOtvPMZsfz6OVi
 MYpcvuGuznCmjAgqZclTEyRb8rY4wupnJ1Ehi5qYf5DXftQKDTMaQ6T9iPU20CfA8Ta8RP2GrmI
 UwWn3ZVlml6UWW8e/Kg==
X-Proofpoint-GUID: W5Tw5IMcIGXvHj_AuIvxxlhyAxyfHNY2
X-Proofpoint-ORIG-GUID: lWF2j0SwOVF9YTpt6ZxsUea50DqF3bwc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX7mo4YKZ1V//y
 IRY7BIqGOtjLRhB0Hqj0C2Hr5r9NHI3wq4Bc5yiZdaHeu6tCjuM+qWvNAMblR9/Xx5Jtz/7skCK
 JPk8RbEtM2hqPihU88VDLjr758jN/3Y=
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

IODA PCT table is implemented
without any functionality, being a debug table.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c              | 7 +++++++
 include/hw/pci-host/pnv_phb4.h      | 2 ++
 include/hw/pci-host/pnv_phb4_regs.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 56952a6200..5f84550a7c 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -264,6 +264,11 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
         mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
         mask -= 1;
         break;
+    case IODA3_TBL_PCT:
+        tptr = phb->ioda_PCT;
+        mask = phb->big_phb ? PNV_PHB4_MAX_PCT : (PNV_PHB4_MAX_PCT >> 1);
+        mask -= 1;
+        break;
     case IODA3_TBL_RCAM:
         mask = phb->big_phb ? 127 : 63;
         break;
@@ -362,6 +367,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
     /* Handle side effects */
     switch (table) {
     case IODA3_TBL_LIST:
+    case IODA3_TBL_PCT:
+        /* No action for debug tables */
         break;
     case IODA3_TBL_MIST: {
         /* Special mask for MIST partial write */
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 33e11a3fe8..8d5822f339 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
 #define PNV_PHB4_MAX_LSIs          8
 #define PNV_PHB4_MAX_INTs          4096
 #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
+#define PNV_PHB4_MAX_PCT           (128 * 2)
 #define PNV_PHB4_MAX_MMIO_WINDOWS  32
 #define PNV_PHB4_MIN_MMIO_WINDOWS  16
 #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
@@ -138,6 +139,7 @@ struct PnvPHB4 {
     /* On-chip IODA tables */
     uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
     uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
+    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
     uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
     uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
     uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index 9ad6713d37..897c869d20 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -478,6 +478,7 @@
 
 #define IODA3_TBL_LIST          1
 #define IODA3_TBL_MIST          2
+#define IODA3_TBL_PCT           3
 #define IODA3_TBL_RCAM          5
 #define IODA3_TBL_MRT           6
 #define IODA3_TBL_PESTA         7
-- 
2.52.0


