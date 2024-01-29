Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D53FC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPD-00073W-Iq; Mon, 29 Jan 2024 10:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPA-0006yS-Bt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:36 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTP8-0007Pa-BT
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:36 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5100cb238bcso5004022e87.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541512; x=1707146312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oz+zTTfGm1MKa4a97HFk11IR2+Bank2vY+LpKIqyLck=;
 b=pfqxMy28pDWE244/PIe9tpSb1jXdcq6Y0PkLBLQKe2VRKLac706aog4AWxt5L4vgW5
 7agX3055VPSRQHentic8SS8iJa/9WY4arv93MU+Z5YcTAYoVNvROVw63MDMNxZXxUi+t
 5LZze8NEEsdBMZ32DEmD7FS7eM/1c3//BZn5nH6VjeZmRWwlIkmgZuj2PIMVbk9+XRHy
 E4CZLqahWCl4sMtR6RLUmNic94nTsHdMLo7dLG0xkqZhOPJWp4w4i2Tzar2qZFeFDHll
 37Dci8FUhJPanD5uRYZy6DYFkE8PPPxxY4NvfkpaY8xBdi0Uahy9QtoxxrEZTuSF6iX+
 tuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541512; x=1707146312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oz+zTTfGm1MKa4a97HFk11IR2+Bank2vY+LpKIqyLck=;
 b=s5aVPe0G37jFHgF+DJ7dVOtIS+j2GNIJUb9GH/OFUF+9vF2hJLIlHWD2ZPvqvIE2st
 rx9zpemTLO9Uguw/Vx/ZwaObDX5DP8wQLEcaIQxM4RlRFztIKKc/C+dIHcfcY3af0IU6
 dMjf6jVpWkWJkhxUlQ5fLdQKMjLQuwxKW4ganGZaK4xPxW8oLCfZr4xJ/dcqBwIofQxb
 vopuqplgr/MxxwnXxvP223yxjPQiAsmuM+WJb5nRXvUSITzPIWW6O2Xx3CMxssrIBNY3
 QXVkYnnp7bytwEQmFa5Tc5GwVzleNHp3i+xte1gLzUacnocb5soXulH4M7LArSg7yFtk
 +vRA==
X-Gm-Message-State: AOJu0YwChFePnC5BGhmYLx1aO3cgi1iFcShCbDReUfv+k2KJ5w8sWayk
 mkfWHPZneUcn8EBW1HdqkYKqxei9UlPcQhMwZAbaIt1Q1351tvfB3g9Py3zGGLWsMBFjeEV5bkF
 K
X-Google-Smtp-Source: AGHT+IE0eIR3XDm29LRt/ScifzFOIdBA1dWVj2tZnTVrHxrcd1Y0dbC3sWfeg3UxMpAhvtTuzYjH1A==
X-Received: by 2002:a05:6512:10c2:b0:510:1487:bcb with SMTP id
 k2-20020a05651210c200b0051014870bcbmr4624283lfg.64.1706541512038; 
 Mon, 29 Jan 2024 07:18:32 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c444300b0040ebfbff33csm14445952wmn.36.2024.01.29.07.18.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:18:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/9] hw/arm: Check for CPU types in machine_run_board_init()
Date: Mon, 29 Jan 2024 16:18:19 +0100
Message-ID: <20240129151828.59544-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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
- Rebased
- Remove default_cpu_type (Richard)
- Added R-b tags

Since v1:
- Add missing QOM parent for CPU cores
- Dropped Aspeed changes (Cédric)

Following Gavin recent CPU type enforcement cleanups,
restrict more single-CPU ARM machines.

Supersedes: <20240123222508.13826-1-philmd@linaro.org>

Philippe Mathieu-Daudé (9):
  hw/arm/exynos: Add missing QOM parent for CPU cores
  hw/arm/exynos: Check for CPU types in machine_run_board_init()
  hw/arm/highbank: Add missing QOM parent for CPU cores
  hw/arm/highbank: Check for CPU types in machine_run_board_init()
  hw/arm/msf2: Simplify setting MachineClass::valid_cpu_types[]
  hw/arm/musca: Simplify setting MachineClass::valid_cpu_types[]
  hw/arm/npcm7xx_boards: Simplify setting
    MachineClass::valid_cpu_types[]
  hw/arm/vexpress: Check for CPU types in machine_run_board_init()
  hw/arm/zynq: Check for CPU types in machine_run_board_init()

 include/hw/arm/msf2-soc.h |  3 ---
 hw/arm/exynos4210.c       |  1 +
 hw/arm/exynos4_boards.c   |  8 ++++++++
 hw/arm/highbank.c         | 11 +++++++++++
 hw/arm/msf2-soc.c         |  3 +--
 hw/arm/msf2-som.c         |  4 ----
 hw/arm/musca.c            |  1 -
 hw/arm/npcm7xx_boards.c   |  1 -
 hw/arm/vexpress.c         | 12 ++++++++++--
 hw/arm/xilinx_zynq.c      |  6 +++++-
 10 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.41.0


