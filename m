Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6184C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC08-0006qM-GP; Thu, 06 Mar 2025 09:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC06-0006pP-GC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC04-0001Zv-45
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wG2/ud91oUoTPzCY10U6/QHq4DEf7p6K3TUNPURNbp4=;
 b=BtX+JrqEGBt+Nk7hyRMpt+SdjN39iOhrm5LaMDAQ7Ush3dfldXUCE40JTULpLP2XbtVPJO
 GFYA2Rq+mCcc6Bkxefl+/y1dfPr8ksMlES7nw/vtdFV821Px0ydHtV4zDvfT31WpuATV17
 EnJ9NG2JYNxhEDSsDlpcL2x1R0Pz7tk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-HmRxqHLGPpCkJy1N-ttJCQ-1; Thu,
 06 Mar 2025 09:14:58 -0500
X-MC-Unique: HmRxqHLGPpCkJy1N-ttJCQ-1
X-Mimecast-MFC-AGG-ID: HmRxqHLGPpCkJy1N-ttJCQ_1741270497
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 838391955D52
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 14:14:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFD1118009BC; Thu,  6 Mar 2025 14:14:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/42] vfio-platform: Deprecate all forms of vfio-platform
 devices
Date: Thu,  6 Mar 2025 15:13:45 +0100
Message-ID: <20250306141419.2015340-10-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Eric Auger <eric.auger@redhat.com>

As an outcome of KVM forum 2024 "vfio-platform: live and let die?"
talk, let's deprecate vfio-platform devices.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250305124225.952791-1-eric.auger@redhat.com
[ clg: Fixed spelling in vfio-amd-xgbe section ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
 hw/vfio/amd-xgbe.c        |  2 ++
 hw/vfio/calxeda-xgmac.c   |  2 ++
 hw/vfio/platform.c        |  1 +
 4 files changed, 30 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index abadf8de2708681fb281b07e5ffc671f0c94cfe1..589951b1368327d74e4478feab903d22c13552b7 100644
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
+The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
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
index aaa96903db0a4bb881078a3f75518ac8469a99fa..5927503b5c452c4065a82786a4bda714749f0705 100644
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
index b016d42b496190ae585df1e0d90843c1f94e4497..a5ef262def9500feba5c799081e4196baba2068e 100644
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
index d9faaa73959ad36aa3a835b87964ab940928bd9f..67bc57409c1f5a6978690c3dc07d249ea0248aa0 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -575,6 +575,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
 
+    warn_report("-device vfio-platform is deprecated");
     qemu_mutex_init(&vdev->intp_mutex);
 
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
-- 
2.48.1


