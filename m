Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743F2CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFKi-0000Qq-9X; Fri, 09 Oct 2026 14:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKf-0000P8-RA; Fri, 09 Oct 2026 14:28:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKd-0001eF-Cv; Fri, 09 Oct 2026 14:28:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha1LF699164; Fri, 9 Oct 2026 18:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6/4plmZZhumT7WGhV
 3jiRvgbXYPg6r9h8y6yl0Pat1U=; b=bAX1RDoebT7Wg0LLoxUYlAWfDWEdiQBV/
 UKmyBLzgyAmLZwQ0XBZA8VHvlOwbOFM/NXZZc1q0RcQdjF6I9vvmCsC9i9beuUWR
 fFgDaDG2NDXdmyXaZr10dV3eOV2Ei0ZusP9NYx4G6QE+3HkYleUPQV/jpKV9gI5A
 aYKFuYtclaC6Uid1R8gdLm/n+sVffvBLeDL1WrHxtFBgxsdBkmt17f2invbYNM82
 fM/2/C33OkCs7ZdpfY50uGQCSXyhPdNFmBrnTkBsMoi2QTcE7sPUqii6e+A1zLeX
 YLkEe0sZuOFxmgf+/prQRj1RrAuA0q9I5mDXUSeiyF2Wz+3kmzPJg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74ter8q6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8SNm4126033; Fri, 9 Oct 2026 18:28:32 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u45mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISVX528115496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 593065805A;
 Fri,  9 Oct 2026 18:28:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 287A558054;
 Fri,  9 Oct 2026 18:28:30 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:30 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 03/19] s390x/pci: Move iommu_mr from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri,  9 Oct 2026 14:28:09 -0400
Message-ID: <20261009182825.148054-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXzNNjui08bgmJ
 uZhtGCy/pl6fbtau20rtrSy+k2CjWtFdSafuOUW5nsPapOnKooJ4VtD+/Ogrpxt9Vvb8WE2RsVe
 ElJaIC0rUv3BoyMbmeY1xLfYaJkvXxM=
X-Proofpoint-GUID: dTK5N5ramsValGmDm4dN71d_j2Kk-R6T
X-Authority-Analysis: v=2.4 cv=P42vFSAu c=1 sm=1 tr=0 ts=6ac93251 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=E7Q9Gpuie88_50F72KoA:9
X-Proofpoint-ORIG-GUID: dTK5N5ramsValGmDm4dN71d_j2Kk-R6T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX62nR7L8B4wpe
 FN2EGKckqJbXpTcHu0t5RgQY6o4LxbgR8CfTmJsOY8hPlKkn5MGpv4lz9/Fk4AMwUeeiRhJpQFI
 e5rU3ONpELgoyXOUGy0w+luKy0oQGqg1Ajd7DeTC4FkkdcyEnXM0owlN0xoywRl38hUGG10uB93
 C3Guk535XvYvv98mEVgHlUtQ7uTzeWkoftotbQyRbtOpXbBwbdMRQswl1IA+b8h+EQQYB3IiK9l
 AVqEZJbe2+Q1zLzk7INN0aI5Q6rh6o/7LfGrJ26IChUsadFZkJ6p7Uzp5rf64hnDew2BSQ0dz9o
 SPuja3D3A6eMREt2gL5yo470pb4dueZo0NbtjMLDLtgUc5PR3dxpJtKUEyJfnjiB7xgZaHXkyOK
 booJpbfOZhKi9B2XxCuKNNG4eYCzbnZkixhSmCcmlcPgiIkn9XqglEnmaBeMFPpDzXyio4El4J5
 eReUAJxcrzRYNVVufiQ==
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
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-4-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 35 +++++++++++++++++---------------
 hw/s390x/s390-pci-inst.c         | 28 +++++++++++++------------
 include/hw/s390x/s390-pci-bus.h  |  6 +++---
 include/hw/s390x/s390-pci-inst.h |  4 ++--
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b3f7b59422..e709d6e478 100644
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
@@ -630,7 +631,7 @@ static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
         if (entry.perm != IOMMU_NONE) {
             while (entry.iova < curr && entry.iova < end) {
                 if (dma_avail > 0) {
-                    dma_avail = s390_pci_update_iotlb(iommu, &entry);
+                    dma_avail = s390_pci_update_iotlb(pbdev, &entry);
                 } else {
                     /*
                      * There is no reliable method to request the guest to
@@ -655,13 +656,13 @@ static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
 static void s390_pci_iommu_replay(IOMMUMemoryRegion *mr,
                                   IOMMUNotifier *notifier)
 {
-    S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
+    S390PCIBusDevice *pbdev = container_of(mr, S390PCIBusDevice, iommu_mr);
 
     /*
      * The notifier argument is not used directly; s390_pci_ioat_replay()
      * broadcasts via memory_region_notify_iommu() instead.
      */
-    s390_pci_ioat_replay(iommu);
+    s390_pci_ioat_replay(pbdev);
 }
 
 static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
@@ -783,19 +784,20 @@ static const MemoryRegionOps s390_msi_ctrl_ops = {
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
 
@@ -821,8 +823,9 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
                                 iommu->dm_mr);
 }
 
-void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
     if (iommu->dm_mr) {
@@ -832,8 +835,8 @@ void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
         iommu->dm_mr = NULL;
     } else {
         memory_region_del_subregion(&iommu->mr,
-                                    MEMORY_REGION(&iommu->iommu_mr));
-        object_unparent(OBJECT(&iommu->iommu_mr));
+                                    MEMORY_REGION(&pbdev->iommu_mr));
+        object_unparent(OBJECT(&pbdev->iommu_mr));
     }
 }
 
