Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382CDC48292
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaB5-0002vN-UW; Thu, 01 Feb 2024 11:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAq-0002qh-Rx
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:25 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAj-0002SU-Gb
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=Qspogv9stZB79QEZpJwewrrR9VbTKEbvJpFBcADIitI=; b=oiTRvCcC0RbEWdhP1WAkNJlFHP
 m34ojOv1OSTpspO9HvBgKhWRuHv6qkEBKbHSrqZmVy2CVjd9rDWzr+KqtkZSmiuVOKOYctlj0Cfkt
 uXMATvUCCPSKlaDKtnKNFFl3oLqP7jtNLsxO0HGkhXtUeiQsROJ14rQ0wijU1Dkw1uaNQORIrJGpe
 c90fykPIB7ENun1osAamC74cFQQVm3u6VJl8kVt3LIOBjNnGQtYcE4NOc+4wII+nhAxWowAIK3kse
 A5jU5IAZoHHWR0aZCUDmKNhaiZLCaROcSdJI2L/nARJx2okFYvm64zbU74KGwlzQOSTe9NJezfXAw
 5EsnOxfw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdK-1IdB for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003INZ-1IT5 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/47] hw/net/lan9118: use qemu_configure_nic_device()
Date: Thu,  1 Feb 2024 16:43:51 +0000
Message-ID: <20240201164412.785520-27-dwmw2@infradead.org>
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

Some callers instantiate the device unconditionally, others will do so only
if there is a NICInfo to go with it. This appears to be fairly random, but
preseve the existing behaviour for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/kzm.c             | 4 ++--
 hw/arm/mps2.c            | 2 +-
 hw/arm/realview.c        | 6 ++----
 hw/arm/vexpress.c        | 4 ++--
 hw/net/lan9118.c         | 5 ++---
 include/hw/net/lan9118.h | 2 +-
 6 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 9be91ebeaa..2ccd6f8a76 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -113,8 +113,8 @@ static void kzm_init(MachineState *machine)
         alias_offset += ram[i].size;
     }
 
-    if (nd_table[0].used) {
-        lan9118_init(&nd_table[0], KZM_LAN9118_ADDR,
+    if (qemu_find_nic_info("lan9118", true, NULL)) {
+        lan9118_init(KZM_LAN9118_ADDR,
                      qdev_get_gpio_in(DEVICE(&s->soc.avic), 52));
     }
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index bd873cc5de..50919ee46d 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -456,7 +456,7 @@ static void mps2_common_init(MachineState *machine)
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    lan9118_init(&nd_table[0], mmc->ethernet_base,
+    lan9118_init(mmc->ethernet_base,
                  qdev_get_gpio_in(armv7m,
                                   mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index c6bd6e5961..9058f5b414 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -85,7 +85,6 @@ static void realview_init(MachineState *machine,
     SysBusDevice *busdev;
     qemu_irq pic[64];
     PCIBus *pci_bus = NULL;
-    NICInfo *nd;
     DriveInfo *dinfo;
     I2CBus *i2c;
     int n;
@@ -296,10 +295,9 @@ static void realview_init(MachineState *machine,
         }
     }
 
-    nd = qemu_find_nic_info(is_pb ? "lan9118" : "smc91c111", true, NULL);
-    if (nd) {
+    if (qemu_find_nic_info(is_pb ? "lan9118" : "smc91c111", true, NULL)) {
         if (is_pb) {
-            lan9118_init(nd, 0x4e000000, pic[28]);
+            lan9118_init(0x4e000000, pic[28]);
         } else {
             smc91c111_init(0x4e000000, pic[28]);
         }
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f1b45245d5..e5fb3ab1f9 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -679,8 +679,8 @@ static void vexpress_common_init(MachineState *machine)
     memory_region_add_subregion(sysmem, map[VE_VIDEORAM], &vms->vram);
 
     /* 0x4e000000 LAN9118 Ethernet */
-    if (nd_table[0].used) {
-        lan9118_init(&nd_table[0], map[VE_ETHERNET], pic[15]);
+    if (qemu_find_nic_info("lan9118", true, NULL)) {
+        lan9118_init(map[VE_ETHERNET], pic[15]);
     }
 
     /* VE_USB: not modelled */
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 598dd79e17..47ff25b441 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1408,14 +1408,13 @@ static void lan9118_register_types(void)
 
 /* Legacy helper function.  Should go away when machine config files are
    implemented.  */
-void lan9118_init(NICInfo *nd, uint32_t base, qemu_irq irq)
+void lan9118_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    qemu_check_nic_model(nd, "lan9118");
     dev = qdev_new(TYPE_LAN9118);
-    qdev_set_nic_properties(dev, nd);
+    qemu_configure_nic_device(dev, true, NULL);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
index 3d0c67f339..4bf9da7a63 100644
--- a/include/hw/net/lan9118.h
+++ b/include/hw/net/lan9118.h
@@ -15,6 +15,6 @@
 
 #define TYPE_LAN9118 "lan9118"
 
-void lan9118_init(NICInfo *, uint32_t, qemu_irq);
+void lan9118_init(uint32_t, qemu_irq);
 
 #endif
-- 
2.43.0


