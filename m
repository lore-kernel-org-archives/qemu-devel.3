Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8948BEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMG7-0006hY-2k; Wed, 11 Sep 2024 08:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFW-0005zH-Bo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:10 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFR-0007BP-9g
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d43657255so513474166b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056899; x=1726661699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8YejXUnvjps1R98iES1hFKof918dPtM+kFcMx/JcZI=;
 b=vlXkVtk+iDcsZ+3gMY3873AX8fC955g4jA2ZnWX0+FhkaGZ7oNYGua1ILhR6hCbEBB
 KjdtJM5qP4MbXVYAdaHAlGJPdK16Ov7vbZkjlJgLEXYYHd/JnHsdplGQvn7KSoQ1Jj3i
 M7Occofi/IvvlZ2FRgd+SMcDk9pE+K66C5BKG/eo9i2e+/bPXyqDn0UuN6oAxgFFik84
 OyGaxRke4gI33huAoCxbZ50zB+ZDZYJLXrK8et3n2/sg2jMCtBpfNCvnmcbRkrWD7upz
 b5fvf94xvlgTjtJAOsxRPZk4t5asqLjQUvD6tcUhwD3oE9R+DwFTDvjEYzoNI8Azis1N
 UD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056899; x=1726661699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8YejXUnvjps1R98iES1hFKof918dPtM+kFcMx/JcZI=;
 b=BmFO23GHxk3mP/HjmvE0e36/Av9AP/OVUKKnkDnXCwQw0FsF6kYMdpwLQFG9QwQSm9
 5+qwhQQxPbpuyjbKr5vv4xN18XPGmJ8rivM/oSyz79r+z61mJ6OPudFQ341nzpOzQVbn
 7wVPhYrnUODa21zW24bCq9dRVgGpIYX5MmxP1Wpqo53abY8C50L0jHIqvbQpCaD9xh54
 ETg+WKYp1phRLo7ny3BJjrwjeLYrg0NhIp9OWFUcFqdxbkl9LevVsHfXF2DdD1k5x1Tf
 z4Dv7vD+Cl4SZ0/fYEwzYw8+lnIX5U6T7eRHwn9AOT7lgKurOgOHD+OSmj2aegpDUhD2
 lgsQ==
X-Gm-Message-State: AOJu0Yy64hPFXnUhWrEBzp5ldlYs/gKMfpglSnqXkXVbR7Zyo/1M/YtQ
 4jg5cbvnWPoUb2efa+UWcGq488fpTEjP21uGDpckDHMMfP3lOOdihLMv4LyaCHlAk4yKHjTr/ff
 B
X-Google-Smtp-Source: AGHT+IH/J+zvj4EKEiIFToZ8vZMCHz4t6e6pSpOXIwD13pbkwujcznAH8M/t0mB5rUoUCpOEN/EGSg==
X-Received: by 2002:a17:907:6095:b0:a8d:1303:2283 with SMTP id
 a640c23a62f3a-a8ffab6cbb4mr354267666b.30.1726056899016; 
 Wed, 11 Sep 2024 05:14:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ce86e0sm611757566b.143.2024.09.11.05.14.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:14:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/56] hw/block: Remove TC58128 NAND EEPROM
Date: Wed, 11 Sep 2024 14:13:30 +0200
Message-ID: <20240911121422.52585-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

The TC58128 NAND EEPROM is not user creatable and
needs to be instanciated in the code via tc58128_init().

Only the SHIX machine was using it, and it was removed
in the previous commit. Since the TC58128 has no more
users, remove it too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240903153959.18392-3-philmd@linaro.org>
---
 MAINTAINERS          |   6 --
 include/hw/sh4/sh.h  |   3 -
 hw/block/tc58128.c   | 211 -------------------------------------------
 hw/block/Kconfig     |   3 -
 hw/block/meson.build |   1 -
 5 files changed, 224 deletions(-)
 delete mode 100644 hw/block/tc58128.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ff5b3d1afd..26f9310a4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1682,12 +1682,6 @@ F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
 
-TC58128 NAND EEPROM
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
-R: Magnus Damm <magnus.damm@gmail.com>
-S: Odd Fixes
-F: hw/block/tc58128.c
-
 SPARC Machines
 --------------
 Sun4m
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index ec716cdd45..b726b987cc 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -60,7 +60,4 @@ int sh7750_register_io_device(struct SH7750State *s,
 /* sh7750.c */
 qemu_irq sh7750_irl(struct SH7750State *s);
 
-/* tc58128.c */
-int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2);
-
 #endif
diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
deleted file mode 100644
index 0984e37417..0000000000
--- a/hw/block/tc58128.c
+++ /dev/null
@@ -1,211 +0,0 @@
-/*
- * TC58128 NAND EEPROM emulation
- *
- * Copyright (c) 2005 Samuel Tardieu
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- *
- * SPDX-License-Identifier: MIT
- */
-#include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "hw/sh4/sh.h"
-#include "hw/loader.h"
-#include "sysemu/qtest.h"
-#include "qemu/error-report.h"
-
-#define CE1  0x0100
-#define CE2  0x0200
-#define RE   0x0400
-#define WE   0x0800
-#define ALE  0x1000
-#define CLE  0x2000
-#define RDY1 0x4000
-#define RDY2 0x8000
-#define RDY(n) ((n) == 0 ? RDY1 : RDY2)
-
-typedef enum { WAIT, READ1, READ2, READ3 } state_t;
-
-typedef struct {
-    uint8_t *flash_contents;
-    state_t state;
-    uint32_t address;
-    uint8_t address_cycle;
-} tc58128_dev;
-
-static tc58128_dev tc58128_devs[2];
-
-#define FLASH_SIZE (16 * MiB)
-
-static void init_dev(tc58128_dev * dev, const char *filename)
-{
-    int ret, blocks;
-
-    dev->state = WAIT;
-    dev->flash_contents = g_malloc(FLASH_SIZE);
-    memset(dev->flash_contents, 0xff, FLASH_SIZE);
-    if (filename) {
-        /* Load flash image skipping the first block */
-        ret = load_image_size(filename, dev->flash_contents + 528 * 32,
-                              FLASH_SIZE - 528 * 32);
-        if (ret < 0) {
-            if (!qtest_enabled()) {
-                error_report("Could not load flash image %s", filename);
-                exit(1);
-            }
-        } else {
-            /* Build first block with number of blocks */
-            blocks = DIV_ROUND_UP(ret, 528 * 32);
-            dev->flash_contents[0] = blocks & 0xff;
-            dev->flash_contents[1] = (blocks >> 8) & 0xff;
-            dev->flash_contents[2] = (blocks >> 16) & 0xff;
-            dev->flash_contents[3] = (blocks >> 24) & 0xff;
-            fprintf(stderr, "loaded %d bytes for %s into flash\n", ret,
-                    filename);
-        }
-    }
-}
-
-static void handle_command(tc58128_dev * dev, uint8_t command)
-{
-    switch (command) {
-    case 0xff:
-        fprintf(stderr, "reset flash device\n");
-        dev->state = WAIT;
-        break;
-    case 0x00:
-        fprintf(stderr, "read mode 1\n");
-        dev->state = READ1;
-        dev->address_cycle = 0;
-        break;
-    case 0x01:
-        fprintf(stderr, "read mode 2\n");
-        dev->state = READ2;
-        dev->address_cycle = 0;
-        break;
-    case 0x50:
-        fprintf(stderr, "read mode 3\n");
-        dev->state = READ3;
-        dev->address_cycle = 0;
-        break;
-    default:
-        fprintf(stderr, "unknown flash command 0x%02x\n", command);
-        abort();
-    }
-}
-
-static void handle_address(tc58128_dev * dev, uint8_t data)
-{
-    switch (dev->state) {
-    case READ1:
-    case READ2:
-    case READ3:
-        switch (dev->address_cycle) {
-        case 0:
-            dev->address = data;
-            if (dev->state == READ2)
-                dev->address |= 0x100;
-            else if (dev->state == READ3)
-                dev->address |= 0x200;
-            break;
-        case 1:
-            dev->address += data * 528 * 0x100;
-            break;
-        case 2:
-            dev->address += data * 528;
-            fprintf(stderr, "address pointer in flash: 0x%08x\n",
-                    dev->address);
-            break;
-        default:
-            /* Invalid data */
-            abort();
-        }
-        dev->address_cycle++;
-        break;
-    default:
-        abort();
-    }
-}
-
-static uint8_t handle_read(tc58128_dev * dev)
-{
-#if 0
-    if (dev->address % 0x100000 == 0)
-        fprintf(stderr, "reading flash at address 0x%08x\n", dev->address);
-#endif
-    return dev->flash_contents[dev->address++];
-}
-
-/* We never mark the device as busy, so interrupts cannot be triggered
-   XXXXX */
-
-static int tc58128_cb(uint16_t porta, uint16_t portb,
-                      uint16_t * periph_pdtra, uint16_t * periph_portadir,
-                      uint16_t * periph_pdtrb, uint16_t * periph_portbdir)
-{
-    int dev;
-
-    if ((porta & CE1) == 0)
-        dev = 0;
-    else if ((porta & CE2) == 0)
-        dev = 1;
-    else
-        return 0;        /* No device selected */
-
-    if ((porta & RE) && (porta & WE)) {
-        /* Nothing to do, assert ready and return to input state */
-        *periph_portadir &= 0xff00;
-        *periph_portadir |= RDY(dev);
-        *periph_pdtra |= RDY(dev);
-        return 1;
-    }
-
-    if (porta & CLE) {
-        /* Command */
-        assert((porta & WE) == 0);
-        handle_command(&tc58128_devs[dev], porta & 0x00ff);
-    } else if (porta & ALE) {
-        assert((porta & WE) == 0);
-        handle_address(&tc58128_devs[dev], porta & 0x00ff);
-    } else if ((porta & RE) == 0) {
-        *periph_portadir |= 0x00ff;
-        *periph_pdtra &= 0xff00;
-        *periph_pdtra |= handle_read(&tc58128_devs[dev]);
-    } else {
-        abort();
-    }
-    return 1;
-}
-
-static sh7750_io_device tc58128 = {
-    RE | WE,            /* Port A triggers */
-    0,                  /* Port B triggers */
-    tc58128_cb          /* Callback */
-};
-
-int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2)
-{
-    if (!qtest_enabled()) {
-        warn_report_once("The TC58128 flash device is deprecated");
-    }
-    init_dev(&tc58128_devs[0], zone1);
-    init_dev(&tc58128_devs[1], zone2);
-    return sh7750_register_io_device(s, &tc58128);
-}
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 9e8f28f982..ef6709b106 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -28,9 +28,6 @@ config ECC
 config ONENAND
     bool
 
-config TC58128
-    bool
-
 config VIRTIO_BLK
     bool
     default y
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 8aa4dc3893..0fb0f41f42 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -15,7 +15,6 @@ system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
 system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
-system_ss.add(when: 'CONFIG_TC58128', if_true: files('tc58128.c'))
 
 specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c', 'virtio-blk-common.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c', 'virtio-blk-common.c'))
-- 
2.45.2


