Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C2AC04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjFG-0001a8-Tm; Tue, 16 Apr 2024 09:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjF9-0001Ua-Uq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjF4-0001Oy-Cw
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41884f8f35bso8282765e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275576; x=1713880376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xtI/ti/zyiWRBP+sRIXWMJFQHPHz8noWNvHuXyxaDzE=;
 b=TyeakZ7neKXiDVU4YkgDN4Ms4EtNO3fsByZ3DiuYtBPlodfJyhycV/GYHIIaqeKsG4
 VdoC8O8hogyFU5RZI8+2LihzvbG1o6CXkbvspeOZ7IaRhiHCM3eM/mqEWhDhyMrJqwzV
 ypApfm+HZKC35TnLuj+c121RezOvDe2AGgJonCgkxnEviyzieBGa2co0PZ6FsSighe55
 WWV9oijv9PhiZpqrj7en2fcIjq+GY/4VYr322+6l5h0JltNbvKjXOJ3fSGuPpuDfnlSU
 5gMKdZYy2xVU89BNDta2UBvsZBV8lxYMe4tZLBOiNl/Wo4/YIQQhR/39zLp3KjS88E0/
 95lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275576; x=1713880376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xtI/ti/zyiWRBP+sRIXWMJFQHPHz8noWNvHuXyxaDzE=;
 b=cFI5RTn0dd00fLMY7E8JcsI8L+rqZy6tmixGgkOuf/2dXJu/IwtDYoU57lC4+3ktDx
 u2A6w8mY6J6BelNDFio994kUB5TPNXyxKmz9QuOvbOdWZV1VkEzk0MefjmsrApkf9ZEG
 iXQLiXp32WSaPbF4NMkF+iuSxYW7gGeTKBd5xB06m7anG/99ah50Aal3loKR78WtcrNZ
 4sOlFqvrIFFhue2wjI+BTG/EvJhPQ4VqpiePwyGqwuUNf0ujz6Q+ErBqpH3llxWe2CQd
 Ao8PqmasZlXUsQKUTh1RFWvmHzNCk7nOjNM8QfoPF8V7GOrgzMIM8YwG3bpqzvCi5pLU
 o54Q==
X-Gm-Message-State: AOJu0YzQVy/lVBLywkjdBLhG8Qv1HVbeFZAy5IqLT6blfZBmhCNhkWL9
 g93xtkSoLY3Rfve6OOz/LTKLbLqRFXfJcC8j1GhbFZMJf7mryykJXTzpTgRhNnrIsyRUujabbAh
 3
X-Google-Smtp-Source: AGHT+IEpmBwLuNs7JbLYV2hI4E/Ma/qC8yzR0tV6teJIQpfXCuI/NAA86AgwIk4+Qb3o4xmbwtdf8Q==
X-Received: by 2002:a05:600c:1d21:b0:418:a5fc:5a5b with SMTP id
 l33-20020a05600c1d2100b00418a5fc5a5bmr432960wms.36.1713275575797; 
 Tue, 16 Apr 2024 06:52:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 l35-20020a05600c1d2300b004161af729f4sm20462920wms.31.2024.04.16.06.52.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:52:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/22] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
Date: Tue, 16 Apr 2024 15:52:29 +0200
Message-ID: <20240416135252.8384-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Missing review: 1 (new, extracted from 20) & 20

Since v2:
- Addressed Zhao review comments

Since v1:
- Addressed Zhao and Thomas review comments

Kill legacy code, because we need to evolve.

I ended there via dynamic machine -> ICH9 -> legacy ACPI...

This should also help Igor cleanups:
http://lore.kernel.org/qemu-devel/20240326171632.3cc7533d@imammedo.users.ipa.redhat.com/

Philippe Mathieu-Daudé (22):
  hw/i386/pc: Deprecate 2.4 to 2.7 pc-i440fx machines
  hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
  hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
  hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
  hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
  hw/acpi/ich9: Remove 'memory-hotplug-support' property
  hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
  hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
  target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
  hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
  hw/smbios: Remove 'uuid_encoded' argument from smbios_set_defaults()
  hw/smbios: Remove 'smbios_uuid_encoded', simplify smbios_encode_uuid()
  hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
  hw/mem/pc-dimm: Remove legacy_align argument from pc_dimm_pre_plug()
  hw/mem/memory-device: Remove legacy_align from
    memory_device_pre_plug()
  hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
  hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
  hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
  hw/i386/acpi: Remove AcpiBuildState::rsdp field
  hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine
  target/i386: Remove X86CPU::kvm_no_smi_migration field
  hw/i386/pc: Replace PCMachineClass::acpi_data_size by
    PC_ACPI_DATA_SIZE

 docs/about/deprecated.rst             |   2 +-
 docs/about/removed-features.rst       |   2 +-
 hw/usb/hcd-xhci.h                     |   4 +-
 include/hw/firmware/smbios.h          |   3 +-
 include/hw/i386/pc.h                  |  22 ------
 include/hw/mem/memory-device.h        |   2 +-
 include/hw/mem/pc-dimm.h              |   3 +-
 target/i386/cpu.h                     |   3 -
 target/i386/kvm/kvm-cpu.h             |  41 ----------
 hw/acpi/ich9.c                        |  46 ++---------
 hw/arm/virt.c                         |   5 +-
 hw/i386/acpi-build.c                  |  95 ++---------------------
 hw/i386/fw_cfg.c                      |   3 +-
 hw/i386/pc.c                          | 107 ++++----------------------
 hw/i386/pc_piix.c                     | 102 +-----------------------
 hw/loongarch/virt.c                   |   4 +-
 hw/mem/memory-device.c                |  12 +--
 hw/mem/pc-dimm.c                      |   6 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/riscv/virt.c                       |   2 +-
 hw/smbios/smbios.c                    |  13 +---
 hw/usb/hcd-xhci-nec.c                 |   4 -
 hw/usb/hcd-xhci-pci.c                 |   4 +-
 hw/usb/hcd-xhci.c                     |  42 ++--------
 hw/virtio/virtio-md-pci.c             |   2 +-
 target/i386/cpu.c                     |   2 -
 target/i386/kvm/kvm-cpu.c             |   3 +-
 target/i386/kvm/kvm.c                 |   7 +-
 tests/avocado/mem-addr-space-check.py |   9 +--
 29 files changed, 68 insertions(+), 484 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

-- 
2.41.0


