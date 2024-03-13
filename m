Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27CEC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 22:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkXSJ-0002Kc-L1; Wed, 13 Mar 2024 18:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkXS1-0002Jf-Ge
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:51:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkXRr-0004Gh-4G
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:51:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc75972f25so2883435ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710370305; x=1710975105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KYGeEP6iiUl0HDjOn4TaQUlkmehxPZ7qemoUKG4d+H0=;
 b=Zqr8PEdIcsfJfYUojLfRBDOgEEjw59k5vsagcuv6YD5aNnisnyTAnP03/ApNcF7Jex
 fcbjXJ0/0BkF7S8uWCzYWOypNdY0B0+jNoz8ISUk/4gBlpndJ+EhDNttVBHHZP4+2ojC
 ZzNmStkCKB0wPZSCUQ+AUcAEEubQHV7RFuDI4y91N8gghqs7yTHaBogP4OXMLuHS9rtO
 SPZzeKwILFU6szcu7EXGX1KiZ8HKBf8E2dGQkluc1YUrpHUwpvgH5tT6sWMVKX8k4cYF
 QxejZyaR1RacW15PA5blcxvAirMyYfppMepEpnW58v70wtdcjwRKr45jZANq8K6l13L/
 S0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710370305; x=1710975105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYGeEP6iiUl0HDjOn4TaQUlkmehxPZ7qemoUKG4d+H0=;
 b=AgU/pcx+7hzx/P9NF9SQPqLs2WrIr2+6sBiS9V9ey2i/oOGXz/lxgVWn/yQEVu/Szd
 hGis+WpwQmFRWw6XxJSUStVB9poNJzkxS14JPalvPSuvRjCF+x9fGDslh2BuDuh9rRu4
 FS0K2wDkiJr1+407iJI6AkfQT1NTEcVaWihf1IjIZn+RAKKQxOEMRQYfwwLLYt8pRuMk
 ye09aMS/U2Tsz8GP3mk3duv05CVYNfiTv2dI+zGmI1l9DqFlWE4K7beca9T7w7z47hLw
 SgiR9i9N1uD27VK0lXBfM8DElRnTYotZonqsYdi/7WxufnOr9DL84ZYquXqcu5Helfq7
 Go/A==
X-Gm-Message-State: AOJu0YyULNI9CyqTQ3xUXVGpXyGNhISpaV8uy31DpNblluC401znFOt4
 /uacruRX3OkxacjsEc0sTfw97GnIKchgKwCTbylELdHiYnDYwAOiKkMxgn5QjNYScvBoWOMyrsn
 z
X-Google-Smtp-Source: AGHT+IG8xPNHuD2tCcDq0dnqt4oI2DN/Zg5c4ujp6vTYNh86KR4qzJXAQ07y91dmjypSD8qpq5aq4w==
X-Received: by 2002:a17:903:1251:b0:1dc:696d:ec6e with SMTP id
 u17-20020a170903125100b001dc696dec6emr185390plh.21.1710370305314; 
 Wed, 13 Mar 2024 15:51:45 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902dacd00b001dcfc68e7desm137269plx.75.2024.03.13.15.51.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:51:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.0 v2 0/3] target/hppa: Fix some wide mode displacements
Date: Wed, 13 Mar 2024 12:51:37 -1000
Message-Id: <20240313225140.812202-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As reported by Sven Schnelle, fixed via decodetree functions.

Changes for v2:
  - Fix extract_16 implementation (deller)
  - Adjust some local variables to match arch doc field names.

r~

Richard Henderson (3):
  target/hppa: Fix assemble_16 insns for wide mode
  target/hppa: Fix assemble_11a insns for wide mode
  target/hppa: Fix assemble_12a insns for wide mode

 target/hppa/insns.decode | 49 ++++++++++++++++++-------------
 target/hppa/translate.c  | 62 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 26 deletions(-)

-- 
2.34.1


