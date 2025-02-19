Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAFEC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqoP-00009K-WB; Wed, 19 Feb 2025 15:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqoN-0008U5-1L
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:36:51 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqoK-0004pk-W9
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:36:50 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqo5-00000007VVT-16DB; Wed, 19 Feb 2025 21:36:33 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 25/36] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
Date: Wed, 19 Feb 2025 21:34:07 +0100
Message-ID: <b555ee5b753efbf2f7152f0692858802fc1bcb80.1739994627.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739994627.git.maciej.szmigiero@oracle.com>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Add support for VFIOMultifd data structure that will contain most of the
receive-side data together with its init/cleanup methods.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c   | 33 +++++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h   |  8 ++++++++
 hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++--
 include/hw/vfio/vfio-common.h |  3 +++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 7328ad8e925c..c2defc0efef0 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -41,6 +41,9 @@ typedef struct VFIOStateBuffer {
     size_t len;
 } VFIOStateBuffer;
 
+typedef struct VFIOMultifd {
+} VFIOMultifd;
+
 static void vfio_state_buffer_clear(gpointer data)
 {
     VFIOStateBuffer *lb = data;
@@ -84,8 +87,38 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
     return &g_array_index(bufs->array, VFIOStateBuffer, idx);
 }
 
+VFIOMultifd *vfio_multifd_new(void)
+{
+    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
+
+    return multifd;
+}
+
+void vfio_multifd_free(VFIOMultifd *multifd)
+{
+    g_free(multifd);
+}
+
 bool vfio_multifd_transfer_supported(void)
 {
     return multifd_device_state_supported() &&
         migrate_send_switchover_start();
 }
+
+bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
+{
+    return false;
+}
+
+bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
+{
+    if (vfio_multifd_transfer_enabled(vbasedev) &&
+        !vfio_multifd_transfer_supported()) {
+        error_setg(errp,
+                   "%s: Multifd device transfer requested but unsupported in the current config",
+                   vbasedev->name);
+        return false;
+    }
+
+    return true;
+}
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 8fe004c1da81..1eefba3b2eed 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -12,6 +12,14 @@
 
 #include "hw/vfio/vfio-common.h"
 
+typedef struct VFIOMultifd VFIOMultifd;
+
+VFIOMultifd *vfio_multifd_new(void);
+void vfio_multifd_free(VFIOMultifd *multifd);
+
 bool vfio_multifd_transfer_supported(void);
+bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
+
+bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
 
 #endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 7b79be6ad293..4311de763885 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -674,15 +674,40 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
 static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    if (!vfio_multifd_transfer_setup(vbasedev, errp)) {
+        return -EINVAL;
+    }
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+                                   migration->device_state, errp);
+    if (ret) {
+        return ret;
+    }
 
-    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
-                                    vbasedev->migration->device_state, errp);
+    if (vfio_multifd_transfer_enabled(vbasedev)) {
+        assert(!migration->multifd);
+        migration->multifd = vfio_multifd_new();
+    }
+
+    return 0;
+}
+
+static void vfio_multifd_cleanup(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    g_clear_pointer(&migration->multifd, vfio_multifd_free);
 }
 
 static int vfio_load_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
 
+    vfio_multifd_cleanup(vbasedev);
+
     vfio_migration_cleanup(vbasedev);
     trace_vfio_load_cleanup(vbasedev->name);
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 64ee3b1a2547..ab110198bd6b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -78,6 +78,8 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+typedef struct VFIOMultifd VFIOMultifd;
+
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
@@ -89,6 +91,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    VFIOMultifd *multifd;
     bool initial_data_sent;
 
     bool event_save_iterate_started;

