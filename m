Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A29C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATe-00080n-GW; Thu, 23 May 2024 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0007kG-NN
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATG-0002S8-Oa
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34f0e55787aso5176304f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478509; x=1717083309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=js5qncWkemZbFOUTBcvGMDqOGolfrcRJMq2DK5PGxrw=;
 b=pWVPflS+TwQQXmmnNM7FvFotsajxVF+lze5EkjXUyXstW34QYBt/d6H8DR6gfRRyQn
 JszjINSNWY9SBIkQHiwsE8PK8XR5xSMYy2odvYpXIuN5DiJecukIQ6IuJ8H1NvxPGuc5
 GnBOQ/h5XOJ1gSVs/b2fCknpXZFRtnv8+/+fgpQJjPyRD22XKjCUxPQWMq1coQ9DzURD
 arPAKM+6FHQm7gINeUqhQJWptMPaLNSelrqsR2N/YBV+ZCNWEfWjHI+QdGWZdSbgMFra
 g1Bwz4aI4S+UW7o177Tuc3QQE0IE3896q43p9kQ88SEB/3EflNW6R/q7YDBdIiwbDZ9K
 ztuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478509; x=1717083309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js5qncWkemZbFOUTBcvGMDqOGolfrcRJMq2DK5PGxrw=;
 b=G/cIJaEWrh7X9UG2lzSm/v/TnHy4lVaiVf+97kESFiLLoPWwxFZUj9A9XE1RNCRgx8
 O659TKhi56uezWbFBFVchLefF44eiukCWN3QJgym36dv30Qn7Yjhpe7yMN5Ku+0ukKhr
 VAz+K+O0hfV2EyOq+O5G0GCGSroEOF/CzBrab2os3L5t2t70RMhMmEnK5RZeor977s54
 CTaphr2i2TYY+RQYYig4qQNJmmQlWKgrMNQeKbCdcbDXaMcCVIvmC3vC7wfelzqwZ/gU
 T96JmLdneKUgm3sopY/ODXmLgNRYYKYMM6yLIgQU+D8x0tmRvufrVhUCgCVIhBbaUen7
 aUPg==
X-Gm-Message-State: AOJu0YwXeAtq3OO/cVt5iV5u9WdXE1ZCw7zcG/p/je46eksbT3Lvx7jq
 RxVqrlF4HdyIYOTvK6lHXtx3F9qXWtn1wh+zUI79QCmARj/PeXJbPrsyBN/2webomvBxqUQMZ8X
 s
X-Google-Smtp-Source: AGHT+IFB96lRqHsZSWi2+6619mCqKfbe3BDlZ10bt7e2UMkdOVNWf8ic/C7Di9/T54CQk+uCjDzYOg==
X-Received: by 2002:adf:f8c4:0:b0:351:d7a0:d48a with SMTP id
 ffacd0b85a97d-354d8da369fmr3815043f8f.51.1716478509042; 
 Thu, 23 May 2024 08:35:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/37] hw/char: Correct STM32L4x5 usart register CR2 field
 ADD_0 size
Date: Thu, 23 May 2024 16:34:32 +0100
Message-Id: <20240523153505.2900433-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240505141613.387508-1-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 02f666308c0..fc5dcac0c45 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -56,7 +56,7 @@ REG32(CR1, 0x00)
     FIELD(CR1, UE, 0, 1)     /* USART enable */
 REG32(CR2, 0x04)
     FIELD(CR2, ADD_1, 28, 4)    /* ADD[7:4] */
-    FIELD(CR2, ADD_0, 24, 1)    /* ADD[3:0] */
+    FIELD(CR2, ADD_0, 24, 4)    /* ADD[3:0] */
     FIELD(CR2, RTOEN, 23, 1)    /* Receiver timeout enable */
     FIELD(CR2, ABRMOD, 21, 2)   /* Auto baud rate mode */
     FIELD(CR2, ABREN, 20, 1)    /* Auto baud rate enable */
-- 
2.34.1


