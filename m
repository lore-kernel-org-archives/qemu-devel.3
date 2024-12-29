Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3B6E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniR-00089j-1O; Sun, 29 Dec 2024 02:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni3-0006o5-Fv
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:37 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhz-0002DW-FL
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:34 -0500
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso967962166b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457250; x=1736062050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feQ0o0AR8lm4HYTI3gKWuN73bpZVkWiDuFcBbBOU3wA=;
 b=we88/nwX6KioGSeqKvfXkn0vGV2AiOJkcMUSI0scwAGOxnAnYPV3IQp0cOGdrAQm2Y
 tI3NO/FWX0+EaeBt+TS0jxk+PRj8lKNO0XdYpNc18Iz6L4SyLtV3BjymMjgGIQIJhtVN
 SUztL9BeOJ2+cV+ZLywjlvJZqghgUFC1In2JNMgyWE8cLtzoOvNGvkcmLxR+L5DoTwel
 3tLKa6oVeeFWh9HxoAz43Lh1Al2z5UajGuBxAd+2OCETKQ/yNDx90csXu01+Z8OAtxO7
 mHfX5hTwskCYUSbt6qeDa/wNW71loEe9ZTC/kWSwv7cvWxgUSS90bd3UM6rKMhQorXPN
 lVZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGHujHcX4+Olf3mq72v3B16f5vNzO+tr3TfyYldNjIgHo3JAmBwWvlF8gunNNJZHpU0pifv2LMXDia@nongnu.org
X-Gm-Message-State: AOJu0Yz1m/ZgdgbcnFx4qNB26alVnwXMtqSiNpwTTCpQ7sYiA2JMtX+J
 qTTZoSs1YRW7t+HlBhDf+xRdndpaVUEPZGhGFRlTifYB/dxp3+C3ZSo3sw==
X-Gm-Gg: ASbGncvnVuarDsPZtalx4iHgxYDr88XUANITmckqZV/vmHGvTX54aAX9ub0N4rzaH6i
 8gvdDb8gCXbdEIUXwqC5+xs44BfRhhlSov2XnuZM0UAPOgl7ZQKiodtwx3TdGzEs10CJ9KNZCSY
 Xza5zrqhk9n0nrXvXnOjQmqeXlHljvfJAD1q6q/3xOWzy7lciwDC10iQ/eVTpdt6L2zf+P3RhrF
 5FNSnyKxuIzBR98x+vsdLvYb/APAkve18Ce8s/pRSfxKz9a1EzKd1zyBPtCA8yFi06eZ5oWjUAP
 8Xs=
X-Google-Smtp-Source: AGHT+IE38h5MRKO21Z8CL4tMV355WsfvqnUfci0PEW689RhEm9TsvRL+LwQUNLuxuXU9AKpgZvjOTQ==
X-Received: by 2002:a17:907:940d:b0:aa6:6a55:ad81 with SMTP id
 a640c23a62f3a-aac334f621fmr2912533866b.41.1735457249523; 
 Sat, 28 Dec 2024 23:27:29 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:28 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 27/35] next-cube: QOMify NeXTRTC
Date: Sun, 29 Dec 2024 08:25:18 +0100
Message-ID: <20241229072526.166555-28-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
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

This is to allow the RTC functionality to be maintained within its own separate
device rather than as part of the next-pc device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241222130012.1013374-26-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 71 +++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 3ca70e376e..883891ce6b 100644
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
@@ -1305,6 +1333,7 @@ static void next_register_type(void)
     type_register_static(&next_typeinfo);
     type_register_static(&next_pc_info);
     type_register_static(&next_scsi_info);
+    type_register_static(&next_rtc_info);
 }
 
 type_init(next_register_type)
-- 
2.47.1


