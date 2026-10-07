Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E94CA6004
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEY26-0004dH-IQ; Wed, 07 Oct 2026 16:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1b-0004aC-An
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:03 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1Z-0002B7-34
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791404041; x=1822940041;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j5Y5Ol7gneFTBsVCADr0uA3bbbqU8zNP6j9n0Cubp4M=;
 b=D56R4wlnzW3gVT79Fd1hQqur15a13NHOfgQ3PnVbmKfJJowNps0JHVKZ
 GstDkdDzaceWXS/i9FxCTM6iW2dfaJCrL1fa5tU312p5i2ew0CI1SM5fo
 ilCUl1nyglJXumcBEQmsZVIXXiMGR888/E9UvqKSPZls+r6Qb9wl6cs6N
 LC58I0IKZ2qe0YUR3H7CH1Uqnnyc1DrLqDosoobiQOkBh+Jj1Vry5S2yI
 yfQBOJ48FGQA422iMwpPYHBwciR0uXb+GeKcu2zj7A4c4hZRmwGOZpUbJ
 q0ge5D7ea0hOt6prhPzoIjxRBA2sJbreoOSohIImYRvZhWDyH14XpTVFf w==;
X-CSE-ConnectionGUID: VxdSNqJbTuWUBeCVSbgyig==
X-CSE-MsgGUID: 2JyNYqdVT96sR0itdLULww==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="178489"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="178489"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:49 -0700
X-CSE-ConnectionGUID: mVA8jQE/S+CDjml634+J1Q==
X-CSE-MsgGUID: NRnJrLvhQ4SLEFQ1BQdxaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1564974"
Received: from vkasired-desk1.fm.intel.com ([10.121.64.242])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:47 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v13 8/9] virtio-gpu-dmabuf: Improve error handling with 'Error
 **' and err enum
Date: Wed,  7 Oct 2026 13:09:27 -0700
Message-ID: <20261007201222.648687-9-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007201222.648687-1-vivek.kasireddy@intel.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Furtheremore, the main reason for using the VFIO enum is to handle
the special INVALID_IOV case which can happen in two scenarios:
1) When the Blob resource's memory is backed by a VFIO region. This
   would cause INVALID_IOV error when we try to create a dmabuf via
   udmabuf driver but we can recover from this error by having the
   dmabuf be created by the VFIO driver instead.
2) When the Blob resource's memory is not backed by memfd or VFIO
   region. In this case, since the error can be attributed to the
   guest, we should use qemu_log_mask() instead of error_report_err()
   and emit a message that can be used to debug the guest error.

Note that, to diagnose errors, a common pattern is to return -errno
to enable the caller to implement specific error handling. However, in
this case, since we want to distinguish the INVALID_IOV error from other
errors, using the VFIO enum allows us to do so and is very convenient.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 69 ++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 6f05f367d0..c9de8e9ba3 100644
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
@@ -27,28 +28,32 @@
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
 
     list = g_try_malloc0(sizeof(struct udmabuf_create_list) +
                          sizeof(struct udmabuf_create_item) * res->iov_cnt);
     if (!list) {
-        return;
+        error_setg(errp, "failed to allocate udmabuf create list");
+        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
     }
 
     for (i = 0; i < res->iov_cnt; i++) {
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
         if (!rb || rb->fd < 0) {
-            return;
+            error_setg(errp, "IOV memory address incompatible with udmabuf ");
+            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
         }
 
         list->list[i].memfd  = rb->fd;
@@ -59,22 +64,28 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
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
 
 void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
@@ -130,6 +141,7 @@ bool virtio_gpu_have_udmabuf(void)
 
 bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
+    Error *local_err = NULL;
     void *pdata = NULL;
 
     res->dmabuf_fd = -1;
@@ -137,17 +149,28 @@ bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else if (res->blob_size) {
-        virtio_gpu_create_udmabuf(res);
+        res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
+        if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+            error_free_or_abort(&local_err);
+
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Cannot create dmabuf: incompatible memory\n");
+            return false;
+        } else if (res->dmabuf_fd >= 0) {
+            pdata = virtio_gpu_remap_dmabuf(res, &local_err);
+            if (!pdata) {
+                virtio_gpu_fini_dmabuf(res);
+            }
+        } else {
+            res->dmabuf_fd = -1;
+        }
+
         if (res->dmabuf_fd < 0) {
-            return false;
-        }
-        virtio_gpu_remap_dmabuf(res);
-        if (!res->remapped) {
-            virtio_gpu_fini_dmabuf(res);
+            error_report_err(local_err);
             return false;
         }
         res->share_handle = res->dmabuf_fd;
-        pdata = res->remapped;
+        res->remapped = pdata;
     }
 
     res->blob = pdata;
-- 
2.53.0


