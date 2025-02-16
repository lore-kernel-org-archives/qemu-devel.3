Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01E9C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjllv-00038K-Ep; Sun, 16 Feb 2025 16:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllk-0002zG-QH
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlli-0007vf-P7
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:40 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso4880415e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739696; x=1740344496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfEBMGQlHGIDpJ2OyiHkFlkYNwQ8cqs09byUGKzTQhU=;
 b=vEnu6a22dQuBi+7XDgWpBRHWKMLJoxz0tNc4NpRLRndog5wp5RNIEql7c2FLxvj05V
 QbNEiCXj5dYXAQ7nTA2nnePobLMROXISf1B8mLhJRA9X1c126FL1CssqO4skMpe1knU1
 fPiZKUXYqSuyMdfzSYDkwFH9qyUiYKdF1K8RIfabNh4VbVZHJIyRf4jqyaNfiYYgeWc5
 AKu7ebf8wdX94D3vzKywoEQX2kQCJUH7psdAUOuswb8pNkzXkxe9+z/Bwc2W67DtyNjh
 cxxLcLPnaCUeFff3xEUGwTohq0n0xuLHx8pbsDSp7rhXDeG7tDf6fhIB6G693fP7Dotp
 AkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739696; x=1740344496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfEBMGQlHGIDpJ2OyiHkFlkYNwQ8cqs09byUGKzTQhU=;
 b=aAjeNfkhJy6iR/fvfxxsA+afoNrW8OnqyuCfeurx4oucSVJPjmHQcm1tP0tRauFa28
 deFqFWJVrOWDSD6Kf8AT33hgzfqIQjZ7UjjiXo4XUyBEWmDsHBw87O26huVTCSZW3tp2
 69caVEoIbs4NbHojUX9EOuTI4+dzKVI7/0FmIxxx1ovIQ9fj2hYA6IasomUzRSE3haJm
 WfXuvID33rnnPY7V1jb4m9PqcIbfu5hVhboIAfLwwzqUO8F+gB5Gu8wm4+eHO4uha1r/
 nNbPGGQHzkrLrHYKBFtfWH8hCJ7lGHFz3CS8a9JG16f6M1udhNeoz4h0YdlrSna14BUJ
 AwJg==
X-Gm-Message-State: AOJu0Yy2bF3eR40htkZwVqzC47lJMGlsGq6riVMIx014Sc2u2lJLD4JC
 4rUpI5ZTRJIc1NVPXj21YOaf89CBNYBIYWc9bgZuqLq+zEIDjxK5UiwGtYo6C2wT8SvE8xp1I+p
 KOT0=
X-Gm-Gg: ASbGncuss6uLcXB87ZRTKYXP7bJ+yVggMUiD6elA7euESLP4dE4PkmTgnmFFvkPt96A
 Mcxz/Huc23ABETd5tRKjUwxs6nxTHFk8lkC9hWxQC2Bz2nZ1bSqtgpDqbOrvbGcCxkWaup+VIcw
 ufLeXQfV1gavT2FhYu8DbVLYRzW6VNAZUW7KyLHIMmPovHumXZyHVic8N5AtmTlhnIlrQXyI9vp
 jFd6LsvRckkq3yGXWlfWXtHX7kKK63PcjjllxMVo3XXXWvXmc7puaQBhZHekgKk6IgdNPT11sQN
 D7kjRtqDYulADdnvpKZ4Lr/Cfd3GQPMi5kDyly2mQ1VUyz3nfaA6bygQf7fFeh6/37D2+uA=
X-Google-Smtp-Source: AGHT+IHtf62UYyZAjFY7qDWfi1PZ82RjsIuNVwuJWkpFlhSTwcCA8gIxiQ6v6BTAgxeyEEyMLPlgCg==
X-Received: by 2002:a05:600c:4711:b0:439:60ef:ce88 with SMTP id
 5b1f17b1804b1-4396e710d27mr71140195e9.23.1739739696083; 
 Sun, 16 Feb 2025 13:01:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961884f48sm101910905e9.30.2025.02.16.13.01.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 34/39] hw/ssi/xilinx_spi: Make device endianness configurable
Date: Sun, 16 Feb 2025 22:00:58 +0100
Message-ID: <20250216210103.70235-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Set the proper endianness on the single machine using the
device.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250213122217.62654-7-philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c |  1 +
 hw/ssi/xilinx_spi.c                 | 32 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 984287fdc53..21ad215e442 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -177,6 +177,7 @@ petalogix_ml605_init(MachineState *machine)
         SSIBus *spi;
 
         dev = qdev_new("xlnx.xps-spi");
+        qdev_prop_set_enum(dev, "endianness", endianness);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index fd1ff12eb1d..be5baa6b350 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -32,6 +33,7 @@
 
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "qom/object.h"
 
@@ -83,6 +85,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XilinxSPI, XILINX_SPI)
 struct XilinxSPI {
     SysBusDevice parent_obj;
 
+    EndianMode model_endianness;
     MemoryRegion mmio;
 
     qemu_irq irq;
@@ -313,14 +316,17 @@ done:
     xlx_spi_update_irq(s);
 }
 
-static const MemoryRegionOps spi_ops = {
-    .read = spi_read,
-    .write = spi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
+static const MemoryRegionOps spi_ops[2] = {
+    [0 ... 1] = {
+        .read = spi_read,
+        .write = spi_write,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+    },
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void xilinx_spi_realize(DeviceState *dev, Error **errp)
@@ -329,6 +335,12 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
     XilinxSPI *s = XILINX_SPI(dev);
     int i;
 
+    if (s->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, TYPE_XILINX_SPI " property 'endianness'"
+                         " must be set to 'big' or 'little'");
+        return;
+    }
+
     DB_PRINT("\n");
 
     s->spi = ssi_create_bus(dev, "spi");
@@ -339,7 +351,8 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->cs_lines[i]);
     }
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
+    memory_region_init_io(&s->mmio, OBJECT(s),
+                          &spi_ops[s->model_endianness == ENDIAN_MODE_BIG], s,
                           "xilinx-spi", R_MAX * 4);
     sysbus_init_mmio(sbd, &s->mmio);
 
@@ -362,6 +375,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
 };
 
 static const Property xilinx_spi_properties[] = {
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XilinxSPI, model_endianness),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
 };
 
-- 
2.47.1


