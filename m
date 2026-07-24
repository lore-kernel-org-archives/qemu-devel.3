Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D27C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Ia-0000Fo-G7; Thu, 23 Jul 2026 23:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6IZ-0000Ei-8z; Thu, 23 Jul 2026 23:10:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6IX-0008Uh-9G; Thu, 23 Jul 2026 23:10:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLg8RB4108929; Fri, 24 Jul 2026 03:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=kgCUH7HAwvT99Xf29
 z+IEKyEOX0qbWMc5OTd9oaw06g=; b=fN0hrJN4sTRj6PWy7ipPuvvwkWnBcmCob
 +TPSNVesApEV6Bd9zOnvUxUNodGinOKWViqg3W1c2/tRLueZCGLT7gpOplCX8IhK
 sWLfqSKc0PuK/Z/IkO4acub3yRPlEdaEkZBhf0XZAYolG/GS8L/zmHEibtC98IHx
 sbjZwFP7OEIhzsddam74DaiYsm+FGWTvK3smj4t5jCr3XRkhmkR3A/NaEpQiYOpJ
 cNqYZFHS+sjhM138lhKccrb0hJ6Qie+cgTRamhBaeZyvQ9o/w4DGdBQxsuBF9vZM
 ehipHNoz8Bc9CZsvAZZk1D6aXBPB7SqMN3mLI5bxn6fxB+VMaFB1g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kj4ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O2ndd3004239;
 Fri, 24 Jul 2026 03:09:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgypw35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O394XE59113930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 03:09:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3AC758059;
 Fri, 24 Jul 2026 03:09:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 575D158053;
 Fri, 24 Jul 2026 03:09:39 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.161])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 03:09:39 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 12/15] s390x/pci: Move max_dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Thu, 23 Jul 2026 22:09:16 -0500
Message-Id: <20260724030919.123733-13-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030919.123733-1-kshk@linux.ibm.com>
References: <20260724030919.123733-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a62d776 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YlvBUofuDPas7G3Xl8cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX2px0V1LNdH3G
 VdGxrM2clbcDPHmL9KM95kMFSu3TUWjWy5XJej/5nhD9mIYEMgIKopYCgX8DOUkydiGsAxiyVXo
 vAnEZwG2ecXqdLpp07oUJSmcdrLChVpwR5xwErvDil7D8lDHNrc4pJDsFaePljVN6sW9i+9cCDK
 JsQF8GotRvBZ2WCMZWj+Nh2tWt2D2Kv0C2lDQurlU59wxcBt9wPX3wGiggqaRAaI2FvWc3+LsEf
 UWT6Yr5bwM0wzuGgo+MD1uSY+E5DrS9aO4GERWRQTV+QaFuXC5dUdZZqp8ohLOlywz6exI2Bc9X
 zL0rxoCkQk+QneRXFQ9andI8oOCNJpMMcc4LwxsATXqzzaYhCIPJczmqbsh0QGnTL8w2VIz+t7j
 TWNNKiZGC7DFbXBTe9ErJIhtaOZ/QqcqSuQcqqUWk5XIJA5uPuJevqWbvrAyPqyI1aYUR45t6XM
 NmfSsHncTwEwai+aDvg==
X-Proofpoint-ORIG-GUID: TCUjnnmLregSO-5EzIu3yvN_gQ_uRkfY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX1UqBbl4rjXP4
 3zWFXDJ0qu7qZ2a+DZEY9FxSrl6NMuSvjuIOWLodYPYyqHLisfEg+PhcwdvT/wsf77X1cvmFiO9
 3qvd3rK6jq6GNbfVSEAFCPTxbVu0yqY=
X-Proofpoint-GUID: TCUjnnmLregSO-5EzIu3yvN_gQ_uRkfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
index db6de00bd2..a035ba5b2c 100644
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
 
@@ -152,7 +152,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
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


