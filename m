Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48513D74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInG-00071N-U2; Fri, 23 Jan 2026 10:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInD-0006yK-GY
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:47 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInB-000300-8O
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:47 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso26760515e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180983; x=1769785783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QKaeC79SyRNtTwshchvmwU1mfm3otynKDkSTOxM6SeI=;
 b=NtLnUjnc1DmpJNQMPWSjE39tmhF7Eo2AxpR7xaUU7cYQgSLDmM7ao4FutVKw396kIE
 u/rN2A8xolIeYM14CXuhv2MrBewW2j0dHIDh8tLpeGacPFEWt8EVr5mYBAiCOiLT2goM
 jXA9wXr0UkTl0B+Feq5a/b/SLyKv8GZPp3xKnhn6HSHVIHoexepB+CocI8LemJH2cksy
 Mj7gmkzPHEI946Je3jfiNdUzQ1ynJXmz/ZE/mo99AoUNkhwe8ILDwPbHoN36M64NCpgh
 /Oyx2LHpDZpDpAqyZgjvpxyAVuwkqFeBkoDeI+869mLSKFHYW8Rii4VswVVPOaGPTubr
 nUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180983; x=1769785783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QKaeC79SyRNtTwshchvmwU1mfm3otynKDkSTOxM6SeI=;
 b=AmfdPC4KWY6xy/Kr+tM6zQerT7Xzt1lfxqW5Mm/N7YCGnTXQEkStJrT27pxQjcceLt
 CgiBXPR4utdEQZiiyDxBTFhapSqGpfM35+gucgUCOuvcQTzPuIeKBmqPYbhZnyaXY8jj
 oE95nMC33T3wf/7434HtJkJ83VQ4JMQXmBISfCu3Gne9HJ8n25OuaEOnb8u3v7pYQSfT
 P8d8fiuw7xsoQgp/QJdBXI5UVRY+RtNtui/36fjdDXnlWRRBi4wD4zKsijLaQFNWCJmL
 VrfNqSBYtNjXpEBaAEBtuZ3b4KWBZaNI136Taj0iYm+hOSSnypzG6mv5dy/0zuaIexue
 MMRg==
X-Gm-Message-State: AOJu0Ywo12zN9xwcylFu2PFlRL2a/hgQwNw1dXHZjW2dn6506LRkxa/X
 5QqsfYPkABodsarhBf3nCBOE6goF+EDNbw4mtU/8tDZSAjYr7t/vZbSDJXkKi6O2jM0QfrkXjHW
 K4TY8cfs=
X-Gm-Gg: AZuq6aJFvD5ZAJWPLEWjpgOG+XzyaCvuWtu/giKuHfisZ0H2vW641Y7SLV8QW9tWtfr
 705HLWmX5CXkAxTEaChyuzqtFCF2nGSAq/kjyeEz39rNyfOSZ31hU7UjP3jC5aSEhmPtse39xzU
 VP0tJ77aCOlvDR7rPZmVMUd7zdVrjqZ+gTyG1Nf9pdYFrYH2DW88vTwjLSkvjfaLmriC0PXbMT6
 DXg+spbcGe2/VulZ5mnRu6Ve567MFqfdQc/zW+ECVAxif6kbE6Od3IV9SkkKp2zVfJemFeJQPX5
 /BBjn95CONQI7f+XoHslzEwXDmN/CrdwDLcaVI9t5lWYFIGepcn+KOFgO89EGWsrjAs7YB8vVXJ
 0KlmMBQRV3licth6gt4UrljVHhezEexy+8FYVCb7O7f/2z3ll0FvePLncOAB9zhNOVzrTWSLUYP
 FqU9cO8YHIHtKwaYLkpQ7YfUslCrs7EtWKc1zAI4lP88Mb0ubKl7lg
X-Received: by 2002:a05:600c:1388:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-4804c958615mr50064385e9.9.1769180982581; 
 Fri, 23 Jan 2026 07:09:42 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/22] target-arm queue
Date: Fri, 23 Jan 2026 15:09:18 +0000
Message-ID: <20260123150941.1877768-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi; here's a target-arm pullreq. Most of the patches in it
are actually docs and similar tidyups, though...

thanks
-- PMM

The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:

  Merge tag 'hw-misc-20260120' of https://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260123

