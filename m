Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422D3FD88E3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09kZ-0000RK-Io; Tue, 10 Mar 2026 22:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kY-0000Qt-61
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:42 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kV-000630-MT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197799; x=1804733799;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WQUubMglOINXkPd3puxed1kwRdXppIaQlkqgg//+It0=;
 b=HJumR9HqAlaf45aAl6n6a8Hibkp4YQ4H8MeSg14xMAavRvHRJWSWOCzP
 SwhCTUYhbnW0Hnyr1K4t7dVVbkv0KqfIrc8xI+3dSLDVL+RpijaPjp1+r
 5ju/AaowZ31aLGla8+bFCs1Vf44Vbxt5/xI4eDIHexHvqDM4tzfAp+Y4F
 6iJQLaI03uNebT7gcjZrfU5XwGIqz0jLjpNk+9Q9bgjyzaP565WSm1HwN
 GGmGgAi6pT4q/8Lm1tgEpcAxigH3NarMv8SIOKcMf4HoosPLvUZdSARFd
 hQ835LzqFCEH2dU+JwSwWHPw6W0ZdNF5xOihA+u5T5AgB9jwF9WJgslxK A==;
X-CSE-ConnectionGUID: 9MkbH/lDTgOytktbfoHjsw==
X-CSE-MsgGUID: pcaSm6YXRHSGl/uCADCBwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867898"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867898"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: E7LQScw+Q7eekdv/AAviKw==
X-CSE-MsgGUID: ayg8DtKCTiu9xnVRPSR80g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611438"
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
Subject: [PATCH v11 03/10] virtio-gpu: Rename udmabuf files and helpers to
 dmabuf
Date: Tue, 10 Mar 2026 19:50:45 -0700
Message-ID: <20260311025340.1335673-4-vivek.kasireddy@intel.com>
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
 hw/display/meson.build                               |  4 ++--
 ...gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} |  4 ++--
 .../{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c}    | 12 ++++++------
 hw/display/virtio-gpu.c                              |  8 ++++----
 include/hw/virtio/virtio-gpu.h                       |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)
 rename hw/display/{virtio-gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} (79%)
 rename hw/display/{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} (94%)

diff --git a/hw/display/meson.build b/hw/display/meson.build
index 90e6c041bd..f5f92b1068 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -69,9 +69,9 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
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
diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gpu-dmabuf-stubs.c
similarity index 79%
rename from hw/display/virtio-gpu-udmabuf-stubs.c
rename to hw/display/virtio-gpu-dmabuf-stubs.c
index f692e13510..01067e246d 100644
--- a/hw/display/virtio-gpu-udmabuf-stubs.c
+++ b/hw/display/virtio-gpu-dmabuf-stubs.c
@@ -7,12 +7,12 @@ bool virtio_gpu_have_udmabuf(void)
     return false;
 }
 
-void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
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
index d804f321aa..c34d4c85bc 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -68,7 +68,7 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     g_free(list);
 }
 
-static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
+static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     res->remapped = mmap(NULL, res->blob_size, PROT_READ,
                          MAP_SHARED, res->dmabuf_fd, 0);
@@ -79,7 +79,7 @@ static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
     }
 }
 
-static void virtio_gpu_destroy_udmabuf(struct virtio_gpu_simple_resource *res)
+static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     if (res->remapped) {
         munmap(res->remapped, res->blob_size);
@@ -128,7 +128,7 @@ bool virtio_gpu_have_udmabuf(void)
     return memfd_backend;
 }
 
-void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     void *pdata = NULL;
 
@@ -141,7 +141,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         if (res->dmabuf_fd < 0) {
             return;
         }
-        virtio_gpu_remap_udmabuf(res);
+        virtio_gpu_remap_dmabuf(res);
         if (!res->remapped) {
             return;
         }
@@ -151,10 +151,10 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     res->blob = pdata;
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     if (res->remapped) {
-        virtio_gpu_destroy_udmabuf(res);
+        virtio_gpu_destroy_dmabuf(res);
     }
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f5c6a7deb9..72c7610664 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -360,7 +360,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
-    virtio_gpu_init_udmabuf(res);
+    virtio_gpu_init_dmabuf(res);
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
@@ -917,7 +917,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     res->addrs = NULL;
 
     if (res->blob) {
-        virtio_gpu_fini_udmabuf(res);
+        virtio_gpu_fini_dmabuf(res);
     }
 }
 
@@ -954,7 +954,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
     }
 
     if (res->blob_size) {
-        virtio_gpu_init_udmabuf(res);
+        virtio_gpu_init_dmabuf(res);
     }
 }
 
@@ -1440,7 +1440,7 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        virtio_gpu_init_udmabuf(res);
+        virtio_gpu_init_dmabuf(res);
 
         resource_id = qemu_get_be32(f);
     }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda..e3d351a2d4 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -354,10 +354,10 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    struct virtio_gpu_set_scanout_blob *ss,
                                    uint64_t blob_size);
 
-/* virtio-gpu-udmabuf.c */
+/* virtio-gpu-dmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
-void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
+void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res);
+void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res);
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              uint32_t scanout_id,
                              struct virtio_gpu_simple_resource *res,
-- 
2.53.0


