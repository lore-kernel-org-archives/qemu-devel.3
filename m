Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93327C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CB-0004o7-M3; Thu, 20 Aug 2026 08:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CA-0004kj-1x
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:34 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2C7-0001W2-O4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:33 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so313640866b.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230110; x=1787834910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GNkCfOLEsLAHbHCKhsqza9SCuQeJzZU8ZEAm4tg/LtU=;
 b=oiY0G7KEKOtwU3PUKbV/zrFZ25yHUSBx075rvSbelIxaUFQ0X/EGFnnMevjxbUnHuq
 UYsp2yvr12l28Zr+sHlhSQwsUwaxcdP5yWiz9yqW/BMA39aqu9WKvVj6jpSp+0+tgnJq
 agSwqkJ93TQgHBqkNRYplh/+NiwnVtiekWqMLb33q8SloFmidbGDKS2N7dhkTgqYnOjY
 nzmD6RoPg7jih8NZOUWgcaIOyllvMQw2iETdvzQ/vnH6d6FBl/ZzUhlhbOHo9q/THwoe
 Cng8ZDfJZDxkhb7qV26vdE1DAe9DYon5MAkxYDuvQitKB/WeXR0497iZtFAc5/+crbAE
 XYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230110; x=1787834910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GNkCfOLEsLAHbHCKhsqza9SCuQeJzZU8ZEAm4tg/LtU=;
 b=PxUxZ37eLV7Ju+7zffHuIH6rPpsNTNiSnqlcZPneFAaEcVrNt/edo44lIyPL/7rVaW
 8Dhsv4ERP9+lOYBz6AQ6JEI8jR2uyF0T7AJZLywuPavhW5RTSQsD92mg5W6K+0i2kLSh
 g+6AOlpIGYL7Y3YEyElvp9mPvEDKQ4Mi6uURpk4WcN7dldcDFZ553GNBGpvY7XEagFmz
 5NeUxAyAKeaXJteXD7xA2tVXGnCryJ1Z2f33ApOI+9tzQaG8hNt97Rrm5hcyjAUF+0ia
 nL2GXpy/jneOkwAGXEUkxNkpPIqxCdvb6+XSU9hI8p9hW2aU52H6okq2JAKGmmK58y7F
 MJig==
X-Gm-Message-State: AOJu0YxXYhJS15m3jJ+aPuxqg5etXaVH2pLgn9pl6Pfeyo68BlmyYBrV
 KMFSNOOZQRbMKR958USfMhVneQJb0i57k/s6Y1NI+ZkhRPTRNaumdSjT3Q/Sdolf
X-Gm-Gg: AR+sD10BA8hMWEL00iI7KfbVpFRLOm0oitTJmh2cEQO0QOawH934SCYY7OtkcYdi4Qn
 PspOAQ4g+W3wGcIictnO/F3IM2akJ2guj0q1955aBB7fip5Zf8J5f9XF2CeHbpIp0BSbnv84G+6
 TgwZGlYn444eXhEYWb8w+/dF+2fsFUzcjZA65v07ghs40LlRMjtwSeO6TjUVCpMGS7BY0Cxn5vA
 njBsP+bi3DyVvMgSsE72+WwBEKQl6KNX3TzD1tOFi47HS7rUVvXi2fUjPLgUFfzz/iY6D/y7JmV
 uegyUdooRzmvuglw5hdhm+fxuWqqI9SXa8si7E2HyAIAhLYt1I/kPBk/SUsrItYQEYS4/XmYVUy
 q+0vSre4dVI6u9OlO002Xl5LaR24wzolzLO1FQsjgErKh3O/ox9kE7CJuw/yKdClV4JtZ0CjVv6
 bcQorMNMmfDqOKyKf8byV/2IPlknJXMCnW5ZOImYRsacHFpa9P0dM4ALicM+IKaMhWtSms62KFh
 89rtAAzkEM=
X-Received: by 2002:a17:907:9997:b0:c20:af9d:4544 with SMTP id
 a640c23a62f3a-c23f92c2a0emr1066129966b.6.1787230109385; 
 Thu, 20 Aug 2026 05:48:29 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:28 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 00/14] hw/arm: add TI AM64x SoC and am64-virt machine
