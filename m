Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCAECCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy4d-0006Ox-2L; Mon, 20 Oct 2025 18:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy4b-0006Ol-LO
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:09:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy4Z-000620-0x
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:09:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4711f3c386eso22401415e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998185; x=1761602985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hESggxtsFS+giAlvbbcUMu1m9enKWWuV7DXrJLG70uo=;
 b=MliN6J3rAFro4eIPuPSgG39nYIUREqrUnHTKqVx/+P663mCdjnZqIQ8zVfmkyBc3GW
 vclOS7u2CSS1SpYGTfB1JwAltknAbVi1aBjQbRgKnwn6iE9IjyCsvlzmgXryiBrBGLz2
 OX/RaCfDxqHNWYzfMGBoPY7hQHIvsqycnZTCzoHNewnLyic+boCEMye0iNK5PKCh8q10
 wiRMX1FaA5kDzpgX44q2P/NtKEGX1KYKtVORw34T7X1ZzzbpLuor/s4tJvJhPwSIJaRg
 1Rd2rN3c/fm4jYuWOz7n8Wfd0TfR4Fhs6i+1XfHQQRxIHyhYx7Aq/ITqemXYHzy30EB6
 H28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998185; x=1761602985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hESggxtsFS+giAlvbbcUMu1m9enKWWuV7DXrJLG70uo=;
 b=AIY0iGEYvLejb4PXZZVOhlP3zFDY6gSOoKFyLwJU8h29VJ+9YTyOW85K1Csad/3Dbv
 WECW53UiUyw1+NtFkpgH3XTDg8GlG5Q20XHyhEJR/bqiuOON4wZWjuxfHkF1QijsP8Bh
 P9JrTq+Oqr7rPHU5x4mtbbpMoB9XU8XqV8/Li+Q1n6E4QYeX5JHvt5v4J8e27q0MOrt6
 EYaFd/IfOy0XE8ZH1ccNeyPfEcIbZBiLnO9Taaj254z9kb1rnNsTSqg3bX2uXtNoLKKz
 vCkYNJUBFdiatgGDF/2B4tchjp0jGXkH2WR0LLw9e0Yeoy7DYKYnLW33G04aWC5a7KYs
 eAPw==
X-Gm-Message-State: AOJu0YzfmPMAEQPTUxwpWxwJwDDFNgE+lTMPoJZi+uAt7fXIT3DHiHhh
 gyUHsQWfcXOM8VXdiRHxTaofZ7pcaI1MuW2eAIcse3wI0XOd9tK41V3cyKsUrHuK6jPi1g8hTD2
 UfQle9Uc=
X-Gm-Gg: ASbGncsJjHMs5JsAEiJGyOURgaaJkEvUs8Z7aN5+Ad/9IUeuYKAr4zr0kEkL9zsAocG
 tQa3r9DN7VZJoU/6BfpuE2rEMJcmRk9Fgaa5JVWN0bIghs932RmZSvkmHDToxGBeTuaXs0OMAhS
 4XxIZNNfDWWlHayp+K16r4EhHsjFZqWVnXdENpGp8+XU0dfEPsJmfdzrFe4nyG7mZSRcdOeVIvb
 Qc9JM0q2eiP+kAAYSvoDyxItWraZHydexUDtkxjI7tSUFe9Bf4+Lqvjxf2D4x2QN88BpJ41N2OR
 D+OO3idxTI2C/6u6Go/Acxe4rtZ4B8f/3x+GGm/GO8OgDcUQRLYF7ZPAXQmkDbKD9JsU5HhPV3I
 NziQe5JreELAWenbqBjfIbn/VgHbarrUTUrgWDh6LhklYTvc0KEND7uQv1a8TA6B2D89cOOL8aT
 dKZtOEg1OcVnWg3XfDE6mjLuMwK2kbuGAakYc+UxmHDdP3Hum2/I9/KIPpsQS2
