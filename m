Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E792C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihL-0004BB-4i; Wed, 22 May 2024 05:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih4-0003a3-2k
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih2-0001jq-CB
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tasUQp7d0Yx+T4QoQ921x6/KbPxPVRWp4GsazcxRjlU=;
 b=D4m5GbQrwxSnu1g8qQ2EucUZy0/D22FvO2YOb1g4Z5ypc/uHvba/CSxSNo4iaM3Hy0qS+S
 fDnDx4p4mc6TylnMgzk6h5w+xAHr6m2DfCrWhL/kMXpCDHC1iaJBmpYXOBG9ic8R7rk+kG
 /1l+HP8HO1f1XJW4M4LjdxCyoZ7Fmhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-oiiYnyzQMJK6y-MrmgZ1pg-1; Wed, 22 May 2024 05:55:27 -0400
X-MC-Unique: oiiYnyzQMJK6y-MrmgZ1pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C55A101A525;
 Wed, 22 May 2024 09:55:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFE0F51BF;
 Wed, 22 May 2024 09:55:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/47] vfio/container: Make vfio_get_device() return bool
Date: Wed, 22 May 2024 11:54:21 +0200
Message-ID: <20240522095442.195243-27-clg@redhat.com>
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

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e330b2897423b97fee467884f4237669ceff4756..53649e397cab94f8a2b61e6d66f21d635556e04e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -802,8 +802,8 @@ static void vfio_put_group(VFIOGroup *group)
     g_free(group);
 }
 
-static int vfio_get_device(VFIOGroup *group, const char *name,
-                           VFIODevice *vbasedev, Error **errp)
+static bool vfio_get_device(VFIOGroup *group, const char *name,
+                            VFIODevice *vbasedev, Error **errp)
 {
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
@@ -815,14 +815,14 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
         error_append_hint(errp,
                       "Verify all devices in group %d are bound to vfio-<bus> "
                       "or pci-stub and not already in use\n", group->groupid);
-        return fd;
+        return false;
     }
 
     info = vfio_get_device_info(fd);
     if (!info) {
         error_setg_errno(errp, errno, "error getting device info");
         close(fd);
-        return -1;
+        return false;
     }
 
     /*
@@ -837,7 +837,7 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
             error_setg(errp, "Inconsistent setting of support for discarding "
                        "RAM (e.g., balloon) within group");
             close(fd);
-            return -1;
+            return false;
         }
 
         if (!group->ram_block_discard_allowed) {
@@ -858,7 +858,7 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
 
     vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
 
-    return 0;
+    return true;
 }
 
 static void vfio_put_base_device(VFIODevice *vbasedev)
@@ -911,7 +911,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     VFIOContainerBase *bcontainer;
-    int ret;
 
     if (groupid < 0) {
         return false;
@@ -931,8 +930,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
             return false;
         }
     }
-    ret = vfio_get_device(group, name, vbasedev, errp);
-    if (ret) {
+    if (!vfio_get_device(group, name, vbasedev, errp)) {
         vfio_put_group(group);
         return false;
     }
-- 
2.45.1


