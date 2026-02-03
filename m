Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB0E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAuO-0007XV-TC; Tue, 03 Feb 2026 02:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAuF-0007VN-CD
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:33:03 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAuD-0006Ca-LQ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770103981; x=1801639981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e7JZ6ZB3ohVIX+KOOS5rF5ICP/rXhFYhCok9J8P+Sqk=;
 b=Th1rInGxOAugGJpDOxSq+7BvCE+0d5FXgobl2rkGoky1jZIx7xvoZzpY
 ZuEdZu2BnqhbFPADmga/w+GmkLd+FMhislSYcwYzSaxnv2JCLXQnKhi8r
 DC67QFu9o9hLOS63ba05+no+dRGPpUwYExqhRlMvA44nnDe4iwun72Xpy
 QfKCsqm0g5jMQHisWEcKHxYZX20eYWk7fnhFaszfug+ml0TXVEIxoMjAV
 IfE8PMC13Q6HYHNv5UjmQDDp4qCS10OIiH9qkH5meal0i6fSsZv3xotIk
 hOq1ZQTrvVM2dzfzPz5aAKmDHsRLMLy+tSVX0KXFkOWlNHPmdZPy04S9O A==;
X-CSE-ConnectionGUID: q7AN4ScISX27aNKWQZjr9A==
X-CSE-MsgGUID: AA4weTh4TYSUoGBeM46Yuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82640930"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82640930"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:37 -0800
X-CSE-ConnectionGUID: utPQdkOZQ02axPngGNgALA==
X-CSE-MsgGUID: Z5nMFG62TZS24OnKudrSog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247373123"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:38 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 12/12] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Date: Mon,  2 Feb 2026 23:30:19 -0800
Message-ID: <20260203073200.848183-13-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203073200.848183-1-vivek.kasireddy@intel.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In addition to memfd, a blob resource can also have its backing
storage in a VFIO device region. Since, there is no effective way
to determine where the backing storage is located, we first try to
create a dmabuf assuming it is in memfd. If that fails, we try to
create a dmabuf assuming it is in VFIO device region.

So, we first call virtio_gpu_create_udmabuf() to check if the blob's
backing storage is located in a memfd or not. If it is not, we invoke
the vfio_device_create_dmabuf() API which identifies the right VFIO
device and eventually creates a dmabuf fd.

Note that in virtio_gpu_remap_dmabuf(), we first try to test if
the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
fall back to the vfio_device_mmap_dmabuf() API to get a mapping
created for the dmabuf.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/Kconfig             |  5 ++++
 hw/display/virtio-gpu-dmabuf.c | 49 ++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1e95ab28ef..0d090f25f5 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -106,6 +106,11 @@ config VIRTIO_VGA
     depends on VIRTIO_PCI
     select VGA
 
+config VIRTIO_GPU_VFIO_BLOB
+    bool
+    default y
+    depends on VFIO
+
 config VHOST_USER_GPU
     bool
     default y
diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 22e66fbb12..2e65f21dda 100644
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
@@ -27,6 +28,23 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
+static bool virtio_gpu_create_vfio_dmabuf(struct virtio_gpu_simple_resource *r,
+                                          Error **errp)
+{
+    bool ret = false;
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+    int fd;
+
+    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd, errp)) {
+        return false;
+    }
+
+    ret = true;
+    r->dmabuf_fd = fd;
+#endif
+    return ret;
+}
+
 static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
                                       Error **errp)
 {
@@ -72,18 +90,25 @@ static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
 }
 
 static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
-                                    Error **err1)
+                                    Error **err1, Error **err2)
 {
+    bool ret = true;
     void *map;
 
     map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
     if (map == MAP_FAILED) {
         error_setg_errno(err1, errno, "dmabuf mmap failed");
-        res->remapped = NULL;
-        return false;
+        map = NULL;
+        ret = false;
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
+                                    res->blob_size, err2)) {
+            ret = true;
+        }
+#endif
     }
     res->remapped = map;
-    return true;
+    return ret;
 }
 
 static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
@@ -137,7 +162,7 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
-    Error *err1 = NULL;
+    Error *err1 = NULL, *err2 = NULL;
     void *pdata = NULL;
 
     res->dmabuf_fd = -1;
@@ -146,12 +171,16 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         pdata = res->iov[0].iov_base;
     } else {
         if (!virtio_gpu_create_udmabuf(res, &err1)) {
-            error_report_err(err1);
-            return;
+            if (!virtio_gpu_create_vfio_dmabuf(res, &err2)) {
+                error_report_err(err1);
+                error_report_err(err2);
+                return;
+            }
         }
 
-        if (!virtio_gpu_remap_dmabuf(res, &err1)) {
+        if (!virtio_gpu_remap_dmabuf(res, &err1, &err2)) {
             error_report_err(err1);
+            error_report_err(err2);
             return;
         }
         pdata = res->remapped;
@@ -162,9 +191,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 
 void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
 {
-    if (res->remapped) {
-        virtio_gpu_destroy_dmabuf(res);
-    }
+    virtio_gpu_destroy_dmabuf(res);
 }
 
 static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
-- 
2.50.1


