Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED0C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6h9-000579-E6; Mon, 19 Feb 2024 11:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6h7-000504-QJ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:41 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6h5-0003Po-KT
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:41 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d2387a5408so19228181fa.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360837; x=1708965637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3eeC3bMQM+uCMwmyOtFt5MF4rfCj1kFAANhRaPaRfQ=;
 b=JTsYYdWwk1w/XseV5ouXQjcXXViMNXk5D3gIkCy/fnxzCvHjhh6RAOtPa79LkyGbso
 Pi+6JUneC2fHn1yjJVAhysYbSU7ILhAU/wkgaDtgAdZYwvUKvH6mEszNY8PZh9VS5B2J
 NHExDuU6bY399TdF7mAMPLxObJf37AehMsKX0eJ5loZ+HWTWzlyN/9BWyKH50RDYJdsg
 SgeJU1P2IOITtjd3pbl3YLt4SIrzL8zsaGZR/i/jpeP+y2eSPh/MV3RyTPIVp4Q/tnvZ
 ZBihwGhzyJQMSTeiP+eAMp24G1/A6E27/zm/5eAO+Glf9fGFFMjHEOZhZpJWd9R6g/FJ
 EqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360837; x=1708965637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3eeC3bMQM+uCMwmyOtFt5MF4rfCj1kFAANhRaPaRfQ=;
 b=v32/nyzot9abwaSl/HAnHUAX+x1WtXHdP5O+cGmxsthOYfRHgqI4hVVdfnP5402dDA
 DbWXBqAvvuyBgm+NIjd3NGwIM45gynlaiOw4C3ma/M4oF7jfiHpYxVpJeNX0ZsVTd6ib
 ftxTo1ATg2cYV56Jh4MA/1jGI7d1y93NBaNXMNS0+hAkbfOK+l5Hlgip4kVpTn2hKNQb
 tRUySjrbcC8ChOfLx6wL7sRL7ZouNrSTPxcAAiqWlYRe50itvIX8t6C9AvzutQKpkpxk
 w/JPD1N5iGh1WlKf0QAAdvgOMba1B+M/CB7y7PH35PYV5//kEoGHh7+g1BPkTlJV239H
 wwkw==
X-Gm-Message-State: AOJu0Yx1PdOf0VGhkbSh+wje39HIUFyY2aV8tR5RxvcLo2XtMTYBgkuk
 VVD4IDSwPj7oWwstQDskYi624L63XMfizhlqK57PDccsEdLIY+ft5Bc6SL5RDNsrAFSCgijunTg
 T
X-Google-Smtp-Source: AGHT+IFL6PlJw3csmcdmMjRyHWjUkItfN9834nwkTJF95CjSJARUAwoDFRFaXI/3Cln36nCuloJcBg==
X-Received: by 2002:a2e:2a84:0:b0:2d2:3b6f:3630 with SMTP id
 q126-20020a2e2a84000000b002d23b6f3630mr1760945ljq.2.1708360837185; 
 Mon, 19 Feb 2024 08:40:37 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 bw4-20020a0560001f8400b0033d297c9118sm8300073wrb.24.2024.02.19.08.40.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:40:36 -0800 (PST)
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
Subject: [PATCH 14/14] hw/southbridge/ich9: Add the LPC / ISA bridge function
Date: Mon, 19 Feb 2024 17:38:54 +0100
Message-ID: <20240219163855.87326-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Instantiate TYPE_ICH9_LPC_DEVICE in TYPE_ICH9_SOUTHBRIDGE.

Expose the SMM property so the Q35 machine can disable it
(depending on the accelerator used).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/southbridge/ich9.h |  4 ----
 hw/i386/pc_q35.c              | 12 +++---------
 hw/isa/lpc_ich9.c             |  3 +++
 hw/southbridge/ich9.c         | 14 ++++++++++++++
 hw/i386/Kconfig               |  1 -
 hw/southbridge/Kconfig        |  1 +
 6 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index d6c3b5ece3..a8da4a8665 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -16,10 +16,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(ICH9State, ICH9_SOUTHBRIDGE)
 #define ICH9_PCIE_DEV                           28
 #define ICH9_PCIE_FUNC_MAX                      6
 
-/* D31:F1 LPC controller */
-#define ICH9_LPC_DEV                            31
-#define ICH9_LPC_FUNC                           0
-
 #define ICH9_GPIO_GSI "gsi"
 
 #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 573a5a0bc0..0fe43e8e2d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -50,7 +50,6 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/intc/ioapic.h"
 #include "hw/southbridge/ich9.h"
