Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE69FFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWeY-0003QV-82; Fri, 06 Mar 2026 09:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeX-0003Pc-5w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:45 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeV-0002Hm-2x
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso81283305e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809181; x=1773413981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SdvCtpzv/Ffm1sB9T9kJKAPgrm0KyX88uhV9MujN1S0=;
 b=UID4bMs672iubl8OaUqjjg8qXaWktTcuhYtyR4HqsAkMtEMjXPz7+Ps5WLWjpMQZQ0
 tMBfUlRv+kh+5v4kxagNYiSzwmn6QYaPZp3OiR8iy5fTM4/xtzl+tbDh4+i3gHtZ42jZ
 6rEbdXlX8iu4B/e+M5YXcU7eeyOsfoaEqf7wdgJglhYu/65L5ZgRo9ZKqqic9dq1VPL3
 Bx/A+IrbSsFelF0w0vIUHn1Im5QOD7NqHLSxRYpO7A8XpXVc4DWi5AYxbzPrApo9SeM8
 U00a0HqO2Wv9iHRFTXSx+n+cpEkoxuWWLnBsWi/UgaeeU/xXeCo8lerzMCk9sL/PauUY
 j44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809181; x=1773413981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdvCtpzv/Ffm1sB9T9kJKAPgrm0KyX88uhV9MujN1S0=;
 b=ij9y2l1ZjFXkcPz7wTBgGH7eZMAHClqACO8a7+kPtOKjsTaH1PHuWITIpBO6wMFmT6
 VP/QVo3XAudt0N5dmsI6o9zNLVZzYYlz60ID2L+zkG+ru7dqKfwt4RqdBoliNHwaLqS1
 X3zFArO+WEWjXOVHcrL0sWiQRx4Bmwt0pmhSbAnheNszR0m/09k24sPGUetHnk3CFev5
 wGGWQ2ZgZt74mkt8qkqWV6V90TK/5ZACCrBV7UvmdD6VyAcKt2ZM1iD8XdLH922KNPji
 M9q1sox7hfDLehhW9upgPhOYhRWGdGmGOXjVMKScacWHnaDkWKnEq30iU4nbvUuLUo2O
 i53A==
X-Gm-Message-State: AOJu0YwLuAjQvGihEr1UOXH63T8KlMpoVdTDBWGzPZaz/RW3YkuNHkG8
 I0KTeXdV/714R/CWOF+FN6VS26GsrB+BrzdawYQi3h/BKjLlbY8b6KeEjvj07LNfo64MqRSF6gb
 skI4O
X-Gm-Gg: ATEYQzymNyRdKtf4yUUpqrQBs4tpxADa1SVVVHQ+gqoj0fBvFaSzJk/MfhYgoy88Jds
 CtBgP6XIj3qw1nU+g1Yu7dKNClhtX/uSa9VbJOfPbO58/r9/scwshw+nH/35WFcjLUfkSolxwzd
 oyQ6ZDFYw+fkx+ArF4J6iikNNp2g8qWOgVpvcbZX1iJWBav6u7Z0DoVKWK3matoinivnCqWpI9m
 r+P61UOCld65Zy5wrcSvf3umhHr2PdXdv7qisoDtpnNlx1zEU6/t5UKRTdrXLpbU0olHYTHTkge
 HB+s7HDuJZB6WxcJhq8EjLHXRrDAh6w9nlclQu+XVSG2/8mTWSrIe7vTH8LaHcRNeXdERv6T0b4
 IuEaA5K08JYsvfWMzbOu+7v0Nv9hkPDy7B9jFVdAQ3mnE+y++hAZPNzwHMux9tJdFXmXQXNl9Du
 4p6jmsLBf7nMLQ7cQaeOLg3hMoKf51HwjvO0J3RNJmf0Mrh8gbwOhHEWYuDGpOjoUIFxd2szrnC
 I2SZCFT2fTw55w+mpu54cnQ/waJ0Gg=
X-Received: by 2002:a05:600c:1d1e:b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-48526951ca9mr40117445e9.22.1772809181094; 
 Fri, 06 Mar 2026 06:59:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/49] target-arm queue
