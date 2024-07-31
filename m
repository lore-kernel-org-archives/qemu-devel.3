Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F4AC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGoo-0007aR-Sc; Wed, 31 Jul 2024 17:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGom-0007Yl-JQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGok-00029F-Uu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3685b3dbcdcso3469177f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722461105; x=1723065905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YsjYVkRSnsXvC6SnYIGaU9fq114orUELIsO6B55S/bE=;
 b=D+sAHf1tRc15AlYOT64pb0noWE6Nki8hSl57dwchUbPcvJjB/Uv3TtCntswti7XJBZ
 n0Fv5IjqSkzTa4fW/5oj/pWUOMlMKK0f0G+scfrmptL41yVElgx1NUeIoxlsacZo0a10
 tfOADXF6AFUZi82kAuqpkgJWFbSNAZ5UVQhLPHu7rON7k8VtZF+6X/UNzV+8UPF2j37K
 FMq/JPUr7l7zSD8GJbQn8fbs/t1qQ6n01xOqGILCYzMUyl0DGqixHxNyPj/DrRsY2I06
 9dBCg4bI70isZNbQR8Br6AX37ViVB0Sl7yrlx83c/npOGLwnbLMGsmKxGHGLzqIT5NM1
 fpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722461105; x=1723065905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsjYVkRSnsXvC6SnYIGaU9fq114orUELIsO6B55S/bE=;
 b=TTelUloXnqdocpXaSAYVFlSnCTSPHplm2xfM/GE58fvTpg9Fl5NZj/FXbrN62co/XO
 HQD3gyM9L3oSBc43JRaTG3+Kzy1tqAl9MIOZSBKX/BanibJ01XC8as3ZAETKyYwag6yX
 N+ADH4EMPtmjBCowH27qONgcuIW55pMb3vPH2R1kmK9NOKvnspoYMx4yf4N8bq/ZDlW4
 6zI0IO1UMnb2rg8nBgEAMfrtR71dHTSyBr2AkRFgpzwR/kZig0qE6v6gFNVzWq6mWTJ6
 Rm710qhQXpBTRdgPWGjTFiLXBaT1DYzrSx9FMXGhaZN7D3XZwo15nv6JgBGmaKgLhTvI
 Z4vg==
X-Gm-Message-State: AOJu0YzHUYRZJ8yURepvBhrq2bmNLcAS365a/FO0GcSLR6cQzq1Fg3uu
 yYsSFCaSaKZ2+hJ5Gx0MiQK1QdDDjQL/rAnTD0OAwtX5XcSYYFXgdhYmmrfqXFy0auSW2Y2SSkw
 i
X-Google-Smtp-Source: AGHT+IFtGTyyB1cdulqQFNvP3+Ovsjt09lOAbHpndJbveXcxLvieZd8rFxlefUXNqi9azs2y8pY3nw==
X-Received: by 2002:a5d:6510:0:b0:367:326b:f257 with SMTP id
 ffacd0b85a97d-36baace4feamr316595f8f.33.1722461104967; 
 Wed, 31 Jul 2024 14:25:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857dc2sm17849498f8f.77.2024.07.31.14.25.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 Jul 2024 14:25:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-9.1? v2 0/4] hw/sd/sdhci: Check ADMA descriptors can be
 accessed
Date: Wed, 31 Jul 2024 23:24:57 +0200
Message-ID: <20240731212501.44385-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Since v1:
- split patch
- do not return MemTxResult from get_adma_description()
- single DMA read in SDHC_CTRL_ADMA2_64 case

Based-on: <20240730092138.32443-5-philmd@linaro.org>

Philippe Mathieu-Daudé (4):
  hw/sd/sdhci: Reduce variables scope in sdhci_do_adma()
  hw/sd/sdhci: Reduce variables scope in get_adma_description()
  hw/sd/sdhci: Read ADMA2_64 descriptor with a single dma_memory_read()
  hw/sd/sdhci: Check ADMA descriptors can be accessed

 hw/sd/sdhci.c | 117 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 47 deletions(-)

-- 
2.45.2


