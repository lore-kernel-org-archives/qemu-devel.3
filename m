Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58420FD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiI-0005Io-MT; Thu, 26 Feb 2026 10:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiG-0005IH-VH
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiE-0003is-M0
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:40 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso14041995e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121337; x=1772726137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Eg/lpITLr/gcwuz8G7fR992djlT3kb1FxJWTvk4PLo8=;
 b=PdkqmDFv97l8PYH9TEhPD7AedLWnJyvkPbDOW9hNpzKa3lYH2aCvmYFIZR/bNBy11K
 FkbdZS307W0DiN6iZ26ZSdHK1GlkSQcTXdtu/WST4IOyF+31PjdPeyiEp9TLRo1028h1
 VWPnYmEPSfMmhlKZWnlQUDGj9amwfhlTdxu/RjUpEyXYPQhpotRWW5rE6rvU7XYfvyHG
 FfoHvTbXODJKMf6/06BkHH0BmGUYFFuL0FpkS4w+jHLo6aLbJgxASKm2fIhJx6Wvlgya
 f1j5t0Wl8gHsiggRsWsaxE1r81CaHRTS9v0ZlH1zbmmpHlWiGM+Rv/v4/4dIdzII8TIl
 BVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121337; x=1772726137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eg/lpITLr/gcwuz8G7fR992djlT3kb1FxJWTvk4PLo8=;
 b=OmOlhKXdjYYzygHl+zncMJkWlgTTUHC5Zy1dDgD6q4bjGUbu2S2Loy2NKo6Ddtp0hf
 BwhnXnvbLNH/OCKN+IDjhorb2A02ImH9+h82r+KdilAGXUCJ5uxOdts7hB8zRH2K1dBL
 /D/VmPO3TI005uP8Jgw+H1VhkZM+JdDet8/Oe/yBuHkRgKP/XbzEWCcQGcabeSdxHMFf
 /Sd6J85qxgvX8hQZYTE/JAyHwIjsIOBmvbuDRDaoohFwvS0AtsO3GVnX7ZzAs/c5vCTn
 zE9yJ3dYjVjADB/aPRMlImXkO2kr71No05Jy789+JRx1DGzAG9pVu/AWy9hSVN1upJyJ
 CvvQ==
X-Gm-Message-State: AOJu0YwEYJP3aCX47Fc3Ka5vHYJE1Yrkuqf0B2/OH2NjoIB90ES9tFHP
 /Ws8OtybXlC/1w+mizOI0fycz+ZLYqMDyuL5KnuwsieajGMS+3ulnjQ1KPkJ0MBQ9dWBc0R0RVP
 1MySE
X-Gm-Gg: ATEYQzxvcJWgAOqK5/cxgPtt4Rspojy36jBdchca+E1frtI+EARScXXrlL0FtuKPl8/
 T8d8ucO++CyH2sMsXlnqU5M6XdQneh8uB379r74FDH/MZ+W3Yi2JnHry9MnPOJDg4O0eMmuMr6f
 YVrKTFxxj9lmKuiTGuwm6vJoL06M8EvKAEMA9yD4ZmVs0Ghh7WfDGsHIHY1RYxg3oCs+fm2NV8d
 sDCpCjONYexieMMfOjjxmEjf7RUaJ7/F1XUXUEQEPouyU0xv4eH3mrgvNCrvI6z7KRemuLXCzdC
 h4awh9+kJSeHNCmMNNduUUYp+7hcaWkrfYLXd8VptM0kbm3uc+NJX47qFQHhzUrcAjgTMAeDl06
 GU5SzM1kHKjd0/GfVm3scAdPzNjXt5wWEaHyiL9H/eNhJLEBDEei9eAR+isOOlygmXNGsta8VZ4
 yLQIKB74BY8ubGnVotYhBrUNViwt2nfWRw1Y0JeWGXU7xsl5pKo4XD/L5TCWocYGK91aWaxlhIF
 P8tMbE9fE3QTCOyM4rOU7doTQOk6OM=
X-Received: by 2002:a05:600c:3b14:b0:483:c35d:3662 with SMTP id
 5b1f17b1804b1-483c3dd6fc6mr46786065e9.18.1772121336777; 
 Thu, 26 Feb 2026 07:55:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] target-arm queue
