Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61182C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYyI-0003Uy-EW; Mon, 26 Feb 2024 06:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxW-0002bI-1h
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxS-0000QF-Iq
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:44 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d153254b7so2299698f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946139; x=1709550939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdxrKQw56OGQ9Tcr1roIQBogyoJhaQPIfliNFvvMZPA=;
 b=gkYus16rAuureH0NQKJ34MFlj3/P3R+pI0TtYpWcVYJ7sEP0umQcWvabx7Bwveg3cz
 JOKjkzej1W62XrhLiPItp1pX5ni9wO1A91ub2tCP162sIi0ImBYMHA2OQ5YQkB0Ukcn0
 O+Mu7TEQJCle8nDI48O6AK8B+8yG0kGVHZb+aUh0KfI6i8oWJ630QuqvR2DSm4G08IuY
 cTMIG/wkz/DkXCAAhmJsRgyPxMDeTgzl9CR5BD+BD4HWxVr2u9vIEpqsJA2kcgfADAV/
 nEeYmTpwRVhBPM7lEJYVZawsBymLDT8U53GUpBdzFJ07FhZ2R7KbkaRioD4PRhcbXv0i
 GjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946139; x=1709550939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdxrKQw56OGQ9Tcr1roIQBogyoJhaQPIfliNFvvMZPA=;
 b=Jq/aTBx6E17FqVdVnEsK2DHxMDxwstc2y0sAWH8SziaTG7sU8seRyXmV5ve9mAsjY8
 t3g5dZJDpMoPoEiQt5dXCD9Vc2eQnqWh5a2x/jrvj/wSoBmQIYgnsY4WYHKlSTjhrwQX
 nw7AsrZ0yIsGbsH2ri5LbdMmj/+F3YdZ/TRX/6CyVpwIdppI46JToPQzVGwW1oLWTEGI
 VUwD4xBWPPYO7609KFCI4QjXJgQ5IrhJlSAJVAARqMP15k3QZxEdtgPOtWTdCiw9eFfO
 uP1JTie4eFCwgUrdF5U7bVsSkr95oT98fLMwCUF7fzWo+CagbtCHVwAJK1FrOGXZe3CL
 JmQg==
X-Gm-Message-State: AOJu0YwVBpDNa4XLy34yUoPIsk2lsdIjYQwGfCo3uWWkxvBHS8O/dsd/
 fBrwxJUDXPgiKT710wA0Hof83jMuoKlJbHVGyyoLECqaKAwdZdHbEf0erF1C3NMDLsZyrLEvBPe
 g
X-Google-Smtp-Source: AGHT+IGMx5SnVJGZW+QrpQW5vebMVTUGgr8KNehCWThaiHgqEzs6URusf6FNewpoiv8SZRea2INZxw==
X-Received: by 2002:a5d:6086:0:b0:33d:3ad2:67ae with SMTP id
 w6-20020a5d6086000000b0033d3ad267aemr4218921wrt.57.1708946139679; 
 Mon, 26 Feb 2024 03:15:39 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5d594d000000b0033dd53c8f15sm3800971wri.13.2024.02.26.03.15.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:39 -0800 (PST)
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
Subject: [PATCH v2 13/15] hw/southbridge/ich9: Add the USB EHCI/UHCI functions
Date: Mon, 26 Feb 2024 12:14:12 +0100
Message-ID: <20240226111416.39217-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Instantiate EHCI and UHCI in TYPE_ICH9_SOUTHBRIDGE.

