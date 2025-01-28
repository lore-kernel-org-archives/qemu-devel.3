Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9FFC02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxl-000287-1o; Tue, 28 Jan 2025 15:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxi-00026S-Ue
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:30 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxh-0001aE-6r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:30 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso41557765e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095208; x=1738700008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YfmFIALECF1YnPo5TXCJA57O7vPBexNzDejZbEElEkM=;
 b=DG6l2ZcmGNKAENqaYaObEcx6o5i2K0alftcMPwE0sRLgXmBozVHyFD3E2+jUPTsZ/8
 tvEaF321fIISPus4wUb6+oAtEnH/76mmUziqQFXiIpFnX6ZYIPBXrIFTQaXZ7udOzf70
 TgMHATrIwWYWcdeR4J1Ra6s6/U2t5EzuxTWBtSNPByrhnXq8yyE+Ud54joUOrtuBs5dt
 cVpE6J7ZLl1I2J3JOiGx2T6QnPnMDMaDdPSxuR4bob2ssvTFjN17OtdHAIWau/bsU8lH
 7xxC/LHsmitkdToYuQnmuaBy5RiCaW//QfxvkYsFaF54dOo0Ek0MsPHhviqxRahG035P
 MUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095208; x=1738700008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfmFIALECF1YnPo5TXCJA57O7vPBexNzDejZbEElEkM=;
 b=TjAm1q7gkH3RraSraRVMkYo/vXqohJnUlzdAtQgX58Nub5FXsoC5dmxxg5p4n37aU8
 I5fsy9ELQ5S/H2BvQYxtdT1fbJnjaTTVsCOGRzq2j9Rwlqqnv7D7gh5+zKJjo/c8gz8E
 IRgjCglAlLGZ2iQHFAIYG92+SuDELTob6zkqzYlj7LPpH7WocwIo3RB5V1OBurpiAc1O
 5QE+cc8HWrEyJXtghbUlgq313xFUn3Isoh7/Qu6dtsfMqowPZhhzmbGUdbRCCulDPgzZ
 C1kBlFjupp73K1pm51Z1oSxNsJvlVaBzXbA8O3E+d0Aw0B/lpQZ6lvhifYWreKtkgLTy
 pAdg==
X-Gm-Message-State: AOJu0YwwWpFGvCnLPwuc4T0/qSm5gVN67fq41XGQaa8G3/OUqBjaM4gK
 KHvP11GeQ/hNapcZ16uXI37YsSPR7pBCmHVWJA08KjurISsqQivVaPJOCbDHo7mg76WFJgk/B8a
 c
X-Gm-Gg: ASbGncsJB1vzJyaPSKcAHLqEvG7+zNREyfMFHvBM/3Pd3W5eaeZDnZADv7FbEpXlDB6
 HpOVTdg2+hq2UzcwPRgfW7Vpltt4xePFvy3Rpf5FavAa0gnntMaPkMex9zwwY/345CAQxOINoCO
 UF/bTolOW8udZVdAreRBcjF8k7cLYlY2np1n2Wm/BvSrEOO1OF3aoRNTO+V4oSxN4XGfURvz+bR
 GmcLRac7D2r5cxUeDM7neo+Db80CqMBxxWFAZk7hrP6I21kBXXPLQH8Q7R/iT9avzNmCkeJL/X+
 lOv0/saOFBOo3RMeyPPuaNfF94wgubfb
X-Google-Smtp-Source: AGHT+IGNl4rUSc0LzoJ/9S0IooZLaCFZoMltveKnerTTsV9DsFdh7wtzi4qq9KaMgdQAISDt70/Y3A==
X-Received: by 2002:a05:600c:4e09:b0:436:1c04:aa8e with SMTP id
 5b1f17b1804b1-438dc3c8200mr2700365e9.16.1738095207736; 
 Tue, 28 Jan 2025 12:13:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/36] hw/arm/stellaris: Use DEVCAP macro to access
 DeviceCapability registers
Date: Tue, 28 Jan 2025 20:12:49 +0000
Message-Id: <20250128201314.44038-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Add definitions (DCx_periph) for the DeviceCapability bits,
replace direct bitmask checks with the DEV_CAP() macro,
which use the extract/deposit API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250110160204.74997-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index dd342b17d2a..82f935cb329 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "hw/core/split-irq.h"
 #include "hw/sysbus.h"
