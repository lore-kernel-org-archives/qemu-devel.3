Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F259FCB61A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXNf-0005a1-Bl; Fri, 06 Mar 2026 10:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXNa-0005Nd-Lp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:46:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXNY-0002Dl-6w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:46:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso1877355e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772811974; x=1773416774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Zp+GO0jZOlq9CH5HmHi4J1cmVnJhE95FM7W/42vfr4=;
 b=h4XfXX+cmq7/bJqG/kBZiYMIBDHo3N5eC3YWNkIJq6bhV9jf2LLj5r/RAWbXVpp/mW
 jmyvz9F0u6B+WKIAOqJTSDb4aFJBAQjuzz+leVGp5q9/fmhPa8rvwZ0F23doFY3QteKp
 NvHyiPr+7gBfcgvWwvAfRyjiMoMABaR2EH3LxOLQhI5io6bAQqzgIR+w1sI6+FjuBX7C
 ut+7A3zj2MLuXaFtYjlyxDoyjM7BMIjGEoA8E+mJ/CR33KzuXZU7EBLjbP84lPRipWyt
 NmNTORJnVCBHcx6GQurCGh4dp3vwcKj/NaMKcj4yJw9OEpopha/U6GaktLwq7Z/nrjom
 oRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772811974; x=1773416774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Zp+GO0jZOlq9CH5HmHi4J1cmVnJhE95FM7W/42vfr4=;
 b=SQeXza+X8nOVw0K+dg3J6CWauNn0etWGVkzSH+/lwQPBS1GEs1z7zVQ/zAjYIpNyWU
 76sAAlJEZc7DnttlvVzg1ErBlGr11fJWzcQGBOTY5pBrCb/RmJ/Tg0ropZmXzKKaCynT
 ePj0Ladmi6KYv6QiQrfBqby2NRun/41dXA89mqWLJ0n7Q9el01UOkGyFUkC0z14dTr4P
 B6Hj5+uJMQmFDO2dxoeXzejrnN/1b8cP7wgFpYDr54176GIjYAzVO+6d48smmEwxPwQN
 pqa4X5hH0H8xJsUZ6D5Umwi4XjlFxS7Gau+NxlM0zc/VACNcgj3BMXn6KK9N2zLx+Dsd
 wDng==
X-Gm-Message-State: AOJu0YzVshdPx+6vB/l+gX6Rv2jKvZ8HppzZPRm5sI8jT3SDpcrPArMV
 c8EfTvmnu4vL+H9YW026yBvoKO0jClw+cxJXMkkTSDb6TUjBx7D3T/WQm8J8vZC5Fyvx//1go/f
 eKOy8
X-Gm-Gg: ATEYQzwMpoWdZGtubWbrbFPcsQ3WP5ug2wniwob4JnjLihv4qYdxFhU0FjG6vyOr/NM
 5ii4gHDqSa1nThz0NudZegpooRQcHndS9hPlFeKIhBnq+2Y5ovFWJIcboDqmUwBI/WHGj//KHRM
 ys1Q1iS82paPdFu3n/f9GWz6CzXj6NErTpvsiLf11aBsxDW9wiBSnAuI4GfZsxmD7vMssKFfzhD
 flU/cT6E7Dt4YqggexZETl7Ds+EASYQqcusKwUsQZJm+7fIfe3yJdj3jZohmww7IpWbHeiWfqLi
 cpVDf2JTZbaJ/7o9d3XXSezujj78Mcl0ohHFGrt2M2osxjm0cWGFawcXo4O4fo/qGFnLRvR2tEb
 Jvr/G3UDoUG6uUW/fubXcmDxqsBXDf5wXty+yENLifqND9Iq18vSUTvo9fWGXnFSvleD+mGuz9B
 MwWt08m58dSbFbq+xzviDtNOHL1tKsD+2xA3hpvpA2svgdN3zNq/mclQcWsbbPucDiW5ySHCy+6
 xUBS2qJMpDdN1jMlsHpzIGR8LHC6SU=
X-Received: by 2002:a05:600c:37cc:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-48526967a63mr41141325e9.28.1772811973879; 
 Fri, 06 Mar 2026 07:46:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246fd237sm36788275e9.7.2026.03.06.07.46.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:46:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/45] target-arm queue
Date: Fri,  6 Mar 2026 15:46:12 +0000
Message-ID: <20260306154612.2196216-1-peter.maydell@linaro.org>
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

Changes from v1: dropped the last 4 patches from the hvf virtualization
series as they caused the macos CI job to fail.

-- PMM

The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:

  Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260306-1

for you to fetch changes up to 394144821aa8d4b704d6013f421bf8bfd43a333a:

  target/arm: hvf: add asserts for code paths not leveraged when using the vGIC (2026-03-06 13:28:49 +0000)

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
 * hvf: preliminaries for nested virtualisation support

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

Mohamed Mediouni (11):
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
 hw/arm/virt.c                           |  29 +-
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
 target/arm/hvf/hvf.c                    | 399 +++++++++++++++-
 target/arm/hvf/hvf_sme_stubs.h          | 172 +++++++
 target/arm/hvf/sysreg.c.inc             |   8 +
 target/arm/hvf_arm.h                    |  41 ++
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
 56 files changed, 2006 insertions(+), 1038 deletions(-)
 delete mode 100644 docs/system/arm/highbank.rst
 delete mode 100644 hw/arm/highbank.c
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
 delete mode 100644 hw/net/xgmac.c
 create mode 100644 scripts/lsan_suppressions.txt
 delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt
 create mode 100644 target/arm/hvf/hvf_sme_stubs.h