Date: Thu, 26 Feb 2026 15:55:15 +0000
Message-ID: <20260226155535.1171290-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 7390b0825b8e041a961f6215a18fa68213dc4779:

  Merge tag 'single-binary-20260226' of https://github.com/philmd/qemu into staging (2026-02-26 09:33:12 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260226

for you to fetch changes up to 907b8d56351b1ba6c97953edaca6a08f02fa2048:

  hw/char/pl011: Only log "data written to disabled UART" once (2026-02-26 11:27:19 +0000)

----------------------------------------------------------------
target-arm queue:
 * target/arm: set the correct TI bits for WFIT traps
 * target/arm: Refactorings preparatory to KVM SME support
 * target/arm/kvm: Don't free migration-blocker reason on failure
 * target/arm/kvm: add kvm-psci-version vcpu property
 * Revert "target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0"
 * hw/arm/virt: Add virtio-mmio-transports property
 * hw/arm/virt: Update error message for bad gic-version option
 * hw/cpu: Build a15mpcore.c once as common object
 * hw/misc/allwinner-cpucfg: Remove use of ARM_CPU() cast macro
 * hw/ssi/xilinx_spips: Reset TX FIFO in reset
 * hw/char/pl011: Only log "data written to disabled UART" once
 * tests/functional: Make sure test case .py files are executable

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: set the correct TI bits for WFIT traps

Mohamed Mediouni (1):
      Revert "target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0"

Mohammadfaiz Bawa (1):
      hw/arm/virt: Add virtio-mmio-transports property

Peter Maydell (4):
      hw/arm/virt: Update error message for bad gic-version option
      tests/functional: Make sure test case .py files are executable
      target/arm/kvm: Don't free migration-blocker reason on failure
      hw/char/pl011: Only log "data written to disabled UART" once

Philippe Mathieu-Daudé (2):
      hw/cpu: Build a15mpcore.c once as common object
      hw/misc/allwinner-cpucfg: Remove use of ARM_CPU() cast macro

Richard Henderson (9):
      target/arm: Remove aarch64 test for kvm
      target/arm: Move kvm_arm_sve_get_vls within kvm.c
      target/arm: Init sve_vq in kvm_arm_set_cpu_features_from_host
      target/arm: Move kvm test out of cpu_arm_set_sve
      target/arm: Drop kvm_arm_sve_supported
      target/arm: Remove kvm test in arm_set_pmu
      target/arm: Drop kvm_arm_pmu_supported
      target/arm: Add vq argument to kvm_arch_{get, put}_sve
      target/arm: Add have_ffr argument to kvm_arch_{get, put}_sve

Sebastian Ott (1):
      target/arm/kvm: add kvm-psci-version vcpu property

Weixie Cui (1):
      hw/ssi/xilinx_spips: Reset TX FIFO in reset

 docs/system/arm/cpu-features.rst   |  11 +++
 docs/system/arm/virt.rst           |   5 +
 hw/arm/virt-acpi-build.c           |   2 +-
 hw/arm/virt.c                      |  45 ++++++++-
 hw/char/pl011.c                    |  24 ++++-
 hw/cpu/a15mpcore.c                 |   2 +-
 hw/cpu/meson.build                 |   2 +-
 hw/misc/allwinner-cpucfg.c         |   4 +-
 hw/ssi/xilinx_spips.c              |   4 +-
 include/hw/arm/virt.h              |   1 +
 include/hw/char/pl011.h            |   1 +
 target/arm/cpu.c                   |  12 ++-
 target/arm/cpu64.c                 |  72 ++++++++------
 target/arm/hvf/hvf.c               |  25 -----
 target/arm/kvm-stub.c              |  15 ---
 target/arm/kvm.c                   | 197 ++++++++++++++++++++-----------------
 target/arm/kvm_arm.h               |  35 -------
 target/arm/tcg/cpu64.c             |   2 +-
 target/arm/tcg/op_helper.c         |   2 +-
 tests/functional/ppc/test_ppe42.py |   0
 20 files changed, 246 insertions(+), 215 deletions(-)
 mode change 100644 => 100755 tests/functional/ppc/test_ppe42.py