Date: Thu, 20 Aug 2026 14:48:00 +0200
Message-ID: <20260820124824.618671-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add support for the TI AM64x (Sitara AM6442) SoC and a board around it,
``am64-virt``. The model is complete enough to run the stock TI boot chain
end to end:

  ROM boot (tiboot3.bin) -> R5 SPL -> TF-A/OP-TEE -> U-Boot -> Linux SMP

This is a resend: I posted a first RFC back in May [1] but got no feedback
on it. Since then was the series rebased onto actual master, reworked for
style and split into reviewable pieces, so I send it out again in the hope
of getting some review.

RFC because I would like feedback on the overall approach before polishing
further; see the open questions at the end.

[1] https://lore.kernel.org/qemu-devel/20260528211210.74266-1-wafgo01@gmail.com/

What is modelled
================

The SoC is heterogeneous, and the model reflects that: a Cortex-A53
cluster behind a GICv3 (GIC-500) at the real addresses, the Cortex-R5F
MCU boot core, and the Cortex-M4F, each with their own RAT (region
address translation) view of the memory map.

The interesting part is the DMSC. On real silicon it is a hidden core
running TI's system firmware (SYSFW) which answers TI-SCI requests for
clocks, power, firewalls and processor boot control from every other core.
Rather than trying to execute the vendor blob, patch 10 models the DMSC
as a TI-SCI endpoint sitting on top of the secure proxy model (patch 9).
That is what actually starts the A53 and M4F cores when the R5 SPL asks
for it, and what TF-A, OP-TEE, U-Boot and Linux talk to for clock/power
management.

The remaining devices (patches 4-8) are the supporting cast: the UART,
the K3 DMTimer, mailboxes, and register-level stubs for CTRL_MMR
(including the DEVSTAT boot pins), GTC, DDRSS, the SDHCI PHY wrapper and
the TRNG. The
stubs implement the handshakes, which firmware polls for, not the
underlying hardware.

Patches 1-3 are prerequisites that touch existing code:

  1-2  give the OMAP I2C model its own Kconfig symbol so it can be reused
       outside the OMAP1 SoC, and implement soft reset and NACK reporting
  3    fixes SDHCI ADMA chain processing; without it, transfer rate
       depends from the virtual clock instead of on the guest's
       programming. Patch 14 contains a qtest that fails without it.

To patch 3: it is only needed as long as Bin Meng's SDHCI series [2] (on
top of the SDMA boundary fix [3]) is not merged. I posted the same fix
standalone in August, Bin showed then, that his series already covers
the AM64x case, and I have withdrawn it there [4]. It is kept here only
so that this series works on actual master - please drop patch 3
together with the pacing qtest in patch 14 as soon as [2] lands. A
version of that qtest for the Icicle Kit was posted separately [5].

[2] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=515264
[3] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=513930
[4] https://lore.kernel.org/qemu-devel/20260810124519.34501-1-wafgo01@gmail.com/
[5] https://lore.kernel.org/qemu-devel/20260813123210.28987-1-wafgo01@gmail.com/

Testing
=======

Patch 14 adds:

  * a unit test for the combined-boot-image parser
  * qtests for the machine topology, GICv3 layout, SMP handling and the
    DMSC TI-SCI request/response path
  * an I2C qtest (soft reset, NACK, and a read from an at24c EEPROM which
    the test attaches with -device)
  * the SDHCI ADMA pacing reproducer
  * a functional test that builds a synthetic tiboot3.bin containing a
    bare-metal R5 payload and checks it runs from the certified entry
    point. Setting QEMU_TEST_TIBOOT3 boots a real image instead.

Migration is not supported yet: none of the new devices has a VMState.
I left it out for the RFC, but can add it if you want it before merge.

The series was built and tested on top of ae4f344320. Every patch builds
on its own, and checkpatch reports no errors.

