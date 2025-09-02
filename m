Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BBCCA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUDi-0008G9-Ji; Tue, 02 Sep 2025 12:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDh-0008Ff-0V
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDe-0004QI-LF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61cebce2f78so10440327a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756831853; x=1757436653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPTO+LPEzNEOE+7bSlvoPAbn0JAQ047SagKkIcn3yp8=;
 b=NBF5SrxPYZ3w6asH9XjlyepbioiuVhF8KtO7XhjClfie4LgZ4lQvhdNwic7swjRBXn
 HfdCt9H39+oBkQryXPqrLZDuuiHPEsoRIkoIHJirl1p2IwE2Yh3F0l/4phhpMMB9FzfG
 BzhmmcuvYy+CFChIzNgUHs+PhErua3c+GioUTvnnwrYw0dkso0WzN94fFtTcC63i6cSi
 +3caGi/c6/3K54jH5BslrHdhBCnpdg/q3t2e5JA/RgSFc2jpgReJIiiZrEwvFbRL+Zt7
 XpwtFowsn4eBjEh7u7fZ/LaCTxbyzQFKpS5NbarodCj1SZ0Tm2o9mzoXsePGthtk8atM
 BbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756831853; x=1757436653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPTO+LPEzNEOE+7bSlvoPAbn0JAQ047SagKkIcn3yp8=;
 b=paYKxx7ezzfDJ4zO7FkzyuKtmgxxSzkA1MhoJNTdBQdtUbqkX8w6FxzlvPxRzAqPby
 xlF773M6udKd9qwpqT6DPZxAro/ppGCshVsFRy9KJNE+/D5dSH+pS7najOW4tWX47Qhv
 HlLI7TDz9BId0MezEhcCM3gX1zX2Z2PkLP0v7/DLZqrHcIzBNvMCGAKN3h+yiAuvCB4G
 8ceIM9VXxN8EjpS2VswxD6YYxIeh8sfKR7y3JR5IGOIF4s3ntymfNA51GdiOTwdDMG4p
 N/P9GLOH2njkPr4NEDcvUzWChw+G4BZ9h0E5HtS8q8vP+RpdQVYAo54OqYHqs030Vxbo
 lZbw==
X-Gm-Message-State: AOJu0Yz3Nk4OUiy10dYGPM3ZGNjK2bmEww4rKJ3Si6cCN+QLDZg7jG9r
 RrIU8BXXzVhcin9Rjq4/5i35qKt/1bvM/0gRt3oRFy7OIL6yrimr4ydoBLvUyi9k1ME=
X-Gm-Gg: ASbGnctIEoYTnNmE46Hg7bmCY6oBlPv673ZHwvNUVdkrhxi5yxxRG86t2fO/lhduNVu
 ffWLMIsysrVblN0f7jp5szxXBVdBG77Y4QR//22H5INJsv5OoRA+EvRTJM8iRZELRYWFLDxQ7ZY
 NGOeL4A5rikRC6iSzORa9/djhuD1LO8M7hR8p1LyZs+evU/cy1//a4EDLxQJHy9qvHqLyYRkqSD
 z1vk9359F76GlKIsWB5bnCoF3+cBR9FEp73TmKh7kP33eBwCxEKrTyyp7wCwEH0ReI9fe54TD9A
 PYFYU2DMAiTTST3AOzd1yqPf3wY+Oki6J/htyR2qQ8VYUokFP8EUumpQlOD40X04mgaJ6Pzh6Wh
 XKwgpYUkjWURkF4q0dhTKh3c=
X-Google-Smtp-Source: AGHT+IHtnqw/QdjhejWTIrkOri4pNOQ9Curwu5/znzs8bCP0KcSCwiDucG8nA2vpfxOKZeNwX8XMbA==
X-Received: by 2002:a05:6402:34d0:b0:61e:92a2:351e with SMTP id
 4fb4d7f45d1cf-61e92a23870mr6927763a12.37.1756831852843; 
 Tue, 02 Sep 2025 09:50:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4bbbd1sm9960037a12.34.2025.09.02.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 09:50:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7D005F8D7;
 Tue, 02 Sep 2025 17:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/4] docs/system: split VirtIO devices from the rest
Date: Tue,  2 Sep 2025 17:50:45 +0100
Message-ID: <20250902165048.1653323-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902165048.1653323-1-alex.bennee@linaro.org>
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

In an effort to tidy up our device documentation split the VirtIO docs
from the rest of the index and put the index to them at the front of
the list. Sort the remaining entries alphabetically and tweak the
references appropriately.

