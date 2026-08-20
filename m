Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD4FC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqE-0001xF-Fx; Wed, 19 Aug 2026 22:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq2-0001sv-SG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:08 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq0-0000Uf-Sw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:06 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66c4e9769bdso2207573d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194142; x=1787798942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xDaaEt1n/sIlofl3Hx3umypupJKxlen86Rp6vXEYh9U=;
 b=r5BqqD/tbgS/OvnNIdcEtP85iWnAEITe9ExGWBIPbu9x632Lyoys/wsQtF++mbsD0w
 ExOa2pJ57Klf6InzIxxCD/e0O+RJTAyEJuBCLzje3J+vAogysLvLpL5PDu8WHb9wlOXj
 rF7cwsBEyBfuYeJaT+CXlJFRGtLVjP5BnbOn03qjyr8sn4taZK4jCvEd7ByI7oonO/ro
 /78w9k7/4m6RtGnHnOvsVsJURYdYbU+hkgThxovSNbF6hb+D4oQA0oG72dZKZ3GFgVDg
 NjAh3RsxRVm81zsfQ7vlo0vtLFfje/ME5//BGXSZMiNsL1qxGC+vxfMZ9nX3U5LeUNSh
 +frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194142; x=1787798942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xDaaEt1n/sIlofl3Hx3umypupJKxlen86Rp6vXEYh9U=;
 b=SFcQT1ilJm5lv8OxbMSYhbq55e8HVTeHJYhrtyU7SXrwIdlIj3yHg/3RoiZf8ikHOF
 bzsU1iC6RuRdsjxpkOXx/WAUgR2g27n3JtWwkLBptPRg2zHc7R1meR/ypxEIX98Rq8sY
 GK7yo6Zce651O9gDRa1E8gmHF/AmmAoSIHsFJFz0c74SdbpSytySLovUJuE1Own7pIEB
 o9utxWg2cOD8U7Ljs4+Tcl2q1yZGRsB7tYEdP/tWBGRwSy8a86y5e/hwjy+fIlBxs0bT
 eYzet8jQDE2pGzCDrVHy4KInODMxHSCP8UUCiKwtIneUyEqJzdb7M6Z3LP+Dq2zBl9Jf
 RLnA==
X-Gm-Message-State: AFuF++kS269mFBb98eKqWSPYcKx/DwUy+X+sq7TJjAhPP7nuhfEfXD8k
 2s8VdryhMnnpos8XcpzEtd8lvSv+mqLvFaczn78NYQ5znCSDgqeSZfj/wao9gw==
X-Gm-Gg: AR+sD10UB6V21DoMGd1F6Yqj4zfCoOa0l6UPxrGT3Qh/9KtlPXOcu4cogQPBIjkZoVM
 qRPnGwqWMu3j0QMiLsbSd9MNZwZ0VJn9foE/6mby2QCC+Ps1ayKw1aVyQnt1hjcgxHbEsdk+DWT
 3GaDCG0BMmk0Q8wvw2Fdc2TsGB6m8A9u2YVF9SmVaBlnT1h24t6LWdTgxpPJBCUHeIb7edF2iHK
 TfdbXmQX2zEZoabbFHqjhTVMhbvKFMR3WYmItOL9+ra8dvb1iTx4Elrdnj00H4vX8f0d2RkqMdC
 eEv4agXdvpNF2wllhmsqTVK6rl9q4IGdpqOz3x8gL6lbWGZP1F9P1MsQ+5RsbOjkRpaNX28LykF
 NjwLx8PYEaCAzGeWL4Mh8q5t5VyUGYOgtxCGztflwciAYl0vfYjgO3SRnvZ8CrarcTTvmNIrK/4
 V5bmHUTkCeIqNfTN+1o5pUVF6rK4foeANRvNdS70EuoIZsyTIClbvksL32lZdMBMD1k1demIVfF
 obR0F9Nno15rvQn/syDcOdm0ukBT8pXsokhwbMztteTn+EidOxhtA==
X-Received: by 2002:a05:690e:4147:b0:664:f064:f663 with SMTP id
 956f58d0204a3-66ccb6f0969mr2843286d50.28.1787194142541; 
 Wed, 19 Aug 2026 19:49:02 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:49:01 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 10/16] hw/misc: add i.MX 95 watchdog
Date: Wed, 19 Aug 2026 21:48:28 -0500
Message-Id: <20260820024834.3286721-11-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The i.MX 95 watchdog. A register-level model of the CS/CNT/TOVAL/WIN
registers and the unlock sequence, enough for the SM and Linux to
configure and refresh it. It has no live timer and does not reset the
machine on timeout; it exists so the watchdog node probes and is
programmable rather than faulting on first access.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/misc/Kconfig      |   3 +
 hw/misc/imx95_wdog.c | 198 +++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build  |   1 +
 hw/misc/trace-events |   2 +
 4 files changed, 204 insertions(+)
 create mode 100644 hw/misc/imx95_wdog.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ded60e21a6c..2bae76b4ec1 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -268,3 +268,6 @@ config IMX_MU
 config IMX95_ELE_SERVER
     bool
     select IMX_MU
