Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B5E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSLk-0005Zw-Pr; Wed, 08 Jan 2025 04:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKI-0003y2-T6; Wed, 08 Jan 2025 04:26:14 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKH-0004pr-9K; Wed, 08 Jan 2025 04:26:10 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so1881761266b.1; 
 Wed, 08 Jan 2025 01:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328366; x=1736933166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47JwbBXTIXSphmQBXHikRa/hsHdiVRz6iqvffl0LB6Y=;
 b=SMOG6IyZyNdqlFTLY3aZlsh9BjgDQvAQ4i9wDoPydWZcexIaOuRlDKgSW7F+7yzc9s
 xQ5PqZWdjUCNKF5ySU9cFO8ZLzo01p2q6CjMiDNp2/5x04oBmaXmRElNmKEwFbpOL4ci
 IwCJ30VhbMgZzZWOZEmSL90m2zIg0yTobTbpsDAWwNXBcayjXAEbQByqHAV5SL7GvwDn
 1SiwiPreOchYD6owf7Cz+u4UX1FSlPGP5nRqelwcK3jk8ddpDgm1cLZa4fXRQEJJdPT8
 H5UyRWz/LCUSpZhVYm13QvIe0nBykay1qSLzAw9kNTAFlqbn0d5ueH7lk2O60hvo/0D+
 lOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328366; x=1736933166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47JwbBXTIXSphmQBXHikRa/hsHdiVRz6iqvffl0LB6Y=;
 b=Vl4k3iYZok1I6awFiPMMv95tVuBTAb1Mr0CVmUddDJnVv4AMU+czoREuwdfVQRoM6p
 nW+TbnCSYZ6ZpnydGuuXgz5sn3zzGxVxoSvEHjxnoF/xtpFOO47q3bPqYbqOWCz7/MvI
 r8EdZMPq18T26gL/1RIYAkSUeTp6owPfEWBPUwi/rYEX0OTxznBher4tt6BAGcY0RqRm
 NgSgnyGbbhLJjbbBMklDncdX4H+CXvduLEx4RMSqIwLw7+X3Z68jl78WTHKpWB1w7Uet
 XSk33Lh2SJsd2rfbQzPp8Ik/MVrdsyHyIAGGgQJOgYN11bohZgw1Sh+j+wE9pFDlgO9p
 dyyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmdJlQcm6bqu5sYUplGIEYK812C0H7/6nN6PIRf11VEh3FJ7jQJexdaFPogI+9Ckt8zqEYewvv5D5Kzg==@nongnu.org,
 AJvYcCVxUt1m0aX4RJei2RFa8Z4A0xF0PquaZVAJrj9IsfzuAgK02I3zXv2tzBwQLzpL12frSG7O8P/R9g==@nongnu.org
X-Gm-Message-State: AOJu0YzupVRBsLYYN7o+vRuq7dpVa17/Y91BVRS7ks/xpAnUjJZBjFO8
 R/ixVdSk5+61moCMG/BLa+YwKo9fwGVqGCyfI25fboqA9uVeNXder6NpihY6
X-Gm-Gg: ASbGncsFo5tqqIxoJRdwhzSpilUpqnUqtVo6w1LRvaseEMg+yj4P7DQOQ1wP/RNMgm4
 YLi6sEpLHKui0xWgiY5K0H1Po+4vDcksm7Hy/TRerLdqTBbQqVQMYs09t/OraZDX87GxTjifz8l
 grGjcsGLqobNGS+IDmKMzpoeoYOv3Nu2zJ1GBRBKpvNnlYNUQbAaztgmynAvOFYtWbrkvm47NiT
 36pLm35MpS1+YsUwx6Fa5sS+57f82JNWe3aKbowpMf0bPJC7MiHwMFR/YD5elfv3Wc0JOYFsVEZ
 Jv5p7zIug9RZ9m8qqOkFqUauuDyFeZgrGXFuSMHfuJesErw=
X-Google-Smtp-Source: AGHT+IF37DM0lPHB6Ht98gxxrmOuEFwmsCCUIHmk5DNfMwiQGRjHc//EVHJJ1SocaxQ68nZdO5pjog==
X-Received: by 2002:a05:6402:4405:b0:5d4:35c7:cd7a with SMTP id
 4fb4d7f45d1cf-5d972e0b20cmr4743427a12.10.1736328366331; 
 Wed, 08 Jan 2025 01:26:06 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:26:05 -0800 (PST)
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
Subject: [PATCH 12/14] hw/i2c/imx_i2c: Convert DPRINTF() to trace events
Date: Wed,  8 Jan 2025 10:25:36 +0100
Message-ID: <20250108092538.11474-13-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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

Also print the MMIO address when tracing. This allows to distinguishing the
many instances a typical i.MX SoC has.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i2c/imx_i2c.c    | 21 +++++----------------
 hw/i2c/trace-events |  5 +++++
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index c565fd5b8a..be1688c064 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -25,18 +25,7 @@
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-
-#ifndef DEBUG_IMX_I2C
-#define DEBUG_IMX_I2C 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_I2C) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_I2C, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx_i2c_get_regname(unsigned offset)
 {
@@ -152,8 +141,8 @@ static uint64_t imx_i2c_read(void *opaque, hwaddr offset,
         break;
     }
 
-    DPRINTF("read %s [0x%" HWADDR_PRIx "] -> 0x%02x\n",
-            imx_i2c_get_regname(offset), offset, value);
+    trace_imx_i2c_read(s->iomem.addr, imx_i2c_get_regname(offset), offset,
+                       value);
 
     return (uint64_t)value;
 }
@@ -163,8 +152,8 @@ static void imx_i2c_write(void *opaque, hwaddr offset,
 {
     IMXI2CState *s = IMX_I2C(opaque);
 
-    DPRINTF("write %s [0x%" HWADDR_PRIx "] <- 0x%02x\n",
-            imx_i2c_get_regname(offset), offset, (int)value);
+    trace_imx_i2c_read(s->iomem.addr, imx_i2c_get_regname(offset), offset,
+                       value);
 
     value &= 0xff;
 
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index f708a7ace1..c6cba1ecf6 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -56,3 +56,8 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
 
 pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
 pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
+
+# imx_i2c.c
+
+imx_i2c_read(uint64_t addr, const char *reg, uint64_t ofs, uint64_t value) "0x%" PRIx64 ":[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
+imx_i2c_write(uint64_t addr, const char *reg, uint64_t ofs, uint64_t value) "0x%" PRIx64 ":[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
-- 
2.47.1


