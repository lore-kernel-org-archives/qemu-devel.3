Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B24C54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2H2-00007k-Lx; Sat, 09 Mar 2024 14:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2H1-00006e-7N
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:23 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Gv-0002Qd-Tj
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:22 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5135e8262e4so3683878e87.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012135; x=1710616935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TyH7jXIm2EqzqL2/UeLpy4EgCXXmlEI1Bk9xOVfXLC0=;
 b=RZTFFzH+zIC+dCeMHyNrPy1MhPGnLnZdmiyVntIsPa90prDECH0IrPNrQv3hoHx9y2
 YFC9KBehtUwZ+xyX7LLIVSuw4aqttuNM5NrKhlFHgmZrWeD6EAi7HLx1eUI9QcxS4fml
 x5sFf6fiK8xToq/9FoXMhmn4GVfsrOR3bA+eN9HIv4XnPGpSeX/SwptrmMo+epddNJD2
 5PzS5zuWOK5LdbP8G7LZfoYa5RDU/f4r35TtIzYTjBBvyAZZ7yprY+/BLjEd3rgWQSVk
 LwC+i4CN9+LEjad++FS5ONs8cJ9QUiVsX4feBFuUfX9lNyYa24k8NkaeJZl4bFcGP7XF
 GUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012135; x=1710616935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TyH7jXIm2EqzqL2/UeLpy4EgCXXmlEI1Bk9xOVfXLC0=;
 b=kUlT/DimC0jtLULVKdXCp3/JNR2FgNlK+iJ+KLi7bdJWzqn/DYqZ3jh7bqJJFrzoJ9
 phLpyMg0yZsOFQg2zEq5rJ3e+90T6tAyYmdPPn3KjZAZDSkgts588rb+hJ5BzCiMmS/h
 6yHe/EKSaDohFvkw08vrE/AmWTTXrADhGazBxwreDluQOWO31id63o5dI7Sz4Lg3PT9G
 4BMFYxm4swBZIcCF3ov8iQ2Gn39VtRopa6xlQUmOKMaIc+b4K/f0RcqNi4S7Bn1kxunD
 WMAnmiNmsxUHhWjU62+xE7opWqWSgHZ0s/Lphv28AtYYxk/tEYlSjWXPZepxv2V37l0W
 3Jjg==
X-Gm-Message-State: AOJu0YxK8+ekYiH/8OpfQP+5Z5XaEj0IpnvHVTxynKUt7bmpWJDzNNFu
 n6Aue+FCaySOyWrN58dBotI37zqcm5X40HxHjuUPDiZqbBUWjDt/xffGLmlLjWW6xlnrpNh+vd/
 T
X-Google-Smtp-Source: AGHT+IGxv2fXSbURwyyXxSpsuByUzVW7NXdk6gzjWxuLRrvjUYJ2JQrVZH9zUsJNe4J+WeP2rwQuLQ==
X-Received: by 2002:ac2:5450:0:b0:512:9857:34f3 with SMTP id
 d16-20020ac25450000000b00512985734f3mr1456036lfn.39.1710012135562; 
 Sat, 09 Mar 2024 11:22:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 uz26-20020a170907119a00b00a45c9945251sm1166699ejb.192.2024.03.09.11.22.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:22:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/43] Misc HW patches for 2024-03-09
Date: Sat,  9 Mar 2024 20:21:27 +0100
Message-ID: <20240309192213.23420-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 84644ac1b0f80d41b8a2f66547b83b2ad4a98576:

  Merge tag 'darwin-20240305' of https://github.com/philmd/qemu into staging (2024-03-08 18:19:25 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240309

for you to fetch changes up to d3c79c397484ad117063702e6246e39f22f020f6:

  hw/m68k/mcf5208: add support for reset (2024-03-09 19:17:01 +0100)

----------------------------------------------------------------
Misc HW patch queue

- hmp: Shorter 'info qtree' output (Zoltan)
- qdev: Add a granule_mode property (Eric)
- Some ERRP_GUARD() fixes (Zhao)
- Doc & style fixes in docs/interop/firmware.json (Thomas)
- hw/xen: Housekeeping (Phil)
- hw/ppc/mac99: Change timebase frequency 25 -> 100 MHz (Mark)
- hw/intc/apic: Memory leak fix (Paolo)
- hw/intc/grlib_irqmp: Ensure ncpus value is in range (Clément)
- hw/m68k/mcf5208: Add support for reset (Angelo)
- hw/i386/pc: Housekeeping (Phil)
- hw/core/smp: Remove/deprecate parameter=0,1 adapting test-smp-parse (Zhao)

----------------------------------------------------------------

Angelo Dureghello (1):
  hw/m68k/mcf5208: add support for reset

BALATON Zoltan (1):
  hmp: Add option to info qtree to omit details

Clément Chigot (1):
  hw/intc/grlib_irqmp: abort realize when ncpus value is out of range

Eric Auger (1):
  qdev: Add a granule_mode property

Mark Cave-Ayland (1):
  mac_newworld: change timebase frequency from 100MHz to 25MHz for mac99
    machine

Paolo Bonzini (1):
  hw/intc/apic: fix memory leak

