Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487A2C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqR-00023K-Nv; Wed, 19 Aug 2026 22:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq1-0001sN-3q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:07 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspx-0000Su-IV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:04 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66c4e9769bdso2207549d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194140; x=1787798940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TuEY6h8uSBfSVhgKCRtzXbvzolUunUFUPvBQ5EhqMr0=;
 b=dohYM8NuzTHUt0rpcjJXP4S0LCkFb/LTL+fS3BCwJ1v6HuznMXPftafJtcxV0+kLy8
 3OZkKoQxcnyN8z3fhLqwiJ9/zXkqLD9df/34e8SqJxRQlIarLhcBM4ymjjvYOecW6S+0
 lV31i9LSif+iFtlMnrNrHwDZUvVs7DKPdLLkzImKPXpdf26RzZ3ZCOb0cWTarlP6dGRV
 FXxEIdF+8sCXjSqtyfR7ivwx5wVVPcO72kZ2/sSPqTVERNpMMm9dyMmB/4a31Q22e3b0
 ZxQ8pHZiipQDAekiuwa4b/gEajB2UEVUH/gyqwlwhAxqLRvvshwOtFKe23c1Bjjf6JNi
 gQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194140; x=1787798940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TuEY6h8uSBfSVhgKCRtzXbvzolUunUFUPvBQ5EhqMr0=;
 b=kYyguscxxGph2yp0PwcJcNC/TPuGYM3MwHMS49/RuKxi7Pi6SBfANTozZBEqa/59g8
 KKKNnute5975gCRVw4C2F4Uvqw8H+iDxCBem4bc2De+psPmuo6x587CICENXkyUX4KiX
 HGvOowS7cgEZsrrJfHJcg57oF0l61nfRVleMg6PwVS4ZE1y8XS5vsritFj1l1RRqymhO
 7yWdAwUPd2dwaF1WsLNPnSZQQZoFeN3St/OqbB7kQeKzzkg8W4QdzexXo8VGLLs3gTQH
 cTjJ4yXDa2wh/Gbqtch1/wc1zUUOhUO+NOQ/cbsyPtJ2jaCHhMwdtaXHDip7qpSe7Q93
 0a+g==
X-Gm-Message-State: AFuF++mIAThTYeuohtH3jifBjF/nETyKE/RMfF2sNP6oB4V/tye0dmOP
 L0ofIzhzc5HM0rAIcnYICOM2NAbXmuifCu6mapjezs9AFxF6CS8/73+S+vrzyA==
X-Gm-Gg: AR+sD128MkzHtxtqJ0SuysOV8XP3vSI9p/Uix0S8cklmgS51mjR/Pg+ioA0WcP0EB7q
 b/TGlUXy33HyYQRZjhgzpy1Ts8l46QqHgzepb4AZIC7v1clzkc/6Pmf6vCYfOAjLHswV4ji6eDO
 0RUFRAaDofwKP2i0mdMBHNqp5WHe2xjanpkCgRaVxBQuK9m+rlyV9RemjWqXzOGxq+PPTdkMv/E
 bUIWXEXLPq7pXz3dA5/SbKdV+RWm+/p8vrhmSwClX85iFv5mDva/llzcP4vC9CjDAihwacSbx/U
 vt3XFsNQXKsn9KqPAI914N+LlR5NGK5xvtQ3SqGvxDZpdBiccDpr7OS4mCMFuKrCUgzMeIAah1u
 96ueNLd/Df2qWScWBB5tFTZfUBENJAfmYVdWVs6aSz9vlYlzF3kHFOiUkHVHpusOzSRGHd2IkBA
 rRY6AqB1Ot5ZlmbWanGhQn7s8AH7tzNC7K55yrgZHctaKzYcMmobsaidYHWroXczFQqj9Caxl9s
 BQEnzy9gSBCpj4b25gUy4mXghd7TGsZON/imFh4aWfoQdHz+AykAQ==
X-Received: by 2002:a53:c9c4:0:b0:668:8dfd:8c7f with SMTP id
 956f58d0204a3-66ccb745f7cmr2614998d50.43.1787194140437; 
 Wed, 19 Aug 2026 19:49:00 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:59 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 09/16] hw/timer: add i.MX 95 system counter
Date: Wed, 19 Aug 2026 21:48:27 -0500
Message-Id: <20260820024834.3286721-10-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12b.google.com
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

The i.MX 95 System Counter: a 24 MHz free-running up-counter with a
compare-match interrupt. On this machine it is the Linux broadcast
clockevent. Models the counter read-back, compare-value programming and
the compare IRQ (backed by a QEMUTimer).

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/timer/Kconfig        |   3 +
 hw/timer/imx95_sysctr.c | 241 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/meson.build    |   1 +
 hw/timer/trace-events   |   2 +
 4 files changed, 247 insertions(+)
 create mode 100644 hw/timer/imx95_sysctr.c

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1b751a54a7..1e8c5d50d7e 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -68,3 +68,6 @@ config AVR_TIMER16
 
 config HEX_QTIMER
     bool
