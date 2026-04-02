Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DB71112276
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87pP-0004g8-Sd; Wed, 01 Apr 2026 22:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87or-0004Dt-Hm; Wed, 01 Apr 2026 22:30:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87op-0001mL-JE; Wed, 01 Apr 2026 22:30:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631Ik9883661500; Thu, 2 Apr 2026 02:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Gt8DeEfDIwQ0aIYf9
 Nv06cYAJNcblIALhEev2YCEqVo=; b=Wei/QR5gv2qlzxGH2P+GLGPQzvfK48wuk
 3FJm0rCqh3oyEyqHq4BikoN4bzu+vIOwvt4K7wx/Xok3XVAIaiK/zmxeZMCZn8sj
 kdyNx43F/R+FThxkq2DatJr7U/NAIkmwKbjTWkRzLBEWBE42heVJdKGIS435dbFP
 Yk6z0OCHlaY3nVhed8JmCEsh03n15bMR94ZK3sWt5i8KZ9TxGmNcUqOOGuXcIvUY
 fRhcbkw3lBb6FyTdPW3WIfeIbgMOnMuO6lL013WEjPG+maxNLSFEz2xF39Y/XKGW
 YYtIBMuSnlZavHXEorX1AI6tiBKoHeeq+AJ6uh01PeCp2kULAa5Fg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcj6d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321i8Gf031007;
 Thu, 2 Apr 2026 02:29:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk05hx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:58 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6322TuWc17367744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 02:29:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E21E3580F4;
 Thu,  2 Apr 2026 02:29:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59C5A580F6;
 Thu,  2 Apr 2026 02:29:56 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.247.119])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 02:29:56 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH 08/15] s390x/pci: Move dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed,  1 Apr 2026 21:29:14 -0500
Message-Id: <20260402022921.298818-9-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402022921.298818-1-kshk@linux.ibm.com>
References: <20260402022921.298818-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cdd4a7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NXusJeJlOfVlo0NZOjUA:9
X-Proofpoint-GUID: Cgg99t6P9cVcbu1MPGNq3SrU7o2ph2FN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAxOSBTYWx0ZWRfXz+DFBguv8VhU
 wCE3/OcIfkB7YsHfKDnBnLGsAOBd+2H5UvOTf3J2S2OsO/rFGvOf7eN9IalES5/fZrsUH1lsCcm
 7C/1FATtBHiL3DxrogxHfKoagMCgsmq4yIo7uwBiy3Ntgei8fc8gcZxUDN5DZu4lzt3xvBc7Q+8
 Nl8vUk+BG5qCJf9c6lW5pTie+ziOXlB8IvvQ6KfCsDOXX9UCrgvjZPPDqr7WHwvnr4SXigTfKve
 CyVqdGS2htw7zrggTdGzWWj5VutHBV0KGozY6jY0LxuSZrP/hCqE5tlvWgsXKkUAi44lCKLTIlu
 +xUirYiomqb2muQTRlgBtuvD4yms3SUGe+N+SHPZYB4K2pLrNykdk6SCD55x6WYKJcbtLo3+OXV
 448/li9ha0jmo590pGVeId7jo/oNY1GH6S+K9ldU1MZ5w/de4Wv88UAFR7JNxfxy24Ee6G5hCwd
 WmSAkBM2ayOQg06k/Cg==
X-Proofpoint-ORIG-GUID: Cgg99t6P9cVcbu1MPGNq3SrU7o2ph2FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020019
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 10 +++++-----
 hw/s390x/s390-pci-inst.c        | 23 +++++++++++------------
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 27ba3c801c..4a0b31b98b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -609,8 +609,8 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
         return;
     }
 
-    if (iommu->dma_limit) {
-        dma_avail = iommu->dma_limit->avail;
+    if (pbdev->dma_limit) {
+        dma_avail = pbdev->dma_limit->avail;
     } else {
         dma_avail = 1;
     }
@@ -1210,7 +1210,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     pbdev->forwarding_assist = false;
                 }
             }
-            pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
+            pbdev->dma_limit = s390_pci_start_dma_count(s, pbdev);
             /* Fill in CLP information passed via the vfio region */
             s390_pci_get_clp_info(pbdev);
             if (!pbdev->interp) {
@@ -1288,8 +1288,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
-        if (pbdev->iommu && pbdev->iommu->dma_limit) {
-            s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
+        if (pbdev->dma_limit) {
+            s390_pci_end_dma_count(s, pbdev->dma_limit);
         }
         g_hash_table_destroy(pbdev->iotlb);
         qdev_unrealize(dev);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 4458eae681..ac4e7f412d 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -28,17 +28,17 @@
 
 #include "trace.h"
 
-static inline void inc_dma_avail(S390PCIIOMMU *iommu)
+static inline void inc_dma_avail(S390PCIBusDevice *pbdev)
 {
-    if (iommu->dma_limit) {
-        iommu->dma_limit->avail++;
+    if (pbdev->dma_limit) {
+        pbdev->dma_limit->avail++;
     }
 }
 
-static inline void dec_dma_avail(S390PCIIOMMU *iommu)
+static inline void dec_dma_avail(S390PCIBusDevice *pbdev)
 {
-    if (iommu->dma_limit) {
-        iommu->dma_limit->avail--;
+    if (pbdev->dma_limit) {
+        pbdev->dma_limit->avail--;
     }
 }
 
@@ -616,7 +616,6 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
                                S390IOTLBEntry *entry)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     S390IOTLBEntry *cache = g_hash_table_lookup(pbdev->iotlb, &entry->iova);
     IOMMUTLBEvent event = {
         .type = entry->perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMAP,
@@ -634,7 +633,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
             goto out;
         }
         g_hash_table_remove(pbdev->iotlb, &entry->iova);
-        inc_dma_avail(iommu);
+        inc_dma_avail(pbdev);
         /* Don't notify the iommu yet, maybe we can bundle contiguous unmaps */
         goto out;
     } else {
@@ -657,7 +656,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
         g_hash_table_replace(pbdev->iotlb, &cache->iova, cache);
-        dec_dma_avail(iommu);
+        dec_dma_avail(pbdev);
     }
 
     /*
@@ -667,7 +666,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
     memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
 
 out:
-    return iommu->dma_limit ? iommu->dma_limit->avail : 1;
+    return pbdev->dma_limit ? pbdev->dma_limit->avail : 1;
 }
 
 static void s390_pci_batch_unmap(S390PCIBusDevice *pbdev, uint64_t iova,
@@ -744,8 +743,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     }
 
     iommu = pbdev->iommu;
-    if (iommu->dma_limit) {
-        dma_avail = iommu->dma_limit->avail;
+    if (pbdev->dma_limit) {
+        dma_avail = pbdev->dma_limit->avail;
     } else {
         dma_avail = 1;
     }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 24f6e60786..126a50c98b 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -279,7 +279,6 @@ struct S390PCIIOMMU {
     uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
-    S390PCIDMACount *dma_limit;
 };
 
 typedef struct S390PCIIOMMUTable {
@@ -353,6 +352,7 @@ struct S390PCIBusDevice {
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
+    S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
-- 
2.34.1


