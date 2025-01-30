Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CA4C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRVz-0005cx-BS; Thu, 30 Jan 2025 05:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRVk-0005Bc-VI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:06 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRVi-0007MF-84
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:10:59 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRVd-00000006U01-3r2a; Thu, 30 Jan 2025 11:10:53 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 20/33] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
Date: Thu, 30 Jan 2025 11:08:41 +0100
Message-ID: <11f12c43e098ac5e2466e456e8cf8936c54210dc.1738171076.git.maciej.szmigiero@oracle.com>
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

This property allows configuring whether to start the config load only
after all iterables were loaded.
Such interlocking is required for ARM64 due to this platform VFIO
dependency on interrupt controller being loaded first.

The property defaults to AUTO, which means ON for ARM, OFF for other
platforms.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 25 +++++++++++++++++++++++++
 hw/vfio/pci.c                 |  3 +++
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 29 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index adfa752db527..d801c861d202 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -254,6 +254,31 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
     return ret;
 }
 
+static bool vfio_load_config_after_iter(VFIODevice *vbasedev)
+{
+    if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_ON) {
+        return true;
+    } else if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+
+    assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
+
+    /*
+     * Starting the config load only after all iterables were loaded is required
+     * for ARM64 due to this platform VFIO dependency on interrupt controller
+     * being loaded first.
+     *
+     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
+     * the right place in VFIO migration").
+     */
+#if defined(TARGET_ARM)
+    return true;
+#else
+    return false;
+#endif
+}
+
 static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
                                          Error **errp)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab17a98ee5b6..83090c544d95 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3377,6 +3377,9 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
+                            vbasedev.migration_load_config_after_iter,
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c60be5b15c7..153d03745dc7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -133,6 +133,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    OnOffAuto migration_load_config_after_iter;
     bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;

