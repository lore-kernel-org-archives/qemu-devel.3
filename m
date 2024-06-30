Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE4CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0TH-0007WZ-GG; Sun, 30 Jun 2024 15:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0TF-0007Vh-4j
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0T6-0006P2-O5
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJdPwK028776;
 Sun, 30 Jun 2024 19:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=n82o1TU97EyS5y3b5BxzvwF+Cm4itWy9ULFCdnBgjAg=; b=
 Fk89f9ZAGHOQWZFiaGSVJtmMzkVmubV77ZLgUCSBJ1yHQbKqnRZ71UonPvAOeeF3
 bf5O7p4I6b5pLULvuqQvd2XGWsKCtz9xKYn9bAGI5VDNh9hYwqYI2zGtyBLL5VXy
 4WbfoQ8gmWDLvdywne5s/4ktTWvE4P54eKVv2C1bPpWw1deHyZRLaxJz5uclmVIa
 bTuE2XnG/7Ea+Jk+rB665FZLtycic0Foj/Q+owOv1COunG4QN1oa7y/y4t/YMXet
 3n1gNX8h0p2iz5alUf4ElqqjcdX71kJlHFDn2KUoT7vW9rDS+4Kc8+rSC0jJAQK7
 txUFv+zisXYCGFNnqQsngQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a591esm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UIQkq7022828; Sun, 30 Jun 2024 19:44:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4028q5gg4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJg4f6039161;
 Sun, 30 Jun 2024 19:44:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 4028q5gg4e-4; Sun, 30 Jun 2024 19:44:10 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 3/6] migration: cpr-transfer save and load
Date: Sun, 30 Jun 2024 12:44:05 -0700
Message-Id: <1719776648-435073-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300157
X-Proofpoint-GUID: PYcfq5jlILKbDAdOwoZ_6tB574kteNxp
X-Proofpoint-ORIG-GUID: PYcfq5jlILKbDAdOwoZ_6tB574kteNxp
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 include/migration/cpr.h  |  3 ++
 migration/cpr-transfer.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build    |  1 +
 3 files changed, 85 insertions(+)
 create mode 100644 migration/cpr-transfer.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index c6c60f8..9aae94c 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -32,4 +32,7 @@ bool cpr_exec_has_state(void);
 void cpr_exec_unpersist_state(void);
 void cpr_mig_init(void);
 void cpr_unpreserve_fds(void);
+
+QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
+QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
 #endif
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
new file mode 100644
index 0000000..fb9ecd8
--- /dev/null
+++ b/migration/cpr-transfer.c
@@ -0,0 +1,81 @@
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
+
+QEMUFile *cpr_transfer_output(const char *uri, Error **errp)
+{
+    g_autoptr(MigrationChannel) channel = NULL;
+    QIOChannel *ioc;
+
+    if (!migrate_uri_parse(uri, &channel, errp)) {
+        return NULL;
+    }
+
+    if (channel->addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        channel->addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        QIOChannelSocket *sioc = qio_channel_socket_new();
+        SocketAddress *saddr = &channel->addr->u.socket;
+
+        if (qio_channel_socket_connect_sync(sioc, saddr, errp)) {
+            object_unref(OBJECT(sioc));
+            return NULL;
+        }
+        ioc = QIO_CHANNEL(sioc);
+
+    } else {
+        error_setg(errp, "bad cpr-uri %s; must be unix:", uri);
+        return NULL;
+    }
+
+    qio_channel_set_name(ioc, "cpr-out");
+    return qemu_file_new_output(ioc);
+}
+
+QEMUFile *cpr_transfer_input(const char *uri, Error **errp)
+{
+    g_autoptr(MigrationChannel) channel = NULL;
+    QIOChannel *ioc;
+
+    if (!migrate_uri_parse(uri, &channel, errp)) {
+        return NULL;
+    }
+
+    if (channel->addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        channel->addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        QIOChannelSocket *sioc;
+        SocketAddress *saddr = &channel->addr->u.socket;
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
+        error_setg(errp, "bad cpr-uri %s; must be unix:", uri);
+        return NULL;
+    }
+
+    qio_channel_set_name(ioc, "cpr-in");
+    return qemu_file_new_input(ioc);
+}
diff --git a/migration/meson.build b/migration/meson.build
index dd1d315..f722980 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -15,6 +15,7 @@ system_ss.add(files(
   'channel-block.c',
   'cpr.c',
   'cpr-exec.c',
+  'cpr-transfer.c',
   'dirtyrate.c',
   'exec.c',
   'fd.c',
-- 
1.8.3.1


