Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E21CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qt-00060q-N0; Tue, 07 Oct 2025 10:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QR-0005om-NY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QA-0002F2-TT
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so49128405e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846321; x=1760451121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6K1r/UXmoqTTIwRgeNIErMtpaMXoLBqHoCdPYTCanlM=;
 b=yT2InjFgbLob4s9aSmxVjB0TC7jsOCv8lEHFJwgl1HHhzIrAKTQGRY7NOAe3Nd3TNg
 d6EFcJZs0vAMD9ITKLs+9tdm4zpDKNTosuLEuvLJHp6oAdBwOdtCV3Sr3HRsKWh7Ssf8
 RgUVhA2aHJkemBASFcSQ3W21ue1BRV9bHJ/j1iWt/RRPHy3B4Jq84eOQYN9CF2qO5zat
 U7iP0hi9G01nT4C3LXGCTpY71lj1Lk0s+6XD8yFfRXF52kuQltiH2gLhcnLiJnWon7Ac
 3uUoZ85+aakOv0gpqvBUY8yWafMpoAnHgh1fcT0RcuXTvNSD5vTEbhSrHp7hWyC+c13e
 OBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846321; x=1760451121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6K1r/UXmoqTTIwRgeNIErMtpaMXoLBqHoCdPYTCanlM=;
 b=gVQmcOQX1LO55liy0sAljY4Obk7hbG9daD+gWABl43jUk22pQKl8t+xxgfC1hNi16Q
 Ok9e31gJy3Ez5mh2qzTCkpVnUnVaxj2ywg6F+PWh0om8Txs031K4pPtwCByevIGzt0Er
 MOYHBL9Ozwf4LxL7EdcCxagDjCr5WJRejzUoMV2eXwQLg/1GIU2Az85DFyRfZWUZA1lW
 FfHDpcl++mrZRKT+pRdtACyDqNuoGDeTROMryD/3wSfM75no14BSKQAnz6FZSF3o05oV
 dXN9qts3Sm3N2rgfZUjhKBdOv4sXnzoImKmkLfNyO5yHyTAdCXN8dypwleS2ZRXCMQTK
 eRVw==
X-Gm-Message-State: AOJu0YwbG5BZicW/9E4BA0vJu2NHVoxC+gaKzbqHyYYFplKi0oKNNA0X
 2yVXYl5+opj4eDcTVT6S2Fy28Y6rDChQkXVljmWTNxxLsgMeC1jywggcxWefGS3VrlHAvz8u4Gg
 3G1k7
X-Gm-Gg: ASbGncvaNYD+qLmM1xf43RAOgI6VWpJ2pNDqv7KeJDZ++xMRQAjUfwsLl+DAUnNaFaK
 z8S3JIK5Ee5ULxIYEGTbnUHAwqfljwNrpy9gmYWTayUWHFghcZeDrtyagbF3eIiIPGM04CDDoM4
 DHpnMgx6YhXRNCMK6PWvi9y/mD75ExjPYeGyistQteEroc5WHX9LCsFm+J1iWKnB9nqYMPrVByV
 6PABeVGRyTY5eeg/nDENpOHTeKUhvt5Noz38g+Y0Q85+HEYWGbZLGaB6WQA5OT0feRSUVgVOjWk
 ySWeYDB3GS62kUwQYj4C9wfz2K2PhSL4y27K/ZQ/7ZHLSzTSTztTyEN36C9+TV22ZHsluzttzOn
 EhXilfEG+qJUndHLjTuMg/ItdJHrdfEKejct3UI9COZ6Yqds0whIEOIKB
X-Google-Smtp-Source: AGHT+IH8h4eCg6GVh0cTAwM7KanAx3+R/ofGaEiPb40z3q2hICTj/WciHESDapeVdU6gu00qtw9k/A==
X-Received: by 2002:a05:600c:4510:b0:46e:59bb:63cf with SMTP id
 5b1f17b1804b1-46e71140be1mr130191695e9.24.1759846320785; 
 Tue, 07 Oct 2025 07:12:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/62] hw/misc/xlnx-versal-crl: refactor device reset logic
Date: Tue,  7 Oct 2025 15:10:53 +0100
Message-ID: <20251007141123.3239867-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Luc Michel <luc.michel@amd.com>

Refactor the device reset logic to have a common register write callback
for all the devices. This uses a decode function to map the register
address to the actual peripheral to reset. This refactoring changes the
CPU property name from cpu_r5[*] to rpu[*] to ease with the connections
in the Versal SoC. It also fixes a bug where the gem device pointer
was mapped to the usb link property.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-33-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/xlnx-versal-crl.h |   8 +-
 hw/misc/xlnx-versal-crl.c         | 169 ++++++++++++++++--------------
 2 files changed, 95 insertions(+), 82 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index 2b39d203a67..7e50a95ad3c 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -220,8 +220,6 @@ REG32(PSM_RST_MODE, 0x370)
 
 #define CRL_R_MAX (R_PSM_RST_MODE + 1)
 
