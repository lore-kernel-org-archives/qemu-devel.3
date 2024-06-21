Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED03C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 11:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcvR-00041V-AA; Fri, 21 Jun 2024 07:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcvK-00040t-7A
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 07:59:22 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcvF-000331-Fx
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 07:59:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so14407505ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718971155; x=1719575955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N8SW3M+Jw2WPyFDDnpJOKhkS8a0TIqDczKk8oeBdly0=;
 b=lXPpEUjK2p8iCh59jvpufPqxhm5Oe3U0vrG8FYArGD22pTVKyf7N9gOFa1EqSs6BcF
 u/evNPajHiH8uhpdkr0s5kgaGO2kx4KlNRgT/u7lDeDqOJipsWCWgeSkkIu3yMtNTy5Z
 CJmxO5QgssMue/IUKOtAtetPQK9C+ZGb4KTNuiVAobI2SytQkDwlFRbqIXyZ0TAF5zyA
 4HGGhaF4LXdI5WlJHqT5Ww2vCHhDBPky26jH/5efj2mkQ9+EyjKL6O48AtJE6NibKmLs
 U4kWJqlsvvdWZu37fvMzpODM79YefIZ1+DABDMvMCiuC6h7v63z92MPLL/AWbuUpR7Ht
 d+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718971155; x=1719575955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N8SW3M+Jw2WPyFDDnpJOKhkS8a0TIqDczKk8oeBdly0=;
 b=pydQrI67ncE+BxBmN7NYRWnNrHE/YTTTiPBb9zzax2MX09Cd1/llK6K04wvNkYGg9k
 VbN5NBfqBPaUr34lqJO6GnMf5qgQ0ru7XHTLFj5IbH3Zt8L2qAFQpZOkitOs3E7IHL1j
 0qivmIwvIgsOkAxkWi7NeQ73AZrleMv7woW/ainIYhu6MhtSwXo2+2XRgdjBW8BFYtSd
 HUSvfFsHqDnVk52Gqm2bM8k0pwuu8+zKpO3oGIMv9wP4SRdkNzhbMbB4ILfkGRAIDcrU
 GT2araPoIQH967QxgRzM1qJyddEUd8PpABs/MjkAAA+NcHQGmGNpfOSXuN/fCHAdq86C
 shiQ==
X-Gm-Message-State: AOJu0Yx5uw+/E/Pwg7KqWMG59zkt+o+vEPxCZ2LqQyhbNg8TCEwaNCF8
 8i7hDyiW9vV0Rl0GZYAnmY2Zn/cDOmQiz6Zhc9H7D7yavdW5xusJmhrg0RJHwARwWOBxrfxe3I0
 G
X-Google-Smtp-Source: AGHT+IHqR78vaUPf6QAXQCrEfJP0tkk2yCvQoiCUmXOokW2z0YDmsokggwAHHFI9Jn5BnRwDbjCrrQ==
X-Received: by 2002:a17:902:e54c:b0:1f6:93a0:9a45 with SMTP id
 d9443c01a7336-1f9aa3ebf85mr102099045ad.36.1718971154864; 
 Fri, 21 Jun 2024 04:59:14 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbb606dsm12422995ad.270.2024.06.21.04.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 04:59:14 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 00/15] Add support for RISC-V ACPI tests
Date: Fri, 21 Jun 2024 17:28:51 +0530
Message-Id: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently, bios-table-test doesn't support RISC-V. This series enables
the framework changes required and basic testing. Things like NUMA
related test cases will be added later.

This needs refactoring/renaming of ARM64 and x86 bios table tests.
Importantly, the test cases now look for the expected AML files under
tests/data/acpi/${arch}/${machine} path instead of directly under
tests/data/acpi/${machine}. To keep test cases not to fail because of
this movement, they are updated to look for both paths first.

As part of this effort, it is found that uefi-test-tools is currently
broken to build. So, updated its Makefile as well to use python based
edk2 build script.

The changes are also available at branch
https://gitlab.com/vlsunil/qemu/-/tree/riscv_bios_table_test_v3

