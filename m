Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C41D29FBC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rEf-0004ml-Do; Wed, 06 Nov 2024 20:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEd-0004ld-Hq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEb-00035e-FA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:55 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d4ba20075so261749f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942572; x=1731547372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahBXLzYOi7JAIMwBkE8CuwTCS9cRnJa6hRJmMZ1e89s=;
 b=wSsFtyA5thVSZIvPTMcfj1XNl8fIP+fnvYtqGL8EDe8bOKD3rSufXOY919q6UpTKGl
 H2XfLwGwVJa8xAnkFeq8JJtG3s06ba48cKXw4ofDiYkTWrln+uJq14dBQkE31U8w/HE9
 0D6s8kVxWDochMgxc1wIP36C48r5u6TmHjrhjC55s38yf7+ja/7SpbyIlw/aCGasNWdN
 QT/16zyAVoMOruBmB9Fy5DQZ9Ws3fFex74xCVLc6SwAv95RXrJcNc3aW1z5bt0JQl49f
 HS86TLeLhnZPRRDKaR7M905qp/kkuwaQydzg6r+qgg3biexnCx7J2xPaGA/Qv9mi+msn
 ukcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942572; x=1731547372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahBXLzYOi7JAIMwBkE8CuwTCS9cRnJa6hRJmMZ1e89s=;
 b=AkGVpCsVENN1EM1IeCKGl/WInyyCTXaI0q6/LuLesidgDuoq2vhICJbb+i8TP+ut9C
 UolWuxAUGRhvVaiOQ6ZP+0To4PiUYpHUq4yy3FjR9BkrtWsGuHKqQes2IhG6voE5KmGm
 f2HtDn3ag9KwMEKM7rYSV6aZveuy5AemEYYcYVfeYSTHRam476NULSr7dJIL2YTibBb1
 Ho9oy2xNSIy5YG14CGdJmXIIHuNUe8a/w3O/Fw6GMQKtSS3l8zO0fXt3IPO06dA7JXxR
 efujiUQjLBqQC0jInOwUwWZVVVZIj6kkGvvxfRauqxx6Qzulms132WZ6ClJ7allMqu2x
 Dzig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4LZzW892b6BRsOoOpbWHgPASiM3g0whnM05Z2s8yUPcPN17I/vUh/3f9UH7xvjV2bg+Ifkb7EhTjg@nongnu.org
X-Gm-Message-State: AOJu0YzrZjKGeQeWHkvVxNySs3iytHTy+qyzdnd17WzlTNIjbuJrNySD
 zYlEkaJ6rLqpB/UuPN+pbbH6tVK5VTMtN3HnDbStJjyp4U3EKEIWjGv1tNkiUHg=
X-Google-Smtp-Source: AGHT+IFmvuDn80/qJZJ0/3+MGoYVqXc9lTQbgEvElc+t8ldwX/W7PeKqgXuxIlWkYJlDfusLVItldw==
X-Received: by 2002:a05:6000:71a:b0:37d:4e03:ff8e with SMTP id
 ffacd0b85a97d-381edaed24cmr211383f8f.28.1730942571912; 
 Wed, 06 Nov 2024 17:22:51 -0800 (PST)
Received: from localhost.localdomain ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda0ed16sm229106f8f.107.2024.11.06.17.22.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:22:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 04/16] hw/net/xilinx_ethlite: Simplify by having
 configurable endianness
Date: Thu,  7 Nov 2024 01:22:10 +0000
Message-ID: <20241107012223.94337-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +
 hw/net/xilinx_ethlite.c                  | 54 +++++++++++++++++-------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index af949196d3..f2e2dc2fd7 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -121,9 +121,11 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     dev = qdev_new("xlnx.xps-ethernetlite");
+    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
+    qdev_prop_set_bit(dev, "little-endian-model", !TARGET_BIG_ENDIAN);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index e84b4cdd35..d2e7939569 100644
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
 
@@ -161,22 +165,37 @@ eth_write(void *opaque, hwaddr addr,
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
+    {
+        .read = eth_read,
+        .write = eth_write,
+        .endianness = DEVICE_BIG_ENDIAN,
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
+    {
+        .read = eth_read,
+        .write = eth_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
     }
 };
 
@@ -237,6 +256,10 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     struct xlx_ethlite *s = XILINX_ETHLITE(dev);
 
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &eth_ops[s->little_endian_model], s,
+                          "xlnx.xps-ethernetlite", R_MAX * 4);
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
@@ -249,13 +272,12 @@ static void xilinx_ethlite_init(Object *obj)
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


