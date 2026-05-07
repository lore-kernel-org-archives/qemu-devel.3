Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A28CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11F-0003RC-Dr; Thu, 07 May 2026 11:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11A-0003Os-8w
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL117-0003kR-AK
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so12771975e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169120; x=1778773920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V1C1Hqd/9X5wZGqORj/IsagCzcveEdkl7UsFoZal3QY=;
 b=yROlnLbbOnJyVyCJD+NLl5ZHG5Gf/3Omj31huV/2VeG94OiXiZPHW3iWaGBsYEXbN1
 DGFb7ExTAwWxeylw6YgqS7jid5OUXy1uaeUlTYa6UistE0YuW2G01wZv7SSexo4NUD1B
 WAyADmc4O74EhXtr9XuUJSjGor7HzGpm617bKOn0Psxyca52uh+RpjLezKR4purV04Ac
 V+5YfAtGjON/F4rFTOMhNW+mwsr9N52MN26JQt/tr2SbyC/o5d+sjP1vlCz3AVcalpOP
 LEdSih4D1vBJ3kEP0nT0e3kg1JivusuhxhRJrLcLe8d/HVdhf7IRW+cxa1fb8b3OFbi+
 RGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169120; x=1778773920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V1C1Hqd/9X5wZGqORj/IsagCzcveEdkl7UsFoZal3QY=;
 b=mjSQckIfSiHP+nKZ/la4ER9vsufelSzqsPhjeATd9+T0VFja1qgxnl7p1wt748gCcO
 AI27G+X4mfvLxhEgBYWvky2WN7zj1ED+3a2rfS/8RuqDleVOhyGZwvHXOG3UM7HmsEO1
 m21ihBXvbbtIprmvFaBsMqADhQSZkpb4/QOpNl3eHFobzX2wxe3ibR6x+0bn3XagoUiS
 ctVvk6KguEfOwwe5dmT4juppp+OJglJjQqSW7KghnPwzLpwZ77wAeZ+MzDlhcPc9e53/
 1oG0XnvAyAWhym/4agfnTby2+AO4qNbc/OcFxr2dyRvfjezYaWIIODzNhWTjuRCeHu3a
 UHUg==
X-Gm-Message-State: AOJu0YwHmq0ZS9UzN6hbBG9Pwd31BnBT9OqTuMHwN3swXb4NtBo2Fgs7
 lxQL9QkAbdYR32i6qFd8m1FeGgqdj12yZa9n7ZYs/+yrrABFcoEVi9fGvOdZaW7/DA8QZj7rK4P
 +upZ8
X-Gm-Gg: AeBDieuhbmbt4c1sNDySvDZ3+zjQx4eVNs0R4cPq8ep4K1XYxWQ8teW5+tRKWZbTvRu
 X/yJsCQZKIG/a97rqZOiVYnTxNR72wmUfwG4O8w507oHOVsSh3IzelkCH1AAd4L0haFXy+xCCHI
 i3yk+eAkZjoiKep0OfEg+A+Q+dZ45BDPST8WoNXXEWkbaA9CrVDOMVWKIIbrNYRBHXBrVtybvnq
 jRXpVJAwJKOom9GFH50iob93q+6BMM5YiUp/B49VfK2XVMsXNCwmj8bqYtosjW9wph9zShnSItd
 N9PQM0D9h8+OrXqEfF3QsYmV0IfBcjSDbnPgIe3HWnwDeZg0PsMsoYLTVL7dD0FzvC8pOLSPBd+
 8M/XEMWfZmmUz83VfMnP8789Lzfif03mmZW0mTsnZQJyLBDW3KD9V4rNtz9iQNWRnC1UXm80CSo
 gdqlZI+dyJ/9V91v5K9vN5pXf0or76I3vmwqC4aKq8E301ejS9asP9U/A3Y+3HElT5nDFSsXBX6
 vmviboBdhvSNO7p2edqBi4WmjlFHfM=
X-Received: by 2002:a05:600c:c096:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48e51f50982mr100817385e9.24.1778169119604; 
 Thu, 07 May 2026 08:51:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.51.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:51:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/67] hw/arm/Kconfig: select ARM_GICV5 for ARM_VIRT board
Date: Thu,  7 May 2026 16:50:51 +0100
Message-ID: <20260507155154.1886557-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

When building the Arm "virt" board, pull in the GICv5.

We haven't added support for creating or wiring up the GICv5 in that
board yet, but adding it to the Kconfig early means that the GICv5
code will be compiled and so we can have more confidence that the
individual commits building it up are correct (or at least compile).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-5-peter.maydell@linaro.org
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c31752e83a..5b198402d5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -10,6 +10,7 @@ config ARM_VIRT
     imply NVDIMM
     imply IOMMUFD
     select ARM_GIC
+    select ARM_GICV5 if TCG
     select ACPI
     select ARM_SMMUV3
     select GPIO_KEY
-- 
2.43.0


