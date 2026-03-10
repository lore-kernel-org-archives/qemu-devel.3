Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618F6EB106E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzynq-0007r7-Fh; Tue, 10 Mar 2026 11:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzynk-0007PR-II
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyng-0000TT-2J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so28187955e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773155709; x=1773760509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JBO254OXcyxuexxiSJRAkJvpBHGqkPF+Kc3tWsQuVWg=;
 b=xj+xGz9cGmPm+Ql+lFFAJWkX8JTg2JASe6YwfgI1NrcwXFBPG+NBhU6bPlA7ogoeLb
 fgfNTgsEC5NXzM6Lvf+POxJIk2mwEKncWCF+lIJGRmmaU2hCbgbc3kaGXhYmHXlFRoA+
 gJz0uviSGFp0nuLIQ7OGKtOLg5Im5XZ/B59vwYXm9SJhgAkuAfVBmubHSHm+A/t51vj+
 gRCa7fTHkMbwxVqSiKjAf6hPTGEU8xrI3zNPmA24Ih1ODXHVQT/9ZZFi7+EMHCiefHAE
 I3rDvWqWe4MrQpoSBa502l3NCGesN/3uLULncwpsGmKYhLuOE/J7+YX365yL7kXn0Lmg
 O67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155709; x=1773760509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBO254OXcyxuexxiSJRAkJvpBHGqkPF+Kc3tWsQuVWg=;
 b=AhxXafec1e+gtMQfhWwbpaTQ5CUaU3QOwZRvT63jQHrfxjjLv2HgwOh8PE24Nhhl9W
 KRbjthnkZVyLTcZ2up/4O8juvv6QwjCpGKsaUKDv703MV8dL2njBv5rxUY1CvQ3CWZp+
 T3vi5Wz0ZPR4b0fyPlhXJxrU8RSf62dLNzBtPmM+DJVz5Wev4/XHxLn7MrxDABbEb0VZ
 t9owXg9hTvs+7hTattkPhhNjrjYvO6AS4tmOmxYmL4IyE/Lm+DaM3rp2wSWauwXj0omS
 7C4dotwuLqbFapOERRIm/AT1jZh6AWHgBjINORwDrG4hD9g6FVoPfRDoVWywJC5zVKbH
 mIrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpYK/hY3Ls1pkkWnomG2/5DZbvp/dx95m6wsSEy42/5ocUz0uQ22Pi6AA61ButUQ9Pq/IXkFii7B8u@nongnu.org
X-Gm-Message-State: AOJu0Yz78GZgFrCltCnUltREsrxPKFDJ2/m+1ZnHGMqPKHXLUPIYi8Qz
 XRG6cpo5SPlSe+ZHkFg2fAhi32N6SFpLJ7FNxLRMWB9D2KqYHeyWZ84s5a6H80ebi1M=
X-Gm-Gg: ATEYQzzGYcE8Vv93jY44P7KRR2ZRo24tovrLusSU5t6N8xdWcBrwLjvsoStBE990cka
 hZ85DwCe0hVjtwXoXo9wpLfP4LWIvVo/4/F5FdyDrjYN/+K6ukmrHkbsZH5OIL5un68Vm/XpZHv
 pjsUFQF7yLaffYRAHpP7HOclz+ZEFms1sPklZQ3SiPVS10zu9N7qjLYrqxLJ2Ra62beRMvQgtxY
 YI2MlBXaFWQbDMxoaZf2dyICXTEXN/UEH8c8CkI0Dw9I5DprSxwWN72TnWzPQmWkmi8VGfWMdx3
 zsQmTbl6tqCQKBWWEVldxTG5KHSuWOCuDvwY5gkY2Z8zH4AjnYs8r5of9AxwAfjTKzspiJLMcyR
 THiwh8MzVx6hIv+Uo68Yft+7fjEkSBsi2+uu8SFI9vFPckelBJumU/jLdWcb/u3Mk+sWKRY+3d6
 Zj2uMMnfQ/ywNuxZKC4rLp/Q6RU6P1GC98NcZJsNy2oSEN1ECIB1zn69YRifzUFcaws5hyXc7Oc
 yqJAH0jv5jfmrZ5/oXBCHlpTDYnfmY=
X-Received: by 2002:a05:600c:4e4f:b0:485:3f72:323f with SMTP id
 5b1f17b1804b1-4853f7233b2mr89907065e9.11.1773155709284; 
 Tue, 10 Mar 2026 08:15:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853588758fsm127303185e9.4.2026.03.10.08.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:15:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 0/2] tests/qtest: Avoid char arrays in some Arm tests
Date: Tue, 10 Mar 2026 15:15:05 +0000
Message-ID: <20260310151507.2973843-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

This patchset fixes a couple of problems reported by Fabiano Rosas
with gcc 7.5.0 now we have turned on -Wformat-overflow=2. In both
cases the test is using sprintf() into a fixed-size char array, and
it can't actually overflow but gcc doesn't realize that. We prefer
to use g_strdup_printf() for this kind of thing anyway, as it is
much less error-prone, so switch to that.

thanks
-- PMM

Peter Maydell (2):
  tests/qtest/ast2700-sgpio-test: Use g_strdup_printf() instead of char
    arrays
  tests/qtest/arm-cpu-features: Use g_strdup_printf() instead of char
    arrays

 tests/qtest/arm-cpu-features.c   | 24 +++++++++++++++---------
 tests/qtest/ast2700-sgpio-test.c | 24 ++++++++++++------------
 2 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.43.0


