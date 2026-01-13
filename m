Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65DFD29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaq6-0007Sv-Mn; Tue, 13 Jan 2026 04:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaq4-0007Gl-Fu
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaq2-0003KA-Pb
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLSaEL8hFLNBJUbpGN52yDV/UnUeDG0ybE+dW81ZIPs=;
 b=RVrJ1/1Rgv0feRjWTXM0s1RTZz3D+hcqql4nPeUN99yuC5Mn7UUGVIx9EURuFBWbkizTOZ
 fNDYV+F6LAIUV+H5cX8alTC1n53E7jmLt5r20fM+tkchkW5A/7K5WCQ05WZj8ad0L/DWxF
 2xrVqM8aLpPIkwRaWyAHsAVEC//cMGk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-8QTTzXDAN3-NvFgSOY7Bsg-1; Tue,
 13 Jan 2026 04:37:18 -0500
X-MC-Unique: 8QTTzXDAN3-NvFgSOY7Bsg-1
X-Mimecast-MFC-AGG-ID: 8QTTzXDAN3-NvFgSOY7Bsg_1768297037
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A73AB1956050; Tue, 13 Jan 2026 09:37:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76FBF30001A8; Tue, 13 Jan 2026 09:37:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/41] intel_iommu_accel: Fail passthrough device under PCI
 bridge if x-flts=on
Date: Tue, 13 Jan 2026 10:36:08 +0100
Message-ID: <20260113093637.1549214-13-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Currently we don't support nested translation for passthrough device with
emulated device under same PCI bridge, because they require different address
space when x-flts=on.

In theory, we do support if devices under same PCI bridge are all passthrough
devices. But emulated device can be hotplugged under same bridge. To simplify,
just forbid passthrough device under PCI bridge no matter if there is, or will
be emulated devices under same bridge. This is acceptable because PCIE bridge
is more popular than PCI bridge now.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-11-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu_accel.h |  4 ++--
 hw/i386/intel_iommu.c       |  7 ++++---
 hw/i386/intel_iommu_accel.c | 12 +++++++++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 79117b25a030a3d22d75b635725a6f78a21ec407..1d1fffb731a0daaf81f283e996707b25738eb5b6 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -13,11 +13,11 @@
 #include CONFIG_DEVICES
 
 #ifdef CONFIG_VTD_ACCEL
-bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
-                                        HostIOMMUDevice *hiod,
+                                        VTDHostIOMMUDevice *vtd_hiod,
                                         Error **errp)
 {
     error_setg(errp, "host IOMMU cannot be checked!");
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b11798d4b75b7fb6961a1b2bde8851667b0d07db..0817b1777220072f6b10e13af73b1c6434447d1a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4570,9 +4570,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
-static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                            Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     int ret;
 
@@ -4596,7 +4597,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
-    return vtd_check_hiod_accel(s, hiod, errp);
+    return vtd_check_hiod_accel(s, vtd_hiod, errp);
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
@@ -4632,7 +4633,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hiod->iommu_state = s;
     vtd_hiod->hiod = hiod;
 
-    if (!vtd_check_hiod(s, hiod, errp)) {
+    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
         g_free(vtd_hiod);
         vtd_iommu_unlock(s);
         return false;
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 2942eff100b9e7871326d27b58b71517ff705271..99f173b2486c4bd05d6cfeed56d03c3efc6a658d 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -12,12 +12,16 @@
 #include "system/iommufd.h"
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
+#include "hw/pci/pci_bus.h"
 
-bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps = &hiod->caps;
     struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+    PCIBus *bus = vtd_hiod->bus;
+    PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
 
     if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
         error_setg(errp, "Need IOMMUFD backend when x-flts=on");
@@ -36,6 +40,12 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return false;
     }
 
+    if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
+        error_setg(errp, "Host device downstream to a PCI bridge is "
+                   "unsupported when x-flts=on");
+        return false;
+    }
+
     error_setg(errp,
                "host IOMMU is incompatible with guest first stage translation");
     return false;
-- 
2.52.0


