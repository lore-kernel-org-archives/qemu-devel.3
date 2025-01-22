Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9600C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacUT-0004e3-DN; Wed, 22 Jan 2025 10:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUO-0004dn-N1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUM-0004a9-UB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737559072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BoilxGy/dKTFh734KqqGJ1Ffq33SYL1+VhPSneWoXI=;
 b=B7JLFcMEw5BR23mK6RNKXc3DIJCwHNZloYWeaXSpTgzzP8kFK9iAYjSU0h598uK0fq/aty
 Tkv9/PVWltZtYsZXv7XspbU3rWinQq0jggOvG0wgcz66AOuIb38mTFHwC5zyHsVpLxeBDX
 dVD6iOQrjMGv66HS0OaD4V1eXx6RS/g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-7Zww7tDyOxawawF2WtrZww-1; Wed,
 22 Jan 2025 10:17:49 -0500
X-MC-Unique: 7Zww7tDyOxawawF2WtrZww-1
X-Mimecast-MFC-AGG-ID: 7Zww7tDyOxawawF2WtrZww
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E96681956055
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 15:17:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC4BD19560AA; Wed, 22 Jan 2025 15:17:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/5] vfio: Check compatibility of CPU and IOMMU address space
 width
Date: Wed, 22 Jan 2025 16:17:32 +0100
Message-ID: <20250122151732.1351821-6-clg@redhat.com>
In-Reply-To: <20250122151732.1351821-1-clg@redhat.com>
References: <20250122151732.1351821-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Print a warning if IOMMU address space width is smaller than the
physical address width. In this case, PCI peer-to-peer transactions on
BARs are not supported and failures of device MMIO regions are to be
expected.

This can occur with the 39-bit IOMMU address space width as found on
consumer grade processors or when using a vIOMMU device with default
settings.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 561be7f57cf903e6e2bcbbb708be9e4d4ee8941c..d0104976e9d99c3f64ec716accd3adb4a70d9afe 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -44,6 +44,8 @@
 #include "migration/qemu-file.h"
 #include "system/tpm.h"
 
+#include "hw/core/cpu.h"
+
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
@@ -1561,12 +1563,28 @@ retry:
     return info;
 }
 
+static bool vfio_device_check_address_space(VFIODevice *vbasedev, Error **errp)
+{
+    uint32_t cpu_aw_bits = cpu_get_phys_bits(first_cpu);
+    uint32_t iommu_aw_bits = vfio_device_get_aw_bits(vbasedev);
+
+    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) {
+        error_setg(errp, "Host physical address space (%u) is larger than "
+                   "the host IOMMU address space (%u).", cpu_aw_bits,
+                   iommu_aw_bits);
+        vfio_container_p2p_error_append(vbasedev->bcontainer, errp);
+        return false;
+    }
+    return true;
+}
+
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp)
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
     HostIOMMUDevice *hiod = NULL;
+    Error *local_err = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1586,6 +1604,9 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
         return false;
     }
 
+    if (!vfio_device_check_address_space(vbasedev, &local_err)) {
+        warn_report_err(local_err);
+    }
     return true;
 }
 
-- 
2.48.1


