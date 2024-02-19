Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E21C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6go-0004B5-KC; Mon, 19 Feb 2024 11:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gm-00040z-RI
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gk-0003Ig-Lz
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:20 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3394b892691so2544684f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360816; x=1708965616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnW3NrES6EgGgUSsi0TQE7HA63k49t1HjgMoJkFxvYI=;
 b=ISXE2Xv1Hg75yvYpo70bPxGahWsoJyl4n0DUW2AxV/4Ve2uxMTsvLdKE7VXorxITHk
 eGVhPLYo7irB+p/qmeMFdLJwIr2vHWa7/cf8ynuRhLk/fcWCvlwHYrPHPWrZHhXpnc0K
 rCx+YcLsFzmjc3btf0FbH/ZO7HCue9nlfdwfd8ArvWCPH+UEVS6nEDf577093cjjsJTE
 Ks4T5URfHnAkN+sVqEYAW/yEKbixeVgcFnzbogQOemwQ8ao5aWz/+cqNJkWAZRk4lPf7
 YQ1fxW3iaTFm3L4vhNO3ARIxOqNynfE4qrvFBIUgLBykVnKgA/IX03d/bS69QIlHr80u
 8yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360816; x=1708965616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnW3NrES6EgGgUSsi0TQE7HA63k49t1HjgMoJkFxvYI=;
 b=nBCis1vkGLc8t1H9md+ZpWLCdczYIjvd50p/wSs9brbonNpNN0c4Q2dg03VeevXExG
 IH/36dP0A1WtOwnFu6wCTpbp1K8x6O9qQpuSEGJNPLtyjotwranKW2H01HAJhAywTEhm
 ASvJl4DziFtS3Zjg1gefdHhWone3BM3UhzxK9SUlaTulo+xJYAq3eR7Mztia7CJBdO9w
 gM7As/uZ25qL4gRPFuVOY+Rs3YBKicQVIpT1O+ZEbttcqFig36zQ6f7qCqGm7N4vNK0q
 IvglH3gS/YcavHqjPljsoyOyBORamlPL26BEZOAON2mOYSkfkumFl41RnZDLINbnh6G0
 1llQ==
X-Gm-Message-State: AOJu0Yx6aIB+6+ljzF7jZH6QcAA5X6sVztyYKO7+TTq6FJQDiyU6eoCk
 5RPIzLaP/SURA2OlDy8WgarLCZyGPnMt78bmL07b0/E/9P0WpRUhNpkw4m5ea37D84hT/BK/aAi
 A
X-Google-Smtp-Source: AGHT+IHCd78u5vNHxFbZZpyHmzY/bzCTE6z370dgmODaQK35zZ4eymo1EclQWaGqn0upKmcW+G9AZg==
X-Received: by 2002:adf:ec4e:0:b0:33d:5472:5751 with SMTP id
 w14-20020adfec4e000000b0033d54725751mr2195354wrn.10.1708360816209; 
 Mon, 19 Feb 2024 08:40:16 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 bw2-20020a0560001f8200b003392206c808sm4803778wrb.105.2024.02.19.08.40.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:40:15 -0800 (PST)
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
Subject: [PATCH 11/14] hw/southbridge/ich9: Add the SMBus function
Date: Mon, 19 Feb 2024 17:38:51 +0100
Message-ID: <20240219163855.87326-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Instantiate TYPE_ICH9_SMB_DEVICE in TYPE_ICH9_SOUTHBRIDGE.

