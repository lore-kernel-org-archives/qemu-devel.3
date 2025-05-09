Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D129DC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 17:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDRmz-0004gV-Bv; Fri, 09 May 2025 13:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uDRmt-0004ds-JG
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:45:33 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uDRmr-0000Wh-BN
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:45:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fab81d6677so4492614a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746812727; x=1747417527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AtqHVaNm7DM2Bot1NJNpgHHouE3xCmaMu7viybNMw78=;
 b=oDQ0cUtV1zyQvEwAnyAvgPl3OLM0lC4XIW20Cu+mEMAtEqk2kLfVz5ENG5s9sDwZMX
 nZofU1SATAGzGTVDTB1l/kY1D/9k5znjfPm2wni/2OBSIMNEB0bBB4/VOOpz1WIM1Xh9
 G8BJLLvvt+IxG7VPHbsly5LwWlxQTbUOZUTPPJtwrJ7VPPn+f5NgJsyHynYtZnzh2fnH
 cCrs1EXC16I5a+cWe9uZr6KRSF6DgTu7STMWW3sPr3sTG1MjfIHfLZQv/hDZWV1TQIG4
 FziF0psqOzO6NT5KYIyj29DiZZ+bJLReOfE824EqmfH+Aq+RfQN8ESoumXgqY0ywPOGp
 0Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746812727; x=1747417527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtqHVaNm7DM2Bot1NJNpgHHouE3xCmaMu7viybNMw78=;
 b=QdqWzFprjMzjM34dm5RTbN9Ji4hf1extUYuNquN7Y//i9zB+90MOA+qRSpvuR+1YfZ
 UUAhTpI+ta2vvKFp2Aw4/sJHt7UAr0SJhOB4rt2OFoT5HTBOKQ8bhRyPdoZKC7F6fv0b
 JVYCq8rpcHxatOd5qbuyzHTTqhS4jadWpE2/NHZhpHW4G5kMqNGZ5HLh3q+55yWdYGJA
 Tbrj+rdinCL5k29rdx1kDypCctGjtp6AS9Y8PDR8E/ZTUTWyZmNxSUrIShlHmnkGQXfC
 QjmpOJkjKD9Xfnyo7/7fELqWg7TomwBJcCSXokDQEJHxBxI2UTSkjuAh+DJYo7AEh91E
 UnFw==
X-Gm-Message-State: AOJu0YzWb+6YQfz1IOpPzLh4DBxBenvdPuxeqY3k1ijR0HTBwgUFZj4u
 zad1RBX9aL8eVEV1sUiFggaoFFU42m2HjQVh2QwgEKH3/Jtc9122nDgarQ+/lps=
X-Gm-Gg: ASbGnct6JnH9ufJRz2+SkAI49//cvGtWxW3gGh6SfR7pBbvZqWJMY4+7hwBqIy5+wO/
 qEHf2uaUCGeZLBbqhdEBdOxvvKHIfKpHk5Z24KbMOXfYx5jmAfhctOSzAUw9TjpX8w6uB2sV2dD
 nhuxpe2bboOEeyUWncxIX15Vi8O/bQdNWcYk4cVmG4TCNka3zggh4q4KOMnHIMJ7sdUmnhD2hPJ
 xCrim2oSVvI81O+ylBfnOeRxeEiOBlVaZp+xUKLzlCHPX8pCoAN9FFt7d2okSFOFkvvT79j5fJt
 7tnWdxhvtLGKhMN5u++1xK59HVPfv3lfYUET2Nag8IE=
X-Google-Smtp-Source: AGHT+IHnlw9ZRWAKwgdjiKlv1AD4q5iM9OFrWYlIwRyjBWOKi1yUzHKqYhlHE/LAVx4VZIHlrQekrQ==
X-Received: by 2002:a05:6402:1ecb:b0:5fc:bb1d:71e4 with SMTP id
 4fb4d7f45d1cf-5fcbb1d76efmr749614a12.6.1746812726581; 
 Fri, 09 May 2025 10:45:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9d70d55bsm1642672a12.65.2025.05.09.10.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 10:45:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 428A75F8C7;
 Fri,  9 May 2025 18:45:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [RFC PATCH] hw/s390x: add vhost-user-device-ccw stub (!WIP)
Date: Fri,  9 May 2025 18:45:02 +0100
Message-Id: <20250509174502.1689585-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This Friday hack was driven by wanting to review some virtiofsd
changes. However I discovered that while virtiofsd support
VHOST_USER_PROTOCOL_F_CONFIG the current virtiofs stubs still assume
QEMU controls the config space.

Ahh I thought, but we have vhost-user-base which both supports this
and provides for a very minimal boilerplate implementation of the
various VirtIO devices. However s390x being a special beast doesn't
use mmio or pci transports but has its own special ccw transport.
Perhaps I could just follow the existing ccw devices and implement the
wrapper. So here we are:

  ./qemu-system-s390x -serial mon:stdio \
      -M s390-ccw-virtio -m 2048M -smp 2 \
      -drive file=/home/alex/lsrc/tests/buildroot.git/builds/s390x/images/rootfs.ext4,if=virtio,format=raw -snapshot \
      -kernel /home/alex/lsrc/linux.git/builds/s390x/arch/s390/boot/bzImage \
      -append "root=/dev/vda console=ttyS0" -display none \
      -chardev socket,id=vfs,path=/tmp/virtiofsd.sock \
      -device vhost-user-device-ccw,chardev=vfs,virtio-id=26,config_size=44,num_vqs=1 -s -S

