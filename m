Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136D1C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGg-0005vJ-EG; Sun, 23 Mar 2025 13:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGa-0005sC-KK
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGY-0002vQ-S0
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2239c066347so79658915ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751461; x=1743356261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1diLEzRhOjCtwJkuJyBuZiDuZxnU+3/mKXg0OjzXEDE=;
 b=lX7wCGfpEsGZt0SDiucwxbgAl/ey6bKkgaa+Xkp7x/LyZ+M0qpFTM6EakI6h+CsK87
 Gh29RO56w9Cfsb/NzNuEL9q1Elej6J5VcNJL59ezA0xiYRO8DJ0761ekUIceu3vnuorD
 h/quOwteyNcOkkj22QFKKIz6VOKBi3ls/anh4/IXXsgS4UCupNWEpbay5t2G36q6ERPL
 5vU59gv4nXlzy0ex842gMCFg8r3z98Nf7VkF6ZU79tddhfKwc3AYLr+6HRa16NeJaPbK
 NthD7OKk7ZkzjeLgt5Jjvf5v4pWpl0dPjXqDDcTKqn+FErusosjmV5bCEXJHc6C62ise
 kYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751461; x=1743356261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1diLEzRhOjCtwJkuJyBuZiDuZxnU+3/mKXg0OjzXEDE=;
 b=M06JAkChCff1sV9KTWEFaLdnw0VKyFjtdh2u8gsBBPo4/3HykXZRZXgqDpp2LD/Qrv
 ufjLsq6H3rm9e1kBDwQ454ZQs+N7oT+nzsGOG4HEHJinTG6qab3H18UhFDqp2gYpNfZK
 8ua76uCeAiwUEfvFG+DZbBFnZ7mXgiV/hfpDZLQCi2GZxlcowW8KRmJ3b2m5f6S003Yq
 bmaqpM+56NZp17k2/6m9di5yfnaYmynjBnemsXR8qEw63nxkSCZkoTn2ljGQH/SnL22K
 2ybRt16JvYaFbdAMagbYRv35ubLiFvOF334NHHiKhaagXkPNBl2oa0e0hTCoR5X6yH4l
 EPiQ==
X-Gm-Message-State: AOJu0YxAHJmhev7yH9+rcJWItth8OobyRF0TkXTZgve/izAzkxD+aa4O
 0alnzGl/zsgyuOYZ5yQsRggSk1B+Vpu3hvn8sNX7pGh6Z4+b3f2zea5UTdUphdw0AxBJj0fV6o7
 B
X-Gm-Gg: ASbGncvqyFjJ/HULaSbMQWXtl7304W6z2EspHVssUaASeLBtr3UXvwLo99e+pVd0dQ0
 ouwEmIgS/TFwpONdrmiQOA6VENiLBpedyLH5JcrQ/XGAQsREYe26Luzs7cQCPSISr1yYMpxyS4W
 o1izSfxZyy7QtzRHwdnPxQ5d4eF8HZ0ISBy5aozWS1yXMhxd6zwaUwh4HOxDosCKUsanCzHhkvM
 PiXA43palHT7fEmrl7tXIxW+Fp1cDAsxVf0DLMT2blrRuU9yfGiIxnjW5oQGe6V0ZufZdJHrg4o
 /eanvkJPQhYHxtAP8kzgnmyfZUmyX4H+hzPifXC1lpEy6WhDWBw3a5zfQrhGB3t/UcMDmioijW1
 c
X-Google-Smtp-Source: AGHT+IGW3mvxhvtAAZqftWK9jo4R2yWEsTwtWwCEH163/f+UaXvGCVr2MAqFHX50J63Vs+xNm4VbxQ==
X-Received: by 2002:a17:902:c94a:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-22780e3fb00mr161436935ad.34.1742751461520; 
 Sun, 23 Mar 2025 10:37:41 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 14/17] hw/avr: Set offset_io and increase page size to 1k
Date: Sun, 23 Mar 2025 10:37:26 -0700
Message-ID: <20250323173730.3213964-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu-param.h |  8 +------
 hw/avr/atmega.c        | 54 ++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 81f3f49ee1..f5248ce9e7 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -21,13 +21,7 @@
 #ifndef AVR_CPU_PARAM_H
 #define AVR_CPU_PARAM_H
 
-/*
- * TARGET_PAGE_BITS cannot be more than 8 bits because
- * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
- *     should be implemented as a device and not memory
- * 2.  SRAM starts at the address 0x0100
- */
-#define TARGET_PAGE_BITS 8
+#define TARGET_PAGE_BITS 10
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 273582b8af..d4fc9c4aee 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
+#include "exec/target_page.h"
 #include "system/system.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -222,6 +223,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     DeviceState *cpudev;
     SysBusDevice *sbd;
     char *devname;
+    uint32_t offset_io, offset_sram;
     size_t i;
 
     assert(mc->io_size <= 0x200);
@@ -231,13 +233,25 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * Bias the virtual data section so that the start of RAM is at
+     * the start of the second page of the physical data section.
+     * This puts all of the I/O at the end of the first page of the
+     * physical data section.
+     */
+    offset_io = TARGET_PAGE_SIZE - mc->io_size;
+    offset_sram = TARGET_PAGE_SIZE;
+
     /* CPU */
     object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
 
     object_property_set_uint(OBJECT(&s->cpu), "init-sp",
                              mc->io_size + mc->sram_size - 1, &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), "offset-io",
