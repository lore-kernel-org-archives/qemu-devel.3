Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D832E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdR-00025C-LB; Sun, 22 Dec 2024 08:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaz-0006Hj-SG
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:16 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLay-0000rT-BT
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=32Hsyr/YReiq//ufLSelktznFqNXWwpKnH9enfCHALA=; b=odNkuqA3wB3H8xnx2AqUbf6nTi
 CnmhCszISkyBTRfNjidConCosI0BpdgDkYUiRsYkbbbL8fGU3sDi5LmKf5A3vqka9nSqbYNjKDegS
 P8cFWBegB5tJfQxkrFkwZtVGgx5D0jJimPUPPRUyyUMMde2imMdsAlxIdfVW9xJnAIrFa8IedxpOJ
 eslZmfD5LkPFH/8IucDDixfY05zfyB7bPTo5ZMADxKU+ejkeM8T+lpOVcT0/XjuEFeUGFRC/xDec5
 MZOlxBVd5h7Jb0N8eYqwQGOQ68CYZ1E1ZJyZ4017TbOB65psEwVPuh1oi03ctbc7l0oa9R48UHAJC
 ioJW4SzEU5yHhE4iCH4fMHcAvGtPeSMRWClMmFLbs1hNYiQL3bTHwQ+20HgNCyObYKYb1WHN60XjJ
 kYgG9P76ys3/FcEqu+X04BSeVfruQssH8W4ZlfR6DaMFZOvXD/oCxnXkBSTbR/qe2q2lGVk0aFDR8
 PqEbH6sWtgmZnnHPoucd5nsXk+nT59sBSmcHjRmwCIZ+E9zW1GHSNhj/13d+A0aDgw1+Rv87HYyqa
 0i12k5cOy70Fk0ISa3ii5PmZQ/YqKG/Q6XO7OK7E15hlMh1HKz9P1AI+A2wrram58Q85L3MK7fjnG
 /MMFvXyql/6ZE+fkwQqa9DKIhL6VSgVfBlSQZQxVA=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaB-0002L7-1y; Sun, 22 Dec 2024 13:01:23 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:04 +0000
Message-Id: <20241222130012.1013374-26-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 25/33] next-cube: QOMify NeXTRTC
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

This is to allow the RTC functionality to be maintained within its own separate
device rather than as part of the next-pc device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 71 +++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9daf2207a5..075c525d24 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -42,7 +42,13 @@
 #define RAM_SIZE    0x4000000
 #define ROM_FILE    "Rev_2.5_v66.bin"
 
-typedef struct NeXTRTC {
+
+#define TYPE_NEXT_RTC "next-rtc"
+OBJECT_DECLARE_SIMPLE_TYPE(NeXTRTC, NEXT_RTC)
+
+struct NeXTRTC {
+    SysBusDevice parent_obj;
+
     int8_t phase;
     uint8_t ram[32];
     uint8_t command;
@@ -50,7 +56,7 @@ typedef struct NeXTRTC {
     uint8_t status;
     uint8_t control;
     uint8_t retval;
-} NeXTRTC;
+};
 
 #define TYPE_NEXT_SCSI "next-scsi"
 OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
@@ -1012,6 +1018,37 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static const VMStateDescription next_rtc_vmstate = {
+    .name = "next-rtc",
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT8(phase, NeXTRTC),
+        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
+        VMSTATE_UINT8(command, NeXTRTC),
+        VMSTATE_UINT8(value, NeXTRTC),
+        VMSTATE_UINT8(status, NeXTRTC),
+        VMSTATE_UINT8(control, NeXTRTC),
+        VMSTATE_UINT8(retval, NeXTRTC),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void next_rtc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NeXT RTC";
+    dc->vmsd = &next_rtc_vmstate;
+}
+
+static const TypeInfo next_rtc_info = {
+    .name = TYPE_NEXT_RTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NeXTRTC),
+    .class_init = next_rtc_class_init,
+};
+
 static void next_pc_rtc_data_in_irq(void *opaque, int n, int level)
 {
     NeXTPC *s = NEXT_PC(opaque);
@@ -1078,6 +1115,12 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
     sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
+
+    /* RTC */
+    d = DEVICE(&s->rtc);
+    if (!sysbus_realize(SYS_BUS_DEVICE(d), errp)) {
+        return;
+    }
 }
 
 static void next_pc_init(Object *obj)
@@ -1111,6 +1154,8 @@ static void next_pc_init(Object *obj)
                           "next.timer", 4);
     sysbus_init_mmio(sbd, &s->timer_mem);
 
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_NEXT_RTC);
+
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
                             "pc-rtc-data-in", 1);
@@ -1128,26 +1173,10 @@ static const Property next_pc_properties[] = {
     DEFINE_PROP_LINK("cpu", NeXTPC, cpu, TYPE_M68K_CPU, M68kCPU *),
 };
 
-static const VMStateDescription next_rtc_vmstate = {
-    .name = "next-rtc",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_INT8(phase, NeXTRTC),
-        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
-        VMSTATE_UINT8(command, NeXTRTC),
-        VMSTATE_UINT8(value, NeXTRTC),
-        VMSTATE_UINT8(status, NeXTRTC),
-        VMSTATE_UINT8(control, NeXTRTC),
-        VMSTATE_UINT8(retval, NeXTRTC),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
 static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
@@ -1155,7 +1184,6 @@ static const VMStateDescription next_pc_vmstate = {
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
         VMSTATE_UINT32(led, NeXTPC),
-        VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NeXTRTC),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1304,6 +1332,7 @@ static void next_register_type(void)
     type_register_static(&next_typeinfo);
     type_register_static(&next_pc_info);
     type_register_static(&next_scsi_info);
+    type_register_static(&next_rtc_info);
 }
 
 type_init(next_register_type)
-- 
2.39.5


