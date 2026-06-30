Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8A1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8b-0006kb-A3; Tue, 30 Jun 2026 00:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8X-0006jA-QG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8W-00035v-0X
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJfCXdYD4bmJUSsKlNA5zjKB+IjN9rgZ/MIuueoCW38=;
 b=Dicaf9rz12mjZw+B9q/oI+AWCPWmThmCfzidOqDgF2JXZ4raBp7Fn8vByS4iezOQHNXDvA
 D5SvPrJjgpowRrIqkodVOb2j9to3TZ9hN5PWQzRNs7DOUuFbXu0wdlSPqw2/wLJ9YMq+q6
 l60QtXfXcSzqPciJpRWfL55e2jiO47I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-0t5Qmf2VO3WcOXEmWJqFBg-1; Tue,
 30 Jun 2026 00:31:44 -0400
X-MC-Unique: 0t5Qmf2VO3WcOXEmWJqFBg-1
X-Mimecast-MFC-AGG-ID: 0t5Qmf2VO3WcOXEmWJqFBg_1782793903
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 348451800576; Tue, 30 Jun 2026 04:31:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C07271956042; Tue, 30 Jun 2026 04:31:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/23] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
Date: Tue, 30 Jun 2026 06:30:59 +0200
Message-ID: <20260630043107.1511076-16-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

vfio_migration_init() already has many failure points and a new one will
be added in next patch.

Add Error ** parameter to vfio_migration_init() to report a detailed
error message through it. Refactor it to return bool as well.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-11-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 45f8e346b4a69a798366d460eccf028f35e7a47f..3ab6b7248fea34dec3b58e508f97c8be4c962ce4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1056,7 +1056,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
     return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
 }
 
-static int vfio_migration_init(VFIODevice *vbasedev)
+static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
     Object *obj;
@@ -1067,22 +1067,32 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
-        return -EINVAL;
+        error_setg(errp, "no vfio_get_object handler");
+        return false;
     }
 
     obj = vbasedev->ops->vfio_get_object(vbasedev);
     if (!obj) {
-        return -EINVAL;
+        error_setg(errp, "failed to get object");
+        return false;
     }
 
     ret = vfio_migration_query_flags(vbasedev, &mig_flags);
     if (ret) {
-        return ret;
+        if (ret == -ENOTTY) {
+            error_setg_errno(errp, -ret,
+                             "migration is not supported in kernel");
+        } else {
+            error_setg_errno(errp, -ret, "failed to query migration flags");
+        }
+
+        return false;
     }
 
     /* Basic migration functionality must be supported */
     if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
-        return -EOPNOTSUPP;
+        error_setg(errp, "VFIO_MIGRATION_STOP_COPY is not supported");
+        return false;
     }
 
     vbasedev->migration = g_new0(VFIOMigration, 1);
@@ -1113,7 +1123,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
-    return 0;
+    return true;
 }
 
 static Error *multiple_devices_migration_blocker;
@@ -1279,18 +1289,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    ret = vfio_migration_init(vbasedev);
-    if (ret) {
-        if (ret == -ENOTTY) {
-            error_setg(&err, "%s: VFIO migration is not supported in kernel",
-                       vbasedev->name);
-        } else {
-            error_setg(&err,
-                       "%s: Migration couldn't be initialized for VFIO device, "
-                       "err: %d (%s)",
-                       vbasedev->name, ret, strerror(-ret));
-        }
-
+    if (!vfio_migration_init(vbasedev, &err)) {
+        error_prepend(&err, "%s: VFIO migration init failed: ", vbasedev->name);
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-- 
2.54.0


