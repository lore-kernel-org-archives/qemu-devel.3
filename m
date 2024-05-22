Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ABAC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihI-0003xw-7v; Wed, 22 May 2024 05:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih8-0003bW-1s
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih6-0001kT-98
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3IyGXEIi8Lck1UpUIn2/C+Qvo2TjwD4ZA/zkD428RJ8=;
 b=Wm1d81BJnhfF8ksgl36SJ5zvbJV2HC4djeNjxWf5Yhv6xjmfpAqD0Kf1c3qQV9AdNyoX2w
 SxQd4t/uNago5SfAhEtzEGUnJ4xYaje2o5wzfyYGak1dCZ6k+Vwb82CAvfYBklwkRFYDwU
 vljVgiHti6pZa8WuW7c+/pIrN19kBAk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-SIxyxu6NONiFXsB1UtYdzA-1; Wed,
 22 May 2024 05:55:31 -0400
X-MC-Unique: SIxyxu6NONiFXsB1UtYdzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A1111C29EA4;
 Wed, 22 May 2024 09:55:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB17C28E2;
 Wed, 22 May 2024 09:55:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/47] backends/iommufd: Make iommufd_backend_*() return bool
Date: Wed, 22 May 2024 11:54:24 +0200
Message-ID: <20240522095442.195243-30-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

The changed functions include:

iommufd_backend_connect
iommufd_backend_alloc_ioas

By this chance, simplify the functions a bit by avoiding duplicate
recordings, e.g., log through either error interface or trace, not
both.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/sysemu/iommufd.h |  6 +++---
 backends/iommufd.c       | 29 +++++++++++++----------------
 hw/vfio/iommufd.c        |  5 ++---
 backends/trace-events    |  4 ++--
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9af27ebd6ccb78ca8e16aa3c62629aab9f7f31e4..293bfbe967215381532b8267227dde61fa9157b7 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -23,11 +23,11 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
-int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
+bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
-int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
-                               Error **errp);
+bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
+                                Error **errp);
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 76a0204852f73466a9f31492a08d89d468bff7c0..c506afbdac4beddb7dac88f74f10544f7a083e58 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -72,24 +72,22 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
 
-int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
+bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 {
-    int fd, ret = 0;
+    int fd;
 
     if (be->owned && !be->users) {
         fd = qemu_open_old("/dev/iommu", O_RDWR);
         if (fd < 0) {
             error_setg_errno(errp, errno, "/dev/iommu opening failed");
-            ret = fd;
-            goto out;
+            return false;
         }
         be->fd = fd;
     }
     be->users++;
-out:
-    trace_iommufd_backend_connect(be->fd, be->owned,
-                                  be->users, ret);
-    return ret;
+
+    trace_iommufd_backend_connect(be->fd, be->owned, be->users);
+    return true;
 }
 
 void iommufd_backend_disconnect(IOMMUFDBackend *be)
@@ -106,25 +104,24 @@ out:
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
-int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
-                               Error **errp)
+bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
+                                Error **errp)
 {
-    int ret, fd = be->fd;
+    int fd = be->fd;
     struct iommu_ioas_alloc alloc_data  = {
         .size = sizeof(alloc_data),
         .flags = 0,
     };
 
-    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
-    if (ret) {
+    if (ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data)) {
         error_setg_errno(errp, errno, "Failed to allocate ioas");
-        return ret;
+        return false;
     }
 
     *ioas_id = alloc_data.out_ioas_id;
-    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
+    trace_iommufd_backend_alloc_ioas(fd, *ioas_id);
 
-    return ret;
+    return true;
 }
 
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6a446b16dcd64838dc9ebb6150cd5ed85ec6fef3..554f9a6292454f51015ab3a56df3fab6a482ccb7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -71,7 +71,7 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         .flags = 0,
     };
 
-    if (iommufd_backend_connect(iommufd, errp)) {
+    if (!iommufd_backend_connect(iommufd, errp)) {
         return false;
     }
 
@@ -346,8 +346,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     }
 
     /* Need to allocate a new dedicated container */
-    ret = iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp);
-    if (ret < 0) {
+    if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
         goto err_alloc_ioas;
     }
 
diff --git a/backends/trace-events b/backends/trace-events
index d45c6e31a67ed66d94787f60eb08a525cf6ff68b..211e6f374adcef25be0409ce3e42cbed6f31b744 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -7,11 +7,11 @@ dbus_vmstate_loading(const char *id) "id: %s"
 dbus_vmstate_saving(const char *id) "id: %s"
 
 # iommufd.c
-iommufd_backend_connect(int fd, bool owned, uint32_t users, int ret) "fd=%d owned=%d users=%d (%d)"
+iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
 iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
 iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
 iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
-iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
+iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
-- 
2.45.1


