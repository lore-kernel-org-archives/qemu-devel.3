Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E2C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1es-0004z1-Dg; Thu, 06 Feb 2025 08:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1eq-0004yI-Me
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1eo-00080O-P6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:04 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso5890725e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847460; x=1739452260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=503eeF5KhCNoQH5RB4G8vUQc3vp07cA9yV4AIGoAB5A=;
 b=Of55DvB6vd+SPEzGdUwkBcgo7J8Nav2wQvUKPeQsIDYWx+PRr6iNZ8tCKqwFxDWqTi
 1Fyysh14Ee+2FfJtIEMrovg6VQAZXswYSw4r5eIdEPZj1oxPhwMsCDqKO/HbfpPRLUGc
 kS50brSJTW+wr6x5xGq2Byb73GhiUBq4g4n4tmnZiNgsBnRD6QnMqM2I6NbY30FB8LBJ
 pazOejYnyhN2hukS0+oPgTcwebgEWE0TrtVD7y8o5hdNbbGfmj8NuC+J0QJTZRt/O1yX
 cJQ2R++uqqAQer9Pwlo71Xh3wKbv5DE3VzH9iUANsdNtPN1V6aqVtISxYI7QZqcH5JAY
 RTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847460; x=1739452260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=503eeF5KhCNoQH5RB4G8vUQc3vp07cA9yV4AIGoAB5A=;
 b=rlYy/VrX6RBaRfhVaA+497Z4CzKZJEeo2yC45z3CkPJcU2dy+pNvb3+QRJSkag3+Gg
 8VP/KXMXNr1uHIWrgaX1xJm0JENTOu39KRC1iPb7TpxsSz7hk4q3tSA8DPksMnOa0m0H
 wb6MC0NhB3jSCgtnBBe03zPjKBgMOI5ETQnJA1pPersxXI4vtX7HXIpT5T6FY2MBKSHo
 DGvY3K0MOeTRUu5r0fLc66UGTRP7OTXkIaPB0kKhLh5xLVBgIAd6+gIFQP6NYA3tjat9
 EZs/Ypcp7BTtRgPeWNc3+N3CZtrnAUhRvNEmv4+Z7mC9ppo25QDp1JNX6tc/ImtIyf7d
 xJMg==
X-Gm-Message-State: AOJu0YwAiWhMf33w08QnGSgZdp+xHxKUceUmREq5sIUMY9+ZnEC/z6SD
 5f0YkX33dtJLN9MOHOhruFt2Nfqmnp4S8rPp6gGYRMSz28J8cDqWY8/46ZPO+ZkebSF91mnxkNA
 DX3A=
X-Gm-Gg: ASbGncuNZTLloXJHtsWak6BOOqArte2m7bCc6lBljDzE7beeeWCLgxCbUgQ32OFjCl/
 kCPZzU/MOyvyigVNoR0sUTRJLPO5zNd3+HfHYcgRpe0+sQHDQydr0hy8689C8BruiI1Ngyzy/px
 7ACgfscVijyCFdGsP9vm9gaBevuFoBDxhIZ2wIjCQFYPLzv9hofDX8g0cO3itq1WGPLkRcg9t4l
 hqPK3WpB5DlA6SE/d+iysh5QSf4XPbNU/7Of4PCBXhldPMKjNdZcxK3pTbxAPQeETzLPcigaVgU
 Dyyzr/o7zqsmlTK/fzCKYlofmqw7I714oQ2EA4lTRV2MzX/lxvBeptV2lRiA9oGXGw==
X-Google-Smtp-Source: AGHT+IHKlu2o4uRkJKB+8J5veGT8Lc19gu0iqnznoKxVLLB90TPa1KMg2rn51WCVtERc21hvXep+Qg==
X-Received: by 2002:a05:600c:3595:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-4390d4347ddmr70713625e9.11.1738847459396; 
 Thu, 06 Feb 2025 05:10:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd35742sm1685808f8f.21.2025.02.06.05.10.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:10:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 01/16] hw/intc/xilinx_intc: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 14:10:37 +0100
Message-ID: <20250206131052.30207-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness for each machine using the device.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/xilinx_intc.c                    | 52 +++++++++++++++++-------
 hw/microblaze/petalogix_ml605_mmu.c      |  1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6930f83907a..cd79ac4d4ff 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * https://docs.amd.com/v/u/en-US/xps_intc
+ * DS572: LogiCORE IP XPS Interrupt Controller (v2.01a)
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -49,6 +52,7 @@ struct XpsIntc
 {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
     qemu_irq parent_irq;
 
@@ -140,18 +144,29 @@ static void pic_write(void *opaque, hwaddr addr,
     update_irq(p);
 }
 
-static const MemoryRegionOps pic_ops = {
-    .read = pic_read,
-    .write = pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+static const MemoryRegionOps pic_ops[2] = {
+    [0 ... 1] = {
+        .read = pic_read,
+        .write = pic_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            /*
+             * All XPS INTC registers are accessed through the PLB interface.
+             * The base address for these registers is provided by the
+             * configuration parameter, C_BASEADDR. Each register is 32 bits
+             * although some bits may be unused and is accessed on a 4-byte
+             * boundary offset from the base address.
+             */
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
 
 static void irq_handler(void *opaque, int irq, int level)
@@ -174,13 +189,21 @@ static void xilinx_intc_init(Object *obj)
 
     qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &p->parent_irq);
-
-    memory_region_init_io(&p->mmio, obj, &pic_ops, p, "xlnx.xps-intc",
-                          R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
 }
 
+static void xilinx_intc_realize(DeviceState *dev, Error **errp)
+{
+    XpsIntc *p = XILINX_INTC(dev);
+
+    memory_region_init_io(&p->mmio, OBJECT(dev),
+                          &pic_ops[p->little_endian_model],
+                          p, "xlnx.xps-intc",
+                          R_MAX * 4);
+}
+
 static const Property xilinx_intc_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XpsIntc, little_endian_model, true),
     DEFINE_PROP_UINT32("kind-of-intr", XpsIntc, c_kind_of_intr, 0),
 };
 
@@ -188,6 +211,7 @@ static void xilinx_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = xilinx_intc_realize;
     device_class_set_props(dc, xilinx_intc_properties);
 }
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8b44be75a22..cf3b9574db3 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -111,6 +111,7 @@ petalogix_ml605_init(MachineState *machine)
 
 
     dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_bit(dev, "little-endian", true);
     qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2c0d8c34cd2..0506497ad0a 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -95,6 +95,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.47.1


