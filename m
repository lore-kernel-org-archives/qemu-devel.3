Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E9E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRj-00007t-Nu; Wed, 11 Dec 2024 11:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRi-00006I-97
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRc-0007Zx-DC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so45363075e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934011; x=1734538811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9TlLdeT9MEbDY4em53wVDo7ir4MgWFdTWtmRTWldJXc=;
 b=NGm3v9EPMmYYPZlv+mxVxsCqojxh6Z8/Xlh5iIg0GB/EJDQ/VdYqqw5NBrAfNax6xR
 YISBbeQK191fz2K98t0fgFjLpVMNIJB1+OQKgR1mK4UbCeFzseoX6XO/yyX683J3DFVb
 n9jynYqSBTzFyjEda5aqmdZSCS4+vZH7iiopBQT8L83WgeD1IAE9f5t33aJC8y25Pf6f
 y7X7xQ7uj0RZnzaveYzl4Ir8daI9gSp4pUpNK8fCy2Vd9mn1Q5lXftWe5uRJ41VEdR8B
 PyGqCRtWSWSLsWZh5jbTOa0kow1np/hSizjTalfGLNxym9KOLUR8QzTVviji0+u9YRCx
 VD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934011; x=1734538811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TlLdeT9MEbDY4em53wVDo7ir4MgWFdTWtmRTWldJXc=;
 b=irCeKVJIdK+LGXNN6/SPEgReA+qG0bHhAp/lL+9T2ZlUmpG/WtDmy8OvItVxpBpn4C
 YvTCXmyQNY6NgNtP05Cm0fUB9IjuTSgv/Z67Bvdv+LT9nBrNx2UEe2XGArdJ1HXsrkGx
 93MJg5893rR7d2JVFX5AFT6iPT7Z2LU7xSjChsNSGH4Zg7WEd7iw2HvaTh+SAMIFnibY
 xoBQKq3QK55FZW0akr1cHsam/xn7l0fxz21oEgjJN/iQuk4ckTBoVqC3+7RGcxEoF6zo
 mSdKqlhfRt2PLAgPlYEO4uFI1OFLrE3Vuaabl0ix2MBYluiJ50m4n3ovdMclg6RNqUOo
 WUYg==
X-Gm-Message-State: AOJu0YwU/zxBfTNR4hplmQXB6l8U2a5DkypqjEPbi3ASiCZohaGL52JT
 ZtnKOjkVFPJ4cUX9dLOlhvvug8CYSyEduM0cVOg6jGfP/zecSIpYHYPaaWlyFaSC9wIq4N9Lozz
 m
X-Gm-Gg: ASbGnctlO/XqVjPbw0qqopsjYw2sPaDauH+f9byCEpg7jeuNfEbWrp9dXFJnUes9uYr
 IFVreClub1tmP7SU5tXi+Ic/eTO6mNmuLvEAqVwOPcdPahviaReJ1xpdwT++/rOwbjDbPBbxK6A
 it9b5I/sqrEgXw+v84GjEu51mMkK446CfLDeYHlFX6+n7xfRj7oiK2inSEAyeDdU0K4yXemChEu
 OvMYNM1tY4ykmwsCbXg3Nk/QdeuRSwdynz0JG64gqQak5j94KdOXQqnb0xl
X-Google-Smtp-Source: AGHT+IExfihj0XLfd390o0W615iKh7G8Vd8JnN650TUXebyg1TW6twQOcDu04ErrhZUgQSmcMnQiAw==
X-Received: by 2002:a05:600c:19cf:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-4361c38cf38mr30621865e9.16.1733934010723; 
 Wed, 11 Dec 2024 08:20:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/72] hw/net/lan9118_phy: Reuse in imx_fec and consolidate
 implementations
Date: Wed, 11 Dec 2024 16:18:54 +0000
Message-Id: <20241211162004.2795499-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

imx_fec models the same PHY as lan9118_phy. The code is almost the same with
imx_fec having more logging and tracing. Merge these improvements into
lan9118_phy and reuse in imx_fec to fix the code duplication.

Some migration state how resides in the new device model which breaks migration
compatibility for the following machines:
* imx25-pdk
* sabrelite
* mcimx7d-sabre
* mcimx6ul-evk

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241102125724.532843-3-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/imx_fec.h |   9 ++-
 hw/net/imx_fec.c         | 146 ++++-----------------------------------
 hw/net/lan9118_phy.c     |  82 ++++++++++++++++------
 hw/net/Kconfig           |   1 +
 hw/net/trace-events      |  10 +--
 5 files changed, 85 insertions(+), 163 deletions(-)

diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 2d13290c787..83b21637eeb 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -31,6 +31,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXFECState, IMX_FEC)
 #define TYPE_IMX_ENET "imx.enet"
 
 #include "hw/sysbus.h"
