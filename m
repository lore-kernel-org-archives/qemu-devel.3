Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABCFC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ON4-0000zl-Oj; Tue, 01 Sep 2026 09:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON1-0000wz-Nn
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:47 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMy-00078G-Db
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:47 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c2533d83e3bso771718866b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268663; x=1788873463; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HhC5z+Rc0v8EepQ+8i0JjAyQTcJlTKlWPfhzeE2BgnA=;
 b=r4wwfNli2PDvZG7VffQGfu5XCHKRxLAan9g0HOchjnvzVwmtzBXo3kX1QVp2hq27UF
 a53RrJw0u10UrfIBA7KE1kIImeWnIoMZa/0Ur+nYEDpo4eKo4SeJp7fGnI1TJhA7QGYR
 ZDlGkZ+p7vlknryxh4uQh4kwu4LmghjJCrQYgwyyZVVempLLwFmKiKNEtl05qALlqlff
 u7GcisqpCn9TjXLx0Eb3jST/xScjkYo9SrKWCPetK98K9cu6zk+h8L2SmKs8RmuK5NAs
 PH4Ej0BCMOGuDM9mjV1zz6CdllyvRA0worV9S0K19zn7zSMA1al9MFAm7otnBSydSpd+
 jbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268663; x=1788873463;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HhC5z+Rc0v8EepQ+8i0JjAyQTcJlTKlWPfhzeE2BgnA=;
 b=SmbB+7ihfmKq7xIfFwpLnYLZOB5QqNV6CLGzYC9nVfOHazRkrF2pXYU4Xqfb0nPHcx
 xK/GkZFPZbZKW2K1MVQ5tiE4jSVycXCVweskrMNQfaFpjdkfoTSnuHOD4d2nVitrDAA1
 HaBojdAGiTVv3Dl9vLACU2eVbxFy/ObDBGz2TO31ppqvvIx6L49L3xeYtFeZPD9tkN9q
 ME1+Wx3F9UmabUl9HxMGRXqJAy+Vq+jBmLjL4mZVmrP8v/VNthbLQzWTyAw5HqC/l+ab
 yl1tYZ2B84CQt3vDkf08eLEOXVFV6m644ZMK0N/hHfHkH+xUP7o53xMtghC60wIGS23i
 UvMw==
X-Gm-Message-State: AFuF++nGKK1IAfRp2x3u6PNq6eJ4DJmB7pWgRLr3k3k+e8ZZDx0+zlrq
 OseZtbwq0JxmwkL3k/7nEwA5EZR2izoZuskFN1WgxTg1AQRADUyBiweIg2g2E/sLGkGJ3A6nDol
 rx2ylaEM=
X-Gm-Gg: AR+sD10H+sb1RBlEz0qRysuknW1P0Is5BYHVEDr9wcIJ7FcYNIgfxyWd8hpUwE6RICb
 aLdjLEpN7XRYcma4EromLNJzLqIx7WpPQdEZEMLQbQBu3ygs/P/I7hsMkmCfiDlsLKiY9wrD0zT
 Sqb+FcyTrCJHtIEzH2qLwqI4kBrQwl9WAND9rIIP0vydiV/eHFnOWazPUJ+iN5OulKs3WQ3e7X3
 ccoMM6ZRD+6zHGs4uDdeyZG9qvtqVX3d1mvdbzTDrEzhgwCNtH7Jwd8lTE/niO/jg9YIShdqPvh
 2IrQpoTH3Ao4cNu/q8BGGan3V6mACnaLMol59U28ykTN8wJmqkiXLUsttKvpo+kjfmwrEc4ioo6
 CT/PKHHKGer+ZypvyIxcQRqkZ6/64mKpK8Xee80mkiybSx83ppyyVun6d1/Sjd1ZPtdbpnidH0f
 WchS6NmrX+WSBe89R0ZTaDzmsJYy7+tqUaXR5fZZYkFoE0mC9hHWH3bkqMH1rhtBgoSZdwSvtWk
 ICTZlvQQFMVL6zo1i5EgsehxjUJLyrz+WBorp1fKlAJjH0RH6rBUie793Ko52VwDzh0Ag==
