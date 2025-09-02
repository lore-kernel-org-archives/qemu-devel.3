Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A0BCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUDl-0008HF-9v; Tue, 02 Sep 2025 12:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDh-0008Fp-VG
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:57 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDf-0004Qi-CI
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:57 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b0431c12df3so343053566b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756831854; x=1757436654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WT25vLnlnlxahwzUq/9pnYWfOU5FHn9MQChZKROLaP8=;
 b=qKyu9e68K50/XMqNqfWHdE8q4JmvBqt851lTrO+ItA4jOsH1rB2/IAQjWdtkK3459a
 KQe/eNPQAG39vAaxnhX2B8I8R/i5BAQ5IsQoWukq4fby0Sbzee3L12rJAJIlwoIlGmN4
 MKYjKCmbqOKCQRS15YzmZaqFvz4r2LnzWwPa0MIvxAlG30XgRCpwLP50V5KcXJoPKf4C
 sumOxAHHMH0KVm2NcOrawk8Rezsmb6JzSSD22mjo4CXRhW6XdHcniHl+VThvT0MqVQCl
 QWtctpyJwKbnSQYloB8KTXmtHoWwKbrOKMRGIdzz0azS46fL+GC2eE0gVzxrzd+g/lF4
 7Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756831854; x=1757436654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WT25vLnlnlxahwzUq/9pnYWfOU5FHn9MQChZKROLaP8=;
 b=tx7nnmverkK0so/QWSPano+1wpJ/VxhJ0t5kKxP6DWIuFY/phDK0xnRnCJ5mbS9l3b
 KtPfVB9FVpkl7BVEFz/v8zeTdmk5ZNOSEDaymRCyd6rnS9TSkgfVS7rp9hq2vBzYygOE
 VEvKVplVgWtH3da7FGCb/Y1a7dtM5Y55TlppWQXA4Zu30P8xhF+aB7hAQqUkunV4DubF
 hPfEBbU6PiFjaRBl7NoCaD/sMPj+M4bK1S1ew1K9ahJEDfq9DMZQAc2qlMBzlrrRYYUJ
 jlC99We22EiCQspigCbvPVQPhptgLYLAsC699zaHcNFDmEt2IQkwYWW2UOzOovXLTnnT
 T08g==
X-Gm-Message-State: AOJu0YwREpI/OZ2gwP3sM9GrfGcr/n+Fia+7ziKjBCfOXUWWETMcijSb
 CNVuKA03OhdAjywkVaqlH1Xf4zFUB282LayQwH75V0KFw5PUWs/Kr3rUjDJ48tfsutA=
X-Gm-Gg: ASbGncv7MSRynApcHE79XIcBbP2vmbJRfHjVI4iwwP/HkBL4xx1wH28LgWNlwsxAeOc
 9XqIlUR0P46dZKBB7JAfCFLiQ+8emI66/kXINWrOjYwfIozXYb/Ip8U7Vo8gLTq0JQU1Q4+YU3e
 RIchgsv8FeciCJJ2nQVCHr1eOdqDf1ietY1E02t5Qpx+pWGwLi4VCMjIIJdz/w3gGOQTFXvfPMR
 BLQaN64WzquFin24Yd8WkBQuMA7mphDFMod5FMzTZvmBbgZ2aW3MmilMHCFQ3sty6GXCN/wCaOx
 UkUX1burxD4WK0/UELhlV16kWScF0WWBbYk8htMDD3xI8l7M5MpoW7FuFjsForef+a0iKipO2kM
 8KFvjiXUEOXLmncXuppE4LBw=
X-Google-Smtp-Source: AGHT+IEAcrNNsRTK0Ud485h0nhmLpFHTDruH1qnwukJVPGEW6I3805c9yKqwj93H0gGDERiMjcXNPw==
X-Received: by 2002:a17:906:4786:b0:afe:e7f1:28a2 with SMTP id
 a640c23a62f3a-b01d8c7835emr1281760466b.23.1756831853581; 
 Tue, 02 Sep 2025 09:50:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04190700a4sm696958166b.63.2025.09.02.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 09:50:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F3955F8DF;
 Tue, 02 Sep 2025 17:50:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] docs/system: merge vhost-user-input into
 vhost-user-contrib
Date: Tue,  2 Sep 2025 17:50:48 +0100
Message-ID: <20250902165048.1653323-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902165048.1653323-1-alex.bennee@linaro.org>
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
index 7f931737cc1..04588fa78ab 100644
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
index 00000000000..10a92c19e82
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
+vhost-user-block is a backed for exposing block devices. It can
+present a flat file or block device as a simple block device to the
+guest. You almost certainly want to use the :ref:`storage-daemon`
+instead which supports the wide variety of storage modes and exports a
+number of interfaces include vhost-user.
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
2.47.2


