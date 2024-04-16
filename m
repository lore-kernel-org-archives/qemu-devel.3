Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76307C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2J-0004w6-9s; Tue, 16 Apr 2024 10:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2H-0004vN-31
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:49 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2F-00020G-Kq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:48 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk27-0002dW-Q4; Tue, 16 Apr 2024 16:43:39 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 05/26] migration: Add a DestroyNotify parameter to
 socket_send_channel_create()
Date: Tue, 16 Apr 2024 16:42:44 +0200
Message-ID: <8e8c54b8ef21a49b7204167d935744a145e1e98e.1713269378.git.maciej.szmigiero@oracle.com>
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Makes managing the memory easier.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c      | 2 +-
 migration/postcopy-ram.c | 2 +-
 migration/socket.c       | 6 ++++--
 migration/socket.h       | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 039c0de40af5..4bc912d7500e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1138,7 +1138,7 @@ static bool multifd_new_send_channel_create(MultiFDSendParams *p, Error **errp)
         return file_send_channel_create(p, errp);
     }
 
-    socket_send_channel_create(multifd_new_send_channel_async, p);
+    socket_send_channel_create(multifd_new_send_channel_async, p, NULL);
     return true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index eccff499cb20..e314e1023dc1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1715,7 +1715,7 @@ int postcopy_preempt_establish_channel(MigrationState *s)
 void postcopy_preempt_setup(MigrationState *s)
 {
     /* Kick an async task to connect */
-    socket_send_channel_create(postcopy_preempt_send_channel_new, s);
+    socket_send_channel_create(postcopy_preempt_send_channel_new, s, NULL);
 }
 
 static void postcopy_pause_ram_fast_load(MigrationIncomingState *mis)
diff --git a/migration/socket.c b/migration/socket.c
index 9ab89b1e089b..6639581cf18d 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -35,11 +35,13 @@ struct SocketOutgoingArgs {
     SocketAddress *saddr;
 } outgoing_args;
 
-void socket_send_channel_create(QIOTaskFunc f, void *data)
+void socket_send_channel_create(QIOTaskFunc f,
+                                void *data, GDestroyNotify data_destroy)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
+
     qio_channel_socket_connect_async(sioc, outgoing_args.saddr,
-                                     f, data, NULL, NULL);
+                                     f, data, data_destroy, NULL);
 }
 
 QIOChannel *socket_send_channel_create_sync(Error **errp)
diff --git a/migration/socket.h b/migration/socket.h
index 46c233ecd29e..114ab34176aa 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -21,7 +21,8 @@
 #include "io/task.h"
 #include "qemu/sockets.h"
 
-void socket_send_channel_create(QIOTaskFunc f, void *data);
+void socket_send_channel_create(QIOTaskFunc f,
+                                void *data, GDestroyNotify data_destroy);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
 
 void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);

