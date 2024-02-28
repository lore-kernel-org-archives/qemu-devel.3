Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD4CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCKA-0003re-Jl; Wed, 28 Feb 2024 00:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIX-0000pr-4l
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIS-0006xM-OQ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qd8Z/jutVJfb9LaI81oSmXF2ibdrxNCl4dXH9s/tEq8=;
 b=EUrwedcCkOMk1jL/0nNbB0B7QBF/YzR5YmA9vD2ayIFLhC02ghPeJ0XeYD32CrPl/rOjBK
 TSABUzLKaFLdWRpTcZF9gZ+tUBTtcchXrTLGQLv0URYzstJoyiNQSHg1oFJJrCQIt7Lvl4
 6pLyNY7dG/5dAUfz0pmwNx+D8Z9K9SQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-Nras3mU-OSSHnKAEGHjgyw-1; Wed, 28 Feb 2024 00:15:56 -0500
X-MC-Unique: Nras3mU-OSSHnKAEGHjgyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B40E185A781;
 Wed, 28 Feb 2024 05:15:56 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 753B31C06532;
 Wed, 28 Feb 2024 05:15:47 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 16/25] migration: MigrationNotifyFunc
Date: Wed, 28 Feb 2024 13:13:06 +0800
Message-ID: <20240228051315.400759-17-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Steve Sistare <steven.sistare@oracle.com>

Define MigrationNotifyFunc to improve type safety and simplify migration
notifiers.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-7-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 5 ++++-
 hw/net/virtio-net.c      | 4 +---
 hw/vfio/migration.c      | 3 +--
 migration/migration.c    | 4 ++--
 net/vhost-vdpa.c         | 6 ++----
 ui/spice-core.c          | 4 +---
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e6150009e0..e36a1f3ec4 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -72,6 +72,9 @@ typedef struct MigrationEvent {
     MigrationEventType type;
 } MigrationEvent;
 
+typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
+                                   MigrationEvent *e, Error **errp);
+
 /*
  * Register the notifier @notify to be called when a migration event occurs
  * for MIG_MODE_NORMAL, as specified by the MigrationEvent passed to @func.
@@ -81,7 +84,7 @@ typedef struct MigrationEvent {
  *    - MIG_EVENT_PRECOPY_FAILED
  */
 void migration_add_notifier(NotifierWithReturn *notify,
-                            NotifierWithReturnFunc func);
+                            MigrationNotifyFunc func);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s, MigrationEventType type);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e803f98c3a..a3c711b56d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3535,10 +3535,8 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
 }
 
 static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
-                                               void *data, Error **errp)
+                                               MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
     virtio_net_handle_migration_primary(n, e);
     return 0;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 869d8417d6..50140eda87 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -755,9 +755,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 }
 
 static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
-                                         void *data, Error **errp)
+                                         MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
diff --git a/migration/migration.c b/migration/migration.c
index 8f7f2d92f4..33149c462c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1464,9 +1464,9 @@ static void migrate_fd_cancel(MigrationState *s)
 }
 
 void migration_add_notifier(NotifierWithReturn *notify,
-                            NotifierWithReturnFunc func)
+                            MigrationNotifyFunc func)
 {
-    notify->notify = func;
+    notify->notify = (NotifierWithReturnFunc)func;
     notifier_with_return_list_add(&migration_state_notifiers, notify);
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a29d18a9ef..e6bdb4562d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -323,11 +323,9 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 }
 
 static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
-                                             void *data, Error **errp)
+                                             MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-    VhostVDPAState *s = container_of(notifier, VhostVDPAState,
-                                     migration_state);
+    VhostVDPAState *s = container_of(notifier, VhostVDPAState, migration_state);
 
     if (e->type == MIG_EVENT_PRECOPY_SETUP) {
         vhost_vdpa_net_log_global_enable(s, true);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 0a59876da2..15be640286 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -569,10 +569,8 @@ static SpiceInfo *qmp_query_spice_real(Error **errp)
 }
 
 static int migration_state_notifier(NotifierWithReturn *notifier,
-                                    void *data, Error **errp)
+                                    MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-
     if (!spice_have_target_host) {
         return 0;
     }
-- 
2.43.0


