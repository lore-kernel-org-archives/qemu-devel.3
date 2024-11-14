Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C27D6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgzJ-00046T-Rk; Thu, 14 Nov 2024 16:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgz3-0003nZ-Bs
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:34 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgz0-0008Bn-7u
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso9090315e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618147; x=1732222947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zyez6NwJ+NWOqgUSWAy7md/NK0fDCEDRWAipgrG6RPE=;
 b=UIC/4e0/GdnWeKfivzM3hhUIqCrlR4PCtR3dA6cjOKM2efERnjFVraCzLRqirPU7Lk
 gz/vK98Fel3crvQQLpxstgioOyPTMZFXv2yNN5F2pjQyEHQVl7dy6/jRxqolBZpqOsnf
 TQlAWFPrsK2o5eEhMUR3iFTLjRfzC6zx+st4Y0A5jyfTcF7LzjI6D7O/0tp6fpYG+cGH
 j4t0TJwqHsDOg6s5MJuRDfphuZjDhLCgCtQOdYkXtqU1togbHDgHQVY5QoVS+pd6VbD0
 40LPKtXyvXIepMWMt5VR5zxzhqIMIohWEwfb5ekG1X8awcXnWCGSRh3U5iauEhiErcMN
 PQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618147; x=1732222947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zyez6NwJ+NWOqgUSWAy7md/NK0fDCEDRWAipgrG6RPE=;
 b=pFIRoq+l9rjhKobr/IjQ1qqrWcuNnZooymY3CDuxVUILl3jHq0hAZq/5mmBPzXpO6K
 zYIE+OsJVZCtoixvej4rLFO4dab6Ap4u2zZa4qauuG3tT6uP/TKI+WVUMJXqkVyskosy
 b3e67wSXicn2SQp4H9hXQcolEa2RXqoAudRxl+dW12oLKt2vw2WRBDkF++v8YMJFcAX7
 bybJIEZm9guD01jVhiFsO6j3iC/cNz/HMVEoNxhc0+PWka3jKeO5nigtHgO1C4nl9CF7
 1I+Qe/cRM5BnL3EPO7qK7l4B8jH+Nzjaqppfgfwh+WQOXZWXyztMyJ1qRf47b+BFqene
 nBbA==
X-Gm-Message-State: AOJu0YyhgBZCO9RvKSJs+ASf2HSE34v3LnYNlh2G/zatT3tT0qxPwByh
 +N/EG/Xt2bhX+fc4FVX+vT2aTMp1bHVmimUHLsNTxZ8XA9ZYXrPkdsf8UJEuVha8zEws/MnHXL3
 Z
X-Google-Smtp-Source: AGHT+IF0vMn1efA+vjIKhjHx3bd3mJpsOfrvgOpn8N5De5ukFbPxlzVFGkSopA2D/YmhkYIwPkck5g==
X-Received: by 2002:a05:600c:46cc:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-432df78d75fmr1538675e9.31.1731618147481; 
 Thu, 14 Nov 2024 13:02:27 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab78918sm31872625e9.17.2024.11.14.13.02.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:02:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 17/19] hw/net/xilinx_ethlite: Map the RAM buffer as
 RAM memory region
Date: Thu, 14 Nov 2024 22:00:08 +0100
Message-ID: <20241114210010.34502-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/net/xilinx_ethlite.c | 81 +++++++++--------------------------------
 1 file changed, 17 insertions(+), 64 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index c710857cfd..0d445653b2 100644
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
@@ -73,6 +67,8 @@ typedef struct XlnxXpsEthLitePort
 {
     MemoryRegion txio;
     MemoryRegion rxio;
+    MemoryRegion txbuf;
+    MemoryRegion rxbuf;
 
     struct {
         uint32_t tx_len;
@@ -101,7 +97,6 @@ struct XlnxXpsEthLite
 
     UnimplementedDeviceState mdio;
     XlnxXpsEthLitePort port[2];
-    uint32_t regs[R_MAX];
 };
 
 static inline void eth_pulse_irq(XlnxXpsEthLite *s)
@@ -119,16 +114,12 @@ static unsigned addr_to_port_index(hwaddr addr)
 
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
@@ -255,53 +246,6 @@ static const MemoryRegionOps eth_portrx_ops = {
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
@@ -357,6 +301,9 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
+    memory_region_init(&s->mmio, OBJECT(dev),
+                       "xlnx.xps-ethernetlite", 0x2000);
+
     object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
                             TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
@@ -366,6 +313,10 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_ram(&s->port[i].txbuf, OBJECT(dev),
+                               i ? "ethlite.tx[1]buf" : "ethlite.tx[0]buf",
+                               BUFSZ_MAX, &error_abort);
+        memory_region_add_subregion(&s->mmio, 0x0800 * i, &s->port[i].txbuf);
         memory_region_init_io(&s->port[i].txio, OBJECT(dev),
                               &eth_porttx_ops, s,
                               i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
@@ -373,6 +324,11 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
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
@@ -393,9 +349,6 @@ static void xilinx_ethlite_init(Object *obj)
     XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &eth_ops, s,
-                          "xlnx.xps-ethernetlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
-- 
2.45.2


