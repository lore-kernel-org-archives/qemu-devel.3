Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7EEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1fB-00054X-C9; Thu, 06 Feb 2025 08:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1f4-000525-Bg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1f2-00083W-Md
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so5841905e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847475; x=1739452275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4b8oiIF0V/wXvMZ/KNd/Z66f59JylUbcAbl8fgf5Kk8=;
 b=mjYRV3Y6lnFjkafNBX8KR92OKIZKPC/yzeO8SE0SZ2sbIUzfoI7Z/K0SwWMLIE/5D8
 mc13ctKCVkB2Y+HEo3xZyXne0FOMGF9UqielHUEeIup8g2EpjubPigThNN2Z20cjbd8H
 WOT1ehO8XrYpZFcK4IKXe1sEaFGhTkUw8uRwRKhzxdy3bkXsoNZTl1yxb4wzVSIspSus
 XMM9xkkPe4K1vjddFwyQ4Sab5qjgwbqSg7iuoi76nLQB75Hoft4q72ZyogdIQroAsFQJ
 Fx9w3+alZmLpQrGr3R24rjUeG/tiJiyCQJQ+f7VcXotbrYHEtOfPU0QrU5IorM3YWSMF
 heVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847475; x=1739452275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4b8oiIF0V/wXvMZ/KNd/Z66f59JylUbcAbl8fgf5Kk8=;
 b=QcNREhfOKwDI/fVIx24liY77e1e6KU6QaBrAM+32iW/MWMSX8qrPQGPmDF0yf+3LQu
 lPq2uh5zhi6oSoh0YcruP/sCXBJ8AGtkovBPbWbcHMv3UjpeMDMxMR2DRsGvKgFB84Mp
 TbLxdkNEe8wo3giGbzhPR+tdy2AocI2WtEdSGmX7vXvVui6TX5NtGHth/XxUjAfA3XAX
 9wHiqiNT9tqZWAmQ/sR5UXHpN3gaoxvfKKgD8TM+0xh+xUqdcmnU+EOcEqJaQ7oPTc/V
 fYnh6Ruyx6O2FTaXkgzlb1FHBdXon/Ds2kDJm1EiyqojWpbzrUFnVAqT+NLAS3TPK2cN
 ZbSA==
X-Gm-Message-State: AOJu0Ywyxz+RBKeTTWeXavgeXrYrxf1FxMsBC9Ph3QUNIrFyGgD4JeU8
 bXm0tW2UFjdyndui5OZj7EFoHSK+pb30kjDS/y+S+s1AgNAhnDgdZykBN0uChVxN+VWaJEfZ+hv
 JDic=
X-Gm-Gg: ASbGncuWd0zxMgZof9mTjLT5lmOx5ZMzfexL5pXSTkUR4T0gMdIKMNnzsysI3cLlEhN
 PGocb9R5iCkU7OIyI0o7TnYqXEK7YI6RWJmHEKg/N7bvSyUVGNtxAzGuQF63E851XYQrb+cMLXu
 jmMjmYaSny8h/PsiKESZuvtqdNDzy081U0XNCIF5bSFzqaFcPUgHWawAgT9rY9SEwEoZ+2fVTio
 aiJIBqN03F3djeLDhFxGdh2DhW65sJfBTHWnZmetUBx0Z8OT8OzXYoSS+sHhQQ8fnSaAM250V9Q
 VB+hc5tF0ajGHxy4xhVqr3yRimPAiljUgRhQ1R8J8JS7SE6aMfmGZSB5q1G2vIfnCw==
X-Google-Smtp-Source: AGHT+IHAkDNRYuha8CDtCBV/X9cJ/R6QTR3iLZmEa3LhmLSUjkEDWAxTWhUQ5x8JAVPARPZoTe0zfQ==
X-Received: by 2002:a5d:64ab:0:b0:386:4a16:dad7 with SMTP id
 ffacd0b85a97d-38db48867c7mr5008176f8f.10.1738847474803; 
 Thu, 06 Feb 2025 05:11:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93379fsm56516865e9.5.2025.02.06.05.11.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 04/16] hw/char/xilinx_uartlite: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 14:10:40 +0100
Message-ID: <20250206131052.30207-5-philmd@linaro.org>
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
Set the proper endianness on the single machine using the
device.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c                | 27 ++++++++++++++----------
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 56955e0d74a..948da4263b9 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -57,6 +57,7 @@
 struct XilinxUARTLite {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
     CharBackend chr;
     qemu_irq irq;
@@ -166,17 +167,21 @@ uart_write(void *opaque, hwaddr addr,
     uart_update_irq(s);
 }
 
-static const MemoryRegionOps uart_ops = {
-    .read = uart_read,
-    .write = uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
-    }
+static const MemoryRegionOps uart_ops[2] = {
+    [0 ... 1] = {
+        .read = uart_read,
+        .write = uart_write,
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+    },
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const Property xilinx_uartlite_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxUARTLite, little_endian_model, true),
     DEFINE_PROP_CHR("chardev", XilinxUARTLite, chr),
 };
 
@@ -214,6 +219,9 @@ static void xilinx_uartlite_realize(DeviceState *dev, Error **errp)
 {
     XilinxUARTLite *s = XILINX_UARTLITE(dev);
 
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &uart_ops[s->little_endian_model],
+                          s, "xlnx.xps-uartlite", R_MAX * 4);
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
                              uart_event, NULL, s, NULL, true);
 }
@@ -223,9 +231,6 @@ static void xilinx_uartlite_init(Object *obj)
     XilinxUARTLite *s = XILINX_UARTLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
-                          "xlnx.xps-uartlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 9d4316b4036..96aed4ed1a3 100644
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
2.47.1


