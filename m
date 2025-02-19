Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDA1C021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeK8-00055Z-R1; Wed, 19 Feb 2025 02:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeIq-0002bT-U3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeIo-0005M8-I5
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739949317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zXi8ePcLudFZrqpdShmQBohG79pDZImwm/7Uyu89uM=;
 b=SZFG2bm4IC18MgdhmELlhGARi3pGeXJUkGJpeeoDlou3nzyIPNkvcIcPTOLjYz30ukLB/+
 Bimkm7lpWbCqCtvaKK2ulBvZXOv5zZIhcyGBc9qxVItdapF8hbvttU1Cue1PhF49hMlh5t
 fM1Lvthzf3HlG/HEwPtjiZQIeBnCE3Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-NB__LR88OamIaonzzkpiJw-1; Wed,
 19 Feb 2025 02:15:13 -0500
X-MC-Unique: NB__LR88OamIaonzzkpiJw-1
X-Mimecast-MFC-AGG-ID: NB__LR88OamIaonzzkpiJw_1739949311
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 382A51800360; Wed, 19 Feb 2025 07:15:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.78])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB78180087E; Wed, 19 Feb 2025 07:15:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5AA131801B04; Wed, 19 Feb 2025 08:14:33 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 graf@amazon.com, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 20/24] hw/uefi-vars-sysbus: add x64 variant
Date: Wed, 19 Feb 2025 08:14:22 +0100
Message-ID: <20250219071431.50626-21-kraxel@redhat.com>
In-Reply-To: <20250219071431.50626-1-kraxel@redhat.com>
References: <20250219071431.50626-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

The x86 variant of the device is mapped on the fixed address 0xfef10000
and uses etc/hardware-info instead of FDT to pass the mapping location
to the edk2 firmware.  The latter allows to move the device to a
different location should that turn out to be necessary in the future.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-sysbus.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 28572981c2af..d953ed8a86d9 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -9,6 +9,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 
+#include "hw/uefi/hardware-info.h"
 #include "hw/uefi/var-service.h"
 #include "hw/uefi/var-service-api.h"
 
@@ -75,6 +76,7 @@ static void uefi_vars_sysbus_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
+/* generic: hardware discovery via FDT */
 static const TypeInfo uefi_vars_sysbus_info = {
     .name          = TYPE_UEFI_VARS_SYSBUS,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -84,9 +86,39 @@ static const TypeInfo uefi_vars_sysbus_info = {
 };
 module_obj(TYPE_UEFI_VARS_SYSBUS);
 
+static void uefi_vars_x64_realize(DeviceState *dev, Error **errp)
+{
+    HARDWARE_INFO_SIMPLE_DEVICE hwinfo = {
+        .mmio_address = 0xfef10000,
+    };
+    SysBusDevice *sysbus = SYS_BUS_DEVICE(dev);
+
+    uefi_vars_sysbus_realize(dev, errp);
+
+    hardware_info_register(HardwareInfoQemuUefiVars,
+                           &hwinfo, sizeof(hwinfo));
+    sysbus_mmio_map(sysbus, 0, hwinfo.mmio_address);
+}
+
+static void uefi_vars_x64_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = uefi_vars_x64_realize;
+}
+
+/* x64: hardware discovery via etc/hardware-info fw_cfg */
+static const TypeInfo uefi_vars_x64_info = {
+    .name          = TYPE_UEFI_VARS_X64,
+    .parent        = TYPE_UEFI_VARS_SYSBUS,
+    .class_init    = uefi_vars_x64_class_init,
+};
+module_obj(TYPE_UEFI_VARS_X64);
+
 static void uefi_vars_sysbus_register_types(void)
 {
     type_register_static(&uefi_vars_sysbus_info);
+    type_register_static(&uefi_vars_x64_info);
 }
 
 type_init(uefi_vars_sysbus_register_types)
-- 
2.48.1