-#include "hw/isa/ich9_lpc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
@@ -69,7 +68,6 @@ static void pc_q35_init(MachineState *machine)
     Object *phb;
     PCIBus *host_bus;
     DeviceState *ich9;
-    PCIDevice *lpc;
     Object *lpc_obj;
     DeviceState *lpc_dev;
     BusState *idebus[2] = { };
@@ -181,6 +179,7 @@ static void pc_q35_init(MachineState *machine)
     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
                              OBJECT(host_bus), &error_abort);
     qdev_prop_set_bit(ich9, "d2p-enabled", false);
+    qdev_prop_set_bit(ich9, "smm-enabled", x86_machine_is_smm_enabled(x86ms));
     qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
     qdev_prop_set_bit(ich9, "smbus-enabled", pcms->smbus_enabled);
     /* Should we create 6 UHCI according to ich9 spec? */
@@ -191,13 +190,8 @@ static void pc_q35_init(MachineState *machine)
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
     /* create ISA bus */
-    lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
-                                TYPE_ICH9_LPC_DEVICE);
-    lpc_obj = OBJECT(lpc);
-    lpc_dev = DEVICE(lpc);
-    qdev_prop_set_bit(lpc_dev, "smm-enabled",
-                      x86_machine_is_smm_enabled(x86ms));
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
+    lpc_obj = object_resolve_path_component(OBJECT(ich9), "lpc");
+    lpc_dev = DEVICE(lpc_obj);
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 685ac38c72..4d7b5c0c64 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -55,6 +55,9 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "trace.h"
 
+#define ICH9_LPC_DEV                            31
+#define ICH9_LPC_FUNC                           0
+
 #define ICH9_A2_LPC_REVISION                    0x2
 #define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
 
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index 085d75e569..57a05b35e1 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -13,6 +13,7 @@
 #include "hw/southbridge/ich9.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/ich_dmi_pci.h"
+#include "hw/isa/ich9_lpc.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide.h"
 #include "hw/i2c/smbus_ich9.h"
@@ -21,6 +22,7 @@
 #include "hw/usb/hcd-uhci.h"
 
 #define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)
+#define ICH9_LPC_DEVFN          PCI_DEVFN(31, 0)
 #define ICH9_SATA1_DEVFN        PCI_DEVFN(31, 2)
 #define ICH9_SMB_DEVFN          PCI_DEVFN(31, 3)
 #define ICH9_EHCI_FUNC          7
@@ -34,6 +36,7 @@ struct ICH9State {
 
     I82801b11Bridge d2p;
     AHCIPCIState sata0;
+    ICH9LPCState lpc;
     ICH9SMBState smb;
     EHCIPCIState ehci[EHCI_PER_FN];
     UHCIState uhci[EHCI_PER_FN * UHCI_PER_FN];
@@ -148,6 +151,13 @@ static bool ich9_realize_usb(ICH9State *s, Error **errp)
 
 static void ich9_init(Object *obj)
 {
+    ICH9State *s = ICH9_SOUTHBRIDGE(obj);
+
+    object_initialize_child(obj, "lpc", &s->lpc, TYPE_ICH9_LPC_DEVICE);
+    qdev_prop_set_int32(DEVICE(&s->lpc), "addr", ICH9_LPC_DEVFN);
+    qdev_prop_set_bit(DEVICE(&s->lpc), "multifunction", true);
+    object_property_add_alias(obj, "smm-enabled",
+                              OBJECT(&s->lpc), "smm-enabled");
 }
 
 static void ich9_realize(DeviceState *dev, Error **errp)
@@ -163,6 +173,10 @@ static void ich9_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!qdev_realize(DEVICE(&s->lpc), BUS(s->pci_bus), errp)) {
+        return;
+    }
+
     if (s->sata_enabled && !ich9_realize_sata(s, errp)) {
         return;
     }
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 226d7f6916..eccc834e49 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -100,7 +100,6 @@ config Q35
     select PC_ACPI
     select PCI_EXPRESS_Q35
     select ICH9
-    select LPC_ICH9
     select DIMM
     select SMBIOS
     select FW_CFG_DMA
diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
index 31eb125bf7..8ce62b703c 100644
--- a/hw/southbridge/Kconfig
+++ b/hw/southbridge/Kconfig
@@ -8,3 +8,4 @@ config ICH9
     select ACPI_ICH9
     imply USB_EHCI_PCI
     imply USB_UHCI
+    select LPC_ICH9
-- 
2.41.0


