Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D3DC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmVB-0003Fy-Go; Tue, 11 Feb 2025 04:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1thmV0-0002kK-Ox
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:24:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1thmUy-00036y-46
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739265846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3JGnByaULko5s3TrMphw9I/6+/M5NwhjAWDR8JTbp8=;
 b=hI71h+DrLrCsOmD2DuFlb0jkuUDQpt7U70M2SPT7VEAvaTcPhRY35oBOSvhRzn+KxMWmM3
 DB8nbF02PmqSNKpf7EJLhmgcUI+u34KshJg+0QE5K3Lpb3/zvBHI0sXpz43fa1TiZs6RRZ
 HztEUzgqGEPfxHrwehhLbdrlgugVlMI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-_wcqeyWeMHqaGxD9wXAMEA-1; Tue,
 11 Feb 2025 04:24:01 -0500
X-MC-Unique: _wcqeyWeMHqaGxD9wXAMEA-1
X-Mimecast-MFC-AGG-ID: _wcqeyWeMHqaGxD9wXAMEA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E488180087F; Tue, 11 Feb 2025 09:24:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.57])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D77630001AB; Tue, 11 Feb 2025 09:24:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F04701800626; Tue, 11 Feb 2025 10:23:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 21/23] hw/uefi-vars-isa: add acpi device
Date: Tue, 11 Feb 2025 10:23:19 +0100
Message-ID: <20250211092324.965440-22-kraxel@redhat.com>
In-Reply-To: <20250211092324.965440-1-kraxel@redhat.com>
References: <20250211092324.965440-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Tell the guest OS the io address range is used.
Shows up in /proc/ioports in linux.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-isa.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/uefi/var-service-isa.c b/hw/uefi/var-service-isa.c
index 8247b9ae054a..24d1cae1bb19 100644
--- a/hw/uefi/var-service-isa.c
+++ b/hw/uefi/var-service-isa.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
 
+#include "hw/acpi/acpi_aml_interface.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 
@@ -61,12 +62,32 @@ static void uefi_vars_isa_realize(DeviceState *dev, Error **errp)
     uefi_vars_realize(&uv->state, errp);
 }
 
+static void uefi_vars_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    Aml *dev;
+    Aml *crs;
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16,
+                           UEFI_VARS_IO_BASE, UEFI_VARS_IO_BASE,
+                           0x00, UEFI_VARS_REGS_SIZE));
+
+    dev = aml_device("QEFI");
+    aml_append(dev, aml_name_decl("_HID", aml_string("UEFIVARS")));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xb)));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, dev);
+}
+
 static void uefi_vars_isa_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     dc->realize = uefi_vars_isa_realize;
     dc->vmsd = &vmstate_uefi_vars_isa;
+    adevc->build_dev_aml = uefi_vars_isa_build_aml;
     device_class_set_legacy_reset(dc, uefi_vars_isa_reset);
     device_class_set_props(dc, uefi_vars_isa_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -78,6 +99,10 @@ static const TypeInfo uefi_vars_isa_info = {
     .instance_size = sizeof(uefi_vars_isa_state),
     .instance_init = uefi_vars_isa_init,
     .class_init    = uefi_vars_isa_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_ACPI_DEV_AML_IF },
+        { },
+    },
 };
 module_obj(TYPE_UEFI_VARS_ISA);
 module_dep("hw-uefi-vars");
-- 
2.48.1


