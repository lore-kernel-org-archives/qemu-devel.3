Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EAEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2m-00052E-0u; Tue, 16 Apr 2024 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2k-00051Y-0Q
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:18 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2i-0002Ad-AT
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:17 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2N-0002eY-OM; Tue, 16 Apr 2024 16:43:55 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 08/26] migration: Allow passing migration header in
 migration channel creation
Date: Tue, 16 Apr 2024 16:42:47 +0200
Message-ID: <c1538bf0593f5e0e46e0c98e91bc1892e6a314b0.1713269378.git.maciej.szmigiero@oracle.com>
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

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
[MSS: Rewrite using MFDSendChannelConnectData/PostcopyPChannelConnectData]
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c      | 14 ++++++++++++--
 migration/postcopy-ram.c | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 58a18bb1e4a8..8eecda68ac0f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -18,6 +18,7 @@
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "channel.h"
 #include "file.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -1014,15 +1015,20 @@ struct MFDSendChannelConnectData {
     unsigned int ref;
     MultiFDSendParams *p;
     QIOChannelTLS *tioc;
+    MigChannelHeader header;
 };
 
-static MFDSendChannelConnectData *mfd_send_channel_connect_data_new(MultiFDSendParams *p)
+static MFDSendChannelConnectData *mfd_send_channel_connect_data_new(MultiFDSendParams *p,
+                                                                    MigChannelHeader *header)
 {
     MFDSendChannelConnectData *data;
 
     data = g_malloc0(sizeof(*data));
     data->ref = 1;
     data->p = p;
+    if (header) {
+        memcpy(&data->header, header, sizeof(*header));
+    }
 
     return data;
 }
@@ -1110,6 +1116,10 @@ bool multifd_channel_connect(MFDSendChannelConnectData *data, QIOChannel *ioc,
 {
     MultiFDSendParams *p = data->p;
 
+    if (migration_channel_header_send(ioc, &data->header, errp)) {
+        return false;
+    }
+
     qio_channel_set_delay(ioc, false);
 
     migration_ioc_register_yank(ioc);
@@ -1182,7 +1192,7 @@ static bool multifd_new_send_channel_create(MultiFDSendParams *p, Error **errp)
 {
     g_autoptr(MFDSendChannelConnectData) data = NULL;
 
-    data = mfd_send_channel_connect_data_new(p);
+    data = mfd_send_channel_connect_data_new(p, NULL);
 
     if (!multifd_use_packets()) {
         return file_send_channel_create(data, errp);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 94fe872d8251..53c90344acce 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/madvise.h"
 #include "exec/target_page.h"
+#include "channel.h"
 #include "migration.h"
 #include "qemu-file.h"
 #include "savevm.h"
@@ -1620,15 +1621,20 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
 typedef struct {
     unsigned int ref;
     MigrationState *s;
+    MigChannelHeader header;
 } PostcopyPChannelConnectData;
 
-static PostcopyPChannelConnectData *pcopy_preempt_connect_data_new(MigrationState *s)
+static PostcopyPChannelConnectData *pcopy_preempt_connect_data_new(MigrationState *s,
+                                                                   MigChannelHeader *header)
 {
     PostcopyPChannelConnectData *data;
 
     data = g_malloc0(sizeof(*data));
     data->ref = 1;
     data->s = s;
+    if (header) {
+        memcpy(&data->header, header, sizeof(*header));
+    }
 
     return data;
 }
@@ -1673,6 +1679,10 @@ postcopy_preempt_send_channel_done(PostcopyPChannelConnectData *data,
 {
     MigrationState *s = data->s;
 
+    if (!local_err) {
+        migration_channel_header_send(ioc, &data->header, &local_err);
+    }
+
     if (local_err) {
         migrate_set_error(s, local_err);
         error_free(local_err);
@@ -1766,7 +1776,7 @@ void postcopy_preempt_setup(MigrationState *s)
 {
     PostcopyPChannelConnectData *data;
 
-    data = pcopy_preempt_connect_data_new(s);
+    data = pcopy_preempt_connect_data_new(s, NULL);
     /* Kick an async task to connect */
     socket_send_channel_create(postcopy_preempt_send_channel_new,
                                data, pcopy_preempt_connect_data_unref);

