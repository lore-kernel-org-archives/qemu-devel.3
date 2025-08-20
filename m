Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAB7CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 19:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoovV-00011X-24; Wed, 20 Aug 2025 15:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uoovO-00011B-5J
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 15:56:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uoovM-0001iY-3b
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 15:56:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b9edf0e4efso169563f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755719802; x=1756324602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SUCwqd44Qvcng06lI8Kd9VZpkd8nFai0eG7YBGJxu6A=;
 b=MyblF2NpFzY7QPxhUgHdRefPS15iKAjSIlujE5P8cNrej/BGpy4iQ66ng6SjhZEZ7e
 Q9ncLYvJFil1b9Wh8Dk9gJE6yXcOv0JG2Z93VLZA0HDTdhCGDpVwIkW1Y0R3VWada3Kp
 JDsrUf+GIMwXOLva/0/bWFdO2f70ixbtcI8CO5YjOWI0npVReEEx/BqwRCIAntC/YyTD
 lTxSGU7w3n3ns2gH0IC/HPj0CxWnv6C5sMhiSwK0BfvZNU06fDZkPfpAU4iJgzgo8Uzf
 Ym9yZd3uYHx5D05pyp/Cg5QxQ5ksrfIJKBAt5418rb133LJ2pS6x2OxoIIcUQ3kPL5Mk
 mpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755719802; x=1756324602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUCwqd44Qvcng06lI8Kd9VZpkd8nFai0eG7YBGJxu6A=;
 b=DrSgRMEC2MkX/3faoJERL90w7vScREhDYL4rD08NrD5qhHxF3n2uuFdQBWbJcicRn5
 6QwbnpIFh3xyIw14T27hAxVSSMMwGwV4kEOW3aYxZ5XJBbN+NtjEEVThhKtNGY16fFlJ
 Knggej/p0GN/BS/9aFKgrVDmIVc948PVlT+G1E590pcF1qJTGaQPtPIwaw5OwS+vxeZK
 zFhSDuyb6tLyXPCg8b294T+NG/7Fdj8t+QWUwSsel5Gb7edLPJJ79Xo2FW6B156pfQpm
 z+kOMykhjUQ7IEnJR2Uul7kcsCGv+I2AIY5qCGGlHLK86N0yLLDCwXbhqAhQfM/PBCif
 Ex1w==
X-Gm-Message-State: AOJu0YyguynDw4HNzau7+IdgkQ2JWr+hqlZQlNRjvaVZY+ZVX1JIw1r7
 28QYp8byPvjzhospFR+5JMks908HWusvY2ZgGYGmukF1t5TpT4gKt2T1QnbiakIe0nY=
X-Gm-Gg: ASbGncvVXKZI/ZjuLzFqIopXTxAljEMnM3j5I5lauVX3tzIaiV87deO0oFjALwMlQHj
 VDZU6gVvvL/npE1MH9CRC9xPUStjxMSQVJrItbtHGZyJreWA+sCX8nfM3Plnv2ZGEYxnB5HA5S0
 b+CIZNwMUEsOTIXxEcS6pXQazcRP6J9k1ZSvqLF7AReXA8aBVRwbkib0QBSl+KvOB832B+uqJmI
 At32ZnGZA43pzmUfIZ5rwyCoREY84MZxZT+gpar1E4ajK9fUI4GG9t8suK0W0JaLpV5A43ItxRN
 3QwQUFB9wWjjcW2ZSntc+HojFtpchk7lD8Y/VkLCa+PPHl+g20jbfErm8hg8T42obj8kLhTNwsm
 KmbVnAe22YxYB6/92eYBXDLs=
X-Google-Smtp-Source: AGHT+IGDZdZRUFWjAgiYhJvErSFqRNbD927CciZx5N8I4uk6mZtPvymlkqA/n3K4NN5aSwJ2gCm6fQ==
X-Received: by 2002:a05:6000:290d:b0:3b7:9ae1:eb9 with SMTP id
 ffacd0b85a97d-3c4953a804cmr61327f8f.23.1755719801761; 
 Wed, 20 Aug 2025 12:56:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074d439adsm8950064f8f.21.2025.08.20.12.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 12:56:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C2CC5F898;
 Wed, 20 Aug 2025 20:56:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] hw/virtio: rename vhost-user-device and make user
 creatable
Date: Wed, 20 Aug 2025 20:56:32 +0100
Message-ID: <20250820195632.1956795-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
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

We didn't make the device user creatable in the first place because we
were worried users might get confused. Rename the device to make its
nature as a test device even more explicit. While we are at it add a
Kconfig variable so it can be skipped for those that want to thin out
their build configuration even further.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/vhost-user.rst            | 20 +++++++------------
 include/hw/virtio/vhost-user-base.h           |  2 +-
 ...ice-pci.c => vhost-user-test-device-pci.c} | 17 +++++++---------
 ...user-device.c => vhost-user-test-device.c} |  9 +++------
 hw/virtio/Kconfig                             |  5 +++++
 hw/virtio/meson.build                         |  5 +++--
 6 files changed, 26 insertions(+), 32 deletions(-)
 rename hw/virtio/{vhost-user-device-pci.c => vhost-user-test-device-pci.c} (77%)
 rename hw/virtio/{vhost-user-device.c => vhost-user-test-device.c} (87%)

diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index 35259d8ec7c..bddf8df5ed5 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -62,26 +62,20 @@ platform details for what sort of virtio bus to use.
 The referenced *daemons* are not exhaustive, any conforming backend
 implementing the device and using the vhost-user protocol should work.
 
-vhost-user-device
-^^^^^^^^^^^^^^^^^
+vhost-user-test-device
+^^^^^^^^^^^^^^^^^^^^^^
 
-The vhost-user-device is a generic development device intended for
-expert use while developing new backends. The user needs to specify
-all the required parameters including:
+The vhost-user-test-device is a generic development device intended
+for expert use while developing new backends. The user needs to
+specify all the required parameters including:
 
   - Device ``virtio-id``
   - The ``num_vqs`` it needs and their ``vq_size``
   - The ``config_size`` if needed
 
 .. note::
-  To prevent user confusion you cannot currently instantiate
-  vhost-user-device without first patching out::
-
-    /* Reason: stop inexperienced users confusing themselves */
-    dc->user_creatable = false;
-
-  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
-  rebuilding.
+  While this is a useful device for development it is not recommended
+  for production use.
 
 vhost-user daemon
 =================
diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
index 51d0968b893..387e434b804 100644
--- a/include/hw/virtio/vhost-user-base.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -44,6 +44,6 @@ struct VHostUserBaseClass {
 };
 
 
-#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
+#define TYPE_VHOST_USER_TEST_DEVICE "vhost-user-test-device"
 
 #endif /* QEMU_VHOST_USER_BASE_H */
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
similarity index 77%
rename from hw/virtio/vhost-user-device-pci.c
rename to hw/virtio/vhost-user-test-device-pci.c
index f10bac874e7..d6a9ca2101d 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-test-device-pci.c
@@ -18,13 +18,13 @@ struct VHostUserDevicePCI {
     VHostUserBase vub;
 };
 
-#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
+#define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci"
 
-OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PCI)
 
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
-    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
+    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vub);
 
     vpci_dev->nvectors = 1;
@@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
-    /* Reason: stop users confusing themselves */
-    dc->user_creatable = false;
-
     k->realize = vhost_user_device_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
@@ -51,15 +48,15 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
 
 static void vhost_user_device_pci_instance_init(Object *obj)
 {
-    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(obj);
+    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(obj);
 
     virtio_instance_init_common(obj, &dev->vub, sizeof(dev->vub),
-                                TYPE_VHOST_USER_DEVICE);
+                                TYPE_VHOST_USER_TEST_DEVICE);
 }
 
 static const VirtioPCIDeviceTypeInfo vhost_user_device_pci_info = {
-    .base_name = TYPE_VHOST_USER_DEVICE_PCI,
-    .non_transitional_name = "vhost-user-device-pci",
+    .base_name = TYPE_VHOST_USER_TEST_DEVICE_PCI,
+    .non_transitional_name = "vhost-user-test-device-pci",
     .instance_size = sizeof(VHostUserDevicePCI),
     .instance_init = vhost_user_device_pci_instance_init,
     .class_init = vhost_user_device_pci_class_init,
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-test-device.c
similarity index 87%
rename from hw/virtio/vhost-user-device.c
rename to hw/virtio/vhost-user-test-device.c
index 3939bdf7552..1b98ea3e488 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-test-device.c
@@ -1,5 +1,5 @@
 /*
- * Generic vhost-user-device implementation for any vhost-user-backend
+ * Generic vhost-user-test-device implementation for any vhost-user-backend
  *
  * This is a concrete implementation of vhost-user-base which can be
  * configured via properties. It is useful for development and
@@ -25,7 +25,7 @@
  */
 
 static const VMStateDescription vud_vmstate = {
-    .name = "vhost-user-device",
+    .name = "vhost-user-test-device",
     .unmigratable = 1,
 };
 
@@ -41,16 +41,13 @@ static void vud_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    /* Reason: stop inexperienced users confusing themselves */
-    dc->user_creatable = false;
-
     device_class_set_props(dc, vud_properties);
     dc->vmsd = &vud_vmstate;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo vud_info = {
-    .name = TYPE_VHOST_USER_DEVICE,
+    .name = TYPE_VHOST_USER_TEST_DEVICE,
     .parent = TYPE_VHOST_USER_BASE,
     .class_init = vud_class_init,
 };
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 7648a2d68da..10f5c53ac09 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -126,3 +126,8 @@ config VHOST_USER_SCMI
     bool
     default y
     depends on VIRTIO && VHOST_USER && ARM
+
+config VHOST_USER_TEST
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 3ea7b3cec83..48b9fedfa56 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -22,7 +22,7 @@ if have_vhost
     system_virtio_ss.add(files('vhost-user-base.c'))
 
     # MMIO Stubs
-    system_virtio_ss.add(files('vhost-user-device.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_TEST', if_true: files('vhost-user-test-device.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
@@ -30,7 +30,8 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
 
     # PCI Stubs
-    system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
+                         if_true: files('vhost-user-test-device-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'],
                          if_true: files('vhost-user-gpio-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_I2C'],
-- 
2.47.2


