Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524A9CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnWN-0005Ek-79; Wed, 17 Jun 2026 06:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUy-0004IN-9N; Wed, 17 Jun 2026 06:28:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUI-00081a-8H; Wed, 17 Jun 2026 06:27:55 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H922Hw3572024; Wed, 17 Jun 2026 03:26:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=Okkay1F5p8TSEulFaCD1+TChz3nSDgRM7pFvmhDvh/U=; b=NqhzBUmeXMfe
 AzUXqRPS/EKpSNV71NmBiHxFPcTBV4Zhp9ifipgut1inOK9rg/eAfDLA3rcQTXRr
 e7GcX9fsd5LOPGdyCvYhOzbw2mMpI/dznIa75K0aV6LXmnqVP1i/Y5Fe0xRBK/oK
 XR9MG36KPd37gDLYZ60mJFYH95jHJy+j9deHt75NY/10RYEviZQn0LTqM5E6kmRR
 RTC8Jrms4TYd0+tAaYJIE9HntbPPUgPW7/2CgcZevdN773UwKPVbWz/+aNd6bPi+
 GWTHYE7sTqeto1uNw+es7ggY/JyfQ3ynYIAMP8zwWS+FdHVflJ4tyBzFQ2cG932w
 C75QOgeFPA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueh0kf50-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 17 Jun 2026 03:26:29 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 17 Jun
 2026 10:26:28 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Wed, 17 Jun 2026 12:26:00 +0200
Subject: [PATCH v2 1/4] hw/sensor: adc128d818: add 12-bit 8-channel ADC device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260617-i2c-adc128d818-anacapa-v2-1-fd38764f0465@meta.com>
References: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
In-Reply-To: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 "Jamin Lin" <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, <qemu-arm@nongnu.org>,
 Emmanuel Blot <eblot@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781691985; l=24657;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=Z6mZxbaE6VSeqtgxTVKNzKEusj+cpnkEMMIludNuwg8=;
 b=l+0eShE7WTQRmJHKZB8bVe5PVvu9vA1ZqvVS+aU5Q59e3RilD+Ayvw3qeC0/tY//ni+6Ls8YY
 0+sd8Z/RqjECSv9nwpWLrYBP4U6P2vNZ7dSmSK2wrLUSVGZN4GO+D9b
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c0a8:1b::30]
X-Proofpoint-GUID: oO0Wl9vkDmpj63aXy3sV9mY4ZQPPyh3i
X-Proofpoint-ORIG-GUID: oO0Wl9vkDmpj63aXy3sV9mY4ZQPPyh3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5OCBTYWx0ZWRfX4U/XqwomhBVg
 BBVh+9k2BYePUk98UMQosZse3yF44IZc5a8MAiGo1wDGaS62gcrXSd/xCuQxCyNe/VGwI2AODjg
 TCmdkelupKNf7164Wp6SnQ+YE1Fp6UkkT3J6WxYM1GDGyrWmHhHTCB+Ki6XwVZkCg85/yv2s5eB
 Yk1XrIoUeey6Siq1tQFk3b5oBSimseqnhF8Gxrb1G9WM1+EeP1qegs0/WfKKhY5HCdtcQO/o5YF
 vSLutavDYhdrBftZvVNnu0y5JyPP4W3yNpKfUt8rsZW/mV5PkaCkqlkXjiisUQ7bbkb2x/7ApUL
 Kv3Z/D6eKf2txGTHdVtp+DivrK2DTEQ0+9JPHRVaYp5gnHBBopx2iuy0SCMlB9JFFgG6Uk+wRfh
 zyAyyflU3vYhv9pboXGPAs4YN+lXXpYv8fgmzqn/iINa3X4j1UCiMHl4DqQptBgyTkyqtvfrTUE
 Owa1F8ID7eHnEKq1rGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5OCBTYWx0ZWRfXxVWxNZn8URdf
 nunf/idiTnB/yRr5rWyJUig8oEOIXBV8407VFNSMUep8rqgYpAwJ8YbcM2hhD1wYmxZdvztz/xz
 wr41q0+6SV9EoX5RySxW//cq27ZgGC4=
