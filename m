Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07615C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSQ-0005Uu-66; Tue, 01 Jul 2025 13:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSG-0005RN-J9
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeS8-0003KC-JR
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so3027087f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389643; x=1751994443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QOHnZnuZkLefFPPn38bCNhPbcEbOkcGXJg0OrwCx5aE=;
 b=w1fuKuwxly2BOdn7bbFAlGPqEAtbzgZxRC2crijXBGG0GsAWYG9kQSDdh1IhP0IzHw
 ZnvvIVin9zoiwrqYQHe9+KvcnAA9S5gGSOsebNhw/ziKw4Ib06/0ecDn7adjcy9qrF8a
 j22E23lazWHOuhleRUzfHol3WqnFgoILxi414oW+cl8llhOE/2Arb2HpwBPr9TALnLGq
 NHb45zpSGmOBg5il7ekN+qshjkEgicPjDTjon93bEAqAqb/vyW1VMPfjAs4xx/674ZGy
 /iJQA03ZRzA0zXLAxcEuJlyinZrqnlwuNAwHdovonfjnS3N4QIjZHbpcGU2PMGIBNRV4
 bEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389643; x=1751994443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOHnZnuZkLefFPPn38bCNhPbcEbOkcGXJg0OrwCx5aE=;
 b=Vuk6JS7n4sPeS+JzSpphjm8uxp7YoZD4fyaZI1q1jUW9Bdj2/HRkYfmVb3/Mte3/cy
 XQks1MWwHcCBPWJsNQs3YRUZssBNA54wGZL3Ix73wbgNqZ8pEO6NH94HlOCz+Tuut7iI
 kSoxIcQtgrkMFJ8zQlS4BDl9LDkeI6urqXirHR/qQpFEwi3/RNjBQq+l4s9TqyfvTGh4
 xuxVV0VuNgpMfAWZbb6MbZFBVZzp3gA479POgX11+JFuBabciL6SuLIYsL2vZaap+53U
 7pogpOTUn+R5JkKuv0IPejsNtfcsbTegVwuY/tX5FQD6xxnTSwXs6i5G5baXNt9M+XVh
 pu+Q==
X-Gm-Message-State: AOJu0Yw9wmmosoRt7+rK1aCCkW/Db726Y0OWEklExabuMBWN6Dd8VgCo
 rgYqi4B4VZH5/YLiEmKsvnO1fY68SS0FTaX1jOjwpiUkGoNJNgTUL02WCd3K3EjjS75b/R9NR7C
 ZSLAe
X-Gm-Gg: ASbGncvo1OCf6LinX6mfL0XffwE9D3jrWzQqXwfDZ5u2Cp4MlmzRg0LE43UmmHXgObL
 ZIFr5CIp6Mw48aCYhGCkn6hUh4v6h7OkLlKrWsOdpPWy1HfA+71U46X+HnVjZJqrVBN2TdZ/KhX
 s6nwewWKWJsb3IFVGFWCM9Km9tIoJ3aTw0XWlbvACwgQv/NGvMbRlKicybWqGagP3dCwsyTMsmq
 xX5eTiJIxdwwhTvjoagYquLQObJTtmjizGBGvQNFjFrO9G9lGP6U4hUDllY4mQ/j8oE1kmBi+Ij
 vS329y341586hdRqj7GZkYOWJdJSfZ7xfRNG3ho0ByiU5DdNeBIiJAcSr/nwHrbVbKjSwRIoyzn
 l/14=
X-Google-Smtp-Source: AGHT+IFDF6fLP/1mwvAonXjZvg2qeSfdGXk6hg4xo0Z2btLdtKL8uqQPn59DMtDSCB1BefW29gIfkw==
X-Received: by 2002:a05:6000:440f:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3a8f454904fmr12265452f8f.10.1751389642526; 
 Tue, 01 Jul 2025 10:07:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/43] target-arm queue
Date: Tue,  1 Jul 2025 18:06:36 +0100
Message-ID: <20250701170720.4072660-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Hi; here's an arm pullreq. Most of it is refactoring and similar
cleanup type patches. I just switched to using gitlab as the
host for pullreq tags; I think I got the config change right but
let me know if this is broken somehow.

thanks
-- PMM

The following changes since commit 6138e72b7e33e0240ee955a2754dd038ee99494d:

  Merge tag 'pull-tcg-20250630' of https://gitlab.com/rth7680/qemu into staging (2025-07-01 04:25:08 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250701-1

for you to fetch changes up to 7bc86ccbb59f2022014e132327a33b94a7ed00fe:

  tests/functional: test device passthrough on aarch64 (2025-07-01 17:22:31 +0100)

----------------------------------------------------------------
target-arm queue:
 * MAINTAINERS update for arm hvf
 * target/arm: Make RETA[AB] UNDEF when pauth is not implemented
 * target/arm: Refactoring of ID register value storage
 * target/arm: Various refactoring/cleanup patches
 * virt: Don't show an ITS in ACPI tables when no ITS is present
 * tests/functional: test device passthrough on aarch64
 * tests/functional: Expand Aarch64 SMMU tests to run on HVF accelerator

----------------------------------------------------------------
Cornelia Huck (1):
      arm/kvm: use fd instead of fdarray[2]

