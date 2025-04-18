Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649A2C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zwj-0001gu-El; Thu, 17 Apr 2025 20:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwi-0001ge-5x
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwe-0005kD-IN
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so10384565e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937462; x=1745542262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e1VTSouQ0/cu6e8HzFmlHeHy/WlwP9UNhCw7bkhOwIw=;
 b=u+4HwfWPEiLlP4HIlkiZzBC6fXMl4JdHhxZcHYp/qCoUdIU45XLKaARCFGU+M9+7cU
 o+AIQxdIKpZm8ADnPd+Cp3t94xIrnQn6IHFoYOj3zoKOz7vNYUQs9k6HYP0l/80ioPKB
 ikWbE8tMHzoAWqC4TfODCGrxgJQddxQs0z8FZyY6GP0J0EMxA7hus6M1DMsxtWLJbuxb
 GYkuFGmwacpfkWg9kzgN7GFVqpshanR1VNYk43Y3QKQqQwJx5IM9UE8MsKXvJVC2O7pX
 qJqeID8aVyxkkglzanK0mFS3SMpXiTlkq6t4WsKHrFmqHoqSDXA5E4hCt3PhblMj9goQ
 yUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937462; x=1745542262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1VTSouQ0/cu6e8HzFmlHeHy/WlwP9UNhCw7bkhOwIw=;
 b=ITHK5BNPFOG+tYW+hP/gHcXEcMhPvcEQ4Mxod0xg1S9JdGoxOTMZqlSCJ8uFPs23Wn
 S/QKd7zoHCgIODhOV1AF74H486GqUeqPd9lIH51jksXWT1EZXzdSPjMkC2Imelq7dDZC
 VNsBDRYY7+6efunssQiqctOKN4W/MHgBfHOHeAIaZgxEhdcFkl3QLZe3veB1IUt6POKu
 if13o/Vw7Ov2s4CoF2vQckq/PTNrRItWPjCbBdXtA+FyRvLNJHMYd1Wa6tojDpUdbztZ
 oaqh9Lq7Ao4X99GcyOZJjynwlpWSUTA4QAMP76TWdQUgPJEplW5ZZV+luPaKTasNPOIE
 iThg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP6NR7xXB7GphqfxfSvbBQgbH9FgsJvcvf+gi9eh01NzkqxBpmYAeL9pnZCQmYKJ4dO2IJfCd/LhdN@nongnu.org
X-Gm-Message-State: AOJu0YwwNF9+73qEkugasu9l9d6obry00Rwk6mGZ2ZKGP+mFyBhDPnmw
 N5kEPEPcyYYaxmCoXCxbr98fQxHPc1PTzcjTVAZAOOUdknmUJ9IYQKruN+KxFFE=
X-Gm-Gg: ASbGncuy3atoQ39kpx+A6lOxVibWjGt9NHxpm9Tdyg0pxLn02mLfSjsT6ZZBELeIJQW
 uyWnzZgXFcZM3Q65gUuErqUNeRQyRMavTgpa01Tea4lXoYckkGQ/H5Hmkb0/DewzI9GagosIcAU
 PtxNHfjG2S8rGe9lo2+nxbykg0e9hKtmtfoawumk3+K06T0G3wSU1Nf5C5iz+mVKaTCjqIR28Aa
 1uiWya+nVw2tOic2uDnzuu+g5X3GsJ3zB45fTk45svHaFZ+k8GZWhPSr6JQgX6p0vdOxIRxscxy
 n9IpSXHybJwHY0MiMVvKpkekyZ2C7AOnC85tKmHk8Kshlia6bxWVwvZykEk0v3s0vlK57MgIIMS
 RI+DdKcPvEzLsuiRQY6r2DNdXrYlm7ps=
X-Google-Smtp-Source: AGHT+IFLDpozgbueFLLgCKJGm99VWF0xf6Cua4GPjBWB6SwX3f3BCgQxs1FnYRhHZNgeZBvzrZD/qA==
X-Received: by 2002:a05:600c:3d0c:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-4406abffaaamr5670625e9.20.1744937462555; 
 Thu, 17 Apr 2025 17:51:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db10csm2011275e9.27.2025.04.17.17.51.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 00/11] single-binary: Make hw/arm/ common
Date: Fri, 18 Apr 2025 02:50:48 +0200
Message-ID: <20250418005059.4436-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
- Dropped unrelated / irrelevant patches
- Addressed Pierrick comments
- Added R-b tag
- Only considering machines, not CPUs.

Hi,

At this point this series is mostly a draft for Pierrick.

After introducing the generic TargetInfo API [*], we implement
the ARM variants, then use the API to remove target-specific code,
allowing to eventually remove the target-specific arm_ss[] source
set in meson.build, having all objects in arm_common_ss[].