@@ -1432,7 +1435,7 @@ static void s390_pcihost_reset(DeviceState *dev)
                 pci_dereg_irqs(pbdev);
             }
             if (pbdev->iommu->enabled) {
-                pci_dereg_ioat(pbdev->iommu);
+                pci_dereg_ioat(pbdev);
             }
             pbdev->state = ZPCI_FS_STANDBY;
             s390_pci_perform_unplug(pbdev);
@@ -1573,7 +1576,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         pci_dereg_irqs(pbdev);
     }
     if (pbdev->iommu->enabled) {
-        pci_dereg_ioat(pbdev->iommu);
+        pci_dereg_ioat(pbdev);
     }
 
     fmb_timer_free(pbdev);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index c5d87aa615..50514d02a6 100644
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
@@ -663,7 +664,7 @@ uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
 
             event.type = IOMMU_NOTIFIER_UNMAP;
             event.entry.perm = IOMMU_NONE;
-            memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
+            memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
             event.type = IOMMU_NOTIFIER_MAP;
             event.entry.perm = entry->perm;
         } else {
@@ -683,13 +684,13 @@ uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
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
@@ -707,7 +708,7 @@ static void s390_pci_batch_unmap(S390PCIIOMMU *iommu, uint64_t iova,
         size = mask + 1;
         event.entry.iova = start;
         event.entry.addr_mask = mask;
-        memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
+        memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
         start += size;
         remain -= size;
     }
@@ -804,7 +805,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             coalesce += entry.len;
         } else if (coalesce > 0) {
             /* Unleash the coalesced unmap before processing a new map */
-            s390_pci_batch_unmap(iommu, iova, coalesce);
+            s390_pci_batch_unmap(pbdev, iova, coalesce);
             coalesce = 0;
         }
 
@@ -812,7 +813,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         start = QEMU_ALIGN_UP(start + 1, entry.len);
         while (entry.iova < start && entry.iova < end) {
             if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
-                dma_avail = s390_pci_update_iotlb(iommu, &entry);
+                dma_avail = s390_pci_update_iotlb(pbdev, &entry);
                 entry.iova += TARGET_PAGE_SIZE;
                 entry.translated_addr += TARGET_PAGE_SIZE;
             } else {
@@ -828,7 +829,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     }
     if (coalesce) {
             /* Unleash the coalesced unmap before finishing rpcit */
-            s390_pci_batch_unmap(iommu, iova, coalesce);
+            s390_pci_batch_unmap(pbdev, iova, coalesce);
             coalesce = 0;
     }
     if (again && dma_avail > 0)
@@ -1079,7 +1080,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     iommu->g_iota = g_iota;
 
     if (t) {
-        s390_pci_iommu_enable(iommu);
+        s390_pci_iommu_enable(pbdev);
     } else {
         s390_pci_iommu_direct_map_enable(iommu);
     }
@@ -1087,9 +1088,10 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
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
@@ -1313,7 +1315,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
-            pci_dereg_ioat(pbdev->iommu);
+            pci_dereg_ioat(pbdev);
         }
         break;
     case ZPCI_MOD_FC_REREG_IOAT:
@@ -1324,7 +1326,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
-            pci_dereg_ioat(pbdev->iommu);
+            pci_dereg_ioat(pbdev);
             if (reg_ioat(env, pbdev, fib, ra)) {
                 cc = ZPCI_PCI_LS_ERR;
                 s390_set_status_code(env, r1, ZPCI_MOD_ST_INSUF_RES);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index a732ad652b..74f559deaf 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -277,7 +277,6 @@ struct S390PCIIOMMU {
     S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
-    IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     bool enabled;
     uint64_t g_iota;
@@ -355,6 +354,7 @@ struct S390PCIBusDevice {
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
+    IOMMUMemoryRegion iommu_mr;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
@@ -392,9 +392,9 @@ int pci_chsc_sei_nt2_have_event(void);
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
2.56.0


