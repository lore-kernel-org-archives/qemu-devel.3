Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5446AC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EiY-0002n6-7t; Fri, 25 Apr 2025 04:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiU-0002mY-67
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiO-0003DO-C1
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+lRuREDYmAb7FRqFmPmzscmAV0dzWDCk1Z9mMPPcq0=;
 b=bbXbrJVwqN+M9UWmmJV7PkBTW7wM5Fgb7HMgltlsVkcwO8KS0WOmD1r/t4iDQvgifkiVhv
 i81gAGeE8HkYPVvDVuoD3ZW+N5v9pBzT0Wr4WlRiVVqMXaUUkjoUTVbNXTvyNbELjl3KC3
 kI18FqxnRoalK78UFhtNeGf46TSfk6o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-W1hyRVRSOfKp2xrlT16HMQ-1; Fri,
 25 Apr 2025 04:47:17 -0400
X-MC-Unique: W1hyRVRSOfKp2xrlT16HMQ-1
X-Mimecast-MFC-AGG-ID: W1hyRVRSOfKp2xrlT16HMQ_1745570836
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22FE119560AE; Fri, 25 Apr 2025 08:47:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BB8C30001A2; Fri, 25 Apr 2025 08:47:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/50] vfio: Rename vfio_reset_bytes_transferred()
Date: Fri, 25 Apr 2025 10:45:59 +0200
Message-ID: <20250425084644.102196-7-clg@redhat.com>
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

Enforce a 'vfio_mig_' prefix for the VFIO migration API to better
reflect the namespace these routines belong to.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-3-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/migration.c           | 2 +-
 migration/target.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f5b3f45a43aefc5e90137bb40de1d50d3abeff11..f58cae9e55c9a2816358160984fab18324fba0cf 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -295,7 +295,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
-void vfio_reset_bytes_transferred(void);
+void vfio_mig_reset_bytes_transferred(void);
 void vfio_mig_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b5fb0d218808d010d8210612d3182dde8f33514b..8bf65b8e11094b8363692dba3084b762362c7dd6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1052,7 +1052,7 @@ int64_t vfio_mig_bytes_transferred(void)
     return MIN(qatomic_read(&bytes_transferred), INT64_MAX);
 }
 
-void vfio_reset_bytes_transferred(void)
+void vfio_mig_reset_bytes_transferred(void)
 {
     qatomic_set(&bytes_transferred, 0);
 }
diff --git a/migration/target.c b/migration/target.c
index a6ffa9a5ce312d1e64157b650827aa726eb4d364..f5d8cfe7c2a3473f4bd3f5068145598c60973c58 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -25,7 +25,7 @@ void migration_populate_vfio_info(MigrationInfo *info)
 
 void migration_reset_vfio_bytes_transferred(void)
 {
-    vfio_reset_bytes_transferred();
+    vfio_mig_reset_bytes_transferred();
 }
 #else
 void migration_populate_vfio_info(MigrationInfo *info)
-- 
2.49.0


