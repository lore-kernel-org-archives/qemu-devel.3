Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E658C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIT-00011I-QP; Fri, 07 Mar 2025 10:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIR-000100-4E
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:31 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIO-0008IM-BF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:30 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1549867f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360047; x=1741964847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=POedfr8OIoRc4zd6hYJv4201L8L1FVmVr4GGYLpisj8=;
 b=kNBWhgy/LEL30ACulA/BuTInuN6Ik4T2XRk0heVgWKUPucJyrypNuh1tAZHuNfk82b
 AGa01dii8V6IIq3xBhSLDtVw/nyEV51/vEgrsqI0b/mxWYEh5eVy2aT6ak0BZqy8PxJa
 r08i5s020Z2IOx/TIRTbT1pVtJMHXwBwj3CN6940eqJR2EriieUGXQsb2GS2uGrFQCFC
 pPski5ZDboxFjwWLV3F9QtlDALkupNWo5599oYbhGNgYbLL1UIgJGGXXnwEK2wG7oTil
 o1uonVVE7t674ArfCRFuicDQMmCmJuHtqk98OJ2RrE1o1A74hTGX4Vei3R52yysvxDlo
 JMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360047; x=1741964847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POedfr8OIoRc4zd6hYJv4201L8L1FVmVr4GGYLpisj8=;
 b=bmkRku7UtnFlIT8wfYaNTENOwHAUheZIaqNDWvYNvh7Bcf0zqwvDgHQCS79BScgnqE
 gpamblNdkfseHcNPMzftmjcbgsfVYM3L3SGfUPvNTRyf/Y62Om6QXpuvpOgVaB4wsISE
 bU1OEeEJU9vpdCgmxXhKLLVw04jKdePVqOYNtX/j8PaUqG+OzzmVXa8sEati9AAfwAA/
 OHHv+SkmaEnni0ezIEgboDtLJOIg8cLeICSHrCkzHeO1liJ7iA1guBpryAjxGaOwmQ+9
 6wqqykBHr66vr1YGGTCZpinQKMFFIweNt2eQMNKLZuUAzYvFB6wl/vnuQJ5qvddTQUov
 E+Yg==
X-Gm-Message-State: AOJu0Yxg3uiXp7DYWPwDs8pwxZkgxwolDXQ93lTTAAKXuAP7T6zei0/6
 dVquTnb3TKO00l1wK4yVe5N9ApP79j8XEdnFLiVVKcycLNHijRD54kB6qV6sOlMZp8FZNwN1/vQ
 a
X-Gm-Gg: ASbGnctlrRpI1k56GPw54vIXmE2AFDQSSXomFN7F5GMHKVC0phkDepx1lctmWihSjS/
 R52/am+r5Q8IGjqiYbQXxGnh1eBfDY3/LtLSqLihqhm34FQifRY+I8Kgu2fekhcp06l+7/Q8hPG
 l0DawYzzVvWdxVJz1AhcGMSqyvWEh6X58g49CfphhwD3vv3q6cyvG7Q4CJFkLF+UJOMIFzyRLuR
 NGcZlI2CHD2SJNqeRrX4FZIJP8AMGLZUjTOm3k/PKP0xW5vCVS4WLZ/stUUmpA7NasZtkpZv+ld
 f4vTiOdJe7qJz2KgWDmM3lBSZqb8G3CRYuLuqbXl0VKpgp7dwNg=
X-Google-Smtp-Source: AGHT+IEvsD8hXWoTWLSm6mqM5kgwRT8yM6HjevbJWpKI89qJe7JEfXFGSKTZHt4ElfQzy4XvFS719w==
X-Received: by 2002:a05:6000:1862:b0:390:fe4b:70b9 with SMTP id
 ffacd0b85a97d-39132d6c5demr3030629f8f.21.1741360044586; 
 Fri, 07 Mar 2025 07:07:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/21] hw/arm: enable secure EL2 timers for virt machine
Date: Fri,  7 Mar 2025 15:06:58 +0000
Message-ID: <20250307150708.3222813-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250204125009.2281315-9-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 904c698b140..a96452f17a4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -882,6 +882,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
         };
 
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-- 
2.43.0


