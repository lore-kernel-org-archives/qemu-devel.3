Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409CDC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYxO-0002Dx-Q6; Mon, 26 Feb 2024 06:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxJ-0001mE-5Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxF-0000JW-9k
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d6cc6d2fcso1886006f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946127; x=1709550927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0myDJN7KWIq+zhdXH485qfcnlMrSf8PYAw/yPV+zbRY=;
 b=pbY6+qG8naM2G0M8LJm5cvmX0Dj8eyHL4adk0JHOgXkHMNoih0fBWULWIcXx7R5lRq
 16MbPv2OJz4JMqBg4MZUbRnGbCF+hGkYZ3SJ+jTlipV52YfIc0F/pC4zWr6TTVWVZbaD
 /7V8LkYWDw6nzVFWgSJYDKNEM6gQqGNbk+Fz6+BN1ExqNT0HGL5zeyZOLwbYp5glp5yt
 M6c62v0xXgiGR8T61kKHfJXj89b6w9G2ska2lmr0j2Q9/sUebSNF+YS269OkmXiN2VPz
 GzfutzLNc/H/QYpcIm9mtfVqtAUtvE5A0DtGplFDNIOPWyNbV30mfXX9cQozeMxiOtY2
 R04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946127; x=1709550927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0myDJN7KWIq+zhdXH485qfcnlMrSf8PYAw/yPV+zbRY=;
 b=VnAAzCz1OmXhN4tKp/yzDc4bbDFfoRLiJ2ML8yEbf+ftLsaHFZrT+/GeMv46gPyvOv
 N9N+m2sves2mqNdxzr9sVAvnwsYHSTlkIeGVVdYt+szS3SeKYlvZh5McH6JJtfjuY7fi
 FM0Q47yDneCn7Zs7VUKEwUKyz/p6c0lSpSCaBYNVH0/Ve7rYnqLbKamEvou+z7/G9/Tq
 1wDvWEgxODmv09eDBkFQYpVhZZONgWa5keDnxzcC+rAV+Egk43xjITXJH1TRI0sVU/Rw
 bGHiQ/mFePZxfwV7IDP6ikYK5H8I+6voFx9rKti8zI6N3nfnQnl+SM0bPhlLLvMPI2Nd
 biGA==
X-Gm-Message-State: AOJu0Yz3Z0aj1PYogebhFbzrs0iS6MQQrHQFPR0Y+4j93+gUfARtBQ+M
 mkS5FIQpQbmfZKXZNJzDB546IpWkOlEZOPEZ4I2QI1g7JtXY1kpi2VP5/xfXvm1mRimSOcKiVxi
 c
X-Google-Smtp-Source: AGHT+IE56Md7aAemZ3kKPHBxRkOaQQtCKRcXvzky86nOSQX+T3Ymyy/dMt3D5C20uhadNQLNb7ZqAQ==
X-Received: by 2002:a5d:4b4f:0:b0:33d:af8b:6b79 with SMTP id
 w15-20020a5d4b4f000000b0033daf8b6b79mr4991784wrs.6.1708946127184; 
 Mon, 26 Feb 2024 03:15:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adfce8f000000b0033db2d6bf83sm7889401wrn.34.2024.02.26.03.15.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:26 -0800 (PST)
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
Subject: [PATCH v2 11/15] hw/southbridge/ich9: Add a AHCI function
Date: Mon, 26 Feb 2024 12:14:10 +0100
Message-ID: <20240226111416.39217-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Instantiate TYPE_ICH9_AHCI in TYPE_ICH9_SOUTHBRIDGE.

Since the PC machines can disable SATA (see the
PC_MACHINE_SATA dynamic property), add the 'sata-enabled'
property to disable it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                   |  2 ++
 include/hw/southbridge/ich9.h |  4 ----
 hw/i386/pc_q35.c              | 21 +++------------------
 hw/southbridge/ich9.c         | 35 +++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig               |  1 -
 hw/southbridge/Kconfig        |  1 +
 6 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4576339053..7d1b3e0d99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2615,10 +2615,12 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: hw/acpi/ich9*.c
 F: hw/i2c/smbus_ich9.c
+F: hw/ide/ich9_ahci.c
 F: hw/isa/lpc_ich9.c
 F: hw/southbridge/ich9.c
 F: include/hw/acpi/ich9*.h
 F: include/hw/i2c/ich9_smbus.h
