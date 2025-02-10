Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F57CC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thac1-00067t-Q7; Mon, 10 Feb 2025 15:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thac0-00067d-Mf
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:36 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabx-0003bs-W4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:35 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dc9f3cc80so1276446f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220152; x=1739824952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17PSkbV7JeDOENoRiscJCBfno7CFpbghPxxgdE/zryg=;
 b=ALaEXUXpJQhce0VixlWFcBLO2/NjL1rcKO0HOVZkuHJ0VPG6uQ3SdPNLuM7bm5FVwr
 bEVBl+ykPvY/r56+Q4egykivXU7Gv51Oly16latbaPAajDeXIbea4+zGvIhJD54MxbG9
 hAjqyeXsPZEMwdcZKGaOfAub/GPFes912pbdiQNKMKdKMtHKN6yYrsmyd0laMWKNo7RO
 kzsfd38VCG/8r7S3J6mxpLIJX9Bf9k6oSBmHG78VfGu5A0NaE0TVCHqNJduqriDzzohq
 QH+kAUykl5GvXve+awUeXHM0gQeQC2vpZVEtBaPcS/+7GB7WAG9uDIQQGipGCWSs32L5
 x2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220152; x=1739824952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17PSkbV7JeDOENoRiscJCBfno7CFpbghPxxgdE/zryg=;
 b=uqPL78FLtQeTRxHW5J22rDWqkonlYX5MCJTW84HWQcBCY39JhailUHFdwtt9pSFzlk
 5bw0Vzuovq9r+6jPVROdnzsjN7q4jjQBipqLgaPMzhqVx/nhgp2+90qQlY6kJu9qmppg
 SzFvfueiEzjqQy64Ey1jmsWbjS4o9SP+lbp0ENzRvoI+O+5/fLkIq2H/Vtq8MvHXrqWv
 MMU0HgOvOj4fU1B8xTyEsM2BKcEQJx9yxZjIrfSIil6DiGk2XH26pjECpQK8XiqSMDZg
 AjFgAr1OI9PnXT4/09Q527yEGRkHsKFUcrgpEOYfwphOfiaOb2eGUSikjzfSR7MVT3g1
 0K8g==
X-Gm-Message-State: AOJu0Yx/NOi47iaD9+yKALKYzuah4MxHR2jtXDVlNhjTMpB61tQLlTTp
 tDg83ntSGcp4C41cA42aGR2tZz4aEI04J0KRyrUUzOSqva0VQwt43WTs3o64zkLYZuTv5uOwU/y
 l3KA=
X-Gm-Gg: ASbGncsZnc/UHsx2KgJXDBECZ+Su+N1IJ1OptAF5JDp1yq5BST9uLNtJ6qHCrZk5uEk
 4PCC/DH6KM1FcM+b+91oxUWg0TCRwktRcCYGEKGVuRBtX5uY+bu3UvhD80L21JgCKhJWvw3QGPX
 ddzs+r2G5SzqlPGD/NhQijfKn1D4lF7sxzE/apm+l6VauLedIO1jLoP47ffEjw07SErFb8MFOWL
 ZDKtbatt2CEaNrpiCJ+1mlUYzqyFhoYwY2dxs1GvznHwEF0geUEwJKDzerL8zRdNyno4T/6cNHJ
 4HjSAxEG/QivPXUGv8LUAI3HzJkwKJHp3Jk/cRQtJ1zKQYIpqAsTv27mdv/ikJ1nhw==
X-Google-Smtp-Source: AGHT+IF4NufiuygfIGNhuqSrER9BKkZEk8GRdFr6bVGoVBG+hJbuZMfFK3YaPyuJtT/hY40COdpReA==
X-Received: by 2002:a5d:5f47:0:b0:38d:dfb8:368d with SMTP id
 ffacd0b85a97d-38ddfb8383bmr3425198f8f.50.1739220151921; 
 Mon, 10 Feb 2025 12:42:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8047sm154727225e9.33.2025.02.10.12.42.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/32] hw/char/xilinx_uartlite: Make device endianness
 configurable
Date: Mon, 10 Feb 2025 21:41:37 +0100
Message-ID: <20250210204204.54407-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
Message-Id: <20250206131052.30207-6-philmd@linaro.org>
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


