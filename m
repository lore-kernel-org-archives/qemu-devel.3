Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C84C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYyT-0003xO-IF; Mon, 26 Feb 2024 06:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxj-0002xf-0x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:16:02 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxf-0000S6-6K
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:57 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33dc3fe739aso828118f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946152; x=1709550952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NakYM+jWDMcLHNPOOXYJjk0hTuKh2AH8qxOcwl0V/RA=;
 b=ZjCLDfeTOHrdJ9H0MsgCia5loQblM/OWcqJSOR6/Y2P7u/RwYNg8MWf5jXobAp6yZa
 HSWWMaAXSMCjnSGbJb3J2b4+dLbmIK2kdG7eDxbgJavoFgN0kfA5Y/NvYq8c7h7xhAVe
 fhWIallJbR85XBt2RQrUbsi5iBqIHTVQS/TSChPhCAZcGMHdnnBBhtC09iGuokrqPN+d
 dX4RpdmqGvP+PvQI6fsXKuOFHd9VNu/SIjCC7uu2/fo8YyttU5PB5o1SNBf09FdlOnRl
 p74xUPch+z4Yx7HBMdnWS90fH3fNggQxakbMtu3qtOnqi3IJGQvg7JOyeYsC0eF2enu4
 7mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946152; x=1709550952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NakYM+jWDMcLHNPOOXYJjk0hTuKh2AH8qxOcwl0V/RA=;
 b=DgFMX3HRkqd7UcjjfXjFogJa3XMYPcARh5mPE/tcwi6pt7nck4XGchle+RVAhFzKdW
 lYlPVPdkcgbWbzewEdK33D04pgQcmo4A7FOZ1eIRCbocyPWaKCviQF4aWGYTAL+07eyb
 PC1pyek2R7zRT+nTvDlXIsruxMHswX9pgeeeJrkKlJJfgfN6ASwWPa9EXYiI1IjNAh6x
 /FIv2vVajPBcqYAsEu2y59ieVO+PT+yWAD+P4/9qTZ0UNP/ktG0GWto58FfrXGgdLjn6
 vI8KGC7Euy5bLwgBcaXYr8lzSrWOW2/6eSdCaHCgGRjQvuew0DglGx/qjs5G9nzDLIPY
 rNig==
X-Gm-Message-State: AOJu0YxRXcYs0rigdApCYj9fCm5nrtAKY+d32wXx3efLV2q2QpO/IXNL
 5ZWoxDTLAJSpadNMGWMNmpoSaIiffkmabtLisqu/iuKufJyDjXDHM3gPI6lK1MFU6Ho2YzwbN3+
 e
X-Google-Smtp-Source: AGHT+IGEe+7RhEBIaT1I5YKLlMeKEK0DxU6RaOXo6TAWssiOiM2DfXepLVmdDt2AL2yBMO/24f6nFA==
X-Received: by 2002:a5d:4b8f:0:b0:33d:d7be:5852 with SMTP id
 b15-20020a5d4b8f000000b0033dd7be5852mr2096555wrt.2.1708946151894; 
 Mon, 26 Feb 2024 03:15:51 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 q1-20020adffec1000000b0033cf80ad6f5sm7903422wrs.60.2024.02.26.03.15.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/15] hw/southbridge/ich9: Add the LPC / ISA bridge
 function
Date: Mon, 26 Feb 2024 12:14:14 +0100
Message-ID: <20240226111416.39217-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Instantiate TYPE_ICH9_LPC_DEVICE in TYPE_ICH9_SOUTHBRIDGE.

Expose the SMM property so the Q35 machine can disable it
(depending on the accelerator used).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/southbridge/ich9.h |  4 ----
 hw/i386/pc_q35.c              | 20 ++++++--------------
 hw/isa/ich9_lpc.c             |  3 +++
 hw/southbridge/ich9.c         | 15 +++++++++++++++
 hw/i386/Kconfig               |  1 -
 hw/southbridge/Kconfig        |  1 +
 6 files changed, 25 insertions(+), 19 deletions(-)

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
index 14df9e910b..31ab0ae77b 100644
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
@@ -67,9 +66,7 @@ static void pc_q35_init(MachineState *machine)
     X86MachineState *x86ms = X86_MACHINE(machine);
     Object *phb;
     DeviceState *ich9;
-    PCIDevice *lpc;
     Object *lpc_obj;
-    DeviceState *lpc_dev;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
@@ -168,24 +165,19 @@ static void pc_q35_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "ich9", OBJECT(ich9));
     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
                              OBJECT(pcms->pcibus), &error_abort);
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        qdev_connect_gpio_out_named(ich9, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
+    }
     qdev_prop_set_bit(ich9, "d2p-enabled", false);
+    qdev_prop_set_bit(ich9, "smm-enabled", x86_machine_is_smm_enabled(x86ms));
     qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
     qdev_prop_set_bit(ich9, "smbus-enabled", pcms->smbus_enabled);
     /* Should we create 6 UHCI according to ich9 spec? */
     qdev_prop_set_uint8(ich9, "ehci-count", machine_usb(machine) ? 1 : 0);
     qdev_realize_and_unref(ich9, NULL, &error_fatal);
 
-    /* create ISA bus */
-    lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
-                                TYPE_ICH9_LPC_DEVICE);
-    lpc_obj = OBJECT(lpc);
-    lpc_dev = DEVICE(lpc);
-    qdev_prop_set_bit(lpc_dev, "smm-enabled",
-                      x86_machine_is_smm_enabled(x86ms));
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
-    }
-    pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
+    /* ISA bus */
+    lpc_obj = object_resolve_path_component(OBJECT(ich9), "lpc");
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(lpc_obj, "rtc"));
 
diff --git a/hw/isa/ich9_lpc.c b/hw/isa/ich9_lpc.c
index 17d4a95bd2..2339f66e0f 100644
--- a/hw/isa/ich9_lpc.c
+++ b/hw/isa/ich9_lpc.c
@@ -54,6 +54,9 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "trace.h"
 
+#define ICH9_LPC_DEV                            31
+#define ICH9_LPC_FUNC                           0
+
 #define ICH9_A2_LPC_REVISION                    0x2
 #define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
 
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index f05012959d..521925b462 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -13,6 +13,7 @@
 #include "hw/southbridge/ich9.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/ich9_dmi.h"
+#include "hw/isa/ich9_lpc.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide/ide-dev.h"
 #include "hw/i2c/ich9_smbus.h"
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
@@ -57,6 +60,14 @@ static Property ich9_props[] = {
 
 static void ich9_init(Object *obj)
 {
+    ICH9State *s = ICH9_SOUTHBRIDGE(obj);
+
+    object_initialize_child(obj, "lpc", &s->lpc, TYPE_ICH9_LPC_DEVICE);
+    qdev_pass_gpios(DEVICE(&s->lpc), DEVICE(s), ICH9_GPIO_GSI);
+    qdev_prop_set_int32(DEVICE(&s->lpc), "addr", ICH9_LPC_DEVFN);
+    qdev_prop_set_bit(DEVICE(&s->lpc), "multifunction", true);
+    object_property_add_alias(obj, "smm-enabled",
+                              OBJECT(&s->lpc), "smm-enabled");
 }
 
 static bool ich9_realize_d2p(ICH9State *s, Error **errp)
@@ -163,6 +174,10 @@ static void ich9_realize(DeviceState *dev, Error **errp)
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


