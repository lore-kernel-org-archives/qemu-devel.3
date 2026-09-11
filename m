Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C4AC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52QT-0004nA-05; Fri, 11 Sep 2026 10:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52N8-0002My-V7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52N2-0007tz-6C
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yZ5P8bgdNVXz/IjME/g+paRrVamgXXAKRQr0EaewDE=;
 b=ZzIxpCvjOMF9fW5oe04nLmO13mA2kjgwrqUbDsX64MXPTK9Ma0jVkTCcjY+v8XrmYBIOok
 7Czb2AQP1kQdViegZMXAm8T50phePsrRlSLSJ4Jv52DcxpIEZCyXPKqBweJGg1QB86FENk
 b0tli4QvYqo1Zyez2qN/ih5zYpMzpBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-r_vv3jVcPcaZDrubIcVqRg-1; Fri,
 11 Sep 2026 10:36:45 -0400
X-MC-Unique: r_vv3jVcPcaZDrubIcVqRg-1
X-Mimecast-MFC-AGG-ID: r_vv3jVcPcaZDrubIcVqRg_1789137404
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C87F19539AB; Fri, 11 Sep 2026 14:36:44 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32CA3300022B; Fri, 11 Sep 2026 14:36:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/28] hw: mark all remaining virtio object types as secure
Date: Fri, 11 Sep 2026 15:36:05 +0100
Message-ID: <20260911143627.2743803-7-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are all intended for use in a virtualization scenario and must
provide a security boundary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/9pfs/virtio-9p-device.c       | 1 +
 hw/audio/virtio-snd.c            | 1 +
 hw/block/virtio-blk.c            | 1 +
 hw/char/virtio-console.c         | 2 ++
 hw/char/virtio-serial-bus.c      | 3 +++
 hw/display/virtio-gpu-base.c     | 3 ++-
 hw/display/virtio-gpu-gl.c       | 1 +
 hw/display/virtio-gpu-rutabaga.c | 1 +
 hw/display/virtio-gpu.c          | 1 +
 hw/input/virtio-input-hid.c      | 5 +++++
 hw/input/virtio-input-host.c     | 1 +
 hw/input/virtio-input.c          | 1 +
 hw/net/virtio-net.c              | 1 +
 hw/scsi/virtio-scsi.c            | 2 ++
 hw/virtio/vdpa-dev.c             | 1 +
 hw/virtio/virtio-balloon.c       | 1 +
 hw/virtio/virtio-bus.c           | 1 +
 hw/virtio/virtio-crypto.c        | 1 +
 hw/virtio/virtio-input-pci.c     | 2 ++
 hw/virtio/virtio-iommu.c         | 2 ++
 hw/virtio/virtio-md-pci.c        | 1 +
 hw/virtio/virtio-mem.c           | 1 +
 hw/virtio/virtio-mmio.c          | 2 ++
 hw/virtio/virtio-nsm.c           | 1 +
 hw/virtio/virtio-pmem.c          | 1 +
 hw/virtio/virtio-rng.c           | 1 +
 hw/virtio/virtio-rtc.c           | 1 +
 27 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 2774fc2290..a4572c851d 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -288,6 +288,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(V9fsVirtioState),
     .class_init = virtio_9p_class_init,
