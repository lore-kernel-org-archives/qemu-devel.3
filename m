Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C88EE3693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvE-0005h3-KK; Thu, 12 Feb 2026 09:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXul-0005Kn-Jn
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXu6-0005fK-Qo
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LKcK4OiOnyFjtkFnUQVwTEazTMvuvfBeQzpgEdtx3RQ=;
 b=E07rouhbQvv/jLWL7Mu6VZPlQHgUbxJT/3bJTxwFVN8m085jjCJQ5PDQ3PYzhMXCOB9sqC
 THhtoqZNilNAGq/jH7YORQH1xbOO8XVzipBsP1m+ltHsCiLecZ6ei6UMZlavfU7Wv5Jnss
 df3A3EdkvsbkWpokRrsnwW6uAXZ1hEM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Vb2Fx__pMPW-HWBUJ6NRIA-1; Thu, 12 Feb 2026 09:42:47 -0500
X-MC-Unique: Vb2Fx__pMPW-HWBUJ6NRIA-1
X-Mimecast-MFC-AGG-ID: Vb2Fx__pMPW-HWBUJ6NRIA_1770907367
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43771113b3bso2194565f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907366; x=1771512166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LKcK4OiOnyFjtkFnUQVwTEazTMvuvfBeQzpgEdtx3RQ=;
 b=sBxOw3ci1gOvC8cnFI2F08UhVnA6zgtuJw88NMM2gQVaeKx9vCFdN9U8N3e8a0ZFXB
 IDe3+7w5oeYoNDevOUWd3U+XN9659ttmEVjZY9anUCZAxYQvEwqZ7iA5i5YY6UTNkWwd
 C/uutpqgZoUFsw6+jFLkfUV2snDMFmfggMhzV1YYZycSdnCbd8HTCDmFXxr3JK4REZ+3
 ZMeKinVt6jvzTaVgj7NtILwu/apsGph9MX7skMo6BA9l3QFKt1gZ90gTjdQ1/0i5csCL
 Sc/cSu2C/FoDZpwKNPxn6pdkYsPt0+eGm/CknVq9rhJ+vYX/5lrCAtacOQK6fXDzJsw/
 aWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907366; x=1771512166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKcK4OiOnyFjtkFnUQVwTEazTMvuvfBeQzpgEdtx3RQ=;
 b=Fo3n26IZ+qlkNCkrVZJa5vjLVnwGFzvQz1jxYO0B3I8yty+o45RG7+QcIyOCTY+Cu2
 G8+Ef2NOMLq0kgH78RDSovTdkMD6qknWX+BSbxhHs05dumpUWXthsYlYP6/sozSoWvUw
 UIh1cj67WbKiBzI3NS5pyE7OyejjeHCbtcGdNWXyu4h3XVnon8Yqz5Fq7YJb/UFBPp+v
 SfIstG4xUUbgACZ5G6SWzjSkhCPWpPRbncDwQCHhLrWYL5geIFcxyEMjhmO1A84yX5Og
 g9xFYc+5qDRbST6CVj3oyp/ZETli1DCKv/yLRxlXEcmLDgkKshBaTYDXnqpoGvMCLYoC
 pNag==
X-Gm-Message-State: AOJu0YyIeDo4SkNpPShb9hdgp8z8TQXupw2lBfK3HWS39uNAXxAuCix5
 sE4zmg+oDOVtiA4TknZW7dtUoJjNJX35C0BRwSEqEELUQH5Bl14Zerj+6rSyeGm8CxuGpyRdall
 yRYy8NhTnKHTdVpD4VAth9wlgBnpAgch+3WPDaacaBBPV6MjLt3x4zxHjnTpy4yiSbVYEsCVGU5
 Cq363gJs5M2M3CnGmilc7rBHQi5WempZqapDoPq42f