+#include "hw/net/lan9118_phy.h"
+#include "hw/irq.h"
 #include "net/net.h"
 
 #define ENET_EIR               1
@@ -264,11 +266,8 @@ struct IMXFECState {
     uint32_t tx_descriptor[ENET_TX_RING_NUM];
     uint32_t tx_ring_num;
 
-    uint32_t phy_status;
-    uint32_t phy_control;
-    uint32_t phy_advertise;
-    uint32_t phy_int;
-    uint32_t phy_int_mask;
+    Lan9118PhyState mii;
+    IRQState mii_irq;
     uint32_t phy_num;
     bool phy_connected;
     struct IMXFECState *phy_consumer;
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6294d292023..4ee6f742063 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -203,17 +203,12 @@ static const VMStateDescription vmstate_imx_eth_txdescs = {
 
 static const VMStateDescription vmstate_imx_eth = {
     .name = TYPE_IMX_FEC,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IMXFECState, ENET_MAX),
         VMSTATE_UINT32(rx_descriptor, IMXFECState),
         VMSTATE_UINT32(tx_descriptor[0], IMXFECState),
-        VMSTATE_UINT32(phy_status, IMXFECState),
-        VMSTATE_UINT32(phy_control, IMXFECState),
-        VMSTATE_UINT32(phy_advertise, IMXFECState),
-        VMSTATE_UINT32(phy_int, IMXFECState),
-        VMSTATE_UINT32(phy_int_mask, IMXFECState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -222,14 +217,6 @@ static const VMStateDescription vmstate_imx_eth = {
     },
 };
 
-#define PHY_INT_ENERGYON            (1 << 7)
-#define PHY_INT_AUTONEG_COMPLETE    (1 << 6)
-#define PHY_INT_FAULT               (1 << 5)
-#define PHY_INT_DOWN                (1 << 4)
-#define PHY_INT_AUTONEG_LP          (1 << 3)
-#define PHY_INT_PARFAULT            (1 << 2)
-#define PHY_INT_AUTONEG_PAGE        (1 << 1)
-
 static void imx_eth_update(IMXFECState *s);
 
 /*
@@ -238,47 +225,19 @@ static void imx_eth_update(IMXFECState *s);
  * For now we don't handle any GPIO/interrupt line, so the OS will
  * have to poll for the PHY status.
  */
-static void imx_phy_update_irq(IMXFECState *s)
+static void imx_phy_update_irq(void *opaque, int n, int level)
 {
-    imx_eth_update(s);
-}
-
-static void imx_phy_update_link(IMXFECState *s)
-{
-    /* Autonegotiation status mirrors link status.  */
-    if (qemu_get_queue(s->nic)->link_down) {
-        trace_imx_phy_update_link("down");
-        s->phy_status &= ~0x0024;
-        s->phy_int |= PHY_INT_DOWN;
-    } else {
-        trace_imx_phy_update_link("up");
-        s->phy_status |= 0x0024;
-        s->phy_int |= PHY_INT_ENERGYON;
-        s->phy_int |= PHY_INT_AUTONEG_COMPLETE;
-    }
-    imx_phy_update_irq(s);
+    imx_eth_update(opaque);
 }
 
 static void imx_eth_set_link(NetClientState *nc)
 {
-    imx_phy_update_link(IMX_FEC(qemu_get_nic_opaque(nc)));
-}
-
-static void imx_phy_reset(IMXFECState *s)
-{
-    trace_imx_phy_reset();
-
-    s->phy_status = 0x7809;
-    s->phy_control = 0x3000;
-    s->phy_advertise = 0x01e1;
-    s->phy_int_mask = 0;
-    s->phy_int = 0;
-    imx_phy_update_link(s);
+    lan9118_phy_update_link(&IMX_FEC(qemu_get_nic_opaque(nc))->mii,
+                            nc->link_down);
 }
 
 static uint32_t imx_phy_read(IMXFECState *s, int reg)
 {
-    uint32_t val;
     uint32_t phy = reg / 32;
 
     if (!s->phy_connected) {
@@ -296,54 +255,7 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
 
     reg %= 32;
 
-    switch (reg) {
-    case 0:     /* Basic Control */
-        val = s->phy_control;
-        break;
-    case 1:     /* Basic Status */
-        val = s->phy_status;
-        break;
-    case 2:     /* ID1 */
-        val = 0x0007;
-        break;
-    case 3:     /* ID2 */
-        val = 0xc0d1;
-        break;
-    case 4:     /* Auto-neg advertisement */
-        val = s->phy_advertise;
-        break;
-    case 5:     /* Auto-neg Link Partner Ability */
-        val = 0x0f71;
-        break;
-    case 6:     /* Auto-neg Expansion */
-        val = 1;
-        break;
-    case 29:    /* Interrupt source.  */
-        val = s->phy_int;
-        s->phy_int = 0;
-        imx_phy_update_irq(s);
-        break;
-    case 30:    /* Interrupt mask */
-        val = s->phy_int_mask;
-        break;
-    case 17:
-    case 18:
-    case 27:
-    case 31:
-        qemu_log_mask(LOG_UNIMP, "[%s.phy]%s: reg %d not implemented\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        val = 0;
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad address at offset %d\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        val = 0;
-        break;
-    }
-
-    trace_imx_phy_read(val, phy, reg);
-
-    return val;
+    return lan9118_phy_read(&s->mii, reg);
 }
 
 static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
@@ -365,39 +277,7 @@ static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
 
     reg %= 32;
 
-    trace_imx_phy_write(val, phy, reg);
-
-    switch (reg) {
-    case 0:     /* Basic Control */
-        if (val & 0x8000) {
-            imx_phy_reset(s);
-        } else {
-            s->phy_control = val & 0x7980;
-            /* Complete autonegotiation immediately.  */
-            if (val & 0x1000) {
-                s->phy_status |= 0x0020;
-            }
-        }
-        break;
-    case 4:     /* Auto-neg advertisement */
-        s->phy_advertise = (val & 0x2d7f) | 0x80;
-        break;
-    case 30:    /* Interrupt mask */
-        s->phy_int_mask = val & 0xff;
-        imx_phy_update_irq(s);
-        break;
-    case 17:
-    case 18:
-    case 27:
-    case 31:
-        qemu_log_mask(LOG_UNIMP, "[%s.phy)%s: reg %d not implemented\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad address at offset %d\n",
-                      TYPE_IMX_FEC, __func__, reg);
-        break;
-    }
+    lan9118_phy_write(&s->mii, reg, val);
 }
 
 static void imx_fec_read_bd(IMXFECBufDesc *bd, dma_addr_t addr)
@@ -682,9 +562,6 @@ static void imx_eth_reset(DeviceState *d)
 
     s->rx_descriptor = 0;
     memset(s->tx_descriptor, 0, sizeof(s->tx_descriptor));
-
-    /* We also reset the PHY */
-    imx_phy_reset(s);
 }
 
 static uint32_t imx_default_read(IMXFECState *s, uint32_t index)
@@ -1329,6 +1206,13 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq[0]);
     sysbus_init_irq(sbd, &s->irq[1]);
 
+    qemu_init_irq(&s->mii_irq, imx_phy_update_irq, s, 0);
+    object_initialize_child(OBJECT(s), "mii", &s->mii, TYPE_LAN9118_PHY);
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->mii), errp)) {
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->mii), 0, &s->mii_irq);
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&imx_eth_net_info, &s->conf,
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index b22c3c28556..d2dcd732ac1 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2009 CodeSourcery, LLC.
  * Written by Paul Brook
  *
