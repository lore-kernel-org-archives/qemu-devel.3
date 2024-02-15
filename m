Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A21DC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag47-0005BD-Kr; Thu, 15 Feb 2024 13:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3d-0003Nt-5h
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:01 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3a-0002fL-6r
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:00 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d11d17dddeso13844371fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020116; x=1708624916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avVErRmCHTD7s/Wno/RUxec7ez6aln5fuHfjB8LlDS4=;
 b=muB9VQmXoNWZB5wTWohU3kAoWKB41f9NiVeV/dmwSJJ5aanz7Vul3ZrowLzEFRfXFO
 4srIsGsRcorAEylAnMqbjsjm/9POY02XOboYfMVNR0Ep+bdQmu1Ke7xHUs48x60GLd2P
 3+cFjqkCvZIjVOGLx5f4oSf+EQxl1wf7qmdkTDFRjEPTIz2wXDEzhFUqpp/Wzdfz4A6N
 O/vJyx7EtBqr4lo366vmoeBw9T8XssOHkLA6fnHGbv3uqU8y2IYL4LdyZpgAVVjd4WoK
 hxM1PM9sF995WK81eJRRACYIQMQQMlqnYZXy9NKcDooaDWzirOc95dvUI7DJvy8Mx5Tw
 DVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020116; x=1708624916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avVErRmCHTD7s/Wno/RUxec7ez6aln5fuHfjB8LlDS4=;
 b=AqOEQlk9cz10pv8jGeiy7qoNgXNe4OUP9n2IK4+31tatzpY+TsvyzSZH5rOR2rrAvd
 i4/5UswPCD/XXjlkqNGIcD/4RhwGRPzw30wOxvx4n0WpgyxZ6v+2RGhXOT7i0Zw2/wPD
 m5HsTAESqP1i0cHnPNVflb/ekR/goTRUg1jOoGqYsqoQdemkCQvzfSHbHc5LOqca8tKi
 gufCgrjcgPuIREQocBtiL4TDkKGbcIFpOwilFJe6XqHxcANeiUUyOEbYLcvDjU0SAJ9q
 wg4lpe1tZdyDxImvjXGAQGqbGrFcQXX2NoJ5VR6tNYDkMBZgGaFhBUFrt+Tx9c19d2Q3
 8NcA==
X-Gm-Message-State: AOJu0YwGTYwNs9pqiAUqczcZjtz/YGdOk+mP8EM735WDKT6CxmjxlwYm
 3cvI6wkHbiQvBF01777onXH2OPHEHIhxStpsO9sGvHdeG60ox29g5b68dOZHBc+TigKS+OOiZBZ
 3POo=
X-Google-Smtp-Source: AGHT+IFVq13Wdr5Pw40vHE3qBJGkGFgnigRkeRIia5qGiw5lSbj1h4EYyV+A9drzfKN2Z/fRpl8lOA==
X-Received: by 2002:a05:651c:d3:b0:2d0:cead:83cb with SMTP id
 19-20020a05651c00d300b002d0cead83cbmr1897443ljr.50.1708020116139; 
 Thu, 15 Feb 2024 10:01:56 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a05600c294900b00410cc2f5550sm5662269wmd.19.2024.02.15.10.01.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:01:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 36/56] hw/intc/grlib_irqmp: implements multicore irq
Date: Thu, 15 Feb 2024 18:57:30 +0100
Message-ID: <20240215175752.82828-37-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now there is an ncpus property, use it in order to deliver the IRQ to
multiple CPU.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240131085047.18458-5-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/grlib_irqmp.h |  2 +-
 hw/intc/grlib_irqmp.c         | 41 +++++++++++++++++------------------
 hw/sparc/leon3.c              |  3 ++-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/hw/intc/grlib_irqmp.h b/include/hw/intc/grlib_irqmp.h
index c5a90cbb3e..a76acbf940 100644
--- a/include/hw/intc/grlib_irqmp.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -36,6 +36,6 @@
 /* IRQMP */
 #define TYPE_GRLIB_IRQMP "grlib-irqmp"
 