X-Gm-Gg: AZuq6aJwG7ueyNYH66FSX8nRtJdGEEGU24s4Viiw66vA4UOhQYw14xNiC1USxzZsky9
 oQd8eM6DDEKuNxgmhKegCiTsDfWbELmd31WiEzosIqdDmnt54re4ewpC1GfcRVLYwO/qntj0ISx
 7PzU1s/af5Z4d7YsE2F61bFtRUVWZ3jG7+0YuKUZVjeMm0vO3oH3lfp6EiE0s53yuET/WC45FWz
 I1M6h2sfxSd0jpr7CQt1n/jKCPpoNWgdMqMhr1XcV8IbCDuBE7AyhSkBSoOXzCpcp+eFTb0ltDW
 oxMdFBKCF/CVyKhtPEq4dr3xbyFap2qV5KFL72EClvUmUwbnFI+9WUPIeLmGH8+bufnLjt6m8S8
 pHJM5Co5jR3DNpbArudHMYEN/szkTpgysDGoVX8uzDg5vFNqEy7tot03CnCXTVnD2q1o7QYCBWL
 lKClzUG9i9nIfGL8UowVjd+XlutB9M+45LNCO9aNDB5S3mVRu52uI=
X-Received: by 2002:a5d:5888:0:b0:435:a3b9:9b8 with SMTP id
 ffacd0b85a97d-4378f11ef6fmr4046523f8f.24.1770907365963; 
 Thu, 12 Feb 2026 06:42:45 -0800 (PST)
X-Received: by 2002:a5d:5888:0:b0:435:a3b9:9b8 with SMTP id
 ffacd0b85a97d-4378f11ef6fmr4046436f8f.24.1770907365143; 
 Thu, 12 Feb 2026 06:42:45 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e5c92fsm13283323f8f.38.2026.02.12.06.42.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] QOM, target/i386 patches for 2026-02-12
Date: Thu, 12 Feb 2026 15:42:02 +0100
Message-ID: <20260212144244.22579-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 28a29efe4342055b4631de96ba71fd577ae83e07:

  target/i386/mshv: remove unused optimization of gva=>gpa translation (2026-02-10 14:41:08 +0100)

----------------------------------------------------------------
* hw/i386: Remove deprecated PC 2.6 and 2.7 machines
* i386/cpu: Fix incorrect initializer in Diamond Rapids definition
* qom: Clean up property release
* target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
* target/i386/kvm: reset AMD and perfmon-v2 PMU registers during VM reset
* mshv: Cleanup
* target/i386: convert SEV-ES termination requests to guest panic events

----------------------------------------------------------------
Aidan Khoury (1):
      i386/cpu: Fix incorrect initializer in Diamond Rapids definition

Chandan Somani (1):
      qdev: Free property array on release

Dongli Zhang (5):
      target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
      target/i386/kvm: extract unrelated code out of kvm_x86_build_cpuid()
      target/i386/kvm: rename architectural PMU variables
      target/i386/kvm: reset AMD PMU registers during VM reset
      target/i386/kvm: support perfmon-v2 for reset

Igor Mammedov (1):
      tests/acpi: Allow DSDT table change for x86 machines

Magnus Kulke (2):
      accel/mshv: Remove remap overlapping mappings code
      target/i386/mshv: remove unused optimization of gva=>gpa translation

Marc-André Lureau (4):
      qdev: make release_string() idempotent
      qdev: make release_drive() idempotent
      qdev: make release_tpm() idempotent
      tests: add /qdev/free-properties test

Paolo Bonzini (1):
      target/i386: convert SEV-ES termination requests to guest panic events

Philippe Mathieu-Daudé (22):
      hw/i386/pc: Remove deprecated pc-q35-2.6 and pc-i440fx-2.6 machines
      hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug field
      hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with '_nodma' suffix
      hw/mips/loongson3_virt: Prefer using fw_cfg_init_mem_nodma()
      hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
      hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() -> fw_cfg_init_mem_dma()
      hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
      hw/i386/pc: Remove multiboot.bin
      hw/i386: Assume fw_cfg DMA is always enabled
      hw/i386: Remove linuxboot.bin
      hw/i386/pc: Remove pc_compat_2_6[] array
      hw/intc/apic: Remove APICCommonState::legacy_instance_id field
      hw/core/machine: Remove hw_compat_2_6[] array
      hw/virtio/virtio-mmio: Remove VirtIOMMIOProxy::format_transport_address field
      hw/i386/pc: Remove deprecated pc-q35-2.7 and pc-i440fx-2.7 machines
      hw/i386/pc: Remove pc_compat_2_7[] array
      target/i386/cpu: Remove CPUX86State::full_cpuid_auto_level field
      hw/audio/pcspk: Remove PCSpkState::migrate field
      hw/core/machine: Remove hw_compat_2_7[] array
      hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
      hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features field
      hw/char/virtio-serial: Do not expose the 'emergency-write' property

