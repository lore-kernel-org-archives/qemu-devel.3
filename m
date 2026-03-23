Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E2F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iW0-0001MH-KA; Mon, 23 Mar 2026 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iVz-0001M6-2n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iVx-0000SC-7v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so31644805e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284747; x=1774889547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/9xlo3DkgERVht39wnMqkq+rDYCD0wv9BKJFxhIWcEo=;
 b=NoatmngrbjRQP9M0QWgB5lftYVGNyQ7sENF/VesqMS8Ak4nb/zX4q9CNV38l4Zhs8s
 dJta2StBT8cm5bhI8eRBU/3DtH7MI3Bp0niK3BY0kr1wmDrShDM/QtDUb5EBMx6m5Ptg
 1vnmxVAu1Njl/fnDecvbVG7t2HiiBdh/IhADOpx/tx8er0nsDMr8QTM2g7jrOPy3TrHB
 4IUUtEvzxap7ezqGq2hsJ7iCxGzrHp66qXgl41b26Ag2t27cvo+TKaRABJ1Vl2ul2U1A
 Sa300s2NsgH1vxl2cSUEWiZyNqYwCJr3NuhWKv5gEi6PQwuEuUhkVZ8+RvTgjEmv2TO7
 2HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284747; x=1774889547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/9xlo3DkgERVht39wnMqkq+rDYCD0wv9BKJFxhIWcEo=;
 b=CHNWGKybPCw+xoNOzSrrT5eBhhxUQsNk6rYhGV7otPj2ukVdShGXOhgDNPBPxq8CLW
 XZyp+CYywfavDSJUFGCLYWBjs+g1m+FMncC2SQDCpqz24q+h7OhjxSPXff5b+IkCpSN2
 BV14ig+bO6hPNwfMjiNiymSMLkhyjeGM9fYOSQKg2F0bZM7/br0nywhOmpwqH2U9MGFa
 dD+pyjn6F46Wy42qMvhQotzm0ALBDIXGjWtyjek7v2zhuyO49GR4RIMz8z1v+o12BK3b
 YTp/PKqJUoVvdmX5Y6le+pNcNlYG2B8xkgOkZnTygBNgVsFp1GITvqV9kbjX4haOm/CU
 f11A==
X-Gm-Message-State: AOJu0YxcajaKAabs6zyhB1j8M8ZIoCj2IvQwy1eEqFOre1zn9bnwSnKT
 ME0c9cQgo4doxtR109L2qWWCaLbS6CV0nRgnkmmXj8jMHFWVEGLd3CY5HQqW7yX8fRwIM+AxWNP
 Mh7UR4hY=
X-Gm-Gg: ATEYQzyLyKWp1Wj0Eo6ECtelQMKWZ4umB6vWp9YrkI9vF37hh1uKU7OHVKzl/NCxFK4
 gvY779b4TVKKGdDEoG8OhBYhOzdA57JpqI4a1JbkvJZ5ADwWVjqsa0xWhvxzWj5yUiDf3hYC66p
 ZZwacxnltmdwTp6So67/w6SgQuJKEY1bnNaicNXff5rJ3KI9AYUSqG+FK2SEc+Z7I5Hfmj7rQ5L
 S+sHp+JOke9ewLGtDeDM5yRYLSTnKgYIbSUPpQX+7Aiuh5EqSTL2PLx9QMAp3BYqjIW52Xdl3/G
 qpe/gZzPnMWlKf2md/Pk9n56PiqdFxHo9kdsf3XdTzlO7NL1mVEDC3pLw3jKd0qp+/D/eVFaMyW
 POA4SSLccmomnCmCzqsWh8D4avfakUeNz+CodpEpx02bgUeuaPqF/7Kp/PXfNX1Hcn+b3UuqW+6
 DxuKqDvK8CcUUiK3QClVwEZ03zCJCHeCiFtP4myhjRe2kfgIWDETnhULGUbA7flngBjdFqUVQN
