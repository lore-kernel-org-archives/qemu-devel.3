Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B36CCD6E75
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVK85-0005Oa-4i; Thu, 04 Jun 2026 22:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK81-0005JW-Hk; Thu, 04 Jun 2026 22:17:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7y-0001mQ-JZ; Thu, 04 Jun 2026 22:17:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654HQBPo3444108; Fri, 5 Jun 2026 02:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=21wAnetksnyEMKaYw
 FAGBSun5+/pbul82YOTNXBd9SY=; b=UnCW6ZCMJSe2j1CWZ9kKK+iqS0kzpx8rf
 9uSV59dkacxlWaHMtPZiqWWc90cWtQmeEywFk3q5cpOZISMpgP6vT0Vptj2qYwCT
 xn8T+Up+6yaneqYRk7QPwbAQk0rnGCR9/8rc5zcS5ErXBKYAvmBH3SvTKNChSv5B
 A9TdCMrrJNBdAWdlzOL84IHUp+b91rRzDywFPf6Sr7y2VTV25PeSl3rbVxNWkPy0
 4YRDHxz3VcCX1twvlLKBVOPaQbJC4RJLIqPDTMr/MiSkyiTwr9o2l3zBEWTn1W4q
 2ulLvhKgtYMq8Vt+IkvJnaJxhA406bKuqUJQiq+XWE/RNYkOgI/oA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4jkhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655296Mx010128;
 Fri, 5 Jun 2026 02:17:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kfspx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6552HZFc31523456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 02:17:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F6DE58052;
 Fri,  5 Jun 2026 02:17:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6478D58056;
 Fri,  5 Jun 2026 02:17:35 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.240.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 02:17:35 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3 12/15] s390x/pci: Move max_dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Thu,  4 Jun 2026 21:17:25 -0500
Message-Id: <20260605021728.1125090-13-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605021728.1125090-1-kshk@linux.ibm.com>
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxOCBTYWx0ZWRfX9qIoHBpf0NnW
 3ZsAIGdkAsEsW9Ygvc1pktDfoIgWVzRwFeKGJQ05YhRoMS0dAguhB3/no54T7CTd30CI3Hu9gys
 dgaYI1zhnEzOPBjDJJiG9Tv/9TAj2JB5pXLOfkBwxFnTDBByoYrxqaJ4cqxevANhEDzaVHaMbdC
 VOAwBpEjvZ+BuRb48KG+h8zoP/oDZzrhqowbD4LuQEZDCLGgq1YAK8GcpwfOlfjq4gxeR4SD8pq
 nsOqSJjEEcR3i5FepIdeuQn4U+ILo1SjseDycIE76hoAQYTkSp7O7VV4TI3WMw0TMIowGSeMOcN
 n6/vjxb6cIJxDt/0ATtAwc/5aP1LjFx0LT57giHC7L8RH5gaSn70wmWG6CkUcYLNszJTRcL9xWS
 Na/zA0cYhwYH36gr5yCpcVCiqILbqEehOxJQTnoWVOeXQNbtlKyyLAuMyvXCOTaWAZq99Ywf0/u
 dOUN02cVZHYql2LNW3w==
X-Proofpoint-GUID: GDMgd9loATVyREYyhHTuctk3W-wSYwUg
X-Proofpoint-ORIG-GUID: GDMgd9loATVyREYyhHTuctk3W-wSYwUg
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2231c2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=YlvBUofuDPas7G3Xl8cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

This field is only used when S390PCIBusDevice exists, so it can be moved
there to simplify S390PCIIOMMU which purpose is just to store the "root"
AddressSpace.

This also allows to save/restore this field during migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-vfio.c        | 4 ++--
 include/hw/s390x/s390-pci-bus.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7c754b656d..093743f2f0 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -90,7 +90,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
     cnt->users = 1;
     cnt->avail = avail;
     QTAILQ_INSERT_TAIL(&s->zpci_dma_limit, cnt, link);
-    pbdev->iommu->max_dma_limit = avail;
+    pbdev->max_dma_limit = avail;
     return cnt;
 }
 
@@ -151,7 +151,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
      * to request that the guest free DMA mappings as necessary.
      */
     if (!pbdev->rtr_avail) {
-        vfio_size = pbdev->iommu->max_dma_limit << qemu_target_page_bits();
+        vfio_size = pbdev->max_dma_limit << qemu_target_page_bits();
         if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
             pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
         }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 1f5d8d4bd4..e3cbee2695 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t max_dma_limit;
 };
 
 typedef struct S390PCIIOMMUTable {
@@ -352,6 +351,7 @@ struct S390PCIBusDevice {
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
+    uint64_t max_dma_limit;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1


