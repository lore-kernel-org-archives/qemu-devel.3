Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F68C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhO-0006XN-SE; Sun, 29 Dec 2024 02:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhJ-0006WQ-GC
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:49 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhH-00028t-Tv
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:49 -0500
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso1222658066b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457206; x=1736062006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfP72JC2fK1YTGLvj0y9Jxg1LY7+nBroE5JdeEJSXHY=;
 b=rEMNvugIzmmDPO1swsaIlwOtimn+vJNvfME3E2MW5/hAc9zQE5oPEgQ3jCB+cfSw0T
 e3paRW/FJlhYrUGkmSNjD8MV64FKfJO/x2srn/O1emHL0SFr70Tl9YQhrSXC+4l3TgpJ
 Q6WrJYkb4A6voeuCJkeEd2ZadiDz2bb9V79O6kbmr+e+8sWTx3buCjcCV7StYDwePx3G
 36UaNubHK2OGTphEXnjtYNkmkXkiiVVDi4wBnunpFE34Uab2QIAHk642jJsacbNyK+5x
 7J7ufDX8l4l6at++IMCIErx3NS6rsfg9UiQKO5boPIJcRjXrd2/DfzWe1o/167c7NFwS
 HR1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKN4q1/P5U56wIfQMBqHDorbZqsm5nRkUk8vFVrxN+y0dzuMStxwCy15se2AWLPsrhUknS9AqteCvh@nongnu.org
X-Gm-Message-State: AOJu0YxioDn5K6o9mD1LeCOegXmlYf4xyDWUnebEfqDn7+xu/BMSKcLR
 D4E//uv6cBXXWHThYlYNdFOy2AlufGdCG0H5J1DOnrJa6nJSFUfrdNqSFQ==
X-Gm-Gg: ASbGncsciiYrClqPdAQBal195E52ZlxTJ60YdzgZAFGbKTU46X4v6fl3bvJyT91vMRm
 INEas4wKZ6G4CDTOosDf6RZjM8+VGWzPi1SCHZXqYUZ7Y+UWuESZZFvEtTI0tMGLV22AKXvNAOH
 xP1EQS4mbmf/McRslmzXDX365PqgslQHCeGceC/kEDqTJiqd7AXdIk4FQXLlIhzJm3p7mXNsMIT
 awJDFnoj/D67cY599VNRVDhdG0oiX9WK20WA1jPbGZhJSsK3YLi5HdfLYxk/VQ6U0bVQkcGV2GL
 vj4=
X-Google-Smtp-Source: AGHT+IH2JPQs42Wu07z9V64ugqJFVDsjF8q/bTncP5jWTxr2ta1t6dhxugP/jm26ZVf01F+/kCx6FA==
X-Received: by 2002:a17:907:d25:b0:aa6:93c4:c68c with SMTP id
 a640c23a62f3a-aac334f3050mr2996132066b.41.1735457206143; 
 Sat, 28 Dec 2024 23:26:46 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:45 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 09/35] next-cube: move SCSI CSRs from next-pc to the next-scsi
 device
Date: Sun, 29 Dec 2024 08:25:00 +0100
Message-ID: <20241229072526.166555-10-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The SCSI CSRs are located within the SCSI subsystem of the NeXT PC (Peripheral
Contoller) which is now modelled as a separate QEMU device. Add a new memory
region subregion to contain the SCSI CSRs that simply store and retrieve the
register values.

Add a new VMStateDescription for the next-scsi device to enable the SCSI CSRs
to be migrated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-8-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 88 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ce147fa9af..687d1b3cb0 100644
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
@@ -999,8 +1069,8 @@ static const VMStateDescription next_rtc_vmstate = {
 
 static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
@@ -1008,8 +1078,6 @@ static const VMStateDescription next_pc_vmstate = {
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
         VMSTATE_UINT32(led, NeXTPC),
-        VMSTATE_UINT8(scsi_csr_1, NeXTPC),
-        VMSTATE_UINT8(scsi_csr_2, NeXTPC),
         VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
         VMSTATE_END_OF_LIST()
     },
-- 
2.47.1


