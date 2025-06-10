Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C7AC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyX9-0006Xz-2I; Tue, 10 Jun 2025 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyWv-0006Wv-4U
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyWs-0002XP-CA
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so34144505e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560195; x=1750164995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jeuOGtzF3tzPzFfkJpJg8XisuC1RT3WPIytfTmZ7FFk=;
 b=QxTSQc5A7xJaVEmRufAwWIu0FyEkGHscph6V2i7XuTwljnOll7H40bOFJBT9yUGHmB
 CN92uRqyjobqc2xQ8mo3CD73u9PST2MntOIvWVfguf9vdmlxBCIv6m27dAezffndJUcM
 vePSK2SZfazwPk3EBLnq+7+flKlJ1lSVd5WAMXZhwkpIkzUHL+/nr40/m3JNxV4p/hPl
 aY9WaWahovhrpOGPgFnL+sm/XwV7pIILGNG+3XwXp0/C/X4F7VDU6c3iSuXNfeEezKHr
 9KDFfRWZeGmwODXjGwlAwzcGGjL94JHXZPn1u3JTsSvHYx8OTh0A1+YbXj/9rIqnjWmK
 gOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560195; x=1750164995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeuOGtzF3tzPzFfkJpJg8XisuC1RT3WPIytfTmZ7FFk=;
 b=mUhKAepDghTSim7kpd0QXzhnniHs04H6KBR01dGgSIbeMPuduuLJSKdD01nyTyVCVU
 y+3G3SAW8J0x7Udnraz410JqpTcOjberYiRFBlszR1ZloWhN4UWi4WWyHRJEuEK15fff
 B7b1+5aNi0oiR5KRWGFzOzgSW2NOAoWVydYip6Uj6Ueq7/opbxBcQODzSAY/h1M+Oov6
 BDyrSGbZ02T7xDs+bDGrmk8h34YMUwdP8scQ2isCTEAHuUfsa346lwuwqDm91HLi7nuX
 YGISl3fuIRNfUcfubV4H260Wn4xNNc+3JSZxB8jENJ4OFzvqEJfcbHlwm/92RAlS7MG6
 YiKQ==
X-Gm-Message-State: AOJu0YyQw8rUCYKeIdwoq1DHpHjgO9npp447XKWW6n3Q9vuB7lKaxnbR
 6KVW9UdpblVLUGpYlsvAWvGjetQXeilHAw3M51G4iP4uYLW0gt5S2+094zwsoswJ2s10UfoLkla
 ndtMu900=
X-Gm-Gg: ASbGnctxHg1a8lJ1T9HiLz4M3hVY5EO6qv/15zDf0YJGc7EipSAkW/sQXrjkWoGDIR4
 D1jhcpwYS7g1GBGFd9e3915t5fWXKKhrJrCjLyeBPSrIq8+MA9X8zv4B3sLfCX2KbGvcoEzFdtn
 veSdGIA2sv2ibG4a3nljawTAisGAFpUq2krXicKq8fi/+7wVPhQAqLlrIE0AZ2Y8f3tH08Febxf
 vdMD0/hiCu3xqvPYuaOGRrXgZYQuyQ9iu4tbj6rvj3fZgfXXmEJslLtvviW9n8eKIBo74XS+2Z/
 x6FLKhqvwX2PftGUWcsBX2BsSZN2Dj7p721Xyk/vsfkobi/qz05CpCnSxixBA3jqIOaSkbtTa9q
 8SOVzdfxQWFIg/Yu4dVwiEbuDvi9izI9P1nQsk5nVrw==
X-Google-Smtp-Source: AGHT+IF4V6/RfFf/YwRq2lOW9PZS+pU8Dn4ZCDXSbQEb0F9f3Thuk5fhGZX3LHNfdVfuC4ObwaerLw==
X-Received: by 2002:a05:600c:190e:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-45201416350mr140062525e9.25.1749560195351; 
 Tue, 10 Jun 2025 05:56:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d3esm141214785e9.6.2025.06.10.05.56.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:56:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/24] Misc HW patches for 2025-06-10
Date: Tue, 10 Jun 2025 14:56:09 +0200
Message-ID: <20250610125633.24411-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:

  Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250610

