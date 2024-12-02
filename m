Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21B2D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Wg-0006k0-If; Mon, 02 Dec 2024 08:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lw-00082P-Pz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lo-0005oM-3d
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:39 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26XhdX006129;
 Mon, 2 Dec 2024 13:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=ifO6Q95YO4NBRU+rtzLgiEN95kUc7QMXkoyWvLHpnt8=; b=
 E5F7FV2g41D2u62FJwjBHKn67eAC7Pt5uG75fa+Mli/m5GdgrD+LaVBJVDIZgR43
 5o/T8/Ilx/EGSc27/xtNgIZzhP/m7uNyZQR98p10mbrUw27p4Mfne2BXzSM+3LDl
 ILMwWGYU66gWx/70GaTzyxgtwNI5ZhvfCj7j7O/u5e8l07eDr+bIVW+73oAfxGeZ
 qjr/helPIw2Uv61IOo8NLywGFqDardHViCUSjrG8VQD4KIi9HfAetyEqZZzQ3c3j
 a+hks0x3PWBDpq5RByqTgTqNpcBIj/Ivfbi9WHCCytLReI03piRisde18BDdfH/e
 qdG3tCDF8P7KnN9Jnk4lAw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk8txgy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2C6OXX032775; Mon, 2 Dec 2024 13:20:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEx032806;
 Mon, 2 Dec 2024 13:20:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-14; Mon, 02 Dec 2024 13:20:22 +0000
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
Subject: [PATCH V4 13/19] migration: cpr-transfer save and load
Date: Mon,  2 Dec 2024 05:20:05 -0800
Message-Id: <1733145611-62315-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-ORIG-GUID: UZDToqFlPDqH6gwxVHpBtJU9idD43S5w
X-Proofpoint-GUID: UZDToqFlPDqH6gwxVHpBtJU9idD43S5w
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add functions to create a QEMUFile based on a unix URI, for saving or
loading, for use by cpr-transfer mode to preserve CPR state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h  |  3 ++
 migration/cpr-transfer.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build    |  1 +
 migration/trace-events   |  2 ++
 4 files changed, 82 insertions(+)
 create mode 100644 migration/cpr-transfer.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index e833fae..51ac7f4 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -25,4 +25,7 @@ int cpr_state_load(Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
+
 #endif
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
new file mode 100644
index 0000000..0fbdf66
--- /dev/null
+++ b/migration/cpr-transfer.c
@@ -0,0 +1,76 @@
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
+    QIOChannel *ioc;
+    MigrationAddress *addr = channel->addr;
+
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        QIOChannelSocket *sioc = qio_channel_socket_new();
+        SocketAddress *saddr = &addr->u.socket;
+
+        if (qio_channel_socket_connect_sync(sioc, saddr, errp)) {
+            object_unref(OBJECT(sioc));
+            return NULL;
+        }
+        ioc = QIO_CHANNEL(sioc);
+
+    } else {
+        error_setg(errp, "bad cpr channel address; must be unix");
+        return NULL;
+    }
+
+    trace_cpr_transfer_output(addr->u.socket.u.q_unix.path);
+    qio_channel_set_name(ioc, "cpr-out");
+    return qemu_file_new_output(ioc);
+}
+
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
+{
+    QIOChannel *ioc;
+    MigrationAddress *addr = channel->addr;
+
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        QIOChannelSocket *sioc;
+        SocketAddress *saddr = &addr->u.socket;
+        QIONetListener *listener = qio_net_listener_new();
+
+        qio_net_listener_set_name(listener, "cpr-socket-listener");
+        if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
+            object_unref(OBJECT(listener));
+            return NULL;
+        }
+
+        sioc = qio_net_listener_wait_client(listener);
+        ioc = QIO_CHANNEL(sioc);
+
+    } else {
+        error_setg(errp, "bad cpr channel socket type; must be unix");
+        return NULL;
+    }
+
+    trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
+    qio_channel_set_name(ioc, "cpr-in");
+    return qemu_file_new_input(ioc);
+}
diff --git a/migration/meson.build b/migration/meson.build
index 039f0f9..d89435b 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -14,6 +14,7 @@ system_ss.add(files(
   'channel.c',
   'channel-block.c',
   'cpr.c',
+  'cpr-transfer.c',
   'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
diff --git a/migration/trace-events b/migration/trace-events
index 9388f81..1dd394d 100644
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


