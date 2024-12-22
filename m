Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4340E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdE-0000UU-Lm; Sun, 22 Dec 2024 08:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZp-00059l-QZ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:20 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZo-0000fJ-34
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=87tidG3WgbLhzqX0KNVuxmSDQyGLjTh7LZAY1x5QHEo=; b=NjvGDbtw/E9d1g4ecU7TEc2qIg
 1bno3h40OPW3l0i60ZCMMjsrYliXPb0+BDvmIIA9yTxAocaPcQecpb+M0ZqOkVdcWftWlBNjc7hiw
 Hi4TnpmRbveQs5lb0W2eoVlmwRMZsRns7Zq4TGLo5PicCiJhftOpePdPLdMsJFOtYr8kbOFBh5XSO
 khphBXUpoUwvi2LY8OkOH0kAT5ruQ3FUBVErPmGiPMEEWDu0JxY6su1QcCvTS1ozGxD5axkJrFKBN
 aKVsRdFnnaw1tTVnk+xfSPUr85nM1VmTQxplsW+kkLisLAHOfpDsxJwGJLaxIzb/BHxUoBXpFqn+N
 4o3Q5ptaXAVuAFu4tzvkOAJcybGs9tyuUiYpGFz/RMid1J4GU4jfJXP7qw8hXP/Gx/88zERhjz7m2
 Ykq/nrovMSBUSOSsJNlBBezOkP9AWPsF1fj/xyWWCwh4yMGNwdPXY4ZcX4LJrFxdKPS8EYq1Kw3Mg
 9sIzA6eadaBS17l4VcoQkdaaZ4fHCeagjNWNqUCj448AGaLqsfG6ik7fJ0Sj0emHIRNFXW3PeeOsp
 eyhGKn6U48dJwp2gLi7JWtCrlbZmSLGOq1g2GVCsFqDq9BW0L8Fz3gKdWm6q5GivHxAcpO6teKAKL
 /dbmiTxyeILPLJm3R/vNsWovuWtPdVt8mZEDv7mPU=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZD-0002L7-VI; Sun, 22 Dec 2024 13:00:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:48 +0000
Message-Id: <20241222130012.1013374-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 09/33] next-cube: move floppy disk MMIO to separate memory
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 61 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 60b4290238..9c0ddf91f8 100644
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