X-Google-Smtp-Source: AGHT+IHtmykQbqFpaEd02uxCaiMyIKWj/Bz5YndbRJ5264MdKtS2eWAtatXRNblNzU1bHcXKzdwgiQ==
X-Received: by 2002:a05:600c:45c9:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-4711791c601mr106956785e9.26.1760998184697; 
 Mon, 20 Oct 2025 15:09:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c43f68sm2542425e9.5.2025.10.20.15.09.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:09:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 00/30] single-binary: Make hw/arm/ common
Date: Tue, 21 Oct 2025 00:09:09 +0200
Message-ID: <20251020220941.65269-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

BALATON Zoltan (1):
  hw/boards: Extend DEFINE_MACHINE macro to cover more use cases

Philippe Mathieu-Daudé (29):
  hw/core: Filter machine list available for a particular target binary
  hw/boards: Move DEFINE_MACHINE() definition closer to its doc string
  hw/boards: Introduce DEFINE_MACHINE_WITH_INTERFACE_ARRAY() macro
  hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
  hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64() macros
  hw/arm: Filter machine types for qemu-system-arm/aarch64 binaries
  qemu/target-info: Include missing 'qapi-types-common.h' header
  meson: Prepare to accept per-binary TargetInfo structure
    implementation
  config/target: Implement per-binary TargetInfo structure (ARM,
    AARCH64)
  hw/arm/aspeed: Build objects once
  hw/arm/raspi: Build objects once
  hw/core/machine: Allow dynamic registration of valid CPU types
  hw/arm/virt: Register valid CPU types dynamically
  hw/arm/virt: Check accelerator availability at runtime
  qemu/target_info: Add target_arm() helper
  qemu/target_info: Add target_aarch64() helper
  qemu/target-info: Add target_base_arch()
  qemu/target_info: Add target_base_arm() helper
  hw/arm/virt: Replace TARGET_AARCH64 -> target_aarch64()
  hw/core: Introduce MachineClass::get_default_cpu_type() helper
  hw/arm/virt: Get default CPU type at runtime
  hw/arm/sbsa-ref: Include missing 'cpu.h' header
  hw/arm/sbsa-ref: Build only once
  hw/arm/virt-acpi-build: Include missing 'cpu.h' header
  hw/arm/virt-acpi-build: Build only once
  hw/arm/virt: Build only once
  hw/arm/meson: Move Xen files to arm_common_ss[]
  hw/arm/meson: Remove now unused arm_ss[] source set

 MAINTAINERS                       |  1 +
 meson.build                       | 10 ++++-
 include/hw/arm/machines-qom.h     | 31 +++++++++++++
 include/hw/boards.h               | 60 ++++++++++++++++++-------
 include/qemu/target-info-impl.h   |  3 ++
 include/qemu/target-info-qapi.h   |  7 +++
 include/qemu/target-info.h        | 21 +++++++++
 configs/targets/aarch64-softmmu.c | 26 +++++++++++
 configs/targets/arm-softmmu.c     | 26 +++++++++++
 hw/arm/aspeed.c                   | 33 +++++++++++---
 hw/arm/aspeed_ast27x0-fc.c        |  2 +
 hw/arm/b-l475e-iot01a.c           |  2 +
 hw/arm/bananapi_m2u.c             |  3 +-
 hw/arm/bcm2836.c                  |  4 --
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
 hw/arm/raspi.c                    | 10 +++--
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
 hw/core/machine-qmp-cmds.c        |  4 +-
 hw/core/machine.c                 | 38 ++++++++++++++++
 hw/core/null-machine.c            |  6 ++-
 monitor/qemu-config-qmp.c         |  3 +-
 system/vl.c                       |  5 ++-
 target-info-qom.c                 | 24 ++++++++++
 target-info-stub.c                |  1 +
 target-info.c                     | 31 +++++++++++++
 target/arm/machine.c              | 12 +++++
 configs/targets/meson.build       |  5 +++
 hw/arm/meson.build                | 27 +++++------
 65 files changed, 485 insertions(+), 100 deletions(-)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c
 create mode 100644 target-info-qom.c
 create mode 100644 configs/targets/meson.build

-- 
2.51.0


