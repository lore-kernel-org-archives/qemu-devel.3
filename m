Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3073C36010
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLYb-0007rd-JZ; Wed, 26 Mar 2025 03:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYa-0007rH-7E
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYY-0006Fr-MI
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiiWpfEa6jKCIajgZpnL7AMQmUw9hRHEuwCDKaVyEO4=;
 b=Tctw4y1MS9O2igYDYVSBt00A9QOkxASvMn8xfQMw6mpLkMPdALKgwfTd1i6Y08I4YVpRvD
 RWYlRKsdnJV63+ZdXd4hNG1yaYKLBzaDmdBXvYN7NJtzubbnK4JSYJIJED+jm2Kw6P6n+E
 QU5RLUFGkBeCw5aVOAlFX7LawhQRejw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-UWSXANvCMGmjUiuQQQYoxA-1; Wed,
 26 Mar 2025 03:52:04 -0400
X-MC-Unique: UWSXANvCMGmjUiuQQQYoxA-1
X-Mimecast-MFC-AGG-ID: UWSXANvCMGmjUiuQQQYoxA_1742975523
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E30C618EBE93; Wed, 26 Mar 2025 07:52:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29E1519560AD; Wed, 26 Mar 2025 07:51:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 07/37] vfio: Move
 vfio_device_state_is_running/precopy() into migration.c
Date: Wed, 26 Mar 2025 08:50:52 +0100
Message-ID: <20250326075122.1299361-8-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

These routines are migration related. Move their declaration and
implementation under the migration files.

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
index 920ad154b4f82b9c244b5b9e8da44f7583e5ead0..799e12d43747addbf444c15052f629b65978322f 100644
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
index 9bbd798e3e9e0b7a7620d4b1f34f1ef5e8ac42c1..33f7191c7fec76bb3f46b96e25dc1872808ccc8c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -67,22 +67,6 @@ int vfio_kvm_device_fd = -1;
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
index 2a72a8e07542096276cc7c386359ad375e7d24c8..8d69de3c80eaedf9bf4b8bc9b25f6d722ae619b2 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1223,3 +1223,19 @@ void vfio_migration_exit(VFIODevice *vbasedev)
 
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


