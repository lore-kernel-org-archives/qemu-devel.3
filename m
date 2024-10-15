Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03218CFC288
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewW-0006ee-AR; Tue, 15 Oct 2024 06:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewU-0006d5-6N
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewS-0005w9-AG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43140a2f7f7so4048685e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988695; x=1729593495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2oogUcyfz+E85mumq1xXQjOwEjwwahsOY55NASPbeB4=;
 b=a1hHL5TqM8PacI/37G3FwaUufNruEojCg8yeb2l9+GXvx4k4z2m2dXrlrJz0+yE2K0
 Bl10O1xTOo6maiLOh097TAbMewj1/r4yYhJKGJmCEFJP2ZKbGw8ZzoALFOGnoc7Be8Oi
 DVH9GeA/K4TZOORSzRI2R8I6kYpPJfHNvCM1waiJL9Q0I8DfYVtq1GhZ472OOzefizms
 eMXRgPw5UuHPgpcAcT5k+k+ThpslFgjGc89LjxTtTplAATwahB387+AymOuxbAGayPBe
 q53Fp0foXF79IHBsRPoA+X7dKutuVqoZEMiVkTRcsGIfn3S6xQ7lZSHKMsOnK344aJfO
 DQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988695; x=1729593495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oogUcyfz+E85mumq1xXQjOwEjwwahsOY55NASPbeB4=;
 b=VarsGzSa27OckbDwLEkd0W9zUpWVCmN0ZOksocJvqLggdjLpsHQsx7kNic+v10Crea
 T1G9RsSS+W5XnXEzF0iHViCqpxfvsje6J7rNptxHpwfzlaM+Cn3VCZsN+0UX0IgBlL13
 NDmIWGpk7oX99kPkMcqtDAFqovTdutZgovVuSCANugu4KMARNIaW1BsTy34JJ7O17SX3
 hR9LgHEcpPfGsbH/r6m1kddG32pS2uE/IJXWXQBNEomkZJVPzKbweCeo3HFhIAKF/Zw9
 i1oontXAz4LxJcCUcKY1oy8YbSqIK1NHBACKX+nR6y11XuJ0BbAHTPqEgtOC5Xuj5oa6
 OXtw==
X-Gm-Message-State: AOJu0Yy1orSHK+aU91kXXi+KGXHY17HXZyWsBlrwMdVr7i1J5ZtLRmQv
 s/b+kezWk+ZINSMvsISYHOfJv3N1wCkq80ay7BNXx+x/Hx8pfiPqCiCs55flosNdQb0FizMPfUT
 U
X-Google-Smtp-Source: AGHT+IHCmRjr0UCrdolkaLluQWZz7RsNELY+g+DbI8uGVBRjYAXvt61EF/4mpPKFv15KhLuOXO2nig==
X-Received: by 2002:a5d:570b:0:b0:37d:51f8:46fd with SMTP id
 ffacd0b85a97d-37d5520571dmr9529677f8f.22.1728988693087; 
 Tue, 15 Oct 2024 03:38:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/28] hw/misc: Create STM32L4x5 SYSCFG clock
Date: Tue, 15 Oct 2024 11:37:47 +0100
Message-Id: <20241015103808.133024-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

This commit creates a clock in STM32L4x5 SYSCFG and wires it up to the
corresponding clock from STM32L4x5 RCC.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Message-id: 20241003081105.40836-2-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/stm32l4x5_syscfg.h |  1 +
 hw/arm/stm32l4x5_soc.c             |  2 ++
 hw/misc/stm32l4x5_syscfg.c         | 19 +++++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4x5_syscfg.h
index 23bb5641507..c450df2b9ea 100644
--- a/include/hw/misc/stm32l4x5_syscfg.h
+++ b/include/hw/misc/stm32l4x5_syscfg.h
@@ -48,6 +48,7 @@ struct Stm32l4x5SyscfgState {
     uint32_t swpr2;
 
     qemu_irq gpio_out[GPIO_NUM_PINS];
+    Clock *clk;
 };
 
 #endif
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index fac83d349c8..16e3505dcb8 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -236,6 +236,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* System configuration controller */
     busdev = SYS_BUS_DEVICE(&s->syscfg);
+    qdev_connect_clock_in(DEVICE(&s->syscfg), "clk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "syscfg-out"));
     if (!sysbus_realize(busdev, errp)) {
         return;
     }
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index a5a1ce26804..a947a9e036b 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -26,6 +26,9 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "qapi/error.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 
@@ -225,12 +228,22 @@ static void stm32l4x5_syscfg_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), stm32l4x5_syscfg_set_irq,
                       GPIO_NUM_PINS * NUM_GPIOS);
     qdev_init_gpio_out(DEVICE(obj), s->gpio_out, GPIO_NUM_PINS);
+    s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
+}
+
+static void stm32l4x5_syscfg_realize(DeviceState *dev, Error **errp)
+{
+    Stm32l4x5SyscfgState *s = STM32L4X5_SYSCFG(dev);
+    if (!clock_has_source(s->clk)) {
+        error_setg(errp, "SYSCFG: clk input must be connected");
+        return;
+    }
 }
 
 static const VMStateDescription vmstate_stm32l4x5_syscfg = {
     .name = TYPE_STM32L4X5_SYSCFG,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(memrmp, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(cfgr1, Stm32l4x5SyscfgState),
@@ -241,6 +254,7 @@ static const VMStateDescription vmstate_stm32l4x5_syscfg = {
         VMSTATE_UINT32(swpr, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(skr, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(swpr2, Stm32l4x5SyscfgState),
+        VMSTATE_CLOCK(clk, Stm32l4x5SyscfgState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -251,6 +265,7 @@ static void stm32l4x5_syscfg_class_init(ObjectClass *klass, void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_stm32l4x5_syscfg;
+    dc->realize = stm32l4x5_syscfg_realize;
     rc->phases.hold = stm32l4x5_syscfg_hold_reset;
 }
 
-- 
2.34.1