X-Received: by 2002:a17:906:ee82:b0:c25:5114:c832 with SMTP id
 a640c23a62f3a-c25b3b804b3mr551915666b.3.1788268662834; 
 Tue, 01 Sep 2026 06:17:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/58] hw: Remove Marvell 88W8618 devices
Date: Tue,  1 Sep 2026 14:16:42 +0100
Message-ID: <20260901131732.2263947-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

The mv88w8618 ethernet and audio devices were used only by the
now-removed musicpal machine, so can also be deleted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Jan Kiszka <jan.kiszka@web.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260819185430.3467629-5-peter.maydell@linaro.org
---
 hw/arm/Kconfig                 |   3 -
 hw/audio/marvell_88w8618.c     | 315 --------------------------
 hw/audio/meson.build           |   1 -
 hw/net/meson.build             |   1 -
 hw/net/mv88w8618_eth.c         | 403 ---------------------------------
 include/hw/net/mv88w8618_eth.h |  13 --
 6 files changed, 736 deletions(-)
 delete mode 100644 hw/audio/marvell_88w8618.c
 delete mode 100644 hw/net/mv88w8618_eth.c
 delete mode 100644 include/hw/net/mv88w8618_eth.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 57db2a2fdf8..5db7ce057f4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -100,9 +100,6 @@ config MUSCA
     select SPLIT_IRQ
     select UNIMP
 
