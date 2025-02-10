Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56145C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thabn-00065b-U0; Mon, 10 Feb 2025 15:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabn-00065S-2B
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabl-0003Xx-1U
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:22 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so48186455e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220138; x=1739824938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wy3ySZz1ZQEjARg3uJtNCm7NxMxde8hFUEYBH3h0BI=;
 b=Xd7IvQmIMe17NWNWxiXXdSAKD01YepENj/gaj/goPG0asY26n/CdW8d88N/e4zJb5v
 V4ck9vDb1lk8IQAR5RRyiNDgJw4eE7pvVEvKrJl5GbxA4Ag/JMSDqnguyQ78EMGd5eKv
 4eCYhG98zTbbdd6/iwkh0r/3dab4ErZYRsa+QXoUUl0WAWXJb55HnJlzq7gQSXzhaRO6
 KogKuwmfYSr6tfYBkyJttaIHbmiAOjDGa0dsCJYgYEzOTBcWxu1y4KmH1jxypLmHx/mK
 JauOKETgdnlb4LkfQC+x1vCs3YhgP1a15MkgRxp+3dWUFAiXDeGGLc3be0sDC+KEKJyL
 e9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220138; x=1739824938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wy3ySZz1ZQEjARg3uJtNCm7NxMxde8hFUEYBH3h0BI=;
 b=sbMgh3W7xpexH3t4L0PmD9KPW5KkEm7Bz6kbLBDsPMzYvcsx41XIqV2B4qMR8Q8nly
 1LrVuL/O18xM68CmdaPV853kTw+IAuxidKJ8DwuufENsq/PkXt9zqhD5BeXykLrn/3Oz
 pAXMwfUNmyJCbeWCITw0YxPXzcY6h2nTUJD/aZ56LbsmVITOu4Pv6AXUNELCXr3GChH3
 lm0an+x3WlSMod9Btj8uScz/jlwx43rVY66q7yJOe4S1Ik/C8KTB12BsEjX5VRp1vTy6
 6PnUx7S1ekGa8SRd9x26/dJdgTIrajZy06erfGUMKJKmjLbGnW5mZJlb5yMUcH7ki0BV
 Z5IA==
X-Gm-Message-State: AOJu0Yyk5i4HQNByMAAz/NtXowLJWJJ5YgjruzGbZdpOi7NWVl92y9hN
 vMyZP4OuYEXqD8INtziAXUi16QteeHKncOcjUT0Sk6Tv2gpVeyAbLpnYNjPtnYyDDF9Zj60VU/P
 B5JI=
X-Gm-Gg: ASbGncucIdlTo0qyVdDmEhobg1wUtG7mK+cKLPc56nRoQx46wQkLZ5nQAn/P+fiJDha
 ckd70AkIP4LM+z5gr3my449A9mHqOPqZRvxHFDsaEBDvpsld02us87w6AiZWEE2EuaTQr9IrOc8
 VZd7DRNY1fqVnIE+6Hw70FVFZHWzBtaQ90cK2aTL2AeowYM4NWquZCSdDCtXV4Q0b8GTe2IWXLC
 0z2fCceuZd8FpyK+GEFnE6trF276fB97/Xf15QbyrjSp6mKBtnVyi47pAwxShqas1xQBUr179lB
 cB8w0SgY3qZD6MvF3uA2x4ERq7ubVlpgXHJqHSxGasBxH3uuQuqqo2Kyh88BQJ1qeg==
X-Google-Smtp-Source: AGHT+IFlGIMjH6uZcU2wP70arUkuL+RAWu+JFd3qmC2X0YgF8p8wEEn4Fpwp/J0hMCEjUVgKptRZ2g==
X-Received: by 2002:a05:6000:e48:b0:38d:b6a9:2cd2 with SMTP id
 ffacd0b85a97d-38dc937347bmr9349357f8f.46.1739220137758; 
 Mon, 10 Feb 2025 12:42:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd18sm13166529f8f.72.2025.02.10.12.42.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/32] hw/intc/xilinx_intc: Make device endianness configurable
Date: Mon, 10 Feb 2025 21:41:34 +0100
Message-ID: <20250210204204.54407-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness for each machine using the device.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250206131052.30207-2-philmd@linaro.org>
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