@@ -54,6 +55,26 @@
 #define NUM_GPTM    4
 #define NUM_I2C     2
 
+/*
+ * See Stellaris Data Sheet chapter 5.2.5 "System Control",
+ * Register 13 .. 17: Device Capabilities 0 .. 4 (DC0 .. DC4).
+ */
+#define DC1_WDT          3
+#define DC1_HIB          6
+#define DC1_MPU          7
+#define DC1_ADC          16
+#define DC1_PWM          20
+#define DC2_UART(n)     (n)
+#define DC2_SSI          4
+#define DC2_QEI(n)      (8 + n)
+#define DC2_I2C(n)      (12 + 2 * n)
+#define DC2_GPTM(n)     (16 + n)
+#define DC2_COMP(n)     (24 + n)
+#define DC4_GPIO(n)     (n)
+#define DC4_EMAC         28
+
+#define DEV_CAP(_dc, _cap) extract32(board->dc##_dc, DC##_dc##_##_cap, 1)
+
 typedef const struct {
     const char *name;
     uint32_t did0;
@@ -1118,7 +1139,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     sysbus_mmio_map(SYS_BUS_DEVICE(ssys_dev), 0, 0x400fe000);
     sysbus_connect_irq(SYS_BUS_DEVICE(ssys_dev), 0, qdev_get_gpio_in(nvic, 28));
 
-    if (board->dc1 & (1 << 16)) {
+    if (DEV_CAP(1, ADC)) {
         dev = sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
                                     qdev_get_gpio_in(nvic, 14),
                                     qdev_get_gpio_in(nvic, 15),
@@ -1130,7 +1151,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         adc = NULL;
     }
     for (i = 0; i < NUM_GPTM; i++) {
-        if (board->dc2 & (0x10000 << i)) {
+        if (DEV_CAP(2, GPTM(i))) {
             SysBusDevice *sbd;
 
             dev = qdev_new(TYPE_STELLARIS_GPTM);
@@ -1147,7 +1168,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
-    if (board->dc1 & (1 << 3)) { /* watchdog present */
+    if (DEV_CAP(1, WDT)) {
         dev = qdev_new(TYPE_LUMINARY_WATCHDOG);
         object_property_add_child(soc_container, "wdg", OBJECT(dev));
         qdev_connect_clock_in(dev, "WDOGCLK",
@@ -1164,7 +1185,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
 
     for (i = 0; i < NUM_GPIO; i++) {
-        if (board->dc4 & (1 << i)) {
+        if (DEV_CAP(4, GPIO(i))) {
             gpio_dev[i] = sysbus_create_simple("pl061_luminary", gpio_addr[i],
                                                qdev_get_gpio_in(nvic,
                                                                 gpio_irq[i]));
@@ -1175,7 +1196,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
-    if (board->dc2 & (1 << 12)) {
+    if (DEV_CAP(2, I2C(0))) {
         dev = sysbus_create_simple(TYPE_STELLARIS_I2C, 0x40020000,
                                    qdev_get_gpio_in(nvic, 8));
         i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
@@ -1185,7 +1206,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     }
 
     for (i = 0; i < NUM_UART; i++) {
-        if (board->dc2 & (1 << i)) {
+        if (DEV_CAP(2, UART(i))) {
             SysBusDevice *sbd;
 
             dev = qdev_new("pl011_luminary");
@@ -1197,7 +1218,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
             sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(nvic, uart_irq[i]));
         }
     }
-    if (board->dc2 & (1 << 4)) {
+    if (DEV_CAP(2, SSI)) {
         dev = sysbus_create_simple("pl022", 0x40008000,
                                    qdev_get_gpio_in(nvic, 7));
         if (board->peripherals & BP_OLED_SSI) {
@@ -1306,7 +1327,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
             qemu_irq_raise(gpio_out[GPIO_D][0]);
         }
     }
-    if (board->dc4 & (1 << 28)) {
+    if (DEV_CAP(4, EMAC)) {
         DeviceState *enet;
 
         enet = qdev_new("stellaris_enet");
-- 
2.34.1


