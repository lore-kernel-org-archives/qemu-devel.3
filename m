Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF94C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaZm-0005RO-1W; Tue, 04 Mar 2025 17:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaYG-00044Q-6d
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:49 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaXG-0001Sp-DP
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:47 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaQF-00000000Lbg-1Ezx; Tue, 04 Mar 2025 23:07:31 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 32/36] vfio/migration: Make x-migration-multifd-transfer
 VFIO property mutable
Date: Tue,  4 Mar 2025 23:03:59 +0100
Message-ID: <f2f2d66bda477da3e6cb8c0311006cff36e8651d.1741124640.git.maciej.szmigiero@oracle.com>
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

DEFINE_PROP_ON_OFF_AUTO() property isn't runtime-mutable so using it
would mean that the source VM would need to decide upfront at startup
time whether it wants to do a multifd device state transfer at some
point.

Source VM can run for a long time before being migrated so it is
desirable to have a fallback mechanism to the old way of transferring
VFIO device state if it turns to be necessary.

This brings this property to the same mutability level as ordinary
migration parameters, which too can be adjusted at the run time.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c |  4 ++++
 hw/vfio/pci.c               | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index aacddc503bb8..233724710b37 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -485,6 +485,10 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
 
+    /*
+     * Make a copy of this setting at the start in case it is changed
+     * mid-migration.
+     */
     if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
         migration->multifd_transfer = vfio_multifd_transfer_supported();
     } else {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6d6f889f59c5..21605bac2fb0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3353,6 +3353,8 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
+static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
+
 static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
@@ -3377,9 +3379,10 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
-                            vbasedev.migration_multifd_transfer,
-                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
+                vbasedev.migration_multifd_transfer,
+                vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
+                .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3480,6 +3483,17 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
 
 static void register_vfio_pci_dev_type(void)
 {
+    /*
+     * Ordinary ON_OFF_AUTO property isn't runtime-mutable, but source VM can
+     * run for a long time before being migrated so it is desirable to have a
+     * fallback mechanism to the old way of transferring VFIO device state if
+     * it turns to be necessary.
+     * The following makes this type of property have the same mutability level
+     * as ordinary migration parameters.
+     */
+    vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
+    vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
+
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }

