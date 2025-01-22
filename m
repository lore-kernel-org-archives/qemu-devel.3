Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDCCC0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacUG-0004bc-Sr; Wed, 22 Jan 2025 10:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUF-0004bH-Pd
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUE-0004YT-Ag
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737559065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCH6PrnlcUl+bRd4c5qQ28sEk/fKhW973tgX711Eulk=;
 b=G0CbGUu/bPCjUqmFgvJsOkvI0Tgk2PlvAlbGaeB3gRxKe7K37KFkjofQtPNuT0ukbAagNb
 NQYMMS36an9Va+EbDqMRrhfJ+XqRThMyt7/MmmJ2Ru2AsUL46EQgivjepeHNCKtPW+eFum
 clpGRFFqmfbRnxuiGNbBQusCmZCgYf0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-uNqx4XTTOJeTRPK0ulYp2g-1; Wed,
 22 Jan 2025 10:17:42 -0500
X-MC-Unique: uNqx4XTTOJeTRPK0ulYp2g-1
X-Mimecast-MFC-AGG-ID: uNqx4XTTOJeTRPK0ulYp2g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B473E19560B3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 15:17:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A22119560AA; Wed, 22 Jan 2025 15:17:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/5] vfio: Modify vfio_viommu_preset() parameter
Date: Wed, 22 Jan 2025 16:17:29 +0100
Message-ID: <20250122151732.1351821-3-clg@redhat.com>
In-Reply-To: <20250122151732.1351821-1-clg@redhat.com>
References: <20250122151732.1351821-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

We plan to use vfio_viommu_preset() in MemoryListener handlers which
operate at the container level. Change the parameter to VFIOContainerBase
to ease future changes.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/common.c              | 4 ++--
 hw/vfio/migration.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 48018dc751e51066769b23bc6e4675a7167b099e..fcfe0b4b8cbe907877e366117e7bb7f74311d4f6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -274,7 +274,7 @@ extern int vfio_kvm_device_fd;
 bool vfio_mig_active(void);
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-bool vfio_viommu_preset(VFIODevice *vbasedev);
+bool vfio_viommu_preset(VFIOContainerBase *bcontainer);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2660a42f9edc9346f2e62652efb0c78a8b48b52b..3ca5dbf883ed2262e36952fcc47e717ff4154f12 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -142,9 +142,9 @@ void vfio_unblock_multiple_devices_migration(void)
     migrate_del_blocker(&multiple_devices_migration_blocker);
 }
 
-bool vfio_viommu_preset(VFIODevice *vbasedev)
+bool vfio_viommu_preset(VFIOContainerBase *bcontainer)
 {
-    return vbasedev->bcontainer->space->as != &address_space_memory;
+    return bcontainer->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int ret)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index adfa752db5272e37d73fc0a435a0834e74e3f2fe..347390adb27bc3cd123f3eec1de6dc6986d8d952 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1069,7 +1069,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         goto out_deinit;
     }
 
-    if (vfio_viommu_preset(vbasedev)) {
+    if (vfio_viommu_preset(vbasedev->bcontainer)) {
         error_setg(&err, "%s: Migration is currently not supported "
                    "with vIOMMU enabled", vbasedev->name);
         goto add_blocker;
-- 
2.48.1


