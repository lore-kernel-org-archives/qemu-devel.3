Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5313C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlVS-0007Eq-P6; Sun, 16 Feb 2025 15:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVR-0007Eh-PX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:49 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVQ-0005f2-2k
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:49 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-855799b9d1cso36672639f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 12:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738686; x=1740343486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9o36hZKDCWruTMgvAe6c+Acq8fbx9dtL4I2IvxRSnR4=;
 b=kcJ5MSjHFSJZy9DB6f0l2QOu8UslCo36AoOKmqbMXhAObu8b8tmnywuJJKwhrgTaV2
 Zp9D7Zm2vWCqAPQTOKRyzFyRyd3VHLSvkERTkErZO3fxZhROeMnymqBG0v7kT3Hxw9xi
 x6ABbAK4hdgWJumaKZ2Tq/qdZmJp7e7snUtyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738686; x=1740343486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9o36hZKDCWruTMgvAe6c+Acq8fbx9dtL4I2IvxRSnR4=;
 b=hAD5itOTNFNVzNCPid8y6j/Pg32Wx3mxRnuZyREwTvREtb2MF+nGxzTffyI3hB5Ywk
 woSvtPOrRGaXfEaLa8Mv5FYQ2TaQtrRIBY4+UoU+x+X4MFKwtdWhI3uw2QQHINyarOa9
 x3AmHzp0ni8mwvQS776MOl/SqaTHq1afwwIn5KqKxPNdS6LfMltdPUAkstYWGda636ZP
 aWgzZjH7ir1a3UPZpH4rKG1I+3KA33EdiFVOsymQItLpu8KA/+FCsnqYBnqN+1caj9sH
 xM8F/7i4Pt6NtXlpXe+bL6V2wThhZVL9/ooqD0XsvQMZj6Skk0GbNBtPJYQD0oovz7TQ
 ZW5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ7PwrFUKyElT6BO7ZR96IlVOUmWScMDO+lJriiFe6IMJBaUMTTWAaiWXOBGbVJDQ2P6jbbtSc9K7P@nongnu.org
X-Gm-Message-State: AOJu0Yynu//dlNXKv5KUx5mUMN1u9g+uK+8eVEV+5CE6g+g4eMPlO+O/
 ot49/P+YdUSH0/8WUs8Vsu9aG7+KyF2QIiaV8oD2MZQJjtRP7SA8x68jc5x4fQ==
X-Gm-Gg: ASbGnctwmnwOl/f+kBB+wOt3j0gNJoz30nov67/k37nkzsg3Mw2q/W5DtRHZ9nEoK+g
 xQMiwEfnE4iaXLU7EGcAkMCmkPpxH8z7FrBtqJw8UOfThS3h3eQysQ5dQS/OLX4NthWwMhb6rkX
 IhWKwDjgF6KekuUGJLFILb1MTafNUonq/OAmI3N+o64egS6V6VVNSAtTXbh54BP9Uj2cLwLtUgB
 08Gixo4wn9xFjAlLlh0OqbIkaJEHs0elGrTJ9uRk/blo9uoPuCKNUeVhZJLuI8nBPAT7bnbeZsf
 pyFQr64ucCgaiu0gCsHUqTEMfBOhkUs8vPdfyaXXNEA6C3yxyvZP
X-Google-Smtp-Source: AGHT+IFXGBJhpKuAnjOnDsrHsy6/84yGXy9ofKXFEeQ34NCD2J6ShVa/NF09vbWUthX1c4jj7VhV0w==
X-Received: by 2002:a05:6e02:2686:b0:3d1:bbc2:a324 with SMTP id
 e9e14a558f8ab-3d28076e074mr71196395ab.4.1739738685752; 
 Sun, 16 Feb 2025 12:44:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 00/28] x86: Improve operation under QEMU
Date: Sun, 16 Feb 2025 13:43:45 -0700
Message-ID: <20250216204421.3560012-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd30.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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

Changes in v2:
- Redo commit message
- Add new patch to rename the _D dirty flag
- Add new patch to support CPU functions in long mode
- Add new patch to tidy up address size in MTRR calculations
- Add new patch with a 64-bit version of is_power_of_2()
- Add new patch to set an MTRR for the RAM in QEMU
- Add new patch with a helper to send characters
- Add new patch to allow tests to be filtered by role
- Add more patches to support booting with kvm
- Add new patch with a test for booting Ubuntu 24.04

Simon Glass (28):
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
  x86: Tidy up address size in MTRR calculations
  Add a 64-bit version of is_power_of_2()
  x86: Support MTRRs of 4GB on 32-bit machines
  x86: emulation: Set an MTRR for the RAM
  scripts: Expand a few options
  test/py: Add a helper to send characters
  test/py: Allow tests to be filtered by role
  RFC: test/py: Deal with timeouts
  test: Add a test for booting Ubuntu 24.04

 .gitlab-ci.yml                   |  5 +++
 arch/x86/cpu/cpu.c               | 24 +++++++++++++++
 arch/x86/cpu/i386/call64.S       | 35 +++++++++------------
 arch/x86/cpu/i386/cpu.c          | 41 +++++++++---------------
 arch/x86/cpu/mtrr.c              | 12 +++++---
 arch/x86/cpu/qemu/dram.c         | 15 +++++++++
 arch/x86/cpu/qemu/qemu.c         | 20 ++++++++----
 arch/x86/cpu/start.S             |  4 ++-
 arch/x86/cpu/start16.S           |  3 +-
 arch/x86/cpu/x86_64/cpu.c        |  5 ---
 arch/x86/include/asm/cpu.h       | 35 ++++++++++++++++++---
 arch/x86/include/asm/interrupt.h |  1 +
 arch/x86/include/asm/processor.h |  5 ++-
 arch/x86/lib/Makefile            |  2 ++
 arch/x86/lib/bios.c              | 27 +++++++++-------
 arch/x86/lib/bios_interrupts.c   |  8 ++---
 arch/x86/lib/i8259.c             |  2 ++
 arch/x86/lib/spl.c               |  4 +--
 configs/qemu-x86_64_defconfig    | 10 +++---
 configs/qemu-x86_defconfig       |  6 ++--
 include/linux/log2.h             |  6 ++++
 scripts/build-qemu.sh            |  4 +--
 test/py/conftest.py              | 22 +++++++++++++
 test/py/console_base.py          | 33 ++++++++++++--------
 test/py/pytest.ini               |  1 +
 test/py/tests/test_distro.py     | 53 ++++++++++++++++++++++++++++++++
 test/py/tests/test_sleep.py      |  1 +
 27 files changed, 273 insertions(+), 111 deletions(-)
 create mode 100644 test/py/tests/test_distro.py

-- 
2.43.0


