Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5688BE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7DhN-0004Lw-MO; Sat, 02 Nov 2024 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhH-0004Km-TE; Sat, 02 Nov 2024 08:57:44 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhG-0003XE-6J; Sat, 02 Nov 2024 08:57:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a68480164so405294766b.3; 
 Sat, 02 Nov 2024 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730552260; x=1731157060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEJit+n3Bz7TMfJTRDNgLiFEZd/dM54jh7Ah9LBdETI=;
 b=ct6vKB45+i0eaK3pgUvgF/oiGCNPsHSDfM5IPDvsp9xiR1G0uuLAxKEZkbjjBoKJuo
 tE+/z2TplQSX9GneSNMgiERA3OZsZpaoMfl/gXMiHG1aUAlQhBPQDkjFaWWcVmYENJ6g
 OzT4WZYN/yp47DLii6qfzDDAmxH5cDj/TpNn3LW0II+Prcy4x879dNCB6MJNvV+lwJoW
 MNH5ErbbJh0Xunh3CGKk4Ko93sOV6F00nn6shvCJX4Gsf9e/eKcgDBMh8CF9XIj/HUJn
 UV4QBspzWgh98ZnMWAvOePygcJoI8kJZubdO0/adTuAU85Er+2/XCQvvjnpulgYfDBiv
 +JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730552260; x=1731157060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEJit+n3Bz7TMfJTRDNgLiFEZd/dM54jh7Ah9LBdETI=;
 b=nuIyzkxmzXvmQe81balOAnM3OcbeMVXKq19cI/q0Xl9bOnSyVE3Bo5VewzHMBhFmne
 CzEQRCNJAGs7z5+l9X3rnCRtt3DncglYIq0x/Lyrgq9raK1Tcr2OUuplrGQtTLMWoEdv
 0KIY/960ulBM2FLVJYtsUcUcepmzwx30UxZmIPG0AZqVBqNvRvfvUnUdjDofHtQEte92
 hdNH13OFLATe42JNwFX8iPXBnPr0ea/tR4UzSu3998tK/syvPce1q4CEDn/YA45xr8/d
 86d+H16uLCA8EEhaRV1QcOuD/nRPJkAgyciTrjOPQG3EThkP7yWQwYj8/LnvBxV5kXl0
 ukRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFnqI/sarJ5GiA5grjDgWx7svMoRx+cwNEtDVUYibGSvBR3MdSPBVdCMrIh7sDAZlQDQ3Samsb1Q==@nongnu.org
X-Gm-Message-State: AOJu0Yz0aG8dAR/pSfKo3H62myegiYBpCVngKlEPDdlQpsNQyrXWi5VK
 tyRwWiAT6H9L7ghTx3s9CGZ+yCHSd56iR84W+K393rkJ/pzWrYJ6K35ofQ==
X-Google-Smtp-Source: AGHT+IHwXhP5hKHqaAkT0ZHi7DyXwIGWluEZ9ovphRnTKFV+4rq6cX0VjB/wRuKpqgVpKBC/XfLUxg==
X-Received: by 2002:a17:907:3e1a:b0:a99:f4be:7a6c with SMTP id
 a640c23a62f3a-a9de61669cdmr2706319666b.52.1730552259871; 
 Sat, 02 Nov 2024 05:57:39 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e566846a7sm305836666b.206.2024.11.02.05.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 05:57:39 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 4/5] hw/net/lan9118_phy: Reuse MII constants
Date: Sat,  2 Nov 2024 13:57:23 +0100
Message-ID: <20241102125724.532843-5-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102125724.532843-1-shentey@gmail.com>
References: <20241102125724.532843-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

Prefer named constants over magic values for better readability.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/mii.h |  6 +++++
 hw/net/lan9118_phy.c | 63 ++++++++++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index f7feddac9b..55bf7c92a1 100644
--- a/include/hw/net/mii.h
+++ b/include/hw/net/mii.h
@@ -71,6 +71,7 @@
 #define MII_BMSR_JABBER     (1 << 1)  /* Jabber detected */
 #define MII_BMSR_EXTCAP     (1 << 0)  /* Ext-reg capability */
 
+#define MII_ANAR_RFAULT     (1 << 13) /* Say we can detect faults */
 #define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymmetric pause */
 #define MII_ANAR_PAUSE      (1 << 10) /* Try for pause */
 #define MII_ANAR_TXFD       (1 << 8)
@@ -78,6 +79,7 @@
 #define MII_ANAR_10FD       (1 << 6)
 #define MII_ANAR_10         (1 << 5)
 #define MII_ANAR_CSMACD     (1 << 0)
+#define MII_ANAR_SELECT     (0x001f)  /* Selector bits */
 
 #define MII_ANLPAR_ACK      (1 << 14)
 #define MII_ANLPAR_PAUSEASY (1 << 11) /* can pause asymmetrically */
@@ -112,6 +114,10 @@
 #define RTL8201CP_PHYID1    0x0000
 #define RTL8201CP_PHYID2    0x8201
 