+    .secure = true,
 };
 
 static void virtio_9p_register_types(void)
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 694bcebb60..eacabca5eb 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1410,6 +1410,7 @@ static const TypeInfo virtio_snd_types[] = {
       .parent        = TYPE_VIRTIO_DEVICE,
       .instance_size = sizeof(VirtIOSound),
       .class_init    = virtio_snd_class_init,
+      .secure        = true,
     }
 };
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff..bcd252482d 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1951,6 +1951,7 @@ static const TypeInfo virtio_blk_info = {
     .instance_init = virtio_blk_instance_init,
     .class_init = virtio_blk_class_init,
     .class_size = sizeof(VirtIOBlkClass),
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 4737b9a56e..e5798a5f4b 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -266,6 +266,7 @@ static const TypeInfo virtconsole_info = {
     .name          = "virtconsole",
     .parent        = TYPE_VIRTIO_CONSOLE_SERIAL_PORT,
     .class_init    = virtconsole_class_init,
+    .secure        = true,
 };
 
 static const Property virtserialport_properties[] = {
@@ -291,6 +292,7 @@ static const TypeInfo virtserialport_info = {
     .parent        = TYPE_VIRTIO_SERIAL_PORT,
     .instance_size = sizeof(VirtConsole),
     .class_init    = virtserialport_class_init,
+    .secure        = true,
 };
 
 static void virtconsole_register_types(void)
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 83a033ce85..60ef9c4f10 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -836,6 +836,7 @@ static const TypeInfo virtser_bus_info = {
     .parent = TYPE_BUS,
     .instance_size = sizeof(VirtIOSerialBus),
     .class_init = virtser_bus_class_init,
+    .secure = true,
 };
 
 #ifdef CONFIG_HMP
@@ -1091,6 +1092,7 @@ static const TypeInfo virtio_serial_port_type_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(VirtIOSerialPort),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(VirtIOSerialPortClass),
     .class_init = virtio_serial_port_class_init,
 };
@@ -1169,6 +1171,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIOSerial),
     .class_init = virtio_serial_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 270fbaae10..7a78d1ee83 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -320,7 +320,8 @@ static const TypeInfo virtio_gpu_base_info = {
     .instance_size = sizeof(VirtIOGPUBase),
     .class_size = sizeof(VirtIOGPUBaseClass),
     .class_init = virtio_gpu_base_class_init,
-    .abstract = true
+    .abstract = true,
+    .secure = true,
 };
 module_obj(TYPE_VIRTIO_GPU_BASE);
 module_kconfig(VIRTIO_GPU);
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c466..75174b6731 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -233,6 +233,7 @@ static const TypeInfo virtio_gpu_gl_info = {
     .parent = TYPE_VIRTIO_GPU,
     .instance_size = sizeof(VirtIOGPUGL),
     .class_init = virtio_gpu_gl_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VIRTIO_GPU_GL);
 module_kconfig(VIRTIO_GPU);
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 041216a10d..aba37efec5 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1170,6 +1170,7 @@ static const TypeInfo virtio_gpu_rutabaga_info[] = {
         .parent = TYPE_VIRTIO_GPU,
         .instance_size = sizeof(VirtIOGPURutabaga),
         .class_init = virtio_gpu_rutabaga_class_init,
+        .secure = true,
     },
 };
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 55a1c7f80f..b1629a28f1 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1915,6 +1915,7 @@ static const TypeInfo virtio_gpu_info = {
     .instance_size = sizeof(VirtIOGPU),
     .class_size = sizeof(VirtIOGPUClass),
     .class_init = virtio_gpu_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VIRTIO_GPU);
 module_kconfig(VIRTIO_GPU);
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 1019d6b2e5..4854860807 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -242,6 +242,7 @@ static const TypeInfo virtio_input_hid_info = {
     .instance_size = sizeof(VirtIOInputHID),
     .class_init    = virtio_input_hid_class_init,
     .abstract      = true,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -315,6 +316,7 @@ static const TypeInfo virtio_keyboard_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_keyboard_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -369,6 +371,7 @@ static const TypeInfo virtio_mouse_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_mouse_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -442,6 +445,7 @@ static const TypeInfo virtio_tablet_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_tablet_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -527,6 +531,7 @@ static const TypeInfo virtio_multitouch_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_multitouch_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 633547cc4f..0d01e00cfc 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -248,6 +248,7 @@ static const TypeInfo virtio_input_host_info = {
     .instance_size = sizeof(VirtIOInputHost),
     .instance_init = virtio_input_host_init,
     .class_init    = virtio_input_host_class_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 6494cfbbe8..cccbeec1e3 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -329,6 +329,7 @@ static const TypeInfo virtio_input_info = {
     .class_size    = sizeof(VirtIOInputClass),
     .class_init    = virtio_input_class_init,
     .abstract      = true,
+    .secure        = true,
     .instance_finalize = virtio_input_finalize,
 };
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d..506a0366dc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4374,6 +4374,7 @@ static const TypeInfo virtio_net_info = {
     .instance_size = sizeof(VirtIONet),
     .instance_init = virtio_net_instance_init,
     .class_init = virtio_net_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bf64d1231a..0fa3f11a43 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1444,6 +1444,7 @@ static const TypeInfo virtio_scsi_common_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIOSCSICommon),
     .abstract = true,
+    .secure = true,
     .class_init = virtio_scsi_common_class_init,
 };
 
@@ -1452,6 +1453,7 @@ static const TypeInfo virtio_scsi_info = {
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VirtIOSCSI),
     .class_init = virtio_scsi_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 6dc684ab09..bd95467652 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -392,6 +392,7 @@ static const TypeInfo vhost_vdpa_device_info = {
     .instance_size = sizeof(VhostVdpaDevice),
     .class_init = vhost_vdpa_device_class_init,
     .instance_init = vhost_vdpa_device_instance_init,
+    .secure = true,
 };
 
 static void register_vhost_vdpa_device_type(void)
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..4d1c81e7d6 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -1083,6 +1083,7 @@ static const TypeInfo virtio_balloon_info = {
     .instance_size = sizeof(VirtIOBalloon),
     .instance_init = virtio_balloon_instance_init,
     .class_init = virtio_balloon_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 9b545acda3..9bf62a7060 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -363,6 +363,7 @@ static const TypeInfo virtio_bus_info = {
     .parent = TYPE_BUS,
     .instance_size = sizeof(VirtioBusState),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(VirtioBusClass),
     .class_init = virtio_bus_class_init
 };
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 79e2acb56c..7d4c944f35 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1314,6 +1314,7 @@ static const TypeInfo virtio_crypto_info = {
     .instance_size = sizeof(VirtIOCrypto),
     .instance_init = virtio_crypto_instance_init,
     .class_init = virtio_crypto_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index cd35608460..3605f990fd 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -117,6 +117,7 @@ static const TypeInfo virtio_input_pci_info = {
     .instance_size = sizeof(VirtIOInputPCI),
     .class_init    = virtio_input_pci_class_init,
     .abstract      = true,
+    .secure        = true,
 };
 
 static const TypeInfo virtio_input_hid_pci_info = {
@@ -124,6 +125,7 @@ static const TypeInfo virtio_input_hid_pci_info = {
     .parent        = TYPE_VIRTIO_INPUT_PCI,
     .instance_size = sizeof(VirtIOInputHIDPCI),
     .abstract      = true,
+    .secure        = true,
 };
 
 static const VirtioPCIDeviceTypeInfo virtio_keyboard_pci_info = {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 533bd5073f..5f1920253b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1734,12 +1734,14 @@ static const TypeInfo virtio_iommu_info = {
     .instance_size = sizeof(VirtIOIOMMU),
     .instance_init = virtio_iommu_instance_init,
     .class_init = virtio_iommu_class_init,
+    .secure = true,
 };
 
 static const TypeInfo virtio_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_VIRTIO_IOMMU_MEMORY_REGION,
     .class_init = virtio_iommu_memory_region_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index 9278b32cf8..9eefb84daa 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -138,6 +138,7 @@ static const TypeInfo virtio_md_pci_info = {
     .instance_size = sizeof(VirtIOMDPCI),
     .class_size = sizeof(VirtIOMDPCIClass),
     .abstract = true,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_MEMORY_DEVICE },
         { }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d..edad9465cb 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1668,6 +1668,7 @@ static const TypeInfo virtio_mem_info = {
     .instance_finalize = virtio_mem_instance_finalize,
     .class_init = virtio_mem_class_init,
     .class_size = sizeof(VirtIOMEMClass),
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_RAM_DISCARD_SOURCE },
         { }
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 55ceaeef5f..f51c8d17b9 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -779,6 +779,7 @@ static const TypeInfo virtio_mmio_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(VirtIOMMIOProxy),
     .class_init    = virtio_mmio_class_init,
+    .secure        = true,
 };
 
 /* virtio-mmio-bus. */
@@ -848,6 +849,7 @@ static const TypeInfo virtio_mmio_bus_info = {
     .parent        = TYPE_VIRTIO_BUS,
     .instance_size = sizeof(VirtioBusState),
     .class_init    = virtio_mmio_bus_class_init,
+    .secure        = true,
 };
 
 static void virtio_mmio_register_types(void)
diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index 3bf5e7009a..099342f379 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1727,6 +1727,7 @@ static const TypeInfo virtio_nsm_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIONSM),
     .class_init = virtio_nsm_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 6f7271c140..1a414d7ba2 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -196,6 +196,7 @@ static const TypeInfo virtio_pmem_info = {
     .class_size    = sizeof(VirtIOPMEMClass),
     .class_init    = virtio_pmem_class_init,
     .instance_size = sizeof(VirtIOPMEM),
+    .secure        = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index d68d901195..ba80138179 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -282,6 +282,7 @@ static const TypeInfo virtio_rng_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIORNG),
     .class_init = virtio_rng_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-rtc.c b/hw/virtio/virtio-rtc.c
index 32de9c1650..08071aadb5 100644
--- a/hw/virtio/virtio-rtc.c
+++ b/hw/virtio/virtio-rtc.c
@@ -180,6 +180,7 @@ static const TypeInfo virtio_rtc_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIORtc),
     .class_init = virtio_rtc_class_init,
+    .secure = true,
 };
 
 static void virtio_rtc_register_types(void)
-- 
2.55.0


