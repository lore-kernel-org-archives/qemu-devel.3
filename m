Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83356CAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293o-00077v-3A; Fri, 26 Sep 2025 10:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293k-0006xF-MS
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293c-0004uk-Bw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lg/hoDvOgBupiHUWGYJ7xqCBjjHA430ydslXyLpv5JA=;
 b=G6EbyskiDj6Rqsd/B0lazhB9nwMiCpFNWMVnxjw6VYPjD3HtmTJ3/Jvrrpdu36+WDIkwhI
 CwdqlMjduQvN3UgtlkLpPfq/e8qkCFXMCrJ3KFcMBi5tIBOYMp3ogJLHFWCwW7odXFbTOP
 ImaNjVOR/WhHAehAAcc5tsoUrp+zq/I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-gjg6ipFTMDK9UZ1MNlJ0fw-1; Fri,
 26 Sep 2025 10:04:01 -0400
X-MC-Unique: gjg6ipFTMDK9UZ1MNlJ0fw-1
X-Mimecast-MFC-AGG-ID: gjg6ipFTMDK9UZ1MNlJ0fw_1758895440
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B81FA1800370; Fri, 26 Sep 2025 14:04:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CBF81956095; Fri, 26 Sep 2025 14:03:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 23/32] hw/xen: mark all Xen related object types as being
 secure
Date: Fri, 26 Sep 2025 15:01:34 +0100
Message-ID: <20250926140144.1998694-24-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All Xen paravirtualized devices are intended to provide a host /
guest security barrier, so mark all Xen object types as scure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/xen-block.c        | 3 +++
 hw/char/xen_console.c       | 1 +
 hw/i386/xen/xen_platform.c  | 1 +
 hw/net/xen_nic.c            | 1 +
 hw/xen/xen-bus.c            | 3 +++
 hw/xen/xen-legacy-backend.c | 3 +++
 hw/xen/xen_pt.c             | 1 +
 7 files changed, 13 insertions(+)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 74de897c79..5112d8bdb3 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -699,6 +699,7 @@ static const TypeInfo xen_block_type_info = {
     .parent = TYPE_XEN_DEVICE,
     .instance_size = sizeof(XenBlockDevice),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(XenBlockDeviceClass),
     .class_init = xen_block_class_init,
 };
@@ -740,6 +741,7 @@ static const TypeInfo xen_disk_type_info = {
     .parent = TYPE_XEN_BLOCK_DEVICE,
     .instance_size = sizeof(XenDiskDevice),
     .class_init = xen_disk_class_init,
+    .secure = true,
 };
 
 static void xen_cdrom_unrealize(XenBlockDevice *blockdev)
@@ -787,6 +789,7 @@ static const TypeInfo xen_cdrom_type_info = {
     .parent = TYPE_XEN_BLOCK_DEVICE,
     .instance_size = sizeof(XenCDRomDevice),
     .class_init = xen_cdrom_class_init,
+    .secure = true,
 };
 
 static void xen_block_register_types(void)
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 9c34a554bf..7ba2d82c0f 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -513,6 +513,7 @@ static const TypeInfo xen_console_type_info = {
     .parent = TYPE_XEN_DEVICE,
     .instance_size = sizeof(XenConsole),
     .class_init = xen_console_class_init,
+    .secure = true,
 };
 
 static void xen_console_register_types(void)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index c8b852be0c..ec0084d6fb 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -604,6 +604,7 @@ static const TypeInfo xen_platform_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIXenPlatformState),
     .class_init    = xen_platform_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 34c6a1d0b0..eae29b4407 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -581,6 +581,7 @@ static const TypeInfo xen_net_type_info = {
     .parent = TYPE_XEN_DEVICE,
     .instance_size = sizeof(XenNetDev),
     .class_init = xen_netdev_class_init,
+    .secure = true,
 };
 
 static void xen_net_register_types(void)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 6bd2e546f6..1098156209 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -399,6 +399,7 @@ static const TypeInfo xen_bus_type_info = {
     .instance_size = sizeof(XenBus),
     .class_size = sizeof(XenBusClass),
     .class_init = xen_bus_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -1122,6 +1123,7 @@ static const TypeInfo xen_device_type_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(XenDevice),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(XenDeviceClass),
     .class_init = xen_device_class_init,
 };
@@ -1136,6 +1138,7 @@ static const TypeInfo xen_bridge_type_info = {
     .name = TYPE_XEN_BRIDGE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XenBridge),
+    .secure = true,
 };
 
 static void xen_register_types(void)
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 5ed53f8943..bc6c662678 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -648,6 +648,7 @@ static const TypeInfo xendev_type_info = {
     .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .class_init    = xendev_class_init,
     .instance_size = sizeof(XenLegacyDevice),
+    .secure        = true,
 };
 
 static void xen_sysbus_class_init(ObjectClass *klass, const void *data)
@@ -661,6 +662,7 @@ static const TypeInfo xensysbus_info = {
     .name       = TYPE_XENSYSBUS,
     .parent     = TYPE_BUS,
     .class_init = xen_sysbus_class_init,
+    .secure     = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -670,6 +672,7 @@ static const TypeInfo xensysbus_info = {
 static const TypeInfo xensysdev_info = {
     .name          = TYPE_XENSYSDEV,
     .parent        = TYPE_SYS_BUS_DEVICE,
+    .secure        = true,
 };
 
 static void xenbe_register_types(void)
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 006b5b55f2..c3ffb95b2d 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -1079,6 +1079,7 @@ static const TypeInfo xen_pci_passthrough_info = {
     .instance_finalize = xen_pci_passthrough_finalize,
     .class_init = xen_pci_passthrough_class_init,
     .class_size = sizeof(XenPTDeviceClass),
+    .secure = true,
     .instance_init = xen_pci_passthrough_instance_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-- 
2.50.1


