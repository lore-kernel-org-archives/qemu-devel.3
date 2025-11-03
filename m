Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAFCCCFA07
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsiv-0001Pm-S0; Mon, 03 Nov 2025 06:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFsiu-0001PN-1W
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:27:44 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFsim-0001YC-DY
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:27:43 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-294fc62d7f4so38357225ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 03:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762169252; x=1762774052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwtAZIIw5VbqFf7Cu53n6UtkWlOeh2o59bxd4j3P3VY=;
 b=QerFGlYitLTkxECROxBnCmAOQ11JLcPmlhq0j+wSoChLHhMkpXRIxKcZ4fygyLBTsX
 GFrhpXwALb1Wj7Id6nwucq7CE3ZxYiepn5gPHe74RVTQEtxi8hTiMEwUtS1xM1cBMjtS
 WMmkaxgCHyGUcxMtY8pBa2Cf/IbWuuRd3SjxK2zJZPTb72pssjfcVNZf64quS1Nsr+aQ
 BVCAoZgFXxwWSTga+hN1ZtFQ5ESSyeanXmfF4qC2yPDOpnWA6Y4rkGpgzfiWb+Pj9uHk
 r06Qj8PNOyahsEdd8/eKYKvNvJLRJpgCZ4ODdT/UjgA28u/kEWfsRT5mIppeg6t8kSCZ
 nHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762169252; x=1762774052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwtAZIIw5VbqFf7Cu53n6UtkWlOeh2o59bxd4j3P3VY=;
 b=nfSrQBRiEEaUW+MB8xe8zKA9g0YuzsdYzZyPsdRY/CqfXMG+W2ACF6wx1hp6Nb4sQV
 YHRgLFFL+ZJxhX9e40zEHOMnPiMy0UbLbf6cTg6Gl5ggAvsBX1LE9Mt81OvropO3qjRz
 v2aCASZ6PLLZ5m71XRw13tbnGMASfoGB4d3dm/ehWhx6EE6LoXHWW9VPMPVvRT7e316F
 wwbTsQyLFg0QEfOXR/vvaJq3uRJyV84ug9tGKJB9+xmGQt+lim/rw/0k9GONoh6eu6Kj
 LUk2vHZ3sDFp7LFFfhMz9vSQtihMlvYr+YQllHJ2Rdr1xd5xY/AWzWnJXba5k5yed98r
 S2Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGA/4G24dXHscT4tv1C1VLjl8suETK5nO9Azi2lQmapnEN+gbVxE1+qqxg3JGcs70TjiBZvmHQOwgo@nongnu.org
X-Gm-Message-State: AOJu0Yw3YKa7rGh7vRTeDIQVXUluRuWnJVAqqktYtT0eGzOn6MLXp6n0
 fmjAGhPQEPRXy33IbzorCpa0q6QNfYqNiVENmkUwRA8HTNBX7uNpJeID
X-Gm-Gg: ASbGnct439oV1R44Vydju4t5fHiuCQ/zVOyNlmon2OxAueJ4GfyTdI+iIkG8Fsn93P8
 wCf7KYvUp4K15pOt89VEEewPeKAD9XowrEBdkUWzPv8DB7EbWNFjuz5SJ2YahNufBgcl34eoBhx
 gSbt5V7QpHRNAN8xiQlKTA0UwCAz+kMmttGqGfyt7yGRETlGbXPHjx0HyqtRJaOrnGvQobdqb7K
 3DhTPTPMmLfTeBCA9jFChdxh3p35abVArpUzis6X+wNhR2TvISE1katMRxwAI2BjQYlYqs9NRPl
 mYLACF7XYVfh+5I0/ljhsl2+TxPJwUHtk95VjnJV0bT4rv7dWFODAXYpsmiTpkZ9pRHz0YhlVbr
 AYk38ScDnSiCp9KHmBC3He//YszP1TeobjARsnGWcpCsc+fAAeANyYsE1LjwUQrTe60ofR0menD
 GM+VqIaPj4sNpEWd5Y97bK0kjsVdd4gEEdiPpXRGqO1zhazHsfBA==
X-Google-Smtp-Source: AGHT+IH3PpuWqT8ly2CCt3btkFIr72FY2eqCqdhv0Zu6PdB9S5zwg54wIg0H+PKpvP6ptErR7Ap7rA==
X-Received: by 2002:a17:903:182:b0:295:e9af:8e4f with SMTP id
 d9443c01a7336-295e9af900amr4261765ad.52.1762169252323; 
 Mon, 03 Nov 2025 03:27:32 -0800 (PST)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341599f14bbsm741661a91.13.2025.11.03.03.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 03:27:31 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com,
 linux@roeck-us.net, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 deller@gmx.de
Cc: Jason Wang <jasowang@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v3 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
Date: Mon,  3 Nov 2025 16:57:21 +0530
Message-ID: <20251103112723.12256-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251103112723.12256-1-soumyajyotisarkar23@gmail.com>
References: <20251103112723.12256-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enable the i82596 network chip which is included in the LASI
multi I/O chip. Since LASI has different start addresses on
the various machines, always initialize the LASI components
by their offsets.

Changes since v1:
As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
- Added TYPE_LASI_82596.
- Removed and rewrote the functionality of lasi_82596_init().

