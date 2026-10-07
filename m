Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A0CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xETCb-0000HB-7L; Wed, 07 Oct 2026 11:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xETCQ-0000GF-MX; Wed, 07 Oct 2026 11:04:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xETCO-0005G1-7b; Wed, 07 Oct 2026 11:04:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BZumY596909; Wed, 7 Oct 2026 15:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gYUpLtTpZt+ca+VXWtdg0rkH86V5IInW837YJjbPi
 vg=; b=VmLgoxU1p+tzlb30AcR0U5OuxSh3KcFgtnKEFcTmlXwk3RoFAr0emTCWJ
 drEoItW39N/bRERiNwRgWdNivI/IGLATnb6uzFhFgr4TDICOOP8VWy7QICyxH5Qm
 BgYmwyavNaGMHyjAMBBNMEHRrBI+ePrsLlKoHoKDe5BUmO5JeCbFxPZGe2ESAj6g
 NcKe3qsoO5w1SSE16RCXW7sY1Qdcbr/8SDmXFaMJEm+PfL/3CSVix+hctKev3ksQ
 /ezjqbzqjjIYXfZQ7+q34ZMv/7NrERzLQbPQkFT+hocNbDACtS45LDSn/+99CWOh
 nupcY40ykDXG25zu23BG+OEvJmJ+A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrp2y9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2026 15:04:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 697F2VVp802316; Wed, 7 Oct 2026 15:04:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tt1mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2026 15:04:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 697F4h0532309776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Oct 2026 15:04:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 228CE58058;
 Wed,  7 Oct 2026 15:04:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35B6F5805F;
 Wed,  7 Oct 2026 15:04:42 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.231])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Oct 2026 15:04:42 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, cam@linux.ibm.com,
 farman@linux.ibm.com, qemu-stable@nongnu.org
Subject: [PATCH v1] s390x/pci: re-fetch DMA slot shadow count from VFIO upon
 IOMMU disable
Date: Wed,  7 Oct 2026 11:04:16 -0400
Message-ID: <20261007150416.13220-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX2dH9F7cjWEBi
 LI32Junmx2s1ERL2Qu4b5A2D4k6/KZaMA17O8JwpVKGYuNYXLOgmo22LDVIP7jr9iFqh0rBTc0s
 nwxKAjj0NHSEE4MtJt7Mcjx/oe2c1wY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfXxVdBEeJkPmKc
 vE0WCAkEfjSWyEWiw+qcnb+gn82ZFBt1L3ITSLv2jJvgC0Q1N5hu3dx+excMIoU7m7XPjqP57Kt
 nyvQt4HxVqC/8CG1sfFAPMK1MpYJi3Yzxkvf5YZ+XVmcnOpmOplmXwBU8TSDH8DscmjXn3PAxGJ
 8f6x7xWIYEcPfvNCVZUxDiJoxtpm03YTWVB6y9PatUOpE1FJvsWPgsDEpDRTD40SIw9wFEW942K
 L/tF8SVbwY2UzvwhEvP226VXWXQFiSJ1FcGOrcxqZ6q69IgcmuvmWysvRskYlUfJtQUkD1BapDn
 HZVqczBkevB5oPGh46yw0O8/hnafvWZ+xeZSmDSOD7pqnK8yZhj+Ga6vgphYeMfdWxoNehJzfRb
 tGGNrZj2bSQ1tj+/SvJDmNPJnrGLwyUm2iNddkHx/ZoxY9ZKOOJzSibMnmc5JaFz6UgIsDiky1Z
 SlKaTcoCFBgYiatnPvw==
X-Proofpoint-GUID: 6phpcCNaVhqIM9duwuqLyTHnBMyLgBQn
X-Proofpoint-ORIG-GUID: 6phpcCNaVhqIM9duwuqLyTHnBMyLgBQn
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac65f8f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=40kIQRfpMbFYpg-JRbYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070058
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
mappings, but it doesn't reset the available DMA slot counter back to
the VFIO-advertised limit. This is problematic when an IOMMU is disabled
and re-enabled while reusing the container (e.g. during a guest reboot),
which may cause the RPCIT path to fail with DMA slot exhaustion errors,
manifesting as unexplained ENOMEMs in the guest.

