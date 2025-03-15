Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF20C35FF3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSTd-0005Ku-6X; Sat, 15 Mar 2025 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSTb-0005KD-Fz
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:26:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSTZ-0003mb-5K
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:26:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so3978275e9.1
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048815; x=1742653615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G/as/eWxpNCQf3T8f3kWUcw2oxdRl+HTSlBOho3qY2Q=;
 b=hSItgPbkNeJKgSXp5bh2S3ixtzCKOHEAsZ9yxnNSxekSurNkZR2pl4Nj7zGpWk15Af
 LbCZctalVLAPzqC3EKp4pGkWBdrrkbeWtTaB2eH55tA5evqJfR0hWV/bc0tSZHsxlG/Z
 hGiO92D/EGt75yeb6SLaQdmUzJAkBzFkszIY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048815; x=1742653615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/as/eWxpNCQf3T8f3kWUcw2oxdRl+HTSlBOho3qY2Q=;
 b=iXGGO4FdrtcZS32y0lS4yV+ttqnzHJj/APF7g7cW00uNea8VA3Ja6z8ehXDwewHa27
 0PVAGiuEevFhVT0TlcOLXXZ15FdfnXCKufk51t4OgYo/dq3BCLaSy9ij+p1su4JelYF2
 E0ujU3jqBBXzVFONaZ+8C+lYARrX/9VwSJ7gkLH97fWV4dFYN8bPFqUbcOL5bqDM9B1v
 4uJpqBSGFC+V9UFjsBqvMSJj95Ghm1Cp7V/77orRi4f2DUNdSz1sXNRFSgl2ogZmfu6K
 dRSbM1EuGFsxN5fWelm3UcC/dt/8Dms1iHqXqMkLnnmmqDBYHsNHPXG5hnc2nYNk0yZn
 I1wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPPVjVJwgLCmu5RUjKq8oSZnMZWZEKuZ/k0zfnw/0zM/ozDFAGqiqPNPeor9T8hbgPL2PN+xnjJKv9@nongnu.org
X-Gm-Message-State: AOJu0YzocGcuKsjsk6UJ09pVu9cQWjSfCij2pxX+NWd9vGvIHEacH7ZL
 i4TF/Lrh3ehxU2KraDeD8JyhUgzPEJH8gF/fwkd8RS633YdbSSLO+A2nvLLfdg==
X-Gm-Gg: ASbGncvS9cwbLTFH4oLkFzErnG/lOyKtZL29XaTOjVaOY0BKuIQB5z/NtxgN3suc3S3
 cBhwxV8jjvNS+NRrdb+SdtwqwHa5CTY9aVapp8E0ouRe/F/Gr+hsP05tEnBaNMN4GInu8KCBJJg
 4urD4ofEI5HMaH9EgquI2dRP7hrliMI5vcnuCiFQIQZmPhKV6PcDgsnUdwOE51t+n46iNpFVoRE
 3EELSrovuREvCkBA4I0/B2Z2U+j43C5Ru/nqBFA93ZG9W9wRv3df6+/vEMcVCY965L1p/cFRQDF
 2XWZCjXX+XeUA0+ID2ECI2KFcGOmb5LTkR5alW658g==
X-Google-Smtp-Source: AGHT+IH09mYHfa7unVQewyjk+bC+XCLW5cDezkZPQTmt9lqzIwuLC1YbwfrRk2Ap6fkZitDgvBAfNg==
X-Received: by 2002:a05:600c:4fcb:b0:43d:7de:16e3 with SMTP id
 5b1f17b1804b1-43d1eccb1f1mr76786605e9.24.1742048814883; 
 Sat, 15 Mar 2025 07:26:54 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:26:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 00/46] x86: Improve operation under QEMU
Date: Sat, 15 Mar 2025 14:25:20 +0000
Message-ID: <20250315142643.2600605-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=sjg@chromium.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
is not perfect.