Date: Fri,  6 Mar 2026 14:58:50 +0000
Message-ID: <20260306145939.2162189-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Hopefully last target-arm pull before the softfreeze. Certainly the
last large one.

-- PMM

The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:

  Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260306

for you to fetch changes up to 9c3ae30d411a94ddd4a0e09d26ba095748b75be3:

  hvf: enable nested virtualisation support (2026-03-06 13:33:58 +0000)

----------------------------------------------------------------
target-arm queue:
 * Remove deprecated 'highbank' and 'midway' machines
 * hw/arm: Add missing dependencies for STM32F405 SoC
 * hw/arm/smmuv3-accel: Read and propagate host vIOMMU events
 * Minor MAINTAINERS updates
 * target/arm: Improve logging of migration errors due to system
   register mismatches between source and destination
 * hw/arm/aspeed_gpio: Don't leak string in aspeed_gpio_init()
 * tests/qtest/iommu-smmuv3-test: Free QPCIDevice
 * chardev: Fix various sanitizer detected leaks
 * tests/qtest/test-x86-cpuid-compat: Free allocated memory
 * tests/qtest/qos-test: Plug a couple of leaks
 * hw/arm/smmuv3: Fix various minor bugs
 * hvf/arm: expose FEAT_SME2 to guest if available
 * hvf/arm: Add hvf vGIC interrupt controller support
 * hvf: enable nested virtualisation support

----------------------------------------------------------------
CLEMENT MATHIEU--DRIF (1):
      MAINTAINERS: Update Clement Mathieu--Drif's email address

Chisheng Chen (1):
      hw/arm: Add missing dependencies for STM32F405 SoC

Eric Auger (7):
      vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
      target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC for cpreg arrays
      target/arm/kvm: Export kvm_print_register_name()
      target/arm/kvm: Tweak print_register_name() for arm64 system register
      target/arm/machine: Trace cpreg names which do not match on migration
      target/arm/machine: Trace all register mismatches
      target/arm/machine: Fix detection of unknown incoming cpregs

Fabiano Rosas (5):
      chardev: Fix QIOChannel refcount
      chardev: Don't attempt to unregister yank function more than once
      chardev: Consolidate yank registration
      tests/qtest/test-x86-cpuid-compat: Free allocated memory
      tests/qtest/qos-test: Plug a couple of leaks

Magnus Kulke (1):
      MAINTAINERS: fix magnuskulke email-address

Manos Pitsidianakis (2):
      hvf/arm: handle FEAT_SME2 migration
      hvf/arm: expose FEAT_SME2 to guest if available

Mohamed Mediouni (15):
      hw/arm: virt: remove hvf_arm.h include
      hvf: hvf-all: stop including hvf_arm.h
      hw/intc: Add hvf vGIC interrupt controller support
      hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
      accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
      target/arm: hvf: instantiate GIC early
      hw/arm, target/arm: nested virtualisation on HVF
      hvf: only call hvf_sync_vtimer() when running without the platform vGIC
      hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
      hvf: arm: allow exposing minimal PMU when running with nested virt on
      target/arm: hvf: add asserts for code paths not leveraged when using the vGIC
      hvf: sync registers used at EL2
      target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
      hvf: arm: disable SME when nested virt is active
      hvf: enable nested virtualisation support

Nicolin Chen (2):
      backends/iommufd: Introduce iommufd_backend_alloc_veventq
      hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Paul Durrant (1):
      MAINTAINERS: remove myself as a Xen maintainer

Peter Maydell (6):
      system/qtest: Support comments in input commands
      hw/net/smc91c111: Don't allow negative-length packets
      scripts: Move lsan_suppressions.txt out of oss-fuzz subdir
      scripts/lsan_suppressions.txt: Add more leaks
      hw/arm/aspeed_gpio: Don't leak string in aspeed_gpio_init()
      tests/qtest/iommu-smmuv3-test: Free QPCIDevice