-                             0, &error_abort);
+                             offset_io, &error_abort);
+
+    offset_io += OFFSET_DATA;
+    offset_sram += OFFSET_DATA;
 
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
@@ -245,8 +259,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     /* SRAM */
     memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
                            &error_abort);
-    memory_region_add_subregion(get_system_memory(),
-                                OFFSET_DATA + mc->io_size, &s->sram);
+    memory_region_add_subregion(get_system_memory(), offset_sram, &s->sram);
 
     /* Flash */
     memory_region_init_rom(&s->flash, OBJECT(dev),
@@ -258,13 +271,14 @@ static void atmega_realize(DeviceState *dev, Error **errp)
      *
      * 0x00 - 0x1f: Registers
      * 0x20 - 0x5f: I/O memory
-     * 0x60 - 0xff: Extended I/O
+     * 0x60 - 0x[1]ff: Extended I/O
      */
     s->io = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(s->io, "name", "I/O");
     qdev_prop_set_uint64(s->io, "size", mc->io_size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s->io), &error_fatal);
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA, -1234);
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, offset_io, -1234);
 
     /* Power Reduction */
     for (i = 0; i < POWER_MAX; i++) {
@@ -277,7 +291,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
                                 TYPE_AVR_MASK);
         sysbus_realize(SYS_BUS_DEVICE(&s->pwr[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0,
-                        OFFSET_DATA + mc->dev[idx].addr);
+                        offset_io + mc->dev[idx].addr);
         g_free(devname);
     }
 
@@ -289,7 +303,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         }
         devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
         create_unimplemented_device(devname,
-                                    OFFSET_DATA + mc->dev[idx].addr, 3);
+                                    offset_io + mc->dev[idx].addr, 3);
         g_free(devname);
     }
 
@@ -305,7 +319,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i));
         sbd = SYS_BUS_DEVICE(&s->usart[i]);
         sysbus_realize(sbd, &error_abort);
-        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[USART(i)].addr);
+        sysbus_mmio_map(sbd, 0, offset_io + mc->dev[USART(i)].addr);
         connect_peripheral_irq(mc, sbd, 0, cpudev, USART_RXC_IRQ(i));
         connect_peripheral_irq(mc, sbd, 1, cpudev, USART_DRE_IRQ(i));
         connect_peripheral_irq(mc, sbd, 2, cpudev, USART_TXC_IRQ(i));
@@ -321,12 +335,12 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         }
         if (!mc->dev[idx].is_timer16) {
             create_unimplemented_device("avr-timer8",
-                                        OFFSET_DATA + mc->dev[idx].addr, 5);
+                                        offset_io + mc->dev[idx].addr, 5);
             create_unimplemented_device("avr-timer8-intmask",
-                                        OFFSET_DATA
+                                        offset_io
                                         + mc->dev[idx].intmask_addr, 1);
             create_unimplemented_device("avr-timer8-intflag",
-                                        OFFSET_DATA
+                                        offset_io
                                         + mc->dev[idx].intflag_addr, 1);
             continue;
         }
@@ -337,9 +351,9 @@ static void atmega_realize(DeviceState *dev, Error **errp)
                                  s->xtal_freq_hz, &error_abort);
         sbd = SYS_BUS_DEVICE(&s->timer[i]);
         sysbus_realize(sbd, &error_abort);
-        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[idx].addr);
-        sysbus_mmio_map(sbd, 1, OFFSET_DATA + mc->dev[idx].intmask_addr);
-        sysbus_mmio_map(sbd, 2, OFFSET_DATA + mc->dev[idx].intflag_addr);
+        sysbus_mmio_map(sbd, 0, offset_io + mc->dev[idx].addr);
+        sysbus_mmio_map(sbd, 1, offset_io + mc->dev[idx].intmask_addr);
+        sysbus_mmio_map(sbd, 2, offset_io + mc->dev[idx].intflag_addr);
         connect_peripheral_irq(mc, sbd, 0, cpudev, TIMER_CAPT_IRQ(i));
         connect_peripheral_irq(mc, sbd, 1, cpudev, TIMER_COMPA_IRQ(i));
         connect_peripheral_irq(mc, sbd, 2, cpudev, TIMER_COMPB_IRQ(i));
@@ -349,12 +363,12 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         g_free(devname);
     }
 
-    create_unimplemented_device("avr-twi",          OFFSET_DATA + 0x0b8, 6);
-    create_unimplemented_device("avr-adc",          OFFSET_DATA + 0x078, 8);
-    create_unimplemented_device("avr-ext-mem-ctrl", OFFSET_DATA + 0x074, 2);
-    create_unimplemented_device("avr-watchdog",     OFFSET_DATA + 0x060, 1);
-    create_unimplemented_device("avr-spi",          OFFSET_DATA + 0x04c, 3);
-    create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f, 3);
+    create_unimplemented_device("avr-twi",          offset_io + 0x0b8, 6);
+    create_unimplemented_device("avr-adc",          offset_io + 0x078, 8);
+    create_unimplemented_device("avr-ext-mem-ctrl", offset_io + 0x074, 2);
+    create_unimplemented_device("avr-watchdog",     offset_io + 0x060, 1);
+    create_unimplemented_device("avr-spi",          offset_io + 0x04c, 3);
+    create_unimplemented_device("avr-eeprom",       offset_io + 0x03f, 3);
 }
 
 static const Property atmega_props[] = {
-- 
2.43.0