+F: include/hw/ide/ahci-pci.h
 F: include/hw/pci-bridge/ich9_dmi.h
 F: include/hw/southbridge/ich9.h
 
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index b9122d299d..ac7f9f4ff5 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -166,10 +166,6 @@ struct ICH9LPCState {
 
 #define ICH9_GPIO_GSI "gsi"
 
-/* D31:F2 SATA Controller #1 */
-#define ICH9_SATA1_DEV                          31
-#define ICH9_SATA1_FUNC                         2
-
 /* D31:F0 power management I/O registers
    offset from the address ICH9_LPC_PMBASE */
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f951cf1e3a..6903719b97 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -60,9 +60,6 @@
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
 
-/* ICH9 AHCI has 6 ports */
-#define MAX_SATA_PORTS     6
-
 struct ehci_companions {
     const char *name;
     int func;
@@ -134,7 +131,6 @@ static void pc_q35_init(MachineState *machine)
     ISABus *isa_bus;
     int i;
     ram_addr_t lowmem;
-    DriveInfo *hd[MAX_SATA_PORTS];
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     bool acpi_pcihp;
     bool keep_pci_slot_hpc;
@@ -227,6 +223,7 @@ static void pc_q35_init(MachineState *machine)
     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
                              OBJECT(pcms->pcibus), &error_abort);
     qdev_prop_set_bit(ich9, "d2p-enabled", false);
+    qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
     qdev_realize_and_unref(ich9, NULL, &error_fatal);
 
     /* create ISA bus */
@@ -287,20 +284,8 @@ static void pc_q35_init(MachineState *machine)
                          0xff0104);
 
     if (pcms->sata_enabled) {
-        PCIDevice *pdev;
-        AHCIPCIState *ich9;
-
-        /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        pdev = pci_create_simple_multifunction(pcms->pcibus,
-                                               PCI_DEVFN(ICH9_SATA1_DEV,
-                                                         ICH9_SATA1_FUNC),
-                                               "ich9-ahci");
-        ich9 = ICH9_AHCI(pdev);
-        pcms->idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
-        g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
-        ide_drive_get(hd, ich9->ahci.ports);
-        ahci_ide_create_devs(&ich9->ahci, hd);
+        pcms->idebus[0] = qdev_get_child_bus(ich9, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(ich9, "ide.1");
     }
 
     if (machine_usb(machine)) {
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index 8c4356ff74..37255bb941 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -13,22 +13,30 @@
 #include "hw/southbridge/ich9.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/ich9_dmi.h"
+#include "hw/ide/ahci-pci.h"
+#include "hw/ide/ide-dev.h"
 
 #define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)
+#define ICH9_SATA1_DEVFN        PCI_DEVFN(31, 2)
+
+#define SATA_PORTS              6
 
 struct ICH9State {
     DeviceState parent_obj;
 
     I82801b11Bridge d2p;
+    AHCIPCIState sata0;
 
     PCIBus *pci_bus;
     bool d2p_enabled;
+    bool sata_enabled;
 };
 
 static Property ich9_props[] = {
     DEFINE_PROP_LINK("mch-pcie-bus", ICH9State, pci_bus,
                      TYPE_PCIE_BUS, PCIBus *),
     DEFINE_PROP_BOOL("d2p-enabled", ICH9State, d2p_enabled, true),
+    DEFINE_PROP_BOOL("sata-enabled", ICH9State, sata_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -52,6 +60,29 @@ static bool ich9_realize_d2p(ICH9State *s, Error **errp)
     return true;
 }
 
+static bool ich9_realize_sata(ICH9State *s, Error **errp)
+{
+    DriveInfo *hd[SATA_PORTS];
+
+    object_initialize_child(OBJECT(s), "sata[0]", &s->sata0, TYPE_ICH9_AHCI);
+    qdev_prop_set_int32(DEVICE(&s->sata0), "addr", ICH9_SATA1_DEVFN);
+    if (!qdev_realize(DEVICE(&s->sata0), BUS(s->pci_bus), errp)) {
+        return false;
+    }
+    for (unsigned i = 0; i < SATA_PORTS; i++) {
+        g_autofree char *portname = g_strdup_printf("ide.%u", i);
+
+        object_property_add_alias(OBJECT(s), portname,
+                                  OBJECT(&s->sata0), portname);
+    }
+
+    g_assert(SATA_PORTS == s->sata0.ahci.ports);
+    ide_drive_get(hd, s->sata0.ahci.ports);
+    ahci_ide_create_devs(&s->sata0.ahci, hd);
+
+    return true;
+}
+
 static void ich9_realize(DeviceState *dev, Error **errp)
 {
     ICH9State *s = ICH9_SOUTHBRIDGE(dev);
@@ -64,6 +95,10 @@ static void ich9_realize(DeviceState *dev, Error **errp)
     if (s->d2p_enabled && !ich9_realize_d2p(s, errp)) {
         return;
     }
+
+    if (s->sata_enabled && !ich9_realize_sata(s, errp)) {
+        return;
+    }
 }
 
 static void ich9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d21638f4f9..226d7f6916 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -101,7 +101,6 @@ config Q35
     select PCI_EXPRESS_Q35
     select ICH9
     select LPC_ICH9
-    select AHCI_ICH9
     select DIMM
     select SMBIOS
     select FW_CFG_DMA
diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
index db7259bf6f..f806033d48 100644
--- a/hw/southbridge/Kconfig
+++ b/hw/southbridge/Kconfig
@@ -4,3 +4,4 @@ config ICH9
     bool
     depends on PCI_EXPRESS
     imply I82801B11
+    select AHCI_ICH9
-- 
2.41.0


