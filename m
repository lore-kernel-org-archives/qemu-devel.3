Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE1FC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6gL-0002Eo-6F; Mon, 19 Feb 2024 11:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gJ-00029x-UT
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:51 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gI-00031s-2C
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d4c0b198aso631402f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360788; x=1708965588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OxqDvZ9j6jb6Om+1GR1gkKRNsMb1bOnUzZDExNDKOw=;
 b=yXeVvcUfy3yR8ERObWsaLGERWC2SRwv7YC/oLlKDA+3ZwQbkNCUBbwl6nrY5G5fPpL
 YucuW3knGL9FziUdVvNisfcgy7Yg6aeM0p9FXbLLKFgPTf+ZT4eMVrUFdIrja7Fo67Vx
 7IrZJ/sxHDpZ8XSWbocJYufyGlq7hC7kJGq8q2aZOfZPLMRAHqwVoEx6ciUbQnwjei1H
 04zohsebj41kKTWiAVENpd1LGJCI3p3eS8LJvGQAr5HAg9p2zaSEyzbKaHr3XrNJklNR
 FglYyYYNSYzueAqajyM5JDWtVgk56v9Ht9Fi0GK/SDPu+IbFpBn/25ykZU8KwxEAUbbQ
 52JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360788; x=1708965588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OxqDvZ9j6jb6Om+1GR1gkKRNsMb1bOnUzZDExNDKOw=;
 b=m2WJ9XyJ7p6UyM5lJihSbrg7jrBrLGBPM6ERVbgRLelPO72plsXOe2c0eYqHuSgLyp
 JGqnrsUAYjmRRXIcV8sHJppNI35saCQg1gfrnwiI4/dWyqOr/G4ShCCERNKsZg5X8D8e
 USNBIqwaEWAkUHi98f1epbNzCc629lCIPlKolEYROSC9HOezbgXAym+oeY3keOgoC3ma
 PEErThHUJMO+Y314TygrvrmU79yyM1UJ2eH5VHyNOLirlvE2Xs/dAOumD05fRveF5h/q
 M//ZIygP5LKLfCmOpOSWL7fc3rtOpt1y5DoCWZfsfOz1/A89T2qNDINitk7pz1mzpJQq
 5L+A==
X-Gm-Message-State: AOJu0YxPcFL55lHLTnitVuVYMtuf2pSu5XfpG3Xp6JMxz8ZRz7NoM7+I
 rmKxKWOPLB+6JWKouF/XSU5acLZjsZpmItZ4zgoqD9V1OLzXi7b8esatsMV2KThYBRJ3ENDgfAc
 c
X-Google-Smtp-Source: AGHT+IGBXbKB49ZsQkDAx1kisuhGhJN5abYaxqbxc/JHz8dDdP60F35ojiVVOCfsIPgZueXR2YiADg==
X-Received: by 2002:a05:6000:1787:b0:33d:56a0:88e7 with SMTP id
 e7-20020a056000178700b0033d56a088e7mr2147299wrg.46.1708360788074; 
 Mon, 19 Feb 2024 08:39:48 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 co22-20020a0560000a1600b0033d2848046asm8501988wrb.95.2024.02.19.08.39.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/14] hw/southbridge/ich9: Introduce TYPE_ICH9_SOUTHBRIDGE
 stub
Date: Mon, 19 Feb 2024 17:38:47 +0100
Message-ID: <20240219163855.87326-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Start the TYPE_ICH9_SOUTHBRIDGE stub, a kind of QOM
container which will contain all the ICH9 parts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                   |  1 +
 include/hw/southbridge/ich9.h |  3 ++
 hw/i386/pc_q35.c              |  7 ++++
 hw/southbridge/ich9.c         | 61 +++++++++++++++++++++++++++++++++++
 hw/Kconfig                    |  1 +
 hw/i386/Kconfig               |  1 +
 hw/meson.build                |  1 +
 hw/southbridge/Kconfig        |  5 +++
 hw/southbridge/meson.build    |  3 ++
 9 files changed, 83 insertions(+)
 create mode 100644 hw/southbridge/ich9.c
 create mode 100644 hw/southbridge/Kconfig
 create mode 100644 hw/southbridge/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 50507c3dd6..d1a2eddd4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2608,6 +2608,7 @@ S: Supported
 F: hw/acpi/ich9*.c
 F: hw/i2c/smbus_ich9.c
 F: hw/isa/lpc_ich9.c
