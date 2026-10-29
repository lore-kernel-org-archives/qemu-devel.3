Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=froxi8yd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPwb-0007rw-26; Thu, 29 Oct 2026 09:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPw9-0007kR-EW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPw6-000664-Hc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrcmyQ+ziZh6xY0lqp7ARwki4RX1f8zj2yvIXg76gaE=;
 b=froxi8ydVwrOQZGqUhPXSQD0rPnm0LwoevPdBtpT/74rhGFSnIKAYU8b2ndRVFHUPCl31V
 7L3+QK3Zj27uYgLU3OW/N19S4M/6z0UigNHMLCtEphp0+9h1P6k10OngDRhPi4ClcPUeZI
 HnttIFP3ftkOR9KVe8srNe+jtDdyy/Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-3zMZcdY-O66aSb6fbj53Yg-1; Thu,
 29 Oct 2026 09:12:50 -0400
X-MC-Unique: 3zMZcdY-O66aSb6fbj53Yg-1
X-Mimecast-MFC-AGG-ID: 3zMZcdY-O66aSb6fbj53Yg_1793279569
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3FAD18005B2; Thu, 29 Oct 2026 13:12:48 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5435D3000738; Thu, 29 Oct 2026 13:12:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/28] hw: mark all virtio PCI devices as secure
Date: Thu, 29 Oct 2026 13:12:14 +0000
Message-ID: <20261029131241.2275706-2-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The virtio-gpu-pci-rutabaga device is unusual in not using the common
virtio_pci_types_register() method, so needs marking directly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/virtio-gpu-pci-rutabaga.c | 1 +
 hw/virtio/virtio-pci.c               | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
index 4db77cb868d..a8e5e1d96cf 100644
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
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c73f1f546cb..7e372bb8de0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2527,6 +2527,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .name = t->generic_name,
         .parent = base_type_info.name,
         .class_init = virtio_pci_generic_class_init,
+        .secure = true,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2562,6 +2563,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->non_transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_non_transitional_instance_init,
+            .secure = true,
             .interfaces = (const InterfaceInfo[]) {
                 { INTERFACE_PCIE_DEVICE },
                 { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2576,6 +2578,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_transitional_instance_init,
+            .secure = true,
             .interfaces = (const InterfaceInfo[]) {
                 /*
                  * Transitional virtio devices work only as Conventional PCI
-- 
2.56.0


