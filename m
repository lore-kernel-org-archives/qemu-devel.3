Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9097AC021A1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiArG-00069d-FV; Wed, 12 Feb 2025 06:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArE-00068o-ED
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:24:44 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArB-0004YX-M6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:24:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so65908095e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739359480; x=1739964280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qque2XZ1dU81iGdYR24fO3GVnw9hhnz4b3BIk7lxH2E=;
 b=yQ2EoxxRFl1NA60u4SQfy/rFNhk0EmKdr8fU9RceuC6mUBJD5eAKLG2KaIF5RHpotI
 /7NmB9FqIQa2TierTWrp4bJ4giBOz7Y+DZGxYJtZzzSoj/XxezFS1561czHlFKluiqtY
 mBPoEUNfh3I8nPdtKV/nvNXxy+zedYlDfaGsoaJ71ftqHXLA/WcPXlwz+pHNx5Mf7yh2
 w7qj11ES5xex49rUPn85YOaf4G4IqOdJ/DJNIyqiYrVb2ImUPBsxvJm5FLvrnVxExx9V
 9vPq0yEzbJ/bRZwerfNXYSeXpU9ZFgJJ7yg9jCN3wlhi6t5pzkBYBnYPniMRYnCLsbqT
 dmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359480; x=1739964280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qque2XZ1dU81iGdYR24fO3GVnw9hhnz4b3BIk7lxH2E=;
 b=UApQVN+gUJVXL/KTlDaOAgRc0Ab73MfPT4ey1Pd8m/1e1MOeEAEnP73bToQOxQBVyx
 8Rzz6Zx9unls8ws0JbrxZJS0VcxFUkvinGAEbtxlugrxTDvJDRuLmwMiTWBvFGx4ppxk
 e+SPkSIsdflyAqSuaUsQhr8wHKEN5GzGio1+2YzMI8Gmffz6It5Vgi/9z97GV20VwTa4
 pC9jjvOBYQ0U7nNHuIrVPI3OeLrg+jEp82jHMHaiohW1gSlCTTQ3ytp0Ro3xN5DQ8MNZ
 ZuFkpxJblSW2uhs8ALbMRjQCIp1MFIiKie5CWoImdytu1DxxnKZfEzY4PXZWvb1F+JSD
 Q0xw==
X-Gm-Message-State: AOJu0Yx1MVs1/X1VsqJ0IH9DNOOSRim9RPBZZ23Dce6B8UplHwcevS15
 i2s+Kc35r4NQ3wisV7X+TMecczo+eIus1yaEZwi9HO+HiBD4YBsGCxnt2lGMBnP64Fvwn2MTQrK
 gR1A=
X-Gm-Gg: ASbGncs68h87cUetVnZdGgY/pYSNV1xuA/KaLDDOCD+aPKHRSirZtlWKO5WPmhiZCXU
 dtKCLk5sAjDAcWyi1sKe4ZsfdRlbda11QCFTxGEsOgC626X+yYPs/tywC+jb8onYGpUYYpePCak
 hZeIpeeVf2ta/QuSLeyFGwl1JgjZ/kYqDMP4eTHIRiyuhfJpZmJDCMNZ/xo1vsDFeQRst6kNKjD
 4D5LxzxIEqUI+P8eJVtl9DGBkl15kXxgo92nN5nj3RWD6who58+lnp/cJ6W8eD0DlPkStbdegcU
 BFb0/ntDDIVLgjkI90tTGcNqUZcvhdpwhX4qlO2zdTciiIpExUFlhJnCyZNCuq0rYw==
X-Google-Smtp-Source: AGHT+IFNDzo6COMI9HZI6tOI90FY8EHZldwBzXiKq59lW+yhMmkMCOTE7aGpWlaD48acOBbaTA8qLw==
X-Received: by 2002:a05:600c:3ba8:b0:439:4832:325f with SMTP id
 5b1f17b1804b1-43958160560mr23189195e9.1.1739359479876; 
 Wed, 12 Feb 2025 03:24:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1af07sm17390101f8f.15.2025.02.12.03.24.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:24:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 05/11] hw/char/xilinx_uartlite: Make device endianness
 configurable
Date: Wed, 12 Feb 2025 12:24:07 +0100
Message-ID: <20250212112413.37553-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212112413.37553-1-philmd@linaro.org>
References: <20250212112413.37553-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c                | 34 ++++++++++++++++--------
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/riscv/microblaze-v-generic.c          |  1 +
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 56955e0d74a..907fb33c6c0 100644
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
+    [ENDIAN_MODE_BIG].endianness = DEVICE_BIG_ENDIAN,
+    [ENDIAN_MODE_LITTLE].endianness = DEVICE_LITTLE_ENDIAN,
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
+                          &uart_ops[s->model_endianness],
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


