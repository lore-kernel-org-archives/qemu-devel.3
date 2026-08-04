Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC07C55838
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr59L-0005ez-Fq; Mon, 03 Aug 2026 22:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59G-0005dh-Tl; Mon, 03 Aug 2026 22:44:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59F-0005C4-7a; Mon, 03 Aug 2026 22:44:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6741IB8i3632568; Tue, 4 Aug 2026 02:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FPbPOfKEqZHgQoRnN
 Oj5Wv/m5QwFAIb4BnCwXQ1J1rI=; b=At85h7Tc0PMK2Ttn+t+ZKeO4XS/qyUSGo
 gJVkhYK5Lh1VM4EQN3TVq0veJjojdED1Gaw+vcWtthq75/9xDEPdy+WhEtTF0L0l
 0R0Dy29wNTFw1r3T5fano7lWKvHtljDlfTNEGIEef/BrCroUOCLa1B4iGOAyKrCO
 +tLdhFa7nlXz5Umb4Noz26V+k7o7SR1p2gmvRsvOiBLgRgQmGGwrnQQw6P76oAMb
 RVPgfl+QiyvZi+/v23y+B7IN9Gx2NHtoDO1i77uGKJphwzc2ebxsfLEaJ9WIhF3N
 yZLDMzQiVmkH2S4GWABtNy7hEhcyDcIFnYFKakzg0kjnPk+ug8QQg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3urcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:44:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6742fFqs027698;
 Tue, 4 Aug 2026 02:44:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qg88j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:44:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6742ioPQ16712262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 02:44:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2D4D58050;
 Tue,  4 Aug 2026 02:44:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57E7358045;
 Tue,  4 Aug 2026 02:44:49 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.58])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 02:44:49 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v5 01/15] s390x/pci: implement IOMMU replay
Date: Mon,  3 Aug 2026 21:44:29 -0500
Message-Id: <20260804024443.56445-2-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804024443.56445-1-kshk@linux.ibm.com>
References: <20260804024443.56445-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a715224 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Ne9W6HA6cR8Tgt2TMNYA:9
X-Proofpoint-ORIG-GUID: EnJb4pdsxUTs5XpUFge0SEd37sba71ct
X-Proofpoint-GUID: EnJb4pdsxUTs5XpUFge0SEd37sba71ct
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfXw4KzSRzvh6u2
 LziTPBVt4jbPqTDkSbgAFDIPYQ7wmFOurHAv8//3fOcdRJppEKWWCvRiXtILf6nTtljN3HHGM33
 W0mtBG5EKCeb5bN9XvmjxOe75FlOUwk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfX8midGo8DZGM8
 pBqtO3eGliFMNkCBVXi16Yr6yUPHoVuIx0ziTLKUI83qzQvrKUZB7hJdO7y1MZ78GZeQxZBal4v
 9R7VpUO3OwZj6YT8Cev+Qql0OGANm2uOm+lVlVzyFmRknH0XCbZ8Rqbw9C8QVRAmB7iuMLbwiO/
 B9DMnFaTGmMfTQJi9DJ5J4ENmun1soU+GLC0/l++HaF1BFjGwgNPe+evN/HItWYBHWSvl1F0Xqg
 Ax2ele9/j4QshVf4G4UPGLEat4ozTSv6wD5xuY8ssdXy1U3s0xhhjBTQg7Wzf0L54MXYRx1Eyti
 1HEGCg7OsS+kBDTgt1ZNBByDYvp2hB2+vLkW0rbjMUZVFaeRX1r1SXjfsGF1Nrf1DpXeBCOYkSW
 4iAkygUaLt/mU4OIIhFl4UXus0SmF4+HGRrJOH4De+RcLRQVVgWOEiFYPjj5EiKZv0pXNUM+ZD8
 VZU/DPeBOR6ZZc674pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 hw/s390x/s390-pci-bus.c          | 63 +++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-inst.c         |  4 +-
 include/hw/s390x/s390-pci-inst.h |  1 +
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eff980fdfe..21bca4d787 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -593,14 +593,65 @@ err:
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
+        if (entry.perm != IOMMU_NONE) {
+            if (dma_avail > 0) {
+                dma_avail = s390_pci_update_iotlb(iommu, &entry);
+            } else {
+                /*
+                 * There is no reliable method to request the guest to release
+                 * mappings other than in response to a RPCIT instruction;
+                 * generate a permanent error condition and require the device
+                 * to be completely re-initialized from the guest side.
+                 */
+                pbdev->state = ZPCI_FS_ERROR;
+                s390_pci_generate_error_event(ERR_EVENT_PERMERR, pbdev->fh,
+                                              pbdev->fid, 0, 0);
+                error_report("DMA mappings exhausted: iommu remap failed");
+                return;
+            }
+        }
+        curr += entry.len;
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


