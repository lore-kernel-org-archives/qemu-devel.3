Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D027EF9011
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpX6-00074v-1u; Wed, 04 Mar 2026 11:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpX5-00074W-0m
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:57:11 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpX1-0003xe-9C
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:57:10 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8f8d80faebso1202431266b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643422; x=1773248222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oL+UTh6dS7cRr9RVX23hKu8PkaeJg5kdlCXSgZk5kTo=;
 b=CyJKSgmIPtHCGUmdVQGPJ5TccyNHYA5k6xwzmo1mMBIYgTil1mKJtXgLX8C2y2C2dE
 MnExM43uM761UsQRayvBjTNXePzFysnxCc8vRitDn09CWkd2pH/DQ9X5MyVtce1158FN
 UM7ojQp398LNBA8onqF89M51xk3nTn44Z7rjxBGRAJ4PUsNK7yCjcGVyw2B12Uuk9UQ9
 5kZwday+fH+WmJkfIUCQvYn2HsNdFRPeXhxnt7Innzq32QhJL3rr95rPTcaCNYVpp/xW
 T2jOtY5kYvhGuyFfi3Kwe7qhsqYnVghhoBcXQl12Q+j5ugFX+fAO++5OBMfsLuvww/nh
 Z0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643422; x=1773248222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oL+UTh6dS7cRr9RVX23hKu8PkaeJg5kdlCXSgZk5kTo=;
 b=l5AIyKi7IagwWr2NurIazLekjdbTb5wvyiUsRnjGKeV6WaTg9korUxQq3CbBrsy87j
 Pov56sJt/UYNg1oPNF+TCp1X0JIO5Ul46oGKU0Hfgr6bBUqXzt16nbYVvK0H55OuajTX
 7Df0UPKKaAqmR/VzzGxbeTaA4r7HtaKfYe5aJry8jN+C1AF3jxCTZw99jDVm9AvpbVLi
 jjSYxdkUwhX6fhKkiw4XpM6+hqH2kqmAnKEUe3DR3dcuucfiCv/OffVtquJAQzV2uqo0
 Xtd5/PdNDLlcHtmB0HP3oNbZ2aoh7QIlooQ8laZjQD8cgtgnVuEB0SKWiQoAQE7GSXru
 3PJg==
X-Gm-Message-State: AOJu0YwDgr6VhlhJg691z7IcMi1KFMQ4S0jGh2i3446Gbch/oYH95A9/
 rn2tXzqvuSiSP3S/jGkuGZ+8hUI+IPPBBLEzCK8Kmz7E/bVMSvBTE+lMWT/iNitRtc8=
X-Gm-Gg: ATEYQzw66ezsMz9pZtxGuPMK+zaG6pFDAk9iKPE3hu0jAaZK9YHsU76qJeGegxB0je6
 jyeJxOZKk38tkaBjhwg6PkePblqtn8FE1D+alXDoGFrVaKWg3ppoGByGC7lLaMrOFqV6XS6jOja
 QYmfpEUlmuITgIpxKyuQkBVl86Q9KZPHa91hgRwOUuKQJfIDTT9PjoZjm4+fnOOEl0Cm8ppqBD5
 KqfMjmkXc1ib+rLn0dLPcSpB8QuXNoyCP5nvgudcDeZdo7ZtroKuqSJ5ESASJ2NlAxyL1ezn1+W
 yFhkyJi8MTIR/HpHnkRN23opxEIgsYwyQJ7+/6Pq4LVSfgxPdGggQ5hXsystQxDQfDxxWZotyG3
 PbSoHPRTQ0ByAta3QvQ8AFKB7jWuNR+7pMA7AQ76vNRzL5hHZUOPBOYR6getC849A0uPLAUJt4B
 NHByQi3u7FKvsiWiy8K0zJ7nI=
X-Received: by 2002:a17:907:2d1e:b0:b8f:6f94:a618 with SMTP id
 a640c23a62f3a-b93eff2e630mr179090366b.17.1772643421471; 
 Wed, 04 Mar 2026 08:57:01 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ac75fd9sm764415366b.28.2026.03.04.08.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:57:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B14662D97;
 Wed, 04 Mar 2026 16:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 15/20] docs/system: virtio-gpu: Document host/guest
 requirements
Date: Wed,  4 Mar 2026 16:50:37 +0000
Message-ID: <20260304165043.1437519-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/virtio/virtio-gpu.rst | 105 +++++++++++++++++++++-
 1 file changed, 102 insertions(+), 3 deletions(-)

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


