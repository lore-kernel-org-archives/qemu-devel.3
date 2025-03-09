Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF7C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 23:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPkY-0004C2-5X; Sun, 09 Mar 2025 19:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trPkR-0003xN-L4
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:07:59 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trPkN-0004mB-FO
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1741561657; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Noq99LLbY8sjBgf2jBtk6iNTPuVgD5DB8TXq6j42p/lJ38mWckzsj7iKL/wffzPTEB/qse1WpxZ9w8tBKs/rOvZYtGYPocsT+5Vo8KLtLd4gRRVewl33f4Q4CC6IPbZF+8+FTNtWcEuWa6KTpfeMHCWm5PdjXpoqTI8UTIxTIFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741561657;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZZ8pA77mG2Bcmmq1QNXVP01UocQs4raDQgL3oc4Dg9w=; 
 b=YsyZlbnzJtw+bZQ1rafwVQREUULoSEbczI9OyMFSrIxK+24honT4dUoPBYXeMn8UIdE8GPUvJK4fPBYYozGHKN3hAgHK1RhOXL3te5udPO2ZCRfrTHKyUDriD1rGtiEt6ezuasr1ZG4slxJF+LPRaQgL29xBV0Yc2QYrHaEH4p8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741561657; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ZZ8pA77mG2Bcmmq1QNXVP01UocQs4raDQgL3oc4Dg9w=;
 b=RUpjP6GraiJUTohfG+rickI3I4mfq+Y27sts1+jd1+BqRKTohNHYR4UWHLsFzKx+
 iY8vbVH0OPquGs0D/j+gZK5gX8u4/AnKZgOTMkmFoPSC8fv7K+S+CMNMj2IGPggxWbQ
 nRRVD7I8nfOv0+y6xoZjmL2nUJ9mJYBIFQoClmRA=
Received: by mx.zohomail.com with SMTPS id 1741561655064877.93523321005;
 Sun, 9 Mar 2025 16:07:35 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v9 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
Date: Mon, 10 Mar 2025 02:05:39 +0300
Message-ID: <20250309230539.125374-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309230539.125374-1-dmitry.osipenko@collabora.com>
References: <20250309230539.125374-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

This attempts to tidy up the VirtIO GPU documentation to make the list
of requirements clearer. There are still a lot of moving parts and the
distros have some catching up to do before this is all handled
automatically.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
[dmitry.osipenko@collabora.com: Extended and corrected doc]
---
 docs/system/devices/virtio-gpu.rst | 90 +++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index ea3eb052df3c..88c7b6011711 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -5,14 +5,28 @@ virtio-gpu
 ==========
 
 This document explains the setup and usage of the virtio-gpu device.
-The virtio-gpu device paravirtualizes the GPU and display controller.
+The virtio-gpu device provides a GPU and display controller
+paravirtualized using VirtIO. It supports a number of different modes
+from simple 2D displays to fully accelerated 3D graphics.
 
-Linux kernel support
---------------------
+Linux guest kernel support
+--------------------------
 
 virtio-gpu requires a guest Linux kernel built with the
 ``CONFIG_DRM_VIRTIO_GPU`` option.
 
+3D acceleration
+---------------
+
+3D acceleration of a virtualized GPU is still an evolving field.
+Depending on the 3D mode you are running you may need to override
+distribution supplied libraries with more recent versions or enable
+build options. There are a number of requirements the host must meet
+to be able to be able to support guests. QEMU must be able to access the
+host's GPU and for the best performance be able to reliably share GPU
+memory with the guest. Details of 3D acceleration requirements are
+described in a further sections.
+
 QEMU virtio-gpu variants
 ------------------------
 
@@ -65,8 +79,14 @@ intermediate representation is communicated to the host and the
 `virglrenderer`_ library on the host translates the intermediate
 representation back to OpenGL API calls.
 
+By default OpenGL version on guest is limited to 4.3. In order to enable
+OpenGL 4.6 support, virtio-gpu  host blobs feature (``hostmem`` and ``blob``
+fields) should be enabled.  The ``hostmem`` field specifies the size of
+virtio-gpu host memory window. This is typically between 256M and 8G.
+
 .. parsed-literal::
     -device virtio-gpu-gl
+    -device virtio-gpu-gl,hostmem=8G,blob=true
 
 .. _virgl: https://docs.mesa3d.org/drivers/virgl.html
 .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
@@ -94,6 +114,52 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
 
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel Version
+  * - OpenGL pass-through
+    - Any Linux version compatible with QEMU if not using host blobs feature,
+      Linux 6.13+ otherwise
+  * - Vulkan pass-through
+    - Linux 6.13+
+  * - AMDGPU DRM native context
+    - Linux 6.13+
+  * - Freedreno DRM native context
+    - Linux 6.4+
+  * - Intel i915 DRM native context
+    - Linux 6.13+
+  * - Asahi DRM native context
+    - Downstream version of Asahi Linux kernel
+
+.. list-table:: Linux Guest Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel Version
+    - Mesa Version
+  * - OpenGL pass-through
+    - Any Linux version supporting virtio-gpu
+    - 16.0.0+
+  * - Vulkan pass-through
+    - Linux 5.16+
+    - 24.2.0+
+  * - AMDGPU DRM native context
+    - Linux 6.14+
+    - 25.0.0+
+  * - Freedreno DRM native context
+    - Linux 6.14+
+    - 23.1.0+
+  * - Intel i915 DRM native context
+    - Linux 6.14+
+    - `mr29870`_
+  * - Asahi DRM native context
+    - Linux 6.14+
+    - 24.2.0+
+
+.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
+
 virtio-gpu rutabaga
 -------------------
 
@@ -133,3 +199,21 @@ Surfaceless is the default if ``wsi`` is not specified.
 .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
 .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
 .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
+
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel version
+  * - Vulkan+Wayland pass-through
+    - Linux 6.13+
+
+.. list-table:: Linux Guest Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel Version
+    - Mesa Version
+  * - Vulkan pass-through
+    - Linux 5.16+
+    - 24.3.0+
-- 
2.48.1


