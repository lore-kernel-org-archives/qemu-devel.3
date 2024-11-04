Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FFBD132A8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7u7L-0000ig-08; Mon, 04 Nov 2024 05:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u7D-0000hB-0j
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u7A-0006X4-Gz
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730715315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTHb1e+iHwXlenyiLDCCN2TDzp/q1TON6QHXNe/VOQY=;
 b=PwNcGeruN71so3+Z1Y8C2ljK8MReoBvReaFr+5qGXedSFu3B4VsteWxzt2a48VY9ppmKgm
 spOut8/Y6mLre8CWAgtnDH/yitLX/SXLq8neJ80Dpdq68+OTESvSMT5bQwZU7XrA7eVAHl
 HjsT1QAVXTzbqgSHFOlLcy4W3EcTw9I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-y64yqqUOO8OmgefVtIWuIw-1; Mon,
 04 Nov 2024 05:15:14 -0500
X-MC-Unique: y64yqqUOO8OmgefVtIWuIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25482193587B; Mon,  4 Nov 2024 10:15:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.67])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B66941956052; Mon,  4 Nov 2024 10:15:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/10] hw/arm/aspeed_ast27x0: Use bsa.h for PPI definitions
Date: Mon,  4 Nov 2024 11:14:54 +0100
Message-ID: <20241104101501.2487001-4-clg@redhat.com>
In-Reply-To: <20241104101501.2487001-1-clg@redhat.com>
References: <20241104101501.2487001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index dca660eb6be2..5638a7a5781b 100644
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
2.47.0


