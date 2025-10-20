Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC554CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnL5-0007cf-4O; Mon, 20 Oct 2025 06:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnL2-0007aX-8s
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:04 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKz-0000i0-Or
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:03 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c4c346bd9so3735324a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956920; x=1761561720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDlmq3nCvS9URXDE65YY6VgZudJg1dxtSBT7JyGkZ8g=;
 b=AE7uhy3aw41/ckN4k9ajFEopZ+AeM0Cm9uBuv1fJ7eBXnUKZWiw+JXbIrntl/nEGm6
 0ar+IzsHKI5BKT9e9hV9s9tt0l2ibcChzCAPuRj2mZC5ZQLa6k7l//469Ud79F1+T7IM
 ATIRHLCWWd9Dx9xMSlLW7BrRIxsFJbY1F7VbkePgHPXZjMWvopscgPtaG4aJA+yAcbOl
 4W4Ulc9CiVhoe3W6jXSv1fl4s8G4xTdsJFUEOaWxBRwKJED7MMEKVyseuurH4a27RLbp
 rbxxda9B63P+j8tXrQjKwcpcMI796zNEFzHfKLVnI9VLu7jD4Nm1Z6jDTSrgOqSrQoCe
 Qbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956920; x=1761561720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDlmq3nCvS9URXDE65YY6VgZudJg1dxtSBT7JyGkZ8g=;
 b=YYwY0g0U+oALyGNuxsHlHPoOK1OkqRMCTKMlUrdB7ZG0+BMfbZOxoc1n78CNDzeRJu
 tDZK3hqwodbDdjqdsjUTxJuYlmE4Ssn9LaRUyim0s1BzL7KEzWKksb2t+4+A6aDSkwAs
 /BliGkmbpcRwon3b/kH/XgAMffsWdCEsLAlq4YOoD5NZ6Vl/eOD8ks1hDfnacDvI7L+B
 TYQXtOwVyAWa5KHNVDZLAYM/Dwa4d+rb58PrQ1tTKsMCULK2KGOdVc1i75f9neirmcOg
 c6dkowTdcRRO7DYIpFPNNRDpi7Wx92DKznXsbfJkaCPr1zXymTdbL50wsnhCPpLS2G3+
 YGjA==
X-Gm-Message-State: AOJu0YxZ0bfhn6XkH/ZWHgBizfn8X1ligvkZieDfSIGJaERTUX5OUNkX
 5IhAJNnOjXX3dxuItfqf8u2BLYF8V6l60RoU5dOyNVnsOUADlcbSQxp9gKn9XnZXUJ6RtB5AqMZ
 Ab8AR5cc=
X-Gm-Gg: ASbGncuaE/ZDmQO2DzM+1rwOffBWoEMjp6ubCJwr+HEuj8jclSDAMrg6byOWt+O1lfQ
 Vj2cvr3hmBn3THdnPD/JhVReWM1cKdU184Tdh0YnP3KNJWIsrqH+B42bt8GzhCqUyILzNGxw8ki
 cUQVAczd8hu1UKhmm4FBg87baifQvFG5Jnz29hjUXJUV+d/hjbGlR7FKGIbz71q9pQRU+XI5D5R
 cnL3DOMCIlXGDXn/qrnGhgEZFCeGKKk9V0iUaMBG+guB8rvpKQ/NnZtyknhVroSIzx2X0C362ZA
 gLgePv8Wb1Zn7ryyxx0j3VWEOs8rQ2ZIRZnLnJdXH7NedVXOpJlcBtaHoADLszqY6ky7I2kdowx
 kYcn5wW1NekTQn5vQBmyecqthk5ZknunLAryDij5WAN70O53XjR5qLLUuvszuYMT4vAysP/jDxV
 toZRWAhEvXf54=
