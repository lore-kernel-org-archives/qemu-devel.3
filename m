Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BECCA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFKu-0000Z1-Ut; Fri, 09 Oct 2026 14:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKo-0000Wd-VV; Fri, 09 Oct 2026 14:28:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKl-0001fy-UH; Fri, 09 Oct 2026 14:28:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha6W1736856; Fri, 9 Oct 2026 18:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GHT8+IyQaitbPXrd3
 fTw7v3FivE0wPnMxeOpHD6ebUM=; b=YHDnUJhBK+cSVjW6OUBoudJwIz70FcZU+
 EvkxiTHrKmRzHLSt+6nKY2bjCg+kX61Arlp/fDQAUxYFmLSDhbglhqJcGGG1SNKY
 m/lVA0pxoteNtd/OsL3GHGjPpn6t8peMJZzYA4PgAdki+6rMya2OtfMbalePB8IN
 eojhK3apfYt6S5IaShm+h9brjzui+wuC+esOaVLB5d3VF8/i7qbadUE0KLtCygvr
 L3RkBVMP+3laENXN3SXCJhq5wB//CPuQ4d7GNnoY5GaG6HI9XqCcJczWTPQVPqDY
 4PppDJade7i2N9oZcI1bi266LanzQjA4MdsULaP0a1FjP/jZouZFA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdr88h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8GKO1162533; Fri, 9 Oct 2026 18:28:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76t5ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISd8Z30868216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D542758054;
 Fri,  9 Oct 2026 18:28:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D18FD5805A;
 Fri,  9 Oct 2026 18:28:38 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:38 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 10/19] s390x/pci: Move pba from S390PCIIOMMU to S390PCIBusDevice
Date: Fri,  9 Oct 2026 14:28:16 -0400
Message-ID: <20261009182825.148054-11-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JL6uIMKb c=1 sm=1 tr=0 ts=6ac9325a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=THYS1zffzJpO_GefUMYA:9
X-Proofpoint-ORIG-GUID: uGOYk6Kpl0N4RJQcCqcPtoIE-qmpVpsN
X-Proofpoint-GUID: uGOYk6Kpl0N4RJQcCqcPtoIE-qmpVpsN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXz+K9peHdiClE
 wufqaki54Vi+8ljRrd/9uMjgc0TCyT7LEejpxI7zVACZfdj6mrz5vH+GktR0a5F5+f3gAB+Zq9H
 3tPbJTX4N3jBYjwp0nxeG3MTGB4nGbo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXwWi+OfjXEZHZ
 XOF81S6Sz9uUQubN9awFAZcdiLudtdLnyn4x7fMjvMOPeyQtQ3/bUoDZE5V8OET54/cCmZgJLk0
 BUyOWnZ6QApDM00LjbgrQRWvXPGuyCG3gXUP8UDoSkamA2BOvz6K5GgWIMOYOrndVboln0PWJgX
 uMqbRUS/KORkkW1O4Gpyqc+uRryfTOqBoRH/zzCqMim0bdmlBwHM943VjiATUGOrDScrnwxNzMB
 Alf1c6LOMYt0fCTTCVzF8+OMDkim0Gb8Hy0ymw74P2h8s9gJY/R+BctWBmQaKIq3baKceIqQV2F
 5G1hAL+jdahQYQY7uqpO+7z6phas7YEYPLDeaSzLUiMt9sGoQKvG1ObwyygJg1tP482JoO033i9
 xfx0bXVBXs4ITSuxlc9SDNtvTYljcgluykbMoDnx5CfyfI0SmLVWPdUuX5mNBXFsF6fwmA+O2Oi
 IqdS3S+B55HyANKYwrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090072
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

This field is only used when S390PCIBusDevice exists, so it can be moved
there to simplify S390PCIIOMMU towards a structure that contains only the
IOMMU container information needed by the PCI layer for a given slot.

This also allows to save/restore this field during migration.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-11-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  4 ++--
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 88ffa93977..b0aaea49cf 100644
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
index 3163539ead..1006b409e4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -773,7 +773,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < start || end < iommu->pba || start > iommu->pal) {
+    if (end < start || end < pbdev->pba || start > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -781,7 +781,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
      * If the specified range at least partially overlaps the registered
      * aperture, clamp the request to the aperture and ignore the rest.
      */
-    sstart = MAX(start, iommu->pba);
+    sstart = MAX(start, pbdev->pba);
     end = MIN(end, iommu->pal + 1);
 
  retry:
@@ -1074,7 +1074,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
         return -EINVAL;
     }
 
-    iommu->pba = pba;
+    pbdev->pba = pba;
     iommu->pal = pal;
     pbdev->g_iota = g_iota;
 
@@ -1091,7 +1091,7 @@ void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     s390_pci_iommu_disable(pbdev);
-    iommu->pba = 0;
+    pbdev->pba = 0;
     iommu->pal = 0;
     pbdev->g_iota = 0;
 }
@@ -1464,7 +1464,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         return 0;
     }
 
-    stq_be_p(&fib.pba, pbdev->iommu->pba);
+    stq_be_p(&fib.pba, pbdev->pba);
     stq_be_p(&fib.pal, pbdev->iommu->pal);
     stq_be_p(&fib.iota, pbdev->g_iota);
     stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 1bb1b87d52..82e79885e4 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -276,7 +276,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
 };
@@ -353,6 +352,7 @@ struct S390PCIBusDevice {
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
     uint64_t g_iota;
+    uint64_t pba;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.56.0


