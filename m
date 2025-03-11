Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0024EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5de-0006sU-Am; Tue, 11 Mar 2025 15:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5da-0006ri-Hw
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dY-0007QL-5n
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:38 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-391211ea598so3307103f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722694; x=1742327494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjZxaci+AWW80mCnNHLbSlblGL4pybx4K0i3v1rxIiE=;
 b=RZR/GB25cNgjhK3VhK2Dq0QZrL5s9r06P40khlk1VcH8A6ptAA8pcIjU0qamMgjlb6
 94/0ZqDXTWnr4HlRNylog+UBCPDvM0e2Bb3JsYCMczCs9mJPHs/o9DdOYZS7W41jILZY
 O8OxRpx6OkHhgsSs9W19YxJ1exgIdcJXfw8YZ7ZNxy1jmIqWawsBQhKpQJuasliimqVX
 j22dwHHbGhPjWth48mlgkOQnszGgNtsaV7FbSICeIS2LVTFBjqYRTQSnxnrRLllEsbZM
 LlsDRovkQh5pd2fyxr9GQl0Ss+43JOlJjkWnUE3AtbS7dlSuobKyP6cvdyONQ7ziMLds
 4PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722694; x=1742327494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjZxaci+AWW80mCnNHLbSlblGL4pybx4K0i3v1rxIiE=;
 b=VpYnUmiXR25Psb6JL7ZgueIFAwHiW+PSWIyQS2SS3+f76efpBXYmIMfL5wZWuzWTpt
 4GVJY5KlTgH0JCrJOALvJTclrsCCl8rWkTeitNRL55gsNM9uXMo6DmNt2oKtMhZRCj/o
 4aA5BUWWxMUBxXhaargIWJymbEja2X17xoqQcqpP5D+UnWailWctPcG+QjjgRZFm9yFf
 Ybk/JovveHS9Y62/TgPkNTUEOfve5rECcRwIzKmegdPrMaKq5QkvflY56DHMp8jM1UJb
 VdeYVsq7G1OkbV85DjuSNoTf2V5EVzDcT4SwQrL69ba4Mw98NDNIOJ8RlRWbvY3zvmbt
 gGrg==
X-Gm-Message-State: AOJu0YxOC8GjoHGNlpgIO3EOnFJqGiKiHKPmlw3LsjgFQSgw9+IChUYT
 wuoWp7NlrRkGvHkTN7EBFsUrWO3Uo1pBQW9qJjzQ4ksrYC9k5n7UvrrtAkf9Ly6Ua46ENjsGmUH
 A8Do=
X-Gm-Gg: ASbGncvDi+B+3zlWDYhOuuUsFyg6GmidXIFk/amJarw0q44JslG4gay9pbBhsH+GRq0
 IJJqIJz6QMzMua5uwklqAGOX2DW4j4z8rrlrrYf9BgumAZzbi3HLiNPXSgR/1GX0RkTtQTSmSKA
 V2sn3HIYoVZXWacIwL6o+KK7qbcYR+E8wDwbzJwdNpxYmGs6xHhhwS3xwPRgQz9Lho/xYtigOkX
 HgdwjmrPWCIFBktOWZWOdmgiywJrelnzj0pGXEBjRWp1MVTeq3vBY+jl1+BkgS3pX9QQTba8J8W
 cbLw39UALYKrePU+JpN2lQKxLg+NgMQc9l98zO7CMxjz9FmW2oA0tY1vGYMRWqdjtzBtxXPN+Yp
 9QON7xj34p0bzVHFGshA=
X-Google-Smtp-Source: AGHT+IEOEiBGzsLTZZAND5xAqc2eMD1xtmrid+JIctNK07GnLE6LS0QFpjXiUhzMbmMF7FqYQa5PFQ==
X-Received: by 2002:a05:6000:188c:b0:391:2f71:bbb3 with SMTP id
 ffacd0b85a97d-39132db782cmr15785510f8f.46.1741722694039; 
 Tue, 11 Mar 2025 12:51:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce5d2808dsm132195345e9.13.2025.03.11.12.51.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 02/14] hw/rtc: Add Ricoh RS5C372 RTC emulation
Date: Tue, 11 Mar 2025 20:51:11 +0100
Message-ID: <20250311195123.94212-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

