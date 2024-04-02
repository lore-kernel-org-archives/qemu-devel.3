Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A417BC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf6i-00052o-Gk; Tue, 02 Apr 2024 10:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf60-0003KK-2e
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:26:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf5r-0000Oi-8O
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:26:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4155baa696eso18307415e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067961; x=1712672761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+fO7oYBR7TJebc9irMjmG12sytPdpVdcVHcme4RXSE=;
 b=OpAHjBMp1eX5zuX7XRQ2kN1WEbKjPq4bL5y1pjQA6KovJJkhkaTB0axW3gVA2QuYUv
 tBhSDvUPB4vmezF02WHIUNgCqEuBiEXIFvRwAxZCWY2VpXG2PHhhQocz4tIOLDNR1HW8
 5BxG5FxG4NvLLYR4QkbiOqpFHAa//4LeBUXG+faT4g1hadGtULl8/bmvMKICh0p0rC+u
 WV6zhJO/WphMgdbF/1QHT+gQZeKwM02d12edumS9H4l2/G8HOvVM461pus/u5znILCYB
 uhzIcdZ6uyRDwbE894wmbnW182ClP7Y9HcjPzfm6b4Zw8gyEUF1k60a/5oZZeo+Zr1yH
 g2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067961; x=1712672761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+fO7oYBR7TJebc9irMjmG12sytPdpVdcVHcme4RXSE=;
 b=hHQ3CixOxd7QZ3yPVauxK5Z0SweMtBBN2eaHjzDeQekkrKGU81wEJn5jVQKieBxg8n
 Wz6+nDEubeVTqX4yUE3vkzYS2o1FJZnJb/ExkHVTnX3zEnwG8kkgyXotajU3EFm1YAQf
 gRG8pv7JPrTiy1ugLoDSDisoCy1CpvP/F1CvgbDA5DvxPdVwTld0kuGsEZcycmuP6iwm
 85ms1DmM8tFgZ3KxEPGKAtrYGSBBgnJxdryJgV0IuuiRLVa0KQ5kW07wNqBCwjbnqpdL
 K/8JplRyXJljlRfKYwd9qEK8v8hpsfoM9D5wsTj0RsWixbPHECmYy8rdm07yRHyxFfbC
 /4Hw==
X-Gm-Message-State: AOJu0YwMgNyB40nXoqNKSMFTBW+H1I0HSA39Favw/GIAgGb5BjxOGIRI
 jOulwprcasTlev56lWFlYOomGtQeiZ8Rbn9hruwqNPUlRqVGqLON19vOVzLHYQMWMPvQX4BIYsp
 HJ2Q=
X-Google-Smtp-Source: AGHT+IFDQ96sSk7UlJhfdLan7XZpN4NSRR0kfFNYVAQfR3LH07i0y2URirND7uiku+7YhxrJ9OIngQ==
X-Received: by 2002:adf:fac4:0:b0:33e:c316:2a51 with SMTP id
 a4-20020adffac4000000b0033ec3162a51mr7397994wrs.27.1712067961597; 
 Tue, 02 Apr 2024 07:26:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 g1-20020adfa481000000b00341e7e52802sm14396909wrb.92.2024.04.02.07.26.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:26:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/15] gpio/pca955x: Update maintainer email address
Date: Tue,  2 Apr 2024 16:24:28 +0200
Message-ID: <20240402142431.70700-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

It was noticed that my linux.vnet.ibm.com address does not
always work so dropping the vnet to see if that works better.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Message-ID: <20240328194914.2145709-1-milesg@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 197a06b42f..e71183eef9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1545,7 +1545,7 @@ F: pc-bios/skiboot.lid
 F: tests/qtest/pnv*
 
 pca955x
-M: Glenn Miles <milesg@linux.vnet.ibm.com>
+M: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 L: qemu-arm@nongnu.org
 S: Odd Fixes
-- 
2.41.0


