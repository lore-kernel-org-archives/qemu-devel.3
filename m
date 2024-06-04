Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF2DC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sET3q-0003iw-0Z; Tue, 04 Jun 2024 08:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3l-0003gk-Rx
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3g-0006xF-Qf
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:37 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VtqDf2DGjz2Cjml;
 Tue,  4 Jun 2024 20:10:42 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id DA27A1A016F;
 Tue,  4 Jun 2024 20:14:22 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:22 +0800
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
 <elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
 <lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
 Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 5/6] migration: introduce new RDMA live migration
Date: Tue, 4 Jun 2024 20:14:11 +0800
Message-ID: <1717503252-51884-6-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.124.235]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=arei.gonglei@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Gonglei <arei.gonglei@huawei.com>
From:  Gonglei via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jialin Wang <wangjialin23@huawei.com>

Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 migration/meson.build |  2 +
 migration/migration.c | 11 +++++-
 migration/rdma.c      | 88 +++++++++++++++++++++++++++++++++++++++++++
 migration/rdma.h      | 24 ++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 migration/rdma.c
 create mode 100644 migration/rdma.h

diff --git a/migration/meson.build b/migration/meson.build
index 4e8a9ccf3e..04e2e16239 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -42,3 +42,5 @@ system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
                                'target.c'))
+
+system_ss.add(when: rdma, if_true: files('rdma.c'))
diff --git a/migration/migration.c b/migration/migration.c
index 6b9ad4ff5f..77c301d351 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -25,6 +25,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpu-throttle.h"
+#include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
@@ -145,7 +146,7 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
         return migrate_mapped_ram();
     } else {
-        return false;
+        return addr->transport == MIGRATION_ADDRESS_TYPE_RDMA;
     }
 }
 
@@ -644,6 +645,10 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
+#endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_incoming_migration(addr->u.exec.args, errp);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
@@ -2046,6 +2051,10 @@ void qmp_migrate(const char *uri, bool has_channels,
         } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
+#endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
diff --git a/migration/rdma.c b/migration/rdma.c
new file mode 100644
index 0000000000..09a4de7f59
--- /dev/null
+++ b/migration/rdma.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU live migration via RDMA
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *  Jialin Wang <wangjialin23@huawei.com>
+ *  Gonglei <arei.gonglei@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "io/channel-rdma.h"
+#include "io/channel.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-types-sockets.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "channel.h"
+#include "migration.h"
+#include "rdma.h"
+#include "trace.h"
+#include <stdio.h>
+
+static struct RDMAOutgoingArgs {
+    InetSocketAddress *addr;
+} outgoing_args;
+
+static void rdma_outgoing_migration(QIOTask *task, gpointer opaque)
+{
+    MigrationState *s = opaque;
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qio_task_get_source(task));
+
+    migration_channel_connect(s, QIO_CHANNEL(rioc), outgoing_args.addr->host,
+                              NULL);
+    object_unref(OBJECT(rioc));
+}
+
+void rdma_start_outgoing_migration(MigrationState *s, InetSocketAddress *iaddr,
+                                   Error **errp)
+{
+    QIOChannelRDMA *rioc = qio_channel_rdma_new();
+
+    /* in case previous migration leaked it */
+    qapi_free_InetSocketAddress(outgoing_args.addr);
+    outgoing_args.addr = QAPI_CLONE(InetSocketAddress, iaddr);
+
+    qio_channel_set_name(QIO_CHANNEL(rioc), "migration-rdma-outgoing");
+    qio_channel_rdma_connect_async(rioc, iaddr, rdma_outgoing_migration, s,
+                                   NULL, NULL);
+}
+
+static void coroutine_fn rdma_accept_incoming_migration(void *opaque)
+{
+    QIOChannelRDMA *rioc = opaque;
+    QIOChannelRDMA *cioc;
+
+    while (!migration_has_all_channels()) {
+        cioc = qio_channel_rdma_accept(rioc, NULL);
+
+        qio_channel_set_name(QIO_CHANNEL(cioc), "migration-rdma-incoming");
+        migration_channel_process_incoming(QIO_CHANNEL(cioc));
+        object_unref(OBJECT(cioc));
+    }
+}
+
+void rdma_start_incoming_migration(InetSocketAddress *addr, Error **errp)
+{
+    QIOChannelRDMA *rioc = qio_channel_rdma_new();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    Coroutine *co;
+    int num = 1;
+
+    qio_channel_set_name(QIO_CHANNEL(rioc), "migration-rdma-listener");
+
+    if (qio_channel_rdma_listen_sync(rioc, addr, num, errp) < 0) {
+        object_unref(OBJECT(rioc));
+        return;
+    }
+
+    mis->transport_data = rioc;
+    mis->transport_cleanup = object_unref;
+
+    qio_channel_set_blocking(QIO_CHANNEL(rioc), false, NULL);
+    co = qemu_coroutine_create(rdma_accept_incoming_migration, rioc);
+    aio_co_schedule(qemu_get_current_aio_context(), co);
+}
diff --git a/migration/rdma.h b/migration/rdma.h
new file mode 100644
index 0000000000..4c3eb9a972
--- /dev/null
+++ b/migration/rdma.h
@@ -0,0 +1,24 @@
+/*
+ * QEMU live migration via RDMA
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *  Jialin Wang <wangjialin23@huawei.com>
+ *  Gonglei <arei.gonglei@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_RDMA_H
+#define QEMU_MIGRATION_RDMA_H
+
+#include "qemu/sockets.h"
+
+void rdma_start_outgoing_migration(MigrationState *s, InetSocketAddress *addr,
+                                   Error **errp);
+
+void rdma_start_incoming_migration(InetSocketAddress *addr, Error **errp);
+
+#endif /* QEMU_MIGRATION_RDMA_H */
-- 
2.43.0


