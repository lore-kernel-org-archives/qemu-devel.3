Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321B606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U8e53vAo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPx9-00006U-Bh; Thu, 29 Oct 2026 09:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwN-0007ol-GS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwG-000693-Cy
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTKTVCYmTNlIUtcbovuhBvsFV61M9EOorWeA23RaOJc=;
 b=U8e53vAouDEHOJG/EPm9xAJspJ4PKXB1+eqpwQ3UCuDyw7g4A7Rxwb4n0vdrmu7xhB1THa
 HrXvXQl4x3vN3eU2pjPOmY5lfFhPMJRMeEK1kHBI4WmcOc+EnJ2MORIAtr8VWemjd4cfzu
 Ygo41GQa5BwDgtZgO5Xci6mjk4nG9xI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-E14aNRfiOdiENRH3b4zU4Q-1; Thu,
 29 Oct 2026 09:12:58 -0400
X-MC-Unique: E14aNRfiOdiENRH3b4zU4Q-1
X-Mimecast-MFC-AGG-ID: E14aNRfiOdiENRH3b4zU4Q_1793279577
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 573C21955EAF; Thu, 29 Oct 2026 13:12:57 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05BC43000738; Thu, 29 Oct 2026 13:12:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 04/28] hw: mark all remaining virtio object types as secure
Date: Thu, 29 Oct 2026 13:12:17 +0000
Message-ID: <20261029131241.2275706-5-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are all intended for use in a virtualization scenario and must
provide a security boundary.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/9pfs/virtio-9p-device.c       | 1 +
 hw/audio/virtio-snd.c            | 1 +
 hw/block/virtio-blk.c            | 1 +
 hw/char/virtio-console.c         | 2 ++
 hw/char/virtio-serial-bus.c      | 2 ++
 hw/display/virtio-gpu-gl.c       | 1 +
 hw/display/virtio-gpu-rutabaga.c | 1 +
 hw/display/virtio-gpu.c          | 1 +
 hw/input/virtio-input-hid.c      | 4 ++++
 hw/input/virtio-input-host.c     | 1 +
 hw/net/virtio-net.c              | 1 +
 hw/scsi/virtio-scsi.c            | 1 +
 hw/virtio/vdpa-dev.c             | 1 +
 hw/virtio/virtio-balloon.c       | 1 +
 hw/virtio/virtio-crypto.c        | 1 +
 hw/virtio/virtio-iommu.c         | 2 ++
 hw/virtio/virtio-mem.c           | 1 +
 hw/virtio/virtio-mmio.c          | 2 ++
 hw/virtio/virtio-nsm.c           | 1 +
 hw/virtio/virtio-pmem.c          | 1 +
 hw/virtio/virtio-rng.c           | 1 +
 hw/virtio/virtio-rtc.c           | 1 +
 22 files changed, 29 insertions(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 2774fc2290a..a4572c851df 100644
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
index 6df7ea0eb04..0e3d5ec6aba 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1536,6 +1536,7 @@ static const TypeInfo virtio_snd_types[] = {
       .parent        = TYPE_VIRTIO_DEVICE,
       .instance_size = sizeof(VirtIOSound),
       .class_init    = virtio_snd_class_init,
+      .secure        = true,
     }
 };
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 536d71a91ad..b15ab8e5450 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -2071,6 +2071,7 @@ static const TypeInfo virtio_blk_info = {
     .instance_init = virtio_blk_instance_init,
     .class_init = virtio_blk_class_init,
     .class_size = sizeof(VirtIOBlkClass),
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index db9d8ca797f..cd42cbe7646 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -295,6 +295,7 @@ static const TypeInfo virtconsole_info = {
     .name          = "virtconsole",
     .parent        = TYPE_VIRTIO_CONSOLE_SERIAL_PORT,
     .class_init    = virtconsole_class_init,
+    .secure        = true,
 };
 
 static const Property virtserialport_properties[] = {
@@ -320,6 +321,7 @@ static const TypeInfo virtserialport_info = {
     .parent        = TYPE_VIRTIO_SERIAL_PORT,
     .instance_size = sizeof(VirtConsole),
     .class_init    = virtserialport_class_init,
+    .secure        = true,
 };
 
 static void virtconsole_register_types(void)
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 882765ac88a..7fe90571249 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -915,6 +915,7 @@ static const TypeInfo virtser_bus_info = {
     .parent = TYPE_BUS,
     .instance_size = sizeof(VirtIOSerialBus),
     .class_init = virtser_bus_class_init,
+    .secure = true,
 };
 
 #ifdef CONFIG_HMP
@@ -1250,6 +1251,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIOSerial),
     .class_init = virtio_serial_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c4664..75174b6731f 100644
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
index 1312a67d701..424f1e3556f 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1169,6 +1169,7 @@ static const TypeInfo virtio_gpu_rutabaga_info[] = {
         .parent = TYPE_VIRTIO_GPU,
         .instance_size = sizeof(VirtIOGPURutabaga),
         .class_init = virtio_gpu_rutabaga_class_init,
+        .secure = true,
     },
 };
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5d43ffb9918..d248e50abcb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1995,6 +1995,7 @@ static const TypeInfo virtio_gpu_info = {
     .instance_size = sizeof(VirtIOGPU),
     .class_size = sizeof(VirtIOGPUClass),
     .class_init = virtio_gpu_class_init,
+    .secure = true,
 };
 module_obj(TYPE_VIRTIO_GPU);
 module_kconfig(VIRTIO_GPU);
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 1019d6b2e53..38c338d836c 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -315,6 +315,7 @@ static const TypeInfo virtio_keyboard_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_keyboard_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -369,6 +370,7 @@ static const TypeInfo virtio_mouse_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_mouse_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -442,6 +444,7 @@ static const TypeInfo virtio_tablet_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_tablet_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
@@ -527,6 +530,7 @@ static const TypeInfo virtio_multitouch_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_multitouch_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 633547cc4f7..0d01e00cfcb 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -248,6 +248,7 @@ static const TypeInfo virtio_input_host_info = {
     .instance_size = sizeof(VirtIOInputHost),
     .instance_init = virtio_input_host_init,
     .class_init    = virtio_input_host_class_init,
+    .secure        = true,
 };
 
 /* ----------------------------------------------------------------- */
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 19f453fb7df..85472038aca 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4491,6 +4491,7 @@ static const TypeInfo virtio_net_info = {
     .instance_size = sizeof(VirtIONet),
     .instance_init = virtio_net_instance_init,
     .class_init = virtio_net_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d7e2662aa73..ef5cc7a6ce8 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1456,6 +1456,7 @@ static const TypeInfo virtio_scsi_info = {
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VirtIOSCSI),
     .class_init = virtio_scsi_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 7e5cc040e94..50811f79c07 100644
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
index 07d519cf6d7..cb9928b16a4 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -1100,6 +1100,7 @@ static const TypeInfo virtio_balloon_info = {
     .instance_size = sizeof(VirtIOBalloon),
     .instance_init = virtio_balloon_instance_init,
     .class_init = virtio_balloon_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 85c7279aae2..8968d9f293e 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1313,6 +1313,7 @@ static const TypeInfo virtio_crypto_info = {
     .instance_size = sizeof(VirtIOCrypto),
     .instance_init = virtio_crypto_instance_init,
     .class_init = virtio_crypto_class_init,
+    .secure = true,
 };
 
 static void virtio_register_types(void)
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 208815096fc..664d1c0b6b9 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1749,12 +1749,14 @@ static const TypeInfo virtio_iommu_info = {
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
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d9..edad9465cb1 100644
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
index 55ceaeef5fc..f51c8d17b9a 100644
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
index 3bf5e7009a4..099342f3792 100644
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
index 6f7271c140a..1a414d7ba29 100644
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
index d68d9011953..ba80138179b 100644
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
index 0dcbe94758a..633bff8ac2c 100644
--- a/hw/virtio/virtio-rtc.c
+++ b/hw/virtio/virtio-rtc.c
@@ -181,6 +181,7 @@ static const TypeInfo virtio_rtc_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIORtc),
     .class_init = virtio_rtc_class_init,
+    .secure = true,
 };
 
 static void virtio_rtc_register_types(void)
-- 
2.56.0