X-Received: by 2002:a05:600c:45c7:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-486fede721amr166888905e9.5.1774284747041; 
 Mon, 23 Mar 2026 09:52:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe032a55sm561676355e9.7.2026.03.23.09.52.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:52:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/27] hw/riscv: Mark RISC-V specific peripherals as
 little-endian
Date: Mon, 23 Mar 2026 17:51:52 +0100
Message-ID: <20260323165218.96607-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These devices are only used by the RISC-V targets, which are
only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260318103122.97244-2-philmd@linaro.org>
---
 hw/char/ibex_uart.c     | 2 +-
 hw/char/shakti_uart.c   | 2 +-
 hw/char/sifive_uart.c   | 2 +-
 hw/misc/sifive_e_aon.c  | 2 +-
 hw/misc/sifive_e_prci.c | 2 +-
 hw/misc/sifive_u_otp.c  | 2 +-
 hw/misc/sifive_u_prci.c | 2 +-
 hw/riscv/riscv-iommu.c  | 2 +-
 hw/sd/cadence_sdhci.c   | 2 +-
 hw/timer/ibex_timer.c   | 2 +-
 hw/timer/sifive_pwm.c   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 127d219df3c..26ed1aea140 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -470,7 +470,7 @@ static void fifo_trigger_update(void *opaque)
 static const MemoryRegionOps ibex_uart_ops = {
     .read = ibex_uart_read,
     .write = ibex_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
index 2d1bc9cb8e2..d38920a03a0 100644
--- a/hw/char/shakti_uart.c
+++ b/hw/char/shakti_uart.c
@@ -103,7 +103,7 @@ static void shakti_uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps shakti_uart_ops = {
     .read = shakti_uart_read,
     .write = shakti_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {.min_access_size = 1, .max_access_size = 4},
     .valid = {.min_access_size = 1, .max_access_size = 4},
 };
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 4c30fbf5685..b4de662d616 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -236,7 +236,7 @@ static void fifo_trigger_update(void *opaque)
 static const MemoryRegionOps sifive_uart_ops = {
     .read = sifive_uart_read,
     .write = sifive_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index e78f4f56725..ff2a7c18235 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -250,7 +250,7 @@ sifive_e_aon_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_e_aon_ops = {
     .read = sifive_e_aon_read,
     .write = sifive_e_aon_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
index 400664aabae..a4a60e7b406 100644
--- a/hw/misc/sifive_e_prci.c
+++ b/hw/misc/sifive_e_prci.c
@@ -75,7 +75,7 @@ static void sifive_e_prci_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_e_prci_ops = {
     .read = sifive_e_prci_read,
     .write = sifive_e_prci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 7205374bc39..cececd4f7a8 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -187,7 +187,7 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_u_otp_ops = {
     .read = sifive_u_otp_read,
     .write = sifive_u_otp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_u_prci.c b/hw/misc/sifive_u_prci.c
index f51588623ab..4674d5925ea 100644
--- a/hw/misc/sifive_u_prci.c
+++ b/hw/misc/sifive_u_prci.c
@@ -112,7 +112,7 @@ static void sifive_u_prci_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_u_prci_ops = {
     .read = sifive_u_prci_read,
     .write = sifive_u_prci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 225394ea838..c3c9ed6469a 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2375,7 +2375,7 @@ static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps riscv_iommu_mmio_ops = {
     .read_with_attrs = riscv_iommu_mmio_read,
     .write_with_attrs = riscv_iommu_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 8,
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index d576855a1a8..8476baf67fb 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -122,7 +122,7 @@ static void cadence_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps cadence_sdhci_ops = {
     .read = cadence_sdhci_read,
     .write = cadence_sdhci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index ee186521893..0f12531934d 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -234,7 +234,7 @@ static void ibex_timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ibex_timer_ops = {
     .read = ibex_timer_read,
     .write = ibex_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index 780eaa50799..4f4f566cd4b 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -388,7 +388,7 @@ static void sifive_pwm_reset(DeviceState *dev)
 static const MemoryRegionOps sifive_pwm_ops = {
     .read = sifive_pwm_read,
     .write = sifive_pwm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_sifive_pwm = {
-- 
2.53.0