Since the PC machines can disable SMBus (see the
PC_MACHINE_SMBUS dynamic property), add the 'smbus-enabled'
property to disable it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/southbridge/ich9.h | 32 --------------------------------
 hw/i2c/smbus_ich9.c           | 29 ++++++++++++++++++++++++++++-
 hw/i386/pc_q35.c              | 10 ++--------
 hw/southbridge/ich9.c         | 21 +++++++++++++++++++++
 hw/southbridge/Kconfig        |  1 +
 5 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index ac7f9f4ff5..d4b299bf3c 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -173,38 +173,6 @@ struct ICH9LPCState {
 #define ICH9_APM_ACPI_ENABLE                    0x2
 #define ICH9_APM_ACPI_DISABLE                   0x3
 
-
-/* D31:F3 SMBus controller */
-#define TYPE_ICH9_SMB_DEVICE "ICH9-SMB"
-
-#define ICH9_A2_SMB_REVISION                    0x02
-#define ICH9_SMB_PI                             0x00
-
-#define ICH9_SMB_SMBMBAR0                       0x10
-#define ICH9_SMB_SMBMBAR1                       0x14
-#define ICH9_SMB_SMBM_BAR                       0
-#define ICH9_SMB_SMBM_SIZE                      (1 << 8)
-#define ICH9_SMB_SMB_BASE                       0x20
-#define ICH9_SMB_SMB_BASE_BAR                   4
-#define ICH9_SMB_SMB_BASE_SIZE                  (1 << 5)
-#define ICH9_SMB_HOSTC                          0x40
-#define ICH9_SMB_HOSTC_SSRESET                  ((uint8_t)(1 << 3))
-#define ICH9_SMB_HOSTC_I2C_EN                   ((uint8_t)(1 << 2))
-#define ICH9_SMB_HOSTC_SMB_SMI_EN               ((uint8_t)(1 << 1))
-#define ICH9_SMB_HOSTC_HST_EN                   ((uint8_t)(1 << 0))
-
-/* D31:F3 SMBus I/O and memory mapped I/O registers */
-#define ICH9_SMB_DEV                            31
-#define ICH9_SMB_FUNC                           3
-
-#define ICH9_SMB_HST_STS                        0x00
-#define ICH9_SMB_HST_CNT                        0x02
-#define ICH9_SMB_HST_CMD                        0x03
-#define ICH9_SMB_XMIT_SLVA                      0x04
-#define ICH9_SMB_HST_D0                         0x05
-#define ICH9_SMB_HST_D1                         0x06
-#define ICH9_SMB_HOST_BLOCK_DB                  0x07
-
 #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
 
 /* bit positions used in fw_cfg SMI feature negotiation */
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 3980bca4c5..2c18278090 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -26,10 +26,37 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
-#include "hw/southbridge/ich9.h"
 #include "qom/object.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
+/* D31:F3 SMBus controller */
+
+#define ICH9_A2_SMB_REVISION                    0x02
+#define ICH9_SMB_PI                             0x00
+
+#define ICH9_SMB_SMBMBAR0                       0x10
+#define ICH9_SMB_SMBMBAR1                       0x14
+#define ICH9_SMB_SMBM_BAR                       0
+#define ICH9_SMB_SMBM_SIZE                      (1 << 8)
+#define ICH9_SMB_SMB_BASE                       0x20
+#define ICH9_SMB_SMB_BASE_BAR                   4
+#define ICH9_SMB_SMB_BASE_SIZE                  (1 << 5)
+#define ICH9_SMB_HOSTC                          0x40
+#define ICH9_SMB_HOSTC_SSRESET                  ((uint8_t)(1 << 3))
+#define ICH9_SMB_HOSTC_I2C_EN                   ((uint8_t)(1 << 2))
+#define ICH9_SMB_HOSTC_SMB_SMI_EN               ((uint8_t)(1 << 1))
+#define ICH9_SMB_HOSTC_HST_EN                   ((uint8_t)(1 << 0))
+
+/* D31:F3 SMBus I/O and memory mapped I/O registers */
+
+#define ICH9_SMB_HST_STS                        0x00
+#define ICH9_SMB_HST_CNT                        0x02
+#define ICH9_SMB_HST_CMD                        0x03
+#define ICH9_SMB_XMIT_SLVA                      0x04
+#define ICH9_SMB_HST_D0                         0x05
+#define ICH9_SMB_HST_D1                         0x06
+#define ICH9_SMB_HOST_BLOCK_DB                  0x07
+
 static bool ich9_vmstate_need_smbus(void *opaque, int version_id)
 {
     return pm_smbus_vmstate_needed();
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 060358d449..7f6ced8a6e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -236,6 +236,7 @@ static void pc_q35_init(MachineState *machine)
                              OBJECT(host_bus), &error_abort);
     qdev_prop_set_bit(ich9, "d2p-enabled", false);
     qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
+    qdev_prop_set_bit(ich9, "smbus-enabled", pcms->smbus_enabled);
     qdev_realize_and_unref(ich9, NULL, &error_fatal);
 
     /* irq lines */
@@ -309,15 +310,8 @@ static void pc_q35_init(MachineState *machine)
     }
 
     if (pcms->smbus_enabled) {
-        PCIDevice *smb;
-
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(ich9, "i2c"));
         /* TODO: Populate SPD eeprom data.  */
