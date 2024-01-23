Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E11C47DDC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPZg-000700-0t; Tue, 23 Jan 2024 17:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZd-0006zU-QH
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:48:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZY-0004GK-7G
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:48:52 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e76626170so53878785e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706050125; x=1706654925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fUPFlWLk66em0xW/7Ae8qBKLbshqAGiGQJRoYlj0Wxg=;
 b=M9JfOjwg1DHOLe2NWwAs3y0dRyw/O6OzrjmCE59nUUqUs72pbqlgUSADr0YWsbdG52
 4HF58+ZCJDjovE0YqRmMtLX/9d5Ofb4a6C47IMd8P4cWSH+vp2/N1/LlGFlaU07FNgmq
 ImXoyluWdFGOVo7hdxhePQuyv+GkJztzrrTU2d/A1qNGjEyWbCJPsgH7/6F/sJqQB354
 FP8JwI7IEDfla+nLSkd9lQ6qEUosxE5jUQL7MQQino2rL7XDeTzu+lfOYPR9grlYW4pP
 BJfl+4rt4c8nqQigERqXPWwmNX28TmrjCOZ2p/AE2a7KEXUNfpRtc/wjsBGEt18aNiN+
 C3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706050125; x=1706654925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fUPFlWLk66em0xW/7Ae8qBKLbshqAGiGQJRoYlj0Wxg=;
 b=M2YDy6WgE+qy28jp/YxKj5iB1QpyENLSsnOU5E+EHuDQX6isks46L1g2LN1eeyVEAJ
 0AoybRjWiA7pesM88o8XCcJemB869sGSeEEROiKWG14o1I5jnHIz3KByWXS9p/rfZnxl
 +J1cfSx4ZQDb+WYPHtlrsoWoA28Fn1+2TTatBi89txbCUcVeuhn5Z2moBid1mUo5pmTB
 YpRxQ0qG+KjuxqEoDZVUmxjb5IigJ3Ma9yevBJrjGoeclxiOIUrvDg040ZsQ7fs8WtdD
 Ej6oSNkSXtYWI0GSGuUKpgwkkKwfKFxjaF67/xzqyKv+gQO7BTg0GJWyHWFwnD6efiZG
 mhjA==
X-Gm-Message-State: AOJu0Yzj5VyBhIc8wJZ0fhIbHOycvNVxCTaxf4kIfaORAw8wKUKEsVni
 C/tH0EhAdXCVxzcKfTbGsTChzrUctTPSAp3R3iX6gFjeiuHNLG2qg4FwmhaVc5+OyiDxMQOhCAT
 o
X-Google-Smtp-Source: AGHT+IGagHeiR/fvt6Q48Ri6wkphdVyi95WMRg8RUUxKiS4/i+87QLKMWwUdhx5wDIROyCIdLPsmVQ==
X-Received: by 2002:a05:600c:84ce:b0:40e:44c2:92be with SMTP id
 er14-20020a05600c84ce00b0040e44c292bemr525133wmb.143.1706050125272; 
 Tue, 23 Jan 2024 14:48:45 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a05600c4f0d00b0040ebf5956absm2919972wmq.29.2024.01.23.14.48.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:48:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/5] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 23:48:37 +0100
Message-ID: <20240123224842.18485-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


