Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FAAE6B27C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s12-0004IQ-BH; Fri, 01 Nov 2024 09:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0z-0004CX-6N
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0w-0002HO-MM
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1DfegQ009327;
 Fri, 1 Nov 2024 13:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=Ng077bxtBe+BwuWE8Ytq2oKycG1Y8NibxMVLxV82HMA=; b=
 nroRRMuLUVQFciWMJGqEfv/uG63pFxfYmNVM4yHADa7btCDN8ize/PsKm3y1mJqA
 dPPrf3TkR+93xJ8e8IriptsOP9Qu/D0jtxwkNfYjWpZFMcolKJQ2M0Pm3m7Qyfkn
 2HCTc9Ourqm7wbJDzZgrjLMZQUutxBjFZIr0L/faGbolI5vXJfOh/34OYqdPWIRe
 82wyXM6UEt0EUR3osr3SeszUc7HaRol8HaOY4HayRMPyYHp+TLu6+oabV6PlLaBj
 Xti44UDKE3qxX9ssfmxc0BZBv91IQArIrG3mQZlThUECzIMjKwBLEZK1DjTSRdD4
 lZrwUKxFhiueiGcD6ezepg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdpca0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1CloLm010012; Fri, 1 Nov 2024 13:48:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91ptk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuOE006031;
 Fri, 1 Nov 2024 13:48:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-8; Fri, 01 Nov 2024 13:48:30 +0000
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
Subject: [PATCH V3 07/16] migration: cpr-transfer save and load
Date: Fri,  1 Nov 2024 06:47:46 -0700
Message-Id: <1730468875-249970-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010100
X-Proofpoint-ORIG-GUID: Yz7naI_RtePmTy93SEhtIRIbb9gebNYx
X-Proofpoint-GUID: Yz7naI_RtePmTy93SEhtIRIbb9gebNYx
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
 migration/cpr-transfer.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/meson.build    |  1 +
 3 files changed, 85 insertions(+)
 create mode 100644 migration/cpr-transfer.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 6e4781c..ae318da 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -20,4 +20,7 @@ int cpr_state_load(Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
+QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
+
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
index e5f4211..684ba98 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -14,6 +14,7 @@ system_ss.add(files(
   'channel.c',
   'channel-block.c',
   'cpr.c',
+  'cpr-transfer.c',
   'dirtyrate.c',
   'exec.c',
   'fd.c',
-- 
1.8.3.1


