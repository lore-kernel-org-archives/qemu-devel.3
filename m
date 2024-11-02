Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC4AE677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7DhL-0004LM-0x; Sat, 02 Nov 2024 08:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhF-0004Jt-8z; Sat, 02 Nov 2024 08:57:41 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhC-0003Wk-UC; Sat, 02 Nov 2024 08:57:41 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a156513a1so464866966b.0; 
 Sat, 02 Nov 2024 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730552257; x=1731157057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlcSxqpsZa4n/dCjn71gV0G7clLJBWqqs/PQbNvaLE0=;
 b=JM0fLlCVRqdw1eSNQjWCYZLiVmpcOAc7QV5/BzxOihrr+Fa9gj3hM46d5ZTAUryCIG
 hsDeBOj7e9WaBBCxLtL6nCGmQGWqHu/lis5GIvR+HHTYrUOnwl+0EnY/2cElWqRiGDqO
 pHTQ/tSdnd1FSkfflWgzVllQDTZ7ibuizl2Wxgpxh+CFiK+JE8IsNVzDW2q4W0sMPhlU
 DdLNd8CnYmwtLMJNR3P+zW87XDamNYXaMp2VfcShIsAlSmO8tMNeYFyA87/w3XY/zjpG
 IfFc31bfAoRl5x0UR6zb4Pf7M1dfseb4NCjfuRKbpYO2mNGnevjXlF7gOsEU8CWMJP92
 45AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730552257; x=1731157057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlcSxqpsZa4n/dCjn71gV0G7clLJBWqqs/PQbNvaLE0=;
 b=TYvcBlVX1LGjfCqphHMGdRVJL4kn95Puh5a/2CLRW2cZEV5PsAxLGuy21+LSyoGgAD
 O+khN//t9R3dQjSdPgR5ESFJ/9PKw8WdNHSCn4hyt8IJHtLkU6gTu0hzidpw3v8f7ctv
 TlBUpwpiI/OeKABcSZ7OsGxfIN1JAgCyvYSSms659IrpzQOXaIfNCoJ8IRPWs/0lVtv5
 i8O9+wIwO1n/3ljg5s5gZ1MKq3VJWxrkGN5+ly/C91QE4QCESHtdJ0FKIj2WmDp67O+Y
 GtqrKJ4X3ff2pmIgR9bQULRK6vPZDQ/iU2lQ6q8A0TRvl0sAfyW906of6PtwmVOQwY+t
 xOYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPjnJG77w3CxmSryAVj/SDqbu6oRXTmikC8XO0eM76vdbgasyuxYH39b/T+Gb4jhacYpKOjqgQaA==@nongnu.org
X-Gm-Message-State: AOJu0YwfdWxR2L59kHmaYQI/1HragnlvgeXlkLLxNr602o5lAbfvpKQ5
 NVQQ10Ed6T/XK7R684nssn7W7Za4YHUfgki3lHxlUmiadBAlUED8ChMK3w==
X-Google-Smtp-Source: AGHT+IG0Yk5WbnWWUW2XePmBdYDSf2W5bzFVb8Ox2qb22J9RsaAT4cfZtx5mVXppgcFmh2f4ExqAkQ==
X-Received: by 2002:a17:907:9451:b0:a9a:cf6:b629 with SMTP id
 a640c23a62f3a-a9de5f72b77mr2371838266b.29.1730552256278; 
 Sat, 02 Nov 2024 05:57:36 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e566846a7sm305836666b.206.2024.11.02.05.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 05:57:35 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 1/5] hw/net/lan9118: Extract lan9118_phy
Date: Sat,  2 Nov 2024 13:57:20 +0100
Message-ID: <20241102125724.532843-2-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102125724.532843-1-shentey@gmail.com>
References: <20241102125724.532843-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

A very similar implementation of the same device exists in imx_fec. Prepare for
a common implementation by extracting a device model into its own files.

Some migration state has been moved into the new device model which breaks
migration compatibility for the following machines:
* smdkc210
* realview-*
* vexpress-*
* kzm
* mps2-*

