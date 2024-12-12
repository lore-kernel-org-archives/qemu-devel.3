Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF74E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfK-0007EQ-GD; Thu, 12 Dec 2024 06:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhf8-00070i-8X
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:29 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhf6-0007G1-2E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0A1xmisst+l5VPDpo//EAdCgd09sPWuMKtgBEWjyBkk=; b=ezM2jBAFk6tr2fyUXhpis8FHqJ
 OQm5x2l9BjWNYK2iYCRwEHIsPka2Qk5h9pCs86HE29GW7diuGPAAJFiDYtN4z1AsTG5owywolLgqS
 hjrcquVoDjPhw1hWIUcc6zCxQ6mP/sD6gCnYvFgLQKPIOOOF3MulN48Y6OSdoB7kb8Zvq6arXBjUi
 OmJJ1IoyJ7vwM7uGD7QbLeWTce/T6moP0NJmeotrTxNa9dEUSHhNfvROgMYoL2zgbSx8ZfxUn/jrc
 2LEMYJOYcSbrKbZiDWZ13fdvAKIcfpAKRGerTvVmGsA1iYMCVHTeLsIUa3xa4C0Xbyo0GQ8FkjMRR
 P3jZnXsxU55WN3HczE6C8A1DEUQOUc6dfcD5RzpestY0cjAEwXMZ6I/0rRT7VeCZm62Say6D4HAIN
 a6LcsV+HuBr0JOs+fFMFgPNiAKrdKZmqGJ/r8UoN2DDbxSP4FtrZG6cducB6IDYJWEKopKmhBbQ93
 orCh33fVsRrGD8/I6ltGk1f6EOm3FkxS1JiMUwF7KzRJ/rR0h6kMPxO2lRi6fYO2aJbom6fH46/qI
 UvKqF9JFv1WGJw+uTRzgfPLc+JzhJ1zLy95CzwjV/kDZAEJ8dyC7bAl077eC4wUBKBvSnEJU3W01A
 Ux/Au6DCWGP9f4HrKqEuBYEH3VvCHFiRSDL/CaczY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheM-00070a-A0; Thu, 12 Dec 2024 11:46:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:59 +0000
Message-Id: <20241212114620.549285-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/34] next-cube: move en ethernet MMIO to separate memory
 region on next-pc device
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

Move the en ethernet MMIO accesses to a separate memory region on the next-pc
device instead of being part of the next.scr MMIO memory region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 48 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 861d90024a..76ecf86ed0 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -110,6 +110,7 @@ struct NeXTPC {
 
     MemoryRegion floppy_mem;
     MemoryRegion timer_mem;
+    MemoryRegion dummyen_mem;
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
 
@@ -372,11 +373,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    /* For now return dummy byte to allow the Ethernet test to timeout */
-    case 0x6000:
-        val = 0xff;
-        break;
-
     default:
         DPRINTF("BMAP Read @ 0x%x size %u\n", (unsigned int)addr, size);
         val = 0;
@@ -1012,6 +1008,38 @@ static const MemoryRegionOps next_timer_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_dummy_en_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    /* Do nothing */
+    return;
+}
+
+static uint64_t next_dummy_en_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+
+    switch (addr) {
+    case 0:
+        /* For now return dummy byte to allow the Ethernet test to timeout */
+        val = 0xff;
+        break;
+
+    default:
+        val = 0;
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps next_dummy_en_ops = {
+    .read = next_dummy_en_read,
+    .write = next_dummy_en_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void next_pc_reset(DeviceState *dev)
 {
     NeXTPC *s = NEXT_PC(dev);
@@ -1034,6 +1062,10 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     DeviceState *d;
 
+    /* en network (dummy) */
+    memory_region_add_subregion(&s->scrmem, 0x6000,
+                                &s->dummyen_mem);
+
     /* SCSI */
     sbd = SYS_BUS_DEVICE(&s->next_scsi);
     if (!sysbus_realize(sbd, errp)) {
@@ -1093,6 +1125,9 @@ static void next_pc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
 
+    memory_region_init_io(&s->dummyen_mem, OBJECT(s), &next_dummy_en_ops, s,
+                          "next.en", 0x20);
+
     object_initialize_child(obj, "next-scsi", &s->next_scsi, TYPE_NEXT_SCSI);
 
     memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
@@ -1239,9 +1274,6 @@ static void next_cube_init(MachineState *machine)
         }
     }
 
-    /* TODO: */
-    /* Network */
-
     /* DMA */
     memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
                           "next.dma", 0x5000);
-- 
2.39.5


