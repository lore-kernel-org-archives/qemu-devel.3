Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C72C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x534t-0008KL-Nh; Fri, 11 Sep 2026 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534b-0007xo-LY; Fri, 11 Sep 2026 11:21:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534W-0004k4-2y; Fri, 11 Sep 2026 11:21:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1PuP2126736; Fri, 11 Sep 2026 15:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2J0jttHL2vogfDdlE
 759gBN/fuM/0Xw0MdkpRXjBCxU=; b=Ly8bHF1gImRpu0HRCjRC6DDDPhB7vhHKw
 9ckfJrKd5ylwCN8Cu5TB6hiMNl73r9Ri0pwK0Dot35Qdkut/VXlGaWUEY0RZiytd
 YGAMw40c0Slo8O7GQVrDx9pEAutqaZ0p63EP2jjYeNskyt2k4B/B6zbPZqRzM9dy
 7bdzrU911v9+qVOk2d2fZQ0NxgPZFQX3Zzwe6qpQ806ZwqMrsDMmHPm0bwpYFlwy
 rRZJnofEDeZWnZtg9J4pNU76WfhRSSQ+3NQGvX2jFWZF9wsbtgM5GLD1+HhZlCtG
 zdFCyiQSihjsjsLgOHSLYEwVVzqMx49T6MDTSplZAjJlPyon0CnoA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qvbas-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEoCKu1789525; Fri, 11 Sep 2026 15:21:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk71s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFLeWm33423978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:21:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C1FC5805D;
 Fri, 11 Sep 2026 15:21:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA40D58058;
 Fri, 11 Sep 2026 15:21:39 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:21:39 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v8 01/16] s390x/pci: implement IOMMU replay
Date: Fri, 11 Sep 2026 10:21:22 -0500
Message-Id: <20260911152137.676602-2-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911152137.676602-1-kshk@linux.ibm.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa41c86 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uoNow8biE-CX8mucm5YA:9
X-Proofpoint-ORIG-GUID: IS0eeGOw9tfIjnFsYJPPwUgyQmydyKvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX+mqAB8lvbkEW
 dCKIG9dQdMM31Xm9UFQrbM8rZLr9IBtjFjiQeyYriNJOa7cbjbIoDTPcWBfDc7N3rgDPYYVaOOl
 wbVzVRdQQvzzqMOKrKIALyIbdhG66Kf4/Wf1I7ba9MG2t7C+A5MLLC3VcMd8dV7ga6n8NcmSgcM
 fWy9VpzQ02SwWsay0l0+jASB8dlNG1Y+acMxP6gcMqvqWUW+hywv2NSjFS1jAiRs8zqlljfe1Qp
 cMT/HbPyabS7Pa9I5diOMjjaI+C5i9A5kbAx6vd8z/VaVO7P3mUSHba2hBba6jZOOemjJPAm4Ol
 tMyIP1lIyAlXY4gteS/4JxJkADWK5OT2Lx7bIXoWwSM5gt7nemrkD9JVG90Y67475uIUtoDAEbC
 Pg6pm7XklqkrOW29M12SX+e8LOhVTNSfHortI3HOTPchdQEaFR/Q8ylxOFs8Wqpk2INXdcvsInM
 39Vm1ItG/OiQXi4FVhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX57aTaX1zhqG6
 1IJ5T8RWs3HsmHunmh0YzlHoc/09bwyZ1fUet7ZX5u8l407NbfUYi4+Spnjkws6udOYGATn81bW
 yZzH9HI4WWbxogMJDHFqB9hVVyfVBKY=
X-Proofpoint-GUID: IS0eeGOw9tfIjnFsYJPPwUgyQmydyKvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
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