While breaking migration ABI, fix the size of the MII registers to be 16 bit,
as defined by IEEE 802.3u.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/lan9118_phy.h |  37 ++++++++
 hw/net/lan9118.c             | 137 +++++-----------------------
 hw/net/lan9118_phy.c         | 169 +++++++++++++++++++++++++++++++++++
 hw/net/Kconfig               |   4 +
 hw/net/meson.build           |   1 +
 5 files changed, 233 insertions(+), 115 deletions(-)
 create mode 100644 include/hw/net/lan9118_phy.h
 create mode 100644 hw/net/lan9118_phy.c

diff --git a/include/hw/net/lan9118_phy.h b/include/hw/net/lan9118_phy.h
new file mode 100644
index 0000000000..af12fc33d5
--- /dev/null
+++ b/include/hw/net/lan9118_phy.h
@@ -0,0 +1,37 @@
+/*
+ * SMSC LAN9118 PHY emulation
+ *
+ * Copyright (c) 2009 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_NET_LAN9118_PHY_H
+#define HW_NET_LAN9118_PHY_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+#define TYPE_LAN9118_PHY "lan9118-phy"
+OBJECT_DECLARE_SIMPLE_TYPE(Lan9118PhyState, LAN9118_PHY)
+
+typedef struct Lan9118PhyState {
+    SysBusDevice parent_obj;
+
+    uint16_t status;
+    uint16_t control;
+    uint16_t advertise;
+    uint16_t ints;
+    uint16_t int_mask;
+    qemu_irq irq;
+    bool link_down;
+} Lan9118PhyState;
+
+void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down);
+void lan9118_phy_reset(Lan9118PhyState *s);
+uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg);
+void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val);
+
+#endif
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index db28a0ef30..99e87b7178 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -16,6 +16,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "hw/irq.h"
+#include "hw/net/lan9118_phy.h"
 #include "hw/net/lan9118.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
@@ -139,14 +140,6 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 #define MAC_CR_RXEN     0x00000004
 #define MAC_CR_RESERVED 0x7f404213
 
-#define PHY_INT_ENERGYON            0x80
-#define PHY_INT_AUTONEG_COMPLETE    0x40
-#define PHY_INT_FAULT               0x20
-#define PHY_INT_DOWN                0x10
-#define PHY_INT_AUTONEG_LP          0x08
-#define PHY_INT_PARFAULT            0x04
-#define PHY_INT_AUTONEG_PAGE        0x02
-
 #define GPT_TIMER_EN    0x20000000
 
 /*
@@ -228,11 +221,8 @@ struct lan9118_state {
     uint32_t mac_mii_data;
     uint32_t mac_flow;
 
-    uint32_t phy_status;
-    uint32_t phy_control;
-    uint32_t phy_advertise;
-    uint32_t phy_int;
-    uint32_t phy_int_mask;
+    Lan9118PhyState mii;
+    IRQState mii_irq;
 
     int32_t eeprom_writable;
     uint8_t eeprom[128];
@@ -274,8 +264,8 @@ struct lan9118_state {
 
 static const VMStateDescription vmstate_lan9118 = {
     .name = "lan9118",
-    .version_id = 2,
-    .minimum_version_id = 1,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, lan9118_state),
         VMSTATE_UINT32(irq_cfg, lan9118_state),
@@ -301,11 +291,6 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_UINT32(mac_mii_acc, lan9118_state),
         VMSTATE_UINT32(mac_mii_data, lan9118_state),
         VMSTATE_UINT32(mac_flow, lan9118_state),
-        VMSTATE_UINT32(phy_status, lan9118_state),
-        VMSTATE_UINT32(phy_control, lan9118_state),
-        VMSTATE_UINT32(phy_advertise, lan9118_state),
-        VMSTATE_UINT32(phy_int, lan9118_state),
-        VMSTATE_UINT32(phy_int_mask, lan9118_state),
         VMSTATE_INT32(eeprom_writable, lan9118_state),
         VMSTATE_UINT8_ARRAY(eeprom, lan9118_state, 128),
         VMSTATE_INT32(tx_fifo_size, lan9118_state),
@@ -385,9 +370,11 @@ static void lan9118_reload_eeprom(lan9118_state *s)
     lan9118_mac_changed(s);
 }
 
-static void phy_update_irq(lan9118_state *s)
+static void lan9118_update_irq(void *opaque, int n, int level)
 {
-    if (s->phy_int & s->phy_int_mask) {
+    lan9118_state *s = opaque;
+
+    if (level) {
         s->int_sts |= PHY_INT;
     } else {
         s->int_sts &= ~PHY_INT;
@@ -395,33 +382,10 @@ static void phy_update_irq(lan9118_state *s)
     lan9118_update(s);
 }
 
-static void phy_update_link(lan9118_state *s)
-{
-    /* Autonegotiation status mirrors link status.  */
-    if (qemu_get_queue(s->nic)->link_down) {
-        s->phy_status &= ~0x0024;
-        s->phy_int |= PHY_INT_DOWN;
-    } else {
-        s->phy_status |= 0x0024;
-        s->phy_int |= PHY_INT_ENERGYON;
-        s->phy_int |= PHY_INT_AUTONEG_COMPLETE;
-    }
-    phy_update_irq(s);
-}
-
 static void lan9118_set_link(NetClientState *nc)
 {
-    phy_update_link(qemu_get_nic_opaque(nc));
-}
-
-static void phy_reset(lan9118_state *s)
-{
-    s->phy_status = 0x7809;
-    s->phy_control = 0x3000;
-    s->phy_advertise = 0x01e1;
-    s->phy_int_mask = 0;
-    s->phy_int = 0;
-    phy_update_link(s);
+    lan9118_phy_update_link(&LAN9118(qemu_get_nic_opaque(nc))->mii,
+                            nc->link_down);
 }
 
 static void lan9118_reset(DeviceState *d)
