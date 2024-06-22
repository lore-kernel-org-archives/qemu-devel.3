Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4254CC27C78
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWI-0007wz-14; Sat, 22 Jun 2024 08:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW7-0007kf-Qg
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW5-0000JJ-2D
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:50 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ec1620a956so32478871fa.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058007; x=1719662807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hDzCMQj4Kz45odIGKOYD91iUsefbCW1gBNGz5HSGeJo=;
 b=o1/Fd2+ePMxG9PQ8pXdfvYzxnpljP7Zdcv3WXJQFp61pRQHc6bjO+FdLgXjLAee8vI
 Zr+LSY0AfK+6+N4jxKamn2lySx8d8GhyXOgZkJF7BhaRI24DCXA+O9SzIhfxwOF6ckl6
 BXIdoxjPUDr4QbNQcKxJSdCsaF3Ej1LRoso1NPMh8mQYTO3oN4Yhed+M3945SQ31zrOe
 dRhPNMhcLG0qEUeRrNCFFfseCf37j4cIBiUzuU5tDpZmQYrzXej5YnovamYqgxSMb2fB
 F4CB74QqO1s3ezUx28s39G0bVaQ/k9yvF/GSXWEd0aHIDgm7fGdkP7M9WX4Mi8MN1TUe
 6cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058007; x=1719662807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDzCMQj4Kz45odIGKOYD91iUsefbCW1gBNGz5HSGeJo=;
 b=hwJGVqczXLOm566Kekbg3Sm6W+NuSDSPYtvLcOJyTN55ZdufL+im9G0AYaBPnMmvyw
 AakTQ8uLlDPLrY8BKnB1V8VC9Vinm/LhpbdADqNw3GSdlsL3Ok4FKEpDszkgVrjokTGU
 f0sBfuZs16DzL/D93CpXVW+yKbu+EPnY65gZnfX42QFgeQPFvgTrf8ecsenAeSvxFyQE
 n/Kbmd+bEbWT78Oh2PIRL400Gc4BZksv6F5pDdjsf/1QHd2L1022df+xa1pxWpvvXs0l
 LtY8hSfJKdINm1iktkw2yFi1aD1a+3jeUA1L14f0Afe0C111uFd+L2Kr3n8tpPz3dKNZ
 oDXA==
X-Gm-Message-State: AOJu0Yybn6PYDoD4b70FMX1hVHjudEu9JyJ5I2wpr1Pz+J67AiLigsqE
 +oHjr7wzZPUaIuPhHYG3+B7yXtcMZXiOC0IWYoL+xUKY/HPlyQEYngdtncjDNhn+HsckxMTY7WJ
 OZo0=
X-Google-Smtp-Source: AGHT+IGNz/KFpBvKqbrAkBmqoQ+0XXSx1w+LGM0VVE4sbpTArZZm30yV8uQCXzgXUG6vzGCqAlquRg==
X-Received: by 2002:a05:6512:3441:b0:52c:dc70:ebf8 with SMTP id
 2adb3069b0e04-52cdc70ef1emr1281076e87.19.1719058006742; 
 Sat, 22 Jun 2024 05:06:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] hw/intc/arm_gic: Fix deactivation of SPI lines
Date: Sat, 22 Jun 2024 13:06:28 +0100
Message-Id: <20240622120643.3797539-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Julien reported that he has seen strange behaviour when running
Xen on QEMU using GICv2. When Xen migrates a guest's vCPU from
one pCPU to another while the vCPU is handling an interrupt, the
guest is unable to properly deactivate interrupts.

Looking at it a little closer, our GICv2 model treats
deactivation of SPI lines as if they were PPI's, i.e banked per
CPU core. The state for active interrupts should only be banked
for PPI lines, not for SPI lines.

Make deactivation of SPI lines unbanked, similar to how we
handle writes to GICD_ICACTIVER.

Reported-by: Julien Grall <julien@xen.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20240605143044.2029444-2-edgar.iglesias@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gic_internal.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index 8d29b40ca10..8ddbf554c69 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -280,6 +280,8 @@ static inline void gic_set_active(GICState *s, int irq, int cpu)
 
 static inline void gic_clear_active(GICState *s, int irq, int cpu)
 {
+    unsigned int cm;
+
     if (gic_is_vcpu(cpu)) {
         uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
         GICH_LR_CLEAR_ACTIVE(*entry);
@@ -301,11 +303,13 @@ static inline void gic_clear_active(GICState *s, int irq, int cpu)
              * the GIC is secure.
              */
             if (!s->security_extn || GIC_DIST_TEST_GROUP(phys_irq, 1 << rcpu)) {
-                GIC_DIST_CLEAR_ACTIVE(phys_irq, 1 << rcpu);
+                cm = phys_irq < GIC_INTERNAL ? 1 << rcpu : ALL_CPU_MASK;
+                GIC_DIST_CLEAR_ACTIVE(phys_irq, cm);
             }
         }
     } else {
-        GIC_DIST_CLEAR_ACTIVE(irq, 1 << cpu);
+        cm = irq < GIC_INTERNAL ? 1 << cpu : ALL_CPU_MASK;
+        GIC_DIST_CLEAR_ACTIVE(irq, cm);
     }
 }
 
-- 
2.34.1


