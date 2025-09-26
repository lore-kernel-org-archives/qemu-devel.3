Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E731ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293c-0006su-C5; Fri, 26 Sep 2025 10:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293a-0006r6-69
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293L-0004sZ-ES
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rj/VuFsAHHTHPZ2krXAd5tToKOZEOM+84xihKMK/wAo=;
 b=Ezw0XCTCG9ScoHAikNl6hEcnIQnMyEXDnjKiuWMdjxrskg+kOjvLCTezc4LB1XlVtpMYHe
 agydHnlYbzGO2LBa0Fvyvj1I3EqXsR5Ie63l920m1aFWk6doiTQVtuXfKE/F4FDIPCjgaD
 APNyR+PfFOpkVpdZTrdrWL/LBr0tAwg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-7k9jwbjhNASmTTrtGWfNVA-1; Fri,
 26 Sep 2025 10:03:55 -0400
X-MC-Unique: 7k9jwbjhNASmTTrtGWfNVA-1
X-Mimecast-MFC-AGG-ID: 7k9jwbjhNASmTTrtGWfNVA_1758895434
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E6601955D6E; Fri, 26 Sep 2025 14:03:54 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E86861956095; Fri, 26 Sep 2025 14:03:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 21/32] hw: mark all remaining virtio object types as secure
Date: Fri, 26 Sep 2025 15:01:32 +0100
Message-ID: <20250926140144.1998694-22-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 25 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 81b91e47c6..f5d7017d2e 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -268,6 +268,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(V9fsVirtioState),
     .class_init = virtio_9p_class_init,
