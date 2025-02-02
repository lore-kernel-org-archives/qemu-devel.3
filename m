Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C836EC0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 23:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tejNl-0003eb-Ni; Sun, 02 Feb 2025 18:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tejNf-0003Vs-UX
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 18:28:00 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tejNd-0003bD-Dh
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 18:27:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738538863; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KSwhHymRGXU9MRTYVlXbBIIv75ZxqIN+L3LDxQi1EWm3RHt0fGomT7ohE+xpo2aPy2qMJYai5FQJcQufIWVfuZ+gs+R5t3v1ociGeeUAMeBrl6w3lblXy6lPgWaZ0+FhIuDxMz9jHdE4motquvz+w4bFpecrijEhMSxbuHR90to=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738538863;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MdlrDBVL5mxVDB27OYZYYdy/66+pKF7zkU8ban+3B1s=; 
 b=EdEiF4RYOrGnESCSTtwCCFrVY8WmnNRx4cjYxOn0ITbZNYoRbXmLwFxeKhkkjqo3ptADyrJngvsuC5TBQUEZhZi2JI7/8OdPGbepKdAkRSBQNnG28EthlTSIpTuid7RiwDPtJOKkUbpVuB/IMl6G5XIdxui53TZL0H1oI0O1r1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738538863; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=MdlrDBVL5mxVDB27OYZYYdy/66+pKF7zkU8ban+3B1s=;
 b=FpxiEaMm4Uk+1Ptod5D4FdhnJTPOzBtScbELy2Mkl08xj3BBNhXJyoUq2f8V7e0N
 ch51JdA4XwCNIIF4Sr8pY6QxZUjaw0P+q1ijkz2aYuoFu70f2tsB+x07q1NUJMtW/d6
 btwgUmNJ5YCC5ny57JCkKKQOufCcHOI0MYPr1BqY=
Received: by mx.zohomail.com with SMTPS id 1738538857014988.1498560462146;
 Sun, 2 Feb 2025 15:27:37 -0800 (PST)
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
Subject: [PATCH v7 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
Date: Mon,  3 Feb 2025 02:21:36 +0300
Message-ID: <20250202232136.919342-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
References: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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
 docs/system/devices/virtio-gpu.rst | 92 +++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index ea3eb052df3c..56950a76aa2e 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -5,7 +5,9 @@ virtio-gpu
 ==========
 
 This document explains the setup and usage of the virtio-gpu device.
-The virtio-gpu device paravirtualizes the GPU and display controller.
+The virtio-gpu device provides a GPU and display controller
+paravirtualized using VirtIO. It supports a number of different modes
+from simple 2D displays to fully accelerated 3D graphics.
 
 Linux kernel support
 --------------------
@@ -56,6 +58,17 @@ on typical modern Linux distributions.
 .. _Mesa: https://www.mesa3d.org/
 .. _SwiftShader: https://github.com/google/swiftshader
 
+3D acceleration
+---------------
+
+3D acceleration of a virtualized GPU is still an evolving field.
+Depending on the 3D mode you are running you may need to override
+distribution supplied libraries with more recent versions or enable
+build options. There are a number of requirements the host must meet
+to be able to be able to support guests. QEMU must be able to access the
+host's GPU and for the best performance be able to reliably share GPU
+memory with the guest.
+
 virtio-gpu virglrenderer
 ------------------------
 
@@ -94,6 +107,61 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
 
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Kernel
+    - libvirglrenderer build flags
+  * - OpenGL pass-through
+    - Linux any stable version
+    - N/A
+  * - Vulkan pass-through
+    - Linux 6.13+
+    - -Dvenus=true -Drender-server=true
+  * - AMDGPU DRM native context
+    - Linux 6.13+
+    - -Ddrm-renderers=amdgpu-experimental
+  * - Freedreno DRM native context
+    - Linux 6.4+
+    - -Ddrm-renderers=msm
+  * - Intel i915 DRM native context
+    - Linux 6.13+
+    - -Ddrm-renderers=i915-experimental `mr1384`_
+  * - Asahi DRM native context
+    - Linux 6.13+
+    - -Ddrm-renderers=asahi-experimental `mr1274`_
+
+.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
+.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274
+
+.. list-table:: Linux Guest Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Mesa Version
+    - Mesa build flags
+  * - OpenGL pass-through
+    - 16.0.0+
+    - -Dgallium-drivers=virgl
+  * - Vulkan pass-through
+    - 24.2.0+
+    - -Dvulkan-drivers=virtio
+  * - AMDGPU DRM native context
+    - 25.0.0+
+    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
+  * - Freedreno DRM native context
+    - 23.1.0+
+    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
+  * - Intel i915 DRM native context
+    - `mr29870`_
+    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-experimental=true
+  * - Asahi DRM native context
+    - 24.2.0+
+    - -Dgallium-drivers=asahi -Dvulkan-drivers=asahi
+
+.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
+
 virtio-gpu rutabaga
 -------------------
 
@@ -133,3 +201,25 @@ Surfaceless is the default if ``wsi`` is not specified.
 .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
 .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
 .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
+
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Kernel
+    - Userspace
+  * - rutabaga-gfxstream
+    - Linux 6.13+
+    - rutabaga_gfx_ffi or vhost-user client with `gfxstream support`_
+
+.. _gfxstream support: https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-gpu
+
+.. list-table:: Linux Guest Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Mesa Version
+    - Mesa build flags
+  * - rutabaga-gfxstream
+    - 24.3.0+
+    - -Dvulkan-drivers=gfxstream
-- 
2.47.1


