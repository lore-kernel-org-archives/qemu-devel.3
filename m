Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CF5C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nlg-0007oN-3x; Wed, 23 Sep 2026 10:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nky-0007fb-Ic; Wed, 23 Sep 2026 10:15:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nkw-0005vD-5O; Wed, 23 Sep 2026 10:15:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8ZXmQ2907148; Wed, 23 Sep 2026 14:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9BK6ZKqqogsiR1guH
 aTUccIjJ/PgjujuLN/O9iXIf90=; b=fZ/C1/fpKylvvTEJty/D0hm0crDRdPylo
 jtW46pohgflpxuP+4CM2uHFoiASq1I0jvqp27WiPnbb27zkmiIBIonucBY1EdeOS
 bQwnqHtQ9E/qWhCybvQ30t710wPmJmr7wwC8wW4s/5G4GLYcOqsrDv/jPzj8GNDT
 J5T53wBFvQwBxKkL/rSvvdIa2utqN7kHEA3JcKqSU89BfW2XWfbJ85zvHm6lId7b
 EmKlysyTmZ/Pi0zBxSSZ2UACNwpIlnOV48N4rG0/q92wDe793aDxEsZ2AhMWfvWP
 wLF+nElstRl4RI4ybE5Klp7Y51rI6nzDpGXAGW+v93Ao0CMgS9lrg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsbrpg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCro0a007937; Wed, 23 Sep 2026 14:15:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2s7gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFNHL11993620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B527A5805B;
 Wed, 23 Sep 2026 14:15:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F85958058;
 Wed, 23 Sep 2026 14:15:23 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:22 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 03/16] s390x/pci: Move iommu_mr from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed, 23 Sep 2026 09:15:05 -0500
Message-Id: <20260923141518.960364-4-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab3defe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=n4sMxHAKvM-efvCv8lMA:9
X-Proofpoint-ORIG-GUID: 6Iu0hHj-ylTBiaC6MZw_GetAs-uGftLw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXwB2ImG5hqQ7t
 4uFw3BM9+M7x/QoOvKT2+2VMam8gcx2+8r0rpsULlej2dEX7fHQ3bTnWdqfo564P4xtkzLmHn3Z
 8LCeR4ych5mOagf2a29A5FJc089tuaiuQIH49U2qUf5VqN0JIsTOQF7n7QMvS7JcVNP+3cR6/sy
 kEyaOQd9VpVLZ2h1cL1RUHh2zjdzahaS0FFTyNuDF3soxb09Sr5FCFvqH47Iuk0cq2zfwW5zB8v
 pSPubc46MpeLULXQ3zqrYjDCHBzO3DsgWyhjYcLEfJem9HYZQ8mhuybGNJRCsZKsl3pUObzX0Kp
 irpS3Q+UmrwdhUIMJ10YgTzG1pcJAVz1Ys2e6sTWbcbnqkFp6oZM4YsIFK+bkQzT5YSAs6q5kx4
 O+yhxTNt6Y4PgYVmJru930WFL1UN6NFeTWOXGyWv3wRU4vdd8KrydCloLaoDTiZ013j2ANaVR7v
 SfAgtvRN+cNm3wnjWLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX+C49th0ISL6G
 2ZI4CT51Jc44e1HayJv5x8Kqx1+UqKJI66TR6FxWo08JuebMYEVvqJVkX9jpEx7+7f03nhm0f8y
 st1OiCDGNkymsh5070mkXSY4xvsZ4SQ=
X-Proofpoint-GUID: 6Iu0hHj-ylTBiaC6MZw_GetAs-uGftLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
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
 hw/s390x/s390-pci-bus.c          | 35 +++++++++++++++++---------------
 hw/s390x/s390-pci-inst.c         | 28 +++++++++++++------------
 include/hw/s390x/s390-pci-bus.h  |  6 +++---
 include/hw/s390x/s390-pci-inst.h |  4 ++--
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 10b417a779..b6a03bcc6a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -207,7 +207,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
             pci_dereg_irqs(pbdev);
         }
         if (pbdev->iommu->enabled) {
-            pci_dereg_ioat(pbdev->iommu);
+            pci_dereg_ioat(pbdev);
         }
         pbdev->state = ZPCI_FS_STANDBY;
         rc = SCLP_RC_NORMAL_COMPLETION;
