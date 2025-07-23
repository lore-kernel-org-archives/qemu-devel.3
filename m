Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A48BC83F25
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 06:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueTKw-0007AV-MM; Wed, 23 Jul 2025 02:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ueSwt-0003vY-Dy
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 02:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ueSwq-00073O-Nw
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 02:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753252043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wMOoIandP/04VySVapkvNcCzxicJDgz4h8Dn0YoFxQ0=;
 b=JHGzuceIcgWnsjngTBRFOPXYr8NlNa1VqxJndXrl/KtE2Y2MEHPYK9jKQlrft+heQHO2+H
 wvRfJzb/4xITV8TQBUof3WQ2uM5ARwIMM4bzIMuYY2s8jllEb9i2o7hC9xOggZ8gRyTFer
 /MNCm1dP47ttc6VCvk2ZMsgXzZkbuoI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-Tdap5CApM8e9dqTb6WWe4g-1; Wed,
 23 Jul 2025 02:27:21 -0400
X-MC-Unique: Tdap5CApM8e9dqTb6WWe4g-1
X-Mimecast-MFC-AGG-ID: Tdap5CApM8e9dqTb6WWe4g_1753252040
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CB8E180028E; Wed, 23 Jul 2025 06:27:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C39CD195608D; Wed, 23 Jul 2025 06:27:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Shaoqin Huang <shahuang@redhat.com>
Subject: [PATCH] hw/i386: Fix 'use-legacy-x86-rom' property compatibility
Date: Wed, 23 Jul 2025 08:27:14 +0200
Message-ID: <20250723062714.1245826-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit 350785d41d8b ("ramfb: Add property to control if load the
romfile") introduced the `use-legacy-x86-rom` property for the
`vfio-pci-nohotplug` device, allowing control over VGA BIOS ROM
loading. However, the property compatibility setting was incorrectly
applied to the `vfio-pci` device instead, which causes all `vfio-pci`
devices to fail to load. This change fixes the issue by ensuring the
property is set on the correct device.

Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/types.h   | 2 ++
 hw/core/machine.c | 2 +-
 hw/i386/microvm.c | 2 +-
 hw/i386/pc_piix.c | 2 +-
 hw/i386/pc_q35.c  | 2 +-
 hw/vfio/pci.c     | 2 --
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/types.h b/hw/vfio/types.h
index fa20c29b9fbbf51ddad4f6cb0535a70152224a94..c19334ff25ae2f5221f08ed863553ce7f8e3be98 100644
--- a/hw/vfio/types.h
+++ b/hw/vfio/types.h
@@ -18,4 +18,6 @@
 #define TYPE_VFIO_PCI "vfio-pci"
 /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
 
+#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
+
 #endif /* HW_VFIO_VFIO_TYPES_H */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d6b2240fc250d2d1194dee62e5356c0c214f1069..bd47527479a7947ca293a47c9a6f49916d24bad3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,7 +41,7 @@ GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
     { "ramfb", "use-legacy-x86-rom", "true"},
-    { "vfio-pci", "use-legacy-x86-rom", "true" },
+    { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d90b69a162007af8af1b8596be590126fb00fb59..94d22a232aca1f82590d80c2ac6cc279bb9ff808 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -635,7 +635,7 @@ GlobalProperty microvm_properties[] = {
      */
     { "pcie-root-port", "io-reserve", "0" },
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
-    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
 };
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ad5caff3a5d251671db591c68bed3b69a5e45d17..c03324281bdb356e17d434b156e4080865867f4f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -80,7 +80,7 @@ static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
 
 static GlobalProperty pc_piix_compat_defaults[] = {
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
-    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
 };
 static const size_t pc_piix_compat_defaults_len =
     G_N_ELEMENTS(pc_piix_compat_defaults);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9b9519fa02d506393058c085178924156e9e0d10..b309b2b378db4741b72828c1f34d2edc2e057a1d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -69,7 +69,7 @@
 static GlobalProperty pc_q35_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
-    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
 };
 static const size_t pc_q35_compat_defaults_len =
     G_N_ELEMENTS(pc_q35_compat_defaults);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e72d514a4cb91946f7c79332492bf5d709c308f2..0c4606d9cb5e163b8c533ed9b89d4d73eafaae24 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -49,8 +49,6 @@
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
 
-#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
-
 /* Protected by BQL */
 static KVMRouteChange vfio_route_change;
 
-- 
2.50.1


