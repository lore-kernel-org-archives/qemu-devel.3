Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD29C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg08n-000776-Ug; Thu, 06 Feb 2025 06:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08c-00072n-7j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08a-0000qE-8a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso4307695e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841618; x=1739446418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hjV9qje+F9WM+1u7JaIIDgc7g6v/WUaxTXGCOTYvnI=;
 b=VPaL2ME7+Jyvnt33FsYFz0VcSH5barU2RrW4u4ErW67S5PC6XdbxXx8PN8Lvd3q3Mz
 utUcJ1SBJm0YOJL+nHyM2N1a7zaiiDpupwOqkBKHLKV4EMa6/iwCwwWBXnsf0iqV1Y82
 S7PM0GMDkET0TBvH3D9FrzHyKPAIkbrDCO8x8/znMyYr2x5HLYBWKFhVYgjr8TZ43M8m
 btgca6aUkj5zdqxhFI4I/ootefVvcGBXoZW9rvHnlekjCuWzjdjw5N0eDZsgkpzIQsgy
 7FO6xXL1nH2nAZ13DogD3VyW5QKhM04uaFb8X4zb53UeTDQUQc0M9rpgvAPzU7RWmYPE
 ohuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841618; x=1739446418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hjV9qje+F9WM+1u7JaIIDgc7g6v/WUaxTXGCOTYvnI=;
 b=Sq6ywV7sWwvaSa4GaDjCP++TktN7zotNgjCk231+Ue/aJJdrLAd7cxELS/rdvEt5EE
 cnsOodF5mr8YNxyqByVdZbjMaRDzwYwX4mfWc+QVUt9QlyA4z0I5rRcoVzduX145ujJN
 npRj2WJwCpYlVPyNYzdTxqMFjxmhjZ9NwZcbdw3Sz+4gCWX9dENzYXA5GyF3/km2ipu5
 Hdc4/Vx187HqOhzSxGzz34sN11ypMzv9LuHQs9u5iEuZyshXA3tyt1K9d7BsYRqrbc1N
 Mq+4OD72gb8jQSRzG9/wlyBrJvYmaOKwpG7cGKQPASvGZ9s62Jem9X7xy30RS6U00TbX
 OcWA==
X-Gm-Message-State: AOJu0YwUnmO9mnGKSH7RIfoCWzK2AYiiF7yG/v40JXmzqX28+xLkAjni
 nieb0cpzP6cOXFiwUfr2d8PFD79e1t2JJrAf5v9qxdSXzbAdcCsvY0D8l+N8vvZUDo97PlaKujj
 qnfo=
X-Gm-Gg: ASbGncs1DBSaIw/4+ZZ1R3WF6taJG2jsmkA37HL9ujXqGhgeUwZbYT7CiBCn/mQhvB4
 IYodvxBhCgz3zOd8uQt8RJ8Exxp6xV2GPhbZRLkA3d0BC2ldpqBUYK46uL7qedmd3kODJro7M8F
 vZ9cbA/0aaOM7X4ICLZWLzbmAiRXINOFuB5zubEa5vPX6zSrTo78JFVy7SBxY+C7Y4OR6RkYdt6
 T5IqhswlXiAT18aeJbmhVaOsMFRPpd9S84NLMiOWq3rWGA5jvyX4b59Oehu5/xw+ZVuhdJAuJoe
 L1GLvE9JWcT7iZ93iTcybY7acbt108fiAhesUZ3/mHit/Hqi6lZKZAKPf/aycrkPHA==
X-Google-Smtp-Source: AGHT+IFUNyBIFgj9CpRFxe2jRvx6kSil4t/OnSl/ZMH9t3+PUQAPrlZRTdAb+DOpSma1P8PpxgjNVA==
X-Received: by 2002:a05:600c:4f50:b0:434:ffb2:f9cf with SMTP id
 5b1f17b1804b1-43912d3f2f9mr20851085e9.14.1738841618150; 
 Thu, 06 Feb 2025 03:33:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd00sm1497546f8f.78.2025.02.06.03.33.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:33:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 03/16] hw/timer/xilinx_timer: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 12:33:08 +0100
Message-ID: <20250206113321.94906-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
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


