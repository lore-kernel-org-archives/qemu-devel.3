Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87B0E98DFC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQw9-000349-8Y; Mon, 23 Feb 2026 03:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvw-0002z8-L3
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:49 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvu-0004Ki-9f
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771833886; x=1803369886;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zk6C2IUz7ZHX3FMtWcsagAH5rq1uf/P/063Si/p1gHc=;
 b=WQpD0FVW1+UJblJNDjaJWeF5ySPqpetWEaxkOt2TUbnTjtq+4xP5r+D1
 RyFHjCbfMYLD8G5sVZ2XLg6s8XmCDNh1DAhbdu/SrzNNMr4fKkK7/oopY
 p3wjKfXIp2Q8k2nF+Fv45uB7jvrpmyUz8nIPomjr7a6rGowh2b8GhW3Wc
 ttJRQ+oBuHI2USmP/UaArLoE7BZefiTjdF3iiCwFxQnI6dhxlKE+f9MrF
 zDALNvgjLoC/iDUU885r75Hgd9Og+Z5jcacN5uOlZgXpHhH0kypWdj2R3
 94T36cPxO1YJHiCAx8vu0qRcdXT+/aNuQDKAldoPvLBXmFfzzmYoXP4eW A==;
X-CSE-ConnectionGUID: 42ZDeAX7Rw+jDrmF0pw/AQ==
X-CSE-MsgGUID: n4gx5CQuTIu6adU3VfMgfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72027147"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="72027147"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 00:04:23 -0800
X-CSE-ConnectionGUID: uGtcMhhyTwKvkcGDH2ZeDQ==
X-CSE-MsgGUID: tTpSS3ZhRCmbqq5+cJOE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="246079187"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 00:04:23 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Date: Mon, 23 Feb 2026 00:00:14 -0800
Message-ID: <20260223080200.468558-11-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223080200.468558-1-vivek.kasireddy@intel.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_NONE=0.001,
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
 hw/display/meson.build         |  1 +
 hw/display/vfio-dmabuf-stubs.c | 23 +++++++++++++++++++++++
 hw/display/virtio-gpu-dmabuf.c | 32 ++++++++++++++++++++++++--------
 3 files changed, 48 insertions(+), 8 deletions(-)
 create mode 100644 hw/display/vfio-dmabuf-stubs.c

diff --git a/hw/display/meson.build b/hw/display/meson.build
index f5f92b1068..7d2bd839cc 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -70,6 +70,7 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
                     if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c'), pixman])
   if host_os == 'linux'
     virtio_gpu_ss.add(files('virtio-gpu-dmabuf.c'))
+    virtio_gpu_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-dmabuf-stubs.c'))
   else
     virtio_gpu_ss.add(files('virtio-gpu-dmabuf-stubs.c'))
   endif
diff --git a/hw/display/vfio-dmabuf-stubs.c b/hw/display/vfio-dmabuf-stubs.c
new file mode 100644
index 0000000000..12f016f0c5
--- /dev/null
+++ b/hw/display/vfio-dmabuf-stubs.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2026 Intel and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/iov.h"
+
+bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                               int *fd, Error **errp)
+{
+    error_setg(errp, "VFIO dmabuf support is not enabled");
+    return false;
+}
+
+bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                             void **addr, size_t total_size, Error **errp)
+{
+    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
+    return false;
+}
diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index fdcf8e53a2..3f39371de1 100644
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
@@ -82,13 +83,21 @@ virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res, int *fd,
 static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
                                     Error **errp)
 {
+    Error *mmap_err = NULL;
     void *map;
 
     map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
     if (map == MAP_FAILED) {
-        error_setg_errno(errp, errno, "dmabuf mmap failed");
+        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed: ");
         res->remapped = NULL;
-        return false;
+
+        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
+                                     res->blob_size, errp)) {
+            error_report_err(mmap_err);
+            return false;
+        }
+        error_free(mmap_err);
+        mmap_err = NULL;
     }
     res->remapped = map;
     return true;
@@ -145,7 +154,7 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
-    Error *local_err = NULL;
+    Error *local_err = NULL, *vfio_err = NULL;
     VirtIOGPUErrorType err;
     void *pdata = NULL;
     int fd;
@@ -158,12 +167,19 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         err = virtio_gpu_create_udmabuf(res, &fd, &local_err);
         if (err != VIRTIO_GPU_NO_ERROR) {
             error_prepend(&local_err, "Cannot create dmabuf: ");
-            if (err == VIRTIO_GPU_GUEST_ERROR) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "Cannot create dmabuf: incompatible mem\n");
+
+            if (!vfio_device_create_dmabuf(res->iov, res->iov_cnt, &fd,
+                                           &vfio_err)) {
+                if (err == VIRTIO_GPU_GUEST_ERROR) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "Cannot create dmabuf: incompatible mem\n");
+                }
+                error_report_err(local_err);
+                error_report_err(vfio_err);
+                return;
             }
-            error_report_err(local_err);
-            return;
+            error_free(local_err);
+            local_err = NULL;
         }
 
         res->dmabuf_fd = fd;
-- 
2.53.0