-#define RPU_MAX_CPU 2
-
 struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
 
@@ -231,6 +229,8 @@ struct XlnxVersalCRLBase {
 
 struct XlnxVersalCRLBaseClass {
     SysBusDeviceClass parent_class;
+
+    DeviceState ** (*decode_periph_rst)(XlnxVersalCRLBase *s, hwaddr, size_t *);
 };
 
 struct XlnxVersalCRL {
@@ -238,11 +238,11 @@ struct XlnxVersalCRL {
     qemu_irq irq;
 
     struct {
-        ARMCPU *cpu_r5[RPU_MAX_CPU];
+        DeviceState *rpu[2];
         DeviceState *adma[8];
         DeviceState *uart[2];
         DeviceState *gem[2];
-        DeviceState *usb;
+        DeviceState *usb[1];
     } cfg;
 
     uint32_t regs[CRL_R_MAX];
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index be89e0da40d..6225a92e0bd 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -55,90 +55,99 @@ static uint64_t crl_disable_prew(RegisterInfo *reg, uint64_t val64)
     return 0;
 }
 
-static void crl_reset_dev(XlnxVersalCRL *s, DeviceState *dev,
-                          bool rst_old, bool rst_new)
+static DeviceState **versal_decode_periph_rst(XlnxVersalCRLBase *s,
+                                              hwaddr addr, size_t *count)
 {
-    device_cold_reset(dev);
-}
+    size_t idx;
+    XlnxVersalCRL *xvc = XLNX_VERSAL_CRL(s);
 
-static void crl_reset_cpu(XlnxVersalCRL *s, ARMCPU *armcpu,
-                          bool rst_old, bool rst_new)
-{
-    if (rst_new) {
-        arm_set_cpu_off(arm_cpu_mp_affinity(armcpu));
-    } else {
-        arm_set_cpu_on_and_reset(arm_cpu_mp_affinity(armcpu));
+    *count = 1;
+
+    switch (addr) {
+    case A_RST_CPU_R5:
+        return xvc->cfg.rpu;
+
+    case A_RST_ADMA:
+        /* A single register fans out to all DMA reset inputs */
+        *count = ARRAY_SIZE(xvc->cfg.adma);
+        return xvc->cfg.adma;
+
+    case A_RST_UART0 ... A_RST_UART1:
+        idx = (addr - A_RST_UART0) / sizeof(uint32_t);
+        return xvc->cfg.uart + idx;
+
+    case A_RST_GEM0 ... A_RST_GEM1:
+        idx = (addr - A_RST_GEM0) / sizeof(uint32_t);
+        return xvc->cfg.gem + idx;
+
+    case A_RST_USB0:
+        return xvc->cfg.usb;
+
+    default:
+        /* invalid or unimplemented */
+        return NULL;
     }
 }
 
-#define REGFIELD_RESET(type, s, reg, f, new_val, dev) {     \
-    bool old_f = ARRAY_FIELD_EX32((s)->regs, reg, f);       \
-    bool new_f = FIELD_EX32(new_val, reg, f);               \
-                                                            \
-    /* Detect edges.  */                                    \
-    if (dev && old_f != new_f) {                            \
-        crl_reset_ ## type(s, dev, old_f, new_f);           \
-    }                                                       \
-}
-
-static uint64_t crl_rst_r5_prew(RegisterInfo *reg, uint64_t val64)
+static uint64_t crl_rst_cpu_prew(RegisterInfo *reg, uint64_t val64)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
+    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
+    DeviceState **dev;
+    size_t i, count;
 
-    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU0, val64, s->cfg.cpu_r5[0]);
-    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU1, val64, s->cfg.cpu_r5[1]);
-    return val64;
-}
+    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
 
-static uint64_t crl_rst_adma_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
-    int i;
+    for (i = 0; i < 2; i++) {
+        bool prev, new;
+        uint64_t aff;
 
-    /* A single register fans out to all ADMA reset inputs.  */
-    for (i = 0; i < ARRAY_SIZE(s->cfg.adma); i++) {
-        REGFIELD_RESET(dev, s, RST_ADMA, RESET, val64, s->cfg.adma[i]);
+        prev = extract32(s->regs[reg->access->addr / 4], i, 1);
+        new = extract32(val64, i, 1);
+
+        if (prev == new) {
+            continue;
+        }
+
+        aff = arm_cpu_mp_affinity(ARM_CPU(dev[i]));
+
+        if (new) {
+            arm_set_cpu_off(aff);
+        } else {
+            arm_set_cpu_on_and_reset(aff);
+        }
     }
+
     return val64;
 }
 
