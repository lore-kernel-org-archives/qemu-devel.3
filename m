Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7569C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis8-00041f-QL; Thu, 29 May 2025 15:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKis1-0003yi-AD
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirz-0000Cg-CR
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:52 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGftKh028811;
 Thu, 29 May 2025 19:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fn9Ul1ZSAWE0UsTA8pqOIPwoHaU3Qen+1oYrf2IiXWU=; b=
 WuJcblBguGcMdM9F6GUObJxJBgThKPidKikyFN42ddYVZAxv4SKlTubuVME/NVLZ
 UWOXeqsCVrWCNbNByEXgxzy4zFaQEW+Aji2LiyE97u06uLGrAnGF2NiGp8Ozy0pY
 9hFMMQizd+xMW2CKoDbUkO0NyriFgaHb00nGqNoDVez/Svo4iInYKM8jiGMroyNO
 Vm2QD4wQhpdApixurOtH4DBafUUhWb+g1d8oEkWk085AZI7yEKvvHexGYcGn3W2q
 NOpWZxbc9a5tT9cK/NZ12PO6w/T6g/iaTovwQpQ/sODmdUllmN4SMUqgsgrmraiP
 HB8q7JK2VSYBJAPwoZwxyA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd8qwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJNsJB020611; Thu, 29 May 2025 19:24:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeR3022158;
 Thu, 29 May 2025 19:24:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-9; Thu, 29 May 2025 19:24:47 +0000
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
Subject: [PATCH V4 08/43] vfio: move vfio-cpr.h
Date: Thu, 29 May 2025 12:24:04 -0700
Message-Id: <1748546679-154091-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-ORIG-GUID: yMgdv1oxsFXC0Bef9owVNhR7HaXtQXeo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXyM3Xk15EVn90
 IxUYDS2gvhGQXi2AaOVmr4mOMr5u2PAB1T0Q/Z3JluB8M/P3bK2KtXKsd9GL9nrmV/QSjOK2+f6
 J5tdpjJXft7ruuNg7vVf1ER0qs6Ljtb8HqUcAOC8+lMbKbUAI06dR6TJQGpH76SvJCHEBcvQ3Ug
 012hcwvYfH6V2zfZTGcSZ2ydW60r8WA+FfoCHqNEn8ObegdeAVzCG26cTI4RF2luYmAgj9yMxtC
 bRUMynr8V3KGx8sn6pPd1cGW0sLetCLF6l/OF6So1U68URpKsTzab7NcJYEgGVcUA5+HLeJEYaX
 so8dq/gPoGpyDhx12DLJnm3DMkNcMGx8TJMyW2JVZ3AYM5cqxNP3zHxP0hjC1bfXaXxp+IU+I6h
 H/dh8aT11pnZY64jHVsIzdwl/veNMzbbElRMianGIl+y624a33ranIx3XoRBOdJGp7ZnOb/q
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6838b480 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=AbqfWwymkoT623_jBzUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yMgdv1oxsFXC0Bef9owVNhR7HaXtQXeo
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

Move vfio-cpr.h to include/hw/vfio, because it will need to be included by
other files there.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                |  1 +
 hw/vfio/vfio-cpr.h         | 15 ---------------
 include/hw/vfio/vfio-cpr.h | 18 ++++++++++++++++++
 hw/vfio/container.c        |  2 +-
 hw/vfio/cpr.c              |  2 +-
 hw/vfio/iommufd.c          |  2 +-
 6 files changed, 22 insertions(+), 18 deletions(-)
 delete mode 100644 hw/vfio/vfio-cpr.h
 create mode 100644 include/hw/vfio/vfio-cpr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e29fb4f..7b919d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3034,6 +3034,7 @@ CheckPoint and Restart (CPR)
 R: Steve Sistare <steven.sistare@oracle.com>
 S: Supported
 F: hw/vfio/cpr*
+F: include/hw/vfio/vfio-cpr.h
 F: include/migration/cpr.h
 F: migration/cpr*
 F: tests/qtest/migration/cpr*
diff --git a/hw/vfio/vfio-cpr.h b/hw/vfio/vfio-cpr.h
deleted file mode 100644
index 134b83a..0000000
--- a/hw/vfio/vfio-cpr.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * VFIO CPR
- *
- * Copyright (c) 2025 Oracle and/or its affiliates.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_VFIO_CPR_H
-#define HW_VFIO_CPR_H
-
-bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
-void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
-
-#endif /* HW_VFIO_CPR_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
new file mode 100644
index 0000000..750ea5b
--- /dev/null
+++ b/include/hw/vfio/vfio-cpr.h
@@ -0,0 +1,18 @@
+/*
+ * VFIO CPR
+ *
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_CPR_H
+#define HW_VFIO_VFIO_CPR_H
+
+struct VFIOContainerBase;
+
+bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
+                                 Error **errp);
+void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
+
+#endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a8c76eb..0f948d0 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,8 +33,8 @@
 #include "qapi/error.h"
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "vfio-helpers.h"
-#include "vfio-cpr.h"
 #include "vfio-listener.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3214184..0210e76 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -8,9 +8,9 @@
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-device.h"
 #include "migration/misc.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
-#include "vfio-cpr.h"
 
 static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
                                     MigrationEvent *e, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a8cc543..eb2f88d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -21,13 +21,13 @@
 #include "qapi/error.h"
 #include "system/iommufd.h"
 #include "hw/qdev-core.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
-#include "vfio-cpr.h"
 #include "vfio-listener.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
-- 
1.8.3.1


