Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF9AC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc42-0008I6-RA; Fri, 04 Jul 2025 04:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc41-0008G6-NR
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3z-00011T-Pm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HqdYRY7R8+Tk3oVyA2DsfR6hwcoRL7MDY+RheEjH5I=;
 b=bBtj/TaL7TBuQNwGYvvlCfbDW91lNWFk3JCwQaq1JC+Xhb8ARZoCoz23e7twsFobiE2tem
 gopJ+CqrnMq5qV+Ebs0o7gmZpaYAOvcqKbPzrCGctMZj0xF2Z5VXcUSqnEbnnpSbDl5am0
 syjEDgZTMNl1QTyECjJLjvHYczNI8Dc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-D6AnspH2PCSTA2u7Ll-c9A-1; Fri,
 04 Jul 2025 04:46:22 -0400
X-MC-Unique: D6AnspH2PCSTA2u7Ll-c9A-1
X-Mimecast-MFC-AGG-ID: D6AnspH2PCSTA2u7Ll-c9A_1751618781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9D811955EC7; Fri,  4 Jul 2025 08:46:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85F5819560A7; Fri,  4 Jul 2025 08:46:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/27] vfio/iommufd: device name blocker
Date: Fri,  4 Jul 2025 10:45:18 +0200
Message-ID: <20250704084528.1412959-18-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

If an invariant device name cannot be created, block CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-12-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  1 +
 hw/vfio/device.c           | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d37acc4a0a0ae1f6f38d8322fb9681227221fd09..fa7d43ddd8eccb305751f2311d4ca8248b5052d0 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -30,6 +30,7 @@ typedef struct VFIOContainerCPR {
 
 typedef struct VFIODeviceCPR {
     Error *mdev_blocker;
+    Error *id_blocker;
 } VFIODeviceCPR;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 97eddd04f5756a0e9e4763c4fef84c9829272053..0ae3f3c6607d329e08fd435d2934e23affc27264 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -28,6 +28,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "migration/cpr.h"
+#include "migration/blocker.h"
 #include "monitor/monitor.h"
 #include "vfio-helpers.h"
 
@@ -324,8 +326,16 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
             } else {
                 /*
                  * Assign a name so any function printing it will not break.
+                 * The fd number changes across processes, so this cannot be
+                 * used as an invariant name for CPR.
                  */
                 vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+                error_setg(&vbasedev->cpr.id_blocker,
+                           "vfio device with fd=%d needs an id property",
+                           vbasedev->fd);
+                return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker,
+                                                 errp, MIG_MODE_CPR_TRANSFER,
+                                                 -1) == 0;
             }
         }
     }
@@ -336,6 +346,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 void vfio_device_free_name(VFIODevice *vbasedev)
 {
     g_clear_pointer(&vbasedev->name, g_free);
+    migrate_del_blocker(&vbasedev->cpr.id_blocker);
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
-- 
2.50.0


