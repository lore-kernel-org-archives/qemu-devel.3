Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9ABC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag41-0004Z6-2Z; Thu, 15 Feb 2024 13:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3Y-0003JH-Uj
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3T-0002e1-Qv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-410ca9e851bso9273655e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020109; x=1708624909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d24ptjop5v0vDtRVKzO4zmRV4raxlddQ2KCuegz4KuQ=;
 b=iE1pr4AdBSs5B4LHUVicwSvRTLthFEBDiRbnz0Isko64bZsM3CqB46gUyW0vDZORJg
 XD3ZoywU/irnjJUmju++FF7OagnN07+bSym5iUEP5IrO0bZsU+zVkSG7xXOfbaEU1ARC
 NkKbnrI7UnjRihnJNh6J0OnHaT1OfLdFVEr6jrWLz+84b0M01M4Yy4e/BZqfS7YhlUza
 0vcx+QAuM1hPd1uxkYIjPJsh7PvlduvrR2AkD4NC42qOABDxfBdT+6/jvzviN7l/el1H
 BuO3TC5xiF+W0CrjdjdhZ3cSKE0xV/DK04fwNgzAFnNAiAi3m0hTWpdnjeD9DUo57Mam
 v3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020109; x=1708624909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d24ptjop5v0vDtRVKzO4zmRV4raxlddQ2KCuegz4KuQ=;
 b=h9x2xATV+fpjsu9bdyYBcGdcVwIQNMSpA7X9g1Ovd10vcRbcXPOaETgt+rXO3S6/O9
 x1nvNWCxyzEU60YsIzgGrCtuTaehK6as70ISHzgy0rraB5OQz7mqa0Iy+sXq8d7aaS+x
 bWKu888qqqrXwmZunlrunIcjQnTyvd2cJgnyq8lNEWg87yJQnhfai3IJnV+HjOTmzZYP
 Xl5vfUl2IED+OaXdHl91y1P9kgt38mTN/MfkD9IuQs2VlveL3BpxqV7TcLMXt3dDOUXK
 vZvuo6NkyG5gr2xLymLOq69tA+odtfOFk0o7uTdiNawtDF5iYF3Y/RCfcyGbqOZJ3Srp
 KoBA==
X-Gm-Message-State: AOJu0YxZqJAmN6M9MXp2nbZSsJklYUFa7CsyRwKPLkvFXYA6YO0yolms
 O0WSVTlcbNNBLlxkzVEp+B4d3dgJ+c93tocUswecK7AALRoBsnpLCSxXGeBsNPsd9qMu/1ag9KA
 zx4g=
X-Google-Smtp-Source: AGHT+IFWsRPf3KdaqdmqnYQkTg97jRJi2UMAa8FO8t7BINh7EWaqHP1zeWca6l8fqotmTRq7Ei2pzw==
X-Received: by 2002:a5d:4491:0:b0:33b:87a0:3af with SMTP id
 j17-20020a5d4491000000b0033b87a003afmr1863512wrq.67.1708020108771; 
 Thu, 15 Feb 2024 10:01:48 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 bu23-20020a056000079700b0033cdf4bea19sm2621169wrb.9.2024.02.15.10.01.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:01:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/56] hw/intc/grlib_irqmp: implements the multiprocessor
 status register
Date: Thu, 15 Feb 2024 18:57:29 +0100
Message-ID: <20240215175752.82828-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Clément Chigot <chigot@adacore.com>

This implements the multiprocessor status register in grlib-irqmp and
bind it to a start signal, which will be later wired in leon3-generic
to start a cpu.

The EIRQ and BA bits are not implemented.

Based on https://gaisler.com/doc/gr712rc-usermanual.pdf, §8.3.5.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240131085047.18458-4-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/grlib_irqmp.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 744cd64c58..1e073bd232 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -52,6 +52,10 @@
 #define FORCE_OFFSET     0x80
 #define EXTENDED_OFFSET  0xC0
 
+/* Multiprocessor Status Register  */
+#define MP_STATUS_CPU_STATUS_MASK ((1 << IRQMP_MAX_CPU)-2)
+#define MP_STATUS_NCPU_SHIFT      28
+
 #define MAX_PILS 16
 
 OBJECT_DECLARE_SIMPLE_TYPE(IRQMP, GRLIB_IRQMP)
@@ -65,6 +69,7 @@ struct IRQMP {
 
     unsigned int ncpus;
     IRQMPState *state;
+    qemu_irq start_signal[IRQMP_MAX_CPU];
     qemu_irq irq;
 };
 
@@ -72,6 +77,7 @@ struct IRQMPState {
     uint32_t level;
     uint32_t pending;
     uint32_t clear;
+    uint32_t mpstatus;
     uint32_t broadcast;
 
     uint32_t mask[IRQMP_MAX_CPU];
@@ -182,10 +188,12 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
         return state->force[0];
 
     case CLEAR_OFFSET:
-    case MP_STATUS_OFFSET:
         /* Always read as 0 */
         return 0;
 
+    case MP_STATUS_OFFSET:
+        return state->mpstatus;
+
     case BROADCAST_OFFSET:
         return state->broadcast;
 
@@ -224,8 +232,9 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
 static void grlib_irqmp_write(void *opaque, hwaddr addr,
                               uint64_t value, unsigned size)
 {
-    IRQMP      *irqmp = opaque;
+    IRQMP *irqmp = opaque;
     IRQMPState *state;
+    int i;
 
     assert(irqmp != NULL);
     state = irqmp->state;
@@ -258,7 +267,18 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
         return;
 
     case MP_STATUS_OFFSET:
-        /* Read Only (no SMP support) */
+        /*
+         * Writing and reading operations are reversed for the CPU status.
+         * Writing "1" will start the CPU, but reading "1" means that the CPU
+         * is power-down.
+         */
+        value &= MP_STATUS_CPU_STATUS_MASK;
+        for (i = 0; i < irqmp->ncpus; i++) {
+            if ((value >> i) & 1) {
+                qemu_set_irq(irqmp->start_signal[i], 1);
+                state->mpstatus &= ~(1 << i);
+            }
+        }
         return;
 
     case BROADCAST_OFFSET:
@@ -325,6 +345,8 @@ static void grlib_irqmp_reset(DeviceState *d)
 
     memset(irqmp->state, 0, sizeof *irqmp->state);
     irqmp->state->parent = irqmp;
+    irqmp->state->mpstatus = ((irqmp->ncpus - 1) << MP_STATUS_NCPU_SHIFT) |
+        ((1 << irqmp->ncpus) - 2);
 }
 
 static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
@@ -338,6 +360,13 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
+
+    /*
+     * Transitionning from 0 to 1 starts the CPUs. The opposite can't
+     * happen.
+     */
+    qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
+                             IRQMP_MAX_CPU);
     qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
-- 
2.41.0


