Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABE4C369D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pWe-00026Y-Pw; Fri, 18 Apr 2025 13:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWc-000265-L6
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWa-0008IW-Or
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso16852815e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997350; x=1745602150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OzC0Dt4axD2vzq8g8kwhE9o+49flV7m5pWt3/D7F2Rk=;
 b=Wd1YdBamqO3viHc6NHRrVceNvxeamFIe3ps5wAL5KlKi0TeZ95s4ImrQGekNoR4Ihi
 hy57W6jUklpkl00kyzCxTR8Ozk0D46d0M5Sw+wSdwOSn9n4kBjAhUfmnF188l/yQR8gv
 Csdiek4AAQbeZpH+F+Q32DzEjpJEYwBuSr3+8j2CH94Qrz46NDzYotA5HdsMcyCfuZQ6
 55SrQ5bzSLxcuTx0iYmxBdvtbJeCl49W8xZ6djKqwGtvPpLBEBoQQ+3GglFNbXhQjqOn
 6Xotl0xyDaEeb/+SkrpAMjIiDbQJQjYzdqZAjeoOPqLRNVdiS6VhKPYAfl2hsnBnC2/3
 hWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997350; x=1745602150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OzC0Dt4axD2vzq8g8kwhE9o+49flV7m5pWt3/D7F2Rk=;
 b=AgeBsoqtnl1eZA4F9mLi9aTeZDNSToO+5C+LxAAs88bavlE/go7ojr4Og1ulQxAjCX
 tYaiIwhRy2inW3r3YgsKJzfZZa+wOqpdgvpTIsGSjKtzy4RIv5VdCdmk8hAjL1RevSRp
 VfCGkBNc/wYO8BCjZk8PAF6Ba0d4hitYFVoKfpCKOoixN7pKTB+c8QbP++XoBgWy2eQf
 +7KFFk/xtvHu2MeTXSqf69fgMTYU9Y1pE/83nEhR/dMd/csff7hsjxYnAoUlr/mug5Xa
 NhReucTw8bQwbRFz7oZXolgs+APVJu7O+g0hkHIfNDb0BXcWhZcSwl+1EY3h+ojQdoMW
 kFqw==
X-Gm-Message-State: AOJu0YwJhZn3itIlMz4kryiXdM1rwiOXav3xkYvCHGcDZggQqqiQvMtd
 W4EUylYrIEbCneA3ZUu78QD/MceAKHK+Yj2oFEQSL0xX16Z77jDWT1v2AB6IEukippg7h/uKzry
 S
X-Gm-Gg: ASbGncuKxRv1t1F2uA9gT/zUqJEUp5qh4VPpMYf6P84E/BYXDywD8t5BJu4NUd410fc
 kDdVTVj/E2ykBBUTN+Zme1cXZK82yskzbqkgPw/F1mn5SX7x/0XQKTc6OqRB5qLinNiuD1iWDlN
 qY+PU1Wli62QKMPRdP17afHUhHq8eJdgqREOPu0ywdEbG7928Nrbr9+ch27ofYqjkT5ZIv+d2+J
 R7vz7r4DcnX9MOIxNv98aw767wMAS/scEAeE1Ho/41HkI8tcx1hbHvL5c8VkelV0/v7r4AXDg2i
 kkKwG98NtcqQuPnlAk2+Y1H7avSMZJ9A5ATC7WjgniANexepKAg611ER1aRewKmbQX2vH9UPB3D
 rDE88zZ2VGWoxL+Q=
X-Google-Smtp-Source: AGHT+IG0WGCVV7zlol4X59iCx9iSfh/aCnJ/LbbokwSU92OGLhPx3zwRzokQM/sqyGB6VqsKMQSQYA==
X-Received: by 2002:a5d:47ad:0:b0:39e:e217:28ce with SMTP id
 ffacd0b85a97d-39efba38006mr3060918f8f.2.1744997350298; 
 Fri, 18 Apr 2025 10:29:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406e0cc627sm18612265e9.1.2025.04.18.10.29.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 00/14] single-binary: Make hw/arm/ common
Date: Fri, 18 Apr 2025 19:28:54 +0200
Message-ID: <20250418172908.25147-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v3

Philippe Mathieu-Daudé (14):
  qapi: Rename TargetInfo structure as BinaryTargetInfo
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
  qemu/target_info: Add target_aarch64() helper
  hw/arm/virt: Replace TARGET_AARCH64 -> target_aarch64()

 meson.build                       |  11 +++
 qapi/machine.json                 |  12 ++--
 include/hw/arm/machines-qom.h     |  18 +++++
 include/hw/boards.h               |   8 +++
 include/hw/core/cpu.h             |   2 -
 include/qemu/target_info-impl.h   |  26 +++++++
 include/qemu/target_info.h        |  34 +++++++++
 configs/targets/aarch64-softmmu.c |  22 ++++++
 configs/targets/arm-softmmu.c     |  22 ++++++
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
 hw/arm/virt.c                     |  50 +++++++------
 hw/arm/xilinx_zynq.c              |   6 ++
 hw/arm/xlnx-versal-virt.c         |   5 ++
 hw/arm/xlnx-zcu102.c              |   5 ++
 hw/core/machine-qmp-cmds.c        |   5 +-
 hw/core/machine.c                 |  30 ++++++++
 hw/core/null-machine.c            |   6 ++
 plugins/loader.c                  |   2 +-
 system/vl.c                       |   5 +-
 target_info-qom.c                 |  24 +++++++
 target_info-stub.c                |  21 ++++++
 target_info.c                     |  26 +++++++
 configs/targets/meson.build       |   3 +
 hw/arm/meson.build                |  12 ++--
 63 files changed, 761 insertions(+), 59 deletions(-)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 include/qemu/target_info-impl.h
 create mode 100644 include/qemu/target_info.h
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c
 create mode 100644 target_info-qom.c
 create mode 100644 target_info-stub.c
 create mode 100644 target_info.c
 create mode 100644 configs/targets/meson.build

-- 
2.47.1


