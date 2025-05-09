Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1D7C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNa4-0003pd-LW; Fri, 09 May 2025 09:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYY-0001pV-NU
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYS-00078X-TS
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySdw9AYxsVFnu6WAFMJ0IuKvHD9ZF9jnVwoN5F1bleI=;
 b=fsrflAYIDIWWZR3yM5oQbHk73gHSxVrxU4ccgNmnRgVnsJfss9fQDwPK4sz1gZiXLcoEyi
 pR3twQT0n8O7clZR4dUX3QfXXOLz5XojgG0IxRhbRVAMKx0E2j2EHJoUC+nJPdL8NK+qBf
 wl+hdvmUaTw7MyKUQlo5mec8bP5g8CQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-GUhlmS5uMaePNgJ6NOl1sA-1; Fri,
 09 May 2025 09:14:16 -0400
X-MC-Unique: GUhlmS5uMaePNgJ6NOl1sA-1
X-Mimecast-MFC-AGG-ID: GUhlmS5uMaePNgJ6NOl1sA_1746796456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0000B1800877; Fri,  9 May 2025 13:14:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAAC818003FD; Fri,  9 May 2025 13:14:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/28] vfio: add vfio_device_unprepare()
Date: Fri,  9 May 2025 15:13:05 +0200
Message-ID: <20250509131317.164235-17-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

From: John Levon <john.levon@nutanix.com>

Add a helper that's the inverse of vfio_device_prepare().

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-3-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 2 ++
 hw/vfio/container.c           | 6 +++---
 hw/vfio/device.c              | 7 +++++++
 hw/vfio/iommufd.c             | 4 +---
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 081929ca4b9bc59217c633421fcbe84ea4171aa7..342c4ba3bfec8d143a297203dbfa0e6f6fae3535 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -137,6 +137,8 @@ extern VFIODeviceList vfio_device_list;
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info);
 
+void vfio_device_unprepare(VFIODevice *vbasedev);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index d30c1a141d34d8b026876e4a289c08ba067ef8a7..cf23aa799f61da58da09411ca6213a753a7f4794 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -927,10 +927,10 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
-    QLIST_REMOVE(vbasedev, global_next);
-    QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->bcontainer = NULL;
     trace_vfio_device_detach(vbasedev->name, group->groupid);
+
+    vfio_device_unprepare(vbasedev);
+
     object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index f3b9902d21cdb4443ffd603b1b3f8ad5950996fc..31c441a3dfffdf459994407904ab78b1798bf979 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -412,3 +412,10 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 }
+
+void vfio_device_unprepare(VFIODevice *vbasedev)
+{
+    QLIST_REMOVE(vbasedev, container_next);
+    QLIST_REMOVE(vbasedev, global_next);
+    vbasedev->bcontainer = NULL;
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 83033c352a7d8d868aea52b2bdfcdcbbb6914bff..62ecb758f1ade0e39efaef2b4001dab91abaa001 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -615,9 +615,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     VFIOIOMMUFDContainer *container = container_of(bcontainer,
                                                    VFIOIOMMUFDContainer,
                                                    bcontainer);
-    QLIST_REMOVE(vbasedev, global_next);
-    QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->bcontainer = NULL;
+    vfio_device_unprepare(vbasedev);
 
     if (!vbasedev->ram_block_discard_allowed) {
         iommufd_cdev_ram_block_discard_disable(false);
-- 
2.49.0


