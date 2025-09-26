Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE47CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23YR-0007ID-73; Fri, 26 Sep 2025 04:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23YO-0007HL-Lc; Fri, 26 Sep 2025 04:11:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23YG-0000Jp-NR; Fri, 26 Sep 2025 04:11:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A97E157D51;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E386290C35;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 09/60] hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ
 objects
Date: Fri, 26 Sep 2025 11:09:37 +0300
Message-ID: <20250926081031.2214971-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In stm32f250_soc_initfn() we mostly use the standard pattern
for child objects of calling object_initialize_child(). However
for s->adc_irqs we call object_new() and then later qdev_realize(),
and we never unref the object on deinit. This causes a leak,
detected by ASAN on the device-introspect-test:

Indirect leak of 10 byte(s) in 1 object(s) allocated from:
    #0 0x5b9fc4789de3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (BuildId: 267a2619a026ed91c78a07b1eb2ef15381538efe)
    #1 0x740de3f28b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x740de3f3e4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #3 0x5b9fc70159e1 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
    #4 0x5b9fc70159e1 in object_property_try_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1276:18
    #5 0x5b9fc7015f94 in object_property_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1294:12
    #6 0x5b9fc701b900 in object_add_link_prop /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2021:10
    #7 0x5b9fc701b3fc in object_property_add_link /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2037:12
    #8 0x5b9fc4c299fb in qdev_init_gpio_out_named /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/gpio.c:90:9
    #9 0x5b9fc4c29b26 in qdev_init_gpio_out /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/gpio.c:101:5
    #10 0x5b9fc4c0f77a in or_irq_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/or-irq.c:70:5
    #11 0x5b9fc70257e1 in object_init_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:428:9
    #12 0x5b9fc700cd4b in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:570:5
    #13 0x5b9fc700e66d in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:774:5
    #14 0x5b9fc700e750 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
    #15 0x5b9fc68b2162 in stm32f205_soc_initfn /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/stm32f205_soc.c:69:26

Switch to using object_initialize_child() like all our
other child objects for this SoC object.

Cc: qemu-stable@nongnu.org
Fixes: b63041c8f6b ("STM32F205: Connect the ADC devices")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250821154229.2417453-1-peter.maydell@linaro.org
(cherry picked from commit 2e27650bddd35477d994a795a3b1cb57c8ed5c76)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 229af7fb10..e3c7203c6e 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -66,7 +66,7 @@ static void stm32f205_soc_initfn(Object *obj)
                                 TYPE_STM32F2XX_TIMER);
     }
 
-    s->adc_irqs = OR_IRQ(object_new(TYPE_OR_IRQ));
+    object_initialize_child(obj, "adc-irq-orgate", &s->adc_irqs, TYPE_OR_IRQ);
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         object_initialize_child(obj, "adc[*]", &s->adc[i], TYPE_STM32F2XX_ADC);
@@ -171,12 +171,12 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* ADC 1 to 3 */
-    object_property_set_int(OBJECT(s->adc_irqs), "num-lines", STM_NUM_ADCS,
+    object_property_set_int(OBJECT(&s->adc_irqs), "num-lines", STM_NUM_ADCS,
                             &error_abort);
-    if (!qdev_realize(DEVICE(s->adc_irqs), NULL, errp)) {
+    if (!qdev_realize(DEVICE(&s->adc_irqs), NULL, errp)) {
         return;
     }
-    qdev_connect_gpio_out(DEVICE(s->adc_irqs), 0,
+    qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
                           qdev_get_gpio_in(armv7m, ADC_IRQ));
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
@@ -187,7 +187,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, adc_addr[i]);
         sysbus_connect_irq(busdev, 0,
-                           qdev_get_gpio_in(DEVICE(s->adc_irqs), i));
+                           qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
     }
 
     /* SPI 1 and 2 */
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 4f4c8bbebc..46eda3403a 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -59,7 +59,7 @@ struct STM32F205State {
     STM32F2XXADCState adc[STM_NUM_ADCS];
     STM32F2XXSPIState spi[STM_NUM_SPIS];
 
-    OrIRQState *adc_irqs;
+    OrIRQState adc_irqs;
 
     MemoryRegion sram;
     MemoryRegion flash;
-- 
2.47.3