Fix it by refactoring s390_pci_update_dma_avail() to take a pointer to
S390PCIBusDevice instead of the plain file descriptor. Call it in
s390_pci_iommu_disable() after the host mappings have been unpinned.

Further print a warning if the VFIO-advertised counter doesn't match the
in-use shadow counter, to reduce the likelihood of introducing new
similar DMA accounting bugs in the future.

Cc: qemu-stable@nongnu.org
Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 19 +++++++++++++++++++
 hw/s390x/s390-pci-vfio-stubs.c   |  2 +-
 hw/s390x/s390-pci-vfio.c         | 18 ++++++++++++------
 include/hw/s390x/s390-pci-vfio.h |  2 +-
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2eb4e8cec4..0da9f67f42 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -762,6 +762,8 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
 
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
+    unsigned int dma_avail;
+
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
     if (iommu->dm_mr) {
@@ -774,6 +776,23 @@ void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
                                     MEMORY_REGION(&iommu->iommu_mr));
         object_unparent(OBJECT(&iommu->iommu_mr));
     }
+
+    /*
+     * update shadow counter from vfio after having unpinned all host mappings.
+     * if this value mismatches our previous shadow count, then we likely have
+     * DMA remapping, unmapping, or accounting bugs
+     */
+    if (iommu->pbdev && s390_pci_update_dma_avail(iommu->pbdev, &dma_avail)) {
+        if (iommu->max_dma_limit != dma_avail) {
+            warn_report("zpci: DMA limit %u from vfio != %" PRIu64 " shadowed",
+                        dma_avail, iommu->max_dma_limit);
+            iommu->max_dma_limit = dma_avail;
+        }
+
+        if (iommu->dma_limit) {
+            iommu->dma_limit->avail = dma_avail;
+        }
+    }
 }
 
 static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
index d9882b7aad..da41c75602 100644
--- a/hw/s390x/s390-pci-vfio-stubs.c
+++ b/hw/s390x/s390-pci-vfio-stubs.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "hw/s390x/s390-pci-vfio.h"
 
-bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
+bool s390_pci_update_dma_avail(S390PCIBusDevice *pbdev, unsigned int *avail)
 {
     return false;
 }
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index db6de00bd2..caa3d88bc1 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -29,13 +29,23 @@
  * limiting DMA requests, false otherwise.  The current available count read
  * from vfio is returned in avail.
  */
-bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
+bool s390_pci_update_dma_avail(S390PCIBusDevice *pbdev, unsigned int *avail)
 {
+    VFIOPCIDevice *vpdev;
     uint32_t argsz = sizeof(struct vfio_iommu_type1_info);
     g_autofree struct vfio_iommu_type1_info *info = g_malloc0(argsz);
+    int fd;
 
+    assert(pbdev);
     assert(avail);
 
+    vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
+    if (!vpdev || !vpdev->vbasedev.group) {
+        return false;
+    }
+
+    fd = vpdev->vbasedev.group->container->fd;
+
     /*
      * If the specified argsz is not large enough to contain all capabilities
      * it will be updated upon return from the ioctl.  Retry until we have
@@ -68,16 +78,12 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 
     assert(vpdev);
 
-    if (!vpdev->vbasedev.group) {
+    if (!s390_pci_update_dma_avail(pbdev, &avail)) {
         return NULL;
     }
 
     id = vpdev->vbasedev.group->container->fd;
 
-    if (!s390_pci_update_dma_avail(id, &avail)) {
-        return NULL;
-    }
-
     QTAILQ_FOREACH(cnt, &s->zpci_dma_limit, link) {
         if (cnt->id  == id) {
             cnt->users++;
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index f7d6149daf..c11d5781d2 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -14,7 +14,7 @@
 
 #include "hw/s390x/s390-pci-bus.h"
 
-bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
+bool s390_pci_update_dma_avail(S390PCIBusDevice *pbdev, unsigned int *avail);
 S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
                                           S390PCIBusDevice *pbdev);
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
-- 
2.56.0


