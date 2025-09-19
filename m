Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F8CCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimX-00074x-09; Fri, 19 Sep 2025 17:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimP-0006nI-4o
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimG-0002YD-06
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:32 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtmWm023181;
 Fri, 19 Sep 2025 21:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=yJm7a
 wrJ9iNJWrOzHn4D5rPYaxLbCzb1eGm1bstdueg=; b=XzBUONICQ9lria/r4KRBz
 fl6SJp3qsll3LWdK0AIK0Am5OVAfAg+sAg7wQ2n2OOWg34pQssPrULIXCEkKO5gO
 cWqUFzhSgbcliu7KiEcEVopMa26WukpNKsr37LtJY6exlqkUox9zPer78TEjOWsl
 hyV8I3y5b3M+B3nTR7iZCpBw2p/Xko2MiCiCulzr32iphxZzD8lQd0bG5WnW58XG
 hwl9l2AM3RqW+wGhPmngIcrFmje5m3hp+rnGF/BvgB2RXaTvsY5jr1TvrZH9sTUe
 3Zndisc0W4pPK+n451vR1mxiwbJfyAtDRzvqn4nWGPew0JVMSDsSReMKejTkHrLy
 A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6pdwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JKd1T5033813; Fri, 19 Sep 2025 21:36:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:00 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0X004301;
 Fri, 19 Sep 2025 21:35:59 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-18; Fri, 19 Sep 2025 21:35:59 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 17/22] amd_iommu: Add dma-remap property to AMD vIOMMU
 device
Date: Fri, 19 Sep 2025 21:35:10 +0000
Message-ID: <20250919213515.917111-18-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cdccc1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=lB8vL2C6TGN_h6hMWm0A:9
X-Proofpoint-GUID: jh5weKxaDStKI65izvpVxAxlAttDchUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5MTv7kay6CbT
 OA20pEb7R3hqt24F8oceNH/ubJ3hCmLoONgpleHbWrfzJ8ea4FYUmFpaTLG9DmO2mubIoIG9zHa
 Gok5HNhqodZyYwBPQvLSY+Hi6YRVR1aKnGNmRv82OkNOGZdju6dkIuVhqW4lI7TflAtYv8wxKmr
 TOu3vCnQxUqd3xZ95zWeXDZseO3nPRXsbx8+plLbLIiM2nl3NmmdcXKCB8ye2Uw7oGKeZj24eTd
 MS1wmiWpWifGVdzpE7Sfu7MFUqlgZmAfjf5Grk3X6fdWGrGpSV7XUGI9ADrPELs1/V+cB0dwrii
 Pp1AXLBq/OpokrItGKdsvgK2mKlg7fCBhHtbkVydNIEG5qv6tk5O0EsuRgGzSPVJTL21AzHGg4o
 Uz7moosg
X-Proofpoint-ORIG-GUID: jh5weKxaDStKI65izvpVxAxlAttDchUb
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to enable device assignment with IOMMU protection and guest DMA
address translation, IOMMU MAP notifier support is necessary to allow users
like VFIO to synchronize the shadow page tables i.e. to receive
notifications when the guest updates its I/O page tables and replay the
mappings onto host I/O page tables.

Provide a new dma-remap property to govern the ability to register for MAP
notifications, effectively providing global control over the DMA address
translation functionality that was implemented in previous changes.

Note that DMA remapping support also requires the vIOMMU is configured with
the NpCache capability, so a guest driver issues IOMMU invalidations for
both map() and unmap() operations. This capability is already set by default
and written to the configuration in amdvi_pci_realize() as part of
AMDVI_CAPAB_FEATURES.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 24 +++++++++++++++++-------
 hw/i386/amd_iommu.h |  3 +++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index e9ce7b46e854f..ce5d4c36624fd 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -990,7 +990,9 @@ static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
  */
 static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
 {
-    if (amdvi_as->addr_translation) {
+    AMDVIState *s = amdvi_as->iommu_state;
+
+    if (s->dma_remap && amdvi_as->addr_translation) {
         /* Enabling DMA region */
         memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
         memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
@@ -2193,12 +2195,19 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
     AMDVIState *s = as->iommu_state;
 
-    if (new & IOMMU_NOTIFIER_MAP) {
-        error_setg(errp,
-                   "device %02x.%02x.%x requires iommu notifier which is not "
-                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                   PCI_FUNC(as->devfn));
-        return -EINVAL;
+    /*
+     * Accurate synchronization of the vIOMMU page tables required to support
+     * MAP notifiers is provided by the dma-remap feature. In addition, this
+     * also requires that the vIOMMU presents the NpCache capability, so a guest
+     * driver issues invalidations for both map() and unmap() operations. The
+     * capability is already set by default as part of AMDVI_CAPAB_FEATURES and
+     * written to the configuration in amdvi_pci_realize().
+     */
+    if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
+        error_setg_errno(errp, ENOTSUP,
+            "device %02x.%02x.%x requires dma-remap=1",
+            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+        return -ENOTSUP;
     }
 
     /*
@@ -2423,6 +2432,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
     DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
+    DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index b51aa74368995..e1354686b6f03 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -418,6 +418,9 @@ struct AMDVIState {
     /* Interrupt remapping */
     bool ga_enabled;
     bool xtsup;
+
+    /* DMA address translation */
+    bool dma_remap;
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
-- 
2.43.5


