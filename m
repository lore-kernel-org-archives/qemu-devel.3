Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1076FE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7Sp-0006i3-QV; Fri, 13 Dec 2024 10:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7S3-0004h0-L6
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:36 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7Rq-0005M3-9W
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:34 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6aad76beeso281793766b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734103161; x=1734707961;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oYrLMZynfGoehZjWa6pbu2oV1B5fji3Vx4MV4wrlhE=;
 b=Ac0kufZqOHVxZ3OzK8cWJSWf7fAWI9SaHETMU4oxidxV7Y41IF0m9gmgctkGHIjNS/
 gCP5htd6mYddGhRNDdSx4LCqgQExFeKAcpNX8D1ArKLH0+z19f/DvkmcObwH1zqFisGM
 RM3m6EvG+ftkuOafJKnO7JH3Qlr/46/F1JFfSVhEBgT4LzEIODouEOMMWNYh8VD2LPty
 e2mdvM6ZDnpMV58Ptz3I9TKyqxp8D1NrqiR5K9H21SrjOTZ/7XTWV8YXUiMrruGr8uWr
 4kG7JSD96RVScT/SCDHgNi+zfH2Z4juCsOSyT+QE8vBNU7wU4R+NmyFoPnI4oU64GvOl
 s6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734103161; x=1734707961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oYrLMZynfGoehZjWa6pbu2oV1B5fji3Vx4MV4wrlhE=;
 b=lwuUg91Ab7LrmiFCSHDDWkFd/H2bbDPROVxjkvkKw7j8xiVdHq0iH0qamjYydz4Pbz
 XXEqDoIx+dH7caWemw4jAUVBlsQBHmyTI3G7y/hAUdJvlag0W9UIEOBA38lIesHxWlWW
 l4S/S2fZbyrgCbXnk6flbabi2wJEbEGQfet41LucUj9YQVdagA4zDYO6qv0k9RPWBn64
 v3MXy4ccewFmZoYxadygYnIE4y+NyXtP91H+KOke0N0tHE2NhAv1LkauOW8UdOLYO0PX
 5MSaEl1Oc+Lu05TbprUBlef5hZZxWdMnNEk6i9u0EMrlmEQmOj+mAuMUHu9bcFakFjXD
 7JRw==
X-Gm-Message-State: AOJu0YxLCJxEWV6+z+taY+e7xTii1wBSN5261HO7N8luhj46T6ulbVH3
 szApPMCmq+dwQRYKbRWV4um2GqK77f4zAxjqMFqxMbDdjbzRP7ZDRZHD+MXIaCVhSRljzBAtI9y
 01A==
X-Gm-Gg: ASbGnctlCPCwRVLwloB0+wprKNOON5zkZVTYBFZYOjtrw5wHPmObAAr2W1Pe0R3ctfO
 NUWxcZ3PV/xMW0AD6VgCRMLUWgdMTJ8XyKRMnnMV6XLFQgzOaE69r935/uFmSJIEFDsyfM+FzBH
 l2wp+zAeiQkRznc6ZanzZg/DnMQtXMO0otIjh8QXRFCI0ra3wIDOFwbh5HwnV5vHohj0bFgCA8n
 drWC0021RPKftbR1kfvZIowUewwp4JJQiic28Ajva/od/ChikDfE7RWB0LnRY36EUNKizg8dOX0
 NIFdc/WZ5V1c7a6lQbwBDfyMyjBjCsC3
X-Google-Smtp-Source: AGHT+IEfGlzW93XmTmvtXRt0w17s9nb+gOhhV6b/RTIMT0/A8y8Oc+wRGF9co2l7d3xuf0CKGI4M3g==
X-Received: by 2002:a17:907:9690:b0:aa6:ac19:7502 with SMTP id
 a640c23a62f3a-aab778e0769mr291075466b.4.1734103160901; 
 Fri, 13 Dec 2024 07:19:20 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab8dd35b19sm29284166b.33.2024.12.13.07.19.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 07:19:20 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Subject: [PATCH v14 07/15] hw/misc/pvpanic: Add MMIO interface
Date: Fri, 13 Dec 2024 16:18:13 +0100
Message-Id: <20241213151821.65748-24-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213151821.65748-1-phil@philjordan.eu>
References: <20241213151821.65748-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::632;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x632.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
platform device that we can use in embedded arm environments.

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v3:
 * Rebased on upstream, updated a header path

 hw/misc/Kconfig           |  4 +++
 hw/misc/meson.build       |  1 +
 hw/misc/pvpanic-mmio.c    | 61 +++++++++++++++++++++++++++++++++++++++
 include/hw/misc/pvpanic.h |  1 +
 4 files changed, 67 insertions(+)
 create mode 100644 hw/misc/pvpanic-mmio.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1f1baa5dde9..5a6c1603b60 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -145,6 +145,10 @@ config PVPANIC_ISA
     depends on ISA_BUS
     select PVPANIC_COMMON
 
+config PVPANIC_MMIO
+    bool
+    select PVPANIC_COMMON
+
 config AUX
     bool
     select I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d02d96e403b..4de4db0a600 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -122,6 +122,7 @@ system_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
 
 system_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
+system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
new file mode 100644
index 00000000000..56738efee53
--- /dev/null
+++ b/hw/misc/pvpanic-mmio.c
@@ -0,0 +1,61 @@
+/*
+ * QEMU simulated pvpanic device (MMIO frontend)
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/misc/pvpanic.h"
+#include "hw/sysbus.h"
+#include "standard-headers/misc/pvpanic.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(PVPanicMMIOState, PVPANIC_MMIO_DEVICE)
+
+#define PVPANIC_MMIO_SIZE 0x2
+
+struct PVPanicMMIOState {
+    SysBusDevice parent_obj;
+
+    PVPanicState pvpanic;
+};
+
+static void pvpanic_mmio_initfn(Object *obj)
+{
+    PVPanicMMIOState *s = PVPANIC_MMIO_DEVICE(obj);
+
+    pvpanic_setup_io(&s->pvpanic, DEVICE(s), PVPANIC_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->pvpanic.mr);
+}
+
+static Property pvpanic_mmio_properties[] = {
+    DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
+                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, pvpanic_mmio_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo pvpanic_mmio_info = {
+    .name          = TYPE_PVPANIC_MMIO_DEVICE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PVPanicMMIOState),
+    .instance_init = pvpanic_mmio_initfn,
+    .class_init    = pvpanic_mmio_class_init,
+};
+
+static void pvpanic_register_types(void)
+{
+    type_register_static(&pvpanic_mmio_info);
+}
+
+type_init(pvpanic_register_types)
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 9a71a5ad0d7..049a94c1125 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -26,6 +26,7 @@
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
+#define TYPE_PVPANIC_MMIO_DEVICE "pvpanic-mmio"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
-- 
2.39.5 (Apple Git-154)


