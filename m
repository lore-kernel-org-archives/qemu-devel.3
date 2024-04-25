Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246A5C25B4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWg-0002RK-LU; Thu, 25 Apr 2024 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWc-0002EP-39
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWa-0007Fx-5E
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41b5dc5e101so1750815e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041618; x=1714646418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/OyvTVKZYtoEIJ/h2hDyr2SLAKjdy8KBH3pJgY2yh4=;
 b=q2hlwIajxDgiFrKKgq/LW0RuqVmvuL3Pz/e7zKJYBNYAjm+TT4gK+WkJQr/j4pKrdk
 LKHSdCvS2KckNqSUKrlmcfNSCLrZ+G25hAofwZh36K3TF0iorSBG2z5yRF6X11H2nhYE
 cgtgjs63BKLsZnGfDJVeZY3iii5+dvLuTdeuLjgSDdIIT7SPcae5EdYj8DI/YSkSGfVo
 4KZx7qKegtZsJiXH7Bre6XHq/jiZ9ZHk34Dqb88o3tJkQlcdn+N0gAUoSLRCZysyB37M
 oaMpJLpIrWxXBGaKGGCawv7up/szujZr5zectGXPgAVBzCKzLm3pQYFgIE+dMb4Udau3
 STcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041618; x=1714646418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/OyvTVKZYtoEIJ/h2hDyr2SLAKjdy8KBH3pJgY2yh4=;
 b=kcCGIDfgGAQ4qJkfm49A5/e45mW5y0M+xeMfcEXS3HwIcPq7dGjYgToPnXkaZBgj0E
 w+XGIfzQLNZe2nqQxXXA04lyj27hc9ZzzZPie9m7/LiY3MbijAxeCfcXt4ETfY94P3mt
 BgtxKGxPTFIZjQhmVHhdFefBt1oF6lqPj6y/DMU9KBnAtciD7IAQ1iqQ2we9HpOEjEy1
 P67/f9zCdOSN78SXsJSRFYYMOCfbhIFg3k1EwELo32XqG88MSe4QmnZwHb/xQZ7YhUkp
 BDuVcwcCtpPATFuo9iXqrhQsmHXOjs/rLbhmvFYtY89DYbBwwIwGIAmuusZnJUcwSPO5
 S7sQ==
X-Gm-Message-State: AOJu0YycgeOSMNQ06fclixcmpjX6Ne/uhOmak7ZOJ1h+Ux56tam+gB2N
 NlT612XLabACE9f2OQQ/F+5AeqjUkQN+iq0ybMPcykE+lfYf8p4a0nXZWydr/GX3W4ZuXBB3OEv
 u
X-Google-Smtp-Source: AGHT+IFMgdibrCQP29pxwWw8qZX2PRWQLg531DZbH2GFnbFqzcNVHvr8ZWUe2ilxyg+3EnNSP4BGIg==
X-Received: by 2002:a05:6000:912:b0:348:b435:273b with SMTP id
 cw18-20020a056000091200b00348b435273bmr4149126wrb.54.1714041618680; 
 Thu, 25 Apr 2024 03:40:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/37] hw/char/stm32l4x5_usart: Add options for serial
 parameters setting
Date: Thu, 25 Apr 2024 11:39:56 +0100
Message-Id: <20240425103958.3237225-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Add a function to change the settings of the
serial connection.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240329174402.60382-4-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c | 98 +++++++++++++++++++++++++++++++++++++++
 hw/char/trace-events      |  1 +
 2 files changed, 99 insertions(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 755fc0bb5a3..2627aab8324 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -271,6 +271,92 @@ static void usart_cancel_transmit(Stm32l4x5UsartBaseState *s)
     }
 }
 
