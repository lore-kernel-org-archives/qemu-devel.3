Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97086E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhez-0006yK-W2; Thu, 12 Dec 2024 06:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheu-0006vx-9y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhes-0007FD-PZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Aa6wAFBQdhcrVadKBysCQkd6OcuIY0Avs9BYh3oB4y4=; b=mxhZP/0TMdXn/ml3z1QIh6wHBw
 2dTBC4H2Zw2rsB2ZoyeK58a5F/Htix8Vwlikpi5YLFT+JqXbvFu+hzINEac+ZPmo7nkelfjqKjWcW
 Jv7NYwYzYCnkJlc2G4ROImnDfVSbEi0MjfIYGkWOiX+RZRCY1pyFgFl/LZaL6kI+dGObQQIwHMMuz
 SpJjjkPtwk6bxVnCLREomuyFsLt0wdw4kaSvUj1fUz/Vpr4iTdtJQvL/bzW4rSDTsu2Xx/4ox0ai8
 2R3A1OF369ciiYaXTVDc5oI560B4KbpBbhU7+wBDXg41Sh96QdR5s4Mt/LTuv4BujiG74S8NsrqJS
 +ixM/OkzODiaSQdqtiNXLdukWxWfZci6LQSPJTq/MKtU+YutHaJMQ1U60eWFqY0TOm18GisqdG3BP
 TS7lEHoztxbRytsQCLRkmrlRP6G3P8Sn5EkRGyynCfrm71fTZBjhXaJ8qanvFnikzjXeWofx4iWXz
 jed2a/EST2EPirQw+oGiFuShOgl3IviB7PmHAGLEIdmO9gM0bDyFyMoJbQA2SRnhEFp2Gf/NBFZbf
 2tppnaFy0jG1X1VU6sAoZM6NOurQxc0Xvmp143vr7W/VisGYXH93wiKpLMSlqFgIfG4TsjvfzmehY
 kArAMHTWJ06/P4wsoeximf9GoJdUAXbTuNP9/Dp6U=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheL-00070a-T4; Thu, 12 Dec 2024 11:46:34 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:58 +0000
Message-Id: <20241212114620.549285-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 12/34] next-cube: move timer MMIO to separate memory region
 on next-pc device
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

Move the timer MMIO accesses to a separate memory region on the next-pc device
instead of being part of the next.scr MMIO memory region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 63 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 20a0b073e1..861d90024a 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -109,6 +109,7 @@ struct NeXTPC {
     M68kCPU *cpu;
 
     MemoryRegion floppy_mem;
+    MemoryRegion timer_mem;
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
 
@@ -371,17 +372,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    /*
-     * These 4 registers are the hardware timer, not sure which register
-     * is the latch instead of data, but no problems so far.
-     *
-     * Hack: We need to have the LSB change consistently to make it work
-     */
-    case 0x1a000 ... 0x1a003:
-        val = extract32(clock(), (4 - (addr - 0x1a000) - size) << 3,
-                        size << 3);
-        break;
-
     /* For now return dummy byte to allow the Ethernet test to timeout */
     case 0x6000:
         val = 0xff;
@@ -400,8 +390,6 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
     switch (addr) {
-    /* Hardware timer latch - not implemented yet */
-    case 0x1a000:
     default:
         DPRINTF("BMAP Write @ 0x%x with 0x%"PRIx64 " size %u\n",
                 (unsigned int)addr, val, size);
@@ -980,6 +968,50 @@ static const MemoryRegionOps next_floppy_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_timer_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    switch (addr) {
+    case 0 ... 3:
+        /* Hardware timer latch - not implemented yet */
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t next_timer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+
+    switch (addr) {
+    case 0 ... 3:
+        /*
+         * These 4 registers are the hardware timer, not sure which register
+         * is the latch instead of data, but no problems so far.
+         *
+         * Hack: We need to have the LSB change consistently to make it work
+         */
+        val = extract32(clock(), (4 - addr - size) << 3,
+                        size << 3);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps next_timer_ops = {
+    .read = next_timer_read,
+    .write = next_timer_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void next_pc_reset(DeviceState *dev)
 {
     NeXTPC *s = NEXT_PC(dev);
@@ -1042,6 +1074,8 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->scrmem, 0x18000,
                                 sysbus_mmio_get_region(sbd, 0));
 
+    /* Timer */
+    memory_region_add_subregion(&s->scrmem, 0x1a000, &s->timer_mem);
 }
 
 static void next_pc_init(Object *obj)
@@ -1065,6 +1099,9 @@ static void next_pc_init(Object *obj)
                           "next.floppy", 4);
 
     object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
+
+    memory_region_init_io(&s->timer_mem, OBJECT(s), &next_timer_ops, s,
+                          "next.timer", 4);
 }
 
 /*
-- 
2.39.5


