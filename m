Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3256C3ABDA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9Q-0003oH-FA; Mon, 12 May 2025 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9N-0003je-Fv
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9K-0006eK-Jg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9x3T018773;
 Mon, 12 May 2025 15:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=o2BPSyk4hmWf/SpdNWGBZh4xxcS8+0kbf3G56bavgP0=; b=
 pElGkKQXdASvmvWk2/6rqrI5kfVHeOcWZYVf8kAZBM6h2aMABxkz6GJ3P3XdPpZf
 TushtfIM7bgYxBN0s9x6lPwKliWdNYeh8agxLUsIea4TGxZVTNrvfi2EfDbRLS1+
 9wOyTiqdfiJXAifjg52kcyxsek5E6chr4LV3jYLMEnPuvjkkEXBShtvDdKAclSrY
 i5pDC0zdxvKXC+V1kryUg6hUEqfN73nVAUQPR3QrHpU4eibh9Ooc/kQaJ5TOP9tH
 FTW7EWD9IONMp0E7liUE5s+buUYgvJBzbCeqSqQN9WkE1ux49OUc4jtDH1HCO7Qs
 eFYw18Yj0rjnln4ecPyd+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEDx3g002961; Mon, 12 May 2025 15:32:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3665v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4m030605;
 Mon, 12 May 2025 15:32:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-6; Mon, 12 May 2025 15:32:58 +0000
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
Subject: [PATCH V3 05/42] vfio: move vfio-cpr.h
Date: Mon, 12 May 2025 08:32:16 -0700
Message-Id: <1747063973-124548-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX10RN49o8b1za
 7USi/sj10tMpS5BnwQbGWp9EEDYPDs7XI7kpPkOpwX7f1BNqUZenkq3Cz1mg9lICjD+91K8raRc
 j5t1WxhFVZoazBdj1H1rS/zjGj18JBhxAHz0+FIxOOhkTLIr9V69SwnZMvi3lJHJ871/SkpfJuD
 cCtSWs5cx0rTxDb2RCCXwcyeI2ovLOdpWJH69P6LzZ0pl8LHEEc0kxXCLYFjl79iFarLTqQIJ2H
 umhKGNRR/mPHE1uObUbpyLGdUG2cTgHhyHk+BpaIp/rY4wVWKl7Q2MtraNikGXA2s6Aii8dMmkU
 +uJ5PcseF/lonp6bDmcW2TIni8WF+hup7XPndhxyEblAZAhoKs+Qva3qbnzYNNVhKboHqCcc2U5
 2pAoXAynluho36LcqUmfc6w806Bm19MIO/cxnLc5qu31C/CIqquUXBt8IkH1oRtPRE5yzE0L
X-Proofpoint-GUID: Nwy5Zgh6LzjP9si8dhSvbS_mv1rIsmoS
X-Proofpoint-ORIG-GUID: Nwy5Zgh6LzjP9si8dhSvbS_mv1rIsmoS
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214ab b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=AbqfWwymkoT623_jBzUA:9
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
---
 MAINTAINERS                |  1 +
 hw/vfio/container.c        |  2 +-
 hw/vfio/cpr.c              |  2 +-
 hw/vfio/iommufd.c          |  2 +-
 hw/vfio/vfio-cpr.h         | 15 ---------------
 include/hw/vfio/vfio-cpr.h | 18 ++++++++++++++++++
 6 files changed, 22 insertions(+), 18 deletions(-)
 delete mode 100644 hw/vfio/vfio-cpr.h
 create mode 100644 include/hw/vfio/vfio-cpr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d54a532..9bee3cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3023,6 +3023,7 @@ CheckPoint and Restart (CPR)
 R: Steve Sistare <steven.sistare@oracle.com>
 S: Supported
 F: hw/vfio/cpr*
+F: include/hw/vfio/vfio-cpr.h
 F: include/migration/cpr.h
 F: migration/cpr*
 F: tests/qtest/migration/cpr*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a9f0dba..eb56f00 100644
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
index af1c7ab..167bda4 100644
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
-- 
1.8.3.1


