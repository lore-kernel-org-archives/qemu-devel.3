Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133D5E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Jx-00044K-96; Sun, 12 Jan 2025 17:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jk-0003Bh-HQ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Je-0006ox-Os
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso26174655e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720417; x=1737325217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFQoJdzHdUvE38GYcn/jd9wG7NJypEZhq9jeSgdzCu0=;
 b=RrLyFnd84LMv06DOormNC19mdDnWuiJLeHlPVtxQuluxFvEO15HOjnhfhalOQiRtX4
 O2bQX0OXBbC2UgwFNx4S24EIKC8h/8L21VJ+/r1f8Jns4d2uPnPC24pqgTKKfMDFmc0k
 f/xnwYw+g4OKGGkvQbkYI/CQ0UKGcbQnduLn2hk6PlJDc73NmtPT+Xk4o2hug628rPm+
 tY0zWZ9tmjIn3Ee0mMU2BPBFaT6dzYUxekSIzcttKeetDDgCtsQa4se18V3IIi1shE79
 BTDIq1D5s/UUI261IAu8Km1u0IUHN6BGjP1lgcBhgxxDKV4c6FYmHe5kTh31lyWhOAA/
 q/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720417; x=1737325217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFQoJdzHdUvE38GYcn/jd9wG7NJypEZhq9jeSgdzCu0=;
 b=YhKXsfcmwAdBoRG/gWHxD8SZl1kTXBCZ0OVwD8ew63ISyseQBO1OFscTHXTPTyU9qi
 83tdDY1nh6pc5xs6p5Ag18eH7d+qsPg7jj3maTTf/RBpMi01c8mqKGkGjG6immRWUbah
 FXycZ5en2oc0Rb7EFKD9hyVo8uMORhCB+I30gpUZhmAZc01xv4t6+7JkJNw4KsX8WO2+
 hL7Or4OA9+aRhXJ2Zt9IV7ix0QZ0f64QwXOGhmy+ixCu8/qqsiutmZQJNzToEr0nNi54
 08wnFb0/Qhat6n04SVh33SHc4BUO9mAdM30hi08NsoHie2OOoNezQsUqE11arXfXfE8G
 jftA==
X-Gm-Message-State: AOJu0Yz0iAP+iX9DgmEoHX6ZMAyHfXLsUbVvW/Xxr8jWDhD78zpSGhWQ
 v8UWLoq+IsaA5NHFKV/ICLKIq2om7XXRuYS8lxDHjB1iYq43KBSEOwOQ3EiivT4LTMBMY+W7J13
 dYdU=
X-Gm-Gg: ASbGnctvVhONyF0u6OoxDpUeLGbARMfjlZXW0/kDfsAr1y2a7ZmkeJopiiN6Ek2QTKZ
 CTzwhRQEp1pnC4SyuQVtClYas+JDlSdXjDyOdBq/NSq9/jBlmjwhJjTsodthGDa/yOD/06P6o6Q
 GxBDvzU+HucjWQ96RPhSGrAdbHG2gkfjrZEC2h8b7N2UFbv1+UteHYDwKZrdx8dqkTTPpysD2xh
 nsQ+GXL4nTqcUIhLj1cPxtKFlOsyPRDrQLzmEXWsl9IBxOrJx8+aMJUVQ1s54Q5GPOClmJQ7Oyz
 aK+esAzL6nYmiJBu7UhQFkVT86L+OPo=
X-Google-Smtp-Source: AGHT+IGEkaYhb9HY5gJX68JJtGMG8NPAumlyuju04zIZU62SMCdtOU5JHS0MogJwekOSftAXcNOi/g==
X-Received: by 2002:a05:600c:3143:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-436e26b9d45mr181464985e9.18.1736720416869; 
 Sun, 12 Jan 2025 14:20:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc81sm124757555e9.5.2025.01.12.14.20.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/49] hw/gpio/imx_gpio: Turn DPRINTF() into trace events
Date: Sun, 12 Jan 2025 23:17:10 +0100
Message-ID: <20250112221726.30206-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

While at it add a trace event for input GPIO events.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20250111183711.2338-14-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/imx_gpio.c   | 18 +++++++-----------
 hw/gpio/trace-events |  5 +++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 898f80f8c83..549a281ed79 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #ifndef DEBUG_IMX_GPIO
 #define DEBUG_IMX_GPIO 0
@@ -34,14 +35,6 @@ typedef enum IMXGPIOLevel {
     IMX_GPIO_LEVEL_HIGH = 1,
 } IMXGPIOLevel;
 
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_GPIO) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_GPIO, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
-
 static const char *imx_gpio_reg_name(uint32_t reg)
 {
     switch (reg) {
@@ -111,6 +104,8 @@ static void imx_gpio_set(void *opaque, int line, int level)
     IMXGPIOState *s = IMX_GPIO(opaque);
     IMXGPIOLevel imx_level = level ? IMX_GPIO_LEVEL_HIGH : IMX_GPIO_LEVEL_LOW;
 
+    trace_imx_gpio_set(DEVICE(s)->canonical_path, line, imx_level);
+
     imx_gpio_set_int_line(s, line, imx_level);
 
     /* this is an input signal, so set PSR */
@@ -200,7 +195,8 @@ static uint64_t imx_gpio_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    DPRINTF("(%s) = 0x%" PRIx32 "\n", imx_gpio_reg_name(offset), reg_value);
+    trace_imx_gpio_read(DEVICE(s)->canonical_path, imx_gpio_reg_name(offset),
+                        reg_value);
 
     return reg_value;
 }
@@ -210,8 +206,8 @@ static void imx_gpio_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMXGPIOState *s = IMX_GPIO(opaque);
 
-    DPRINTF("(%s, value = 0x%" PRIx32 ")\n", imx_gpio_reg_name(offset),
-            (uint32_t)value);
+    trace_imx_gpio_write(DEVICE(s)->canonical_path, imx_gpio_reg_name(offset),
+                         value);
 
     switch (offset) {
     case DR_ADDR:
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index b91cc7e9a45..cea896b28f6 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# imx_gpio.c
+imx_gpio_read(const char *id, const char *reg, uint32_t value) "%s:[%s] -> 0x%" PRIx32
+imx_gpio_write(const char *id, const char *reg, uint32_t value) "%s:[%s] <- 0x%" PRIx32
+imx_gpio_set(const char *id, int line, int level) "%s:[%d] <- %d"
+
 # npcm7xx_gpio.c
 npcm7xx_gpio_read(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
 npcm7xx_gpio_write(const char *id, uint64_t offset, uint64_t value) "%s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
-- 
2.47.1