-void grlib_irqmp_ack(DeviceState *dev, int intno);
+void grlib_irqmp_ack(DeviceState *dev, unsigned int cpu, int intno);
 
 #endif /* GRLIB_IRQMP_H */
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 1e073bd232..144b121d48 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -70,7 +70,7 @@ struct IRQMP {
     unsigned int ncpus;
     IRQMPState *state;
     qemu_irq start_signal[IRQMP_MAX_CPU];
-    qemu_irq irq;
+    qemu_irq irq[IRQMP_MAX_CPU];
 };
 
 struct IRQMPState {
@@ -89,37 +89,35 @@ struct IRQMPState {
 
 static void grlib_irqmp_check_irqs(IRQMPState *state)
 {
-    uint32_t      pend   = 0;
-    uint32_t      level0 = 0;
-    uint32_t      level1 = 0;
+    int i;
 
     assert(state != NULL);
     assert(state->parent != NULL);
 
-    /* IRQ for CPU 0 (no SMP support) */
-    pend = (state->pending | state->force[0])
-        & state->mask[0];
+    for (i = 0; i < state->parent->ncpus; i++) {
+        uint32_t pend = (state->pending | state->force[i]) & state->mask[i];
+        uint32_t level0 = pend & ~state->level;
+        uint32_t level1 = pend &  state->level;
 
-    level0 = pend & ~state->level;
-    level1 = pend &  state->level;
+        trace_grlib_irqmp_check_irqs(state->pending, state->force[i],
+                                     state->mask[i], level1, level0);
 
-    trace_grlib_irqmp_check_irqs(state->pending, state->force[0],
-                                 state->mask[0], level1, level0);
-
-    /* Trigger level1 interrupt first and level0 if there is no level1 */
-    qemu_set_irq(state->parent->irq, level1 ?: level0);
+        /* Trigger level1 interrupt first and level0 if there is no level1 */
+        qemu_set_irq(state->parent->irq[i], level1 ?: level0);
+    }
 }
 
-static void grlib_irqmp_ack_mask(IRQMPState *state, uint32_t mask)
+static void grlib_irqmp_ack_mask(IRQMPState *state, unsigned int cpu,
+                                 uint32_t mask)
 {
     /* Clear registers */
     state->pending  &= ~mask;
-    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
+    state->force[cpu] &= ~mask;
 
     grlib_irqmp_check_irqs(state);
 }
 
-void grlib_irqmp_ack(DeviceState *dev, int intno)
+void grlib_irqmp_ack(DeviceState *dev, unsigned int cpu, int intno)
 {
     IRQMP        *irqmp = GRLIB_IRQMP(dev);
     IRQMPState   *state;
@@ -133,7 +131,7 @@ void grlib_irqmp_ack(DeviceState *dev, int intno)
 
     trace_grlib_irqmp_ack(intno);
 
-    grlib_irqmp_ack_mask(state, mask);
+    grlib_irqmp_ack_mask(state, cpu, mask);
 }
 
 static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
@@ -159,7 +157,6 @@ static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
             s->pending |= 1 << irq;
         }
         grlib_irqmp_check_irqs(s);
-
     }
 }
 
@@ -263,7 +260,9 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
 
     case CLEAR_OFFSET:
         value &= ~1; /* clean up the value */
-        grlib_irqmp_ack_mask(state, value);
+        for (i = 0; i < irqmp->ncpus; i++) {
+            grlib_irqmp_ack_mask(state, i, value);
+        }
         return;
 
     case MP_STATUS_OFFSET:
@@ -367,7 +366,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
      */
     qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
                              IRQMP_MAX_CPU);
-    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
+    qdev_init_gpio_out_named(dev, irqmp->irq, "grlib-irq", irqmp->ncpus);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index bc6a85be9c..3f86b74ba4 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -169,7 +169,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    grlib_irqmp_ack(env->irq_manager, intno);
+    /* No SMP support yet, only CPU #0 available so far.  */
+    grlib_irqmp_ack(env->irq_manager, 0, intno);
 }
 
 /*
-- 
2.41.0