X-Google-Smtp-Source: AGHT+IHBiANNBrzWbgHQBzxXh/IgCzw4+7h2aVx37yyYFgkk8tybiRgghshCfBi107aij5+5jLAaOg==
X-Received: by 2002:a05:6402:4407:b0:63c:eb9:4778 with SMTP id
 4fb4d7f45d1cf-63c1f626e36mr11612434a12.1.1760956919876; 
 Mon, 20 Oct 2025 03:41:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm6492315a12.27.2025.10.20.03.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AAEED60F3D;
 Mon, 20 Oct 2025 11:41:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 11/11] docs/system: merge vhost-user-input into
 vhost-user-contrib
Date: Mon, 20 Oct 2025 11:41:49 +0100
Message-ID: <20251020104149.4034124-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

We might as well group all the contrib submissions together and gently
dissuade people from using them in production. Update the references in
vhost-user to neatly refer to the storage daemon and the various
external rust backends.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251016150357.876415-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/virtio/index.rst
index e3839e61824..c292101ade6 100644
--- a/docs/system/devices/virtio/index.rst
+++ b/docs/system/devices/virtio/index.rst
@@ -24,6 +24,6 @@ can also be off-loaded to an external process via :ref:`vhost user
    virtio-pmem.rst
    virtio-snd.rst
    vhost-user.rst
-   vhost-user-input.rst
+   vhost-user-contrib.rst
 
 .. _VirtIO specification: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
diff --git a/docs/system/devices/virtio/vhost-user-contrib.rst b/docs/system/devices/virtio/vhost-user-contrib.rst
new file mode 100644
index 00000000000..48d04d2ade3
--- /dev/null
+++ b/docs/system/devices/virtio/vhost-user-contrib.rst
@@ -0,0 +1,87 @@
+vhost-user daemons in contrib
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+QEMU provides a number of :ref:`vhost_user` daemons in the contrib
+directory. They were often written when vhost-user was initially added
+to the code base. You should also consider if other vhost-user daemons
+such as those from the rust-vmm `vhost-device repository`_ are better
+suited for production use.
+
+.. _vhost-device repository: https://github.com/rust-vmm/vhost-device
+
+.. _vhost_user_block:
+
+vhost-user-block - block device
+===============================
+
+vhost-user-block is a backend for exposing block devices. It can
+present a flat file or block device as a simple block device to the
+guest. You almost certainly want to use the :ref:`storage-daemon`
+instead which supports a wide variety of storage modes and exports a
+number of interfaces including vhost-user.
+
+.. _vhost_user_gpu:
+
+vhost-user-gpu - gpu device
+===========================
+
+vhost-user-gpu presents a paravirtualized GPU and display controller.
+You probably want to use the internal :ref:`virtio_gpu` implementation
+if you want the latest features. There is also a `vhost_device_gpu`_
+daemon as part of the rust-vmm project.
+
+.. _vhost_device_gpu: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-gpu
+
+.. _vhost_user_input:
+
+vhost-user-input - Input emulation
+==================================
+
+The Virtio input device is a paravirtualized device for input events.
+
+Description
+-----------
+
+The vhost-user-input device implementation was designed to work with a daemon
+polling on input devices and passes input events to the guest.
+
+QEMU provides a backend implementation in contrib/vhost-user-input.
+
+Linux kernel support
+--------------------
+
+Virtio input requires a guest Linux kernel built with the
+``CONFIG_VIRTIO_INPUT`` option.
+
+Examples
+--------
+
+The backend daemon should be started first:
+
+::
+
+  host# vhost-user-input --socket-path=input.sock	\
+      --evdev-path=/dev/input/event17
+
+The QEMU invocation needs to create a chardev socket to communicate with the
+backend daemon and access the VirtIO queues with the guest over the
+:ref:`shared memory <shared_memory_object>`.
+
+::
+
+  host# qemu-system								\
+      -chardev socket,path=/tmp/input.sock,id=mouse0				\
+      -device vhost-user-input-pci,chardev=mouse0				\
+      -m 4096 									\
+      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on	\
+      -numa node,memdev=mem							\
+      ...
+
+
+.. _vhost_user_scsi:
+
+vhost-user-scsi - SCSI controller
+=================================
+
+The vhost-user-scsi daemon can proxy iSCSI devices onto a virtualized
+SCSI controller.
diff --git a/docs/system/devices/virtio/vhost-user-input.rst b/docs/system/devices/virtio/vhost-user-input.rst
deleted file mode 100644
index 118eb78101c..00000000000
--- a/docs/system/devices/virtio/vhost-user-input.rst
+++ /dev/null
@@ -1,45 +0,0 @@
-.. _vhost_user_input:
-
-QEMU vhost-user-input - Input emulation
-=======================================
-
-This document describes the setup and usage of the Virtio input device.
-The Virtio input device is a paravirtualized device for input events.
-
-Description
------------
-
-The vhost-user-input device implementation was designed to work with a daemon
-polling on input devices and passes input events to the guest.
-
-QEMU provides a backend implementation in contrib/vhost-user-input.
-
-Linux kernel support
---------------------
-
-Virtio input requires a guest Linux kernel built with the
-``CONFIG_VIRTIO_INPUT`` option.
-
-Examples
---------
-
-The backend daemon should be started first:
-
-::
-
-  host# vhost-user-input --socket-path=input.sock	\
-      --evdev-path=/dev/input/event17
-
-The QEMU invocation needs to create a chardev socket to communicate with the
-backend daemon and access the VirtIO queues with the guest over the
-:ref:`shared memory <shared_memory_object>`.
-
-::
-
-  host# qemu-system								\
-      -chardev socket,path=/tmp/input.sock,id=mouse0				\
-      -device vhost-user-input-pci,chardev=mouse0				\
-      -m 4096 									\
-      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on	\
-      -numa node,memdev=mem							\
-      ...
diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
index 9c9a28df380..f556a840e99 100644
--- a/docs/system/devices/virtio/vhost-user.rst
+++ b/docs/system/devices/virtio/vhost-user.rst
@@ -27,37 +27,37 @@ platform details for what sort of virtio bus to use.
     - Notes
   * - vhost-user-blk
     - Block storage
-    - See contrib/vhost-user-blk
+    - :ref:`storage-daemon`
   * - vhost-user-fs
     - File based storage driver
-    - See https://gitlab.com/virtio-fs/virtiofsd
+    - `virtiofsd <https://gitlab.com/virtio-fs/virtiofsd>`_
   * - vhost-user-gpio
     - Proxy gpio pins to host
