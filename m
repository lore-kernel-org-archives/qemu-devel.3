Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265C1E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Id-00010j-QE; Sun, 12 Jan 2025 17:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IS-0000l3-TB
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IP-0006Ue-Me
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso42576385e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720340; x=1737325140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjOXcw3e6sngFlw7RAw10nmapkVZsHVwbnyM2hBKQkY=;
 b=yS95/JfvWIvdREGOAm0785hBk4vpe81EH/gqTfugDez1VyXRCBKRIxexvPK52Q7gHp
 9YiKwnUNJNCSJwPQHroBQ0hZzYXeYTeHHoaOh3kYSixMCu+PSRjlTii3YYrfWRUS+18T
 KIIPofd+VWqp3eY8lOLOb7n1wk7USD9yweZ+KaBQx7DTLfyexz+I4iT3f3+F4tJseVrN
 vycjvML6z6oaKFKesS7XO+/Adfxu4UqsuJpeumtU8uQLhp+wN+e4uFyNvGu7pRJSR8KT
 Ao0ZrDAmWiTXHzodY5MNPauqscGohGWsxuw86SOPrxfHixFsOadNUezELXNE5dgKYJ4h
 Lv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720340; x=1737325140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjOXcw3e6sngFlw7RAw10nmapkVZsHVwbnyM2hBKQkY=;
 b=sgCRlPCvRzJ9kAg3vpDVaoTitS3CErCLk1gvWn9jIcK7Axf0fnzAGRtjpTbgSDVIRV
 /iD4zS3mq+QqbdlFmjw6+OuXpJA7CO06t0EpfjjonzGzavo36wKVofcz3gB+6CSrTMC6
 QgT9ZJNz6iwqIZLyLT0k9Jin5aC8g2pSPfB+OVY8l7WCbYX7z5HOCfIWtxi0yQzB1ieE
 4nJURMnLGlq4LiD+kS1CgH/TwLN++AdlqvAL1fi8dZA20VoXU1TWbiVO9dTkb+SajVQL
 1Jv26nJIwwxdmpEJ32d24else+GHk15H+56dnwknrFg22axQImFC7jj7yvIfr/TSDp0r
 kecw==
X-Gm-Message-State: AOJu0YxZiUVTRwkJUGD0LkhgY02HuCRxjGnVsE9pZjbcZg1lx+/2vYbK
 j/2x8asyN3MHkb4aaZ04lkop5TbTX6bOrQn83oxmTsIAHI49o4bjE/TbXIK2632CtgAZOfUGl4M
 +Qvw=
X-Gm-Gg: ASbGncuWJG0+EnHAcHaZsVSb59z02c4vdF44CZknbN/vB3WYy6+x+Dleq0XytgjOW+g
 gs3qmg7pCbgm5zzV3OaZTslhhF4m//vqKejPbUOYYgrpkDJgmxkVc4ZD9+uSUmmN1SPqjCAkdSw
 f1xLXNrsnB+fH2ytjbZ/JYd48kp2LMkfaFEEy0WBf/y1Iz5MRXBFOBYfkLyK3h5X+6TmMTCaTr7
 wxmIX8s425Z0f0SuX8E+2K/BTtA2KMNrnVUu3p3jUpba7fNZGgd2l2sr0K0MYknJ00U3HnMum9u
 AxV5M8lbMTPUHRRsSbdyOtr2nIrqs/I=
X-Google-Smtp-Source: AGHT+IEslhTK0K3tz40IdK4M7CdhIAckx8VztmUMQkXhkFwRgg/qZqRf9Uy+zXYtth4KAXRauWgkCQ==
X-Received: by 2002:a05:6000:1561:b0:38a:9f47:557b with SMTP id
 ffacd0b85a97d-38a9f47568cmr5614344f8f.40.1736720339681; 
 Sun, 12 Jan 2025 14:18:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da6336sm158466635e9.8.2025.01.12.14.18.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 18/49] hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory
 region
Date: Sun, 12 Jan 2025 23:16:54 +0100
Message-ID: <20250112221726.30206-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Rather than using I/O registers for RAM buffer, having to
swap endianness back and forth (because the core memory layer
automatically swaps endiannes for us), declare the buffers
as RAM regions. The "xlnx.xps-ethernetlite" MR doesn't have
any more I/O regions. Remove the now unused s->regs[] array.