for you to fetch changes up to 62580edc02ae16ba520d220f6fd7556999504a84:

  qemu-options.hx: Improve formatting in colo-compare docs (2026-01-23 14:08:57 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/imx8mp-evk: Provide some defaults matching real hardware
 * hw/intc: endianness fixes
 * various: Clean up includes
 * kernel-doc.py: sync with upstream Kernel v6.19-rc4
 * scripts/clean-includes: Minor improvements; exclude list update
 * docs/system/arm/imx8mp-evk: Avoid suggesting redundant CLI parameters
 * docs/system/arm/xlnx-zynq.rst: Improve docs rendering
 * docs: Be consistent about capitalization of 'Arm' (again)
 * docs: Avoid unintended mailto: hyperlinks
 * qemu-options.hx: Drop uses of @var
 * qemu-options.hx: Improve formatting in colo-compare docs

----------------------------------------------------------------
Alex Bennée (4):
      hw/intc: declare NVIC regions as little endian
      hw/intc: declare GIC regions as little endian
      hw/intc: declare GICv3 regions as little endian
      hw/intc: avoid byte swap fiddling in gicv3 its path

Bernhard Beschow (2):
      hw/arm/imx8mp-evk: Provide some defaults matching real hardware
      docs/system/arm/imx8mp-evk: Avoid suggesting redundant CLI parameters

Mauro Carvalho Chehab (1):
      kernel-doc.py: sync with upstream Kernel v6.19-rc4

Peter Maydell (15):
      docs: Be consistent about capitalization of 'Arm' (again)
      scripts/clean-includes: Allow directories on command line
      scripts/clean-includes: Remove outdated comment
      scripts/clean-includes: Make ignore-regexes one per line
      scripts/clean-includes: Do all our exclusions with REGEXFILE
      scripts/clean-includes: Give the args in git commit messages
      scripts/clean-includes: Update exclude list
      mshv: Clean up includes
      bsd-user: Clean up includes
      misc: Clean up includes
      all: Clean up includes
      docs/system/arm/xlnx-zynq.rst: Improve docs rendering
      docs: avoid unintended mailto: hyperlinks
      qemu-options.hx: Drop uses of @var
      qemu-options.hx: Improve formatting in colo-compare docs

 accel/mshv/irq.c                      |   3 +-
 accel/mshv/mshv-all.c                 |   1 -
 bsd-user/bsd-mem.h                    |   3 -
 bsd-user/bsd-proc.c                   |   1 -
 bsd-user/freebsd/os-proc.h            |   2 -
 bsd-user/qemu-bsd.h                   |   1 -
 docs/devel/submitting-a-patch.rst     |   2 +-
 docs/devel/testing/qgraph.rst         |   8 +-
 docs/devel/vfio-iommufd.rst           |   2 +-
 docs/specs/fsi.rst                    |   2 +-
 docs/system/arm/aspeed.rst            |   6 +-
 docs/system/arm/b-l475e-iot01a.rst    |   2 +-
 docs/system/arm/imx8mp-evk.rst        |   4 +-
 docs/system/arm/nrf.rst               |   4 +-
 docs/system/arm/stm32.rst             |  12 +-
 docs/system/arm/xlnx-versal-virt.rst  |  16 +-
 docs/system/arm/xlnx-zynq.rst         |  51 +-
 docs/system/device-url-syntax.rst.inc |   4 +-
 docs/system/guest-loader.rst          |   2 +-
 docs/system/replay.rst                |   2 +-
 docs/system/vnc-security.rst          |   6 +-
 hw/arm/imx8mp-evk.c                   |   2 +
 hw/core/machine-qmp-cmds.c            |   1 -
 hw/intc/arm_gic.c                     |  12 +-
 hw/intc/arm_gicv3.c                   |   4 +-
 hw/intc/arm_gicv3_its.c               |   4 +-
 hw/intc/arm_gicv3_its_common.c        |   4 +-
 hw/intc/arm_gicv3_its_kvm.c           |   2 +-
 hw/intc/armv7m_nvic.c                 |   2 +-
 hw/scsi/lasi_ncr710.h                 |   1 -
 hw/scsi/ncr53c710.h                   |   1 -
 include/hw/core/loader.h              |   1 -
 include/hw/i386/tdvf.h                |   1 -
 include/hw/ppc/spapr_fadump.h         |   1 -
 include/hw/riscv/iommu.h              |   1 -
 include/system/accel-irq.h            |   1 -
 include/system/mshv.h                 |   1 -
 linux-user/alpha/target_proc.h        |   1 -
 qemu-options.hx                       |  51 +-
 qga/commands-windows-ssh.h            |   1 -
 qga/vss-win32/vss-debug.h             |   1 -
 scripts/clean-includes                | 103 ++--
 scripts/lib/kdoc/kdoc_files.py        |  11 +-
 scripts/lib/kdoc/kdoc_item.py         |   3 +-
 scripts/lib/kdoc/kdoc_output.py       |  93 +++-
 scripts/lib/kdoc/kdoc_parser.py       | 901 +++++++++++++++++-----------------
 scripts/lib/kdoc/kdoc_re.py           |  24 +-
 semihosting/arm-compat-semi-stub.c    |   1 -
 target/arm/cpu32-stubs.c              |   1 -
 target/i386/kvm/kvm.c                 |   1 -
 target/i386/kvm/vmsr_energy.h         |   2 -
 target/i386/mshv/mshv-cpu.c           |   1 -
 target/i386/mshv/x86.c                |   1 -
 target/loongarch/csr.c                |   1 -
 target/riscv/csr.c                    |   1 -
 tools/i386/qemu-vmsr-helper.c         |   1 -
 util/cpuinfo-aarch64.c                |   1 -
 57 files changed, 738 insertions(+), 635 deletions(-)

