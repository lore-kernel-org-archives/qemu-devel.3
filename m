Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70093C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXZ-00046E-GO; Mon, 20 Jan 2025 15:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXU-00042x-JC; Mon, 20 Jan 2025 15:38:28 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXS-0002aF-Mq; Mon, 20 Jan 2025 15:38:28 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso8641472a12.1; 
 Mon, 20 Jan 2025 12:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405504; x=1738010304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fzc6m2g5iiLvtqeih5u2IFw38y7XBfSQIzXv6KF9Euc=;
 b=COH2sbM6mjbRTjt0cz3Pf+sQHxW5NeBbUjZDMq6TADpUCA62nfOh/xkiPd5nn+1xrJ
 Nm6/RC5AKrf0osOX2AgO4B7V1G6fX+4eaZiLb+FHp/6dp6fC90HNZmULSvzR9Tna4cBG
 DszQvtgCZufqiR/VyoVANCb3lia99O851ZihxAgQJ0Xzdgv6QurcoyhcoSgOa5dF+i5S
 JP4LAm95b6XTaE/HWGRJ0C580TZUsn/aXYRzVPaxw6PK3qlarsyKMUnZo5DjU1STd8hd
 nrnBgws7XL2CS7t91i9FvImqVgNxnM3LdSRbMJqO7B2RumSYti0yHvmWET/wqKKC+Tcq
 Q74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405504; x=1738010304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fzc6m2g5iiLvtqeih5u2IFw38y7XBfSQIzXv6KF9Euc=;
 b=uVdYq3KbRgRUCfX36MVz4zAnp/ujUDpkNEu3qjgN6YchTPvIsCy1z+vTsfNKsu2UJB
 acUdVrxtE+yBkIfnXFFC8fWB0H69ZKp/+8Xgii+zjIix5W/qBSry1Skaqa+gPeNXw1BR
 6dwAQPKM64nBQhUO78m0IbYYEfg112UYbJyy5rJ4P8SLh83tR1N+XGbzzAi2HuXJEmCv
 ZBzTWDK8pkwE4YfJoadYjSD43bLWi6DwSk6KIIdntzauxHvGRS99/+V8cnP5XjMEkmdr
 wXi8JvtMQq9IAEUrf3aW0t58RexQlnaLS/QCZ9qkrulF+1rOP3BfvVhll0pBXufhr/7K
 A98Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf1IV/tNEf8BbNk3tk4GBuQRKd1wtV5Nvk1uu8+Qz1razm8R5EbCKqNVsUKtHE9VjDBoQ9YtIP0g==@nongnu.org
X-Gm-Message-State: AOJu0YzEqIK5c+OS0Ozv2EDQbHBItEutaN2zX+2PMnlEueUcQymoQ2VX
 XvR+hAE/XshMmAS7cOxq9lflqiKLS81ZD4L+pMvsL5Ih63omm0SkCfclEuwj
X-Gm-Gg: ASbGncvSlxH3K+WNsRh3t5zkoAND75jRDt0nHlCyvSnBjjN8K4RAPuAHIeKdhFmObU1
 r/9MJxYYb1gAM/O6wlVfC2usaNHnrMOSsktxYElxB69XDl0g4yBLe3mht2z1jgYXuvJ4x2qcFxd
 x8TFQJpn3NqUyzAftQtyD542LddeTIFNCSuEa/2XPMdOW811upBXLKR9IvI5GC63G7qLrHcO/OU
 JRgLg0447UMJ2aWkrLAWTUmkBvNKQAhl/Z5Tqgg/Cj8uQ2MKekdt+alHcns53eEBG0ZFJyhf1AN
 m0oHQtaNqJLqD2pi6qu1b5adRDlE2NWuD8p1qYD8ijWUaXQFppaGQK0s49Yp
X-Google-Smtp-Source: AGHT+IHOcTeF+6oQ7MptGi4n4ofel+2NKQSTQgmb03i2NICItpwGE0/01IxgGABX7c05+H5SCB99Jw==
X-Received: by 2002:a05:6402:2686:b0:5db:67a7:e741 with SMTP id
 4fb4d7f45d1cf-5db7d2f5e87mr10808839a12.8.1737405504325; 
 Mon, 20 Jan 2025 12:38:24 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:23 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 19/21] hw/rtc: Add Ricoh RS5C372 RTC emulation