+ * Copyright (c) 2013 Jean-Christophe Dubois. <jcd@tribudubois.net>
+ *
  * This code is licensed under the GNU GPL v2
  *
  * Contributions after 2012-01-13 are licensed under the terms of the
@@ -16,6 +18,7 @@
 #include "hw/resettable.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 #define PHY_INT_ENERGYON            (1 << 7)
 #define PHY_INT_AUTONEG_COMPLETE    (1 << 6)
@@ -36,59 +39,88 @@ uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
 
     switch (reg) {
     case 0: /* Basic Control */
-        return s->control;
+        val = s->control;
+        break;
     case 1: /* Basic Status */
-        return s->status;
+        val = s->status;
+        break;
     case 2: /* ID1 */
-        return 0x0007;
+        val = 0x0007;
+        break;
     case 3: /* ID2 */
-        return 0xc0d1;
+        val = 0xc0d1;
+        break;
     case 4: /* Auto-neg advertisement */
-        return s->advertise;
+        val = s->advertise;
+        break;
     case 5: /* Auto-neg Link Partner Ability */
-        return 0x0f71;
+        val = 0x0f71;
+        break;
     case 6: /* Auto-neg Expansion */
-        return 1;
-        /* TODO 17, 18, 27, 29, 30, 31 */
+        val = 1;
+        break;
     case 29: /* Interrupt source. */
         val = s->ints;
         s->ints = 0;
         lan9118_phy_update_irq(s);
-        return val;
+        break;
     case 30: /* Interrupt mask */
-        return s->int_mask;
+        val = s->int_mask;
+        break;
+    case 17:
+    case 18:
+    case 27:
+    case 31:
+        qemu_log_mask(LOG_UNIMP, "%s: reg %d not implemented\n",
+                      __func__, reg);
+        val = 0;
+        break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "lan9118_phy_read: PHY read reg %d\n", reg);
-        return 0;
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset %d\n",
+                      __func__, reg);
+        val = 0;
+        break;
     }
