Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5A7C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaBk-0003Tq-6J; Thu, 01 Feb 2024 11:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB2-0002v9-Vu
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:37 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAt-0002SV-Qu
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=/ulRku6s7viRleZiI+J1AG9hPUHHwrzfLVNgMu8tpd0=; b=ZpJ+PauTQV6lng/LOMvpfOse6C
 RDtEaRsiI6XoNWHW6kP5SFrqe3rxz0egAdzxVV8LFd/GV9atiTf6sqj9XNTzMDTlHsKfsw5FjwIDE
 P751UW3WjzU5g2n7rfPFbziohf9EYba+ow4jyu9EjTlAJwX/pGL2NDQcTt7MYddQWe7Fuozu/8czr
 rywAbLAGXLcfxGhOCKfxkayRxeEwKQ+jGouuk2b68MsMaxu/XM+7JSetJpFnFsJoo0PoFj/GthDiK
 vVRUnfUb6yFcqYUGRwCIjiabGVRIha83hG/knSWoMgX9coRmETrJH9he2Lz7SkhsrlzsaSG2olM+g
 0NgYucmA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdR-1gqx for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003INl-1cJq for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/47] hw/arm/stellaris: use qemu_find_nic_info()
Date: Thu,  1 Feb 2024 16:43:54 +0000
Message-ID: <20240201164412.785520-30-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

Rather than just using qemu_configure_nic_device(), populate the MAC
address in the system-registers device by peeking at the NICInfo before
it's assigned to the device.

Generate the MAC address early, if there is no matching -nic option.
Otherwise the MAC address wouldn't be generated until net_client_init1()
runs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/stellaris.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index d18b1144af..34c5a86ac2 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1028,7 +1028,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     DeviceState *ssys_dev;
     int i;
     int j;
-    const uint8_t *macaddr;
+    NICInfo *nd;
+    MACAddr mac;
 
     MemoryRegion *sram = g_new(MemoryRegion, 1);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
@@ -1051,12 +1052,22 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * need its sysclk output.
      */
     ssys_dev = qdev_new(TYPE_STELLARIS_SYS);
-    /* Most devices come preprogrammed with a MAC address in the user data. */
-    macaddr = nd_table[0].macaddr.a;
+
+    /*
+     * Most devices come preprogrammed with a MAC address in the user data.
+     * Generate a MAC address now, if there isn't a matching -nic for it.
+     */
+    nd = qemu_find_nic_info("stellaris_enet", true, "stellaris");
+    if (nd) {
+        memcpy(mac.a, nd->macaddr.a, sizeof(mac.a));
+    } else {
+        qemu_macaddr_default_if_unset(&mac);
+    }
+
     qdev_prop_set_uint32(ssys_dev, "user0",
-                         macaddr[0] | (macaddr[1] << 8) | (macaddr[2] << 16));
+                         mac.a[0] | (mac.a[1] << 8) | (mac.a[2] << 16));
     qdev_prop_set_uint32(ssys_dev, "user1",
-                         macaddr[3] | (macaddr[4] << 8) | (macaddr[5] << 16));
+                         mac.a[3] | (mac.a[4] << 8) | (mac.a[5] << 16));
     qdev_prop_set_uint32(ssys_dev, "did0", board->did0);
     qdev_prop_set_uint32(ssys_dev, "did1", board->did1);
     qdev_prop_set_uint32(ssys_dev, "dc0", board->dc0);
@@ -1269,10 +1280,13 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     if (board->dc4 & (1 << 28)) {
         DeviceState *enet;
 
-        qemu_check_nic_model(&nd_table[0], "stellaris");
-
         enet = qdev_new("stellaris_enet");
-        qdev_set_nic_properties(enet, &nd_table[0]);
+        if (nd) {
+            qdev_set_nic_properties(enet, nd);
+        } else {
+            qdev_prop_set_macaddr(enet, "mac", mac.a);
+        }
+
         sysbus_realize_and_unref(SYS_BUS_DEVICE(enet), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(enet), 0, 0x40048000);
         sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
-- 
2.43.0


