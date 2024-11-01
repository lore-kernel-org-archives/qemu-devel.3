Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7BCE6F06C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 16:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6uFO-0004IW-EP; Fri, 01 Nov 2024 12:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6uFG-0004GU-Q5
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:11:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6uFF-0008Ga-1Z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:11:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so1217692f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730477487; x=1731082287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fhSn5hEytgSspXIQ7EOuLQkNlvmpGv4ycpV45iM8Ao=;
 b=lumKceIHT6DbeCQehzEJizt2F3fG/mdecACmkJuJcUpf0USWdDBgJBKP4+DSDl8ett
 3x0MEnLrLSdD6ozEnKIM7Dby6JxuR0GNAhlJNyk2LZi02Nto4or3CpP58iYMlfiONH/Q
 T4WOO60v6cntM+9WtCAyi6tKyxvxhlSlsKadiSAWG88i13WZSnw7DTnP+HQoDgXS8/Ok
 +TyB5T2dYMlFXfwsxH5bqSiuyZPwMTArlsrFP+B5xI+WJmuA48RmbODYu7PYQZkb/O8e
 82gvCwVJ23c+fyZ0D9ou7NTpiWQoSnPPFRRsZ0zox4B5LdO/eaCVB2pT0BujSYZBq1Zf
 SG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730477487; x=1731082287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fhSn5hEytgSspXIQ7EOuLQkNlvmpGv4ycpV45iM8Ao=;
 b=En5SDgTFAPhOPD0rF3fjh6p7VNL9H9rRP23qDM5/ufnmyei/oeeH5iMKoiatfXoYXq
 XFK56N4nH0Fj4pknP91zU1mGkYshHok6TO4TqL5RGpJgx/k+Ke2Nzw/jb0+FmGZRFE8R
 ufsA8InFSartennBYhtwyra8MYmHscA9EsZ2SU3zAD3Wmcx42tPdnZXfrhMr6rPkZHfE
 XfsRT4hpJiIKG68WeESZ6dF2j8THN7M05QI8HOQlUigGaMqbWcdyrAwahFdcSJa3VS7L
 HTFBQH00EBEZbxyxgcQtMnG6SysRblagYM5iwPU/4Gur25SO3Y2pmqkJ+9mv5nLFs020
 peKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNAHU0L1eFxkatAPSS3tP0Zn8LLzN4NW6WnCh8jGylvJjIHepXYVEWPkY6ILe1rk4UWFojB68yZxpF@nongnu.org
X-Gm-Message-State: AOJu0YzlJqhwVx8qHRaAtfqcp3mmhRApyKoiJ+KuXYDD/JZMtQaR3ezk
 cCNeJuRotK+g6t3qd+Un0Xc0f0as15z2jSdqSUPUzMfPInLGOpmtACkPMNljVcXluKkrj2dX/or
 q
X-Google-Smtp-Source: AGHT+IGGfv/uuKbiQIDHLQv+l+YnMjhlnX8JlvMC0pnT2XgPhH8w77lfVsGRgB1YA1k6pmsaktcwnA==
X-Received: by 2002:a05:6000:3c6:b0:37d:3650:fae5 with SMTP id
 ffacd0b85a97d-381c7ab60efmr4083705f8f.52.1730477487282; 
 Fri, 01 Nov 2024 09:11:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7f80sm5658313f8f.20.2024.11.01.09.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:11:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/2] hw/arm/aspeed_ast27x0: Use bsa.h for PPI definitions
Date: Fri,  1 Nov 2024 16:11:24 +0000
Message-Id: <20241101161125.1901394-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101161125.1901394-1-peter.maydell@linaro.org>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Use the private peripheral interrupt definitions from bsa.h instead
of defining them locally.

Note that bsa.h defines these values as INTID values, which are all
16 greater than the PPI values that we were previously using.  So we
refactor the code to use INTID-based values to match that.

This is the same thing we did in commit d40ab068c07d9 for sbsa-ref.
It removes the "same constant, different values" confusion where this
board code and bsa.h both define an ARCH_GIC_MAINT_IRQ, and allows us
to use symbolic names for the timer interrupt IDs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index dca660eb6be..5638a7a5781 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
+#include "hw/arm/bsa.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
@@ -416,28 +417,28 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < sc->num_cpus; i++) {
         DeviceState *cpudev = DEVICE(&a->cpu[i]);
-        int NUM_IRQS = 256, ARCH_GIC_MAINT_IRQ = 9, VIRTUAL_PMU_IRQ = 7;
-        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int NUM_IRQS = 256;
+        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
 
         const int timer_irq[] = {
-            [GTIMER_PHYS] = 14,
-            [GTIMER_VIRT] = 11,
-            [GTIMER_HYP]  = 10,
-            [GTIMER_SEC]  = 13,
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
         };
         int j;
 
         for (j = 0; j < ARRAY_SIZE(timer_irq); j++) {
             qdev_connect_gpio_out(cpudev, j,
-                    qdev_get_gpio_in(gicdev, ppibase + timer_irq[j]));
+                    qdev_get_gpio_in(gicdev, intidbase + timer_irq[j]));
         }
 
         qemu_irq irq = qdev_get_gpio_in(gicdev,
-                                        ppibase + ARCH_GIC_MAINT_IRQ);
+                                        intidbase + ARCH_GIC_MAINT_IRQ);
         qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
                                     0, irq);
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                qdev_get_gpio_in(gicdev, ppibase + VIRTUAL_PMU_IRQ));
+                qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
         sysbus_connect_irq(gicbusdev, i + sc->num_cpus,
-- 
2.34.1


