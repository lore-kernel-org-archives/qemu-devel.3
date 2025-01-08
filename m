Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB02E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKu-0004Ks-LQ; Wed, 08 Jan 2025 04:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKK-0003y6-75; Wed, 08 Jan 2025 04:26:14 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKI-0004q7-Hb; Wed, 08 Jan 2025 04:26:11 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so31100716a12.2; 
 Wed, 08 Jan 2025 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328368; x=1736933168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5XIWWZbGtFfQ4MTLsvT7sCPSQ8s8Yj74r5V10Of4Ng=;
 b=WrpVF1nwocm3q7Url/4je2qzu7K93pg8drKXvh9TTOO608LdLhbKyjB13iy1X44sRX
 ruThUaUcHnXuC2arIwmLGzDi5L/UqiEu3XXGyhed86I0VwHv2BYh23t0tmq+RNWC6olP
 /Q3M4Gh/v64VTSwGcUMCHj3tYdIfZneAnvf1B+ZBVWr0X3ZuNU+0EaPHFwDjGLtfxEEy
 94Tj8pzvlhC4C1xRdADQNCpwrosm4pWvRLXqvRmOR8qX63gap84juoQkti2H0Khxtf/Z
 TR5jzYa7oC/3DZqgd6VvO9tlQyzYvbYfWTGaxeNoJIyLTjJJuJvsyd+VutQEkON5U3cl
 dMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328368; x=1736933168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5XIWWZbGtFfQ4MTLsvT7sCPSQ8s8Yj74r5V10Of4Ng=;
 b=GYuNxu/013Q0ZjSF7WAFaL6GtwGfS3t1fEwmZzTR7VFO8NvXdHLZHyH4/kD0zWrcBv
 XEB1FkaC4iZgdsDV9xIY++EcZZz/Ca3BqrZIoI1FjSAz6zU3bVvSLnu4oNJTbPPsdHTQ
 uFcPaf6Us4srsVwpkgRlwSpwf5i6Jl+XE1WYthSOlqdHnfeanf7ba+cNQmaX7tPMrrKS
 KFW5Fakpu9PfeIMX2rlSlB4eFfgbFEK2RjwTJqnjp8xkTfM/M0Bibm86yyqvD19Qd9tn
 E6mv4Lsu/zdjgo86GibF9YrBF5SiFH5jZUBupXbah2YBvYPkWyU+sjw8TR9E1HQOpVJi
 2DmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8d8jgTa31uc2IPaIVBcVhgjY2F4uh9Rsmhkxf2+jimP3FftjEhnjcD5dBG/lOaUlf3NAlrDN8ja06zg==@nongnu.org,
 AJvYcCUweHQJGs43wsqUru3SOKD3L8m1WtmfeKFN85eWRizczUtm/jb6EaCael1T8QHhk01Dj4IFIHqkrg==@nongnu.org
X-Gm-Message-State: AOJu0Yy634PZH+3HXd8goOrqKttVoW8YQ6Oa7z31pCzSqrI0DRMuj3s8
 9l/Kow6apo/kAFYXWla8+6XDB3Tj5UkA4Umi55nX6j+vaeDbT4N0t5ebF4VT
X-Gm-Gg: ASbGncsSMDY9mbxAK4+/kQ3rsHSyzSyGLRTM1/Lm1wJEgbobnjghkoxHCVvWz3gcluu
 GUyS/aPzLdK2s0mbJj4J8u7y822R8TldvSVPCScjkZFNnjC7aKn4rk5GUTON93vweK8aAbzDD94
 5Doee78bqU38usTQ5HVmgQ2FOwXcaeu3nAyBRo84xo5fiRNg2355zjcViXm/vDdbtdyHwCdbn0q
 yyIjAGn2wS5WSmMGe/Muudvuv3IfE0q4hVwj3AFF5ys/5oLywW3pKR7ga3u/WSrSEDzCl6qegZy
 zlztqZJ5V/MUUZghmjKmWadNBgVlq/Slu0301LMYj4TD9bY=
X-Google-Smtp-Source: AGHT+IESIs4boSwLec1jkASIU/5xuPkKSIQRIUMB9EtuREGeKhWy9xY49lqjFfexevUm5noIheWOjw==
X-Received: by 2002:a05:6402:388a:b0:5d1:2631:b897 with SMTP id
 4fb4d7f45d1cf-5d972e08403mr1800015a12.14.1736328367863; 
 Wed, 08 Jan 2025 01:26:07 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:26:06 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 13/14] hw/misc/imx6_src: Convert DPRINTF() to trace events
Date: Wed,  8 Jan 2025 10:25:37 +0100
Message-ID: <20250108092538.11474-14-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/imx6_src.c   | 23 +++++------------------
 hw/misc/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index dc6a2b92ba..06cc46292e 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -17,18 +17,7 @@
 #include "qemu/module.h"
 #include "target/arm/arm-powerctl.h"
 #include "hw/core/cpu.h"
-
-#ifndef DEBUG_IMX6_SRC
-#define DEBUG_IMX6_SRC 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX6_SRC) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX6_SRC, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx6_src_reg_name(uint32_t reg)
 {
@@ -87,7 +76,7 @@ static void imx6_src_reset(DeviceState *dev)
 {
     IMX6SRCState *s = IMX6_SRC(dev);
 
-    DPRINTF("\n");
+    trace_imx6_src_reset();
 
     memset(s->regs, 0, sizeof(s->regs));
 
@@ -111,7 +100,7 @@ static uint64_t imx6_src_read(void *opaque, hwaddr offset, unsigned size)
 
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx6_src_reg_name(index), value);
+    trace_imx6_src_read(imx6_src_reg_name(index), value);
 
     return value;
 }
@@ -134,8 +123,7 @@ static void imx6_clear_reset_bit(CPUState *cpu, run_on_cpu_data data)
     assert(bql_locked());
 
     s->regs[SRC_SCR] = deposit32(s->regs[SRC_SCR], ri->reset_bit, 1, 0);
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n",
-            imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
+    trace_imx6_clear_reset_bit(imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
 
     g_free(ri);
 }
@@ -173,8 +161,7 @@ static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx6_src_reg_name(index),
-            (uint32_t)current_value);
+    trace_imx6_src_write(imx6_src_reg_name(index), value);
 
     change_mask = s->regs[index] ^ (uint32_t)current_value;
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0f5d2b5666..cf1abe6928 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -253,6 +253,12 @@ ccm_clock_freq(uint32_t clock, uint32_t freq) "(Clock = %d) = %d"
 ccm_read_reg(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
 ccm_write_reg(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 
+# imx6_src.c
+imx6_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx6_src_write(const char *reg_name, uint64_t value) "reg[%s] <= 0x%" PRIx64
+imx6_clear_reset_bit(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
+imx6_src_reset(void) ""
+
 # imx7_src.c
 imx7_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx7_src_write(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
-- 
2.47.1


