Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D815C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret18-0006hu-MX; Tue, 27 Feb 2024 03:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret17-0006gA-2H
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:49 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret14-0007r7-6c
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:48 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so5262695a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023244; x=1709628044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSLapJ/N2+XLeA9rBJUgjR1T0MBY+vpck1YklG7N1oM=;
 b=WQxwkUQ3OsSwO528RyhjnNnnx7a+8WB6IZ4jzFL7fxyXSDO0EAEJWgOb3gR62bSag0
 rxDmEIFx24AlJHZQDIABmuy2wndQD/4MsweJggJTHcHLZPrdu67xKLy4t9TzMF14mxHV
 lV6BNaKz1E9YFkjoorEihjbveU7T/gk/rR4ALSELoikhlJH4/f18QeJ6uu2nqIEKutfH
 J5tctzG70El+oAsdzXKHSWrrTfA9ca0TWf+iEfo7Fsofuqr8DkjqVI3h/cIsz8Aze0VH
 LCTJWxCqk5Sx4XIYbG81LzSgQRLDRagQivBIjBoO9uz3+dMN6dbUND4nGDXSPn+QxtSP
 jpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023244; x=1709628044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSLapJ/N2+XLeA9rBJUgjR1T0MBY+vpck1YklG7N1oM=;
 b=QpnqyxhzR316y8xifOtj8cQCscUcbKprfH914by5m8spRlMuaBhvEi1bhfbozGOWA+
 55J8tlxccucTHqFg06OysCTeeiUdbIB2EhpRxEvIyDAGJie/a9ETnhDxuPdDz9baVIMp
 9fsMHaIyO20rujBF77WSan7iurRk8hPbk6tcJn0A6uYPJxymLh2UatUGOElVQrVdm0yu
 clIhDiJ44MpCKDnXvTBFPcV+33b+G3L5e117Ioh526l61sRCJ9lsV5fFIWVZK9LjJ7Ob
 muqa+/CUlCrlkzlkJVKK0okLa1Ga6PSamClbCLPTkZNdAB/IxT5Ujg3FXfF7Zzn22VUu
 9EWw==
X-Gm-Message-State: AOJu0Yz7L7D5fy0cOfbkwtQyTEU8B2S6Z9LhIv58Phd8TqMOIqTozHg9
 hiNKfhSk2GzJ/ifHa5ScckBplJTPiX1VU5lQy+UXi6IdYrN6PGQDvZIRrGafJ1YH75JxNqiMhr7
 Y
X-Google-Smtp-Source: AGHT+IG34tHzNic2vEbsxr/yqpb7KEyn1KgdcvqySNz9F9ODhY49dXusJfmfSYDHxkyV0aZN6PtStg==
X-Received: by 2002:aa7:d912:0:b0:565:6c31:9a47 with SMTP id
 a18-20020aa7d912000000b005656c319a47mr7299942edr.39.1709023244355; 
 Tue, 27 Feb 2024 00:40:44 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 cs5-20020a0564020c4500b00562d908daf4sm542409edb.84.2024.02.27.00.40.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:40:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/30] hw/nubus: add nubus-virtio-mmio device
Date: Tue, 27 Feb 2024 09:39:25 +0100
Message-ID: <20240227083948.5427-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The nubus-virtio-mmio device is a Nubus card that contains a set of 32 virtio-mmio
devices and a goldfish PIC similar to the m68k virt machine that can be plugged
into the m68k q800 machine.

There are currently a number of drivers under development that can be used in
conjunction with this device to provide accelerated and/or additional hypervisor
services to 68k Classic MacOS.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20240111102954.449462-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
 hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
 hw/nubus/meson.build                 |   1 +
 3 files changed, 139 insertions(+)
 create mode 100644 include/hw/nubus/nubus-virtio-mmio.h
 create mode 100644 hw/nubus/nubus-virtio-mmio.c