@@ -539,7 +539,8 @@ uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
 static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
                                           IOMMUAccessFlags flag, int iommu_idx)
 {
-    S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
+    S390PCIBusDevice *pbdev = container_of(mr, S390PCIBusDevice, iommu_mr);
+    S390PCIIOMMU *iommu = pbdev->iommu;
     S390IOTLBEntry *entry;
     uint64_t iova = addr & TARGET_PAGE_MASK;
     uint16_t error = 0;
@@ -593,18 +594,18 @@ err:
     return ret;
 }
 
-static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
+static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
 {
-    S390PCIBusDevice *pbdev = iommu->pbdev;
     S390IOTLBEntry entry;
     uint16_t error = 0;
     uint32_t dma_avail;
     hwaddr curr, end;
+    S390PCIIOMMU *iommu = pbdev->iommu;
 
     curr = iommu->pba;
     end = iommu->pal;
 
-    if (iommu->dm_mr || !pbdev) {
+    if (iommu->dm_mr) {
         /* If direct mapping is used, there are no guest tables to replay */
         return;
     }
@@ -629,7 +630,7 @@ static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
         if (entry.perm != IOMMU_NONE) {
             while (entry.iova < curr && entry.iova < end) {
                 if (dma_avail > 0) {
-                    dma_avail = s390_pci_update_iotlb(iommu, &entry);
+                    dma_avail = s390_pci_update_iotlb(pbdev, &entry);
                 } else {
                     /*
                      * There is no reliable method to request the guest to
@@ -654,9 +655,9 @@ static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
 static void s390_pci_iommu_replay(IOMMUMemoryRegion *mr,
                                   IOMMUNotifier *notifier)
 {
-    S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
+    S390PCIBusDevice *pbdev = container_of(mr, S390PCIBusDevice, iommu_mr);
 
-    s390_pci_ioat_replay(iommu);
+    s390_pci_ioat_replay(pbdev);
 }
 
 static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
@@ -778,19 +779,20 @@ static const MemoryRegionOps s390_msi_ctrl_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     /*
      * The iommu region is initialized against a 0-mapped address space,
      * so the smallest IOMMU region we can define runs from 0 to the end
      * of the PCI address space.
      */
     char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
-    memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
+    memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
     iommu->enabled = true;
-    memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
+    memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&pbdev->iommu_mr));
     g_free(name);
 }
 
@@ -816,8 +818,9 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
                                 iommu->dm_mr);
 }
 
-void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
     if (iommu->dm_mr) {
@@ -827,8 +830,8 @@ void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
         iommu->dm_mr = NULL;
     } else {
         memory_region_del_subregion(&iommu->mr,
-                                    MEMORY_REGION(&iommu->iommu_mr));
-        object_unparent(OBJECT(&iommu->iommu_mr));
+                                    MEMORY_REGION(&pbdev->iommu_mr));
+        object_unparent(OBJECT(&pbdev->iommu_mr));
     }
 }
 
@@ -1427,7 +1430,7 @@ static void s390_pcihost_reset(DeviceState *dev)
                 pci_dereg_irqs(pbdev);
             }
             if (pbdev->iommu->enabled) {
-                pci_dereg_ioat(pbdev->iommu);
+                pci_dereg_ioat(pbdev);
             }
             pbdev->state = ZPCI_FS_STANDBY;
             s390_pci_perform_unplug(pbdev);
@@ -1568,7 +1571,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         pci_dereg_irqs(pbdev);
     }
     if (pbdev->iommu->enabled) {
-        pci_dereg_ioat(pbdev->iommu);
+        pci_dereg_ioat(pbdev);
     }
 
     fmb_timer_free(pbdev);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 00a847f493..0772f04cc2 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -630,9 +630,10 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     return 0;
 }
 
-uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
+uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
                                S390IOTLBEntry *entry)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     S390IOTLBEntry *cache = g_hash_table_lookup(iommu->iotlb, &entry->iova);
     IOMMUTLBEvent event = {
         .type = entry->perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMAP,
@@ -662,7 +663,7 @@ uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
 
             event.type = IOMMU_NOTIFIER_UNMAP;
             event.entry.perm = IOMMU_NONE;
-            memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
+            memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
             event.type = IOMMU_NOTIFIER_MAP;
             event.entry.perm = entry->perm;
         }
@@ -680,13 +681,13 @@ uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
      * All associated iotlb entries have already been cleared, trigger the
      * unmaps.
      */
