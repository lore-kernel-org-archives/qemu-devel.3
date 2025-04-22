Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E115CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F1j-0006lR-FF; Tue, 22 Apr 2025 10:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1h-0006jZ-2O
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1e-00056Y-KB
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:08 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3266802f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333704; x=1745938504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yxl4aJx9kDFtBdy1ZVBDbGRwT7YOukchD6kWnStUhFg=;
 b=t9UVZ/wKkxCkf/p9cOjNRSv255yCjVv5Y8ATlub55cqCG7yghxK4oCCp4mzo6q2uKg
 UOWFuu79qkHE/6YyUiIZ72vDSsYmx5SYfFdxmVMBg9eLuQGTmX8Xw7olYT+WpPfiktA+
 wjLLKJI4/aFhTAv/N/aHAHIMFL70aYAC5AxRs+auJPBii+TEDvfIcHNJyjFUmXMlduN/
 a057mVBzakcOP8XQ4CYso1rnWqDOQutdeWunkdBxO9YSaiqf60M2p8uEkwoiZqme5Oub
 PohaoDRLX7iIznwG5XKIBTvZbsBAvIQsYKChfWoE2el7AazProvmo8evSEHyV37uniHG
 iK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333704; x=1745938504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yxl4aJx9kDFtBdy1ZVBDbGRwT7YOukchD6kWnStUhFg=;
 b=UItI12V5wlLRXPGLASSKTsHO7HOwRCXYXZsFw6gJfyBQLLl1HMnNXbVC7Zz7Yt8fnr
 ZJgrAX02ig84zW/GX7RKZFON1pdjDLVC0JwW4HXqv+icYhqXuPqgEYM7FVdANkXtN2Xo
 55ilMF0HR4PAomASt3pVg0wpvVEtyh1lgLOTAU5p6pENTbt3vhjvlmco1W+lmtOKoOxV
 MjUBrwA4ZhV59oSo3AwLpN9XKt8AYVHT9bA5wTnVVN9iIqYWgsn3Zk2/gG6+rPkOEOPV
 KrQAkJpjwkIFKXGfhSsK3gMIo3XvM1m01LSevyAufn57OuVFYAt3FyJcuD0SuhbRDBI7
 7cQQ==
X-Gm-Message-State: AOJu0Yyg1dS0geI4/y+kKbMg7asN/ksv3K+t8Hrm46OXCKHSiEtYO1ZU
 ewGRXETwFYEFlP16N64PLekrWNLyh0oWh/zg4ipLk5JvdFMNKYAOGMbxuCetl1eI0K/V4PVwmRA
 j
X-Gm-Gg: ASbGncvC9uUDPMU4TPIGdDTMRPkHIQGF2bavpaJjGrJa1BA+AgUVZNU63kUI6TKpBCA
 jkGkIE5PYAkx45AQUytMtoCpF3pg3R7G78vNC9KHkcQY1T0G6I15U8jiN/Au+ASxFV8AKnWYq/3
 rjqdUUskrUBRXDsc+x0IdGHOT4+0MlZB8lvAAIDXqw9tjM6CUDd14Dx6zC+tGRWg5/Ybsv7uB9P
 WJdM5IL12jPw5b+PU3HIqdiRCD0415Kxwl4KqaEjbZlbCDokFLH9tFL7vy6QvL/pK/paMxV/S7b
 DkwRiaEKzukq04ARC7EmVjRAAY0d8SZKaKFPxXot0wNEAZDTy7x7x7VzosHo8xiFJ+moXNZLmLH
 Lwhl1twchPTE+yiQ=
X-Google-Smtp-Source: AGHT+IGaLHXcIYnQviW//SVgN6V9DTUyhKhUJwD8FlynwkGc6P/+RC3WO6kCiszK9Oh1orsxON70EA==
X-Received: by 2002:a5d:6488:0:b0:391:3207:2e6f with SMTP id
 ffacd0b85a97d-39efbace3e3mr10913621f8f.42.1745333703702; 
 Tue, 22 Apr 2025 07:55:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa493207sm15562711f8f.79.2025.04.22.07.55.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 00/19] single-binary: Make hw/arm/ common
Date: Tue, 22 Apr 2025 16:54:42 +0200
Message-ID: <20250422145502.70770-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since v3
- QAPI structure renamed as QemuTargetInfo
- MachineClass::get_valid_cpu_types() runtime
- target_aarch64() checking SysEmuTarget value
- Remove CONFIG_TCG #ifdef'ry in hw/arm/

Since v2:
- More comments from Pierrick addressed
- Use GList to register valid CPUs list
- Remove all TARGET_AARCH64 uses in hw/arm/

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
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v4

