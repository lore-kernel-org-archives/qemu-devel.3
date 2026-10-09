Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C22CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFKg-0000Pd-NE; Fri, 09 Oct 2026 14:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKe-0000OC-1r; Fri, 09 Oct 2026 14:28:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKb-0001dx-Td; Fri, 09 Oct 2026 14:28:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZxHV3128435; Fri, 9 Oct 2026 18:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dgfHwCZ9WokCdyBVn
 LFCvza36SUkmwYZd5Unuc5wUdc=; b=VpHRsgpTpjGHGOv284RNAFoq4oIAARFLq
 OyVIoYoM7CEPrVyuRjJeDLlIYcbJNJE83h/s0OAsvyXrt+B+EEQUCevl9nB9zWpy
 heRElr4YiVH7HeNYcXc8YIs0rCs3bjGji0r+RRwjrhqrw41Tw4Dh/6xI33Jq4fMx
 41WQAn2rvcmLJiVbbAXPGFc/PZPeemU8lb0ZtlQy/jcNmW0cCAFhvBl9c9ROom52
 0O7QHeUcaoQ3fSq8iAnYgiz0DbKiEzDZ4oHZ277TCHzFVM/30kEMapyoPdMAcMin
 CCvDRZ9n73RAk2ypmkIXeSkaUhqIW6aFhVWeHe4MKh+nNwhmJALMg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tcg8jw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8G4b1206683; Fri, 9 Oct 2026 18:28:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnm7n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISS0E24379934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEA915805C;
 Fri,  9 Oct 2026 18:28:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EF7758054;
 Fri,  9 Oct 2026 18:28:27 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:27 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 01/19] s390x/pci: implement IOMMU replay
Date: Fri,  9 Oct 2026 14:28:07 -0400
Message-ID: <20261009182825.148054-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX0abIWrVI05/0
 or4LgxvWXhiubtdMWFKjLQ2/yl53y2SsDYum88yhff5L1W46gHHZxm0aqjMadjmhskuyfQvShFL
 LSze1QEUYtF+P6BvQjOQ9ypXYW0pHlQgqMFL0+De963LWDPOeCXAGZvZrg4EZpdy/XIlXAjAs3B
 iokKlGi/h2OUnCjgComLY1I80jwpAM4CjO39t5bipJp7SbPX2N1PA+q5tR1eTDakaqipUtztmcV
 6HxNECqYjxfXD866aNH33gW3t83MwVCPx3X6bhgebiAR9AHCiLjcfebYVVB7bvSDeQeFKW7MJRi
 AW/pgYG5quStTwrUhP1t8ko8gTSRqxoIUZ3h+sVxWF9L/pzWgXRxgfizV40E8ZhrFMVhnTO/YLW
 JLG/sayHzs9DZRDjdbsCEO3dr+xYy07t1cCngpf4/W+OKWjJFMfM9EgvbrNPp5pZRsZ3nzbP/T1
 iBJ0qqqJ7ArJFTEpxww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX01X2R+45Chd3
 Cb2P0URmCADqdysx5h5Ibi/m8UxZ6Z1sgQ0xqdrNXmweqPrSAS2RyoyrQQVRRRasd1rZmWprXlN
 LDenG+gZEykhv4w80Rae/MpiyWhBqfs=
X-Proofpoint-GUID: FH2CLTbDXxEMrYD_SK7y6Radd8vwoTXb
X-Proofpoint-ORIG-GUID: FH2CLTbDXxEMrYD_SK7y6Radd8vwoTXb
X-Authority-Analysis: v=2.4 cv=Yu+a1IYX c=1 sm=1 tr=0 ts=6ac9324f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=uoNow8biE-CX8mucm5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
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
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-2-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 71 +++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-inst.c         |  4 +-
 include/hw/s390x/s390-pci-inst.h |  1 +
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2eb4e8cec4..b3f7b59422 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -593,14 +593,75 @@ err:
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
+        /* Advance to next frame boundary if start was not frame-aligned */
+        curr = QEMU_ALIGN_UP(curr + 1, entry.len);
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
+    S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
+
+    /*
+     * The notifier argument is not used directly; s390_pci_ioat_replay()
+     * broadcasts via memory_region_notify_iommu() instead.
      */
+    s390_pci_ioat_replay(iommu);
 }
 
 static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 09026360d4..285ff0e089 100644
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
2.56.0


