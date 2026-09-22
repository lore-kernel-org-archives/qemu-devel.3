Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985A5C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95NE-0007i8-WC; Tue, 22 Sep 2026 14:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mg-0007aE-3p; Tue, 22 Sep 2026 14:37:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95MX-0005vE-AY; Tue, 22 Sep 2026 14:37:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7bFI965137; Tue, 22 Sep 2026 18:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2J0jttHL2vogfDdlE
 759gBN/fuM/0Xw0MdkpRXjBCxU=; b=IFSQFQDb1xrW1yuheWemHhuyVEJwyXikb
 L/AEU1/eZKmfDZ4ioeUuLEo/BvprbzNAt1fzhKAJYOH26jtgDMvwChVgMf0d6cvQ
 5gAxmnLLZLaZrX+hMmvtJ1oHL4CiqSzPBe1eiwa8MFRo8PM89YxKE4Eum9WHxef/
 hLgoJNg1fA+imago3mtqYQgToK8gAKUSf3m8wxehCq+pFQIOlZ3owK/crj44DtBT
 gzpBxl3lKJKTsUz4DAaPd+bG4qHANd46GFbg7QPxeVRvnqlo2qD+7z1EUfLA2i4x
 z9rUdbSXS0HVVeFEOqI4nV7XiHluW/z0hKu8ldtgsTrazDG38e1XQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1f4yu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHU0T4187944; Tue, 22 Sep 2026 18:36:59 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyasre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MIavnq24248988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 18:36:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 658F658065;
 Tue, 22 Sep 2026 18:36:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3988B5805D;
 Tue, 22 Sep 2026 18:36:57 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.122])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 18:36:57 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v9 01/16] s390x/pci: implement IOMMU replay
Date: Tue, 22 Sep 2026 13:36:39 -0500
Message-Id: <20260922183654.798470-2-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922183654.798470-1-kshk@linux.ibm.com>
References: <20260922183654.798470-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kXgEGzEeG_fvvXM0VwK8TYZApK9NW83I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX4mt92fizKrJC
 LPq6IaWshERhG0JQIvHSOvU7B8YtgiDUmVPSk5avcUCzLvGGvoeePlUloMfun5PO+MyHKY3r5Cz
 /1VQYQbVSzek5eb91J1TmGCRaA6HYDxy8oGE5IwnGQWwDMjMxkZNs6iKRN4vaVeLe2kM5nkfFq9
 lfAg+DYELyIMNIg1mNKzrv2hTjvo395ddvNiZIBKDEU/JT5Ikv5XM5U529SZXKeSFUbc6HAEORG
 gERXxZuWEgBBWHuTIYAtYehQBO5jrdZVmGBHkxiWicLnxM0+FQYh7fOLBmgWQ9CK/zIr0xvfoxI
 Q3uWWILHPFsgmHIo6M119C1iKQDbPU+9QXqV8vPHWFATsmodrFGrQi8FrNgaBDI3kentiKaRc0v
 Yt+FyW4IUdZ8mP2HjL7vvGfVY4IoHKQXN/qApnXLDOg6waaZHSq7UP0K+akfxJj9eko5BTn1gwP
 mhZc4/sZg/U51uzs89Q==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2cacc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=uoNow8biE-CX8mucm5YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX26k/SIvhi+Zl
 jNfun8BysrD5ukNk3uOOUSbDOian9F7PogDynsxLLs2160ePD8ItrPui9A7t8iw4ES7OUS0Tmxu
 K+dFjyrZYwuWIxZvyJW++WZMt3MOPzg=
X-Proofpoint-GUID: kXgEGzEeG_fvvXM0VwK8TYZApK9NW83I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220273
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

There are a few scenarios where IOMMU replay can potentially be needed
for zPCI device, namely VFIO device reset scenarios where the guest
continues running and expects the contents of its IOMMU to be replayed
upon IOAT re-registration and migration scenarios where the destination
must reconstruct the IOMMU on the destination.

zPCI migration is not supported yet, but the IOMMU replay function is
implemented so that it can be called both from IOMMUMemoryRegionClass
now and migration post_load later.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 68 +++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-inst.c         |  4 +-
 include/hw/s390x/s390-pci-inst.h |  1 +
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eff980fdfe..10b417a779 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -593,14 +593,70 @@ err:
     return ret;
 }
 
-static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
+static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
+{
+    S390PCIBusDevice *pbdev = iommu->pbdev;
+    S390IOTLBEntry entry;
+    uint16_t error = 0;
+    uint32_t dma_avail;
+    hwaddr curr, end;
+
+    curr = iommu->pba;
+    end = iommu->pal;
+
+    if (iommu->dm_mr || !pbdev) {
+        /* If direct mapping is used, there are no guest tables to replay */
+        return;
+    }
+
+    if (iommu->dma_limit) {
+        dma_avail = iommu->dma_limit->avail;
+    } else {
+        dma_avail = 1;
+    }
+
+    while (curr < end) {
+        error = s390_guest_io_table_walk(iommu->g_iota, curr, &entry);
+        if (error) {
+            pbdev->state = ZPCI_FS_ERROR;
+            s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, curr,
+                                          0);
+            error_report("Failure to walk table during iommu remap");
+            return;
+        }
+
+        curr += entry.len;
+        if (entry.perm != IOMMU_NONE) {
+            while (entry.iova < curr && entry.iova < end) {
+                if (dma_avail > 0) {
+                    dma_avail = s390_pci_update_iotlb(iommu, &entry);
+                } else {
+                    /*
+                     * There is no reliable method to request the guest to
+                     * release mappings other than in response to a RPCIT
+                     * instruction; generate a permanent error condition and
+                     * require the device to be completely re-initialized from
+                     * the guest side.
+                     */
+                    pbdev->state = ZPCI_FS_ERROR;
+                    s390_pci_generate_error_event(ERR_EVENT_PERMERR, pbdev->fh,
+                                                  pbdev->fid, 0, 0);
+                    error_report("DMA mappings exhausted: iommu remap failed");
+                    return;
+                }
+                entry.iova += TARGET_PAGE_SIZE;
+                entry.translated_addr += TARGET_PAGE_SIZE;
+            }
+        }
+    }
+}
+
+static void s390_pci_iommu_replay(IOMMUMemoryRegion *mr,
                                   IOMMUNotifier *notifier)
 {
-    /* It's impossible to plug a pci device on s390x that already has iommu
-     * mappings which need to be replayed, that is due to the "one iommu per
-     * zpci device" construct. But when we support migration of vfio-pci
-     * devices in future, we need to revisit this.
-     */
+    S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
+
+    s390_pci_ioat_replay(iommu);
 }
 
 static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b7de23c7d2..37ca70dcf1 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -630,8 +630,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     return 0;
 }
 
-static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
-                                      S390IOTLBEntry *entry)
+uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
+                               S390IOTLBEntry *entry)
 {
     S390IOTLBEntry *cache = g_hash_table_lookup(iommu->iotlb, &entry->iova);
     IOMMUTLBEvent event = {
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index 5cb8da540b..c782990e3b 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -111,6 +111,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra);
 void fmb_timer_free(S390PCIBusDevice *pbdev);
+uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry);
 
 #define ZPCI_IO_BAR_MIN 0
 #define ZPCI_IO_BAR_MAX 5
-- 
2.34.1


