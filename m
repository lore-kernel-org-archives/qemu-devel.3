Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB3ACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoQ-0002SX-Ib; Tue, 12 May 2026 16:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoD-0002Ns-W7
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMto8-0002MW-1y
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ba840146so53817475e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618061; x=1779222861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zpCSnTZDy0cXLQEkLxVTYXKV5hdeLG4LMCu3JIo7jKo=;
 b=fCi8qTsDK4l53mtZy+aR/88SQCY0AeUVI/aKpkmYFQi0z+4byPA1Z2QsSYhzIgYXTQ
 LWFqNavFp6kWcWelwajsUiO/L01JbOj4UPEElrUaVU0iljG/l/2olctuBsez9HusLvtV
 Z4vBSBHKF76kdk8JOQZEX83YoDThb4bEOgBj6Kb8kiaAnZtBVlZh8sPXnnQGbEE4aAVU
 UNevaPhfiVhwrnmUbcBPaeq3maWyCNjvyim5xHqCnfuV5jr6QicKcWBDSLmF+rnykmMc
 ivP0Vmwa6nTrzicTNtTxMxDopAcWalV8AN9CEtuiAU/qFHkH0HSSGiN7ZjUlqatYPWor
 0VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618061; x=1779222861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zpCSnTZDy0cXLQEkLxVTYXKV5hdeLG4LMCu3JIo7jKo=;
 b=pywYkrTIT2k4BAM9hdKHDXEbz6LPYyHO5i0x0TSSKZWOfhw6kNHOYPZMDxcfXls637
 gxr1YYkxPIsortbLZofqAcrEYF70S8EC9v7badaGAEhYc3/vFUVX7/uULuNS9nwqq2IU
 mRiePiDHxr0tYTBF3iJLuzRplHFHpW3OfSHCQgH8KgKF9nBJFyL0UzNeLCy/3iEYlvu9
 hXnLEQD2RK3zU6d5zdW/JGCuOR24ugRoC901x6mfO4qu9B4gL/6QwGhzWeoQ+hTuqWvd
 Xg/XBeYOGy2xUBEr7+wNtvEP8dmJj6WDT032XdefkpZZ5aHL7V4QqZExpEeP8ZnGLrcb
 0Rew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XuqNLJaIiG02VLFAa8T2l1oxHp1evH/Tg1lzAOQE5HL7M8fiN1vAnAhzINNDLpKzGACTjfHDSg7Bt@nongnu.org
X-Gm-Message-State: AOJu0YxIkB5Yd7Fmk2Uy8KbyFVDqCWaMhNaZlxMGbkm0MoCxvcNwdl8g
 dnOJIrjpX0DQM0RpMhC2PLTa+qbq/T0BJ2BcYJ4SHDGlJR5L5QJk+h49jVMw95DfVmY=
X-Gm-Gg: Acq92OELBEawYhTtFT89yiabnUA1gGPA3Mn5/LIxW/KkaU2Hx14tbMBBt7SIgdTrOXc
 hlqJ8jtUZGYK9w+iVwGQy3oI0J4G7we1kw/q2WRjI6tX/jGkeAYMl220OqUVLRAbF94ykc36ZaJ
 c8r0va00Myv9UIxUkd3rYmk6UJxHlWa9RyMcqJ4mXBtpaacbjYUoLLB/rFAydL2TW04vIl5TCMo
 jHoyvgHmUzLAj627W68tw5DT5JcvEDrG7RWBV6rzLnOBLA+9Fp+YAc/Tpv/1VCcWS/klykrGxrD
 peII3LG1y268oNiGcnr448sg/EQocy9PxFo80GgSQXxQRmXBKYaCja+FHIl6V7m/Ii7jAQDuRh1
 SBVq46QpyxRA7PzmwWfOz7MO+gcHNaKwSImS2eAO6i9vOF3gKKN8jnfTm7OOItknZi+mfEIvkJ1
 MLIpzYNThUOuHV2c5CjGgjPm26X9zwEpv+UB0A064JiBkhFvCeKS0pUM6fySJfGTaeXaut4NJNe
 TcdLpVHAtOu7q8s1j3h2lG+fiV3Hno=
X-Received: by 2002:a05:600c:a15:b0:48e:89f9:9408 with SMTP id
 5b1f17b1804b1-48fc9a3864emr4780115e9.20.1778618060817; 
 Tue, 12 May 2026 13:34:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/12] hw/arm/omap: Remove stray unused prototype
Date: Tue, 12 May 2026 21:34:05 +0100
Message-ID: <20260512203414.3633237-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When we removed the support for most of the OMAP SoCs, we missed
deleting a function prototype that was for a function defined in
removed code.  Delete it now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index dc63323210..96a52d280c 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -338,10 +338,6 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
                 MemoryRegion *sysmem,
                 qemu_irq lcd_irq, struct omap_mpu_state_s *mpu, omap_clk clk,
                 enum omap_dma_model model);
-struct soc_dma_s *omap_dma4_init(hwaddr base, qemu_irq *irqs,
-                MemoryRegion *sysmem,
-                struct omap_mpu_state_s *mpu, int fifo,
-                int chans, omap_clk iclk, omap_clk fclk);
 void omap_dma_reset(struct soc_dma_s *s);
 
 struct dma_irq_map {
-- 
2.43.0


