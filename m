Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F1EC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sET3r-0003jU-I1; Tue, 04 Jun 2024 08:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3l-0003gl-Rv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3i-0006xV-92
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:37 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VtqDg1ybZz355fS;
 Tue,  4 Jun 2024 20:10:43 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id A0ED81A0188;
 Tue,  4 Jun 2024 20:14:23 +0800 (CST)
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
Subject: [PATCH 6/6] migration/rdma: support multifd for RDMA migration
Date: Tue, 4 Jun 2024 20:14:12 +0800
Message-ID: <1717503252-51884-7-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.124.235]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=arei.gonglei@huawei.com; helo=szxga05-in.huawei.com
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
 migration/multifd.c | 10 ++++++++++
 migration/rdma.c    | 27 +++++++++++++++++++++++++++
 migration/rdma.h    |  6 ++++++
 3 files changed, 43 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index f317bff077..cee9858ad1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -32,6 +32,7 @@
 #include "io/channel-file.h"
 #include "io/channel-socket.h"
 #include "yank_functions.h"
+#include "rdma.h"
 
 /* Multiple fd's */
 
@@ -793,6 +794,9 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 static void multifd_send_cleanup_state(void)
 {
     file_cleanup_outgoing_migration();
+#ifdef CONFIG_RDMA
+    rdma_cleanup_outgoing_migration();
+#endif
     socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
@@ -1139,6 +1143,12 @@ static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
         return file_send_channel_create(opaque, errp);
     }
 
+#ifdef CONFIG_RDMA
+    if (rdma_send_channel_create(multifd_new_send_channel_async, opaque)) {
+        return true;
+    }
+#endif
+
     socket_send_channel_create(multifd_new_send_channel_async, opaque);
     return true;
 }
diff --git a/migration/rdma.c b/migration/rdma.c
index 09a4de7f59..af4d2b5a5a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -19,6 +19,7 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "channel.h"
 #include "migration.h"
+#include "options.h"
 #include "rdma.h"
 #include "trace.h"
 #include <stdio.h>
@@ -27,6 +28,28 @@ static struct RDMAOutgoingArgs {
     InetSocketAddress *addr;
 } outgoing_args;
 
+bool rdma_send_channel_create(QIOTaskFunc f, void *data)
+{
+    QIOChannelRDMA *rioc;
+
+    if (!outgoing_args.addr) {
+        return false;
+    }
+
+    rioc = qio_channel_rdma_new();
+    qio_channel_rdma_connect_async(rioc, outgoing_args.addr, f, data, NULL,
+                                   NULL);
+    return true;
+}
+
+void rdma_cleanup_outgoing_migration(void)
+{
+    if (outgoing_args.addr) {
+        qapi_free_InetSocketAddress(outgoing_args.addr);
+        outgoing_args.addr = NULL;
+    }
+}
+
 static void rdma_outgoing_migration(QIOTask *task, gpointer opaque)
 {
     MigrationState *s = opaque;
@@ -74,6 +97,10 @@ void rdma_start_incoming_migration(InetSocketAddress *addr, Error **errp)
 
     qio_channel_set_name(QIO_CHANNEL(rioc), "migration-rdma-listener");
 
+    if (migrate_multifd()) {
+        num = migrate_multifd_channels();
+    }
+
     if (qio_channel_rdma_listen_sync(rioc, addr, num, errp) < 0) {
         object_unref(OBJECT(rioc));
         return;
diff --git a/migration/rdma.h b/migration/rdma.h
index 4c3eb9a972..cefccac61c 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -16,6 +16,12 @@
 
 #include "qemu/sockets.h"
 
+#include <stdbool.h>
+
+bool rdma_send_channel_create(QIOTaskFunc f, void *data);
+
+void rdma_cleanup_outgoing_migration(void);
+
 void rdma_start_outgoing_migration(MigrationState *s, InetSocketAddress *addr,
                                    Error **errp);
 
-- 
2.43.0


