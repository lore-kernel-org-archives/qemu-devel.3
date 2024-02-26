Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C68AC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reew6-0004PU-K1; Mon, 26 Feb 2024 12:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reevt-00042Y-No
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:32 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reevp-00077T-RG
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412a9a3dba2so3269205e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708969104; x=1709573904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDIRaAfrV77mDOzirHYEWIS1MDxHTben8a6a1zFSPbk=;
 b=tP415/iwp966js4vZxd6sxUzV4Ch8rJnlrAe7NLpqir/bqbhtKeR39k/USXBU4NjQF
 gYV5cOq+ZXnCvZPyUKBKlsV6+r3Wqlc6gJqoY4kQkfrDZs+gsxFuyrC0I2Egtrxq3QyM
 hCnp8zBJhKz1Fd3iRypZYKcZ1M9FNL0AB2bzV+WwHz1geqKag0rTS3uPoNRgu3E9eRVE
 kFvREn0OLBX6S5qcBb6Gb8CIKXk2kuWPF14CP/JnCLrm2oZCt8+Pbxy1jPBrvycXlH2e
 Rj/ygwqZrIrPxQqezEC/p81OAWoAmVwUZ1gv0gfK04PxVPawOXkBFVk4344TfPWFclpM
 7XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708969104; x=1709573904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDIRaAfrV77mDOzirHYEWIS1MDxHTben8a6a1zFSPbk=;
 b=kgxF+kDkFdsLHZvP5EnNj1PlE34WksUzizcUyOktpD/xS+q0YuYwd8BTIebOE7T5La
 DZkzhLIeQFsVFi/Fjk2OC/GuiwFYIC4vDdOBBTb/4sp7KBNU3hqZUxAoCrN4jnMsuGfM
 EL06TO4e0CuHGuGX8OsT1IptyDCk79oNwBarCa0ulk/POk9ELCYN/pqozeqspc8p2Pmk
 4L1DPx8rXasnwe/c6VlzoeiQaI27LolHsMj8L/1TL5+kHkwwc+hXNhDA+V70JcEZ6/+R
 F3FW2YAIZsOiIiS9QgrGHAdq0+AFXwoEBPZ/iqJaUohiPGXX/dlC0UOAA3iKc54B1Lus
 bWXw==
X-Gm-Message-State: AOJu0YxHU5F/1QmQluLdOsV405pg3u3a8DfAcbgiI1ztMsMbEWvVyXcW
 BXugHQpyepJbVT+hrfxCw3wUGtOYxCJQg2x/gZv1x2gWwgYvjXt9bl/R1N9PjmfILDlewb2eAPN
 b
X-Google-Smtp-Source: AGHT+IGsF/3pVugPGHNCdpyHMPEhBMyzzshLBX5Fr0YkiUmkVOvMoWI+2/b52CaXyKSwpbraneFoyQ==
X-Received: by 2002:a05:6000:71b:b0:33d:c652:7c41 with SMTP id
 bs27-20020a056000071b00b0033dc6527c41mr5226316wrb.71.1708969104173; 
 Mon, 26 Feb 2024 09:38:24 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a056000038900b0033cffd1a302sm5592272wrf.57.2024.02.26.09.38.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 09:38:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/6] hw/arm/exynos4210: Inline
 sysbus_create_varargs(EXYNOS4210_FIMD)
Date: Mon, 26 Feb 2024 18:38:01 +0100
Message-ID: <20240226173805.289-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226173805.289-1-philmd@linaro.org>
References: <20240226173805.289-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We want to set another qdev property (a link) for the FIMD
device, we can not use sysbus_create_varargs() which only
passes sysbus base address and IRQs as arguments. Inline
it so we can set the link property in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/exynos4210.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 57c77b140c..ab18836943 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -769,11 +769,13 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /*** Display controller (FIMD) ***/
-    sysbus_create_varargs("exynos4210.fimd", EXYNOS4210_FIMD0_BASE_ADDR,
-            s->irq_table[exynos4210_get_irq(11, 0)],
-            s->irq_table[exynos4210_get_irq(11, 1)],
-            s->irq_table[exynos4210_get_irq(11, 2)],
-            NULL);
+    dev = qdev_new("exynos4210.fimd");
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, EXYNOS4210_FIMD0_BASE_ADDR);
+    for (n = 0; n < 3; n++) {
+        sysbus_connect_irq(busdev, n, s->irq_table[exynos4210_get_irq(11, n)]);
+    }
 
     sysbus_create_simple(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR,
             s->irq_table[exynos4210_get_irq(28, 3)]);
-- 
2.41.0