-    - See https://github.com/rust-vmm/vhost-device
+    - `vhost-device-gpio <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-gpio>`_
   * - vhost-user-gpu
     - GPU driver
-    - See contrib/vhost-user-gpu
+    - `vhost-device-gpu <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-gpu>`_ or :ref:`vhost_user_gpu`
   * - vhost-user-i2c
     - Proxy i2c devices to host
-    - See https://github.com/rust-vmm/vhost-device
+    - `vhost-device-i2c <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-i2c>`_
   * - vhost-user-input
     - Generic input driver
-    - :ref:`vhost_user_input`
+    - `vhost-device-input <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-input>`_ or :ref:`vhost_user_input`
   * - vhost-user-rng
     - Entropy driver
-    - See https://github.com/rust-vmm/vhost-device
+    - `vhost-device-rng <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rng>`_
   * - vhost-user-scmi
     - System Control and Management Interface
-    - See https://github.com/rust-vmm/vhost-device
+    - `vhost-device-scmi <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-scmi>`_
   * - vhost-user-snd
     - Audio device
-    - See https://github.com/rust-vmm/vhost-device/staging
+    - `vhost-device-sound <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-sound>`_
   * - vhost-user-scsi
     - SCSI based storage
-    - See contrib/vhost-user-scsi
+    - :ref:`vhost_user_scsi`
   * - vhost-user-vsock
     - Socket based communication
-    - See https://github.com/rust-vmm/vhost-device
+    - `vhost-device-vsock <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock>`_
 
 The referenced *daemons* are not exhaustive, any conforming backend
 implementing the device and using the vhost-user protocol should work.
diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 39d2fd2d21c..0f4bb304a9b 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -1,6 +1,8 @@
 ..
    SPDX-License-Identifier: GPL-2.0-or-later
 
+.. _virtio_gpu:
+
 VirtIO GPU
 ==========
 
-- 
2.47.3


