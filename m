Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92311C07C79
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 14:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryXq8-0001YR-O0; Sun, 21 Apr 2024 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1ryXpq-0001QV-KI; Sun, 21 Apr 2024 10:06:27 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1ryXpn-0008Mo-Tz; Sun, 21 Apr 2024 10:06:26 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id A0F8E2066D;
 Sun, 21 Apr 2024 16:06:19 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id YCijbNb5RytD; Sun, 21 Apr 2024 16:06:14 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 87D632063F;
 Sun, 21 Apr 2024 16:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 87D632063F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713708374;
 bh=hNqybmlSV1pxEVky3sG0QeIZsID6krChaHXMIdDSGpo=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=2Io5omn3rJcMLEMPy8lJO08XU/vR/2F+Czx9x04N4m8C+doxSsH04rLuJCk59PXIi
 64q9eColE9PojfRMBT4n+P15Esomr1xkgKwNfuDjEhQUogh0zU93TM8x7g7Z/iZG+i
 TFhg9RpfbOHyoAEYfoLX3vC6HPvWFJR+eKRVouj0=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id xyU0UFhwVjQW; Sun, 21 Apr 2024 16:06:14 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:204:e56c:d081:2a7:415b:bbbd])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 72B1020616;
 Sun, 21 Apr 2024 16:06:13 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 1/5] hw/display : Add device DM163
Date: Sun, 21 Apr 2024 16:02:44 +0200
Message-ID: <20240421140604.111262-2-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240421140604.111262-1-ines.varhol@telecom-paris.fr>
References: <20240421140604.111262-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

This device implements the IM120417002 colors shield v1.1 for Arduino
(which relies on the DM163 8x3-channel led driving logic) and features
a simple display of an 8x8 RGB matrix. The columns of the matrix are
driven by the DM163 and the rows are driven externally.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 docs/system/arm/b-l475e-iot01a.rst |   3 +-
 include/hw/display/dm163.h         |  59 +++++
 hw/display/dm163.c                 | 334 +++++++++++++++++++++++++++++
 hw/display/Kconfig                 |   3 +
 hw/display/meson.build             |   1 +
 hw/display/trace-events            |  14 ++
 6 files changed, 413 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/display/dm163.h
 create mode 100644 hw/display/dm163.c

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
index 0afef8e4f4..91de5e82fc 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -12,13 +12,14 @@ USART, I2C, SPI, CAN and USB OTG, as well as a variet=
y of sensors.
 Supported devices
 """""""""""""""""
=20
-Currently B-L475E-IOT01A machine's only supports the following devices:
+Currently B-L475E-IOT01A machines support the following devices:
=20
 - Cortex-M4F based STM32L4x5 SoC
 - STM32L4x5 EXTI (Extended interrupts and events controller)
 - STM32L4x5 SYSCFG (System configuration controller)
 - STM32L4x5 RCC (Reset and clock control)
 - STM32L4x5 GPIOs (General-purpose I/Os)
+- optional 8x8 led display (based on DM163 driver)
=20
 Missing devices
 """""""""""""""
