Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3584DC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRWh-0008T5-58; Thu, 30 Jan 2025 05:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWP-0007uM-0l
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:44 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWN-0007PM-8A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:40 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRW8-00000006U1C-3U7w; Thu, 30 Jan 2025 11:11:24 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 26/33] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
Date: Thu, 30 Jan 2025 11:08:47 +0100
Message-ID: <1fcf182307e8e1f67a3c226e62d26cad3a2f60d0.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 hw/vfio/migration.c           | 52 +++++++++++++++++++++++++++++++++--
 include/hw/vfio/vfio-common.h |  5 ++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3211041939c6..bcdf204d5cf4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -300,6 +300,9 @@ typedef struct VFIOStateBuffer {
     size_t len;
 } VFIOStateBuffer;
 
+typedef struct VFIOMultifd {
+} VFIOMultifd;
+
 static void vfio_state_buffer_clear(gpointer data)
 {
     VFIOStateBuffer *lb = data;
@@ -398,6 +401,18 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     return qemu_file_get_error(f);
 }
 
+static VFIOMultifd *vfio_multifd_new(void)
+{
+    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
+
+    return multifd;
+}
+
+static void vfio_multifd_free(VFIOMultifd *multifd)
+{
+    g_free(multifd);
+}
+
 static void vfio_migration_cleanup(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -785,14 +800,47 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
 static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    /*
+     * Make a copy of this setting at the start in case it is changed
+     * mid-migration.
+     */
+    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
+        migration->multifd_transfer = vfio_multifd_transfer_supported();
+    } else {
+        migration->multifd_transfer =
+            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
+    }
+
+    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
+        error_setg(errp,
+                   "%s: Multifd device transfer requested but unsupported in the current config",
+                   vbasedev->name);
+        return -EINVAL;
+    }
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+                                   migration->device_state, errp);
+    if (ret) {
+        return ret;
+    }
+
+    if (migration->multifd_transfer) {
+        assert(!migration->multifd);
+        migration->multifd = vfio_multifd_new();
+    }
 
-    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
-                                    vbasedev->migration->device_state, errp);
+    return 0;
 }
 
 static int vfio_load_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    g_clear_pointer(&migration->multifd, vfio_multifd_free);
 
     vfio_migration_cleanup(vbasedev);
     trace_vfio_load_cleanup(vbasedev->name);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 153d03745dc7..c0c9c0b1b263 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -61,6 +61,8 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+typedef struct VFIOMultifd VFIOMultifd;
+
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
@@ -72,6 +74,8 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    bool multifd_transfer;
+    VFIOMultifd *multifd;
     bool initial_data_sent;
 
     bool event_save_iterate_started;
@@ -133,6 +137,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    OnOffAuto migration_multifd_transfer;
     OnOffAuto migration_load_config_after_iter;
     bool migration_events;
     VFIODeviceOps *ops;

