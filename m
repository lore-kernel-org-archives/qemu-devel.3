Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0494C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB5z-0002Gz-JI; Wed, 12 Feb 2025 06:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB5x-0002G3-1x
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:39:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB5q-0000dW-Bd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:39:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso452100f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360385; x=1739965185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIXSfpZB5bg/6F/oxfJ3kCEKliHJiMRTVVFGSr9Kzec=;
 b=ApfGU6N90m80snJK1PDVahwRAKMQ7AtifRNDzQhoZThqRc1+1u7505TBXlj6CyYy2K
 496fBz4rgOXvo695gDcNv5aQRA6tQ9KXZG5jTPremQKPU3+tBnRdDY0qutuxpPe+Nf/Y
 +iN+hnTahlxYupOR72jCe00aC4V7mNXqCWRCI4xxDgit4PY6s6kWGNT3hCfCtZwlj5Tx
 v4wIFyCgocotFOoCJdood53N3mbG1H3sPDI47OAJB9/Tz3NqBmbWC0ZdCOyzGFROfVMO
 NVI4jAOeqZeZPRpYvrGmaQya1h+50RPrkkhwAFIll+nC/QmEHAfEpKCDbvN8pYhEMQD0
 DJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360385; x=1739965185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIXSfpZB5bg/6F/oxfJ3kCEKliHJiMRTVVFGSr9Kzec=;
 b=Ra8jAEU+pFp1QG3K1SDSXHPj9CAZbhvzGhtvPMRTjNkouG+xEJ2TJ05F/Jj4ZaVn3t
 8WCLwpeW18ZftUEtf4Dr5XzyG3wFI4Lys7QjCJ5apy9DdVpyqhHjLRv9jYqNn1Op8PBL
 wvheKeCsjhvJRkTf380MRvgtZdEUxc44HPWqoRErgywnTfvT4CQZgpZ0RkyAU0dudBc7
 y/sxJ0rTb6CEG1OZNB0sYmUNdBACq1jgOoFyBl7dKgCpiVuorWZU6c/+cX7gD5KcrZFZ
 1F/RIjMEA0t+SUegAc1soUjJB0lhtqDvphQt0VYKZHO8vCIibEa+jDqLWKEXw4iwdsBQ
 r89w==
X-Gm-Message-State: AOJu0YyGGT3lPGz7g6CszBJklE6xSrwYbcit9UsivWvt2a7s30k8iwWu
 pOecTk9PqhFHnSgOaf3aAwIp4sLz3WQ7LUStkW/LTiUzNGEP1v5pRLx3ui8do3ErpuVi7zZmPwF
 HcAQ=
X-Gm-Gg: ASbGnctb+HrjtF4sMRuOqh6WO+exuibe3Cqgk8OhtN69F62/kk7DGg3xOCqyyYvWtVA
 7L6XBXlfC8QcnqS917zc9L+7nw8RzsymWu5oTsK27P5SYBaNP1Jme4QWVbfUXWF0yRDBdx9QRTf
 Xx3QhXG9tTcQU78eXhXcPzUOmOikQA8X4gvkTHuCgJRatkcYTb51c7oJa3yocKl9z9SlNhaONCe
 VG4XwpPJoQJ6dmNKVsyFsqgzxE7FD5wIyFRzd1cH7KYZ/QhjyWXrQFvejQFRivhLoaUeEHte+i5
 Rt7ThES+oxE4VQ/iDIVMddrSXZiLbrdgjUBp0R6xsWrSYP1Sa1JsL/XhXk+N37ln3g==
X-Google-Smtp-Source: AGHT+IESUJRQAo6EYp11bDp1eO161ExXQ0Ia4GF2BgAYRBqK2fsCfBPEyyIG05JR9SOkp0/NEfrI9Q==
X-Received: by 2002:a05:6000:178d:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-38dea1e118dmr2225310f8f.8.1739360385415; 
 Wed, 12 Feb 2025 03:39:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2e0765esm11984517f8f.82.2025.02.12.03.39.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:39:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 1/5] hw/arm: Mark Allwinner Technology devices as little-endian
Date: Wed, 12 Feb 2025 12:39:34 +0100
Message-ID: <20250212113938.38692-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212113938.38692-1-philmd@linaro.org>
References: <20250212113938.38692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

