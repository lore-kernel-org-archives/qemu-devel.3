Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F157606BDEF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJPZ2uRZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwEu-00071M-6p; Fri, 13 Nov 2026 13:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwEq-0006ws-Lw
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwEo-0005LK-Sh
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jr4A4wlA7xAnR6mxdBR/jWrLR9VBJ+sMNLGYFc+Nycw=;
 b=IJPZ2uRZcmrnFt6lcCLR9rcr15zuP4cZsqW/+8pzYPMNeW32IRUaq2ySvugjcF6hDoq4Il
 D+I3fBcLwVCvpaeMLq34JUzgPBnLLLAoKwxSVYqxbNS11KdJ2uqBvp0tMUWl3w5zWbT36N
 5E6VhJdbhHwx1x5/EzDVIoGBzoMBgIE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-m40ayeqoMY6DZN62RU-C5g-1; Fri,
 13 Nov 2026 13:43:00 -0500
X-MC-Unique: m40ayeqoMY6DZN62RU-C5g-1
X-Mimecast-MFC-AGG-ID: m40ayeqoMY6DZN62RU-C5g_1794595379
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83EF6180047A
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:42:59 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 481891955DB9; Fri, 13 Nov 2026 18:42:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 01/26] hw: mark most virtio PCI devices as secure
Date: Fri, 13 Nov 2026 18:42:29 +0000
Message-ID: <20261113184254.2524253-2-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are all intended for use in a virtualization scenario and must
provide a security boundary. This can be done for almost all virtio
PCI devices by modifying the common type register helper.

Exceptions are made for the virtio-gpu-gl, virtio-vga-gl,
virtio-vga-rutatbaga and virtio-gpu-rutabaga devices.

Despite being intended for virtualization use cases, the complexity
of support for 3d acceleration is such that QEMU can't offer security
for these devices at this time.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/virtio-gpu-pci-gl.c   |  2 +-
 hw/display/virtio-vga-gl.c       |  2 +-
 hw/display/virtio-vga-rutabaga.c |  2 +-
 hw/virtio/virtio-pci.c           | 17 ++++++++++++++++-
 include/hw/virtio/virtio-pci.h   | 10 +++++++++-
 5 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-pci-gl.c b/hw/display/virtio-gpu-pci-gl.c
index c8923795dfa..dc67516b377 100644
--- a/hw/display/virtio-gpu-pci-gl.c
+++ b/hw/display/virtio-gpu-pci-gl.c
@@ -51,7 +51,7 @@ module_kconfig(VIRTIO_PCI);
 
 static void virtio_gpu_gl_pci_register_types(void)
 {
-    virtio_pci_types_register(&virtio_gpu_gl_pci_info);
+    virtio_pci_types_register_insecure(&virtio_gpu_gl_pci_info);
 }
 
 type_init(virtio_gpu_gl_pci_register_types)
diff --git a/hw/display/virtio-vga-gl.c b/hw/display/virtio-vga-gl.c
index 178e4c71725..029d288c035 100644
--- a/hw/display/virtio-vga-gl.c
+++ b/hw/display/virtio-vga-gl.c
@@ -42,7 +42,7 @@ module_kconfig(VIRTIO_VGA);
 static void virtio_vga_register_types(void)
 {
     if (have_vga) {
-        virtio_pci_types_register(&virtio_vga_gl_info);
+        virtio_pci_types_register_insecure(&virtio_vga_gl_info);
     }
 }
 
diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-rutabaga.c
index 1e07ee0b0d3..8ff715f8a35 100644
--- a/hw/display/virtio-vga-rutabaga.c
+++ b/hw/display/virtio-vga-rutabaga.c
@@ -41,7 +41,7 @@ module_kconfig(VIRTIO_VGA);
 static void virtio_vga_register_types(void)
 {
     if (have_vga) {
-        virtio_pci_types_register(&virtio_vga_rutabaga_info);
+        virtio_pci_types_register_insecure(&virtio_vga_rutabaga_info);
     }
 }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c73f1f546cb..fe2e545c302 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2510,7 +2510,9 @@ static void virtio_pci_non_transitional_instance_init(Object *obj)
     proxy->disable_modern = false;
 }
 
-void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
+static void
+virtio_pci_types_register_internal(const VirtioPCIDeviceTypeInfo *t,
+                                   bool secure)
 {
     char *base_name = NULL;
     TypeInfo base_type_info = {
@@ -2527,6 +2529,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .name = t->generic_name,
         .parent = base_type_info.name,
         .class_init = virtio_pci_generic_class_init,
+        .secure = secure,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2562,6 +2565,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->non_transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_non_transitional_instance_init,
+            .secure = secure,
             .interfaces = (const InterfaceInfo[]) {
                 { INTERFACE_PCIE_DEVICE },
                 { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2576,6 +2580,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_transitional_instance_init,
+            .secure = secure,
             .interfaces = (const InterfaceInfo[]) {
                 /*
                  * Transitional virtio devices work only as Conventional PCI
@@ -2590,6 +2595,16 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     g_free(base_name);
 }
 
+void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
+{
+    virtio_pci_types_register_internal(t, true);
+}
+
+void virtio_pci_types_register_insecure(const VirtioPCIDeviceTypeInfo *t)
+{
+    virtio_pci_types_register_internal(t, false);
+}
+
 unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues)
 {
     /*
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index ee50fb0d551..f033237035a 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -239,8 +239,16 @@ typedef struct VirtioPCIDeviceTypeInfo {
     const InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
-/* Register virtio-pci type(s).  @t must be static. */
+/*
+ * Register virtio-pci type(s).
+ * @t must be static.
+ *
+ * Since they serve the virtualization use case, most virtio
+ * devices are expected to be classed as secure. In the rare
+ * scenario where this is not desired, use the second method.
+ */
 void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
+void virtio_pci_types_register_insecure(const VirtioPCIDeviceTypeInfo *t);
 
 /**
  * virtio_pci_optimal_num_queues:
-- 
2.56.1


