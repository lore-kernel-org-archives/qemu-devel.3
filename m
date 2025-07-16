Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9485BC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5WD-0001fc-AT; Wed, 16 Jul 2025 13:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uc5Vp-00013D-4r
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:01:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uc5Vm-0003cA-WC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:01:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEffnp022148
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ne5f7t4lbM5Rs2prVzxVMIFunk7Ki+/dI5GdDmPBT
 1Q=; b=ML0x6wPHeIlPizaNF5UvxI3/l/ng5WaFvN86ZJpQXoViMxV4+v+0tf9Vk
 sylqIZYqedEkeYgeOTi7pXmNB5w5PFafflWk6atJzdIXyGXjZk5kJCFfTPnQQMgn
 JNZ2xGXcvPaBNMaquNWL8VZhobMcFevaYlCuO9PZkymOdtYH8Kv5PnEJwL8gb1Cu
 xGlkWM1Dy+tkebxFW5Fh/eU/xTwlj2/ha9Y78LKe6Hvy9pBvx6IDPsjnF246+3Fn
 OrI4r/gnTLMAx/rAeX0UJAZVc/ggqYbnfuX334Y09h3eS5uLCE1Imw2aLJ+fF1fs
 G0C+fHISz9phwiES1MGNLezxiRP3w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamu1s00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:01:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56GGpSnC006078
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:01:38 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamu1ryw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 17:01:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFm6FV000722;
 Wed, 16 Jul 2025 17:01:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48m83a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 17:01:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56GH1a9726870442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 17:01:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 948D35805F;
 Wed, 16 Jul 2025 17:01:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17CF85805A;
 Wed, 16 Jul 2025 17:01:36 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Jul 2025 17:01:35 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, kowal@linux.ibm.com,
 saif.abrar@linux.ibm.com, npiggin@gmail.com
Subject: [PATCH] hw/pci-host: PowerNV PCIe Device On Small PHB Seg Faults
Date: Wed, 16 Jul 2025 11:50:03 -0500
Message-ID: <20250716165017.2770845-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BqekKlKO0i3KwCHhJJOIgLS9tgu32KLd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MSBTYWx0ZWRfX93tOhGF7306B
 a33UFhWh8Nu/NAQ/NojvHDS5LcYJnFUTLwkx5cMyjeOWjFnJYSmp/5TgEpqHOdDfjyl+qhsG3I4
 HNj4qA2lxsgt/VuHe083cFMMIUA4IsAQNqNecf9qRP1SRQ2zwSfWanR8qz0Kj21y3jJoyb2tXz6
 fsizH8bW/caJZaDIF9Msu4onr66Z1xrWHs9UL3BCwrl5JdCYvt0x8fPS6Dol2oeooA3jzVjALPv
 iVEhqQsoEsM5qv8qSZHHzsBE8HkGvAtT7uLRI2XKbwHGt3CefHEYMYw8f5r8dOPxdiQVcSqdCl1
 g3ZMVHgUmRFrAD75Nn2c777Xlheo9QDIY0ksgJaZWjEnZC0iGqaqS1gpnArI6IE1ovF0mSh/nG3
 0v/Rhw2YkyLjgPQeHEPgpq4R+OYBK2CeMGbjU9GiR4mL438uk2vTRGIxReranH8WeoUHDgGo
X-Proofpoint-ORIG-GUID: RZ_3i8n2aBlFz-ge19kftCJNNvd56csQ
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6877daf3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=fLpkDopDSWjLzx9oElYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=964 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PowerNV PCI Host Bridge (PHB) supports a large and small
configuration where the small configuration supports only
half the number of interrupts supported by the large configuration.

Since the PCIe LSIs are allocated at the end of the PHB IRQ list,
when calculating the LSI IRQ number, the code must take into
consideration the number of IRQ's supported by the PHB.  This
was not happening and was resulting in a QEMU segmentation fault
when a PCI device was added to a PHB with the small configuration.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 18992054e8..aeb2a45b4b 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1167,6 +1167,7 @@ static int pnv_phb4_map_irq(PCIDevice *pci_dev, int irq_num)
 static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
+    XiveSource *xsrc = &phb->xsrc;
     uint32_t lsi_base;
 
     /* LSI only ... */
@@ -1175,6 +1176,7 @@ static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
     }
     lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
     lsi_base <<= 3;
+    lsi_base &= xsrc->nr_irqs - 1;
     qemu_set_irq(phb->qirqs[lsi_base + irq_num], level);
 }
 
-- 
2.43.5