Philippe Mathieu-Daudé (19):
  qapi: Rename TargetInfo structure as QemuTargetInfo
  qemu: Convert target_name() to TargetInfo API
  system/vl: Filter machine list available for a particular target
    binary
  hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
  hw/arm: Filter machine types for qemu-system-arm/aarch64 binaries
  meson: Prepare to accept per-binary TargetInfo structure
    implementation
  config/target: Implement per-binary TargetInfo structure (ARM,
    AARCH64)
  hw/arm/aspeed: Build objects once
  hw/arm/raspi: Build objects once
  hw/core/machine: Allow dynamic registration of valid CPU types
  hw/arm/virt: Register valid CPU types dynamically
  hw/arm/virt: Check accelerator availability at runtime
  qemu/target_info: Add %target_arch field to TargetInfo
  qemu/target_info: Add target_aarch64() helper
  hw/arm/virt: Replace TARGET_AARCH64 -> target_aarch64()
  hw/core: Get default_cpu_type calling machine_class_default_cpu_type()
  hw/core: Introduce MachineClass::get_default_cpu_type() helper
  hw/arm/virt: Get default CPU type at runtime

 MAINTAINERS                       |   8 +++
 meson.build                       |  11 +++
 qapi/machine.json                 |  10 +--
 include/hw/arm/machines-qom.h     |  18 +++++
 include/hw/boards.h               |  10 +++
 include/hw/core/cpu.h             |   2 -
 include/qemu/target-info-impl.h   |  35 +++++++++
 include/qemu/target-info.h        |  34 +++++++++
 configs/targets/aarch64-softmmu.c |  23 ++++++
 configs/targets/arm-softmmu.c     |  23 ++++++
 cpu-target.c                      |   5 --
 hw/arm/aspeed.c                   | 115 ++++++++++++++++++++++++++++--
 hw/arm/b-l475e-iot01a.c           |   6 ++
 hw/arm/bananapi_m2u.c             |   6 ++
 hw/arm/bcm2836.c                  |   5 +-
 hw/arm/collie.c                   |   6 ++
 hw/arm/cubieboard.c               |   6 ++
 hw/arm/digic_boards.c             |   6 ++
 hw/arm/exynos4_boards.c           |  11 +++
 hw/arm/fby35.c                    |   6 ++
 hw/arm/highbank.c                 |  11 +++
 hw/arm/imx25_pdk.c                |   6 ++
 hw/arm/imx8mp-evk.c               |   5 ++
 hw/arm/integratorcp.c             |   6 ++
 hw/arm/kzm.c                      |   6 ++
 hw/arm/mcimx6ul-evk.c             |   6 ++
 hw/arm/mcimx7d-sabre.c            |   6 ++
 hw/arm/microbit.c                 |   6 ++
 hw/arm/mps2-tz.c                  |  21 ++++++
 hw/arm/mps2.c                     |  21 ++++++
 hw/arm/mps3r.c                    |   6 ++
 hw/arm/msf2-som.c                 |   6 ++
 hw/arm/musca.c                    |  11 +++
 hw/arm/musicpal.c                 |   6 ++
 hw/arm/netduino2.c                |   6 ++
 hw/arm/netduinoplus2.c            |   6 ++
 hw/arm/npcm7xx_boards.c           |  26 +++++++
 hw/arm/npcm8xx_boards.c           |   5 ++
 hw/arm/olimex-stm32-h405.c        |   6 ++
 hw/arm/omap_sx1.c                 |  11 +++
 hw/arm/orangepi.c                 |   6 ++
 hw/arm/raspi.c                    |  28 ++++++--
 hw/arm/raspi4b.c                  |   5 ++
 hw/arm/realview.c                 |  21 ++++++
 hw/arm/sabrelite.c                |   6 ++
 hw/arm/sbsa-ref.c                 |   5 ++
 hw/arm/stellaris.c                |  11 +++
 hw/arm/stm32vldiscovery.c         |   6 ++
 hw/arm/versatilepb.c              |  11 +++
 hw/arm/vexpress.c                 |  11 +++
 hw/arm/virt.c                     |  78 +++++++++++---------
 hw/arm/xilinx_zynq.c              |   6 ++
 hw/arm/xlnx-versal-virt.c         |   5 ++
 hw/arm/xlnx-zcu102.c              |   5 ++
 hw/core/machine-qmp-cmds.c        |  10 +--
 hw/core/machine.c                 |  37 ++++++++++
 hw/core/null-machine.c            |   6 ++
 plugins/loader.c                  |   2 +-
 system/vl.c                       |   7 +-
 target-info-qom.c                 |  24 +++++++
 target-info-stub.c                |  22 ++++++
 target-info.c                     |  26 +++++++
 target/ppc/cpu_init.c             |   2 +-
 configs/targets/meson.build       |   3 +
 hw/arm/meson.build                |  12 ++--
 65 files changed, 813 insertions(+), 71 deletions(-)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 include/qemu/target-info-impl.h
 create mode 100644 include/qemu/target-info.h
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c
 create mode 100644 target-info-qom.c
 create mode 100644 target-info-stub.c
 create mode 100644 target-info.c
 create mode 100644 configs/targets/meson.build

-- 
2.47.1