Open questions
==============

  * pc-bios/dtb/am64-virt.dtb: patch 13 checks in a generated DTB (with
    its source) for convenience. I am not sure a machine-specific blob
    belongs in pc-bios; happy to drop it and have the functional test
    generate it with dtc instead, or drop the Linux-boot part of the test.

  * Splitting the DMSC: hw/misc/ti-dmsc.c is large because TI-SCI is
    large. It could be split per message class (clocks / devices /
    processor boot / security) if reviewers prefer, at the cost of a
    non-functional intermediate state.

  * Only one of the four R5F cores is modelled. mc->max_cpus reserves
    room for the rest. Because the SoC realizes M4F/R5F vCPUs in addition
    to the A53s and every vCPU needs a TCG context slot inside
    smp.max_cpus, the machine defaults to the full vCPU budget. I would
    appreciate a better idea than the actual "fail early with an
    explanatory message" handling when the user passes a too-small -smp.

  * The register-level stubs (DDRSS in particular) fake success rather
    than modelling the hardware. That is deliberate, but tell me if you
    would rather see them as plain unimplemented-device windows plus
    firmware quirks elsewhere.

Wadim Mueller (14):
  hw/i2c/omap_i2c: add a dedicated CONFIG_OMAP_I2C symbol
  hw/i2c/omap_i2c: implement soft reset and NACK reporting
  hw/sd/sdhci: complete non-interrupt ADMA descriptor chains in one pass
  hw/char: add TI AM64x UART model
  hw/timer: add TI K3 DMTimer model
  hw/misc: add TI K3 CTRL_MMR, GTC, DDRSS, SDHCI PHY and TRNG models
  hw/misc: add TI RAT (region address translation) model
  hw/misc: add TI mailbox (IPC) model
  hw/misc: add TI K3 secure proxy model
  hw/misc: add TI DMSC (TI-SCI system controller) model
  hw/arm: add TI K3 combined boot image parser
  hw/arm: add TI AM64x SoC model
  hw/arm: add the am64-virt machine
  tests: add AM64x unit, qtest and functional tests

 MAINTAINERS                                   |   22 +
 docs/system/arm/am64.rst                      |   74 +
 docs/system/target-arm.rst                    |    1 +
 hw/arm/Kconfig                                |   26 +
 hw/arm/am64-virt.c                            |  347 ++++
 hw/arm/k3-bootrom-parse.c                     |  250 +++
 hw/arm/k3-bootrom.c                           |  125 ++
 hw/arm/meson.build                            |    4 +
 hw/arm/ti-am64x.c                             | 1223 ++++++++++++
 hw/arm/trace-events                           |    4 +
 hw/char/Kconfig                               |    4 +
 hw/char/meson.build                           |    1 +
 hw/char/ti-am64-uart.c                        |  109 ++
 hw/i2c/Kconfig                                |    4 +
 hw/i2c/meson.build                            |    2 +-
 hw/i2c/omap_i2c.c                             |  234 ++-
 hw/misc/Kconfig                               |   27 +
 hw/misc/meson.build                           |   10 +
 hw/misc/ti-dmsc.c                             | 1725 +++++++++++++++++
 hw/misc/ti-k3-ctrlmmr.c                       |  103 +
 hw/misc/ti-k3-ddrss.c                         |   98 +
 hw/misc/ti-k3-gtc.c                           |  100 +
 hw/misc/ti-k3-sdhci-phy.c                     |   91 +
 hw/misc/ti-k3-trng.c                          |  139 ++
 hw/misc/ti-mailbox.c                          |  566 ++++++
 hw/misc/ti-rat.c                              |  290 +++
 hw/misc/ti-sec-proxy.c                        |  446 +++++
 hw/misc/trace-events                          |   62 +
 hw/sd/sdhci-internal.h                        |    9 +
 hw/sd/sdhci.c                                 |   23 +-
 hw/timer/Kconfig                              |    3 +
 hw/timer/meson.build                          |    1 +
 hw/timer/ti-k3-dmtimer.c                      |  177 ++
 include/hw/arm/k3-bootrom.h                   |   43 +
 include/hw/arm/ti-am64x.h                     |   86 +
 include/hw/char/ti-am64-uart.h                |   28 +
 include/hw/misc/ti-dmsc.h                     |  661 +++++++
 include/hw/misc/ti-k3-ctrlmmr.h               |   26 +
 include/hw/misc/ti-k3-ddrss.h                 |   26 +
 include/hw/misc/ti-k3-gtc.h                   |   23 +
 include/hw/misc/ti-k3-sdhci-phy.h             |   26 +
 include/hw/misc/ti-k3-trng.h                  |   35 +
 include/hw/misc/ti-mailbox.h                  |   44 +
 include/hw/misc/ti-rat.h                      |   51 +
 include/hw/misc/ti-sec-proxy.h                |  108 ++
 include/hw/timer/ti-k3-dmtimer.h              |   30 +
 pc-bios/dtb/am64-virt.dtb                     |  Bin 0 -> 6116 bytes
 pc-bios/dtb/am64-virt.dts                     |  292 +++
 tests/functional/aarch64/meson.build          |    2 +
 tests/functional/aarch64/test_am64_bootrom.py |  137 ++
 tests/qtest/am64-adma-pacing-test.c           |  243 +++
 tests/qtest/am64-virt-test.c                  |  502 +++++
 tests/qtest/meson.build                       |    1 +
 tests/qtest/ti-am64-i2c-test.c                |  137 ++
 tests/unit/meson.build                        |    1 +
 tests/unit/test-k3-bootrom.c                  |  263 +++
 56 files changed, 9060 insertions(+), 5 deletions(-)
 create mode 100644 docs/system/arm/am64.rst
 create mode 100644 hw/arm/am64-virt.c
 create mode 100644 hw/arm/k3-bootrom-parse.c
 create mode 100644 hw/arm/k3-bootrom.c
 create mode 100644 hw/arm/ti-am64x.c
 create mode 100644 hw/char/ti-am64-uart.c
 create mode 100644 hw/misc/ti-dmsc.c
 create mode 100644 hw/misc/ti-k3-ctrlmmr.c
 create mode 100644 hw/misc/ti-k3-ddrss.c
 create mode 100644 hw/misc/ti-k3-gtc.c
 create mode 100644 hw/misc/ti-k3-sdhci-phy.c
 create mode 100644 hw/misc/ti-k3-trng.c
 create mode 100644 hw/misc/ti-mailbox.c
 create mode 100644 hw/misc/ti-rat.c
 create mode 100644 hw/misc/ti-sec-proxy.c
 create mode 100644 hw/timer/ti-k3-dmtimer.c
 create mode 100644 include/hw/arm/k3-bootrom.h
 create mode 100644 include/hw/arm/ti-am64x.h
 create mode 100644 include/hw/char/ti-am64-uart.h
 create mode 100644 include/hw/misc/ti-dmsc.h
 create mode 100644 include/hw/misc/ti-k3-ctrlmmr.h
 create mode 100644 include/hw/misc/ti-k3-ddrss.h
 create mode 100644 include/hw/misc/ti-k3-gtc.h
 create mode 100644 include/hw/misc/ti-k3-sdhci-phy.h
 create mode 100644 include/hw/misc/ti-k3-trng.h
 create mode 100644 include/hw/misc/ti-mailbox.h
 create mode 100644 include/hw/misc/ti-rat.h
 create mode 100644 include/hw/misc/ti-sec-proxy.h
 create mode 100644 include/hw/timer/ti-k3-dmtimer.h
 create mode 100644 pc-bios/dtb/am64-virt.dtb
 create mode 100644 pc-bios/dtb/am64-virt.dts
 create mode 100644 tests/functional/aarch64/test_am64_bootrom.py
 create mode 100644 tests/qtest/am64-adma-pacing-test.c
 create mode 100644 tests/qtest/am64-virt-test.c
 create mode 100644 tests/qtest/ti-am64-i2c-test.c
 create mode 100644 tests/unit/test-k3-bootrom.c


base-commit: ae4f3443209ab154b48b706a146e5f557ab147cb
-- 
2.43.0


