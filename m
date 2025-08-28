Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B428C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ura3a-0008UK-S3; Thu, 28 Aug 2025 06:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ura3Y-0008Tg-WD
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:40:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ura3W-00016H-1z
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:40:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so5017095e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756377630; x=1756982430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k0m/MiRDszBkIMo8H90TBjCbJGBTX2Nf1dQSOE54bBM=;
 b=TftS4Aq3jAoOUzEfA4lZXb54yr9CxSmi5g1L4On1ElkjKgt16v82yNPCQiUkDo3eyu
 XFhpDyOTr2yrp4UTkCs+Zl2LyFxmKUr7mOLbZsHNZikUzJW273RGQEPb8eSqI/erqovG
 XNPm1o1J8u5Hv8GCKQGdkQdGIF8m692VuVv9vkvmDdZLVplKBlPIJFC4jpliVrejXxTK
 LdEanqqePUXPoJ9YRfE+OzfN4jxSJ/IouVlFD0RFUpJ12fWBpPhZXBKHLNj9g8YLeElr
 ROV8h9IpfaPINS1eQXfynwyA4nyA2tkLJVHOLRUi569Cmvbn6TbKmlpYV7/0/mcMRSAS
 xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756377630; x=1756982430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k0m/MiRDszBkIMo8H90TBjCbJGBTX2Nf1dQSOE54bBM=;
 b=ZboOgavr9TqWgbyf96p4U+aLCVDOA/4VdyR+sUi1mug42rZu348JhwHcDkcM7NX+VJ
 rcuwZVV0SwrcjKwFepoWVnNUsT6ENTI26QKZqvmjWpGqGW1Qy5RCbDz6/h/bP1inWg9k
 MrmeULSyZ3LbR6lhz79QjTnWMcMpveOEDp3SRvYsrc6bv4irWO2thGO2ANUYfiDfzuiY
 PyYZPTQbQYHrGxHQOU/f8apXsEFIlM3z884ur8NKdARX2vV9CpC/5K2MZx59kzmiqZ1X
 7zqmAqHIM2YVCe57IFjLTI5A7WT4Lj/sPQyUnpMRwNzJZg1bzYXalctVXqAdcdDPkJSy
 iUAw==
X-Gm-Message-State: AOJu0YxVoDWDfdnJ60tXD0rt+yqDlOwQI6OUBy8wOTmZ8hwDOgFyH4V5
 kNJWaAKljwNSV0vNK0oh4ouRsJj47MAMU4F1dgVe3R3wS73kbVYRXx1UO58EmtQvpXA=
X-Gm-Gg: ASbGncstCF8tz3treiI+tQ4IYTDaFBvgD/87zb57mPqTLOhtqGzRcRH+b+MB02xcLL9
 1wZIB8HWxx8h/33CLhK7ppgx1qITRqVkbsvs5CSHqHWK0EJxPPWjFZp+L0y+GzWl19e+lG6zgdZ
 rEgCla3PhdRfljTCnUmrBehLuDGmimtKw6Hq64k4Zl3lgF7qG5isYCAZswdj/BQWUw5IEbRdzMf
 yzpwdtZNxoUKcn+/0nSpil12QMd+g7Ls17CQe2kSss4ep8pQDevxUjotzl8rIM52L/Rs/grB4TK
 IDGaj9+Tx8LrCCHxxAg2QrclLpFyh0VkDucTDRoyleqSmbBH5jKx0wZHA258xNzCYPweaG6yTn3
 eRMo8Ju8tZyEh02hyHj6ARkMjM6+BnxZkYg==
X-Google-Smtp-Source: AGHT+IFht/k1Opl5HpjrlOw8bUj1gXIv2p70pjTy6NPe89EqE5BKI5XWW6NiCvv/KrMC6cQL1WhTAg==
X-Received: by 2002:a05:6000:4025:b0:3cc:faaa:ec96 with SMTP id
 ffacd0b85a97d-3ccfaaaf496mr3641596f8f.0.1756377630076; 
 Thu, 28 Aug 2025 03:40:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd5997658fsm4392539f8f.46.2025.08.28.03.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 03:40:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6D395F832;
 Thu, 28 Aug 2025 11:40:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/virtio: rename vhost-user-device and make user creatable
Date: Thu, 28 Aug 2025 11:40:21 +0100
Message-ID: <20250828104021.3910859-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250820195632.1956795-1-alex.bennee@linaro.org>

---
v2
  - add review tags, ready to merge
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


