Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C47C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NYL-0007AR-6e; Tue, 15 Sep 2026 03:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6NXt-00072o-2o
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6NXq-0003px-4R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789457131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G2cOVilHEU94V7VWrEhEc/7CPmcmkHOm88kjHxf7ZQ=;
 b=OQOCQLgffQg+q/vhnnBvMF2ps02GkZwARx7hBvcGq30jbFHI8Y54ir3wUsypgp/psjdvnc
 npp7/pRHynme/A//TJjynHHLbnTbBXM3OMMR1rBJ/ip69ngh40Vxf8NzVulPyC4WiXGr3x
 WHnlZhGR02mnd5IHOO76z8F8gloIgXg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-OrWUy97vNE-F4lCzma8n_Q-1; Tue,
 15 Sep 2026 03:25:27 -0400
X-MC-Unique: OrWUy97vNE-F4lCzma8n_Q-1
X-Mimecast-MFC-AGG-ID: OrWUy97vNE-F4lCzma8n_Q_1789457126
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C8191802163; Tue, 15 Sep 2026 07:25:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.23])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33960426; Tue, 15 Sep 2026 07:25:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] hw/pci-bridge: Add x-speed and x-width properties to
 x3130-upstream
Date: Tue, 15 Sep 2026 09:25:07 +0200
Message-ID: <20260915072507.1230187-3-clg@redhat.com>
In-Reply-To: <20260915072507.1230187-1-clg@redhat.com>
References: <20260915072507.1230187-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The x3130 upstream port is stuck at the 2.5GT/s x1 default. Following
the CXL upstream port pattern, introduce an XIO3130Upstream struct
wrapping PCIEPort with speed and width fields to be able to set them.

Default to 16GT/s x32 for new machine types and add compat entries
for <= 11.1 to preserve the old 2.5GT/s x1 behavior.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4409
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/core/machine.c                |  2 ++
 hw/pci-bridge/xio3130_upstream.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b702a61f7335a30841164279e73432bc238ee5e5..3c98d62860d5ce058c4fbfdb86d2661f20e22b8f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -45,6 +45,8 @@ GlobalProperty hw_compat_11_1[] = {
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "xio3130-downstream", "x-speed", "2_5" },
     { "xio3130-downstream", "x-width", "1" },
+    { "x3130-upstream", "x-speed", "2_5" },
+    { "x3130-upstream", "x-width", "1" },
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 40057b749bfd01bbd548b025607ef041b9feccc5..247994772c30373b7f3c6f9e72237dbed529ed98 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,9 +24,24 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
+#define TYPE_XIO3130_UPSTREAM "x3130-upstream"
+
+OBJECT_DECLARE_SIMPLE_TYPE(XIO3130Upstream, XIO3130_UPSTREAM)
+
+struct XIO3130Upstream {
+    /*< private >*/
+    PCIEPort parent_obj;
+
+    /*< public >*/
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+};
+
 #define PCI_DEVICE_ID_TI_XIO3130U       0x8232  /* upstream port */
 #define XIO3130_REVISION                0x2
 #define XIO3130_MSI_OFFSET              0x70
@@ -49,9 +64,11 @@ static void xio3130_upstream_write_config(PCIDevice *d, uint32_t address,
 static void xio3130_upstream_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
+    XIO3130Upstream *u = XIO3130_UPSTREAM(qdev);
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
+    pcie_cap_fill_link_ep_usp(d, u->width, u->speed, false);
 }
 
 static void xio3130_upstream_realize(PCIDevice *d, Error **errp)
@@ -110,6 +127,13 @@ static void xio3130_upstream_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
+static const Property xio3130_upstream_props[] = {
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", XIO3130Upstream,
+                                speed, PCIE_LINK_SPEED_16),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", XIO3130Upstream,
+                                width, PCIE_LINK_WIDTH_32),
+};
+
 static const VMStateDescription vmstate_xio3130_upstream = {
     .name = "xio3130-express-upstream-port",
     .priority = MIG_PRI_PCI_BUS,
@@ -138,11 +162,13 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
     dc->desc = "TI X3130 Upstream Port of PCI Express Switch";
     device_class_set_legacy_reset(dc, xio3130_upstream_reset);
     dc->vmsd = &vmstate_xio3130_upstream;
+    device_class_set_props(dc, xio3130_upstream_props);
 }
 
 static const TypeInfo xio3130_upstream_info = {
-    .name          = "x3130-upstream",
+    .name          = TYPE_XIO3130_UPSTREAM,
     .parent        = TYPE_PCIE_PORT,
+    .instance_size = sizeof(XIO3130Upstream),
     .class_init    = xio3130_upstream_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
-- 
2.55.0