Date: Mon, 20 Jan 2025 21:37:46 +0100
Message-ID: <20250120203748.4687-20-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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

The implementation just allows Linux to determine date and time.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS         |   1 +
 hw/rtc/rs5c372.c    | 227 ++++++++++++++++++++++++++++++++++++++++++++
 hw/rtc/Kconfig      |   5 +
 hw/rtc/meson.build  |   1 +
 hw/rtc/trace-events |   4 +
 5 files changed, 238 insertions(+)
 create mode 100644 hw/rtc/rs5c372.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d2cdc790ff..7531d65429 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -827,6 +827,7 @@ F: hw/arm/imx8mp-evk.c
 F: hw/arm/fsl-imx8mp.c
 F: hw/misc/imx8mp_*.c
 F: hw/pci-host/fsl_imx8m_phy.c
+F: hw/rtc/rs5c372.c
 F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
diff --git a/hw/rtc/rs5c372.c b/hw/rtc/rs5c372.c
new file mode 100644
index 0000000000..d300f93e13
--- /dev/null
+++ b/hw/rtc/rs5c372.c
@@ -0,0 +1,227 @@
+/*
+ * Ricoh RS5C372, R222x I2C RTC
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * Based on hw/rtc/ds1338.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qemu/bcd.h"
+#include "qom/object.h"
+#include "system/rtc.h"
+#include "trace.h"
+
+#define NVRAM_SIZE 0x10
+
+/* Flags definitions */
+#define SECONDS_CH 0x80
+#define HOURS_PM   0x20
+#define CTRL2_24   0x20
+
+#define TYPE_RS5C372 "rs5c372"
+OBJECT_DECLARE_SIMPLE_TYPE(RS5C372State, RS5C372)
+
+struct RS5C372State {
+    I2CSlave parent_obj;
+
+    int64_t offset;
+    uint8_t wday_offset;
+    uint8_t nvram[NVRAM_SIZE];
+    uint8_t ptr;
+    uint8_t tx_format;
+    bool addr_byte;
+};
+
+static const VMStateDescription vmstate_rs5c372 = {
+    .name = "rs5c372",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, RS5C372State),
+        VMSTATE_INT64(offset, RS5C372State),
+        VMSTATE_UINT8_V(wday_offset, RS5C372State, 2),
+        VMSTATE_UINT8_ARRAY(nvram, RS5C372State, NVRAM_SIZE),
+        VMSTATE_UINT8(ptr, RS5C372State),
+        VMSTATE_UINT8(tx_format, RS5C372State),
+        VMSTATE_BOOL(addr_byte, RS5C372State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void capture_current_time(RS5C372State *s)
+{
+    /*
+     * Capture the current time into the secondary registers which will be
+     * actually read by the data transfer operation.
+     */
+    struct tm now;
+    qemu_get_timedate(&now, s->offset);
+    s->nvram[0] = to_bcd(now.tm_sec);
+    s->nvram[1] = to_bcd(now.tm_min);
+    if (s->nvram[0xf] & CTRL2_24) {
+        s->nvram[2] = to_bcd(now.tm_hour);
+    } else {
+        int tmp = now.tm_hour;
+        if (tmp % 12 == 0) {
+            tmp += 12;
+        }
+        if (tmp <= 12) {
+            s->nvram[2] = to_bcd(tmp);
+        } else {
+            s->nvram[2] = HOURS_PM | to_bcd(tmp - 12);
+        }
+    }
+    s->nvram[3] = (now.tm_wday + s->wday_offset) % 7 + 1;
+    s->nvram[4] = to_bcd(now.tm_mday);
+    s->nvram[5] = to_bcd(now.tm_mon + 1);
+    s->nvram[6] = to_bcd(now.tm_year - 100);
+}
+
+static void inc_regptr(RS5C372State *s)
+{
+    s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
+}
+
+static int rs5c372_event(I2CSlave *i2c, enum i2c_event event)
+{
+    RS5C372State *s = RS5C372(i2c);
+
+    switch (event) {
+    case I2C_START_RECV:
+        /*
+         * In h/w, capture happens on any START condition, not just a
+         * START_RECV, but there is no need to actually capture on
+         * START_SEND, because the guest can't get at that data
+         * without going through a START_RECV which would overwrite it.
+         */
+        capture_current_time(s);
+        s->ptr = 0xf;
+        break;
+    case I2C_START_SEND:
+        s->addr_byte = true;
+        break;
+    default:
+        break;
+    }
+
+    return 0;
+}
+
+static uint8_t rs5c372_recv(I2CSlave *i2c)
+{
+    RS5C372State *s = RS5C372(i2c);
+    uint8_t res;
+
+    res  = s->nvram[s->ptr];
+
+    trace_rs5c372_recv(s->ptr, res);
+
+    inc_regptr(s);
+    return res;
+}
+
+static int rs5c372_send(I2CSlave *i2c, uint8_t data)
+{
+    RS5C372State *s = RS5C372(i2c);
+
+    if (s->addr_byte) {
+        s->ptr = data >> 4;
+        s->tx_format = data & 0xf;
+        s->addr_byte = false;
+        return 0;
+    }
+
+    trace_rs5c372_send(s->ptr, data);
+
+    if (s->ptr < 7) {
+        /* Time register. */
+        struct tm now;
+        qemu_get_timedate(&now, s->offset);
+        switch (s->ptr) {
+        case 0:
+            now.tm_sec = from_bcd(data & 0x7f);
+            break;
+        case 1:
+            now.tm_min = from_bcd(data & 0x7f);
+            break;
+        case 2:
+            if (s->nvram[0xf] & CTRL2_24) {
+                now.tm_hour = from_bcd(data & 0x3f);
+            } else {
+                int tmp = from_bcd(data & (HOURS_PM - 1));
+                if (data & HOURS_PM) {
+                    tmp += 12;
+                }
+                if (tmp % 12 == 0) {
+                    tmp -= 12;
+                }
+                now.tm_hour = tmp;
+            }
+            break;
+        case 3:
+            {
+                /*
+                 * The day field is supposed to contain a value in the range
+                 * 1-7. Otherwise behavior is undefined.
+                 */
+                int user_wday = (data & 7) - 1;
+                s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
+            }
+            break;
+        case 4:
+            now.tm_mday = from_bcd(data & 0x3f);
+            break;
+        case 5:
+            now.tm_mon = from_bcd(data & 0x1f) - 1;
+            break;
+        case 6:
+            now.tm_year = from_bcd(data) + 100;
+            break;
+        }
+        s->offset = qemu_timedate_diff(&now);
+    } else {
+        s->nvram[s->ptr] = data;
+    }
+    inc_regptr(s);
+    return 0;
+}
+
+static void rs5c372_reset(DeviceState *dev)
+{
+    RS5C372State *s = RS5C372(dev);
+
+    /* The clock is running and synchronized with the host */
+    s->offset = 0;
+    s->wday_offset = 0;
+    memset(s->nvram, 0, NVRAM_SIZE);
+    s->ptr = 0;
+    s->addr_byte = false;
+}
+
+static void rs5c372_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = rs5c372_event;
+    k->recv = rs5c372_recv;
+    k->send = rs5c372_send;
+    device_class_set_legacy_reset(dc, rs5c372_reset);
+    dc->vmsd = &vmstate_rs5c372;
+}
+
+static const TypeInfo rs5c372_types[] = {
+    {
+        .name          = TYPE_RS5C372,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(RS5C372State),
+        .class_init    = rs5c372_class_init,
+    },
+};
+
+DEFINE_TYPES(rs5c372_types)
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 2fe04ec1d0..315b0e4ecc 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -26,3 +26,8 @@ config GOLDFISH_RTC
 
 config LS7A_RTC
     bool
+
+config RS5C372_RTC
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 8ecc2d792c..6c87864dc0 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_RTC', if_true: files('goldfish_rtc.c'))
 system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
+system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372.c'))
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 8012afe102..b9f2852d35 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -35,3 +35,7 @@ m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x val
 # goldfish_rtc.c
 goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
+
+# rs5c372.c
+rs5c372_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0x%02" PRIx8
+rs5c372_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0x%02" PRIx8
-- 
2.48.1