+
+    trace_lan9118_phy_read(val, reg);
+
+    return val;
 }
 
 void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
 {
+    trace_lan9118_phy_write(val, reg);
+
     switch (reg) {
     case 0: /* Basic Control */
         if (val & 0x8000) {
             lan9118_phy_reset(s);
-            break;
-        }
-        s->control = val & 0x7980;
-        /* Complete autonegotiation immediately. */
-        if (val & 0x1000) {
-            s->status |= 0x0020;
+        } else {
+            s->control = val & 0x7980;
+            /* Complete autonegotiation immediately. */
+            if (val & 0x1000) {
+                s->status |= 0x0020;
+            }
         }
         break;
     case 4: /* Auto-neg advertisement */
         s->advertise = (val & 0x2d7f) | 0x80;
         break;
-        /* TODO 17, 18, 27, 31 */
     case 30: /* Interrupt mask */
         s->int_mask = val & 0xff;
         lan9118_phy_update_irq(s);
         break;
+    case 17:
+    case 18:
+    case 27:
+    case 31:
+        qemu_log_mask(LOG_UNIMP, "%s: reg %d not implemented\n",
+                      __func__, reg);
+        break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "lan9118_phy_write: PHY write reg %d = 0x%04x\n", reg, val);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset %d\n",
+                      __func__, reg);
+        break;
     }
 }
 
@@ -98,9 +130,11 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
 
     /* Autonegotiation status mirrors link status. */
     if (link_down) {
+        trace_lan9118_phy_update_link("down");
         s->status &= ~0x0024;
         s->ints |= PHY_INT_DOWN;
     } else {
+        trace_lan9118_phy_update_link("up");
         s->status |= 0x0024;
         s->ints |= PHY_INT_ENERGYON;
         s->ints |= PHY_INT_AUTONEG_COMPLETE;
@@ -110,6 +144,8 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
 
 void lan9118_phy_reset(Lan9118PhyState *s)
 {
+    trace_lan9118_phy_reset();
+
     s->control = 0x3000;
     s->status = 0x7809;
     s->advertise = 0x01e1;
@@ -137,8 +173,8 @@ static const VMStateDescription vmstate_lan9118_phy = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT16(control, Lan9118PhyState),
         VMSTATE_UINT16(status, Lan9118PhyState),
+        VMSTATE_UINT16(control, Lan9118PhyState),
         VMSTATE_UINT16(advertise, Lan9118PhyState),
         VMSTATE_UINT16(ints, Lan9118PhyState),
         VMSTATE_UINT16(int_mask, Lan9118PhyState),
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 6b2ff2f937a..7f80218d10f 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -93,6 +93,7 @@ config ALLWINNER_SUN8I_EMAC
 
 config IMX_FEC
     bool
+    select LAN9118_PHY
 
 config CADENCE
     bool
diff --git a/hw/net/trace-events b/hw/net/trace-events
index d0f1d8c0fbe..6100ec324a7 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -10,6 +10,12 @@ allwinner_sun8i_emac_set_link(bool active) "Set link: active=%u"
 allwinner_sun8i_emac_read(uint64_t offset, uint64_t val) "MMIO read: offset=0x%" PRIx64 " value=0x%" PRIx64
 allwinner_sun8i_emac_write(uint64_t offset, uint64_t val) "MMIO write: offset=0x%" PRIx64 " value=0x%" PRIx64
 
+# lan9118_phy.c
+lan9118_phy_read(uint16_t val, int reg) "[0x%02x] -> 0x%04" PRIx16
+lan9118_phy_write(uint16_t val, int reg) "[0x%02x] <- 0x%04" PRIx16
+lan9118_phy_update_link(const char *s) "%s"
+lan9118_phy_reset(void) ""
+
 # lance.c
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64"val=0x%04x"
 lance_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64"val=0x%04x"
@@ -428,12 +434,8 @@ i82596_set_multicast(uint16_t count) "Added %d multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
 
 # imx_fec.c
-imx_phy_read(uint32_t val, int phy, int reg) "0x%04"PRIx32" <= phy[%d].reg[%d]"
 imx_phy_read_num(int phy, int configured) "read request from unconfigured phy %d (configured %d)"
-imx_phy_write(uint32_t val, int phy, int reg) "0x%04"PRIx32" => phy[%d].reg[%d]"
 imx_phy_write_num(int phy, int configured) "write request to unconfigured phy %d (configured %d)"
-imx_phy_update_link(const char *s) "%s"
-imx_phy_reset(void) ""
 imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
 imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int options, int status) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x option 0x%04x status 0x%04x"
 imx_eth_tx_bd_busy(void) "tx_bd ran out of descriptors to transmit"
-- 
2.34.1


