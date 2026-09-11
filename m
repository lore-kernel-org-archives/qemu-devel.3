Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75989C88E59
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x534t-0008JU-48; Fri, 11 Sep 2026 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534d-0007yW-Cs; Fri, 11 Sep 2026 11:21:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534Z-0004l5-SN; Fri, 11 Sep 2026 11:21:55 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1g2K2143845; Fri, 11 Sep 2026 15:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5msSFBZFSz3QiEZHq
 quXq9/jt6MRDepF1uzVOiQ7gzw=; b=MISkPT6LzHK+sypP9+jwRxo3nX9LRP/zq
 nFevh/cYpeq/4wm1T33XivL5Y7GwATfHqowabw1G9xOTw5aoa3elw/0jtGV5Qxsl
 zlvT4ak/f+Vg5qyg6HW2Hu6TCg3T8t7kC2zZRlqI3gcC8g1DxsrsJPtnZhkPLZL4
 CBNzjXpcNqUZnDm2j3xeQuVwMdf/QxVQd2Y0QEBF4tXJSv6O/Z8/5pBvoWOVOsGc
 qF8PUW9o55A08Y1OJ2/MpzTseM5XaSK2fyr4yRLnNIw0Lm965EO71sTDe2n/DExR
 8Gk6w+suNlRSiBaOIraVWmxmR9cDNsTna3fKzcBocBlBRKLnRLmlQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8t480e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEo8d91802524; Fri, 11 Sep 2026 15:21:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtff29j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFLgdo7209780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:21:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DAD358061;
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1806B58063;
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v8 10/16] s390x/pci: Move pba from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri, 11 Sep 2026 10:21:31 -0500
Message-Id: <20260911152137.676602-11-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911152137.676602-1-kshk@linux.ibm.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX/HJWgTaib4pH
 jEprXBKj5tOGB8ZgbzK+8/BbpWdMOKJarM7g6STJmcye7YZBJ2yHgGbiK2OWIHYMa/WC4QqV6dR
 A+HbfQm3C+e0MFzDozzHHu21s385568=
X-Proofpoint-ORIG-GUID: GWzdVhoJyZ9NaKsfmzLYUVfvmH15WHkl
X-Proofpoint-GUID: GWzdVhoJyZ9NaKsfmzLYUVfvmH15WHkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX6+mIsuUMHdIs
 eGh70Ig2knIM5mSi3zu+HeYDBBNx46oDwIlL/mJmbVHJpwPbC9AOEBxbUWHuT8ibMpOpCFytBCE
 5LwYg4TnvXd6oikPeFk8cB566SIvn0Q/FHZNFM8ZGbTVGu/I+tkAVV7LiAxBrI9dpj8zKo11hRa
 bidbHp3u9iqHsrbiVAHZPmR2tA9fpu6W0XjVwt30FqSd6iX+vgI13NW7JcEyM4Rorlg1Rp6IbW7
 A7K5D2qVS4UkCDGwR0SMvzRn7xXVGlY1wafhSn5ZeOUffO3hY3qI0dOZdLG5Fs3Toxw+bew1mGj
 p5AF+Kd0YjhyjQBwFfZMkreA1ie4VU0iNKIGImVn9veQYRYIRGtuPpGpbi10K1CWbkI7LBiLcOa
 1DxwbZgrfKKe8iZsHdqpVDfNwm1L9cITpMXi27ZVUTLUDB5kxNigTlYQSb63pqii+TadKfvJB4z
 /UZA2KaL2h/MHLKPjRA==
X-Authority-Analysis: v=2.4 cv=PIGaavqC c=1 sm=1 tr=0 ts=6aa41c88 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=THYS1zffzJpO_GefUMYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
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
there to simplify S390PCIIOMMU towards a structure that contains only the
IOMMU container information needed by the PCI layer for a given slot.

This also allows to save/restore this field during migration.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  4 ++--
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index ec54eb64a6..6cf54b8ab6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -565,7 +565,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
 
     trace_s390_pci_iommu_xlate(addr);
 
-    if (addr < iommu->pba || addr > iommu->pal) {
+    if (addr < pbdev->pba || addr > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -602,7 +602,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     hwaddr curr, end;
     S390PCIIOMMU *iommu = pbdev->iommu;
 
-    curr = iommu->pba;
+    curr = pbdev->pba;
     end = iommu->pal;
 
     if (pbdev->dm_mr) {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 22b477ab38..aa2bc98254 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -770,7 +770,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < start || end < iommu->pba || start > iommu->pal) {
+    if (end < start || end < pbdev->pba || start > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -778,7 +778,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
      * If the specified range at least partially overlaps the registered
      * aperture, clamp the request to the aperture and ignore the rest.
      */
-    sstart = MAX(start, iommu->pba);
+    sstart = MAX(start, pbdev->pba);
     end = MIN(end, iommu->pal + 1);
 
  retry:
@@ -1054,7 +1054,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
         return -EINVAL;
     }
 
-    iommu->pba = pba;
+    pbdev->pba = pba;
     iommu->pal = pal;
     pbdev->g_iota = g_iota;
 
@@ -1071,7 +1071,7 @@ void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     s390_pci_iommu_disable(pbdev);
-    iommu->pba = 0;
+    pbdev->pba = 0;
     iommu->pal = 0;
     pbdev->g_iota = 0;
 }
@@ -1444,7 +1444,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         return 0;
     }
 
-    stq_be_p(&fib.pba, pbdev->iommu->pba);
+    stq_be_p(&fib.pba, pbdev->pba);
     stq_be_p(&fib.pal, pbdev->iommu->pal);
     stq_be_p(&fib.iota, pbdev->g_iota);
     stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index a7d1f1ade2..42f39a5cf0 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
 };
@@ -352,6 +351,7 @@ struct S390PCIBusDevice {
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
     uint64_t g_iota;
+    uint64_t pba;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1


