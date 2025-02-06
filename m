Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CD8C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg08k-000765-Vu; Thu, 06 Feb 2025 06:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08g-00074T-Nv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08f-0000qg-00
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361c705434so5285205e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841623; x=1739446423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4b8oiIF0V/wXvMZ/KNd/Z66f59JylUbcAbl8fgf5Kk8=;
 b=oKGHTp8Z6Z/fezhmkjQYEeQMD0UnMMruwaEICughuZ2x7Gr/5aTBRFzn4P94k7pDC6
 zbvNzWD4o8oEVbYtXMzk5pzJHDXtGSkb0+ogl+ZgtfJ8boFzsFR/5KI4V8IRGBrop9zr
 GbWwy3SOJxGiJo51w7Yctte6qVikqhBN676lsQZKBHAF4whlq9eiuNqcfx0zCEtJtCDq
 DTwIbf58KxqnfGNFcyuHfdxxGpn8VeWsaW7xgRzWvYUvPKMCSifi0nu/6cSswQYZh2L+
 4SaO6nU/dDJvxF0njrYev/Gfnohl/WSTkD9oKkZBfeNoBH73rhWmdk1LX3oR4R/gyebo
 oBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841623; x=1739446423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4b8oiIF0V/wXvMZ/KNd/Z66f59JylUbcAbl8fgf5Kk8=;
 b=kYRPRnYGY0jBc6P71PXAgij9YHfA7bmshFHjVKj5RTp4Dts2huuO/lwg/AjS7zuuow
 D7PL39q9GfJ9ratXNfoId782QWte0UU74IvK0dACLRQXxXx8Q5v1Gvr567GtYE7TvjUu
 MlCXMQ52/+DqVypWV5GXUjqxrou3XIIC4lTvlxJr5uEVhsuHoRPX/uoQw4BqUoygYJow
 oiTEZmtnv5SC3UTETsZ/tJIj15JoevAWw9WLTaKIKeViBu+izblnPMz8NkcV8oEN5jdg
 hmmFWvIiXKonkZkWh4fFgvgHdAkIkGvXYtAxeDFmOBC9Zm+4qeFUElfjll8Lqfc6WIj0
 5BLA==
X-Gm-Message-State: AOJu0YzRynhTdh1PAZtQ/yoQa/2oLnk0XG1VMZscRBE7Tl6ecNHCtYnY
 v2BrJkrxtBS/gPLLa52aPbDvcpK9xKxVYyCSNe64pX3dyMM2nR/KVAB24N+baujcoYnK5karpqo
 3WJE=
X-Gm-Gg: ASbGncvX3ZHP5JCOlxgzBE3wBqNGX44slUhMHGi/xysONg/juJ9rHviw2Y9unp4b76u
 /u9UB358YH7/H5PiEBedz2Cn5mdME50PDFqMFnj3HJMG9Y6xTdDz1orWq3QCPnjtvg4MDJoB3UW
 i76tnf8pqkJMPCkbka7V7VzHtolf/5eUv5rjk0lTZ6kqau2+cXKIRp9PBt/bwYWt42ftc0BG+IQ
 1JafTLe7vJ3f3yAHFyWGNfmd687uyzXb+/i4wDpZM+RssfCzMV4GpF/oIafSnKp4EZWxYW7nIf6
 ICV4ud2DnKTtFKSAuQkkAX9ss1V9Qcaw19dGxd1Gjl+Ekb7pBsisAU37tPIaB5pkYw==
X-Google-Smtp-Source: AGHT+IFx8+W1K9YHZm9JspaCgy3cs6sp2kSQrqZJeMyfmcswVd22Tayyt5OEPxyP1iyzHyvGWLqoPw==
X-Received: by 2002:a05:600c:5103:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-4390d43ddb7mr54773925e9.18.1738841622784; 
 Thu, 06 Feb 2025 03:33:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d7d4sm53433895e9.10.2025.02.06.03.33.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:33:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 04/16] hw/char/xilinx_uartlite: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 12:33:09 +0100
Message-ID: <20250206113321.94906-5-philmd@linaro.org>
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


