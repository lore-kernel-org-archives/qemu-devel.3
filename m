Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA277E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAu7-0007Oz-9S; Tue, 03 Feb 2026 02:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAty-0007Bl-HL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:46 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAtv-0006Ca-Ig
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770103963; x=1801639963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3QOpse0X65ajxJkuQD2k8UwfOB3vdSSNPt3BSqLJ1b0=;
 b=Wp4HkCApqwAhn4B0dMYwqeCLgw2RP7SIivQcX9kwcqxsHe7hxo6P1XuF
 X/+fqqe/JPOZboh/z6Jwuh9BAMvra9KDhHbYxwdyRqmmrxI7Sds0DDMGH
 Pve4VpYLDF0M3MjRkZAHgvGJfS0t7Q0DUKWoN4pUnIwCSKXlN/D6QUbG0
 EkJzFIkYw5l+OIlP9P4XiOV46JyV3RRjOd6/gFFOhyVCx3UGkkznM2JN0
 uhuMDyGTROTyNBLcScnM3EPO922Fe7S3GkiaJlmHTOxVivcGvvYx0tcR4
 1yc2lh/fEq1XHjDWGuBxo9u5acebtnTcfcjCr5RFMOZkNJrODfGxqJV5B w==;
X-CSE-ConnectionGUID: NYG6epV0TBGSIECSGJzOWg==
X-CSE-MsgGUID: FgXNNAwOQw6o9hyQDN6yZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82640907"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82640907"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:36 -0800
X-CSE-ConnectionGUID: T9VWdQBQQ1q5Dg22gF1mxA==
X-CSE-MsgGUID: STQlY0VdRgajbNp9JdSAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247373102"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:36 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 06/12] virtio-gpu-dmabuf: Improve error handling by
 introducing 'Error **'
Date: Mon,  2 Feb 2026 23:30:13 -0800
Message-ID: <20260203073200.848183-7-vivek.kasireddy@intel.com>
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

Make the error handling more robust in virtio_gpu_init_udmabuf()
by passing in 'Error **' parameter to capture errors from
virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
And, since they now take in 'Error **' parameter, have them
return a bool to adhere to best practices.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 44 ++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 8d67ef7c2a..22e66fbb12 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -27,7 +27,8 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
-static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
+static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
+                                      Error **errp)
 {
     g_autofree struct udmabuf_create_list *list = NULL;
     RAMBlock *rb;
@@ -36,7 +37,8 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 
     udmabuf = udmabuf_fd();
     if (udmabuf < 0) {
-        return;
+        error_setg(errp, "udmabuf device not available");
+        return false;
     }
 
     list = g_malloc0(sizeof(struct udmabuf_create_list) +
@@ -45,7 +47,11 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     for (i = 0; i < res->iov_cnt; i++) {
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
         if (!rb || rb->fd < 0) {
-            return;
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Could not find valid ramblock\n",
+                          __func__);
+            error_setg(errp, "Could not find ramblock for dmabuf segment");
+            return false;
         }
 
         list->list[i].memfd  = rb->fd;
@@ -58,20 +64,26 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 
     res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
     if (res->dmabuf_fd < 0) {
-        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
-                    strerror(errno));
+        error_setg_errno(errp, -res->dmabuf_fd,
+                         "Could not create dmabuf fd via udmabuf driver");
+        return false;
     }
+    return true;
 }
 
-static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
+static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
+                                    Error **err1)
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
+        error_setg_errno(err1, errno, "dmabuf mmap failed");
         res->remapped = NULL;
+        return false;
     }
+    res->remapped = map;
+    return true;
 }
 
 static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
@@ -125,6 +137,7 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
+    Error *err1 = NULL;
     void *pdata = NULL;
 
     res->dmabuf_fd = -1;
@@ -132,12 +145,13 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else {
-        virtio_gpu_create_udmabuf(res);
-        if (res->dmabuf_fd < 0) {
+        if (!virtio_gpu_create_udmabuf(res, &err1)) {
+            error_report_err(err1);
             return;
         }
-        virtio_gpu_remap_dmabuf(res);
-        if (!res->remapped) {
+
+        if (!virtio_gpu_remap_dmabuf(res, &err1)) {
+            error_report_err(err1);
             return;
         }
         pdata = res->remapped;
-- 
2.50.1


