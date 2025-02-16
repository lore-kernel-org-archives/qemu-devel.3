Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10542C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlln-0002zq-KU; Sun, 16 Feb 2025 16:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlla-0002yB-Ft
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllX-0007uw-Mk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43963935585so36581005e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739685; x=1740344485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4BWG0UyJBMGuNS/Yd69+AKuKZVB4ktl8qLDFtIcsAU=;
 b=r6md0mqlP3aLLP9jSi6zD3jaj7rlcWdFWNcdI7mvP+RVyzBldhsNxVTkWJOkE1zj/7
 pl8F6n4x0n1avFOr+QILBgj56mtsE4qDfbvSlUrmFurdxfEufLgU2JdhqL8VgWJANjOy
 7Zzzqn8IYJLk1ss9a8gmPFnTc4OkFOuSuTKcxwjR21EGx4d2KHaitsHuaJkl6kcuqq9y
 X3s7seri0w98UlA81IsRXrSE0Bmt+8u/HLmjwUV/RAEegCA2CdXxqphieGEUfZayzyZZ
 PWcZQDYHC82WXNVV6EGAZ/Gl5UTM85sDuIl8iWmfBoZlyl8EumFBAcus3HANw71diMcv
 fdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739685; x=1740344485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4BWG0UyJBMGuNS/Yd69+AKuKZVB4ktl8qLDFtIcsAU=;
 b=ivGzhcd1YtVjBgnu8q1K7pWPYXNqqwXDRSKn6zoULmN7kHxVUTaolEtIuMjNry0b5/
 S4AsknqxHTHFr5pRSaOYk6Mj6YIzlsRk0orDSORYWS0sO6D/zJgkH4ILRz+nOOTC3kO8
 QoLN0dwxg6zSLwZK7bsFYmHovfig9j2ygh58TyNeSB2Tlp56rCPGTL7YIlQJ6aBb30uM
 pHK/q9oJKj2axW+COgVhmzcIu1kwjhGAMyEz8zZ2QnQpgnWX7c9cqitPlszN18hVcEex
 9+IMTOYhOBKaWySckKjLDO3JRUrKKxtpTr3M9aGP6Som2P+QwArwyHok6eKiitOnm757
 SWLg==
X-Gm-Message-State: AOJu0Yw2On7KWBXkceJwWGKtxnS1I3bXCQ3SfKcpmJR3kuN0tz8NjRSK
 Ux7GGs6VwlyCIh1GVFlcj0BjkMc57xus5P6+C8bYUv7LROEUcK2mWlWausMtwRGvWYgChJ8I2BR
 xAy4=
X-Gm-Gg: ASbGncs6y5h6yGAaIPrkpJE2ECsWQPV56uG6en94pH2eN950tSAuUnOyFm5zdPK9hwA
 K9bn+vMzg0KukrylLfti+GZtLpMu9ty5mc55pk+WCoHtiKDS8JLg2lEtFqR2M+yhHPe4az3EcFE
 4nJ0VmfSTIxjj/c5l68BaTLWcQpG3kcrVH+AcV0s8ynMFGFf7ioTdr300b+RbU2lFtyFzAvcW9u
 3UyO9AQoT70fBQTiwulNYFFHpBwoAljMFgHE9CeG/QeTx1TJJykLnGSlNvT0R44BOlSqTFRWUkv
 hEUPCPGvxSEErMcRNi71FHNTYNFApmFgtzWSilB0D1Rev/DLn2bBv4/15h9EMTJABqTY3oU=
X-Google-Smtp-Source: AGHT+IGEEkKPj0wHBIJOXAl5ZUItljitJyNHWtI7AVLxUjVhQ5MkdUd5DCtSrdzdTk+ouOOZjljVOA==
X-Received: by 2002:a05:6000:188c:b0:38d:c557:1147 with SMTP id
 ffacd0b85a97d-38f33f4e5bbmr7555699f8f.51.1739739685581; 
 Sun, 16 Feb 2025 13:01:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915688sm10599309f8f.57.2025.02.16.13.01.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/39] hw/timer/xilinx_timer: Make device endianness
 configurable
Date: Sun, 16 Feb 2025 22:00:56 +0100
Message-ID: <20250216210103.70235-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.

Add the "endianness" property to select the device endianness.
This property is unspecified by default, and machines need to
set it explicitly.

Set the proper endianness for each machine using the device.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250213122217.62654-5-philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c      |  1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/ppc/virtex_ml507.c                    |  1 +
 hw/riscv/microblaze-v-generic.c          |  2 ++
 hw/timer/xilinx_timer.c                  | 43 +++++++++++++++++-------
 5 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index a876aeb0bba..984287fdc53 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -129,6 +129,7 @@ petalogix_ml605_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index d419dc49a25..caaea222a8c 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -116,6 +116,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index df8f9644829..a01354d991d 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -231,6 +231,7 @@ static void virtex_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index a21fdfbe6db..3c79f5733b2 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -104,6 +104,7 @@ static void mb_v_generic_init(MachineState *machine)
 
     /* 2 timers at irq 0 @ 100 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -112,6 +113,7 @@ static void mb_v_generic_init(MachineState *machine)
 
     /* 2 timers at irq 3 @ 100 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 6595cf5f517..4620528f985 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * DS573: https://docs.amd.com/v/u/en-US/xps_timer
+ * LogiCORE IP XPS Timer/Counter (v1.02a)
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -23,10 +26,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -69,6 +74,7 @@ struct XpsTimerState
 {
     SysBusDevice parent_obj;
 
+    EndianMode model_endianness;
     MemoryRegion mmio;
     qemu_irq irq;
     uint8_t one_timer_only;
@@ -189,18 +195,21 @@ timer_write(void *opaque, hwaddr addr,
     timer_update_irq(t);
 }
 
-static const MemoryRegionOps timer_ops = {
-    .read = timer_read,
-    .write = timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+static const MemoryRegionOps timer_ops[2] = {
+    [0 ... 1] = {
+        .read = timer_read,
+        .write = timer_write,
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
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void timer_hit(void *opaque)
@@ -220,6 +229,12 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
     XpsTimerState *t = XILINX_TIMER(dev);
     unsigned int i;
 
+    if (t->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, TYPE_XILINX_TIMER " property 'endianness'"
+                         " must be set to 'big' or 'little'");
+        return;
+    }
+
     /* Init all the ptimers.  */
     t->timers = g_malloc0(sizeof t->timers[0] * num_timers(t));
     for (i = 0; i < num_timers(t); i++) {
@@ -233,8 +248,9 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
         ptimer_transaction_commit(xt->ptimer);
     }
 
-    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, "xlnx.xps-timer",
-                          R_MAX * 4 * num_timers(t));
+    memory_region_init_io(&t->mmio, OBJECT(t),
+                          &timer_ops[t->model_endianness == ENDIAN_MODE_BIG],
+                          t, "xlnx.xps-timer", R_MAX * 4 * num_timers(t));
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &t->mmio);
 }
 
@@ -247,6 +263,7 @@ static void xilinx_timer_init(Object *obj)
 }
 
 static const Property xilinx_timer_properties[] = {
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XpsTimerState, model_endianness),
     DEFINE_PROP_UINT32("clock-frequency", XpsTimerState, freq_hz, 62 * 1000000),
     DEFINE_PROP_UINT8("one-timer-only", XpsTimerState, one_timer_only, 0),
 };
-- 
2.47.1