@@ -478,8 +442,6 @@ static void lan9118_reset(DeviceState *d)
     s->read_word_n = 0;
     s->write_word_n = 0;
 
-    phy_reset(s);
-
     s->eeprom_writable = 0;
     lan9118_reload_eeprom(s);
 }
@@ -678,7 +640,7 @@ static void do_tx_packet(lan9118_state *s)
     uint32_t status;
 
     /* FIXME: Honor TX disable, and allow queueing of packets.  */
-    if (s->phy_control & 0x4000)  {
+    if (s->mii.control & 0x4000) {
         /* This assumes the receive routine doesn't touch the VLANClient.  */
         qemu_receive_packet(qemu_get_queue(s->nic), s->txp->data, s->txp->len);
     } else {
@@ -834,68 +796,6 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
     }
 }
 
-static uint32_t do_phy_read(lan9118_state *s, int reg)
-{
-    uint32_t val;
-
-    switch (reg) {
-    case 0: /* Basic Control */
-        return s->phy_control;
-    case 1: /* Basic Status */
-        return s->phy_status;
-    case 2: /* ID1 */
-        return 0x0007;
-    case 3: /* ID2 */
-        return 0xc0d1;
-    case 4: /* Auto-neg advertisement */
-        return s->phy_advertise;
-    case 5: /* Auto-neg Link Partner Ability */
-        return 0x0f71;
-    case 6: /* Auto-neg Expansion */
-        return 1;
-        /* TODO 17, 18, 27, 29, 30, 31 */
-    case 29: /* Interrupt source.  */
-        val = s->phy_int;
-        s->phy_int = 0;
-        phy_update_irq(s);
-        return val;
-    case 30: /* Interrupt mask */
-        return s->phy_int_mask;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "do_phy_read: PHY read reg %d\n", reg);
-        return 0;
-    }
-}
-
-static void do_phy_write(lan9118_state *s, int reg, uint32_t val)
-{
-    switch (reg) {
-    case 0: /* Basic Control */
-        if (val & 0x8000) {
-            phy_reset(s);
-            break;
-        }
-        s->phy_control = val & 0x7980;
-        /* Complete autonegotiation immediately.  */
-        if (val & 0x1000) {
-            s->phy_status |= 0x0020;
-        }
-        break;
-    case 4: /* Auto-neg advertisement */
-        s->phy_advertise = (val & 0x2d7f) | 0x80;
-        break;
-        /* TODO 17, 18, 27, 31 */
-    case 30: /* Interrupt mask */
-        s->phy_int_mask = val & 0xff;
-        phy_update_irq(s);
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "do_phy_write: PHY write reg %d = 0x%04x\n", reg, val);
-    }
-}
-
 static void do_mac_write(lan9118_state *s, int reg, uint32_t val)
 {
     switch (reg) {
@@ -929,9 +829,9 @@ static void do_mac_write(lan9118_state *s, int reg, uint32_t val)
         if (val & 2) {
             DPRINTF("PHY write %d = 0x%04x\n",
                     (val >> 6) & 0x1f, s->mac_mii_data);
-            do_phy_write(s, (val >> 6) & 0x1f, s->mac_mii_data);
+            lan9118_phy_write(&s->mii, (val >> 6) & 0x1f, s->mac_mii_data);
         } else {
-            s->mac_mii_data = do_phy_read(s, (val >> 6) & 0x1f);
+            s->mac_mii_data = lan9118_phy_read(&s->mii, (val >> 6) & 0x1f);
             DPRINTF("PHY read %d = 0x%04x\n",
                     (val >> 6) & 0x1f, s->mac_mii_data);
         }
@@ -1126,7 +1026,7 @@ static void lan9118_writel(void *opaque, hwaddr offset,
         break;
     case CSR_PMT_CTRL:
         if (val & 0x400) {
-            phy_reset(s);
+            lan9118_phy_reset(&s->mii);
         }
         s->pmt_ctrl &= ~0x34e;
         s->pmt_ctrl |= (val & 0x34e);
@@ -1373,6 +1273,13 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
     const MemoryRegionOps *mem_ops =
             s->mode_16bit ? &lan9118_16bit_mem_ops : &lan9118_mem_ops;
 
+    qemu_init_irq(&s->mii_irq, lan9118_update_irq, s, 0);
+    object_initialize_child(OBJECT(s), "mii", &s->mii, TYPE_LAN9118_PHY);
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->mii), errp)) {
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->mii), 0, &s->mii_irq);
+
     memory_region_init_io(&s->mmio, OBJECT(dev), mem_ops, s,
                           "lan9118-mmio", 0x100);
     sysbus_init_mmio(sbd, &s->mmio);
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
new file mode 100644
index 0000000000..b22c3c2855
--- /dev/null
+++ b/hw/net/lan9118_phy.c
@@ -0,0 +1,169 @@
+/*
+ * SMSC LAN9118 PHY emulation
+ *
+ * Copyright (c) 2009 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GNU GPL v2
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/net/lan9118_phy.h"
+#include "hw/irq.h"
+#include "hw/resettable.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+
+#define PHY_INT_ENERGYON            (1 << 7)
+#define PHY_INT_AUTONEG_COMPLETE    (1 << 6)
+#define PHY_INT_FAULT               (1 << 5)
+#define PHY_INT_DOWN                (1 << 4)
+#define PHY_INT_AUTONEG_LP          (1 << 3)
+#define PHY_INT_PARFAULT            (1 << 2)
+#define PHY_INT_AUTONEG_PAGE        (1 << 1)
+
+static void lan9118_phy_update_irq(Lan9118PhyState *s)
+{
+    qemu_set_irq(s->irq, !!(s->ints & s->int_mask));
+}
+
+uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
+{
+    uint16_t val;
+
+    switch (reg) {
+    case 0: /* Basic Control */
+        return s->control;
+    case 1: /* Basic Status */
+        return s->status;
+    case 2: /* ID1 */
+        return 0x0007;
+    case 3: /* ID2 */
+        return 0xc0d1;
+    case 4: /* Auto-neg advertisement */
+        return s->advertise;
+    case 5: /* Auto-neg Link Partner Ability */
+        return 0x0f71;
+    case 6: /* Auto-neg Expansion */
+        return 1;
+        /* TODO 17, 18, 27, 29, 30, 31 */
+    case 29: /* Interrupt source. */
+        val = s->ints;
+        s->ints = 0;
+        lan9118_phy_update_irq(s);
+        return val;
+    case 30: /* Interrupt mask */
+        return s->int_mask;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "lan9118_phy_read: PHY read reg %d\n", reg);
+        return 0;
+    }
+}
+
+void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
+{
+    switch (reg) {
+    case 0: /* Basic Control */
+        if (val & 0x8000) {
+            lan9118_phy_reset(s);
+            break;
+        }
+        s->control = val & 0x7980;
+        /* Complete autonegotiation immediately. */
+        if (val & 0x1000) {
+            s->status |= 0x0020;
+        }
+        break;
+    case 4: /* Auto-neg advertisement */
+        s->advertise = (val & 0x2d7f) | 0x80;
+        break;
+        /* TODO 17, 18, 27, 31 */
+    case 30: /* Interrupt mask */
+        s->int_mask = val & 0xff;
+        lan9118_phy_update_irq(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "lan9118_phy_write: PHY write reg %d = 0x%04x\n", reg, val);
+    }
+}
+
+void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
+{
+    s->link_down = link_down;
+
+    /* Autonegotiation status mirrors link status. */
+    if (link_down) {
+        s->status &= ~0x0024;
+        s->ints |= PHY_INT_DOWN;
+    } else {
+        s->status |= 0x0024;
+        s->ints |= PHY_INT_ENERGYON;
+        s->ints |= PHY_INT_AUTONEG_COMPLETE;
+    }
+    lan9118_phy_update_irq(s);
+}
+
+void lan9118_phy_reset(Lan9118PhyState *s)
+{
+    s->control = 0x3000;
+    s->status = 0x7809;
+    s->advertise = 0x01e1;
+    s->int_mask = 0;
+    s->ints = 0;
+    lan9118_phy_update_link(s, s->link_down);
+}
+
+static void lan9118_phy_reset_hold(Object *obj, ResetType type)
+{
+    Lan9118PhyState *s = LAN9118_PHY(obj);
+
+    lan9118_phy_reset(s);
+}
+
+static void lan9118_phy_init(Object *obj)
+{
+    Lan9118PhyState *s = LAN9118_PHY(obj);
+
+    qdev_init_gpio_out(DEVICE(s), &s->irq, 1);
+}
+
+static const VMStateDescription vmstate_lan9118_phy = {
+    .name = "lan9118-phy",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(control, Lan9118PhyState),
+        VMSTATE_UINT16(status, Lan9118PhyState),
+        VMSTATE_UINT16(advertise, Lan9118PhyState),
+        VMSTATE_UINT16(ints, Lan9118PhyState),
+        VMSTATE_UINT16(int_mask, Lan9118PhyState),
+        VMSTATE_BOOL(link_down, Lan9118PhyState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void lan9118_phy_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    rc->phases.hold = lan9118_phy_reset_hold;
+    dc->vmsd = &vmstate_lan9118_phy;
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_LAN9118_PHY,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(Lan9118PhyState),
+        .instance_init = lan9118_phy_init,
+        .class_init    = lan9118_phy_class_init,
+    }
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 7fcc0d7faa..6b2ff2f937 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -62,8 +62,12 @@ config VMXNET3_PCI
 config SMC91C111
     bool
 
+config LAN9118_PHY
+    bool
+
 config LAN9118
     bool
+    select LAN9118_PHY
     select PTIMER
 
 config NE2000_ISA
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 00a9e9dd51..3bb5d749a8 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -19,6 +19,7 @@ system_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('vmxnet3.c'))
 
 system_ss.add(when: 'CONFIG_SMC91C111', if_true: files('smc91c111.c'))
 system_ss.add(when: 'CONFIG_LAN9118', if_true: files('lan9118.c'))
+system_ss.add(when: 'CONFIG_LAN9118_PHY', if_true: files('lan9118_phy.c'))
 system_ss.add(when: 'CONFIG_NE2000_ISA', if_true: files('ne2000-isa.c'))
 system_ss.add(when: 'CONFIG_OPENCORES_ETH', if_true: files('opencores_eth.c'))
 system_ss.add(when: 'CONFIG_XGMAC', if_true: files('xgmac.c'))
-- 
2.47.0


