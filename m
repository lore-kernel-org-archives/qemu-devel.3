Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5A0C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDum-0005vE-68; Fri, 11 Jul 2025 09:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu3-0004Wr-IL
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu0-00039w-SV
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so4525925e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240899; x=1752845699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tnq7IbYE5RKAsvS2Bxpq4+1qdk4LhwMgwm937ZzNCaw=;
 b=V+4pJ+YVbNoGqlYE9VmLCBzN9IKFkhMBZbvPfAtjrHRb0HfROw53LH+b1CxWtvw1Pb
 qFx8FUwBdJJkGdEuX1qYil9vJDlnHAWHRwJejk5WwEm9skQGkmeOfKpXGd2yec5jGUeX
 5cw1ZGUasjJFWEed3+HDb6F4MrjHqzJhvM0Dug9QpeFdCi3SKq1PVRQgDBMcv4r37nIp
 v4LwFNIbf0CypZV2ARnJfEAuWibYyQbV1P0xhiMDBEnJtvt24RFdehjFHS8n38BWV38Q
 HEBfjjr25zd0L0J5GVFdDMc1gvgzyMYzHKveDN1MADxx7mzvYUrmVWke1HxMZ/wrRNaD
 qtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240899; x=1752845699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnq7IbYE5RKAsvS2Bxpq4+1qdk4LhwMgwm937ZzNCaw=;
 b=YYzWEBTNMS2rMfXOF5oW/2S1bT77tSW+ifvQKNyB8fwm11DOlykFc7mozgkPrvifux
 m9z7rkHEtK9syLpHHEWVsor4mj9l/h+29FCJ2nYRjAUPNoygjxqW37OzhpPmWkQNM6EB
 Q11biTMGkEAmS4gqBXXhwSI1RPsZrTAk2nrtoAie1iSUJvfjQ6PcVo5t8eRnEg/p3Hzh
 FJphK5ce0pfaNBdWsZn8wtvpBd2432obQHPMNmRiwe+G47traMsSecC7+lj16utuO58k
 hsoTelLAUyOgj+gLLqGfvFqjJT2closZx0u54RKhxbxl6gC6C9bUtoksILIn3TaTuUB3
 I7og==
X-Gm-Message-State: AOJu0YwQXqJTAsJ/DK2QN+VTpyf3dh4cvhpL2RXxMFs0aYXuO+4gtdve
 donFWbQmCqmhNlxX1rqNok/BWMMckMvLDSuBXBZbsLoCdQQyVQBuw/ZUB2BfC3KA/5bGJsBvFH1
 995hk
X-Gm-Gg: ASbGncvpGPD4ztNoPArR/KWCQp5ulEDTcGNkRR2ZaynIUAhRndP4rasTuNA0G6qsBlN
 zyNvxW+oXrpookyuyqUgFAd31ZknZDKAA/hohIVEZqy5M3yq26Hz4vPqa2qZeTg29pEz2mlH2jR
 XMpGx265fUMZ00TPPlUwQL7d6NS9fKwIXs12AipJDmrVnf18k5/t5dyo1wnHI8qCpvKcOsRcamw
 Cor2jwDGuph3Y7zeorEWcARXJauAzlBteAXSQZqk6bSdNaaDYRTPlR1cE5dPio2T07JEJy3IhNr
 fPdIfxMAw8VRuHi7ozrKROsBITihI7IJIboatvwE0FWfEtl28+oXv7dGo9rqLpCBPL8rI/Hws29
 NWkZlIqxp7PZaiB4T4MaQu7wE7cVy
X-Google-Smtp-Source: AGHT+IEtsFw5LE/Vgg0zO6MD31+lRph7HhXP6w+dBbP6b0YVVRkFt5HX6qpMg+e1W1CBGFp8TU49ag==
X-Received: by 2002:a05:600c:8b84:b0:454:aedd:96fb with SMTP id
 5b1f17b1804b1-454f4275fa0mr28996815e9.29.1752240898909; 
 Fri, 11 Jul 2025 06:34:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/36] hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ
Date: Fri, 11 Jul 2025 14:34:19 +0100
Message-ID: <20250711133429.1423030-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Allows to run KVM guests inside the imx8mp-evk machine.

Fixes: a4eefc69b237 ("hw/arm: Add i.MX 8M Plus EVK board")
CC: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx8mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 23e662c16ca..866f4d1d740 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -356,6 +356,10 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                                qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
             sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
                                qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
         }
     }
 
-- 
2.43.0


