Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297C5E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLheX-0006rP-2I; Thu, 12 Dec 2024 06:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheU-0006qn-1c
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheR-0007Az-QW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DKzEpPmI0MZmSbnedA2smid+AevzVEfve3PG/SI1rcg=; b=G6H9Gk6S/NrKmKzdNMHbbZTKI1
 d21bmXcF3JxYAxWwwo53ZNBhPvfuO3KDtV+Hlf9ydcOfJq56d2baJOjF88gAsBSROa740bdCiw+jd
 XAJ9lSAib7Mq4T0PwdX0IrHSaWxpSnOQI4WnCp1kCexx5ayZaeWxOIzpBxZg9whAeOwecdYeif98y
 YVl864Q6wdPRMDNfcmjwa+1RPJG7ldWYYLVH8+KVurcI35hP9GAlkQoRGhwEEbQffilb4b9mO3zTV
 JN/v0Ftwh8UtyTy0suPog58BBKeHaZhMDJAzEs03FLWGRlT71kFSCZZdLOnN3tR6l7hxc1Ewl9u+w
 AjU/DBEJ2RiXvdX6a+Y8S/H+gUuhgMK3i8SAtzvVr1fA76vvM0xaemnUA82aa+xgFPkiolHO9kDPW
 uN4+xjygP3PFVxSpIhK/k1hjnVbZZN6orB2E/qPSrDpVx5FD0Vv/1mTJzVhHJk/eK5plNTSBM18Qh
 pYxFOf/HNbF0y4l4X6oGfAG/dE6vkelb0MdDAqNHVGM1X6NX/+yGCs2lPa+CR/eV/TYnXaimWA1Fm
 fs9lguqPyhrrJGUe4xILC7Nj+9r+h5KZOGOKok0eZfnWsZjRIVt1oYLpYdvtLuUPpHt5fTYMmwxKl
 Cb92kZlvsiR6Th/bteB4DvMpKyyyXX9PADrobnOGE=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhdr-00070a-CN; Thu, 12 Dec 2024 11:46:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:48 +0000
Message-Id: <20241212114620.549285-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 02/34] next-cube: remove overlap between next.dma and
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
after the next.dma memory region. Increase the address offsets in
next_mmio_read() and next_mmio_write(), and reduce the size of the next.mmio
memory region accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/next-cube.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0418fbc8aa..550e7f0b0a 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    case 0x7000:
+    case 0x2000:    /* 0x2005000 */
         /* DPRINTF("Read INT status: %x\n", s->int_status); */
         val = s->int_status;
         break;
 
-    case 0x7800:
+    case 0x2800:    /* 0x2007800 */
         DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
         val = s->int_mask;
         break;
 
-    case 0xc000 ... 0xc003:
-        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+    case 0x7000 ... 0x7003:    /* 0x200c000 */
+        val = extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
                         size << 3);
         break;
 
-    case 0xd000 ... 0xd003:
-        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+    case 0x8000 ... 0x8003:    /* 0x200d000 */
+        val = extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
                         size << 3);
         break;
 
@@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     NeXTPC *s = NEXT_PC(opaque);
 
     switch (addr) {
-    case 0x7000:
+    case 0x2000:    /* 0x2005000 */
         DPRINTF("INT Status old: %x new: %x\n", s->int_status,
                 (unsigned int)val);
         s->int_status = val;
         break;
 
-    case 0x7800:
+    case 0x2800:    /* 0x2007800 */
         DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, (unsigned int)val);
         s->int_mask  = val;
         break;
 
-    case 0xc000 ... 0xc003:
+    case 0x7000 ... 0x7003:    /* 0x200c000 */
         DPRINTF("SCR1 Write: %x\n", (unsigned int)val);
-        s->scr1 = deposit32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+        s->scr1 = deposit32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
                             size << 3, val);
         break;
 
-    case 0xd000 ... 0xd003:
-        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+    case 0x8000 ... 0x8003:    /* 0x200d000 */
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