Since machines can disable USB, add the 'ehci-count'
property. Machine can disable USB functions by setting
ehci-count=0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/southbridge/ich9.h |  5 ---
 hw/i386/pc_q35.c              | 62 ++---------------------------------
 hw/southbridge/ich9.c         | 54 ++++++++++++++++++++++++++++++
 hw/southbridge/Kconfig        |  2 ++
 4 files changed, 58 insertions(+), 65 deletions(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index d4b299bf3c..7e75496b0b 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -103,11 +103,6 @@ struct ICH9LPCState {
 #define ICH9_PCIE_DEV                           28
 #define ICH9_PCIE_FUNC_MAX                      6
 
-
-/* D29:F0 USB UHCI Controller #1 */
-#define ICH9_USB_UHCI1_DEV                      29
-#define ICH9_USB_UHCI1_FUNC                     0
-
 /* D31:F0 LPC Processor Interface */
 #define ICH9_RST_CNT_IOPORT                     0xCF9
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0ff94b7afd..63fec8b439 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -50,8 +50,6 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/intc/ioapic.h"
 #include "hw/southbridge/ich9.h"
-#include "hw/usb.h"
-#include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
@@ -60,59 +58,6 @@
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
 
-struct ehci_companions {
-    const char *name;
-    int func;
-    int port;
-};
-
-static const struct ehci_companions ich9_1d[] = {
-    { .name = TYPE_ICH9_USB_UHCI(1), .func = 0, .port = 0 },
-    { .name = TYPE_ICH9_USB_UHCI(2), .func = 1, .port = 2 },
-    { .name = TYPE_ICH9_USB_UHCI(3), .func = 2, .port = 4 },
-};
-
-static const struct ehci_companions ich9_1a[] = {
-    { .name = TYPE_ICH9_USB_UHCI(4), .func = 0, .port = 0 },
-    { .name = TYPE_ICH9_USB_UHCI(5), .func = 1, .port = 2 },
-    { .name = TYPE_ICH9_USB_UHCI(6), .func = 2, .port = 4 },
-};
-
-static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
-{
-    const struct ehci_companions *comp;
-    PCIDevice *ehci, *uhci;
-    BusState *usbbus;
-    const char *name;
-    int i;
-
-    switch (slot) {
-    case 0x1d:
-        name = "ich9-usb-ehci1";
-        comp = ich9_1d;
-        break;
-    case 0x1a:
-        name = "ich9-usb-ehci2";
-        comp = ich9_1a;
-        break;
-    default:
-        return -1;
-    }
-
-    ehci = pci_new_multifunction(PCI_DEVFN(slot, 7), name);
-    pci_realize_and_unref(ehci, bus, &error_fatal);
-    usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
-
-    for (i = 0; i < 3; i++) {
-        uhci = pci_new_multifunction(PCI_DEVFN(slot, comp[i].func),
-                                     comp[i].name);
-        qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
-        qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
-        pci_realize_and_unref(uhci, bus, &error_fatal);
-    }
-    return 0;
-}
-
 /* PC hardware initialisation */
 static void pc_q35_init(MachineState *machine)
 {
@@ -225,6 +170,8 @@ static void pc_q35_init(MachineState *machine)
     qdev_prop_set_bit(ich9, "d2p-enabled", false);
     qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
     qdev_prop_set_bit(ich9, "smbus-enabled", pcms->smbus_enabled);
+    /* Should we create 6 UHCI according to ich9 spec? */
+    qdev_prop_set_uint8(ich9, "ehci-count", machine_usb(machine) ? 1 : 0);
     qdev_realize_and_unref(ich9, NULL, &error_fatal);
 
     /* create ISA bus */
@@ -289,11 +236,6 @@ static void pc_q35_init(MachineState *machine)
         pcms->idebus[1] = qdev_get_child_bus(ich9, "ide.1");
     }
 
-    if (machine_usb(machine)) {
-        /* Should we create 6 UHCI according to ich9 spec? */
-        ehci_create_ich9_with_companions(pcms->pcibus, 0x1d);
-    }
-
     if (pcms->smbus_enabled) {
         pcms->smbus = I2C_BUS(qdev_get_child_bus(ich9, "i2c"));
         /* TODO: Populate SPD eeprom data.  */
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index 413e9187e4..f05012959d 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -16,12 +16,18 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide/ide-dev.h"
 #include "hw/i2c/ich9_smbus.h"
+#include "hw/usb.h"
+#include "hw/usb/hcd-ehci.h"
+#include "hw/usb/hcd-uhci.h"
 
 #define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)
 #define ICH9_SATA1_DEVFN        PCI_DEVFN(31, 2)
 #define ICH9_SMB_DEVFN          PCI_DEVFN(31, 3)
+#define ICH9_EHCI_FUNC          7
 
 #define SATA_PORTS              6
+#define EHCI_PER_FN             2
+#define UHCI_PER_FN             3
 
 struct ICH9State {
     DeviceState parent_obj;
@@ -29,11 +35,14 @@ struct ICH9State {
     I82801b11Bridge d2p;
     AHCIPCIState sata0;
     ICH9SMBState smb;
+    EHCIPCIState ehci[EHCI_PER_FN];
+    UHCIState uhci[EHCI_PER_FN * UHCI_PER_FN];
 
     PCIBus *pci_bus;
     bool d2p_enabled;
     bool sata_enabled;
     bool smbus_enabled;
+    uint8_t ehci_count;
 };
 
 static Property ich9_props[] = {
@@ -42,6 +51,7 @@ static Property ich9_props[] = {
     DEFINE_PROP_BOOL("d2p-enabled", ICH9State, d2p_enabled, true),
     DEFINE_PROP_BOOL("sata-enabled", ICH9State, sata_enabled, true),
     DEFINE_PROP_BOOL("smbus-enabled", ICH9State, smbus_enabled, true),
+    DEFINE_PROP_UINT8("ehci-count", ICH9State, ehci_count, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -100,6 +110,46 @@ static bool ich9_realize_smbus(ICH9State *s, Error **errp)
     return true;
 }
 
+static bool ich9_realize_usb(ICH9State *s, Error **errp)
+{
+    if (!module_object_class_by_name(TYPE_ICH9_USB_UHCI(1))
+        || !module_object_class_by_name("ich9-usb-ehci1")) {
+        error_setg(errp, "USB functions not available in this build");
+        return false;
+    }
+    for (unsigned e = 0; e < s->ehci_count; e++) {
+        g_autofree gchar *ename = g_strdup_printf("ich9-usb-ehci%u", e + 1);
+        EHCIPCIState *ehci = &s->ehci[e];
+        const unsigned devid = e ? 0x1a : 0x1d;
+        BusState *masterbus;
+
+        object_initialize_child(OBJECT(s), "ehci[*]", ehci, ename);
+        qdev_prop_set_int32(DEVICE(ehci), "addr", PCI_DEVFN(devid,
+                                                            ICH9_EHCI_FUNC));
+        if (!qdev_realize(DEVICE(ehci), BUS(s->pci_bus), errp)) {
+            return false;
+        }
+        masterbus = QLIST_FIRST(&DEVICE(ehci)->child_bus);
+
+        for (unsigned u = 0; u < UHCI_PER_FN; u++) {
+            unsigned c = UHCI_PER_FN * e + u;
+            UHCIState *uhci = &s->uhci[c];
+            g_autofree gchar *cname = g_strdup_printf("ich9-usb-uhci%u", c + 1);
+
+            object_initialize_child(OBJECT(s), "uhci[*]", uhci, cname);
+            qdev_prop_set_bit(DEVICE(uhci), "multifunction", true);
+            qdev_prop_set_int32(DEVICE(uhci), "addr", PCI_DEVFN(devid, u));
+            qdev_prop_set_string(DEVICE(uhci), "masterbus", masterbus->name);
+            qdev_prop_set_uint32(DEVICE(uhci), "firstport", 2 * u);
+            if (!qdev_realize(DEVICE(uhci), BUS(s->pci_bus), errp)) {
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
 static void ich9_realize(DeviceState *dev, Error **errp)
 {
     ICH9State *s = ICH9_SOUTHBRIDGE(dev);
@@ -120,6 +170,10 @@ static void ich9_realize(DeviceState *dev, Error **errp)
     if (s->smbus_enabled && !ich9_realize_smbus(s, errp)) {
         return;
     }
+
+    if (!ich9_realize_usb(s, errp)) {
+        return;
+    }
 }
 
 static void ich9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
index 03e89a55d1..31eb125bf7 100644
--- a/hw/southbridge/Kconfig
+++ b/hw/southbridge/Kconfig
@@ -6,3 +6,5 @@ config ICH9
     imply I82801B11
     select AHCI_ICH9
     select ACPI_ICH9
+    imply USB_EHCI_PCI
+    imply USB_UHCI
-- 
2.41.0


