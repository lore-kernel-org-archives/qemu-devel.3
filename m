Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B83DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 16:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLdd-00015u-BO; Fri, 25 Jul 2025 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLdZ-00014P-93
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:51:13 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLdX-0000JN-JM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:51:12 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3141b84bf65so2296196a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753462270; x=1754067070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sc7UIkEgpR8AeMO4NYv303wm6GTONTcLb4gr7qERJ+E=;
 b=nZ9e7YWqKBxL2uMgAH8WniEuvh3Xt8t20Ek9iS86ge8cnRz/FoB7YmCmezAeHTiFqH
 yp5JQOBn2sVmXKgZl/87H3gnEJ3XKlkUgH+/6IhJ2kH2dbEfFyAwYslS7L7hU5Xe+Swc
 uBKnT3wjzQ9nl1nN1TU4DdRMP8+OIOlAilNs6TwgpXXh6LSVNYTOVMxsJDcQz7slJ7wC
 iCG/DUB0RHF7A1au0G3GjfOGXd5MvQTdqMAcp2Hn5KZNQ3XGT8q96wiPKwlP2Gs0ZffC
 kvvltFxR0iR7J3ydYOW+JJ97iCDMBCGlVTkXBrRDwe2IX2e7erejisEKx8SCuIKFypbn
 E//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462270; x=1754067070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sc7UIkEgpR8AeMO4NYv303wm6GTONTcLb4gr7qERJ+E=;
 b=Jv15zhpgYsVmugZP4mTWhnE6M/eLdfrOEqBPmDNoKWe69bxOysO3Ji/r9qGNHc1Fny
 enoMzm00i2J65NGAKsZ0tKSLKEI+1e1s4EZgA4sAfRbW0A+Y/PCGLiS/IQOfprQ/b2P0
 KjERfs9LbfTYuRSVrYvJQ6KCGnttxoR9iEhA9AEpIAiHcMKlbqLif2wPFol96O2q9S5g
 /8RN+66Vis5ygwGK9BTj4yaIb+1W2cXt3I1TVnvDg4krfG7lTY4XWQWp2JIlMqNAwEv3
 3E2VzNQLSu9NuXp8VDh2S0tbfRr9HQLM66hBT+vv80ZsoHq68/42y9T8bocw1nwlaHXT
 vTag==
X-Gm-Message-State: AOJu0Yz0KzPa1LRrtHSMVHU06b8uA0vMOMrrLYPfUxoUWWaBfrFxaBgr
 fevK0uRsQHYZcoIPJdRCfottZLKjsk0HzNOEFHKFgkpT8is/kxZTO7yy5zRBjEbeXxj5Mr1RuEI
 T7+jZ
X-Gm-Gg: ASbGncv0KA1nJr8KRA4EEITaX11QAom+v58finWLJI31ow1fksiBRawGwpbkxOEm4mC
 V1IiMtYm2HpvUu8aaLFmLYrrikeiXynb878Kzt727OZ5EvCzLTlYF/XxRpl8ej2gl2GwREAF/6T
 stcZy57RWhmIt/WVDH2dHTTRg16XjImdFItxH5/qJFoj+K+e6roMPuJwtsVHci53JPbYUcNf6E1
 Ub9+A8JYwEFkHtiIOwB3uIwgE4WE6gsWYqGG9Wp7Sg4MY9kQ7V+xVG6lWgoyczwupYdWEg3g23G
 nMx64qUmOqdB1cHMVbmHADaNlXO1sE9Ee8yKvbRh5YkZR6H/hhD/grCb/KENIMdMtu8ZU0dS05Q
 l/ksarMjR9vXUeKQiRljVvjB890j5ANfvY2zS5X4t75NY77W93iPRhyVj3A0eaeJXbpl7R77FVe
 BsW0jZ0QZ5Z72VesNqhazf
X-Google-Smtp-Source: AGHT+IG6jn5SC/BXPG6R7eXi2pw7BVd+EISuWQ0Akh5IXDB2w7JL8GtzQP3HmOsyEudAtCcYmOYpIw==
X-Received: by 2002:a17:90b:4d0b:b0:311:df4b:4b81 with SMTP id
 98e67ed59e1d1-31e77a02716mr3509384a91.25.1753462269856; 
 Fri, 25 Jul 2025 09:51:09 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6635efc3sm3864080a91.22.2025.07.25.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 09:51:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 0/2] linux-user/aarch64: Syndrome fixes and enhancements
Date: Fri, 25 Jul 2025 06:51:03 -1000
Message-ID: <20250725165106.37105-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

The first patch is a true bug fix versus the si_code of some SIGILL.
The second patch is new feature, adding the ESR record to the frame.


r~


Richard Henderson (2):
  linux-user/aarch64: Check syndrome for EXCP_UDEF
  linux-user/aarch64: Generate ESR signal records

 linux-user/aarch64/cpu_loop.c | 20 +++++++++++++++++---
 linux-user/aarch64/signal.c   | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.43.0


