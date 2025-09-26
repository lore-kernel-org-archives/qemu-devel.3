Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84869CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293M-0006n2-D7; Fri, 26 Sep 2025 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293I-0006ke-S8
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2936-0004pY-Ui
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzvJdoRpKjbbnlvFY+3uY75z5RpH1paQjQOZjP0sbEY=;
 b=c64WU1zeo/3OK2xmx+Gv3v1yoPgqObr/7ywiMbJ89SkFQFByr4tv67fPHItnUbVuY5mnj3
 GoBd11iGzoYM5z+dq5UeDm8Zgj4Fl9GH1x52Xg/FCZjXGEM6Y400lXPLHbeJcI9ud1TbgI
 RQzvyMNqiINCJ3rhZZWEeJt86rGmiF8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-FelZ0o6_OLCclBMHzXTQwg-1; Fri,
 26 Sep 2025 10:03:41 -0400
X-MC-Unique: FelZ0o6_OLCclBMHzXTQwg-1
X-Mimecast-MFC-AGG-ID: FelZ0o6_OLCclBMHzXTQwg_1758895420
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303C119560AD; Fri, 26 Sep 2025 14:03:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DC5A19540EB; Fri, 26 Sep 2025 14:03:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 18/32] hw: mark all virtio PCI devices as secure
Date: Fri, 26 Sep 2025 15:01:29 +0100
Message-ID: <20250926140144.1998694-19-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/display/virtio-gpu-pci-rutabaga.c | 1 +
 hw/display/virtio-gpu-pci.c          | 3 ++-
 hw/virtio/virtio-pci.c               | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
index 5fdff37f2c..56e32e9f5b 100644
--- a/hw/display/virtio-gpu-pci-rutabaga.c
+++ b/hw/display/virtio-gpu-pci-rutabaga.c
@@ -34,6 +34,7 @@ static const TypeInfo virtio_gpu_rutabaga_pci_info[] = {
         .parent = TYPE_VIRTIO_GPU_PCI_BASE,
         .instance_size = sizeof(VirtIOGPURutabagaPCI),
         .instance_init = virtio_gpu_rutabaga_initfn,
+        .secure = true,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index c0d71b6254..6c7cac7a25 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -75,7 +75,8 @@ static const TypeInfo virtio_gpu_pci_base_info = {
     .parent = TYPE_VIRTIO_PCI,
     .instance_size = sizeof(VirtIOGPUPCIBase),
     .class_init = virtio_gpu_pci_base_class_init,
-    .abstract = true
+    .abstract = true,
+    .secure = true,
 };
 module_obj(TYPE_VIRTIO_GPU_PCI_BASE);
 module_kconfig(VIRTIO_PCI);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 767216d795..f2f720792a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2494,6 +2494,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .name = t->generic_name,
         .parent = base_type_info.name,
         .class_init = virtio_pci_generic_class_init,
+        .secure = true,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2529,6 +2530,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->non_transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_non_transitional_instance_init,
+            .secure = true,
             .interfaces = (const InterfaceInfo[]) {
                 { INTERFACE_PCIE_DEVICE },
                 { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2543,6 +2545,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_transitional_instance_init,
+            .secure = true,
             .interfaces = (const InterfaceInfo[]) {
                 /*
                  * Transitional virtio devices work only as Conventional PCI
-- 
2.50.1


