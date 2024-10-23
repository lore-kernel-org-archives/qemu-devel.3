Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC33DD2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEh-0004Fs-DU; Wed, 23 Oct 2024 05:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEd-0003he-Ez
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEb-0000dY-BS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NhCZyCFErLCszre0CM34JVp5DnPOhwrf2z4MZ65ATyc=; b=OFZocslB+2ocVCIMgPZhYV/CYS
 1PEm2st68Wr84tAooVDE+VuWavkXSRs1eAjCysnP5ObFC5AKa7hbDPZwprFGKarG7Lw3eNetOHCfN
 hbdroG5+gsU+QA+Q0RjZhhSN7frdhN+STFu/poi33IJZZM4gabrgtM2kbwouGRuQHDDPyii27tXr9
 19KzmT8brBuyEDVIwZVrvZmFaZKTqSWE9l9sdb+icAtXpwNLvTmNLAG7jal0v04ZZOcH8V74NuWcJ
 ysXZ0sK8Gql/+ImZKETaBGnot501o94V7es/gX8b6UOyAfKRRE04ekIqxD/Jp/0RaMUoAGFxYUgSh
 ObcfgKGNz5j5C3UXZdqSWAzX0vu4o8wnlwAV7wrNbAOvUvZ4fXbiCEijG28gWzaUXVlm3AlwGqW69
 ZnTQnk1K99wCauBLa+5AATTBlZqje8f5tXt4qaHB2ivB6ourAe6WcObus2e176dy3UV3EHWRQlgfv
 C5ONfhpB6BnP/JqAoZZS6R4XcVzYB51xvRPdRFIaA86Q/D9o0VwEZ5kvf/cytEDWs0IdHCDcu1He5
 rgNF4zXw7iAOVRwJkXSUeWws9hzbUjrP2QLz1aba9d+2MsBssZ+ruU/E1F/EX/U0rp8XrTi/kC/7g
 fTpyk3Xm+NcVWjityp/ca7a4l4efYs64ROve5cb4Q=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XE7-0008EL-Ru; Wed, 23 Oct 2024 10:00:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:43 +0100
Message-Id: <20241023085852.1061031-28-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 27/36] next-cube: QOMify NeXTRTC
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
device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 66 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e4d0083eb0..6b574d39cf 100644
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
+    d = DEVICE(object_resolve_path_component(OBJECT(dev), "rtc"));
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
@@ -1129,22 +1174,6 @@ static Property next_pc_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
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
     .version_id = 3,
@@ -1297,6 +1326,7 @@ static void next_register_type(void)
     type_register_static(&next_typeinfo);
     type_register_static(&next_pc_info);
     type_register_static(&next_scsi_info);
+    type_register_static(&next_rtc_info);
 }
 
 type_init(next_register_type)
-- 
2.39.5


