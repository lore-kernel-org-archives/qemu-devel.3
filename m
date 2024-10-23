Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1300AD2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDX-0000TO-35; Wed, 23 Oct 2024 04:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDV-0000OE-0s
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:45 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDT-0000Lr-Es
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=GU4QjM+2048QbLKA96q1WvPb15JSkUQ7o03Nxy+uq+A=; b=0g+3883WDXBgMbjTT9dTS7jijw
 VJE3OkrafUAWyiYBPiHbzQ7OH0xTRyciI2citarwR1Y0QnxRCk6RTFa2BdPY6iHPuy479vWFzgg1B
 60I9DSy0W/Ff4wOdSh4Va46jGS1vqsQWgu/nHA0kLlD6TBLSXW+s9JIIXqNfx5z1q7gNy4uu18h2n
 qB8n0rj2cXp2HLvvnlQye6huo1bKQoLXTK27ZIM6Nyo+ulAybix3gdmmGh8VrJ3IA9CCk5a6+M+VB
 Xf04HOYNwo1kBxnLE+Ap7bX0c1q1l9eSBarzipoegzolnIHkFd4ldBBWtqSHq/VkAHt0/NIbxIKEW
 qU4KxMQvvIL6CxWiyRltf9fs+sUwc0s55a5Hk1bWmyjxp99qLx6E/18yEPCfQoRpylSsXjj1b4Xlh
 2lt5fOfVPCAe3PmcD2MYefwWODzyfSoHiSWtnoO/ORzIU7OMvuZq7AFERRB6B40AfN71J51E7/iDm
 iHNAXVGQbK05tn+jVQIW7GxEysKdB4qPnFrfufgylxET7eO2QpbRmSZZElm4HRRw9qdE8FpZ1Fy4k
 IQNQYVzQcXx54iYr9kwnypyZ7gochLzRzt0fpbx6qBlmiuFPQzs0rmTJdk8zNXvAFBBpHGJo8dznE
 zd1fW9wKYO1Uqa+Kf1iV9w/s1ikF8D6dMjb8IbXd0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD9-0008EL-4n; Wed, 23 Oct 2024 09:59:27 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:27 +0100
Message-Id: <20241023085852.1061031-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/36] next-cube: move floppy disk MMIO to separate memory
 region in next-pc
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

The dummy floppy disk device is part of the next-pc device, and not related to
the NeXTCube SCRs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 61 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 22da777006..f1a50ec737 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -108,6 +108,7 @@ struct NeXTPC {
 
     M68kCPU *cpu;
 
+    MemoryRegion floppy_mem;
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
 
@@ -368,11 +369,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    case 0x14108:
-        DPRINTF("FD read @ %x\n", (unsigned int)addr);
-        val = 0x40 | 0x04 | 0x2 | 0x1;
-        break;
-
     /*
      * These 4 registers are the hardware timer, not sure which register
      * is the latch instead of data, but no problems so far.
@@ -402,13 +398,6 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
     switch (addr) {
-    case 0x14108:
-        DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
-        if (val == 0x0) {
-            /* qemu_irq_raise(s->fd_irq[0]); */
-        }
-        break;
-
     /* Hardware timer latch - not implemented yet */
     case 0x1a000:
     default:
@@ -948,6 +937,47 @@ static const TypeInfo next_scsi_info = {
     .class_init = next_scsi_class_init,
 };
 
+static void next_floppy_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    switch (addr) {
+    case 0:
+        DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
+        if (val == 0x0) {
+            /* qemu_irq_raise(s->fd_irq[0]); */
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t next_floppy_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+
+    switch (addr) {
+    case 0:
+        DPRINTF("FD read @ %x\n", (unsigned int)addr);
+        val = 0x40 | 0x04 | 0x2 | 0x1;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps next_floppy_ops = {
+    .read = next_floppy_read,
+    .write = next_floppy_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void next_escc_init(DeviceState *pcdev)
 {
     DeviceState *dev;
@@ -1006,6 +1036,10 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
 
     s->scsi_reset = qdev_get_gpio_in(d, 0);
     s->scsi_dma = qdev_get_gpio_in(d, 1);
+
+    /* Floppy */
+    memory_region_add_subregion(&s->scrmem, 0x14108,
+                                &s->floppy_mem);
 }
 
 static void next_pc_init(Object *obj)
@@ -1024,6 +1058,9 @@ static void next_pc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->scrmem);
 
     object_initialize_child(obj, "next-scsi", &s->next_scsi, TYPE_NEXT_SCSI);
+
+    memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
+                          "next.floppy", 4);
 }
 
 /*
-- 
2.39.5


