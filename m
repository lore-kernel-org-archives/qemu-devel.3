Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F46CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFL5-0000gF-Ln; Fri, 09 Oct 2026 14:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKq-0000YA-Ic; Fri, 09 Oct 2026 14:28:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKo-0001gQ-Qj; Fri, 09 Oct 2026 14:28:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha1FM699055; Fri, 9 Oct 2026 18:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4nRQdjxnHZEozz+dq
 SC4RfhZ5eBX9sQ5dAGYRK63kKs=; b=g0Sa6mw7eH/PicF3iTp0JwuCofF8rJHhV
 p+7dYoukojtWQC+QiLUmOu7XiSH4+2K5FAKxM+9JJb9VsAb/adRinHPOO8oavP9w
 5t5i6ln75e08tjNXnhGsS0QV4HXzr8TT6IHnNQmNLJQQcIjrUhxIplnJDWAf5NiQ
 IlTFWHKf8vZObr2wnoSVDgKy8lo1cJsZHCGOcilKBubCtGBKa2WkPyAOywDRag73
 2c7B0WC/7tJHlunI73p3QG0+w67lbzHYUeMxxakHPly4SzwRqBS5oP+Pf1VcSdgQ
 Q3ZH8YcPfidTu7iAYuJOvAoFbzsL6u3qX1SsfHvMYO89JpwoB7y6A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74ter8qx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8G4c1206683; Fri, 9 Oct 2026 18:28:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnm7nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISgc021430744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 266D358054;
 Fri,  9 Oct 2026 18:28:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 494D05805A;
 Fri,  9 Oct 2026 18:28:41 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:41 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 12/19] s390x/pci: Move max_dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri,  9 Oct 2026 14:28:18 -0400
Message-ID: <20261009182825.148054-13-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX4mL7R1pdnvnj
 52CfZ52XMybXBzSqMuD3d2mkYmThwOFOQjq0okHmU/UyovM7LRktAQJ4nAO0rSfC040ZE627wfi
 HHFT0u9AAz+Qmy9cHWJQR4Sdr3qbI20=
X-Proofpoint-GUID: 5Bj8mdlgmjaVfpEdtiGkPBgJpezo7hMA
X-Authority-Analysis: v=2.4 cv=P42vFSAu c=1 sm=1 tr=0 ts=6ac9325c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=H9rQf2XcI7Xh5L5g7L0A:9
X-Proofpoint-ORIG-GUID: 5Bj8mdlgmjaVfpEdtiGkPBgJpezo7hMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX3Km2aEbHF5CR
 g2XFKDgUm0RQjIc6wLbXW1q+IviI7Pv4pivf4XNkKyyS4kZ9VravsFhfGUxW+vpefTTW1fl+z3r
 yoxreOVxE8KjqLTo9WXSW2zr9e0WoIHAVsEhOEv3GXImVmYsgldCXn075Vtdobqtf+XBJR4AEf1
 vP+EsLmNtriO03juvRVWIaXX39YGOV0LTDxKi4ScjSk8DeKlXrGLhw27O47jhKEG6S1qzLe+0VN
 u8fE34dkQ1aZTBaGyUpYJVb8/Cr0cqTPBidpKTABlZpCs+CPtXhFQX0TBpzxqMa4Fjvk9952zaR
 XUMIuGMIVnhtXsoGb8UuWsgcaSOK7vfNmqZPH0rD8ZGIFV2p1H7q1LcCCCAKUO4in0ihyqhxqbJ
 E2BOjI+T8jlAfcuPMyLZZxEYGVdf+rnD2Xv4V7POBRlhj9IPHZ6Y90EnF7//pkpqy8KxXLNON1b
 WIhTqoXLfovza6v2m0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

This field is only used when S390PCIBusDevice exists, so it can be moved
there to simplify S390PCIIOMMU towards a structure that contains only the
IOMMU container information needed by the PCI layer for a given slot.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-13-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
index 9332763522..c7fa7b9514 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -276,7 +276,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t max_dma_limit;
 };
 
 typedef struct S390PCIIOMMUTable {
@@ -353,6 +352,7 @@ struct S390PCIBusDevice {
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
+    uint64_t max_dma_limit;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.56.0


