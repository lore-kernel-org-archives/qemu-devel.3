Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD842CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr8X-0007yD-Ne; Wed, 04 Sep 2024 10:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8U-0007cm-Cn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8R-0005QY-3K
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42c79deb7c4so35727995e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460645; x=1726065445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+MPGXfzpvD5ne4OXlgUgbB/n5ba4zDrGXsbjf3V6ZE=;
 b=g8FaIRWtn27CKNQzQGMykLSfdCYrd874/lGHpFnzfMdoNnMQes9a0IiDDMxSVeGdZ9
 lAIidEmllhMlwtRFlTjLq705fsdU/+QQXpa8aXUGHPLZrAzHJfUP2ZyGrlAcimTOUqou
 TgTVa5ocNt3jv4JcrLQ4y0/sJDsKolroBcVELwarm/4YsoaZHa84kuof+aKH4WsRmBNc
 QNm7VmE1ElrqhBFUEy59yBI2YPWJkyUFcMDHbijWV68F17Mh3rzLHrK5jjJ3vw1SzwrQ
 e0DeUeabA45W3kr3TFJdPy8Rp7rzFY5nXzqObSN1+/KsEeT64HYLueYSjFZi9YnIBpbk
 YotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460645; x=1726065445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+MPGXfzpvD5ne4OXlgUgbB/n5ba4zDrGXsbjf3V6ZE=;
 b=PpjseAgFcZsgl7mrCmO5S8BCAhS/jpJoyFa7IUOhG0sj21go3rT21hPlqeCJAcIOWs
 B62xwwPiP1SDS+cWdeU543PGZMbPUxTtRoN2E9PwTv9VAkXWCe+WQZeQ9n3Q4X1gchqS
 8+uwER4PydKAtYcpns0HWdkMqiWOyuefjUWuk8E7ZOKNc64f6MwABhwo6jvojsYgyXBP
 qMYlaXDkLAd+h/3FmC5lCCEZ2YIfQpiIeGsH03KwwrzoRat7GxmhDflgl25lGslolDcE
 v3Fi4bJmKwxAe6eVgUa81IC9GQAida98z+xJv8EKaK0kJ+MQqZS8VEAzWMERh+jzn6ZV
 9ULA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIB4JQKl3VeJ8FyIfV9dBjzB3dLKQ12PALxrFO/Mi5im3zfofOrgjDl4z1XWm2dbtChsG9s79CV9aS@nongnu.org
X-Gm-Message-State: AOJu0Yw53jh3aMZlruOdZFhCe3gwQrAUI/wwmMGJbrHKaHv4AgYzqGOK
 O8zJfsSlWyaN1748SKT3tH37y3N8hJRo+Om0Qypq8WTNC3695tIxriihr81EQWE=
X-Google-Smtp-Source: AGHT+IGskY04Kd5WboG5/0Jgb8QPz96Km06iwn4PZxehXAJt6q3FEKKhidr+t35q0+p3p1kZD+4PVw==
X-Received: by 2002:a05:600c:3b8f:b0:426:6320:226a with SMTP id
 5b1f17b1804b1-42c7b5a8f75mr106414285e9.15.1725460645158; 
 Wed, 04 Sep 2024 07:37:25 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374cd205ab0sm7568410f8f.87.2024.09.04.07.37.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:37:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/15] hw/char: Remove TYPE_ETRAX_FS_SERIAL device
Date: Wed,  4 Sep 2024 16:35:56 +0200
Message-ID: <20240904143603.52934-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We just removed the single machine using it (axis-dev88).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cris/etraxfs.h |  18 ---
 hw/char/etraxfs_ser.c     | 267 --------------------------------------
 hw/char/meson.build       |   1 -
 3 files changed, 286 deletions(-)
 delete mode 100644 hw/char/etraxfs_ser.c

diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 012c4e9974..6d23f6f13f 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -27,28 +27,10 @@
 
 #include "net/net.h"
 #include "hw/cris/etraxfs_dma.h"
-#include "hw/qdev-properties.h"
-#include "hw/sysbus.h"
 #include "qapi/error.h"
 
 DeviceState *etraxfs_eth_init(hwaddr base, int phyaddr,
                               struct etraxfs_dma_client *dma_out,
                               struct etraxfs_dma_client *dma_in);
 
