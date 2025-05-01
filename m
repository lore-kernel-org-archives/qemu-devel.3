Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC40C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYkQ-0004ux-Cl; Thu, 01 May 2025 14:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAYkO-0004u2-Ib; Thu, 01 May 2025 14:35:00 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAYkM-0007Vk-Rn; Thu, 01 May 2025 14:35:00 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso1869087a12.1; 
 Thu, 01 May 2025 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746124496; x=1746729296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9SBlCSkCVD4bmzSTB80UsQ0zXpNYjxPRjiJK/2PHJs=;
 b=aTjnnqW0LfaxeK626i5CkzrLm9VOSyBBC4qF+kAk5G1gonewNXEvqPR1Yfa3DLiJD1
 ZtP3HAXBxV3Po2mJI04dZx6csfkdFt5+MZqtDS3yYSN4EAnv90r0u38UOPC3SyTvaxN7
 81f9iOBWE7vg6q9dPfzeIqZ/K91qdRbNUtqeJJfA4CmkjKg0HNuD02bNYvnI+k95bCw3
 F/+DuwCPEPo+nBIWzB6K9bJG3fgZ703uUhBBA+2xe7UCJLrbz+JbM2E7v5h93f1WitKi
 0QAQUKmuzO7PfqRfKDS1SA/LgF7a+5HcXOCi+iNUFSs9akvEjUmSVr2Vo9oDEzfI+H8L
 7vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124496; x=1746729296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9SBlCSkCVD4bmzSTB80UsQ0zXpNYjxPRjiJK/2PHJs=;
 b=bgx4e3g1snaBhQUuoXDfDCpaitpaihm3CEdfpvLieR/r1TywlSSsSN3gAVToiSDHte
 SJMWyCwR7ydFnMn48ZYeFnelObOCQN9xlavAlYeVqmsHMjv0AfPSjHTNyvV3CgSxvDPY
 1LNhuaYhKpP/SkyXg8T2SyHGPYVtQXaQx+dbXhQKylKLjwycIQQnK56KQapZd1pH+RmQ
 geE0a96e0xilw+HeEqrHW2Sq8QqROkg33wUQQ/VwkmQIpDiVXkQ/bqjvejXU5d2Ittld
 yFE/14FV97HmbO7jwRWu2tcqk1CQ6atqQOPPE2nZCstpIyGYnix59Q8FFxA/krgIvG76
 SI9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKHV26l5pbPWzxc0vuA/eLJgL2WA6ACkXoJ0DA/uEYZNcV7J8cLxWkHiTwKAuWyffAi+FRGsdZ7w==@nongnu.org
X-Gm-Message-State: AOJu0Yxv+FIejs5rdJl2fvRSP2Syo5SKTpv4ORF/EtOtDO/pyQV8GERE
 qFde9vfHHgDDD0wHuM9yjiBYbizaCuuZXbIExBY2e2RhOp1E/OJdd7t6Jw==
X-Gm-Gg: ASbGnctTlmoSd+3jjCBU4h3iFJZBeA/y3pYHbdrqE1zjgymoCLHDfVZVpKKrXqjQV4y
 ojD1/IRxaOvSUJVRzv0woRa2hlgleAR2qkSFxqGa569vGyy2etBlIW3LO7fcHupDJZZR+3to15B
 VtjfxpoVXHmxLTR23LawP5HV59sZPJB/ClCMkkksZzPPczNaFq8J3WeLzxHkFnADnfrBmvFd9lJ
 QDwvqaWYc+M6K5lAQdkDH0tqvanNDoF/n7XuqMcKhfJhY5qVYLcAbCxbIm8dU/CoqIDCGqkUWcD
 gQZCPGeNQXBS79ZSxCjB1TtiUfvIX8SF9U6gIT5RQ01ea9VuxnnnCKXB0HdbV1CuE/JMwGLwdoA
 nLeNwP/lvjIGv1mJ8ajQ3qIDHxN8VRuZ6JzV/W2u0cgnx9tfkkvzqFTtgEYh++A==
X-Google-Smtp-Source: AGHT+IE4nGQN5+5x1RpSwi8siiCDFy1SHzB9KJb2Is3zZeBAasegPyvMMXXkDhIff3z9roFDWixD3A==
X-Received: by 2002:a05:6402:84d:b0:5f4:5dfa:995f with SMTP id
 4fb4d7f45d1cf-5f89ae6c439mr6525224a12.13.1746124495133; 
 Thu, 01 May 2025 11:34:55 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-2980-eb00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2980:eb00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f93000b272sm751709a12.68.2025.05.01.11.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 11:34:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/3] i.MX fixes
Date: Thu,  1 May 2025 20:34:42 +0200
Message-ID: <20250501183445.2389-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series contains two bug fixes related to i.MX SoCs, plus one cosmetic=
=0D
change. The first fix adresses a bug in the Designware PCIe bridge that jus=
t=0D
got introduced in the 10.1 development cycle, the other one fixes a bug in =
the=0D
i.MX GPIO controller which existed since its introduction.=0D
=0D
Bernhard Beschow (3):=0D
  hw/pci-host/designware: Remove unused include=0D
  hw/pci-host/designware: Fix viewport configuration=0D
  hw/gpio/imx_gpio: Fix interpretation of GDIR polarity=0D
=0D
 hw/gpio/imx_gpio.c       | 2 +-=0D
 hw/pci-host/designware.c | 5 ++---=0D
 2 files changed, 3 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.49.0=0D
=0D

