Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAF6C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 22:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZdNj-00079j-IQ; Sun, 19 Jan 2025 17:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tZdNY-00072U-7K
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 17:02:52 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tZdNW-0008Bj-EV
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 17:02:47 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1737324156; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lg9xK0Nx0osMbbP8vddK+2oN+uEyoR5MNUkRiG0qptVW9qmgsA6IgVz9gQoI+tNY10vBA5zbrCoSKwZN/T/M1V7l0RxDlEaufgyOHobMfS2zMSaeKMYh81T9yy4E9aAZb7Pb2dd1Ix7u5lrq22ANfLFdBR8wryw1rVByd3t2+IY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737324156;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=E4PT0wmlHRKJpXGJ+7b/TX4o4/zJZJUFB/7QjAhc710=; 
 b=CIEWSigYWth1spiVLcfxXjTSmVd3KWxRn9609FH5CIyolCEiB+rVtYOiGA7fW6SdJKQKnJEz+Dw20fcPVPAelKT/ZF9Pch/ve9+jE8Uz0tUzNDZzdYCyAEIwO3CIACVFxce0NprCh4e0xs2vA1o+zKWuxYO1EBwYs0rTKGXKYIA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737324156; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=E4PT0wmlHRKJpXGJ+7b/TX4o4/zJZJUFB/7QjAhc710=;
 b=GMs+tmBjIE8tKMZWUuk9PEdTUGuDkeTLJSZPbH37XXmqTAxa+WwarGbyNRUaRdGB
 JY8hKhE5gC13gKUPzTeuVff13TikexvPU0rDcFi7/BVY/VOAQSGWGcX7bsHXPuM1qIl
 H2pxLf77fydEgLWESs88hVPqCjIujeueHGTD14XA=
Received: by mx.zohomail.com with SMTPS id 1737324153798380.37430422816954;
 Sun, 19 Jan 2025 14:02:33 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
Date: Mon, 20 Jan 2025 01:00:50 +0300
Message-ID: <20250119220050.15167-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.024,
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
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
[dmitry.osipenko@collabora.com: Extended and corrected doc]
---
 docs/system/devices/virtio-gpu.rst | 94 ++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 6 deletions(-)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index f20c60016376..79af291a9316 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -4,14 +4,96 @@
 virtio-gpu
 ==========
 
-This document explains the setup and usage of the virtio-gpu device.
-The virtio-gpu device paravirtualizes the GPU and display controller.
-
-Linux kernel support
---------------------
+The virtio-gpu device provides a GPU and display controller
+paravirtualized using VirtIO. It supports a number of different modes
+from simple 2D displays to fully accelerated 3D graphics.
+
+Dependencies
+............
+
+.. note::
+  GPU virtualisation is still an evolving field. Depending on the mode
+  you are running you may need to override distribution supplied
+  libraries with more recent versions or enable build options.
+
+Host requirements
+-----------------
+
+Depending on the mode there are a number of requirements the host must
+meet to be able to be able to support guests. For 3D acceleration QEMU
+must be able to access the hosts GPU and for the best performance be
+able to reliably share GPU memory with the guest.
+
+.. list-table:: Host Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Kernel
+    - Userspace
+  * - virtio-gpu
+    - framebuffer enabled
+    - GTK or SDL display
+  * - virtio-gpu-gl (OpenGL pass-through)
+    - GPU enabled
+    - libvirglrenderer (virgl support)
+  * - virtio-gpu-gl (rutabaga/gfxstream)
+    - GPU enabled
+    - aemu/rutabaga_gfx_ffi or vhost-user client with support
+  * - virtio-gpu-gl (Vulkan pass-through)
+    - Linux 6.13+
+    - libvirglrenderer (>= 1.0.0, venus support)
+  * - virtio-gpu-gl (vDRM native context/AMD)
+    - Linux 6.13+
+    - libvirglrenderer (>= 1.1.0, DRM renderer support)
+  * - virtio-gpu-gl (vDRM native context/Freedreno)
+    - Linux 6.13+
+    - libvirglrenderer (>= 1.0.0, DRM renderer support)
+  * - virtio-gpu-gl (vDRM native context/Intel i915)
+    - Linux 6.13+
+    - libvirglrenderer (`mr1384`_, DRM renderer support)
+
+.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
+
+Guest requirements
+------------------
 
 virtio-gpu requires a guest Linux kernel built with the
-``CONFIG_DRM_VIRTIO_GPU`` option.
+``CONFIG_DRM_VIRTIO_GPU`` option. Otherwise for 3D accelerations you
+will need support from Mesa configured for whichever encapsulation you
+need.
+
+.. list-table:: Guest Requirements
+  :header-rows: 1
+
+  * - Mode
+    - Mesa Version
+    - Mesa build flags
+  * - virtio-gpu
+    - n/a
+    - n/a
+  * - virtio-gpu-gl (OpenGL pass-through)
+    - 20.3.0+
+    - -Dgallium-drivers=virgl
+  * - virtio-gpu-gl (rutabaga/gfxstream)
+    - 24.3.0+
+    - -Dvulkan-drivers=gfxstream
+  * - virtio-gpu-gl (Vulkan pass-through)
+    - 24.2+
+    - -Dvulkan-drivers=virtio
+  * - virtio-gpu-gl (vDRM native context/AMD)
+    - 25.0.0+
+    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
+  * - virtio-gpu-gl (vDRM native context/Freedreno)
+    - 23.1.0+
+    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
+  * - virtio-gpu-gl (vDRM native context/Intel i915)
+    - `mr29870`_
+    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-experimental=true
+
+.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
+
+Further information
+...................
 
 QEMU virtio-gpu variants
 ------------------------
-- 
2.47.1


