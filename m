Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E8DC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thac0-00067G-79; Mon, 10 Feb 2025 15:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabv-00066U-PW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabt-0003ab-KG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38dc33931d3so2063167f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220147; x=1739824947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxnVqTrw69QSOa26f2GLgtndlndnd+p0IrIRgpQeBXY=;
 b=CaLkFbNQaufLSaZt/3GgdFgSt6PHjU0eUKRON9j+rKf8uXFNZQsZHZ4F19xWLkWet3
 xuturYDUadzaNbFPlUKJkvHODoBPhyOZk7HTfyCYvlNSgJb1NLXwBLQGPvWOBL4mLD8N
 FMvP/iJxUcsZXEjzK7k6e5L3JAKOjBCAiDmvuDYrzwzV9lJV9M/65CkW43HqXZ81xNIt
 8zteiLkGp8rKTwzwIUs87xONG34Rm+3VxVCYovWPTJauJsOkyuubkmaErtFd+BExXqlp
 nDkhxFH8lyXFD+rlpjwyeCo8XJb5aq7UO4Hp7msxa4Jzjb2c1/rXhY3jP7L9DN+qA5IB
 c8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220147; x=1739824947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxnVqTrw69QSOa26f2GLgtndlndnd+p0IrIRgpQeBXY=;
 b=WebwFN3/5FOjr//xWMvAqOFXbPX6OT8WVHOZu3KmjPizmD4UpuS0mpIcX9AFzTmkja
 vMNyJPAnkhYCaVP+4av5/KicqTXhq7jR61jBVo42hUswGAwxR3L0571PIprZ+iDQxpfK
 DvU2blkoEoUXzq1ywskveRxaTeeSSgD7tbW1bQevntGQLYuuDMomwfy85+2/3L/WD0Rv
 J82UYf4n9OCjHWCKvKneE3vBPnfLRXkX5rT3446t9/TlmnXcrt2LKintdUkDt43JvViE
 dxGOYnng+pK/3GGgOHTR9wRd7y2TkgWaHVe4VX/T5/8sWftFrt2+9LfLOfOa8Yl0Wo6d
 1p0A==
X-Gm-Message-State: AOJu0YxJ3VpUufyyk8RTrRS60SaxWvuENEgFOVP69/7/DklzLs84uMk5
 vsGglKdb9WLWcP9u8hcGHIiIox/Yv9tEQZ+4sY4Stm8oS43mDNU/SVxGEX2T0RQHAYZYjE6Gb5b
 gnZY=
X-Gm-Gg: ASbGncvJkIfHTWDrw4Usudra9L0JUSOLHf9Y0Xq5x0ima+720xpCIsv1gdJdwHtYv7z
 2ixJrmrTsWB/M4dvNAmfJWPDymgaamLJVqKji6WAbjj7vUIE7IjFYzLooNQNMsGba1+mBvVlPam
 hXP/Ahl77+4FEOLnhS2bUJf+nD+/isryP37VS/5DxxKG/kzdso1hGqTwqi6Fy+LMln1GyD33/ZE
 uovG8s6UUVg+vPI0cO6bVL7TS7VkpNWpFkfePIRkToXlgf9UcqWL2MwBMhZk7kCfdJgSfThNasn
 ekqPnoij5VZ7vGyk8vE3j32nxz92JzWE1e3BA7cZ40pzPe408rydv8pI6hR8gQh4tQ==
X-Google-Smtp-Source: AGHT+IFyf8RL1daNzM4j/8yahBQRjnEW3H26fYIFfVSNbuptJeFg6qR6lwuXskyc2p4i+u/G+DZlFw==
X-Received: by 2002:a05:6000:1fac:b0:38d:d8c0:1f8c with SMTP id
 ffacd0b85a97d-38dd8c023f7mr7909327f8f.38.1739220147257; 
 Mon, 10 Feb 2025 12:42:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dde7d3f8asm3800777f8f.21.2025.02.10.12.42.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/32] hw/timer/xilinx_timer: Make device endianness
 configurable
Date: Mon, 10 Feb 2025 21:41:36 +0100
Message-ID: <20250210204204.54407-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Message-Id: <20250206131052.30207-5-philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c      |  1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/ppc/virtex_ml507.c                    |  1 +
 hw/timer/xilinx_timer.c                  | 35 +++++++++++++++---------
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index cf3b9574db3..bbda70aa93b 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -127,6 +127,7 @@ petalogix_ml605_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_bit(dev, "little-endian", true);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index fbf52ba8f2f..9d4316b4036 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -114,6 +114,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 23238119273..f87c221d076 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -230,6 +230,7 @@ static void virtex_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
+    qdev_prop_set_bit(dev, "little-endian", false);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 6595cf5f517..d942ac226e6 100644
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
@@ -69,6 +72,7 @@ struct XpsTimerState
 {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
     qemu_irq irq;
     uint8_t one_timer_only;
@@ -189,18 +193,21 @@ timer_write(void *opaque, hwaddr addr,
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
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void timer_hit(void *opaque)
@@ -233,8 +240,9 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
         ptimer_transaction_commit(xt->ptimer);
     }
 
-    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, "xlnx.xps-timer",
-                          R_MAX * 4 * num_timers(t));
+    memory_region_init_io(&t->mmio, OBJECT(t),
+                          &timer_ops[t->little_endian_model], t,
+                          "xlnx.xps-timer", R_MAX * 4 * num_timers(t));
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &t->mmio);
 }
 
@@ -247,6 +255,7 @@ static void xilinx_timer_init(Object *obj)
 }
 
 static const Property xilinx_timer_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XpsTimerState, little_endian_model, true),
     DEFINE_PROP_UINT32("clock-frequency", XpsTimerState, freq_hz, 62 * 1000000),
     DEFINE_PROP_UINT8("one-timer-only", XpsTimerState, one_timer_only, 0),
 };
-- 
2.47.1


