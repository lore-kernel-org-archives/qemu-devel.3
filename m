Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC45CD4F3E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 12:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKcLL-0005qY-75; Sun, 16 Nov 2025 07:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcLF-0005kx-7S
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:58:53 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKcLD-0000B7-9H
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 07:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763297911; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KXNts/IGvmjD2o12wW2UrRL7x7uIg3/hieJEtNNNZhNKCyatDdW1uq1kvvrrBidPgQAOo8A4bEnJH4jkFqXcQeeNTNvz8+gk8Q7ot1/82VroAV+yhi7R6nfG6R54bFZdaFn2o1rvVZ2Kl+nOs6ak0kktVmUTYz5VjO6daNXG45k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763297911;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4yStiIrw/Erg38g4/Q3HvaLqXs9jgX/hWgQqgDr2Iu0=; 
 b=YV3SFwVgPG47rWZ45S0bqg5ZzHS3DJ/mwsfMiDhFTw2ktVGpM3rgpGiTsEHjL8qR/L4P0cSXz6WIytg/sA39HFZzNjA6tVLzFXyYVhA7KVlXgnVvluyt/zMPEQjPyrXytx3OxJuYmF4gYTZb/B8mQIuaT0qokpKPqQ10eN+T2Rw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763297911; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=4yStiIrw/Erg38g4/Q3HvaLqXs9jgX/hWgQqgDr2Iu0=;
 b=KrI5TuWnZEWJ6Ulk3A1e3Yn2aANUPyV+yLi+Xskq0KOK4ZTpDpORoYCRJh+DT6uz
 zrG1O/eOi+/xhDyviQ6CIvHaJqZAnYnHGXwblyaY4DHOw3Ag1HXaCioJFWzPBAWfmZU
 wIRyZJxGJamdcBq0V1gk49ExfU0fGj479a+vPZWM=
Received: by mx.zohomail.com with SMTPS id 1763297908397794.9971265807997;
 Sun, 16 Nov 2025 04:58:28 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
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
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v16 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
Date: Sun, 16 Nov 2025 15:56:41 +0300
Message-ID: <20251116125641.2255794-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251116125641.2255794-1-dmitry.osipenko@collabora.com>
References: <20251116125641.2255794-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
[dmitry.osipenko@collabora.com: Extended and corrected doc]
---
 docs/system/devices/virtio/virtio-gpu.rst | 100 +++++++++++++++++++++-
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index ef5fb0401d5d..cdba4669f518 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -7,14 +7,28 @@ VirtIO GPU
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
 
@@ -67,8 +81,14 @@ intermediate representation is communicated to the host and the
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
@@ -96,6 +116,62 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
 
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel Version
+    - Libvirglrenderer Version
+  * - OpenGL pass-through
+    - Any Linux version compatible with QEMU if not using host blobs feature,
+      Linux 6.13+ otherwise
+    - 0.8.2+
+  * - Vulkan pass-through
+    - Linux 6.13+
+    - 1.0.0+
+  * - AMDGPU DRM native context
+    - Linux 6.13+
+    - 1.1.0+
+  * - Freedreno DRM native context
+    - Linux 6.4+
+    - 1.0.0+
+  * - Intel i915 DRM native context
+    - Linux 6.13+
+    - `mr1384`_
+  * - Asahi DRM native context
+    - `Downstream version`_ of Asahi Linux kernel
+    - 1.2.0+
+
+.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
+.. _Downstream version: https://github.com/AsahiLinux/linux
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
 
@@ -135,3 +211,21 @@ Surfaceless is the default if ``wsi`` is not specified.
 .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
 .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
 .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
+
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel Version
+  * - Vulkan+Wayland pass-through
+    - Linux 6.13+
+
+.. list-table:: Linux Guest Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel Version
+    - Mesa Version
+  * - Vulkan+Wayland pass-through
+    - Linux 5.16+
+    - 24.3.0+
-- 
2.51.1


