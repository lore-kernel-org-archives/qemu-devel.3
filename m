Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E30EC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeN-0004W2-A3; Wed, 28 Feb 2024 07:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rfIe6-0004Ds-2N; Wed, 28 Feb 2024 07:02:46 -0500
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rfIdp-000306-JK; Wed, 28 Feb 2024 07:02:44 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id DE64DA0645;
 Wed, 28 Feb 2024 13:02:25 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id kBEtAx4F5tH0; Wed, 28 Feb 2024 13:02:23 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 3C170A064A;
 Wed, 28 Feb 2024 13:02:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 3C170A064A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709121743;
 bh=ONIvnu0A4Xb5p0Ydmv9/f59ibakza/ktRAZhMS6rlaY=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=eoouL5Ry7/d5gqRmRQrR7QPbw4ff1UJKMXC0ix66l4w3DE4+zSF4oHhwVFEBULDPK
 oy96dSK02fRQudU0M99kIowrkU3IJgmgKW247t4qj5vqzuDmEAeXN/r1+nlATSOWpt
 sKV9o5ttleBh4jcIZyS+e5T7jVWV5kQrIAlNT/34=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 32oJI0aHpqbB; Wed, 28 Feb 2024 13:02:23 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id C4C35A05BB;
 Wed, 28 Feb 2024 13:02:22 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 1/5] hw/display : Add device DM163
