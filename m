Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E61EC982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Cjg-0006bY-VJ; Thu, 17 Sep 2026 10:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1x7CjS-0006Z6-BQ; Thu, 17 Sep 2026 10:04:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1x7CjQ-0001Qg-Ah; Thu, 17 Sep 2026 10:04:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HE1PhW2697594; Thu, 17 Sep 2026 14:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=4R2dzHKiDJ7sTRUVNJ9RZlIdWASxwsV33dEo1UBm+
 ME=; b=YSXAyZ409+1E+QlxuK9iY2fcrfPIrK4i8NfntMSCxuqN/tC1uywWJ7gKM
 6MFZeDJwUq5nQPGorgW0ntTCQTGukOHcVJhJ+7oDmgJbPGPTMlHVerMnRxo82AcD
 cVXw4hMddsQCfIKSWK5opFtbSFeP3Sn83MBR1jPnPQ5DXoC9WwHZH6OlmoMiz7UZ
 0H10eWRhTZB7/PkOSSY7c/ZpG1qKoBlbc3Dhcm5+bvuRIvCN/oL7TbGKBk6gtvtU
 bsHAv7MsCZSiZL9sd9olpalhF5MmmCUaPuDeoz696IlKPrF5VuYXCXQnMCtqJdVy
 fWnMhvKGHDvfjcopRgim1bveFadGA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx842u2d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 14:04:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HDa3AP4151503; Thu, 17 Sep 2026 14:04:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gejag4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 14:04:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HE4nou13828660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 14:04:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B10558065;
 Thu, 17 Sep 2026 14:04:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AED6658052;
 Thu, 17 Sep 2026 14:04:48 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.238])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 14:04:48 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v2] s390x/pci: fix DMA slot leak on I/O TLB entry replacement
Date: Thu, 17 Sep 2026 10:04:31 -0400
Message-ID: <20260917140431.45343-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE5OCBTYWx0ZWRfXzfSINC12oUoL
 fBntGAk4hDF065mW1nONXESgJjaEEN5RhF04Pu9VQuyYhC6tVslxb2UKdQc7lnSvVyC4cK0v3CP
 5ZoZYpM3FRU0jMhb6v+VZKvv5IDvgyIJX2uT6Hrfox2zXo2nN0qGAwrhwo1hL8i18YakYmu9zvE
 8wO8pLoyPpCrKg8bmmoTJlo5SdXUgglB9pG7Lhot2hOekFXXTduMdw7oBX4dnOkj7LsPoicAn60
 NW98YFD88Rew8VUEKs/QH/IF4vAmVeF9hGdUnyHiB02HxkFoIPqiuW3WKQTkmw65t7HfBWZLLf0
 9nNQYRLcCBCFsyaZCbagsGuS/SS4tsNmJQwbn3WfiARRQNSOT09Vm8l9JA1jW1fFgOlaHuNM41t
 lK4zTGidlRY1SxNIMJrd4s7WxMAHQo1DXIifo8BjhqIN9oMGfICyx9FK7OgNOV8aY89rXhyMo14
 zedz/iE3fBwlq9y0zDQ==
X-Proofpoint-ORIG-GUID: qaH5cGVwITJwgdj1erEQP3-m5OtB2zsN
X-Proofpoint-GUID: qaH5cGVwITJwgdj1erEQP3-m5OtB2zsN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE5OCBTYWx0ZWRfX/PiR1orU5WGy
 +LeZ2bDIBcB5U43CyBjlKVrYG0eMZGbwfCSb+JgMkOp6v7my196ad+zULeNI6D7PWBSu1oTrseT
 gZm655mNv9PxyOoJDw7uUHdTbBwBlds=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aabf384 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=9xhCHi5sD7DbSV9palMA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170198
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
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b7de23c7d2..652e1712ec 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -655,6 +655,7 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
         goto out;
     } else {
         if (cache) {
+            /* valid->valid transitions reuse the DMA slot */
             if (cache->perm == entry->perm &&
                 cache->translated_addr == entry->translated_addr) {
                 goto out;
@@ -665,6 +666,9 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
             memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
             event.type = IOMMU_NOTIFIER_MAP;
             event.entry.perm = entry->perm;
+        } else {
+            /* invalid->valid transitions consume a new DMA slot */
+            dec_dma_avail(iommu);
         }
 
         cache = g_new(S390IOTLBEntry, 1);
@@ -673,7 +677,6 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
         g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
-        dec_dma_avail(iommu);
     }
 
     /*
-- 
2.55.0


