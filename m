Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAC3CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWm-0002Fw-PV; Thu, 16 Oct 2025 11:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWi-0002Er-M0
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWT-0001Am-Bu
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso533632f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627045; x=1761231845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFnHEU9xjltvh+ypLAj3KV62Jnkg0sBcs3wWuIX0eJ0=;
 b=zubRwJME5D5PsdWfsnqUeGr/BECIKKcY5zwLKczJaY7/cfjaolN822aG0gp/OOi9Vw
 ym+TSIXMRQg9J4Sv8cmWUK6pN0uy58D9E1NqFM6Xv+dp/PD4F2ZTV+F01lhOZ0XTJIpS
 zbba+vZcKVEjdtHv20F2l31H8x1i2gZgG9YA2rr5YfmvKzbpz6tfjkfeUn2C4Uc4rGsv
 eWLE7unxtRoBMw+ZHEVoUDvbZJWFw6ltjqdluf7KPiq+BmI8di9Bcjb5BVooixqU5dGs
 dgTMhdIt7UpOaZalkpTh8/FenTYDkqELo9ax50WtHohsMGiWO56owygOQTlneczQQZQ1
 otng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627045; x=1761231845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFnHEU9xjltvh+ypLAj3KV62Jnkg0sBcs3wWuIX0eJ0=;
 b=iW87QLOlhamFA3gQ5xS3QkneTYWX0ZpWuJtmoUqgnfSyDXn6mrj0DFLfDXZFn2XDlo
 RNgA/axaOFZL9yfAnuwuqyH4clGXTctXr+sKoPNbzTHxaF86n0kPbdJSTwAOChd3/o/i
 gkG2BX8qhxXxEXGIxmPAiigGoCC0TeYmTos47ddetggZaM05yGqVQydRVaMQrHmzpPqi
 n066BW3M4MQVbr48UaOQo3TnSeLOCdsW8eRk3ZJLIl+a1bkIvizLF4V2qSF4Iguy1ZGu
 F68hy5etd4aYL0HoKrCO6BJohNdrfkmSQPUsLHq96nnhNZNsjslX1eOHKI4jydXk9QG0
 tRCA==
X-Gm-Message-State: AOJu0YzBgtKdm87+GkR88meY+5rE6RRNIY/8TIyjtMxm46Z+c2aAg9yK
 0Wm3D5EyP3/5oCZfYStQWOYCfveU4t7ffff8J/cz4QhTNXOFyeFESJaR6jKp33xWGTU=
X-Gm-Gg: ASbGncs0sfjYYJO/QWoEfvgPLcyPBAOfCY+In+52eKvnEV32F1di2U+g78SX99NsiC4
 Xu7fWOqq2XTelGT3fIaIqlHYKtGmKx38K9Nwapb6DO7lKYaqCJXMenRtAWHNnMmksviTyk0fVCG
 umaLqKjPsr7ONqoLGdJhATN/BsxhMTYBgp15aD+dmUBxXPwRUPkNHOFwMFcf0hBSUhtbJTmbO4K
 GheU2Uevlz9gevroxrNCdnJJOYFW4DgEa0qaqoUtx0LO5sLuim+xwRo4x18mEsOOFH44MN1h9Wj
 osbGpS5rvM/D4rpWXwKCKsOCLVLbwnic+6K86LSYhGAQlfN8ZbmqRUnWKdzURNH/e4palmze3rw
 mcPGqc/pKs4uMce1s4QhnMGzj6QYX1o2OFS0F1UwBY1YuSn6xIW67F40ub6qTcTDbqjniqC3o44
 V6I1kGhkd/Lrs=
X-Google-Smtp-Source: AGHT+IFF8H43+e8MRI2EbA9TpwS6S4VuaDGg6SQ44rLsKOAXzusgPe/QpAuz22b3YblyUKsBJ46SuA==
X-Received: by 2002:a5d:5888:0:b0:3ec:2ef7:2134 with SMTP id
 ffacd0b85a97d-42704d54b25mr281115f8f.18.1760627045189; 
 Thu, 16 Oct 2025 08:04:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583424sm34452478f8f.21.2025.10.16.08.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 425B95FADF;
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
Subject: [PATCH 08/11] docs/system: split VirtIO devices from the rest
Date: Thu, 16 Oct 2025 16:03:53 +0100
Message-ID: <20251016150357.876415-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix recommend/recommended
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
index 00000000000..fc457ca74c7
--- /dev/null
+++ b/docs/system/devices/virtio/index.rst
@@ -0,0 +1,30 @@
+VirtIO Devices
+==============
+
+VirtIO devices are paravirtualized devices designed to be efficient to
+emulate and virtualize. Unless you are specifically trying to exercise
+a driver for some particular hardware they are the recommended device
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
2.47.3