These devices are only used by the ARM targets, which are
only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/allwinner-a10.c         |  2 +-
 hw/arm/allwinner-h3.c          |  8 ++++----
 hw/arm/allwinner-r40.c         |  2 +-
 hw/i2c/allwinner-i2c.c         |  2 +-
 hw/intc/allwinner-a10-pic.c    |  2 +-
 hw/misc/allwinner-a10-ccm.c    |  2 +-
 hw/misc/allwinner-a10-dramc.c  |  2 +-
 hw/misc/allwinner-cpucfg.c     |  2 +-
 hw/misc/allwinner-h3-ccu.c     |  2 +-
 hw/misc/allwinner-h3-dramc.c   |  6 +++---
 hw/misc/allwinner-h3-sysctrl.c |  2 +-
 hw/misc/allwinner-r40-ccu.c    |  2 +-
 hw/misc/allwinner-r40-dramc.c  | 10 +++++-----
 hw/misc/allwinner-sid.c        |  2 +-
 hw/misc/allwinner-sramc.c      |  2 +-
 hw/net/allwinner-sun8i-emac.c  |  2 +-
 hw/net/allwinner_emac.c        |  2 +-
 hw/rtc/allwinner-rtc.c         |  2 +-
 hw/sd/allwinner-sdhost.c       |  2 +-
 hw/ssi/allwinner-a10-spi.c     |  2 +-
 hw/timer/allwinner-a10-pit.c   |  2 +-
 hw/watchdog/allwinner-wdt.c    |  2 +-
 22 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index a829913f1b5..f1b399759a1 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -158,7 +158,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     /* FIXME use a qdev chardev prop instead of serial_hd() */
     serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2,
                    qdev_get_gpio_in(dev, 1),
-                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
         g_autofree char *bus = g_strdup_printf("usb-bus.%zu", i);
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 2efced3f66a..1b1afa4fb6f 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -408,19 +408,19 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
-                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     /* UART1 */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART1], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART1),
-                   115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(1), DEVICE_LITTLE_ENDIAN);
     /* UART2 */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART2], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART2),
-                   115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(2), DEVICE_LITTLE_ENDIAN);
     /* UART3 */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART3], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART3),
-                   115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(3), DEVICE_LITTLE_ENDIAN);
 
     /* DRAMC */
     sysbus_realize(SYS_BUS_DEVICE(&s->dramc), &error_fatal);
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 47b3180f0ec..cef6e4d18c2 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -492,7 +492,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
 
         serial_mm_init(get_system_memory(), addr, 2,
                        qdev_get_gpio_in(DEVICE(&s->gic), uart_irqs[i]),
-                       115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
+                       115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
     }
 
     /* I2C */
diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
index 16f1d6d40e7..66d6431c508 100644
--- a/hw/i2c/allwinner-i2c.c
+++ b/hw/i2c/allwinner-i2c.c
@@ -407,7 +407,7 @@ static const MemoryRegionOps allwinner_i2c_ops = {
     .write = allwinner_i2c_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription allwinner_i2c_vmstate = {
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index c0f30092cd6..93a604f7a04 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -135,7 +135,7 @@ static void aw_a10_pic_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps aw_a10_pic_ops = {
     .read = aw_a10_pic_read,
     .write = aw_a10_pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_aw_a10_pic = {
diff --git a/hw/misc/allwinner-a10-ccm.c b/hw/misc/allwinner-a10-ccm.c
index 575b0189524..6ca1daaff8a 100644
--- a/hw/misc/allwinner-a10-ccm.c
+++ b/hw/misc/allwinner-a10-ccm.c
@@ -147,7 +147,7 @@ static void allwinner_a10_ccm_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_a10_ccm_ops = {
     .read = allwinner_a10_ccm_read,
     .write = allwinner_a10_ccm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-a10-dramc.c b/hw/misc/allwinner-a10-dramc.c
index a7c58fa6d06..badc4c56eb7 100644
--- a/hw/misc/allwinner-a10-dramc.c
+++ b/hw/misc/allwinner-a10-dramc.c
@@ -114,7 +114,7 @@ static void allwinner_a10_dramc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_a10_dramc_ops = {
     .read = allwinner_a10_dramc_read,
     .write = allwinner_a10_dramc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
index 022f63ddf34..a4f7a011419 100644
--- a/hw/misc/allwinner-cpucfg.c
+++ b/hw/misc/allwinner-cpucfg.c
@@ -217,7 +217,7 @@ static void allwinner_cpucfg_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_cpucfg_ops = {
     .read = allwinner_cpucfg_read,
     .write = allwinner_cpucfg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
index 92e579a9918..e765f4c54b4 100644
--- a/hw/misc/allwinner-h3-ccu.c
+++ b/hw/misc/allwinner-h3-ccu.c
@@ -155,7 +155,7 @@ static void allwinner_h3_ccu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_h3_ccu_ops = {
     .read = allwinner_h3_ccu_read,
     .write = allwinner_h3_ccu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 13bba26d0e4..c4f3eb92747 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -219,7 +219,7 @@ static void allwinner_h3_dramphy_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_h3_dramcom_ops = {
     .read = allwinner_h3_dramcom_read,
     .write = allwinner_h3_dramcom_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -230,7 +230,7 @@ static const MemoryRegionOps allwinner_h3_dramcom_ops = {
 static const MemoryRegionOps allwinner_h3_dramctl_ops = {
     .read = allwinner_h3_dramctl_read,
     .write = allwinner_h3_dramctl_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -241,7 +241,7 @@ static const MemoryRegionOps allwinner_h3_dramctl_ops = {
 static const MemoryRegionOps allwinner_h3_dramphy_ops = {
     .read = allwinner_h3_dramphy_read,
     .write = allwinner_h3_dramphy_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-h3-sysctrl.c b/hw/misc/allwinner-h3-sysctrl.c
index 40059e8cb0c..32a0ceb01a3 100644
--- a/hw/misc/allwinner-h3-sysctrl.c
+++ b/hw/misc/allwinner-h3-sysctrl.c
@@ -78,7 +78,7 @@ static void allwinner_h3_sysctrl_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_h3_sysctrl_ops = {
     .read = allwinner_h3_sysctrl_read,
     .write = allwinner_h3_sysctrl_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
index 005a15b2dae..8f37a9213c0 100644
--- a/hw/misc/allwinner-r40-ccu.c
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -129,7 +129,7 @@ static void allwinner_r40_ccu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_r40_ccu_ops = {
     .read = allwinner_r40_ccu_read,
     .write = allwinner_r40_ccu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 97c3664e3a3..96e1848c21f 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -297,7 +297,7 @@ static void allwinner_r40_dramphy_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_r40_dramcom_ops = {
     .read = allwinner_r40_dramcom_read,
     .write = allwinner_r40_dramcom_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -308,7 +308,7 @@ static const MemoryRegionOps allwinner_r40_dramcom_ops = {
 static const MemoryRegionOps allwinner_r40_dramctl_ops = {
     .read = allwinner_r40_dramctl_read,
     .write = allwinner_r40_dramctl_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -319,7 +319,7 @@ static const MemoryRegionOps allwinner_r40_dramctl_ops = {
 static const MemoryRegionOps allwinner_r40_dramphy_ops = {
     .read = allwinner_r40_dramphy_read,
     .write = allwinner_r40_dramphy_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -358,7 +358,7 @@ static void allwinner_r40_detect_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_r40_detect_ops = {
     .read = allwinner_r40_detect_read,
     .write = allwinner_r40_detect_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -393,7 +393,7 @@ static uint64_t allwinner_r40_dualrank_detect_read(void *opaque, hwaddr offset,
 
 static const MemoryRegionOps allwinner_r40_dualrank_detect_ops = {
     .read = allwinner_r40_dualrank_detect_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 042b747f30b..2bb81f9c540 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -99,7 +99,7 @@ static void allwinner_sid_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_sid_ops = {
     .read = allwinner_sid_read,
     .write = allwinner_sid_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index a20b0b4c5cb..51df5e45aa2 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -104,7 +104,7 @@ static void allwinner_sramc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_sramc_ops = {
     .read = allwinner_sramc_read,
     .write = allwinner_sramc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index ff44554e957..5adb41dc469 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -784,7 +784,7 @@ static void allwinner_sun8i_emac_set_link(NetClientState *nc)
 static const MemoryRegionOps allwinner_sun8i_emac_mem_ops = {
     .read = allwinner_sun8i_emac_read,
     .write = allwinner_sun8i_emac_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 3eb9e09dc5c..47f1e7f086c 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -421,7 +421,7 @@ static void aw_emac_set_link(NetClientState *nc)
 static const MemoryRegionOps aw_emac_mem_ops = {
     .read = aw_emac_read,
     .write = aw_emac_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index a19e4310bb1..fd8355a8676 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -259,7 +259,7 @@ static void allwinner_rtc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_rtc_ops = {
     .read = allwinner_rtc_read,
     .write = allwinner_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index ee5c5c78a81..03980d27168 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -761,7 +761,7 @@ static void allwinner_sdhost_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_sdhost_ops = {
     .read = allwinner_sdhost_read,
     .write = allwinner_sdhost_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c
index 3eb50b44ac5..d2f6bb9cdc7 100644
--- a/hw/ssi/allwinner-a10-spi.c
+++ b/hw/ssi/allwinner-a10-spi.c
@@ -502,7 +502,7 @@ static const MemoryRegionOps allwinner_a10_spi_ops = {
     .write = allwinner_a10_spi_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription allwinner_a10_spi_vmstate = {
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index ddaf2128c2d..da3d7173ef5 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -185,7 +185,7 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps a10_pit_ops = {
     .read = a10_pit_read,
     .write = a10_pit_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const Property a10_pit_properties[] = {
diff --git a/hw/watchdog/allwinner-wdt.c b/hw/watchdog/allwinner-wdt.c
index 1bfec41ff8b..78f4f9d6f67 100644
--- a/hw/watchdog/allwinner-wdt.c
+++ b/hw/watchdog/allwinner-wdt.c
@@ -275,7 +275,7 @@ static void allwinner_wdt_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps allwinner_wdt_ops = {
     .read = allwinner_wdt_read,
     .write = allwinner_wdt_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.47.1