+F: hw/southbridge/ich9.c
 F: include/hw/acpi/ich9*.h
 F: include/hw/pci-bridge/ich_dmi_pci.h
 F: include/hw/southbridge/ich9.h
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index b2abf483e0..162ae3baa1 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -11,6 +11,9 @@
 #include "qemu/notify.h"
 #include "qom/object.h"
 
+#define TYPE_ICH9_SOUTHBRIDGE "ICH9-southbridge"
+OBJECT_DECLARE_SIMPLE_TYPE(ICH9State, ICH9_SOUTHBRIDGE)
+
 #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
 
 #define TYPE_ICH9_LPC_DEVICE "ICH9-LPC"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 621661a738..311ac2be6f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -125,6 +125,7 @@ static void pc_q35_init(MachineState *machine)
     X86MachineState *x86ms = X86_MACHINE(machine);
     Object *phb;
     PCIBus *host_bus;
+    DeviceState *ich9;
     PCIDevice *lpc;
     Object *lpc_obj;
     DeviceState *lpc_dev;
@@ -233,6 +234,12 @@ static void pc_q35_init(MachineState *machine)
     host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
     pcms->bus = host_bus;
 
+    ich9 = qdev_new(TYPE_ICH9_SOUTHBRIDGE);
+    object_property_add_child(OBJECT(machine), "ich9", OBJECT(ich9));
+    object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
+                             OBJECT(host_bus), &error_abort);
+    qdev_realize_and_unref(ich9, NULL, &error_fatal);
+
     /* irq lines */
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
new file mode 100644
index 0000000000..f3a9b932ab
--- /dev/null
+++ b/hw/southbridge/ich9.c
@@ -0,0 +1,61 @@
+/*
+ * QEMU Intel ICH9 south bridge emulation
+ *
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd
+ * SPDX-FileContributor: Philippe Mathieu-Daudé
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/southbridge/ich9.h"
+#include "hw/pci/pci.h"
+
+struct ICH9State {
+    DeviceState parent_obj;
+
+    PCIBus *pci_bus;
+};
+
+static Property ich9_props[] = {
+    DEFINE_PROP_LINK("mch-pcie-bus", ICH9State, pci_bus,
+                     TYPE_PCIE_BUS, PCIBus *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ich9_init(Object *obj)
+{
+}
+
+static void ich9_realize(DeviceState *dev, Error **errp)
+{
+    ICH9State *s = ICH9_SOUTHBRIDGE(dev);
+
+    if (!s->pci_bus) {
+        error_setg(errp, "'pcie-bus' property must be set");
+        return;
+    }
+}
+
+static void ich9_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = ich9_realize;
+    device_class_set_props(dc, ich9_props);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+static const TypeInfo ich9_types[] = {
+    {
+        .name           = TYPE_ICH9_SOUTHBRIDGE,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(ICH9State),
+        .instance_init  = ich9_init,
+        .class_init     = ich9_class_init,
+    }
+};
+
+DEFINE_TYPES(ich9_types)
diff --git a/hw/Kconfig b/hw/Kconfig
index 2c00936c28..6584f2f72a 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -36,6 +36,7 @@ source scsi/Kconfig
 source sd/Kconfig
 source sensor/Kconfig
 source smbios/Kconfig
+source southbridge/Kconfig
 source ssi/Kconfig
 source timer/Kconfig
 source tpm/Kconfig
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a1846be6f7..d21638f4f9 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -99,6 +99,7 @@ config Q35
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
+    select ICH9
     select LPC_ICH9
     select AHCI_ICH9
     select DIMM
diff --git a/hw/meson.build b/hw/meson.build
index 463d702683..7f9ae8659a 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -33,6 +33,7 @@ subdir('rtc')
 subdir('scsi')
 subdir('sd')
 subdir('sensor')
+subdir('southbridge')
 subdir('smbios')
 subdir('ssi')
 subdir('timer')
diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
new file mode 100644
index 0000000000..852b7f346f
--- /dev/null
+++ b/hw/southbridge/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config ICH9
+    bool
+    depends on PCI_EXPRESS
diff --git a/hw/southbridge/meson.build b/hw/southbridge/meson.build
new file mode 100644
index 0000000000..70c1fa3cb2
--- /dev/null
+++ b/hw/southbridge/meson.build
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+system_ss.add(when: 'CONFIG_ICH9', if_true: files('ich9.c'))
-- 
2.41.0