As suggested by Guenter Roeck <linux@roeck-us.net>
- Removed duplicate define in hppa_hardware.h

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/hppa/hppa_hardware.h     | 10 ++--------
 hw/hppa/machine.c           | 31 +++++++++++++++++--------------
 hw/net/lasi_i82596.c        | 30 +++++++-----------------------
 include/hw/net/lasi_82596.h |  3 ---
 4 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index d422af0429..0a89c3ed52 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -21,14 +21,6 @@
 #define DINO_SCSI_HPA   0xfff8c000
 #define LASI_HPA_715    0xf0100000
 #define LASI_HPA        0xffd00000
-#define LASI_UART_HPA   0xffd05000
-#define LASI_SCSI_HPA   0xffd06000
-#define LASI_LAN_HPA    0xffd07000
-#define LASI_RTC_HPA    0xffd09000
-#define LASI_LPT_HPA    0xffd02000
-#define LASI_AUDIO_HPA  0xffd04000
-#define LASI_PS2KBD_HPA 0xffd08000
-#define LASI_PS2MOU_HPA 0xffd08100
 #define LASI_GFX_HPA    0xf8000000
 #define ARTIST_FB_ADDR  0xf9000000
 #define CPU_HPA         0xfffb0000
@@ -44,6 +36,8 @@
 
 #define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be in f region */
 
+#define HPA_DISABLED_DEVICE     1       /* add to HPA to disable */
+
 /* offsets to DINO HPA: */
 #define DINO_PCI_ADDR           0x064
 #define DINO_CONFIG_DATA        0x068
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cbca0026ab..8c66eed5a2 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -50,8 +50,6 @@ struct HppaMachineState {
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
 
-#define enable_lasi_lan()       0
-
 static DeviceState *lasi_dev;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
@@ -376,13 +374,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         }
     }
 
-    /* Network setup. */
-    if (lasi_dev) {
-        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
-                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
-                        enable_lasi_lan());
-    }
-
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
 
@@ -595,6 +586,17 @@ static void machine_HP_715_init(MachineState *machine)
         lasi_ncr710_handle_legacy_cmdline(dev);
     }
 
+    /* LASI i82596 network */
+    dev = qemu_create_nic_device(TYPE_LASI_82596, true, "lasi");
+    if (dev) {
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
+        memory_region_add_subregion(addr_space,
+                                    translate(NULL, LASI_HPA_715 + LASI_LAN),
+                                    sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+    }
+
     /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, NULL, translate);
 }
@@ -638,7 +640,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     assert(isa_bus);
 
     /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, translate(NULL, LASI_UART_HPA + 0x800), 0,
+    serial_mm_init(addr_space, translate(NULL, LASI_HPA + LASI_UART + 0x800), 0,
         qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
@@ -647,7 +649,8 @@ static void machine_HP_B160L_init(MachineState *machine)
         serial_hd(1), DEVICE_BIG_ENDIAN);
 
     /* Parallel port */
-    parallel_mm_init(addr_space, translate(NULL, LASI_LPT_HPA + 0x800), 0,
+    parallel_mm_init(addr_space,
+                     translate(NULL, LASI_HPA + LASI_LPT + 0x800), 0,
                      qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
                      parallel_hds[0]);
 
@@ -657,11 +660,11 @@ static void machine_HP_B160L_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA),
+                                translate(NULL, LASI_HPA + LASI_PS2),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        0));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA + 0x100),
+                                translate(NULL, LASI_HPA + LASI_PS2 + 0x100),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        1));
 
@@ -832,7 +835,7 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     /* can only support up to max. 8 CPUs due inventory major numbers */
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
-    mc->default_nic = NULL;
+    mc->default_nic = TYPE_LASI_82596;
 }
 
 
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 9e1dd21546..b87cea411a 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -115,30 +115,10 @@ static void lasi_82596_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mmio, OBJECT(d), &lasi_82596_mem_ops, d,
                 "lasi_82596-mmio", PA_GET_MACADDR + 4);
 
-    i82596_common_init(dev, s, &net_lasi_82596_info);
-}
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
-                                   qemu_irq lan_irq, gboolean match_default)
-{
-    DeviceState *dev;
-    SysBusI82596State *s;
-    static const MACAddr HP_MAC = {
-        .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
-
-    dev = qemu_create_nic_device(TYPE_LASI_82596, match_default, "lasi");
-    if (!dev) {
-        return NULL;
-    }
-
-    s = SYSBUS_I82596(dev);
-    s->state.irq = lan_irq;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    s->state.conf.macaddr = HP_MAC; /* set HP MAC prefix */
-
-    /* LASI 82596 ports in main memory. */
-    memory_region_add_subregion(addr_space, hpa, &s->state.mmio);
-    return s;
+    i82596_common_init(dev, s, &net_lasi_82596_info);
 }
 
 static void lasi_82596_reset(DeviceState *dev)
@@ -152,6 +132,10 @@ static void lasi_82596_instance_init(Object *obj)
 {
     SysBusI82596State *d = SYSBUS_I82596(obj);
     I82596State *s = &d->state;
+    static const MACAddr HP_MAC = {
+        .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
+
+    s->conf.macaddr = HP_MAC;
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
diff --git a/include/hw/net/lasi_82596.h b/include/hw/net/lasi_82596.h
index 439356ec19..c46a4a137e 100644
--- a/include/hw/net/lasi_82596.h
+++ b/include/hw/net/lasi_82596.h
@@ -25,7 +25,4 @@ struct SysBusI82596State {
     int val_index:1;
 };
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
-                                   qemu_irq irq, gboolean match_default);
-
 #endif
-- 
2.49.0