The implementation just allows Linux to determine date and time.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250223114708.1780-19-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                |   2 +
 hw/rtc/rs5c372.c           | 236 +++++++++++++++++++++++++++++++++++++
 tests/qtest/rs5c372-test.c |  43 +++++++
 hw/rtc/Kconfig             |   5 +
 hw/rtc/meson.build         |   1 +
 hw/rtc/trace-events        |   4 +
 tests/qtest/meson.build    |   1 +
 7 files changed, 292 insertions(+)
 create mode 100644 hw/rtc/rs5c372.c
 create mode 100644 tests/qtest/rs5c372-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e5db7a5744..e34de420f08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -827,10 +827,12 @@ F: hw/arm/imx8mp-evk.c
 F: hw/arm/fsl-imx8mp.c
 F: hw/misc/imx8mp_*.c
 F: hw/pci-host/fsl_imx8m_phy.c
+F: hw/rtc/rs5c372.c
 F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
 F: docs/system/arm/imx8mp-evk.rst
+F: tests/qtest/rs5c372-test.c
 
 MPS2 / MPS3
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/rtc/rs5c372.c b/hw/rtc/rs5c372.c
new file mode 100644
index 00000000000..5542f74085a
--- /dev/null
+++ b/hw/rtc/rs5c372.c
@@ -0,0 +1,236 @@
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
+#include "hw/qdev-properties.h"
+#include "hw/resettable.h"
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
+static void rs5c372_reset_hold(Object *obj, ResetType type)
+{
+    RS5C372State *s = RS5C372(obj);
+
+    /* The clock is running and synchronized with the host */
+    s->offset = 0;
+    s->wday_offset = 0;
+    memset(s->nvram, 0, NVRAM_SIZE);
+    s->ptr = 0;
+    s->addr_byte = false;
+}
+
+static const VMStateDescription rs5c372_vmstate = {
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
+static void rs5c372_init(Object *obj)
+{
+    qdev_prop_set_uint8(DEVICE(obj), "address", 0x32);
+}
+
+static void rs5c372_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    k->event = rs5c372_event;
+    k->recv = rs5c372_recv;
+    k->send = rs5c372_send;
+    dc->vmsd = &rs5c372_vmstate;
+    rc->phases.hold = rs5c372_reset_hold;
+}
+
+static const TypeInfo rs5c372_types[] = {
+    {
+        .name          = TYPE_RS5C372,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(RS5C372State),
+        .instance_init = rs5c372_init,
+        .class_init    = rs5c372_class_init,
+    },
+};
+
+DEFINE_TYPES(rs5c372_types)
diff --git a/tests/qtest/rs5c372-test.c b/tests/qtest/rs5c372-test.c
new file mode 100644
index 00000000000..0f6a9b68b9f
--- /dev/null
+++ b/tests/qtest/rs5c372-test.c
@@ -0,0 +1,43 @@
+/*
+ * QTest testcase for the RS5C372 RTC
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * Based on ds1338-test.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bcd.h"
+#include "libqos/i2c.h"
+
+#define RS5C372_ADDR 0x32
+
+static void rs5c372_read_date(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = obj;
+
+    uint8_t resp[0x10];
+    time_t now = time(NULL);
+    struct tm *utc = gmtime(&now);
+
+    i2c_read_block(i2cdev, 0, resp, sizeof(resp));
+
+    /* check retrieved time against local time */
+    g_assert_cmpuint(from_bcd(resp[5]), == , utc->tm_mday);
+    g_assert_cmpuint(from_bcd(resp[6]), == , 1 + utc->tm_mon);
+    g_assert_cmpuint(2000 + from_bcd(resp[7]), == , 1900 + utc->tm_year);
+}
+
+static void rs5c372_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = { };
+    add_qi2c_address(&opts, &(QI2CAddress) { RS5C372_ADDR });
+
+    qos_node_create_driver("rs5c372", i2c_device_create);
+    qos_node_consumes("rs5c372", "i2c-bus", &opts);
+    qos_add_test("read_date", "rs5c372", rs5c372_read_date, NULL);
+}
+
+libqos_init(rs5c372_register_nodes);
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 2fe04ec1d04..315b0e4eccd 100644
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
index 8ecc2d792c1..6c87864dc07 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_RTC', if_true: files('goldfish_rtc.c'))
 system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
+system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372.c'))
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 8012afe1021..b9f2852d35f 100644
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8a6243382a1..9e5380ba7a2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -298,6 +298,7 @@ qos_test_ss.add(
   'pca9552-test.c',
   'pci-test.c',
   'pcnet-test.c',
+  'rs5c372-test.c',
   'sdhci-test.c',
   'spapr-phb-test.c',
   'tmp105-test.c',
-- 
2.47.1


