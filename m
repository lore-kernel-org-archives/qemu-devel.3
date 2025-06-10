Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8896DC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP277-0001vd-IX; Tue, 10 Jun 2025 12:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15t-0004Zd-PY
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:41:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15r-0006F0-UQ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:57 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXdkS006193;
 Tue, 10 Jun 2025 15:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=HHaGubG9Y0uk46KSXFc8EYqRILZ7O9/+4uxWBG4ffkg=; b=
 FEqELmVHoaGTOPEtGuLmodz3rvakZNU5iirTr3DFmTHr1NB9AHceL0//FGbPwVzN
 bQ3AGLct9J0nrhFAvU1P0yHYOyMYbLfxxTXDsgZrEeMTHGD4xRZV3GtuEqOm1vI+
 x+RBIP+feqvd7qPOLXmX62dHlCLIxcGGdGT+DwvhNzeJdPIVWn7NVfOLKThHMmA/
 B/SB5eKqjIn3OvZyNfaNgk+K7yetzFcZbWb5GHYO102BvAlhq82iZL8r4d+wSxv/
 Kw3gr6UxJaVefD62YnwT7OEYmxouR7nQE1DLBLTuqptKD+NuMx6Q5YnlFhB3wFHw
 Xbhh1HYOzyko5ZAChb0w0w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad4f2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEjtiW003964; Tue, 10 Jun 2025 15:40:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrg7028825;
 Tue, 10 Jun 2025 15:40:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-31; Tue, 10 Jun 2025 15:40:40 +0000
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
Subject: [PATCH V5 30/38] migration: vfio cpr state hook
Date: Tue, 10 Jun 2025 08:39:43 -0700
Message-Id: <1749569991-25171-31-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-ORIG-GUID: QfJ_TAlsXuZHZXSHbi4_fRoON-gJgLtz
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684851fa b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=98wZ__1tFoD98bssFbsA:9 cc=ntf
 awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX00/6XikD/zfa
 eIlxrJWygbo+psxj666KGWWKdS8UAABCCdJLp3LIjvrDwUqJOqQKjBxvhDbhv8zrxIPzWNpNYzc
 o9hh482+lerJY/2mRUIh5KGQrd8VGDcFzqCISkUkj8869L1nJv0AD4jicH2jRpiddSu65vtcwGZ
 6aGUtMfGsXBz9mD5VEKOOdk4az/NOlRRG0j2CrnssniERHouY8D3ZEkzjCYX92PkQ90jEJnb4Mg
 tdK5XBEDtkAMLkZH1A4KVfB+8+s1iCQo1y0M4O5MPa60c3rIFrDuBtYI2oVY6GFQY8SSwChz9lx
 mycpPKKnPm9YxOLf1C4AxiF9JO9IchVCTxyB2HWWMcNec3pfazlLBeKHtlXVIauvwsVI0MfQAwB
 IezGkHEbCRJxdNe2tUeTF+KuGUFvt6lWFdnTBobWAGyxxbr8rx/PSb5kpeHUCjNfk5If1E3L
X-Proofpoint-GUID: QfJ_TAlsXuZHZXSHbi4_fRoON-gJgLtz
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

Define a list of vfio devices in CPR state, in a subsection so that
older QEMU can be live updated to this version.  However, new QEMU
will not be live updateable to old QEMU.  This is acceptable because
CPR is not yet commonly used, and updates to older versions are unusual.

The contents of each device object will be defined by the vfio subsystem
in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/vfio/vfio-cpr.h |  1 +
 include/migration/cpr.h    | 12 ++++++++++++
 hw/vfio/cpr-iommufd.c      |  2 ++
 hw/vfio/iommufd-stubs.c    | 18 ++++++++++++++++++
 migration/cpr.c            | 14 +++++---------
 hw/vfio/meson.build        |  1 +
 6 files changed, 39 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio/iommufd-stubs.c

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index b9b77ae..619af07 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -74,5 +74,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                                int nr);
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
+extern const VMStateDescription vmstate_cpr_vfio_devices;
 
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 7fd8065..8fd8bfe 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -9,11 +9,23 @@
 #define MIGRATION_CPR_H
 
 #include "qapi/qapi-types-migration.h"
+#include "qemu/queue.h"
 
 #define MIG_MODE_NONE           -1
 
 #define QEMU_CPR_FILE_MAGIC     0x51435052
 #define QEMU_CPR_FILE_VERSION   0x00000001
+#define CPR_STATE "CprState"
+
+typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
+typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
+
+typedef struct CprState {
+    CprFdList fds;
+    CprVFIODeviceList vfio_devices;
+} CprState;
+
+extern CprState cpr_state;
 
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 60bd7e8..3e78265 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -14,6 +14,8 @@
 #include "system/iommufd.h"
 #include "vfio-iommufd.h"
 
+const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
+
 static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
 {
     if (!iommufd_change_process_capable(be)) {
diff --git a/hw/vfio/iommufd-stubs.c b/hw/vfio/iommufd-stubs.c
new file mode 100644
index 0000000..0be5276
--- /dev/null
+++ b/hw/vfio/iommufd-stubs.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "migration/cpr.h"
+#include "migration/vmstate.h"
+
+const VMStateDescription vmstate_cpr_vfio_devices = {
+    .name = CPR_STATE "/vfio devices",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]){
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/migration/cpr.c b/migration/cpr.c
index 4574608..47898ab 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -22,13 +22,7 @@
 /*************************************************************************/
 /* cpr state container for all information to be saved. */
 
-typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
-
-typedef struct CprState {
-    CprFdList fds;
-} CprState;
-
-static CprState cpr_state;
+CprState cpr_state;
 
 /****************************************************************************/
 
@@ -129,8 +123,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 }
 
 /*************************************************************************/
-#define CPR_STATE "CprState"
-
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
     .version_id = 1,
@@ -138,6 +130,10 @@ static const VMStateDescription vmstate_cpr_state = {
     .fields = (VMStateField[]) {
         VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_cpr_vfio_devices,
+        NULL
     }
 };
 /*************************************************************************/
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 56373e3..b9420cf 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -33,6 +33,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
   'cpr-iommufd.c',
 ))
+system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
 ))
-- 
1.8.3.1


