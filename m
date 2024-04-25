Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CFEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWZ-00025S-Sx; Thu, 25 Apr 2024 06:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWV-00022O-TE
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWS-0007D6-Fx
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34b64b7728cso704482f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041611; x=1714646411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HzNnGVxNUANHnRTDrHNeQGZ2Bf5NCH/o+ElhlaY0jvE=;
 b=X7YD3+CqbVef9fC3374VB/Rx3QdmIrJbW1nNw38cHI154CKJCSAMI/44d77MoUZSsI
 fDdlpuaq7iTkVQTRS0RMWc7rzC4VrK9Hq6vt5TiEO8b2uP1cWArEoAVTMW6WJb++Oh0u
 arNIfNQsC8psoUndiqS5Yb4hHQsKUkgmHdKwAKT7ffL7mpOcGOhdcsYeQXnLv7RK51Qg
 4bnjo1sr7h1Gc8vpmPuuFYfGKGq726QfWrrGmzBih1v8hgzsI4gyZ1aR4EYuGf68XcIv
 U3jGhj101KbVuI/0511iGAs8ASU24IZ5z8XE26bE9tJkYGKQnHSctfHx58ZDou8inaoa
 WzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041611; x=1714646411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzNnGVxNUANHnRTDrHNeQGZ2Bf5NCH/o+ElhlaY0jvE=;
 b=D2D/WGua2xLaiZuxOR34CPZjRvPYExKcl1kpnQ1J1lLWsFOOAA9GJ/CAz/ny5SlI1k
 NsGadIf9EBqIPkTGuPaxZUGgvK3gNc4h5rdnwLDRLOALgGRUD+jlkpveP6WNoQA/l0gq
 /hbd+GKQ1Pqz+N0MTvdwYSlKXr9xNYWoiftLbRI0ppYJkt1j5TIt7qEQ9m2ApHcweaHI
 EdbWOGMyUf4VdV7nlaO1s+7ORRF1Ou3ktVwBIxrc7mtJcq/bkIwDKQwB85vfQkhnSV8Y
 AXT4gKMQPyke59pG3Da9KnxGgqq6ACXdpvW8un9xseSCccfzn+wm9Z1T0jiyG9ekGJGG
 9qtA==
X-Gm-Message-State: AOJu0YwCq22PXlYsEWxD7XJcUfArbA5tt4TNRC+PWTbmbCE5sXasGkZm
 9tYlZVeGtnrm9QTLhlE44yfi527n7XKuHawNzPB7nJRJyR9A17/w54bz0FX60QSnbpnWDM1SI+J
 2
X-Google-Smtp-Source: AGHT+IEGJV7UKxEtu29OHIA5wLqftBJSybiXFExMUydWnPyMqds8cdVkMeavcAzP9D5E7grrBQLW5A==
X-Received: by 2002:adf:f384:0:b0:34a:e6aa:bc01 with SMTP id
 m4-20020adff384000000b0034ae6aabc01mr3990814wro.5.1714041611185; 
 Thu, 25 Apr 2024 03:40:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/37] hw/intc/arm_gicv3: Report the NMI interrupt in
 gicv3_cpuif_update()
Date: Thu, 25 Apr 2024 11:39:42 +0100
Message-Id: <20240425103958.3237225-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

In CPU Interface, if the IRQ has the non-maskable property, report NMI to
the corresponding PE.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-22-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index b1f6c16ffef..2cf232d099c 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1038,6 +1038,7 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     /* Tell the CPU about its highest priority pending interrupt */
     int irqlevel = 0;
     int fiqlevel = 0;
+    int nmilevel = 0;
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
@@ -1076,6 +1077,8 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
 
         if (isfiq) {
             fiqlevel = 1;
+        } else if (cs->hppi.nmi) {
+            nmilevel = 1;
         } else {
             irqlevel = 1;
         }
@@ -1085,6 +1088,7 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
 
     qemu_set_irq(cs->parent_fiq, fiqlevel);
     qemu_set_irq(cs->parent_irq, irqlevel);
+    qemu_set_irq(cs->parent_nmi, nmilevel);
 }
 
 static uint64_t icc_pmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
-- 
2.34.1


