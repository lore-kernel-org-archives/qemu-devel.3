Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AE9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwNk8-0002nf-Bh; Mon, 15 Apr 2024 10:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNjv-0002jt-5c
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:55:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNjm-0002TN-AK
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:55:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-343c7fae6e4so2784800f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713192909; x=1713797709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8bzNC3yHSozC+0IoUDb2SqpLTdqaKlXScvBV9gx/+p0=;
 b=aMQMCIM9nCWq4wemD3R4FrOcwQlr4OhiaA1GypW27nFHs736BupJWsVKme214fvdn8
 IRgiBxSaosBKnCzxHGLAR3GvyK+jyZ6Dx2fF5+MVYtNBY+nmgcLhBG5d2AmraLz9FGYC
 6/HaAa5jYGcjVdE8fE7TrjVlDZt+KtTELwYM7BQC1p1Us60HqDWH2wKQXXKAqYt9srlL
 oT0eAYGOuxUup6t36VfxmOAvqT4FrA8m/lDTDy6a/sr3UKAvFsCDosK2CLtloGslL0tT
 xI0HHjDBFahgZti8ZycNnxE+CtXKbUb1ITnzAtDpN5LQ3qcNTfHUIffQbkTF++807Rqe
 O49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713192909; x=1713797709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8bzNC3yHSozC+0IoUDb2SqpLTdqaKlXScvBV9gx/+p0=;
 b=cfgqk6vkQ7sf3/hWIbUgOL+aXpY0wYDb8Xw8P3bAEJb0dOqltmIIWzZHOeMo9aMZCC
 1UXp6BT6PPTa5eC40sgLZfGcc8cVsbv9oqF7M0japMJX5X3jp/Aa+qS4Ne+ZI4XpvYtc
 OEGN+beCLmTPk0phTWs3oanSUisCB4HtTWrUojpoAeUQ236e+7TjUoKjnaNfoz6USIZ4
 KiN2YYKHBw8Y5gyo6Yv2AumKFIZVbj6wbjXSEQUQ0nbVNc3sZ6rtRUO26T7TXxLNvQ2Y
 0FWwMLPgaAFfWpok+Yci1SIIhHacnGCcOeXzN9q1Ju35NSJjdCwAiQJp9PcTJSp0C1HJ
 vSnQ==
X-Gm-Message-State: AOJu0YwcnQzON5xSyFJ1kBwdCU8YTAc1z8be140LT5XqKAyt1kUlADGW
 k2DbviW62eSif9x7CAjMok8UbqgvAdomGeewBjJJnYqHwcC1OM43ewDNsiknHYrofz1EWbIC/ai
 m
X-Google-Smtp-Source: AGHT+IEK7aXT22QcZDA4clxSttuLZ2KAiRAY9DCWYqc4dfFzIzfSKdYv4C3NsM5uqXd/WDDOxav8Ng==
X-Received: by 2002:a5d:588c:0:b0:341:d912:1fec with SMTP id
 n12-20020a5d588c000000b00341d9121fecmr8392794wrf.49.1713192908813; 
 Mon, 15 Apr 2024 07:55:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a5d5046000000b00346df659e7dsm10874215wrt.17.2024.04.15.07.55.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Apr 2024 07:55:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/2] Misc HW patches for 2024-04-15
Date: Mon, 15 Apr 2024 16:55:03 +0200
Message-ID: <20240415145506.48179-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

The following changes since commit 824ebb92c39920a65b34a93d1bd462baf0d2d174:

  Merge tag 'pull-sp-20240412' of https://gitlab.com/rth7680/qemu into staging (2024-04-13 09:43:46 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240415

for you to fetch changes up to 6e4aceba2079e3df42edc89d44f4ee02343bb09e:

  hw/pci-host/ppc440_pcix: Do not expose a bridge device on PCI bus (2024-04-15 13:07:15 +0200)

----------------------------------------------------------------
Misc HW patch queue

Fixes for hardware used by machines running AmigaOS.

----------------------------------------------------------------

BALATON Zoltan (2):
  hw/isa/vt82c686: Keep track of PIRQ/PINT pins separately
  hw/pci-host/ppc440_pcix: Do not expose a bridge device on PCI bus

 hw/isa/vt82c686.c         |  3 ++-
 hw/pci-host/ppc440_pcix.c | 11 ++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.41.0


