Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C00CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWj-0002F9-Po; Thu, 16 Oct 2025 11:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWi-0002Eo-0x
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWY-0001B8-5v
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4256866958bso582645f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627048; x=1761231848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyRk/+Kom5+xaZjZRwpB6HWrShbewUSfqklsztKJrc8=;
 b=Z8ovIo2M2jrI4wUkmrDK+yEcbdNeZcZhzRPeq/WQg8/ETy6LBLsPI+mXs5/Fs7D6r9
 nk0HfaD6haJf/BmiySrYholXr0E/mC2yFn4cV/LLWLCYguujC10q77xc0AsyPciT5qum
 dg7SK8iytPlCu38Deq5KF4wuj0EF9qjjYaObU52TmryEIEjmfYEX86xXMDU45zUeZEfs
 ck9ynwY/x99IiOH8yNEfiVUcIt55RaxX1ppImiB7QWJfyDwXZbbuI14VLyj1deB+jmVe
 xFGvV9fAGdaZfHRqx1VRuyVryIRqx+baNhvX4B3O4i+Jb42rKTo5WSCC3ncDGrqzA/la
 71sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627048; x=1761231848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyRk/+Kom5+xaZjZRwpB6HWrShbewUSfqklsztKJrc8=;
 b=tIF3bGnOg8Gnp3GbfswPZ/8J0l1StZozx67ocC2dDi8HpGCwAmYZRiJWP3PuPHdteV
 4SR2sh5mR6wvqaWql5z2tsXKWENSxMPijCAWUlAotx7fqcZV9iVf2DmgsSdCbqmScqIV
 9eZYh0CLx5yjVv2CohRh7RfqT+yOTaWUsWaskpoYMjqKY0kZwEaQiAkfNIgIoAub0pjh
 j0mTTC/rTb/uI83M/4Nyn4Wz/hSgj9gGnLMvBUS9LT/ffBZsmSpIekk0+JrVk0r27BRY
 jDN5vqppcWpcfM1vNcoIrHDPOds/bdOJVPPtwBG0AMOQj2QKj52BU7oyX2gRbkICgC+z
 3kbg==
X-Gm-Message-State: AOJu0Yw2mDYQVS1YiBxvZhsrwfxScm16H8w8wB1OJWKVcMEHOnuB6lor
 Pmd3TFPKjrMMdqDQI63jfLyH3STf0eq7ri3aefcijRExnE65I+sE1zNjK1EPWfuVqrQ=
X-Gm-Gg: ASbGncuFd4+TmmvViXw10fE5yQiXCmg0Px9/L/10a0ohhImh1uvLI6VRJscdO5r6RD3
 5o0SlcuIwwMzdToiTi1PStGZ5mjIlcQbycklAnfEGCwtLiXTro+Og8f1GzFgYqGNsWEtQ2I3b1G
 4a5GeFI9pi5/GAC5Ljqs1BocffCa45nJusaHXr31W2ECNmu6D0xr5GfX+sR2RjvR8x3HN+Tq0Hz
 9ZcQgZySz6kLRSQKnrT08gfCmuHWBaoMA58f0yEdKi3TW7H4u0zU7MZ9lBWsQyQNGusSMReODuY
 aAipes05mo7aToKz3UL4crlG/cBWWf2KV18JXCgNkPgBFjLlS6jrpMOBI1vwUc0aJgZCaq2OE3x
 mj+tKtVLijS5CGaqv6cshaWHfxcs5RQQWki142qKayaBqF8nJJzfpSkv3DMuzqfFsGhAuiZBuSc
 d1X7dsNRKnSV38Hi8ek8YEGlUYOA==
X-Google-Smtp-Source: AGHT+IF2QctGDAzzeTp9k5LE37/HhFvvdkepOSL3cuakDw7tAy5A6JebXq0nm9KpJvKf/yIozkJJPA==
X-Received: by 2002:a05:600c:540c:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-4711789d9e4mr2360605e9.10.1760627047881; 
 Thu, 16 Oct 2025 08:04:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c91sm31149045e9.11.2025.10.16.08.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 912225FAFD;
 Thu, 16 Oct 2025 16:03:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 11/11] docs/system: merge vhost-user-input into
 vhost-user-contrib
Date: Thu, 16 Oct 2025 16:03:56 +0100
Message-ID: <20251016150357.876415-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - some typo fixes
---
 docs/system/devices/virtio/index.rst          |  2 +-
 .../devices/virtio/vhost-user-contrib.rst     | 87 +++++++++++++++++++
 .../devices/virtio/vhost-user-input.rst       | 45 ----------
 docs/system/devices/virtio/vhost-user.rst     | 22 ++---
 docs/system/devices/virtio/virtio-gpu.rst     |  2 +
 5 files changed, 101 insertions(+), 57 deletions(-)
 create mode 100644 docs/system/devices/virtio/vhost-user-contrib.rst
 delete mode 100644 docs/system/devices/virtio/vhost-user-input.rst

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


