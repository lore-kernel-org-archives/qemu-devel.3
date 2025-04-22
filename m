Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5C3C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G64-0007aR-Iw; Tue, 22 Apr 2025 12:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5F-0006nf-98
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5D-0004zS-6V
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHxFB50YltHZse54hKXFNduextTmwbK0uBsGBd3Tts0=;
 b=eYF8SczfHGJkFOuj0yhAE4UYSI7g9IGfv/+NRSLdn13uMsFNGcrdjf89qi9uE773jjjAGT
 asanYM2euyDpgAuqNmLqM0/IzZ0kclMTmomBE90iL13/2Q/4ybJUPZSWjeD6eLbRf2nsAC
 5hwYljn1Yg9APdNLyGnNxbdchsWCyOM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-5n2Y0rTNOtGUKpPuqyPANA-1; Tue,
 22 Apr 2025 12:02:44 -0400
X-MC-Unique: 5n2Y0rTNOtGUKpPuqyPANA-1
X-Mimecast-MFC-AGG-ID: 5n2Y0rTNOtGUKpPuqyPANA_1745337763
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3738619560A0; Tue, 22 Apr 2025 16:02:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD3E318001DD; Tue, 22 Apr 2025 16:02:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3 03/37] vfio: Introduce a new header file for external
 migration services
Date: Tue, 22 Apr 2025 18:01:50 +0200
Message-ID: <20250422160224.199714-4-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The migration core subsystem makes use of the VFIO migration API to
collect statistics on the number of bytes transferred. These services
are declared in "hw/vfio/vfio-common.h" which also contains VFIO
internal declarations. Move the migration declarations into a new
header file "hw/vfio/vfio-migration.h" to reduce the exposure of VFIO
internals.

While at it, use a 'vfio_migration_' prefix for these services.

To be noted, vfio_migration_add_bytes_transferred() is a VFIO
migration internal service which we will be moved in the subsequent
patches.

Cc: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-4-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h    |  5 +----
 include/hw/vfio/vfio-migration.h | 16 ++++++++++++++++
 hw/vfio/migration-multifd.c      |  5 +++--
 hw/vfio/migration.c              | 11 ++++++-----
 migration/target.c               |  8 ++++----
 5 files changed, 30 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/vfio/vfio-migration.h

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc..fd424a4a3d40132e940f457f9250458e50ea0b71 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -290,13 +290,10 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-bool vfio_mig_active(void);
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
-int64_t vfio_mig_bytes_transferred(void);
-void vfio_mig_reset_bytes_transferred(void);
-void vfio_mig_add_bytes_transferred(unsigned long val);
+void vfio_migration_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
diff --git a/include/hw/vfio/vfio-migration.h b/include/hw/vfio/vfio-migration.h
new file mode 100644
index 0000000000000000000000000000000000000000..0d4ecd33d5d8c214bb77e0652b4405b6e43bcafa
--- /dev/null
+++ b/include/hw/vfio/vfio-migration.h
@@ -0,0 +1,16 @@
+/*
+ * VFIO migration interface
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_MIGRATION_H
+#define HW_VFIO_VFIO_MIGRATION_H
+
+bool vfio_migration_active(void);
+int64_t vfio_migration_bytes_transferred(void);
+void vfio_migration_reset_bytes_transferred(void);
+
+#endif /* HW_VFIO_VFIO_MIGRATION_H */
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 378f6f3bf01f6a4155fb424f8028cb5380f27f02..09aa57f5f890f37f7e36c857fd813f55b1da2fce 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
 #include "qemu/bswap.h"
@@ -575,7 +576,7 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
         return false;
     }
 
-    vfio_mig_add_bytes_transferred(packet_len);
+    vfio_migration_add_bytes_transferred(packet_len);
 
     return true;
 }
@@ -645,7 +646,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
             goto thread_exit;
         }
 
-        vfio_mig_add_bytes_transferred(packet_size);
+        vfio_migration_add_bytes_transferred(packet_size);
     }
 
     if (!vfio_save_complete_precopy_thread_config_state(vbasedev,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 8bf65b8e11094b8363692dba3084b762362c7dd6..582d65932a6c590eaecd8bf0b765f27d93896c72 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -17,6 +17,7 @@
 
 #include "system/runstate.h"
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
@@ -373,7 +374,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
     qemu_put_be64(f, data_size);
     qemu_put_buffer(f, migration->data_buffer, data_size);
-    vfio_mig_add_bytes_transferred(data_size);
+    vfio_migration_add_bytes_transferred(data_size);
 
     trace_vfio_save_block(migration->vbasedev->name, data_size);
 
@@ -1047,22 +1048,22 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
 
 /* ---------------------------------------------------------------------- */
 
-int64_t vfio_mig_bytes_transferred(void)
+int64_t vfio_migration_bytes_transferred(void)
 {
     return MIN(qatomic_read(&bytes_transferred), INT64_MAX);
 }
 
-void vfio_mig_reset_bytes_transferred(void)
+void vfio_migration_reset_bytes_transferred(void)
 {
     qatomic_set(&bytes_transferred, 0);
 }
 
-void vfio_mig_add_bytes_transferred(unsigned long val)
+void vfio_migration_add_bytes_transferred(unsigned long val)
 {
     qatomic_add(&bytes_transferred, val);
 }
 
-bool vfio_mig_active(void)
+bool vfio_migration_active(void)
 {
     VFIODevice *vbasedev;
 
diff --git a/migration/target.c b/migration/target.c
index f5d8cfe7c2a3473f4bd3f5068145598c60973c58..12fd399f0c521c5c28535b58f24feab6845947fd 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -11,21 +11,21 @@
 #include CONFIG_DEVICES
 
 #ifdef CONFIG_VFIO
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-migration.h"
 #endif
 
 #ifdef CONFIG_VFIO
 void migration_populate_vfio_info(MigrationInfo *info)
 {
-    if (vfio_mig_active()) {
+    if (vfio_migration_active()) {
         info->vfio = g_malloc0(sizeof(*info->vfio));
-        info->vfio->transferred = vfio_mig_bytes_transferred();
+        info->vfio->transferred = vfio_migration_bytes_transferred();
     }
 }
 
 void migration_reset_vfio_bytes_transferred(void)
 {
-    vfio_mig_reset_bytes_transferred();
+    vfio_migration_reset_bytes_transferred();
 }
 #else
 void migration_populate_vfio_info(MigrationInfo *info)
-- 
2.49.0


