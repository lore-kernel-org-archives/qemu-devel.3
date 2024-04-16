Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22198C04FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2X-0004xk-2l; Tue, 16 Apr 2024 10:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2U-0004xL-Cm
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:02 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2S-00029e-P0
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:02 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2I-0002eE-CT; Tue, 16 Apr 2024 16:43:50 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 07/26] migration/postcopy: pass
 PostcopyPChannelConnectData when connecting sending preempt socket
Date: Tue, 16 Apr 2024 16:42:46 +0200
Message-ID: <5bd9a83e61c0f78805a9e1a51dff391f2e73aec0.1713269378.git.maciej.szmigiero@oracle.com>
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
 migration/postcopy-ram.c | 68 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e314e1023dc1..94fe872d8251 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1617,14 +1617,62 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
     trace_postcopy_preempt_new_channel();
 }
 
+typedef struct {
+    unsigned int ref;
+    MigrationState *s;
+} PostcopyPChannelConnectData;
+
+static PostcopyPChannelConnectData *pcopy_preempt_connect_data_new(MigrationState *s)
+{
+    PostcopyPChannelConnectData *data;
+
+    data = g_malloc0(sizeof(*data));
+    data->ref = 1;
+    data->s = s;
+
+    return data;
+}
+
+static void pcopy_preempt_connect_data_free(PostcopyPChannelConnectData *data)
+{
+    g_free(data);
+}
+
+static PostcopyPChannelConnectData *
+pcopy_preempt_connect_data_ref(PostcopyPChannelConnectData *data)
+{
+    unsigned int ref_old;
+
+    ref_old = qatomic_fetch_inc(&data->ref);
+    assert(ref_old < UINT_MAX);
+
+    return data;
+}
+
+static void pcopy_preempt_connect_data_unref(gpointer opaque)
+{
+    PostcopyPChannelConnectData *data = opaque;
+    unsigned int ref_old;
+
+    ref_old = qatomic_fetch_dec(&data->ref);
+    assert(ref_old > 0);
+    if (ref_old == 1) {
+        pcopy_preempt_connect_data_free(data);
+    }
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(PostcopyPChannelConnectData, pcopy_preempt_connect_data_unref)
+
 /*
  * Setup the postcopy preempt channel with the IOC.  If ERROR is specified,
  * setup the error instead.  This helper will free the ERROR if specified.
  */
 static void
-postcopy_preempt_send_channel_done(MigrationState *s,
+postcopy_preempt_send_channel_done(PostcopyPChannelConnectData *data,
                                    QIOChannel *ioc, Error *local_err)
 {
+    MigrationState *s = data->s;
+
     if (local_err) {
         migrate_set_error(s, local_err);
         error_free(local_err);
@@ -1645,18 +1693,19 @@ static void
 postcopy_preempt_tls_handshake(QIOTask *task, gpointer opaque)
 {
     g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
-    MigrationState *s = opaque;
+    PostcopyPChannelConnectData *data = opaque;
     Error *local_err = NULL;
 
     qio_task_propagate_error(task, &local_err);
-    postcopy_preempt_send_channel_done(s, ioc, local_err);
+    postcopy_preempt_send_channel_done(data, ioc, local_err);
 }
 
 static void
 postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
 {
     g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
-    MigrationState *s = opaque;
+    PostcopyPChannelConnectData *data = opaque;
+    MigrationState *s = data->s;
     QIOChannelTLS *tioc;
     Error *local_err = NULL;
 
@@ -1672,14 +1721,15 @@ postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
         trace_postcopy_preempt_tls_handshake();
         qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-preempt");
         qio_channel_tls_handshake(tioc, postcopy_preempt_tls_handshake,
-                                  s, NULL, NULL);
+                                  pcopy_preempt_connect_data_ref(data),
+                                  pcopy_preempt_connect_data_unref, NULL);
         /* Setup the channel until TLS handshake finished */
         return;
     }
 
 out:
     /* This handles both good and error cases */
-    postcopy_preempt_send_channel_done(s, ioc, local_err);
+    postcopy_preempt_send_channel_done(data, ioc, local_err);
 }
 
 /*
@@ -1714,8 +1764,12 @@ int postcopy_preempt_establish_channel(MigrationState *s)
 
 void postcopy_preempt_setup(MigrationState *s)
 {
+    PostcopyPChannelConnectData *data;
+
+    data = pcopy_preempt_connect_data_new(s);
     /* Kick an async task to connect */
-    socket_send_channel_create(postcopy_preempt_send_channel_new, s, NULL);
+    socket_send_channel_create(postcopy_preempt_send_channel_new,
+                               data, pcopy_preempt_connect_data_unref);
 }
 
 static void postcopy_pause_ram_fast_load(MigrationIncomingState *mis)

