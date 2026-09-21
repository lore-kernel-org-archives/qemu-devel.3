Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D6FC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKU-0006eu-SZ; Mon, 21 Sep 2026 16:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKM-0006UL-Ne; Mon, 21 Sep 2026 16:09:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKK-0005Pt-Qp; Mon, 21 Sep 2026 16:09:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8VaH1711825; Mon, 21 Sep 2026 20:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NdUWY3U0Vhsf8HWZH
 iMs0eXyxmC4M014KnY9KH+3Rzc=; b=CNr8mCoEeKOjq5+ARO45rM+06sdGTKyH+
 AlTkFqTKPAaAQu3ZB76q2p++CqB2cOwEv9kSCX1mV0W9Rl7sbgm7bkfnQKb5s2fZ
 2WM+i9rQKN8InDZm03mGHIxZnH1LsPKo3NneZJbe8w44rH/ZYl2XoiQ3hwvTJCtb
 PQcBAjKXs9cARtGInwjrmVwDmrs8tCTMVNSIIq2LczNzBmDFn+womRMTvrUilIzk
 Je4WEF+VnO82Af5q/RZvBF/RSBygVm3Bn9w28FF+ijb2zOTbC1X+A/cuFq3HD4HK
 yVszoiOSe02k0guV36aKv8NtmlyRKLYHE8a2D161EEc+Hjt7IXJAQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1abwe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJUIMj1408451; Mon, 21 Sep 2026 20:08:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjpvmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8pgT33293018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2ECD758055;
 Mon, 21 Sep 2026 20:08:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0BC358043;
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Omar Elghoul <oelghoul@linux.ibm.com>, qemu-stable@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 32/33] s390x/pci: fix DMA slot leak on I/O TLB entry replacement
Date: Mon, 21 Sep 2026 16:08:29 -0400
Message-ID: <20260921200830.1302919-33-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZiwbUp7QrkusjK4cYH_X7l4NOGm-5s9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfXxHh/Qjh8deXk
 BpE5oIsxNllsvDZHGGvW53/5ZbOqXXVyYG27bJgcWj6muh+GWIPeXMizvIj3IltdbG4HOH5A1Hr
 RKMR2xqxJrjnYCBT33ClyWisCo99+yZuC+sYDk6DEJ2ell17JDXiWSD9usOuWxUdXvEnrSBsIGe
 WFXkKyhIatm6L/LLoyJ6aq+ZKEw0+9mua/0CasAcrpHBTzLsM3Rz0ZlDVtnuLXAwZ6lOXSZa9wd
 Br/d5U1AUWKr5wLdZE0fU398EMxt2QqM7FCYcRwf34nIlESSZV1Ib3fLavVs/Zl8cA+fE5nAGpk
 MJv/Ikn2xg1Edu4s62Hoh79zYPBsEw3JnhYB7RgDtsLr0yMYoMK4hu7ocyBP2fgdbOt9lKWSHaB
 3r0tXAPqvvKXplVMYKMJcOGCzpXpziJXRTem5G694NNRbjybBiSDQY4AXayzd/fkNuf8O71cpa1
 +HRTN2nRvO6jjYrR03g==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab18ed4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=9xhCHi5sD7DbSV9palMA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX+GTj0sh1EF0C
 XcRQeEBmisr944R1IGdqYU5Ut7NW17pQU7/jKEALDvM/XDlELAhzAvHMI51TD0YVQk1sUh7KQ7u
 2xdpTW312gKMMsEMF6gaEYEANwbjj7o=
X-Proofpoint-GUID: ZiwbUp7QrkusjK4cYH_X7l4NOGm-5s9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Omar Elghoul <oelghoul@linux.ibm.com>

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
Link: https://lore.kernel.org/qemu-devel/20260917140431.45343-1-oelghoul@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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


