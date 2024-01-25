Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F9FC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsiT-0003Gl-1J; Thu, 25 Jan 2024 00:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsiP-0003GC-DM
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:55:54 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsiM-00016R-4B
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:55:52 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ed1e78835so1527335e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706162147; x=1706766947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LTjUodNM1cz/FwQ+agsvuxdNwnKZ6thXnjAI9kk5o1E=;
 b=hure3xIE0uajhbLsa4z+UrtyDXcDnOk8FD9OjbUuyG4dchJou+ZC1bO5WgdTIEIM3k
 HqzxjBxXrn/klSAhPll1WhqJWV8S7UEtQwffknl+qtFDYw2ZlNSIzBASyT0Ifl933504
 z/lamoS3u6lQvBmPAMhW6CFzpEWkOoyrYeE4SO+LDoJ3FeCgmCLVkIttxOOWqxTrJ1B7
 NN7V9kMeJQBpEl1ponzkOoJUcdP0xggVeoN+Mayxg5bPzBbevnidyzKtD400xTlxoaSW
 irDJR8wfZ6qkzsvAo8v69PazULTVbVF9EfWhQIkRWmZjzKTWJyc+aUYBwMXUcEWGgKs6
 NfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706162147; x=1706766947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTjUodNM1cz/FwQ+agsvuxdNwnKZ6thXnjAI9kk5o1E=;
 b=RQDggitFS31Hk9Dj7kkE3cP6uwIonATNAmB8nROFyRuNnHslUjei1+0t4r5RtQRmma
 rRy1aRDuQE9Xt3UOFwQQihXhg20jIZJUAYktHp8kz4ZPBnzCZ0nPA8G0fdKSWh8BaTUB
 2B/TULMg+IHVM8z8EPW9oZGZWMAduZfd5lJEUpOxNKCSig6klksHID/iZtJ1DfuUzFev
 3F4McLC3mVg/uNM4L7OIBfyGaKlY8Fzwml/aWsB6n15P9iaAPCnuxtcbzc9jnf35ZA3l
 UZ57PWwtyUY+DpBM0ilbBb1saTC4Cy9BdNuE4Oyt5oCYMjwPMa+vBoU4B5osZAhH/O9W
 uqKg==
X-Gm-Message-State: AOJu0YwVynSYFZMp3GCI8ue6fdsW0WNT5dRQV0NuJw/e72DhsF6iKjLU
 zy4QqT0pN+uKtoqotMMtwC/Qa3DgleaxHcToe9RR6Nt+cZZIbaNxy/HyO7gHMlGV8NBUtLIkVHE
 m
X-Google-Smtp-Source: AGHT+IH8UIffeq77TyMsovKwPG6RUMJkmw6FZkcgB2XjfAQjwF/3zWNY6DwUnEzCI8ccPZmMvM513g==
X-Received: by 2002:a05:600c:54d0:b0:40e:6639:6708 with SMTP id
 iw16-20020a05600c54d000b0040e66396708mr16641wmb.49.1706162147617; 
 Wed, 24 Jan 2024 21:55:47 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 d10-20020a05600c3aca00b0040e88fbe051sm1222406wms.48.2024.01.24.21.55.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 21:55:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/5] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Date: Thu, 25 Jan 2024 06:55:39 +0100
Message-ID: <20240125055544.79405-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Series fully reviewed.

Since v2:
- Addressed Gavin & Richard review comments.
- Collected R-b tags

Since v1:
- Follow suggestions from Cédric from [*]

[*] https://lore.kernel.org/qemu-devel/e13c655b-7904-4e47-a673-4efd13c26b3d@kaod.org/

Based-on: <20240123222508.13826-1-philmd@linaro.org>

Philippe Mathieu-Daudé (5):
  hw/arm/aspeed: Remove dead code
  hw/arm/aspeed: Set default CPU count using aspeed_soc_num_cpus()
  hw/arm/aspeed: Init CPU defaults in a common helper
  hw/arm/aspeed: Introduce aspeed_soc_cpu_type() helper
  hw/arm/aspeed: Check for CPU types in machine_run_board_init()

 include/hw/arm/aspeed_soc.h |  4 ++-
 hw/arm/aspeed.c             | 70 +++++++++++++++----------------------
 hw/arm/aspeed_ast10x0.c     |  8 +++--
 hw/arm/aspeed_ast2400.c     | 15 ++++++--
 hw/arm/aspeed_ast2600.c     |  9 +++--
 hw/arm/aspeed_soc_common.c  |  8 +++++
 6 files changed, 65 insertions(+), 49 deletions(-)

-- 
2.41.0


