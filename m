Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EE8C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJc-0001rb-EG; Wed, 28 Feb 2024 00:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCI4-0000Qe-RD
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHz-0006ul-NP
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YO0QxHUKB0AsGIn6Pnka0iwoxzS4NVkRToYE9m6xvc8=;
 b=K0P15POzLhud1iLs/InbKMMitTuCX0Fec4R0azb5iuUn+Akt2KmSc44fCCbuQdbPHpzwP4
 FnFOsw7LjVcrnq7yv8o3FbLui+Xqb1nIjvnRXWC0A7fF7zO3ivHXEC5L1bNhysSNZG4Oqe
 T/ANe5O5IxtPU3rWeG6euGvTeh8ZeEw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-tXLUCgjNPcOiBZb_OIY6SQ-1; Wed,
 28 Feb 2024 00:15:27 -0500
X-MC-Unique: tXLUCgjNPcOiBZb_OIY6SQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F05938212DF;
 Wed, 28 Feb 2024 05:15:27 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB491C060AF;
 Wed, 28 Feb 2024 05:15:17 +0000 (UTC)
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
Subject: [PULL 13/25] migration: convert to NotifierWithReturn
Date: Wed, 28 Feb 2024 13:13:03 +0800
Message-ID: <20240228051315.400759-14-peterx@redhat.com>
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

Change all migration notifiers to type NotifierWithReturn, so notifiers
can return an error status in a future patch.  For now, pass NULL for the
notifier error parameter, and do not check the return value.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-4-git-send-email-steven.sistare@oracle.com
[peterx: dropped unexpected update to roms/seabios-hppa]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/vfio/vfio-common.h  |  2 +-
 include/hw/virtio/virtio-net.h |  2 +-
 include/migration/misc.h       |  6 +++---
 include/qemu/notify.h          |  1 +
 hw/net/virtio-net.c            |  4 +++-
 hw/vfio/migration.c            |  4 +++-
 migration/migration.c          | 16 ++++++++--------
 net/vhost-vdpa.c               |  6 ++++--
 ui/spice-core.c                |  8 +++++---
 9 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9b7ef7d02b..4a6c262f77 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -62,7 +62,7 @@ typedef struct VFIORegion {
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
-    Notifier migration_state;
+    NotifierWithReturn migration_state;
     uint32_t device_state;
     int data_fd;
     void *data_buffer;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 55977f01f0..eaee8f4243 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -221,7 +221,7 @@ struct VirtIONet {
     DeviceListener primary_listener;
     QDict *primary_opts;
     bool primary_opts_from_json;
-    Notifier migration_state;
+    NotifierWithReturn migration_state;
     VirtioNetRssData rss_data;
     struct NetRxPkt *rx_pkt;
     struct EBPFRSSContext ebpf_rss;
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5e65c18f1a..b62e351d96 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,9 +60,9 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
-void migration_add_notifier(Notifier *notify,
-                            void (*func)(Notifier *notifier, void *data));
-void migration_remove_notifier(Notifier *notify);
+void migration_add_notifier(NotifierWithReturn *notify,
+                            NotifierWithReturnFunc func);
+void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
diff --git a/include/qemu/notify.h b/include/qemu/notify.h
index 9a85631864..abf18dbf59 100644
--- a/include/qemu/notify.h
+++ b/include/qemu/notify.h
@@ -45,6 +45,7 @@ bool notifier_list_empty(NotifierList *list);
 /* Same as Notifier but allows .notify() to return errors */
 typedef struct NotifierWithReturn NotifierWithReturn;
 
+/* Return int to allow for different failure modes and recovery actions */
 typedef int (*NotifierWithReturnFunc)(NotifierWithReturn *notifier, void *data,
                                       Error **errp);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5a79bc3a3a..75f4e8664d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3534,11 +3534,13 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
     }
 }
 
-static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
+static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
+                                               void *data, Error **errp)
 {
     MigrationState *s = data;
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
     virtio_net_handle_migration_primary(n, s);
+    return 0;
 }
 
 static bool failover_hide_primary_device(DeviceListener *listener,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 70e6b1a709..6b6acc4140 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -754,7 +754,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                               mig_state_to_str(new_state));
 }
 
-static void vfio_migration_state_notifier(Notifier *notifier, void *data)
+static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
+                                         void *data, Error **errp)
 {
     MigrationState *s = data;
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
@@ -770,6 +771,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_FAILED:
         vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
     }
+    return 0;
 }
 
 static void vfio_migration_free(VFIODevice *vbasedev)
diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..6d4072e8e9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -69,8 +69,8 @@
 #include "qemu/sockets.h"
 #include "sysemu/kvm.h"
 
-static NotifierList migration_state_notifiers =
-    NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
+static NotifierWithReturnList migration_state_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(migration_state_notifiers);
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1459,24 +1459,24 @@ static void migrate_fd_cancel(MigrationState *s)
     }
 }
 
-void migration_add_notifier(Notifier *notify,
-                            void (*func)(Notifier *notifier, void *data))
+void migration_add_notifier(NotifierWithReturn *notify,
+                            NotifierWithReturnFunc func)
 {
     notify->notify = func;
-    notifier_list_add(&migration_state_notifiers, notify);
+    notifier_with_return_list_add(&migration_state_notifiers, notify);
 }
 
-void migration_remove_notifier(Notifier *notify)
+void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
-        notifier_remove(notify);
+        notifier_with_return_remove(notify);
         notify->notify = NULL;
     }
 }
 
 void migration_call_notifiers(MigrationState *s)
 {
-    notifier_list_notify(&migration_state_notifiers, s);
+    notifier_with_return_list_notify(&migration_state_notifiers, s, 0);
 }
 
 bool migration_in_setup(MigrationState *s)
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3726ee5d67..1c00519f10 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -34,7 +34,7 @@
 typedef struct VhostVDPAState {
     NetClientState nc;
     struct vhost_vdpa vhost_vdpa;
-    Notifier migration_state;
+    NotifierWithReturn migration_state;
     VHostNetState *vhost_net;
 
     /* Control commands shadow buffers */
@@ -322,7 +322,8 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     }
 }
 
-static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
+static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
+                                             void *data, Error **errp)
 {
     MigrationState *migration = data;
     VhostVDPAState *s = container_of(notifier, VhostVDPAState,
@@ -333,6 +334,7 @@ static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
     } else if (migration_has_failed(migration)) {
         vhost_vdpa_net_log_global_enable(s, false);
     }
+    return 0;
 }
 
 static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 37b277fd09..b3cd229023 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -42,7 +42,7 @@
 /* core bits */
 
 static SpiceServer *spice_server;
-static Notifier migration_state;
+static NotifierWithReturn migration_state;
 static const char *auth = "spice";
 static char *auth_passwd;
 static time_t auth_expires = TIME_MAX;
@@ -568,12 +568,13 @@ static SpiceInfo *qmp_query_spice_real(Error **errp)
     return info;
 }
 
-static void migration_state_notifier(Notifier *notifier, void *data)
+static int migration_state_notifier(NotifierWithReturn *notifier,
+                                    void *data, Error **errp)
 {
     MigrationState *s = data;
 
     if (!spice_have_target_host) {
-        return;
+        return 0;
     }
 
     if (migration_in_setup(s)) {
@@ -586,6 +587,7 @@ static void migration_state_notifier(Notifier *notifier, void *data)
         spice_server_migrate_end(spice_server, false);
         spice_have_target_host = false;
     }
+    return 0;
 }
 
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
-- 
2.43.0


