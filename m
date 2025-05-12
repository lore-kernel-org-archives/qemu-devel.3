Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC8C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9k-0004am-Du; Mon, 12 May 2025 11:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9d-0004RH-HP
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9b-0006g8-HB
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9gEr018654;
 Mon, 12 May 2025 15:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=w+mEqD3nTFEMy2i/R5aKwRIL5NojpY/9Zx3QNmJfEDc=; b=
 o/NPrQ5ZomvMf5V+f10vLsm8ZwJsHqT9n0i2n5FC0lfygfPWpYW2gfLbkCpf3tSC
 oSydUr7U59Clm1G6fM0afB/+9cmONh5z/8s0QBmyjsrsdEukt1Y/M7KOmQXDW0gG
 E8iTnu25WJczdqW6a7ccextz7Wh1M0GX8RpnQYqqhhT+RcFf4ZAz3/RGvhCW/+fX
 mBwjZDjP7p9hoUU+oooViVQqHYAk4jy/nmVFXM2P+29gTczQllVMKEva4WH0kp2M
 IPsBTsfH9JsRQ4+gCUI/ob59vhhv6kk/w8fIWGFK77K/4Wi9iowFGKVA+wERzduI
 7nNA0Isc43MxJfv6oIspBw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEU6U8002599; Mon, 12 May 2025 15:33:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk58030605;
 Mon, 12 May 2025 15:33:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-16; Mon, 12 May 2025 15:33:05 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 15/42] vfio-pci: skip reset during cpr
Date: Mon, 12 May 2025 08:32:26 -0700
Message-Id: <1747063973-124548-16-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX1E2wb72vkFyX
 QZK1vpV3/jL0fWGHPPaET+arxB4vYTn6piHNV0wUfaRZygRixR/wD/7CGyag6hHj2fipC5e3EO1
 igiUVrnhYiwXXaJxpKIkiDDXR5N52DnnmpAnZU9KvIjawJZOw8R3nYLrH/Qw59/aSUIrFPQrZ8t
 xY71GEj0DIAAqJ35kJIDIVDBW9ggUs6ds356daAT9D09u24C8WqERPYIU/HjHz1zgV5FmBuF92z
 n8emDQ0K+n25vyyivD+IeMERRUrlpsQPmhTR0j1beTiTIeBLHxZ3bpIicN4QbuEHiHmQXl7ju94
 x+b/lqYZhf5Wz+kTsKWgIXaAGKkl52dFY0fBEGVPOZ/F+WfuQ/rXLmSPMmfkh4SKPKbqyWRtor4
 LfSq0kXOXbZBuJJOKxFtexPlCoE3Djd8ewqnFd5QPeYXEbHVdofqZtllh5QaJ9MLGn/ZdG4A
X-Proofpoint-GUID: pxGkhdt6fAfgKMnCBCtaJg9xB0yLOdgo
X-Proofpoint-ORIG-GUID: pxGkhdt6fAfgKMnCBCtaJg9xB0yLOdgo
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214b2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=SludaupRx6HYuAq3bskA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not reset a vfio-pci device during CPR, and do not complain if the
kernel's PCI config space changes for non-emulated bits between the
vmstate save and load, which can happen due to ongoing interrupt activity.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr.c              | 31 +++++++++++++++++++++++++++++++
 hw/vfio/pci.c              |  6 ++++++
 include/hw/vfio/vfio-cpr.h |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 0e59612..6ea8e9f 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -8,6 +8,8 @@
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/pci.h"
+#include "migration/cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
 
@@ -37,3 +39,32 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
 {
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
+
+/*
+ * The kernel may change non-emulated config bits.  Exclude them from the
+ * changed-bits check in get_pci_config_device.
+ */
+static int vfio_cpr_pci_pre_load(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+    int size = MIN(pci_config_size(pdev), vdev->config_size);
+    int i;
+
+    for (i = 0; i < size; i++) {
+        pdev->cmask[i] &= vdev->emulated_config_bits[i];
+    }
+
+    return 0;
+}
+
+const VMStateDescription vfio_cpr_pci_vmstate = {
+    .name = "vfio-cpr-pci",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .pre_load = vfio_cpr_pci_pre_load,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe..4aa83b1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3344,6 +3344,11 @@ static void vfio_pci_reset(DeviceState *dev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
+    /* Do not reset the device during qemu_system_reset prior to cpr load */
+    if (vdev->vbasedev.cpr.reused) {
+        return;
+    }
+
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
     vfio_pci_pre_reset(vdev);
@@ -3513,6 +3518,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
+    dc->vmsd = &vfio_cpr_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     pdc->realize = vfio_realize;
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d6d22f2..e93600f 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -49,4 +49,6 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
 bool vfio_cpr_ram_discard_register_listener(
     struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+extern const VMStateDescription vfio_cpr_pci_vmstate;
+
 #endif /* HW_VFIO_VFIO_CPR_H */
-- 
1.8.3.1


