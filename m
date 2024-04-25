Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F27C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWT-00021N-QW; Thu, 25 Apr 2024 06:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWP-0001zZ-RE
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWN-0007Af-G0
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b5e74f7d1so1547975e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041606; x=1714646406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W1vuqdUJDiebxiqtPqaJPfGS9dPS4E9rgVyHYzZb3+c=;
 b=p8grnZL1z3qbL89vrf5wkWOCirFMBQrxvEiCmeb4uenZSyJU1/SuJoEWAvzgP1Q2FM
 XNPsgAcHEnGXhKSZItRfAsrg9bgIviaBIhNqqz4WDVl8Stk5S5LBmrq/wW4Z2oI/XVLn
 bqVSl3DF1knP3pm1XR4GN4l5zyOIWDlzFv/xLJSiXWzq4kg2mXbrksr1/a1iIhsKRGJO
 /TN+v6mRODPqDgHpTDrlSK5KoehleuVFXfBeU/R4z9e04m8vXEItRQaueZZY5xfsqeym
 7eq7RJRQwPY7RBp1MoNKuqSPhRHI4ugRv1yVay3bLBOHIIFMBSCFwnFFBpY+0acz8YXQ
 RgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041606; x=1714646406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1vuqdUJDiebxiqtPqaJPfGS9dPS4E9rgVyHYzZb3+c=;
 b=cbtghypzAj847iwI0M8sfGQNTfhzh0UFzl3pbXGypuVxfQcKxuZGO2aejSYVAiVHhU
 a8RLPUMEAi3Y4LEmC0zjaEuyBinSl2/StzDuYBMoBQ4lDYrmdv45dbEZtb6pH8R8a/za
 WEX7AldeKuJ8GcrzgTCVAdJoKYp1ZOBcKIgEar1wq8/Ka3A4ZRQZn0mXFsMBU0gwdc3R
 T0eUPCgbDmWlGe3MfoiIHkjrVCV2nhhRuan9FgEVhbGI1efT+CP38ONhbPzw91DsAcVO
 MSnsAtNC8U3gCExb4CgL5fIrB1fSW8W3Re5fDhVj17ho9vs0jmzjLGYRYMXEb6QZ8bPw
 zbAQ==
X-Gm-Message-State: AOJu0YyGi9VSK+kYo21BmC3eCarmZ4DFi2L1TtmFJSQ9fuXTYa1VTWG8
 IBLFTRp1M21sAiuQlkyWyhrFc0SpcFEr+HsQeJHuKghsDPqumXOWKtb2jEN6d2vMWjMjiu90GQb
 n
X-Google-Smtp-Source: AGHT+IFILE5l75VqWQQrB+py+3SebJkG83ywHExDMjZ9HLxI4QlpyCrmH1HVNcFqYSphd26gBeCUEg==
X-Received: by 2002:a05:600c:35d4:b0:418:f184:53f8 with SMTP id
 r20-20020a05600c35d400b00418f18453f8mr4732350wmq.36.1714041605985; 
 Thu, 25 Apr 2024 03:40:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/37] hw/intc/arm_gicv3: Add external IRQ lines for NMI
Date: Thu, 25 Apr 2024 11:39:31 +0100
Message-Id: <20240425103958.3237225-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Augment the GICv3's QOM device interface by adding one
new set of sysbus IRQ line, to signal NMI to each CPU.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-11-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gic_common.h   | 2 ++
 include/hw/intc/arm_gicv3_common.h | 2 ++
 hw/intc/arm_gicv3_common.c         | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index 70803750081..97fea4102d3 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -71,6 +71,8 @@ struct GICState {
     qemu_irq parent_fiq[GIC_NCPU];
     qemu_irq parent_virq[GIC_NCPU];
     qemu_irq parent_vfiq[GIC_NCPU];
+    qemu_irq parent_nmi[GIC_NCPU];
+    qemu_irq parent_vnmi[GIC_NCPU];
     qemu_irq maintenance_irq[GIC_NCPU];
 
     /* GICD_CTLR; for a GIC with the security extensions the NS banked version
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 4e2fb518e72..7324c7d983f 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -155,6 +155,8 @@ struct GICv3CPUState {
     qemu_irq parent_fiq;
     qemu_irq parent_virq;
     qemu_irq parent_vfiq;
+    qemu_irq parent_nmi;
+    qemu_irq parent_vnmi;
 
     /* Redistributor */
     uint32_t level;                  /* Current IRQ level */
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index cb55c726810..c52f060026a 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -299,6 +299,12 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
     for (i = 0; i < s->num_cpu; i++) {
         sysbus_init_irq(sbd, &s->cpu[i].parent_vfiq);
     }
+    for (i = 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->cpu[i].parent_nmi);
+    }
+    for (i = 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->cpu[i].parent_vnmi);
+    }
 
     memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
                           "gicv3_dist", 0x10000);
-- 
2.34.1


