Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDEECD3445
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slVdu-0003TM-DG; Tue, 03 Sep 2024 11:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVdq-0003B2-1r
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVdn-0006RS-Ts
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-374bd059b12so2044529f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725378011; x=1725982811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq81OzY4iMM1Td9sT8YiUCw5rHsCA7uPrMTvhOIEyE8=;
 b=V7/2v5EalWA+iytdvBT+W4/KFz0udCoePaO6QQWWNxtJ7lIiOGt2qhi9wIOLXcUK+4
 /ohjTvtQIfpgrwOOV0m6uQPprGEzkrT8207xb/UtIL0FxN7jxuM6QRmjDwilYzMnS+PS
 6vawsKJ3CIrIaB8zoxrEm9QQgleq95CNoI8jGviB/4yfdkN2d4ApQaRs0EpxPIgDZbc4
 O0ktckJyJhCvJLDspkr+dfxvrwRiSGvUgcAZtoXEp86ZufWfYq0gYld1WyrZAR/kLgTd
 HBLhhaEQKq/scM55vMxnEXdxszvxrL70I0qqKO4Og/7yv269vLToweZnW4VlgvviI0Vn
 9+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725378011; x=1725982811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gq81OzY4iMM1Td9sT8YiUCw5rHsCA7uPrMTvhOIEyE8=;
 b=PECcRhJJDljLmyU1GzKK8aCB4Nmm009ke9+32bwbULP+9BmP2usESi8oa37jGrW2Xv
 o9aehCwL9OnaSW4/xYdAPsnieDZQ3BiD0ymHVeMOQNVlq1WUp/2tNF/Ro00dkTPNm8om
 /ceBMhYAVdksyMTJm53qVdCkON02pG4Py7AAbuk2qJsmnYI1Ymbp4U8bvdMXlp6TfBE0
 EE6DgzPMbACWTdo7jo7/vUOgfyAiztGf4hzccjqsLkX62c+Y9rnv13Jrgobz2YDVqg+c
 +92RMzsLmTNSMd0ZDoQnHWLRhptUKuvCjkCXdXSxir0wn9M9zS2zvGgzjlRlCSmJjzoE
 X6kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYhv2KDrPM7tEgqsloiglToG2T9YBCSi5KwPFl1k7NW+BTdjrQBFpPSaY6S/FXzLRvXctimSiJ7OPA@nongnu.org
X-Gm-Message-State: AOJu0Ywyrx49zjGoBfSaLqNHuIDXLbCVtgkj1Upo4ZYXh9uIIHBYGfyA
 5+BxoD64fH/nfYI3SF9csX1AfOngMem9W40jY8dhONqInlwqMnUPJV+QLRVIdz0=
X-Google-Smtp-Source: AGHT+IGFEW+M9uWXAUG0ZPT7rovqlNfppWr4tOmeYmruBzVExbvlQlIpTNZlUlA7edzwYrMhHmStQw==
X-Received: by 2002:adf:e6ce:0:b0:377:2df4:55f6 with SMTP id
 ffacd0b85a97d-3772df4571fmr115273f8f.17.1725378010531; 
 Tue, 03 Sep 2024 08:40:10 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374d00564b6sm4478327f8f.91.2024.09.03.08.40.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 08:40:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Samuel Tardieu <sam@rfc1149.net>,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Magnus Damm <magnus.damm@gmail.com>,
 qemu-block@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/block: Remove TC58128 NAND EEPROM
Date: Tue,  3 Sep 2024 17:39:58 +0200
Message-ID: <20240903153959.18392-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903153959.18392-1-philmd@linaro.org>
References: <20240903153959.18392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 MAINTAINERS          |   6 --
 include/hw/sh4/sh.h  |   3 -
 hw/block/tc58128.c   | 211 -------------------------------------------
 hw/block/Kconfig     |   3 -
 hw/block/meson.build |   1 -
 5 files changed, 224 deletions(-)
 delete mode 100644 hw/block/tc58128.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c8e4e3329c..55f41ecbc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1676,12 +1676,6 @@ F: hw/timer/sh_timer.c
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


