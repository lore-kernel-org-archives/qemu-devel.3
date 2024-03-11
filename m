Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EA2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjm5-00020M-OD; Mon, 11 Mar 2024 13:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm4-0001zV-1Y
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjlo-0008Tj-Fa
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG46gs011922; Mon, 11 Mar 2024 17:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=6y8I3EaPx19dsJG+yzx2YDiAWapdAcWTjFgfCVHmZEo=;
 b=c0M03AnLxiWOWQ7oUn1yhYA2Ev+Pao/X8m5OF8e7HH1IQDTXvEivzzO89DT8akgafNN9
 FuH/Z9aVQe6om/NUAzDl1jL6HSjQpl1oSV5+d3R7O+n4EG6Y2fIu2/7AexXU2m1Ntb3r
 T+YSTpRsQ4Ojn4tMwuH3rATNq1KMw5JLkmzENapuk3ylszLOsWqg+u82ZeKG6jBOPdRq
 04SCveTiTODZsoodFNvcypdlEiBQ6fI6maEbmmVWStkmRg18nU+boOzuXeILolhPprTM
 TwhdJQorgdPXmOeL5jAUD7tkXgmkxE7Ybh3Ql3/vkvQflUT6IP9I20mLsAZRVvvrEHEh cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ec0xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:00 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHIji1028602; Mon, 11 Mar 2024 17:48:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7632qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:48:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHmhbU024177;
 Mon, 11 Mar 2024 17:48:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre7632me-1; Mon, 11 Mar 2024 17:48:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3] migration: export fewer options
Date: Mon, 11 Mar 2024 10:48:39 -0700
Message-Id: <1710179319-294320-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110136
X-Proofpoint-GUID: 1ljBWEZLoNVrrs-PN31tPVKIN_8ZjAUj
X-Proofpoint-ORIG-GUID: 1ljBWEZLoNVrrs-PN31tPVKIN_8ZjAUj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

A small number of migration options are accessed by migration clients,
but to see them clients must include all of options.h, which is mostly
for migration core code.  migrate_mode() in particular will be needed by
multiple clients.

Refactor the option declarations so clients can see the necessary few via
misc.h, which already exports a portion of the client API.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
Changes in V3:
  * rebase to migration-next
---
---
 hw/vfio/migration.c                |  1 -
 hw/virtio/virtio-balloon.c         |  1 -
 include/migration/client-options.h | 24 ++++++++++++++++++++++++
 include/migration/misc.h           |  1 +
 migration/options.h                |  6 +-----
 system/dirtylimit.c                |  1 -
 6 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 include/migration/client-options.h

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 50140ed..5d4a23c 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -18,7 +18,6 @@
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/migration.h"
-#include "migration/options.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 89f853f..a59ff17 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -32,7 +32,6 @@
 #include "qemu/error-report.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
-#include "migration/options.h"
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/include/migration/client-options.h b/include/migration/client-options.h
new file mode 100644
index 0000000..887fea1
--- /dev/null
+++ b/include/migration/client-options.h
@@ -0,0 +1,24 @@
+/*
+ * QEMU public migration capabilities
+ *
+ * Copyright (c) 2012-2023 Red Hat Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_CLIENT_OPTIONS_H
+#define QEMU_MIGRATION_CLIENT_OPTIONS_H
+
+/* capabilities */
+
+bool migrate_background_snapshot(void);
+bool migrate_dirty_limit(void);
+bool migrate_postcopy_ram(void);
+bool migrate_switchover_ack(void);
+
+/* parameters */
+
+MigMode migrate_mode(void);
+
+#endif
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5d1aa59..4c226a4 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -17,6 +17,7 @@
 #include "qemu/notify.h"
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-types-net.h"
+#include "migration/client-options.h"
 
 /* migration/ram.c */
 
diff --git a/migration/options.h b/migration/options.h
index 6ddd8da..b6b69c2 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -16,6 +16,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/client-options.h"
 
 /* migration properties */
 
@@ -24,12 +25,10 @@ extern Property migration_properties[];
 /* capabilities */
 
 bool migrate_auto_converge(void);
-bool migrate_background_snapshot(void);
 bool migrate_block(void);
 bool migrate_colo(void);
 bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
-bool migrate_dirty_limit(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
 bool migrate_ignore_shared(void);
@@ -38,11 +37,9 @@ bool migrate_multifd(void);
 bool migrate_pause_before_switchover(void);
 bool migrate_postcopy_blocktime(void);
 bool migrate_postcopy_preempt(void);
-bool migrate_postcopy_ram(void);
 bool migrate_rdma_pin_all(void);
 bool migrate_release_ram(void);
 bool migrate_return_path(void);
-bool migrate_switchover_ack(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_blocks(void);
@@ -84,7 +81,6 @@ uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
 uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
-MigMode migrate_mode(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index b5607eb..774ff44 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -26,7 +26,6 @@
 #include "trace.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
-#include "migration/options.h"
 
 /*
  * Dirtylimit stop working if dirty page rate error
-- 
1.8.3.1


