Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D932C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ih0-0003XZ-Vr; Wed, 22 May 2024 05:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igo-0003Rt-J5
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igm-0001QM-2P
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mb4TS0heb25hYEpWvRRpq8aztVfsgZO11urO3GR9nl8=;
 b=N/JW4uR7pUSB2IEvKeHk06t9nWmhEQMaRckTxBwvV4ITZKSzN5qbhRSh4gAzGaHyOINQDP
 Ewq1aHaN/Dck4lh4v3aZmAwOP/MxZijWWx3tGtoVohlRo52jZAjU60nDcFHg+Z/fWvyWlO
 iinx+90NDCLPuge1YZChwtTivo/5i6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-R3SEFLHgPlWuyXg7-NVZRg-1; Wed, 22 May 2024 05:55:13 -0400
X-MC-Unique: R3SEFLHgPlWuyXg7-NVZRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D3F7101A525;
 Wed, 22 May 2024 09:55:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C03351BF;
 Wed, 22 May 2024 09:55:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/47] vfio/migration: Emit VFIO migration QAPI event
Date: Wed, 22 May 2024 11:54:11 +0200
Message-ID: <20240522095442.195243-17-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Emit VFIO migration QAPI event when a VFIO device changes its migration
state. This can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

A new per VFIO device capability, "migration-events", is added so events
can be enabled only for the required devices. It is disabled by default.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 59 +++++++++++++++++++++++++++++++++--
 hw/vfio/pci.c                 |  2 ++
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b6ac24953667bc5f72f28480a6bf0f4722069cb9..878e34a12874f63fcb8bbc8dc8ca3d2dfa84fdb4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -115,6 +115,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index c4403a38ddb5e7e09fbcde0ad4132653ecaf0d24..af579b868d7caa726fde1eeb73c832ebc3136a7a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -24,6 +24,7 @@
 #include "migration/register.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-vfio.h"
 #include "exec/ramlist.h"
 #include "exec/ram_addr.h"
 #include "pci.h"
@@ -80,6 +81,58 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
     }
 }
 
+static VfioMigrationState
+mig_state_to_qapi_state(enum vfio_device_mig_state state)
+{
+    switch (state) {
+    case VFIO_DEVICE_STATE_STOP:
+        return QAPI_VFIO_MIGRATION_STATE_STOP;
+    case VFIO_DEVICE_STATE_RUNNING:
+        return QAPI_VFIO_MIGRATION_STATE_RUNNING;
+    case VFIO_DEVICE_STATE_STOP_COPY:
+        return QAPI_VFIO_MIGRATION_STATE_STOP_COPY;
+    case VFIO_DEVICE_STATE_RESUMING:
+        return QAPI_VFIO_MIGRATION_STATE_RESUMING;
+    case VFIO_DEVICE_STATE_RUNNING_P2P:
+        return QAPI_VFIO_MIGRATION_STATE_RUNNING_P2P;
+    case VFIO_DEVICE_STATE_PRE_COPY:
+        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
+    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
+        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void vfio_migration_send_event(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    DeviceState *dev = vbasedev->dev;
+    g_autofree char *qom_path = NULL;
+    Object *obj;
+
+    if (!vbasedev->migration_events) {
+        return;
+    }
+
+    g_assert(vbasedev->ops->vfio_get_object);
+    obj = vbasedev->ops->vfio_get_object(vbasedev);
+    g_assert(obj);
+    qom_path = object_get_canonical_path(obj);
+
+    qapi_event_send_vfio_migration(
+        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
+}
+
+static void vfio_migration_set_device_state(VFIODevice *vbasedev,
+                                            enum vfio_device_mig_state state)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    migration->device_state = state;
+    vfio_migration_send_event(vbasedev);
+}
+
 static int vfio_migration_set_state(VFIODevice *vbasedev,
                                     enum vfio_device_mig_state new_state,
                                     enum vfio_device_mig_state recover_state,
@@ -131,12 +184,12 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
             goto reset_device;
         }
 
-        migration->device_state = recover_state;
+        vfio_migration_set_device_state(vbasedev, recover_state);
 
         return ret;
     }
 
-    migration->device_state = new_state;
+    vfio_migration_set_device_state(vbasedev, new_state);
     if (mig_state->data_fd != -1) {
         if (migration->data_fd != -1) {
             /*
@@ -162,7 +215,7 @@ reset_device:
                  strerror(errno));
     }
 
-    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
+    vfio_migration_set_device_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
 
     return ret;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4789d43c0f9cc7ef94b73adc815377f7222d8c57..b5d1d398b120076c85cdd92d61793393f65e8554 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3388,6 +3388,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
+                     vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
                      vbasedev.ram_block_discard_allowed, false),
-- 
2.45.1


