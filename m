Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FAACCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnL2-0007aY-Ag; Mon, 20 Oct 2025 06:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKz-0007Yv-Qi
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:01 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKx-0000hG-Hq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-62fca01f0d9so8674059a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956917; x=1761561717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXw1SscUx+MXLaJBI0mjTbbWzaRi5EgFazzwVthoJSQ=;
 b=NCEVImll5vI/o4bEffAJJL6SWdnsDVdtUzUT0IZuvbsibnLCbkwPOHett/5uVaSZeH
 MfSBspUd8TNTtaXFUPbpWMNVV7JwnDslv/0QyERQ9SNqXDgl4og3V2EM7YuICqU3Q73O
 a4WtAufhYv+gHUNwiFrjpSPKYTlBTDqvrlcdTgVNeSntcPtSNH6NrSiO3pNDRcWfc8qP
 fwDuQ2C4T0CN+5PgwvgvvTR6THpxEAKrGBxSuRTxHjbzYX9oQWQpRkJyqdwAD5vhJz3G
 f5ZFAEmR5aBeY+IH14wjmVoG0I80H3SfcQmlcd/HMxZSSzjlju8PH3QjZgY2U2jLOKc2
 S0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956917; x=1761561717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXw1SscUx+MXLaJBI0mjTbbWzaRi5EgFazzwVthoJSQ=;
 b=JOA8IR1ozzdKq0ch3WkHclRHD8yymyvhyzFcAlX3HwYkq1sCLnG6xaYkDxtsiy1rVC
 P2Lne7PLtFYcyVrqqcbCQahz/NlScFus2dCvfB9rVTLFkAQLy0csiChTNxeMFvr4qR9p
 g5sTIsQM/b31dw3uOV7eW4ZoVi8rWbp6rDP0gghRN/MtLpuVdB2o1jZH5Axxrsp1QNhs
 oD7+LRoUURIiG4jk9vNvMgWaEYAXLc/8R2F3MDYoj3GxldXx3OCpAw6qe/iwAygCFQ3m
 PrbMbeghg4JlKxwY61ck73Ff8OyBG/hDyIxZdcNyQljMXOHmAcLsNixGJGxwbx8IuQko
 9fhg==
X-Gm-Message-State: AOJu0YyyauKteKJmYi1VKstI0G1UyfApV5rzoq59jZEucL2JwlDb7U+R
 SqcB2l6Ai8gFPSstlpfx4S8b2cH24jARzti923H+japD4+NYRzFzUdGGBZpw3JdjZI8=
X-Gm-Gg: ASbGncsIW6JTdgbNz7OmFdHVldtHS9LFt90ub7wC2GbHN/4cs8+M/jo2wXR8wbS9hQY
 vFXOmCn+nawPWBnbPoqdAFb0iDWSj/dKuQqk8kWA1+VamV0SHbVbjhHnBX6A6gYSRAT/Fxq+uxN
 6uM/tQiUMgXCsBqD+WEBUxWFjQ9xCfCTmA66BNPBH0W7FiBa/96044E0XVo8H5k+d7opz472XQ7
 AP5U/0KKj391gwpOVMZPsvo7bH4ZmnC1Z1J8E8cO97yLOXFBPsTdslOayBH6T1FNTDC6xmUap26
 9PceyHPT5xfu0ntdmnvdj+iCxE/0q5JVjnScGf2rRJxpAIkNjrfaxwmpzSbC1yd99ICR6GruFc1
 22qhmOFQ38FBF2zRGjclMOahH83P5XORJt6dg5i0fUG0lsvOMGBFR0cmca87DTIHqbNMzkK9SC7
 M8XC9ma6yJ7oI=
X-Google-Smtp-Source: AGHT+IFOPWMzOVmS+J+ogN5oE/tyavikzUZ4TCy31qq5WO+3y0n7TAgOJYkbD9PehL0tw13o/r3Avw==
X-Received: by 2002:a17:907:9607:b0:b3e:26ae:7288 with SMTP id
 a640c23a62f3a-b6471d48331mr1417981966b.8.1760956917493; 
 Mon, 20 Oct 2025 03:41:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65ebf434f0sm748865066b.82.2025.10.20.03.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CF2D60D98;
 Mon, 20 Oct 2025 11:41:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/11] docs/system: split VirtIO devices from the rest
Date: Mon, 20 Oct 2025 11:41:46 +0100
Message-ID: <20251020104149.4034124-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: John Levon <john.levon@nutanix.com>
Message-ID: <20251016150357.876415-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


