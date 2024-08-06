Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C98C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJfd-0004rz-4P; Tue, 06 Aug 2024 08:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfb-0004px-2v
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfW-0008Ev-Pg
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7ac449a0e6so44334066b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948720; x=1723553520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oafBUJnJPxdfDSlslFuAdeciTJMbfPmoSpGpf+p1T6Q=;
 b=gpX8nwz7I5FwwrCAXGPqZL9vYIml1IivWX4xD4UC/NqgjtYA5z5PNxDtnVDs7Ph0us
 CJTfYiEcpdz17DOAaCXNHkB7inmBJDsqkKPq/5T0UBpKcZ9qZAyX1grY1LZCQ20JlIJ8
 rCuZUUc81BC4KkTPImra0Zcji1bAfzZzAhQMywSyrfH/kAFLKIHj1teuK88AiXvFDzZ9
 08OsTKSRHV5nHPVsAhRr43IBU4KJNz5xLQ3e3gkJKPrOtOHMuD8ca68wvitHhcsjxYmO
 jVaUgJAqz5xiUo6b3iJOvFXLFsbsCLp1cyQM7/7T+NY/MD92l7Kfefrr2LPQ4ynup+3d
 fbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948720; x=1723553520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oafBUJnJPxdfDSlslFuAdeciTJMbfPmoSpGpf+p1T6Q=;
 b=MKWlizbn9HEdl7+Sbqo8tFhxd70/Nx1nAQxk+55CfJFSHhJZmGrBi5xHOAu8cl2Zvo
 B6UsBQkAOZ49/zmnwGUMJVSzSB7uRY4yg2unlT80BFvO1ag4tR+O1beOofvb+xB/aI6Y
 9A2BkZkaawMiiDEjyllmtCqbEzGrC1D7mmHI22DhGh9lCxtdFnXXwyYOELE/05X6YRLa
 6tR7ty7GV55JYJ+3jSRAmHXridQa1LyXod3czNOtO3qUZOrdn2O2N3eTjG8Zc8HJVAkv
 po/gF5IPQs47R0uIleIi2v60HLLQDbyQWc794wBcgJt0hd6ALJgC2kAm7AwqC0irqsWp
 z/UQ==
X-Gm-Message-State: AOJu0YxrpGANo+PnucoHQT7qkulxSj9t388bTkOtlonpC1JttNvNFqFs
 9O7P4D14MOKA19H2z/NbNHZs4066FCWwZeKJNINbxKAfCs7ZZo1i22yvrfQWKUlMw2ji9I1DLYR
 G
X-Google-Smtp-Source: AGHT+IFxW1F9PzjFJ0RanJWBK1zqpylYdIT5t6YWw+D4638F76rbTgDIlT+fRVHYGm+/1sKJ3Evm1w==
X-Received: by 2002:a17:907:a0c:b0:a77:b054:ba7d with SMTP id
 a640c23a62f3a-a7dc509bc76mr1081440066b.46.1722948719825; 
 Tue, 06 Aug 2024 05:51:59 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3ce6sm546184066b.4.2024.08.06.05.51.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:51:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/28] Misc HW & UI patches for 2024-08-06
Date: Tue,  6 Aug 2024 14:51:28 +0200
Message-ID: <20240806125157.91185-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi,

Bigger PR than I expected for RC2, but unfortunately
the LoongArch Virt is broken so requires these patches
(it took me long to figure all the issues with them).

The following changes since commit e7207a9971dd41618b407030902b0b2256deb664:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-06 08:02:34 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240806

for you to fetch changes up to e006f0186bff4c66d3dd7a34e08fdae81d606480:

  docs/specs/pci-ids: Fix markup (2024-08-06 10:22:52 +0200)

----------------------------------------------------------------
Misc HW & UI patches

- Replace Loongson IPI with LoongArch IPI on LoongArch Virt machine (Bibo)
- SD card: Do not abort when reading DAT lines on invalid cmd state (Phil)
- SDHCI: Reset @data_count index on invalid ADMA transfers (Phil)
- Don't decrement PFlash counter below 0 (Peter)
- Explicit a 8bit truncate on IDE ATAPI (Peter)
- Silent Coverity warning in ISA FDC (Peter)
- Remove dead code in PCI IDE bmdma_prepare_buf (Peter)
- Improve OpenGL and related display error messages (Peter)
- Set PCI base address register write mask on GC64120 host bridge (Phil)
- List PCIe Root Port and PCIe-to-PCI bridge in QEMU PCI IDs list (George)

----------------------------------------------------------------

Bibo Mao (14):
  hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
  hw/intc/loongson_ipi: Extract loongson_ipi_common_realize()
  hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub
  hw/intc/loongson_ipi: Move common definitions to loongson_ipi_common.h
  hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIState
  hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_common.h
  hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_data()
  hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as handler
  hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_id
    handler
  hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpers
  hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c
  hw/intc/loongarch_ipi: Add loongarch IPI support
  hw/loongarch/virt: Replace Loongson IPI with LoongArch IPI
  hw/intc/loongson_ipi: Restrict to MIPS

George Matsumura (2):
  docs/specs/pci-ids: Add missing devices
  docs/specs/pci-ids: Fix markup

Peter Maydell (7):
  hw/block/pflash_cfi01: Don't decrement pfl->counter below 0
  hw/ide/atapi: Be explicit that assigning to s->lcyl truncates
  hw/block/fdc-isa: Assert that isa_fdc_get_drive_max_chs() found
    something
  hw/ide/pci: Remove dead code from bmdma_prepare_buf()
  hw/display/virtio-gpu: Improve "opengl is not available" error message
  system/vl.c: Expand OpenGL related errors
  ui/console: Note in '-display help' that some backends support
    suboptions

Philippe Mathieu-Daudé (5):
  hw/sd/sdcard: Explicit dummy byte value
  hw/sd/sdcard: Do not abort when reading DAT lines on invalid cmd state
  hw/sd/sdhci: Reset @data_count index on invalid ADMA transfers
  hw/pci-host/gt64120: Set PCI base address register write mask
  hw/pci-host/gt64120: Reset config registers during RESET phase

 MAINTAINERS                           |   6 +-
 docs/specs/pci-ids.rst                |   8 +-
 include/hw/intc/loongarch_ipi.h       |  25 ++
 include/hw/intc/loongson_ipi.h        |  51 +---
 include/hw/intc/loongson_ipi_common.h |  74 ++++++
 include/hw/loongarch/virt.h           |   1 -
 hw/block/fdc-isa.c                    |   2 +
 hw/block/pflash_cfi01.c               |   1 +
 hw/display/virtio-gpu-gl.c            |   8 +-
 hw/ide/atapi.c                        |   2 +-
 hw/ide/pci.c                          |   7 +-
 hw/intc/loongarch_ipi.c               |  68 +++++
 hw/intc/loongson_ipi.c                | 338 +++----------------------
 hw/intc/loongson_ipi_common.c         | 347 ++++++++++++++++++++++++++
 hw/loongarch/virt.c                   |   4 +-
 hw/pci-host/gt64120.c                 |  23 +-
 hw/sd/sd.c                            |  16 +-
 hw/sd/sdhci.c                         |   1 +
 system/vl.c                           |   5 +-
 ui/console.c                          |   5 +
 hw/intc/Kconfig                       |   8 +
 hw/intc/meson.build                   |   2 +
 hw/loongarch/Kconfig                  |   2 +-
 23 files changed, 634 insertions(+), 370 deletions(-)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongarch_ipi.c
 create mode 100644 hw/intc/loongson_ipi_common.c

-- 
2.45.2