Shameer Kolothum (3):
      hw/arm/smmuv3-accel: Add viommu free helper
      hw/arm/smmuv3: Introduce a helper function for event propagation
      hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

Tao Tang (3):
      hw/arm/smmuv3-common: Fix incorrect reserved mask for SMMU CR0 register
      hw/arm/smmuv3: Correct SMMUEN field name in CR0
      hw/arm/smmuv3: Fix CFGI_CD handling when stage-1 is unsupported

Thomas Huth (2):
      hw/arm: Remove the deprecated "highbank" and "midway" machines
      hw/net: Remove the xgmac device

 .gitlab-ci.d/buildtest.yml              |   2 +-
 MAINTAINERS                             |  16 +-
 accel/hvf/hvf-all.c                     |  52 +-
 accel/stubs/hvf-stub.c                  |   2 +
 backends/iommufd.c                      |  31 ++
 backends/trace-events                   |   1 +
 chardev/char-io.c                       |   5 +
 chardev/char-socket.c                   |  34 +-
 configs/devices/arm-softmmu/default.mak |   1 -
 docs/about/deprecated.rst               |   7 -
 docs/about/removed-features.rst         |   7 +
 docs/system/arm/highbank.rst            |  19 -
 docs/system/target-arm.rst              |   1 -
 hw/arm/Kconfig                          |  21 +-
 hw/arm/highbank.c                       | 404 ----------------
 hw/arm/meson.build                      |   1 -
 hw/arm/smmuv3-accel.c                   | 146 +++++-
 hw/arm/smmuv3-accel.h                   |   6 +
 hw/arm/smmuv3-internal.h                |   6 +-
 hw/arm/smmuv3.c                         |  35 +-
 hw/arm/trace-events                     |   2 +-
 hw/arm/virt.c                           |  38 +-
 hw/gpio/aspeed_gpio.c                   |   2 +-
 hw/intc/arm_gicv3_common.c              |   4 +
 hw/intc/arm_gicv3_hvf.c                 | 822 ++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c            |  25 +
 hw/intc/meson.build                     |   2 +
 hw/net/Kconfig                          |   3 -
 hw/net/meson.build                      |   1 -
 hw/net/smc91c111.c                      |  16 +-
 hw/net/xgmac.c                          | 443 -----------------
 include/hw/arm/smmuv3-common.h          |   4 +-
 include/hw/intc/arm_gicv3_common.h      |   4 +
 include/migration/vmstate.h             |  10 +
 include/system/hvf.h                    |   8 +
 include/system/iommufd.h                |  14 +
 scripts/coverity-scan/COMPONENTS.md     |   2 +-
 scripts/lsan_suppressions.txt           |  26 +
 scripts/oss-fuzz/lsan_suppressions.txt  |   5 -
 system/qtest.c                          |   5 +-
 system/vl.c                             |   2 +
 target/arm/helper.c                     |   5 -
 target/arm/hvf/hvf.c                    | 466 +++++++++++++++++-
 target/arm/hvf/hvf_sme_stubs.h          | 172 +++++++
 target/arm/hvf/sysreg.c.inc             |  52 ++
 target/arm/hvf_arm.h                    |  46 ++
 target/arm/kvm-stub.c                   |   5 +
 target/arm/kvm.c                        |   9 +-
 target/arm/kvm_arm.h                    |   9 +
 target/arm/machine.c                    | 117 ++++-
 target/arm/trace-events                 |   3 +
 target/arm/whpx/whpx-all.c              |   7 -
 tests/docker/test-fuzz                  |   2 +-
 tests/qtest/iommu-smmuv3-test.c         |   1 +
 tests/qtest/qos-test.c                  |  36 +-
 tests/qtest/test-x86-cpuid-compat.c     |   4 +
 56 files changed, 2128 insertions(+), 1041 deletions(-)
 delete mode 100644 docs/system/arm/highbank.rst
 delete mode 100644 hw/arm/highbank.c
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
 delete mode 100644 hw/net/xgmac.c
 create mode 100644 scripts/lsan_suppressions.txt
 delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt
 create mode 100644 target/arm/hvf/hvf_sme_stubs.h

