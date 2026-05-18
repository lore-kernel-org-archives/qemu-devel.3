Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3512CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsYB-00049P-2j; Mon, 18 May 2026 03:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khaled.saleh.req@gmail.com>)
 id 1wOsXi-0003xs-P9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:37:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <khaled.saleh.req@gmail.com>)
 id 1wOsXg-00024w-4D
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:37:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bd0fc4c336eso421712066b.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089854; x=1779694654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VbKi8Yc8JA84Fh5O5Hw2DC9TRezepdwCjtJF/nXJMEI=;
 b=UhxtQ8+GfxJ2vlQeEpKt6c+Lc5WJsX6si1IXqtGh1P7JOTEsjhnIyjpcu0s/OA+vHw
 K/pVrwYJiMQnSoh756Ajffu0oEkoG9rXEZfkTGLZnk9JIhxNRvTr8BWwoIqfGUgPIsr5
 lMjHRxI3JFGiIrYd9R26rYJDDGvLPKFg+3RXOPFGA50sduarbaj7Bq/B5aFnqv9hQReT
 kCv1eOj+hDIV6rAaq7lHuXsYf5ZlaGbK16eXzULDaTQTlD/UPH5EUhaQWn2ENbHb8mUr
 9j38PCB4BferHn7ba/oSmnyqE7zu3igcY81Kk+E/V1kZ/FwX1ftEipsOqTxbpnvKEleN
 kvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089854; x=1779694654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbKi8Yc8JA84Fh5O5Hw2DC9TRezepdwCjtJF/nXJMEI=;
 b=MZviW0qHbKjGu18SecQ+FwbBQQq7UH9jbtgdgXMRI3f4/y2gkxGsnvPbMs85HoVFK8
 pF+caim85RqmEHr5MrX7zmgc+brz1HFrY9KBQApW2lkej5xPChzHzSftrJkokc1uTKX5
 Klmnc8Oo+DZNzBcysT+C/dMYXlKnhizupjUpzlrxfBYJ6xNevODlsWCwDfwW/29NwELh
 GyVKd3PUMiRREIZ/xkjLPkRetEPWO6D/KJiJvzt6AIbedHKu3N8vvJbBm9UtjodLZjt+
 NsQMYwkUGCcjmRnYUTLuA5jZfi09+sZwb39Hom416QoNeaJ8HmBY3bA+bMJEHTEH0RqG
 BAXA==
X-Gm-Message-State: AOJu0YyYly47YuGJ4YtPE0xFILya/tBUORb8d3ww8aFNBZsls3mPP60Y
 s8jaUZR3XcvyYM639nx4OgBp3GCqomb1KzxPbwC22G5EsEWMpL1O0QKPJMqlQZDLkys=
X-Gm-Gg: Acq92OGpmprE2Hyvg5+pmFhXiVZoboLMd4/HLC5758y7H/KVQBSjP7MxSUPXQqzIaed
 ockhBMAm5X3QsplfbVmKi/eM/H2KWfUMDZax6MItwI+ewR5fWzmxeiodKkEeHJE61+hPnVPYYuA
 v2tGgjNY+hYU+n1zhqpNxdcfSUQswwKTjaLZxJIwm3VMyqPu60NB1jqWRfQexmqPfRkZ6SNqtkj
 /njzjYl0RrazV6SX77MSNBsLq5ZmDwpYqGtZfRgKGpO9+yIjJ9bYOj1FTdqa2+8txDyJkotl8Yz
 5f5bIrZZndJgGsy3oUPrtGgVJNydWk2J19BDuweAgjmimWC+j8mhhhWNvdtpTxR+Ne+wvYnEOJz
 ZBfidOPhQfWIk2PZ3RWYCfA68OijUM/rn153OSQKeVlD80r5gROszVuN01rDoSa1kRO2SC+Upw5
 Y+prO30RiVhIIcGZga7KnqU17LGKxdi8mFztT5BMHgYP29q/y/Qt3oad4SGpgTQK7+nuYWqbUm8
 clw+pSmYuT8jgw=
X-Received: by 2002:a17:907:ca0a:b0:bd5:ec9:e063 with SMTP id
 a640c23a62f3a-bd51797a6d0mr543534666b.49.1779089854102; 
 Mon, 18 May 2026 00:37:34 -0700 (PDT)
Received: from localhost.localdomain ([105.32.5.68])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bd0a24sm533191866b.11.2026.05.18.00.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:37:33 -0700 (PDT)
From: khaled saleh <khaled.saleh.req@gmail.com>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org,
	khaled.saleh.req@gmail.com
Subject: [PATCH] hw/pci/shpc: Enable 66MHz Bus Speed Support
Date: Mon, 18 May 2026 09:37:14 +0200
Message-Id: <20260518073714.70571-1-khaled.saleh.req@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=khaled.saleh.req@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Standard Hot-Plug Controller (SHPC) specification (PI=1) defines
66MHz conventional PCI as a valid bus speed mode. While QEMU defined
the relevant constants, it hardcoded the secondary bus speed to 33MHz
and advertised 0 slots as 66MHz capable.

