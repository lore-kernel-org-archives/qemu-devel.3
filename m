Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BEFC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP275-0001rw-Fp; Tue, 10 Jun 2025 12:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15F-0004O3-FJ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15D-0006AT-Lg
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXaWc030396;
 Tue, 10 Jun 2025 15:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=E5MuTLav213KsaZrzKuuqJSs7RvxdgmAgnYEfRlIS38=; b=
 isBYrj2FqAPj7m9KMuMZ9LX4D4Sc3aiAM6kMj4UIs6McV9wwVoO5OBNmQcpYMqxh
 RNKRyme3ePdLNsxDgxLn54ei9qSFiass6PlyNF2DMsnz+oj/UX9lu5TH4VWPwDfq
 NhkC1oqaPTyq4wqsmFoTa3Zxr6rJYKHZoy7s1EWOSF0gEbX9sEfzGupa4X5pZFUZ
 SxGKp7VcUhXQwTLHrjy04YG8Rt7XST0NopmaFQcswvcffra/lPW2P+LCuR8vmCJx
 NrcAZrZjkK2diZcQcRbfM5cyeJ3D0Wg5CXpg7WeS3hgoOLVvT9lt6OWHxpLuBZjG
 lRQoSbE/pMoQHCc8jjhL+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF0F2e003984; Tue, 10 Jun 2025 15:40:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wb0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfT028825;
 Tue, 10 Jun 2025 15:40:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-12; Tue, 10 Jun 2025 15:40:09 +0000
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
Subject: [PATCH V5 11/38] vfio-pci: skip reset during cpr
Date: Tue, 10 Jun 2025 08:39:24 -0700
Message-Id: <1749569991-25171-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: 2n8VmOPzF2EgORDF71et0wNQZQ_TJoqF
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684851db b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=HoecKI5d6pZ_3ip9vgoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX8xC8MitGGWdY
 0/ZLraINdugezeLxHv4E+nWiJT3brnSJ7oktZLLdJdTeG8LTHOhsK+eYSwMS8T6piGbXCpbv7fX
 jF+EFCHCCRQoCvFbvIWJPzjcAeYdaCN58sLRhvM4oeovyw1VfSQm9hHI4dQcHVKvxgp7b8rilAW
 +aJzpsTvFqX7gcEhQR7s/dPHp8G2IqiUJPKy1eUYR5khmjfmqxFJT2cOPF6J9LiKnGaEGQPbpbO
 ezXHIP7ChW8fa1eZ50db0mo34/IsYS9BMK4HAsja1gOfzcJbfyzWCjhqcgwepQwH0ylgrgw8uuD
 xgmaVEl0ATBvguyppJUube+waoS+9tBE6i68txg89EASEoOcFWUgcZ95aWwLdPCQGzQEEJ5tkOO
 0O0a6umZGqUP6dDENgcbhRKYp4O9SIkTUlTaTI58J80oOTHxZs2WJ5Kcf+vzKEfl9vg1jX5d
X-Proofpoint-ORIG-GUID: 2n8VmOPzF2EgORDF71et0wNQZQ_TJoqF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  2 ++
 hw/vfio/cpr.c              | 31 +++++++++++++++++++++++++++++++
 hw/vfio/pci.c              |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 56ede04..8bf85b9 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -52,4 +52,6 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
 bool vfio_cpr_ram_discard_register_listener(
     struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+extern const VMStateDescription vfio_cpr_pci_vmstate;
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 0e59612..fdbb58e 100644
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
+    .needed = cpr_incoming_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 819170d..67edf80 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -30,6 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
+#include "migration/cpr.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -3351,6 +3352,11 @@ static void vfio_pci_reset(DeviceState *dev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
+    /* Do not reset the device during qemu_system_reset prior to cpr load */
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
     vfio_pci_pre_reset(vdev);
@@ -3527,6 +3533,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
+    dc->vmsd = &vfio_cpr_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     pdc->realize = vfio_pci_realize;
 
-- 
1.8.3.1


