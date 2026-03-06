Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48326FCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDY-0006Ty-Rn; Fri, 06 Mar 2026 14:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCV-0004EC-Cw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCP-0000Rs-2B
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-48529c325f0so4850215e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826659; x=1773431459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS5AFqvs7neblJVLo/6AkMOZ1wbglI8t3qNCBUD2rL0=;
 b=E9H9+8mB3/wFowTcHWlh/1Rya21jGYD5XdOG0ngJAYT8YDBouyBmgSf9d8UzqtYsaV
 L0/r1+fmAbSCBBT0NrwmLdm1U+9yshXnERWTMiM288GBx1nYGOV1M9a9L8JpQe/z1AZ3
 rzVvvISQxQBlk3zfNp4NuLx+KVvzWl6pHbIHsMzbBTYy0COXWqnf32dgFBBiGErlWSyU
 /xjXNzLPY8z127Cv55Obb1lSOQhS3MqmNzBrAa8i6ockJsxzUIwIUPP2g/T5m+/IsGDc
 jr6TWaNkEnC2v6SiQadDVrCToaQKN+/Qj+jpiIbF2IvRoKhQFDLe23hfqdMmNVWN1wIA
 nlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826659; x=1773431459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pS5AFqvs7neblJVLo/6AkMOZ1wbglI8t3qNCBUD2rL0=;
 b=wDv+J9Brd5oFw7qJytrqmid+naBQLpFT43jlH9sY2R+S/FCeYz+/8eooMOQhkcNXaO
 HQ0S3/igfBYFdstZMKlmxlMKDDRfij4WS5f/uOwOGTGGgTK1CNh+npzCyRDwq76JSolz
 +quSamm78eudgdUoXjjhBK2WY6C4ZvwTDAJGzyY1VrKcPauWoblmGjDTL/U3d7vmhLEg
 va4F+ca3cu8690MFwA0Qh/93+zpAF05sjoxcgTpVjHi98OcgbMJPXD/d8vZlkoqHbGmL
 VrKX7rvlBSqTGmtZG2F/lqNuh5ZtYVgYmwZfB6fPn/Ck2cEZxJvzHgXZknzdCMeO7LSH
 gtrQ==
X-Gm-Message-State: AOJu0YyXNIw3PnahgtET5Fx2jXiFihO59K8/oFPJ42tUs+LayN085qg/
 8UbmBPakjx7eDHHDh1f1x+v9/RyI4Tsnd52ql9Vz89XhA2rIZeluiqYZSKSYuYB1cqA=
X-Gm-Gg: ATEYQzyt4mkYOYS0TaD1zMLmZnoEbGSdLmptUrkX6ZuMTrttQvAWivkg0FOSa4wzKDA
 MqLZwrlx0syc61SvFc7eiLilW9StZqg47PZXUOxz5m9khRO1yRE/oq2fAVyO9xZ5dJ7TsBCnSEL
 spfhlPoe1KwzZUN17A+8U69UIHwzfWTqjLVjdgwJHif9E3Sr2lPkhiwM8NbGzcD30TiZJAcebxV
 iM3CxB8wg3SP6YYRj1ZGGSPFKWlUVlTEArYATXKahcGyvcS61fcZ8UkPbFxqZcrX6SJ4TbMSlpv
 zjabS5yNY0UJ1mVOZ0gyFgbKDOwzHQkw59Zz1o3LW6IfIYVKaD479pC28A3+0ZTZ9zdqWRpZN8c
 0UpJwZ/CLYvsoaEQFd+ENHAfJr+I8Hx0MAeAXy1FuRK7yO8XmZLUwNYZK2EBnh4UIxqtDFox3qb
 GCBXK5BGgfZTonZcH1lM37uVrHgUFPg2pwkg==
X-Received: by 2002:a05:600c:1908:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-4852695943emr59983305e9.19.1772826659376; 
 Fri, 06 Mar 2026 11:50:59 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527648a19sm55127515e9.0.2026.03.06.11.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 63797689DE;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/20] docs/system: virtio-gpu: Document host/guest requirements
Date: Fri,  6 Mar 2026 19:50:42 +0000
Message-ID: <20260306195048.2869788-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This attempts to tidy up the VirtIO GPU documentation to make the list
of requirements clearer. There are still a lot of moving parts and the
distros have some catching up to do before this is all handled
automatically.

Cc: Sergio Lopez Pascual <slp@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
[dmitry.osipenko@collabora.com: Extended and corrected doc]
Message-ID: <20260303151422.977399-14-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-16-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index ef5fb0401d5..d05f8cb8e3f 100644
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
@@ -96,6 +116,67 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
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
+    - 1.3.0+
+  * - Asahi DRM native context
+    - `Downstream version`_ of Asahi Linux kernel
+    - 1.2.0+
+  * - Panfrost native context
+    - Linux 6.13+
+    - 1.3.0+
+
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
+    - 26.1.0+
+  * - Asahi DRM native context
+    - Linux 6.14+
+    - 24.2.0+
+  * - Panfrost native context
+    - Linux 6.14+
+    - `mr36814`_
+
+.. _mr36814: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36814
+
 virtio-gpu rutabaga
 -------------------
 
@@ -135,3 +216,21 @@ Surfaceless is the default if ``wsi`` is not specified.
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
2.47.3


