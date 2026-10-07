Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA00CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEY1Z-0004Za-8P; Wed, 07 Oct 2026 16:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1W-0004Ye-GO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:13:58 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1U-0002B7-Dc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791404037; x=1822940037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rwyE6cR6hgEBINtf7YjYhXPvHcIR4ULy5pnzxbrkrzE=;
 b=WIRPFHeFE6Eav+zgokbAZhh0ohUKffslqL4lfFPewJnk4xFP5jec7XuT
 O+2xefERJheiPyQL2P05+mOK6873M7uxquOr/YvBSPR9a5LsokJKa1mon
 8/TRWofyE2+brBLt5nVn3uKJBY8gWpNmi/0sKRSnU+swdxslPo6V8z+BK
 QQ1GeA1w7pC8RNRvg//g4cI3kXDYZDeWW9WJH9ZQ1L/uzOnBcYSeDm+fo
 B84scuWL02D2yuEtyW1lW97x87zD/H8F1G8bzqxom5nDH4snW83Otj2Na
 xu5o/w+K8VGT6YDxxKBvZrrAZ/Oww6xSftpc2hRfpZigcHbGwSsdBep5R A==;
X-CSE-ConnectionGUID: XSJ9EPm6Q4q44gVMvFBGRg==
X-CSE-MsgGUID: QEPDyHTaTWCunO787NJibQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="178462"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="178462"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:48 -0700
X-CSE-ConnectionGUID: 66DRKZLGQvihknpMiOEeFg==
X-CSE-MsgGUID: XjdN4wjqRS6TQHAQN9EF/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1564955"
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
Subject: [PATCH v13 2/9] virtio-gpu: Rename udmabuf files and helpers to dmabuf
Date: Wed,  7 Oct 2026 13:09:21 -0700
Message-ID: <20261007201222.648687-3-vivek.kasireddy@intel.com>
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

This is prep-work for adding the ability to create dmabuf fds from
VFIO devices in addition to udmabuf.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/hw/virtio/virtio-gpu.h                         |  6 +++---
 ...o-gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} |  4 ++--
 .../{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c}      | 10 +++++-----
 hw/display/virtio-gpu.c                                |  8 ++++----
 hw/display/meson.build                                 |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)
 rename hw/display/{virtio-gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} (79%)
 rename hw/display/{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} (94%)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 631dfc63a4..4f3a5c6fb3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -388,10 +388,10 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    struct virtio_gpu_set_scanout_blob *ss,
                                    uint64_t blob_size);
 
-/* virtio-gpu-udmabuf.c */
+/* virtio-gpu-dmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
-bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
+bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res);
+void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res);
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              uint32_t scanout_id,
                              struct virtio_gpu_simple_resource *res,
diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gpu-dmabuf-stubs.c
similarity index 79%
rename from hw/display/virtio-gpu-udmabuf-stubs.c
rename to hw/display/virtio-gpu-dmabuf-stubs.c
index 1a9dfbdec1..83c3e16c23 100644
--- a/hw/display/virtio-gpu-udmabuf-stubs.c
+++ b/hw/display/virtio-gpu-dmabuf-stubs.c
@@ -7,13 +7,13 @@ bool virtio_gpu_have_udmabuf(void)
     return false;
 }
 
-bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
+bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
     return false;
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
 }
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-dmabuf.c
similarity index 94%
rename from hw/display/virtio-gpu-udmabuf.c
rename to hw/display/virtio-gpu-dmabuf.c
index 6d2bc8d977..c537ec0a8c 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -71,7 +71,7 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     g_free(list);
 }
 
-static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
+static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     res->remapped = mmap(NULL, res->blob_size, PROT_READ,
                          MAP_SHARED, res->dmabuf_fd, 0);
@@ -82,7 +82,7 @@ static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
     }
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     if (res->remapped) {
         munmap(res->remapped, res->blob_size);
@@ -133,7 +133,7 @@ bool virtio_gpu_have_udmabuf(void)
     return memfd_backend;
 }
 
-bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
+bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     void *pdata = NULL;
 
@@ -146,9 +146,9 @@ bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         if (res->dmabuf_fd < 0) {
             return false;
         }
-        virtio_gpu_remap_udmabuf(res);
+        virtio_gpu_remap_dmabuf(res);
         if (!res->remapped) {
-            virtio_gpu_fini_udmabuf(res);
+            virtio_gpu_fini_dmabuf(res);
             return false;
         }
         res->share_handle = res->dmabuf_fd;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 386db05e5b..c7346c8c68 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -407,7 +407,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
             return;
         }
 
-        if (!virtio_gpu_init_udmabuf(res)) {
+        if (!virtio_gpu_init_dmabuf(res)) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             virtio_gpu_cleanup_mapping(g, res);
             g_free(res);
@@ -1091,7 +1091,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     res->addrs = NULL;
 
     if (res->blob) {
-        virtio_gpu_fini_udmabuf(res);
+        virtio_gpu_fini_dmabuf(res);
     }
 }
 
@@ -1136,7 +1136,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         return;
     }
 
-    if (!res->image && !virtio_gpu_init_udmabuf(res)) {
+    if (!res->image && !virtio_gpu_init_dmabuf(res)) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         virtio_gpu_cleanup_mapping(g, res);
     }
@@ -1652,7 +1652,7 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
                 return -EINVAL;
             }
 
-            if (!virtio_gpu_init_udmabuf(res)) {
+            if (!virtio_gpu_init_dmabuf(res)) {
                 virtio_gpu_cleanup_mapping(g, res);
                 g_free(res);
                 return -EINVAL;
diff --git a/hw/display/meson.build b/hw/display/meson.build
index d8b4e121fe..89b8f74b7d 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -73,9 +73,9 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
                     if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c'), pixman])
   if host_os == 'linux'
-    virtio_gpu_ss.add(files('virtio-gpu-udmabuf.c'))
+    virtio_gpu_ss.add(files('virtio-gpu-dmabuf.c'))
   else
-    virtio_gpu_ss.add(files('virtio-gpu-udmabuf-stubs.c'))
+    virtio_gpu_ss.add(files('virtio-gpu-dmabuf-stubs.c'))
   endif
   virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
   hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
-- 
2.53.0


