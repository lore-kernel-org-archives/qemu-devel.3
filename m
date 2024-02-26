Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B0DC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYxZ-0002hW-CE; Mon, 26 Feb 2024 06:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxO-0002Cw-2L
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxL-0000NK-G8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:37 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d8d5165dbso1618050f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946133; x=1709550933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s983EWlXUw8CoLKGoGbnyYE6HyzW/fgxYhU+WY62/gc=;
 b=VaVQOcMvpdqLAioMyxVOjZzlBoFZeDex+ghTwq36g3NxlCuvP1q0ledzeF4QFGE462
 ChrgE28ixs/VDC5G3eIU9sVUJYIz132Bm3xJkYdfxg54dY1QcIvZpMcJ/+bAZEkHvR12
 OHMj3F+NjqYGgqqbafy675vT/WKm3pxeHhGdclc+xLh4iOrlH6hT+VY0Vm7S0zQFUDsA
 9XZsacnjaVRbaXcljSRg3D+8/aVlRU8+EXlYAHcp2aD0S8rhPcvqmi5RjCIy6PdI3rIB
 2mXCyagp02niX6X594Cvr88aC94pE3xAYGs/1vQfxpJEasyoNtXTKrXyLRBaJpw08d+5
 4bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946133; x=1709550933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s983EWlXUw8CoLKGoGbnyYE6HyzW/fgxYhU+WY62/gc=;
 b=OvtFqUv/hc3kSLbTfZnBwqrkpvWcgFBrOI9jay8AiDp+wzTZxN04F2YwbwBwaVDlkC
 Kq2qdiaDTzsII9HlA8scRI+Gk5wZXcoZ7TuCaaOvH+0wsHP3vTFID8bo41A45ZEylwUx
 2u1vWKb36QM57pCNLnZyQcDoQB8DSP3Iwhd1CGo6wdn2WKPYrHRWOVHTQexNI1I1OSeP
 KJIB9dTeVRSk4U17fK1n9A7woWet5s1jEiQyxmkRnhOgBDJ1fXhtMunX0rJHF2OZc5pG
 xlfeuemGnmSUjLrkaPZcX7TxJ62gfkFnf7ejpJvAYLFWMmO7AAQtkN1yYoTBPhc7Y+vX
 7glg==
X-Gm-Message-State: AOJu0YxwqbURTavsLu6pnHCAy5O3TpIV7qvh6d3AheOO+J8gdp2E9Sg2
 dhybW3TU0WSWFyP0IBJeexpPnskkRd9tVmgK+JCi17Am7zZ8eK5UulaUxXBEYJyTBleXBqLhuaL
 F
X-Google-Smtp-Source: AGHT+IFpZheZUV7JSmoSzU7hEqYnUJhwqD3pr0OuOPH93uXUsadrMJq08GFPN6rMiouXS2JHxO4x5Q==
X-Received: by 2002:adf:f350:0:b0:33d:855d:7457 with SMTP id
 e16-20020adff350000000b0033d855d7457mr4649165wrp.21.1708946133496; 
 Mon, 26 Feb 2024 03:15:33 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 g10-20020adfd1ea000000b0033d282c7537sm8202395wrd.23.2024.02.26.03.15.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:33 -0800 (PST)
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
Subject: [PATCH v2 12/15] hw/southbridge/ich9: Add the SMBus function
Date: Mon, 26 Feb 2024 12:14:11 +0100
Message-ID: <20240226111416.39217-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
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

Instantiate TYPE_ICH9_SMB_DEVICE in TYPE_ICH9_SOUTHBRIDGE.

Since the PC machines can disable SMBus (see the
PC_MACHINE_SMBUS dynamic property), add the 'smbus-enabled'
property to disable it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/southbridge/ich9.h | 32 --------------------------------
 hw/i2c/ich9_smbus.c           | 29 ++++++++++++++++++++++++++++-
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
diff --git a/hw/i2c/ich9_smbus.c b/hw/i2c/ich9_smbus.c
index 35f526d71c..1c3b9964de 100644
--- a/hw/i2c/ich9_smbus.c
+++ b/hw/i2c/ich9_smbus.c
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
index 6903719b97..0ff94b7afd 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -224,6 +224,7 @@ static void pc_q35_init(MachineState *machine)
                              OBJECT(pcms->pcibus), &error_abort);
     qdev_prop_set_bit(ich9, "d2p-enabled", false);
     qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
+    qdev_prop_set_bit(ich9, "smbus-enabled", pcms->smbus_enabled);
     qdev_realize_and_unref(ich9, NULL, &error_fatal);
 
     /* create ISA bus */
@@ -294,15 +295,8 @@ static void pc_q35_init(MachineState *machine)
     }
 
     if (pcms->smbus_enabled) {
-        PCIDevice *smb;
-
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(ich9, "i2c"));
         /* TODO: Populate SPD eeprom data.  */
-        smb = pci_create_simple_multifunction(pcms->pcibus,
-                                              PCI_DEVFN(ICH9_SMB_DEV,
-                                                        ICH9_SMB_FUNC),
-                                              TYPE_ICH9_SMB_DEVICE);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(smb), "i2c"));
-
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index 37255bb941..413e9187e4 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -15,9 +15,11 @@
 #include "hw/pci-bridge/ich9_dmi.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide/ide-dev.h"
+#include "hw/i2c/ich9_smbus.h"
 
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
 
@@ -83,6 +88,18 @@ static bool ich9_realize_sata(ICH9State *s, Error **errp)
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
 static void ich9_realize(DeviceState *dev, Error **errp)
 {
     ICH9State *s = ICH9_SOUTHBRIDGE(dev);
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


