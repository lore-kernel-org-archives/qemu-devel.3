Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82461E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu1r-0006YY-Cp; Sun, 15 Dec 2024 14:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu03-0003XC-R7
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:56 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzy-0001Ws-BD
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:55 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71e1158fe3eso1714666a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289789; x=1734894589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEHd4CM8L1GCpQcebyZN8Iy/9TXq3pypUB9Ffjp85Gg=;
 b=HrHGGx4r1YrOjymjZrWhOFcOdglUEsmozkYqF/qVjOMSCHlCcN9APb8u9D0amHz96s
 axVeQmHFkdB7AUvtf32l1r60Ij0Ju0434qEkVmv57K2zhJDoLnBgCAbPsRxg/h4pRY9H
 uDEmmLG5kjJ/lHMpQuaQP161bwia+oSb868Lh9eTlrWYqw0p636yUHIHuEEozvKgAlEt
 YYHK6Er3pnRJwAr084uf+oAu2qgSJnTCXSGaALsHr2C9zgTNhg4wUfhf+mH7fIAyIAXv
 qF4RCH86sSIeUjBDJIBNGq8V/FbTLkCsp831X3I2IE91hrMnbxsohmBVo7fHa0p5Tzb3
 gYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289789; x=1734894589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEHd4CM8L1GCpQcebyZN8Iy/9TXq3pypUB9Ffjp85Gg=;
 b=kWKVfCc1k4MkyynLWmwAuCPnWhB+NIQIyM89hKWD7tCrLYudOBZibAtQq1NoG9DNtb
 G/icNdtrl3zVLe9DRco5DyvTgAtLqqfWc33SmUuq9/wNtJghKKYMw3kr8ZHW+WZuxLEU
 p4cvnD/BDKX9CEhZh5IzIy3R1i9JHvRiYECB72q1hURSzCib0d0KkL8sTeqheBHNwKHz
 s9jrRWRx0feoi3Xev5WtMYX/j8lmQrENS6ZG7BQeBLSTXAWOqiPQ95qE+1cROks9urE2
 SjkcFr0TPhDYQvacbU8ioZeXWvWoL8sHTijRIbZs8iSvxo2hfyePEX+7fi8WLJbBTWM/
 gVeA==
X-Gm-Message-State: AOJu0Yzh/e3n/xozPFxNkcWyQzWQ05OCm52P78vmlF80A48sdq9prVVK
 vXrpQ/Qo47oG4K5hi2i5NDnXJtMVqJu9UIyJSVIsc7/E0Btz02xUI5/Qa0R8SdZK1N0Oq+sOk/5
 Gf/bRb2BB
X-Gm-Gg: ASbGnctQI05WNziBV8BZqSvo2DuRiDle+gKUW4CUjZD91iz/h2yqQIt0I3XL0lSYNYr
 old6Ae7RK08tGOODdUR6/sGXmBbvIXHnXge9Iej2bml5SiwRuSxYoMmR/VzUOOX/ePe0AMbRhZQ
 LQTRbJPXwwjdo8BWKB+JVfIkkbrIhUoiJdaZep2U1Iy2aGtjEXL+RZ2i0PPJl2c7vRO7d6abkuf
 1SkS8MPHoRXkFKtvDrCD4ThEIHm4RKW7aV6d3wL3cTPyKRkQCMcssIKPIj9073Bee7m+IOemksH
 pHPSkW2pGbO0rbS6NmbnS5nVSkhVx4jYSxPfe07xsjo=
X-Google-Smtp-Source: AGHT+IG4p5nxyHFBYUvaVv7BGeiGMfWNJxQRvLEuyipbJGohEADDMii1G6M6jjX6MUE1aGTh/aNWNw==
X-Received: by 2002:a9d:3e03:0:b0:71e:4ce2:432d with SMTP id
 46e09a7af769-71e4ce24574mr2401088a34.19.1734289789030; 
 Sun, 15 Dec 2024 11:09:49 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 55/67] hw/sparc: Constify all Property
Date: Sun, 15 Dec 2024 13:05:21 -0600
Message-ID: <20241215190533.3222854-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sparc/sun4m_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 6f765e97e4..3d6fcdf576 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -368,7 +368,7 @@ static void iommu_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
-static Property iommu_properties[] = {
+static const Property iommu_properties[] = {
     DEFINE_PROP_UINT32("version", IOMMUState, version, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