Philippe Mathieu-Daudé (18):
  hw/i386: Rename kvmvapic.c -> vapic.c
  sysemu/xen: Forbid using Xen headers in user emulation
  sysemu/xen-mapcache: Check Xen availability with
    CONFIG_XEN_IS_POSSIBLE
  system/physmem: Do not include 'hw/xen/xen.h' but 'sysemu/xen.h'
  hw/pci/msi: Restrict xen_is_pirq_msi() call to Xen
  hw/xen: Remove unnecessary xen_hvm_inject_msi() stub
  hw/xen: Rename 'ram_memory' global variable as 'xen_memory'
  hw/xen: Use target-agnostic qemu_target_page_bits()
  hw/xen/xen_pt: Add missing license
  hw/xen: Extract 'xen_igd.h' from 'xen_pt.h'
  hw/i386/xen: Compile 'xen-hvm.c' with Xen CPPFLAGS
  hw/xen/hvm: Inline TARGET_PAGE_ALIGN() macro
  hw/xen/hvm: Propagate page_mask to a pair of functions
  hw/xen/hvm: Get target page size at runtime
  hw/i386/pc: Remove pc_compat_1_4..1.7[] left over declarations
  hw/i386/pc: Use generated NotifyVmexitOption_str()
  hw/i386/pc: Remove 'host_type' argument from pc_init1()
  hw/i386/pc: Have pc_init_isa() pass a NULL pci_type argument

Thomas Weißschuh (2):
  docs/interop/firmware.json: Align examples
  docs/interop/firmware.json: Fix doc for FirmwareFlashMode

Zhao Liu (17):
  hw/char/xen_console: Fix missing ERRP_GUARD() for error_prepend()
  hw/net/xen_nic: Fix missing ERRP_GUARD() for error_prepend()
  hw/remote/remote-obj: hw/misc/ivshmem: Fix missing ERRP_GUARD() for
    error_prepend()
  target/i386/sev: Fix missing ERRP_GUARD() for error_prepend()
  hw/core/machine-smp: Remove deprecated "parameter=0" SMP
    configurations
  hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
    configurations
  hw/core/machine-smp: Calculate total CPUs once in
    machine_parse_smp_config()
  tests/unit/test-smp-parse: Drop the unsupported "dies=1" case
  tests/unit/test-smp-parse: Use CPU number macros in invalid topology
    case
  tests/unit/test-smp-parse: Bump max_cpus to 4096
  tests/unit/test-smp-parse: Make test cases aware of the book/drawer
  tests/unit/test-smp-parse: Test "books" parameter in -smp
  tests/unit/test-smp-parse: Test "drawers" parameter in -smp
  tests/unit/test-smp-parse: Test "drawers" and "books" combination case
  tests/unit/test-smp-parse: Test the full 7-levels topology hierarchy
  tests/unit/test-smp-parse: Test smp_props.has_clusters
  tests/unit/test-smp-parse: Test "parameter=0" SMP configurations

 docs/about/deprecated.rst           |  30 +-
 docs/about/removed-features.rst     |  15 +
 docs/interop/firmware.json          | 376 ++++++++---------
 qapi/virtio.json                    |  18 +
 hw/xen/xen_pt.h                     |  24 +-
 include/hw/i386/pc.h                |  12 -
 include/hw/qdev-properties-system.h |   3 +
 include/hw/xen/xen-hvm-common.h     |   2 +-
 include/hw/xen/xen_igd.h            |  33 ++
 include/sysemu/xen-mapcache.h       |   3 +-
 include/sysemu/xen.h                |   8 +-
 accel/xen/xen-all.c                 |   1 +
 hw/arm/xen_arm.c                    |   6 +-
 hw/char/xen_console.c               |   1 +
 hw/core/machine-smp.c               |  78 ++--
 hw/core/qdev-properties-system.c    |  14 +
 hw/i386/pc_piix.c                   |  19 +-
 hw/i386/{kvmvapic.c => vapic.c}     |   5 +-
 hw/i386/xen/xen-hvm.c               |  82 ++--
 hw/intc/apic.c                      |   6 +-
 hw/intc/grlib_irqmp.c               |   1 +
 hw/m68k/mcf5208.c                   |  44 +-
 hw/net/xen_nic.c                    |   1 +
 hw/pci/msi.c                        |   3 +-
 hw/ppc/mac_newworld.c               |   2 +-
 hw/remote/remote-obj.c              |   1 +
 hw/xen/xen-hvm-common.c             |  12 +-
 hw/xen/xen_pt.c                     |   3 +-
 hw/xen/xen_pt_config_init.c         |   3 +-
 hw/xen/xen_pt_graphics.c            |   3 +-
 hw/xen/xen_pt_stub.c                |   2 +-
 stubs/xen-hw-stub.c                 |   4 -
 system/physmem.c                    |   2 +-
 system/qdev-monitor.c               |  27 +-
 target/i386/sev.c                   |   1 +
 tests/unit/test-smp-parse.c         | 612 ++++++++++++++++++++++++++--
 hmp-commands-info.hx                |   6 +-
 hw/i386/meson.build                 |   2 +-
 hw/i386/xen/meson.build             |   4 +-
 39 files changed, 1095 insertions(+), 374 deletions(-)
 create mode 100644 include/hw/xen/xen_igd.h
 rename hw/i386/{kvmvapic.c => vapic.c} (99%)

-- 
2.41.0


