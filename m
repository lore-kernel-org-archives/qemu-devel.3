Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A368C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2D-0004sm-Je; Tue, 16 Apr 2024 10:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2B-0004sR-Nx
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:43 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk28-0001yk-VO
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:43 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk1x-0002cs-DY; Tue, 16 Apr 2024 16:43:29 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 03/26] migration: Add send/receive header for main channel
Date: Tue, 16 Apr 2024 16:42:42 +0200
Message-ID: <2ea2f26a513ceb53fc33bc3a5073c64d11b3f76b.1713269378.git.maciej.szmigiero@oracle.com>
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

Add send and receive migration channel header for main channel.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
[MSS: Rename main channel -> default channel where it matches the current term]
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/channel.c   |  9 +++++
 migration/migration.c | 82 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index a72e85f5791c..0e3f51654752 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -81,6 +81,13 @@ void migration_channel_connect(MigrationState *s,
                 return;
             }
         } else {
+            /* TODO: Send header after register yank? Make a QEMUFile variant? */
+            MigChannelHeader header = {};
+            header.channel_type = MIG_CHANNEL_TYPE_MAIN;
+            if (migration_channel_header_send(ioc, &header, &error)) {
+                goto out;
+            }
+
             QEMUFile *f = qemu_file_new_output(ioc);
 
             migration_ioc_register_yank(ioc);
@@ -90,6 +97,8 @@ void migration_channel_connect(MigrationState *s,
             qemu_mutex_unlock(&s->qemu_file_lock);
         }
     }
+
+out:
     migrate_fd_connect(s, error);
     error_free(error);
 }
diff --git a/migration/migration.c b/migration/migration.c
index 86bf76e92585..0eb5b4f4f5a1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -869,12 +869,39 @@ void migration_fd_process_incoming(QEMUFile *f)
     migration_incoming_process();
 }
 
+static bool migration_should_start_incoming_header(bool main_channel)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!mis->from_src_file) {
+        return false;
+    }
+
+    if (migrate_multifd()) {
+        return multifd_recv_all_channels_created();
+    }
+
+    if (migrate_postcopy_preempt() && migrate_get_current()->preempt_pre_7_2) {
+        return mis->postcopy_qemufile_dst != NULL;
+    }
+
+    if (migrate_postcopy_preempt()) {
+        return main_channel;
+    }
+
+    return true;
+}
+
 /*
  * Returns true when we want to start a new incoming migration process,
  * false otherwise.
  */
 static bool migration_should_start_incoming(bool main_channel)
 {
+    if (migrate_channel_header()) {
+        return migration_should_start_incoming_header(main_channel);
+    }
+
     /* Multifd doesn't start unless all channels are established */
     if (migrate_multifd()) {
         return migration_has_all_channels();
@@ -894,7 +921,22 @@ static bool migration_should_start_incoming(bool main_channel)
     return true;
 }
 
-void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
+static void migration_start_incoming(bool main_channel)
+{
+    if (!migration_should_start_incoming(main_channel)) {
+        return;
+    }
+
+    /* If it's a recovery, we're done */
+    if (postcopy_try_recover()) {
+        return;
+    }
+
+    migration_incoming_process();
+}
+
+static void migration_ioc_process_incoming_no_header(QIOChannel *ioc,
+                                                     Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
@@ -951,13 +993,39 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         }
     }
 
-    if (migration_should_start_incoming(default_channel)) {
-        /* If it's a recovery, we're done */
-        if (postcopy_try_recover()) {
-            return;
-        }
-        migration_incoming_process();
+    migration_start_incoming(default_channel);
+}
+
+void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
+{
+    MigChannelHeader header = {};
+    bool default_channel = false;
+    QEMUFile *f;
+    int ret;
+
+    if (!migrate_channel_header()) {
+        migration_ioc_process_incoming_no_header(ioc, errp);
+        return;
+    }
+
+    ret = migration_channel_header_recv(ioc, &header, errp);
+    if (ret) {
+        return;
+    }
+
+    switch (header.channel_type) {
+    case MIG_CHANNEL_TYPE_MAIN:
+        f = qemu_file_new_input(ioc);
+        migration_incoming_setup(f);
+        default_channel = true;
+        break;
+    default:
+        error_setg(errp, "Received unknown migration channel type %u",
+                   header.channel_type);
+        return;
     }
+
+    migration_start_incoming(default_channel);
 }
 
 /**

