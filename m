Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A722B104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Bl-00067k-JJ; Fri, 27 Feb 2026 17:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vw6Bh-00067B-NR
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:19:57 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vw6Bf-0007m5-6R
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772230795; x=1803766795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tvGLLWt/KVjrGwxv7KBoBI5nAuzCFdI/ypVr4mmfOqY=;
 b=dr2iPaaZRU2W5pTHBoUViAGuVoAf+HwS25WAxNeV5iQCL6GwIbymAAgQ
 1kAt8+qvSg8lYZw66vEywuJdXBVITmL26rmEGKFSj95xZSL83wCfMWSOU
 JpX9vfm5KrsO4aV/DPxSGK2cIY5PFn5AIysa0NIAhxBmd6VvTVFFW/JsP
 YdDbk5i1J77tEnD+Fx0yYFbwnRsSHoAuAvbKxXfZLIJilf8TbuptAYDQD
 ZjIehxtAovu/hvgQnnL5ep2oTK0MrqgVWyTSEAvnrHka0IPw0fWEGOkvV
 c+ZGPTn9WF7iD6ohVnKMzqF9FQW8M+BcDwvwRRorNwY6TnOQNUHdT8AyI g==;
X-CSE-ConnectionGUID: wvGPkJOQSyihfrJXenM9bg==
X-CSE-MsgGUID: UHp+2VrbSTSfwD71sjBwzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73509368"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="73509368"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 14:19:41 -0800
X-CSE-ConnectionGUID: SjVVzUI4TCmCae/aCs3JMQ==
X-CSE-MsgGUID: NXkHtFmwSh6Gve+hqZlFmw==
X-ExtLoop1: 1
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 14:19:40 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Date: Fri, 27 Feb 2026 14:13:55 -0800
Message-ID: <20260227221632.827046-10-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227221632.827046-1-vivek.kasireddy@intel.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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
by introducing 'Error **' parameter to capture errors and using an
enum from VFIO to categorize Guest and Host errors. This allows
for better error reporting and handling of errors from
virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 61 ++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 8d67ef7c2a..b2badfc1bd 100644
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
+        return VFIO_DMABUF_CREATE_HOST_ERROR;
     }
 
     list = g_malloc0(sizeof(struct udmabuf_create_list) +
@@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     for (i = 0; i < res->iov_cnt; i++) {
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
         if (!rb || rb->fd < 0) {
-            return;
+            error_setg(errp, "IOV memory address incompatible with udmabuf ");
+            return VFIO_DMABUF_CREATE_GUEST_ERROR;
         }
 
         list->list[i].memfd  = rb->fd;
@@ -56,22 +60,30 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
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
+            return VFIO_DMABUF_CREATE_GUEST_ERROR;
+        }
+        return VFIO_DMABUF_CREATE_HOST_ERROR;
     }
+    return fd;
 }
 
-static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
+static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
+                                    Error **errp)
 {
-    res->remapped = mmap(NULL, res->blob_size, PROT_READ,
-                         MAP_SHARED, res->dmabuf_fd, 0);
-    if (res->remapped == MAP_FAILED) {
-        warn_report("%s: dmabuf mmap failed: %s", __func__,
-                    strerror(errno));
+    void *map;
+
+    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
+    if (map == MAP_FAILED) {
+        error_setg_errno(errp, errno, "dmabuf mmap failed");
         res->remapped = NULL;
+        return false;
     }
+    res->remapped = map;
+    return true;
 }
 
 static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
@@ -125,19 +137,32 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
+    Error *local_err = NULL;
     void *pdata = NULL;
+    int ret;
 
     res->dmabuf_fd = -1;
     if (res->iov_cnt == 1 &&
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else {
-        virtio_gpu_create_udmabuf(res);
-        if (res->dmabuf_fd < 0) {
+        ret = virtio_gpu_create_udmabuf(res, &local_err);
+        if (ret < 0) {
+            error_prepend(&local_err, "Cannot create dmabuf: ");
+
+            if (ret == VFIO_DMABUF_CREATE_GUEST_ERROR) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Cannot create dmabuf: incompatible memory\n");
+                error_free(local_err);
+                return;
+            }
+            error_report_err(local_err);
             return;
         }
-        virtio_gpu_remap_dmabuf(res);
-        if (!res->remapped) {
+
+        res->dmabuf_fd = ret;
+        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
+            error_report_err(local_err);
             return;
         }
         pdata = res->remapped;
-- 
2.53.0