+
+config IMX95_SYSCTR
+    bool
diff --git a/hw/timer/imx95_sysctr.c b/hw/timer/imx95_sysctr.c
new file mode 100644
index 00000000000..597bb851f23
--- /dev/null
+++ b/hw/timer/imx95_sysctr.c
@@ -0,0 +1,241 @@
+/*
+ * NXP i.MX 95 System Counter (sysctr) timer
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The system counter is a free-running up-counter plus a compare block that
+ * raises an interrupt when the counter reaches a programmed value. Linux uses
+ * it as the tick BROADCAST clockevent: the imx95 idle state `cpu-pd-wait`
+ * carries `local-timer-stop`, so a core entering cpuidle shuts down its
+ * per-CPU arch timer and depends entirely on this counter's compare interrupt
+ * to be woken. Modelling it as plain RAM (the previous stub) left idle cores
+ * with no wake source -> RCU stalls -> the boot needed `cpuidle.off=1`. This
+ * model gives a live counter + working compare IRQ so the broadcast-timer
+ * wake path works (deep cpuidle still needs cpuidle.off=1 - see the docs).
+ *
+ * Register layout (from Linux drivers/clocksource/timer-imx-sysctr.c, the
+ * imx95 quirk path which QEMU always takes - the IMX_SIP_GET_SOC_INFO SiP
+ * SMC is unimplemented here, so the driver sets SYS_CTR_IMX95_QUIRK):
+ *   - read frame  @ 0x20000: CNTCV_LO 0x20008 / CNTCV_HI 0x2000c (RO counter)
+ *     (also exposed at 0x8 / 0xc for the non-quirk read path)
+ *   - cmp frame   @ 0x10000: CMPCV_LO 0x10020 / CMPCV_HI 0x10024 (compare
+ *     value, RW, read-back-verified by the driver) and CMPCR 0x1002c
+ *     (control: EN = bit0; the driver acks the IRQ by clearing EN, which
+ *     drops the status bit and negates the interrupt).
+ *
+ * Only the master compare channel + its single interrupt are modelled (the
+ * DT exposes one IRQ; the broadcast framework needs only one channel).
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/host-utils.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX95_SYSCTR "imx95.sysctr"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95SysctrState, IMX95_SYSCTR)
+
+#define IMX95_SYSCTR_REG_SIZE   0x30000
+
+/* The system counter reference is the 24 MHz oscillator (nxp,no-divider). */
+#define IMX95_SYSCTR_FREQ_HZ    24000000ULL
+
+/* Register offsets (see file header). */
+#define SYSCTR_CNTCV_LO         0x8
+#define SYSCTR_CNTCV_HI         0xc
+#define SYSCTR_CMPCV_LO         0x10020
+#define SYSCTR_CMPCV_HI         0x10024
+#define SYSCTR_CMPCR            0x1002c
+#define SYSCTR_CNTCV_LO_RD      0x20008
+#define SYSCTR_CNTCV_HI_RD      0x2000c
+
+#define SYSCTR_CMPCR_EN         0x1
+
+struct IMX95SysctrState {
+    SysBusDevice    parent_obj;
+    MemoryRegion    iomem;
+    qemu_irq        irq;
+    QEMUTimer       timer;
+
+    uint32_t        cmpcv_lo;
+    uint32_t        cmpcv_hi;
+    uint32_t        cmpcr;
+};
+
+static uint64_t imx95_sysctr_count(void)
+{
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                    IMX95_SYSCTR_FREQ_HZ, NANOSECONDS_PER_SECOND);
+}
+
+static uint64_t imx95_sysctr_cmpcv(IMX95SysctrState *s)
+{
+    return ((uint64_t)s->cmpcv_hi << 32) | s->cmpcv_lo;
+}
+
+/*
+ * (Re)arm or disarm the compare. When the compare is enabled, schedule the
+ * timer for the virtual-time instant the counter reaches CMPCV; a value
+ * already in the past makes timer_mod fire at the next opportunity. When
+ * disabled, cancel the timer and negate the interrupt (this is how the
+ * driver's ISR acks: it clears EN).
+ */
+static void imx95_sysctr_update(IMX95SysctrState *s)
+{
+    if (s->cmpcr & SYSCTR_CMPCR_EN) {
+        uint64_t deadline = muldiv64(imx95_sysctr_cmpcv(s),
+                                     NANOSECONDS_PER_SECOND,
+                                     IMX95_SYSCTR_FREQ_HZ);
+        trace_imx95_sysctr_cmp(imx95_sysctr_cmpcv(s));
+        timer_mod(&s->timer, deadline);
+    } else {
+        timer_del(&s->timer);
+        qemu_set_irq(s->irq, 0);
+    }
+}
+
+static void imx95_sysctr_timer_cb(void *opaque)
+{
+    IMX95SysctrState *s = opaque;
+
+    if (s->cmpcr & SYSCTR_CMPCR_EN) {
+        trace_imx95_sysctr_expire();
+        qemu_set_irq(s->irq, 1);
+    }
+}
+
+static uint64_t imx95_sysctr_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX95SysctrState *s = opaque;
+    uint64_t cnt = imx95_sysctr_count();
+
+    switch (offset) {
+    case SYSCTR_CNTCV_LO:
+    case SYSCTR_CNTCV_LO_RD:
+        return cnt & 0xffffffff;
+    case SYSCTR_CNTCV_HI:
+    case SYSCTR_CNTCV_HI_RD:
+        return (cnt >> 32) & 0xffffffff;
+    case SYSCTR_CMPCV_LO:
+        return s->cmpcv_lo;
+    case SYSCTR_CMPCV_HI:
+        return s->cmpcv_hi;
+    case SYSCTR_CMPCR:
+        return s->cmpcr;
+    default:
+        return 0;
+    }
+}
+
+static void imx95_sysctr_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    IMX95SysctrState *s = opaque;
+
+    switch (offset) {
+    case SYSCTR_CMPCV_LO:
+        s->cmpcv_lo = value;
+        imx95_sysctr_update(s);
+        break;
+    case SYSCTR_CMPCV_HI:
+        s->cmpcv_hi = value;
+        imx95_sysctr_update(s);
+        break;
+    case SYSCTR_CMPCR:
+        s->cmpcr = value;
+        imx95_sysctr_update(s);
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps imx95_sysctr_ops = {
+    .read = imx95_sysctr_read,
+    .write = imx95_sysctr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx95_sysctr_reset_hold(Object *obj, ResetType type)
+{
+    IMX95SysctrState *s = IMX95_SYSCTR(obj);
+
+    s->cmpcv_lo = 0;
+    s->cmpcv_hi = 0;
+    s->cmpcr = 0;
+    timer_del(&s->timer);
+    qemu_set_irq(s->irq, 0);
+}
+
+static void imx95_sysctr_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMX95SysctrState *s = IMX95_SYSCTR(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_sysctr_ops, s,
+                          TYPE_IMX95_SYSCTR, IMX95_SYSCTR_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+    timer_init_ns(&s->timer, QEMU_CLOCK_VIRTUAL, imx95_sysctr_timer_cb, s);
+}
+
+static int imx95_sysctr_post_load(void *opaque, int version_id)
+{
+    /* Re-arm the compare (and re-raise a past-due IRQ) from restored state. */
+    imx95_sysctr_update(opaque);
+    return 0;
+}
+
+static const VMStateDescription vmstate_imx95_sysctr = {
+    .name = TYPE_IMX95_SYSCTR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = imx95_sysctr_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cmpcv_lo, IMX95SysctrState),
+        VMSTATE_UINT32(cmpcv_hi, IMX95SysctrState),
+        VMSTATE_UINT32(cmpcr, IMX95SysctrState),
+        VMSTATE_TIMER(timer, IMX95SysctrState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_sysctr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx95_sysctr;
+    rc->phases.hold = imx95_sysctr_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 system counter timer";
+}
+
+static const TypeInfo imx95_sysctr_info = {
+    .name           = TYPE_IMX95_SYSCTR,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95SysctrState),
+    .instance_init  = imx95_sysctr_init,
+    .class_init     = imx95_sysctr_class_init,
+};
+
+static void imx95_sysctr_register_types(void)
+{
+    type_register_static(&imx95_sysctr_info);
+}
+
+type_init(imx95_sysctr_register_types)
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 8323efaf46b..5ce27a6df0a 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -36,3 +36,4 @@ system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
 
 system_ss.add(when: 'CONFIG_HEX_QTIMER', if_true: files('qct-qtimer.c'))
+system_ss.add(when: 'CONFIG_IMX95_SYSCTR', if_true: files('imx95_sysctr.c'))
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 636310f8caa..df457bbb967 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -133,3 +133,5 @@ imx_epit_cmp(uint32_t sr) "sr was %d"
 qtimer_interrupt(void) "qtimer interrupt line updated"
 qtimer_read(uint64_t offset) "offset 0x%" PRIx64
 qtimer_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
+imx95_sysctr_cmp(uint64_t cmpcv) "compare value 0x%" PRIx64
+imx95_sysctr_expire(void) "compare fired"
-- 
2.34.1


