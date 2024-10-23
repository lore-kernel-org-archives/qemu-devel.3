Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72951D2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDN-0008DQ-7v; Wed, 23 Oct 2024 04:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDL-00086g-V6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:35 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDK-0000Kz-8G
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lovQXUFZq/8wE1+TqDLG4yC4PA1aDuChFoBu/D3JZ8Y=; b=tNl9xBpUd5PBYnQ8m6CUFd2YuJ
 VO2xuMlYSMrIMgDyYPzYrg9AzYE+0zHD8PylDo70zSzafY4OR0bflT/K50sKaZKxWpjb4M9I9WxiU
 4mBsSp+Jj7yG6SIynmqxaCZvkrK4AtrrnABXAJ1Ss8jTykz+nT9gNCO2SjG0zQddAAEFws8Eq3w1V
 h7MapO6I/pLZl2rfHRChvROwL052RHUfX03WMuM4PIg++Ml2AMOItHLbbK4nxaxkqF7JgP5XFs0iA
 noIV7Ek0ww+DwZD34pKv2UyWV9/hdhRKOebXL2FHgXbnEH6G4kGCErYCSKa13F/Uua7oXdGoV9Som
 H0U1+/FW4F4VZ4VotnfD37X/7E8SJvVbQov5l+l2I4xMJhdodouhsdAY/CLBtXVes7YpwzhiefN6a
 Btl80BHCrIrVgy94WU7lgaR/QOWRAg/iQ5JM+UTU8sw8V3kCUENPE5FdZkA8Ti57QM7/QOrZCwQeh
 m2q6D1UL+efojvmDDBsXyBHBRp6dt7aJfre00xIwXXkeOr4/g3DpcYehFaBJgho/yMk6p+B581Ul+
 qCQIJ7ZozyqT3qKSW6iQflw4K3yXnZHDYJtGIaj8mL1x93cdP0iiH7chBVyxW4gCrE+bpUiLeIY+q
 R0e+az1cjlJIa7OMLnecCis1hLQa1UtSawwXRMGI0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD0-0008EL-4Z; Wed, 23 Oct 2024 09:59:18 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:25 +0100
Message-Id: <20241023085852.1061031-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 09/36] next-cube: move SCSI CSRs from next-pc to the next-scsi
 device
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

The SCSI CSRs are located within the SCSI subsystem of the NeXT PC (Peripheral
Contoller) which is now modelled as a separate QEMU device.

Add a new VMStateDescription for the next-scsi device to enable the SCSI CSRs
to be migrated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 88 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 266f57ac63..32466a425f 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -93,6 +93,10 @@ struct NeXTSCSI {
     MemoryRegion scsi_mem;
 
     SysBusESPState sysbus_esp;
+
+    MemoryRegion scsi_csr_mem;
+    uint8_t scsi_csr_1;
+    uint8_t scsi_csr_2;
 };
 
 #define TYPE_NEXT_PC "next-pc"
@@ -115,8 +119,6 @@ struct NeXTPC {
     uint32_t led;
 
     NeXTSCSI next_scsi;
-    uint8_t scsi_csr_1;
-    uint8_t scsi_csr_2;
 
     qemu_irq scsi_reset;
     qemu_irq scsi_dma;
@@ -364,6 +366,7 @@ static const MemoryRegionOps next_mmio_ops = {
 static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
 {
     NeXTPC *s = NEXT_PC(opaque);
+    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
     uint64_t val;
 
     switch (addr) {
@@ -373,12 +376,12 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case 0x14020:
-        DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
-        val = s->scsi_csr_1;
+        DPRINTF("SCSI 4020  STATUS READ %X\n", ns->scsi_csr_1);
+        val = ns->scsi_csr_1;
         break;
 
     case 0x14021:
-        DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
+        DPRINTF("SCSI 4021 STATUS READ %X\n", ns->scsi_csr_2);
         val = 0x40;
         break;
 
@@ -411,6 +414,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
     NeXTPC *s = NEXT_PC(opaque);
+    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
 
     switch (addr) {
     case 0x14108:
@@ -445,7 +449,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
             DPRINTF("SCSICSR Reset\n");
             /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
             qemu_irq_raise(s->scsi_reset);
-            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
+            ns->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
             qemu_irq_lower(s->scsi_reset);
         }
         if (val & SCSICSR_DMADIR) {
@@ -838,6 +842,54 @@ static void nextscsi_write(void *opaque, uint8_t *buf, int size)
     nextdma_write(opaque, buf, size, NEXTDMA_SCSI);
 }
 
+static void next_scsi_csr_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    NeXTSCSI *s = NEXT_SCSI(opaque);
+
+    switch (addr) {
+    case 0:
+        s->scsi_csr_1 = val;
+        break;
+
+    case 1:
+        s->scsi_csr_2 = val;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t next_scsi_csr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    NeXTSCSI *s = NEXT_SCSI(opaque);
+    uint64_t val;
+
+    switch (addr) {
+    case 0:
+        val = s->scsi_csr_1;
+        break;
+
+    case 1:
+        val = s->scsi_csr_2;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps next_scsi_csr_ops = {
+    .read = next_scsi_csr_read,
+    .write = next_scsi_csr_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 1,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void next_scsi_init(Object *obj)
 {
     NeXTSCSI *s = NEXT_SCSI(obj);
@@ -845,6 +897,9 @@ static void next_scsi_init(Object *obj)
 
     object_initialize_child(obj, "esp", &s->sysbus_esp, TYPE_SYSBUS_ESP);
 
+    memory_region_init_io(&s->scsi_csr_mem, obj, &next_scsi_csr_ops,
+                          s, "csrs", 2);
+
     memory_region_init(&s->scsi_mem, obj, "next.scsi", 0x40);
     sysbus_init_mmio(sbd, &s->scsi_mem);
 }
@@ -874,15 +929,30 @@ static void next_scsi_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->scsi_mem, 0x0,
                                 sysbus_mmio_get_region(sbd, 0));
 
+    /* SCSI CSRs */
+    memory_region_add_subregion(&s->scsi_mem, 0x20, &s->scsi_csr_mem);
+
     scsi_bus_legacy_handle_cmdline(&s->sysbus_esp.esp.bus);
 }
 
+static const VMStateDescription next_scsi_vmstate = {
+    .name = "next-scsi",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(scsi_csr_1, NeXTSCSI),
+        VMSTATE_UINT8(scsi_csr_2, NeXTSCSI),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static void next_scsi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "NeXT SCSI Controller";
     dc->realize = next_scsi_realize;
+    dc->vmsd = &next_scsi_vmstate;
 }
 
 static const TypeInfo next_scsi_info = {
@@ -1000,8 +1070,8 @@ static const VMStateDescription next_rtc_vmstate = {
 
 static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
@@ -1009,8 +1079,6 @@ static const VMStateDescription next_pc_vmstate = {
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
         VMSTATE_UINT32(led, NeXTPC),
-        VMSTATE_UINT8(scsi_csr_1, NeXTPC),
-        VMSTATE_UINT8(scsi_csr_2, NeXTPC),
         VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
         VMSTATE_END_OF_LIST()
     },
-- 
2.39.5