with:

  ./target/debug/virtiofsd --shared-dir $HOME \
    --socket-path /tmp/virtiofsd.sock --tag home --log-level debug

and the kernel gets surprisingly far before oopsing:

  [    2.084873] virtio_blk virtio1: 1/0/0 default/read/poll queues
  [    2.097845] virtiofs virtio2: discovered new tag: home

heh I think GET_CONFIG worked because the tag can only have come from
the daemon.

  [    2.101920] Segment Routing with IPv6
  [    2.102040] RPL Segment Routing with IPv6
  [    2.102326] In-situ OAM (IOAM) with IPv6
  [    2.103443] NET: Registered PF_PACKET protocol family
  [    2.103848] virtio_blk virtio1: [vda] 122880 512-byte logical blocks (62.9 MB/60.0 MiB)
  [    2.104918] Key type dns_resolver registered
  [    2.106171] virtiofs virtio2: probe with driver virtiofs failed with error -2

Hmm disappointing...

  [    2.113538] Unable to handle kernel pointer dereference in virtual kernel address space
  [    2.113650] Failing address: 766461000242c000 TEID: 766461000242c803
  [    2.113697] Fault in home space mode while using kernel ASCE.
  [    2.113881] AS:0000000001e08007 R3:0000000000000024
  [    2.114679] Oops: 0038 ilc:3 [#1] SMP
  [    2.114837] Modules linked in:
  [    2.115351] CPU: 1 UID: 0 PID: 30 Comm: kworker/u10:1 Not tainted 6.14.5-ajb #8
  [    2.115629] Hardware name: QEMU 8561 QEMU (KVM/Linux)
  [    2.115850] Workqueue: async async_run_entry_fn

At which point my attempts to debug the s390 kernel failed because the
debug symbols don't seem to match where the kernel lives. Also its
Friday and I have a cold beer waiting for me in the fridge.

So it seems frustratingly close to being functional but as I'm going
to be away for a week I thought it was worth posting as an RFC in case
anyone wants to take a closer look.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/s390x/vhost-user-device-ccw.c | 75 ++++++++++++++++++++++++++++++++
 hw/s390x/meson.build             | 18 +++++---
 2 files changed, 88 insertions(+), 5 deletions(-)
 create mode 100644 hw/s390x/vhost-user-device-ccw.c

diff --git a/hw/s390x/vhost-user-device-ccw.c b/hw/s390x/vhost-user-device-ccw.c
new file mode 100644
index 0000000000..03881efc02
--- /dev/null
+++ b/hw/s390x/vhost-user-device-ccw.c
@@ -0,0 +1,75 @@
+/*
+ * Vhost-user generic device virtio-ccw glue
+ *
+ * Copyright (c) 2025 Linaro Ltd.
+ * Author: Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-base.h"
+#include "virtio-ccw.h"
+
+struct VHostUserDeviceCCW {
+    VirtioCcwDevice parent_obj;
+
+    VHostUserBase vub;
+};
+
+static const Property vhost_user_ccw_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+};
+
+#define TYPE_VHOST_USER_DEVICE_CCW "vhost-user-device-ccw"
+
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDeviceCCW, VHOST_USER_DEVICE_CCW)
+
+static void vhost_user_device_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VHostUserDeviceCCW *dev = VHOST_USER_DEVICE_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vub);
+
+    qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
+}
+
+static void vhost_user_device_ccw_instance_init(Object *obj)
+{
+    VHostUserDeviceCCW *dev = VHOST_USER_DEVICE_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vub, sizeof(dev->vub),
+                                TYPE_VHOST_USER_DEVICE);
+}
+
+static void vhost_user_device_ccw_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    /* Reason: stop users confusing themselves */
+    /* dc->user_creatable = false; */
+
+    k->realize = vhost_user_device_ccw_realize;
+    device_class_set_props(dc, vhost_user_ccw_properties);
+}
+
+static const TypeInfo vhost_user_device_ccw = {
+    .name          = TYPE_VHOST_USER_DEVICE_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VHostUserDeviceCCW),
+    .instance_init = vhost_user_device_ccw_instance_init,
+    .class_init    = vhost_user_device_ccw_class_init,
+};
+
+static void vhost_user_device_ccw_register(void)
+{
+    type_register_static(&vhost_user_device_ccw);
+}
+
+type_init(vhost_user_device_ccw_register)
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 3bbebfd817..a311ccca8d 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -44,14 +44,22 @@ virtio_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-ccw-net.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-ccw-rng.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-ccw-scsi.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-ccw-serial.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-ccw-md.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-ccw-mem.c'))
 if have_virtfs
   virtio_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-ccw-9p.c'))
 endif
-virtio_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-ccw.c'))
-virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.c'))
-virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-ccw.c'))
-virtio_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-ccw-md.c'))
-virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-ccw-mem.c'))
+
+if have_vhost
+  virtio_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-ccw.c'))
+  virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.c'))
+
+  if have_vhost_user
+    virtio_ss.add(files('vhost-user-device-ccw.c'))
+    virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-ccw.c'))
+  endif
+endif
+
 s390x_ss.add_all(when: 'CONFIG_VIRTIO_CCW', if_true: virtio_ss)
 
 s390x_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-ccw-md-stubs.c'))
-- 
2.39.5