Zhao Liu (4):
      pc: Start with modern CPU hotplug interface by default
      acpi: Remove legacy cpu hotplug utilities
      docs/specs/acpi_cpu_hotplug: Remove legacy cpu hotplug descriptions
      tests/acpi: Update DSDT tables for pc & q35 machines

 docs/specs/acpi_cpu_hotplug.rst                   |  28 +-
 qapi/run-state.json                               |  23 +-
 include/hw/acpi/cpu.h                             |   1 -
 include/hw/acpi/ich9.h                            |   4 +-
 include/hw/acpi/piix4.h                           |   4 +-
 include/hw/core/boards.h                          |   6 -
 include/hw/i386/apic_internal.h                   |   1 -
 include/hw/i386/intel_iommu.h                     |   1 -
 include/hw/i386/pc.h                              |   9 -
 include/hw/i386/x86.h                             |   2 -
 include/hw/nvram/fw_cfg.h                         |   9 +-
 include/hw/virtio/virtio-mmio.h                   |   1 -
 include/hw/virtio/virtio-pci.h                    |   1 -
 include/hw/virtio/virtio-serial.h                 |   2 -
 include/system/mshv_int.h                         |  22 +-
 pc-bios/optionrom/optionrom.h                     |   4 -
 target/i386/cpu.h                                 |  19 +-
 accel/kvm/kvm-all.c                               |   1 +
 accel/mshv/mem.c                                  | 406 ++--------------------
 accel/mshv/mshv-all.c                             |   2 -
 backends/tpm/tpm_util.c                           |   1 +
 block/accounting.c                                |   1 -
 hw/acpi/acpi-cpu-hotplug-stub.c                   |  19 +-
 hw/acpi/cpu.c                                     |  10 -
 hw/acpi/cpu_hotplug.c                             | 348 -------------------
 hw/acpi/generic_event_device.c                    |   1 +
 hw/acpi/ich9.c                                    |  61 +---
 hw/acpi/piix4.c                                   |  61 +---
 hw/arm/virt.c                                     |   2 +-
 hw/audio/pcspk.c                                  |  10 -
 hw/char/virtio-serial-bus.c                       |   9 +-
 hw/core/machine.c                                 |  17 -
 hw/core/qdev-properties-system.c                  |   1 +
 hw/core/qdev-properties.c                         |  24 +-
 hw/hppa/machine.c                                 |   2 +-
 hw/i386/acpi-build.c                              |   7 +-
 hw/i386/fw_cfg.c                                  |  16 +-
 hw/i386/intel_iommu.c                             |   5 +-
 hw/i386/microvm.c                                 |   3 -
 hw/i386/multiboot.c                               |   7 +-
 hw/i386/pc.c                                      |  25 +-
 hw/i386/pc_piix.c                                 |  23 --
 hw/i386/pc_q35.c                                  |  24 --
 hw/i386/x86-common.c                              |   8 +-
 hw/i386/x86.c                                     |   2 -
 hw/input/stellaris_gamepad.c                      |   8 -
 hw/intc/apic_common.c                             |   5 -
 hw/intc/arm_gicv3_common.c                        |   8 -
 hw/intc/rx_icu.c                                  |   8 -
 hw/loongarch/fw_cfg.c                             |   4 +-
 hw/loongarch/virt-acpi-build.c                    |   1 -
 hw/mips/loongson3_virt.c                          |   2 +-
 hw/misc/arm_sysctl.c                              |   2 -
 hw/misc/mps2-scc.c                                |   8 -
 hw/net/rocker/rocker.c                            |   1 -
 hw/nvram/fw_cfg.c                                 |  22 +-
 hw/nvram/xlnx-efuse.c                             |   8 -
 hw/nvram/xlnx-versal-efuse-ctrl.c                 |   8 -
 hw/riscv/virt.c                                   |   4 +-
 hw/virtio/virtio-iommu-pci.c                      |   8 -
 hw/virtio/virtio-mmio.c                           |  15 -
 hw/virtio/virtio-pci.c                            |   5 +-
 system/runstate.c                                 |   4 +
 target/i386/cpu-system.c                          |  22 ++
 target/i386/cpu.c                                 | 119 ++++---
 target/i386/kvm/kvm.c                             | 314 ++++++++++++++---
 target/i386/mshv/mshv-cpu.c                       |  63 +---
 tests/qtest/test-x86-cpuid-compat.c               |  11 -
 tests/unit/test-qdev.c                            |  96 +++++
 accel/mshv/trace-events                           |   5 -
 hw/acpi/meson.build                               |   2 +-
 pc-bios/meson.build                               |   2 -
 pc-bios/multiboot.bin                             | Bin 1024 -> 0 bytes
 pc-bios/optionrom/Makefile                        |   2 +-
 pc-bios/optionrom/linuxboot.S                     | 195 -----------
 pc-bios/optionrom/multiboot.S                     | 232 -------------
 pc-bios/optionrom/multiboot_dma.S                 | 234 ++++++++++++-
 roms/seabios-hppa                                 |   2 +-
 tests/data/acpi/x86/pc/DSDT                       | Bin 8611 -> 8598 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst              | Bin 8522 -> 8509 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat              | Bin 9936 -> 9923 bytes
 tests/data/acpi/x86/pc/DSDT.bridge                | Bin 15482 -> 15469 bytes
 tests/data/acpi/x86/pc/DSDT.cphp                  | Bin 9075 -> 9062 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm               | Bin 10265 -> 10252 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge              | Bin 8562 -> 8549 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot              | Bin 5100 -> 5087 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs               | Bin 8683 -> 8670 bytes
 tests/data/acpi/x86/pc/DSDT.memhp                 | Bin 9970 -> 9957 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet                | Bin 8469 -> 8456 bytes
 tests/data/acpi/x86/pc/DSDT.numamem               | Bin 8617 -> 8604 bytes
 tests/data/acpi/x86/pc/DSDT.roothp                | Bin 12404 -> 12391 bytes
 tests/data/acpi/x86/q35/DSDT                      | Bin 8440 -> 8427 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst             | Bin 8457 -> 8444 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat             | Bin 9765 -> 9752 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x   | Bin 12650 -> 12637 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator | Bin 8719 -> 8706 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc             | Bin 8486 -> 8473 bytes
 tests/data/acpi/x86/q35/DSDT.bridge               | Bin 12053 -> 12040 bytes
 tests/data/acpi/x86/q35/DSDT.core-count           | Bin 12998 -> 12985 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2          | Bin 33855 -> 33842 bytes
 tests/data/acpi/x86/q35/DSDT.cphp                 | Bin 8904 -> 8891 bytes
 tests/data/acpi/x86/q35/DSDT.cxl                  | Bin 13231 -> 13218 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm              | Bin 10094 -> 10081 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt               | Bin 8515 -> 8502 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus            | Bin 8528 -> 8515 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs                 | Bin 8457 -> 8444 bytes
 tests/data/acpi/x86/q35/DSDT.memhp                | Bin 9799 -> 9786 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64               | Bin 9570 -> 9557 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge         | Bin 13293 -> 13280 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp             | Bin 8302 -> 8289 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet               | Bin 8298 -> 8285 bytes
 tests/data/acpi/x86/q35/DSDT.numamem              | Bin 8446 -> 8433 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa          | Bin 8541 -> 8528 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count         | Bin 12998 -> 12985 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2        | Bin 33855 -> 33842 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12            | Bin 9046 -> 9033 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2             | Bin 9072 -> 9059 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count          | Bin 18674 -> 18661 bytes
 tests/data/acpi/x86/q35/DSDT.viot                 | Bin 14697 -> 14684 bytes
 tests/data/acpi/x86/q35/DSDT.xapic                | Bin 35803 -> 35790 bytes
 tests/unit/meson.build                            |   1 +
 121 files changed, 852 insertions(+), 1802 deletions(-)
 delete mode 100644 hw/acpi/cpu_hotplug.c
 create mode 100644 tests/unit/test-qdev.c
 delete mode 100644 pc-bios/multiboot.bin
 delete mode 100644 pc-bios/optionrom/linuxboot.S
 delete mode 100644 pc-bios/optionrom/multiboot.S
-- 
2.52.0


