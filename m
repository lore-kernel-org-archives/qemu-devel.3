Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8941FC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 20:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucrIT-00022e-4T; Fri, 18 Jul 2025 16:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ucr01-0006XV-Bh
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ucqzx-0000Ky-OD
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752867841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFMLACJLii3DfCYL/mU4zLV/+6fIm/s2iVEOiPOxUiA=;
 b=U15JW0QkUXAn26rpT7eA+0Cj4pE/nP95L8YRxoWI+yxVogPi2s1YssAOwLFTyqZbptlEwE
 aK7JE/3EeMw0ODNPlVmPCIjYv5ATlPkmt6QSM8NTpf6oP/NdhsBJB2W3S7obsoC/Om2Py4
 9Q+Vp8gRiql0zIhkqwfJrvJIn48JBWM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-spba4xvcPqGvSi7ciP2pRg-1; Fri,
 18 Jul 2025 15:43:58 -0400
X-MC-Unique: spba4xvcPqGvSi7ciP2pRg-1
X-Mimecast-MFC-AGG-ID: spba4xvcPqGvSi7ciP2pRg_1752867837
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2036719560B4; Fri, 18 Jul 2025 19:43:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6616195608D; Fri, 18 Jul 2025 19:43:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 98F54180090C; Fri, 18 Jul 2025 21:43:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Shaoqin Huang <shahuang@redhat.com>
Subject: [PULL 2/3] vfio: Move the TYPE_* to hw/vfio/types.h
Date: Fri, 18 Jul 2025 21:43:48 +0200
Message-ID: <20250718194349.65771-3-kraxel@redhat.com>
In-Reply-To: <20250718194349.65771-1-kraxel@redhat.com>
References: <20250718194349.65771-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Shaoqin Huang <shahuang@redhat.com>

Move the TYPE_* to a new file hw/vfio/types.h because the
TYPE_VFIO_PCI will be used in later patch, but directly include the
hw/vfio/pci.h can cause some compilation error when cross build the
windows version.

The hw/vfio/types.h can be included to mitigate that problem.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
Message-ID: <20250717100941.2230408-3-shahuang@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h   | 10 +---------
 hw/vfio/types.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio/types.h

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 826db8c1319b..0fd151c5dc2c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -14,6 +14,7 @@
 
 #include "system/memory.h"
 #include "hw/pci/pci_device.h"
+#include "hw/vfio/types.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-region.h"
 #include "qemu/event_notifier.h"
@@ -119,17 +120,8 @@ typedef struct VFIOMSIXInfo {
     MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
-/*
- * TYPE_VFIO_PCI_BASE is an abstract type used to share code
- * between VFIO implementations that use a kernel driver
- * with those that use user sockets.
- */
-#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
-#define TYPE_VFIO_PCI "vfio-pci"
-/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
-
 struct VFIOPCIDevice {
     PCIDevice pdev;
     VFIODevice vbasedev;
diff --git a/hw/vfio/types.h b/hw/vfio/types.h
new file mode 100644
index 000000000000..fa20c29b9fbb
--- /dev/null
+++ b/hw/vfio/types.h
@@ -0,0 +1,21 @@
+/*
+ * VFIO types definition
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_VFIO_VFIO_TYPES_H
+#define HW_VFIO_VFIO_TYPES_H
+
+/*
+ * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * between VFIO implementations that use a kernel driver
+ * with those that use user sockets.
+ */
+#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+
+#define TYPE_VFIO_PCI "vfio-pci"
+/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
+
+#endif /* HW_VFIO_VFIO_TYPES_H */
-- 
2.50.1