+static void stm32l4x5_update_params(Stm32l4x5UsartBaseState *s)
+{
+    int speed, parity, data_bits, stop_bits;
+    uint32_t value, usart_div;
+    QEMUSerialSetParams ssp;
+
+    /* Select the parity type */
+    if (s->cr1 & R_CR1_PCE_MASK) {
+        if (s->cr1 & R_CR1_PS_MASK) {
+            parity = 'O';
+        } else {
+            parity = 'E';
+        }
+    } else {
+        parity = 'N';
+    }
+
+    /* Select the number of stop bits */
+    switch (FIELD_EX32(s->cr2, CR2, STOP)) {
+    case 0:
+        stop_bits = 1;
+        break;
+    case 2:
+        stop_bits = 2;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+            "UNIMPLEMENTED: fractionnal stop bits; CR2[13:12] = %u",
+            FIELD_EX32(s->cr2, CR2, STOP));
+        return;
+    }
+
+    /* Select the length of the word */
+    switch ((FIELD_EX32(s->cr1, CR1, M1) << 1) | FIELD_EX32(s->cr1, CR1, M0)) {
+    case 0:
+        data_bits = 8;
+        break;
+    case 1:
+        data_bits = 9;
+        break;
+    case 2:
+        data_bits = 7;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "UNDEFINED: invalid word length, CR1.M = 0b11");
+        return;
+    }
+
+    /* Select the baud rate */
+    value = FIELD_EX32(s->brr, BRR, BRR);
+    if (value < 16) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "UNDEFINED: BRR less than 16: %u", value);
+        return;
+    }
+
+    if (FIELD_EX32(s->cr1, CR1, OVER8) == 0) {
+        /*
+         * Oversampling by 16
+         * BRR = USARTDIV
+         */
+        usart_div = value;
+    } else {
+        /*
+         * Oversampling by 8
+         * - BRR[2:0] = USARTDIV[3:0] shifted 1 bit to the right.
+         * - BRR[3] must be kept cleared.
+         * - BRR[15:4] = USARTDIV[15:4]
+         * - The frequency is multiplied by 2
+         */
+        usart_div = ((value & 0xFFF0) | ((value & 0x0007) << 1)) / 2;
+    }
+
+    speed = clock_get_hz(s->clk) / usart_div;
+
+    ssp.speed     = speed;
+    ssp.parity    = parity;
+    ssp.data_bits = data_bits;
+    ssp.stop_bits = stop_bits;
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
+
+    trace_stm32l4x5_usart_update_params(speed, parity, data_bits, stop_bits);
+}
+
 static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
 {
     Stm32l4x5UsartBaseState *s = STM32L4X5_USART_BASE(obj);
@@ -369,16 +455,19 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
     switch (addr) {
     case A_CR1:
         s->cr1 = value;
+        stm32l4x5_update_params(s);
         stm32l4x5_update_irq(s);
         return;
     case A_CR2:
         s->cr2 = value;
+        stm32l4x5_update_params(s);
         return;
     case A_CR3:
         s->cr3 = value;
         return;
     case A_BRR:
         s->brr = value;
+        stm32l4x5_update_params(s);
         return;
     case A_GTPR:
         s->gtpr = value;
@@ -447,10 +536,19 @@ static void stm32l4x5_usart_base_init(Object *obj)
     s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
 }
 
+static int stm32l4x5_usart_base_post_load(void *opaque, int version_id)
+{
+    Stm32l4x5UsartBaseState *s = (Stm32l4x5UsartBaseState *)opaque;
+
+    stm32l4x5_update_params(s);
+    return 0;
+}
+
 static const VMStateDescription vmstate_stm32l4x5_usart_base = {
     .name = TYPE_STM32L4X5_USART_BASE,
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = stm32l4x5_usart_base_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(cr1, Stm32l4x5UsartBaseState),
         VMSTATE_UINT32(cr2, Stm32l4x5UsartBaseState),
diff --git a/hw/char/trace-events b/hw/char/trace-events
index f22f0ee2bc5..8875758076c 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -116,6 +116,7 @@ stm32l4x5_usart_irq_raised(uint32_t reg) "USART: IRQ raised: 0x%08"PRIx32
 stm32l4x5_usart_irq_lowered(void) "USART: IRQ lowered"
 stm32l4x5_usart_overrun_detected(uint8_t current, uint8_t received) "USART: Overrun detected, RDR='0x%x', received 0x%x"
 stm32l4x5_usart_receiver_not_enabled(uint8_t ue_bit, uint8_t re_bit) "USART: Receiver not enabled, UE=0x%x, RE=0x%x"
+stm32l4x5_usart_update_params(int speed, uint8_t parity, int data, int stop) "USART: speed: %d, parity: %c, data bits: %d, stop bits: %d"
 
 # xen_console.c
 xen_console_connect(unsigned int idx, unsigned int ring_ref, unsigned int port, unsigned int limit) "idx %u ring_ref %u port %u limit %u"
-- 
2.34.1


