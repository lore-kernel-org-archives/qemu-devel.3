Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFA6C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEtt-0004NW-VU; Wed, 12 Feb 2025 10:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEtp-0004Mi-6V
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEtm-0006rA-FR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:40 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso150092f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375015; x=1739979815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4vm6afgEv8gVUTs+JOz0gnkTZ6lQwFtG+S/fZI0syuk=;
 b=lI5RI4cklAK3YPQyiJ4U0ZkSPQe4N8PDLz/5KSyTg7FWZof2DETWrzMbaBPBugpiK1
 MwBt6lmwfrB/d9cfsDOLXF9R/Zc+KfFUfRgN1YFuUTVaMQMOtEL2+uYXfiCn/E5n3w2m
 EEI9+tV0WLIoziwEOjDCM0Wgc5/pK9Bf7vE8QDv2Op61FRdfNkMqmFkbKzIC0/nZJBQt
 zhUQQbv4pHaOczL6JGd3JlywKuu6FbCoubUiYDf4ML+IJUMDEpigNOMvuKa4EAnjZpt0
 sdnuE/VC3YzQlrJ/AykVdMD6J3MUr1EYPEM/e6o5bUsjE9s6pCtl/6AbTuMFnmSPyl8P
 RPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375015; x=1739979815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4vm6afgEv8gVUTs+JOz0gnkTZ6lQwFtG+S/fZI0syuk=;
 b=A1rb+KsxQ/7pUGIZd6IY2qxhI7YL7FRQW0YZKmvUcQgM9pFTO1yvZSVOOsE/igafey
 lHSLkgHVibVfY9jy22GcwqKqg6toBywD0uE3WL+c4etpswNiWRlCFBRSR9ldlMCLpRV4
 1cBWitF9YryNxZ/JQyIerg+9309W17fTJAiJjcWq1IGLwojr9bRcP00dynj2cpUv1rZa
 Viht+xV7o79NQ6XD+yKySZczgt3sfsn7tbL+IfaqObrdb2p6kL/hnQJuhdSvIfDjfisE
 OAu6EYafB74cO6hkXC5maN+3uqygk4GY0Tvxo+6kttr+UdU2ByzI58cx6asgon6SD3tM
 YYYA==
X-Gm-Message-State: AOJu0Yx/0tECtvobvbVo6Djcd7bhqDS1uCSVNbgTxoGXwO4IlBuAH8Xw
 1KB0wJXwquhW0MHpChGtVnQc3YICoWiHuTsZgnezVCBKb/SdedxNXpOKXri9Yn8HAq1cj88XIWJ
 Tlas=
X-Gm-Gg: ASbGncv7jwLjMSTFWuDk/HPuwQrEFBbFDMJE5a6fsFrTsGYQTZBUCQNn2YdoB0BKjJO
 ACA+ahRSwoH3U9IG0HlAX8g5M8HkJ6VNsE3HWRt1oNDzgZVy+owuu7rXF3EHyeEwmOV39Q2BPdR
 3LePuRlkA0xhPUYK5FLcP7U3zISvK3uYbIqnqVII0iz5E0gUu7vEXiXlr9ByD77pxURLPzCvAnA
 hbLYCZRJrLepo36pdrxzsxNI2LRH921TtfQ5LU/i9FyRRyD77lSs/8MGa6R1B56emXNpO4EhlWN
 jIk2ewZeS9L9iuZnGoqS2V4ONrLB0L20nyZM6Eebq2o95BR+VzKe7vfUsg9oAnpfmzijJP0=
X-Google-Smtp-Source: AGHT+IGBJwX5eQdWH7GwG9724DI+55yzHVoJRObhbuXv4L0SOiIPm0Htpdg78xICyTOA+mxdY4j6hA==
X-Received: by 2002:a5d:6dac:0:b0:38d:c56e:f1dd with SMTP id
 ffacd0b85a97d-38dea2cf642mr3755338f8f.38.1739375015620; 
 Wed, 12 Feb 2025 07:43:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b8471sm23415105e9.37.2025.02.12.07.43.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:43:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/8] hw/arm: Explicit number of GIC external IRQs for
 Cortex A9/A15 MPCore
Date: Wed, 12 Feb 2025 16:43:25 +0100
Message-ID: <20250212154333.28644-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Some boards based on Cortex-A9MP / Cortex-A15MP do not explicit
the number of external GIC IRQs, using some (implicit) default value,
not always trivial to figure out. Change that by removing the default
value, requiring MPCore objects to be created with the "num-irq" set.

Since v1:
- Remove generic comments (Peter)

Philippe Mathieu-Daudé (8):
  hw/arm/exynos4210: Replace magic 32 by proper 'GIC_INTERNAL'
    definition
  hw/arm/exynos4210: Specify explicitly the GIC has 64 external IRQs
  hw/arm/realview: Specify explicitly the GIC has 64 external IRQs
  hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
  hw/arm/xilinx_zynq: Specify explicitly the GIC has 64 external IRQs
  hw/arm/vexpress: Specify explicitly the GIC has 64 external IRQs
  hw/arm/highbank: Specify explicitly the GIC has 128 external IRQs
  hw/cpu/arm_mpcore: Remove default values for GIC external IRQs

 hw/arm/exynos4210.c  | 10 ++++++++--
 hw/arm/highbank.c    |  8 ++++----
 hw/arm/realview.c    | 11 +++++++++--
 hw/arm/vexpress.c    |  7 +++++--
 hw/arm/xilinx_zynq.c | 43 ++++++++++++++++++++++---------------------
 hw/cpu/a15mpcore.c   | 18 ++++++++++++------
 hw/cpu/a9mpcore.c    | 18 ++++++++++++------
 7 files changed, 72 insertions(+), 43 deletions(-)

-- 
2.47.1


