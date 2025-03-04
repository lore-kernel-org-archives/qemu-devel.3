Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F380C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpRki-0001Kh-U0; Tue, 04 Mar 2025 07:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhq-0004vU-1A
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhm-0007Ka-Ui
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741092542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCfTLGK5BCPPyuAOyalwI7XVH4IGkc4LkKHa1QF2XYI=;
 b=PgIdhtMN/S5bEE+AFAlpMFOg9AOPAuraHapvfL9UJEtoMv61uTUsU72GHjMRstxkQ8SfvA
 DmB0zbcDrBPhyTU6E9JPmLYN4x1IxFTWLwDG3phfjkJ3a6DU1x4LOEjpx0U7tDi4V8mNsJ
 qN9svjkMMYs1f6qNwJm3km76Ch2BYMM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-E2cBlXwAMnGUepkLmjbCdg-1; Tue,
 04 Mar 2025 07:48:58 -0500
X-MC-Unique: E2cBlXwAMnGUepkLmjbCdg-1
X-Mimecast-MFC-AGG-ID: E2cBlXwAMnGUepkLmjbCdg_1741092536
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 964F11944D01; Tue,  4 Mar 2025 12:48:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2004819560AA; Tue,  4 Mar 2025 12:48:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 91455180060A; Tue, 04 Mar 2025 13:48:16 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 20/24] hw/uefi-vars-sysbus: add x64 variant
Date: Tue,  4 Mar 2025 13:48:08 +0100
Message-ID: <20250304124815.591749-21-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-1-kraxel@redhat.com>
References: <20250304124815.591749-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20250225163031.1409078-21-kraxel@redhat.com>
---
 hw/uefi/var-service-sysbus.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 28572981c2af..97da8672ee95 100644
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
+        .mmio_address = cpu_to_le64(0xfef10000),
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


