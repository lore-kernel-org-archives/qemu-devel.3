Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8A7E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLheo-0006u3-Qu; Thu, 12 Dec 2024 06:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheh-0006t3-4c
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:56 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhef-0007Cx-1m
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nzKg2LM80xANrmPr2xZWrjICGi73Lkfo4WMb51mfQ44=; b=XJs9keE2+g0wmhQE3oX09nj6nQ
 PUj0jtOeNIRPJkYaTDvgfyiRUkQZBgDIShtcQaLgCsgZAT25sT1PrKTho/eXbD0OaeVN1DFYH/ssJ
 t0DgJRFvutteQ+iLTlSk2xSxEWj7mYh2hxn2ix6bOc66mT9V4I2pS5cwh3XLk5UFQItR6XQQswDFg
 fNr2dHbr3hHELb59v5K7XfgI34VNAxEAUFhNpVsEwwcvdven51+lapiECPoznsCwnzw5jiFkjgsG+
 7U+r4ElYGrFSOnZU0cnQ0/dOL2oZUSGaD/ren8QOM+JVZSDd5Hm8BSWdOIeE+9krmQbMLv0xd6rOO
 O2zMobYP7G6QDHDQqChgXLdmqWNhYsUIayH6vwoWo1Iqiw7YQWCS7xWo18WZJdtN8n1nqpF7o+LxB
 HwJpnEIF/IhT+o2s0Osup0Q5vC5+k+4bECVQ6SkgC3i5eNosq7A3etCENL4V5vZo78NDFyC/Kxt2P
 4B9kfrExDNY+8MpG/fXkyqGmeLcjX71Uz4PbjTqDbOL74k8IEQNudfHQdyVGguc1FbgIkRbjxu+Ub
 40O1cSdqxLionYjZpLYM6XbzHpItChb5EYkZF049Z3iYHNDnhIovUK72zEaORB/iZLXQhA9kqJw4N
 JASanaU31jTSTbleLWqiyzFIa+qQpqL8PHAGd2u3A=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhe8-00070a-CJ; Thu, 12 Dec 2024 11:46:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:53 +0000
Message-Id: <20241212114620.549285-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 07/34] next-cube: move SCSI CSRs from next-pc to the
 next-scsi device
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
Contoller) which is now modelled as a separate QEMU device. Add a new memory
region subregion to contain the SCSI CSRs that simply store and retrieve the
register values.

Add a new VMStateDescription for the next-scsi device to enable the SCSI CSRs
to be migrated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 88 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 1321c04520..928740b281 100644
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