Eric Auger (11):
      arm/cpu: Add sysreg definitions in cpu-sysregs.h
      arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays
      arm/cpu: Store aa64isar1/2 into the idregs array
      arm/cpu: Store aa64pfr0/1 into the idregs array
      arm/cpu: Store aa64mmfr0-3 into the idregs array
      arm/cpu: Store aa64dfr0/1 into the idregs array
      arm/cpu: Store aa64smfr0 into the idregs array
      arm/cpu: Store id_isar0-7 into the idregs array
      arm/cpu: Store id_pfr0/1/2 into the idregs array
      arm/cpu: Store id_dfr0/1 into the idregs array
      arm/cpu: Store id_mmfr0-5 into the idregs array

Gustavo Romero (6):
      hw/arm/virt: Simplify logic for setting instance's 'tcg_its' variable
      hw/arm/virt-acpi-build: Improve comment in build_iort
      hw/arm/virt-acpi-build: Factor out create_its_idmaps
      qtest/bios-tables-test: Add blobs for its=off test on aarch64
      hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off
      qtest/bios-tables-test: Update blobs for its=off test on aarch64

Mads Ynddal (1):
      MAINTAINERS: add myself as reviewer for Apple Silicon HVF

Peter Maydell (1):
      tests/functional: Add hvf_available() helper

Philippe Mathieu-Daudé (21):
      hw/intc/gicv3_its: Do not check its_class_name()
      hw/arm/virt: Simplify create_its()
      qtest/bios-tables-test: Add test for when ITS is off on aarch64
      target/arm: Remove arm_handle_psci_call() stub
      target/arm: Reduce arm_cpu_post_init() declaration scope
      target/arm: Unify gen_exception_internal()
      target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
      target/arm/hvf: Trace hv_vcpu_run() failures
      accel/hvf: Trace VM memory mapping
      target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
      target/arm: Correct KVM & HVF dtb_compatible value
      target/arm/hvf: Pass @target_el argument to hvf_raise_exception()
      target/arm: Restrict system register properties to system binary
      hw/arm/virt: Make EL3-guest accel check an accept-list
      hw/arm/virt: Make EL2 accelerator check an accept-list
      hw/arm/virt: Rename cpu_post_init() -> post_cpus_gic_realized()
      hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
      tests/functional: Set sbsa-ref machine type in each test function
      tests/functional: Restrict nested Aarch64 Xen test to TCG
      tests/functional: Require TCG to run Aarch64 imx8mp-evk test
      tests/functional: Expand Aarch64 SMMU tests to run on HVF accelerator

Pierrick Bouvier (1):
      tests/functional: test device passthrough on aarch64

Solomon Tan (1):
      target/arm: Make RETA[AB] UNDEF when pauth is not implemented

 MAINTAINERS                                        |   2 +
 meson.build                                        |   1 +
 accel/hvf/trace.h                                  |   2 +
 include/hw/intc/arm_gicv3_its_common.h             |   2 +-
 target/arm/cpu-features.h                          | 317 +++++++-------
 target/arm/cpu-sysregs.h                           |  42 ++
 target/arm/cpu.h                                   |  82 ++--
 target/arm/internals.h                             |  12 +-
 target/arm/tcg/translate.h                         |   1 +
 target/arm/cpu-sysregs.h.inc                       |  36 ++
 accel/hvf/hvf-accel-ops.c                          |   6 +
 hw/arm/sbsa-ref.c                                  |   8 +-
 hw/arm/virt-acpi-build.c                           | 186 ++++++---
 hw/arm/virt.c                                      |  38 +-
 hw/intc/armv7m_nvic.c                              |  27 +-
 target/arm/cpu.c                                   | 124 +++---
 target/arm/cpu64.c                                 | 128 +++---
 target/arm/helper.c                                |  68 +--
 target/arm/hvf/hvf.c                               |  72 ++--
 target/arm/kvm.c                                   | 139 +++----
 target/arm/ptw.c                                   |   6 +-
 target/arm/tcg/cpu-v7m.c                           | 174 ++++----
 target/arm/tcg/cpu32.c                             | 320 +++++++-------
 target/arm/tcg/cpu64.c                             | 459 +++++++++++----------
 target/arm/tcg/translate-a64.c                     |  10 +-
 target/arm/tcg/translate.c                         |   2 +-
 tests/qtest/bios-tables-test.c                     |  21 +
 accel/hvf/trace-events                             |   7 +
 python/qemu/utils/__init__.py                      |   8 +-
 python/qemu/utils/accel.py                         |   9 +
 target/arm/hvf/trace-events                        |   5 +-
 tests/data/acpi/aarch64/virt/APIC.its_off          | Bin 0 -> 164 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off          | Bin 0 -> 172 bytes
 tests/functional/meson.build                       |   2 +
 tests/functional/qemu_test/testcase.py             |   6 +-
 .../functional/test_aarch64_device_passthrough.py  | 142 +++++++
 tests/functional/test_aarch64_imx8mp_evk.py        |   1 +
 tests/functional/test_aarch64_sbsaref.py           |   5 +-
 tests/functional/test_aarch64_sbsaref_alpine.py    |   3 +-
 tests/functional/test_aarch64_sbsaref_freebsd.py   |   3 +-
 tests/functional/test_aarch64_smmu.py              |  12 +-
 tests/functional/test_aarch64_xen.py               |   1 +
 42 files changed, 1432 insertions(+), 1057 deletions(-)
 create mode 100644 accel/hvf/trace.h
 create mode 100644 target/arm/cpu-sysregs.h
 create mode 100644 target/arm/cpu-sysregs.h.inc
 create mode 100644 accel/hvf/trace-events
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
 create mode 100755 tests/functional/test_aarch64_device_passthrough.py

