Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EABE103E164
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oQm-0003af-5B; Wed, 18 Mar 2026 06:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQf-0003XL-K4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQd-0003MM-UH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-485392de558so4551335e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773830826; x=1774435626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYIBQykwSMkrGv+gyaXLV2ztInHFjx95YsKunyyWQjg=;
 b=QMasZ/JUhNsInjOGW9rjgaH9HfWIlDuLw2g+2x1fOGfDxrHjl6x1nh4Ify9CGVKQ43
 3wdhW7l3mVW9CZR9LDjANc6az0fg8t92gu+b3DrqYmWvJyMonbpbfynsVFFsQM8+oy4M
 dkmDoUQgdK6gqfJEIeuErMvgnTb2KVfdzXUvVkOPkHA0dSC8X6GpYgGD9Bw9Tvxckvrg
 xMXnqyPggdyZ1hMOxmEjqajv6kVD0X0fXPJs5qOz0ZxXcJwan7yp5ZzUwn3OWW36hqs+
 CBtLvoRV/6p7khQZhcuxz7sYBbzybSXyX0/JoMQIlnDn/eKlp7iFyHA1V6Q4bwujNcd0
 /8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830826; x=1774435626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cYIBQykwSMkrGv+gyaXLV2ztInHFjx95YsKunyyWQjg=;
 b=HARC4SCHLByb5770TosFzBRvbSOXHgLqXXHkIFs22u5FO4uF/AcaPXjjx+ZPIWAgTd
 8Gk0CyES5r7aYIxP606K3AnpC1wEU+rX5rH/nlRLKXLK/LPs29wV07SZ9bqjGHipfml3
 cFfjkOneV9aJ6XOiCt1zC3wgIFThXfbHYPyWKRXiGPolJ91UT7kCkposiwYJ7lYtvWgV
 gs1WleHejjulklRmJ7njqdTwbqlz4AIAa5qYQLsayeqA2gqedKXkdk/VHK2Q5sWQoDh4
 QzaKMF0bjvsh/nsrvIKeBJmZ5kRQZUCnD5QDlAjprBxlOfj7I8WWzqQAJJIYgf5/qQ7X
 L4yA==
X-Gm-Message-State: AOJu0YyT3+t6l+1fVrjx4GTUm42Zgopdn0NUX6RnnYF6tWadJhpEwJ63
 PgdlO1iFrM4lUyVgPKR6wKkRJI/zDGev6NRGBmm7f7wNtZgyexj5+IPVOpWpNpK0
X-Gm-Gg: ATEYQzxT3bnh1a7F3VVbHBct2myVAhBZ5jiSoXS9r1vqx+cRVO/Q2wGTW9jx73psQES
 2WapSssvb277F6YID1ynGQhgCSzMYYgyHJgk3MMQ+lzn7b/kLNGMz8Zez/yFwGM84+SVB1qkENh
 6jFM/vJxV3bDN5AofF5dHX4jMw4PDBYXxhMl3Sw1KXkZNh/2vuL1G4dOXzJ4q8d0AGQ0j06TmPH
 x1Gocv4aMzyn88xaPJ1xlCqMQrbhIrBigDBAHS5mFU+TbCQDJjKcUyM18bxL+xbL6w/U2Dt2ynu
 h7/dfAyxGZmsFVKC/pj0znmTrfQ9q9pxeh4BucM6puZtlK7L8gp+4YaONscgLCswg6+mvZ8a/b5
 2dhQ5oGsEdMg+NWY2Og+XImJpYar7kjiEqsLiutdO0a0nH35qghSCNZWEPx7p1hCRudCVjGVwqo
 No3P/bI1uwUcgGn6xvKl75QpMXv3HzZg97HBtNOqxy7nUUi+ySYiCqX3ng0dALaNXMTq86H1O+k
 tl2