Add a short preface to the VirtIO section nudging users to use VirtIO
unless they specifically want a particular piece of hardware
emulation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/device-emulation.rst              | 18 +++++------
 docs/system/devices/vfio-user.rst             |  2 +-
 docs/system/devices/virtio/index.rst          | 30 +++++++++++++++++++
 .../devices/{ => virtio}/vhost-user-input.rst |  0
 .../devices/{ => virtio}/vhost-user-rng.rst   |  0
 .../devices/{ => virtio}/vhost-user.rst       |  0
 .../devices/{ => virtio}/virtio-gpu.rst       |  0
 .../devices/{ => virtio}/virtio-pmem.rst      |  0
 .../devices/{ => virtio}/virtio-snd.rst       |  0
 9 files changed, 38 insertions(+), 12 deletions(-)
 create mode 100644 docs/system/devices/virtio/index.rst
 rename docs/system/devices/{ => virtio}/vhost-user-input.rst (100%)
 rename docs/system/devices/{ => virtio}/vhost-user-rng.rst (100%)
 rename docs/system/devices/{ => virtio}/vhost-user.rst (100%)
 rename docs/system/devices/{ => virtio}/virtio-gpu.rst (100%)
 rename docs/system/devices/{ => virtio}/virtio-pmem.rst (100%)
 rename docs/system/devices/{ => virtio}/virtio-snd.rst (100%)

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 911381643f1..db714ad47aa 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -82,22 +82,18 @@ Emulated Devices
 .. toctree::
    :maxdepth: 1
 
+   devices/virtio/index.rst
+
    devices/can.rst
+   devices/canokey.rst
    devices/ccid.rst
    devices/cxl.rst
-   devices/vfio-user.rst
-   devices/ivshmem.rst
+   devices/igb.rst
    devices/ivshmem-flat.rst
+   devices/ivshmem.rst
    devices/keyboard.rst
    devices/net.rst
    devices/nvme.rst
-   devices/usb.rst
-   devices/vhost-user.rst
-   devices/virtio-gpu.rst
-   devices/virtio-pmem.rst
-   devices/virtio-snd.rst
-   devices/vhost-user-input.rst
-   devices/vhost-user-rng.rst
-   devices/canokey.rst
    devices/usb-u2f.rst
-   devices/igb.rst
+   devices/usb.rst
+   devices/vfio-user.rst
diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
index b6dcaa5615e..30c2215f4ea 100644
--- a/docs/system/devices/vfio-user.rst
+++ b/docs/system/devices/vfio-user.rst
@@ -6,7 +6,7 @@ vfio-user
 
 QEMU includes a ``vfio-user`` client. The ``vfio-user`` specification allows for
 implementing (PCI) devices in userspace outside of QEMU; it is similar to
-``vhost-user`` in this respect (see :doc:`vhost-user`), but can emulate arbitrary
+``vhost-user`` in this respect (see :doc:`virtio/vhost-user`), but can emulate arbitrary
 PCI devices, not just ``virtio``. Whereas ``vfio`` is handled by the host
 kernel, ``vfio-user``, while similar in implementation, is handled entirely in
 userspace.
diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/virtio/index.rst
new file mode 100644
index 00000000000..bb44b14423e
--- /dev/null
+++ b/docs/system/devices/virtio/index.rst
@@ -0,0 +1,30 @@
+VirtIO Devices
+==============
+
+VirtIO devices are paravirtualized devices designed to be efficient to
+emulate and virtualize. Unless you are specifically trying to exercise
+a driver for some particular hardware they are the recommend device
+models to use for virtual machines.
+
+The `VirtIO specification`_ is an open standard managed by OASIS. It
+describes how a *driver* in a guest operating system interacts with
+the *device* model provided by QEMU. Multiple Operating Systems
+support drivers for VirtIO with Linux perhaps having the widest range
+of device types supported.
+
+The device implementation can either be provided wholly by QEMU, or in
+concert with the kernel (known as *vhost*). The device implementation
+can also be off-loaded to an external process via :ref:`vhost user
+<vhost_user>`.
+
+.. toctree::
+   :maxdepth: 1
+
+   virtio-gpu.rst
+   virtio-pmem.rst
+   virtio-snd.rst
+   vhost-user.rst
+   vhost-user-input.rst
+   vhost-user-rng.rst
+
+.. _VirtIO specification: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devices/virtio/vhost-user-input.rst
similarity index 100%
rename from docs/system/devices/vhost-user-input.rst
rename to docs/system/devices/virtio/vhost-user-input.rst
diff --git a/docs/system/devices/vhost-user-rng.rst b/docs/system/devices/virtio/vhost-user-rng.rst
similarity index 100%
rename from docs/system/devices/vhost-user-rng.rst
rename to docs/system/devices/virtio/vhost-user-rng.rst
diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
similarity index 100%
rename from docs/system/devices/vhost-user.rst
rename to docs/system/devices/virtio/vhost-user.rst
diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
similarity index 100%
rename from docs/system/devices/virtio-gpu.rst
rename to docs/system/devices/virtio/virtio-gpu.rst
diff --git a/docs/system/devices/virtio-pmem.rst b/docs/system/devices/virtio/virtio-pmem.rst
similarity index 100%
rename from docs/system/devices/virtio-pmem.rst
rename to docs/system/devices/virtio/virtio-pmem.rst
diff --git a/docs/system/devices/virtio-snd.rst b/docs/system/devices/virtio/virtio-snd.rst
similarity index 100%
rename from docs/system/devices/virtio-snd.rst
rename to docs/system/devices/virtio/virtio-snd.rst
-- 
2.47.2