diff --git a/include/hw/display/dm163.h b/include/hw/display/dm163.h
new file mode 100644
index 0000000000..4377f77bb7
--- /dev/null
+++ b/include/hw/display/dm163.h
@@ -0,0 +1,59 @@
+/*
+ * QEMU DM163 8x3-channel constant current led driver
+ * driving columns of associated 8x8 RGB matrix.
+ *
+ * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
+ * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (C) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_DISPLAY_DM163_H
+#define HW_DISPLAY_DM163_H
+
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_DM163 "dm163"
+OBJECT_DECLARE_SIMPLE_TYPE(DM163State, DM163);
+
+#define RGB_MATRIX_NUM_ROWS 8
+#define RGB_MATRIX_NUM_COLS 8
+#define DM163_NUM_LEDS (RGB_MATRIX_NUM_COLS * 3)
+/* The last row is filled with 0 (turned off row) */
+#define COLOR_BUFFER_SIZE (RGB_MATRIX_NUM_ROWS + 1)
+
+typedef struct DM163State {
+    DeviceState parent_obj;
+
+    /* DM163 driver */
+    uint64_t bank0_shift_register[3];
+    uint64_t bank1_shift_register[3];
+    uint16_t latched_outputs[DM163_NUM_LEDS];
+    uint16_t outputs[DM163_NUM_LEDS];
+    qemu_irq sout;
+
+    uint8_t sin;
+    uint8_t dck;
+    uint8_t rst_b;
+    uint8_t lat_b;
+    uint8_t selbk;
+    uint8_t en_b;
+
+    /* IM120417002 colors shield */
+    uint8_t activated_rows;
+
+    /* 8x8 RGB matrix */
+    QemuConsole *console;
+    uint8_t redraw;
+    /* Rows currently being displayed on the matrix. */
+    /* The last row is filled with 0 (turned off row) */
+    uint32_t buffer[COLOR_BUFFER_SIZE][RGB_MATRIX_NUM_COLS];
+    uint8_t last_buffer_idx;
+    uint8_t buffer_idx_of_row[RGB_MATRIX_NUM_ROWS];
+    /* Used to simulate retinal persistence of rows */
+    uint8_t row_persistence_delay[RGB_MATRIX_NUM_ROWS];
+} DM163State;
+
+#endif /* HW_DISPLAY_DM163_H */
diff --git a/hw/display/dm163.c b/hw/display/dm163.c
new file mode 100644
index 0000000000..9079e6604e
--- /dev/null
+++ b/hw/display/dm163.c
@@ -0,0 +1,334 @@
+/*
+ * QEMU DM163 8x3-channel constant current led driver
+ * driving columns of associated 8x8 RGB matrix.
+ *
+ * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
+ * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (C) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * The reference used for the DM163 is the following :
+ * http://www.siti.com.tw/product/spec/LED/DM163.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/display/dm163.h"
+#include "ui/console.h"
+#include "trace.h"
+
+#define LED_SQUARE_SIZE 100
+/* Number of frames a row stays visible after being turned off. */
+#define ROW_PERSISTENCE 3
+#define TURNED_OFF_ROW (COLOR_BUFFER_SIZE - 1)
+
+static const VMStateDescription vmstate_dm163 =3D {
+    .name =3D TYPE_DM163,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(bank0_shift_register, DM163State, 3),
+        VMSTATE_UINT64_ARRAY(bank1_shift_register, DM163State, 3),
+        VMSTATE_UINT16_ARRAY(latched_outputs, DM163State, DM163_NUM_LEDS=
),
+        VMSTATE_UINT16_ARRAY(outputs, DM163State, DM163_NUM_LEDS),
+        VMSTATE_UINT8(dck, DM163State),
+        VMSTATE_UINT8(en_b, DM163State),
+        VMSTATE_UINT8(lat_b, DM163State),
+        VMSTATE_UINT8(rst_b, DM163State),
+        VMSTATE_UINT8(selbk, DM163State),
+        VMSTATE_UINT8(sin, DM163State),
+        VMSTATE_UINT8(activated_rows, DM163State),
+        VMSTATE_UINT32_2DARRAY(buffer, DM163State, COLOR_BUFFER_SIZE,
+                               RGB_MATRIX_NUM_COLS),
+        VMSTATE_UINT8(last_buffer_idx, DM163State),
+        VMSTATE_UINT8_ARRAY(buffer_idx_of_row, DM163State, RGB_MATRIX_NU=
M_ROWS),
+        VMSTATE_UINT8_ARRAY(row_persistence_delay, DM163State,
+                            RGB_MATRIX_NUM_ROWS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void dm163_reset_hold(Object *obj)
+{
+    DM163State *s =3D DM163(obj);
+
+    s->sin =3D 0;
+    s->dck =3D 0;
+    s->rst_b =3D 0;
+    /* Ensuring the first falling edge of lat_b isn't missed */
+    s->lat_b =3D 1;
+    s->selbk =3D 0;
+    s->en_b =3D 0;
+    /* Reset stops the PWM, not the shift and latched registers. */
+    memset(s->outputs, 0, sizeof(s->outputs));
+
+    s->activated_rows =3D 0;
+    s->redraw =3D 0;
+    trace_dm163_redraw(s->redraw);
+    for (unsigned i =3D 0; i < COLOR_BUFFER_SIZE; i++) {
+        memset(s->buffer[i], 0, sizeof(s->buffer[0]));
+    }
+    s->last_buffer_idx =3D 0;
+    memset(s->buffer_idx_of_row, TURNED_OFF_ROW, sizeof(s->buffer_idx_of=
_row));
+    memset(s->row_persistence_delay, 0, sizeof(s->row_persistence_delay)=
);
+}
+
+static void dm163_dck_gpio_handler(void *opaque, int line, int new_state=
)
+{
+    DM163State *s =3D opaque;
+
+    if (new_state && !s->dck) {
+        /*
+         * On raising dck, sample selbk to get the bank to use, and
+         * sample sin for the bit to enter into the bank shift buffer.
+         */
+        uint64_t *sb =3D
+            s->selbk ? s->bank1_shift_register : s->bank0_shift_register=
;
+        /* Output the outgoing bit on sout */
+        const bool sout =3D (s->selbk ? sb[2] & MAKE_64BIT_MASK(63, 1) :
+                           sb[2] & MAKE_64BIT_MASK(15, 1)) !=3D 0;
+        qemu_set_irq(s->sout, sout);
+        /* Enter sin into the shift buffer */
+        sb[2] =3D (sb[2] << 1) | ((sb[1] >> 63) & 1);
+        sb[1] =3D (sb[1] << 1) | ((sb[0] >> 63) & 1);
+        sb[0] =3D (sb[0] << 1) | s->sin;
+    }
+
+    s->dck =3D new_state;
+    trace_dm163_dck(new_state);
+}
+
+static void dm163_propagate_outputs(DM163State *s)
+{
+    s->last_buffer_idx =3D (s->last_buffer_idx + 1) % RGB_MATRIX_NUM_ROW=
S;
+    /* Values are output when reset is high and enable is low. */
+    if (s->rst_b && !s->en_b) {
+        memcpy(s->outputs, s->latched_outputs, sizeof(s->outputs));
+    } else {
+        memset(s->outputs, 0, sizeof(s->outputs));
+    }
+    for (unsigned x =3D 0; x < RGB_MATRIX_NUM_COLS; x++) {
+        trace_dm163_channels(3 * x, (uint8_t)(s->outputs[3 * x] >> 6));
+        trace_dm163_channels(3 * x + 1, (uint8_t)(s->outputs[3 * x + 1] =
>> 6));
+        trace_dm163_channels(3 * x + 2, (uint8_t)(s->outputs[3 * x + 2] =
>> 6));
+        s->buffer[s->last_buffer_idx][x] =3D
+            (s->outputs[3 * x + 2] >> 6) |
+            ((s->outputs[3 * x + 1] << 2) & 0xFF00) |
+            (((uint32_t)s->outputs[3 * x] << 10) & 0xFF0000);
+    }
+    for (unsigned row =3D 0; row < RGB_MATRIX_NUM_ROWS; row++) {
+        if (s->activated_rows & (1 << row)) {
+            s->buffer_idx_of_row[row] =3D s->last_buffer_idx;
+            s->redraw |=3D (1 << row);
+            trace_dm163_redraw(s->redraw);
+        }
+    }
+}
+
+static void dm163_en_b_gpio_handler(void *opaque, int line, int new_stat=
e)
+{
+    DM163State *s =3D opaque;
+
+    s->en_b =3D new_state;
+    dm163_propagate_outputs(s);
+    trace_dm163_en_b(new_state);
+}
+
+static uint8_t dm163_bank0(const DM163State *s, uint8_t led)
+{
+    /*
+     * Bank 1 uses 6 bits per led, so a value may be stored accross
+     * two uint64_t entries.
+     */
+    const uint8_t low_bit =3D 6 * led;
+    const uint8_t low_word =3D low_bit / 64;
+    const uint8_t high_word =3D (low_bit + 5) / 64;
+    const uint8_t low_shift =3D low_bit % 64;
+
+    if (low_word =3D=3D high_word) {
+        /* Simple case: the value belongs to one entry. */
+        return (s->bank0_shift_register[low_word] &
+                MAKE_64BIT_MASK(low_shift, 6)) >> low_shift;
+    }
+
+    const uint8_t bits_in_low_word =3D 64 - low_shift;
+    const uint8_t bits_in_high_word =3D 6 - bits_in_low_word;
+    return ((s->bank0_shift_register[low_word] &
+             MAKE_64BIT_MASK(low_shift, bits_in_low_word)) >>
+            low_shift) |
+           ((s->bank0_shift_register[high_word] &
+             MAKE_64BIT_MASK(0, bits_in_high_word))
+         << bits_in_low_word);
+}
+
+static uint8_t dm163_bank1(const DM163State *s, uint8_t led)
+{
+    const uint64_t entry =3D s->bank1_shift_register[led / RGB_MATRIX_NU=
M_COLS];
+    const unsigned shift =3D 8 * (led % RGB_MATRIX_NUM_COLS);
+    return (entry & MAKE_64BIT_MASK(shift, 8)) >> shift;
+}
+
+static void dm163_lat_b_gpio_handler(void *opaque, int line, int new_sta=
te)
+{
+    DM163State *s =3D opaque;
+
+    if (s->lat_b && !new_state) {
+        for (int led =3D 0; led < DM163_NUM_LEDS; led++) {
+            s->latched_outputs[led] =3D dm163_bank0(s, led) * dm163_bank=
1(s, led);
+        }
+        dm163_propagate_outputs(s);
+    }
+
+    s->lat_b =3D new_state;
+    trace_dm163_lat_b(new_state);
+}
+
+static void dm163_rst_b_gpio_handler(void *opaque, int line, int new_sta=
te)
+{
+    DM163State *s =3D opaque;
+
+    s->rst_b =3D new_state;
+    dm163_propagate_outputs(s);
+    trace_dm163_rst_b(new_state);
+}
+
+static void dm163_selbk_gpio_handler(void *opaque, int line, int new_sta=
te)
+{
+    DM163State *s =3D opaque;
+
+    s->selbk =3D new_state;
+    trace_dm163_selbk(new_state);
+}
+
+static void dm163_sin_gpio_handler(void *opaque, int line, int new_state=
)
+{
+    DM163State *s =3D opaque;
+
+    s->sin =3D new_state;
+    trace_dm163_sin(new_state);
+}
+
+static void dm163_rows_gpio_handler(void *opaque, int line, int new_stat=
e)
+{
+    DM163State *s =3D opaque;
+
+    if (new_state) {
+        s->activated_rows |=3D (1 << line);
+        s->buffer_idx_of_row[line] =3D s->last_buffer_idx;
+        s->redraw |=3D (1 << line);
+        trace_dm163_redraw(s->redraw);
+    } else {
+        s->activated_rows &=3D ~(1 << line);
+        s->row_persistence_delay[line] =3D ROW_PERSISTENCE;
+    }
+    trace_dm163_activated_rows(s->activated_rows);
+}
+
+static void dm163_invalidate_display(void *opaque)
+{
+    DM163State *s =3D (DM163State *)opaque;
+    s->redraw =3D 0xFF;
+    trace_dm163_redraw(s->redraw);
+}
+
+static void update_row_persistence_delay(DM163State *s, unsigned row)
+{
+    if (s->row_persistence_delay[row]) {
+        s->row_persistence_delay[row]--;
+    } else {
+        /*
+         * If the ROW_PERSISTENCE delay is up,
+         * the row is turned off.
+         */
+        s->buffer_idx_of_row[row] =3D TURNED_OFF_ROW;
+        s->redraw |=3D (1 << row);
+        trace_dm163_redraw(s->redraw);
+    }
+}
+
+static uint32_t *update_display_of_row(DM163State *s, uint32_t *dest,
+                                       unsigned row)
+{
+    for (unsigned _ =3D 0; _ < LED_SQUARE_SIZE; _++) {
+        for (int x =3D RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE - 1; x >=3D=
 0; x--) {
+            /* UI layer guarantees that there's 32 bits per pixel (Mar 2=
024) */
+            *dest++ =3D s->buffer[s->buffer_idx_of_row[row]][x / LED_SQU=
ARE_SIZE];
+        }
+    }
+
+    dpy_gfx_update(s->console, 0, LED_SQUARE_SIZE * row,
+                    RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE, LED_SQUARE_SI=
ZE);
+    s->redraw &=3D ~(1 << row);
+    trace_dm163_redraw(s->redraw);
+
+    return dest;
+}
+
+static void dm163_update_display(void *opaque)
+{
+    DM163State *s =3D (DM163State *)opaque;
+    DisplaySurface *surface =3D qemu_console_surface(s->console);
+    uint32_t *dest;
+
+    dest =3D surface_data(surface);
+    for (unsigned row =3D 0; row < RGB_MATRIX_NUM_ROWS; row++) {
+        update_row_persistence_delay(s, row);
+        if (!extract8(s->redraw, row, 1)) {
+            dest +=3D LED_SQUARE_SIZE * LED_SQUARE_SIZE * RGB_MATRIX_NUM=
_COLS;
+            continue;
+        }
+        dest =3D update_display_of_row(s, dest, row);
+    }
+}
+
+static const GraphicHwOps dm163_ops =3D {
+    .invalidate  =3D dm163_invalidate_display,
+    .gfx_update  =3D dm163_update_display,
+};
+
+static void dm163_realize(DeviceState *dev, Error **errp)
+{
+    DM163State *s =3D DM163(dev);
+
+    qdev_init_gpio_in(dev, dm163_rows_gpio_handler, RGB_MATRIX_NUM_ROWS)=
;
+    qdev_init_gpio_in(dev, dm163_sin_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_dck_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_rst_b_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_lat_b_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_selbk_gpio_handler, 1);
+    qdev_init_gpio_in(dev, dm163_en_b_gpio_handler, 1);
+    qdev_init_gpio_out_named(dev, &s->sout, "sout", 1);
+
+    s->console =3D graphic_console_init(dev, 0, &dm163_ops, s);
+    qemu_console_resize(s->console, RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZ=
E,
+                        RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);
+}
+
+static void dm163_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->desc =3D "DM163";
+    dc->vmsd =3D &vmstate_dm163;
+    dc->realize =3D dm163_realize;
+    rc->phases.hold =3D dm163_reset_hold;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+}
+
+static const TypeInfo dm163_types[] =3D {
+    {
+        .name =3D TYPE_DM163,
+        .parent =3D TYPE_DEVICE,
+        .instance_size =3D sizeof(DM163State),
+        .class_init =3D dm163_class_init
+    }
+};
+
+DEFINE_TYPES(dm163_types)
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 234c7de027..a4552c8ed7 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -140,3 +140,6 @@ config XLNX_DISPLAYPORT
     bool
     # defaults to "N", enabled by specific boards
     depends on PIXMAN
+
+config DM163
+    bool
diff --git a/hw/display/meson.build b/hw/display/meson.build
index f93a69f70f..71e489308e 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('=
next-fb.c'))
=20
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
+system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
=20
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
     config_all_devices.has_key('CONFIG_VGA_PCI') or
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 2336a0ca15..781f8a3320 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -177,3 +177,17 @@ macfb_ctrl_write(uint64_t addr, uint64_t value, unsi=
gned int size) "addr 0x%"PRI
 macfb_sense_read(uint32_t value) "video sense: 0x%"PRIx32
 macfb_sense_write(uint32_t value) "video sense: 0x%"PRIx32
 macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setti=
ng mode to width %"PRId32 " height %"PRId32 " size %d"
+
+# dm163.c
+dm163_redraw(uint8_t redraw) "0x%02x"
+dm163_dck(unsigned new_state) "dck : %u"
+dm163_en_b(unsigned new_state) "en_b : %u"
+dm163_rst_b(unsigned new_state) "rst_b : %u"
+dm163_lat_b(unsigned new_state) "lat_b : %u"
+dm163_sin(unsigned new_state) "sin : %u"
+dm163_selbk(unsigned new_state) "selbk : %u"
+dm163_activated_rows(int new_state) "Activated rows : 0x%" PRIx32 ""
+dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
+dm163_leds(int led, uint32_t value) "led %d: 0x%x"
+dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
+dm163_refresh_rate(uint32_t rr) "refresh rate %d"
--=20
2.43.2