-config MARVELL_88W8618
-    bool
-
 config NETDUINO2
     bool
     default y
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
deleted file mode 100644
index 061d076dade..00000000000
--- a/hw/audio/marvell_88w8618.c
+++ /dev/null
@@ -1,315 +0,0 @@
-/*
- * Marvell 88w8618 audio emulation extracted from
- * Marvell MV88w8618 / Freecom MusicPal emulation.
- *
- * Copyright (c) 2008 Jan Kiszka
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/core/sysbus.h"
-#include "exec/cpu-common.h"
-#include "migration/vmstate.h"
-#include "hw/core/irq.h"
-#include "hw/core/qdev-properties.h"
-#include "hw/audio/wm8750.h"
-#include "qemu/audio.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-#include "system/physmem.h"
-
-#define MP_AUDIO_SIZE           0x00001000
-
-/* Audio register offsets */
-#define MP_AUDIO_PLAYBACK_MODE  0x00
-#define MP_AUDIO_CLOCK_DIV      0x18
-#define MP_AUDIO_IRQ_STATUS     0x20
-#define MP_AUDIO_IRQ_ENABLE     0x24
-#define MP_AUDIO_TX_START_LO    0x28
-#define MP_AUDIO_TX_THRESHOLD   0x2C
-#define MP_AUDIO_TX_STATUS      0x38
-#define MP_AUDIO_TX_START_HI    0x40
-
-/* Status register and IRQ enable bits */
-#define MP_AUDIO_TX_HALF        (1 << 6)
-#define MP_AUDIO_TX_FULL        (1 << 7)
-
-/* Playback mode bits */
-#define MP_AUDIO_16BIT_SAMPLE   (1 << 0)
-#define MP_AUDIO_PLAYBACK_EN    (1 << 7)
-#define MP_AUDIO_CLOCK_24MHZ    (1 << 9)
-#define MP_AUDIO_MONO           (1 << 14)
-
-OBJECT_DECLARE_SIMPLE_TYPE(mv88w8618_audio_state, MV88W8618_AUDIO)
-
-struct mv88w8618_audio_state {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    qemu_irq irq;
-    uint32_t playback_mode;
-    uint32_t status;
-    uint32_t irq_enable;
-    uint32_t phys_buf;
-    uint32_t target_buffer;
-    uint32_t threshold;
-    uint32_t play_pos;
-    uint32_t last_free;
-    uint32_t clock_div;
-    void *wm;
-};
-
-static void mv88w8618_audio_callback(void *opaque, int free_out, int free_in)
-{
-    mv88w8618_audio_state *s = opaque;
-    int16_t *codec_buffer;
-    QEMU_UNINITIALIZED int8_t buf[4096];
-    int8_t *mem_buffer;
-    int pos, block_size;
-
-    if (!(s->playback_mode & MP_AUDIO_PLAYBACK_EN)) {
-        return;
-    }
-    if (s->playback_mode & MP_AUDIO_16BIT_SAMPLE) {
-        free_out <<= 1;
-    }
-    if (!(s->playback_mode & MP_AUDIO_MONO)) {
-        free_out <<= 1;
-    }
-    block_size = s->threshold / 2;
-    if (free_out - s->last_free < block_size) {
-        return;
-    }
-    if (block_size > 4096) {
-        return;
-    }
-    physical_memory_read(s->target_buffer + s->play_pos, buf, block_size);
-    mem_buffer = buf;
-    if (s->playback_mode & MP_AUDIO_16BIT_SAMPLE) {
-        if (s->playback_mode & MP_AUDIO_MONO) {
-            codec_buffer = wm8750_dac_buffer(s->wm, block_size >> 1);
-            for (pos = 0; pos < block_size; pos += 2) {
-                *codec_buffer++ = *(int16_t *)mem_buffer;
-                *codec_buffer++ = *(int16_t *)mem_buffer;
-                mem_buffer += 2;
-            }
-        } else {
-            memcpy(wm8750_dac_buffer(s->wm, block_size >> 2),
-                   (uint32_t *)mem_buffer, block_size);
-        }
-    } else {
-        if (s->playback_mode & MP_AUDIO_MONO) {
-            codec_buffer = wm8750_dac_buffer(s->wm, block_size);
-            for (pos = 0; pos < block_size; pos++) {
-                *codec_buffer++ = cpu_to_le16(256 * *mem_buffer);
-                *codec_buffer++ = cpu_to_le16(256 * *mem_buffer++);
-            }
-        } else {
-            codec_buffer = wm8750_dac_buffer(s->wm, block_size >> 1);
-            for (pos = 0; pos < block_size; pos += 2) {
-                *codec_buffer++ = cpu_to_le16(256 * *mem_buffer++);
-                *codec_buffer++ = cpu_to_le16(256 * *mem_buffer++);
-            }
-        }
-    }
-    wm8750_dac_commit(s->wm);
-
-    s->last_free = free_out - block_size;
-
-    if (s->play_pos == 0) {
-        s->status |= MP_AUDIO_TX_HALF;
-        s->play_pos = block_size;
-    } else {
-        s->status |= MP_AUDIO_TX_FULL;
-        s->play_pos = 0;
-    }
-
-    if (s->status & s->irq_enable) {
-        qemu_irq_raise(s->irq);
-    }
-}
-
-static void mv88w8618_audio_clock_update(mv88w8618_audio_state *s)
-{
-    int rate;
-
-    if (s->playback_mode & MP_AUDIO_CLOCK_24MHZ) {
-        rate = 24576000 / 64; /* 24.576MHz */
-    } else {
-        rate = 11289600 / 64; /* 11.2896MHz */
-    }
-    rate /= ((s->clock_div >> 8) & 0xff) + 1;
-
-    wm8750_set_bclk_in(s->wm, rate);
-}
-
-static uint64_t mv88w8618_audio_read(void *opaque, hwaddr offset,
-                                    unsigned size)
-{
-    mv88w8618_audio_state *s = opaque;
-
-    switch (offset) {
-    case MP_AUDIO_PLAYBACK_MODE:
-        return s->playback_mode;
-
-    case MP_AUDIO_CLOCK_DIV:
-        return s->clock_div;
-
-    case MP_AUDIO_IRQ_STATUS:
-        return s->status;
-
-    case MP_AUDIO_IRQ_ENABLE:
-        return s->irq_enable;
-
-    case MP_AUDIO_TX_STATUS:
-        return s->play_pos >> 2;
-
-    default:
-        return 0;
-    }
-}
-
-static void mv88w8618_audio_write(void *opaque, hwaddr offset,
-                                  uint64_t value, unsigned size)
-{
-    mv88w8618_audio_state *s = opaque;
-
-    switch (offset) {
-    case MP_AUDIO_PLAYBACK_MODE:
-        if (value & MP_AUDIO_PLAYBACK_EN &&
-            !(s->playback_mode & MP_AUDIO_PLAYBACK_EN)) {
-            s->status = 0;
-            s->last_free = 0;
-            s->play_pos = 0;
-        }
-        s->playback_mode = value;
-        mv88w8618_audio_clock_update(s);
-        break;
-
-    case MP_AUDIO_CLOCK_DIV:
-        s->clock_div = value;
-        s->last_free = 0;
-        s->play_pos = 0;
-        mv88w8618_audio_clock_update(s);
-        break;
-
-    case MP_AUDIO_IRQ_STATUS:
-        s->status &= ~value;
-        break;
-
-    case MP_AUDIO_IRQ_ENABLE:
-        s->irq_enable = value;
-        if (s->status & s->irq_enable) {
-            qemu_irq_raise(s->irq);
-        }
-        break;
-
-    case MP_AUDIO_TX_START_LO:
-        s->phys_buf = (s->phys_buf & 0xFFFF0000) | (value & 0xFFFF);
-        s->target_buffer = s->phys_buf;
-        s->play_pos = 0;
-        s->last_free = 0;
-        break;
-
-    case MP_AUDIO_TX_THRESHOLD:
-        s->threshold = (value + 1) * 4;
-        break;
-
-    case MP_AUDIO_TX_START_HI:
-        s->phys_buf = (s->phys_buf & 0xFFFF) | (value << 16);
-        s->target_buffer = s->phys_buf;
-        s->play_pos = 0;
-        s->last_free = 0;
-        break;
-    }
-}
-
-static void mv88w8618_audio_reset(DeviceState *d)
-{
-    mv88w8618_audio_state *s = MV88W8618_AUDIO(d);
-
-    s->playback_mode = 0;
-    s->status = 0;
-    s->irq_enable = 0;
-    s->clock_div = 0;
-    s->threshold = 0;
-    s->phys_buf = 0;
-}
-
-static const MemoryRegionOps mv88w8618_audio_ops = {
-    .read = mv88w8618_audio_read,
-    .write = mv88w8618_audio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void mv88w8618_audio_init(Object *obj)
-{
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    mv88w8618_audio_state *s = MV88W8618_AUDIO(dev);
-
-    sysbus_init_irq(dev, &s->irq);
-
-    memory_region_init_io(&s->iomem, obj, &mv88w8618_audio_ops, s,
-                          "audio", MP_AUDIO_SIZE);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
-                             (Object **) &s->wm,
-                             qdev_prop_allow_set_link_before_realize,
-                             0);
-}
-
-static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
-{
-    mv88w8618_audio_state *s = MV88W8618_AUDIO(dev);
-
-    wm8750_data_req_set(s->wm, mv88w8618_audio_callback, s);
-}
-
-static const VMStateDescription mv88w8618_audio_vmsd = {
-    .name = "mv88w8618_audio",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(playback_mode, mv88w8618_audio_state),
-        VMSTATE_UINT32(status, mv88w8618_audio_state),
-        VMSTATE_UINT32(irq_enable, mv88w8618_audio_state),
-        VMSTATE_UINT32(phys_buf, mv88w8618_audio_state),
-        VMSTATE_UINT32(target_buffer, mv88w8618_audio_state),
-        VMSTATE_UINT32(threshold, mv88w8618_audio_state),
-        VMSTATE_UINT32(play_pos, mv88w8618_audio_state),
-        VMSTATE_UINT32(last_free, mv88w8618_audio_state),
-        VMSTATE_UINT32(clock_div, mv88w8618_audio_state),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void mv88w8618_audio_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = mv88w8618_audio_realize;
-    device_class_set_legacy_reset(dc, mv88w8618_audio_reset);
-    dc->vmsd = &mv88w8618_audio_vmsd;
-    dc->user_creatable = false;
-}
-
-static const TypeInfo mv88w8618_audio_info = {
-    .name          = TYPE_MV88W8618_AUDIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(mv88w8618_audio_state),
-    .instance_init = mv88w8618_audio_init,
-    .class_init    = mv88w8618_audio_class_init,
-};
-
-static void mv88w8618_register_types(void)
-{
-    type_register_static(&mv88w8618_audio_info);
-}
-
-type_init(mv88w8618_register_types)
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
index 2154cbdb57a..c977679e23a 100644
--- a/hw/audio/meson.build
+++ b/hw/audio/meson.build
@@ -7,7 +7,6 @@ system_ss.add(when: 'CONFIG_CS4231A', if_true: files('cs4231a.c'))
 system_ss.add(when: 'CONFIG_ES1370', if_true: files('es1370.c'))
 system_ss.add(when: 'CONFIG_GUS', if_true: files('gus.c', 'gusemu_hal.c', 'gusemu_mixer.c'))
 system_ss.add(when: 'CONFIG_HDA', if_true: files('intel-hda.c', 'hda-codec.c'))