+    .secure = true,
 };
 
 static void virtio_9p_register_types(void)
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index eca3319e59..166f82f78f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1386,6 +1386,7 @@ static const TypeInfo virtio_snd_types[] = {
       .parent        = TYPE_VIRTIO_DEVICE,
       .instance_size = sizeof(VirtIOSound),
       .class_init    = virtio_snd_class_init,
+      .secure        = true,
     }
 };
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9bab2716c1..e560d021a7 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1915,6 +1915,7 @@ static const TypeInfo virtio_blk_info = {
     .instance_init = virtio_blk_instance_init,
     .class_init = virtio_blk_class_init,
     .class_size = sizeof(VirtIOBlkClass),
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 0932a3572b..3732b441e8 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -272,6 +272,7 @@ static const TypeInfo virtconsole_info = {
     .name          = "virtconsole",
     .parent        = TYPE_VIRTIO_CONSOLE_SERIAL_PORT,
     .class_init    = virtconsole_class_init,
+    .secure        = true,
 };
 
 static const Property virtserialport_properties[] = {
@@ -297,6 +298,7 @@ static const TypeInfo virtserialport_info = {
     .parent        = TYPE_VIRTIO_SERIAL_PORT,
     .instance_size = sizeof(VirtConsole),
     .class_init    = virtserialport_class_init,
+    .secure        = true,
 };
 
 static void virtconsole_register_types(void)
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 673c50f0be..56577f91df 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -852,6 +852,7 @@ static const TypeInfo virtser_bus_info = {
     .parent = TYPE_BUS,
     .instance_size = sizeof(VirtIOSerialBus),
     .class_init = virtser_bus_class_init,
+    .secure = true,
 };
 
 static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
@@ -1109,6 +1110,7 @@ static const TypeInfo virtio_serial_port_type_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(VirtIOSerialPort),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(VirtIOSerialPortClass),
     .class_init = virtio_serial_port_class_init,
 };
@@ -1189,6 +1191,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIOSerial),
     .class_init = virtio_serial_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..c593ab146c 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -308,7 +308,8 @@ static const TypeInfo virtio_gpu_base_info = {
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
index c06a078fb3..38a27e5459 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -205,6 +205,7 @@ static const TypeInfo virtio_gpu_gl_info = {
     .parent = TYPE_VIRTIO_GPU,
     .instance_size = sizeof(VirtIOGPUGL),
     .class_init = virtio_gpu_gl_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VIRTIO_GPU_GL);
 module_kconfig(VIRTIO_GPU);
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index ed5ae52acb..d0b86f49c1 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1132,6 +1132,7 @@ static const TypeInfo virtio_gpu_rutabaga_info[] = {
         .parent = TYPE_VIRTIO_GPU,
         .instance_size = sizeof(VirtIOGPURutabaga),
         .class_init = virtio_gpu_rutabaga_class_init,
+        .secure = true,
     },
 };
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0e..0fcefa1f0b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1713,6 +1713,7 @@ static const TypeInfo virtio_gpu_info = {
     .instance_size = sizeof(VirtIOGPU),
     .class_size = sizeof(VirtIOGPUClass),
     .class_init = virtio_gpu_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VIRTIO_GPU);
 module_kconfig(VIRTIO_GPU);
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index d986c3c16e..aa475641f6 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -260,6 +260,7 @@ static const TypeInfo virtio_input_hid_info = {
     .instance_size = sizeof(VirtIOInputHID),
     .class_init    = virtio_input_hid_class_init,
     .abstract      = true,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -317,6 +318,7 @@ static const TypeInfo virtio_keyboard_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_keyboard_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -410,6 +412,7 @@ static const TypeInfo virtio_mouse_info = {
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_mouse_init,
     .class_init    = virtio_mouse_class_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -534,6 +537,7 @@ static const TypeInfo virtio_tablet_info = {
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_tablet_init,
     .class_init    = virtio_tablet_class_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -619,6 +623,7 @@ static const TypeInfo virtio_multitouch_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_multitouch_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 9f62532559..46db99eeb7 100644
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
index a3f554f211..3bddcfc168 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -329,6 +329,7 @@ static const TypeInfo virtio_input_info = {
     .class_size    = sizeof(VirtIOInputClass),
     .class_init    = virtio_input_class_init,
     .abstract      = true,
+    .secure        = true,
     .instance_finalize = virtio_input_finalize,
 };
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 34ae14f7bf..7b91663a40 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1430,6 +1430,7 @@ static const TypeInfo virtio_scsi_common_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIOSCSICommon),
     .abstract = true,
+    .secure = true,
     .class_init = virtio_scsi_common_class_init,
 };
 
@@ -1438,6 +1439,7 @@ static const TypeInfo virtio_scsi_info = {
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VirtIOSCSI),
     .class_init = virtio_scsi_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index d1da40afc8..a8c5375f5d 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -385,6 +385,7 @@ static const TypeInfo vhost_vdpa_device_info = {
     .instance_size = sizeof(VhostVdpaDevice),
     .class_init = vhost_vdpa_device_class_init,
     .instance_init = vhost_vdpa_device_instance_init,
+    .secure = true,
 };
 
 static void register_vhost_vdpa_device_type(void)
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index db787d00b3..51f261dd32 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -1087,6 +1087,7 @@ static const TypeInfo virtio_balloon_info = {
     .instance_size = sizeof(VirtIOBalloon),
     .instance_init = virtio_balloon_instance_init,
     .class_init = virtio_balloon_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 11adfbf3ab..2efc0e306f 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -360,6 +360,7 @@ static const TypeInfo virtio_bus_info = {
     .parent = TYPE_BUS,
     .instance_size = sizeof(VirtioBusState),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(VirtioBusClass),
     .class_init = virtio_bus_class_init
 };
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 517f2089c5..e0bec9d6ee 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1301,6 +1301,7 @@ static const TypeInfo virtio_crypto_info = {
     .instance_size = sizeof(VirtIOCrypto),
     .instance_init = virtio_crypto_instance_init,
     .class_init = virtio_crypto_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 3be5358b4c..1ce9b28d8b 100644
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
index 3500f1b082..fa46f4129f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1706,12 +1706,14 @@ static const TypeInfo virtio_iommu_info = {
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
index c46f6f9c3e..a444b9dfff 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1888,6 +1888,7 @@ static const TypeInfo virtio_mem_info = {
     .instance_finalize = virtio_mem_instance_finalize,
     .class_init = virtio_mem_class_init,
     .class_size = sizeof(VirtIOMEMClass),
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_RAM_DISCARD_MANAGER },
         { }
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 532c67107b..1e3d949304 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -799,6 +799,7 @@ static const TypeInfo virtio_mmio_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(VirtIOMMIOProxy),
     .class_init    = virtio_mmio_class_init,
+    .secure        = true,
 };
 
 /* virtio-mmio-bus. */
@@ -881,6 +882,7 @@ static const TypeInfo virtio_mmio_bus_info = {
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
index 3416ea1827..6e62efadf0 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -185,6 +185,7 @@ static const TypeInfo virtio_pmem_info = {
     .class_size    = sizeof(VirtIOPMEMClass),
     .class_init    = virtio_pmem_class_init,
     .instance_size = sizeof(VirtIOPMEM),
+    .secure        = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 3df5d2576e..dec7bade7f 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -280,6 +280,7 @@ static const TypeInfo virtio_rng_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIORNG),
     .class_init = virtio_rng_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
-- 
2.50.1


