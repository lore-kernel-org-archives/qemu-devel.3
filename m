Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ACBC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZx-0002Uf-7p; Mon, 01 Jul 2024 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZI-0000wl-92
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:53 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZE-0005Uz-Cn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:52 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52cd717ec07so4066287e87.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850066; x=1720454866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XF99cI8EMXtHQdN2r/6udNjoGMUqreNEU/+MKGXXDD0=;
 b=HDcBAjceT7QOlkkAtv3vioO0BsUdkIB6V3BSWImhX5sNSyf2u5YkIp6Jj4Gz6FWjG8
 Bf8MQrgUx1VDNekXsEoMNY0TWw1zTc6XHCZfZ8sq2KMQ6mNcJEOE8fkhhG6RXyODllVK
 DWsJfHs0CvL8KDhsJQ6Be4ABtjEp1zISaJ9Q02tmxJpwl0rxwhvh1kfee9bUYBSs2Obg
 HtAXPTm0y1UvgGIjxbRXseXXjAxYtTq9p18lgV3Sr2xQ9g05GmT4iQEAsFyIlb/RlU8/
 Eal2yz3wBImy7DvfwitMljCQms2wctLgt0ic2uSSo9sznSjPPNraOgPixIXiTNm8afrV
 6p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850066; x=1720454866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XF99cI8EMXtHQdN2r/6udNjoGMUqreNEU/+MKGXXDD0=;
 b=gdw7bR6QmHbygVZmHdLw0Ux4WeTN/4v2o5AgA3su/EagUOYPP/XHbMTAyjF49F2h/N
 SE6Tm9SOjPeeKc0ltPwkreVLYX+eWc8izC/7Qg0/lqWFZ2AoEhkbk0h8bKg9MjUyc/iy
 hQqdCBblykpNIvYwDp4/HKxhp9+o7F7l2BZBAwW3HPJc3fVzxbq7yRWOy+8+lrjYHUIO
 iIHLSyS1qYkdKZoCWEB3HXpu03EwtVFn6ScPry5Ixpi8OxHg3bu2ZxIuyHRZNp8lxjj8
 ep41u8vC00WZmStUqVWFq0xj5drLXtZ/VjXsOcPdJcZexLzP0yrjv6qRwaylQ0bRTtwJ
 TQ2g==
X-Gm-Message-State: AOJu0Yy6MAt90lJTfbEXWU3wJufbMxPICSQP9Tm5JG4q5cxhOYIAKMpz
 Co5FDgYeIpmE0enOdetspaXZPzlpBQywkD3ysGu5aj4No3iTDzH22GB7hc13FCmuO5HshE7F5WG
 +2lU=
X-Google-Smtp-Source: AGHT+IHXTWJOtnXmoULvk3S4KH6gxBbh7JUWQuQXA+RAAUlQ45ONdVcN8rPuFwRpTzp3k8WsmtovuA==
X-Received: by 2002:a05:6512:3c9f:b0:52e:7a8c:35a0 with SMTP id
 2adb3069b0e04-52e82651c44mr5297140e87.7.1719850066523; 
 Mon, 01 Jul 2024 09:07:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/29] hw/misc: In STM32L4x5 EXTI,
 correct configurable interrupts
Date: Mon,  1 Jul 2024 17:07:28 +0100
Message-Id: <20240701160729.1910763-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

The implementation of configurable interrupts (interrupts supporting
edge selection) was incorrectly expecting alternating input levels :
this commits adds a new status field `irq_levels` to actually detect
edges.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240629110800.539969-2-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/stm32l4x5_exti.h |  2 ++
 hw/misc/stm32l4x5_exti.c         | 28 +++++++++++++---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5_exti.h
index be961d2f01f..55f763fa376 100644
--- a/include/hw/misc/stm32l4x5_exti.h
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -45,6 +45,8 @@ struct Stm32l4x5ExtiState {
     uint32_t swier[EXTI_NUM_REGISTER];
     uint32_t pr[EXTI_NUM_REGISTER];
 
+    /* used for edge detection */
+    uint32_t irq_levels[EXTI_NUM_REGISTER];
     qemu_irq irq[EXTI_NUM_INTERRUPT_OUT_LINES];
 };
 
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 495a0004ab4..6a2ec62d785 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -88,6 +88,7 @@ static void stm32l4x5_exti_reset_hold(Object *obj, ResetType type)
         s->ftsr[bank] = 0x00000000;
         s->swier[bank] = 0x00000000;
         s->pr[bank] = 0x00000000;
+        s->irq_levels[bank] = 0x00000000;
     }
 }
 
@@ -102,27 +103,23 @@ static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
     /* Shift the value to enable access in x2 registers. */
     irq %= EXTI_MAX_IRQ_PER_BANK;
 
+    if (level == extract32(s->irq_levels[bank], irq, 1)) {
+        /* No change in IRQ line state: do nothing */
+        return;
+    }
+    s->irq_levels[bank] = deposit32(s->irq_levels[bank], irq, 1, level);
+
     /* If the interrupt is masked, pr won't be raised */
     if (!extract32(s->imr[bank], irq, 1)) {
         return;
     }
 
-    if (((1 << irq) & s->rtsr[bank]) && level) {
-        /* Rising Edge */
-        s->pr[bank] |= 1 << irq;
-        qemu_irq_pulse(s->irq[oirq]);
-    } else if (((1 << irq) & s->ftsr[bank]) && !level) {
-        /* Falling Edge */
+    if ((level && extract32(s->rtsr[bank], irq, 1)) ||
+        (!level && extract32(s->ftsr[bank], irq, 1))) {
+
         s->pr[bank] |= 1 << irq;
         qemu_irq_pulse(s->irq[oirq]);
     }
-    /*
-     * In the following situations :
-     * - falling edge but rising trigger selected
-     * - rising edge but falling trigger selected
-     * - no trigger selected
-     * No action is required
-     */
 }
 
 static uint64_t stm32l4x5_exti_read(void *opaque, hwaddr addr,
@@ -255,8 +252,8 @@ static void stm32l4x5_exti_init(Object *obj)
 
 static const VMStateDescription vmstate_stm32l4x5_exti = {
     .name = TYPE_STM32L4X5_EXTI,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(imr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
         VMSTATE_UINT32_ARRAY(emr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
@@ -264,6 +261,7 @@ static const VMStateDescription vmstate_stm32l4x5_exti = {
         VMSTATE_UINT32_ARRAY(ftsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
         VMSTATE_UINT32_ARRAY(swier, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
         VMSTATE_UINT32_ARRAY(pr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(irq_levels, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.34.1


