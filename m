Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B15DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rejGk-0001qm-3F; Mon, 26 Feb 2024 17:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rejGi-0001qS-43
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 17:16:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rejGf-0002Hz-Tp
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 17:16:15 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QGmnBG007002; Mon, 26 Feb 2024 22:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=sL8E/PaYkZIxwYPpS0QqWnJcZYla/I/TFtY5WtReal8=;
 b=KVydspAk2Uj3wVjh3xFId2zX+rbIbr9AmWWR4jFJhZT/qMj4a2d5aFDZslXx/YK2rs73
 1mDpTUSbJoaZY5ZhCdsFgsuV2rkT6BNRhRUiEcCTXHXNXFfkV44byhvcr5LXd0qhh94b
 hGfxhZj98IJWEzUe3ezmzxH1y4yAKFJaZmNQ5oCFuopvHrD/JL9cLDiPydXheL9GSSy+
 5o2XWQxcGudpmQXP0GasgV1F4qsunbWT18Rb5bDDV4EnDDD3PeaSP4AVk6YQQh1O7WvF
 T7anW6sYSFn1nb0NCx7JXXOwkolU03phJ/B7ws+pMlUEpaOPwwKXstA5CgGZssY0CKWB xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gddvja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 22:16:12 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41QM43k9025727; Mon, 26 Feb 2024 22:16:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6wcrtx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 22:16:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QMGBZa030196;
 Mon, 26 Feb 2024 22:16:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6wcrtw6-1; Mon, 26 Feb 2024 22:16:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2] migration: export fewer options
Date: Mon, 26 Feb 2024 14:16:09 -0800
Message-Id: <1708985769-280850-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260172
X-Proofpoint-ORIG-GUID: swRPScAjKH4wnkeYVfg5tI9hV-Ma9UsQ
X-Proofpoint-GUID: swRPScAjKH4wnkeYVfg5tI9hV-Ma9UsQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Changes in V2:
  * renamed options-pub.h to client-options.h
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
index 246c160..964ebdd 100644
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
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
@@ -37,11 +36,9 @@ bool migrate_multifd(void);
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
@@ -83,7 +80,6 @@ uint8_t migrate_max_cpu_throttle(void);
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