-        smb = pci_create_simple_multifunction(host_bus,
-                                              PCI_DEVFN(ICH9_SMB_DEV,
-                                                        ICH9_SMB_FUNC),
-                                              TYPE_ICH9_SMB_DEVICE);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(smb), "i2c"));
-
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index 233dc1c5d7..4d2c298666 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -15,9 +15,11 @@
 #include "hw/pci-bridge/ich_dmi_pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide.h"
+#include "hw/i2c/smbus_ich9.h"
 
 #define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)
 #define ICH9_SATA1_DEVFN        PCI_DEVFN(31, 2)
+#define ICH9_SMB_DEVFN          PCI_DEVFN(31, 3)
 
 #define SATA_PORTS              6
 
@@ -26,10 +28,12 @@ struct ICH9State {
 
     I82801b11Bridge d2p;
     AHCIPCIState sata0;
+    ICH9SMBState smb;
 
     PCIBus *pci_bus;
     bool d2p_enabled;
     bool sata_enabled;
+    bool smbus_enabled;
 };
 
 static Property ich9_props[] = {
@@ -37,6 +41,7 @@ static Property ich9_props[] = {
                      TYPE_PCIE_BUS, PCIBus *),
     DEFINE_PROP_BOOL("d2p-enabled", ICH9State, d2p_enabled, true),
     DEFINE_PROP_BOOL("sata-enabled", ICH9State, sata_enabled, true),
+    DEFINE_PROP_BOOL("smbus-enabled", ICH9State, smbus_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -79,6 +84,18 @@ static bool ich9_realize_sata(ICH9State *s, Error **errp)
     return true;
 }
 
+static bool ich9_realize_smbus(ICH9State *s, Error **errp)
+{
+    object_initialize_child(OBJECT(s), "smb", &s->smb, TYPE_ICH9_SMB_DEVICE);
+    qdev_prop_set_int32(DEVICE(&s->smb), "addr", ICH9_SMB_DEVFN);
+    if (!qdev_realize(DEVICE(&s->smb), BUS(s->pci_bus), errp)) {
+        return false;
+    }
+    object_property_add_alias(OBJECT(s), "i2c", OBJECT(&s->smb), "i2c");
+
+    return true;
+}
+
 static void ich9_init(Object *obj)
 {
 }
@@ -99,6 +116,10 @@ static void ich9_realize(DeviceState *dev, Error **errp)
     if (s->sata_enabled && !ich9_realize_sata(s, errp)) {
         return;
     }
+
+    if (s->smbus_enabled && !ich9_realize_smbus(s, errp)) {
+        return;
+    }
 }
 
 static void ich9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
index f806033d48..03e89a55d1 100644
--- a/hw/southbridge/Kconfig
+++ b/hw/southbridge/Kconfig
@@ -5,3 +5,4 @@ config ICH9
     depends on PCI_EXPRESS
     imply I82801B11
     select AHCI_ICH9
+    select ACPI_ICH9
-- 
2.41.0


