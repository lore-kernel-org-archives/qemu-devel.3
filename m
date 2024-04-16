Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC52C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2o-00053S-2z; Tue, 16 Apr 2024 10:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2m-00052T-9w
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:20 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2k-0002FW-S9
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:20 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2Y-0002fG-4V; Tue, 16 Apr 2024 16:44:06 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 10/26] migration: Add send/receive header for multifd
 channel
Date: Tue, 16 Apr 2024 16:42:49 +0200
Message-ID: <ee0bbaa7e7e9147a96f60a1a3a228fddc958c990.1713269378.git.maciej.szmigiero@oracle.com>
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

Add send and receive migration channel header for multifd channel.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
[MSS: Adapt to rewritten migration header passing commit]
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/channel.h   |  1 +
 migration/migration.c | 16 ++++++++++++++++
 migration/multifd.c   |  4 +++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/migration/channel.h b/migration/channel.h
index c59ccedc7b6b..4232ee649939 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -32,6 +32,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
 typedef enum {
     MIG_CHANNEL_TYPE_MAIN,
     MIG_CHANNEL_TYPE_POSTCOPY_PREEMPT,
+    MIG_CHANNEL_TYPE_MULTIFD,
 } MigChannelTypes;
 
 typedef struct QEMU_PACKED {
diff --git a/migration/migration.c b/migration/migration.c
index ac9ecf1f4f22..8fe8be71a0e3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1024,6 +1024,22 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         f = qemu_file_new_input(ioc);
         postcopy_preempt_new_channel(migration_incoming_get_current(), f);
         break;
+    case MIG_CHANNEL_TYPE_MULTIFD:
+    {
+        Error *local_err = NULL;
+
+        assert(migrate_multifd());
+        if (multifd_recv_setup(errp) != 0) {
+            return;
+        }
+
+        multifd_recv_new_channel(ioc, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        break;
+    }
     default:
         error_setg(errp, "Received unknown migration channel type %u",
                    header.channel_type);
diff --git a/migration/multifd.c b/migration/multifd.c
index 8eecda68ac0f..c2575e3d6dbf 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1191,8 +1191,10 @@ out:
 static bool multifd_new_send_channel_create(MultiFDSendParams *p, Error **errp)
 {
     g_autoptr(MFDSendChannelConnectData) data = NULL;
+    MigChannelHeader header = {};
 
-    data = mfd_send_channel_connect_data_new(p, NULL);
+    header.channel_type = MIG_CHANNEL_TYPE_MULTIFD;
+    data = mfd_send_channel_connect_data_new(p, &header);
 
     if (!multifd_use_packets()) {
         return file_send_channel_create(data, errp);