-static inline DeviceState *etraxfs_ser_create(hwaddr addr,
-                                              qemu_irq irq,
-                                              Chardev *chr)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-
-    dev = qdev_new("etraxfs-serial");
-    s = SYS_BUS_DEVICE(dev);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_mmio_map(s, 0, addr);
-    sysbus_connect_irq(s, 0, irq);
-    return dev;
-}
-
 #endif
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
deleted file mode 100644
index 8d6422dae4..0000000000
--- a/hw/char/etraxfs_ser.c
+++ /dev/null
@@ -1,267 +0,0 @@
-/*
- * QEMU ETRAX System Emulator
- *
- * Copyright (c) 2007 Edgar E. Iglesias, Axis Communications AB.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
-#include "hw/sysbus.h"
-#include "chardev/char-fe.h"
-#include "qemu/log.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-#define D(x)
-
-#define RW_TR_CTRL     (0x00 / 4)
-#define RW_TR_DMA_EN   (0x04 / 4)
-#define RW_REC_CTRL    (0x08 / 4)
-#define RW_DOUT        (0x1c / 4)
-#define RS_STAT_DIN    (0x20 / 4)
-#define R_STAT_DIN     (0x24 / 4)
-#define RW_INTR_MASK   (0x2c / 4)
-#define RW_ACK_INTR    (0x30 / 4)
-#define R_INTR         (0x34 / 4)
-#define R_MASKED_INTR  (0x38 / 4)
-#define R_MAX          (0x3c / 4)
-
-#define STAT_DAV     16
-#define STAT_TR_IDLE 22
-#define STAT_TR_RDY  24
-
-#define TYPE_ETRAX_FS_SERIAL "etraxfs-serial"
-typedef struct ETRAXSerial ETRAXSerial;
-DECLARE_INSTANCE_CHECKER(ETRAXSerial, ETRAX_SERIAL,
-                         TYPE_ETRAX_FS_SERIAL)
-
-struct ETRAXSerial {
-    SysBusDevice parent_obj;
-
-    MemoryRegion mmio;
-    CharBackend chr;
-    qemu_irq irq;
-
-    int pending_tx;
-
-    uint8_t rx_fifo[16];
-    unsigned int rx_fifo_pos;
-    unsigned int rx_fifo_len;
-
-    /* Control registers.  */
-    uint32_t regs[R_MAX];
-};
-
-static void ser_update_irq(ETRAXSerial *s)
-{
-
-    if (s->rx_fifo_len) {
-        s->regs[R_INTR] |= 8;
-    } else {
-        s->regs[R_INTR] &= ~8;
-    }
-
-    s->regs[R_MASKED_INTR] = s->regs[R_INTR] & s->regs[RW_INTR_MASK];
-    qemu_set_irq(s->irq, !!s->regs[R_MASKED_INTR]);
-}
-
-static uint64_t
-ser_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    ETRAXSerial *s = opaque;
-    uint32_t r = 0;
-
-    addr >>= 2;
-    switch (addr)
-    {
-        case R_STAT_DIN:
-            r = s->rx_fifo[(s->rx_fifo_pos - s->rx_fifo_len) & 15];
-            if (s->rx_fifo_len) {
-                r |= 1 << STAT_DAV;
-            }
-            r |= 1 << STAT_TR_RDY;
-            r |= 1 << STAT_TR_IDLE;
-            break;
-        case RS_STAT_DIN:
-            r = s->rx_fifo[(s->rx_fifo_pos - s->rx_fifo_len) & 15];
-            if (s->rx_fifo_len) {
-                r |= 1 << STAT_DAV;
-                s->rx_fifo_len--;
-            }
-            r |= 1 << STAT_TR_RDY;
-            r |= 1 << STAT_TR_IDLE;
-            break;
-        default:
-            r = s->regs[addr];
-            D(qemu_log("%s " HWADDR_FMT_plx "=%x\n", __func__, addr, r));
-            break;
-    }
-    return r;
-}
-
-static void
-ser_write(void *opaque, hwaddr addr,
-          uint64_t val64, unsigned int size)
-{
-    ETRAXSerial *s = opaque;
-    uint32_t value = val64;
-    unsigned char ch = val64;
-
-    D(qemu_log("%s " HWADDR_FMT_plx "=%x\n",  __func__, addr, value));
-    addr >>= 2;
-    switch (addr)
-    {
-        case RW_DOUT:
-            /* XXX this blocks entire thread. Rewrite to use
-             * qemu_chr_fe_write and background I/O callbacks */
-            qemu_chr_fe_write_all(&s->chr, &ch, 1);
-            s->regs[R_INTR] |= 3;
-            s->pending_tx = 1;
-            s->regs[addr] = value;
-            break;
-        case RW_ACK_INTR:
-            if (s->pending_tx) {
-                value &= ~1;
-                s->pending_tx = 0;
-                D(qemu_log("fixedup value=%x r_intr=%x\n",
-                           value, s->regs[R_INTR]));
-            }
-            s->regs[addr] = value;
-            s->regs[R_INTR] &= ~value;
-            D(printf("r_intr=%x\n", s->regs[R_INTR]));
-            break;
-        default:
-            s->regs[addr] = value;
-            break;
-    }
-    ser_update_irq(s);
-}
-
-static const MemoryRegionOps ser_ops = {
-    .read = ser_read,
-    .write = ser_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
-};
-
-static Property etraxfs_ser_properties[] = {
-    DEFINE_PROP_CHR("chardev", ETRAXSerial, chr),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void serial_receive(void *opaque, const uint8_t *buf, int size)
-{
-    ETRAXSerial *s = opaque;
-    int i;
-
-    /* Got a byte.  */
-    if (s->rx_fifo_len >= 16) {
-        D(qemu_log("WARNING: UART dropped char.\n"));
-        return;
-    }
-
-    for (i = 0; i < size; i++) { 
-        s->rx_fifo[s->rx_fifo_pos] = buf[i];
-        s->rx_fifo_pos++;
-        s->rx_fifo_pos &= 15;
-        s->rx_fifo_len++;
-    }
-
-    ser_update_irq(s);
-}
-
-static int serial_can_receive(void *opaque)
-{
-    ETRAXSerial *s = opaque;
-
-    /* Is the receiver enabled?  */
-    if (!(s->regs[RW_REC_CTRL] & (1 << 3))) {
-        return 0;
-    }
-
-    return sizeof(s->rx_fifo) - s->rx_fifo_len;
-}
-
-static void serial_event(void *opaque, QEMUChrEvent event)
-{
-
-}
-
-static void etraxfs_ser_reset(DeviceState *d)
-{
-    ETRAXSerial *s = ETRAX_SERIAL(d);
-
-    /* transmitter begins ready and idle.  */
-    s->regs[RS_STAT_DIN] |= (1 << STAT_TR_RDY);
-    s->regs[RS_STAT_DIN] |= (1 << STAT_TR_IDLE);
-
-    s->regs[RW_REC_CTRL] = 0x10000;
-
-}
-
-static void etraxfs_ser_init(Object *obj)
-{
-    ETRAXSerial *s = ETRAX_SERIAL(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-
-    sysbus_init_irq(dev, &s->irq);
-    memory_region_init_io(&s->mmio, obj, &ser_ops, s,
-                          "etraxfs-serial", R_MAX * 4);
-    sysbus_init_mmio(dev, &s->mmio);
-}
-
-static void etraxfs_ser_realize(DeviceState *dev, Error **errp)
-{
-    ETRAXSerial *s = ETRAX_SERIAL(dev);
-
-    qemu_chr_fe_set_handlers(&s->chr,
-                             serial_can_receive, serial_receive,
-                             serial_event, NULL, s, NULL, true);
-}
-
-static void etraxfs_ser_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->reset = etraxfs_ser_reset;
-    device_class_set_props(dc, etraxfs_ser_properties);
-    dc->realize = etraxfs_ser_realize;
-}
-
-static const TypeInfo etraxfs_ser_info = {
-    .name          = TYPE_ETRAX_FS_SERIAL,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(ETRAXSerial),
-    .instance_init = etraxfs_ser_init,
-    .class_init    = etraxfs_ser_class_init,
-};
-
-static void etraxfs_serial_register_types(void)
-{
-    type_register_static(&etraxfs_ser_info);
-}
-
-type_init(etraxfs_serial_register_types)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index e5b13b6958..a4c4c5ff0f 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -1,7 +1,6 @@
 system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_uart.c'))
 system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
-system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_ser.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
-- 
2.45.2


