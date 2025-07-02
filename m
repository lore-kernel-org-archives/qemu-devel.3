Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C699EC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5UD-0003Wg-9u; Wed, 02 Jul 2025 17:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UB-0003WN-N8
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U0-0003ig-Vy
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQkQE019503;
 Wed, 2 Jul 2025 21:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=db32jM6k2dT+QYMa6s5Z+22X3vI7epg9Xqj3kp603/I=; b=
 RXhChntPt552vcHXAgo0b5VMWIvWOXb+tUWvpTfBQbl9/qKtHoJnHfELIINHRzvZ
 xl0QFaXstQcuY67i3/SHkravDhfimhpfh6P4WCfpu1R0CA6LuB6JWft7T2OkH7O+
 2dcfqvv3AoJiesFnPvtzmIl6rYvSX14aaBSxhVMk3QY7G7ogit/rzoGU+oKmMf18
 hpNPWv/4CqM/fGuzpaF22sKT+QvtLTrJaFRnjehsfz4t/Rxqy7AoI1t2LPs0OzNc
 QU2y7FEPivMz/ACXKV5CB1KqRJG5bFOiRyixMx3CBN+l9av5RiJ8dn/FNFk4Pvdu
 oAr4+xzRygpY9u765UEgog==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7y5bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LlpmL033648; Wed, 2 Jul 2025 21:59:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgK020012;
 Wed, 2 Jul 2025 21:59:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-14; Wed, 02 Jul 2025 21:59:08 +0000
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
Subject: [PATCH V6 13/21] migration: vfio cpr state hook
Date: Wed,  2 Jul 2025 14:58:50 -0700
Message-Id: <1751493538-202042-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX08UkYtQGEmDn
 +59k6Le7XRaLaH1L4Q1bPCaiW1YZiKWuN/NKHC2qYZxIfNTK+MLilFyinTNxu83XvjejdVI9FsI
 vw9fpqzJE5tOtPvGInuuyRRl749zlI6Uy0qFcvZ+8wam7hrvXpqUirDAlOTTR2JlDo+vEg2uEkc
 lusVwTymqdJ/OZMTrmSxGQ1XlL4omvnw9BjRkkRaeYWk1ADDz3s6sO+K5ujrvg8Y2BMRj3OhG3Z
 qjceKTYyczP0eUvms89ZtS/1OizdZsfWcJDerSRswzWxuCn+m4/mG3I8v1G5ueH6MGcpq5rn2i+
 idHlsR6Cf8mK3btCAQPToad6JqvGXg6VQf1f8Ajp2cM03N93c3xqSe6et+BggQ0+IVw8Dfg91n8
 swu4G5Dorfj5CkLFZxBBBXajwIQF5HYylRiSeEnObeEhxffDGdIKdqoDRCBlRK5V/jtoUtMR
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6865abae cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=98wZ__1tFoD98bssFbsA:9
X-Proofpoint-ORIG-GUID: ftVz1OIzqj6qB7_CwDvM7nkfuvZqmfVJ
X-Proofpoint-GUID: ftVz1OIzqj6qB7_CwDvM7nkfuvZqmfVJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 migration/cpr.c            | 15 ++++++---------
 hw/vfio/meson.build        |  1 +
 6 files changed, 40 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio/iommufd-stubs.c

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index e0e3ee2..c94d5e0 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -74,6 +74,7 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                                int nr);
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
+extern const VMStateDescription vmstate_cpr_vfio_devices;
 
 void vfio_cpr_add_kvm_notifier(void);
 
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index eb27a93..3fc19a7 100644
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
index 2f58b43..f95773b 100644
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
index 535d587..42ad0b0 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/options.h"
@@ -20,13 +21,7 @@
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
 
@@ -127,8 +122,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 }
 
 /*************************************************************************/
-#define CPR_STATE "CprState"
-
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
     .version_id = 1,
@@ -136,6 +129,10 @@ static const VMStateDescription vmstate_cpr_state = {
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
index 7a88174..bfaf6be 100644
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