Regards,

Phil.

Available here, based on tcg-next:
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v2

Philippe Mathieu-Daudé (11):
  qapi: Rename TargetInfo structure as BinaryTargetInfo
  qemu: Convert target_name() to TargetInfo API
  system/vl: Filter machine list available for a particular target
    binary
  hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU QOM interfaces
  hw/arm: Filter machine types for qemu-system-aarch64 binary
  hw/arm: Filter machine types for qemu-system-arm binary
  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
  config/target: Implement per-binary TargetInfo structure (ARM)
  config/target: Implement per-binary TargetInfo structure (Aarch64)
  hw/arm/aspeed: Build objects once
  hw/arm/raspi: Build objects once

 meson.build                       |   9 +++
 qapi/machine.json                 |  12 ++--
 include/hw/boards.h               |   1 +
 include/hw/core/cpu.h             |   2 -
 include/qemu/target_info-impl.h   |  26 +++++++
 include/qemu/target_info-qom.h    |  18 +++++
 include/qemu/target_info.h        |  27 +++++++
 configs/targets/aarch64-softmmu.c |  22 ++++++
 configs/targets/arm-softmmu.c     |  22 ++++++
 cpu-target.c                      |   5 --
 hw/arm/aspeed.c                   | 114 ++++++++++++++++++++++++++++--
 hw/arm/b-l475e-iot01a.c           |   5 ++
 hw/arm/bananapi_m2u.c             |   5 ++
 hw/arm/bcm2836.c                  |   4 --
 hw/arm/collie.c                   |   5 ++
 hw/arm/cubieboard.c               |   5 ++
 hw/arm/digic_boards.c             |   5 ++
 hw/arm/exynos4_boards.c           |  10 +++
 hw/arm/fby35.c                    |   5 ++
 hw/arm/highbank.c                 |  10 +++
 hw/arm/imx25_pdk.c                |   5 ++
 hw/arm/imx8mp-evk.c               |   4 ++
 hw/arm/integratorcp.c             |   5 ++
 hw/arm/kzm.c                      |   5 ++
 hw/arm/mcimx6ul-evk.c             |   5 ++
 hw/arm/mcimx7d-sabre.c            |   5 ++
 hw/arm/microbit.c                 |   5 ++
 hw/arm/mps2-tz.c                  |  20 ++++++
 hw/arm/mps2.c                     |  20 ++++++
 hw/arm/mps3r.c                    |   5 ++
 hw/arm/msf2-som.c                 |   5 ++
 hw/arm/musca.c                    |  10 +++
 hw/arm/musicpal.c                 |   5 ++
 hw/arm/netduino2.c                |   5 ++
 hw/arm/netduinoplus2.c            |   5 ++
 hw/arm/npcm7xx_boards.c           |  25 +++++++
 hw/arm/npcm8xx_boards.c           |   4 ++
 hw/arm/olimex-stm32-h405.c        |   5 ++
 hw/arm/omap_sx1.c                 |  10 +++
 hw/arm/orangepi.c                 |   5 ++
 hw/arm/raspi.c                    |  27 +++++--
 hw/arm/raspi4b.c                  |   4 ++
 hw/arm/realview.c                 |  20 ++++++
 hw/arm/sabrelite.c                |   5 ++
 hw/arm/sbsa-ref.c                 |   4 ++
 hw/arm/stellaris.c                |  10 +++
 hw/arm/stm32vldiscovery.c         |   5 ++
 hw/arm/versatilepb.c              |  10 +++
 hw/arm/vexpress.c                 |  10 +++
 hw/arm/virt.c                     |   5 ++
 hw/arm/xilinx_zynq.c              |   5 ++
 hw/arm/xlnx-versal-virt.c         |   4 ++
 hw/arm/xlnx-zcu102.c              |   4 ++
 hw/core/machine-qmp-cmds.c        |   5 +-
 hw/core/null-machine.c            |   5 ++
 plugins/loader.c                  |   2 +-
 system/vl.c                       |  16 ++++-
 target_info-qom.c                 |  24 +++++++
 target_info-stub.c                |  19 +++++
 target_info.c                     |  21 ++++++
 hw/arm/meson.build                |  12 ++--
 61 files changed, 652 insertions(+), 35 deletions(-)
 create mode 100644 include/qemu/target_info-impl.h
 create mode 100644 include/qemu/target_info-qom.h
 create mode 100644 include/qemu/target_info.h
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c
 create mode 100644 target_info-qom.c
 create mode 100644 target_info-stub.c
 create mode 100644 target_info.c

-- 
2.47.1