-    memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
+    memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
 
 out:
     return iommu->dma_limit ? iommu->dma_limit->avail : 1;
 }
 
-static void s390_pci_batch_unmap(S390PCIIOMMU *iommu, uint64_t iova,
+static void s390_pci_batch_unmap(S390PCIBusDevice *pbdev, uint64_t iova,
                                  uint64_t len)
 {
     uint64_t remain = len, start = iova, end = start + len - 1, mask, size;
@@ -704,7 +705,7 @@ static void s390_pci_batch_unmap(S390PCIIOMMU *iommu, uint64_t iova,
         size = mask + 1;
         event.entry.iova = start;
         event.entry.addr_mask = mask;
-        memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
+        memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
         start += size;
         remain -= size;
     }
@@ -801,14 +802,14 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             coalesce += entry.len;
         } else if (coalesce > 0) {
             /* Unleash the coalesced unmap before processing a new map */
-            s390_pci_batch_unmap(iommu, iova, coalesce);
+            s390_pci_batch_unmap(pbdev, iova, coalesce);
             coalesce = 0;
         }
 
         start += entry.len;
         while (entry.iova < start && entry.iova < end) {
             if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
-                dma_avail = s390_pci_update_iotlb(iommu, &entry);
+                dma_avail = s390_pci_update_iotlb(pbdev, &entry);
                 entry.iova += TARGET_PAGE_SIZE;
                 entry.translated_addr += TARGET_PAGE_SIZE;
             } else {
@@ -824,7 +825,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     }
     if (coalesce) {
             /* Unleash the coalesced unmap before finishing rpcit */
-            s390_pci_batch_unmap(iommu, iova, coalesce);
+            s390_pci_batch_unmap(pbdev, iova, coalesce);
             coalesce = 0;
     }
     if (again && dma_avail > 0)
@@ -1059,7 +1060,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     iommu->g_iota = g_iota;
 
     if (t) {
-        s390_pci_iommu_enable(iommu);
+        s390_pci_iommu_enable(pbdev);
     } else {
         s390_pci_iommu_direct_map_enable(iommu);
     }
@@ -1067,9 +1068,10 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     return 0;
 }
 
-void pci_dereg_ioat(S390PCIIOMMU *iommu)
+void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
-    s390_pci_iommu_disable(iommu);
+    S390PCIIOMMU *iommu = pbdev->iommu;
+    s390_pci_iommu_disable(pbdev);
     iommu->pba = 0;
     iommu->pal = 0;
     iommu->g_iota = 0;
@@ -1293,7 +1295,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
-            pci_dereg_ioat(pbdev->iommu);
+            pci_dereg_ioat(pbdev);
         }
         break;
     case ZPCI_MOD_FC_REREG_IOAT:
@@ -1304,7 +1306,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
-            pci_dereg_ioat(pbdev->iommu);
+            pci_dereg_ioat(pbdev);
             if (reg_ioat(env, pbdev, fib, ra)) {
                 cc = ZPCI_PCI_LS_ERR;
                 s390_set_status_code(env, r1, ZPCI_MOD_ST_INSUF_RES);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index eb15cb8b2d..a71f562dfc 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -276,7 +276,6 @@ struct S390PCIIOMMU {
     S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
-    IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     bool enabled;
     uint64_t g_iota;
@@ -354,6 +353,7 @@ struct S390PCIBusDevice {
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
+    IOMMUMemoryRegion iommu_mr;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
@@ -391,9 +391,9 @@ int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 bool s390_pci_is_translation_enabled(uint64_t g_iota);
-void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_enable(S390PCIBusDevice *pbdev);
 void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
-void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_disable(S390PCIBusDevice *pbdev);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
 uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index c782990e3b..38268c256e 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -99,7 +99,7 @@ typedef struct ZpciFib {
 } QEMU_PACKED ZpciFib;
 
 int pci_dereg_irqs(S390PCIBusDevice *pbdev);
-void pci_dereg_ioat(S390PCIIOMMU *iommu);
+void pci_dereg_ioat(S390PCIBusDevice *pbdev);
 int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra);
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
 int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
@@ -111,7 +111,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra);
 void fmb_timer_free(S390PCIBusDevice *pbdev);
-uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry);
+uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev, S390IOTLBEntry *entry);
 
 #define ZPCI_IO_BAR_MIN 0
 #define ZPCI_IO_BAR_MAX 5
-- 
2.34.1


