Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AB0CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJQW-0008U6-9A; Tue, 21 Oct 2025 16:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJQT-0008TV-DP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:57:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJQQ-0002Gl-Vv
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:57:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so34150935e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080264; x=1761685064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7GEreXBwb2oQd4NdZr8CgAI0vxp7JPLccaI2BF+pSKQ=;
 b=VqKGdD1I/qcfbkgqHT3En7s3yXLvCSb8dsvujeXLQ/j90Ku1xNPG97RCRCPamRjh9/
 jX8GPq4YmdYSJRQloB3Gi4km3cqQCH8Lzls/XsqryGt5EdLbCqUgCGjVC2A+OgWHhzTd
 IHWBUBtxsc2c1au7uCKbdsZddWoyNLBPuvTcdUQk5yg+7JsGvWqsxRrz+8jwLPd68uxe
 EJ7+db2YvEqIuiZEm9f8JAHsH9MtZyI8Sb0krAjfuwQsCvLCFMihBU1R8t4f8B5uLnyS
 5MjmcwodxrWFZjwkaESAgL+eduat74szkmKYysSn4tHWgSiG/T50iuWU5bW22kuAaDE7
 vnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080264; x=1761685064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GEreXBwb2oQd4NdZr8CgAI0vxp7JPLccaI2BF+pSKQ=;
 b=skrrbKRg+Wj62XzYgAtiU874Z/nuH+lxD9BGQl0xtRIvilpvTxtyPFon4J8e87NcfN
 qkL2UOoptMDE38wqdkZ3Ax568aEu0D9W0Uhvw6kCmv4A1710q4DRnMLjmMYswWxm8bhU
 Rl5YYbjXNAoSxkl3uRT9tdOy84yZeGuZBynbp1OqZer2C6Y5OA3UkYMjh9RVqv2QK7F1
 QhPNq0A4zacE8S3RY5NPJVpbnD79fPGCbeO1B1Zg30cv9MOKwv0g8N5IErLhFzklWIr6
 dMChsB2ADL5c0xxgbfKQNbsBXCE3plZ+bmEbJTp0xU/JIYcKe5p+aDWqhBCyAWAk2QKt
 zGng==
X-Gm-Message-State: AOJu0Ywk3FNaXscGw7j3EpOFIQcIeeStaWBiDdb37erZCTWPwPlXVojj
 g/n6hhDCxr9m69EXizcSv7c6CxSo++QkubNqkyHmg52pteSdcth+bPmGPtQ5g17TYJ4O91Q6SdG
 SRRMquqs=
X-Gm-Gg: ASbGncugSun1dvbBzPJzK+A4XnpRGpQcu5s1utsB0Y7T+/RgUxCZCoce7AWr4IDqDRc
 dc7W3gJ3KAxMlEXy04L74DfPFYMu/HLGBrauaRXl59Hjf4QsTa7gOprvNgPPImbRLVSmAclwych
 gdamDIDDkMDu/UBuZkwmPudGgZhA07/UNZk9dMz3e1iGmvu3qieN3zZmfuPYmdxrltDxVqMZFKH
 mO+UOKsI1Q6HDfegIjw3ROoMqYHRx1VyVMt3tLx9NSyDjuMjohQ/5L02DgFPQ3Ffje0OqLYlyv6
 tVtDMj1iBq1YvEtBIVQOvQYPm6jtCBGEmiEF289UjgME2igJy1RhOEYMsgfc2jYyr+UreN7Gccd
 V5xr8afaBgQCA51V2a1L0UzjvYusINkQh1+2TYEVez3EhjjEC3BUrM9nr8MsT3p8N8TpBp9Upgv
 RDSKndFyPt+VKf044xXzRqDgk7MSuf/rYmag8A7I4qZe3X54emsDsscYTp3xd9
X-Google-Smtp-Source: AGHT+IHmc2WAXunWMSJY0h5+feSjd7fylunygd15nSU3qUMgAWbi9OscTPxUdu3pPzRQU+OOcm7s1g==
X-Received: by 2002:a05:600c:1da7:b0:46e:4be1:a423 with SMTP id
 5b1f17b1804b1-4711786d630mr119251055e9.1.1761080263503; 
 Tue, 21 Oct 2025 13:57:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b33sm9444135e9.14.2025.10.21.13.57.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:57:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 00/19] single-binary: Make hw/arm/ common
Date: Tue, 21 Oct 2025 22:57:21 +0200
Message-ID: <20251021205741.57109-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Series fully reviewed.

Since v6:
- Addressed Jan comment
- Removed aspeed/raspi meson patches

Since v5:
- Rebased
- Use Zoltan's patch
- Filter QMP list
- Addressed Richard & Pierrick comments
- qtest/device-introspect-test failing

Since v4:
- Add DEFINE_MACHINE_WITH_INTERFACES (Zoltan)
- Use GPtrArray for get_valid_cpu_type (Richard)
- Define InterfaceInfo[] arrays (Richard)
- Collect R-b tags

