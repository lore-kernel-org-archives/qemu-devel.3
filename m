Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DB1C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Eiq-0002sF-OE; Fri, 25 Apr 2025 04:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ein-0002qk-98
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eig-0003EG-Ay
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFKVfC+mPXFEgEjYEyqCmo1qq98Q48Y9AjnID8hqikE=;
 b=JmhnpNuX5vHutNDZKlo6MVttHVJGe7BRu9WmS+bYsWRPicmscDGXonVxLR8dV08X/e/3Ud
 Q5ysSRd98lLh0eQGHbc2xiiiLn6dquCCN1ottPAmVpRJet/I5kC6zWWhD20KMgIyKEKN79
 84kvbRN4Fgp00+GCnpoXIvJd6elKLy0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-za_iRC0cMlqIzBiTwXFOVw-1; Fri,
 25 Apr 2025 04:47:32 -0400
X-MC-Unique: za_iRC0cMlqIzBiTwXFOVw-1
X-Mimecast-MFC-AGG-ID: za_iRC0cMlqIzBiTwXFOVw_1745570851
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1EAE18001EA; Fri, 25 Apr 2025 08:47:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9635D30001A2; Fri, 25 Apr 2025 08:47:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, John Levon <john.levon@nutanix.com>
Subject: [PULL 11/50] vfio: Move vfio_device_state_is_running/precopy() into
 migration.c
Date: Fri, 25 Apr 2025 10:46:04 +0200
Message-ID: <20250425084644.102196-12-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

These routines are migration related. Move their declaration and
implementation under the migration files.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-8-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-migration-internal.h |  2 ++
 include/hw/vfio/vfio-common.h     |  3 ---
 hw/vfio/common.c                  | 16 ----------------
 hw/vfio/migration.c               | 16 ++++++++++++++++
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index ab6a1bad9b513aa61557905e72e5c6b264372276..a8b456b239df8a54ab96daf56b5f778b3ffbfa5e 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -57,6 +57,8 @@ typedef struct VFIOMigration {
 
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
+bool vfio_device_state_is_running(VFIODevice *vbasedev);
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
 int vfio_load_device_config_state(QEMUFile *f, void *opaque);
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 05c88753ce93ab9df7863082d938467d21d76967..fa0b74d5eac53cc49e9da97007cc36ca7b8d8611 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -252,9 +252,6 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-bool vfio_device_state_is_running(VFIODevice *vbasedev);
-bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
-
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index bef5414dd7a2b1f005b75816ff46b4f390c630b1..8f55e7b212991acb8be63c924327206c8d1727b0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -66,22 +66,6 @@ int vfio_kvm_device_fd = -1;
  */
 
 
-bool vfio_device_state_is_running(VFIODevice *vbasedev)
-{
-    VFIOMigration *migration = vbasedev->migration;
-
-    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
-}
-
-bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
-{
-    VFIOMigration *migration = vbasedev->migration;
-
-    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
-           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
-}
-
 static bool vfio_devices_all_device_dirty_tracking_started(
     const VFIOContainerBase *bcontainer)
 {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 54f6ca3e7ce0024ac103535cb1978b1941d0bf15..4da05263255b9f858539a55d03d1b35609a4c697 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1220,3 +1220,19 @@ void vfio_migration_exit(VFIODevice *vbasedev)
 
     migrate_del_blocker(&vbasedev->migration_blocker);
 }
+
+bool vfio_device_state_is_running(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
+}
+
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
+           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
+}
-- 
2.49.0


