Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B721C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRWj-0000SN-Vn; Thu, 30 Jan 2025 05:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWe-0008Jt-FE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:56 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWc-0007QN-O0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:56 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWO-00000006U1g-1BUc; Thu, 30 Jan 2025 11:11:40 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 29/33] vfio/migration: Multifd device state transfer
 support - config loading support
Date: Thu, 30 Jan 2025 11:08:50 +0100
Message-ID: <de41d1ae244fccfa928eb78787ba903b420e1346.1738171076.git.maciej.szmigiero@oracle.com>
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

Load device config received via multifd using the existing machinery
behind vfio_load_device_config_state().

Also, make sure to process the relevant main migration channel flags.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c | 103 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index ab5b097f59c9..31f651ffee85 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -15,6 +15,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
+#include "io/channel-buffer.h"
 #include "system/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/misc.h"
@@ -457,6 +458,57 @@ static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
     return true;
 }
 
+static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
+
+static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    VFIOStateBuffer *lb;
+    g_autoptr(QIOChannelBuffer) bioc = NULL;
+    QEMUFile *f_out = NULL, *f_in = NULL;
+    uint64_t mig_header;
+    int ret;
+
+    assert(multifd->load_buf_idx == multifd->load_buf_idx_last);
+    lb = vfio_state_buffers_at(&multifd->load_bufs, multifd->load_buf_idx);
+    assert(lb->is_present);
+
+    bioc = qio_channel_buffer_new(lb->len);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
+
+    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
+    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
+
+    ret = qemu_fflush(f_out);
+    if (ret) {
+        g_clear_pointer(&f_out, qemu_fclose);
+        return ret;
+    }
+
+    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
+    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
+
+    mig_header = qemu_get_be64(f_in);
+    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
+        g_clear_pointer(&f_out, qemu_fclose);
+        g_clear_pointer(&f_in, qemu_fclose);
+        return -EINVAL;
+    }
+
+    bql_lock();
+    ret = vfio_load_device_config_state(f_in, vbasedev);
+    bql_unlock();
+
+    g_clear_pointer(&f_out, qemu_fclose);
+    g_clear_pointer(&f_in, qemu_fclose);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
 {
     VFIOStateBuffer *lb;
@@ -477,11 +529,6 @@ static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
     return lb;
 }
 
-static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
-{
-    return -EINVAL;
-}
-
 static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
                                          VFIOStateBuffer *lb,
                                          Error **errp)
@@ -1168,6 +1215,8 @@ static int vfio_load_cleanup(void *opaque)
 static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
     int ret = 0;
     uint64_t data;
 
@@ -1179,6 +1228,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
         switch (data) {
         case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
         {
+            if (migration->multifd_transfer) {
+                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
+                             vbasedev->name);
+                return -EINVAL;
+            }
+
             return vfio_load_device_config_state(f, opaque);
         }
         case VFIO_MIG_FLAG_DEV_SETUP_STATE:
@@ -1223,6 +1278,44 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 
             return ret;
         }
+        case VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY:
+        {
+            if (!migration->multifd_transfer) {
+                error_report("%s: got DEV_CONFIG_LOAD_READY outside multifd transfer",
+                             vbasedev->name);
+                return -EINVAL;
+            }
+
+            if (!vfio_load_config_after_iter(vbasedev)) {
+                error_report("%s: got DEV_CONFIG_LOAD_READY but was disabled",
+                             vbasedev->name);
+                return -EINVAL;
+            }
+
+            assert(multifd);
+
+            /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
+            bql_unlock();
+            WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
+                if (multifd->load_bufs_iter_done) {
+                    /* Can't print error here as we're outside BQL */
+                    ret = -EINVAL;
+                    break;
+                }
+
+                multifd->load_bufs_iter_done = true;
+                qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
+
+                ret = 0;
+            }
+            bql_lock();
+
+            if (ret) {
+                error_report("%s: duplicate DEV_CONFIG_LOAD_READY",
+                             vbasedev->name);
+            }
+            return ret;
+        }
         default:
             error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
             return -EINVAL;

