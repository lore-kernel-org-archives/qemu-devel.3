Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB60C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0RE-0002mz-PE; Tue, 27 Aug 2024 13:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Qb-00082T-3K
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:28 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QZ-0001e8-JM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:24 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QT-0002QJ-4P; Tue, 27 Aug 2024 19:56:17 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 16/17] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
Date: Tue, 27 Aug 2024 19:54:35 +0200
Message-ID: <49b797459ace788bce2de757df3a722c3678cb0c.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This property allows configuring at runtime whether to send the
particular device state via multifd channels when live migrating that
device.

It is ignored on the receive side and defaults to "false" for bit stream
compatibility with older QEMU versions.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/pci.c                 | 7 +++++++
 include/hw/vfio/vfio-common.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 08cb56d27a05..b68f08ba8a4f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3354,6 +3354,8 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
+static PropertyInfo qdev_prop_bool_mutable;
+
 static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
@@ -3378,6 +3380,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
+                vbasedev.migration_multifd_transfer, qdev_prop_bool_mutable, bool),
     DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
                        vbasedev.migration_max_queued_buffers, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
@@ -3477,6 +3481,9 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
 
 static void register_vfio_pci_dev_type(void)
 {
+    qdev_prop_bool_mutable = qdev_prop_bool;
+    qdev_prop_bool_mutable.realized_set_allowed = true;
+
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ba5b9464e79a..fe05acb9a5d1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -149,6 +149,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    bool migration_multifd_transfer;
     bool migration_events;
     uint64_t migration_max_queued_buffers;
     VFIODeviceOps *ops;

