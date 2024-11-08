Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87D7D5C0F5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R9X-0003sx-MW; Fri, 08 Nov 2024 10:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9G-00035a-87
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:46 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9C-0005S9-Bw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:45 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso19453735e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080620; x=1731685420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jztEo/+GQMsNL+O6RII0AfRvEqFktG+ZuY9PKLU7Y+w=;
 b=YdfIhHtMCTkN3S9XNqE9VoZDJlZs3SJFoUBSGx3kCaavt8VsZ5Yo4YnJjpT1eYQljF
 IPKaUgW1ab4iONYSlDbtYBaggPR6hKulDdSCUj/1y4kxq0IFd1qLjBzMlPHKOOjK9UwQ
 bfbRkrYt6Cn0GSC9ZLfSJ6UYiZdb1wAHy2nAmRWLkD/UzUP8jSPqxTxP5bqeffonVVqZ
 +87eSjFBM88VkBDVc0RyOCbP2x61ShBHrhsebAdV9c7nd9tNE06jPeKvYGsN25CGocv9
 BIRIqxTF+APM5eVji3lUPwTqCrhwkuYIuBpJjRqyLmwqXe1raNqpKJ0U6vsmfaLX1E4u
 rwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080620; x=1731685420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jztEo/+GQMsNL+O6RII0AfRvEqFktG+ZuY9PKLU7Y+w=;
 b=Q3Jnw942Fv7LA9fETmUUmmGY/KF/mbZQNzF5UUXRn6JltI7Ca4vTjv5x0fVLPjF+mf
 gc3trD8OPKnC8AQsuu1fWIWYOyC7zPLtkS/B0qlR31nUbk/dUysUZz8MvBy4Hhy+w/+I
 6vgoU+V0+z07D32y5RXbA9H7b9+cv0KxcelkOc672BRBdDjBaO/Ie30PYrgdvZJxStqW
 LXb3HfkFeBIT8iiB1h6h1TeUMiAat1y62O2rWTyDK+wFmKqlK0mCufd/oo3IFzTMKnn2
 bYJOw651skY1TILCCKKt1w5cg33rtjIVTExPTACd0Pveb0cVJguaHX+4OnxxXG7zraCM
 wa/g==
X-Gm-Message-State: AOJu0Yw8BxeqyGfO/sIyg34jmhx4kC/keONmJ46pq1iXtmzwkAhQEKs8
 h5HgRrfzg+pZ6Jiosgnm0R++r25Gs5Mz32MuvOY+EXYTREh/ve21ZdFaZKgS0VMvq7Q2gzvjJ0M
 T
X-Google-Smtp-Source: AGHT+IF4Ugi9i4ohYJ6/e/reb5mP7ZkKvdFRLOQDtGNOw2OnU1DRbDqdGn8AVX3iYc0JeXIcm9zFdA==
X-Received: by 2002:a05:600c:8715:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-432b75199famr24760155e9.32.1731080619895; 
 Fri, 08 Nov 2024 07:43:39 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda0411csm5171097f8f.95.2024.11.08.07.43.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:43:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v3 04/17] hw/net/xilinx_ethlite: Simplify by having
 configurable endianness
Date: Fri,  8 Nov 2024 15:43:04 +0000
Message-ID: <20241108154317.12129-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The Xilinx 'ethlite' device was added in commit b43848a100
("xilinx: Add ethlite emulation"), being only built back
then for a big-endian MicroBlaze target (see commit 72b675caac
"microblaze: Hook into the build-system").

I/O endianness access was then clarified in commit d48751ed4f
("xilinx-ethlite: Simplify byteswapping to/from brams"). Here
the 'fix' was to use tswap32(). Since the machine was built as
big-endian target, tswap32() use means the fix was for a little
endian host. While the datasheet (reference added in file header)
is not precise about it, we interpret such change as the device
expects accesses in big-endian order.

Instead of having a double swapping, one in the core memory layer
due to DEVICE_NATIVE_ENDIAN and a second one with the tswap calls,
allow the machine code to select the proper endianness desired,
removing the need of tswap().

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device endianness,
defaulting to little endian.
Set the proper endianness on the single machine using the device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC until I digest Paolo's review from v1:
https://lore.kernel.org/qemu-devel/34f6fe2f-06e0-4e2a-a361-2d662f6814b5@redhat.com/
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/net/xilinx_ethlite.c                  | 44 +++++++++++++++---------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index af949196d3..f02d343e29 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -121,6 +121,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     dev = qdev_new("xlnx.xps-ethernetlite");
+    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index e84b4cdd35..5c27f1250d 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
+ * LogiCORE IP XPS Ethernet Lite Media Access Controller
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -25,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "exec/tswap.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -60,6 +62,7 @@ struct xlx_ethlite
 {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
     qemu_irq irq;
     NICState *nic;
@@ -103,9 +106,10 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             break;
 
         default:
-            r = tswap32(s->regs[addr]);
+            r = s->regs[addr];
             break;
     }
+
     return r;
 }
 
@@ -161,23 +165,26 @@ eth_write(void *opaque, hwaddr addr,
             break;
 
         default:
-            s->regs[addr] = tswap32(value);
+            s->regs[addr] = value;
             break;
     }
 }
 
-static const MemoryRegionOps eth_ops = {
-    .read = eth_read,
-    .write = eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+static const MemoryRegionOps eth_ops[2] = {
+    [0 ... 1] = {
+        .read = eth_read,
+        .write = eth_write,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
     },
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static bool eth_can_rx(NetClientState *nc)
@@ -237,6 +244,10 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     struct xlx_ethlite *s = XILINX_ETHLITE(dev);
 
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &eth_ops[s->little_endian_model], s,
+                          "xlnx.xps-ethernetlite", R_MAX * 4);
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
@@ -249,13 +260,12 @@ static void xilinx_ethlite_init(Object *obj)
     struct xlx_ethlite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &eth_ops, s,
-                          "xlnx.xps-ethernetlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
 static Property xilinx_ethlite_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", struct xlx_ethlite,
+                     little_endian_model, true),
     DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong, 1),
     DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong, 1),
     DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),
-- 
2.45.2


