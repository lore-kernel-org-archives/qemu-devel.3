Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38963C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4eoq-0001Pd-Tx; Thu, 10 Sep 2026 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1x4eoo-0001Ob-Gi; Thu, 10 Sep 2026 09:27:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1x4eom-0002yU-Ow; Thu, 10 Sep 2026 09:27:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ACVUiP1017614; Thu, 10 Sep 2026 13:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ZJfLxj1pht2kz1mYb8nn6icgteY8n9vb72O1GUrji
 4Q=; b=oFv9FVuzEJoelxfrKlWGNBYwHD4xEeFkMBqAY0+TKhWPZym/NPSMLHqgb
 l4nCg0leWza5P9bVr6smuOUs9U6VI5B4+xd/mM+mzhThPZXHS79oggJUTZfEO5La
 fTRIkQSwPUxtuc5+opyFu8OWK2KD8UsEcDOJ2j5YhGQok3JXjpq84YdSVzWsiX8E
 baTaGltV/Z8LKzcrB7ZpT2/Iz9tOfl/bM0uph08yFAarmVwXK5ddY1EHTjIHZQmc
 HwBwTimVW8Z9yxX61PV2A/eQ3uOLmHxDIAxcyvOJwWw0vIaAIQBOM6dKYvqXCgcC
 emcvDlvcUnW4M8LuC0UWrGsksRbqQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8n4swx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 13:27:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ADAObY064951; Thu, 10 Sep 2026 13:27:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2r7bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 13:27:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ADRp5u9896478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2026 13:27:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C40B5805F;
 Thu, 10 Sep 2026 13:27:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BBDF5805B;
 Thu, 10 Sep 2026 13:27:50 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.244.81])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2026 13:27:50 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v1] s390x/pci: fix DMA slot leak on I/O TLB entry replacement
Date: Thu, 10 Sep 2026 09:24:08 -0400
Message-ID: <20260910132408.12707-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa2b059 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=LIsPFFd6MgQa4MQ-8P8A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Nt656pUpSkqvXXdq81Dfk5JTEtNSdVa4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX8TyGQYX6xMy6
 qGpC0glaX/kxWlDSS5uLA8zsurpTKYxTV1XTfAkGkzLvEmgpK+oXLsecQJVk1ULdoUSfSE3exw4
 hHoqsEkPtHz0vh8cADTWk9Xgaxy0RcCDm/YqbRnkRGUAqLTK0ErwNRg10Yhx0hU4Qv99E3rzYGF
 yHeMLn9VxECT4cU+jbaxhAMZbeW2BaNAmX2cN+bkZpWqGSsLT1K6MbqymI/Ez4XzxJvfUOCcy16
 OYe0ZTI2ik+bSGxcN9Wfjal54OAOg0nBm0mzmYHPjFC3BLK7NYFegFm5Qu6LngWaoBij8JQA5Ur
 p4/fZNJgvG1YDqE7sbpoNzqMlyzmWTOI/KpHIXJwom6JI7OpSz9+VW4IP7pJzsAQJiCbcJMT6uC
 wN3st5cou8AieboCudIjaAIZOTZwRdCvGpjRdA+6K8UoqWAlKWxMN5DrXtFDuA4K7w8DEU1uxdS
 mE3aysMt4GjZvyoHOsQ==
X-Proofpoint-ORIG-GUID: Nt656pUpSkqvXXdq81Dfk5JTEtNSdVa4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX5uQSXw+y5kvj
 ylGqt/51nErVLTS/SzNkVCakahMe/qzArvEoZFd5Rf0Al+rqYd1hjLu1iAQ5ONRXUF8Xc84k20D
 W0WD4qbgWuk/Ca7TObBezBos6AaCHsQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100156
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

When s390_pci_update_iotlb() does a mapping update for an IOVA that has
an already-existing TLB entry with different permissions or translated
address, it unmaps then remaps it. However, at the end of the map path,
it unconditionally decrements the available DMA slot counter without a
corresponding increment in the intermediate unmap branch.

This causes the DMA slot count to be decremented on every remapping of
an active IOVA, leading to a permanent DMA slot leak. This remapping
without a prior invalidation and sync is not seen today in well-behaved
guests but is allowed by the architecture. Fix it by only decrementing
available DMA slots when inserting a brand new mapping.

Cc: qemu-stable@nongnu.org
Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b7de23c7d2..5840675aba 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -665,6 +665,9 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
             memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
             event.type = IOMMU_NOTIFIER_MAP;
             event.entry.perm = entry->perm;
+        } else {
+            /* only new mappings consume DMA slots */
+            dec_dma_avail(iommu);
         }
 
         cache = g_new(S390IOTLBEntry, 1);
@@ -673,7 +676,6 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
         g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
-        dec_dma_avail(iommu);
     }
 
     /*
-- 
2.55.0


