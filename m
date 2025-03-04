Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A9BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaaP-0006bR-QY; Tue, 04 Mar 2025 17:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaYH-00046S-78
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:51 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaX7-0001SP-UU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:48 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaQA-00000000LbW-0kqQ; Tue, 04 Mar 2025 23:07:26 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 31/36] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
Date: Tue,  4 Mar 2025 23:03:58 +0100
Message-ID: <d6dbb326e3d53c7104d62c96c9e3dd64e1c7b940.1741124640.git.maciej.szmigiero@oracle.com>
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

This property allows configuring whether to transfer the particular device
state via multifd channels when live migrating that device.

It defaults to AUTO, which means that VFIO device state transfer via
multifd channels is attempted in configurations that otherwise support it.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c   | 18 +++++++++++++++++-
 hw/vfio/pci.c                 |  8 ++++++++
 include/hw/vfio/vfio-common.h |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index bfb9a72fa450..aacddc503bb8 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -476,18 +476,34 @@ bool vfio_multifd_transfer_supported(void)
 
 bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
 {
-    return false;
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->multifd_transfer;
 }
 
 bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
 
+    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
+        migration->multifd_transfer = vfio_multifd_transfer_supported();
+    } else {
+        migration->multifd_transfer =
+            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
+    }
+
     if (!vfio_multifd_transfer_enabled(vbasedev)) {
         /* Nothing further to check or do */
         return true;
     }
 
+    if (!vfio_multifd_transfer_supported()) {
+        error_setg(errp,
+                   "%s: Multifd device transfer requested but unsupported in the current config",
+                   vbasedev->name);
+        return false;
+    }
+
     if (alloc_multifd) {
         assert(!migration->multifd);
         migration->multifd = vfio_multifd_new();
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 89d900e9cf0c..6d6f889f59c5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3377,6 +3377,9 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
+                            vbasedev.migration_multifd_transfer,
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3433,6 +3436,11 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     pdc->exit = vfio_exitfn;
     pdc->config_read = vfio_pci_read_config;
     pdc->config_write = vfio_pci_write_config;
+
+    object_class_property_set_description(klass, /* 10.0 */
+                                          "x-migration-multifd-transfer",
+                                          "Transfer this device state via "
+                                          "multifd channels when live migrating it");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 961931d9f457..04b123a6c929 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -91,6 +91,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    bool multifd_transfer;
     VFIOMultifd *multifd;
     bool initial_data_sent;
 
@@ -153,6 +154,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    OnOffAuto migration_multifd_transfer;
     bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;

