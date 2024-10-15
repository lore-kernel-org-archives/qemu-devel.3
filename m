Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5093CFC288
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewu-0006lU-FF; Tue, 15 Oct 2024 06:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewa-0006hP-Mo
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewX-0005ye-UR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:24 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so3174398f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988700; x=1729593500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/3GHUipPzvi4A2i69xuufVZyjr3Qe+7m285e1Wp6leM=;
 b=Mmnc3OwECjMnOb7O5r56sCxw9L30+PvPcLE0zO8m2vu2Xeciu4nE69KeeLDGn47Z8t
 AfzcoAFsm7d7B7EuqC934WR/CCxVVdnkpDVta8m/4htQsm4Ugib/XU2b/82LnY6a7zaz
 38mpDZoFSOgULVeRnD47N1pucVAWH09mUUpYt5jJRqRWbOyE2nRKvGs+/XbTYzcJuMmQ
 u4GQXornq28TihsmRwg0qlGzV3teCVnyMuX3sCFlw/4NQZTzAHFH4wCVyOAsaw/Hq7Ku
 ck6w+8Nlu5OtMCixYESbMs3oI2gGlSHoDN718sxZRJGbKvsTq8h5SQfQsSjsG9n/y3Cl
 T72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988700; x=1729593500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3GHUipPzvi4A2i69xuufVZyjr3Qe+7m285e1Wp6leM=;
 b=gjbv4zjxt7tjkPf3X1xR9aPzrbPLD6S6oDsPPrwyGr4M+kyK13bZBHHdyVB7Rsr5rj
 7V4A5NMP6VRoD5DTPBdi83TUDlMQG4hQQUp2JnmrAmDLOIQYMl2i12V/kTr0EeiNZYy2
 EhOFQ/GsxJ9zBa3nCIb7wzHVy5zPd7oAkIggf4Lx8+hXJaZW0xJTPt6cbgTbR2CK+LZH
 FCcuXs1f5aIvrt8RQoru4s3plDFb+aGdV54dWl74fBMK0teaacrKXNKEV/Ein7ocDjBX
 eTOf2wSY1l2Phmc4YdMoh6tL/ZnMrg7RQt3GCyEfdmbzSZysXCyrI9jzPtPfO66u6iRQ
 o4uw==
X-Gm-Message-State: AOJu0Yz6JfoZD4FCSwczFqiG/LSskTexF6Z1n98kRGnourcdqTSUhJ0x
 Q6QUtaMZWqbHJExPUMh+IQ42hhPwYIWU7o4Bey1+zyPjENoDodnGIfZlsIW2MXmFqKTE/mt5R9m
 P
X-Google-Smtp-Source: AGHT+IHQyWflPOiB1gZBzJVyiTU0tPj5GjqcDpuOHQw26wZ3UCYvUE7/2jOfblM62mQbZI/LWN9XVg==
X-Received: by 2002:a5d:5105:0:b0:37c:ffdd:6d5a with SMTP id
 ffacd0b85a97d-37d5519df73mr12249238f8f.6.1728988700394; 
 Tue, 15 Oct 2024 03:38:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/28] hw/gpio: Remove MAX7310 device
Date: Tue, 15 Oct 2024 11:38:02 +0100
Message-Id: <20241015103808.133024-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The MAX7310 GPIO controller was used only by the XScale-based Zaurus
machine types.  Now they have been removed we can remove this device
model as well.

Because this device is an I2C device, in theory it could be created
by users on the command line for boards with a different I2c
controller, but we don't believe users are doing this -- it would be
impossible on the command line to connect up the GPIO inputs/outputs.
The only example a web search produces for "device max7310" is a user
trying to create this because they didn't realize that there was no
way to manipulate the GPIO lines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241003140010.1653808-3-peter.maydell@linaro.org
---
 hw/gpio/max7310.c   | 217 --------------------------------------------
 hw/gpio/Kconfig     |   4 -
 hw/gpio/meson.build |   1 -
 3 files changed, 222 deletions(-)
 delete mode 100644 hw/gpio/max7310.c

diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
deleted file mode 100644
index 43a92b8db97..00000000000
--- a/hw/gpio/max7310.c
+++ /dev/null
@@ -1,217 +0,0 @@
-/*
- * MAX7310 8-port GPIO expansion chip.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This file is licensed under GNU GPL.
- */
-
-#include "qemu/osdep.h"
-#include "hw/i2c/i2c.h"
-#include "hw/irq.h"
-#include "migration/vmstate.h"
-#include "qemu/log.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-#define TYPE_MAX7310 "max7310"
-OBJECT_DECLARE_SIMPLE_TYPE(MAX7310State, MAX7310)
-
-struct MAX7310State {
-    I2CSlave parent_obj;
-
-    int i2c_command_byte;
-    int len;
-
-    uint8_t level;
-    uint8_t direction;
-    uint8_t polarity;
-    uint8_t status;
-    uint8_t command;
-    qemu_irq handler[8];
-    qemu_irq *gpio_in;
-};
-
-static void max7310_reset(DeviceState *dev)
-{
-    MAX7310State *s = MAX7310(dev);
-
-    s->level &= s->direction;
-    s->direction = 0xff;
-    s->polarity = 0xf0;
-    s->status = 0x01;
-    s->command = 0x00;
-}
-
-static uint8_t max7310_rx(I2CSlave *i2c)
-{
-    MAX7310State *s = MAX7310(i2c);
-
-    switch (s->command) {
-    case 0x00:  /* Input port */
-        return s->level ^ s->polarity;
-
-    case 0x01:  /* Output port */
-        return s->level & ~s->direction;
-
-    case 0x02:  /* Polarity inversion */
-        return s->polarity;
-
-    case 0x03:  /* Configuration */
-        return s->direction;
-
-    case 0x04:  /* Timeout */
-        return s->status;
-
-    case 0xff:  /* Reserved */
-        return 0xff;
-
-    default:
-        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
-                      __func__, s->command);
-        break;
-    }
-    return 0xff;
-}
-
-static int max7310_tx(I2CSlave *i2c, uint8_t data)
-{
-    MAX7310State *s = MAX7310(i2c);
-    uint8_t diff;
-    int line;
-
-    if (s->len ++ > 1) {
-#ifdef VERBOSE
-        printf("%s: message too long (%i bytes)\n", __func__, s->len);
-#endif
-        return 1;
-    }
-
-    if (s->i2c_command_byte) {
-        s->command = data;
-        s->i2c_command_byte = 0;
-        return 0;
-    }
-
-    switch (s->command) {
-    case 0x01:  /* Output port */
-        for (diff = (data ^ s->level) & ~s->direction; diff;
-                        diff &= ~(1 << line)) {
-            line = ctz32(diff);
-            if (s->handler[line])
-                qemu_set_irq(s->handler[line], (data >> line) & 1);
-        }
-        s->level = (s->level & s->direction) | (data & ~s->direction);
-        break;
-
-    case 0x02:  /* Polarity inversion */
-        s->polarity = data;
-        break;
-
-    case 0x03:  /* Configuration */
-        s->level &= ~(s->direction ^ data);
-        s->direction = data;
-        break;
-
-    case 0x04:  /* Timeout */
-        s->status = data;
-        break;
-
-    case 0x00:  /* Input port - ignore writes */
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
-                      __func__, s->command);
-        return 1;
-    }
-
-    return 0;
-}
-
-static int max7310_event(I2CSlave *i2c, enum i2c_event event)
-{
-    MAX7310State *s = MAX7310(i2c);
-    s->len = 0;
-
-    switch (event) {
-    case I2C_START_SEND:
-        s->i2c_command_byte = 1;
-        break;
-    case I2C_FINISH:
-#ifdef VERBOSE
-        if (s->len == 1)
-            printf("%s: message too short (%i bytes)\n", __func__, s->len);
-#endif
-        break;
-    default:
-        break;
-    }
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_max7310 = {
-    .name = "max7310",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_INT32(i2c_command_byte, MAX7310State),
-        VMSTATE_INT32(len, MAX7310State),
-        VMSTATE_UINT8(level, MAX7310State),
-        VMSTATE_UINT8(direction, MAX7310State),
-        VMSTATE_UINT8(polarity, MAX7310State),
-        VMSTATE_UINT8(status, MAX7310State),
-        VMSTATE_UINT8(command, MAX7310State),
-        VMSTATE_I2C_SLAVE(parent_obj, MAX7310State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void max7310_gpio_set(void *opaque, int line, int level)
-{
-    MAX7310State *s = (MAX7310State *) opaque;
-    assert(line >= 0 && line < ARRAY_SIZE(s->handler));
-
-    if (level)
-        s->level |= s->direction & (1 << line);
-    else
-        s->level &= ~(s->direction & (1 << line));
-}
-
-/* MAX7310 is SMBus-compatible (can be used with only SMBus protocols),
- * but also accepts sequences that are not SMBus so return an I2C device.  */
-static void max7310_realize(DeviceState *dev, Error **errp)
-{
-    MAX7310State *s = MAX7310(dev);
-
-    qdev_init_gpio_in(dev, max7310_gpio_set, ARRAY_SIZE(s->handler));
-    qdev_init_gpio_out(dev, s->handler, ARRAY_SIZE(s->handler));
-}
-
-static void max7310_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
-
-    dc->realize = max7310_realize;
-    k->event = max7310_event;
-    k->recv = max7310_rx;
-    k->send = max7310_tx;
-    device_class_set_legacy_reset(dc, max7310_reset);
-    dc->vmsd = &vmstate_max7310;
-}
-
-static const TypeInfo max7310_info = {
-    .name          = TYPE_MAX7310,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(MAX7310State),
-    .class_init    = max7310_class_init,
-};
-
-static void max7310_register_types(void)
-{
-    type_register_static(&max7310_info);
-}
-
-type_init(max7310_register_types)
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 843630d4f5f..c423e10f59f 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -1,7 +1,3 @@
-config MAX7310
-    bool
-    depends on I2C
-
 config PL061
     bool
 
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 089b24802ef..74840619c01 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -1,7 +1,6 @@
 system_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
 system_ss.add(when: 'CONFIG_GPIO_MPC8XXX', if_true: files('mpc8xxx.c'))
 system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
-system_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
 system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
-- 
2.34.1


