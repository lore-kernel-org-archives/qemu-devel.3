Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F8FC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1fD-000557-Ps; Thu, 06 Feb 2025 08:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fB-00054Y-GZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1f8-000856-7d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dbcf418f5so339235f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847480; x=1739452280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X20R65gi2tCckItv1V/R89183LZ1ZNOLWFw83d9B9RI=;
 b=ZswQIY0Xica2E3W2WGNaXzqh+KYYVESzI4FPNjMdT7C7k/xwIr24qFS5FK/Fvyhjuy
 gF/RoCczIthkE+KGKtf5bJcwj1byLnoaEbelSjoO8zsdSrgG0zJ73yguYrHTzXkkfFdn
 ttQSNvCQlgZqFXLnhqPYKfFN5JyVuxzMJaZ5UFCuYQT+mk/jIoYD4FNivyxkoa6C9qIC
 PVm1E4fuCaAo+4epL9XStP7vqz+ebYjktz94/KDkhgpE4wFNfes3L69AadQVIiYkWvte
 YfdADTlJHHDfgdmAnq3U2B9kh/rQXNJm8k9EwNOLW/5+m2I0jRvfHvwKkdM/+D2U700F
 QN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847480; x=1739452280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X20R65gi2tCckItv1V/R89183LZ1ZNOLWFw83d9B9RI=;
 b=DnEto8oUUwJUlo8cbZchrHQnKfgn8dJueuQGGX+VMRYkzfIO+PS0Y262mKE9BD4xqR
 EotqyS8ZD5sF/YIs+4rZvqRj/aVTdU+RVpR7Rle0IosbrSqc/Puy626o8OpwPHGshXjY
 GhP2RSnA5asdxB55I8nUQ2LmRrn9NnTJKNp0Ydp7GFh57l4KrpZMwYUjTHUDU4gDy+rr
 prxKbdIJ8zvTcc/AZAEMiOyD+L+Qt3cojXpDYZLKUcIB+cQDZlB36XwKz4ininWOj5dA
 +cmWkf6VxP6YtZuVjlmMILzQbWwu9yXl7atGX+i8sZplix0KeO11oPJptlThl3AUldvX
 CVMA==
X-Gm-Message-State: AOJu0YzxCj07/yXhSOr9Z2K2jGqrE+pejXMdGyrM2pwgk7+keP1/sGOG
 XGQldSmsYCYZNPr/jIbS+gNrSp+T9GPSoLaYqHsv21PMBNBZkBwGpWL9d3SOz/fRepzqcaIx0VO
 bN1Q=
X-Gm-Gg: ASbGncvY6XgIaaQjrxopELJgqekv9MLnUif/U39Sbw1VLy7YkPGh1N/fyFSmMMzrWWY
 KdUtdfhyN6PB3CJ2tmafQGNa631OQgR13WqB6OlEW8oDZzAqZgaHplyR/RvkQdZ3iN6KRhPhGNF
 Fwl88r072rh3/yz8nSlmFeOrkxmxDSf1QR1n+f/DwESBtV3wySB9U72tWGtMcDSlK0C4JqxIHnG
 tDBVHG4XyqwTdCcer6DHOuFLJTLojH/90FyvPKMkKigSwZ08j2qjEkImzzdJRgnKEGs9kLz5a57
 g10wDVEdWf5bwGsdsd3M9/QMVHf45d0TssV2a/rmcgHZXF1NKlRtBrCFLpD00HO25w==
X-Google-Smtp-Source: AGHT+IEyVzXfV8+1W0wsg2XiziTo9MaIysVng3j4cjton4+hSj1eJzA+TuXZsVlOGkarXmYsViTLBA==
X-Received: by 2002:a5d:47a9:0:b0:38d:bcf1:1011 with SMTP id
 ffacd0b85a97d-38dbcf11476mr1847306f8f.29.1738847479735; 
 Thu, 06 Feb 2025 05:11:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1e034sm1672874f8f.89.2025.02.06.05.11.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 05/16] hw/ssi/xilinx_spi: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 14:10:41 +0100
Message-ID: <20250206131052.30207-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 hw/microblaze/petalogix_ml605_mmu.c |  1 +
 hw/ssi/xilinx_spi.c                 | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index bbda70aa93b..a795c6385b4 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -175,6 +175,7 @@ petalogix_ml605_init(MachineState *machine)
         SSIBus *spi;
 
         dev = qdev_new("xlnx.xps-spi");
+        qdev_prop_set_bit(dev, "little-endian", true);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index fd1ff12eb1d..299004ff36d 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -83,6 +83,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XilinxSPI, XILINX_SPI)
 struct XilinxSPI {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
 
     qemu_irq irq;
@@ -313,14 +314,17 @@ done:
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
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void xilinx_spi_realize(DeviceState *dev, Error **errp)
@@ -339,7 +343,8 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->cs_lines[i]);
     }
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
+    memory_region_init_io(&s->mmio, OBJECT(s),
+                          &spi_ops[s->little_endian_model], s,
                           "xilinx-spi", R_MAX * 4);
     sysbus_init_mmio(sbd, &s->mmio);
 
@@ -362,6 +367,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
 };
 
 static const Property xilinx_spi_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxSPI, little_endian_model, true),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
 };
 
-- 
2.47.1


