Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9855AC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8df-0007Le-6W; Wed, 15 Jan 2025 14:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dZ-0007HY-Ny
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dX-0005dv-Oc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:09 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtlJA008390;
 Wed, 15 Jan 2025 19:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=wf4PSR3VAzq38yh5VF55A15O/FurG8XbnyosuBpb0ZA=; b=
 Hneo+EH8bufLMvNVUOvI/rJ3xx8GpJjO2mU0zz0gydhJ5HNyZReGITJ9jjkTDyDS
 jv4uLIYyh/SnsrKUnd47PEr7EwoWMrxyL08+fPvlqb/N6dZcNS0sgdvxir3OgrbY
 qBkOl2YZBBBpOjMZzuRakrpuHLj1YgbXWV4r7JBwj0MkL10eou59FuLsbrVCPkG8
 X5JeJaXqoGkXVviZKz5xLUKAiEUJlMA3NkUn9OZ4Img8EXR8FiGg7RRk/GCHYSkd
 cPGYH8aYfi8spJNAh4uIDCYuDbT7Rgzyh0M/FtMDmUkzqb77IT5EkCDoExG3Nz8h
 j8BeesaR5UDBjS+eXyNxJQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjarpt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FInbGt034910; Wed, 15 Jan 2025 19:01:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39ur75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:02 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0peN016497;
 Wed, 15 Jan 2025 19:01:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-16; Wed, 15 Jan 2025 19:01:02 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 15/24] migration: cpr-transfer save and load
Date: Wed, 15 Jan 2025 11:00:41 -0800
Message-Id: <1736967650-129648-16-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-GUID: y2DCBtk6lNldU0EcvRHhNlLZ_mICrbL7
X-Proofpoint-ORIG-GUID: y2DCBtk6lNldU0EcvRHhNlLZ_mICrbL7
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.793,
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

Add functions to create a QEMUFile based on a unix URI, for saving or
loading, for use by cpr-transfer mode to preserve CPR state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h  |  3 ++
 migration/cpr-transfer.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build    |  1 +
 migration/trace-events   |  2 ++
 4 files changed, 77 insertions(+)
 create mode 100644 migration/cpr-transfer.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index d9364f7..c669b8b 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -22,4 +22,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
+
 #endif
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
new file mode 100644
index 0000000..e1f1403
--- /dev/null
+++ b/migration/cpr-transfer.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "io/channel-file.h"
+#include "io/channel-socket.h"
+#include "io/net-listener.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/savevm.h"
+#include "migration/qemu-file.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
+{
+    MigrationAddress *addr = channel->addr;
+
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        g_autoptr(QIOChannelSocket) sioc = qio_channel_socket_new();
+        QIOChannel *ioc = QIO_CHANNEL(sioc);
+        SocketAddress *saddr = &addr->u.socket;
+
+        if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
+            return NULL;
+        }
+        trace_cpr_transfer_output(addr->u.socket.u.q_unix.path);
+        qio_channel_set_name(ioc, "cpr-out");
+        return qemu_file_new_output(ioc);
+
+    } else {
+        error_setg(errp, "bad cpr channel address; must be unix");
+        return NULL;
+    }
+}
+
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
+{
+    MigrationAddress *addr = channel->addr;
+
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        g_autoptr(QIOChannelSocket) sioc = NULL;
+        SocketAddress *saddr = &addr->u.socket;
+        g_autoptr(QIONetListener) listener = qio_net_listener_new();
+        QIOChannel *ioc;
+
+        qio_net_listener_set_name(listener, "cpr-socket-listener");
+        if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
+            return NULL;
+        }
+
+        sioc = qio_net_listener_wait_client(listener);
+        ioc = QIO_CHANNEL(sioc);
+        trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
+        qio_channel_set_name(ioc, "cpr-in");
+        return qemu_file_new_input(ioc);
+
+    } else {
+        error_setg(errp, "bad cpr channel socket type; must be unix");
+        return NULL;
+    }
+}
diff --git a/migration/meson.build b/migration/meson.build
index 1eb8c96..d3bfe84 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -15,6 +15,7 @@ system_ss.add(files(
   'channel.c',
   'channel-block.c',
   'cpr.c',
+  'cpr-transfer.c',
   'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
diff --git a/migration/trace-events b/migration/trace-events
index abd9cdf..e03a914 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -350,6 +350,8 @@ cpr_delete_fd(const char *name, int id) "%s, id %d"
 cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
 cpr_state_save(const char *mode) "%s mode"
 cpr_state_load(const char *mode) "%s mode"
+cpr_transfer_input(const char *path) "%s"
+cpr_transfer_output(const char *path) "%s"
 
 # block-dirty-bitmap.c
 send_bitmap_header_enter(void) ""
-- 
1.8.3.1