This patch enables 66MHz support by:
1. Allowing SHPC_SEC_BUS_66 in shpc_set_sec_bus_speed().
2. Advertising all slots as 66MHz capable in shpc_reset().
3. Dynamically checking and reporting a slot's 66MHz capability based
   on the plugged PCI device's Status Register (PCI_STATUS_66MHZ).

PCI-X speeds remain unsupported and will continue to trigger an
INVALID_MODE command status error.

Signed-off-by: khaled saleh <khaled.saleh.req@gmail.com>
---
 hw/pci/shpc.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 938602866d..3becde7f10 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -12,7 +12,7 @@
 
 /* TODO: model power only and disabled slot states. */
 /* TODO: handle SERR and wakeups */
-/* TODO: consider enabling 66MHz support */
+
 
 /* TODO: remove fully only on state DISABLED and LED off.
  * track state to properly record this. */
@@ -30,7 +30,7 @@
 #define SHPC_PHYS_BUTTON  0x8000
 #define SHPC_SEC_BUS      0x10 /* 2 bytes */
 #define SHPC_SEC_BUS_33   0x0
-#define SHPC_SEC_BUS_66   0x1 /* Unused */
+#define SHPC_SEC_BUS_66   0x1
 #define SHPC_SEC_BUS_MASK 0x7
 #define SHPC_MSI_CTL      0x12 /* 1 byte */
 #define SHPC_PROG_IFC     0x13 /* 1 byte */
@@ -169,6 +169,17 @@ static void shpc_set_status(SHPCDevice *shpc,
     pci_word_test_and_set_mask(status, value << ctz32(msk));
 }
 
+static bool shpc_device_is_66mhz_capable(SHPCDevice *shpc, int slot)
+{
+    int pci_slot = SHPC_IDX_TO_PCI(slot);
+    PCIDevice *dev = shpc->sec_bus->devices[PCI_DEVFN(pci_slot, 0)];
+
+    if (!dev) {
+        return false;
+    }
+    return pci_get_word(dev->config + PCI_STATUS) & PCI_STATUS_66MHZ;
+}
+
 static void shpc_interrupt_update(PCIDevice *d)
 {
     SHPCDevice *shpc = d->shpc;
@@ -203,6 +214,7 @@ static void shpc_set_sec_bus_speed(SHPCDevice *shpc, uint8_t speed)
 {
     switch (speed) {
     case SHPC_SEC_BUS_33:
+    case SHPC_SEC_BUS_66:
         shpc->config[SHPC_SEC_BUS] &= ~SHPC_SEC_BUS_MASK;
         shpc->config[SHPC_SEC_BUS] |= speed;
         break;
@@ -220,7 +232,7 @@ void shpc_reset(PCIDevice *d)
     memset(shpc->config, 0, SHPC_SIZEOF(d));
     pci_set_byte(shpc->config + SHPC_NSLOTS, nslots);
     pci_set_long(shpc->config + SHPC_SLOTS_33, nslots);
-    pci_set_long(shpc->config + SHPC_SLOTS_66, 0);
+    pci_set_long(shpc->config + SHPC_SLOTS_66, nslots);
     pci_set_byte(shpc->config + SHPC_FIRST_DEV, SHPC_IDX_TO_PCI(0));
     pci_set_word(shpc->config + SHPC_PHYS_SLOT,
                  SHPC_IDX_TO_PHYSICAL(0) |
@@ -256,7 +268,9 @@ void shpc_reset(PCIDevice *d)
             shpc_set_status(shpc, i, SHPC_LED_OFF, SHPC_SLOT_PWR_LED_MASK);
         }
         shpc_set_status(shpc, i, SHPC_LED_OFF, SHPC_SLOT_ATTN_LED_MASK);
-        shpc_set_status(shpc, i, 0, SHPC_SLOT_STATUS_66);
+        shpc_set_status(shpc, i,
+                        shpc_device_is_66mhz_capable(shpc, i) ? 1 : 0,
+                        SHPC_SLOT_STATUS_66);
     }
     shpc_set_sec_bus_speed(shpc, SHPC_SEC_BUS_33);
     shpc->msi_requested = 0;
@@ -578,6 +592,9 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         shpc_set_status(shpc, slot, 0, SHPC_SLOT_STATUS_MRL_OPEN);
         shpc_set_status(shpc, slot, SHPC_SLOT_STATUS_PRSNT_7_5W,
                         SHPC_SLOT_STATUS_PRSNT_MASK);
+        shpc_set_status(shpc, slot,
+                        shpc_device_is_66mhz_capable(shpc, slot) ? 1 : 0,
+                        SHPC_SLOT_STATUS_66);
         return;
     }
 
@@ -596,7 +613,9 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         shpc->config[SHPC_SLOT_EVENT_LATCH(slot)] |=
             SHPC_SLOT_EVENT_BUTTON;
     }
-    shpc_set_status(shpc, slot, 0, SHPC_SLOT_STATUS_66);
+    shpc_set_status(shpc, slot,
+                    shpc_device_is_66mhz_capable(shpc, slot) ? 1 : 0,
+                    SHPC_SLOT_STATUS_66);
     shpc_interrupt_update(pci_hotplug_dev);
 }
 
-- 
2.34.1


