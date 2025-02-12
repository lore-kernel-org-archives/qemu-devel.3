Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACD8C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEu0-0004PZ-61; Wed, 12 Feb 2025 10:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEtx-0004Op-AO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEtv-0006tS-Ne
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4395561ab71so21170125e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375025; x=1739979825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LU07FFTNrNmuJxeXtZj1sROe3UDgZjRzrIqhpiTHeSE=;
 b=akQTDbLxAjbKTWIfWY+SQwhZAh/ztcYL8vYyOuwDuUkHDxWXea1gpUiIvrWsG4kbGD
 +xKiU6Tzj/9o0i0wJWsLndfh0X/9htvADotYAZrw6dvqoRSMDD/+H46gw1oGXlD60aA5
 rDfOAyTpXkbbQl4712Q/dj6Pqch5aIUzuagD40v56XKQ5oMjmdO4c/Vpjc4xroLu78PN
 gOPFDmhJ8POoi731JIeNtXrkMx/ajrcOzZidZi8YnDdDliLn9zXka3WqKh7lwdaGZDJL
 LZ7CG7Z9Eg4CyZR2foLk7tjSoPZqGDKwINqsAcjAavh1lFOaby1ds1QW49XmjeXmx7g/
 pFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375025; x=1739979825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LU07FFTNrNmuJxeXtZj1sROe3UDgZjRzrIqhpiTHeSE=;
 b=HVG4p20Atsf4ENJ/2ySINZ3wZpFL/40jpv8juoeOs+HgRshpuLbJZFM+V5wQLLcpps
 LQJuQVq6W8DLk4fILvulpoxgV1aqvcyvjwsL4VfiIxj+I9YI/qAy8Y73tJy06mYsaKb7
 hUiZDp20qxZ1ZEmGRVBjoa1rqgNiX/NMznaU/s3+OTX5qiEyyLPamwKmJkmdsfAD8XFp
 i5ubSNSC1W1E5J2I+elZLIryFY+rAW6Go6sMTZmiNSnVw0T56FmM+yHPbj/S7b5lz7LT
 SU0IL5M2MS1qpGR5Z0c11ps2T9QDyGaiJh14SFNz2EBb6+4LQZG7y0LeH7649IfbNV7F
 Xgiw==
X-Gm-Message-State: AOJu0YzxVmhylDs+VC4Zmh2PK7bg39qmxHUVKllqUjXWxsh7wbbo9jOJ
 053v5cZ+UGCXRUadNae3zmlDfLcfSGmpMlwWkVkObfz1gAUIxTsuMZU7jSlrZtHFnE2YmlmAfoG
 uzTo=
X-Gm-Gg: ASbGncu0FxhXZR5SPzDdjzkkmbClKqJoVA3PKgcHetiLqcut9gWfT9EDCTPFqklOYeF
 zP1AOvM52w2LeYnORawTTiXimjFhaGerZwtg9u4h3s6feS1FYw7pJktNCRrBipXJPG4SUdzzghK
 qt9Z9X5RMT2AocjBVSWv9prYUKxrdmccsKUmUt/XhypmjSaQQJDGnDy72k3ABHy7qLsA2DK6BPZ
 ZBZ0OHarDgUXYWVEkiPTcCUOsPh4GhUum5bdHZqqTHBKd0SjbWO7vFAtYafm381zbRHb2LxEzED
 ohYfjKEqr/KqAooj9+8voXnvJI/KmxYRs9z3cL4lTcueXTABoMgJFRrmCT4kArSONzEjPDY=
X-Google-Smtp-Source: AGHT+IHlhfbkonA5LDB4UciTmUWHBXmFcfzt2OowPXOILfszXnrpzmvt8xtjdTdHqF1GP9OPmZQu0w==
X-Received: by 2002:a5d:6da9:0:b0:38d:d666:5457 with SMTP id
 ffacd0b85a97d-38dea2cfee0mr3483006f8f.42.1739375025566; 
 Wed, 12 Feb 2025 07:43:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b824dsm22948015e9.34.2025.02.12.07.43.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:43:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/8] hw/arm/exynos4210: Specify explicitly the GIC has 64
 external IRQs
Date: Wed, 12 Feb 2025 16:43:27 +0100
Message-ID: <20250212154333.28644-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
References: <20250212154333.28644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"). Add the GIC_EXT_IRQS definition (with a comment)
to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4210.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index b6537a2d64a..b452470598b 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -103,6 +103,8 @@
 #define EXYNOS4210_PL330_BASE1_ADDR         0x12690000
 #define EXYNOS4210_PL330_BASE2_ADDR         0x12850000
 
+#define GIC_EXT_IRQS 64 /* FIXME: verify for this SoC */
+
 enum ExtGicId {
     EXT_GIC_ID_MDMA_LCD0 = 66,
     EXT_GIC_ID_PDMA0,
@@ -588,6 +590,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /* Private memory region and Internal GIC */
     qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cpu", EXYNOS4210_NCPUS);
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-irq",
+                         GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(&s->a9mpcore);
     sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
-- 
2.47.1


