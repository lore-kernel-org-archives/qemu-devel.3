Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B27D5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R9k-00052x-76; Fri, 08 Nov 2024 10:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9S-0003dj-5n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:58 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9Q-0005Wf-Cy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso20059635e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080634; x=1731685434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gmpb3Wgw7d9JZF5PrdGS8a2GyTd0IHtG2ing10Pn98=;
 b=hWEGFiUd+m/ch5FrlQ3mhn8XtpXNxRI7RnmF5mvEl5bzobMrJeeQNHEUivaVl32uKf
 Hpp3wyIuYBMVzusP+BUl/iH/Bvn9QwsvX7Fw+kq4qp4fpf3Wk0bU89iMxJXEegM/caZg
 s3+a1wDz3WuUqSuSvu9CxwKtYglp1Zs4/HW08A/YhG/Y5zOWd+ib7SGmvOjiwafb9MwJ
 Ns97CwWmlaPU+f9RKONIcrPHFRTMO5/vYnMjH37eCCfvLwYGdlLJ8/rma/RZxuvbBRpt
 gCT2IAFCY8Ir1vn8da/iTZwENBGH/M/xMLcd4HaiTK8lKUwJ/vNy5Lj3ijwgZ1sNNMk6
 hZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080634; x=1731685434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gmpb3Wgw7d9JZF5PrdGS8a2GyTd0IHtG2ing10Pn98=;
 b=hjkRUmuctXU6ysGFf8OoFTD9JglokGeGIYXyhXvc47sYXCcU1pyzPPzXJqou+VKOYo
 38rpPj/MK1PzAAIFGzB53MtOLHR7x1Sz4TUCbcM9vH5qAbc8HD9JN5t16deK9NPvVDhW
 W4plqPh6cPYvofofI073avxjgpXtwJrCZQp34GZktGGdSKIMJ9f3YplosRoS4d76tsa7
 lNYsfmKwS8Gy9YP4yDuXc0XDyCMMyVz2xXwg6qR1rcj1AiXOJHQyGZ7aNomA2WFsIsDl
 VR8t40mWK2IFBd/LQsxYC/Qt4NGQCYrLRJfFWtL/Nd6D7xC4YASotYab6eQexScNG6Tj
 j1Kg==
X-Gm-Message-State: AOJu0YyoqHJEvvJr0gIGQCzSzdn/9/ur+B8T1gcV7VKoMpZlKdkdh+Vi
 yM239UVaxnwK7kqpieL5UrQiOLlJTrAxX38KHOro5rBtbbEBUwIJVLV0TTOrQmCzgBtfpuHT0iS
 y
X-Google-Smtp-Source: AGHT+IFWyGL/UJ1Cl3imuQTYOgHw6Ru0QZgYAbSCS/zPIdKGpHTmwpZDzwHVg6tI+Y0Xibe3YzUugg==
X-Received: by 2002:a05:600c:4587:b0:431:52a3:d9ea with SMTP id
 5b1f17b1804b1-432b74a0c04mr29486475e9.0.1731080634000; 
 Fri, 08 Nov 2024 07:43:54 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b054aed6sm71588895e9.15.2024.11.08.07.43.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:43:53 -0800 (PST)
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
Subject: [PATCH v3 07/17] hw/char/xilinx_uartlite: Make device endianness
 configurable
Date: Fri,  8 Nov 2024 15:43:07 +0000
Message-ID: <20241108154317.12129-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness on the single machine using the
device.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c                | 33 ++++++++++++++----------
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 3022b3d8ef..a7dd30f90f 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -57,6 +57,7 @@
 struct XilinxUARTLite {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
     CharBackend chr;
     qemu_irq irq;
@@ -166,21 +167,25 @@ uart_write(void *opaque, hwaddr addr,
     uart_update_irq(s);
 }
 
-static const MemoryRegionOps uart_ops = {
-    .read = uart_read,
-    .write = uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+static const MemoryRegionOps uart_ops[2] = {
+    [0 ... 1] = {
+        .read = uart_read,
+        .write = uart_write,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
     },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
-    }
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static Property xilinx_uartlite_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxUARTLite, little_endian_model, true),
     DEFINE_PROP_CHR("chardev", XilinxUARTLite, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -219,6 +224,9 @@ static void xilinx_uartlite_realize(DeviceState *dev, Error **errp)
 {
     XilinxUARTLite *s = XILINX_UARTLITE(dev);
 
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &uart_ops[s->little_endian_model],
+                          s, "xlnx.xps-uartlite", R_MAX * 4);
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
                              uart_event, NULL, s, NULL, true);
 }
@@ -228,9 +236,6 @@ static void xilinx_uartlite_init(Object *obj)
     XilinxUARTLite *s = XILINX_UARTLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
-                          "xlnx.xps-uartlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 10d9713150..2d2b3c9bca 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -107,6 +107,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     }
 
     dev = qdev_new(TYPE_XILINX_UARTLITE);
+    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
-- 
2.45.2


