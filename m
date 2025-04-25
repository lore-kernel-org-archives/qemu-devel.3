Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E9EC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ein-0002qD-6o; Fri, 25 Apr 2025 04:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiZ-0002nh-4E
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiW-0003Dg-Ta
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ElvJk4d/udYXi++Bf5ZwZ/ZHHJwQTpXFh+529TpK0U=;
 b=EJcR4Ex1I0cCuZNpuXCit9mabY3Z2gb0WkGjVuaDDKQr8N/t0TvAvz2Mdx0OLgxIAhI29B
 1Iyw8A2SP5UhmGdIM6/dZIINkfi5gWXNxx6labkAWgJVu8tiV5LZBNjvXuTs2oIUESr05f
 hjI6luR7X1UxPPftyF7FRzBXBCpLtaw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-RwDOgm5JNdqnN3L0HPsRog-1; Fri,
 25 Apr 2025 04:47:23 -0400
X-MC-Unique: RwDOgm5JNdqnN3L0HPsRog-1
X-Mimecast-MFC-AGG-ID: RwDOgm5JNdqnN3L0HPsRog_1745570842
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9406180036F; Fri, 25 Apr 2025 08:47:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8BA430001A2; Fri, 25 Apr 2025 08:47:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 08/50] vfio: Make vfio_un/block_multiple_devices_migration()
 static
Date: Fri, 25 Apr 2025 10:46:01 +0200
Message-ID: <20250425084644.102196-9-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

Both of these routines are only used in file "migration.c". Move them
there.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-5-clg@redhat.com
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-5-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 --
 hw/vfio/common.c              | 59 -----------------------------------
 hw/vfio/migration.c           | 59 +++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7a551bb2300f047b98c90a72ea0b21356ecb668a..5f1c0bee9de3b4ed38a63872bca7db5bde3815c4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -290,8 +290,6 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
-void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 void vfio_migration_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2ea4e12c902c05fd707f7cb471ea86a520a93f4f..d65e77b93a15dff8ef244e296ff073c906e4af35 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -40,7 +40,6 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/misc.h"
-#include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "system/tcg.h"
 #include "system/tpm.h"
@@ -65,64 +64,6 @@ int vfio_kvm_device_fd = -1;
  * Device state interfaces
  */
 
-static Error *multiple_devices_migration_blocker;
-
-/*
- * Multiple devices migration is allowed only if all devices support P2P
- * migration. Single device migration is allowed regardless of P2P migration
- * support.
- */
-static bool vfio_multiple_devices_migration_is_supported(void)
-{
-    VFIODevice *vbasedev;
-    unsigned int device_num = 0;
-    bool all_support_p2p = true;
-
-    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->migration) {
-            device_num++;
-
-            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
-                all_support_p2p = false;
-            }
-        }
-    }
-
-    return all_support_p2p || device_num <= 1;
-}
-
-int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
-{
-    if (vfio_multiple_devices_migration_is_supported()) {
-        return 0;
-    }
-
-    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
-        error_setg(errp, "Multiple VFIO devices migration is supported only if "
-                         "all of them support P2P migration");
-        return -EINVAL;
-    }
-
-    if (multiple_devices_migration_blocker) {
-        return 0;
-    }
-
-    error_setg(&multiple_devices_migration_blocker,
-               "Multiple VFIO devices migration is supported only if all of "
-               "them support P2P migration");
-    return migrate_add_blocker_normal(&multiple_devices_migration_blocker,
-                                      errp);
-}
-
-void vfio_unblock_multiple_devices_migration(void)
-{
-    if (!multiple_devices_migration_blocker ||
-        !vfio_multiple_devices_migration_is_supported()) {
-        return;
-    }
-
-    migrate_del_blocker(&multiple_devices_migration_blocker);
-}
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 582d65932a6c590eaecd8bf0b765f27d93896c72..ace3d8548edfa438a6479df6a617ceb8f495c622 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1022,6 +1022,65 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     return 0;
 }
 
+static Error *multiple_devices_migration_blocker;
+
+/*
+ * Multiple devices migration is allowed only if all devices support P2P
+ * migration. Single device migration is allowed regardless of P2P migration
+ * support.
+ */
+static bool vfio_multiple_devices_migration_is_supported(void)
+{
+    VFIODevice *vbasedev;
+    unsigned int device_num = 0;
+    bool all_support_p2p = true;
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
+        if (vbasedev->migration) {
+            device_num++;
+
+            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
+                all_support_p2p = false;
+            }
+        }
+    }
+
+    return all_support_p2p || device_num <= 1;
+}
+
+static int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
+{
+    if (vfio_multiple_devices_migration_is_supported()) {
+        return 0;
+    }
+
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp, "Multiple VFIO devices migration is supported only if "
+                         "all of them support P2P migration");
+        return -EINVAL;
+    }
+
+    if (multiple_devices_migration_blocker) {
+        return 0;
+    }
+
+    error_setg(&multiple_devices_migration_blocker,
+               "Multiple VFIO devices migration is supported only if all of "
+               "them support P2P migration");
+    return migrate_add_blocker_normal(&multiple_devices_migration_blocker,
+                                      errp);
+}
+
+static void vfio_unblock_multiple_devices_migration(void)
+{
+    if (!multiple_devices_migration_blocker ||
+        !vfio_multiple_devices_migration_is_supported()) {
+        return;
+    }
+
+    migrate_del_blocker(&multiple_devices_migration_blocker);
+}
+
 static void vfio_migration_deinit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
-- 
2.49.0


