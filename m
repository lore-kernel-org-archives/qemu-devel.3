Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36F1FD88E3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09kf-0000Uf-Ji; Tue, 10 Mar 2026 22:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kd-0000Tf-VZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:47 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kc-000648-73
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197806; x=1804733806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EL9tM49KX8UwBYS/5t3yoawpXWhzE0kjsbW+72P3W4E=;
 b=Y1C1lU1e3eXDhgblPw97fg3seZwVjyaRCmLxRTnG7UsvANCyqFOp8NPf
 24i8DWDyIDz2XIURfjpb19FRAwaUAZo7A2I7PHcsEYPK0APhyTUamkwAl
 jq9aRG7y9ZgkG2iCwO5NjKeofULkmOSPcwCFuqdivlFDAHYSNVtCq0AmB
 miO3CF6cJc3DbQq5KWqZHGKczDFFQyrJQc2UJV0lHpKUinSmRN8o/Y+5A
 Sr5cw7hj+j1ECnldv88ApTThQHW7fg9gqMw57UuoZ4h63BN5cFSBWgX6Q
 51nJrgOpP7Lo8SiLiD2HVO2f2w/NZnoh+yhKnHpoFKj6FPJdS1WzwfaKr g==;
X-CSE-ConnectionGUID: UW7oPMzURXGCS4KeKWLDcw==
X-CSE-MsgGUID: rGW4pesFS0eec4FHR0i27g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867930"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867930"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: gh0rhi6WSIaXBCLUVWbHxA==
X-CSE-MsgGUID: 9TD7WS2nRlOEZAGnRL4SHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611456"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Date: Tue, 10 Mar 2026 19:50:51 -0700
Message-ID: <20260311025340.1335673-10-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make the error handling more robust in virtio_gpu_init_udmabuf()
by introducing 'Error **' parameter to capture errors and using
an enum from VFIO to categorize different errors. This allows for
better error reporting and handling of errors from
virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 67 +++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 8d67ef7c2a..eddf398a43 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -18,6 +18,7 @@
 #include "ui/console.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
+#include "hw/vfio/vfio-device.h"
 #include "trace.h"
 #include "system/ramblock.h"
 #include "system/hostmem.h"
@@ -27,16 +28,18 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
-static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
+static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
+                                     Error **errp)
 {
     g_autofree struct udmabuf_create_list *list = NULL;
     RAMBlock *rb;
     ram_addr_t offset;
-    int udmabuf, i;
+    int udmabuf, i, fd;
 
     udmabuf = udmabuf_fd();
     if (udmabuf < 0) {
-        return;
+        error_setg(errp, "udmabuf device not available or enabled");
+        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
     }
 
     list = g_malloc0(sizeof(struct udmabuf_create_list) +
@@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     for (i = 0; i < res->iov_cnt; i++) {
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
         if (!rb || rb->fd < 0) {
-            return;
+            error_setg(errp, "IOV memory address incompatible with udmabuf ");
+            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
         }
 
         list->list[i].memfd  = rb->fd;
@@ -56,22 +60,28 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     list->count = res->iov_cnt;
     list->flags = UDMABUF_FLAGS_CLOEXEC;
 
-    res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
-    if (res->dmabuf_fd < 0) {
-        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
-                    strerror(errno));
+    fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl failed");
+        if (errno == EINVAL || errno == EBADFD) {
+            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+        }
+        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
     }
+    return fd;
 }
 
-static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
+static void *virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
+                                     Error **errp)
 {
-    res->remapped = mmap(NULL, res->blob_size, PROT_READ,
-                         MAP_SHARED, res->dmabuf_fd, 0);
-    if (res->remapped == MAP_FAILED) {
-        warn_report("%s: dmabuf mmap failed: %s", __func__,
-                    strerror(errno));
-        res->remapped = NULL;
+    void *map;
+
+    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
+    if (map == MAP_FAILED) {
+        error_setg_errno(errp, errno, "dmabuf mmap failed");
+        return NULL;
     }
+    return map;
 }
 
 static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
@@ -125,22 +135,35 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
+    Error *local_err = NULL;
     void *pdata = NULL;
 
-    res->dmabuf_fd = -1;
     if (res->iov_cnt == 1 &&
         res->iov[0].iov_len < 4096) {
+        res->dmabuf_fd = -1;
         pdata = res->iov[0].iov_base;
     } else {
-        virtio_gpu_create_udmabuf(res);
+        res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
+        if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+            error_free_or_abort(&local_err);
+
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Cannot create dmabuf: incompatible memory\n");
+            return;
+        } else if (res->dmabuf_fd >= 0) {
+            pdata = virtio_gpu_remap_dmabuf(res, &local_err);
+            if (!pdata) {
+                virtio_gpu_destroy_dmabuf(res);
+            }
+        } else {
+            res->dmabuf_fd = -1;
+        }
+
         if (res->dmabuf_fd < 0) {
+            error_report_err(local_err);
             return;
         }
-        virtio_gpu_remap_dmabuf(res);
-        if (!res->remapped) {
-            return;
-        }
-        pdata = res->remapped;
+        res->remapped = pdata;
     }
 
     res->blob = pdata;
-- 
2.53.0