-static uint64_t crl_rst_uart0_prew(RegisterInfo *reg, uint64_t val64)
+static uint64_t crl_rst_dev_prew(RegisterInfo *reg, uint64_t val64)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
+    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
+    DeviceState **dev;
+    bool prev, new;
+    size_t i, count;
 
-    REGFIELD_RESET(dev, s, RST_UART0, RESET, val64, s->cfg.uart[0]);
-    return val64;
-}
+    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
 
-static uint64_t crl_rst_uart1_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    if (dev == NULL) {
+        return val64;
+    }
 
-    REGFIELD_RESET(dev, s, RST_UART1, RESET, val64, s->cfg.uart[1]);
-    return val64;
-}
+    prev = s->regs[reg->access->addr / 4] & 0x1;
+    new = val64 & 0x1;
 
-static uint64_t crl_rst_gem0_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
+    if (prev == new) {
+        return val64;
+    }
 
-    REGFIELD_RESET(dev, s, RST_GEM0, RESET, val64, s->cfg.gem[0]);
-    return val64;
-}
+    for (i = 0; i < count; i++) {
+        if (dev[i]) {
+            device_cold_reset(dev[i]);
+        }
+    }
 
-static uint64_t crl_rst_gem1_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
-
-    REGFIELD_RESET(dev, s, RST_GEM1, RESET, val64, s->cfg.gem[1]);
-    return val64;
-}
-
-static uint64_t crl_rst_usb_prew(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
-
-    REGFIELD_RESET(dev, s, RST_USB0, RESET, val64, s->cfg.usb);
     return val64;
 }
 
@@ -244,27 +253,27 @@ static const RegisterAccessInfo crl_regs_info[] = {
     },{ .name = "RST_CPU_R5",  .addr = A_RST_CPU_R5,
         .reset = 0x17,
         .rsvd = 0x8,
-        .pre_write = crl_rst_r5_prew,
+        .pre_write = crl_rst_cpu_prew,
     },{ .name = "RST_ADMA",  .addr = A_RST_ADMA,
         .reset = 0x1,
-        .pre_write = crl_rst_adma_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_GEM0",  .addr = A_RST_GEM0,
         .reset = 0x1,
-        .pre_write = crl_rst_gem0_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_GEM1",  .addr = A_RST_GEM1,
         .reset = 0x1,
-        .pre_write = crl_rst_gem1_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_SPARE",  .addr = A_RST_SPARE,
         .reset = 0x1,
     },{ .name = "RST_USB0",  .addr = A_RST_USB0,
         .reset = 0x1,
-        .pre_write = crl_rst_usb_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_UART0",  .addr = A_RST_UART0,
         .reset = 0x1,
-        .pre_write = crl_rst_uart0_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_UART1",  .addr = A_RST_UART1,
         .reset = 0x1,
-        .pre_write = crl_rst_uart1_prew,
+        .pre_write = crl_rst_dev_prew,
     },{ .name = "RST_SPI0",  .addr = A_RST_SPI0,
         .reset = 0x1,
     },{ .name = "RST_SPI1",  .addr = A_RST_SPI1,
@@ -343,9 +352,9 @@ static void versal_crl_init(Object *obj)
     sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
-    for (i = 0; i < ARRAY_SIZE(s->cfg.cpu_r5); ++i) {
-        object_property_add_link(obj, "cpu_r5[*]", TYPE_ARM_CPU,
-                                 (Object **)&s->cfg.cpu_r5[i],
+    for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
+        object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
+                                 (Object **)&s->cfg.rpu[i],
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG);
     }
@@ -371,10 +380,12 @@ static void versal_crl_init(Object *obj)
                                  OBJ_PROP_LINK_STRONG);
     }
 
-    object_property_add_link(obj, "usb", TYPE_DEVICE,
-                             (Object **)&s->cfg.gem[i],
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
+    for (i = 0; i < ARRAY_SIZE(s->cfg.usb); ++i) {
+        object_property_add_link(obj, "usb[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.usb[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
 }
 
 static void crl_finalize(Object *obj)
@@ -396,11 +407,13 @@ static const VMStateDescription vmstate_versal_crl = {
 static void versal_crl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_versal_crl;
     rc->phases.enter = versal_crl_reset_enter;
     rc->phases.hold = versal_crl_reset_hold;
+    xvcc->decode_periph_rst = versal_decode_periph_rst;
 }
 
 static const TypeInfo crl_base_info = {
-- 
2.43.0


