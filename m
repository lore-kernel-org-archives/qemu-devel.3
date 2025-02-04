Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB0EC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF89-0005nY-1M; Tue, 04 Feb 2025 04:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7p-00057T-Qx; Tue, 04 Feb 2025 04:21:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7n-00056q-2m; Tue, 04 Feb 2025 04:21:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so61911125e9.0; 
 Tue, 04 Feb 2025 01:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660900; x=1739265700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8F5xCOhhynwLC/fmoiu9ikpJz3majDALcSrfoJxGNU=;
 b=NYsVII0Ni2/bJXI1Sb7ydkHQBrob4AXMyhRYfGaOCUl66lVaShon/8KOjN1vomdWu0
 Kzn7C94ySa6p+p13444LfodBnVlGdCB2rbBdMXsm5WUt1oGCQQaQ1uJ/sdv56n4bwVUN
 EReXf/szOZ4yYYOVD3GWQrz5q+aiRy7HQxPRKG5X1VPgLEBxbERR3WRvjmxDbGyI55fy
 WR+86ARmW87bmkdWIquydmXDm+ZOmXpbNB4jbDKm4+NBYp9owiJkKRU3aDM8/0GID5A/
 njajA3/XdWUPg8CiHXmz8p4VmGmWrxjtfagfHW8fioLmb2ZIcjh+zC/YHesDLY3i1/kX
 LGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660900; x=1739265700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8F5xCOhhynwLC/fmoiu9ikpJz3majDALcSrfoJxGNU=;
 b=wdLVv9I9ifZhLsr8pDXOw87EPFoZLxvATiembwXUrFhuFzdR4IKjNUkVzhBAmjsLrg
 2v5mDE0I9nTSBE7yTcOKjqaeT1mG7z5C45M0FGr8BiaKdmDZqM3fK4Whk9k/IUDhOlvv
 bwuea9D73RbE9pShUJjNi3hExK2SfJewfTWKi2FPhOHinSAN0tXejiUNptZAoq/GGuOy
 JTv0HAwcbjs9InKiJMQkwi1tBPtomMAPHWmI+6soyQLuPx4IsnlEf3eEsYRJLj6xlNEB
 2eY2SCsWKGFE5vngxrhLOy745e7wEnkUfUc6IAQ6dSU4Jrigzgzh4103GD20X7grmm6R
 BQUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeBe14s4mDWUOiD+4H6bYGKesQ33rsDACQAtPcxM+V73Vh14fDg2XzfawDwiuCsb+bhW7Lg3sddg==@nongnu.org
X-Gm-Message-State: AOJu0YxayrxeuUTFCgKhNWlJX34pLFdFkcCOEiNnYT1LtT1x4An63Ovn
 tDmF/1/yuCmaoAVUt3JfgF/latZd2XIfVQ8+zmRT8L2uELXBhHL0uvxbkQ==
X-Gm-Gg: ASbGncvuKRMuD09Dd0r3aDQpBPKzRCBQM1qz8kGlUrfN5nzWbiBEDl7TBb3791tlMC8
 kINTFupFQdBR01AedwQP7aToPW5nKiUpq+8NSM9LCSovJRgLoZWzwWgsCVpbz3VuUfMywPtIypB
 jQwdWGA0Ab+HZxJyCL6ONAfBbb456V7bwfSLsajEjMS08PLgepYYNFeceH9NUq+iwP1qzEEpDDt
 kKvfbL8aiaXXAwMvaVPvbuQt9PRVVAFOOL+CaVpZB63u3ziQkF4wHqTgqx3e6jBVs0Bi+GBsiVl
 WOit/p0ciE/COfDay1hlWFAH1gT9ripKbsKThICPf2al2izdVlfn2Ip4Nwni8c+JEpGoc/F7OWF
 q9PbxugIUJw==
X-Google-Smtp-Source: AGHT+IFMOtTAn3ue3kgHE8ein66zQhRIcjQViAjG5icJHCgknCWW3DwDTss+7TPeWjyaKixPdL09Eg==
X-Received: by 2002:a05:600c:4f07:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-438dc40da5dmr201147225e9.23.1738660900342; 
 Tue, 04 Feb 2025 01:21:40 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:39 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
Date: Tue,  4 Feb 2025 10:21:12 +0100
Message-ID: <20250204092112.26957-19-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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
index ee837a3f6e..d87435adba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -828,6 +828,7 @@ F: hw/arm/imx8mp-evk.c
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


