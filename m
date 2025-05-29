Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20343C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisa-0004GM-DJ; Thu, 29 May 2025 15:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisJ-00047v-B0
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisG-0000EI-BG
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfuui022092;
 Thu, 29 May 2025 19:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=hFvG80vBr54FDYN1LXb92eeG4ntsJZE/ueleLz7qMOE=; b=
 fx4BpsfVv7i3oJoSKE3+VHbCEYnoOgo87BbYHmCDc16+5006tJVm2lZxUWLn+d/h
 eIRnyLTrThzpQ3JnX7Nm6FgFJ+C489Ib/JB3qdNY2sc2LsMUlTGK0wVjNCoeJu7O
 Fa6oTSvEEF3blYdCdsOljeefjccQ2RUCcyC9fylLya9fTLD9aBEArNJKnKwsWvJN
 4k9qArX8dzbAguLcK3mjUNOus9FPKLZtoqqiKlGXznbXzljA/oTuvN8zZ1pAhzv6
 DMrhqNvpfezezE+O5pT2JL9NC5GWHG2+DvPvyR9Ryvc1JnNpPfck8xKkhIwGVoeb
 J4VA/8ueftrqOcLxtuJiMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJLPvB020301; Thu, 29 May 2025 19:24:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRL022158;
 Thu, 29 May 2025 19:24:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-18; Thu, 29 May 2025 19:24:54 +0000
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
Subject: [PATCH V4 17/43] vfio-pci: skip reset during cpr
Date: Thu, 29 May 2025 12:24:13 -0700
Message-Id: <1748546679-154091-18-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: 9qQyqED2xyPmygXgrXdrZ8gH3y-ZrsFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXxZ+BsACMyGvp
 s9HDrY8DhrIRcdS0nxTFpmokKhLsW/MApGetgxjUT1/CERedwWqMT12yJaUw2ubsBgB6ObIEYI/
 O0F5PP3cnc7nmkDIe7Qoatw/Cd8wSQYea1CSOcreuF/WBEiLP1VqgdXuPNdiQ2NZ864pbgSy5Rj
 okO2Lmb+nDkQnJF6tbTZ7NhDUCi29qBonb7UDyieV8A4zTc0EhNQlkT/sRn/DOWbnWjwhlS8z90
 8L0WYLisfwVebr87LssPzZbC57xatJYuu7xPHd8j25Dqup+XqQDB2qPsNJ+RAuf3yRPyNjZehYi
 zWp3BqCiUCBZ5QEKsXKz8/YrHW1JR4pbMeRZ7D1j8p057/WO0LfpHlsDqjQxSJHSD3r4JYh+ZQj
 n4ZHKNI0vOS2hlEEGbTu7sEPgE32OpNlGByedWW5y9iC82CF1M1BP/MEFaA9QVvLWbSDi9c/
X-Proofpoint-ORIG-GUID: 9qQyqED2xyPmygXgrXdrZ8gH3y-ZrsFA
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b487 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=HoecKI5d6pZ_3ip9vgoA:9
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
index 56e7fdd..840590c 100644
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
@@ -3345,6 +3346,11 @@ static void vfio_pci_reset(DeviceState *dev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
+    /* Do not reset the device during qemu_system_reset prior to cpr load */
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
     vfio_pci_pre_reset(vdev);
@@ -3521,6 +3527,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
+    dc->vmsd = &vfio_cpr_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     pdc->realize = vfio_realize;
 
-- 
1.8.3.1


