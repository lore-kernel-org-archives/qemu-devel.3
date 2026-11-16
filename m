Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33231606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PJKIobST
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT55Z-0003mk-Dm; Mon, 16 Nov 2026 17:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55T-0003ko-Tg
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55S-0005q9-6x
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794867725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBq9pcr1JOR5XHoo8faLFsSboSRQPhGGiJ+j8polE5Y=;
 b=PJKIobSTI6wW22yp+nBj9Q5/uoxYHEbC52v2xt1f0TEiVGWIs2vCmM40gadF1Zsx4a9sN6
 ldduqzk7NPwdwN3YgMqdMnCI64Fn0TeSvr6+SLq+4wRlIZDmGQhhgK2R6V6iMSGK+DE4OQ
 RzyaiZwinjiaA1nw1azxF5iwsNiOuk4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-CTzmEV6uP7-oPoDlOM-mPQ-1; Mon,
 16 Nov 2026 17:22:03 -0500
X-MC-Unique: CTzmEV6uP7-oPoDlOM-mPQ-1
X-Mimecast-MFC-AGG-ID: CTzmEV6uP7-oPoDlOM-mPQ_1794867722
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6E5C1956064
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:22:02 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B06030001A2; Mon, 16 Nov 2026 22:22:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 01/26] hw: mark most virtio PCI devices as secure
Date: Mon, 16 Nov 2026 22:21:33 +0000
Message-ID: <20261116222158.2840471-2-berrange@redhat.com>
In-Reply-To: <20261116222158.2840471-1-berrange@redhat.com>
References: <20261116222158.2840471-1-berrange@redhat.com>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