Changes since v2:
	1) Used ${arch}/${machine} path instead of {machine}/${arch} as
	   per the feedback.
	2) Updated x86 AML files and test cases as well to use new path.
	3) Used data->cd for RISC-V test which internally uses -cdrom
	   option. This needs a fix in RISC-V virt machine [1]. So,
	   the patch [1] is a dependency for this series.
	3) Updated tags.

Changes since v1:
	1) Addressed feedback from Gerd and Alistair
	2) Rebased and added tags received

[1]: https://mail.gnu.org/archive/html/qemu-devel/2024-06/msg03683.html

Sunil V L (15):
  uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
  uefi-test-tools: Add support for python based build script
  tests/data/uefi-boot-images: Add RISC-V ISO image
  qtest: bios-tables-test: Rename aarch64 tests with aarch64 in them
  tests/qtest/bios-tables-test.c: Add support for arch in path
  tests/qtest/bios-tables-test.c: Set "arch" for aarch64 tests
  tests/qtest/bios-tables-test.c: Set "arch" for x86 tests
  tests/data/acpi: Move x86 ACPI tables under x86/${machine} path
  tests/data/acpi/virt: Move ARM64 ACPI tables under aarch64/${machine}
    path
  meson.build: Add RISC-V to the edk2-target list
  pc-bios/meson.build: Add support for RISC-V in unpack_edk2_blobs
  tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
  tests/qtest/bios-tables-test: Add empty ACPI data files for RISC-V
  tests/qtest/bios-tables-test.c: Enable basic testing for RISC-V
  tests/qtest/bios-tables-test: Add expected ACPI data files for RISC-V

 meson.build                                   |   2 +-
 pc-bios/meson.build                           |   2 +
 tests/data/acpi/{ => aarch64}/virt/APIC       | Bin
 .../acpi/{ => aarch64}/virt/APIC.acpihmatvirt | Bin
 .../acpi/{ => aarch64}/virt/APIC.topology     | Bin
 tests/data/acpi/{ => aarch64}/virt/DBG2       | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT       | Bin
 .../acpi/{ => aarch64}/virt/DSDT.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.memhp | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.pxb   | Bin
 .../acpi/{ => aarch64}/virt/DSDT.topology     | Bin
 tests/data/acpi/{ => aarch64}/virt/FACP       | Bin
 tests/data/acpi/{ => aarch64}/virt/GTDT       | Bin
 .../acpi/{ => aarch64}/virt/HMAT.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/IORT       | Bin
 tests/data/acpi/{ => aarch64}/virt/MCFG       | Bin
 tests/data/acpi/{ => aarch64}/virt/NFIT.memhp | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT       | Bin
 .../acpi/{ => aarch64}/virt/PPTT.acpihmatvirt | Bin
 .../acpi/{ => aarch64}/virt/PPTT.topology     | Bin
 .../data/acpi/{pc => aarch64/virt}/SLIT.memhp | Bin
 tests/data/acpi/{ => aarch64}/virt/SPCR       | Bin
 .../acpi/{ => aarch64}/virt/SRAT.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.memhp | Bin
 .../data/acpi/{ => aarch64}/virt/SRAT.numamem | Bin
 tests/data/acpi/{ => aarch64}/virt/SSDT.memhp | Bin
 tests/data/acpi/{ => aarch64}/virt/VIOT       | Bin
 tests/data/acpi/rebuild-expected-aml.sh       |   5 +-
 tests/data/acpi/riscv64/virt/APIC             | Bin 0 -> 116 bytes
 .../{microvm/DSDT.pcie => riscv64/virt/DSDT}  | Bin 3023 -> 3518 bytes
 tests/data/acpi/riscv64/virt/FACP             | Bin 0 -> 276 bytes
 tests/data/acpi/riscv64/virt/MCFG             | Bin 0 -> 60 bytes
 tests/data/acpi/riscv64/virt/RHCT             | Bin 0 -> 314 bytes
 tests/data/acpi/riscv64/virt/SPCR             | Bin 0 -> 80 bytes
 tests/data/acpi/{ => x86}/microvm/APIC        | Bin
 .../data/acpi/{ => x86}/microvm/APIC.ioapic2  | Bin
 tests/data/acpi/{ => x86}/microvm/APIC.pcie   | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT        | Bin
 .../data/acpi/{ => x86}/microvm/DSDT.ioapic2  | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.pcie   | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.rtc    | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.usb    | Bin
 tests/data/acpi/{ => x86}/microvm/ERST.pcie   | Bin
 tests/data/acpi/{ => x86}/microvm/FACP        | Bin
 tests/data/acpi/{ => x86}/pc/APIC             | Bin
 tests/data/acpi/{ => x86}/pc/APIC.acpihmat    | Bin
 tests/data/acpi/{ => x86}/pc/APIC.cphp        | Bin
 tests/data/acpi/{ => x86}/pc/APIC.dimmpxm     | Bin
 tests/data/acpi/{ => x86}/pc/DSDT             | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpierst    | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpihmat    | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.bridge      | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.cphp        | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm     | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbridge    | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot    | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs     | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.memhp       | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.nohpet      | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.numamem     | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.roothp      | Bin
 tests/data/acpi/{ => x86}/pc/ERST.acpierst    | Bin
 tests/data/acpi/{ => x86}/pc/FACP             | Bin
 tests/data/acpi/{ => x86}/pc/FACP.nosmm       | Bin
 tests/data/acpi/{ => x86}/pc/FACS             | Bin
 tests/data/acpi/{ => x86}/pc/HMAT.acpihmat    | Bin
 tests/data/acpi/{ => x86}/pc/HPET             | Bin
 tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm     | Bin
 tests/data/acpi/{ => x86}/pc/SLIT.cphp        | Bin
 tests/data/acpi/{q35 => x86/pc}/SLIT.memhp    | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.acpihmat    | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.cphp        | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm     | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.memhp       | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.numamem     | Bin
 tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm     | Bin
 tests/data/acpi/{ => x86}/pc/WAET             | Bin
 tests/data/acpi/{ => x86}/q35/APIC            | Bin
 tests/data/acpi/{ => x86}/q35/APIC.acpihmat   | Bin
 .../{ => x86}/q35/APIC.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/APIC.core-count | Bin
 .../data/acpi/{ => x86}/q35/APIC.core-count2  | Bin
 tests/data/acpi/{ => x86}/q35/APIC.cphp       | Bin
 tests/data/acpi/{ => x86}/q35/APIC.dimmpxm    | Bin
 .../data/acpi/{ => x86}/q35/APIC.thread-count | Bin
 .../acpi/{ => x86}/q35/APIC.thread-count2     | Bin
 .../data/acpi/{ => x86}/q35/APIC.type4-count  | Bin
 tests/data/acpi/{ => x86}/q35/APIC.xapic      | Bin
 tests/data/acpi/{ => x86}/q35/CEDT.cxl        | Bin
 tests/data/acpi/{ => x86}/q35/DMAR.dmar       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT            | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpierst   | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpihmat   | Bin
 .../{ => x86}/q35/DSDT.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.applesmc   | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.bridge     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.core-count | Bin
 .../data/acpi/{ => x86}/q35/DSDT.core-count2  | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cphp       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cxl        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm    | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmibt     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus  | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ivrs       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.memhp      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.mmio64     | Bin
 .../data/acpi/{ => x86}/q35/DSDT.multi-bridge | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.noacpihp   | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.nohpet     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.numamem    | Bin
 .../data/acpi/{ => x86}/q35/DSDT.pvpanic-isa  | Bin
 .../data/acpi/{ => x86}/q35/DSDT.thread-count | Bin
 .../acpi/{ => x86}/q35/DSDT.thread-count2     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12  | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2   | Bin
 .../data/acpi/{ => x86}/q35/DSDT.type4-count  | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.viot       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.xapic      | Bin
 tests/data/acpi/{ => x86}/q35/ERST.acpierst   | Bin
 tests/data/acpi/{ => x86}/q35/FACP            | Bin
 tests/data/acpi/{ => x86}/q35/FACP.core-count | Bin
 .../data/acpi/{ => x86}/q35/FACP.core-count2  | Bin
 tests/data/acpi/{ => x86}/q35/FACP.nosmm      | Bin
 tests/data/acpi/{ => x86}/q35/FACP.slic       | Bin
 .../data/acpi/{ => x86}/q35/FACP.thread-count | Bin
 .../acpi/{ => x86}/q35/FACP.thread-count2     | Bin
 .../data/acpi/{ => x86}/q35/FACP.type4-count  | Bin
 tests/data/acpi/{ => x86}/q35/FACP.xapic      | Bin
 tests/data/acpi/{ => x86}/q35/FACS            | Bin
 tests/data/acpi/{ => x86}/q35/HMAT.acpihmat   | Bin
 .../{ => x86}/q35/HMAT.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/HPET            | Bin
 tests/data/acpi/{ => x86}/q35/IVRS.ivrs       | Bin
 tests/data/acpi/{ => x86}/q35/MCFG            | Bin
 tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm    | Bin
 tests/data/acpi/{ => x86}/q35/SLIC.slic       | Bin
 tests/data/acpi/{ => x86}/q35/SLIT.cphp       | Bin
 tests/data/acpi/{virt => x86/q35}/SLIT.memhp  | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.acpihmat   | Bin
 .../{ => x86}/q35/SRAT.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.cphp       | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm    | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.memhp      | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.mmio64     | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.numamem    | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.xapic      | Bin
 tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm    | Bin
 tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12  | Bin
 tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2   | Bin
 tests/data/acpi/{ => x86}/q35/VIOT.viot       | Bin
 tests/data/acpi/{ => x86}/q35/WAET            | Bin
 .../bios-tables-test.riscv64.iso.qcow2        | Bin 0 -> 16896 bytes
 tests/qtest/bios-tables-test.c                | 169 ++++++++++++++----
 tests/qtest/meson.build                       |   3 +
 tests/uefi-test-tools/Makefile                |  19 +-
 .../UefiTestToolsPkg/UefiTestToolsPkg.dsc     |   6 +-
 tests/uefi-test-tools/uefi-test-build.config  |  52 ++++++
 157 files changed, 210 insertions(+), 48 deletions(-)
 rename tests/data/acpi/{ => aarch64}/virt/APIC (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DBG2 (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.pxb (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/FACP (100%)
 rename tests/data/acpi/{ => aarch64}/virt/GTDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/IORT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/MCFG (100%)
 rename tests/data/acpi/{ => aarch64}/virt/NFIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.topology (100%)
 rename tests/data/acpi/{pc => aarch64/virt}/SLIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SPCR (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.numamem (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/VIOT (100%)
 create mode 100644 tests/data/acpi/riscv64/virt/APIC
 copy tests/data/acpi/{microvm/DSDT.pcie => riscv64/virt/DSDT} (62%)
 create mode 100644 tests/data/acpi/riscv64/virt/FACP
 create mode 100644 tests/data/acpi/riscv64/virt/MCFG
 create mode 100644 tests/data/acpi/riscv64/virt/RHCT
 create mode 100644 tests/data/acpi/riscv64/virt/SPCR
 rename tests/data/acpi/{ => x86}/microvm/APIC (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.rtc (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.usb (100%)
 rename tests/data/acpi/{ => x86}/microvm/ERST.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.roothp (100%)
 rename tests/data/acpi/{ => x86}/pc/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/pc/FACS (100%)
 rename tests/data/acpi/{ => x86}/pc/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/HPET (100%)
 rename tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SLIT.cphp (100%)
 rename tests/data/acpi/{q35 => x86/pc}/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/WAET (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/CEDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DMAR.dmar (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.applesmc (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmibt (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.multi-bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.noacpihp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.pvpanic-isa (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACS (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/HPET (100%)
 rename tests/data/acpi/{ => x86}/q35/IVRS.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/MCFG (100%)
 rename tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIC.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIT.cphp (100%)
 rename tests/data/acpi/{virt => x86/q35}/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/VIOT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/WAET (100%)
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2
 create mode 100644 tests/uefi-test-tools/uefi-test-build.config

-- 
2.40.1


