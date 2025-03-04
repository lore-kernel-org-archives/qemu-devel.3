Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF1AC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaa9-0006AK-I0; Tue, 04 Mar 2025 17:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaYJ-000475-LE
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:53 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaQc-0001PZ-NW
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:50 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaPa-00000000LaL-1GE4; Tue, 04 Mar 2025 23:06:50 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 24/36] vfio/migration: Multifd setup/cleanup functions and
 associated VFIOMultifd
Date: Tue,  4 Mar 2025 23:03:51 +0100
Message-ID: <c0520523053b1087787152ddf2163257d3030be0.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
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

Add multifd setup/cleanup functions and an associated VFIOMultifd data
structure that will contain most of the receive-side data together
with its init/cleanup methods.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c   | 44 +++++++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h   |  4 ++++
 include/hw/vfio/vfio-common.h |  3 +++
 3 files changed, 51 insertions(+)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 79fae0b6296f..091dc43210ad 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -32,8 +32,52 @@ typedef struct VFIODeviceStatePacket {
     uint8_t data[0];
 } QEMU_PACKED VFIODeviceStatePacket;
 
+typedef struct VFIOMultifd {
+} VFIOMultifd;
+
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
+void vfio_multifd_cleanup(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    g_clear_pointer(&migration->multifd, vfio_multifd_free);
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
+bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (!vfio_multifd_transfer_enabled(vbasedev)) {
+        /* Nothing further to check or do */
+        return true;
+    }
+
+    if (alloc_multifd) {
+        assert(!migration->multifd);
+        migration->multifd = vfio_multifd_new();
+    }
+
+    return true;
+}
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 1b60d5f67a1c..2a7a76164f29 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -14,6 +14,10 @@
 
 #include "hw/vfio/vfio-common.h"
 
+bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp);
+void vfio_multifd_cleanup(VFIODevice *vbasedev);
+
 bool vfio_multifd_transfer_supported(void);
+bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 
 #endif
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bf5d52087129..40382390692d 100644
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

