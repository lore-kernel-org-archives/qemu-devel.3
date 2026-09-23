Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B9C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nls-00084M-W8; Wed, 23 Sep 2026 10:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nlc-0007pA-QA; Wed, 23 Sep 2026 10:16:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9NlW-0005xA-6i; Wed, 23 Sep 2026 10:16:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8Zg2Q2908998; Wed, 23 Sep 2026 14:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rux/H3LAdtYio6jAJ
 mWWbniXXpuMoyoF5/Z26HUjjSU=; b=VCu1++c+8YFtZqtlQTez+uYarZLbJdRWa
 oan22ATkxIDuNElIk6V8ZFG4LNSbkpQIiQqiunsF4h8BAp0MBa3Teu46ZUu5fQyN
 Via94Lai5wP8LhVKN2QZ2m7WWBdTKEbuYxbKGLbTFuK9OobqiU5FnzSSkoiHprEi
 7vtvu3yJNvBUKRzyQ6vYU7/ik4rY85puR2HFl6ktJfsZJ1HJb2EN7cdIO4EpoDXu
 d7Jsyftcl3MQQnJYqY+q1faylXZNdaYa5gQw1xG/U7SBUu0st0xzEEOU38W96h6c
 apnPsCCT8EfsJRgsKxWPxPg2iZ5meZAHl+L9TI1VNVOTrsqIUYccQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ktsw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCSZ8X008421; Wed, 23 Sep 2026 14:15:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jsbfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFVQA27525654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD9055805B;
 Wed, 23 Sep 2026 14:15:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19EA358058;
 Wed, 23 Sep 2026 14:15:31 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:31 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 12/16] s390x/pci: Move max_dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed, 23 Sep 2026 09:15:14 -0500
Message-Id: <20260923141518.960364-13-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R4VrbnValn0Fqw5jGDsqHbF3y_s6VvNZ
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab3df06 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=wu6SjTzT1SSAPCv-QiYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX3dzFnOpra7Sk
 kZI7tj88Y/PjjP8w+49gpwgW2yAYsaautyu8GSIiyV82ZQKRHo0nwZUgdTOY0Z4EYnBHJytRV7Z
 vXqlG1vRY/wZ1qerG6qUeRGIgT/MkVMxQlRXTpeYxFHZ0BpJX/jP9gAu04s1iuMZ1afoMK3m+OV
 xN66I7vbBcYJ3wR65Jgz6MBrAncw3ss8nFNQMugpQraJ2gqkcY1YGfyfnGQmnYtOHZv14eGKmC/
 hr6Cbu72mNEaf0OW0iFsBfuMEzGS2OU/Po9yjQ50V4rCif5W3mXNgeeYMoDUDI6RspRVDvdi2y0
 cWhrPGvJWtgQ8vxl3G8GZdn5sRIYe0+XOWhzzj5jSHBatbUsoaLRwt50aw1y0vGYqrp0ce4k7Se
 izfJgRfF+60yJSEqvSKyaesg1B3vvXb+ADKL0xkEYuism5fdzHGx65N2tDSVDoJUq+hP6tq51rz
 1XOizKh9ndI9mZLFDbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX5G2sd9A1c/UB
 AB8a3qA2qQCBV++pi7XeRpejIc9CleZBNvGe8m9xwXQ6v/xovCn/vwGIT5Sect0GXazRK5x7woM
 /MVcO0W4sytQsgJIoC0Nvjs6B4hBiTg=
X-Proofpoint-GUID: R4VrbnValn0Fqw5jGDsqHbF3y_s6VvNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230056
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
there to simplify S390PCIIOMMU towards a structure that contains only the
IOMMU container information needed by the PCI layer for a given slot.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