Since v3:
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

Based-on: <20251021204700.56072-1-philmd@linaro.org>

Available here, based on hw-misc:
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v7

Philippe Mathieu-Daudé (19):
  hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
  hw/arm: Add DEFINE_MACHINE_ARM() / DEFINE_MACHINE_AARCH64() macros
  hw/arm: Filter machine types for qemu-system-arm/aarch64 binaries
  meson: Prepare to accept per-binary TargetInfo structure
    implementation
  config/target: Implement per-binary TargetInfo structure (ARM,
    AARCH64)
  hw/arm/virt: Register valid CPU types dynamically
  hw/arm/virt: Check accelerator availability at runtime
  qemu/target_info: Add target_arm() helper
  qemu/target_info: Add target_aarch64() helper
  qemu/target_info: Add target_base_arm() helper
  hw/arm/virt: Replace TARGET_AARCH64 -> target_aarch64()
  hw/arm/virt: Get default CPU type at runtime
  hw/arm/sbsa-ref: Include missing 'cpu.h' header
  hw/arm/sbsa-ref: Build only once
  hw/arm/virt-acpi-build: Include missing 'cpu.h' header
  hw/arm/virt-acpi-build: Build only once
  hw/arm/virt: Build only once
  hw/arm/meson: Move Xen files to arm_common_ss[]

 MAINTAINERS                       |  1 +
 meson.build                       | 10 ++++-
 include/hw/arm/machines-qom.h     | 46 +++++++++++++++++++
 include/qemu/target-info.h        | 21 +++++++++
 configs/targets/aarch64-softmmu.c | 26 +++++++++++
 configs/targets/arm-softmmu.c     | 26 +++++++++++
 hw/arm/aspeed.c                   | 27 ++++++++++-
 hw/arm/aspeed_ast27x0-fc.c        |  2 +
 hw/arm/b-l475e-iot01a.c           |  2 +
 hw/arm/bananapi_m2u.c             |  3 +-
 hw/arm/collie.c                   |  2 +
 hw/arm/cubieboard.c               |  3 +-
 hw/arm/digic_boards.c             |  3 +-
 hw/arm/exynos4_boards.c           |  3 ++
 hw/arm/fby35.c                    |  2 +
 hw/arm/highbank.c                 |  3 ++
 hw/arm/imx25_pdk.c                |  3 +-
 hw/arm/imx8mp-evk.c               |  4 +-
 hw/arm/integratorcp.c             |  3 +-
 hw/arm/kzm.c                      |  3 +-
 hw/arm/mcimx6ul-evk.c             |  4 +-
 hw/arm/mcimx7d-sabre.c            |  4 +-
 hw/arm/microbit.c                 |  2 +
 hw/arm/mps2-tz.c                  |  5 +++
 hw/arm/mps2.c                     |  5 +++
 hw/arm/mps3r.c                    |  2 +
 hw/arm/msf2-som.c                 |  3 +-
 hw/arm/musca.c                    |  3 ++
 hw/arm/musicpal.c                 |  3 +-
 hw/arm/netduino2.c                |  3 +-
 hw/arm/netduinoplus2.c            |  3 +-
 hw/arm/npcm7xx_boards.c           |  6 +++
 hw/arm/npcm8xx_boards.c           |  2 +
 hw/arm/olimex-stm32-h405.c        |  3 +-
 hw/arm/omap_sx1.c                 |  3 ++
 hw/arm/orangepi.c                 |  3 +-
 hw/arm/raspi.c                    |  6 +++
 hw/arm/raspi4b.c                  |  2 +
 hw/arm/realview.c                 |  5 +++
 hw/arm/sabrelite.c                |  3 +-
 hw/arm/sbsa-ref.c                 |  3 ++
 hw/arm/stellaris.c                |  3 ++
 hw/arm/stm32vldiscovery.c         |  3 +-
 hw/arm/versatilepb.c              |  3 ++
 hw/arm/vexpress.c                 |  3 ++
 hw/arm/virt-acpi-build.c          |  1 +
 hw/arm/virt.c                     | 74 ++++++++++++++++++-------------
 hw/arm/xilinx_zynq.c              |  2 +
 hw/arm/xlnx-versal-virt.c         |  3 ++
 hw/arm/xlnx-zcu102.c              |  2 +
 hw/core/null-machine.c            |  6 ++-
 target-info-qom.c                 | 24 ++++++++++
 target-info.c                     | 21 +++++++++
 target/arm/machine.c              | 18 ++++++++
 configs/targets/meson.build       |  5 +++
 hw/arm/meson.build                |  8 ++--
 56 files changed, 386 insertions(+), 56 deletions(-)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c
 create mode 100644 target-info-qom.c
 create mode 100644 configs/targets/meson.build

-- 
2.51.0


