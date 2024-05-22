Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8366CC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihI-0003yA-8J; Wed, 22 May 2024 05:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihG-0003n6-7g
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihD-0001lh-Fu
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPJI4jkMtJpab0/3uJYRgdID4KuU50kijZ9YVzhF8fo=;
 b=D8ziA4Gqmm3sVLnpRrRDPyaon326ZhBxb6GSgwb/AyOoMWtcvty7MdxGTSQCpVWMA2xsfN
 RqaRWcVUU1OroUkOR21ilU5kwHgeBM3ZfQEAKsvUEFRr/lVp16muhzCu3TIT28a6hyZEJI
 KnyaD4WjAacnS4DKLOPESuUFdPjawuc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-B1nthK5bNqWkPPij9uub9g-1; Wed, 22 May 2024 05:55:38 -0400
X-MC-Unique: B1nthK5bNqWkPPij9uub9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45F75185A780;
 Wed, 22 May 2024 09:55:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22ECE51BF;
 Wed, 22 May 2024 09:55:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/47] vfio/helpers: Make vfio_device_get_name() return bool
Date: Wed, 22 May 2024 11:54:29 +0200
Message-ID: <20240522095442.195243-35-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/ap.c                  | 2 +-
 hw/vfio/ccw.c                 | 2 +-
 hw/vfio/helpers.c             | 8 ++++----
 hw/vfio/pci.c                 | 2 +-
 hw/vfio/platform.c            | 5 ++---
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b712799caffdc950b593a87d569d7f5281976e2f..4cb1ab8645dcdf604f3c2bb29328668fd5eb7284 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -279,7 +279,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
 /* Returns 0 on success, or a negative errno. */
-int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
+bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index d8a9615feec065e98f53831912087d9878fdff9c..c12531a7886a2fe87598be0861fba5923bd2c206 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -158,7 +158,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
-    if (vfio_device_get_name(vbasedev, errp) < 0) {
+    if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 1f578a3c75d975e12bbac52b3683e6fd193801cb..8850ca17c84632d278e27819cd52e104ed436d6c 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -588,7 +588,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (vfio_device_get_name(vbasedev, errp) < 0) {
+    if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 9edbc966884de12e7248af8d50d87f26c8cd2764..4b079dc383683a71d1d96507a0fb66a4bc3ba923 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -607,7 +607,7 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
     return ret;
 }
 
-int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
+bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 {
     ERRP_GUARD();
     struct stat st;
@@ -616,7 +616,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
         if (stat(vbasedev->sysfsdev, &st) < 0) {
             error_setg_errno(errp, errno, "no such host device");
             error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
-            return -errno;
+            return false;
         }
         /* User may specify a name, e.g: VFIO platform device */
         if (!vbasedev->name) {
@@ -625,7 +625,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
     } else {
         if (!vbasedev->iommufd) {
             error_setg(errp, "Use FD passing only with iommufd backend");
-            return -EINVAL;
+            return false;
         }
         /*
          * Give a name with fd so any function printing out vbasedev->name
@@ -636,7 +636,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
         }
     }
 
-    return 0;
+    return true;
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 358da4497b8ab9b58b4f36252d1857279efbe521..aad012c34885ff2a5a39039777dddd962236b41b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2999,7 +2999,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                             vdev->host.slot, vdev->host.function);
     }
 
-    if (vfio_device_get_name(vbasedev, errp) < 0) {
+    if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 3233ca86918a22b69265b83a1a9dec8b6b59380f..e1a32863d919fe09a743f5fb108f9787984d4378 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -545,9 +545,8 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
                                              vbasedev->name);
     }
 
-    ret = vfio_device_get_name(vbasedev, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_device_get_name(vbasedev, errp)) {
+        return -EINVAL;
     }
 
     if (!vfio_attach_device(vbasedev->name, vbasedev,
-- 
2.45.1


