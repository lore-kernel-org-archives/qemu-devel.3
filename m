Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5697FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNYn-0001xT-JQ; Fri, 09 May 2025 09:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYR-0001ou-Ns
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYO-00077B-Ri
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40cRvs0eAD+P5ZNGuz/k6ER2KaiSahsbMtU8YqYZtNg=;
 b=YKR4ucF+bBabgpdARq0VCbDrers2oG/h49ekY+muOv5kd/VGyVXBE4bwF82TnQmRElniF3
 +3Vohe5OA0h7cvpg4AWOqhDo+Ve/6gmldcNh2x7oEOkhfco6FJNKRpeqaKTghrJoKgMjyF
 J5vlRtfpaEk6Zv7R00NnN74aV9ykwtQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-kfUvc1f6PDGERkr8ohX3vw-1; Fri,
 09 May 2025 09:14:15 -0400
X-MC-Unique: kfUvc1f6PDGERkr8ohX3vw-1
X-Mimecast-MFC-AGG-ID: kfUvc1f6PDGERkr8ohX3vw_1746796453
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 198191800DA1; Fri,  9 May 2025 13:14:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8419F180045B; Fri,  9 May 2025 13:14:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/28] vfio: add vfio_device_prepare()
Date: Fri,  9 May 2025 15:13:04 +0200
Message-ID: <20250509131317.164235-16-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Commonize some initialization code shared by the legacy and iommufd vfio
implementations.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  3 +++
 hw/vfio/container.c           | 14 ++------------
 hw/vfio/device.c              | 14 ++++++++++++++
 hw/vfio/iommufd.c             |  9 +--------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 81c95bb51eeead0e8c4d126c2d0561e235632946..081929ca4b9bc59217c633421fcbe84ea4171aa7 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -134,6 +134,9 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a761f0958b71de39093d8849b49c55e3662e096f..d30c1a141d34d8b026876e4a289c08ba067ef8a7 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -826,18 +826,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         }
     }
 
+    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
+
     vbasedev->fd = fd;
     vbasedev->group = group;
     QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
-
     trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
     return true;
 }
 
@@ -890,7 +886,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_get_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
 
     if (groupid < 0) {
         return false;
@@ -919,11 +914,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto device_put_exit;
     }
 
-    bcontainer = &group->container->bcontainer;
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
-
     return true;
 
 device_put_exit:
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d625a7c4dbbf4ac222541283c4034e840da02b08..f3b9902d21cdb4443ffd603b1b3f8ad5950996fc 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -398,3 +398,17 @@ void vfio_device_detach(VFIODevice *vbasedev)
     }
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
+
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info)
+{
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 232c06dd15ba922b9ac4adbb96ec04e2e56a4072..83033c352a7d8d868aea52b2bdfcdcbbb6914bff 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -588,14 +588,7 @@ found_container:
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vbasedev->group = 0;
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_device_prepare(vbasedev, bcontainer, &dev_info);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
-- 
2.49.0


