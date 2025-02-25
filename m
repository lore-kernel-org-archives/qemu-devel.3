Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DF2C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxqo-0002CK-G3; Tue, 25 Feb 2025 11:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxq3-000171-Hz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpz-0006bh-OR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740501075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvorbgiHjRAcQNyyKsR/FLp8f9h6za5NToARgffqtJo=;
 b=K3xcTr1ZkNo95BZ+JA4DY8dJQULkaE5lacHV8qP09Ty/NT6Vdvh0NqvyUqW/S7m9Z5gYRv
 edPTjydZIU6tXF9K0XqC0NZCkNF3jfOyYBkPqCRy52ydl9O8BjT4Hgt6TwZTuxyxErdIU5
 7o5mV5lDoZZ106OxNrXb+YYwQLicDEY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-pLfCMs8tPwygfsT2PPhbtA-1; Tue,
 25 Feb 2025 11:31:09 -0500
X-MC-Unique: pLfCMs8tPwygfsT2PPhbtA-1
X-Mimecast-MFC-AGG-ID: pLfCMs8tPwygfsT2PPhbtA_1740501068
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F007418D95EA; Tue, 25 Feb 2025 16:31:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2B12300018D; Tue, 25 Feb 2025 16:31:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CF8931800798; Tue, 25 Feb 2025 17:30:32 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 19/24] hw/uefi-vars-sysbus: qemu platform bus support
Date: Tue, 25 Feb 2025 17:30:23 +0100
Message-ID: <20250225163031.1409078-20-kraxel@redhat.com>
In-Reply-To: <20250225163031.1409078-1-kraxel@redhat.com>
References: <20250225163031.1409078-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add and register function to create an device tree entry when
the device is added to the qemu platform bus.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/sysbus-fdt.c         | 24 ++++++++++++++++++++++++
 hw/uefi/var-service-sysbus.c |  1 +
 2 files changed, 25 insertions(+)

diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index 774c0aed41b5..e85066b90563 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
+#include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
 
 /*
@@ -471,6 +472,28 @@ static int add_tpm_tis_fdt_node(SysBusDevice *sbdev, void *opaque)
 }
 #endif
 
+static int add_uefi_vars_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data = opaque;
+    PlatformBusDevice *pbus = data->pbus;
+    const char *parent_node = data->pbus_node_name;
+    void *fdt = data->fdt;
+    uint64_t mmio_base;
+    char *nodename;
+
+    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
+                               UEFI_VARS_FDT_NODE, mmio_base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename,
+                            "compatible", UEFI_VARS_FDT_COMPAT);
+    qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                 1, mmio_base,
+                                 1, UEFI_VARS_REGS_SIZE);
+    g_free(nodename);
+    return 0;
+}
+
 static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
 {
     return 0;
@@ -495,6 +518,7 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
+    TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 60072c8815cd..28572981c2af 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -69,6 +69,7 @@ static void uefi_vars_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->realize = uefi_vars_sysbus_realize;
     dc->vmsd = &vmstate_uefi_vars_sysbus;
+    dc->user_creatable = true;
     device_class_set_legacy_reset(dc, uefi_vars_sysbus_reset);
     device_class_set_props(dc, uefi_vars_sysbus_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.48.1