X-Authority-Analysis: v=2.4 cv=VcnH+lp9 c=1 sm=1 tr=0 ts=6a327655 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8
 a=7APM2Y97aGwioPLpVesA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=4628a4021f=eblot@meta.com; helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ADC128D818 is a TI 12-bit, 8-channel I2C ADC used on several
OpenBMC platforms for voltage and temperature monitoring.

Implement the device with:
 - four operating modes
 - 12-bit voltage conversion from QOM inputs
 - 9-bit temperature conversion from milli-degree Celsius QOM inputs
 - switchable internal or external voltage reference
 - per-channel high/low limit registers
 - interrupt support
 - software reset
 - one-shot conversion support in shutdown mode

Signed-off-by: Emmanuel Blot <eblot@meta.com>
---
 hw/sensor/Kconfig              |   4 +
 hw/sensor/adc128d818.c         | 695 +++++++++++++++++++++++++++++++++++++++++
 hw/sensor/meson.build          |   1 +
 hw/sensor/trace-events         |   8 +
 include/hw/sensor/adc128d818.h |  12 +
 5 files changed, 720 insertions(+)

diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index bc6331b4ab..b459ac2240 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -1,3 +1,7 @@
+config ADC128D818
+    bool
+    depends on I2C
+
 config TMP105
     bool
     depends on I2C
diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
new file mode 100644
index 0000000000..46c0f5d71a
--- /dev/null
+++ b/hw/sensor/adc128d818.c
@@ -0,0 +1,695 @@
+/*
+ * Texas Instruments ADC128D818 12-bit 8-channel ADC with I2C interface
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qom/object.h"
+#include "hw/sensor/adc128d818.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+
+/* Register addresses */
+#define REG_CONFIG              0x00u
+#define REG_INT_STATUS          0x01u
+#define REG_INT_MASK            0x03u
+#define REG_CONV_RATE           0x07u
+#define REG_CH_DISABLE          0x08u
+#define REG_ONE_SHOT            0x09u
+#define REG_DEEP_SHUTDOWN       0x0Au
+#define REG_ADV_CONFIG          0x0Bu
+#define REG_BUSY_STATUS         0x0Cu
+
+/* Channel Reading Registers (16-bit, read-only) */
+#define REG_CH_READING_BASE     0x20u
+#define REG_CH_READING_LAST     0x27u
+
+/* Limit Registers (8-bit, read/write) */
+#define REG_LIMIT_BASE          0x2Au
+#define REG_LIMIT_LAST          0x39u
+
+/* ID Registers (read-only) */
+#define REG_MANUFACTURER_ID     0x3Eu
+#define REG_REVISION_ID         0x3Fu
+
+/* Configuration Register (0x00) bitfields */
+#define CONFIG_START            BIT(0)
+#define CONFIG_INT_ENABLE       BIT(1)
+#define CONFIG_INT_CLEAR        BIT(3)
+#define CONFIG_INITIALIZATION   BIT(7)
+#define CONFIG_WR_MASK \
+    (CONFIG_START | CONFIG_INT_ENABLE | CONFIG_INT_CLEAR)
+
+/* Advanced Configuration Register (0x0B) bitfields */
+#define ADV_CONFIG_EXT_REF_EN   BIT(0)
+#define ADV_CONFIG_MODE_SHIFT   1u
+#define ADV_CONFIG_MODE_MASK    (0x3u << ADV_CONFIG_MODE_SHIFT)
+#define ADV_CONFIG_WR_MASK \
+    (ADV_CONFIG_EXT_REF_EN | ADV_CONFIG_MODE_MASK)
+
+/* Busy Status Register (0x0C) bitfields */
+#define BUSY_STATUS_NOT_READY   BIT(1)
+
+/* Conversion Rate Register (0x07) bitfields */
+#define CONV_RATE_MASK          0x01u
+
+/* Deep Shutdown Register (0x0A) bitfields */
+#define DEEP_SHUTDOWN_EN        0x01u
+
+/* Device constants */
+#define ADC128D818_NUM_CHANNELS         8u
+#define ADC128D818_NUM_REGS             0x40u
+
+#define ADC128D818_INTERNAL_VREF_MV     2560u
+#define ADC128D818_MAX_VDD_MV           5500u
+#define ADC128D818_MANUFACTURER_ID_VAL  0x01u
+#define ADC128D818_REVISION_ID_VAL      0x09u
+
+/* ADC resolution */
+#define ADC128D818_ADC_RESOLUTION       4096u
+#define ADC128D818_ADC_MAX              4095u
+
+/* Temperature: 0.5 deg C per LSb = 500 milli-degrees per LSb */
+#define ADC128D818_TEMP_LSB_MC          500
+#define ADC128D818_TEMP_RAW_MIN         (-256)
+#define ADC128D818_TEMP_RAW_MAX         255
+
+
+typedef struct ADC128D818State ADC128D818State;
+DECLARE_INSTANCE_CHECKER(ADC128D818State, ADC128D818, TYPE_ADC128D818)
+
+struct ADC128D818State {
+    I2CSlave i2c;
+
+    qemu_irq irq;
+
+    uint8_t len;
+    uint8_t pointer;
+    uint8_t rx_byte;
+
+    uint8_t regs[ADC128D818_NUM_REGS];
+    uint16_t channel[ADC128D818_NUM_CHANNELS];
+
+    int16_t ain[ADC128D818_NUM_CHANNELS]; /* mV */
+    int32_t temperature; /* milli-degrees Celsius */
+    uint16_t ext_vref; /* mV, 0 means not connected */
+    bool temp_alarm; /* temperature high-limit alarm latched */
+
+    char *description;
+};
+
+static uint16_t adc128d818_get_vref(const ADC128D818State *s)
+{
+    if (s->regs[REG_ADV_CONFIG] & ADV_CONFIG_EXT_REF_EN) {
+        if (s->ext_vref > 0u) {
+            return s->ext_vref;
+        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: %s: external VREF selected but not"
+                      " connected, falling back to internal\n",
+                      __func__, s->description);
+    }
+
+    return ADC128D818_INTERNAL_VREF_MV;
+}
+
+static uint8_t adc128d818_get_mode(const ADC128D818State *s)
+{
+    return (s->regs[REG_ADV_CONFIG] & ADV_CONFIG_MODE_MASK) >>
+           ADV_CONFIG_MODE_SHIFT;
+}
+
+static bool adc128d818_is_temp_channel(const ADC128D818State *s, unsigned ch)
+{
+    if (ch != 7u) {
+        return false;
+    }
+
+    return adc128d818_get_mode(s) != 1u;
+}
+
+static bool adc128d818_is_reserved_channel(const ADC128D818State *s,
+                                           unsigned ch)
+{
+    switch (adc128d818_get_mode(s)) {
+    case 2u:
+        return ch >= 4u && ch <= 6u;
+    case 3u:
+        return ch == 6u;
+    default:
+        return false;
+    }
+}
+
+static int16_t adc128d818_channel_voltage(const ADC128D818State *s, unsigned ch)
+{
+    switch (adc128d818_get_mode(s)) {
+    case 2u:
+        switch (ch) {
+        case 0u:
+            return (int16_t)(s->ain[0] - s->ain[1]);
+        case 1u:
+            return (int16_t)(s->ain[3] - s->ain[2]);
+        case 2u:
+            return (int16_t)(s->ain[4] - s->ain[5]);
+        case 3u:
+            return (int16_t)(s->ain[7] - s->ain[6]);
+        default:
+            return 0;
+        }
+    case 3u:
+        switch (ch) {
+        case 4u:
+            return (int16_t)(s->ain[4] - s->ain[5]);
+        case 5u:
+            return (int16_t)(s->ain[7] - s->ain[6]);
+        default:
+            return s->ain[ch];
+        }
+    default:
+        return s->ain[ch];
+    }
+}
+
+static void adc128d818_update_irq(ADC128D818State *s)
+{
+    uint8_t cfg = s->regs[REG_CONFIG];
+    uint8_t active;
+    bool level;
+
+    active = s->regs[REG_INT_STATUS] & ~s->regs[REG_INT_MASK];
+
+    /* INT pin is active-low */
+    level = !((cfg & CONFIG_INT_ENABLE) && !(cfg & CONFIG_INT_CLEAR) &&
+              (active != 0u));
+
+    trace_adc128d818_irq(s->description, level);
+    qemu_set_irq(s->irq, level);
+}
+
+static bool adc128d818_monitoring_active(const ADC128D818State *s)
+{
+    if (s->regs[REG_DEEP_SHUTDOWN] & DEEP_SHUTDOWN_EN) {
+        return false;
+    }
+    if (!(s->regs[REG_CONFIG] & CONFIG_START)) {
+        return false;
+    }
+    if (s->regs[REG_CONFIG] & CONFIG_INT_CLEAR) {
+        return false;
+    }
+
+    return true;
+}
+
+static void adc128d818_check_limits(ADC128D818State *s)
+{
+    uint8_t disabled = s->regs[REG_CH_DISABLE];
+    uint8_t int_status = 0u;
+
+    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
+        if ((disabled & (1u << ch)) ||
+            adc128d818_is_reserved_channel(s, ch)) {
+            continue;
+        }
+
+        if (adc128d818_is_temp_channel(s, ch)) {
+            int raw = s->temperature / ADC128D818_TEMP_LSB_MC;
+            int thot;
+            int thyst;
+
+            raw = MAX(ADC128D818_TEMP_RAW_MIN,
+                      MIN(ADC128D818_TEMP_RAW_MAX, raw));
+            thot = (int)(int8_t)s->regs[REG_LIMIT_BASE + ch * 2u] * 2;
+            thyst = (int)(int8_t)s->regs[REG_LIMIT_BASE + ch * 2u + 1u] * 2;
+
+            if (raw > thot) {
+                s->temp_alarm = true;
+            } else if (raw <= thyst) {
+                s->temp_alarm = false;
+            }
+            if (s->temp_alarm) {
+                int_status |= (1u << ch);
+            }
+        } else {
+            uint8_t msb = (uint8_t)(s->channel[ch] >> 8u);
+            uint8_t high_lim = s->regs[REG_LIMIT_BASE + ch * 2u];
+            uint8_t low_lim = s->regs[REG_LIMIT_BASE + ch * 2u + 1u];
+
+            if (msb > high_lim || msb <= low_lim) {
+                int_status |= (1u << ch);
+            }
+        }
+    }
+
+    s->regs[REG_INT_STATUS] = int_status;
+    adc128d818_update_irq(s);
+}
+
+static void adc128d818_convert(ADC128D818State *s)
+{
+    uint8_t disabled;
+    uint16_t vref;
+
+    disabled = s->regs[REG_CH_DISABLE];
+    vref = adc128d818_get_vref(s);
+
+    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
+        if ((disabled & (1u << ch)) ||
+            adc128d818_is_reserved_channel(s, ch)) {
+            continue;
+        }
+
+        if (adc128d818_is_temp_channel(s, ch)) {
+            int32_t raw = s->temperature / ADC128D818_TEMP_LSB_MC;
+
+            raw =
+                MAX(ADC128D818_TEMP_RAW_MIN, MIN(ADC128D818_TEMP_RAW_MAX, raw));
+            s->channel[ch] = (uint16_t)(((unsigned)raw & 0x1FFu) << 7u);
+        } else {
+            int16_t vin = adc128d818_channel_voltage(s, ch);
+            int32_t dout;
+
+            dout = vin * (int32_t)ADC128D818_ADC_RESOLUTION / vref;
+            dout = MAX(0, MIN((int32_t)ADC128D818_ADC_MAX, dout));
+            s->channel[ch] = (uint16_t)(dout << 4u);
+        }
+
+        trace_adc128d818_convert(s->description, ch, s->channel[ch]);
+    }
+
+    s->regs[REG_BUSY_STATUS] &= ~BUSY_STATUS_NOT_READY;
+
+    adc128d818_check_limits(s);
+}
+
+static uint8_t adc128d818_read_channel(ADC128D818State *s, unsigned ch)
+{
+    uint8_t val;
+
+    if (s->rx_byte == 0u) {
+        val = (uint8_t)(s->channel[ch] >> 8u);
+        trace_adc128d818_read_channel(s->description, ch, s->channel[ch]);
+    } else {
+        val = (uint8_t)(s->channel[ch] & 0xFFu);
+    }
+    s->rx_byte ^= 1u;
+
+    return val;
+}
+
+static uint8_t adc128d818_read_reg(ADC128D818State *s, uint8_t reg)
+{
+    uint8_t val;
+
+    switch (reg) {
+    case REG_INT_STATUS:
+        val = s->regs[REG_INT_STATUS];
+        s->regs[REG_INT_STATUS] = 0x00u;
+        if (adc128d818_monitoring_active(s)) {
+            adc128d818_check_limits(s);
+        } else {
+            adc128d818_update_irq(s);
+        }
+        trace_adc128d818_read(s->description, reg, val);
+        return val;
+    case REG_CONFIG:
+    case REG_INT_MASK:
+    case REG_CONV_RATE:
+    case REG_CH_DISABLE:
+    case REG_ONE_SHOT:
+    case REG_DEEP_SHUTDOWN:
+    case REG_ADV_CONFIG:
+    case REG_BUSY_STATUS:
+    case REG_LIMIT_BASE ... REG_LIMIT_LAST:
+    case REG_MANUFACTURER_ID:
+    case REG_REVISION_ID:
+        trace_adc128d818_read(s->description, reg, s->regs[reg]);
+        return s->regs[reg];
+    case REG_CH_READING_BASE ... REG_CH_READING_LAST:
+        return adc128d818_read_channel(s, reg - REG_CH_READING_BASE);
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: %s: read from undefined register 0x%02x\n",
+                      __func__, s->description, reg);
+        return 0x00u;
+    }
+}
+
+static void adc128d818_write_reg(ADC128D818State *s, uint8_t reg, uint8_t val);
+
+static void adc128d818_reset_regs(ADC128D818State *s)
+{
+    memset(s->regs, 0, sizeof(s->regs));
+    memset(s->channel, 0, sizeof(s->channel));
+    s->temp_alarm = false;
+
+    s->regs[REG_CONFIG] = 0x08u;
+    s->regs[REG_BUSY_STATUS] = 0x02u;
+    s->regs[REG_MANUFACTURER_ID] = ADC128D818_MANUFACTURER_ID_VAL;
+    s->regs[REG_REVISION_ID] = ADC128D818_REVISION_ID_VAL;
+
+    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
+        s->regs[REG_LIMIT_BASE + ch * 2u] = 0xFFu;
+    }
+
+    s->pointer = 0x00u;
+    s->len = 0u;
+    s->rx_byte = 0u;
+
+    adc128d818_update_irq(s);
+}
+
+static void adc128d818_write_reg(ADC128D818State *s, uint8_t reg, uint8_t val)
+{
+    trace_adc128d818_write(s->description, reg, val);
+
+    switch (reg) {
+    case REG_CONFIG:
+        if (val & CONFIG_INITIALIZATION) {
+            trace_adc128d818_reset(s->description, "reg");
+            adc128d818_reset_regs(s);
+            break;
+        }
+        s->regs[REG_CONFIG] = val & CONFIG_WR_MASK;
+        if ((val & CONFIG_START) && !(val & CONFIG_INT_CLEAR) &&
+            !(s->regs[REG_DEEP_SHUTDOWN] & DEEP_SHUTDOWN_EN)) {
+            adc128d818_convert(s);
+        }
+        adc128d818_update_irq(s);
+        break;
+    case REG_INT_MASK:
+        s->regs[REG_INT_MASK] = val;
+        adc128d818_update_irq(s);
+        break;
+    case REG_CONV_RATE:
+        if (s->regs[REG_CONFIG] & CONFIG_START) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: %s: CONV_RATE written while running\n",
+                          __func__, s->description);
+            break;
+        }
+        s->regs[REG_CONV_RATE] = val & CONV_RATE_MASK;
+        break;
+    case REG_CH_DISABLE:
+        if (s->regs[REG_CONFIG] & CONFIG_START) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: %s: CH_DISABLE written while running\n",
+                          __func__, s->description);
+            break;
+        }
+        s->regs[REG_CH_DISABLE] = val;
+        memset(s->channel, 0, sizeof(s->channel));
+        s->regs[REG_INT_STATUS] = 0x00u;
+        s->temp_alarm = false;
+        adc128d818_update_irq(s);
+        break;
+    case REG_ONE_SHOT:
+        if (!(s->regs[REG_CONFIG] & CONFIG_START)) {
+            adc128d818_convert(s);
+        }
+        break;
+    case REG_DEEP_SHUTDOWN:
+        if ((val & DEEP_SHUTDOWN_EN) && (s->regs[REG_CONFIG] & CONFIG_START)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: %s: DEEP_SHUTDOWN set while running\n",
+                          __func__, s->description);
+            break;
+        }
+        s->regs[REG_DEEP_SHUTDOWN] = val & DEEP_SHUTDOWN_EN;
+        break;
+    case REG_ADV_CONFIG:
+        if (s->regs[REG_CONFIG] & CONFIG_START) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: %s: ADV_CONFIG written while running\n",
+                          __func__, s->description);
+            break;
+        }
+        s->regs[REG_ADV_CONFIG] = val & ADV_CONFIG_WR_MASK;
+        memset(s->channel, 0, sizeof(s->channel));
+        s->regs[REG_INT_STATUS] = 0x00u;
+        s->temp_alarm = false;
+        adc128d818_update_irq(s);
+        break;
+    case REG_LIMIT_BASE ... REG_LIMIT_LAST:
+        s->regs[reg] = val;
+        break;
+    case REG_INT_STATUS:
+    case REG_BUSY_STATUS:
+    case REG_MANUFACTURER_ID:
+    case REG_REVISION_ID:
+    case REG_CH_READING_BASE ... REG_CH_READING_LAST:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: %s: write to read-only register 0x%02x\n",
+                      __func__, s->description, reg);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: %s: write to undefined register 0x%02x\n",
+                      __func__, s->description, reg);
+        break;
+    }
+}
+
+static uint8_t adc128d818_recv(I2CSlave *i2c)
+{
+    ADC128D818State *s = ADC128D818(i2c);
+
+    return adc128d818_read_reg(s, s->pointer);
+}
+
+static int adc128d818_send(I2CSlave *i2c, uint8_t data)
+{
+    ADC128D818State *s = ADC128D818(i2c);
+
+    if (s->len == 0u) {
+        s->pointer = data;
+        s->len++;
+    } else {
+        adc128d818_write_reg(s, s->pointer, data);
+    }
+
+    return 0;
+}
+
+static int adc128d818_event(I2CSlave *i2c, enum i2c_event event)
+{
+    ADC128D818State *s = ADC128D818(i2c);
+
+    s->len = 0u;
+    s->rx_byte = 0u;
+
+    return 0;
+}
+
+static void adc128d818_get_ain(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(obj);
+    int64_t value;
+    int ch_num;
+    int rc;
+
+    rc = sscanf(name, "ain%d", &ch_num);
+    if (rc != 1 || ch_num < 0 || ch_num >= (int)ADC128D818_NUM_CHANNELS) {
+        error_setg(errp, "%s: %s: invalid channel '%s'", __func__,
+                   s->description, name);
+        return;
+    }
+
+    value = s->ain[ch_num];
+    visit_type_int(v, name, &value, errp);
+}
+
+static void adc128d818_set_ain(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(obj);
+    int64_t value;
+    int ch_num;
+    int rc;
+
+    if (!visit_type_int(v, name, &value, errp)) {
+        return;
+    }
+
+    rc = sscanf(name, "ain%d", &ch_num);
+    if (rc != 1 || ch_num < 0 || ch_num >= (int)ADC128D818_NUM_CHANNELS) {
+        error_setg(errp, "%s: %s: invalid channel '%s'", __func__,
+                   s->description, name);
+        return;
+    }
+
+    if (value < INT16_MIN || value > INT16_MAX) {
+        error_setg(errp, "%s: %s: value %" PRId64 " out of range for '%s'",
+                   __func__, s->description, value, name);
+        return;
+    }
+
+    s->ain[ch_num] = (int16_t)value;
+
+    if (adc128d818_monitoring_active(s)) {
+        adc128d818_convert(s);
+    }
+}
+
+static void adc128d818_get_temperature(
+    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(obj);
+    int64_t value = s->temperature;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void adc128d818_set_temperature(
+    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(obj);
+    int64_t value;
+
+    if (!visit_type_int(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value < INT32_MIN || value > INT32_MAX) {
+        error_setg(errp, "%s: %s: value %" PRId64 " out of range", __func__,
+                   s->description, value);
+        return;
+    }
+
+    s->temperature = (int32_t)value;
+
+    if (adc128d818_monitoring_active(s)) {
+        adc128d818_convert(s);
+    }
+}
+
+static const VMStateDescription adc128d818_vmstate = {
+    .name = "ADC128D818",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(len, ADC128D818State),
+        VMSTATE_UINT8(pointer, ADC128D818State),
+        VMSTATE_UINT8(rx_byte, ADC128D818State),
+        VMSTATE_UINT8_ARRAY(regs, ADC128D818State,
+                            ADC128D818_NUM_REGS),
+        VMSTATE_UINT16_ARRAY(channel, ADC128D818State,
+                             ADC128D818_NUM_CHANNELS),
+        VMSTATE_INT16_ARRAY(ain, ADC128D818State,
+                            ADC128D818_NUM_CHANNELS),
+        VMSTATE_INT32(temperature, ADC128D818State),
+        VMSTATE_UINT16(ext_vref, ADC128D818State),
+        VMSTATE_BOOL(temp_alarm, ADC128D818State),
+        VMSTATE_I2C_SLAVE(i2c, ADC128D818State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void adc128d818_reset_hold(Object *obj, ResetType type)
+{
+    ADC128D818State *s = ADC128D818(obj);
+
+    trace_adc128d818_reset(s->description, "hw");
+    adc128d818_reset_regs(s);
+}
+
+static void adc128d818_get_ext_vref(
+    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(obj);
+    int64_t value = (int64_t)s->ext_vref;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void adc128d818_set_ext_vref(
+    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(obj);
+    int64_t value;
+
+    if (!visit_type_int(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value < 0 || value > ADC128D818_MAX_VDD_MV) {
+        error_setg(errp,
+                   "%s: %s: ext-vref-mv %" PRId64 " out of range (0..%u mV)",
+                   __func__, s->description, value, ADC128D818_MAX_VDD_MV);
+        return;
+    }
+
+    s->ext_vref = (uint16_t)value;
+
+    if (adc128d818_monitoring_active(s)) {
+        adc128d818_convert(s);
+    }
+}
+
+static void adc128d818_initfn(Object *obj)
+{
+    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
+        char *name = g_strdup_printf("ain%u", ch);
+
+        object_property_add(obj, name, "int", adc128d818_get_ain,
+                            adc128d818_set_ain, NULL, NULL);
+        g_free(name);
+    }
+
+    object_property_add(obj, "temperature", "int", adc128d818_get_temperature,
+                        adc128d818_set_temperature, NULL, NULL);
+    object_property_add(obj, "ext-vref-mv", "int", adc128d818_get_ext_vref,
+                        adc128d818_set_ext_vref, NULL, NULL);
+}
+
+static void adc128d818_realize(DeviceState *dev, Error **errp)
+{
+    ADC128D818State *s = ADC128D818(dev);
+
+    if (!s->description) {
+        s->description = g_strdup(object_get_typename(OBJECT(dev)));
+    }
+
+    qdev_init_gpio_out(dev, &s->irq, 1u);
+}
+
+static const Property adc128d818_properties[] = {
+    DEFINE_PROP_STRING("description", ADC128D818State, description),
+};
+
+static void adc128d818_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *ic = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    ic->event = adc128d818_event;
+    ic->recv = adc128d818_recv;
+    ic->send = adc128d818_send;
+    dc->realize = adc128d818_realize;
+    rc->phases.hold = adc128d818_reset_hold;
+    dc->vmsd = &adc128d818_vmstate;
+    device_class_set_props(dc, adc128d818_properties);
+}
+
+static const TypeInfo adc128d818_types[] = {
+    {
+        .name          = TYPE_ADC128D818,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_init = adc128d818_initfn,
+        .instance_size = sizeof(ADC128D818State),
+        .class_init    = adc128d818_class_init,
+    },
+};
+
+DEFINE_TYPES(adc128d818_types)
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 420fdc3359..fe36c9ef91 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -1,3 +1,4 @@
+system_ss.add(when: 'CONFIG_ADC128D818', if_true: files('adc128d818.c'))
 system_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
 system_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
 system_ss.add(when: 'CONFIG_DPS310', if_true: files('dps310.c'))
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
index a3fe54fa6d..5a3630f7bb 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -1,5 +1,13 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# adc128d818.c
+adc128d818_read(const char *id, uint8_t reg, uint8_t value) "%s reg 0x%02x val 0x%02x"
+adc128d818_read_channel(const char *id, uint8_t channel, uint16_t value) "%s ch %u val 0x%04x"
+adc128d818_write(const char *id, uint8_t reg, uint8_t value) "%s reg 0x%02x val 0x%02x"
+adc128d818_convert(const char *id, uint8_t channel, uint16_t value) "%s ch %u val 0x%04x"
+adc128d818_irq(const char *id, bool level) "%s level %u"
+adc128d818_reset(const char *id, const char *source) "%s %s"
+
 # tmp105.c
 tmp105_read(uint8_t dev, uint8_t addr) "device: 0x%02x, addr: 0x%02x"
 tmp105_write(uint8_t dev, uint8_t addr) "device: 0x%02x, addr 0x%02x"
diff --git a/include/hw/sensor/adc128d818.h b/include/hw/sensor/adc128d818.h
new file mode 100644
index 0000000000..ce7e94d2b4
--- /dev/null
+++ b/include/hw/sensor/adc128d818.h
@@ -0,0 +1,12 @@
+/*
+ * Texas Instruments ADC128D818 12-bit 8-channel ADC with I2C interface
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SENSOR_ADC128D818_H
+#define HW_SENSOR_ADC128D818_H
+
+#define TYPE_ADC128D818 "adc128d818"
+
+#endif

-- 
2.50.1


