Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75683E98DFC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQvm-0002x4-Py; Mon, 23 Feb 2026 03:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvk-0002vZ-08
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:36 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvi-0004Ki-6o
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771833874; x=1803369874;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rEN7gJG69z1iHbkpzNoQlYFgF+PtYJCFEZUSWY1s9U8=;
 b=ZH1Nr39GwCsXgEr9piKwwUSIly4gNwVpAH9oVBEjnlivZTtSA+Oa9tps
 dswrivRa7xwEnm+MznQvyNeCOzxQUAJuAFi6kYXvN9YvGka6/iVLEjUGz
 SLdXbed+R/61Y1+n68Nt5rnd6g9pXDRcQ7CBb21WJh2yp2iqUfgfux32Q
 5Ohp8JIKr+B7vwC1tTxVjbywojMJ/J+Vr9RKgl8swidEVRwN1S1lf4gSc
 3uk/0hv8z76bIFGccPXvCZ3p96D8Yk2jJAWxQvMKSTO7upDT3wfUNmdHk
 MbuAHEEP27bNdH5wQlLafPmXbrwYeBeTV+qwOqaSniaKLlylpaPJ8tYBW Q==;
X-CSE-ConnectionGUID: w3UiYE+kQ2esYyx/NvZB1g==
X-CSE-MsgGUID: r2dLbhTAQSK5LVALz9V6Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72027131"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="72027131"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 00:04:23 -0800
X-CSE-ConnectionGUID: DwWQjd3WQB6tlN0cIrGAJQ==
X-CSE-MsgGUID: zLxSUqgHREmwbB/gLMWgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="246079170"
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
Subject: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Date: Mon, 23 Feb 2026 00:00:10 -0800
Message-ID: <20260223080200.468558-7-vivek.kasireddy@intel.com>
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

Make the error handling more robust in virtio_gpu_init_udmabuf()
by introducing 'Error **' parameter to capture errors and an enum
to categorize Guest and Host errors. This allows for better error
reporting and handling of errors from virtio_gpu_create_udmabuf()
and virtio_gpu_remap_dmabuf().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 65 +++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 8d67ef7c2a..fdcf8e53a2 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -27,7 +27,17 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
-static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
+typedef enum VirtIOGPUErrorType {
+    VIRTIO_GPU_NO_ERROR = 0,
+    /* Guest is responsible for this error */
+    VIRTIO_GPU_GUEST_ERROR = 1,
+    /* Host is at fault for this error */
+    VIRTIO_GPU_HOST_ERROR = 2,
+} VirtIOGPUErrorType;
+
+static VirtIOGPUErrorType
+virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res, int *fd,
+                          Error **errp)
 {
     g_autofree struct udmabuf_create_list *list = NULL;
     RAMBlock *rb;
@@ -36,7 +46,8 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 
     udmabuf = udmabuf_fd();
     if (udmabuf < 0) {
-        return;
+        error_setg(errp, "udmabuf device not available");
+        return VIRTIO_GPU_HOST_ERROR;
     }
 
     list = g_malloc0(sizeof(struct udmabuf_create_list) +
@@ -45,7 +56,8 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     for (i = 0; i < res->iov_cnt; i++) {
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
         if (!rb || rb->fd < 0) {
-            return;
+            error_setg(errp, "Could not find valid ramblock");
+            return VIRTIO_GPU_GUEST_ERROR;
         }
 
         list->list[i].memfd  = rb->fd;
@@ -56,22 +68,30 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     list->count = res->iov_cnt;
     list->flags = UDMABUF_FLAGS_CLOEXEC;
 
-    res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
-    if (res->dmabuf_fd < 0) {
-        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
-                    strerror(errno));
+    *fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
+    if (*fd < 0) {
+        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl failed");
+        if (errno == EINVAL || errno == EBADFD) {
+            return VIRTIO_GPU_GUEST_ERROR;
+        }
+        return VIRTIO_GPU_HOST_ERROR;
     }
+    return VIRTIO_GPU_NO_ERROR;
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
@@ -125,19 +145,30 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
+    Error *local_err = NULL;
+    VirtIOGPUErrorType err;
     void *pdata = NULL;
+    int fd;
 
     res->dmabuf_fd = -1;
     if (res->iov_cnt == 1 &&
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else {
-        virtio_gpu_create_udmabuf(res);
-        if (res->dmabuf_fd < 0) {
+        err = virtio_gpu_create_udmabuf(res, &fd, &local_err);
+        if (err != VIRTIO_GPU_NO_ERROR) {
+            error_prepend(&local_err, "Cannot create dmabuf: ");
+            if (err == VIRTIO_GPU_GUEST_ERROR) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Cannot create dmabuf: incompatible mem\n");
+            }
+            error_report_err(local_err);
             return;
         }
-        virtio_gpu_remap_dmabuf(res);
-        if (!res->remapped) {
+
+        res->dmabuf_fd = fd;
+        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
+            error_report_err(local_err);
             return;
         }
         pdata = res->remapped;
-- 
2.53.0


