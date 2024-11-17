Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074AD10F26
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkrQ-0005Vz-GQ; Sun, 17 Nov 2024 14:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrD-00058E-8h
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:52 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrB-0005yH-PW
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:51 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkr8-00000002GWD-2D0b; Sun, 17 Nov 2024 20:22:46 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 19/24] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
Date: Sun, 17 Nov 2024 20:20:14 +0100
Message-ID: <b34680f99e294532a5d095b34b5ef0e4f778b1f2.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This property allows configuring at runtime whether to transfer the
particular device state via multifd channels when live migrating that
device.

It defaults to AUTO, which means that VFIO device state transfer via
multifd channels is attempted in configurations that otherwise support it.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/core/machine.c             | 1 +
 hw/vfio/pci.c                 | 9 +++++++++
 include/hw/vfio/vfio-common.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed8d39fd769f..fda0f8280edd 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@
 GlobalProperty hw_compat_9_1[] = {
     { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
     { "migration", "send-switchover-start", "off"},
+    { "vfio-pci", "x-migration-multifd-transfer", "off" },
 };
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 14bcc725c301..9d547cb5cdff 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3354,6 +3354,8 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
+static PropertyInfo qdev_prop_on_off_auto_mutable;
+
 static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
@@ -3378,6 +3380,10 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
+                vbasedev.migration_multifd_transfer,
+                qdev_prop_on_off_auto_mutable, OnOffAuto,
+                .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3475,6 +3481,9 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
 
 static void register_vfio_pci_dev_type(void)
 {
+    qdev_prop_on_off_auto_mutable = qdev_prop_on_off_auto;
+    qdev_prop_on_off_auto_mutable.realized_set_allowed = true;
+
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 246250ed8b75..b1c03a82eec8 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -134,6 +134,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    OnOffAuto migration_multifd_transfer;
     bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;

