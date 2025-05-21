Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82969C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHltN-0001eP-1p; Wed, 21 May 2025 12:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHltB-0001Ui-7v
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:01:56 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHlt8-0000Wg-Q4
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wx11R4hHmcZx4Owx73f7dFOsZyVJSShRDqAxd3mWQgY=; b=D813DH5WV77Rzr6hQarVCXGnXe
 mCpdWPKayN0EdwN8/IRptMQnT3TLaee55jRb1aWnHlzS0Hu3NAD3BlxqP/b1CJLqxaq+yFfNXPYZQ
 9U90+QPT4gXnMzw8e5v/dvQE7iOsvIqUsU5k7JeXyVJQHUc5mSIV70rVE7d99CifScwVfEmhxQJXM
 MkFr/lOr1/gS4OwgaMbfJcExaQFpV7gj7A9eMaRRi5uTNVf2XUxwXp8bY2f1KQ2N7+jqM0BsWdVeJ
 oB1svcA4k6p+3rOZZFepxys7g3nb4gDUwzO4pSkwr8ZcwT1pjK1AjBpAT1TQMEhrOwj2WefZ4AE6x
 y3zFI57A==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uHlt1-00FTdN-Fy; Wed, 21 May 2025 17:01:43 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uHlt1-000000006RH-0zPR;
 Wed, 21 May 2025 17:01:43 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 qemu-devel@nongnu.org
Cc: ben.dooks@codethink.co.uk
Subject: [RFC 3/3] hw/net: lowrisc: initial mdio_bb work
Date: Wed, 21 May 2025 17:01:42 +0100
Message-Id: <20250521160142.24715-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250521160142.24715-1-ben.dooks@codethink.co.uk>
References: <20250521160142.24715-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=srv_ts003@codethink.com; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add initial implementation of PHY via bit-banged code.

This is to test the mdio_bb code and will need updating
for real board values.
---
 hw/net/Kconfig               |  1 +
 hw/net/lowrisc.c             | 42 +++++++++++++++++++++++++++++++-----
 include/hw/net/lowrisc_eth.h |  4 ++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 3abee9130e..0bc11e567a 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -114,6 +114,7 @@ config MDIO_BB
 
 config LOWRISC_ETH
     bool
+    select MDIO_BB
 
 config SUNHME
     bool
diff --git a/hw/net/lowrisc.c b/hw/net/lowrisc.c
index 98177793e6..d5cae83eb0 100644
--- a/hw/net/lowrisc.c
+++ b/hw/net/lowrisc.c
@@ -194,6 +194,32 @@ static bool lowrisc_eth_can_receive(NetClientState *nc)
     return ok;
 }
 
+static unsigned lowrisc_eth_phy_read(void *opaque, unsigned reg)
+{
+    unsigned phy = reg >> 5;
+
+    reg &= 0x1f;
+    if (phy == 1) {
+        switch (reg) {
+        case 0x00:
+            return 0xcafe;
+        case 0x01:
+            return 0xf00d;
+
+        default:
+            return 0xffff;
+        }
+    } else {
+        return reg;
+    }
+
+    return 0xffff;
+}
+
+static void lowrisc_eth_phy_write(void *opaque, unsigned reg, unsigned val)
+{
+}
+
 #define make_mac(__m, __b) (((uint32_t)(__m)) << (__b))
 
 static void lowrisc_eth_init_registers(LowriscEthState *s)
@@ -209,6 +235,13 @@ static void lowrisc_eth_init_registers(LowriscEthState *s)
     s->r_mdioctrl = FIELD_DP32(0x0, MDIOCTRL, M_DI, 1);
     memset(&s->r_rplr, 0, sizeof(s->r_rplr));
 
+    /* setup the mdio bus */
+    mdio_bb_init(&s->mdio_bb);
+    s->mdio_bb.name = "lowrisc_eth";
+    s->mdio_bb.param = s;
+    s->mdio_bb.read = lowrisc_eth_phy_read;
+    s->mdio_bb.write = lowrisc_eth_phy_write;
+    
     /* init mac registers */
 
     mac = &s->conf.macaddr.a[0];
@@ -259,12 +292,11 @@ static uint64_t lowrisc_eth_read(void *opaque, hwaddr offset, unsigned size)
 
 static void lowrisc_eth_update_mdioctrl(LowriscEthState *s, uint32_t val)
 {
-    /* since we're not implementing any sort of bit-banged MDIO, we just
-     * return the data input as high, which seems to be enough to allow
-     * the PHY link checks to work
-     */
+    bool mdc = FIELD_EX32(val, MDIOCTRL, M_CLK);
+    bool mdo = FIELD_EX32(val, MDIOCTRL, M_DO);
 
-    s->r_mdioctrl = FIELD_DP32(s->r_mdioctrl, MDIOCTRL, M_DI, 1);
+    mdio_bb_update(&s->mdio_bb, mdc, mdo);
+    s->r_mdioctrl = FIELD_DP32(val, MDIOCTRL, M_DI, s->mdio_bb.mdi);
 }
 
 /* update tplr register, assume we're transmitting a packet */
diff --git a/include/hw/net/lowrisc_eth.h b/include/hw/net/lowrisc_eth.h
index 1f27d92ca8..5c15549cc1 100644
--- a/include/hw/net/lowrisc_eth.h
+++ b/include/hw/net/lowrisc_eth.h
@@ -17,6 +17,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(LowriscEthState, LOWRISC_ETH)
 
 #include "net/net.h"
 #include "hw/sysbus.h"
+#include "hw/net/mdio_bb.h"
 
 #define RX_SZ           (2048)
 #define NR_RX_BUFFS     (8)
@@ -37,6 +38,9 @@ struct LowriscEthState {
     NICConf conf;
     qemu_irq irq;
 
+    /* the mdio bus */
+    struct mdio_bb mdio_bb;
+
     /* register states */
     uint32_t r_maclo;
     uint32_t r_machi;
-- 
2.37.2.352.g3c44437643


