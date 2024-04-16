Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FA5C04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2G-0004vL-Uc; Tue, 16 Apr 2024 10:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2E-0004td-KM
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:46 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2B-0001zN-T5
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:46 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk1s-0002ci-5r; Tue, 16 Apr 2024 16:43:24 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 02/26] migration: Add migration channel header send/receive
Date: Tue, 16 Apr 2024 16:42:41 +0200
Message-ID: <636cec92eb801f13ba893de79d4872f5d8342097.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Add functions to send and receive migration channel header.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
[MSS: Mark MigChannelHeader as packed, remove device id from it]
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/channel.c    | 59 ++++++++++++++++++++++++++++++++++++++++++
 migration/channel.h    | 14 ++++++++++
 migration/trace-events |  2 ++
 3 files changed, 75 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index f9de064f3b13..a72e85f5791c 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -21,6 +21,7 @@
 #include "io/channel-socket.h"
 #include "qemu/yank.h"
 #include "yank_functions.h"
+#include "options.h"
 
 /**
  * @migration_channel_process_incoming - Create new incoming migration channel
@@ -93,6 +94,64 @@ void migration_channel_connect(MigrationState *s,
     error_free(error);
 }
 
+int migration_channel_header_recv(QIOChannel *ioc, MigChannelHeader *header,
+                                  Error **errp)
+{
+    uint64_t header_size;
+    int ret;
+
+    ret = qio_channel_read_all_eof(ioc, (char *)&header_size,
+                                   sizeof(header_size), errp);
+    if (ret == 0 || ret == -1) {
+        return -1;
+    }
+
+    header_size = be64_to_cpu(header_size);
+    if (header_size > sizeof(*header)) {
+        error_setg(errp,
+                   "Received header of size %lu bytes which is greater than "
+                   "max header size of %lu bytes",
+                   header_size, sizeof(*header));
+        return -EINVAL;
+    }
+
+    ret = qio_channel_read_all_eof(ioc, (char *)header, header_size, errp);
+    if (ret == 0 || ret == -1) {
+        return -1;
+    }
+
+    header->channel_type = be32_to_cpu(header->channel_type);
+
+    trace_migration_channel_header_recv(header->channel_type,
+                                        header_size);
+
+    return 0;
+}
+
+int migration_channel_header_send(QIOChannel *ioc, MigChannelHeader *header,
+                                  Error **errp)
+{
+    uint64_t header_size = sizeof(*header);
+    int ret;
+
+    if (!migrate_channel_header()) {
+        return 0;
+    }
+
+    trace_migration_channel_header_send(header->channel_type,
+                                        header_size);
+
+    header_size = cpu_to_be64(header_size);
+    ret = qio_channel_write_all(ioc, (char *)&header_size, sizeof(header_size),
+                                errp);
+    if (ret) {
+        return ret;
+    }
+
+    header->channel_type = cpu_to_be32(header->channel_type);
+
+    return qio_channel_write_all(ioc, (char *)header, sizeof(*header), errp);
+}
 
 /**
  * @migration_channel_read_peek - Peek at migration channel, without
diff --git a/migration/channel.h b/migration/channel.h
index 5bdb8208a744..95d281828aaa 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -29,4 +29,18 @@ int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
                                 const size_t buflen,
                                 Error **errp);
+typedef enum {
+    MIG_CHANNEL_TYPE_MAIN,
+} MigChannelTypes;
+
+typedef struct QEMU_PACKED {
+    uint32_t channel_type;
+} MigChannelHeader;
+
+int migration_channel_header_send(QIOChannel *ioc, MigChannelHeader *header,
+                                  Error **errp);
+
+int migration_channel_header_recv(QIOChannel *ioc, MigChannelHeader *header,
+                                  Error **errp);
+
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index f0e1cb80c75b..e48607d5a6a2 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,8 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
 # channel.c
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
+migration_channel_header_send(uint32_t channel_type, uint64_t header_size) "Migration channel header send: channel_type=%u, header_size=%lu"
+migration_channel_header_recv(uint32_t channel_type, uint64_t header_size) "Migration channel header recv: channel_type=%u, header_size=%lu"
 
 # global_state.c
 migrate_state_too_big(void) ""

