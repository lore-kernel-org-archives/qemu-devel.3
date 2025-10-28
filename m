Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16280CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDefg-0005w9-VT; Tue, 28 Oct 2025 04:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDefe-0005uq-PJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:03:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDefZ-0000n5-Vi
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:03:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso69831995e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638580; x=1762243380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AaJsVvVhH+hhDSMcy010RCCK5d+kbdBS7ibwzW1yshc=;
 b=Y+DsDo206vPP3uUwmVtqRs/En0wyYN+LfiISrBOjJbE5oy8hJ1S4vYtuJqhpIQIpqp
 qoq7S72J5pRlRsBLuPJMBXEN5hptHNK8HgXKHePkHn+VHbwQhiiiOLrU49SKXpPYwu0q
 dMshZX79bhsKr5HyYtTb017jsMKiTUZv1wcE02DWdli8cv3tkRl6oQv/W0xKunIk/iqg
 x1KxtVgM2ffql1mAlkHBwiserIHW/x+3J5cxAdqLqlaXan4i8J/6tFaa+d2fCmKhoT9A
 Z+6yDjSenOtsxqnUAOoio72GeLwT6SgJzaNPolfy5xKP+/JW1k5yaJBNnPn/iV5AmDIb
 i8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638580; x=1762243380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AaJsVvVhH+hhDSMcy010RCCK5d+kbdBS7ibwzW1yshc=;
 b=BfRNgsxkzrWKmRPFy3/1VMiLPwbjGKnMkIAggfY029zegYxW7EfA3LEeDXvbpH2OrB
 uhxfhpCDO4KBdNHYJbRHAWM2hDHV6J38Yc8fvMLMd58F/oHSYvMXgMGALMepYjcSXBT1
 mcpZIBTN7zk8iRdMt1auI7+EjY7twsNiu6RVSbLy1Cll7QoTh//ypDqpS52RzI0Mh8yC
 a8r6OsAf662NgtuVsaDJAcqJ/OQWcNVH0ka8PZLi3xm2ZuKgkyLzQU3YG3kBAa/kz1W2
 9g2VZ2h2GK0omvGebcuhr2M84ikR04yQGDldosPB3oiS8jNbEQTyS5O/fJ7Yk9g7V0Cf
 e99g==
X-Gm-Message-State: AOJu0YzWyjAsB0EMLQQP/U5By6mTlrbyUdNtawQCadvX9Qzd666u7SWe
 Q9BHPA6oMneX3x9AmTHTMQI3fPnx/DJvEJIw9wV566ub0GnRAmYGTRx1em7bg32as5svYcux2YG
 5d64s0II=
X-Gm-Gg: ASbGncsgp5yFS9hWrhp2mo3aRtrl67AOxMyZdnUN0oP2tnqxgkzvd7VJpIf852mDlFW
 MOBXmmIRiCQs50GeDCkosd/9SR44hGR93ErvYvyfH1EX8OW/R13msclZObjfFEdop5BXfJL6tR+
 b8PMLX2qn6ZqTBevOqOWGIVzSASi+eqrmrld87lxgQxQ/s4axXvq2anwLfgdKRUEEy0vFFm+g1E
 MgdqN+m27/xdPk7eMFrvLjsg0cbVkMCHGvzfLotMKOlrFOUvu90n7rx0GGR2VFjBGognEQ5RlCR
 VyCXThvC095wR9NNVGmyP9BxHKHgMfFjfHglODM93sDTg4AYyAnvJl0V5IOvwbk7sMg0nMLnG7d
 XKf4MGpAQnveJcw4kfFg1HklO6tlPkdqUV1jgKRV70GRwjr37bmy17hy7mljDNmLUxwPgOOlzNZ
 +KsRtmk+NIhKNDIom5rXPLDw/Sv5uRdTijoSjJgXd1KfcC/R6CK/rGBY0=
X-Google-Smtp-Source: AGHT+IGZM8eE80Fn5hYe80UZn4EAKsdHfpdOu90kdDQpegzFsSjxJ/7R/M8IKMSRaLGVuejV4l/b7A==
X-Received: by 2002:a05:6000:2c0e:b0:429:89c2:d944 with SMTP id
 ffacd0b85a97d-429a7e56654mr2358787f8f.15.1761638580022; 
 Tue, 28 Oct 2025 01:03:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5678sm18629797f8f.22.2025.10.28.01.02.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 01:02:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] hw/sysbus: Spring cleanups (part 1)
Date: Tue, 28 Oct 2025 09:02:50 +0100
Message-ID: <20251028080258.23309-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

- Use proper SysBus accessors

Since v1:
- Reduce series

Philippe Mathieu-Daudé (7):
  hw/sysbus: Use memory_region_name()
  hw/i386/microvm: Use proper SysBus accessors
  hw/i386/ioapic: Use proper SysBus accessors
  hw/timer/hpet: Use proper SysBus accessors
  hw/acpi/cxl: Use proper SysBus accessors
  hw/ppc/e500: Use proper SysBus accessors
  hw/pci-bridge/pci_expander_bridge: Use proper SysBus accessors

 hw/acpi/cxl.c                       | 2 +-
 hw/core/sysbus.c                    | 2 +-
 hw/i386/kvm/ioapic.c                | 3 ++-
 hw/i386/microvm-dt.c                | 6 ++++--
 hw/pci-bridge/pci_expander_bridge.c | 6 +++---
 hw/ppc/e500.c                       | 2 +-
 hw/timer/hpet.c                     | 3 ++-
 7 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.51.0


