Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B53E7719C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMi-0007Ju-LV; Sat, 11 Jan 2025 13:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMg-0007Ie-Bp; Sat, 11 Jan 2025 13:37:42 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMe-0003yD-Ol; Sat, 11 Jan 2025 13:37:42 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso628760666b.1; 
 Sat, 11 Jan 2025 10:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620658; x=1737225458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cijIcZdZaAOihYoMkcsx+H5h8BGPo9Nea9lYvcHlISQ=;
 b=TATGpqdctNPXEQ2AI1UjHlO0+jYa9bUkrnKQvPoqycaMsUwo0nySzhH/kiOcPVk/Or
 9IraK7fgH7m2RQ1ioOyXXo7LftTns8nLDtpxKAeDc+AqobSExwg9PRfKl2OvySMa+y5Q
 5xgdom/a20P8AP5lHWAIavDbpjbshvVqv5ogB1cSJ+oNnQtraWp3R7TCttrLS4EC8BQS
 RJM5zKo0XRnMbh3dvTWoYwRfbUpaFwzxdXDxAvp4x+Tu1D2HT0DjcUdFFCk53LjMWe4q
 CnAbzj55dPNKC011KwT3apCi2zCYuzUW1xGNEoFG0VcN30i0t0xaEDwLErWtxSVf+CVj
 X+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620658; x=1737225458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cijIcZdZaAOihYoMkcsx+H5h8BGPo9Nea9lYvcHlISQ=;
 b=Db88SgiY63b53DpeGuSSOnbOHzZS1353sVxinU8UGCT2ZpRImSYMIrHUeFRiu8mM1r
 tlT3IQa/cZ0fWVwqsJ/6Q1a3vzlddKyLuuFVMVvYuWyKIh771jjStDAq5k0TfkdMKH6H
 z4V3FUipNwjmsNZrNals91mq2o4rANryMqIf64x6PzlDvc6NFlmVsqcm0935wuVmpaXV
 LijpfmomoNa5hkWUby/TGnYItWzklLVuipaLhaDIGahGfbtkt0nkv4Zp8bnhNHiHRFqa
 sOkXOou47TqwP/o1hJZJABLON+HJ9PKFtOrkgFbxu23dj8NqndcLRBAO0q+kCDVGW8CH
 NAQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYbctGGPDFZhJG1fdLAeqrLjDYHHSXSuO385voz5j6STTTUiIcmnczLP7A6pRVEvHRP+O11Y8zCQ==@nongnu.org,
 AJvYcCXNSuLGRiBvL9wWVOYfmRftbhQ+wGPC8c9QrCmBfMupanWqk3y0fC6yke7f4hqCGL6n+07QfgmyAyHujw==@nongnu.org
X-Gm-Message-State: AOJu0Yz2UhQ9vxnXGUmQb9h+I5craHqyG7rhBjPfP76hCHI1MQT77CDW
 qNfvoxI4wwmDW3bSZHB5YWwDkOEWIaaZtKUn9NEAUtFtJC87+8UTo7EkEQ==
X-Gm-Gg: ASbGnctm/52VAaAI7s9nWKkN/i2rNY8gS48Mrf0Rj9SXFxi6cEWntegauc4bRO2Gven
 xNbz2EEQSgN1c1fvSYXYZWlyLCrVtJcxaKYtPFyDkNDJEPEKTD4KHPEElC4CJEGOqBRbyfbPrNQ
 H5Vg/ET4jaiIU6DfL8Z//ZBPin1+k1hTMOa6ItKItOxeePcQYJxKotohjPon8N3vgcgog8Fi0FQ
 ZMk0slixORHggupjXCLjXHYMl+j4/1KmM9eplgFE1TgDoRDoyBtsxpeAdxAaZbZ5/xYYeZePTS5
 Ay0Ueifl9l2Nbbi5TFb2rXMeav0KUDGGoDFY5HqvF+I=
X-Google-Smtp-Source: AGHT+IEc1JrxjdcpdFoR3Xop+lrAc1XAU2Rhx0DX+V1+hzaGHAmKq1aKYgdDTovpI4yiTZnQ7nKbsw==
X-Received: by 2002:a17:907:1b83:b0:ab2:aea7:510f with SMTP id
 a640c23a62f3a-ab2aea752a0mr1010000566b.30.1736620658097; 
 Sat, 11 Jan 2025 10:37:38 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:36 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 13/13] hw/gpio/imx_gpio: Turn DPRINTF() into trace events
Date: Sat, 11 Jan 2025 19:37:11 +0100
Message-ID: <20250111183711.2338-14-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

While at it add a trace event for input GPIO events.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/imx_gpio.c   | 18 +++++++-----------
 hw/gpio/trace-events |  5 +++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 67c47a7280..25546221e0 100644
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
index b91cc7e9a4..cea896b28f 100644
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
2.48.0


