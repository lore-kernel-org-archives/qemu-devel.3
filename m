Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6A5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2S-0004wx-23; Tue, 16 Apr 2024 10:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2R-0004wo-5l
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:59 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2P-00025z-9s
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:58 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2D-0002dn-6D; Tue, 16 Apr 2024 16:43:45 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 06/26] multifd: pass MFDSendChannelConnectData when
 connecting sending socket
Date: Tue, 16 Apr 2024 16:42:45 +0200
Message-ID: <6a28983b31e2791b0ca55f3c1cd4eae64f64f3b1.1713269378.git.maciej.szmigiero@oracle.com>
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

This will allow passing additional parameters there in the future.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/file.c    |  5 ++-
 migration/multifd.c | 95 ++++++++++++++++++++++++++++++++++-----------
 migration/multifd.h |  4 +-
 3 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index ab18ba505a1d..34dfbc4a5a2d 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -62,7 +62,10 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
         goto out;
     }
 
-    multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
+    ret = multifd_channel_connect(opaque, QIO_CHANNEL(ioc), errp);
+    if (!ret) {
+        object_unref(OBJECT(ioc));
+    }
 
 out:
     /*
diff --git a/migration/multifd.c b/migration/multifd.c
index 4bc912d7500e..58a18bb1e4a8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1010,34 +1010,76 @@ out:
     return NULL;
 }
 
-static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
-
-typedef struct {
+struct MFDSendChannelConnectData {
+    unsigned int ref;
     MultiFDSendParams *p;
     QIOChannelTLS *tioc;
-} MultiFDTLSThreadArgs;
+};
+
+static MFDSendChannelConnectData *mfd_send_channel_connect_data_new(MultiFDSendParams *p)
+{
+    MFDSendChannelConnectData *data;
+
+    data = g_malloc0(sizeof(*data));
+    data->ref = 1;
+    data->p = p;
+
+    return data;
+}
+
+static void mfd_send_channel_connect_data_free(MFDSendChannelConnectData *data)
+{
+    g_free(data);
+}
+
+static MFDSendChannelConnectData *
+mfd_send_channel_connect_data_ref(MFDSendChannelConnectData *data)
+{
+    unsigned int ref_old;
+
+    ref_old = qatomic_fetch_inc(&data->ref);
+    assert(ref_old < UINT_MAX);
+
+    return data;
+}
+
+static void mfd_send_channel_connect_data_unref(gpointer opaque)
+{
+    MFDSendChannelConnectData *data = opaque;
+    unsigned int ref_old;
+
+    ref_old = qatomic_fetch_dec(&data->ref);
+    assert(ref_old > 0);
+    if (ref_old == 1) {
+        mfd_send_channel_connect_data_free(data);
+    }
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(MFDSendChannelConnectData, mfd_send_channel_connect_data_unref)
+
+static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
 
 static void *multifd_tls_handshake_thread(void *opaque)
 {
-    MultiFDTLSThreadArgs *args = opaque;
+    g_autoptr(MFDSendChannelConnectData) data = opaque;
+    QIOChannelTLS *tioc = data->tioc;
 
-    qio_channel_tls_handshake(args->tioc,
+    qio_channel_tls_handshake(tioc,
                               multifd_new_send_channel_async,
-                              args->p,
-                              NULL,
+                              g_steal_pointer(&data),
+                              mfd_send_channel_connect_data_unref,
                               NULL);
-    g_free(args);
 
     return NULL;
 }
 
-static bool multifd_tls_channel_connect(MultiFDSendParams *p,
+static bool multifd_tls_channel_connect(MFDSendChannelConnectData *data,
                                         QIOChannel *ioc,
                                         Error **errp)
 {
+    MultiFDSendParams *p = data->p;
     MigrationState *s = migrate_get_current();
     const char *hostname = s->hostname;
-    MultiFDTLSThreadArgs *args;
     QIOChannelTLS *tioc;
 
     tioc = migration_tls_client_create(ioc, hostname, errp);
@@ -1053,19 +1095,21 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
 
-    args = g_new0(MultiFDTLSThreadArgs, 1);
-    args->tioc = tioc;
-    args->p = p;
+    data->tioc = tioc;
 
     p->tls_thread_created = true;
     qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
-                       multifd_tls_handshake_thread, args,
+                       multifd_tls_handshake_thread,
+                       mfd_send_channel_connect_data_ref(data),
                        QEMU_THREAD_JOINABLE);
     return true;
 }
 
-void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
+bool multifd_channel_connect(MFDSendChannelConnectData *data, QIOChannel *ioc,
+                             Error **errp)
 {
+    MultiFDSendParams *p = data->p;
+
     qio_channel_set_delay(ioc, false);
 
     migration_ioc_register_yank(ioc);
@@ -1075,6 +1119,8 @@ void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
     p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                        QEMU_THREAD_JOINABLE);
+
+    return true;
 }
 
 /*
@@ -1085,7 +1131,8 @@ void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
  */
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 {
-    MultiFDSendParams *p = opaque;
+    MFDSendChannelConnectData *data = opaque;
+    MultiFDSendParams *p = data->p;
     QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *local_err = NULL;
     bool ret;
@@ -1101,13 +1148,12 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
                                        migrate_get_current()->hostname);
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
-        ret = multifd_tls_channel_connect(p, ioc, &local_err);
+        ret = multifd_tls_channel_connect(data, ioc, &local_err);
         if (ret) {
             return;
         }
     } else {
-        multifd_channel_connect(p, ioc);
-        ret = true;
+        ret = multifd_channel_connect(data, ioc, &local_err);
     }
 
 out:
@@ -1134,11 +1180,16 @@ out:
 
 static bool multifd_new_send_channel_create(MultiFDSendParams *p, Error **errp)
 {
+    g_autoptr(MFDSendChannelConnectData) data = NULL;
+
+    data = mfd_send_channel_connect_data_new(p);
+
     if (!multifd_use_packets()) {
-        return file_send_channel_create(p, errp);
+        return file_send_channel_create(data, errp);
     }
 
-    socket_send_channel_create(multifd_new_send_channel_async, p, NULL);
+    socket_send_channel_create(multifd_new_send_channel_async, g_steal_pointer(&data),
+                               mfd_send_channel_connect_data_unref);
     return true;
 }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index c9d9b0923953..fd0cd29104c1 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -250,6 +250,8 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
     p->iovs_num++;
 }
 
-void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
+struct MFDSendChannelConnectData;
+typedef struct MFDSendChannelConnectData MFDSendChannelConnectData;
+bool multifd_channel_connect(MFDSendChannelConnectData *data, QIOChannel *ioc, Error **errp);
 
 #endif

