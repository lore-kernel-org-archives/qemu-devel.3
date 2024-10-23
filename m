Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA20ED2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XD3-0007on-MA; Wed, 23 Oct 2024 04:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD2-0007oS-MZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD1-0000JX-7l
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/89sOURaQGbKq4a9OFoHv7MwAXwRzgUgk1pwsCvXNkk=; b=MTdT6W0j8R8FEY3L4FFfj6pWhZ
 Q0/Iq9ZL2LqLkrET2OjquQOs/eAVwq8eT4iL8UEGKtKC4bddQLmi5LGUrAPSSPrmZKQu2F0ec+iOQ
 2SKBQQhcr9H69kjMW4zmJDqEbpw7fbNCUbxaIquBwMiTeBjEYsjPQ3RlDnBn9m0TUajlw5dp4sQ7U
 xUfvzIGE5kaaVUr5rwzHaqkRxre1cb4eB+r7Sb8H2TTNFxMQMmYTkQBopPa6aZixVZPQ+d5BMBBBU
 Wlsarefc9UvsAoGmhlOcwJ58GOY9pLDXw9lEaEULXzmUo/t0eMLUK9pq1D7y+vDKL/MicgryB2mgx
 Tsv5+CU52qQRR+7yaB/puagLDqhRbMtPSZ1DYiSXnIfRkxgFrHcziDBXAChxZ7OQyC1hjmqK9s2IP
 YVaZiS13x/DNrpXbyR2HyAzQCfjHiJROPOiMPrv7BJFSnSQLpni+y6NajlNRsIa6h4IU7bLWqw0tG
 ZVuo4+Kk2E9/+1FZATwGx0RKOy1NRlXTGEmk332fI9yB4ZKeXpairAZpr7nG7A8L2z9smzlIV4qbL
 mbAx2NF0mXkJbt522hIL16JrwJEqaZGg06/Lsyy1LwCRPlU1EIZy1DQCaeANvIv9doxssNuU20EDf
 Kf+dI8j7+Jkch4bDN71CXcbCL+9LM49fhpqXuIqxk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCk-0008EL-Lp; Wed, 23 Oct 2024 09:58:59 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:19 +0100
Message-Id: <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/36] next-cube: remove overlap between next.dma and
 next.mmio memory regions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Change the start of the next.mmio memory region so that it follows on directly
after the next.dma memory region, adjusting the address offsets in
next_mmio_read() and next_mmio_write() accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 4e8e55a8bd..e1d94c1ce0 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    case 0x7000:
+    case 0x2000:
         /* DPRINTF("Read INT status: %x\n", s->int_status); */
         val = s->int_status;
         break;
 
-    case 0x7800:
+    case 0x2800:
         DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
         val = s->int_mask;
         break;
 
-    case 0xc000 ... 0xc003:
-        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+    case 0x7000 ... 0x7003:
+        val = extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
                         size << 3);
         break;
 
-    case 0xd000 ... 0xd003:
-        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+    case 0x8000 ... 0x8003:
+        val = extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
                         size << 3);
         break;
 
@@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     NeXTPC *s = NEXT_PC(opaque);
 
     switch (addr) {
-    case 0x7000:
+    case 0x2000:
         DPRINTF("INT Status old: %x new: %x\n", s->int_status,
                 (unsigned int)val);
         s->int_status = val;
         break;
 
-    case 0x7800:
+    case 0x2800:
         DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, (unsigned int)val);
         s->int_mask  = val;
         break;
 
-    case 0xc000 ... 0xc003:
+    case 0x7000 ... 0x7003:
         DPRINTF("SCR1 Write: %x\n", (unsigned int)val);
-        s->scr1 = deposit32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+        s->scr1 = deposit32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
                             size << 3, val);
         break;
 
-    case 0xd000 ... 0xd003:
-        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+    case 0x8000 ... 0x8003:
+        s->scr2 = deposit32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
                             size << 3, val);
         next_scr2_led_update(s);
         next_scr2_rtc_update(s);
@@ -897,7 +897,7 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
-                          "next.mmio", 0xd0000);
+                          "next.mmio", 0x9000);
     memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
                           "next.scr", 0x20000);
     sysbus_init_mmio(sbd, &s->mmiomem);
@@ -1000,7 +1000,7 @@ static void next_cube_init(MachineState *machine)
     sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
 
     /* MMIO */
-    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02000000);
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02005000);
 
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
-- 
2.39.5