The memory flat view becomes:

  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, ram): ethlite.tx[0]buf
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810007ff (prio 0, i/o): ethlite.tx[0]io
    0000000081000800-0000000081000fe3 (prio 0, ram): ethlite.tx[1]buf
    0000000081000ff4-0000000081000fff (prio 0, i/o): ethlite.tx[1]io
    0000000081001000-00000000810017e3 (prio 0, ram): ethlite.rx[0]buf
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001fe3 (prio 0, ram): ethlite.rx[1]buf
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241114210010.34502-18-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 81 +++++++++--------------------------------
 1 file changed, 17 insertions(+), 64 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 5ab8ae43b2b..758226a65dd 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -2,6 +2,7 @@
  * QEMU model of the Xilinx Ethernet Lite MAC.
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
+ * Copyright (c) 2024 Linaro, Ltd
  *
  * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
  * LogiCORE IP XPS Ethernet Lite Media Access Controller
@@ -30,7 +31,6 @@
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-#include "exec/tswap.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -38,18 +38,12 @@
 #include "net/net.h"
 #include "trace.h"
 
-#define R_TX_BUF0     0
 #define BUFSZ_MAX      0x07e4
 #define A_MDIO_BASE    0x07e4
 #define A_TX_BASE0     0x07f4
-#define R_TX_BUF1     (0x0800 / 4)
 #define A_TX_BASE1     0x0ff4
-
-#define R_RX_BUF0     (0x1000 / 4)
 #define A_RX_BASE0     0x17fc
-#define R_RX_BUF1     (0x1800 / 4)
 #define A_RX_BASE1     0x1ffc
-#define R_MAX         (0x2000 / 4)
 
 enum {
     TX_LEN =  0,
@@ -72,6 +66,8 @@ enum {
 typedef struct XlnxXpsEthLitePort {
     MemoryRegion txio;
     MemoryRegion rxio;
+    MemoryRegion txbuf;
+    MemoryRegion rxbuf;
 
     struct {
         uint32_t tx_len;
@@ -100,7 +96,6 @@ struct XlnxXpsEthLite
 
     UnimplementedDeviceState mdio;
     XlnxXpsEthLitePort port[2];
-    uint32_t regs[R_MAX];
 };
 
 static inline void eth_pulse_irq(XlnxXpsEthLite *s)
@@ -118,16 +113,12 @@ static unsigned addr_to_port_index(hwaddr addr)
 
 static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
 {
-    unsigned int rxbase = port_index * (0x800 / 4);
-
-    return &s->regs[rxbase + R_TX_BUF0];
+    return memory_region_get_ram_ptr(&s->port[port_index].txbuf);
 }
 
 static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
 {
-    unsigned int rxbase = port_index * (0x800 / 4);
-
-    return &s->regs[rxbase + R_RX_BUF0];
+    return memory_region_get_ram_ptr(&s->port[port_index].rxbuf);
 }
 
 static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
@@ -254,53 +245,6 @@ static const MemoryRegionOps eth_portrx_ops = {
         },
 };
 
-static uint64_t
-eth_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    XlnxXpsEthLite *s = opaque;
-    uint32_t r = 0;
-
-    addr >>= 2;
-
-    switch (addr)
-    {
-        default:
-            r = tswap32(s->regs[addr]);
-            break;
-    }
-    return r;
-}
-
-static void
-eth_write(void *opaque, hwaddr addr,
-          uint64_t val64, unsigned int size)
-{
-    XlnxXpsEthLite *s = opaque;
-    uint32_t value = val64;
-
-    addr >>= 2;
-    switch (addr) 
-    {
-        default:
-            s->regs[addr] = tswap32(value);
-            break;
-    }
-}
-
-static const MemoryRegionOps eth_ops = {
-    .read = eth_read,
-    .write = eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
-};
-
 static bool eth_can_rx(NetClientState *nc)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
@@ -356,6 +300,9 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
+    memory_region_init(&s->mmio, OBJECT(dev),
+                       "xlnx.xps-ethernetlite", 0x2000);
+
     object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
                             TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
@@ -365,6 +312,10 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_ram(&s->port[i].txbuf, OBJECT(dev),
+                               i ? "ethlite.tx[1]buf" : "ethlite.tx[0]buf",
+                               BUFSZ_MAX, &error_abort);
+        memory_region_add_subregion(&s->mmio, 0x0800 * i, &s->port[i].txbuf);
         memory_region_init_io(&s->port[i].txio, OBJECT(dev),
                               &eth_porttx_ops, s,
                               i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
@@ -372,6 +323,11 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
         memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
                                     &s->port[i].txio);
 
+        memory_region_init_ram(&s->port[i].rxbuf, OBJECT(dev),
+                               i ? "ethlite.rx[1]buf" : "ethlite.rx[0]buf",
+                               BUFSZ_MAX, &error_abort);
+        memory_region_add_subregion(&s->mmio, 0x1000 + 0x0800 * i,
+                                    &s->port[i].rxbuf);
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
                               &eth_portrx_ops, s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
@@ -392,9 +348,6 @@ static void xilinx_ethlite_init(Object *obj)
     XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &eth_ops, s,
-                          "xlnx.xps-ethernetlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-- 
2.47.1