for you to fetch changes up to 46d9ac6602dfa3bd69fbee17198d77ac796b4919:

  hw/net/i82596: Factor configure function out (2025-06-10 12:59:09 +0200)

----------------------------------------------------------------
Misc HW patches
----------------------------------------------------------------

Akihiko Odaki (1):
  MAINTAINERS: Update Akihiko Odaki's affiliation

BALATON Zoltan (4):
  hw/pci-host/raven: Remove is-legacy-prep property
  hw/pci-host/raven: Revert "raven: Move BIOS loading from board code to
    PCI host"
  hw/ppc/e500: Move clock and TB frequency to machine class
  hw/net/fsl_etsec: Set default MAC address

Bernhard Beschow (1):
  hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
    resources

Daniel P. Berrangé (1):
  pc-bios: ensure installed ROMs don't have execute permissions

Philippe Mathieu-Daudé (6):
  hw/char/sh_serial: Delete fifo_timeout_timer in DeviceUnrealize
  hw/char/sh_serial: Convert to TypeInfo
  accel/hvf: Fix TYPE_HVF_ACCEL instance size
  hw/gpio/pca9552: Avoid using g_newa()
  backends/tpm: Avoid using g_alloca()
  tests/unit/test-char: Avoid using g_alloca()

Philippe Michaud-Boudreault (1):
  hw/misc/stm32_rcc: Fix stm32_rcc_write() arguments order

Soumyajyotii_Ssarkar (2):
  hw/net/i82596: Update datasheet URL
  hw/net/i82596: Factor configure function out

Thomas Huth (1):
  tests/functional: Add a test for the Arduino UNO machine

Zhao Liu (3):
  hw/core/resetcontainer: Consolidate OBJECT_DECLARE_SIMPLE_TYPE
  hw/hyperv/balloon: Consolidate
    OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
  hw/core/cpu: Move CacheType to general cpu.h

Zhenzhong Duan (4):
  hw/virtio/virtio-mem: Fix definition of VirtIOMEMClass
  hw/virtio/virtio-pmem: Fix definition of VirtIOPMEMClass
  hw/gpio/aspeed: Fix definition of AspeedGPIOClass
  hw/riscv/riscv-iommu: Remove definition of RISCVIOMMU[Pci|Sys]Class

 MAINTAINERS                      | 19 +++----
 hw/ppc/e500.h                    |  4 ++
 include/hw/core/cpu.h            |  6 +++
 include/hw/core/resetcontainer.h |  2 +-
 include/hw/gpio/aspeed_gpio.h    |  2 +-
 include/hw/riscv/iommu.h         |  6 +--
 include/hw/virtio/virtio-mem.h   |  2 +-
 include/hw/virtio/virtio-pmem.h  |  2 +-
 include/system/hvf_int.h         |  1 +
 target/i386/cpu.h                |  6 ---
 accel/hvf/hvf-accel-ops.c        |  1 +
 backends/tpm/tpm_emulator.c      |  4 +-
 hw/char/sh_serial.c              | 24 +++++----
 hw/gpio/pca9552.c                |  2 +-
 hw/hyperv/hv-balloon.c           |  9 ++--
 hw/misc/stm32_rcc.c              |  2 +-
 hw/net/fsl_etsec/etsec.c         |  1 +
 hw/net/i82596.c                  | 38 ++++++++------
 hw/pci-host/ppce500.c            |  8 +--
 hw/pci-host/raven.c              | 85 +++++---------------------------
 hw/ppc/e500.c                    | 26 +++++-----
 hw/ppc/e500plat.c                |  2 +
 hw/ppc/mpc8544ds.c               |  2 +
 hw/ppc/prep.c                    | 27 +++++++++-
 hw/riscv/riscv-iommu-pci.c       |  6 ---
 hw/riscv/riscv-iommu-sys.c       |  6 ---
 tests/unit/test-char.c           |  3 +-
 .mailmap                         |  3 +-
 pc-bios/meson.build              |  2 +-
 tests/functional/meson.build     |  1 +
 tests/functional/test_avr_uno.py | 32 ++++++++++++
 31 files changed, 166 insertions(+), 168 deletions(-)
 create mode 100755 tests/functional/test_avr_uno.py

-- 
2.49.0


