Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40408C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JS-0007FW-5K; Thu, 20 Feb 2025 11:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JQ-0007F2-VT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JP-0008Ge-2F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso11632725e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068526; x=1740673326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TvzLhy1cCVoLs5UL4NDUaH3PLHgGFRSysvG/yfdXyIw=;
 b=Q4dUBzSc0jQ0EHfIOMshEK/0qNqo9uGwX/2mFGymMSHeeA8f3IJm3UTZGZFVNAjbOb
 BwGozjEChQZt1iWQAeP4mXtQSOS9browbSvSP0YYBYOQfQswGu/3Vlm7lFaSAYIb3Y/M
 BzJsI6XehkQ3Y46zlhCCtvzXLsqDcaBT1vRn0lU1x0puxZrWM5a0fBhNRfyoQNPfPypw
 DkhIOdIXV4QE88YMWAXN4gAP3R1HvP9V7Pqk1oK+PHsAxef/U6twKjKgw/T8vSyEdSEO
 ejN0fgzv1/z37IRX0XVoUFqVeKL8Yt3AiDjbDaIVXtwv9b2z8IoxE8gacCmITuuCGX0Z
 /AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068526; x=1740673326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvzLhy1cCVoLs5UL4NDUaH3PLHgGFRSysvG/yfdXyIw=;
 b=NXisXU7XQuHBSu7kBsDe1G0/X2C0xmpfuyuhORYKmbDVwmUHe1xVZvDYaIbLFkme9j
 P3nq5CeT5UTJvanDp8uQ/cg/49G2CYbD8UxncJ0xjK4J5rpqg8TPQWoYksTIV/4vB0d6
 MglwinZhnuBXGcxdWfiqyQNHyX9/gYbREyHE01QJmVSXYEIiNTMXegdzFubVaFpjcj1B
 pGaQvSgJcMItn5Rt0Hf8M8eh0HhsENxSYLTfQdUli+XTMcQSCUsdzn8FgLFGNCSe6ml3
 QP04DAJtskIDhvgLiYoGxWMxBw/0qLEGD6612jAFWHodOiq9ZwaztAvxCNganqHigB3x
 DXXA==
X-Gm-Message-State: AOJu0Yx3E169dAGZahVb1hB3PQeMZ8lHr9hG79BaMTYZ74wavoQ28fOq
 g6FvSWM4oNTFH2uURlTbYNq8MqEJuKr0A5IJ/kYi8Tdv61GpcVGz6PgQXeoQrhEbfomGh4fgDoo
 H
X-Gm-Gg: ASbGncuYdRRweJeQ0mDNIpLsXa/Fm0hUUe5+ei4nvu4SZ8+2EUoOSX3Kxoy8YmLsWPP
 Gyu5nrIXNZpO3o3+3mhHLbzMEDp+EyyYQ3BzzyWfP1w6PEa/KGa6mv91976T97Q3Qa7u/b/7uG6
 oEcrJFMJ6YQhmDvAyRKTFoS8lZw0YCzfTfhpJ3cWrXK+UfbbbiJrntJE2NGWsflzK3QPzVnefiE
 7KxYb/Lo/+M6gWbYbjJh37P9VUOUPVzTn67rrkSOMcV1GJehdevDL/hO3DH3szD8Seb88ULk878
 3a41Dnkk18MqAIOiQK4hHQ==
X-Google-Smtp-Source: AGHT+IH285lL50bxNt5Yke8UF+3LHtqXTF5C9BkUMJN0Tnhi/7Ta6SqadNND2CJLsGar/489VlHBxA==
X-Received: by 2002:a5d:525a:0:b0:38f:3245:21fc with SMTP id
 ffacd0b85a97d-38f33f56512mr17214411f8f.50.1740068525549; 
 Thu, 20 Feb 2025 08:22:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/41] hw/misc: Store DRAM size in NPCM8XX GCR Module
Date: Thu, 20 Feb 2025 16:21:13 +0000
Message-ID: <20250220162123.626941-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Hao Wu <wuhaotsh@google.com>

NPCM8XX boot block stores the DRAM size in SCRPAD_B register in GCR
module. Since we don't simulate a detailed memory controller, we
need to store this information directly similar to the NPCM7XX's
INCTR3 register.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-9-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/npcm_gcr.h |  1 +
 hw/misc/npcm_gcr.c         | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 9ac76ca9abb..d81bb9afb26 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -68,6 +68,7 @@ typedef struct NPCMGCRState {
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
+    uint32_t reset_scrpad_b;
 } NPCMGCRState;
 
 typedef struct NPCMGCRClass {
diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index ac22fb08cb2..9e4a6aee611 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -280,6 +280,19 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
 }
 
+static void npcm8xx_gcr_enter_reset(Object *obj, ResetType type)
+{
+    NPCMGCRState *s = NPCM_GCR(obj);
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
+
+    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));
+    /* These 3 registers are at the same location in both 7xx and 8xx. */
+    s->regs[NPCM8XX_GCR_PWRON] = s->reset_pwron;
+    s->regs[NPCM8XX_GCR_MDLR] = s->reset_mdlr;
+    s->regs[NPCM8XX_GCR_INTCR3] = s->reset_intcr3;
+    s->regs[NPCM8XX_GCR_SCRPAD_B] = s->reset_scrpad_b;
+}
+
 static void npcm_gcr_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
@@ -323,6 +336,14 @@ static void npcm_gcr_realize(DeviceState *dev, Error **errp)
      * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
      */
     s->reset_intcr3 |= ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) << 8;
+
+    /*
+     * The boot block starting from 0.0.6 for NPCM8xx SoCs stores the DRAM size
+     * in the SCRPAD2 registers. We need to set this field correctly since
+     * the initialization is skipped as we mentioned above.
+     * https://github.com/Nuvoton-Israel/u-boot/blob/npcm8mnx-v2019.01_tmp/board/nuvoton/arbel/arbel.c#L737
+     */
+    s->reset_scrpad_b = dram_size;
 }
 
 static void npcm_gcr_init(Object *obj)
@@ -370,16 +391,19 @@ static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
 
     c->nr_regs = NPCM7XX_GCR_NR_REGS;
     c->cold_reset_values = npcm7xx_cold_reset_values;
+    rc->phases.enter = npcm7xx_gcr_enter_reset;
 }
 
 static void npcm8xx_gcr_class_init(ObjectClass *klass, void *data)
 {
     NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "NPCM8xx System Global Control Registers";
     c->nr_regs = NPCM8XX_GCR_NR_REGS;
     c->cold_reset_values = npcm8xx_cold_reset_values;
+    rc->phases.enter = npcm8xx_gcr_enter_reset;
 }
 
 static const TypeInfo npcm_gcr_info[] = {
-- 
2.43.0