X-Received: by 2002:a05:600c:4e42:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-486f446359emr43098145e9.29.1773830826003; 
 Wed, 18 Mar 2026 03:47:06 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-80-194.adsl.net.t-com.hr.
 [93.143.80.194]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-486f420de8asm56471095e9.3.2026.03.18.03.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:47:05 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 pierrick.bouvier@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Subject: [RFC PATCH 6/9] hw/intc/arm_gic: Register primary GIC for plugin IRQ
 injection
Date: Wed, 18 Mar 2026 11:46:37 +0100
Message-ID: <20260318104640.239752-7-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318104640.239752-1-ruslichenko.r@gmail.com>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x330.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Call plugin_register_primary_intc() at the end of the realization
of both ARM GICv2 and GICv3.

This links the system's primary interrupt controllers ot the
plugins subsystem, so that plugins can inject hardware irqs
using generic qemu_plugin_set_irq() API.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/intc/arm_gic.c   | 28 ++++++++++++++++++++++++++++
 hw/intc/arm_gicv3.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4d4b79e6f3..aef39b3ef7 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -29,6 +29,8 @@
 #include "trace.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
+#include "qemu/plugin.h"
+
 
 /* #define DEBUG_GIC */
 
@@ -2096,6 +2098,31 @@ static const MemoryRegionOps gic_viface_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static void gic_plugin_irq_inject(void *opaque, int irq, int cpu, bool pulse)
+{
+    DeviceState *dev = opaque;
+    GICState *s = ARM_GIC(dev);
+
+    qemu_irq gic_irq;
+
+    if (irq >= GIC_INTERNAL) {
+        assert(irq < s->num_irq);
+
+        gic_irq = qdev_get_gpio_in(dev, irq - GIC_INTERNAL);
+    } else {
+        assert(cpu < s->num_cpu);
+
+        uint32_t offset = s->num_irq - GIC_INTERNAL + (cpu * GIC_INTERNAL) + irq;
+        gic_irq = qdev_get_gpio_in(dev, offset);
+    }
+
+    if (pulse) {
+        qemu_irq_pulse(gic_irq);
+    } else {
+        qemu_irq_raise(gic_irq);
+    }
+}
+
 static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
     /* Device instance realize function for the GIC sysbus device */
@@ -2160,6 +2187,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    plugin_register_intc(dev, gic_plugin_irq_inject);
 }
 
 static void arm_gic_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 542f81ea49..1bae8c9f17 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -20,6 +20,8 @@
 #include "qemu/module.h"
 #include "hw/intc/arm_gicv3.h"
 #include "gicv3_internal.h"
+#include "hw/core/irq.h"
+#include "qemu/plugin.h"
 
 static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio, bool nmi)
 {
@@ -434,6 +436,31 @@ static const MemoryRegionOps gic_ops[] = {
     }
 };
 
+static void gicv3_plugin_irq_inject(void *opaque, int irq, int cpu, bool pulse)
+{
+    DeviceState *dev = opaque;
+    GICv3State *s = ARM_GICV3(dev);
+
+    qemu_irq gic_irq;
+
+    if (irq >= GIC_INTERNAL) {
+        assert(irq < s->num_irq);
+
+        gic_irq = qdev_get_gpio_in(dev, irq - GIC_INTERNAL);
+    } else {
+        assert(cpu < s->num_cpu);
+
+        uint32_t offset = s->num_irq - GIC_INTERNAL + (cpu * GIC_INTERNAL) + irq;
+        gic_irq = qdev_get_gpio_in(dev, offset);
+    }
+
+    if (pulse) {
+        qemu_irq_pulse(gic_irq);
+    } else {
+        qemu_irq_raise(gic_irq);
+    }
+}
+
 static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
     /* Device instance realize function for the GIC sysbus device */
@@ -450,6 +477,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
     gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
 
     gicv3_init_cpuif(s);
+    plugin_register_intc(dev, gicv3_plugin_irq_inject);
 }
 
 static void arm_gicv3_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