+
+config IMX95_WDOG
+    bool
diff --git a/hw/misc/imx95_wdog.c b/hw/misc/imx95_wdog.c
new file mode 100644
index 00000000000..4fe91a92b6d
--- /dev/null
+++ b/hw/misc/imx95_wdog.c
@@ -0,0 +1,198 @@
+/*
+ * NXP i.MX 95 ULP Watchdog stub model
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Minimal stub of the ULP watchdog (compatible "fsl,imx93-wdt") used
+ * by U-Boot SPL's arch_cpu_init() to disable WDG3/4/5 before the
+ * console comes up. SPL's disable_wdog() reads CS @ 0x00 and either
+ * early-exits if the enable bit (0x80) is clear or runs an unlock +
+ * disable handshake that polls for CS.ULK (0x800) and CS.RCS (0x400).
+ *
+ * The stub leaves the watchdog disabled at reset, so the first CS
+ * read returns 0 and disable_wdog() returns immediately. The unlock
+ * sequence is implemented for the cases where the guest forces the
+ * unlock anyway: a write of 0xD928C520 to CNT @ 0x04 sets CS.ULK,
+ * any subsequent write to CS sets CS.RCS. No timer behaviour is
+ * modelled.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX95_WDOG "imx95.wdog"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95WDogState, IMX95_WDOG)
+
+#define IMX95_WDOG_REG_SIZE     0x10000
+
+/* Register offsets. */
+#define WDOG_CS                 0x00
+#define WDOG_CNT                0x04
+#define WDOG_TOVAL              0x08
+#define WDOG_WIN                0x0C
+
+/* CS bit fields exercised by U-Boot. */
+#define CS_EN                   0x00000080
+#define CS_RCS                  0x00000400  /* reconfig complete */
+#define CS_ULK                  0x00000800  /* unlocked */
+
+#define UNLOCK_WORD             0xD928C520
+
+struct IMX95WDogState {
+    SysBusDevice    parent_obj;
+
+    MemoryRegion    iomem;
+
+    uint32_t        cs;
+    uint32_t        cnt;
+    uint32_t        toval;
+    uint32_t        win;
+};
+
+static uint64_t imx95_wdog_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX95WDogState *s = opaque;
+
+    switch (offset) {
+    case WDOG_CS:
+        return s->cs;
+    case WDOG_CNT:
+        return s->cnt;
+    case WDOG_TOVAL:
+        return s->toval;
+    case WDOG_WIN:
+        return s->win;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void imx95_wdog_write(void *opaque, hwaddr offset,
+                             uint64_t value, unsigned size)
+{
+    IMX95WDogState *s = opaque;
+
+    switch (offset) {
+    case WDOG_CS:
+        /*
+         * SPL writes CS to update timeout + window and to clear EN.
+         * Acknowledge by setting RCS (reconfig complete) so the
+         * "wait for RCS" loop at the tail of disable_wdog() exits.
+         */
+        s->cs = (value & ~CS_RCS) | CS_RCS;
+        trace_imx95_wdog_config(s->cs);
+        break;
+
+    case WDOG_CNT:
+        s->cnt = value;
+        /*
+         * A 32-bit UNLOCK_WORD write to CNT puts the watchdog into
+         * the unlocked state. Any other value (e.g. REFRESH_WORD)
+         * is just a refresh ping; ignore.
+         */
+        if ((uint32_t)value == UNLOCK_WORD) {
+            s->cs |= CS_ULK;
+            trace_imx95_wdog_unlock();
+        }
+        break;
+
+    case WDOG_TOVAL:
+        s->toval = value;
+        break;
+
+    case WDOG_WIN:
+        s->win = value;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx
+                      " value 0x%" PRIx64 "\n",
+                      __func__, offset, value);
+        break;
+    }
+}
+
+static const MemoryRegionOps imx95_wdog_ops = {
+    .read = imx95_wdog_read,
+    .write = imx95_wdog_write,
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
+static void imx95_wdog_reset_hold(Object *obj, ResetType type)
+{
+    IMX95WDogState *s = IMX95_WDOG(obj);
+
+    /* Watchdog disabled at reset: CS = 0 makes disable_wdog() early-exit. */
+    s->cs = 0;
+    s->cnt = 0;
+    s->toval = 0x400;
+    s->win = 0;
+}
+
+static void imx95_wdog_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMX95WDogState *s = IMX95_WDOG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_wdog_ops, s,
+                          TYPE_IMX95_WDOG, IMX95_WDOG_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx95_wdog = {
+    .name = TYPE_IMX95_WDOG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cs, IMX95WDogState),
+        VMSTATE_UINT32(cnt, IMX95WDogState),
+        VMSTATE_UINT32(toval, IMX95WDogState),
+        VMSTATE_UINT32(win, IMX95WDogState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_wdog_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx95_wdog;
+    rc->phases.hold = imx95_wdog_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 ULP watchdog (stub)";
+}
+
+static const TypeInfo imx95_wdog_info = {
+    .name           = TYPE_IMX95_WDOG,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95WDogState),
+    .instance_init  = imx95_wdog_init,
+    .class_init     = imx95_wdog_class_init,
+};
+
+static void imx95_wdog_register_types(void)
+{
+    type_register_static(&imx95_wdog_info);
+}
+
+type_init(imx95_wdog_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b0dade72c6c..3f8cd1d825e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -173,3 +173,4 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 system_ss.add(when: 'CONFIG_IMX_MU', if_true: files('imx_mu.c'))
 system_ss.add(when: 'CONFIG_IMX95_ELE_SERVER', if_true: files('imx95_ele_server.c'))
+system_ss.add(when: 'CONFIG_IMX95_WDOG', if_true: files('imx95_wdog.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 6b3cff74549..584c1f90963 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -448,3 +448,5 @@ imx_mu_doorbell(unsigned idx) "doorbell GIR channel %u"
 imx_mu_gip(unsigned idx) "GIP assert channel %u"
 imx95_ele_msg(uint8_t command, uint8_t tag, uint32_t size) "received cmd 0x%02x tag 0x%02x size %u"
 imx95_ele_response(uint8_t command) "response cmd 0x%02x"
+imx95_wdog_config(uint32_t cs) "CS <- 0x%08x"
+imx95_wdog_unlock(void) "unlock word written"
-- 
2.34.1


