Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9A3C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95NC-0007gP-FR; Tue, 22 Sep 2026 14:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mn-0007ae-ML; Tue, 22 Sep 2026 14:37:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Ma-0005vO-Ph; Tue, 22 Sep 2026 14:37:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7WIO3447626; Tue, 22 Sep 2026 18:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=370oi7erpzbA5pBwt
 zgl9MF+hjpJBIEDmH4vLh3CXKY=; b=aTMeNEjLxYahz3gjGOESu+ecHybK4vDj0
 CNPGZYubNxAlY+INLeQ8SbKP0hN+exC/O6X1HykAUQj57qEN/ukci7Y2bEZNv4RC
 feTQTGIamSuW2Z2zj5/TcFElEm2SCpLOTyD3zonMg3tfLBXtzhfnkUuabkUamEG2
 RPNMCxnrca//yb3KmAVn/2LknogrGJ6e+us3Y0jrX9srTqQPHoQwTedu6jrrO32r
 wzGZN9y2g5sfsI2q09AUpGhs5sc5zR/9uA9pmRjQjGANJcw2VvVIzSaDIYQ1Ls1A
 6SzuWATVGaUXd+tPT1cfKU3AMdIhVKIKbys1vJvOZ6G6blawC/9ew==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qdq3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHd1O1972793; Tue, 22 Sep 2026 18:37:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkdk2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MIawI129164032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 18:36:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CC2158052;
 Tue, 22 Sep 2026 18:36:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D48DA5806A;
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
Subject: [PATCH v9 04/16] s390x/pci: Move dm_mr from S390PCIIOMMU to
 S390PCIBusDevice
Date: Tue, 22 Sep 2026 13:36:42 -0500
Message-Id: <20260922183654.798470-5-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922183654.798470-1-kshk@linux.ibm.com>
References: <20260922183654.798470-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 93XieArd7DEbFEX3seiIgBFLThhWexHR
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2cacc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jDWEBKAz6ZLYevfwb9sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX4DRiJzA0g9Ut
 J83JF1I4FeOF1p1cxUdQEuHYVtwfDga8cbv1FZLIaYHoJfaAwNeGQ++zfpplxv8/qj30mW1v96v
 GZwwqD920XsPEmfb4K2HM8uc4XkoGXY=
X-Proofpoint-GUID: 93XieArd7DEbFEX3seiIgBFLThhWexHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX6hQM2uhHzZs+
 sO2GQwogzQkR+O91yXTekEQ82yfRKagbOXDijOI4d5wc91xBpnu/OfMu9z33eAf/+jduG4qaqmT
 8PuUqNQ7QmyQMKj1sPYXbwEzj9xaH8Q6w2ekxhHfRcOEfkjUzi6Nlqw03+zMNG6oBmcGXHBD4dV
 /XbhJBiOkwGxImkj1GcEhVkL6rk/Z84QnvDDNncwG02aSemWxDX/6U4/tbZ1upW68BLXL+/nGz8
 mxzy+sgOcjYuZfOnKnPbd0tQuCwGvuIsXb6zmM5VnN6EDWkhric00Q8Cut0GSNVqurXI8vtAtSa
 c8UDRQFLD7a9W7HwpOrH8HytfO8GEVkZhllZN7kwicZcsu0bd5jDbEjSHIoc7ugomw5KQGIYJLu
 t/I57Wdbu/rCns7IRU2i39MiQQGJwb3WDyz3A6dcEwafD7lNWOi4uFMU1hofOEgX033ICd3rsQi
 JKIT4hbRJvUE3VxuPNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220273
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
there to simplify to simplify S390PCIIOMMU towards a structure that
contains only the IOMMU container information needed by the PCI layer for
a given slot.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 21 +++++++++++----------
 hw/s390x/s390-pci-inst.c        |  2 +-
 include/hw/s390x/s390-pci-bus.h |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b6a03bcc6a..e1b47f3914 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -605,7 +605,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     curr = iommu->pba;
     end = iommu->pal;
 
-    if (iommu->dm_mr) {
+    if (pbdev->dm_mr) {
         /* If direct mapping is used, there are no guest tables to replay */
         return;
     }
@@ -796,8 +796,9 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     g_free(name);
 }
 
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     MachineState *ms = MACHINE(qdev_get_machine());
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
 
@@ -809,13 +810,13 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
     g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
                                             iommu->pbdev->uid);
 
-    iommu->dm_mr = g_malloc0(sizeof(*iommu->dm_mr));
-    memory_region_init_alias(iommu->dm_mr, OBJECT(&iommu->mr), name,
+    pbdev->dm_mr = g_malloc0(sizeof(*pbdev->dm_mr));
+    memory_region_init_alias(pbdev->dm_mr, OBJECT(&iommu->mr), name,
                              get_system_memory(), 0,
                              s390_get_memory_limit(s390ms));
     iommu->enabled = true;
     memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
-                                iommu->dm_mr);
+                                pbdev->dm_mr);
 }
 
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
@@ -823,11 +824,11 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
     S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
-    if (iommu->dm_mr) {
-        memory_region_del_subregion(&iommu->mr, iommu->dm_mr);
-        object_unparent(OBJECT(iommu->dm_mr));
-        g_free(iommu->dm_mr);
-        iommu->dm_mr = NULL;
+    if (pbdev->dm_mr) {
+        memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
+        object_unparent(OBJECT(pbdev->dm_mr));
+        g_free(pbdev->dm_mr);
+        pbdev->dm_mr = NULL;
     } else {
         memory_region_del_subregion(&iommu->mr,
                                     MEMORY_REGION(&pbdev->iommu_mr));
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0772f04cc2..582e93a741 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1062,7 +1062,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     if (t) {
         s390_pci_iommu_enable(pbdev);
     } else {
-        s390_pci_iommu_direct_map_enable(iommu);
+        s390_pci_iommu_direct_map_enable(pbdev);
     }
 
     return 0;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index a71f562dfc..f310672584 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -276,7 +276,6 @@ struct S390PCIIOMMU {
     S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
-    MemoryRegion *dm_mr;
     bool enabled;
     uint64_t g_iota;
     uint64_t pba;
@@ -354,6 +353,7 @@ struct S390PCIBusDevice {
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
     IOMMUMemoryRegion iommu_mr;
+    MemoryRegion *dm_mr;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
@@ -392,7 +392,7 @@ void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 bool s390_pci_is_translation_enabled(uint64_t g_iota);
 void s390_pci_iommu_enable(S390PCIBusDevice *pbdev);
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev);
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
-- 
2.34.1