diff --git a/include/hw/nubus/nubus-virtio-mmio.h b/include/hw/nubus/nubus-virtio-mmio.h
new file mode 100644
index 0000000000..de497b7f76
--- /dev/null
+++ b/include/hw/nubus/nubus-virtio-mmio.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU Macintosh Nubus Virtio MMIO card
+ *
+ * Copyright (c) 2023 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NUBUS_VIRTIO_MMIO_H
+#define HW_NUBUS_VIRTIO_MMIO_H
+
+#include "hw/nubus/nubus.h"
+#include "qom/object.h"
+#include "hw/intc/goldfish_pic.h"
+#include "hw/virtio/virtio-mmio.h"
+
+#define TYPE_NUBUS_VIRTIO_MMIO "nubus-virtio-mmio"
+OBJECT_DECLARE_TYPE(NubusVirtioMMIO, NubusVirtioMMIODeviceClass,
+                    NUBUS_VIRTIO_MMIO)
+
+struct NubusVirtioMMIODeviceClass {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+#define NUBUS_VIRTIO_MMIO_NUM_DEVICES 32
+
+struct NubusVirtioMMIO {
+    NubusDevice parent_obj;
+
+    GoldfishPICState pic;
+    VirtIOMMIOProxy virtio_mmio[NUBUS_VIRTIO_MMIO_NUM_DEVICES];
+};
+
+#endif
diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
new file mode 100644
index 0000000000..58a63c84d0
--- /dev/null
+++ b/hw/nubus/nubus-virtio-mmio.c
@@ -0,0 +1,102 @@
+/*
+ * QEMU Macintosh Nubus Virtio MMIO card
+ *
+ * Copyright (c) 2024 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nubus/nubus-virtio-mmio.h"
+
+
+#define NUBUS_VIRTIO_MMIO_PIC_OFFSET   0
+#define NUBUS_VIRTIO_MMIO_DEV_OFFSET   0x200
+
+
+static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
+{
+    NubusDevice *nd = NUBUS_DEVICE(opaque);
+
+    nubus_set_irq(nd, level);
+}
+
+static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
+{
+    NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
+    NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
+    NubusDevice *nd = NUBUS_DEVICE(dev);
+    SysBusDevice *sbd;
+    int i, offset;
+
+    nvmdc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    /* Goldfish PIC */
+    sbd = SYS_BUS_DEVICE(&s->pic);
+    if (!sysbus_realize(sbd, errp)) {
+        return;
+    }
+    memory_region_add_subregion(&nd->slot_mem, NUBUS_VIRTIO_MMIO_PIC_OFFSET,
+                                sysbus_mmio_get_region(sbd, 0));
+    sysbus_connect_irq(sbd, 0,
+                       qdev_get_gpio_in_named(dev, "pic-input-irq", 0));
+
+    /* virtio-mmio devices */
+    offset = NUBUS_VIRTIO_MMIO_DEV_OFFSET;
+    for (i = 0; i < NUBUS_VIRTIO_MMIO_NUM_DEVICES; i++) {
+        sbd = SYS_BUS_DEVICE(&s->virtio_mmio[i]);
+        qdev_prop_set_bit(DEVICE(sbd), "force-legacy", false);
+        if (!sysbus_realize_and_unref(sbd, errp)) {
+            return;
+        }
+
+        memory_region_add_subregion(&nd->slot_mem, offset,
+                                    sysbus_mmio_get_region(sbd, 0));
+        offset += 0x200;
+
+        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(DEVICE(&s->pic), i));
+    }
+}
+
+static void nubus_virtio_mmio_init(Object *obj)
+{
+    NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(obj);
+    int i;
+
+    object_initialize_child(obj, "pic", &s->pic, TYPE_GOLDFISH_PIC);
+    for (i = 0; i < NUBUS_VIRTIO_MMIO_NUM_DEVICES; i++) {
+        char *name = g_strdup_printf("virtio-mmio[%d]", i);
+        object_initialize_child(obj, name, &s->virtio_mmio[i],
+                                TYPE_VIRTIO_MMIO);
+        g_free(name);
+    }
+
+    /* Input from goldfish PIC */
+    qdev_init_gpio_in_named(DEVICE(obj), nubus_virtio_mmio_set_input_irq,
+                            "pic-input-irq", 1);
+}
+
+static void nubus_virtio_mmio_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_CLASS(oc);
+
+    device_class_set_parent_realize(dc, nubus_virtio_mmio_realize,
+                                    &nvmdc->parent_realize);
+}
+
+static const TypeInfo nubus_virtio_mmio_types[] = {
+    {
+        .name = TYPE_NUBUS_VIRTIO_MMIO,
+        .parent = TYPE_NUBUS_DEVICE,
+        .instance_init = nubus_virtio_mmio_init,
+        .instance_size = sizeof(NubusVirtioMMIO),
+        .class_init = nubus_virtio_mmio_class_init,
+        .class_size = sizeof(NubusVirtioMMIODeviceClass),
+    },
+};
+
+DEFINE_TYPES(nubus_virtio_mmio_types)
diff --git a/hw/nubus/meson.build b/hw/nubus/meson.build
index e7ebda8993..9a7a12ea68 100644
--- a/hw/nubus/meson.build
+++ b/hw/nubus/meson.build
@@ -2,6 +2,7 @@ nubus_ss = ss.source_set()
 nubus_ss.add(files('nubus-device.c'))
 nubus_ss.add(files('nubus-bus.c'))
 nubus_ss.add(files('nubus-bridge.c'))
+nubus_ss.add(files('nubus-virtio-mmio.c'))
 nubus_ss.add(when: 'CONFIG_Q800', if_true: files('mac-nubus-bridge.c'))
 
 system_ss.add_all(when: 'CONFIG_NUBUS', if_true: nubus_ss)
-- 
2.41.0


