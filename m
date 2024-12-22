Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B0FE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLbc-0006qP-8w; Sun, 22 Dec 2024 08:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLa4-0005IA-RC
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLa0-0000hM-De
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nomOuLrjdVFIkt/fJcG/uMEUJg2nP4CQC3YSh6qawQQ=; b=S2vLibKy5e43gldddtx2CNYac0
 5eIUhAufdGoJHjpYdIGgs4HPbmGhMv/ZSiUamnQSlJeYmeKTgCrV3A8SNYXY8oKEl3laVzECdwjkY
 qZZpoq/bcxTYc/Wq1Zvon0mbwZVnoqz3lM1r+FLV2cSbocJE5nyjrZCTtPGDMHM7fbplgMm9gr4LE
 vcFwQuXjMcfy33NynmZvwCe43DLUXBxyGvLK/eI66BLqlnmLpPAwHwPYMvczX5KyZ90VrWNtYaNnw
 5rQhhDaHEgDRU79XeiU+HjHn9VhJlIJpQx0YIs1tenEYeV7/dFijR4IDbF+y6vApxZPrfIjgaHaNE
 V+bbtoyaDQvlfOBilUGZ+FqzG4FE1WSwB440B0IbSR32vQA3EEp2VgyqgpDlyFLQXpis1Gjs0f2Gv
 hK9UThbSoxq9aucxLmy9lMnqNtyjd3H15coLW8L95ZnAMAqzcaLayaZ7mMWCq0dyTfAMsz3aLai64
 kqNzoZ6eECwahm8ST4BAfHtQ2K+p8j3lJ2JSyRBhY9cvDS25Uoqvon9aT5CyBvRVEkRjybamA8Qv2
 F8tEUWmTMibI4+w/sqs1fF0J3c26NsI4NesoGsmijnYPVG/bc9GugMXoWrhNeyOWcC+hlqvcD9cTr
 FOwtZD2UwsBXf0RUWjkt+OhCWbInb/JlYXFsJawVA=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZN-0002L7-60; Sun, 22 Dec 2024 13:00:33 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:51 +0000
Message-Id: <20241222130012.1013374-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 12/33] next-cube: move timer MMIO to separate memory region
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/next-cube.c | 63 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 49dff14fb9..a84106219f 100644
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


