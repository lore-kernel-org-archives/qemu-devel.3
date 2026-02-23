Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCEBEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKD-0001IT-F8; Mon, 23 Feb 2026 12:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKA-0001Ba-4e
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:22 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK7-0008US-ID
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso30463545e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866138; x=1772470938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kPtDe6w1LWavMJnFSy0nCTCbHx5GgbeM6ZGU53JeD94=;
 b=U+2uh3XLm0nvZ1TNoUual6Pd0/IDHtDvLmG8SP+nnefPh6sdSm252L131i90BQWGjb
 w/qIY1rb5xv9rc5SMbwBkN3zP9FFY7L4j7nUt/jciqfnl909M/7/uU17mizoj4aXkNHV
 oY7qNm+DM638lsl7jCP/A9XG4uZcEzlZl2G0TQ3wbxMl1mZ1WdCfVT0N67kDPDJZGzJ8
 ZzohlqJ9zcDlwFIQx3Ae+rCZSMHe5Pgk83OvxeWK7vNJHdUNTB+OuhEvuB1n5Pd40Hdu
 ofWcBueVNpP8WDKJzswrJvdJY7WGNgxWmAFUpmDl550O8D14drpndWoozwR8P7VKv6w8
 LfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866138; x=1772470938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kPtDe6w1LWavMJnFSy0nCTCbHx5GgbeM6ZGU53JeD94=;
 b=UyEVSvDpUh1tNU/1sNFRRwHRib2Swie4fDIP3C9CSqgHMZtlfllLhU1QPJV8BdvFDr
 CSJGbGxQAejSGLE9vW91lAVdNKNGLnlZC7HOeJ7M1smSdVlSao1CI+gHaXExFBSvZ1Mf
 de2mGf0OybzHINFjnXqDnkmLuuu2ms/dw5K2dqFslAFY4Q9q/zYrPtb05bEPpU4f6l6c
 jSpkoLVjo3N/BuNGGd7OwzMBI0YVQt3dcuodZlv2VclkX132ysBYHeIgy4FT2QTq+hPD
 PmmU7n46Dk0l/FjeoXhcDTvUNb1VUjqWieAjHJGmHtr3hNXva2p6GUqCQSJFxESg4Swk
 t7QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn4YSk5QXg4vCXUyZ/k6z8ZFWFo1b0sqBkwrSgHXeNeyrb8S52D5OInsmxcgG30xu5/swX0xeUEnyP@nongnu.org
X-Gm-Message-State: AOJu0YwjoRn6CTAkAWeW8hfs0rB9fXpk+ADo2yLtDw2ghAOSw3WJaCTx
 5pJdDdLTV9Y3OXJGvytfYSY+LXCIZw08BHVcVk/xLpYjr5ZSHfMfRDsC8MH2c/QdLTPShYii3z9
 QGMJ5
X-Gm-Gg: AZuq6aJ9WO62g2GcQGCsaRj8BI0ugd5NGA1Yr22YQRyA0rsgaJmTugmIu6rlmQ8hJNf
 XrtrnYWWpHnEAF3o/8QUWdX+VutUKoR2NOQxH4CkhjAIRfJ3eunUHuySAz/XUFrVVDDreDb6ozf
 k/b1xEEwvTYZeqLrwhEfJmOsbiCoQ1Rm1yk6EDszegnQD13F3IJmvEpwR9AbiwElZiot7F1Ont8
 1nYKwMXr3fYOlVWCQttDlh8BzYVz304srOerCJZUQ7YplC3hvyDx6tvK186bXB0TzLBg5S1GonI
 5ds83enaPt0EDWAyKOWzxciO/5Fo6QRyQ3PlmP7RH4clbJxVeGl9HZLTYfij5amONT2mJKpQF7u
 3+Qm0D4FsdZ3R8NCFHmElOk4OWqsovTK/LIYeG/XY2q/DKMzq1aG6IDwGqJpmTINWpCbAej9AZ2
 jIXy+lk2bMYqYGcO3gWgsJIvAblOUSMg6K14/4Y1H8yBMDv1vQNc07z8aEH4reHqFT1AzrDSMbh
 fgN8X4p6y+ae7y+BWsCoZOFs5QusHc=
X-Received: by 2002:a05:600c:8a0a:10b0:483:a2b0:d210 with SMTP id
 5b1f17b1804b1-483a2b0d22fmr170457205e9.7.1771866137541; 
 Mon, 23 Feb 2026 09:02:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/65] hw/arm/Kconfig: select ARM_GICV5 for ARM_VIRT board
Date: Mon, 23 Feb 2026 17:01:10 +0000
Message-ID: <20260223170212.441276-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

When building the Arm "virt" board, pull in the GICv5.

We haven't added support for creating or wiring up the GICv5 in that
board yet, but adding it to the Kconfig early means that the GICv5
code will be compiled and so we can have more confidence that the
individual commits building it up are correct (or at least compile).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..91a15040a4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -10,6 +10,7 @@ config ARM_VIRT
     imply NVDIMM
     imply IOMMUFD
     select ARM_GIC
+    select ARM_GICV5
     select ACPI
     select ARM_SMMUV3
     select GPIO_KEY
-- 
2.43.0