-system_ss.add(when: 'CONFIG_MARVELL_88W8618', if_true: files('marvell_88w8618.c'))
 system_ss.add(when: 'CONFIG_PCSPK', if_true: files('pcspk.c'))
 system_ss.add(when: 'CONFIG_PL041', if_true: files('pl041.c', 'lm4549.c'))
 system_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 84f142df222..b4c95b58faf 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -27,7 +27,6 @@ system_ss.add(when: 'CONFIG_ALLWINNER_EMAC', if_true: files('allwinner_emac.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_SUN8I_EMAC', if_true: files('allwinner-sun8i-emac.c'))
 system_ss.add(when: 'CONFIG_IMX_FEC', if_true: files('imx_fec.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-emac.c'))
-system_ss.add(when: 'CONFIG_MARVELL_88W8618', if_true: files('mv88w8618_eth.c'))
 
 system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_gem.c'))
 system_ss.add(when: 'CONFIG_STELLARIS_ENET', if_true: files('stellaris_enet.c'))
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
deleted file mode 100644
index 1fcfbe912ee..00000000000
--- a/hw/net/mv88w8618_eth.c
+++ /dev/null
@@ -1,403 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Marvell MV88W8618 / Freecom MusicPal emulation.
- *
- * Copyright (c) 2008 Jan Kiszka
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/core/qdev-properties.h"
-#include "hw/core/sysbus.h"
-#include "hw/core/irq.h"
-#include "hw/net/mv88w8618_eth.h"
-#include "migration/vmstate.h"
-#include "system/dma.h"
-#include "net/net.h"
-
-#define MP_ETH_SIZE             0x00001000
-
-/* Ethernet register offsets */
-#define MP_ETH_SMIR             0x010
-#define MP_ETH_PCXR             0x408
-#define MP_ETH_SDCMR            0x448
-#define MP_ETH_ICR              0x450
-#define MP_ETH_IMR              0x458
-#define MP_ETH_FRDP0            0x480
-#define MP_ETH_FRDP1            0x484
-#define MP_ETH_FRDP2            0x488
-#define MP_ETH_FRDP3            0x48C
-#define MP_ETH_CRDP0            0x4A0
-#define MP_ETH_CRDP1            0x4A4
-#define MP_ETH_CRDP2            0x4A8
-#define MP_ETH_CRDP3            0x4AC
-#define MP_ETH_CTDP0            0x4E0
-#define MP_ETH_CTDP1            0x4E4
-
-/* MII PHY access */
-#define MP_ETH_SMIR_DATA        0x0000FFFF
-#define MP_ETH_SMIR_ADDR        0x03FF0000
-#define MP_ETH_SMIR_OPCODE      (1 << 26) /* Read value */
-#define MP_ETH_SMIR_RDVALID     (1 << 27)
-
-/* PHY registers */
-#define MP_ETH_PHY1_BMSR        0x00210000
-#define MP_ETH_PHY1_PHYSID1     0x00410000
-#define MP_ETH_PHY1_PHYSID2     0x00610000
-
-#define MP_PHY_BMSR_LINK        0x0004
-#define MP_PHY_BMSR_AUTONEG     0x0008
-
-#define MP_PHY_88E3015          0x01410E20
-
-/* TX descriptor status */
-#define MP_ETH_TX_OWN           (1U << 31)
-
-/* RX descriptor status */
-#define MP_ETH_RX_OWN           (1U << 31)
-
-/* Interrupt cause/mask bits */
-#define MP_ETH_IRQ_RX_BIT       0
-#define MP_ETH_IRQ_RX           (1 << MP_ETH_IRQ_RX_BIT)
-#define MP_ETH_IRQ_TXHI_BIT     2
-#define MP_ETH_IRQ_TXLO_BIT     3
-
-/* Port config bits */
-#define MP_ETH_PCXR_2BSM_BIT    28 /* 2-byte incoming suffix */
-
-/* SDMA command bits */
-#define MP_ETH_CMD_TXHI         (1 << 23)
-#define MP_ETH_CMD_TXLO         (1 << 22)
-
-typedef struct mv88w8618_tx_desc {
-    uint32_t cmdstat;
-    uint16_t res;
-    uint16_t bytes;
-    uint32_t buffer;
-    uint32_t next;
-} mv88w8618_tx_desc;
-
-typedef struct mv88w8618_rx_desc {
-    uint32_t cmdstat;
-    uint16_t bytes;
-    uint16_t buffer_size;
-    uint32_t buffer;
-    uint32_t next;
-} mv88w8618_rx_desc;
-
-OBJECT_DECLARE_SIMPLE_TYPE(mv88w8618_eth_state, MV88W8618_ETH)
-
-struct mv88w8618_eth_state {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion iomem;
-    qemu_irq irq;
-    MemoryRegion *dma_mr;
-    AddressSpace dma_as;
-    uint32_t smir;
-    uint32_t icr;
-    uint32_t imr;
-    int mmio_index;
-    uint32_t vlan_header;
-    uint32_t tx_queue[2];
-    uint32_t rx_queue[4];
-    uint32_t frx_queue[4];
-    uint32_t cur_rx[4];
-    NICState *nic;
-    NICConf conf;
-};
-
-static void eth_rx_desc_put(AddressSpace *dma_as, uint32_t addr,
-                            mv88w8618_rx_desc *desc)
-{
-    cpu_to_le32s(&desc->cmdstat);
-    cpu_to_le16s(&desc->bytes);
-    cpu_to_le16s(&desc->buffer_size);
-    cpu_to_le32s(&desc->buffer);
-    cpu_to_le32s(&desc->next);
-    dma_memory_write(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
-}
-
-static void eth_rx_desc_get(AddressSpace *dma_as, uint32_t addr,
-                            mv88w8618_rx_desc *desc)
-{
-    dma_memory_read(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
-    le32_to_cpus(&desc->cmdstat);
-    le16_to_cpus(&desc->bytes);
-    le16_to_cpus(&desc->buffer_size);
-    le32_to_cpus(&desc->buffer);
-    le32_to_cpus(&desc->next);
-}
-
-static ssize_t eth_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    mv88w8618_eth_state *s = qemu_get_nic_opaque(nc);
-    uint32_t desc_addr;
-    mv88w8618_rx_desc desc;
-    int i;
-
-    for (i = 0; i < 4; i++) {
-        desc_addr = s->cur_rx[i];
-        if (!desc_addr) {
-            continue;
-        }
-        do {
-            eth_rx_desc_get(&s->dma_as, desc_addr, &desc);
-            if ((desc.cmdstat & MP_ETH_RX_OWN) && desc.buffer_size >= size) {
-                dma_memory_write(&s->dma_as, desc.buffer + s->vlan_header,
-                                 buf, size, MEMTXATTRS_UNSPECIFIED);
-                desc.bytes = size + s->vlan_header;
-                desc.cmdstat &= ~MP_ETH_RX_OWN;
-                s->cur_rx[i] = desc.next;
-
-                s->icr |= MP_ETH_IRQ_RX;
-                if (s->icr & s->imr) {
-                    qemu_irq_raise(s->irq);
-                }
-                eth_rx_desc_put(&s->dma_as, desc_addr, &desc);
-                return size;
-            }
-            desc_addr = desc.next;
-        } while (desc_addr != s->rx_queue[i]);
-    }
-    return size;
-}
-
-static void eth_tx_desc_put(AddressSpace *dma_as, uint32_t addr,
-                            mv88w8618_tx_desc *desc)
-{
-    cpu_to_le32s(&desc->cmdstat);
-    cpu_to_le16s(&desc->res);
-    cpu_to_le16s(&desc->bytes);
-    cpu_to_le32s(&desc->buffer);
-    cpu_to_le32s(&desc->next);
-    dma_memory_write(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
-}
-
-static void eth_tx_desc_get(AddressSpace *dma_as, uint32_t addr,
-                            mv88w8618_tx_desc *desc)
-{
-    dma_memory_read(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
-    le32_to_cpus(&desc->cmdstat);
-    le16_to_cpus(&desc->res);
-    le16_to_cpus(&desc->bytes);
-    le32_to_cpus(&desc->buffer);
-    le32_to_cpus(&desc->next);
-}
-
-static void eth_send(mv88w8618_eth_state *s, int queue_index)
-{
-    uint32_t desc_addr = s->tx_queue[queue_index];
-    mv88w8618_tx_desc desc;
-    uint32_t next_desc;
-    uint8_t buf[2048];
-    int len;
-
-    do {
-        eth_tx_desc_get(&s->dma_as, desc_addr, &desc);
-        next_desc = desc.next;
-        if (desc.cmdstat & MP_ETH_TX_OWN) {
-            len = desc.bytes;
-            if (len < 2048) {
-                dma_memory_read(&s->dma_as, desc.buffer, buf, len,
-                                MEMTXATTRS_UNSPECIFIED);
-                qemu_send_packet(qemu_get_queue(s->nic), buf, len);
-            }
-            desc.cmdstat &= ~MP_ETH_TX_OWN;
-            s->icr |= 1 << (MP_ETH_IRQ_TXLO_BIT - queue_index);
-            eth_tx_desc_put(&s->dma_as, desc_addr, &desc);
-        }
-        desc_addr = next_desc;
-    } while (desc_addr != s->tx_queue[queue_index]);
-}
-
-static uint64_t mv88w8618_eth_read(void *opaque, hwaddr offset,
-                                   unsigned size)
-{
-    mv88w8618_eth_state *s = opaque;
-
-    switch (offset) {
-    case MP_ETH_SMIR:
-        if (s->smir & MP_ETH_SMIR_OPCODE) {
-            switch (s->smir & MP_ETH_SMIR_ADDR) {
-            case MP_ETH_PHY1_BMSR:
-                return MP_PHY_BMSR_LINK | MP_PHY_BMSR_AUTONEG |
-                       MP_ETH_SMIR_RDVALID;
-            case MP_ETH_PHY1_PHYSID1:
-                return (MP_PHY_88E3015 >> 16) | MP_ETH_SMIR_RDVALID;
-            case MP_ETH_PHY1_PHYSID2:
-                return (MP_PHY_88E3015 & 0xFFFF) | MP_ETH_SMIR_RDVALID;
-            default:
-                return MP_ETH_SMIR_RDVALID;
-            }
-        }
-        return 0;
-
-    case MP_ETH_ICR:
-        return s->icr;
-
-    case MP_ETH_IMR:
-        return s->imr;
-
-    case MP_ETH_FRDP0 ... MP_ETH_FRDP3:
-        return s->frx_queue[(offset - MP_ETH_FRDP0) / 4];
-
-    case MP_ETH_CRDP0 ... MP_ETH_CRDP3:
-        return s->rx_queue[(offset - MP_ETH_CRDP0) / 4];
-
-    case MP_ETH_CTDP0 ... MP_ETH_CTDP1:
-        return s->tx_queue[(offset - MP_ETH_CTDP0) / 4];
-
-    default:
-        return 0;
-    }
-}
-
-static void mv88w8618_eth_write(void *opaque, hwaddr offset,
-                                uint64_t value, unsigned size)
-{
-    mv88w8618_eth_state *s = opaque;
-
-    switch (offset) {
-    case MP_ETH_SMIR:
-        s->smir = value;
-        break;
-
-    case MP_ETH_PCXR:
-        s->vlan_header = ((value >> MP_ETH_PCXR_2BSM_BIT) & 1) * 2;
-        break;
-
-    case MP_ETH_SDCMR:
-        if (value & MP_ETH_CMD_TXHI) {
-            eth_send(s, 1);
-        }
-        if (value & MP_ETH_CMD_TXLO) {
-            eth_send(s, 0);
-        }
-        if (value & (MP_ETH_CMD_TXHI | MP_ETH_CMD_TXLO) && s->icr & s->imr) {
-            qemu_irq_raise(s->irq);
-        }
-        break;
-
-    case MP_ETH_ICR:
-        s->icr &= value;
-        break;
-
-    case MP_ETH_IMR:
-        s->imr = value;
-        if (s->icr & s->imr) {
-            qemu_irq_raise(s->irq);
-        }
-        break;
-
-    case MP_ETH_FRDP0 ... MP_ETH_FRDP3:
-        s->frx_queue[(offset - MP_ETH_FRDP0) / 4] = value;
-        break;
-
-    case MP_ETH_CRDP0 ... MP_ETH_CRDP3:
-        s->rx_queue[(offset - MP_ETH_CRDP0) / 4] =
-            s->cur_rx[(offset - MP_ETH_CRDP0) / 4] = value;
-        break;
-
-    case MP_ETH_CTDP0 ... MP_ETH_CTDP1:
-        s->tx_queue[(offset - MP_ETH_CTDP0) / 4] = value;
-        break;
-    }
-}
-
-static const MemoryRegionOps mv88w8618_eth_ops = {
-    .read = mv88w8618_eth_read,
-    .write = mv88w8618_eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void eth_cleanup(NetClientState *nc)
-{
-    mv88w8618_eth_state *s = qemu_get_nic_opaque(nc);
-
-    s->nic = NULL;
-}
-
-static NetClientInfo net_mv88w8618_info = {
-    .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState),
-    .receive = eth_receive,
-    .cleanup = eth_cleanup,
-};
-
-static void mv88w8618_eth_init(Object *obj)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    DeviceState *dev = DEVICE(sbd);
-    mv88w8618_eth_state *s = MV88W8618_ETH(dev);
-
-    sysbus_init_irq(sbd, &s->irq);
-    memory_region_init_io(&s->iomem, obj, &mv88w8618_eth_ops, s,
-                          "mv88w8618-eth", MP_ETH_SIZE);
-    sysbus_init_mmio(sbd, &s->iomem);
-}
-
-static void mv88w8618_eth_realize(DeviceState *dev, Error **errp)
-{
-    mv88w8618_eth_state *s = MV88W8618_ETH(dev);
-
-    if (!s->dma_mr) {
-        error_setg(errp, TYPE_MV88W8618_ETH " 'dma-memory' link not set");
-        return;
-    }
-
-    address_space_init(&s->dma_as, s->dma_mr, "emac-dma");
-    s->nic = qemu_new_nic(&net_mv88w8618_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id,
-                          &dev->mem_reentrancy_guard, s);
-}
-
-static const VMStateDescription mv88w8618_eth_vmsd = {
-    .name = "mv88w8618_eth",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(smir, mv88w8618_eth_state),
-        VMSTATE_UINT32(icr, mv88w8618_eth_state),
-        VMSTATE_UINT32(imr, mv88w8618_eth_state),
-        VMSTATE_UINT32(vlan_header, mv88w8618_eth_state),
-        VMSTATE_UINT32_ARRAY(tx_queue, mv88w8618_eth_state, 2),
-        VMSTATE_UINT32_ARRAY(rx_queue, mv88w8618_eth_state, 4),
-        VMSTATE_UINT32_ARRAY(frx_queue, mv88w8618_eth_state, 4),
-        VMSTATE_UINT32_ARRAY(cur_rx, mv88w8618_eth_state, 4),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const Property mv88w8618_eth_properties[] = {
-    DEFINE_NIC_PROPERTIES(mv88w8618_eth_state, conf),
-    DEFINE_PROP_LINK("dma-memory", mv88w8618_eth_state, dma_mr,
-                     TYPE_MEMORY_REGION, MemoryRegion *),
-};
-
-static void mv88w8618_eth_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd = &mv88w8618_eth_vmsd;
-    device_class_set_props(dc, mv88w8618_eth_properties);
-    dc->realize = mv88w8618_eth_realize;
-}
-
-static const TypeInfo mv88w8618_eth_info = {
-    .name          = TYPE_MV88W8618_ETH,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(mv88w8618_eth_state),
-    .instance_init = mv88w8618_eth_init,
-    .class_init    = mv88w8618_eth_class_init,
-};
-
-static void musicpal_register_types(void)
-{
-    type_register_static(&mv88w8618_eth_info);
-}
-
-type_init(musicpal_register_types)
-
diff --git a/include/hw/net/mv88w8618_eth.h b/include/hw/net/mv88w8618_eth.h
deleted file mode 100644
index 41074940ec0..00000000000
--- a/include/hw/net/mv88w8618_eth.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Marvell MV88W8618 / Freecom MusicPal emulation.
- *
- * Copyright (c) 2008-2021 QEMU contributors
- */
-
-#ifndef HW_NET_MV88W8618_ETH_H
-#define HW_NET_MV88W8618_ETH_H
-
-#define TYPE_MV88W8618_ETH "mv88w8618_eth"
-
-#endif
-- 
2.43.0