With both builds, executing the VESA ROM causes an intermittent hang, at
least on some AMD CPUs.

With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
is done in a way that works on real hardware but not with QEMU. This
means that performance is 4-5x slower than it could be, at least on my
CPU.

We can work around the first problem by using Bochs, which is anyway a
better choice than VESA for QEMU. The second can be addressed by using
the same descriptor across the jump to long mode.

With an MTRR fix this allows booting into Ubuntu on qemu-x86_64

In v3 some e820 patches are included to make booting reliable and avoid
ACPI tables being dropped. Also, several MTTR problems are addressed, to
support memory sizes above 4GB reliably.

Changes in v5:
- Drop timeouts patch
- Use Ctrl-N instead of down-arrow to make the test more reliable
- Add more logging into the test

Changes in v4:
- Rewrite the commit message
- Enable the flag by default
- Split out into separate patch
- Split out the command change into a separate patch

Changes in v3:
- Always return true from flag_is_changeable_p() on amd64
- Add new patch with functions to convert between mtrr size and mask
- Add new patch to update mtrr command to support 64-bit values
- Add new patch to update cpuid_eax et al to work on amd64
- Add new patch to correct msr operation on amd64
- Add new patch to allow adding non-aligned size for MTRR
- Support memory sizes above 3GB properly
- Add new patch to correct sizing of created disks
- Add new patch with a function to dump the e820 table
- Add new patch with an API for e820
- Add new patch to use the new e820 API
- Add new patch to support BLOBLIST_TABLES properly in QEMU
- Add new patch to support a 64-bit ramdisk address
- Add new patch to mark struct acpi_rsdp as packed
- Add new patch to consider non-bootable partitions
- Add new patch to handle running out of labels
- Add new patch to support IO UARTs for earlycon and console
- Add new patch to correct mapping in FADT
- Add new patch to add a checksum to the DMAR table
- Add new patch to correct memory leaks in the ACPI test
- Add new patch to support checking checksums with ACPI command
- Significantly expanded to correct e820 and other issues

Changes in v2:
- Redo commit message
- Add new patch to rename the _D dirty flag
- Add new patch to support CPU functions in long mode
- Add new patch to set an MTRR for the RAM in QEMU
- Add new patch with a helper to send characters
- Add new patch to allow tests to be filtered by role
- Add more patches to support booting with kvm
- Add new patch with a test for booting Ubuntu 24.04

