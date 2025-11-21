Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DF1CFA761
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNY2-0004bz-T6; Fri, 21 Nov 2025 04:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMNXv-0004aN-3b
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:35:15 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMNXt-00040e-Lf
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:35:14 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so1246308f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763717712; x=1764322512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lscgF91ypRxV9/SV8iyaXiAxCk048Dx6xn/+pJER6kE=;
 b=oDZ0FevemFFkOhbOWWO2b9xbMh/qwbcqYx0Yz3z235bhXumYxdPfdzvmUZ5kw7NchQ
 IOl3ej3sJ3tpGcJ4xNoUYuF+B9CI3rUrnluvtPPDMIZ8jh5gjQD4YeOTqWVmy7OhWXCX
 AJ8mYrf7hHkcf7LGkD15KMYANPhKCMzabGzQ2vsmpP70mPrLwHfqzvQHDveBNnnFZlgr
 IAV6/vJkxBiI0eJjtaGQciykvBHkvSO9+iO2t1U7SqQQO9tRZz9NpK1y+0i+tZnWpMEB
 eVNwhjUr/FATC11AJYBUuzGvtgkDlndSFz2ihfXQCURznlzirifX/omQRXgzYfRGoG+Q
 vQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763717712; x=1764322512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lscgF91ypRxV9/SV8iyaXiAxCk048Dx6xn/+pJER6kE=;
 b=vNbUoyNHAr/R3z39rzlp9Mu9jOt31G9g1lGISodaxcXCKCEiHKVH0W6X80uIofezYV
 urkv2CNDlS2kAq5w2rOo1ZzDzRnZWSTeDzH5O2iqNT4P3XOcykufIkDICWQiP3ejNnxL
 HsoJhHTDpNQxy0HjphlHEW+2fZMPNdlWfhg0QzPv0MWgmYb7kajPOHaTWty+IWvohqfN
 kHlK/pu8TAuY1OPXDnsgKGsebfg+QHRH3WchhjG9hI85MBJWKu8RBazRfVdj1i8B2G+p
 hGhW1BKdx/z2ShdwxD8Om05/trWhHjJD/5ZhiGIY/QKdZ5h0adljgpNqfLQ4NgivNOYC
 IRRg==
X-Gm-Message-State: AOJu0Yw5MOOUuVqZpEAp/w7pdWfzpoFmAO3eMbO7Ri1HM6Ji77li9w3k
 gZPef4lXbVf/UISPKxMG3YjtkdOUopwCKN4WmRjz5YqBi8TUaZTvKLMf7NK0e6WDPLwHpOT94dG
 kiukvnJgjZA==
X-Gm-Gg: ASbGncu0vt4NE0qp/a3JDNYtrzwBovqStvmjkjC9m6n2N3Ob7+42N5PdPBpb4VioK4j
 zeZ7qAFTaiaLDE7FyjD/ESZCX8a5gzaz1FCSq7OO1Mq/VDCMEREcA+aGRUwHD03bU+9NNEeOUxM
 ODy+PfGAQhv2dbbSqIS7odQsBu/zg76JH8oNKB/tX6cBkr3RS07CKhXPGzEJQmiQ6HOIBuGQHx6
 EpflNQhh8DjnGi/x6Tj0rCHQh6fNizX/B8pVS5QkSdtpalQhTkk3sp3ND+30b6rz6c3AbQNgavi
 +3RXGdUSsKwoUYnfo6uPeysu01MA9pwpVbvdriR1BZ7YvzzPaRG+VJhWbHky2xdawhkJUhHVxlG
 gYSXpcO44VSyGSbgRFhga91PwIKrBAcl9z19bu7icF48F90u6a9Q4o15S2jokq2BVAWZGled9Ri
 6uoElvWaZnSDjpvOEdl28z9W+C0PLxc55mke/QIeuAncAT9imuy4/tTt6pYNTT
X-Google-Smtp-Source: AGHT+IGwrnp1eKx+lCMYDkfzoWz7Aj53lG/PrYMZiv0/816IlixTS3nqNyNxnBoTzfOOi9EMY49siA==
X-Received: by 2002:a05:6000:40cc:b0:42b:4223:e63c with SMTP id
 ffacd0b85a97d-42cc1ab8944mr1545447f8f.11.1763717711814; 
 Fri, 21 Nov 2025 01:35:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba201sm9965392f8f.32.2025.11.21.01.35.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 01:35:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/display/exynos4210_fimd: Remove duplicated definition
Date: Fri, 21 Nov 2025 10:35:09 +0100
Message-ID: <20251121093509.25088-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

FIMD_VIDWADD0_END is defined twice, keep only one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/exynos4210_fimd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c61e0280a7c..6b1eb43987c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -131,7 +131,6 @@
 /* Frame buffer address registers */
 #define FIMD_VIDWADD0_START         0x00A0
 #define FIMD_VIDWADD0_END           0x00C4
-#define FIMD_VIDWADD0_END           0x00C4
 #define FIMD_VIDWADD1_START         0x00D0
 #define FIMD_VIDWADD1_END           0x00F4
 #define FIMD_VIDWADD2_START         0x0100
-- 
2.51.0


