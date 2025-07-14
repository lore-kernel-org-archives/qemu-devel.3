Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F29AC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKg-0008AN-IZ; Mon, 14 Jul 2025 19:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIb-0004VY-O4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIZ-0005tH-SV
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvnomgrO0EIpFHMECBjp7SXzcEMSUEgRi45f0SJbgzI=;
 b=SgKL4RRm79sUPpNfUNiPLVRYnwVj0Elako76z8wYrQcomW5tHJZmvS1J8DESvduMKaCX4h
 KSnyMMoNRz8lEyEkOM0VUoVDKC0KwM4DbFhx16dyd4EmeCLQgnkD8hnNQ4l+BjXvdGUC6r
 INnF0Vikz17495Zv7vRZ7c47tNPJovE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-5NyrKIRWM_Sy79ejyyJ_XQ-1; Mon, 14 Jul 2025 19:09:26 -0400
X-MC-Unique: 5NyrKIRWM_Sy79ejyyJ_XQ-1
X-Mimecast-MFC-AGG-ID: 5NyrKIRWM_Sy79ejyyJ_XQ_1752534565
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so2107731f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534564; x=1753139364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvnomgrO0EIpFHMECBjp7SXzcEMSUEgRi45f0SJbgzI=;
 b=Zzl8ZZytQioiHkpqIIxugaVFYFzC+LtPtimbEBLQweJPj6JAhuhmBcOkNMC1kj9B2y
 ace7Mm3fog/gx73C/EMJHrXS3Cinv4wthccG72LIC0kD89XhGH1m+Yprz7uIxblYaRCf
 qeuzq16hudpC9e4w7u777ZWHaSlDYXawto2CZYrS3fPpg0jXZZND068dnPBckQR7wdM4
 /aXP0YArlAkWJaJoC27WvTEhLQSYjKgUh0w/lebhuy3lPAIsXHBAsWvSVv3Lkh+jFKnC
 SldNfjg5u1m2pXDVxrfQfQNj/1T56VmFpdWV09fXp8nyKDMu7hqofc2rSjr/nN7IUT9w
 XXNQ==
X-Gm-Message-State: AOJu0YwDtUBRAWIkigyFLrGV1ZCtXPNBDnAh40pi+EpDXYQ+1OzXHqVA
 KJtuhfUdfTD2qFyX22EeWNWqKeiOVlaIWI9MWrUSyoYhF9o++o+hjXVVd6itmsZ0PZlUYGv0+KT
 iMl9R8q/0ULMxp/CZUFVxN1Rq+oxOebYDDxr96BKG4eOfYgnqKZBXCTZ08AINWK5ZFHlWeH6izC
 pp5rcN9upsE1fdpDS+2p33vcvHoqdRiY0kwg==
X-Gm-Gg: ASbGncu33p3NgB4mKPJK9n3EORBWOuXTZX3P+OzfbB7aO65T9/WaXyRrjVDHnLnPtxo
 7vL+a6srh4b4vZnGV4XzO+qc7yKDFzIHhkpD0fYJt7TCiM/wq11RtqQ0xhXHNLcf3BEe0rs4jeI
 HjdhYYsJC7NRmzFpBsMqcA9AZTeokedyCNfmib0VCdgbqxrYq0wU4OJ4DV38r7xS8iqU2WtRYUS
 7MZe0wsblbDmCcbku5qdkBQmaFc+Q+8VDx3kPuYJSg4IzsZdt4t1OBEUljWiD9KUIZsGHY5S1GH
 eQ9Pt0byKPtm3rMJjXu29p25gP/RR7T3
X-Received: by 2002:a05:6000:1ac8:b0:3b4:990a:a0d6 with SMTP id
 ffacd0b85a97d-3b5f2dc2958mr10298821f8f.19.1752534564589; 
 Mon, 14 Jul 2025 16:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYEDxg9iIqOjS+1bPGVLpVKZX3A1xlg1cF1bUvJm6qAlPkE/TrFqmbaY0T0A0T4bE5443UaQ==
X-Received: by 2002:a05:6000:1ac8:b0:3b4:990a:a0d6 with SMTP id
 ffacd0b85a97d-3b5f2dc2958mr10298802f8f.19.1752534564164; 
 Mon, 14 Jul 2025 16:09:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm13500295f8f.44.2025.07.14.16.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:23 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 72/97] hw/acpi/ged: Call pcihp plug callbacks in hotplug
 handler implementation
Message-ID: <d66c3b5fd72d2badaba767f2beca5846ed7eaa39.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Add PCI device related code in the TYPE_HOTPLUG_HANDLER
implementation.

For a PCI device hotplug/hotunplug event, the code routes to
acpi_pcihp_device callbacks (pre_plug_cb, plug_cb, unplug_request_cb,
unplug_cb).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <20250714080639.2525563-27-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/generic_event_device.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index ef1c1ec51f..92b931758f 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -17,6 +17,7 @@
 #include "hw/irq.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
@@ -228,6 +229,14 @@ static const MemoryRegionOps ged_regs_ops = {
     },
 };
 
+static void acpi_ged_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
+    }
+}
+
 static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
@@ -241,6 +250,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_plug_cb(hotplug_dev, &s->pcihp_state, dev, errp);
     } else {
         error_setg(errp, "virt: device plug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -257,6 +268,9 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
         acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->pcihp_state,
+                                            dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -272,6 +286,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
         acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->pcihp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -485,6 +501,7 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
     dc->vmsd = &vmstate_acpi_ged;
     dc->realize = acpi_ged_realize;
 
+    hc->pre_plug = acpi_ged_device_pre_plug_cb;
     hc->plug = acpi_ged_device_plug_cb;
     hc->unplug_request = acpi_ged_unplug_request_cb;
     hc->unplug = acpi_ged_unplug_cb;
-- 
MST