Simon Glass (46):
  boot: Correct ramdisk address
  sandbox: Correct a typo in mapmem
  x86: Expand x86_64 early memory
  x86: qemu: Switch to bochs display
  x86: qemu: Enable dhrystone
  x86: qemu: Avoid accessing BSS too early
  x86: Drop mpspec from the SPL build
  x86: Add some log categories
  x86: Drop use of CONFIG_REALMODE_DEBUG
  x86: Avoid clearing the VESA display
  x86: Add 64-bit entries to the GDT
  x86: Use defines for the cache flags
  x86: spl: Drop duplicate CPU init
  x86: Drop the message about features missing in 64-bit
  x86: Include stdbool.h in interrupt header
  x86: Tidy up the GDT size in start/16.S
  x86: Disable paging before changing to long mode
  x86: Use the same GDT when jumping to long mode
  x86: Use a simple jump into long mode
  x86: Rename the _D dirty flag
  x86: Support CPU functions in long mode
  x86: Add functions to convert between mtrr size and mask
  x86: Update mtrr command to support 64-bit values
  x86: Update cpuid_eax et al to work on amd64
  x86: Correct msr operation on amd64
  x86: Allow adding non-aligned size for MTRR
  x86: emulation: Set an MTRR for the RAM
  x86: qemu: Support environment and cat command
  test/py: Correct sizing of created disks
  test/py: Add a helper to send characters
  test/py: Allow tests to be filtered by role
  x86: e820: Add a function to dump the e820 table
  x86: Add a new API for e820
  x86: qemu: Use the new e820 API
  x86: emulation: Support BLOBLIST_TABLES properly
  x86: Support a 64-bit ramdisk address
  acpi: Mark struct acpi_rsdp as packed
  boot: Consider non-bootable partitions
  boot: Handle running out of labels
  boot: Support IO UARTs for earlycon and console
  sandbox: acpi: Avoid a warning about FADT
  sandbox: acpi: Correct mapping in FADT
  acpi: Add a checksum to the DMAR table
  test: acpi: Correct memory leaks
  acpi: Support checking checksums
  test: Add a test for booting Ubuntu 24.04

 .gitlab-ci.yml                   |   8 ++-
 arch/x86/cpu/cpu.c               |  24 +++++++
 arch/x86/cpu/i386/call64.S       |  35 ++++------
 arch/x86/cpu/i386/cpu.c          |  41 ++++-------
 arch/x86/cpu/mtrr.c              | 115 ++++++++++++++++++++++++-------
 arch/x86/cpu/qemu/dram.c         |  18 +++++
 arch/x86/cpu/qemu/e820.c         |  62 +++++++----------
 arch/x86/cpu/qemu/qemu.c         |  20 ++++--
 arch/x86/cpu/start.S             |   4 +-
 arch/x86/cpu/start16.S           |   3 +-
 arch/x86/cpu/x86_64/cpu.c        |   5 --
 arch/x86/include/asm/bootparam.h |  15 +++-
 arch/x86/include/asm/cpu.h       |  91 ++++++++++--------------
 arch/x86/include/asm/e820.h      |  95 ++++++++++++++++++++++++-
 arch/x86/include/asm/interrupt.h |   1 +
 arch/x86/include/asm/msr.h       |   9 ++-
 arch/x86/include/asm/mtrr.h      |  16 +++++
 arch/x86/include/asm/processor.h |   5 +-
 arch/x86/lib/Makefile            |   2 +
 arch/x86/lib/bios.c              |  27 +++++---
 arch/x86/lib/bios_interrupts.c   |   8 +--
 arch/x86/lib/e820.c              |  70 +++++++++++++++++++
 arch/x86/lib/i8259.c             |   2 +
 arch/x86/lib/spl.c               |   4 +-
 arch/x86/lib/tables.c            |   9 ++-
 arch/x86/lib/zimage.c            |  34 +++------
 boot/bootdev-uclass.c            |   7 +-
 boot/bootflow.c                  |   7 +-
 boot/pxe_utils.c                 |   3 +-
 cmd/acpi.c                       |  59 ++++++++++------
 cmd/bootflow.c                   |   2 +-
 cmd/x86/mtrr.c                   |  11 ++-
 configs/qemu-x86_64_defconfig    |  18 ++---
 configs/qemu-x86_defconfig       |  12 ++--
 doc/develop/bootstd/overview.rst |   5 +-
 doc/usage/cmd/acpi.rst           |  20 +++++-
 drivers/misc/qfw_acpi.c          |  32 +++++++--
 include/acpi/acpi_table.h        |   2 +-
 include/bootflow.h               |   2 +
 include/bootstd.h                |   3 +
 include/mapmem.h                 |   2 +-
 lib/acpi/acpi_table.c            |   5 +-
 test/boot/bootdev.c              |   1 +
 test/boot/bootflow.c             |   5 +-
 test/dm/acpi.c                   |  59 ++++++++++++++++
 test/py/conftest.py              |  22 ++++++
 test/py/console_base.py          |  25 ++++---
 test/py/pytest.ini               |   1 +
 test/py/tests/test_distro.py     |  61 ++++++++++++++++
 test/py/tests/test_ut.py         |  17 ++++-
 50 files changed, 805 insertions(+), 299 deletions(-)
 create mode 100644 test/py/tests/test_distro.py

-- 
2.43.0


