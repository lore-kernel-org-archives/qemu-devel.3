Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF940C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLYI-0007om-KR; Wed, 26 Mar 2025 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYH-0007oQ-5w
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYF-0006EF-7O
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0KGPIyi2VZ3P11RSRtQPdTPRM3uau7bmwklgXVhA48=;
 b=A1Yrye2ZQkoas0Fk+YspAnLnKXc0HsUARNcs/gPBkh8CQhiiCWL5oJN8Mj+DJLCsqWdZp3
 9wdYiF7s4ZbTJIHAougvJIQft77AI45LZwr0LSQAYLMS+ZBkMyqom6qZCvLrkEukkdu0kF
 QLCE5rZ0wNFqIsEw4dPso4NqpgcviVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-xn-WHGZdOjGAdOqypwf0uw-1; Wed,
 26 Mar 2025 03:51:46 -0400
X-MC-Unique: xn-WHGZdOjGAdOqypwf0uw-1
X-Mimecast-MFC-AGG-ID: xn-WHGZdOjGAdOqypwf0uw_1742975505
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDB32196D2D2; Wed, 26 Mar 2025 07:51:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4DF319560AB; Wed, 26 Mar 2025 07:51:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for-10.1 v2 02/37] vfio: Rename vfio_reset_bytes_transferred()
Date: Wed, 26 Mar 2025 08:50:47 +0100
Message-ID: <20250326075122.1299361-3-clg@redhat.com>
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

Enforce a 'vfio_mig_' prefix for the VFIO migration API to better
reflect the namespace these routines belong to.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/migration.c           | 2 +-
 migration/target.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 04b123a6c929a8f47d740fc5433b54dadd32f731..9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc 100644
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


