Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D45E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6e6-0007ca-Hq; Tue, 24 Dec 2024 10:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dy-0007ID-5z
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dw-00045D-EO
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77QBj1Y7bNfhgedyYJEptps/L2oTvIdmai50MTIxpNE=;
 b=ck9VOlcDkBJ3EyEpNHBG5awl4Tq3EONL+KmwBg6WYbBt/QVN7kpp0EgikLqzxUjJnX+lNF
 fiQChP+iozq6UujZUbMXsbC5zfhBWj16lXI05u0LT/LgrVIJkuz7iwBpCSwm5zIlOyeEfd
 iTiwS6T5nOGKRt9xnQA9UI7pdNkyuLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-SMSWJQLmPgOdkyhc3ZVU8w-1; Tue,
 24 Dec 2024 10:16:18 -0500
X-MC-Unique: SMSWJQLmPgOdkyhc3ZVU8w-1
X-Mimecast-MFC-AGG-ID: SMSWJQLmPgOdkyhc3ZVU8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 467A91956088; Tue, 24 Dec 2024 15:16:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BA413000197; Tue, 24 Dec 2024 15:16:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/17] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
Date: Tue, 24 Dec 2024 16:15:42 +0100
Message-ID: <20241224151547.386529-13-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
check if dirty tracking has been started in order to avoid errors. The
current logic checks if migration is in ACTIVE or DEVICE states to
ensure dirty tracking has been started.

However, recently there has been an effort to simplify the migration
status API and reduce it to a single migration_is_running() function.

To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
it won't use migration_is_active() and migration_is_device(). Instead,
use internal VFIO dirty tracking flags.

As a side effect, now that migration status is no longer used to detect
dirty tracking status, VFIO log syncs are untied from migration. This
will make calc-dirty-rate more accurate as now it will also include VFIO
dirty pages.

While at it, as VFIODevice->dirty_tracking is now used to detect dirty
tracking status, add a comment that states how it's protected.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20241218134022.21264-3-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 +-
 hw/vfio/common.c              | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d57111843dafbc215da8f9de43780227e572dd54..a9a68e3fd9a2a570856193cb290cc252b46093de 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -143,7 +143,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
-    bool dirty_tracking;
+    bool dirty_tracking; /* Protected by BQL */
     bool iommu_dirty_tracking;
     HostIOMMUDevice *hiod;
     int devid;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 598272f4dd2708f8241733f5a994d0ea135c4e39..fd24b7ced83d241445c0b3dbd014b125b41a0927 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -170,11 +170,26 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
            migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
 }
 
+static bool vfio_devices_all_device_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
+{
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (!vbasedev->dirty_tracking) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active() && !migration_is_device()) {
+    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+          bcontainer->dirty_pages_started)) {
         return false;
     }
 
-- 
2.47.1