Date: Wed, 28 Feb 2024 13:01:04 +0100
Message-ID: <20240228120215.277717-2-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228120215.277717-1-ines.varhol@telecom-paris.fr>
References: <20240228120215.277717-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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
 include/hw/display/dm163.h         |  57 ++++++
 hw/display/dm163.c                 | 308 +++++++++++++++++++++++++++++
 hw/display/Kconfig                 |   3 +
 hw/display/meson.build             |   1 +
 hw/display/trace-events            |  13 ++
 6 files changed, 384 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/display/dm163.h
 create mode 100644 hw/display/dm163.c

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
index 0afef8e4f4..60b9611167 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -12,13 +12,14 @@ USART, I2C, SPI, CAN and USB OTG, as well as a variet=
y of sensors.
 Supported devices
 """""""""""""""""
=20
-Currently B-L475E-IOT01A machine's only supports the following devices:
+Currently B-L475E-IOT01A machine's supports the following devices:
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
index 0000000000..aa775e51e1
--- /dev/null
+++ b/include/hw/display/dm163.h
@@ -0,0 +1,57 @@
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
+#define DM163_NUM_LEDS 24
+#define RGB_MATRIX_NUM_ROWS 8
+#define RGB_MATRIX_NUM_COLS (DM163_NUM_LEDS / 3)
+#define COLOR_BUFFER_SIZE RGB_MATRIX_NUM_ROWS
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
+    uint8_t dck;
+    uint8_t en_b;
+    uint8_t lat_b;
+    uint8_t rst_b;
+    uint8_t selbk;
+    uint8_t sin;
+
+    /* IM120417002 colors shield */
+    uint8_t activated_rows;
+
+    /* 8x8 RGB matrix */
+    QemuConsole *console;
+    /* Rows currently being displayed on the matrix. */
+    /* The last row is filled with 0 (turned off row) */
+    uint32_t buffer[COLOR_BUFFER_SIZE + 1][RGB_MATRIX_NUM_COLS];
+    uint8_t last_buffer_idx;
+    uint8_t buffer_idx_of_row[RGB_MATRIX_NUM_ROWS];
+    /* Used to simulate retinal persistance of rows */
+    uint8_t age_of_row[RGB_MATRIX_NUM_ROWS];
+} DM163State;
+
+#endif /* HW_DISPLAY_DM163_H */
diff --git a/hw/display/dm163.c b/hw/display/dm163.c
new file mode 100644
index 0000000000..87e886356a
--- /dev/null
+++ b/hw/display/dm163.c
@@ -0,0 +1,308 @@
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
+#define ROW_PERSISTANCE 4
+
+static const VMStateDescription vmstate_dm163 =3D {
+    .name =3D TYPE_DM163,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT8(activated_rows, DM163State),
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
+        VMSTATE_UINT32_2DARRAY(buffer, DM163State,
+            COLOR_BUFFER_SIZE + 1, RGB_MATRIX_NUM_COLS),
+        VMSTATE_UINT8(last_buffer_idx, DM163State),
+        VMSTATE_UINT8_ARRAY(buffer_idx_of_row, DM163State, RGB_MATRIX_NU=
M_ROWS),
+        VMSTATE_UINT8_ARRAY(age_of_row, DM163State, RGB_MATRIX_NUM_ROWS)=
,
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void dm163_reset_hold(Object *obj)
+{
+    DM163State *s =3D DM163(obj);
+
+    /* Reset only stops the PWM. */
+    memset(s->outputs, 0, sizeof(s->outputs));
+
+    /* The last row of the buffer stores a turned off row */
+    memset(s->buffer[COLOR_BUFFER_SIZE], 0, sizeof(s->buffer[0]));
+}
+
+static void dm163_dck_gpio_handler(void *opaque, int line, int new_state=
)
+{
+    DM163State *s =3D DM163(opaque);
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
+    s->last_buffer_idx =3D (s->last_buffer_idx + 1) % COLOR_BUFFER_SIZE;
+    /* Values are output when reset and enable are both high. */
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
+        }
+    }
+}
+
+static void dm163_en_b_gpio_handler(void *opaque, int line, int new_stat=
e)
+{
+    DM163State *s =3D DM163(opaque);
+
+    s->en_b =3D new_state;
+    dm163_propagate_outputs(s);
+    trace_dm163_en_b(new_state);
+}
+
+static inline uint8_t dm163_bank0(const DM163State *s, uint8_t led)
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
+static inline uint8_t dm163_bank1(const DM163State *s, uint8_t led)
+{
+    const uint64_t entry =3D s->bank1_shift_register[led / 8];
+    const unsigned shift =3D 8 * (led % 8);
+    return (entry & MAKE_64BIT_MASK(shift, 8)) >> shift;
+}
+
+static void dm163_lat_b_gpio_handler(void *opaque, int line, int new_sta=
te)
+{
+    DM163State *s =3D DM163(opaque);
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
+    DM163State *s =3D DM163(opaque);
+
+    s->rst_b =3D new_state;
+    dm163_propagate_outputs(s);
+    trace_dm163_rst_b(new_state);
+}
+
+static void dm163_selbk_gpio_handler(void *opaque, int line, int new_sta=
te)
+{
+    DM163State *s =3D DM163(opaque);
+
+    s->selbk =3D new_state;
+    trace_dm163_selbk(new_state);
+}
+
+static void dm163_sin_gpio_handler(void *opaque, int line, int new_state=
)
+{
+    DM163State *s =3D DM163(opaque);
+
+    s->sin =3D new_state;
+    trace_dm163_sin(new_state);
+}
+
+static void dm163_rows_gpio_handler(void *opaque, int line, int new_stat=
e)
+{
+    DM163State *s =3D DM163(opaque);
+
+    if (new_state) {
+        s->activated_rows |=3D (1 << line);
+        s->buffer_idx_of_row[line] =3D s->last_buffer_idx;
+        s->age_of_row[line] =3D 0;
+    } else {
+        s->activated_rows &=3D ~(1 << line);
+        s->age_of_row[line] =3D ROW_PERSISTANCE;
+    }
+    trace_dm163_activated_rows(s->activated_rows);
+}
+
+static void dm163_invalidate_display(void *opaque)
+{
+}
+
+static void dm163_update_display(void *opaque)
+{
+    DM163State *s =3D (DM163State *)opaque;
+    DisplaySurface *surface =3D qemu_console_surface(s->console);
+    uint32_t *dest;
+    unsigned bits_ppi =3D surface_bits_per_pixel(surface);
+
+    /* Should the code be updated to handle other bpp than 32 ? */
+    /* trace_dm163_bits_ppi(bits_ppi); */
+    g_assert((bits_ppi =3D=3D 32));
+    dest =3D surface_data(surface);
+    for (unsigned y =3D 0; y < RGB_MATRIX_NUM_ROWS; y++) {
+        for (unsigned _ =3D 0; _ < LED_SQUARE_SIZE; _++) {
+            for (int x =3D RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE - 1; x =
>=3D 0; x--) {
+                *dest++ =3D s->buffer[s->buffer_idx_of_row[y]][x / LED_S=
QUARE_SIZE];
+            }
+        }
+        if (s->age_of_row[y]) {
+            s->age_of_row[y]--;
+            if (!s->age_of_row[y]) {
+                /*
+                 * If the ROW_PERSISTANCE delay is up,
+                 * the row is turned off.
+                 * (s->buffer[COLOR_BUFFER] is filled with 0)
+                 */
+                s->buffer_idx_of_row[y] =3D COLOR_BUFFER_SIZE;
+            }
+        }
+    }
+    /*
+     * Ideally set the refresh rate so that the row persistance
+     * doesn't need to be changed.
+     *
+     * Currently `dpy_ui_info_supported(s->console)` returns false
+     * which makes it impossible to get or set UIInfo.
+     */
+    if (dpy_ui_info_supported(s->console)) {
+        trace_dm163_refresh_rate(dpy_get_ui_info(s->console)->refresh_ra=
te);
+    } else {
+        trace_dm163_refresh_rate(0);
+    }
+   =20
+    dpy_gfx_update(s->console, 0, 0, RGB_MATRIX_NUM_COLS * LED_SQUARE_SI=
ZE,
+                   RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);
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
+    qdev_init_gpio_in(dev, dm163_rows_gpio_handler, 8);
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
index 1aafe1923d..4dbfc6e7af 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -139,3 +139,6 @@ config XLNX_DISPLAYPORT
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
index 2336a0ca15..444b014d6e 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -177,3 +177,16 @@ macfb_ctrl_write(uint64_t addr, uint64_t value, unsi=
gned int size) "addr 0x%"PRI
 macfb_sense_read(uint32_t value) "video sense: 0x%"PRIx32
 macfb_sense_write(uint32_t value) "video sense: 0x%"PRIx32
 macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setti=
ng mode to width %"PRId32 " height %"PRId32 " size %d"
+
+# dm163.c
+dm163_dck(int new_state) "dck : %d"
+dm163_en_b(int new_state) "en_b : %d"
+dm163_rst_b(int new_state) "rst_b : %d"
+dm163_lat_b(int new_state) "lat_b : %d"
+dm163_sin(int new_state) "sin : %d"
+dm163_selbk(int new_state) "selbk : %d"
+dm163_activated_rows(int new_state) "Activated rows : 0x%" PRIx32 ""
+dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
+dm163_leds(int led, uint32_t value) "led %d: 0x%x"
+dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
+dm163_refresh_rate(uint32_t rr) "refresh rate %d"
--=20
2.43.2


