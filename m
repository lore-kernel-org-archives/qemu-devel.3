Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984BAD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1njZ-0000wa-An; Fri, 18 Oct 2024 10:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njW-0000uq-J0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njU-0006wh-Lz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so1925871f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260815; x=1729865615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2lDYVfRW2UdAzAzqSSVMXHFzpJAZtFQKbpf5EclSHE=;
 b=BJ3ynSViRwHs9nEmcdKADyhvByDQZfKy9hLulIBrH0qD0YEtqbc4C4x5rdqapD1ihh
 a8iqVSJ0LFB37cMB3C87Dw6GIJIv0WziaPvhB/AF8pkOKYb3CkSP3DnjUZ9Cv9Y25Jqx
 uXjtPVhk0man+mz8Df70W2U5ZiZteM7OWzdCwG8wS4fZ4eOU57MsGUJY6B/QhvXKM+G8
 OL77HmYTLDcX8HoqOUJFokpgifcHqOCALuscBiZeyoxvhtlbVXcuuqyTHdJDRFrvYUKz
 F+9MRqjU55+krJaYtkHJqy7DpRi/wu1fuD9hu1WSB3MP2jy9+8ykSws4Nnr8v6pVDBhl
 5QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260815; x=1729865615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2lDYVfRW2UdAzAzqSSVMXHFzpJAZtFQKbpf5EclSHE=;
 b=l95yAoSNAoy9OThLYV4PjdcCWJu+Lz8ga4WWG6Oyaod4LObUmZNeCpHJ1hyWFiJQdM
 LbPv6VLRMMGGOiyCy9su1BCBYXsXObkoQFchoW3vnv9aemi6zQgXuZvB+W42an13DJPu
 jDulwJmmekgjXLJOLZvN1Bqud7JG8rgIUQTXOEEQqgV+ow0QI3MvdntiEXXsOscYS20w
 ZGQuQ+Zq3SiXfZAWVzLdazJ7CbcWE3W84Zvbik7cCza9Z9c26nt7j18e2nQhERo7bqoX
 mh+VPARfNodwRbqUopaL6jUDHz45yNIsQ2Clxyz7orR2rfqlzEeyqeJWVM7cMMkheSFP
 er3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoKJCsqTZbFYd3zVe0Oba5gPJI4GGhtm17y3Gw8Rzlx4pnSG7oSoMjHH04rWD6HchvScTYg94vgl4q@nongnu.org
X-Gm-Message-State: AOJu0Yx6xUKoUDYH7TOkqV4TF8Y4roBlhBQq9YmjC0JO5oDNSIW+zaaX
 caY4d5b0mVzIS5rEBA0a+CovR2WkBIYDaXwf1iI5fNZjBUkoH7oW0IMfZEPbeGw=
X-Google-Smtp-Source: AGHT+IHh+9BITtOsB3WacxP8YgdH8C2te8mHYrrqdN2oUlyuxXQYQv5L2XHaLfZNQhYo5D/P2DsAfQ==
X-Received: by 2002:adf:eac8:0:b0:37d:397a:5a05 with SMTP id
 ffacd0b85a97d-37eb485ed73mr2364472f8f.54.1729260814993; 
 Fri, 18 Oct 2024 07:13:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 1/7] docs/system/arm/stm32: List olimex-stm32-h405 in document
 title
Date: Fri, 18 Oct 2024 15:13:26 +0100
Message-Id: <20241018141332.942844-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

List the olimex-stm32-h405 board in the document title, so that the
board name appears in the table of contents in system/target-arm.rst.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/stm32.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index ca7a55841b4..511e3eb9ac1 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -1,5 +1,5 @@
-STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``stm32vldiscovery``)
-========================================================================================
+STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``olimex-stm32-h405``, ``stm32vldiscovery``)
+===============================================================================================================
 
 The `STM32`_ chips are a family of 32-bit ARM-based microcontroller by
 STMicroelectronics.
-- 
2.34.1


