Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6775FC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjllp-000307-Uu; Sun, 16 Feb 2025 16:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllg-0002yW-F4
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllc-0007vB-CR
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4396a4d5e3bso21810905e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739690; x=1740344490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcyVI0kPFXhH981sg+d29nPiWvZ9LL1zDe7HaHRgPOQ=;
 b=wmXjjD6I3wCUhgRib1v1ewxQrQMxh9AOtG4m+ZoQOqOrATKTBXdIDYVdWTwhIQlYNa
 ylLT+5luSRxd+XKDPljujUNoK2YJ9hv6LmixozpJbuWKzbPyltxZ1Zzzt3ZiOzr6B9rX
 ybiC9T3h7eAP6i511//mzyZMcyuJx2joKN8mVMO6rqVWYqa4iw5YOpAud7h6uhxNQNyZ
 XnjahJLeMouIiLA4Phnu+oLSKeDLM27MvexDa2z+skV39isRrMG3hXq4b1bxiNW4QU3A
 n6Y7qscwGeO3QeNKwjS1ZAulIF9IjBZNigIcIYAYg+xkMmt5b9os9yq2KX3jAL/HpxnD
 9PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739690; x=1740344490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcyVI0kPFXhH981sg+d29nPiWvZ9LL1zDe7HaHRgPOQ=;
 b=V/WA8GztHRFe9BlZgMSP42cy87qDchkHB5YY1vVG3q+ImOBAAXBU8fxbqZM88thTjV
 CUEOwCPDt5oo+llP2+TpkukbGcStLCeYRYnJ4Aitpn6f1F2FbqB+zpypM/aPSJMHQl3d
 H7S2ck7VVnx+gxvXnbDFmOIHHlkTaYthlYM1qgFjuSal9E9fl/BwIM1SCFpCSlNMoFeA
 EMlpVqkXi/pYXXgYWLzpyF15cMe4MxfDY3XDFTwxBqZdKl9iOs/DskWabH4ygqjXM2jt
 rkaPT9RElcTnxEoz9NomHTvmeSItMak9eiYuLCtor1onp+SzyctVjYOrOOnZGbS9GdbX
 sJrg==
X-Gm-Message-State: AOJu0YyAAjpr7DJA+s41t12A1Nh1oHu2QquJNTi3PUvTvwbXBpkxnM6a
 OpYdE1PjXloiNeWGLJPkUOov3bMXqBR35njbmhraMMJgt7fLZEBHOlvf9rsDks+UiWJA046v5qj
 23A0=
X-Gm-Gg: ASbGncua1lQTWZGs3UctBE5hI+ULQVdYLmcYWYRJ74UcJwz7z7qZW/t7iNfb7IvX0YZ
 1kU+7DzmS9vwnFIhBAOGSw2BvrMVEC1SBd/TF+G0rOq/DW6f6jyo9D7rJFWxYw1qXimBePxiUVN
 I6spVrzbWWWefgpPHGwyoSFBIB6gZ6c1ymjeaAak483eWJhX0rPKYpk8Xv3y1AfvjJvaBKVGt4G
 suzbCrB9BPerL2Jq0+MLzmtcfPR4d44CBFLBaNN4Ck2z2hvmfy3X2w+g9EJeY7IPFNlRHmKfU8b
 p6AKIPxxlJn2z+cRXUZrriOuEieyIHyMLHU5R1Az6UqEx2pkag179klKMRtnxf7GyvzyrFw=
X-Google-Smtp-Source: AGHT+IFdyOBdynkCEGwXLHZ4wIaFIcEo6twxikU+6ClxguiWHZKgu8vllLzz1d+tm0OGlSEvHLHl4w==
X-Received: by 2002:a05:600c:310e:b0:439:57bb:2aa with SMTP id
 5b1f17b1804b1-4396e6aa7d3mr84051405e9.11.1739739690378; 
 Sun, 16 Feb 2025 13:01:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961884e88sm101602185e9.26.2025.02.16.13.01.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 33/39] hw/char/xilinx_uartlite: Make device endianness
 configurable
Date: Sun, 16 Feb 2025 22:00:57 +0100
Message-ID: <20250216210103.70235-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250213122217.62654-6-philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c                | 34 ++++++++++++++++--------
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/riscv/microblaze-v-generic.c          |  1 +
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 56955e0d74a..4037c937eeb 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qapi/error.h"
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -57,6 +58,7 @@
 struct XilinxUARTLite {
     SysBusDevice parent_obj;
 
+    EndianMode model_endianness;
     MemoryRegion mmio;
     CharBackend chr;
     qemu_irq irq;
@@ -166,17 +168,21 @@ uart_write(void *opaque, hwaddr addr,
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
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static const Property xilinx_uartlite_properties[] = {
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XilinxUARTLite, model_endianness),
     DEFINE_PROP_CHR("chardev", XilinxUARTLite, chr),
 };
 
@@ -214,6 +220,15 @@ static void xilinx_uartlite_realize(DeviceState *dev, Error **errp)
 {
     XilinxUARTLite *s = XILINX_UARTLITE(dev);
 
+    if (s->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, TYPE_XILINX_UARTLITE " property 'endianness'"
+                         " must be set to 'big' or 'little'");
+        return;
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &uart_ops[s->model_endianness == ENDIAN_MODE_BIG],
+                          s, "xlnx.xps-uartlite", R_MAX * 4);
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
                              uart_event, NULL, s, NULL, true);
 }
@@ -223,9 +238,6 @@ static void xilinx_uartlite_init(Object *obj)
     XilinxUARTLite *s = XILINX_UARTLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
-                          "xlnx.xps-uartlite", R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index caaea222a8c..bdba2006b72 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -109,6 +109,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     }
 
     dev = qdev_new(TYPE_XILINX_UARTLITE);
+    qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 3c79f5733b2..d8e67906d26 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -92,6 +92,7 @@ static void mb_v_generic_init(MachineState *machine)
 
     /* Uartlite */
     dev = qdev_new(TYPE_XILINX_UARTLITE);
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
-- 
2.47.1


