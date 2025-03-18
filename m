Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DFFC35FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTfK-0004Ge-1c; Tue, 18 Mar 2025 05:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfH-0004G0-Ks
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfE-0002HA-OJ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3eE4hlkaMPnf7AhJKvotGRiJ8yh1rzIjBQynVufb1Y=;
 b=gNO/ozREXRzGTPp4lkMIOoToETMnI5/VDjo84nujsK2Ugh7BUePWaZ18EdMwUZTj6H/Mi7
 Ikb6g3k7JC3MKsrsX7DuGAkUZlD7LGfLw7G57rnYhcVikMe7FnK1FoSB5bYt0jYinqKHUn
 bVAnRIM6eNANydJI7IyEdWQpBEA3N3M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-zBoesQ3HNM2NiDGILQ675g-1; Tue,
 18 Mar 2025 05:55:04 -0400
X-MC-Unique: zBoesQ3HNM2NiDGILQ675g-1
X-Mimecast-MFC-AGG-ID: zBoesQ3HNM2NiDGILQ675g_1742291703
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87AA41800361; Tue, 18 Mar 2025 09:54:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5951518001EF; Tue, 18 Mar 2025 09:54:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 03/32] vfio: Introduce a new header file for external
 migration services
Date: Tue, 18 Mar 2025 10:53:46 +0100
Message-ID: <20250318095415.670319-4-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The migration core subsytem makes uses of the VFIO migration API to
collect statistics on the number of bytes transferred. These services
are declared in "hw/vfio/vfio-common.h" which also contains VFIO
internal declarations. Move the migration declarations into a new
header file "hw/vfio/vfio-migration.h" to reduce the exposure of VFIO
internals.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h    |  4 ----
 include/hw/vfio/vfio-migration.h | 17 +++++++++++++++++
 hw/vfio/migration-multifd.c      |  1 +
 hw/vfio/migration.c              |  1 +
 migration/target.c               |  2 +-
 5 files changed, 20 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/vfio/vfio-migration.h

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc..5fc7ee76573375bc8464baee29ab88974fac3d3b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -290,13 +290,9 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-bool vfio_mig_active(void);
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
-int64_t vfio_mig_bytes_transferred(void);
-void vfio_mig_reset_bytes_transferred(void);
-void vfio_mig_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
diff --git a/include/hw/vfio/vfio-migration.h b/include/hw/vfio/vfio-migration.h
new file mode 100644
index 0000000000000000000000000000000000000000..259c532f64bdd002d512375df3140f291a0ade85
--- /dev/null
+++ b/include/hw/vfio/vfio-migration.h
@@ -0,0 +1,17 @@
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
+bool vfio_mig_active(void);
+int64_t vfio_mig_bytes_transferred(void);
+void vfio_mig_reset_bytes_transferred(void);
+void vfio_mig_add_bytes_transferred(unsigned long val);
+
+#endif /* HW_VFIO_VFIO_MIGRATION_H */
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 378f6f3bf01f6a4155fb424f8028cb5380f27f02..fe84735ec2c7bd085820d25c06be558761fbe0d5 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
 #include "qemu/bswap.h"
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 8bf65b8e11094b8363692dba3084b762362c7dd6..75096377ffecf62b3bab91102a00d723827ea4c7 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -17,6 +17,7 @@
 
 #include "system/runstate.h"
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
diff --git a/migration/target.c b/migration/target.c
index f5d8cfe7c2a3473f4bd3f5068145598c60973c58..e1eacd1db7a471cba51b4e257a834eb7581f9671 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -11,7 +11,7 @@
 #include CONFIG_DEVICES
 
 #ifdef CONFIG_VFIO
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-migration.h"
 #endif
 
 #ifdef CONFIG_VFIO
-- 
2.48.1


