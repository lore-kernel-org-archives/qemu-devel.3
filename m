Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8ADD1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84H1-0003Ws-A1; Mon, 04 Nov 2024 16:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gz-0003WI-HS
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gx-0005Hp-Ok
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SE9pXEMAmep9AJtTJezsr1YC4hkUva7ZKQGQAabu7F0=;
 b=LaRk4AYYSWhcd6J4XAcEjftmETMyQ8aNVD6uV6/3HsWQtsL42LaRfeTCaEyJ9HkFuxL3kX
 8kFIYIpXEU66XRitoMD6SafsDFnu4opEKTZo3yT1uU3tVBk0EzgXdtVIEZptL3o8qkHTp0
 FylXn6Cz3st/WrZwjAYy1R0ryntxKA8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-or7VEbV7MYy4aSq1VzjSFQ-1; Mon, 04 Nov 2024 16:05:59 -0500
X-MC-Unique: or7VEbV7MYy4aSq1VzjSFQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a9a1828916fso515190466b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754357; x=1731359157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SE9pXEMAmep9AJtTJezsr1YC4hkUva7ZKQGQAabu7F0=;
 b=IO0b89IQ1wvfuA5m56q7Uc4hCUc1q4X4wx8X6jMTib2WH5/ksuK909YnS6Uh6KQf+u
 ykBbqEXMFe81Eop+EgcdlzhwYfyZBlPUhdYBRvjRfFpXRRFLCH+YFkViijvanmFnpP/o
 2AZPHbAfAGma3YFyEKW0/e2w3lUa8aGDtrI+L6vuv+4a+4w1ZTxtwQfC8nSQN5yozQS6
 PPZYpBW74NO6tnmJKrYAurB8yyMz0nsMTlbrlOm1WdFeiltn5UmW2S9czL+zdRv6Af7Q
 vWLJsS+kCv+FL/mJgociZtaCi4U9gLJ6X/f5PZJLIVtoSmnOqn1/1mCsKGDaIhH80YCO
 62Uw==
X-Gm-Message-State: AOJu0YySvw1HO36AQ2H2MzMug0F3QlGBvRAH/qv3XleICA37fifTGKcz
 VkrDTvRFiLU+MW/tELiF7VNBrNsYEvmwovhcLEThUsieuuwniJh7ND/TDu1OYz5GSaYaqYmftK2
 P8vw1Kkur94xb1RQAVIumo9My97f3FBcH9jbMC7n1CixBJ2nlJ4XQOxtntcH1I72qWhtvG7ujoI
 MTx2hxgI9nVxVYHDdyQ23/YSU5SX12tA==
X-Received: by 2002:a17:907:1b98:b0:a9e:5747:9019 with SMTP id
 a640c23a62f3a-a9e57479111mr1089861566b.8.1730754357344; 
 Mon, 04 Nov 2024 13:05:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK/zQa2XbXXxffRDFtVN6aR9pgaK0xY0QmNDB/64c01xS8gPQHF5LhMbVQu5iWHu394T/Miw==
X-Received: by 2002:a17:907:1b98:b0:a9e:5747:9019 with SMTP id
 a640c23a62f3a-a9e57479111mr1089859766b.8.1730754356931; 
 Mon, 04 Nov 2024 13:05:56 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16d6749sm31263266b.62.2024.11.04.13.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:56 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 07/65] hw/pci: Add a busnr property to pci_props and use for
 acpi/gi
Message-ID: <df9ac7254fd943c834f9666969b0852b50e91692.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using a property allows us to hide the internal details of the PCI device
from the code to build a SRAT Generic Initiator Affinity Structure with
PCI Device Handle.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/acpi_generic_initiator.c | 14 +++++++++-----
 hw/pci/pci.c                     | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 73bafaaaea..365feb527f 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -9,6 +9,7 @@
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 
 typedef struct AcpiGenericInitiatorClass {
     ObjectClass parent_class;
@@ -79,7 +80,8 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDevice *pci_dev;
+    int32_t devfn;
+    uint8_t bus;
     Object *o;
 
     if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
@@ -100,10 +102,12 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
         exit(1);
     }
 
-    pci_dev = PCI_DEVICE(o);
-    build_srat_pci_generic_initiator(table_data, gi->node, 0,
-                                     pci_bus_num(pci_get_bus(pci_dev)),
-                                     pci_dev->devfn);
+    bus = object_property_get_uint(o, "busnr", &error_fatal);
+    devfn = object_property_get_int(o, "addr", &error_fatal);
+    /* devfn is constrained in PCI to be 8 bit but storage is an int32_t */
+    assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 87da35ca9b..0b6bdaa0d7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
+static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
+
+    visit_type_uint8(v, name, &busnr, errp);
+}
+
+static const PropertyInfo prop_pci_busnr = {
+    .name = "busnr",
+    .get = prop_pci_busnr_get,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -87,6 +100,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
     DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
                      max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
+    { .name = "busnr", .info = &prop_pci_busnr },
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
MST