+/* SMSC LAN9118 */
+#define SMSCLAN9118_PHYID1  0x0007
+#define SMSCLAN9118_PHYID2  0xc0d1
+
 /* RealTek 8211E */
 #define RTL8211E_PHYID1     0x001c
 #define RTL8211E_PHYID2     0xc915
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index d8fc9ddd3a..874dae4155 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/net/lan9118_phy.h"
+#include "hw/net/mii.h"
 #include "hw/irq.h"
 #include "hw/resettable.h"
 #include "migration/vmstate.h"
@@ -38,26 +39,28 @@ uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
     uint16_t val;
 
     switch (reg) {
-    case 0: /* Basic Control */
+    case MII_BMCR:
         val = s->control;
         break;
-    case 1: /* Basic Status */
+    case MII_BMSR:
         val = s->status;
         break;
-    case 2: /* ID1 */
-        val = 0x0007;
+    case MII_PHYID1:
+        val = SMSCLAN9118_PHYID1;
         break;
-    case 3: /* ID2 */
-        val = 0xc0d1;
+    case MII_PHYID2:
+        val = SMSCLAN9118_PHYID2;
         break;
-    case 4: /* Auto-neg advertisement */
+    case MII_ANAR:
         val = s->advertise;
         break;
-    case 5: /* Auto-neg Link Partner Ability */
-        val = 0x0fe1;
+    case MII_ANLPAR:
+        val = MII_ANLPAR_PAUSEASY | MII_ANLPAR_PAUSE | MII_ANLPAR_T4 |
+              MII_ANLPAR_TXFD | MII_ANLPAR_TX | MII_ANLPAR_10FD |
+              MII_ANLPAR_10 | MII_ANLPAR_CSMACD;
         break;
-    case 6: /* Auto-neg Expansion */
-        val = 1;
+    case MII_ANER:
+        val = MII_ANER_NWAY;
         break;
     case 29: /* Interrupt source. */
         val = s->ints;
@@ -92,19 +95,24 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
     trace_lan9118_phy_write(val, reg);
 
     switch (reg) {
-    case 0: /* Basic Control */
-        if (val & 0x8000) {
+    case MII_BMCR:
+        if (val & MII_BMCR_RESET) {
             lan9118_phy_reset(s);
         } else {
-            s->control = val & 0x7980;
+            s->control = val & (MII_BMCR_LOOPBACK | MII_BMCR_SPEED100 |
+                                MII_BMCR_AUTOEN | MII_BMCR_PDOWN | MII_BMCR_FD |
+                                MII_BMCR_CTST);
             /* Complete autonegotiation immediately. */
-            if (val & 0x1000) {
-                s->status |= 0x0020;
+            if (val & MII_BMCR_AUTOEN) {
+                s->status |= MII_BMSR_AN_COMP;
             }
         }
         break;
-    case 4: /* Auto-neg advertisement */
-        s->advertise = (val & 0x2d7f) | 0x80;
+    case MII_ANAR:
+        s->advertise = (val & (MII_ANAR_RFAULT | MII_ANAR_PAUSE_ASYM |
+                               MII_ANAR_PAUSE | MII_ANAR_10FD | MII_ANAR_10 |
+                               MII_ANAR_SELECT))
+                     | MII_ANAR_TX;
         break;
     case 30: /* Interrupt mask */
         s->int_mask = val & 0xff;
@@ -131,11 +139,11 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
     /* Autonegotiation status mirrors link status. */
     if (link_down) {
         trace_lan9118_phy_update_link("down");
-        s->status &= ~0x0024;
+        s->status &= ~(MII_BMSR_AN_COMP | MII_BMSR_LINK_ST);
         s->ints |= PHY_INT_DOWN;
     } else {
         trace_lan9118_phy_update_link("up");
-        s->status |= 0x0024;
+        s->status |= MII_BMSR_AN_COMP | MII_BMSR_LINK_ST;
         s->ints |= PHY_INT_ENERGYON;
         s->ints |= PHY_INT_AUTONEG_COMPLETE;
     }
@@ -146,9 +154,18 @@ void lan9118_phy_reset(Lan9118PhyState *s)
 {
     trace_lan9118_phy_reset();
 
-    s->control = 0x3000;
-    s->status = 0x7809;
-    s->advertise = 0x01e1;
+    s->control = MII_BMCR_AUTOEN | MII_BMCR_SPEED100;
+    s->status = MII_BMSR_100TX_FD
+                | MII_BMSR_100TX_HD
+                | MII_BMSR_10T_FD
+                | MII_BMSR_10T_HD
+                | MII_BMSR_AUTONEG
+                | MII_BMSR_EXTCAP;
+    s->advertise = MII_ANAR_TXFD
+                   | MII_ANAR_TX
+                   | MII_ANAR_10FD
+                   | MII_ANAR_10
+                   | MII_ANAR_CSMACD;
     s->int_mask = 0;
     s->ints = 0;
     lan9118_phy_update_link(s, s->link_down);
-- 
2.47.0


