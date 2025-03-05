Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39143C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 12:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpo5P-0006ZS-Sl; Wed, 05 Mar 2025 07:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tpo5M-0006Z7-M4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tpo5L-0004M4-3C
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741178569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fg5J8NxkDbLS4yeDRQRJ9QAMHMcVuEAVMAod44bApaU=;
 b=E774GMilVvjeKnMqwEloGPktF8cggOIX9qZOGT2G0Yq6fipVbI1GxOy/9k1H5HqmNpx6zI
 KnDLWuVv8XPU+2fLOWkt2p2TCoBodt0C1UoFbIB+m5h28pJbpUerAx+W7U6cmm0GgUT7iD
 2Ee06WyKOgpZ3FnMHQrB3Tgxohwm6Bg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-D3XAp5m1O0Ok5eXVo-XRYA-1; Wed,
 05 Mar 2025 07:42:41 -0500
X-MC-Unique: D3XAp5m1O0Ok5eXVo-XRYA-1
X-Mimecast-MFC-AGG-ID: D3XAp5m1O0Ok5eXVo-XRYA_1741178560
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DD9019560B4; Wed,  5 Mar 2025 12:42:39 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.225.55])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF9AB1956095; Wed,  5 Mar 2025 12:42:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, clg@redhat.com
Cc: zhenzhong.duan@intel.com,
	will@kernel.org,
	maz@kernel.org
Subject: [PATCH v2] vfio-platform: Deprecate all forms of vfio-platform devices
Date: Wed,  5 Mar 2025 13:42:25 +0100
Message-ID: <20250305124225.952791-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

As an outcome of KVM forum 2024 "vfio-platform: live and let die?"
talk, let's deprecate vfio-platform devices.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
 hw/vfio/amd-xgbe.c        |  2 ++
 hw/vfio/calxeda-xgmac.c   |  2 ++
 hw/vfio/platform.c        |  1 +
 4 files changed, 30 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index abadf8de27..004ed48159 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -434,6 +434,31 @@ Stream ``reconnect`` (since 9.2)
 The ``reconnect`` option only allows specifiying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
+VFIO device options
+'''''''''''''''''''
+
+``-device vfio-calxeda-xgmac`` (since 10.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
+10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
+string) to a guest. Calxeda HW has been ewasted now and there is no point
+keeping that device.
+
+``-device vfio-amd-xgbe`` (since 10.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The vfio-amd-xgbe devices allows to assign a host AMD 10GbE controller
+to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
+is not supported anymore and there is no point keeping that device.
+
+``-device vfio-platform`` (since 10.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The vfio-platform device allows to assign a host platform device
+to a guest in a generic manner. Integrating a new device into
+the vfio-platform infrastructure requires some adaptation at
+both kernel and qemu level. No such attempt has been done for years
+and the conclusion is that vfio-platform has not got any traction.
+PCIe passthrough shall be the mainline solution.
+
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index aaa96903db..5927503b5c 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -15,12 +15,14 @@
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 
 static void amd_xgbe_realize(DeviceState *dev, Error **errp)
 {
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
     VFIOAmdXgbeDeviceClass *k = VFIO_AMD_XGBE_DEVICE_GET_CLASS(dev);
 
+    warn_report("-device vfio-amd-xgbe is deprecated");
     vdev->compat = g_strdup("amd,xgbe-seattle-v1a");
     vdev->num_compat = 1;
 
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index b016d42b49..a5ef262def 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -15,12 +15,14 @@
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 
 static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
 {
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
     VFIOCalxedaXgmacDeviceClass *k = VFIO_CALXEDA_XGMAC_DEVICE_GET_CLASS(dev);
 
+    warn_report("-device vfio-calxeda-xgmac is deprecated");
     vdev->compat = g_strdup("calxeda,hb-xgmac");
     vdev->num_compat = 1;
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index f491f4dc95..a09f7f65c6 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -575,6 +575,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
 
+    warn_report("-device vfio-platform is deprecated");
     qemu_mutex_init(&vdev->intp_mutex);
 
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
-- 
2.47.1


