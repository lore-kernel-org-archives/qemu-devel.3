Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B76CD65531
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxf-0007jl-J3; Tue, 26 Nov 2024 12:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxd-0007iD-96
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxb-00025h-Ju
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a7ee3d60so4435225e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640566; x=1733245366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KhNpoYBpBgMtrTtvaiAKYKeBjehZXk/NeYq/vlyz2aU=;
 b=DFlE3bZ41KcVzWlFuqF/kujhTptk1RD9O6RLDxqrcbB5Wxr/fTYAxWE57zhvclZukv
 OdphXmCW3ltq+Xqr4LT6tKgKMWctD99/n/bR9pfYdg6SxaI7JDyxnR+hC6ysVS9iSEJA
 mYo0MIj2XLkmUtJsCwYeJAE406ba6O5/4/OB9pUwJzr2RSxk5m4U9/5UN5tBbRPoHZYN
 0/32KsFYr4PqH2D4HALS6EyoeO0D3M7OAzWscUkBlgrt+0+nGSL5E2Q/eNJ/V4pJ6HG0
 iC3/hqpLMxIzXES+ozLzT46IP+KHHt/9wgTmwBczHonFuBoOGaRqNeN/zs6ng/YkG331
 GMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640566; x=1733245366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhNpoYBpBgMtrTtvaiAKYKeBjehZXk/NeYq/vlyz2aU=;
 b=dkNu+amkqm4tK/2P4vGiiAIs79oryWLOCWEHzy0qDF6ZeNT7/sYGE05N3t+mmzh+Fc
 J6EC4i9OauNKSsRxxo4/+czsyvvUDAfh+fP62j5ywRxOP25bgd/AE2L4TBV2p+RJ6TH3
 koPV1eWAxzV4y3roleEPdQHkYLcLXZ2wZS0IIz+MNahGJ/je3eZOL6x49NH5C2q0I1uj
 5vpxqFZVvX/G40FyEXMBuzOQBmG7a4qsrpHhtb6EJhNTiA/m/iBmJdgUfST3mcxii5KC
 d/ywkwEXHnFVkeDfUXrUqTwdn6ZkktTXZIefmwJtjt1dA+jtIc904tdxB//nl5azEuSv
 auKQ==
X-Gm-Message-State: AOJu0Yy0rFT77he2l+TSRs+GIhu95rlhdmnKUs0r8burEW5HInpJwyv0
 Aln3fLa7gsLjLvm7ooc9TkJRhsL2ObUmRYRuW6ZlurH40o873Q/RC2LqQ2foOdNcd803uHX+MS7
 i
X-Gm-Gg: ASbGncs2DEpUtg2AliRx469dh6Y2TSn4VRiY0VSwo50Vbu97lMSycqBMYAdv2vYluWQ
 TCIYUOsISenHLuM4rMc2luPkkwoArvtpA05kgLFVGQVtsA0FWJOjpbpDhHWMqRGrrjGKg+CPNw/
 9j9Y4pWA4fZAjQYYXl4le3bIgTzNRsmZfuIQlvc9a5KVTfA1LEDrvd8BvpfKWRAEcK0gJZdtJm4
 6lD2Qg74VPzOP/gdAbIn0uQpEtgAzdmBgTmjMiS5oMLqTBxGHengtyf
X-Google-Smtp-Source: AGHT+IGPWZd1rG/6U/gx0VOAQJPnTPI2YZzhOm66JGyu5vyM0qwyvxx6PsVQ07GPfnzaxMxxLv+BJQ==
X-Received: by 2002:a05:600c:3b03:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-434a4e7ac3emr35145915e9.8.1732640552538; 
 Tue, 26 Nov 2024 09:02:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] docs/system/arm/: add FEAT_DoubleLock
Date: Tue, 26 Nov 2024 17:02:22 +0000
Message-Id: <20241126170224.2926917-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We already implement FEAT_DoubleLock (see commit f94a6df5dd6a7) when
the ID registers call for it.  This feature is actually one that must
*not* be implemented in v9.0, but since our documentation lists
everything we can emulate, we should include FEAT_DoubleLock in the
list.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20241122225049.1617774-7-pierrick.bouvier@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expand commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 47f5123a31d..38534dcdd32 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -37,6 +37,7 @@ the following architecture extensions:
 - FEAT_CSV3 (Cache speculation variant 3)
 - FEAT_DGH (Data gathering hint)
 - FEAT_DIT (Data Independent Timing instructions)
+- FEAT_DoubleLock (Double Lock)
 - FEAT_DPB (DC CVAP instruction)
 - FEAT_DPB2 (DC CVADP instruction)
 - FEAT_Debugv8p1 (Debug with VHE)
-- 
2.34.1


